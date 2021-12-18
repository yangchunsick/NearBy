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
	.mainBoardWrap {
	width: 560px; 
	height: 700px;
	border:1px solid pink;
	padding: 10px;
	border-radius: 10px;
	margin-bottom: 50px;
	margin: 30px auto;
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
	   	background-image: url('resources/image/logo_black.png');
	   	background-size: 80px 80px;
		background-size: contain;
	   	background-repeat: no-repeat;
		margin-right: 10px;
   }
   #board_writer {
   	font-weight: bold;
   	font-size: 18px;
	   display: inline-block;
	   margin-left: 10px;
	   width: 250px;
	     
   }
   .setting { 
  		 	color:pink; 
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
    margin: 30px auto;
   	position: relative;
 
   }
   .content {
	   margin-top: 5px;
	   margin-bottom: 10px;
	   margin-left: 100px;
	   width : 300px;
   }
   
   
</style>

</head>
<body>
<jsp:include page="/WEB-INF/views/layout/layout.jsp" flush="true" />
	<h1>MAINMAIN</h1>
	
	<a href="/nearby/board/insertPage">새 갤러리 작성</a> <!-- header로빠질예정 -->
	<a href="/nearby/member/logout">로그아웃</a>
	<hr>
	
	<c:if test="${not empty list}">
	  <c:forEach items="${list}" var="board">
	
		<div class="mainBoardWrap" >
		
		    <div class="boardIntro"> 
		    	<div class="profileImg">(프로필)</div>
		    	
		    	<div class="id">
		    	   <a href="/nearby/board/selectBoard" id="board_writer">${board.id}프로필이동</a>
		    	</div>
		    	
		    	<i class="fas fa-cog setting"></i>
		    	
		    </div>
		     	
		        <div class="content">
		        		내용 : ${board.content}
		        </div>
		      
		      <div class="addressAndImage">
		     
		      <div class="addrAndMap">
		       		  <i class="fas fa-map-marker-alt" style="color:pink; font-size:15px; width:30px"></i>
		              <span class="address"> ${board.location} </span>
		      </div>
		      
  					<c:set value="${board.saved}" var="video"></c:set>
  					   
		  				 <c:if test="${not f:contains(video, 'video')}">
		  						   <img alt="${board.origin}" src="/nearby/${board.path}/${board.saved}" style="width:500px;">
		  				  </c:if>
		  				
		  				<c:if test ="${f:contains(video, 'video')}">
		  				<video autoplay controls loop muted poster="video" width="500px">
		  					<source src="/nearby/${board.path}/${board.saved}"  type="video/mp4" >
		  				</video>
		  				</c:if>
		  		</div>
		   
		</div>
	  </c:forEach>
	</c:if>
	
	
</body>
</html>