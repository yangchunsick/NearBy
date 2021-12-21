package com.koreait.nearby.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreait.nearby.service.MemberService;

@Controller
@RequestMapping("member/*")
public class MemberController {
	
	private MemberService service;
	
	@Autowired
	public MemberController(MemberService service) {
		super();
		this.service = service;
	}

	/* 회원가입 동의여부 페이지 이동 */
	@GetMapping("joinAgreePage")
	public String joinAgreePage() {
		return "member/joinAgreePage";
	}

	/* 회원가입 화면 이동 */
	@GetMapping("joinPage")
	public String joinPage() {
		return "member/joinPage";
	}	
	
	/* 회원가입 */
	@PostMapping("insertMember")
	public void insertMember(HttpServletRequest request, HttpServletResponse response) {
		service.insertMember(request, response);
	}

	/* 아이디 중복 체크 */
	@PostMapping(value = "idCheck",
			produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> idCheck(@RequestParam("id") String id){
		return service.idCheck(id);
	}
	
	/* 이메일 인증코드 발송 */
	@PostMapping(value = "snedAuthCode", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> snedAuthCode(@RequestParam("email") String email){
		return service.snedAuthCode(email);
	}
	
	// 이메일 중복확인 + 아이디 찾기 
	@ResponseBody
	@PostMapping(value="selectByEmail", produces ="application/json; charset=UTF-8" )
	public Map<String,Object> selectByEmail(@RequestParam String email) {
		return service.selectByEmail(email);
	}
	
	// 로그인
	@PostMapping(value="login")
	public void login(HttpServletRequest request, HttpServletResponse response) {
		service.login(request, response);
	}

	// 로그아웃
	@GetMapping(value="logout")
	public String logout(HttpSession session) {
		if (session.getAttribute("loginUser") != null) {
			session.invalidate();
		}
		return "redirect:/";
	}

}