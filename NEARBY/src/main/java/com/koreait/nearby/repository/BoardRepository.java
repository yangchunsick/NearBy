package com.koreait.nearby.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.koreait.nearby.domain.Board;

@Repository
public interface BoardRepository {
   public List<Board> selectListBoard();
   public Board selectBoardByNo(Long no);
   public int insertBoard(Board board);
   public int updateBoard(Board board);
   public int deleteBoard(Long no);
   
   
   // 좋아요 관련 
   public int boardLike(Board board);
   public int boardLikeCancel(Board board);
   public Board boardLikesCount(Board board);
}
