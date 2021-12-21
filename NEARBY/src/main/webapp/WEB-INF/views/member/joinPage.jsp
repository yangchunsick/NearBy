<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>* NearBy 회원가입 페이지 *</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!--<script src="${pageContext.request.contextPath}/resources/js/join.js"></script>-->
<script type="text/javascript">
$(document).ready(function(){
	   fnIdCheck();
	   fnPwCheck();
	   fnPw2Check();
	   fnNameCheck();
	   fnEmailCheck();
	   fnPhoneCheck();
	   fnbirth();
	   fnAllCheck();
	   fnResetBtn();
	});

	// 아이디 정규식
	let regId = /^[a-zA-Z0-9_-]{4,32}$/;
	// 비밀번호 정규식
	let regPw = /^[a-zA-Z0-9!@$%^&*()]{8,20}$/;
	// 이름 정규식
	let regName = /^[a-zA-Z가-힣]{1,30}$/;
	// 이메일 정규식
	let regEmail = /^[0-9a-zA-Z-_]+@[a-zA-Z0-9]+([.][a-zA-Z]{2,}){1,2}/;
	// 핸드폰 번호 정규식
	let regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;

	let id_result = false;
	let pw_result = false;
	let pw2_result = false;
	let name_result = false;
	let email_result = false;
	let authCodePass = false;
	let phone_result = false;

	/* 아이디 */
	function fnIdCheck() {
	    // 1차 정규식 체크
	    $('#id').on('keyup', function(){
	        if(regId.test($(this).val()) == false ){
	            $('#id_check_msg').text('아이디는 4~ 32자의 영문 대소문자/숫자 사용 가능합니다.')
	                          .addClass('error_msg')
	                          .removeClass('pass_msg');
	            id_result = false;
	            return;
	        }
	        // 중복 체크
	        $.ajax({
	            url: '/nearby/member/idCheck',
	            type: 'post',
	            data: 'id=' + $(this).val(),
	            dataType: 'json',
	            success: function(map){
	                if(map.result == null){
	                    $('#id_check_msg').text('사용 가능한 아이디 입니다.')
	                                      .removeClass('error_msg')
	                                      .addClass('pass_msg');
	                    id_result = true;
	                }else if($('#id').val() == ''){
	                    $('#id_check_msg').text('필수 정보 입니다.')
	                                      .removeClass('pass_msg')
	                                      .addClass('error_msg');
	                    id_result = false;
	                    return;
	                }else{
	                    $('#id_check_msg').text('사용 중인 아이디 입니다.')
	                                      .removeClass('pass_msg')
	                                      .addClass('error_msg');
	                    id_result = false;
	                    return;
	                }
	            },
	            error: function(){
	                $('#id_check_msg').text('사용할 수 없는 아이디 입니다.')
	                                  .removeClass('pass_msg')
	                                  .addClass('error_msg');
	                id_result = false;
	            }
	        }); // AJAX
	        
	    });

	} // end fnIdCheck

	/* 비밀번호 */
	function fnPwCheck(){
	    $('#pw').on('keyup blur', function(){
	        if($('#pw').val() == ''){
	            $('#pw_check_msg').text('필수 정보 입니다.')
	                              .removeClass('pass_msg')
	                              .addClass('error_msg');
	            pw_result = false;         
	        }else if(regPw.test($(this).val()) == false){
	            $('#pw_check_msg').text('비밀번호는 8~20자의 영문 대/소문자, 숫자, 특수문자 등 3종류 이상으로 조합해주세요')
	                              .removeClass('pass_msg')                  
	                              .addClass('error_msg');
	            pw_result = false;
	        }else{
	            $('#pw_check_msg').text('사용 가능한 비밀번호 입니다.')
	                              .addClass('pass_msg')
	                              .removeClass('error_msg');
	            pw_result = true;
	        }

	        /*
	        $.ajax({
	            url: ,
	            type: ,
	            data: ,
	            dataType: ,
	            success: function(){

	            },
	            error: function(){

	            }
	        }); // AJAX
	        */
	    });
	}// end fnPwCheck

	/* 비밀번호 재확인 */
	function fnPw2Check(){
	    $('#pw2').on('keyup blur', function(){
	        if($('#pw').val() != $('#pw2').val() ){
	            $('#pw2_check_msg').text('비밀번호를 확인 해주세요.')
	                               .removeClass('pass_msg')
	                               .addClass('error_msg');
	            pw2_result = false;
	        }else{
	            $('#pw2_check_msg').text('');
	            pw2_result = true;
	        }

	    })
	}// end fnPw2Check

	/* 이름 */
	function fnNameCheck(){
	    $('#name').on('keyup blur', function(){
	       if($('#name').val() == ''){
	           $('#name_check_msg').text('필수 정보 입니다.')
	                               .removeClass('pass_msg')
	                               .addClass('error_msg');
	            name_result = false;
	       }else if(regName.test($(this).val()) == false){
	           $('#name_check_msg').text('정말 당신의 이름이 맞습니까 ?')
	                               .removeClass('pass_msg')
	                               .addClass('error_msg');
	            name_result = false;
	       }else{
	            $('#name_check_msg').text('멋있는 이름이군요 !')
	                                .removeClass('error_msg')
	                                .addClass('pass_msg')
	            name_result = true;
	       }
	    });
	}// end fnNameChekc

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
	            $('#authCode_btn').css('display', 'inline-block');
	            $('#email_check_msg').text('')
	            email_result = true;
	        }

	        // 인증 코드 버튼
	        $('#authCode_btn').on('click', function(){
	            $('#authCode_box').css('display', 'inline-block');
	        /*
	        $.ajax({
	            url: ,
	            type: ,
	            data: ,
	            dataType: ,
	            success: function(){

	            },
	            error: function(){

	            }
	        }); // AJAX
	        */            
	        });
	    });
	}// end fnEmailCheck

	/* 휴대폰 번호 */
	function fnPhoneCheck(){
	    $('#phone').on('keyup blur', function(){
	        if(regPhone.test($(this).val()) == false ){
	            $('#phone_check_msg').text('휴대폰 번호를 정확히 입력 해주세요.')
	                             .removeClass('pass_msg')
	                             .addClass('error_msg');
	            phone_result = false;
	        }else{
	            $('#phone_check_msg').text('');
	            phone_result = true;
	        }
	    });

	}// end fnPhoneCheck

	/* 생년월일 */
	function fnbirth(){
	    let year = '';
	    year +=  '<option value="year">년도</option>';
	    for(let i=2007; i>=1907; i--){
	        year += '<option value="'+i+'">'+i+'</option>';
	    }
	     $('#birthday').html(year);
	    
	    let month = '';
	    month +=  '<option value="month">월</option>';
	    for(let i=1; i<=12; i++){
	        month += '<option value="'+i+'">'+i+'</option>';
	    }
	     $('#month').html(month);
	     
	     let day ='';
	     day += '<option value="day">일</option>';
	     for(let i=1; i<=31; i++){
	         day += '<option value="'+i+'">'+i+'</option>';
	     }
	      $('#day').html(day);	 
	} // end

	/*
	    최종 서브밋 
	*/

	function fnAllCheck(){
	    $('#join_form').on('submit', function(event){
	       if( id_result == false){
	           event.preventDefault();
	           return false;
	       }else if( pw_result == false ){
	           event.preventDefault();
	           return false;
	       }else if( pw2_result == false ){
	           event.preventDefault();
	           return false;
	       }else if( name_result == false ){
	            event.preventDefault();
	            return false;
	        }else if( email_result == false ){
	            event.preventDefault();
	            return false;
	        }/*else if( authCodePass == false ){
	            event.preventDefault();
	            return false;
	        }*/else if( phone_result == false ){
	            event.preventDefault();
	            return false;
	        }else{
	            return true;
	        }
	    });
	}// end fnAllCheck

	function fnResetBtn(){
	    $('#reset_btn').click(function(){
	        $('#id_check_msg').text('');
	        $('#pw_check_msg').text('');
	        $('#pw2_check_msg').text('');
	        $('#name_check_msg').text('');
	        $('#authCode').text('');
	        $('#phone_check_msg').text('');
	        $('#email_check_msg').text('');
	        // $('#authCode_box').css('display', 'none');
	    });
	}

</script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/join.css">
</head>
<body>

    <div class="container">
    
        <div class="head">
            <h1 class="title"><a href="#">NearBy</a></h1>
        </div>
 
        <div class="join_form">
    
            <form action="/nearby/member/insertMember" method="post" id="join_form">
                <!-- 아이디 --> 
                <div class="input_box">
                    <label for="id">아이디</label>
                    <span class="space">
                        <input type="text" id="id" name="id">
                    </span>
                    <span id="id_check_msg"></span>
                </div>

                <!-- 비밀번호 -->
                <div class="input_box">
                    <label for="pw">비밀번호</label>
                    <span class="space">
                        <input type="text" id="pw" name="pw">
                    </span>
                    <span id="pw_check_msg"></span>
                </div>

                <!-- 비밀번호 확인 -->
                <div class="input_box">
                    <label for="pw2">비밀번호 재확인44</label>
                    <span class="space">
                        <input type="text" id="pw2" >
                    </span>
                    <span id="pw2_check_msg"></span>
                </div>
                
                <!-- 이름 -->
                <div class="input_box">
                    <label for="name">이름</label>
                    <span class="space">
                        <input type="text" id="name" name="name">
                    </span>
                    <span id="name_check_msg"></span>
                </div>

                <!-- 이메일 -->
                <div class="email_box">

                    <!-- 이메일 -->
                    <label for="email">이메일</label>
                    <span class="space">
                        <input type="text" id="email" name="email">
                    </span>
                    
                    <!-- 인증코드 발송 -->
                    <input type="button" value="인증번호받기" id="authCode_btn">
                    <span id="email_check_msg"></span>
                    
                    <!-- 인증코드 입력 칸 -->
                    <div id="authCode_box">
                        <span class="space">
                            <input type="text" name="authCode" id="authCode">
                        </span>
                        <input type="button" value="인증하기" id="verify_btn">
                    </div>
                </div>

                <!-- 번호 -->
                <div class="tel_box">
                    <label for="phone">번호</label>
                    <span class="space">
                        <input type="text" id="phone" name="phone" placeholder="- 표시 없이 입력해주세요">
                    </span>
                    <span id="phone_check_msg"></span>
                </div>

                <!-- 생년월일 -->
                <div class="birth_box">
                    
                    <!-- 년도 -->
                    <label for="birthday">생년월일</label>
                    <select id="birthday" name="year"></select>

                    <!-- 월 -->
                    <select id="month" name="month"></select>

                    <!-- 일 -->
                    <select id="day" name="day"></select>
                </div>

                <!-- 성별 -->
                <div class="gender_box">
                    <p id="gender_box">성별</p>
                    <!-- 선택 안 함 -->
                    <input type="radio" name="gender" value="n" id="n" checked>
                    <label id="n"  for="n">선택안함</label>
                    
                    <!-- 남성 -->
                    <input type="radio" name="gender" value="m" id="male">
                    <label id="m"  for="male">남성</label>

                    <!-- 여성 -->
                    <input type="radio" name="gender" value="f" id="female">
                    <label id="f" for="female">여성</label>

                </div>

                <div class="join_btn_wrap" id="join_btn_wrap">
                    <button class="btn btn-primary">회원가입</button>                 
                    <input type="reset" value="다시작성" id="reset" class="reset">                
                </div>                
            </form>
        </div>

        <div style="text-align: center;">
        	<span>NearBy <a href="/nearby/member/joinAgreePage">이용약관</a>어쩌구 저쩌구</span>
        </div>

   
    </div>
</body>
</html>