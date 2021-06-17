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
  .main {
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
  /* 카카오 맵 초기 설정 및 변수 셋팅 */
  var map;
  var mapTypeControl;
  var container;
  var options;
  var geocoder;
  $(function(){
    kakaoInit(36.39195639201677,127.40704329624886);
  });

  function kakaoInit(hiddenLat,hiddenLng){
    container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    options = { //지도를 생성할 때 필요한 기본 옵션
      center: new kakao.maps.LatLng(hiddenLat,hiddenLng), //지도의 중심좌표.
      level: 10 //지도의 레벨(확대, 축소 정도)
    };
    map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    mapTypeControl = new kakao.maps.MapTypeControl();  // 지도 타입 변경 컨트롤을 생성한다
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);  // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
    // 주소-좌표 변환 객체를 생성합니다
    geocoder = new kakao.maps.services.Geocoder();
  }

  /* 유기견 센터 */
  function event01(){
    var select = $("#select").val();
    if(select == "" || select == null){
      alert("지역을 먼저 선택해 주세요.");
      return false;
    }

    /* 리셋 */
    var hiddenLat = $("#hiddenLat").val();
    var hiddenLng = $("#hiddenLng").val();
    kakaoInit(hiddenLat,hiddenLng);

    $.ajax({
      type: "get",
      url: "/search",
      async : false,
      data : { select : select},
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

  /* 로컬 데이타 */
  function event02(gubun){
    var select = $("#select").val();
    if(select == "" || select == null){
      alert("지역을 먼저 선택해 주세요.");
      return false;
    }

    /* 리셋 */
    var hiddenLat = $("#hiddenLat").val();
    var hiddenLng = $("#hiddenLng").val();
    kakaoInit(hiddenLat,hiddenLng);

    $.ajax({
      type: "get",
      url: "/localSearch",
      async : false,
      data : { gubun : gubun , select : select},
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

  /* 지역 select 이벤트 */
  function panTo() {
    var val = $("#select").val();
    var lat = "";
    var lng = "";

    if( val == "서울특별시" ){
      lat = 37.566535;   lng = 126.97796919;
    }else if( val == "인천광역시" ){
      lat = 37.45639;   lng = 126.70528;
    }else if( val == "대전광역시" ){
      lat = 36.35111;   lng = 127.38500;
    }else if( val == "대구광역시" ){
      lat = 35.87222;   lng = 128.60250;
    }else if( val == "울산광역시" ){
      lat = 35.53889;    lng = 129.31667;
    }else if( val == "부산광역시" ){
      lat = 35.17944;    lng = 129.07556;
    }else if( val == "광주광역시" ){
      lat = 35.1595454; lng = 126.8526012;
    }else if( val == "세종특별자치시" ){
      lat = 36.48750;  lng = 127.28167;
    }else if( val == "경기도" ){
      lat = 37.417771;   lng = 127.521919;
    }else if( val == "강원도" ){
      lat = 37.893141;   lng = 128.213197;
    }else if( val == "충청북도" ){
      lat = 36.995916;   lng = 127.689729;
    }else if( val == "충청남도" ){
      lat = 36.716868;   lng = 126.784369;
    }else if( val == "경상북도" ){
      lat = 36.288682;   lng = 128.887613;
    }else if( val == "경상남도" ){
      lat = 35.455620;   lng = 128.209619;
    }else if( val == "전라북도" ){
      lat = 35.716798;   lng = 127.150097;
    }else if( val == "전라남도" ){
      lat = 34.864898;   lng = 126.997167;
    }else if( val == "제주특별자치도" ){
      lat = 33.382526;   lng = 126.538488;
    }else {
      /* 플랜아이 */
      lat = 36.39195639201677; lng =127.40704329624886;
    }
    $("#hiddenLat").val(lat);
    $("#hiddenLng").val(lng);

    // 이동할 위도 경도 위치를 생성합니다
    var moveLatLon = new kakao.maps.LatLng(lat, lng);
    // 지도 중심을 부드럽게 이동시킵니다
    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
    map.panTo(moveLatLon);
  }

</script>

<html>
  <head>
    <title>KakaoTest</title>
  </head>
  <body>
  <input type="hidden" id="hiddenLat" value=""/>
  <input type="hidden" id="hiddenLng" value=""/>

  <div  class="main">
    <%--  카카오 맵 --%>
    <div class="left">
      <div id="map" style="width:100%;height:900px;"></div>

      <select id="select" onchange="panTo()">
        <option value="">지역 선택</option>
        <option value="서울특별시">서울특별시</option>
        <option value="인천광역시">인천광역시</option>
        <option value="대전광역시">대전광역시</option>
        <option value="대구광역시">대구광역시</option>
        <option value="울산광역시">울산광역시</option>
        <option value="부산광역시">부산광역시</option>
        <option value="광주광역시">광주광역시</option>
        <option value="세종특별자치시">세종특별자치시</option>
        <option value="경기도">경기도</option>
        <option value="강원도">강원도</option>
        <option value="충청북도">충청북도</option>
        <option value="충청남도">충청남도</option>
        <option value="경상북도">경상북도</option>
        <option value="경상남도">경상남도</option>
        <option value="전라북도">전라북도</option>
        <option value="전라남도">전라남도</option>
        <option value="제주특별자치도">제주특별자치도</option>
      </select>

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