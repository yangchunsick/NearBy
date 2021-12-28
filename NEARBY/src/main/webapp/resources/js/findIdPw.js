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
             $('#authCode_box').css('display', 'inline-block');
            $.ajax({
                url: '/nearby/member/snedAuthCode',
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