package com.koreait.nearby.domain;

public class Follow {

	private Long fNo;
	private String following, follower;
	
	 
	public Follow() {
	
	}


	public Follow(Long fNo, String following, String follower) {
		super();
		this.fNo = fNo;
		this.following = following;
		this.follower = follower;
	}


	public Long getfNo() {
		return fNo;
	}


	public void setfNo(Long fNo) {
		this.fNo = fNo;
	}


	public String getFollowing() {
		return following;
	}


	public void setFollowing(String following) {
		this.following = following;
	}


	public String getFollower() {
		return follower;
	}


	public void setFollower(String follower) {
		this.follower = follower;
	}


	@Override
	public String toString() {
		return "Follow [fNo=" + fNo + ", following=" + following + ", follower=" + follower + "]";
	}
	
	
	
}
