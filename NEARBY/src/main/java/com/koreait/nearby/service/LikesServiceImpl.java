package com.koreait.nearby.service;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.koreait.nearby.repository.LikesRepository;

public class LikesServiceImpl  implements LikesService{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	// 좋아요 클릭
    @Override
    public  Map<String, Object> likes(Long bNo, String id) {
    	Map<String, Object> map = new  HashMap<String, Object>();
    	map.put("id", id);
    	map.put("bNo", bNo);
    	
    	LikesRepository likesRepository = sqlSession.getMapper(LikesRepository.class);	
   
    	
    	int result = likesRepository.likeCheck(map);
    	
    	
    	
    	Map<String, Object> m = new HashMap<String, Object>();
    	m.put("result", result);
    	
    	return m;
    }
    
    
    
    
	
}
