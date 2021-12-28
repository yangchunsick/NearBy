package com.koreait.nearby.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.koreait.nearby.domain.Reply;
import com.koreait.nearby.repository.ReplyRepository;

public class ReplyServiceImpl implements ReplyService {

	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Map<String, Object> replyList(Long bNo) {
		System.out.println("전달받은 파라메터 bNo : " + bNo);
		Map<String, Object> map = new HashMap<String, Object>();
		ReplyRepository replyRepository = sqlSession.getMapper(ReplyRepository.class);
		List<Reply> replyList = replyRepository.selectReplyList(bNo);
		System.out.println("DB의 결과 : " + replyList);
		map.put("replyList", replyList);
		System.out.println("반환할 map : " + map);
		return map;
	}
	
}
