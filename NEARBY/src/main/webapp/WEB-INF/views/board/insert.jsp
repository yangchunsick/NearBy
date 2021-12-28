<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=4lnq99nnpg&submodules=geocoder"></script>
<script>
  $(document).ready(function(){
		fnFileCheck();
		fnSubmitCheck();
		// file 클릭시 map 안보이게 처리
		$("#file").click(function(){
			$("#map").css('display', 'none');
		})
		
		
		// textarea 크기 보이게 함 
		var txtArea = $(".content_height");
	    if (txtArea) {
	        txtArea.each(function(){
	            $(this).height(this.scrollHeight);
	        });
	    }
	    
	   
	});
  
  
  // submit 막기
  function fnSubmitCheck(){
      $('#insertBtn').click(function(event){
    	  
    	  // 위치 파일 내용 빈값일때
    	  if( $('.location').val() == ''  && $('#content').val() == '' && $('#modify_file').val() == '' )  {
    		  alert("당신의 일상을 입력해주세요.");
    	  	  event.preventDefault();
    	  
    	  // 위치는 빈값 이고 내용이나 파일은 있을 때
    	  } else if (  $('.location').val() == ''  &&  ( $('#content').val() != '' || $('#modify_file').val() != '' ) )  {
    		  if ( confirm ("주변 사람들에게 일상을 공유하고 싶으시다면 위치를 입력해주세요") ) {
    			  map();
	    		  $("#map").css('display', 'block');
	    		  event.preventDefault();
    		  } else {}
    	// 위치는 빈값이 아니나 파일이랑 내용이 빈값일 때 
    	  } else if ( $('.location').val() != ''  &&   $('#content').val() == '' && $('#modify_file').val() == '' )  {
    		  alert("사진이나 일상을 입력해주세요.");
    		  event.preventDefault();
          }  
  	  })
    
}
  
	// 이미지 및 비디오 확장자 및 크기  체크
	function fnFileCheck(){
		
		$("#modify_file").on('change',function(){
			let origin = $(this).val();      // 첨부된 파일명
			let extName = origin.substring(origin.lastIndexOf(".")+1 ).toUpperCase();     // 확장자 대문자로 저장 
			
			// 확장자 정보
			if( $.inArray(extName, ["JPG", "PNG", "JPEG", "GIF","MP4", "MPEG", "AVI", "MOV", "M4V"])  == -1 )  {  // 첨부된 파일이 ["JPG", "PNG", "JPEC", "GIF"] 중 하나가 아니면
			 	alert('업로드 할 수 없는 확장자입니다.');
				$(this).val('');
				return;
		   }
			
			// 파일크기점검
			let maxSize = 1024 * 1024 * 1000;   		   // 최대크기 10MB
			let fileSize = $(this)[0].files[0].size;       // 첨부된 파일 크기
			if ( fileSize > maxSize ){
				alert('1GB 이하의 파일만 업로드가 가능합니다.');
				$(this).val('');
				return;
			}
		});
	}
	
	// file 클릭하고 변경시 이미지 및 비디오 변경가능하게 하는 함수
	function readURL(input) {
		if (input.files && input.files[0]) {
			let image = ["JPG", "PNG", "JPEG", "GIF",];
			let video = ["MP4", "MPEG", "AVI", "MOV", "M4V"];
			var reader = new FileReader();
			reader.onload = function(e) {
				if(  image.includes(input.files[0].name.split('.').pop().toUpperCase() )){
				document.getElementById('previewImg').src = e.target.result;
				$("#previewImg").css('display', 'block');
				$("#previewVideo").css('display', 'none');
				}
				 else if (    video.includes(input.files[0].name.split('.').pop().toUpperCase() )        )  {
					 document.getElementById('previewVideo').src = e.target.result;
						$("#previewVideo").css('display', 'block');
						$("#previewImg").css('display', 'none');
				 }
			};
				reader.readAsDataURL(input.files[0]);
			// console.log(input.files[0].name.split('.').pop().toLowerCase());
			$('#modify_file').css('display', 'block');
			$("#previewImg").css('display', 'block');
			$('#img_wrap').css('padding', '0');
			$('#file_label').css('display', 'none');
			$('#upload').css('display', 'none');
		} else {
			document.getElementById('preview').src = "";
		}
	}
	
	

	function map() {
		$("#map").css('display', 'block');
		
		var map = new naver.maps.Map("map", {
			  center: new naver.maps.LatLng(37.55415109162072, 126.93582461156707),
			  zoom: 15,
			  mapTypeControl: true
			});

		 map.setOptions({ //모든 지도 컨트롤 숨기기
	            scaleControl: false,
	            logoControl: false,
	            mapDataControl: false,
	            zoomControl: false,
	            mapTypeControl: false
	        });
		
		
			var infoWindow = new naver.maps.InfoWindow({
			    anchorSkew: true,
			    backgroundColor: "none",
			    Color: "pink",
			    borderColor: "none",
			    borderWidth: "none",
			    anchorSize: new naver.maps.Size(0, 0),
			    display:  "none"
			});

			
			var marker = new naver.maps.Marker({
			    position: new naver.maps.LatLng(37.55415109162072, 126.93582461156707),
			    map: map
			});

			naver.maps.Event.addListener(map, 'click', function(e) {
			    marker.setPosition(e.coord);
			});
			
			map.setCursor('marker');

			

	 // 포인트(클릭)
	function searchCoordinateToAddress(latlng) {

		  infoWindow.close();

		  naver.maps.Service.reverseGeocode({
		    coords: latlng,
		    orders: [
		      naver.maps.Service.OrderType.ADDR,
		      naver.maps.Service.OrderType.ROAD_ADDR
		    ].join(',')
		  }, function(status, response) {
		    if (status === naver.maps.Service.Status.ERROR) {
		      if (!latlng) {
		        return alert('다시 입력해주세요');
		      }
		      if (latlng.toString) {
		        return  alert('다시 입력해주세요');
		      }
		      if (latlng.x && latlng.y) {
		        return  alert('다시 입력해주세요'); 
		      }
		      return  alert('다시 입력해주세요'); 
		    }

		    var address = response.v2.address,
		        htmlAddresses = [];
		    
			
		    document.insertBoard_Form.location.value = address.jibunAddress;
		    var sub = address.jibunAddress.split(' ');
		    var nearbyAddress = sub[0]+" "+sub[1]+" "+sub[2];
		    document.insertBoard_Form.location.value = nearbyAddress;
		    document.insertBoard_Form.addr_remove.value ='';

		    if (address.jibunAddress !== '') {
		        htmlAddresses.push(address.jibunAddress);
		    }

		    infoWindow.setContent([
		      '<div style="padding:10px;min-width:100px;line-height:100%;font-size:10px; display:none">',
		      htmlAddresses.join('<br />'),
		      '</div>'
		    ].join('\n'));
		    
		    $('#address').val(htmlAddresses);
		    

		    infoWindow.open(map, latlng);
		  });
		}
	 
	 //검색했을 때
	function searchAddressToCoordinate(address) {
		  naver.maps.Service.geocode({
		    query: address
		  }, function(status, response) {
		    if (status === naver.maps.Service.Status.ERROR) {
		      if (!address) {
		        return alert('죄송합니다. 다시 입력해주세요');
		      }
		      return  alert('죄송합니다. 다시 입력해주세요');
		    }

		    if (response.v2.meta.totalCount === 0) {
		      return  alert('죄송합니다. 다시 입력해주세요');
		    }
		    

		    var htmlAddresses = [],
		      item = response.v2.addresses[0],
		      point = new naver.maps.Point(item.x, item.y);
		    console.log(item);	  // item 객체에 지번, 도로명, 위도, 경도 필드존재함
		    document.insertBoard_Form.location.value = item.jibunAddress;
		    console.log(item.jibunAddress);
		    var sub = item.jibunAddress.split(' ');
		   
		    var nearbyAddress = sub[0]+" "+sub[1]+" "+sub[2];
		    document.insertBoard_Form.location.value = nearbyAddress;
		    console.log(nearbyAddress )
		    
		    
         // 주소 검색 할 때 item.x   item.y
		    if (item.jibunAddress) {
	      		htmlAddresses.push( item.jibunAddress);
		    }

		    infoWindow.setContent([
		      '<div style="padding:10px;min-width:50px;line-height:100%;font-size:10px;  display:none;">',
		      htmlAddresses.join('<br />'),
		      '</div>'
		    ].join('\n'));
			
		    map.setCenter(point);
		    infoWindow.open(map, point);
		    
		  });
		}
	
	function initGeocoder() {
		  if (!map.isStyleMapReady) {
		    return;
		  }

		  map.addListener('click', function(e) {
		    searchCoordinateToAddress(e.coord);
		   // alert(e.coord.lat() + ', ' + e.coord.lng());  // 클릭하면 위도경도
	
		  });

		  $('#address').on('keydown', function(e) {
		    var keyCode = e.which;

		    if (keyCode === 13) { // Enter Key
		      searchAddressToCoordinate($('#address').val());
		    }
		  });

		  $('#submit').on('click', function(e) {
		    e.preventDefault();

		    searchAddressToCoordinate($('#address').val());
		  
		  });

		  searchAddressToCoordinate('노고산동 106-1');
		}

		naver.maps.onJSContentLoaded = initGeocoder;
		naver.maps.Event.once(map, 'init_stylemap', initGeocoder);
	}
</script>
<style>
   /* ----------------  초기화 ----------------  */
	*{
		padding: 0;
		margin: 0;
		box-sizing: border-box;	
		width: 100%;
	}
	.insert_wrap a {
		text-decoration: none;
		color: black;
		font-weight: bold;
	}
    body{
  	    width:100%;
 	    margin: 0 auto;
  	 }
  	 
  	 /* header css */
	.header {
		width: 100%;
		height: 106px;
		background-color: white;
	}
	 #insert_btn {    border-bottom: 8px solid  #fe4662;   }
     #insert_icon {  color:  #fe4662;  }
	/* End header Css */	
  	 
  	 
  	 /* ----------------  insert box ----------------  */
  	.insert_wrap {
  	    position: relative;
        width:600px;
        height : 900px;
        margin: 30px auto 10px;
        padding: 30px 30px;
        background-color: rgba(255, 250, 250, 0.8);
        border : 1px solid #fe4662; 
        border-radius: 8px;
     }
     
    /* ----------------  기본 정보 ----------------  */
   .id_wrap{  height: 50px;  }
    #board_writer {
   	   font-weight: bold;
   	   font-size: 18px;
	   display: inline-block;
	   margin-left: 10px;
	   width: 100px;
   }
    .setting { 
  	    position:absolute;
 		color: #fe4662; 
 		font-size:20px;
 		width:30px;
 		right: 40px;
    }
    .fas { cursor: pointer; }
   input::placeholder {  font-size: 6px;	}
   
  /* ----------------  MAP ----------------  */
   #map { 
   	 display:none;
   	 margin: 0 auto;
   	 }
   .search { 
   		position:absolute;
   		z-index:1000;
   		top:15px;
   		left:15px; 
   	}
   .search #address { 
 		width:280px;
 		height:20px;
 		line-height:20px;
 		border:solid 1px #555;
 		padding:5px;
 		font-size:12px;
 		box-sizing:content-box;
   		 }
   .search #submit { 
   		height:30px;
   		width: 55px;
   		line-height:30px;
   		padding:0 10px;
   		font-size:12px;
   		border:solid 1px #555;
   		border-radius:3px;
   		cursor:pointer;
   		box-sizing:content-box; 
   	}
   .location {   
   		width:280px;
   		height:20px;
   		line-height:20px;
   		border:none; 
   		padding:5px; 
   		padding-left:10px; 
   		font-size:10px;  
   		border: none;
   		font-size: 15px;
   		outline: none;
   		background-color: rgba(255, 250, 250, 0.8);
   	}
   .myMap{
   		margin: 20px 0;
   		width:400px;
   }
   .myMap i {  	width: 20px;  }
   #map {  	margin-bottom: 20px;  }
   #map ul li {
   	display: none;
   	border: none;
   }
   #map ul { 	display: none;  }
   
   
 /* ----------  IMAGE ----------  */
   #img_wrap{
  		 border:1px solid black;
  		 width:480px; 
  		 height: 320px;
  	 	 padding:30px; 
  	 	 margin:0 auto;
  		 font-size:30px;
  		 background-color: #f0f2f5;
  		 border: none;
  		 border-radius: 5px;
  		   overflow: hidden;
   }
   .preview{
      width:480px; 
      height: 320px;
      overflow: hidden;
   }
   #modify_file {
   		display: inline-block;
   		margin: 10px 0;
   		font-size: 13px;
   }
   #file_label, #upload {
   		display: inline-block;
   		margin: 30px auto;
   		text-align: center;
   		color: gray;	
   }
   /* ----------  프로필이미지 ----------  */
   .profileImg{
	   	width : 90px;
		height : 80px;
		border : 1px solid silver;
	    display: inline-block;
	    border-radius: 100%;
		margin-right: 10px;
   }
   #previewImg {  
	  width:100%;
      overflow: hidden;
	  display:none;
	  z-index: 100;
   }
   
   /* ----------  사진 및 비디오 미리보기 -> script에서 처리함 ----------  */
   #previewVideo {
	   	width:480px;
	   	height: 320px;
	   	display:none;
	   	border: none;
	   	z-index: 100;
   }
   /* ----------  내용 ----------  */
   .content_wrap {	 
    	margin: 30px auto 15px;	  }
   .content_wrap #content {
   		height: 40px;
   		padding-left: 10px;
   		background-color:#f0f2f5;
   		border: none;
  		border-radius: 5px;
  		outline: none;
   }
  
  /* ----------  '게시' 버튼  ----------  */
   #insertBtn { 
   		width: 100%;
   		height: 30px;
   		margin-top: 5px; 
   		color: white;
   		background-color:  #fe4662; 
   		border: none;
   		border-radius: 5px;
   		outline: none;
   		cursor: pointer;
    }
    /* ---------- 아래 공간 확보 위한 푸터처리 ----------  */
	#footer_wrap {  height: 80px; }
   
</style>
</head>
<body>
	
	<header class="header">
		<jsp:include page="/WEB-INF/views/layout/header.jsp" flush="true" />
	</header>
	
	<div class="insert_wrap">
	<form id="insertBoard_Form" action="/nearby/board/insertBoard" method="post" enctype="multipart/form-data" name="insertBoard_Form">
		<div class="profileImg">(프로필)</div>
		<span class="id_wrap">
		    	   <a href="/nearby/board/selectBoard" id="board_writer">${loginUser.id}</a>
		    	   	<input type="hidden" name="id" class="id" value="${loginUser.id}" >
		 </span>
		<i class="fas fa-cog setting"></i>
			
	
	    <div class="myMap">
	     <span>내 위치 > <i class="fas fa-map-marker-alt" style="color:pink; font-size:15px;" onclick="map()"></i>
	     	<input type="text" name="location" class="location" value=""  readonly="readonly"  >
	     </span>
	     </div>
	     
	     <div id="map_wrap"></div>
	    
	<div id="map" style="width:500px; height:200px;">
        <div class="search" style="">
            <input id="address" type="text" name="addr_remove" placeholder="주소를 입력해주세요(ex. 서울특별시, 마포구, 노고산동)" />
            <input id="submit" type="button" value="주소 검색" />
        </div>
    </div>  
	    
	    <input type="file" name="file" id="modify_file" style="display:none;" onchange="readURL(this);">
		<div id="img_wrap" >
			  <label for="modify_file" id="file_label" class="file_label"> 
			  <i class="fas fa-photo-video" id="upload" style="color:pink; font-size:70px;"></i>
			       사진 / 동영상을 올려주세요   </label>
			      <div class="preview">
			           <img id="previewImg" />
 				       <video id="previewVideo" controls></video>
 				   </div>
		</div>
		<div class="content_wrap">
			<textarea name="content" id="content" class="content_height"  placeholder="당신의 일상을 공유해주세요"></textarea>
		</div>
		<button id="insertBtn">게시</button>
	</form>
</div>
	
	<footer id="footer_wrap"></footer>
	
	

	
</body>
</html>