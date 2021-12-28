<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />	
<script type="text/javascript">
	$(document).ready(function() {
		fnProfileBtn();			// 우측 상단 프로필 클릭했을 때 토글, 로그아웃, 프로필수정 메뉴 나타나기
	});
	
	// fnProfileBtn();
	function fnProfileBtn() {
		$('#profile_menu').toggleClass('profile_see profile_no');
	}
</script>

   <div class="container">
   
       <div class="left_box">
       		<a href="/nearby/board/boardList"><img src="${pageContext.request.contextPath}/resources/image/logo_color.png" id="logo_img"></a>
       </div> 
       <div class="mid_box">
            <ul class="btn_box">
			    <li id="home_btn" ><div class="boxes"><a href="/nearby/board/boardList"><i id="home_icon" class="fas fa-home"></i></a></div></li>
	   			<li id="chat_btn"><div class="boxes"><a href="#"><i id="chat_icon" class="fas fa-comments"></i></a></div></li>
	   			<li id="myhome_btn"><div class="boxes"><a href="/nearby/member/mypage.jsp"><i id="myhome_icon" class="fas fa-user-alt"></i></a></div></li>
	    		<li id="insert_btn"><div class="boxes"><a href="/nearby/board/insertPage"><i id="insert_icon" class="far fa-plus-square"></i></a></div></li>   
    	    </ul>			
       </div>
   	   <div class="right_box">
   	   		<form class="main_search">
   	   			<div class="search_box">
   	   				<input type=text id="search" name="search">
   	   				<div id="search_icon"><i class="fas fa-search"></i></div>   	   				
   	   			</div>	   	   				
   	   		</form>
   	   	  <div id="profile_box">
   	   	 	<c:if test="${empty loginUser.profile.pSaved}">
					<img id="profile_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" onclick="fnShowBtnBox()" class="pointer defaultImg">
			</c:if>
			<c:if test="${not empty loginUser.profile.pSaved}">
					<img id="profile_img" src="/nearby/${loginUser.profile.pPath}/${loginUser.profile.pSaved}" onclick="fnShowBtnBox()" class="pointer">
			</c:if>
          </div>
   	   		<div id="profile_menu">
   	   			<ul>
   	   				<li><a href="/nearby/member/mypage">개인정보수정</a></li>
   	   				<li><a href="/nearby/member/logout">로그아웃</a></li>   	   					
   	   			</ul>
   	   		</div>	
   	   	</div> 
 	</div>
 	<!--   <div id="search_submit"><i class="fas fa-search"></i></div>  -->
 	
 

	
