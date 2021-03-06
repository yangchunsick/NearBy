<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NearBy</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/image/titleImg3.png">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/follow.css">


<script type="text/javascript">

	$(document).ready(function(){
		fnFollowSeeNo();
		fnCheckFollow();
	});
	
	function fnFollowSeeNo(){
		$('#right_select_box').click(function (){
			$('#right_select_box').addClass('checked').removeClass('unchecked');
			$('#left_select_box').addClass('unchecked').removeClass('checked');
			$('#right_follow_box').addClass('follow_see').removeClass('follow_no');
			$('#left_follow_box').addClass('follow_no').removeClass('follow_see');
			$('#follower_text').addClass('unchecked1').removeClass('checked1');
			$('#following_text').addClass('checked1').removeClass('unchecked1');		
			
		});
		
		$('#left_select_box').click(function (){
			$('#left_select_box').addClass('checked').removeClass('unchecked');// 'border-bottom-right-radius':'0' );
			$('#right_select_box').addClass('unchecked').removeClass('checked');//'border-bottom-left-radius':'10px' );
			$('#right_follow_box').addClass('follow_no').removeClass('follow_see');
			$('#left_follow_box').addClass('follow_see').removeClass('follow_no');
			$('#follower_text').addClass('checked1').removeClass('unchecked1');		
			$('#following_text').addClass('unchecked1').removeClass('checked1');
		});   
	}
	
	//fnCheckFollow();
	function fnCheckFollow() {
		let pId = '${userId}';
		let follow = JSON.stringify({
	  	  profile : {id : pId} 
		  	});
		$.ajax({
			url: '<%=request.getContextPath()%>/follow/checkFollow',
			type: 'post',
			data: follow,
	  	  	contentType: 'application/json',
	  	  	dataType: 'json',
		    success: function(map) {
		    	 // map.result == 1  '????????????'
				//  map.result == 0  '???????????? ??????'	
		      },
		     error: function(xhr) {
		    	  console.log(xhr.responseText);
		     }
		});
		
	}
	
	// fnMoveUserHome();
	function fnMoveUserHome(id) {
		location.href='<%=request.getContextPath()%>/board/selectUserHome?id=' + id; 
	}

	
</script>
<style>




</style>
</head>
<body>
	<header class="header">
		<jsp:include page="/WEB-INF/views/layout/header.jsp" flush="true" />
	</header>
	
	
	<section class="board">
        <!-- ????????? ??????, ??????, ?????????, ?????????, ?????????, ????????? ??????-->
        <div class="user_box">
            <div class="user_img_box">
           		<c:if test="${empty userProfile.pSaved}">
					<img id="user_img" class="pointer" onclick="location.href='<%=request.getContextPath()%>/board/selectUserHome?id=${userProfile.id}'"  src="${pageContext.request.contextPath}/resources/image/profile_default.png">
            	</c:if>
            	<c:if test="${not empty userProfile.pSaved}">
            		<img id="user_img" class="pointer" onclick="location.href='<%=request.getContextPath()%>/board/selectUserHome?id=${userProfile.id}'" src="/${userProfile.pPath}/${userProfile.pSaved}">           				
            	</c:if>
            </div>
            
        	<div class="user_item_box">
                <span>${userProfile.id}</span>
				
				<div class="friend_box">
					<c:if test="${not empty followingList}">
						<c:forEach items="${followingList}"  var="followingList" begin="0" end="4">
								
								<c:if test="${empty followingList.profile.pSaved}">
									<img title="${followingList.profile.id}" id="friends_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" class="defaultImg pointer" onclick="fnMoveUserHome('${followingList.profile.id}')">
								</c:if>
								<c:if test="${not empty followingList.profile.pSaved}">
									<img title="${followingList.profile.id}" id="friends_img" src="${pageContext.request.contextPath}/${followingList.profile.pPath}/${followingList.profile.pSaved}" class="pointer" onclick="fnMoveUserHome('${followingList.profile.id}')">
								</c:if>	
						</c:forEach>
					</c:if>		
				</div>   
            </div>
         </div>
      <div class="follow_container">
         <div class="select_box">
         		<div id="left_select_box" class="checked">
         			<p id="follower_text" class="checked1">?????????(${fn:length(followedList)})</p>
         		</div>
         		<div id="right_select_box" class="unchecked">
         			<p id="following_text" class="unchecked1">?????????(${fn:length(followingList)})</p>
          		</div>
           	</div>
         <div class="content_box">
           		<div id="left_follow_box" class="left_follow_box follow_see">
           			<c:if test="${empty followedList}">
             			<div class="each_follow_box no_follow_box">
             				<p class="no_follow">????????? ??????<p>
             			</div>
             		</c:if>
           			<c:if test="${not empty followedList}">
						<c:forEach items="${followedList}"  var="followedList">
							<div class="each_follow_box" >
								<c:if test="${empty followedList.profile.pSaved}">
									<img id="user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" class="defaultImg pointer" onclick="fnMoveUserHome('${followedList.followingId}')">
								</c:if>
								<c:if test="${not empty followedList.profile.pSaved}">
									<img id="user_img" src="${pageContext.request.contextPath}/${followedList.profile.pPath}/${followedList.profile.pSaved}" onclick="fnMoveUserHome('${followedList.followingId}')">
								</c:if>
								<div class="profile_next_id" onclick="fnMoveUserHome('${followedList.followingId}')">${followedList.followingId}</div>
								<div class="profile_next_content">${followedList.profile.pContent}</div>		
							</div>	
						</c:forEach>
					</c:if>
           		</div>
           		<div id="right_follow_box" class="right_follow_box follow_no">
           			<c:if test="${empty followingList}">
			 		<div class="each_follow_box no_follow_box">
			 			<p class="no_follow">??????????????? ?????? ??????</p>
			 		</div>
			 	</c:if>
           			<c:if test="${not empty followingList}">
						<c:forEach items="${followingList}"  var="followingList">
							<div class="each_follow_box">
								<c:if test="${empty followingList.profile.pSaved}">
									<img id="user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" class="defaultImg"  onclick="fnMoveUserHome('${followingList.followedId}')">
								</c:if>
								<c:if test="${not empty followingList.profile.pSaved}">
									<img id="user_img" src="${pageContext.request.contextPath}/${followingList.profile.pPath}/${followingList.profile.pSaved}"  onclick="fnMoveUserHome('${followingList.followedId}')">
								</c:if>
								<div class="profile_next_id"  onclick="fnMoveUserHome('${followingList.followedId}')">${followingList.followedId}</div><br>	
								<div class="profile_next_content">${followingList.profile.pContent}</div>
							</div>	
						</c:forEach>
					</c:if>			
           		</div>
           	</div>
  	  </div>
</section>
	

</body>
</html>