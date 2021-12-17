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
   
}
