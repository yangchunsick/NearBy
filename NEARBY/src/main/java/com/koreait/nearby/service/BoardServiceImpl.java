package com.koreait.nearby.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;

import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koreait.nearby.domain.Board;
import com.koreait.nearby.repository.BoardRepository;

public class BoardServiceImpl implements BoardService {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	// 게시글 전체 목록
	@Override
	public List<Board> selectBoardList() {
		BoardRepository boardRepository = sqlSession.getMapper(BoardRepository.class);	
		return boardRepository.selectListBoard();
	}


	// 게시글 등록하기
	@Override
	public void insertBoard(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		
		String id = multipartRequest.getParameter("id");
		Board board = new Board();
		
		board.setId(id);
		board.setContent(multipartRequest.getParameter("content"));
		board.setLocation(multipartRequest.getParameter("location"));
		board.setIp(multipartRequest.getRemoteAddr());
		
		try {
			
			MultipartFile file = multipartRequest.getFile("file");
			
			if(file != null && !file.isEmpty() ) {
		
				String[] video = {"mp4", "mpeg", "avi", "mov"};
				String origin = file.getOriginalFilename();
				String extName = origin.substring(origin.lastIndexOf("."));
				String uuid = UUID.randomUUID().toString().replaceAll("-", "");
				String saved = uuid + extName;
				
				String sep = Matcher.quoteReplacement(File.separator);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String path = "resources"+sep + "upload" + sep + id+sep + sdf.format(new Date()).replaceAll("-", sep);
				String realPath = multipartRequest.getServletContext().getRealPath(path);
				
				logger.info("path: "+ path);
				logger.info("realpath: "+realPath);  // 루트 확인용
				
				File dir = new File(realPath);
				if ( !dir.exists() ) dir.mkdirs();
				
				File uploadFile = null;
				
				board.setPath(path);
				board.setOrigin(origin);
			
				
				// 비디오 확장자 saved 네임에 "video" 붙이기!
				for( int i =0; i<video.length; i++) {
					// System.out.println(saved.contains(video[i]));
				 	if(saved.contains(video[i])) {
						saved = "video" + saved;
						uploadFile = new File(realPath, saved); 
						board.setSaved(saved);
					} else {
						 uploadFile = new File(realPath, saved); 
						board.setSaved(saved);
					}
				}
				file.transferTo(uploadFile);
			}
			else {
				board.setPath("");
				board.setOrigin("");
				board.setSaved("");
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 삽입확인용
		logger.info(board.toString());
		
		BoardRepository boardRepository = sqlSession.getMapper(BoardRepository.class);	
		int result = boardRepository.insertBoard(board);
		
		message(result, response, "등록성공.", "등록실패", "/nearby/board/boardList");
	}
	
	
	// 게시글 상세보기
	@Override
	public Board selectBoardByNo(Long bNo) {
		BoardRepository boardRepository = sqlSession.getMapper(BoardRepository.class);	
		logger.info("보드 상세보기 : "+boardRepository.selectBoardByNo(bNo));
		Board board = boardRepository.selectBoardByNo(bNo);
		return board;
	}
	
	
	// 게시글 수정하기
	@Override
	public void updateBoard(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		String id = multipartRequest.getParameter("id");
		
		// logger.info(multipartRequest.getParameter("bNo"));
		
		Board board = new Board();
		board.setbNo(Long.parseLong(multipartRequest.getParameter("bNo")));
		board.setContent(multipartRequest.getParameter("content"));
		board.setLocation(multipartRequest.getParameter("location"));
		
	try {
			
			MultipartFile file = multipartRequest.getFile("file");
			
			if(file != null && !file.isEmpty() ) {
		
				String[] video = {"mp4", "mpeg", "avi", "mov"};
				String origin = file.getOriginalFilename();
				String extName = origin.substring(origin.lastIndexOf("."));
				String uuid = UUID.randomUUID().toString().replaceAll("-", "");
				String saved = uuid + extName;
				
				String sep = Matcher.quoteReplacement(File.separator);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String path = "resources"+sep + "upload" + sep + id+sep + sdf.format(new Date()).replaceAll("-", sep);
				String realPath = multipartRequest.getServletContext().getRealPath(path);
				
				logger.info("path: "+ path);
				logger.info("realpath: "+realPath);  // 루트 확인용
				
				File dir = new File(realPath);
				if ( !dir.exists() ) dir.mkdirs();
				
				File uploadFile = null;
				
				board.setPath(path);
				board.setOrigin(origin);
			
				
				// 비디오 확장자 saved 네임에 "video" 붙이기!
				for( int i =0; i<video.length; i++) {
					// System.out.println(saved.contains(video[i]));
				 	if(saved.contains(video[i])) {
						saved = "video" + saved;
						uploadFile = new File(realPath, saved); 
						board.setSaved(saved);
					} else {
						 uploadFile = new File(realPath, saved); 
						board.setSaved(saved);
					}
				}
				file.transferTo(uploadFile);
			}
			else {
				board.setPath("");
				board.setOrigin("");
				board.setSaved("");
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 삽입확인용
		logger.info("수정되었닝" + board.toString());
		
		BoardRepository boardRepository = sqlSession.getMapper(BoardRepository.class);	
		int result = boardRepository.updateBoard(board);	
		message(result, response, "수정성공", "수정실패",  "/nearby/board/boardList");
	}
	
	// 게시글 삭제하기
	@Override
	public void deleteBoard(Long bNo, HttpServletResponse response) {
		BoardRepository boardRepository = sqlSession.getMapper(BoardRepository.class);
		
		int result = boardRepository.deleteBoard(bNo);
		message(result, response, "삭제성공.", "삭제실패", "/nearby/board/boardList");
	}
}