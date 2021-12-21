package com.koreait.nearby.domain;

public class Likes {
  private Long likeNo;
  private Long bNo;
  private String id;
  private Long likeCheck;

  
  public Likes() {
	// TODO Auto-generated constructor stub
	}
	
  
	
	public Likes(Long likeNo, Long bNo, String id, Long likeCheck) {
	super();
	this.likeNo = likeNo;
	this.bNo = bNo;
	this.id = id;
	this.likeCheck = likeCheck;
	}



	public Long getLikeNo() {
		return likeNo;
	}
	
	
	public void setLikeNo(Long likeNo) {
		this.likeNo = likeNo;
	}
	
	
	public Long getbNo() {
		return bNo;
	}
	
	
	public void setbNo(Long bNo) {
		this.bNo = bNo;
	}
	
	
	public String getId() {
		return id;
	}
	
	
	public void setId(String id) {
		this.id = id;
	}
	
	
	public Long getLikeCheck() {
		return likeCheck;
	}


public void setLikeCheck(Long likeCheck) {
	this.likeCheck = likeCheck;
}
  
  
	
	
	
}
