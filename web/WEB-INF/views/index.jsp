<%--
  Created by IntelliJ IDEA.
  User: PRO
  Date: 2021-04-30
  Time: 오전 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<%-- 이거 라이브러리 두개 이상 추가하면 --%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=de357793020bb46467d448f396354148&libraries=services"></script>
<script type="text/javascript">
  /* 카카오 맵 초기 설정 */
  $(function(){
    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var options = { //지도를 생성할 때 필요한 기본 옵션
      center: new kakao.maps.LatLng(36.39195639201677, 127.40704329624886), //지도의 중심좌표.
      level: 10, //지도의 레벨(확대, 축소 정도)
      mapTypeId : kakao.maps.MapTypeId.ROADMAP
    };
    var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    var mapTypeControl = new kakao.maps.MapTypeControl();  // 지도 타입 변경 컨트롤을 생성한다
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);  // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
  });

  /* 유기견 센터 */
  function event01(){
    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var options = { //지도를 생성할 때 필요한 기본 옵션
      center: new kakao.maps.LatLng(36.39195639201677, 127.40704329624886), //지도의 중심좌표.
      level: 10, //지도의 레벨(확대, 축소 정도)
      mapTypeId : kakao.maps.MapTypeId.ROADMAP
    };

    var geocoder       = new kakao.maps.services.Geocoder(); // 주소-좌표 변환 객체를 생성합니다
    var map            = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    var mapTypeControl = new kakao.maps.MapTypeControl();                 // 지도 타입 변경 컨트롤을 생성한다
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);  // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다

    $.ajax({
      type: "get",
      url: "/test01",
      processData: false,
      contentType: false,
      cache: false,
      async : false,
      dataType:"json",
      success: function (result){
        result.forEach(function (element,index){
          geocoder.addressSearch(element.careAddr, function(result, status) {
            // 정상적으로 검색이 완료됐으면
            if (status === kakao.maps.services.Status.OK) {
              var imageSrc    = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; // 마커 이미지의 이미지 주소입니다
              var imageSize   = new kakao.maps.Size(24, 35);  // 마커 이미지의 이미지 크기 입니다
              var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); // 마커 이미지를 생성합니다
              var marker      = new kakao.maps.Marker({  // 마커를 생성합니다
                map: map,                           // 마커를 표시할 지도
                position: new kakao.maps.LatLng(result[0].y, result[0].x),      // 마커를 표시할 위치
                title : element.careNm,         // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                image : markerImage                 // 마커 이미지
              });
            }
          });
        });
      },
      error: function (XMLHttpRequest,status,error){
        alert("에러");
      }
    });
  }

  /* 펫 샵 */
  function event02(){
    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var options = { //지도를 생성할 때 필요한 기본 옵션
      center: new kakao.maps.LatLng(36.39195639201677, 127.40704329624886), //지도의 중심좌표.
      level: 10, //지도의 레벨(확대, 축소 정도)
      mapTypeId : kakao.maps.MapTypeId.ROADMAP
    };

    var geocoder       = new kakao.maps.services.Geocoder(); // 주소-좌표 변환 객체를 생성합니다
    var map            = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    var mapTypeControl = new kakao.maps.MapTypeControl();                 // 지도 타입 변경 컨트롤을 생성한다
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);  // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다

    $.ajax({
      type: "get",
      url: "/test02",
      processData: false,
      contentType: false,
      cache: false,
      async : false,
      dataType:"json",
      success: function (result){
        result.forEach(function (element,index){
          geocoder.addressSearch(element.siteWhlAddr, function(result, status) {
            // 정상적으로 검색이 완료됐으면
            if (status === kakao.maps.services.Status.OK) {
              var imageSrc    = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; // 마커 이미지의 이미지 주소입니다
              var imageSize   = new kakao.maps.Size(24, 35);  // 마커 이미지의 이미지 크기 입니다
              var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); // 마커 이미지를 생성합니다
              var marker      = new kakao.maps.Marker({  // 마커를 생성합니다
                map: map,                                // 마커를 표시할 지도
                position: new kakao.maps.LatLng(result[0].y, result[0].x),      // 마커를 표시할 위치
                title : element.bplcNm,         // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                image : markerImage             // 마커 이미지
              });
            }
          });
        });
      },
      error: function (XMLHttpRequest,status,error){
        alert("에러");
      }
    });
  }

  /* 병원 */
  function event03(){
    alert("동물 병원은 준비 중 입니다.");
  }

</script>

<html>
  <head>
    <title>KakaoTest</title>
  </head>
  <body>
  <%--  카카오 맵 --%>
  <div id="map" style="width:1300px;height:900px;"></div>

  <button onclick="event01();" >유기견 센터</button>
  <button onclick="event02();" >펫샵</button>
  <button onclick="event03();" >동물 병원</button>
  </body>
</html>