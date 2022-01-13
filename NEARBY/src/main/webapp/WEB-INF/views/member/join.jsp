<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NearBy 회원가입 페이지</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/image/titleImg3.png">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/join.css">
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
});

	// 아이디 정규식
	let regId = /^[a-z0-9_-]{4,12}$/;
	// 비밀번호 정규식
	let regPw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,20}$/;
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
	let birthday_result = false;
	let phone_result = false;
    

	/* 아이디 */
	function fnIdCheck() {
	    // 1차 정규식 체크
	    $('#id').on('keyup blur', function(){
	    	if($('#id').val() == ''){
				$('.idCheckTrue').css('display', 'none');
				$('.idCheckFalse').css('display', 'block');
				$('#id_check_msg').text('필수 정보 입니다.')
								  .removeClass('pass_msg')
								  .addClass('error_msg');
				id_result = false;
				return;
			}else if(regId.test($(this).val()) == false ){
				$('.idCheckTrue').css('display', 'none');
				$('.idCheckFalse').css('display', 'block');
	            $('#id_check_msg').text('아이디는 4~ 12자의 영문 대소문자/숫자 사용 가능합니다.')
								  .addClass('error_msg')
								  .removeClass('pass_msg');
	            id_result = false;
	            return;
	        }
	        // 중복 체크
	        $.ajax({
	            url: '/member/idCheck',
	            type: 'post',
	            data: 'id=' + $(this).val(),
	            dataType: 'json',
	            success: function(map){
	                if(map.result == null ){
						$('.idCheckTrue').css('display', 'block');
						$('.idCheckFalse').css('display', 'none');
						$('#id_check_msg').text('');
	                    id_result = true;
	                }else {
						$('.idCheckTrue').css('display', 'none');
						$('.idCheckFalse').css('display', 'block');
	                    $('#id_check_msg').text('사용 중인 아이디 입니다.')
	                                      .removeClass('pass_msg')
	                                      .addClass('error_msg');
	                    id_result = false;
	                    return;
	                }
	            },
	            error: function(xhr){
	            	console.log(xhr.responseText);
					$('.idCheckTrue').css('display', 'none');
					$('.idCheckFalse').css('display', 'block');
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
				$('.pwCheckTrue').css('display', 'none');
				$('.pwCheckFalse').css('display', 'block');
	            $('#pw_check_msg').text('필수 정보 입니다.')
	                              .removeClass('pass_msg')
	                              .addClass('error_msg');
	            pw_result = false;
				return;
	        }else if(regPw.test($(this).val()) == false){
				$('.pwCheckTrue').css('display', 'none');
				$('.pwCheckFalse').css('display', 'block');
	            $('#pw_check_msg').text('비밀번호는 8~20자의 영문 대/소문자, 숫자, 특수문자 등 3종류 이상으로 조합해주세요')
	                              .removeClass('pass_msg')                  
	                              .addClass('error_msg');
	            pw_result = false;
				return;
	        }else{
				$('.pwCheckTrue').css('display', 'block');
				$('.pwCheckFalse').css('display', 'none');
	            $('#pw_check_msg').text('');
	            pw_result = true;
	        }
	    });
	}// end fnPwCheck

	/* 비밀번호 재확인 */
	function fnPw2Check(){
	    $('#pw2').on('keyup blur', function(){
	        if($('#pw').val() != $('#pw2').val() ){
				$('.pw2CheckTrue').css('display', 'none');
				$('.pw2CheckFalse').css('display', 'block');
	            $('#pw2_check_msg').text('비밀번호를 확인 해주세요.')
	                               .removeClass('pass_msg')
	                               .addClass('error_msg');
	            pw2_result = false;
	        }else if($('#pw2').val() == ''){
				$('.pw2CheckTrue').css('display', 'none');
				$('.pw2CheckFalse').css('display', 'block');
	            $('#pw2_check_msg').text('필수 정보 입니다.')
	                               .removeClass('pass_msg')
	                               .addClass('error_msg');
	        }else{
				$('.pw2CheckTrue').css('display', 'block');
				$('.pw2CheckFalse').css('display', 'none');
	            $('#pw2_check_msg').text('');
	            pw2_result = true;
	        }

	    })
	}// end fnPw2Check

	/* 이름 */
	function fnNameCheck(){
	    $('#name').on('keyup blur', function(){
	       if($('#name').val() == ''){
			   $('.nameCheckTrue').css('display', 'none');
			   $('.nameCheckFalse').css('display', 'block');
	           $('#name_check_msg').text('필수 정보 입니다.')
	                               .removeClass('pass_msg')
	                               .addClass('error_msg');
	            name_result = false;
	       }else if(regName.test($(this).val()) == false){
			   $('.nameCheckTrue').css('display', 'none');
			   $('.nameCheckFalse').css('display', 'block');
	           $('#name_check_msg').text('정말 당신의 이름이 맞습니까 ?')
	                               .removeClass('pass_msg')
	                               .addClass('error_msg');
	        	name_result = false;
	       }else{
				$('.nameCheckTrue').css('display', 'block');
				$('.nameCheckFalse').css('display', 'none');
	            $('#name_check_msg').text('');
	            name_result = true;
	       }
	    });
	}// end fnNameChekc

	/* 이메일 */
	function fnEmailCheck(){
	    $('#email').on('keyup blur', function(){
	        if(regEmail.test($(this).val()) == false){
				$('#email').css('width', '450px');
	            $('#authCode_btn').css('display', 'none');
	            $('#emailCheck_btn').css('display', 'none');
				$('.verifyCheckTrue').css('display', 'none');
				$('.emailCheckTrue').css('display', 'none');
				$('.emailCheckFalse').css('display', 'block');
	            $('#email_check_msg').text('이메일을 다시 확인 해주세요.')
	                                 .removeClass('pass_msg')
	                                 .addClass('error_msg');
	            email_result = false;
	        }else{
				$('.emailCheckFalse').css('display', 'none');
				$('#email').css('width', '337.5px');
				$('#authCode').css('width', '337.5px');
	            $('#emailCheck_btn').css('display', 'inline-block');
	            $('#email_check_msg').text('')
	            email_result = true;
	        }
	    });	
	    	// 이메일 중복 확인
	    	$('#emailCheck_btn').click(function(){
	    		$.ajax({
	    			url: '/member/selectByEmail',
	    			type: 'post',
	    			data: 'email=' + $('#email').val(),
	    			dataType: 'json',
	    			success: function(map){
						if(map.result == null){
							$('#email_check_msg').text('가입 가능한 이메일 입니다.')
												 .removeClass('error_msg')
												 .addClass('.pass_msg');
							$('#emailCheck_btn').css('display', 'none');
							$('#authCode_btn').css('display', 'inline-block');
							email_result = true;
						}else if(map.result.email == $('#email').val()){
							$('#email_check_msg').text('');
							Swal.fire({
								icon: 'error',
								title: '동일한 이메일이 존재 합니다.',
							});
							email_result = false;
						}
					},
					error : function(xhr){
						console.log(xhr.responseText);
					}
	    		});
	    	});
	    
	        // 인증코드 전송 버튼
	        $('#authCode_btn').click(function(){
	        	Swal.fire({
					icon: 'info',
					timer: 3000,
					title: '인증 코드 전송 중..',
  					button: false
				});
				$('#email').css('width', '450px');
				$('.emailCheckTrue').css('display', 'block');
				$('#authCode_btn').css('display', 'none');
			 	$('#authCode_box').css('display', 'inline-block');
				$.ajax({
					url: '/member/sendAuthCode',
					type: 'post',
					data: 'email=' + $('#email').val(),
					dataType: 'json',
					success: function(map){
						console.log(map.authCode);
						Swal.fire({
							icon: 'success',
							title: '인증코드 발송 되었습니다.',
							text: '해당 이메일로 인증코드가 발송 되었습니다.',
						});
						fnVerifyAuthCode(map.authCode);
					},
					error: function(xhr){
						console.log(xhr.responseText);
		            	console.log('서버오류');
						Swal.fire({
							icon: 'error',
							title: '인증코드 발송 실패.',
							text: '이메일을 다시 확인 해주세요.',
						});
					}
				}); // AJAX          
			});
	}// end fnEmailCheck

	/* 인증코드 검증 */
	function fnVerifyAuthCode(authCode){
		$('#verify_btn').click(function(){
			if($('#authCode').val() == authCode){
				$('.verifyCheckTrue').css('display', 'block');
				$('.verifyCheckFalse').css('display', 'none');
				Swal.fire({
					icon: 'success',
					title: '성공',
					text: '인증 완료 !',
				});
				authCodePass = true;
			}else{
				$('.verifyCheckTrue').css('display', 'none');
				Swal.fire({
					icon: 'error',
					title: '인증 실패.',
					text: '인증코드를 다시 확인해주세요.',
				});
				authCodePass = false;
			}
		});
	}// fnVerifyAuthCode
	

	/* 휴대폰 번호 */
	function fnPhoneCheck(){
	    $('#phone').on('keyup blur', function(){
	        if(regPhone.test($(this).val()) == false ){
				$('.telCheckTrue').css('display', 'none');
				$('.telCheckFalse').css('display', 'block');
	            $('#phone_check_msg').text('휴대폰 번호를 정확히 입력 해주세요.')
	                             	 .removeClass('pass_msg')
	                                 .addClass('error_msg');
	            phone_result = false;
	        }else{
				$('.telCheckTrue').css('display', 'block');
				$('.telCheckFalse').css('display', 'none');
	            $('#phone_check_msg').text('');
	            phone_result = true;
	        }
	    });

	}// end fnPhoneCheck

	/* 생년월일 */
	function fnbirth(){
	    let year = '';
	    year +=  '<option value="">년</option>';
	    for(let i=2007; i>=1907; i--){
	        year += '<option value="'+i+'">'+i+'</option>';
	    }
	     $('#year').html(year);
	    
	    let month = '';
	    month +=  '<option value="">월</option>';
	    for(let i=1; i<=9; i++){
		    month += '<option value="'+'0'+i+'">'+'0'+i+'</option>';
		}
		for(let i=10; i<=12; i++){
		    month += '<option value="'+i+'">'+i+'</option>';
		}
	     $('#month').html(month);
	     
	     let day ='';
	     day += '<option value="">일</option>';
	      for(let i=1; i<=9; i++){
		     day += '<option value="'+'0'+i+'">'+'0'+i+'</option>';
		 }
		 for(let i=10; i<=31; i++){
		     day += '<option value="'+i+'">'+i+'</option>';
		 }
	      $('#day').html(day);
	} // end fnPhoneCheck

	/*
	    최종 서브밋 
	*/

	function fnAllCheck(){
	    $('#join_form').on('submit', function(event){
	       if( id_result == false){
	           event.preventDefault();
				Swal.fire({
					icon: 'error',
					title: '필수 입력입니다.',
					text: '아이디를 입력 해주세요.',
				});
	           return false;
	       }else if( pw_result == false ){
	           event.preventDefault();
				Swal.fire({
					icon: 'error',
					title: '필수 입력입니다.',
					text: '비밀번호를 입력 해주세요.',
				});
	           return false;
	       }else if( pw2_result == false ){
	           event.preventDefault();
				Swal.fire({
					icon: 'error',
					title: '필수 입력입니다.',
					text: '비밀번호를 다시 확인 해주세요.',
				});
	           return false;
	       }else if( name_result == false ){
	            event.preventDefault();
				Swal.fire({
					icon: 'error',
					title: '필수 입력입니다.',
					text: '이름을 입력 해주세요.',
				});
	            return false;
	        }else if( email_result == false ){
	            event.preventDefault();
				Swal.fire({
					icon: 'error',
					title: '필수 입력입니다.',
					text: '이메일 입력 해주세요.',
				});
	            return false;
	        }else if( authCodePass == false ){
	            event.preventDefault();
				Swal.fire({
					icon: 'error',
					title: '이메일 인증을 받아야 합니다.',
					text: '이메일 인증이 필요 합니다.',
				});
	            return false;
	        }else if( $('#year').val() == ''){
				Swal.fire({
					icon: 'error',
					title: '필수 정보 입니다.',
					text: '생년월일을 입력 해주세요.',
				});
				event.preventDefault();
				return false;
			}else if($('#month').val() == ''){
				Swal.fire({
					icon: 'error',
					title: '필수 정보 입니다.',
					text: '생년월일을 입력 해주세요.',
				});
				event.preventDefault();
				return false;
			}else if($('#day').val() == '' ){
				Swal.fire({
					icon: 'error',
					title: '필수 정보 입니다.',
					text: '생년월일을 입력 해주세요.',
				});
				event.preventDefault();
				return false;
			}else if( phone_result == false ){
	            event.preventDefault();
				Swal.fire({
					icon: 'error',
					title: '필수 정보 입니다.',
					text: '휴대폰 번호를 입력 해주세요.',
				});
	            return false;
	        }else{
				Swal.fire({
					icon: 'success',
					title: '필수 정보 입니다.',
					text: '생년월일을 입력 해주세요.',
				});
	            return true;
	        }
	    });
	}// end fnAllCheck



</script>
</head>
<body>



    <div class="container">
    
        <div class="head">
            <h1 class="title"><a href="<%=request.getContextPath()%>/">NearBy</a></h1>
        </div>
 
        <div class="join_form">
    
            <form action="/member/insertMember" method="post" id="join_form">
                
                <!-- 아이디 --> 
                <div class="input_box">
                    <label for="id">아이디</label>
                        <input type="text" id="id" name="id">
                        <span class="icon"><i class="fas fa-check idCheckTrue"></i><i class="fas fa-times idCheckFalse"></i></span>
                    <span id="id_check_msg"></span>
                </div>

                <!-- 비밀번호 -->
                <div class="input_box">
                    <label for="pw">비밀번호</label>
                        <input type="password" id="pw" name="pw">
                    	<span class="icon"><i class="fas fa-check pwCheckTrue"></i><i class="fas fa-times pwCheckFalse"></i></span>
                    <span id="pw_check_msg"></span>
                </div>

                <!-- 비밀번호 확인 -->
                <div class="input_box">
                    <label for="pw2">비밀번호 재확인</label>
                        <input type="password" id="pw2" >
                    	<span class="icon"><i class="fas fa-check pw2CheckTrue"></i><i class="fas fa-times pw2CheckFalse"></i></span>
                    <span id="pw2_check_msg"></span>
                </div>
                
                <!-- 이름 -->
                <div class="input_box">
                    <label for="name">이름</label>
                        <input type="text" id="name" name="name">
                    	<span class="icon"><i class="fas fa-check nameCheckTrue"></i><i class="fas fa-times nameCheckFalse"></i></span>
                    <span id="name_check_msg"></span>
                </div>

                <!-- 이메일 -->
                <div class="email_box">

                    <!-- 이메일 -->
                    <label for="email">이메일</label>
                        <input type="text" id="email" name="email">
                        <input type="button" value="이메일 확인" id="emailCheck_btn">
                    	<span class="icon"><i class="fas fa-check emailCheckTrue"></i><i class="fas fa-times emailCheckFalse"></i></span>
                    
                    <!-- 인증코드 발송 버튼-->
                    <input type="button" value="인증번호받기" id="authCode_btn">
                    <span id="email_check_msg"></span>
                    
                    <!-- 인증코드 입력 칸 -->
                    <div id="authCode_box">
                        <input type="text" name="authCode" id="authCode">
                        <input type="button" value="인증하기" id="verify_btn">
                    	<span class="icon"><i class="fas fa-check verifyCheckTrue"></i><i class="fas fa-times verifyCheckFalse"></i></span>
                  <span id="verify_msg"></span>
                    </div>
                </div>

                <!-- 번호 -->
                <div class="tel_box">
                    <label for="phone">번호</label>
                        <input type="text" id="phone" name="phone" placeholder="- 표시 없이 입력해주세요">
                    	<span class="icon"><i class="fas fa-check telCheckTrue"></i><i class="fas fa-times telCheckFalse"></i></span>
                    <span id="phone_check_msg"></span>
                </div>

                <!-- 생년월일 -->
                <div class="birth_box">
                    
                    <!-- 년도 -->
                    <label for="birthday">생년월일</label>
                  <select id="year" name="year"></select>

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
                </div>                
            </form>
        </div>

        <div style="text-align: center;">
           <a href="<%=request.getContextPath()%>/member/serviceTerms" id="pol">NearBy 서비스 이용 약관</a>
        </div>
    </div>
</body>
</html>