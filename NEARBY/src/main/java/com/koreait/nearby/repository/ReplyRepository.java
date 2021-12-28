package com.koreait.nearby.repository;


import java.util.List;

import org.springframework.stereotype.Repository;

import com.koreait.nearby.domain.Reply;

@Repository
public interface ReplyRepository {

	public List<Reply> selectReplyList(Long bNo);
	public int insertReply(Reply reply);
	public int updatePreviousReplyGroupOrd(Reply reply);
	
}
