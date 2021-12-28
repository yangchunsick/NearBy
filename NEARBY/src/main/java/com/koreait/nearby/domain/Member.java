package com.koreait.nearby.domain;

import java.sql.Date;

public class Member {
	private Long mNo;
	private String id, pw, email, birthday, gender, name, phone;
	private int state;
	private Profile profile;
	private Date mCreated;

	// constructor
	public Member() {
	}

	public Member(Long mNo, String id, String pw, String email, String birthday, String gender, String name,
			String phone, int state, Profile profile, Date mCreated) {
		super();
		this.mNo = mNo;
		this.id = id;
		this.pw = pw;
		this.email = email;
		this.birthday = birthday;
		this.gender = gender;
		this.name = name;
		this.phone = phone;
		this.state = state;
		this.profile = profile;
		this.mCreated = mCreated;
	}

	public Long getmNo() {
		return mNo;
	}

	public void setmNo(Long mNo) {
		this.mNo = mNo;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public Profile getProfile() {
		return profile;
	}

	public void setProfile(Profile profile) {
		this.profile = profile;
	}

	public Date getmCreated() {
		return mCreated;
	}

	public void setmCreated(Date mCreated) {
		this.mCreated = mCreated;
	}

	@Override
	public String toString() {
		return "Member [mNo=" + mNo + ", id=" + id + ", pw=" + pw + ", email=" + email + ", birthday=" + birthday
				+ ", gender=" + gender + ", name=" + name + ", phone=" + phone + ", state=" + state + ", profile="
				+ profile + ", mCreated=" + mCreated + "]";
	}
	
	

}
