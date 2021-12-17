package com.koreait.nearby.service;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.nearby.domain.Member;

public interface MemberService {
   
	// 회원가입
	public void joinMember(HttpServletRequest request, HttpServletResponse response);
	
    // 회원가입시 아이디 중복 체크 
	public Map<String, Object> idCheck(String id);
	
	// 회원가입시 이메일 중복 체크 + 아이디 찾기
	public Map<String, Object> selectByEmail(String email);
	
	
	// 회원가입 이메일 인증
	public Map<String, Object> sendAuthCode(String email);

	// 로그인
	public void login(HttpServletRequest request, HttpServletResponse response);
	
   
	// default method
	 	public default void message(int result, HttpServletResponse response, 
	 			String success, String fail, String path) {
	 		try {
	 			response.setContentType("text/html; charset=UTF-8");
	 			PrintWriter out = response.getWriter();
	 			if (result > 0) {
	 				out.println("<script>");
	 				out.println("alert('" + success + "')");
	 				out.println("location.href='" + path + "'");
	 				out.println("</script>");
	 				out.close();
	 			} else {
	 				out.println("<script>");
	 				out.println("alert('" + fail + "')");
	 				out.println("history.back()");
	 				out.println("</script>");
	 				out.close();
	 			}
	 		} catch (Exception e) {
	 			e.printStackTrace();
	 		}
	 	}
	    
   
   
}
