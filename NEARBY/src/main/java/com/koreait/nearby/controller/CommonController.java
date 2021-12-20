package com.koreait.nearby.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommonController {

	@GetMapping("/")
	public String index() {
		return "index";
	}

	// 이용약관 안내 페이지 이동
	@GetMapping("member/joinAgreePage")
	public String joinAgreePage() {
		return "member/joinAgreePage";
	}
	
	// 회원가입 화면 이동
	@GetMapping("member/joinPage")
	public String joinPage() {
		return "member/joinPage";
	}

}
