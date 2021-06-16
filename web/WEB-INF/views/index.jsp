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

<style>
  div {
    width: 100%;
    height: 100%;
  }
  div.left {
    width: 70%;
    float: left;
    box-sizing: border-box;
  }
  div.right {
    width: 30%;
    float: right;
    box-sizing: border-box;
  }

  .text01{
    width : 100%;
    height: 150px;
    text-align: center;
    padding-top: 2px;
    font-size: 10pt;
    border: 2px solid lightseagreen;
  }
  .text02{
    width : 100%;
    height: 110px;
    text-align: center;
    padding-top: 1px;
    font-size: 10pt;
    border: 2px solid indigo;
  }
  .text03{
    width : 100%;
    height: 110px;
    text-align: center;
    padding-top: 1px;
    font-size: 10pt;
    border: 2px solid deeppink;
  }
  .text04{
    width : 100%;
    height: 110px;
    text-align: center;
    padding-top: 1px;
    font-size: 10pt;
    border: 2px solid blue;
  }
  .text05{
    width : 100%;
    height: 110px;
    text-align: center;
    padding-top: 1px;
    font-size: 10pt;
    border: 2px solid brown;
  }
  .text06{
    width : 100%;
    height: 110px;
    text-align: center;
    padding-top: 1px;
    font-size: 10pt;
    border: 2px solid greenyellow;
  }
  .text07{
    width : 100%;
    height: 110px;
    text-align: center;
    padding-top: 1px;
    font-size: 10pt;
    border: 2px solid cornflowerblue;
  }
  .text08{
    width : 100%;
    height: 110px;
    text-align: center;
    padding-top: 1px;
    font-size: 10pt;
    border: 2px solid cornflowerblue;
  }

</style>


<script type="text/javascript">
  /* 카카오 맵 초기 설정 */
  $(function(){
    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var options = { //지도를 생성할 때 필요한 기본 옵션
      center: new kakao.maps.LatLng(36.39195639201677, 127.40704329624886), //지도의 중심좌표.
      level: 12, //지도의 레벨(확대, 축소 정도)
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
      level: 12, //지도의 레벨(확대, 축소 정도)
      mapTypeId : kakao.maps.MapTypeId.ROADMAP
    };

    var geocoder       = new kakao.maps.services.Geocoder(); // 주소-좌표 변환 객체를 생성합니다
    var map            = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    var mapTypeControl = new kakao.maps.MapTypeControl();                 // 지도 타입 변경 컨트롤을 생성한다
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);  // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다

    $.ajax({
      type: "get",
      url: "/search",
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
  function event02(gubun){
    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var options = { //지도를 생성할 때 필요한 기본 옵션
      center: new kakao.maps.LatLng(36.39195639201677, 127.40704329624886), //지도의 중심좌표.
      level: 12, //지도의 레벨(확대, 축소 정도)
      mapTypeId : kakao.maps.MapTypeId.ROADMAP
    };

    var geocoder       = new kakao.maps.services.Geocoder(); // 주소-좌표 변환 객체를 생성합니다
    var map            = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    var mapTypeControl = new kakao.maps.MapTypeControl();                 // 지도 타입 변경 컨트롤을 생성한다
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);  // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다

    $.ajax({
      type: "get",
      url: "/localSearch",
      async : false,
      data : { gubun : gubun },
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

  <div>
    <%--  카카오 맵 --%>
    <div class="left">
      <div id="map" style="width:100%;height:900px;"></div>
      <button onclick="event01();" >유기견 센터</button>
      <button onclick="event02('02_03_01_P');" >동물 병원</button>
      <button onclick="event02('02_03_02_P');" >동물 약국</button>
      <button onclick="event02('02_03_03_P');" >동물용 의료 용구 판매업</button>
      <button onclick="event02('02_03_04_P');" >동물용의약품도매상</button>
      <button onclick="event02('02_03_05_P');" >동물 장묘업</button>
      <button onclick="event02('02_03_06_P');" >동물 판매업</button>
    </div>

    <div class="right">
      <div class="text01">
        <ul>
          <li><strong>서버               :</strong> AWS[아마존 EC2]</li>
          <li><strong>아파치톰켓          :</strong> docker [개인설정톰켓]</li>
          <li><strong>DB                :</strong> docker [postgresql]</li>
          <li><strong>유기견api Data 링크 :</strong> <a href="https://www.data.go.kr/data/15035887/openapi.do"> 공공 데이터 </a> </li>
          <li><strong>그외 api Data 링크  :</strong> <a href="https://www.localdata.go.kr/devcenter/dataDown.do?menuNo=20001">LOCAL DATA </a>  </li>
          <li><strong>지도 api      링크  :</strong> <a href="https://apis.map.kakao.com/"> 카카오 MAP </a> </li>
          <li><strong>참고 사이트 링크     :</strong> <a href="https://www.animal.go.kr/front/awtis/institution/institutionList.do">동물관리시스템</a> </li>
        </ul>
      </div>
      <div class="text02">
        <ul>
          <li><strong>유기견 센터</strong></li>
          <li><strong>데이터 type :</strong> 공공 데이터 </li>
          <li><strong>총 데이터 건수 : </strong> 253 </li>
          <li><strong>설 명  :</strong> 공공 데이터 api를 이용한 실시간 호출 </li>
        </ul>
      </div>
      <div class="text03">
        <ul>
          <li> <strong> 동물 병원 </strong> </li>
          <li><strong>데이터 type :</strong> LOCAL DATA </li>
          <li><strong>총 데이터 건수 :</strong> 8255 </li>
          <li><strong>설 명  :</strong> LOCAL DATA 의 xml 파일 + LOCAL DATA api를 이용해 DB에 저장 후 쿼리 호출 </li>
        </ul>
      </div>
      <div class="text04">
        <ul>
          <li> <strong> 동물 약국 </strong> </li>
          <li><strong>데이터 type :</strong> LOCAL DATA </li>
          <li><strong>총 데이터 건수 :</strong> 9593 </li>
          <li><strong>설 명  :</strong> LOCAL DATA 의 xml 파일 + LOCAL DATA api를 이용해 DB에 저장 후 쿼리 호출 </li>
        </ul>
      </div>
      <div class="text05">
        <ul>
          <li> <strong>동물용 의료 용구 판매업 </strong> </li>
          <li><strong>데이터 type :</strong> LOCAL DATA </li>
          <li><strong>총 데이터 건수 :</strong> 1120 </li>
          <li><strong>설 명  :</strong> LOCAL DATA 의 xml 파일 + LOCAL DATA api를 이용해 DB에 저장 후 쿼리 호출 </li>
        </ul>
      </div>
      <div class="text06">
        <ul>
          <li><strong> 동물용의약품도매상 </strong> </li>
          <li><strong>데이터 type :</strong> LOCAL DATA </li>
          <li><strong>총 데이터 건수 :</strong> 1038 </li>
          <li><strong>설 명  :</strong> LOCAL DATA 의 xml 파일 + LOCAL DATA api를 이용해 DB에 저장 후 쿼리 호출 </li>
        </ul>
      </div>
      <div class="text07">
        <ul>
          <li><strong> 동물 장묘업</strong> </li>
          <li><strong>데이터 type :</strong> LOCAL DATA </li>
          <li><strong>총 데이터 건수 :</strong> 61 </li>
          <li><strong>설 명  :</strong> LOCAL DATA 의 xml 파일 + LOCAL DATA api를 이용해 DB에 저장 후 쿼리 호출 </li>
        </ul>
      </div>
      <div class="text08">
        <ul>
          <li><strong> 동물 판매업 </strong> </li>
          <li><strong>데이터 type :</strong> LOCAL DATA </li>
          <li><strong>총 데이터 건수 :</strong> 17233 </li>
          <li><strong>설 명  :</strong> LOCAL DATA 의 xml 파일 + LOCAL DATA api를 이용해 DB에 저장 후 쿼리 호출 </li>
        </ul>
      </div>
    </div>
  </div>
  </body>
</html>