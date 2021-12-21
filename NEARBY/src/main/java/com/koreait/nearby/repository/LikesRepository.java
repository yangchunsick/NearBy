package com.koreait.nearby.repository;

import java.util.Map;

public interface LikesRepository {
	
	public int likeCheck(Map<String, Object> map);
	public int likeCheckCancel(Map<String, Object> map);
	
	
	
}
