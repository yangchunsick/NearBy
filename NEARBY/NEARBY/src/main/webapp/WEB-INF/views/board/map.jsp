<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>간단한 지도 표시하기</title>
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
  <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=4lnq99nnpg&submodules=geocoder"></script>
<title>Insert title here</title>
<script type="text/javascript">
	$(document).ready(function(){

		var map = new naver.maps.Map("map", {
		  center: new naver.maps.LatLng(37.55415109162072, 126.93582461156707),
		  zoom: 30,
		  mapTypeControl: true
		});

		var infoWindow = new naver.maps.InfoWindow({
		  anchorSkew: true
		});

		map.setCursor('pointer');

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
			        return alert('ReverseGeocode Error, Please check latlng');
			      }
			      if (latlng.toString) {
			        return alert('ReverseGeocode Error, latlng:' + latlng.toString());
			      }
			      if (latlng.x && latlng.y) {
			        return alert('ReverseGeocode Error, x:' + latlng.x + ', y:' + latlng.y);
			      }
			      return alert('ReverseGeocode Error, Please check latlng');
			    }

			    var address = response.v2.address,
			        htmlAddresses = [];
			    
				
			    document.addr.answer.value = address.roadAddress;
			    var sub = address.roadAddress.split(' ');
			    var ss = sub[0]+" "+sub[1];
			    document.addr.aa.value = ss;
			    

			    if (address.jibunAddress !== '') {
			        htmlAddresses.push('[지번 주소] ' + address.jibunAddress);
			    }

			    if (address.roadAddress !== '') {
			        htmlAddresses.push('[도로명 주소] ' + address.roadAddress);
			    }

			    infoWindow.setContent([
			      '<div style="padding:10px;min-width:200px;line-height:150%;">',
			      '<h5 style="margin-top:5px;">검색 좌표</h5><br />',
			      htmlAddresses.join('<br />'),
			      '</div>'
			    ].join('\n'));

			    infoWindow.open(map, latlng);
			  });
		}

		function searchAddressToCoordinate(address) {
			 naver.maps.Service.geocode({
				    query: address
				  }, function(status, response) {
				    if (status === naver.maps.Service.Status.ERROR) {
				      if (!address) {
				        return alert('Geocode Error, Please check address');
				      }
				      return alert('Geocode Error, address:' + address);
				    }

				    if (response.v2.meta.totalCount === 0) {
				      return alert('No result.');
				    }

				    var htmlAddresses = [],
				      item = response.v2.addresses[0],
				      point = new naver.maps.Point(item.x, item.y);

				    if (item.roadAddress) {
				      htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
				    }

				    if (item.jibunAddress) {
				      htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
				    }

				    if (item.englishAddress) {
				      htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
				    }

				    infoWindow.setContent([
				      '<div style="padding:10px;min-width:100px;line-height:150%;">',
				      '<h5 style="margin-top:5px;">검색 주소 : '+ address +'</h5><br />',
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
				    alert(e.coord.lat() + ', ' + e.coord.lng());
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

		
	})


</script>


</head>
<body>
<div id="map" style="width:100px;height:100px;"></div>

<script>

//지도를 삽입할 HTML 요소 또는 HTML 요소의 id를 지정합니다.
var mapDiv = document.getElementById('map'); // 'map'으로 선언해도 동일

//옵션 없이 지도 객체를 생성하면 서울 시청을 중심으로 하는 16 레벨의 지도가 생성됩니다.
var map = new naver.maps.Map(mapDiv);

</script>
</body>
</html>