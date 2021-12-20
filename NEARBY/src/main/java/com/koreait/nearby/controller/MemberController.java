package com.koreait.nearby.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.koreait.nearby.service.MemberService;

@Controller
@RequestMapping("member")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	
	/* 회원가입 */
	@PostMapping(value = "insertMember")
	public void insertMember(HttpServletRequest request, HttpServletResponse response) {
		service.insertMember(request, response);
	}
  
	public MemberController(MemberService service) {
		super();
		this.service = service;
	}
	
	// 회원가입
	@PostMapping("insertMember")
	public void insertMember(HttpServletRequest request, HttpServletResponse response) {
		service.joinMember(request, response);
	}
	
	
}