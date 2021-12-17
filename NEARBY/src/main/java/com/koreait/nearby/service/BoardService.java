package com.koreait.nearby.service;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koreait.nearby.domain.Board;

@Service
public interface BoardService {
	public List<Board> selectBoardList();
	public Board selectBoardByNo(Long no);
    public void insertBoard(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
    public int updateBoard(Board board);
    public int deleteBoard(Long no);
    
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
