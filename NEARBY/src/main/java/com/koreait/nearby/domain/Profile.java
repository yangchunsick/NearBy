package com.koreait.nearby.domain;

public class Profile {

	private Long pNo;
	private String id, content, pOrigin, pSaved, path;
	
	public Profile() {

	}

	public Profile(Long pNo, String id, String content, String pOrigin, String pSaved, String path) {
		super();
		this.pNo = pNo;
		this.id = id;
		this.content = content;
		this.pOrigin = pOrigin;
		this.pSaved = pSaved;
		this.path = path;
	}

	public Long getpNo() {
		return pNo;
	}

	public void setpNo(Long pNo) {
		this.pNo = pNo;
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

	public String getpOrigin() {
		return pOrigin;
	}

	public void setpOrigin(String pOrigin) {
		this.pOrigin = pOrigin;
	}

	public String getpSaved() {
		return pSaved;
	}

	public void setpSaved(String pSaved) {
		this.pSaved = pSaved;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	@Override
	public String toString() {
		return "Profile [pNo=" + pNo + ", id=" + id + ", content=" + content + ", pOrigin=" + pOrigin + ", pSaved="
				+ pSaved + ", path=" + path + "]";
	}
	
	
	
}
