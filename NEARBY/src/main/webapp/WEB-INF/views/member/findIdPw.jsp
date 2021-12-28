<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>* 아이디/비밀번호 찾기 *</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/findIdPw.css">
<%-- <script src="${pageContext.request.contextPath}/resources/js/findIdPw.js"></script>
 --%><script>
$(document).ready(function(){
    fnFindId();
    fnFindPw();
    fnEmailCheck();
});

// 이메일 정규식
let regEmail = /^[0-9a-zA-Z-_]+@[a-zA-Z0-9]+([.][a-zA-Z]{2,}){1,2}/;
let email_result = false;


function fnFindId(){
    $('#findId_btn').on('click', function(){
        $('#findPw_btn').css('backgroundColor', 'lightgray');
        $('#findId_btn').css('backgroundColor', 'white');
        $('.form_box').css('backgroundColor', 'white');
        $('#pw_box').css('zIndex', '1');
        $('#id_box').css('zIndex', '2');
    });
}


function fnFindPw(){
    $('#findPw_btn').on('click', function(){
        $('#findId_btn').css('backgroundColor', 'lightgray');
        $('#findPw_btn').css('backgroundColor', 'white');
        $('.form_box').css('backgroundColor', 'white');
        $('#id_box').css('zIndex', '1');
        $('#pw_box').css('zIndex', '2');
    });
}

/* 이메일 */
function fnEmailCheck(){

    $('#email').on('keyup blur', function(){
        if(regEmail.test($(this).val()) == false){
            $('#authCode_btn').css('disply', 'none');
            $('#email_check_msg').text('이메일을 다시 확인 해주세요.')
                                 .removeClass('pass_msg')
                                 .addClass('error_msg');
            email_result = false;
        }else{
            $('#email').css('width', '337.5px');
            $('#authCode').css('width', '337.5px');
            $('#authCode_btn').css('display', 'inline-block');
            $('#email_check_msg').text('')
            email_result = true;
        }
    });	
    
  
    
    
    


        email_result = true;
       // 인증코드 전송 버튼
        $('#authCode_btn').click(function(){
             
             // 이메일 있는지 확인하기
             $.ajax({
            	 url: "/nearby/member/selectByEmail",
            	 type: 'post',
            	 data : 'email=' + $("#email").val(),
            	 dataType: 'json',
            	 success: function(map){
            		 if(map.result != null ){
            			/*  $('#email_check_msg').html("회원님의 아이디는 <strong>"+map.result.id +"</strong> 입니다."); */
            			 fnSendAuthCode(map.result.id);
            		 } else {
     		 			$('#email_check_msg').text("입력하신 이메일 조회 결과 없는 회원입니다.");
            		 }
            	 }, 
            	 error : function(xhr) {
            		 $('#email_check_msg').text(xhr.responseText);
            		 return;
            	 }
             }); // 이메일 유무 확인
             
        });
       
       
       
       
}// end fnEmailCheck


function fnSendAuthCode(id){
	$("#authCode_box").css("display", 'inline-block');
	  $.ajax({
        url: '/nearby/member/sendAuthCode',
        type: 'post',
        data: 'email=' + $('#email').val(),
        dataType: 'json',
        success: function(map){
            $('#email_check_msg').text('인증코드가 발송 되었습니다.')
                                 .addClass('pass_msg');
            fnVerifyAuthCode(map.authCode, id);
        },
        error: function(){
            alert('인증코드 전송 실패');
        }
    }); // AJAX     
 }       
       
         


function fnVerifyAuthCode(authCode, id){
	$('#verify_btn').click(function(){
		if($('#authCode').val() == authCode){
			$('#verify_msg').html('회원님의 아이디는 <strong>'+id +'</strong> 입니다.').addClass('pass_msg');
			authCodePass = true;
		}else{
			alert('인증 실패');
			authCodePass = false;
		}
	});
}// fnVerifyAuthCode



</script>


<style>
@charset "UTF-8";
/* 기본 레이아웃 */
*{
    margin: 0; padding: 0;
    box-sizing: border-box;
    font-size: 14px;
    font-weight: 600;
}

html{
    background-color: rgb(240, 242, 245);
}

a{
    text-decoration: 0;
    color: black;
}

ul, ol{
    list-style-type: none;
}

.container{
    width: 600px; height: 400px;
    margin: 50px auto;
    position: relative;
}

/* 인풋 공통 레이아웃 작업 */

/* 
text input 
크기, 배경색, 테두리, 커서
*/
input[type="text"]{
    width: 280px; height: 40px;
    padding-left: 15px;
    background-color: rgb(232, 240, 254);
    border: 2px solid rgb(0, 0, 0, 0);
    border-radius: 10px;
    cursor: pointer;
}

input[type="text"]:focus{
    background-color: #91c7fa;
    box-shadow: 0 0 10px rgba(102, 179, 251, 0.5);
    outline: none;
}

.wrap{
    width: 600px; height: 400px;
    position: relative;
}

.container label{
    display: block;
    padding-bottom: 20px;
}


.input_wrap{
    width: 70%;
    margin: 0 auto;
    padding-top: 30px;
}

/* ID 박스 */
#id_box{
    position: absolute;
    z-index: 2;
}

#findId_btn[type="button"]{
    width: 280px; height: 80px;
    margin-right: 35.1px;
    background-color: white;
    border: none;
    border-radius: 30px 30px 0 0;
    cursor: pointer;
}

#id_box > .form_box{
    width: 100%; height: 100%;
    background-color: white;
    border-radius: 0 0 30px 30px;
}

/* PW 박스 */

#findPw_btn[type="button"]{
    width: 280px; height: 80px;
    background-color: lightgray;
    border: none;
    border-radius: 30px 30px 0 0;
    cursor: pointer;
}

#pw_box > .form_box{
    width: 100%; height: 100%;
    background-color: lightgray;
    border-radius: 30px 30px 30px 30px;
}

#pw_box{
    position: absolute;
    z-index: 1;
}

/* 이메일 인증 박스 defualt */
.input_wrap{
    width: 450px;
}

.input_wrap input[type=text]{
    width: 450px; height: 45px;
    border-radius: 10px;
    margin-bottom: 5px;
}

.input_wrap > input[type=button]{
    display: inline-block;
    width: 23%; height: 45px;
    background: linear-gradient(#ff6e56,#ff3268);
    border-radius: 10px;
    font-size: 12px;
    color: white;
    border: none;
    outline: none;
}

#authCode_box > input[type=text]{
    width: 75%; height: 45px;
    border-radius: 10px;
    margin-bottom: 5px;
}

#authCode_box > input[type=button]{
    width: 23%; height: 45px;
    background: linear-gradient(#ff6e56,#ff3268);
    border-radius: 10px;
    font-size: 12px;
    color: white;
    outline: none;
    border: none;
}

.email_box > #email_check_box{
    display: block;
}

#authCode_box{
    width: 450px;
    display: none;
}

</style>

</head>
<body>

	기본 뼈대
    
    <div class="container">
        <!-- 아이디 찾기 -->
        <input id="findId_btn" type="button" value="아이디 찾기">
        <div class="wrap" id="id_box">
            <div class="form_box">
                <form action="">
                    <!-- 이메일 -->
                    <div class="input_wrap">
    
                        <!-- 이메일 -->
                        <label for="email">아이디 찾기 회원정보에 등록한 이메일 인증</label>
                        <span class="space">
                            <input type="text" id="email" name="email">
                        </span>
                        
                        <!-- 인증코드 발송 버튼-->
                        <input type="button" value="인증번호받기" id="authCode_btn">
                        <span id="email_check_msg"></span>
                        
                        <!-- 인증코드 입력 칸 -->
                        <div id="authCode_box">
                            <span class="space">
                                <input type="text" name="authCode" id="authCode">
                            </span>
                            <input type="button" value="인증하기" id="verify_btn">
                            <span id="verify_msg"></span>
                        </div>
                        
                        <div>
                        	<span id="id_confirm"></span>
                        </div>
                    </div>   
                </form>
            </div>
        </div>

        <!-- 비밀번호 찾기 -->
        <input id="findPw_btn" type="button" value="비밀번호 찾기">
        <div class="wrap" id="pw_box">
            <div class="form_box">
                <form action="">
                <!-- 이메일 -->
                <div class="input_wrap">

                    <!-- 이메일 -->
                    <label for="email">비밀번호 찾기 회원정보에 등록한 이메일 인증</label>
                    <span class="space">
                        <input type="text" id="email" name="email">
                    </span>
                    
                    <!-- 인증코드 발송 버튼-->
                    <input type="button" value="인증번호받기" id="authCode_btn">
                    <span id="email_check_msg"></span>
                    
                    <!-- 인증코드 입력 칸 -->
                    <div id="authCode_box">
                        <span class="space">
                            <input type="text" name="authCode" id="authCode">
                        </span>
                        <input type="button" value="인증하기" id="verify_btn">
						<span id="verify_msg"></span>
                    </div>
                </div> 
                </form>
            </div>
        </div>
    </div>
</body>
</html>