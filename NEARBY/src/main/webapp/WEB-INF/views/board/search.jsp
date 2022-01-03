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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boardView.css">

<script type="text/javascript">
	
	$(document).ready(function(){
		fnLike();
		var txtArea = $(".content_height");
	    if (txtArea) {
	        txtArea.each(function(){
	            $(this).height(this.scrollHeight);
	        });
	    }
	    
	})


 	function fnLike(i){
		   console.log(i)
	       let likeBtn = $('.like_btn');
		   $('#'+i).find('i').toggleClass('like');
	            if(  $('#'+i).find('i').hasClass('like') == true  ) {
	            	
		            $.ajax({
		 				url : '/nearby/board/likes',
		 				type: 'post',
						data: "bNo=" + i,
						dataType: 'json',
		 				success: function(map){
		 					if(map.result > 0){
		 						//likeBtn.find('.like_count').text(map.count);
		 						$('#'+i).find('.like_count').text(map.count);
		 					} else {
		 						alert(map.msg);
		 					}
		 				},
		 				error : function(xhr, error){
		 					console.log(xhr.status);
		 					console.log(error)
		 				}				
		 			 }); 
	 		   } // if
	 		
	 	   //	console.log($('.like_btn').find('i').hasClass('like'));
	 		if(  $('#'+i).find('i').hasClass('like') == false ){
	 			 $.ajax({
	  				url : '/nearby/board/likesCancel',
	  				type: 'post',
	 				data: "bNo=" +i, 
	 				dataType: 'json',
	  				success: function(map){
	  					if(map.result > 0){
	  						$('#'+i).find('.like_count').text(map.count);
	  					} else {	alert(map.msg);	}
	  				},
	  				error : function(xhr, error){
	  					console.log(xhr.status);
	  					console.log(xhr.error)
	  				}				
	  			});  // ajax		
	 	      }
 }	// fnLike
</script>
<style>
  .board_icon{
  color: gray;
  cursor: pointer;
  }
   .like {
   		color: pink; cursor: pointer;
   }
  .header {
  	margin-top: 130px;
  }
 
</style>
</head>
<body>
	<header class="header">
		<jsp:include page="/WEB-INF/views/layout/header.jsp" flush="true" />
	</header>
	
	<div class="search_result_text">
		<c:if test="${empty list[0]}">
			<div class="search_result_wrap"><h3>" ${query} " </h3> 에 대한 검색 결과가 없습니다.</div>
		</c:if>
		<c:if test="${not empty list[0]}">
			<div class="search_result_wrap"><h3>" ${query} " </h3> 에 대한 검색 결과</div>
		</c:if>
	</div>

	<div class="board_container">
	 	 
	 
	 <c:if test="${not empty list[0]}"> 
	  	<c:forEach items="${list}" var="board">

	    <%-- 	보드 값 확인 용 ${board} --%>
		<div id="mainBoardWrap" >
		    <div class="boardIntro"> 
		    	<div class="profileImg"  id="p_img">
		    <c:if test="${empty board.profile.pSaved}">
				<img id="user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" onclick="fnShowBtnBox()" class="pointer defaultImg">
			</c:if>
		    <c:if test="${board.profile.id == board.id and not empty board.profile.pSaved}" >
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
		           			<textarea readonly="readonly" class="content_height">${board.content}</textarea>  
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
		  					<input type="hidden" name="path" value="${board.path}">
		  					  <div class="content">  
		            			 	<textarea readonly="readonly"  class="content_height"> ${board.content}</textarea> 
		     				 </div>
		  		</div>
		  		
		  </c:if>		
		  
		  		<!--------------  댓글 + 좋아요 수 ----------------------->
		  		<div class="likesAndReplyCount">
			  		<div class="countIcon likesCount"> 
			  			${board.bNo }
			  		
		  				<span class="like_btn" id="${board.bNo}"  data-bno="${board.bNo}" onclick="fnLike(${board.bNo})">
		  					<i class="fas board_icon fa-thumbs-up"></i>
			  				<span class="like_count">${board.likes}</span>
		  				</span>
		  			
			  		</div>
			  		<div class="countIcon replyCount">
			  			<i class="fas board_icon fa-comments countIcon replyCount" ></i>
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