package com.koreait.nearby.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.exceptions.PersistenceException;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;

import com.koreait.nearby.domain.Member;
import com.koreait.nearby.domain.Profile;
import com.koreait.nearby.repository.MemberRepository;
import com.koreait.nearby.repository.ProfileRepository;
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
		String id = request.getParameter("id"); 
		Member member = new Member();
		 member.setId(id);
		 member.setPw(SecurityUtils.sha256(request.getParameter("pw")));
		 member.setName(request.getParameter("name"));
		 member.setEmail(request.getParameter("email"));
		 member.setPhone(request.getParameter("phone"));
		 String birthday = request.getParameter("year") + request.getParameter("month")+request.getParameter("day");
		 member.setBirthday(birthday);
		 member.setGender(request.getParameter("gender"));
		 
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);	
		int result = memberRepository.joinMember(member);
		
		/* 회원가입과 동시에 프로필 테이블에 DATA삽입. */
		Profile profile = new Profile(); //DTO
		// DB에 전달 할 data 담기
		profile.setId(id);
		profile.setpContent("");
		profile.setpPath("");
		profile.setpOrigin("");
		profile.setpSaved("");
		ProfileRepository profileRepository = sqlSession.getMapper(ProfileRepository.class);
		int profileResult = profileRepository.insertProfile(profile);
		System.out.println("profileResult 결과 : " + profileResult );
		
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
			System.out.println("loginUser information : " + loginUser);
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

	// 회원정보 확인
	@Override
	public Map<String, Object> memberInfo(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			// 세션에 저장된 loginUser정보 받아오기.
			Member loginUser = (Member)request.getSession().getAttribute("loginUser");
			if (loginUser == null) throw new NullPointerException("다시 로그인을 진행해주세요.");
			// DB로 보낼 Bean 생성
			Member member = new Member();
			member.setId(loginUser.getId());
			member.setPw(loginUser.getPw()); // 수정
			MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
			Member selectResult = memberRepository.selectMemberById(member);
			if (selectResult == null ) throw new PersistenceException("일치하는 회원정보가 없습니다.");
			map.put("member", member);
			map.put("result", selectResult);
		} catch(PersistenceException e) {
			map.put("updateErrorMsg", e.getMessage());
		} catch(NullPointerException e) {
			map.put("loginErrorMsg", e.getMessage());
		} catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println("DB갔다온 Map : " + map.toString());
		
		return map;
	}
	
	// 회원정보 수정  // 받아올 파라미터 이름/핸드폰번호/생년월일/성별 
	@Override
	public Map<String, Object> modifyMember(Member m, HttpServletRequest request) {
		// 보낼 map 생성
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			// 세션에 저장된 loginUser정보 받아오기.
			Member loginUser = (Member)request.getSession().getAttribute("loginUser");
			// 파라미터 처리
			Long mNo = m.getmNo();
			String birthday = m.getBirthday();
			String name = m.getName();
			String phone = m.getPhone();
			String gender = m.getGender();
			String content = m.getProfile().getpContent();
			if (birthday.length() != 8) throw new NullPointerException("생일 정보가 없습니다");
			if (name.isEmpty()) throw new NullPointerException("입력된 이름이 없습니다");
			if (phone.isEmpty()) throw new NullPointerException("입력된 핸드폰 번호가 없습니다");
			if (phone.length() != 11 ) throw new NullPointerException("올바른 형식이 아닙니다.");
			
			// Profile DB로 보낼 Bean 
			Profile profile = new Profile();
			profile.setpContent(content);
			profile.setId(loginUser.getId());
			ProfileRepository profileRepository = sqlSession.getMapper(ProfileRepository.class);
			profileRepository.updateContent(profile);
			map.put("profile", profile);

			// DB로 보낼 Bean 생성
			Member member = new Member();
			member.setmNo(mNo);
			member.setId(loginUser.getId());
			member.setName(name);
			member.setPw(loginUser.getPw());
			member.setPhone(phone);
			member.setBirthday(birthday);
			member.setGender(gender);
			MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
			int updateResult = memberRepository.updateMember(member);
			if (updateResult < 0 ) throw new PersistenceException("일치하는 회원정보가 없습니다");
			map.put("member", member);
			map.put("result", updateResult);
			// 세션에 올릴 로그인정보 업데이트
			loginUser = memberRepository.login(member);
			if (loginUser != null ) {
				request.getSession().invalidate();
				request.getSession().setAttribute("loginUser", loginUser);
			}
		} catch(NullPointerException e) {
			map.put("nullErrorMsg", e.getMessage());
		} catch(NumberFormatException e) {
			map.put("formatErrorMsg", e.getMessage());
		} catch(PersistenceException e) {
			map.put("updateErrorMsg", e.getMessage());
		} catch(Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	// 회원 탈퇴 // 받아올 파라미터 mNo
	public void leaveMember(Long mNo) {
		// 파라미터 받기
		Map<String, Object> map = new HashMap<String, Object>();
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		int result = memberRepository.leaveMember(mNo);
		map.put("result", result);
	}
	
	@Override
	public Map<String, Object> checkPassword(HttpServletRequest request) {
		// 가입당시 비밀번호는 ajax 처리하여 pass true - false 매김 -- DB 에서 비밀번호 일치하는지 확인 필요.
		// 비밀번호가 일치하면 1 아니면 0
		//javax.mail.internet.AddressException: Illegal address in string ``''
		Map<String, Object> map = new HashMap<String, Object>();	
		try {
			String password = SecurityUtils.sha256(request.getParameter("pw"));
			MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
			int selectResult = memberRepository.selectPassword(password);
			map.put("selectResult", selectResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	
	// 회원비밀번호 변경
	@Override
	public void changePassword(HttpServletRequest request) {
		// 비밀번호 찾기 process 
		// 변경할 비밀번호와 비밀번호 재확인을 통해 비밀번호를 확인하고 -- pass true / false
		// 이후 통과되면 가입당시 입력한 이메일을 작성 -> 인증번호받고 인증하기 -- pass true / false
		// 다 끝난 뒤에 수정완료 버튼을 누르면 page이동 : 페이지는 내 정보 변경 mypage
		// 보낼 파라미터 새로운 pw / email
		Member member = new Member();
		member.setPw(SecurityUtils.sha256(request.getParameter("newPw")));
		System.out.println(request.getParameter("newPw"));
		member.setEmail(request.getParameter("email"));
		MemberRepository memberRepository = sqlSession.getMapper(MemberRepository.class);
		memberRepository.updatePw(member);
		System.out.println("결과 : " + memberRepository.updatePw(member));
		return;
	}
	
}
