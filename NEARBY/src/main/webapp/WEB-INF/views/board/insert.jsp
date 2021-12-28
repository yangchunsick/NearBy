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
		$("#file").click(function(){
			$("#map").css('display', 'none');
		})
		
	});
	
	function fnFileCheck(){
		
		$("#file").on('change',function(){
			let origin = $(this).val();      // 첨부된 파일명
			let extName = origin.substring(origin.lastIndexOf(".")+1 ).toUpperCase();     // 확장자 대문자로 저장 
			
			// 확장자 정보
			if( $.inArray(extName, ["JPG", "PNG", "JPEG", "GIF","MP4", "MPEG", "AVI", 'MOV'])  == -1 )  {  // 첨부된 파일이 ["JPG", "PNG", "JPEC", "GIF"] 중 하나가 아니면
			 	alert('확장자가 jpg, png, jpeG, gif인 파일만 업로드가 가능합니다.');
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
	
	
	function map() {
		$("#map").css('display', 'block');
		
		var map = new naver.maps.Map("map", {
			  center: new naver.maps.LatLng(37.55415109162072, 126.93582461156707),
			  zoom: 15,
			  mapTypeControl: true
			});

			var infoWindow = new naver.maps.InfoWindow({
			  anchorSkew: true
			});

			map.setCursor('pointer');


	 // 포인트같음
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
		        //alert('ReverseGeocode Error, Please check latlng');
		      }
		      if (latlng.toString) {
		        return  alert('다시 입력해주세요');
		        // alert('ReverseGeocode Error, latlng:' + latlng.toString());
		      }
		      if (latlng.x && latlng.y) {
		        return  alert('다시 입력해주세요'); 
		        // alert('ReverseGeocode Error, x:' + latlng.x + ', y:' + latlng.y);
		      }
		      return  alert('다시 입력해주세요'); 
		      // alert('ReverseGeocode Error, Please check latlng');
		    }

		    var address = response.v2.address,
		        htmlAddresses = [];
		    
			
		    document.insertBoard_Form.location.value = address.jibunAddress;
		    var sub = address.jibunAddress.split(' ');
		    var nearbyAddress = sub[0]+" "+sub[1]+" "+sub[2];
		    document.insertBoard_Form.location.value = nearbyAddress;
		    document.insertBoard_Form.addr_remove.value ='';

		    if (address.jibunAddress !== '') {
		//        htmlAddresses.push('[지번 주소] ' + address.jibunAddress);
		        htmlAddresses.push(address.jibunAddress);
		    }

// 		    if (address.roadAddress !== '') {
// 		        htmlAddresses.push('[도로명 주소] ' + address.roadAddress);
// 		    }

		    infoWindow.setContent([
		      '<div style="padding:10px;min-width:100px;line-height:100%;font-size:10px;">',
// 		      '<p style="margin-top:1px;">검색 좌표</p><br />',
		      htmlAddresses.join('<br />'),
		      '</div>'
		    ].join('\n'));

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
		        // alert('Geocode Error, Please check address');
		      }
		      return  alert('죄송합니다. 다시 입력해주세요');
		      //alert('Geocode Error, address:' + address);
		    }

		    if (response.v2.meta.totalCount === 0) {
		      return  alert('죄송합니다. 다시 입력해주세요');
		      // alert('No result.');
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
		    if (item.roadAddress) {
		//    htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
		//    htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
		
		    }

		    if (item.jibunAddress) {
//		      htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
	      htmlAddresses.push( item.jibunAddress);
		    }

// 		    if (item.englishAddress) {
// 		      htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
// 		    }


		    infoWindow.setContent([
		      '<div style="padding:10px;min-width:50px;line-height:100%;font-size:10px;">',
// 		      '<p style="margin-top:5px;">검색 주소 : '+ address +'</p><br />',
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
	*{
		padding: 0;
		margin: 0;
		box-sizing: border-box;	
		width: 100%;
	}
	a {
		text-decoration: none;
		color: black;
		font-weight: bold;
	}
    body{
  	    width:100%;
 	    margin: 0 auto;
  	 }
  	.insert_wrap {
        width:500px;
        margin: 0 auto;
     }
   #map { display:none; }
   .search { 
   		position:absolute;
   		z-index:1000;
   		top:15px;
   		left:15px; 
   	}
   .search #address { 
   			width:280px;height:20px;line-height:20px;border:solid 1px #555;padding:5px;font-size:12px;box-sizing:content-box; }
   .search #submit { height:30px;line-height:30px;padding:0 10px;font-size:12px;border:solid 1px #555;border-radius:3px;cursor:pointer;box-sizing:content-box; }
   .location {   width:280px;height:20px;line-height:20px;border:none; padding:5px; padding-left:10px; font-size:10px;  }
   input::placeholder {  font-size: 6px;	}
   
   

   
   
   
   
</style>
</head>
<body>
	
	<jsp:include page="/WEB-INF/views/layout/layout.jsp" flush="true" />

 
	<h1>업로드 화면</h1>
	
	
	
	<div class="insert_wrap">
	<form id="insertBoard_Form" action="/nearby/board/insertBoard" method="post" enctype="multipart/form-data" name="insertBoard_Form">
		<b>작성자</b><br>
		${loginUser.id}<br><br>
		<input type="hidden" name="id" value="${loginUser.id}">
	
	     <b>내 위치 > <i class="fas fa-map-marker-alt" style="color:pink; font-size:15px;" onclick="map()"></i>
	     	<input type="text" name="location" class="location" value="" >
	     
	     </b><br>
	     <div id="map_wrap"></div>
	    
	<div id="map" style="width:500px; height:200px;">
        <div class="search" style="">
            <input id="address" type="text" name="addr_remove" placeholder="주소를 입력해주세요(ex. 서울특별시, 마포구, 노고산동)"  />
            <input id="submit" type="button" value="주소 검색" />
        </div>
        
    </div>
   
	    
	    <br><br>
		<b>사진 업로드</b><br>
		<div style="border:1px solid black; width:480px; height: 320px; padding:30px; font-size:30px;">
			  <label for="file"> <i class="fas fa-photo-video" id="upload" style="color:pink; font-size:40px;"></i>
			       사진 / 동영상을 올려주세요   </label>
		</div>
		<input type="file" name="file" id="file" style="display:none;" multiple>
		
				
		<b>내용</b><br>
		<input type="text" name="content"><br><br>
		
		<button>작성완료</button>
		<input type="button" value="목록" onclick="location.href='/nearby/board/boardList'">
	
	
	</form>
</div>
	
</body>
</html>