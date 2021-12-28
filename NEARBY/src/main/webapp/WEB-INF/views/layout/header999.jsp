<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- font-awesome cdn -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header999.css">
    <!-- JavaScript -->
    <!--<script src="header999.js"></script>-->
    <title>NearBy</title>
</head>
<body>
    
    <header>
        
        <!-- 로고 -->
        <h1 class="title">
            <a href="#">NearBy</a>
        </h1>

        <nav class="menu">
            <ul class="menu_list">
                <!-- HOME -->
                <li class="btn" id="home_btn">
                    <a href="/nearby/board/boardList"><i class="fas fa-home"></i></a>
                </li>
                <!-- MYHOME -->
                <li class="btn" id="myhome_btn">
                    <a href="/nearby/board/myHome"><i class="fas fa-user-alt"></i></a>
                </li>
                <!-- INSERT -->
                <li class="btn" id="insert_btn">
                    <a href="/nearby/board/insertPage"><i class="far fa-plus-square"></i></a>
                </li>
            </ul>
        </nav>

        <div class="search_box">
            <form id="search_box">
                <i class="fas fa-search"></i>
                <input id="search" type="text"placeholder="Search">
            </form>
        </div>

        <div class="profile">
            <a href="#">profile</a>
        </div>
    </header>

</body>
</html>