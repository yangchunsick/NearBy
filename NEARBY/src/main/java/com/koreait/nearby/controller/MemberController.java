package com.koreait.nearby.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	
	@Autowired
	private MemberService service;

	/* 회원가입 화면 이동 */
	@GetMapping("joinPage")
	public String joinPage() {
		return "member/joinPage";
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

	/* 회원가입 */
	@PostMapping("insertMember")
	public void insertMember(HttpServletRequest request, HttpServletResponse response) {
		service.insertMember(request, response);
	}

}