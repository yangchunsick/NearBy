package com.koreait.nearby.controller;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koreait.nearby.domain.Board;
import com.koreait.nearby.service.BoardService;

@Controller
@RequestMapping("board")
public class BoardController {
  
	   private BoardService service;
	   
	   @Autowired
	   public BoardController(BoardService service) {
	      super();
	      this.service = service;
	   }
	   
	   // 전체 리스트
	   @GetMapping("boardList")
	   public String boardList(Model model) {
	      model.addAttribute("list", service.selectBoardList());
	      System.out.println(model);
	      return "board/board";
	   }

	    // 등록하는 곳으로가기
	   @GetMapping(value="insertPage")
	   public String insertPage() {
	      return "board/insert";
	   }
	   
	   
	   // 등록하기
	   @PostMapping(value="insertBoard")
	   public void insertBoard(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
	      service.insertBoard(multipartRequest, response);
	   }
	   
	   // 상세보기
	   @GetMapping("selectBoard")
	   public String selectBoard(@RequestParam Long bNo, Model model) {
	      Board board = service.selectBoardByNo(bNo);
	      model.addAttribute("board", board);
	      return "board/selectView";
	   }
	   
	   
	    // 수정하러가기
	   @GetMapping("updateBoardPage")
	   public String updateBoardPage(@RequestParam Long bNo, Model model) {
	      Board board = service.selectBoardByNo(bNo);
	      model.addAttribute("board", board);
	      System.out.println("보드 수정하기 : "+board.toString());
	      return "board/boardUpdate";
	   }
	   
	   // 수정하기
	   @PostMapping("updateBoard")
	   public void updateBoard(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
	      service.updateBoard(multipartRequest, response);
	   }
	   
	   
	   
	   // 삭제하기
	   @GetMapping("deleteBoard")
	   public void deleteBoard(@RequestParam Long bNo, HttpServletResponse response) {
	      service.deleteBoard(bNo, response);
	      
	   }
	   
	   // 좋아요
	   @ResponseBody
	   @PostMapping(value="likes", produces ="application/json; charset=UTF-8" )
	    public Map<String, Object> likes(@RequestParam Long bNo, HttpSession session) {
		   System.out.println("controller bNo" + bNo);
		  return service.likes(bNo, session);
	   }

	   // 좋아요 취소하기
	   @ResponseBody
	   @PostMapping(value="likesCancel",  produces ="application/json; charset=UTF-8")
	   public Map<String, Object> likesCancel(@RequestParam Long bNo, HttpSession session){
		   System.out.println("controller bNo" + bNo);
		   return service.likesCancel(bNo, session);
	   }
	  

}
