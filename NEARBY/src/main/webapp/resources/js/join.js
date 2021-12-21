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
    $('#id').on('keyup, blur', function(){
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
