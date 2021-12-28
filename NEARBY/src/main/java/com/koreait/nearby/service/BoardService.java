package com.koreait.nearby.service;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koreait.nearby.domain.Board;

@Service
public interface BoardService {
	public List<Board> selectBoardList();
	public Board selectBoardByNo(Long no);
    public void insertBoard(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
    public void updateBoard(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
    public void deleteBoard(Long bNo, HttpServletResponse response);
   
    /* 유저의 게시물 갯수 구하기 */    
    public int selectUserBoardsCount(HttpServletRequest request);
    
    
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
