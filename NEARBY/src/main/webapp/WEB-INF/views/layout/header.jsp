<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
	integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script type="text/javascript">
		$(document).ready(function() {
			fnProfileBtn();			// 우측 상단 프로필 클릭했을 때 토글, 로그아웃, 프로필수정 메뉴 나타나기

		});
		
		// fnProfileBtn();
		function fnProfileBtn() {
			$('#profile_box').click(function (){
				$('#profile_menu').toggleClass('profile_see');
			});
		};
	
</script>

<div class="container">

	<div class="left_box">
		<a href="/nearby/board/boardList">logo_img</a>
	</div>
	<div class="mid_box">
		<ul class="btn_box">
			<li id="home_btn" ><a class="boxes" href="/nearby/board/boardList"><i id="home_icon" class="fas fa-home"></i></a></li>
			<li id="chat_btn"><a class="boxes" href="/nearby/member/followList"><i id="chat_icon" class="fas fa-comments"></i></a></li>
			<li id="myhome_btn"><a class="boxes" href="/nearby/board/myHome"><i id="myhome_icon" class="fas fa-user-alt"></i></a></li>
			<li id="insert_btn" ><a class="boxes" href="/nearby/board/insertPage"><i id="insert_icon" class="far fa-plus-square"></i></a></li>
		</ul>
		<div class="text_icon_box">
			<a href="/nearby/board/boardList">홈</a>
		</div>
		<div class="text_icon_box">
			<a href="/nearby/board/boardList">친구</a>
		</div>
		<div class="text_icon_box">
			<a href="/nearby/board/boardList">마이홈</a>
		</div>
		<div class="text_icon_box">
			<a href="/nearby/board/boardList">사진/ 동영상 게시</a>
		</div>
	</div>
	<div class="right_box">
		<form class="main_search" action="/nearby/board/searchBoardList">
			<div class="search_box pointer">
				<input type=text id="query" name="query">
				<button id="search_icon">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</form>
		<div id="profile_box">
   	   	 	<c:if test="${empty loginUser.profile.pSaved}">
					<img id="profile_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" class="pointer defaultImg">
			</c:if>
			<c:if test="${not empty loginUser.profile.pSaved}">
					<img id="profile_img" src="/nearby/${loginUser.profile.pPath}/${loginUser.profile.pSaved}" class="pointer">
			</c:if>
          </div>
		<div id="profile_menu" class="profile_no">
			<ul>
				<li>
					<a id="profile_menu_list1" href="#">${loginUser.id}</a>
					<p>${loginUser.name}님<p>
					<p>${loginUser.email}</p>	
					
				</li>
   	   			<li><a id="profile_menu_list2" href="/nearby/member/mypage">계정 관리</a></li>
   	   			<li><a id="profile_menu_list3" href="/nearby/member/logout">로그아웃</a></li>
			</ul>
		</div>
	</div>
</div>

