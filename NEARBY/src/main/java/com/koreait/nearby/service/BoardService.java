package com.koreait.nearby.service;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koreait.nearby.domain.Board;
import com.koreait.nearby.domain.Likes;

@Service
public interface BoardService {
	public List<Board> selectBoardList();
	public Board selectBoardByNo(Long no);
    public void insertBoard(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
    public void updateBoard(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
    public void deleteBoard(HttpServletRequest request, HttpServletResponse response);
    
    
    // 로그인 유저가 각 게시물 좋아요 표시 확인위한 bNo 전달
     public Map<String, Object> boardBnoList(Long bNo,  HttpSession session);
    
    
    // 검색
    public List<Board> searchBoardList(HttpServletRequest request);
   
    /* myHome 이동 및 유저의 게시물 갯수 구하기 */
	public int selectUserBoardsCount(HttpServletRequest request);
    
    // 좋아요
    public Board likes( Likes likes, HttpSession session);
    
    // 좋아요취소
    public Board likesCancel(Likes likes, HttpSession session);
    
    
    // 관리자 지역별게시글 구분 메서드
    public  Map<String, Object> adminBoardList();
    
    // 관리자 보드 삭제 
    public Map<String, Object> adminBoardDelete(Long bNo, HttpServletRequest request);
    
    
    
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
