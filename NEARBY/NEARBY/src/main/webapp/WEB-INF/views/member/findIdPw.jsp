<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>* 아이디/비밀번호 찾기 *</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/findIdPw.css">
<script src="${pageContext.request.contextPath}/resources/js/findIdPw.js"></script>

<!--
<script>
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
			$('#verify_msg').html('회원님의 아이디는 <strong>'+ id +'</strong> 입니다.').addClass('pass_msg');
			authCodePass = true;
		}else{
			alert('인증 실패');
			authCodePass = false;
		}
	});
}// fnVerifyAuthCode

</script>
-->


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

                    <!-- 아이디 -->
                    <label for="email">찾을 비밀번호의 아이디</label>
                    <span class="space">
                        <input type="text" id="pwId" name="pwId">
                    </span>

                    <!-- 아이디 확인 버튼-->
                    <input type="button" value="확인" id="idCheck_btn">
                    <span id="idCheck_msg"></span>

                    <div class="emailCheck_box">
                        <!-- 이메일 -->
                        <label for="email">회원정보에 등록한 이메일 인증</label>
                        <span class="space">
                            <input type="text" id="pwEmail" name="pwEmail">
                        </span>
                        
                        <!-- 이메일 확인 -->
                        <input type="button" value="이메일 확인" id="emailCheck_btn">
                        <!-- 인증코드 발송 버튼-->
                        <input type="button" value="인증번호받기" id="pwAuthCode_btn">
                        <span id="pwEmail_check_msg"></span>
                    </div>

                    <!-- 인증코드 입력 칸 -->
                    <div id="pwAuthCode_box">
                        <span class="space">
                            <input type="text" name="authCode" id="pwAuthCode">
                        </span>
                        <input type="button" value="인증하기" id="pwVerify_btn">
						<span id="pwVerify_msg"></span>

                        <input type="button" id="updatePw" value="임시 비밀번호 발급 받기">

                    </div>
                </div> 
                </form>
            </div>
        </div>
    </div>
</body>
</html>