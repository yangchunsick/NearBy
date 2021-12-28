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

	.mainBoardWrap {
		width: 560px; 
		border: 4px solid #fab1bc; 
		padding: 15px;
		border-radius: 15px;
		margin: 30px auto;
		background-color: rgba(255, 250, 250, 0.8);
		box-shadow: 10px 10px 20px rgba(30, 30, 30, 0.5);
	}
	.boardIntro{
		display: flex;	
		width: 500px;
	}
   #p_img{
	   	width: 100px;
		height: 100px;
	    display: inline-block;
	    border-radius: 100%;
		margin-right: 10px;
		position: relative;
   }
     #p_img #user_img {
		width: 100px;
		height: 100px;
		border-radius: 100%;
	}
   
   .id {
   		width: 430px;
   		height: 80px;
   }
   .setting_wrap{
  	   position: relative; 
  	   width: 10px;
  	   text-align: right;
   }
   .setting { 
	 	color: #696969	;
	 	font-size:20px;
	 	width:20px;
	 	cursor: pointer;
   }
   .fas {  display: inline-block;  }
   .fa-map-marker-alt, .fa-cog { font-size: 12px; }
   #board_writer {
   	   font-weight: bold;
   	   font-size: 18px;
	   display: inline-block;
	   margin-left: 10px;
	   width: 250px;
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
   }
    .imgSize {
    	margin: 0 auto;
 		width: 480px;
 		overflow: hidden;
   }
   #image, #video {
   	 	width: 480px;
  	  	overflow: hidden;
  	  	margin: 0 auto;
   }
   .content {
	   margin: 10px auto;
	   width : 520px;
	 
   }
   .content textarea {
   		border: none;
   		background-color : rgba(255, 250, 250, 0.8);
   		outline: none;
   		overflow:visible;
    }
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
   .no {   display: none; }
   .delete_update_form {
       position:absolute;
       top: 5px;
       left: 5px;
       border-radius: 10px;
       border : 1px solid rgba(50,50,50,0.3);
       margin: 0 auto;
       margin-top: 20px;
       padding: 5px;
       text-align: center;
       background-color: white;
   }
   .delete_update_form li:first-child {
   	   padding-top: 5px;
       padding-bottom: 4px;
       border-bottom: 1px solid rgba(50,50,50,0.3);
   }
    .delete_update_form li {
    	font-size: 10px;
        font-weight: 400;
    }
    .delete_update_form li:hover {	
    	font-weight: bold; 
    	cursor: pointer;
   	 }
   	.pointer {
   		cursor: pointer;
   	} 
/* ------------------- reply 구역 ----------------- */
/* 	테이블 구역 확인용
	table {
		border-collapse: collapse;
	}
	table tr {
		border: 1px solid;
	}
	table td {
		border: 1px solid;
	} */
	.reply_user_img {
		width:20px;
		height: 20px;
		margin: 5px;
		border-radius: 100%;
	}
	#input_reply_table td:nth-of-type(1){
		width:20px;
	}
	#input_reply_table #reply_user_name_area input[type=text]{
		width: auto;
	}
	#input_reply_table input[type=text]{
		margin: 5px;
		width: 378px;
		height: 22px;
		font-size: 12px;
		outline-style: none;
	}
	
	/* 댓글 보여주는 구역 CSS */
	.output_reply_area {
		border:1px solid black; 
		height: 100px; 
		width: 500px; 
		margin:10px auto 5px;
	}
	.reply_user_image_area{
		width: 25px;
	}
	.reply_user_image_area .reply_user_img{
		width:25px;
		height: 25px;
		margin: 5px;
	}
	.output_reply_area .reply_user_name_area{
		color: black;
		width: auto;
	}
	.like_icon_area {
		font-size: 16px;
		padding: 5px;
	}
	.output_reply_table input[type=text]{
		margin: 5px;
		width: 370px;
		height: 22px;
		font-size: 12px;
		outline-style: none;
	}
	.btn_area {
		width: auto;
	}
	.reply_btns{
		margin-right:5px;
		width:36px; 
		font-size: 12px;
		border: none;
		padding: 5px 0 5px 0;
		background-color: pink;
		border-radius: 5px;
	}
   
</style>
<script>
	$(document).ready(function(){
		fnReplyList();
		
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
	
	function fnDelete(){
		if ( confirm('게시글을 삭제하시겠습니까?') ){
			location.href= '/nearby/board/deleteBoard?bNo='+${board.bNo};
		}
	}
	function fnUpdate(){
		if(confirm('게시글을 수정하시겠습니까?') )
			location.href= '/nearby/board/updateBoardPage?bNo='+${board.bNo};
	}
</script>

<script>
/* ----------------------------------------- fnReplyList() --------------------------------  */
	function fnReplyList(){
		$.ajax({
			url: '/nearby/reply/replyList',
			type: 'get',
			data: 'bNo=${board.bNo}',
			dataType: 'json',
			success: function(map) {
				fnPrintReplyList(map);
			},
			error: function(xhr) {
				console.log(xhr.responseText);
			}
		}) // End ajax
	} // End fnReplyList
	
/* ----------------------------------------- fnPrintReplyList() --------------------------------  */
  
 
	function fnPrintReplyList(map){
		$('#output_reply_table').empty();
		$.each(map.replyList, function(i, reply){ 
 		 	if ( reply.profile.pSaved != null ) {
			console.log('reply.rNo :' + reply.rNo);
			console.log('reply.profile.pSaved :' + reply.profile.pSaved);
			console.log('reply.profile.pPath :' + reply.profile.pPath);
			let pSaved = reply.profile.pSaved;
			let pPath = reply.profile.pPath;
  					$('#output_reply_table').append( $('<tr>').html( $('<td rowspan="2" class="reply_user_image_area"><img class="reply_user_img" src="/nearby/'+pPath+'/'+pSaved+'" class="pointer"></td>') ) )
 				} else if(reply.profile.pPath == null) {
 					$('#output_reply_table').append( $('<tr>').html( $('<td rowspan="2" class="reply_user_image_area"><img id="reply_user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" class="pointer defaultImg"></td>') ) )
 				} 
			$('<tr class="reply_show">')
			.append( $('<td class="reply_user_name_area">').html( $('<a href="#">'+reply.id+'</a>') ) )
			.append( $('<td class="like_icon_area">').html( $('<i class="fas fa-thumbs-up pointer" style="color:#fe4662; width: 16px"></i>') ) )
			.append( $('<td class="btn_area">').html( $('<input type="button" class="update_reply_btn pointer reply_btns" value="수정"></td>') ) )
			.append( $('<td class="btn_area">').html( $('<input type="button" class="delete_reply_btn pointer reply_btns" value="삭제"></td>') ) )
			.appendTo( '#output_reply_table' );
			$('#output_reply_table').append( $('<tr>').html( $('<td colspan="4"><input type="text" name="rContent" class="outputContent" value="'+reply.rContent+'"></td>') ) )
			
		}) // End each
	} // End fnPringReplyList
	
	
</script>


</head>
<body>
	<header class="header">
		<jsp:include page="/WEB-INF/views/layout/header.jsp" flush="true" />
	</header>
	
	<div class="mainBoardWrap" >
	    <div class="boardIntro"> 
	    	<div class="profileImg" id="p_img">
	    	  <c:if test="${empty board.profile.pSaved}">
				<img id="user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" onclick="fnShowBtnBox()" class="pointer defaultImg">
			</c:if>
		    <c:if test="${board.profile.id == board.id and not empty board.profile.pSaved}" >
		    		<img id="user_img" src="/nearby/${board.profile.pPath}/${board.profile.pSaved}"  class="pointer">
		    </c:if>
	    	</div>
	    	<input type="hidden" id="bNo" value="${board.bNo}">
	    	<div class="id">
	    	   <a href="/nearby/board/selectBoard" id="board_writer">${board.id}</a>
	    	</div> 
	    
		<c:if test="${board.id == loginUser.id}">   
		 <div class="setting_wrap">	
	    	<i class="fas fa-cog setting" onclick="fnSetting()" >
	    	</i>
	    	<ul class="delete_update_form no">
		    		<li class="update_link" onclick="fnUpdate(); return false;">게시글 수정</li>
		    		<li class="delete_link" onclick="fnDelete(); return false; ">게시글 삭제</li>
		    	</ul>
		   </div> 
	    </c:if>	
	    	
	 </div>
		<!--------------------- 내용만 삽입할 때 ------------------------------->
 			 <c:if test="${ null == board.origin }">
	  			<div class="AddrAndContent"  onclick="location.href='/nearby/board/selectBoard?bNo=${board.bNo}';">
	  				  <div class="addrAndMap">
						       		  <i class="fas fa-map-marker-alt" style="color:#fe4662; font-size:15px; width:30px"></i>
						              <span class="address"> ${board.location} </span>
				      </div>
		  		       <div class="content onlyContent">
		           			<textarea readonly="readonly" class="content_height"> ${board.content}</textarea> 
		       		   </div>
	  		    </div>
		  </c:if>
  		<!-------------------- 이미지/비디오 삽입할때ㅐ---------------->		  
		 <c:if test="${board.saved ne null}">	  
		      <div class="addressAndImage"  onclick="location.href='/nearby/board/selectBoard?bNo=${board.bNo}';">
			      <div class="addrAndMap">
			       		  <i class="fas fa-map-marker-alt" style="color:#fe4662; font-size:15px; width:30px"></i>
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
		  					<input type="hidden" name="path" value="${board.path}">
		  					
		  		      <div class="content">
		           			<textarea readonly="readonly"  class="content_height"> ${board.content}</textarea> 
		       		   </div>
		  		</div>
		  		
		  		
		  		
		  </c:if>		
		  
		  
		  
		  
		  
		  		<!--------------  댓글 + 좋아요 수 ----------------------->
		  		<div class="likesAndReplyCount">
			  		<div class="countIcon likesCount"> 
			  				<button type="button"  class="like_btn"  style="background-color: white; border: none; width:60px; cursor: pointer;">
			  					<i class="fas fa-thumbs-up" style="color:#fe4662; width: 50px"></i>
			  					<span class="like_count"></span>
			  				</button>
			  		</div>
			  		<div class="countIcon replyCount">
			  			<i class="fas fa-comments countIcon replyCount" style="color:#fe4662"></i>
			  			<span class=""></span>
			  		</div>
		  		</div>
		  		
		  		<!--  댓글 보이기  -->
	  			<div class="input_reply_area">
	  				<!-- 댓글 작성 -->
		  			<table id="input_reply_table">
		  				<tr>
		  					<td>
		  						<c:if test="${empty board.profile.pSaved}">
									<img class="reply_user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" onclick="fnShowBtnBox()" class="pointer defaultImg">
		  						</c:if>
		  						<c:if test="${board.profile.id == board.id and not empty board.profile.pSaved}">
						    		<img class="reply_user_img" src="/nearby/${board.profile.pPath}/${board.profile.pSaved}"  class="pointer">
		  						</c:if>
		  					</td>
		  					<td id="reply_user_name_area">
		  						${loginUser.id}
		  					</td>
		  					<td>
		  						<input type="text" name="rContent" id="rContent">
		  					</td>
		  					<td>
		  						<input type="button" id="insert_reply_btn" class="pointer reply_btns" value="등록">
		  					</td>
		  				</tr>
		  			</table>
	  			</div>
		  		<div class="reply_wrap">
		  			<!-- 댓글 뿌리기 -->
		  			<div class="output_reply_area">
			  			<table id="output_reply_table"></table>
		  			</div>
		  		</div>
		</div>
	
	
	
</body>
</html>