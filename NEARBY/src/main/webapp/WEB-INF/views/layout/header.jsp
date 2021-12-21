<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />	
	
	 <header class="index_header">
          <nav class="header_wrap">
          
              <div class="hearder_logo"><a href="/nearby/board/boardList">
                     <img src="${pageContext.request.contextPath}/resources/image/logo_color.png" id="logo_img"></a>
              </div> 
          
          
              <ul class="heaer_ul">
                <li id="home_btn" ><a href="/nearby/board/boardList"><i class="fas fa-home"></i></a></li>
                <li id="chat_btn"><a href="#"><i class="fas fa-comments"></i></a></li>
                <li id="myhome_btn"><a href="#"><i class="fas fa-user-alt"></i></a></li>
                <li  id="insert_btn"><a href="/nearby/board/insertPage"><i class="far fa-plus-square"></i></a></li>
            </ul>
            
          
            <div class="right">
    
                <form id="search_box">
                    <input type="text" id="search" placeholder="검색창">
                </form>
        
            </div>
            
            <div class="profile">
                <h1 class="mypage"><a href="#">mypage</a></h1>
            </div>
        </nav>
        
        </header>
	
	
