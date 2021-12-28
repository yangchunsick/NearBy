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
	
	.pw_change_box{
	    width: 600px;
	    margin: 0 auto;
	}
	
	/* 비밀번호 : 현재 비밀번호 / 새 비밀번호 / 새 비밀번호 확인 */
	.input_box{
	    width: 450px;
	    height: 80px;
	    margin: 35px auto 20px; 	
	}
	
	.input_box input{
	    width: 100%; height: 45px;
	    border-radius: 10px;
	}
	
	/* 이메일 */
	.email_box{
	    width: 450px;
	    margin: 35px auto;
	}
	
	.email_box input[type=text]{
	    width: 75%; height: 45px;
	    border-radius: 10px;
	    margin-bottom: 5px;
	}
	
	.email_box input[type=button]{
	    width: 23%; height: 45px;
	    background-color: pink;
	    border-radius: 10px;
	    font-size: 12px;
	}
	
	.email_box input[type=button]:hover{
	    background-color: #ff3268;
	}
	
	
	/* input tag 공백 */
	.space input[type=text] {
		padding-left:15px;
	}
	
	/* 정규식 메세지 */
	.error_msg {
	    font-size:13px;
	    color:red;
	}
	.pass_msg {
	    font-size:13px;
	    color:grey;
	}
	
	
	/* btn */
	.btn_wrap{
	    width: 450px;
	    margin: 35px auto;
	}
	.btn_wrap input, button{
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
	
	/* 안내메세지 박스 */
	.msg_box {
		padding: 5px;
	} 
	
	/* 현재 비밀번호 */
	#password_check_btn {
	    width: 102.5px;
	    height: 45px;
	    background-color: pink;
	    border-radius: 10px;
	    font-size: 12px;
	    margin-left: 5px;
	}
	#pw {
		width: 337.5px;
	}
	#current_pw_box {
		display: flex;
		width:220px;
	}
	
</style>

<script type="text/javascript">

//이름/비밀번호/핸드폰/생일/성별 --> 이메일은X

	$(document).ready(function(){
		fnCheckSubmit();             // 모든 함수 확인 후 서브밋넘기기
		fnCurrentPwCheck();
		fnNewPwCheck(); // 새 비밀번호 정규식
		fnPwDoubleCheck();
		fnCurrentEmailCheck();
		fnHomeBtn(); // 홈으로 가기
	}); 
	
	// 서브밋
	 function fnCheckSubmit(){
	  /*   $('#pw_change_form').on('submit', function(event){ */
	    $('#modify_btn').on('click', function(event){
	      if( confirm('변경하시겠습니까?') == false){
				event.preventDefault(); 
	          return false;
			} else if ( pw_result == false ) {
                event.preventDefault(); 
                console.log('submit result : ' + pw_result);
                return false;  
            } else if ( new_pw_result == false ) {
                event.preventDefault();  
                console.log('submit new_pw_result : ' + new_pw_result);
                return false;  
            } else if ( pw_double_result == false ) {
                event.preventDefault();  
                console.log('submit pw_double_result : ' + pw_double_result);
                return false;  
            } else if ( email_result == false ) {
				event.preventDefault();
                console.log('submit email_result : ' + email_result);
                return false;  
            } else if ( authCodePass == false ) { 
				event.preventDefault();
				alert('이메일 인증을 진행해주세요'); 
                console.log('submit authCodePass : ' + authCodePass);
            	return false;
            } else{
            	return true;
            }
	        });
	    } //   function fnCheckSubmit()
	    
	
    // 아이디
	let regId = /^[a-zA-Z0-9_-]{4,}$/;
    // 비밀번호
	let regPwd = /^[a-zA-Z0-9!@$%^&*()]{8,20}$/;
    // 이름
	let regName = /^[a-zA-Z가-힣]{1,30}$/;
    // 이메일
	let regEmail = /^[0-9a-zA-Z-_]+@[a-zA-Z0-9]+([.][a-zA-Z]{2,}){1,2}/;
    // 핸드폰 번호
	let pw_result = false;
	let new_pw_result = false;
	let pw_double_result = false;
	let email_result = false;
	let authCodePass = false;
      


/* -------------------------------------------------------------- fnNewPwCheck() ------------------------------------------------ */
      // 새 비밀번호 정규식 
      function fnNewPwCheck(){
         
         $('#newPw').on('blur keyup', function(){
            if( regPwd.test( $("#newPw").val())){    
                $("#new_pw_check").text("사용가능한 비밀번호입니다.").addClass("pass_msg").removeClass('error_msg');
                new_pw_result = true;
            } else if (    $('#newPw').val() == '' ){
                $("#new_pw_check").text('입력은 필수입니다.').addClass('error_msg').removeClass('pass_msg');
                new_pw_result = false;
            }    else {
                $("#new_pw_check").text("비밀번호는 8~20자의 영문 대/소문자, 숫자, 특수문자 등 3종류 이상으로 조합해주세요.").addClass('error_msg').removeClass('pass_msg');
                new_pw_result = false;
            }
         console.log("newPw: "+pw_result);
            return new_pw_result;
         }); 
      
      } // fnPwCheck
      
/* -------------------------------------------------------------- fnPwDoubleCheck() ------------------------------------------------ */
   // 비밀번호 재확인 일치 
         function fnPwDoubleCheck(){
          
          $('#pwCheck').on('blur keyup', function(){     
                if($('#newPw').val() !=  $("#pwCheck").val() ){
                    $("#pw_doubleCheck").text( '비밀번호가 일치하지 않습니다.').addClass('error_msg').removeClass('pass_msg');
                    pw_double_result = false;
                } else{
                    $("#pw_doubleCheck").text('').removeClass('error_msg').removeClass('pass_msg');
                    pw_double_result = true;
                }  
          console.log("pw2 : "+pw_double_result);
          return pw_double_result;
            });
      }

/* -------------------------------------------------------------- fnSendAuthCode() ------------------------------------------------ */
         function fnSendAuthCode(){
         	
         	$('#authCode_btn').click(function(){
         		$.ajax({
         			url : '/nearby/member/sendAuthCode',
         			type: 'post',
         			data: 'email='+ $('#email').val(),
         			dataType: 'json',
         			success : function(map) {
         				alert('인증코드가 발송되었습니다.');
         				fnVerifyAuthcode(map.authCode); // 12/13추가
         			},
         			error: function() {
     					alert('인증코드 전송 실패');
     				}
         		});	 // ajax
         	});
         	return;
         } 
/* ******************* 12/14 수정 ************* fnVerifyAuthcode() ********************* */
      	// 인증코드 검증 변수와 함수
      	function fnVerifyAuthcode(authCode){
      		$('#verify_btn').click(function(){
      			if ( $('#authCode').val() == authCode ) {
      				alert('인증되었습니다.');
      				authCodePass = true;
      			} else if ( $('#authCode').val() == '' ) { // 12/14 추가
      				alert('인증번호를 입력하세요');
      				authCodePass = false;
      			} else {
      				alert('인증에 실패했습니다.');
      				authCodePass = false;
      			}
      		}); // end click
      	}         
 /* ************************************************************************************ */
         
</script>

<script>
// 비밀번호 찾기 process 
// 가입당시 비밀번호는 ajax 처리하여 pass true - false 매김 -- DB 에서 비밀번호 일치하는지 확인 필요.
// 변경할 비밀번호와 비밀번호 재확인을 통해 비밀번호를 확인하고 -- pass true / false // 여기까지 되었다.
// 이후 통과되면 가입당시 입력한 이메일을 작성 -> 인증번호받고 인증하기 -- pass true / false
// 다 끝난 뒤에 수정완료 버튼을 누르면 page이동 : 페이지는 내 정보 변경 mypage
// 보낼 파라미터 새로운 pw / email


/* ------------------------------------------------------------- fnCurrentPwCheck() ------------------------------------------------- */	
	// 현재 비밀번호 확인 함수
	function fnCurrentPwCheck() {  // checkPassword
	    $('#password_check_btn').on('click',function(){ // TODO ajax로 select 결과 받아서 처리하기해야함.

			$.ajax({
				url : '/nearby/member/checkPassword',
				type : 'post',
				data : 'pw=' + $('#pw').val(),
				dataType: 'json',               // 받아올 데이터 타입
				success : function(map){
					console.log(map);
					let name = '${loginUser.name}';
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
			       console.log(xhr.responseText);
				} // End Error function
				
			}) // End ajax
		}); // click event
	} // End fnCurrentPwCheck
	
	
	
	
/* ------------------------------------------------------------- fnCurrentEmailCheck() ------------------------------------------------- */	
	// 현재 이메일 확인 함수
	function fnCurrentEmailCheck() {  // checkPassword
	    $('#authCode_btn').on('click',function(){ 

			$.ajax({
				url : '/nearby/member/selectByEmail',
				type : 'post',
				data : 'email=' + $('#email').val(),
				dataType: 'json',               // 받아올 데이터 타입
				success : function(map){
					console.log(map);
					let name = '${loginUser.name}';
					 if( map.result != null){
						Swal.fire({
							icon: 'success',
							title: '이메일 확인완료',
							text: name + '님의 이메일로 인증번호가 발송되었습니다.',
						})
						fnSendAuthCode(map.result.id);
						 email_result = true;
		             } else if(map.result == null) {
						Swal.fire({
							icon: 'error',
							title: '이메일 재확인필요',
							text: name + '님의 이메일이 일치하지 않습니다.',
						})
						 email_result = false;
					 }
					 console.log(email_result);
				}, // End Seuccess function
				error : function(xhr, ajaxOptions, thrownError) {
			       alert(xhr.responseText);
				} // End Error function
				
			}) // End ajax
		}); // click event
	} // End fnCurrentPwCheck
/* ------------------------------------------------------------- fnCurrentEmailCheck() ------------------------------------------------- */	
    function fnSendAuthCode(id){
    	
   /*  	$('#authCode_btn').click(function(){ */
    		$.ajax({
    			url : '/nearby/member/sendAuthCode',
    			type: 'post',
    			data: 'email='+ $('#email').val(),
    			dataType: 'json',
    			success : function(map) {
    				fnVerifyAuthcode(map.authCode, id); // 12/13추가
    			},
    			error: function() {
					alert('인증코드 전송 실패');
				}
    		});	 // ajax
/*     	}); */
    	return;
    }

/* ------------------------------------------------------------- fnCurrentEmailCheck() ------------------------------------------------- */	

   	// 인증코드 검증 변수와 함수
   	function fnVerifyAuthcode(authCode){
   		$('#verify_btn').click(function(){
   			if ( $('#authCode').val() == authCode ) {
   				alert('인증되었습니다.');
   				authCodePass = true;
   			} else if ( $('#authCode').val() == '' ) { // 12/14 추가
   				alert('인증번호를 입력하세요');
   				authCodePass = false;
   			} else {
   				alert('인증에 실패했습니다.');
   				authCodePass = false;
   			}
   			
   		}); // end click
   	}         


</script>	


<script>
/* ---------------------------------------	fnHomeBtn()	------------------------------------------- */
// 홈으로 가기
function fnHomeBtn() {
	$('#home_btn').on('click', function(){
		if(confirm('홈으로 이동하시겠습니까?')) {
			location.href='/nearby/board/updateProfilePicture';
		}
	}) // End home_btn click event
} // End fnHomeBtn
</script>
</head>
<body>

 <!-- 레이아웃 header 삽입하기 -->
 
    <div class="container">
    
        <div class="head">
            <h1 class="title"><a href="/nearby/">NearBy</a></h1>
        </div>
 
        <div class="pw_change_box">
    
            <form action="/nearby/member/changePassword" method="post" id="pw_change_form">

                <!-- 비밀번호 -->
                <div class="input_box">
                    <label for="pw">현재 비밀번호</label>
                    <div id="current_pw_box">
	                    <span class="space">
	                  	  <input type="text" id="pw" name="pw">
	                    </span>
	                    <span>
		                    <input type="button" value="확인하기" id="password_check_btn" class="pointer">
	                    </span>
                    </div>
                </div>
                
                <div class="input_box">
                    <label for="newPw">새 비밀번호</label>
                    <span class="space">
                  	  <input type="text" id="newPw" name="newPw">
                    </span>
                    <p id="new_pw_check" class="msg_box"></p>
                </div>

                <!-- 비밀번호 확인 -->
                <div class="input_box">
                    <label for="pw">새 비밀번호 확인</label>
                    <span class="space">
	                    <input type="text" id="pwCheck" >
                    </span>
                    <p id="pw_doubleCheck" class="msg_box"></p>
                </div>

                <!-- 이메일 -->
                <div class="email_box">

                    <!-- 이메일 -->
                    <label for="email">이메일</label>
                    <span class="space">
	                    <input type="text" id="email" name="email">
                    </span>

                    <!-- 인증코드 발송 -->
                    <span class="space">
	                    <input type="button" value="인증번호받기" id="authCode_btn" class="pointer">
                    </span>
                    <span id="email_check"></span>

                    <!-- 인증코드 입력 칸 -->
                    <span class="space">
	                    <input type="text" name="authCode" id="authCode">
                    </span>
                    <input type="button" value="인증하기" id="verify_btn" class="pointer">
                </div>

               <div class="btn_wrap">
                   <button id="modify_btn" class="btn btn-primary pointer">수정완료</button>             
                   <input type="button" value="홈으로" id="home_btn" class="pointer">                
               </div>                    
            </form>
            
        </div>
   
    </div>
</body>
</html>