package com.koreait.nearby.service;

import java.util.Map;

public interface LikesService {
    // 좋아요
    public Map<String, Object> likes(Long bNo, String id);
}
