/**
 * 
 */
 
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
				$('#id_check_msg').text('필수 정보 입니다.').removeClass('pass_msg').addClass('error_msg');
				id_result = false;
				return;
			}else if(regId.test($(this).val()) == false ){
	            $('#id_check_msg').text('아이디는 4~ 32자의 영문 대소문자/숫자 사용 가능합니다.').addClass('error_msg').removeClass('pass_msg');
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
				return;
	        }else if(regPw.test($(this).val()) == false){
	            $('#pw_check_msg').text('비밀번호는 8~20자의 영문 대/소문자, 숫자, 특수문자 등 3종류 이상으로 조합해주세요')
	                              .removeClass('pass_msg')                  
	                              .addClass('error_msg');
	            pw_result = false;
				return;
	        }else{
	            $('#pw_check_msg').text('사용 가능한 비밀번호 입니다.')
	                              .removeClass('error_msg')
	                              .addClass('pass_msg');
	            pw_result = true;
	        }
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
	        }else if($('#pw2').val() == ''){
	            $('#pw2_check_msg').text('필수 정보 입니다.')
	                               .removeClass('pass_msg')
	                               .addClass('error_msg');
	        }else{
	            $('#pw2_check_msg').text('일치 합니다.')
	                               .removeClass('error_msg')
	                               .addClass('pass_msg');
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
				$('#email').css('width', '337.5px');
				$('#authCode').css('width', '337.5px');
	            $('#authCode_btn').css('display', 'inline-block');
	            $('#email_check_msg').text('')
	            email_result = true;
	        }
	    });	        
	        // 인증코드 전송 버튼
	        $('#authCode_btn').click(function(){
			 	$('#authCode_box').css('display', 'inline-block');
				$.ajax({
					url: '/nearby/member/sendAuthCode',
					type: 'post',
					data: 'email=' + $('#email').val(),
					dataType: 'json',
					success: function(map){
						$('#email_check_msg').text('인증코드가 발송 되었습니다.')
											 .addClass('pass_msg');
						fnVerifyAuthCode(map.authCode);
					},
					error: function(){
						alert('인증코드 전송 실패');
					}
				}); // AJAX          
			});
	}// end fnEmailCheck

	/* 인증코드 검증 */
	function fnVerifyAuthCode(authCode){
		$('#verify_btn').click(function(){
			if($('#authCode').val() == authCode){
				alert('인증 완료');
				$('#verify_msg').text('인증 완료')
								.addClass('pass_msg');
				authCodePass = true;
			}else{
				alert('인증 실패');
				authCodePass = false;
			}
		});
	}// fnVerifyAuthCode
	


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
		 /*
		  if(){
			  alert('생년월일을 입력 해주세요');
			  birthday_result = false;
			  return;
		  }else{
			  alert($('#year').val() + $('#month').val() + $('#day').val() );
			  birthday_result = true;
		  }
		  */
	} // end fnPhoneCheck

	/*
	    최종 서브밋 
	*/

	function fnAllCheck(){
	    $('#join_form').on('submit', function(event){
	       if( id_result == false){
	           event.preventDefault();
			   alert('아이디를 입력 해주세요.');
	           return false;
	       }else if( pw_result == false ){
	           event.preventDefault();
			   alert('비밀번호를 입력 해주세요.');
	           return false;
	       }else if( pw2_result == false ){
	           event.preventDefault();
			   alert('비밀번호를 다시 확인 해주세요.');
	           return false;
	       }else if( name_result == false ){
	            event.preventDefault();
			   alert('이름을 입력 해주세요.');
	            return false;
	        }else if( email_result == false ){
	            event.preventDefault();
			   alert('이메일 입력 해주세요.');
	            return false;
	        }else if( authCodePass == false ){
	            event.preventDefault();
				alert('이메일 인증이 필요 합니다.');
	            return false;
	        }else if( $('#year').val() == '' && $('#month').val() == '' && $('#day').val() == '' ){
				alert('생년월일을 입력 해주세요.');
				event.preventDefault();
				return false;
			}else if( phone_result == false ){
	            event.preventDefault();
			   alert('휴대폰 번호를 입력 해주세요.');
	            return false;
	        }else{
	            return true;
	        }
	    });
	}// end fnAllCheck

	// 초기화 버튼
	function fnResetBtn(){
	    $('#reset_btn').click(function(){
	        $('#id_check_msg').text('');
	        $('#pw_check_msg').text('');
	        $('#pw2_check_msg').text('');
	        $('#name_check_msg').text('');
	        $('#authCode').text('');
	        $('#phone_check_msg').text('');
			$('#email').css('width', '450px');
	        $('#email_check_msg').text('');
	        $('#authCode_box').css('display', 'none');
			$('#verify_msg').text('');
	        $('#authCode_btn').css('display', 'none');
	    });
	}