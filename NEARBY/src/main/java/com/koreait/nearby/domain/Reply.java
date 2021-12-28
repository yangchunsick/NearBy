package com.koreait.nearby.domain;

import java.sql.Date;

public class Reply {

	private Long rNo, bNo, likes;
	private String id, content;
	private Date created, modified;
	private int depth, state;
	
	public Reply() {

	}

	public Reply(Long rNo, Long bNo, Long likes, String id, String content, Date created, Date modified, int depth,
			int state) {
		super();
		this.rNo = rNo;
		this.bNo = bNo;
		this.likes = likes;
		this.id = id;
		this.content = content;
		this.created = created;
		this.modified = modified;
		this.depth = depth;
		this.state = state;
	}

	public Long getrNo() {
		return rNo;
	}

	public void setrNo(Long rNo) {
		this.rNo = rNo;
	}

	public Long getbNo() {
		return bNo;
	}

	public void setbNo(Long bNo) {
		this.bNo = bNo;
	}

	public Long getLikes() {
		return likes;
	}

	public void setLikes(Long likes) {
		this.likes = likes;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreated() {
		return created;
	}

	public void setCreated(Date created) {
		this.created = created;
	}

	public Date getModified() {
		return modified;
	}

	public void setModified(Date modified) {
		this.modified = modified;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	@Override
	public String toString() {
		return "Reply [rNo=" + rNo + ", bNo=" + bNo + ", likes=" + likes + ", id=" + id + ", content=" + content
				+ ", created=" + created + ", modified=" + modified + ", depth=" + depth + ", state=" + state + "]";
	}
	
	
	
	
}
