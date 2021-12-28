<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/functions" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<style>

/* 기본 레이아웃 */
	*{
		padding: 0;
		margin: 0;
		box-sizing: border-box;	
		width: 100%;
	}
	a {
		text-decoration: none;
		color: black;
		font-weight: bold;
	}
	
/* header css */
	.header {
		width: 100%;
		height: 106px;
		background-color: white;
	}
	#home_btn { border-bottom: 8px solid  #fe4662; }
	#home_icon { color: #fe4662; }
/* End header Css */	
	.board_container {	width: 100%;	}
/* board main wrap */  
	#mainBoardWrap {
		width: 560px; 
		border:1px solid pink;
		padding: 15px;
		border-radius: 10px;
		margin: 30px auto;
		background-color: rgba(255, 250, 250, 0.8);
		box-shadow: 10px 10px 20px rgba(30, 30, 30, 0.5);
	}
	.mainBoardWrap_img {
		height: 750px;
	}
	.mainBoardWrap_content {
		height: 350px;
	}
	.boardIntro{
		display: flex;	
		width: 500px;
	}
   .profileImg{
	   	width : 110px;
		height : 80px;
		border : 1px solid silver;
	    display: inline-block;
	    border-radius: 100%;
		margin-right: 10px;
   }
   #board_writer {
   	   font-weight: bold;
   	   font-size: 18px;
	   display: inline-block;
	   margin-left: 10px;
	   width: 250px;
   }
    .setting_wrap{
   		position: relative; 
   		width: 50px;
   }
   .setting { 
	 	color: #fe4662; 
	 	font-size:20px;
	 	width:30px
   }
   .addrAndMap {
	    text-align: right;
	    padding-right: 10px;
	    margin-top: 10px;
	    margin-bottom: 10px;
   }
   .addressAndImage {
   	    width:500px;
        margin: 5px auto 10px;
    	position: relative;
    	cursor: pointer;
   }
   .AddrAndContent { cursor: pointer; }
   #select_link {
	    display:inline-block;
	   	width: 500px;
	   	height: 400px;
   }
   .content {
	   margin: 10px auto;
	   width : 510px;
   }
   .onlyContent {	margin:20px 8px;  }
    .content textarea {
   		border: none;
   		background-color : rgba(255, 250, 250, 0.8);
   		outline: none;
   		overflow:visible;
   		cursor: pointer;
    }
   
   .board_icon {  display: inline-block;  }
   .likesAndReplyCount  {
	   	border-top : 1px solid gray;
	   	border-bottom : 1px solid gray;
	   	height: 35px;
	   	line-height: 35px;
	   	display: flex;
    }
   .likesCount .replyCount { color :#fe4662;  }
    .see {
      display: block;
      width: 90px;
      height: 55px;
   }
   .no {  display: none;  }
   .imgSize {
 		width: 480px;
 		height: 320px;
 		overflow: hidden;
   }
   #image, #video {
   	  width: 480px;
  	  overflow: hidden;
   }
   .delete_update_form {
       position:absolute;
       top: 5px;
       left: 5px;
       border-radius: 10px;
       border : 1px solid rgba(50,50,50,0.3);
       margin: 0 auto;
       margin-top: 20px;
       padding: 3px;
       text-align: center;
       background-color: white;
   }
   .delete_update_form li:first-child {
    	padding-bottom: 3px;
   		border-bottom: 1px solid rgba(50,50,50,0.3);
   }
    .delete_update_form li a {
    	font-size: 10px;
        font-weight: 400;
    }
    .delete_update_form li a:hover {	font-weight: bold;  }
    
    #p_img {
    width: 120px;
		height: 120px;
    }
    	#p_img #user_img {
		width: 120px;
		height: 120px;
		border-radius: 100%;
	}
    
    
    
    
</style>


<script type="text/javascript">
	
	$(document).ready(function(){
		var txtArea = $(".content_height");
	    if (txtArea) {
	        txtArea.each(function(){
	            $(this).height(this.scrollHeight);
	        });
	    }
	})


	function fnSetting(){
		 $('.delete_update_form').toggleClass('see no');
	}


   
	function fnselectBoard(){
		$(".addressAndImage").click(function(){
  		 location.href=
		 console.log($('#bNo').val() );
		})
	}
// 	function fnLike(){
// 		$('.like_btn').click(function(){
// 			alert( $('#bNo').val() );
// 			$.ajax({
// 				url : '/nearby/like/likes',
// 				type: 'post',
// 				data: JSON.stringify({
// 					"bNo": $('#bNo').val()
// 				}),  // json 데이터를 서버로 보냄
// 				contentType: 'application/json',
// 				dataType: 'json',
// 				success: function(resData){
// 					alert(resData);
// 					$('.like_count').text(resData.result);
// 				},
// 				error : function(xhr, error){
// 					console.log(xhr.status);
// 					console.log(error)
// 				}				
// 			});
// 		});
// 	}
</script>
</head>
<body>
	<header class="header">
		<jsp:include page="/WEB-INF/views/layout/header.jsp" flush="true" />
	</header>

	<a href="/nearby/board/insertPage">새 갤러리 작성</a> <!-- header로빠질예정 -->
	<a href="/nearby/member/logout">로그아웃</a>

<div class="board_container">

	<c:if test="${not empty list}">
	  <c:forEach items="${list}" var="board">

	    <%-- 	보드 값 확인 용 ${board} --%>
		<div id="mainBoardWrap" >
		    <div class="boardIntro"> 
		    	<div class="profileImg"  id="p_img">
		    <c:if test="${board.profile.id == board.id}" >
		    		<img id="user_img" src="/nearby/${board.profile.pPath}/${board.profile.pSaved}"  class="pointer">
		    </c:if>
		    	</div>
		    	<input type="hidden" id="bNo" value="${board.bNo}">
		    	<input type="hidden" id="origin" value="${board.origin}">
		    	<input type="hidden" id="saved" value="${board.saved}">
		    	<input type="hidden" id="location" value="${board.location}">
		    	<div class="id">
		    	   <a href="/nearby/board/selectBoard" id="board_writer">${board.id}</a>
		    	</div>
		    </div>
  		<!--------------------- 내용만 삽입할 때 ------------------------------->
 			 <c:if test="${ null == board.origin }">
	  			<div class="AddrAndContent"  onclick="location.href='/nearby/board/selectBoard?bNo=${board.bNo}';">
	  				  <div class="addrAndMap">
						       		  <i class="fas board_icon fa-map-marker-alt" style="color:#fe4662; font-size:15px; width:30px"></i>
						              <span class="address"> ${board.location} </span>
				      </div>
		  		       <div class="content onlyContent">
		           			<span readonly="readonly" class="content_height">${board.content}</span>  
		       		   </div>
	  		    </div>
		  </c:if>
  		<!-------------------- 이미지/비디오 삽입할 때---------------->		  
		 <c:if test="${board.saved ne null}">	  
		      <div class="addressAndImage"  onclick="location.href='/nearby/board/selectBoard?bNo=${board.bNo}';">
			      <div class="addrAndMap">
			       		  <i class="fas board_icon fa-map-marker-alt" style="color:#fe4662; font-size:15px; width:30px"></i>
			              <span class="address"> ${board.location} </span>
			      </div>
		    	  <!------------------ 이미지 및 영상 관련 ----------------------------------------->
  					   <c:set value="${board.saved}" var="video"></c:set>
		  				 <c:if test="${not f:contains(video, 'video')}">
		  						 <div class="imgSize">  <img alt="${board.origin}" src="/nearby/${board.path}/${board.saved}" id="image">  </div>
		  				  </c:if>
		  				
		  				<c:if test ="${f:contains(video, 'video')}">
		  				   <div class="imgSize">
			  				    <video autoplay controls loop muted poster="video"  id="video">
			  						<source src="/nearby/${board.path}/${board.saved}"  type="video/mp4" >
			  					</video>
		  					</div>
		  				</c:if>
		  				<c:if test="${not empty board.content}">
		  					  <div class="content">  
		            			 	<span readonly="readonly"  class="content_height"> ${board.content}</span> 
		     				 </div>		  				
		  				</c:if>
		  				<c:if test="${empty board.content}">
		  					<div>내용 없음</div>
		  				</c:if>
		  					<input type="hidden" name="path" value="${board.path}">
		  		</div>
		  		
		  </c:if>		
		  
		  
		  
		  		<!--------------  댓글 + 좋아요 수 ----------------------->
		  		<div class="likesAndReplyCount">
			  		<div class="countIcon likesCount"> 
			  				<button type="button"  class="like_btn"  style="background-color: white; border: none; width:60px; cursor: pointer;">
			  					<i class="fas board_icon fa-thumbs-up" style="color:#fe4662; width: 50px"></i>
			  					<span class="like_count"></span>
			  				</button>
			  		</div>
			  		<div class="countIcon replyCount">
			  			<i class="fas board_icon fa-comments countIcon replyCount" style="color:#fe4662"></i>
			  			<span class=""></span>
			  		</div>
		  		</div>
		  		
		  		<!--  댓글 보이기  -->
		  		<div class="reply_wrap" style="margin: 20px; border:1px solid black; height: 100px; width: 500px; margin:12px auto 5px;">
		  			소정언니댓글구현
		  		</div>
		</div>
	  </c:forEach>
	</c:if>
	
</div>	
</body>
</html>