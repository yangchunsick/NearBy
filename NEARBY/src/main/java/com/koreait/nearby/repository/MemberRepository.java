package com.koreait.nearby.repository;

import org.springframework.stereotype.Repository;

import com.koreait.nearby.domain.Member;
@Repository
public interface MemberRepository {
	 	



















	
	// DB와 연결
 
	/* 회원가입 */ 
	public int joinMember(Member member);

	/* 중복체크 */
	public Member duplicateIdCheck(String id);
	
	/* 회원가입 */ 
	public int joinMember(Member member);
}
