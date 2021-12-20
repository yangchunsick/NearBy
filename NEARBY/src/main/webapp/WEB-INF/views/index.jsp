<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<style>
   *{
      margin : 0;
      padding : 0;
   }

   .container {
      width: 100%;
      margin: 0 auto;
      text-align: center;   
   }
   
   .index_header {
   	width:100%;
      background-color: rgb( 30, 30, 30);
   }
    #login_form {
       position:absolute;
       top: 200px;
       left: 860px;
       border-radius: 30px;
       border : 1px solid rgba(50,50,50,0.3);
       margin: 0 auto;
       margin-top: 20px;
       padding: 10px;
       text-align: center;
       background-color: white;
   }
   .see {
      display: block;
      width: 500px;
      height: 600px;
   }
   .no {
      display: none;
   }
   .input_wrap{
      margin: 0 auto;
      
   }
   #login_submit {
      margin-top: 30px;
      width: 400px;
      height: 50px;
      border-radius: 5px;
      border: none;
      background-color: #fe585c;
      font-size: 22px;
      color: white;
      
   }
   #login_btn {
      margin-right: 100px;
       margin-top: 40px;
      margin-left: 1100px;
      display: block;
      width: 140px;
      height: 40px;
      border-radius: 30px;
      border: none;
      font-size: 20px;
      cursor:pointer;
      
   }
   .logo_wrap {
      margin-top: 20px;
      margin-left: 30px;
      display: flex;
   }
   .input_box {
      border-radius: 5px;
      margin: 5px auto;
      margin-bottom: 30px;
      border: none;
      width: 400px;
      height: 40px;
      line-height: 20px;
      background-color: #e8f0fe;
   }
   .input_box > input {
      border: none;
      outline: none;
      width: 340px;
      height: 30px;
      line-height: 30px;
      margin-top: 5px;
      background-color: #e8f0fe;
      
   }
   
   .input_wrap > p{
      text-align: left;
      margin-left : 54px;
      font-size: 18px;
   }
   #logo2 {
      width: 280px;
      margin-top :40px;
      margin-bottom: 20px;
   }
   .main {
      background-color: RGB(240,242,245);
      width: 100%;
      height: 3000px;
      background-image: url('resources/image/abc.png');
      background-repeat: no-repeat;
   }
   #move_area {
     margin-top : 10px;
   }
   .blur {
      
   }
   
</style>

<script type="text/javascript">
  $(document).ready(function(){
   fnLoginBtn();      // login 버튼 눌렀을 때 로그인 창 나타나기
   fnLogin();         // login 서브밋
  });
     
  
     // login 버튼 눌렀을 때 로그인 창 나타나기
    function fnLoginBtn() {
     $('#login_btn').click( function() {
        $('#login_form').addClass('see').removeClass('no');
   
      });
     

   }
   
    
    
     // login 서브밋
   function fnLogin() {
      $("#login_form").submit(function(event){
         let regId = /^[a-zA-Z0-9_-]{4,}$/;                  // ID 정규식
         let regPw = /^[a-zA-Z0-9!@$%^&*()]{8,20}$/;         // PW 정규식
         if ( regId.test($('#id').val()) == false || regPw.test($('#pw').val()) == false){
            alert('아이디와 비밀번호의 형식이 올바르지 않습니다.');
            event.preventDefault();
            return false;
         }
         return true;   
      });
   }
   
   
</script>


</head>
<body>
   <div class="container">
   
      <header class="index_header">
        <div class="logo_wrap"> 
           <div><img id="logo" src="resources/image/logo_white.png" width="200px"></div> 
           <div><input type="button" value="로그인" id="login_btn"></div>
        </div>
      </header>
      
      <main class="main" >
   
         <hr>
             <form id="login_form" method="post" class="no" action="/nearby/member/login">
               <div>
                  <img id="logo2" src="resources/image/logo_color.png" width="200px">
               </div>
               <div class="input_wrap">
                  <p>아이디</p>
                  <div class="input_box">
                     <input type="text" name="id" id="id">
                  </div>
               </div>   
               <div class="input_wrap">
                  <p>비밀번호<p>
                  <div class="input_box">
                     <input type="text" name="pw" id="pw">
                  </div>
                  
               </div>            
                  <button id="login_submit">로그인</button>
                         <div id="move_area">
        		 			 <a href="/nearby/board/boardList">Board로 가기</a>
        					 <a href="/nearby/member/joinAgreePage">회원가입하러가기</a>
        					 <!-- <a href="/nearby/member/memberJoin">회원가입하러가기</a> -->
        				</div>
             </form>   
            
   
        <br><br><br>
 
      
      <br><br><br>
      
      
      </main>
      
      
        <hr>
   
      <footer>
          안녕 나는 footer 
      </footer>
   </div>   
</body>
</html>