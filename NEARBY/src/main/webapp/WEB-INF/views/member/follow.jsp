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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/follow.css">

<script type="text/javascript">

</script>
<style>




 
 
</style>
</head>
<body>
	<header class="header">
		<jsp:include page="/WEB-INF/views/layout/header.jsp" flush="true" />
	</header>
	
	<div class="follow_container">
			<h1> ${loginUser.id} 님</h1>
			<div class="follow">	
		   	   	  <div id="profile_box2">
		   	   	 	<c:if test="${empty loginUser.profile.pSaved}">
		   	   	 			<h1>없을때</h1>
							<img id="profile_img2" src="${pageContext.request.contextPath}/resources/image/profile_default.png" class="pointer defaultImg">
					</c:if>
					<c:if test="${not empty loginUser.profile.pSaved}">
							<img id="profile_img2" src="/nearby/${loginUser.profile.pPath}/${loginUser.profile.pSaved}" class="pointer">
							<h1>있을때</h1>
					</c:if>
		          </div>
			</div>
	</div>
	
</body>
</html>