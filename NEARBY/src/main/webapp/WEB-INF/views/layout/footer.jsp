<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
	integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<style>
	* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 14px;
	
	}

	a {
	text-decoration: none;
	color: black;
	}
	footer_wrap ul, li {
	list-style-type: none;
	float: left;
	}
	#footer_container {
		width: 100%;
		height: 300px;
		background-color: #232323;
	}
	.footer_wrap {
		margin: 4px auto;
		background-color: #232323;
	}
	.footer_top {
		display: flex;
		height: 50px;
		background-color: #232323;
	}
	
	.footer_top_left {
		margin-left: 170px;
		background-color: #232323;
	}
	.footer_top_right {
		margin-top: 30px;
		margin-left: 60px;
		color: white;
		
	}
	.footer_top_right ul li {
		margin-left: 30px;
	}
	.footer_top_right ul li a {	
		color: #737273;
		font-size: 16px;
		font-weight: 300;
	}
	.footer_top_right ul li a:hover {
		color: rgb(180, 180, 180);
		font-weight: 400;		
	}
	.footer_mid {
		display: flex;
		background-color: #232323;
	}
	.footer_mid_icon_box {
		width: 700px;
		height: 50px;
		margin-left: 1556px;
		background-color: #232323;
	}
	.footer_mid_icon_box i{
		color: #737273;
		margin-left: 30px;
		font-size: 30px;
	}
	.footer_mid_icon_box i:hover {
		color: rgb(180, 180, 180);
		font-weight: 400;		
	}	
	
	
	.footer_bot {
		width:	1600px;
		height: 150px;
		border-top: 1px solid #737273;
		margin: 20px auto;
		background-color: #232323;
	}
	.footer_bot_left {
		margin-top: 10px;
	}
	
	.footer_bot_left p{
		color: #737273;
	}
	.copyright_text {
		margin-top: 30px;
		text-align: center;
		color: #737273;
	}
</style>
<script type="text/javascript">
		
</script>

<div id="footer_container">
	<div class="footer_wrap">
		<div class="footer_top">
			<div class="footer_top_left">
				<img id="logo" src="${pageContext.request.contextPath}/resources/image/logo_white.png" width="300px">	
			</div>
			<div class="footer_top_right">
				<ul>
					<li><a href="#">????????????</a></li>
					<li><a href="#">????????????</a></li>
					<li><a href="#">????????????</a></li>
					<li><a href="#">?????????</a></li>
					<li><a href="#">????????????</a></li>
					<li><a href="#">????????????????????????</a></li>
				</ul>
			</div>
		</div>
		<div class="footer_mid">
			<div class="footer_mid_icon_box">
			<a title="???????????????" href="#"><i class="fab fa-instagram"></i></a>
			<a title="????????????" href="#"><i class="fab fa-facebook"></i></a>
			<a title="?????????" href="#"><i class="fab fa-youtube"></i></a>
			<a title="?????????" href="#"><i class="fab fa-twitter"></i></a>
			</div>
		</div>
		<div class="footer_bot">
			<div class="footer_bot_left">
				<p>(???)NEARBY CORPS.</p>   
				<p>?????? : ??????????????? ????????? ????????? 136(??????????????? ????????? ???????????? 106-5)</p>
				<p>???????????????????????????: ????????? ??????</p>
				<p>E-MAIL: nearby.corp@gmail.com</p>
				<p>???????????? : 1588-9999*(??????)</p>
			</div>	
			<p class="copyright_text">COPYRIGHT?? 2022 NEARBY.ALL RIGHTS RESERVED.</p>
		</div>
	</div>
</div>

