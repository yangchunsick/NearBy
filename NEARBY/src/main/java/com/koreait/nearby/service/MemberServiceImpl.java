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
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private JavaMailSender javaMailSender;
	

	// birthday 파라미터 세개 더해야 돼서 request로 받음.. 
	@Override
	public void joinMember(HttpServletRequest request, HttpServletResponse response) {
		 Member member = new Member();
		 member.setId(request.getParameter("id"));
		 member.setPw(SecurityUtils.sha256(request.getParameter("pw")));
		 member.setName(request.getParameter("name"));
		 member.setEmail(request.getParameter("email"));
		 member.setPhone(request.getParameter("phone"));
		 String birthday = request.getParameter("year") + request.getParameter("month")+request.getParameter("day");
		 member.setBirthday(birthday);
		 member.setGender(request.getParameter("gender"));
		 
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);	
		int result = memberRepository.joinMember(member);
		
		message(result, response, "회원가입성공", "회원가입실패", "/nearby");
		
	}

    // 아이디 중복 확인 
	@Override
	public Map<String, Object> idCheck(String id){
		Map<String, Object> map = new HashMap<String, Object>();
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		map.put("result", memberRepository.idCheck(id));
		return map;
	}
	
	// 이메일 중복확인 + 아이디 찾기
	@Override
	public Map<String, Object> selectByEmail(String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		map.put("result", memberRepository.selectByEmail(email));
		return map;
	}
	
	
	// 이메일 인증
	@Override
	public Map<String, Object> sendAuthCode(String email) {
		
		// 인증코드 발생
		String authCode = SecurityUtils.authCode(6);
		
		// 이메일 전송
		try {
			
			MimeMessage message = javaMailSender.createMimeMessage();
			message.setHeader("Content-Type", "text/plain; charset=UTF-8");
			message.setFrom(new InternetAddress("nearby.corp@gmail.com", "인증코드관리자"));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
			message.setSubject("NEARBY 인증 요청 메일입니다.");
			message.setText("인증번호는 " + authCode + " 입니다.");
			javaMailSender.send(message);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("authCode", authCode);
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
