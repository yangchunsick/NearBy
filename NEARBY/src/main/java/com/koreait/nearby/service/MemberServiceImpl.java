package com.koreait.nearby.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.koreait.nearby.domain.Member;
import com.koreait.nearby.repository.MemberRepository;
import com.koreait.nearby.util.SecurityUtils;

public class MemberServiceImpl implements MemberService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/* 아이디 체크 */
	@Override
	public String idCheck(String id) {
		// TODO Auto-generated method stub
		return null;
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
		String Birthday = request.getParameter("year") + request.getParameter("month") + request.getParameter("day");
		member.setBirthday(Birthday);
		member.setPhone(request.getParameter("phone"));
		member.setGender(request.getParameter("gender"));
		
		int result = repository.joinMember(member);
		message(result, response, "회원가입 성공", "회원가입 실패", "/board/board");
		
	}

}