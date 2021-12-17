package com.koreait.nearby.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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





}
