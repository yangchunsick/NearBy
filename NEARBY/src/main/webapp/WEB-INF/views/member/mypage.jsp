<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<style>
	/* 초기화 */
	*{ margin: 0; padding: 0; box-sizing: border-box; font-size: 14px; font-weight: 600; }
	html{ background-color: rgb(240, 242, 245); }
	a{ text-decoration: 0; color: black; }
	ul, ol{ list-style-type: none; }
	
	label{
	    display: block;
	    text-align: left;
	    padding-bottom: 5px;
	    font-size: 18px;
	}
	
	input{
		background-color: aliceblue;
	    border: 2px solid rgb(0, 0, 0, 0);
	}
	
	input:focus{
	    outline: none;
	}
	
	.container{
	    width: 600px;
	    margin: 100px auto;
	    background-color: white;
	    border-radius: 30px;
	}
	
	.head{
	    width: 100%;
	}
	
	/* 상단 로고 */
	.title > a{
	    display: block;
	    width: 200px; height: 130px;
	    margin: 30px auto;
	    text-align: center;
	    font-size: 0;
	
	    background-image: url(/NearBy_logo.png);
	    background-size: 200px 130px;
	    background-repeat: no-repeat;
	}
	
	.join_form{
	    width: 600px;
	    margin: 0 auto;
	}
	/* 회원 탈퇴 구역 */
	.leave_user_wrap {
		position: relative;
		margin: 0 auto;
	}
	.current_pw_check_box{
		background-color: white;
		z-index: -5;
		width: 500px;
		height: 300px;
		position: absolute;
	    border-radius: 10px;
		margin-left: 50px;
		margin-top: 100px;
	    border: 2px solid lightgray;
	}
	.current_pw_check_box label {
		margin: 20px 300px 0 28px;
		width: 120px;
	}
	
		/* 현재 비밀번호 */
	.current_pw_check_box #password_check_btn {
	    width: 102.5px;
	    height: 45px;
	    background-color: pink;
	    border-radius: 10px;
	    font-size: 12px;
	    margin-left: 5px;
	}
	.current_pw_check_box #pw {
		width: 337.5px;
		height: 45px;
	    border-radius: 10px;
	    margin-bottom: 5px;
		background-color: aliceblue;
	}
	#current_pw_box {
		display: flex;
		width: 440px;
		margin: 20px auto 0 auto;
	}
	
	/* 탈퇴 박스 띄우는 버튼 */
	#show_leave_btn_box {
		float: right;
		margin: 20px 20px 0 0;
		background-color: white;
		font-weight: 400;
		color: lightgray;
		font-size: 10px;
	}
	#show_leave_btn_box:hover {
		text-decoration: underline;
	}
	/* 찐 탈퇴 버튼 */
	#leave_btn {
		color:white;
	    width: 220px; height: 50px;
	    background: linear-gradient(#ff6e56,#ff3268);
	    border-radius: 10px;
		border: none;
		margin: 30px 140px 20px 140px;
	}
	.close_leave_btn_box{
		display: none;
	}
	#close_leave_btn_area{
		display: block;
	}
	#close_leave_area_icon {
	    margin-left: 460px;
	    font-size: 20px;
	    padding: 5px;
	    margin-top: 8px;
	}
	.opacity_box {
		opacity: 0.3;
	}
/* ---------------------- 탈퇴 구역 끝 ----------------------- */
	
	
	/* profile area */
	#user_img:hover{
		visibility: visible;
	}
	#profile_area {
		height: 150px;
		padding: 50px 0 0 80px;
		position: relative;
		display: flex;
	}
	#p_img #user_img {
		width: 100%;
		height: 100%;
		border-radius: 100%;
	}
	.defaultImg{
		background-image: url(../image/profile_default.png);
		background-size: 100px 100px;
	}
	
	.content_box {
		margin-left: 20px;
	}
	#content {
		border-radius: 10px;
		border: 1px solid rgba(50,50,50,0.3);
		padding: 10px;
		resize: none;
		outline: none;
	}
		/* file box */
	.file_box{
		width:250px;
		height: 150px;
		position: absolute;
		z-index: -1;
		background-color: pink;
		text-align: center;
		border-radius: 10px;
		border: 1px solid rgba(50,50,50,0.3);
		top: 150px;
	}
	#p_img:before{
		content: attr(data-msg);
		font-weight: lighter;
		font-size: 12px;
		position: absolute;
		z-index:2;
		visibility: hidden;
		background-color: pink;
		border-radius: 10px;
		padding:5px;
	}
	#p_img:hover:before{
		visibility: visible;
	}
	.show {
		z-index: 3;
	}
	#file {
		margin:10px auto 20px;
		width: 200px;
		background-color: white;
		border-radius: 10px;
		padding: 5px;
		font-weight: 400;
	}

	#profile_result {
		width: 100px;
		height: 100px;
		border-radius:  100px;
	}
	.p_btn {
		padding-top: 10px;
		background-color: white;
		font-size: 14px;
	}
	.p_btn:hover {
		text-decoration: underline;
	}
		/* profile area / file box / btns */
	.delete_update_form{
		width: 148px;
		border-radius: 10px;
		border : 1px solid rgba(50,50,50,0.3);
		margin: 0 auto;
		padding: 3px;
		text-align: center;
		background-color: white;
		display: flex;
   }
   	#close_file_box_icon_area {
		display: block;
   		width: 16px;
    	margin-left: 220px;
	}
   		/* 사진박스 닫기 아이콘 */
   #close_file_box_icon {
		font-size: 16px;
		margin: 10px 10px 0 0;
   }
   .delete_update_form li:first-child {
		border-right: 1px solid rgba(50,50,50,0.3);
   }
   .delete_update_form li {
		padding: 5px;
   }
    .delete_update_form li input {
       font-size: 12px;
       font-weight: 400;
       background-color: white;
    }
    .delete_update_form li input:hover {   font-weight: bold;  }
    
    
	#user_name_area {
		font-size: 20px;
		padding-top: 50px;
		margin-left: 50px;
	}

	
	/* 
	    아이디, 비밀번호, 비밀번호 재확인, 이름
	*/
	.input_box{
	    width: 450px;
	    margin: 35px auto;
	}
	
	.input_box input{
	    width: 100%; height: 45px;
	    border-radius: 10px;
	}
	
	/* 번호 */
	.tel_box{
	    width: 450px; height: 100%;
	    margin: 35px auto;
	
	}
	
	.tel_box > span > input{
	    width: 450px; height: 45px;
	    border-radius: 10px;
	}
	
	/* 생년월일 */
	.birth_box{
	    width: 450px;
	    margin: 35px auto;
	}
	
	.birth_box > select, option{
	    width: 120px; height: 40px;
	    text-align: center;
	    margin: 0 10px 0 0;
	    font-size: 16px;
	}
	
	/* 성별 */
	.gender_box{
	    width: 450px;
	    margin: 35px auto;
	}
	
	.gender_box > p{
	    font-size: 18px;
	    padding-bottom: 5px;
	}
	
	.gender_box > label{
	    display: inline-block;
	    padding-bottom: 5px;
	    margin: 0 40px 0 40px;
	}
	
	/* input tag 공백 */
	.space input[type=text] {
		padding-left:15px;
	}
	
	/* 회원가입 버튼 */
	.btn_wrap{
	    width: 450px;
	    margin: 35px auto;
	}
	#change_pw_btn {
		background-color: pink;
	}
	#change_pw_btn:hover {
		background-color: #ff6e56;
	}
	
	.btn_wrap input{
		color:white;
	    width: 220px; height: 50px;
	    background: linear-gradient(#ff6e56,#ff3268);
	    border-radius: 10px;
	    margin-bottom: 40px;
		border: none; 
	}
	
	/* 포인터 */
	.pointer:hover {
		cursor: pointer;
	}

</style>

<script type="text/javascript">

//이름/비밀번호/핸드폰/생일/성별 --> 이메일은X

	$(document).ready(function(){
		fnFindMemberInfo();
		fnBirth();
		fnFileCheck();
		fnHomeBtn();
		fnProfilePic(); // 프로필 사진 등록
		fnDeleteProfilePic(); // 프로필 사진 초기화
		fnModifyMemberInfo();
		fnLeave();	// 회원탈퇴
		fnCurrentPwCheck(); // 탈퇴시 비밀번호 확인
		fnChangeBtn(); // 비밀번호 변경페이지 이동
	}); 
 	 	
    // 아이디
	let regId = /^[a-zA-Z0-9_-]{4,}$/;
    // 이름
	let regName = /^[a-zA-Z가-힣]{1,30}$/;
    // 핸드폰 번호
	let regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
	let id_result = false;
	let name_result = false;
	let phone_result = false;
	let pw_result = false;
   
 /* ************************************************************************************ */
/* ------------------------------------------------------------ fnFindMemberInfo() ------------------------------------------------------------ */
	// 서브밋 방지 함수
	function fnPreventSubmit() {

 	}
	
/* ------------------------------------------------------------ fnFindMemberInfo() ------------------------------------------------------------ */
	// 회원 조회 함수
	function fnFindMemberInfo(){
	 
		$.ajax({
			 url: '/nearby/member/memberInfo', // url에 param이 아니라, 변수가 포함되어 넘어간다.
			type: 'post',
			dataType: 'json', // 받아오는 data Type
			success: function(map){
				if(map.loginErrorMsg != null) {
					Swal.fire({
						icon: 'error',
						title: '로그인세션만료',
						text: '로그인을 다시 진행해 주세요.',
					})
				} else if (map.member != null) { 
				let birthday = map.result.birthday;
				console.log(birthday);
				let year = birthday.substring(0,4);
				let month = birthday.substring(4,6);
				let day = birthday.substring(6,8);
					$('#user_name_area').text(map.result.name + '님 환영합니다.');
					$('#mNo').val(map.result.mNo); 
					$('#phone').val(map.result.phone);
					$('#content').val(map.result.profile.pContent);
					$('#name').val(map.result.name);
					$('#birthday').val(year);
					$('#month').val(month);
					$('#day').val(day);
					if (map.result.profile.pOrigin != null) {
						$('#user_img').attr('src', '/nearby/' + map.result.profile.pPath + '/' + map.result.profile.pSaved);
					} else {
						$('#user_img').attr('src', '${pageContext.request.contextPath}/resources/image/profile_default.png');
					}
					$('input:radio[name="gender"][value="'+map.result.gender+'"]').prop('checked', true); // prop는 객체에 저장 된 값이므로 true or false가 된다
				} else {
					Swal.fire({
						icon: 'error',
						title: '회원정보를 찾을 수 없음',
						text: '죄송합니다. 회원님과 일치하는 정보가 없습니다.',
					})
				}
			}
		}) // End ajax
 	} // End fnFindMemberInfo


/* ------------------------------------------------------------ fnFileCheck() ------------------------------------------------------------ */
	// 첨부파일 점검 함수 (확장자 + 크기)
	function fnFileCheck(){
		
		$('#file').on('change', function(){
			/* 확장자 점검 */
			let origin = $(this).val(); // 첨부된 파일명
			let extName = origin.substring(origin.lastIndexOf(".") + 1).toUpperCase(); // 확장자를 대문자로 저장 aaa.aaa.aaa.ccc 일 때, 마지막 마침표 다음 자리부터 끝까지 substring으로 가지고오고 
			if ( $.inArray(extName, ['JPG', 'JPEG', 'GIF', 'PNG']) == -1 ) {	// 첨부된 파일이 ['JPG', 'JPEG', 'GIF', 'PNG'] 중 하나가 아니면 (-1) :: 확장자 제한 두기
				Swal.fire({
					icon: 'warning',
					title: '확장자를 확인해주세요',
					text: '첨부 가능한 이미지의 확장자는 jpg, jpeg, gif, png 입니다.'
				});
				$(this).val(''); // 첨부 초기화
				return;
			}			
			
			/* 파일크기 점검 */
			let maxSize = 1024 * 1024 * 10;	// 최대 크기 10MB
			let fileSize = $(this)[0].files[0].size; // 첨부된 파일 크기
			if (fileSize > maxSize) {
				Swal.fire({
					icon: 'warning',
					title: '파일의 크기를 확인해 주세요',
					text: '10MB 이하의 파일만 사용하실 수 있습니다.'
				});
				$(this).val('');
				return;
			}
			
		}) // change function
		
	} //fn FileCheck
	

/* ------------------------------------------------------------ fnProfilePic() ------------------------------------------------------------ */
	// 프로필 사진 변경
	function fnProfilePic(){
		$('#insert_btn').on('click', function(){
			
			let formData = new FormData();
				let file = $('#file')[0].files[0];
				console.log(file);
				formData.append('file', file); // 첨부를 FormData에 넣기
/* 				console.log(formData); */
				$.ajax({
				url: '/nearby/profile/profilePic',
				type: 'post',
				contentType: false,
				processData: false,
				data: formData,
				enctype: 'multipart/form-data',
				dataType: 'json',
				success: function(map){
					let name = '${loginUser.name}';
					if(map.insertResult && map.insertResult != null) {
						Swal.fire({
							icon: 'success',
							title: '사진등록완료',
							text: name + '님의 프로필 사진등록이 완료되었습니다.',
						})
						$('#file').val('');
						$('.file_box').removeClass('show');
	/* 					fnShowAttachedFile(map); */
						fnFindMemberInfo();
					} else if (map.nullMsg != null) {
						console.log(map.nullMsg);
						Swal.fire({
							icon: 'error',
							title: '사진의 변경사항 없음',
							text: name + '님의 프로필 사진등록을 실패했습니다.',
						})
					} else {
						Swal.fire({
							icon: 'error',
							title: '사진등록실패',
							text: name + '님의 프로필 사진등록을 실패했습니다.',
						})
					}
				} // success
			}) // End ajax
			
		}) // End insert_btn click event
	} // fnProfilePic

/* ------------------------------------------------------------ fnProfilePic() ------------------------------------------------------------ */
	// 사진 삭제
	function fnDeleteProfilePic(){
		$('#delete_btn').on('click', function(){

			$.ajax({
			url: '/nearby/profile/profilePicDelete',
			type: 'post',
			dataType: 'json',
			success: function(map){
				let name = '${loginUser.name}';
				if(map.deleteResult && map.deleteResult != null) {
					Swal.fire({
						icon: 'success',
						title: '사진초기화완료',
						text: name + '님의 프로필이 초기화되었습니다.',
					})
					$('#file').val('');
					$('.file_box').removeClass('show');
					fnFindMemberInfo();
				} else {
					Swal.fire({
						icon: 'error',
						title: '사진초기화실패',
						text: name + '님의 프로필이 초기화되지 않았습니다.',
					})
				}
				} // success
			}) // End ajax
		}) // End deleteBtn Click Event
	} //  End fnDeleteProfilePic
	
	
/* ------------------------------------------------------------ fnShowAttachedFile() ------------------------------------------------------------ */
	// 첨부된 파일 확인 함수
/*  	function fnShowAttachedFile(map) {
		$('#profile_result').empty();
	
		$('#profile_result')
		.append( $('<div id="p_img" style="width:100%;height:100%;">').html( $('<img>').attr('src', '/nearby/' + map.profile.pPath + '/' + map.profile.pSaved) ) );
	} 
 */

/* ---------------------------------------------------------- fnModifyMemberInfo() ------------------------------ */
	// 회원정보 수정하기 modify_btn"
	function fnModifyMemberInfo() {
		$('#modify_btn').click(function(){
	// /nearby/member/modifyMember'
 			let member = JSON.stringify({
				mNo: $('#mNo').val(),
				profile : {pContent : $('#content').val()},
				name: $('#name').val(),
				phone: $('#phone').val(),
				birthday: $('#birthday').val() + $('#month').val() + $('#day').val(),
				gender: $('input:radio[name="gender"]:checked').val()
			}); 
			
			$.ajax({
				url: '/nearby/member/modifyMember',
				type: 'post',
				data: member,
				contentType: 'application/json',
				dataType: 'json',
				success: function(map){
					if(map.result && map.result != null) {
						Swal.fire({
				            icon: 'success',
				            title: '수정완료',
				            text: map.member.name + '님의 회원정보가 수정되었습니다.',
				        });
						fnFindMemberInfo();
					} else if (map.nullErrorMsg == '올바른 형식이 아닙니다.'){
						Swal.fire({
				            icon: 'error',
				            title: map.nullErrorMsg,
				            text: '핸드폰 번호는 11자리 정수입니다.',
				        });
					} else if (map.nullErrorMsg != null){
						Swal.fire({
	                        icon: 'error',
	                        title: map.nullErrorMsg,
	                        text: map.nullErrorMsg + ' 내용을 채워주세요.',
	                    });
					} else {
						Swal.fire({
				            icon: 'error',
				            title: '잘못 된 접근',
				            text: '잘못 된 접근입니다. 다시 시도해 주세요.',
				        });
					}
				} // End fn_success
			}) // End ajax
		}) // End modify_btn click event
	} // End fnModifyMemberInfo

	
/* ---------------------------------------------------------- fnLeave() ------------------------------ */
	// 회원 탈퇴
	function fnLeave() {
		$('#leave_btn').on('click', function(){
					
			if(confirm('정말 탈퇴하시겠습니까?') == false) { // confirm이 false이면 return
				return;
			} else { // confirm이 true이면 pw_result check
				if(pw_result == true) { // if pw_result == true이면 submit
					Swal.fire({
			            icon: 'error',
			            title: '탈퇴되었습니다.',
			            text: 'NearBy를 이용해주셔서 감사합니다.',
			        });
					$('#form').attr('action', '/nearby/member/leaveMember/');
					$('#form').submit();
				} else if (pw_result == false || $('#pw').val()=='') { // pw_result == false 이면 return;
					Swal.fire({
			            icon: 'error',
			            title: '비밀번호 확인필요',
			            text: '비밀번호 확인 후 진행해 주세요',
			        });
					return;
				}
			}

		}) // End click event
	} // End fnLeave
	
/* ------------------------------------------------------------ fnCurrentPwCheck() ------------------------------------------------------------ */
	// 현재 비밀번호 확인 함수
	function fnCurrentPwCheck() {  // checkPassword
	    $('#password_check_btn').on('click',function(){ // TODO ajax로 select 결과 받아서 처리하기해야함.

			$.ajax({
				url : '/nearby/member/checkPassword',
				type : 'post',
				data : 'pw=' + $('#pw').val(),
				dataType: 'json',               // 받아올 데이터 타입
				success : function(map){
					let name = '${loginUser.name}';
					fnPwCheck(map);
					 if( map.selectResult > 0){
						Swal.fire({
							icon: 'success',
							title: '비밀번호 확인완료',
							text: name + '님의 비밀번호가 확인되었습니다.',
						})
						 pw_result = true;
		             } else if(map.selectResult == 0) {
						Swal.fire({
							icon: 'error',
							title: '비밀번호 재확인필요',
							text: name + '님의 비밀번호가 일치하지 않습니다. 다시시도해 주세요.',
						})
						 pw_result = false;
					 }
					 console.log(pw_result);
				}, // End Seuccess function
				error : function(xhr, ajaxOptions, thrownError) {
			       alert(xhr.responseText);
				} // End Error function
				
			}) // End ajax
		}); // click event
		
	function fnPwCheck(map){
	    $('#pw').on('keyup', function(){
	        if($('#pw').val() == ''){
	            pw_result = false;
				return;
	        }else if(map.selectResult > 0){
	            pw_result = false;
				return;
	        }else{
	            pw_result = true;
	        }
	    });
	}// end fnPwCheck
	} // End fnCurrentPwCheck

	
</script>
	    
<script>


/* --------------------------------------- fnShowLeaveFormArea() --------------------------------------- */
	// 회원탈퇴 누르면 비밀번호 확인 area 보이기
	function fnShowLeaveFormArea() {
		$('.current_pw_check_box').toggleClass('show');
		$('#user_name_area').toggleClass('opacity_box');
		$('.join_form').toggleClass('opacity_box');
	} // fnShowLeaveFormArea
	
/* --------------------------------------- fnCloseBtn() --------------------------------------- */
	// close btn 누르면 사라지기
	function fnCloseBtn(){
		$('.current_pw_check_box').toggleClass('show');
		$('#user_name_area').toggleClass('opacity_box');
		$('.join_form').toggleClass('opacity_box');
	}	

/* --------------------------------------- fnShowBtnBox() --------------------------------------- */
	// file box 보이기
	function fnShowBtnBox() {
		$('.file_box').toggleClass('show');
	}

/* ---------------------------------------	fnHomeBtn()	------------------------------------------- */
	// 홈으로 가기
	function fnHomeBtn() {
		$('#home_btn').on('click', function(){
			if(confirm('홈으로 이동하시겠습니까?')) {
				location.href='/nearby/board/updateProfilePicture';
			}
		}) // End home_btn click event
	} // End fnHomeBtn
	
/* ---------------------------------------	fnHomeBtn()	------------------------------------------- */
	// 비번 바꾸기
	function fnChangeBtn() {
		$('#change_pw_btn').on('click', function(){
			if(confirm('비밀번호 변경 화면으로 이동하시겠습니까?')) {
				location.href='/nearby/member/changePasswordPage';
			}
		}) // End find_pw_btn 
	} // End 


	// 생년월일 삽입
	function fnBirth(){
		let year = '';
		year +=  '<option>년도</option>';
		for(let i=2007; i>=1907; i--){
		    year += '<option value="'+i+'">'+i+'</option>';
		}
		 $('#birthday').html(year);
		
		let month = '';
		month +=  '<option>월</option>';
		for(let i=1; i<=9; i++){
		    month += '<option value="'+'0'+i+'">'+'0'+i+'</option>';
		}
		for(let i=10; i<=12; i++){
		    month += '<option value="'+i+'">'+i+'</option>';
		}
		 $('#month').html(month);
		 
		 let day ='';
		 day += '<option>일</option>';
		 for(let i=1; i<=9; i++){
		     day += '<option value="'+'0'+i+'">'+'0'+i+'</option>';
		 }
		 for(let i=10; i<=31; i++){
		     day += '<option value="'+i+'">'+i+'</option>';
		 }
		  $('#day').html(day);	 
	}
</script>
</head>
<body>

 <!-- 레이아웃 header 삽입하기 -->
    <div class="container">
    	<c:if test="${loginUser.state == -1}">
    		<h1>탈퇴된 회원의 페이지 입니다.</h1>
    	</c:if>
    	<c:if test="${loginUser.state == 0}">
	    	<!-- 회원탈퇴 -->
	    	<div class="leave_user_wrap">
	    		<input type="button" id="show_leave_btn_box" class="btn pointer" value="회원탈퇴하기" onclick="fnShowLeaveFormArea()">
	    			<!-- 탈퇴시, 비밀번호 인증 -->
                <div class="current_pw_check_box">
                	<div id="close_leave_btn_area">
	               		<i id="close_leave_area_icon" class="fas fa-times pointer" onclick="fnCloseBtn()"></i>   
                	</div>
                    <label for="pw">현재 비밀번호</label>
               		
               		
                    <div id="current_pw_box">
	                    <span class="space">
	                  	  <input type="text" id="pw" name="pw">
	                    </span>
	                    <span>
		                    <input type="button" value="확인하기" id="password_check_btn" class="pointer">
	                    </span>
                    </div>
		    		<input type="button" id="leave_btn" class="btn pointer" value="회원탈퇴하기">
                </div>
	    	</div>
	    	
	    	<p id='user_name_area'></p>
	    	<div id="profile_area">
				<div id="profile_result">
					<div id="p_img" style="width:100%;height:100%;" data-msg="이미지변경">
						<c:if test="${empty loginUser.profile.pSaved}">
							<img id="user_img" src="${pageContext.request.contextPath}/resources/image/profile_default.png" onclick="fnShowBtnBox()" class="pointer defaultImg">
						</c:if>
						<c:if test="${not empty loginUser.profile.pSaved}">
							<img id="user_img" src="/nearby/${loginUser.profile.pPath}/${loginUser.profile.pSaved}" onclick="fnShowBtnBox()" class="pointer">
						</c:if>
					</div>
				</div>
				<div class="content_box">
					<textarea rows="5" cols="25" placeholder="자신을 맘껏 표현해보세요" id="content" name="content"></textarea>
				</div>
				<!-- 첨부박스 -->
				<div class="file_box">
					<div id="close_file_box_icon_area">
						<i id="close_file_box_icon" class="fas fa-times pointer" onclick="fnShowBtnBox()"></i>   
					</div>
					<input type="file" id="file" class="pointer">
					<ul class="delete_update_form">
						<li><input type="button" value=' 사진변경 ' id="insert_btn"  class="pointer"></li>
						<li><input type="button" value='사진초기화' id="delete_btn"  class="pointer"></li>
					</ul>
				</div>
	    	</div>
	 
	        <div class="join_form">
	        	<form id="form" method="post">
					<input type="hidden" value="${loginUser.mNo}" id="mNo" name="mNo">
	        	</form>
	               <!-- 이름 -->
	               <div class="input_box">
	                   <label for="name">이름</label>
	                   <span class="space">
	                    <input type="text" id="name" name="name">
	                   </span>
	                   <span id="name_check"></span>
	               </div>
	
	               <!-- 번호 -->
	               <div class="tel_box">
	                   <label for="phone">핸드폰 번호</label>
	                   <span class="space">
	                    <input type="text" id="phone" name="phone" placeholder=" - 표시 없이 입력해주세요">
	                   </span>
	                   <span id="phone_check"></span>
	               </div>
	               
	               <!-- 생년월일 -->
	               <div class="birth_box">
	                   
	                   <!-- 년도 -->
	                   <label for="birthday">생년월일</label>
	                   <select id="birthday" name="year"  class="pointer"></select>
	
	                   <!-- 월 -->
	                   <select id="month" name="month"  class="pointer">
	                       <option>월</option>
	                   </select>
	
	                   <!-- 일 -->
	                   <select id="day" name="day"  class="pointer">
	                       <option>일</option>
	                   </select>
	               </div>
	
	               <!-- 성별 -->
	               <div class="gender_box">
	                   <p id="gender_box">성별</p>
	                   <!-- 여성 -->
	                   <input type="radio" name="gender" value="f" id="female" checked>
	                   <label id="f" for="female" class="pointer">여성</label>
	
	                   <!-- 남성 -->
	                   <input type="radio" name="gender" value="m" id="male" class="btns">
	                   <label id="m"  for="male" class="pointer">남성</label>
	
	                   <!-- 선택 안 함 -->
	                   <input type="radio" name="gender" value="n" id="n" class="btns">
	                   <label id="n"  for="n" class="pointer">선택안함</label>
	               </div>
	
	               <!-- 비밀번호 -->
	               <div class="input_box">
	                   <label for="find_pw_btn">비밀번호 수정</label>
	                   <input type="button"  class="btn pointer" id="change_pw_btn" value="비밀번호 변경 이동">
	               </div>
	
	               <div class="btn_wrap">
	                   <input type="button" id="modify_btn" class="btn btn-primary pointer" value="수정완료">                
	                   <input type="button" value="홈으로" id="home_btn" class="pointer">                
	               </div>                
	        </div>
    	</c:if>
    </div>
</body>
</html>