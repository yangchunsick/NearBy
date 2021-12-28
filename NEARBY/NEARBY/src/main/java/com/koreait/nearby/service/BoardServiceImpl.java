package com.koreait.nearby.service;

import java.io.File;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koreait.nearby.domain.Board;
import com.koreait.nearby.domain.Member;
import com.koreait.nearby.domain.Profile;
import com.koreait.nearby.repository.BoardRepository;

public class BoardServiceImpl implements BoardService {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	// 게시글 전체 목록
	@Override
	public List<Board> selectBoardList() {
		BoardRepository boardRepository = sqlSession.getMapper(BoardRepository.class);	
		logger.info("보드 상세보기 : "+boardRepository.selectListBoard());
		return boardRepository.selectListBoard();
	}

	// 게시글 등록하기
	@Override
	public void insertBoard(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		
//		Member member = (Member)multipartRequest.getSession().getAttribute("loginUser");
//		String id = member.getId();

		
		String id =multipartRequest.getParameter("id");
	
		String content = multipartRequest.getParameter("content");
		String location = multipartRequest.getParameter("location");
		
		Board board = new Board();
		
		board.setId(id);
		board.setContent(content);
		board.setLocation(location);
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
			logger.info(board.toString());
			

 
		      
		
	} catch (Exception e) {
			e.printStackTrace();
		}

		
		
		// 삽입확인용
		//logger.info(board.toString());
		
		BoardRepository boardRepository = sqlSession.getMapper(BoardRepository.class);	
		int result = boardRepository.insertBoard(board);
		
		try {
			   response.setContentType("text/html; charset=UTF-8");
			   PrintWriter out = response.getWriter();
 			
 			
 			if (result > 0) {
 				out.println("<script>");
 				out.println("alert('등록하겠습니다')");
 				out.println("location.href='/nearby/board/boardList'");
 				out.println("</script>");
 				out.close();
 			} else {
 				out.println("<script>");
 				out.println("alert('게시글 등록에 실패했습니다.')");
 				out.println("history.back()");
 				out.println("</script>");
 				out.close();
 			}
 		} catch (Exception e) {
 			e.printStackTrace();
 		}
		
		
		
//	  	message(result, response, "게시글을 등록하겠습니다.", "게시글 등록에 실패했습니다.", "/nearby/board/boardList");
		
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

		// logger.info(multipartRequest.getParameter("bNo"));
		String id = multipartRequest.getParameter("id");
		Board board = new Board();
		board.setId(id);
		board.setbNo(Long.parseLong(multipartRequest.getParameter("bNo")));
		board.setContent(multipartRequest.getParameter("content"));
		board.setLocation(multipartRequest.getParameter("location"));
		board.setIp(multipartRequest.getRemoteAddr());
		
		
		
	try {
	
			MultipartFile file = multipartRequest.getFile("file");
			
			if(multipartRequest.getParameter("path").isEmpty()) {   // path가 빈값이 아니라는건 기존에 이미지/비디오가 있었다는 의미다. 때문에 없는 경우엔 새로 만들고, 아니면 원래  path, saved, origin을 board에 다시 넣는다!!!
			
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
			} else {
			
				board.setPath("");
				board.setOrigin("");
				board.setSaved("");
			} 
			
	} else {		
//			   System.out.println(multipartRequest.getParameter("path"));
//			   System.out.println(multipartRequest.getParameter("saved"));
//			   System.out.println(multipartRequest.getParameter("origin"));
				
				board.setPath(multipartRequest.getParameter("path"));
				board.setSaved(multipartRequest.getParameter("saved"));
				board.setOrigin(multipartRequest.getParameter("origin"));					
			
	}
			
	    } catch (Exception e) {
			e.printStackTrace();
		}
		
		// 삽입확인용
		BoardRepository boardRepository = sqlSession.getMapper(BoardRepository.class);	
		int result = boardRepository.updateBoard(board);	
		// logger.info("수정되었닝" + board.toString());
		message(result, response, "수정성공", "수정실패",  "/nearby/board/boardList");
	}
	
	// 게시글 삭제하기
	@Override
	public void deleteBoard(Long bNo, HttpServletResponse response) {
		BoardRepository boardRepository = sqlSession.getMapper(BoardRepository.class);
		
		int result = boardRepository.deleteBoard(bNo);
		message(result, response, "삭제성공.", "삭제실패", "/nearby/board/boardList");
	}
	
	/* 유저의 게시물 갯수 구하기 */
	@Override
	public int selectUserBoardsCount(HttpServletRequest request) {
		BoardRepository boardRepository = sqlSession.getMapper(BoardRepository.class);
		Member loginUser = new Member();
		loginUser = (Member)request.getSession().getAttribute("loginUser");
		int userBoardCount = boardRepository.selectUserBoardsCount(loginUser.getId());
		return userBoardCount;
	}
	
}