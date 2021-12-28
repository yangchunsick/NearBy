<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/functions" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- font-awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
        integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header999.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myHome.css">
<script src="${pageContext.request.contextPath}/resources/js/myHome.js" ></script>
</head>

<body>

    <jsp:include page="/WEB-INF/views/layout/header999.jsp" flush="true" />

    <section class="board">

        <!-- 프로필 사진, 이름, 게시물, 팔로워, 팔로잉, 프로필 설정-->
        <div class="user_box">
            <div class="user_img_box">
            	<c:if test="${empty loginUser.profile.pSaved}">
            		<img id="user_img" src="">
            	</c:if>
            	<c:if test="${not empty loginUser.profile.pSaved}">
            		<img id="user_img" src="/nearby/${loginUser.profile.pPath}/${loginUser.profile.pSaved}">            	
            	</c:if>
            </div>

            <div class="user_item_box">
                <span>${loginUser.id}</span>

                <div class="follower_box">
                    <input id="my_border" type="button" value="게시물">
                    <label for="my_border">${userBoardCount}</label>

                    <input id="my_follower" type="button" value="팔로워">
                    <label for="my_follower">200</label>

                    <input id="my_following" type="button" value="팔로잉">
                    <label for="my_following">300</label>
                </div>

                <div class="content_box">
                    <span>${loginUser.profile.pContent}</span>
                </div>

            </div>

            <div class="profile_setup_box">
                <input id="profile_setup" type="button" value="프로필 설정" onclick="fnMyPage()">
            </div>

        </div>

		<!-- 게시물이 없을 때 -->
		<c:if test="${empty list}">
			<div class="no_board">
				<h1>게시글 없음</h1>
			</div>
		</c:if>
		
		<!-- 게시물이 있을 때 -->
		<c:if test="${not empty list}">
		<c:forEach items="${list}" var="board">
		
		<c:if test="${loginUser.id == board.id}">
        <!-- 게시물 전체를 감싸고 있는 박스 -->
	        <div class="board_container">
	
	            <!-- 게시물을 내용을 감싸고 있는 박스 -->
	            <div class="board_wrap">
	
	                <!-- 유저 정보 -->
	                <div class="board_head">
	                    <div class="board_intro">		    
	                    	<img id="user_img" src="/nearby/${loginUser.profile.pPath}/${loginUser.profile.pSaved}">
	                        <input type="hidden" id="bNo" value="${board.bNo}">
	                        <input type="hidden" id="origin" value="${board.origin}">
	                        <input type="hidden" id="saved" value="${board.saved}">
	                        <input type="hidden" id="location" value="${board.location}">
	                    </div>
	
	                    <!-- 유저 아이디 -->
	                    <div class="user_id">
	                        <a href="/nearby/board/selectBoard" id="board_writer">${board.id}</a>
	                    </div>
	
	                    <!-- 버튼(수정) 박스 -->
	                    <div class="btn_box">
	                        <a id="update_btn" href=""><i class="fas fa-cog"></i></a>
	                    </div>
	                </div>
	
	                <div class="board_body">
	                    <!-- 내용만 작성 했을 경우 -->
	                    <c:if test="${ null == board.origin }">
	                        <div class="AddrAndContent" onclick="location.href='/nearby/board/selectBoard?bNo=${board.bNo}';">
	                            <!-- 지도 -->
	                            <div class="addrAndMap">
	                                <i class="fas fa-map-marker-alt"></i>
	                                <span class="address">${board.location}</span>
	                            </div>
	                            <!-- 내용 -->
	                            <div class="content">
	                                <textarea>${board.content}</textarea>
	                            </div>
	                        </div>
	                    </c:if>
	
	                    <!-- 이미지/ 비디오가 삽입 되어 있을 경우 -->
	                    <c:if test="${board.saved ne null}">
	
	                        <div class="addressAndImage"
	                            onclick="location.href='/nearby/board/selectBoard?bNo=${board.bNo}';">
	                            <div class="addrAndMap">
	                                <i class="fas fa-map-marker-alt"></i>
	                                <span class="address">${board.location}</span>
	                            </div>
	                        </div>
	
	                        <!-- 이미지 일때 -->
	                        <!-- video 변수 생성 -->
	                        <c:set value="${board.saved}" var="video"></c:set>
	
	                        <!-- video가 아닌 것을 가져와라 ! -->
	                        <c:if test="${not f:contains(video, 'video')}">
	                            <div class="imgSize">
	                                <img alt="${board.origin}" src="/nearby/${board.path}/${board.saved}" id="image">
	                            </div>
	                        </c:if>
	
	                        <!-- video인 것을 가져와라 ! -->
	                        <c:if test="${f:contains(video, 'video')}">
	                            <div class="imgSize">
	                                <video autoplay controls loop muted id="video">
	                                    <source src="/nearby/${board.path}/${board.saved}" type="video/mp4">
	                                </video>
	                            </div>
	                        </c:if>
	
	                        <input type="hidden" name="path" value="${board.path}">
	                        <div class="content"><span>${board.content}</span></div>
	
	                    </c:if>
	                    <!-- 댓글 / 좋아요 버튼 -->
	                    <div class="like_reply_btn">
	                        <!-- 좋아요 -->
	                        <div class="like_box box">
	                            <label for="like_btn"></label>
	                            <i class="fas fa-thumbs-up"></i>
	                            <input type="button" id="like_btn" value="">
	                            <span class="count"></span>
	                        </div>
	                        <!-- 댓글 수 -->
	                        <div class="reply_box box">
	                            <label for="reply_btn"></label>
	                            <i class="fas fa-comments"></i>
	                            <input type="button" id="reply_btn">
	                            <span class="count"></span>
	                        </div>
	                    </div>
	                </div>
	
	                <!-- 댓글 -->
	                <div class="reply_wrap" style="margin: 20px; border: 1px solid black; height: 100px; width: 500px; margin: 12px auto 5px;">
	                    	소정언니댓글구현
	                </div>
	
	
	
	            </div>
	
	        </div>
	        </c:if>
	        </c:forEach>
		</c:if>


    </section>
    
    <footer>
    
    </footer>



</body>

</html>