package com.koreait.nearby.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.koreait.nearby.domain.Board;

@Repository
public interface BoardRepository {
	
  // 전체 리스트 ok
   public List<Board> selectListBoard();
   
   // 상세보기
   public Board selectBoardByNo(Long bNo);
   
   // 삽입하기 ok
   public int insertBoard(Board board);
   
   // 수정하기 ok
   public int updateBoard(Board board);
   
   // 게시글 삭제
   public int deleteBoard(Long bNo);
   
   
 
   
}
