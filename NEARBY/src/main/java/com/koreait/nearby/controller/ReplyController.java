package com.koreait.nearby.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreait.nearby.service.ReplyService;

@Controller
@RequestMapping("reply")
public class ReplyController {
	
	private ReplyService service;
	
	@Autowired
	public ReplyController(ReplyService service) {
		super();
		this.service = service;
	}
	
	// 댓글 전체 리스트
	@GetMapping(value="replyList", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> replyList(@RequestParam("bNo")Long bNo){
		System.out.println("JSP에서 전달받은 bNo : " + bNo);
		return service.replyList(bNo);
	}
	

}
