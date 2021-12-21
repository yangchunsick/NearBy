package com.koreait.nearby.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;

import com.koreait.nearby.domain.Member;
import com.koreait.nearby.repository.MemberRepository;
import com.koreait.nearby.util.SecurityUtils;

public class MemberServiceImpl implements MemberService {

	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	private SqlSessionTemplate sqlSession;
	private JavaMailSender javaMailSender;
	
	@Autowired
	public void setBean(SqlSessionTemplate sqlSession, JavaMailSender javaMailSender) {
		this.sqlSession = sqlSession;
		this.javaMailSender = javaMailSender;
	}

	/* 아이디 체크 */
	@Override
	public Map<String, Object> idCheck(String id) {
		// 매퍼와 연결하기 위해 sqlSession을 불러옴
		MemberRepository repository = sqlSession.getMapper(MemberRepository.class);
		// Map에 id를 담기
		Map<String, Object> map = new HashMap<String, Object>();
		// result라는 이름으로 담았음
		map.put("result", repository.duplicateIdCheck(id));
		return map;
	}
	
	/* 이메일 인증코드 발송*/
	@Override
	public Map<String, Object> snedAuthCode(String email) {

		// 인증코드 발생
		String authCode = SecurityUtils.authCode(6);
		
		// 이메일 전송
		try {
			// 인증코드 생성
			MimeMessage message = javaMailSender.createMimeMessage();
			// 인코딩
			message.setHeader("Content-Type", "text/plain; charset=UTF-8");
			// 보내는 이메일 주소와 이름
			message.setFrom(new InternetAddress("nearby.corp@gmail.com", "NearBy 인증메일"));
			// 누구에게 보내는가 ?
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
			// 이메일 제목
			message.setSubject("NearBy 회원가입 인증 코드");
			// 내용
			message.setText("인증번호는 " + authCode + "입니다.");
			// 보냄
			javaMailSender.send(message);
		}catch(Exception e) {
			e.printStackTrace();
		}
		// 보낸 인증코드를 검증하기 위해 map에 authCode라는 이름으로 담아서 가져옴
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("authCode", authCode);
		return map;
	}
	
	/* 회원가입 */
	@Override
	public void insertMember(HttpServletRequest request, HttpServletResponse response) {
		MemberRepository repository = sqlSession.getMapper(MemberRepository.class);
		Member member = new Member();
		member.setId(request.getParameter("id"));
		member.setPw(SecurityUtils.sha256(request.getParameter("pw")));
		member.setName(request.getParameter("name"));
		member.setEmail(request.getParameter("email"));
		String birthday = request.getParameter("year") + request.getParameter("month") + request.getParameter("day");
		member.setBirthday(birthday);
		member.setPhone(request.getParameter("phone"));
		member.setGender(request.getParameter("gender"));
		
		int result = repository.joinMember(member);
		message(result, response, "회원가입 성공", "회원가입 실패", "/nearby");
	}
	
	// 이메일 중복확인 + 아이디 찾기
	@Override
	public Map<String, Object> selectByEmail(String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		map.put("result", memberRepository.selectByEmail(email));
		return map;
	}

	// 로그인
	@Override
	public void login(HttpServletRequest request, HttpServletResponse response) {
		Member member = new Member();
		member.setId(request.getParameter("id"));
		member.setPw(SecurityUtils.sha256(request.getParameter("pw")));
		MemberRepository repository = sqlSession.getMapper(MemberRepository.class);
		Member loginUser = repository.login(member);
		if (loginUser != null) {
			request.getSession().setAttribute("loginUser", loginUser);
			logger.info(loginUser.toString());
		}

		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			if (loginUser != null) {
				out.println("<script>");
				out.println("alert('로그인 성공')");
				out.println("location.href='/nearby/board/boardList'");
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('응아니야!')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	
	
}