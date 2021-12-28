package com.koreait.nearby.repository;

import org.springframework.stereotype.Repository;

import com.koreait.nearby.domain.Member;
@Repository
public interface MemberRepository {
 
	/* 회원가입 */ 
	public int joinMember(Member member);

	/* 아이디 중복체크 */
	public Member duplicateIdCheck(String id);
	
	// 이메일중복 + 아이디 찾기 
	public Member selectByEmail(String email);
	
	/* 비밀번호 찾기 */
	public int findPw(Member member);
	
	// 로그인
	public Member login(Member member);
	
	// 회원정보 받아오기 
	public Member selectMemberById(Member member);
	
	// 비밀번호 일치여부 (조회 성공 : 1 / 조회 실패 : 0)
	public int selectPassword(String password);
	
	// 비밀번호수정 
	public int updatePw(Member member);
	
	// 정보수정(이름, 생일, 성별, 폰)
	public int updateMember(Member member);
	
	// 회원탈퇴(DB삭제x)
	public int leaveMember(Long mNo);

}
