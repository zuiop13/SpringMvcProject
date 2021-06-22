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

  div.bottom {
    height: 100px;
    clear: both;
  }

  .text01{
    width : 100%;
    height: 200px;
    padding-top: 2px;
    font-size: 10pt;
    border: 2px solid lightseagreen;
  }
  .text02{
    margin-top: 2px;
    width : 100%;
    height: 90px;
    padding-top: 1px;
    font-size: 10pt;
    border: 2px solid lightseagreen;
  }
  .text03{
    margin-top: 2px;
    width : 100%;
    height: 90px;
    padding-top: 1px;
    font-size: 10pt;
    border: 2px solid lightseagreen;
  }
  .text04{
    margin-top: 2px;
    width : 100%;
    height: 90px;
    padding-top: 1px;
    font-size: 10pt;
    border: 2px solid lightseagreen;
  }
  .text05{
    margin-top: 2px;
    width : 100%;
    height: 90px;
    padding-top: 1px;
    font-size: 10pt;
    border: 2px solid lightseagreen;
  }
  .text06{
    margin-top: 2px;
    width : 100%;
    height: 90px;
    padding-top: 1px;
    font-size: 10pt;
    border: 2px solid lightseagreen;
  }
  .text07{
    margin-top: 2px;
    width : 100%;
    height: 90px;
    padding-top: 1px;
    font-size: 10pt;
    border: 2px solid lightseagreen;
  }
  .text08{
    margin-top: 2px;
    width : 100%;
    height: 90px;
    padding-top: 1px;
    font-size: 10pt;
    border: 2px solid lightseagreen;
  }
  .winDiv{
    width: 100%;
  }
  .map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
  .map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
  .map_wrap {position:relative;width:100%;height:500px;}
  #menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
  .bg_white {background:#fff;}
  #menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
  #menu_wrap .option{text-align: center;}
  #menu_wrap .option p {margin:10px 0;}
  #menu_wrap .option button {margin-left:5px;}
  #placesList li {list-style: none;}
  #placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
  #placesList .item span {display: block;margin-top:4px;}
  #placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
  #placesList .item .info{padding:10px 0 10px 55px;}
  #placesList .info .gray {color:#8a8a8a;}
  #placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
  #placesList .info .tel {color:#009900;}
  #placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
  #placesList .item .marker_1 {background-position: 0 -10px;}
  #placesList .item .marker_2 {background-position: 0 -56px;}
  #placesList .item .marker_3 {background-position: 0 -102px}
  #placesList .item .marker_4 {background-position: 0 -148px;}
  #placesList .item .marker_5 {background-position: 0 -194px;}
  #placesList .item .marker_6 {background-position: 0 -240px;}
  #placesList .item .marker_7 {background-position: 0 -286px;}
  #placesList .item .marker_8 {background-position: 0 -332px;}
  #placesList .item .marker_9 {background-position: 0 -378px;}
  #placesList .item .marker_10 {background-position: 0 -423px;}
  #placesList .item .marker_11 {background-position: 0 -470px;}
  #placesList .item .marker_12 {background-position: 0 -516px;}
  #placesList .item .marker_13 {background-position: 0 -562px;}
  #placesList .item .marker_14 {background-position: 0 -608px;}
  #placesList .item .marker_15 {background-position: 0 -654px;}
  #pagination {margin:10px auto;text-align: center;}
  #pagination a {display:inline-block;margin-right:10px;}
  #pagination .on {font-weight: bold; cursor: default;color:#777;}
</style>


<script type="text/javascript">
  /* 카카오 맵 초기 설정 및 변수 셋팅 */
  var map;
  var mapTypeControl;
  var container;
  var options;
  var geocoder;
  var ps;
  var infowindow;
  // 마커를 담을 배열입니다
  var markers = [];

  $(function(){
    kakaoInit(36.39195639201677,127.40704329624886);
  });

  function kakaoInit(hiddenLat,hiddenLng){
    container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    options = { //지도를 생성할 때 필요한 기본 옵션
      center: new kakao.maps.LatLng(hiddenLat,hiddenLng), //지도의 중심좌표.
      level: 8 //지도의 레벨(확대, 축소 정도)
    };
    map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    // 장소 검색 객체를 생성합니다
    ps = new kakao.maps.services.Places();
    // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
    infowindow = new kakao.maps.InfoWindow({zIndex:1});
    //searchPlaces();//키워드 장소 검색
    mapTypeControl = new kakao.maps.MapTypeControl();  // 지도 타입 변경 컨트롤을 생성한다
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);  // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
    // 주소-좌표 변환 객체를 생성합니다
    geocoder = new kakao.maps.services.Geocoder();
  }

  /* 유기견 센터 */
  function event01(){
    var select = $("#select").val();
    var selectEnd = $("#selectEnd").val();
    if(select == "" || select == null){
      alert("시/도 를 선택해 주세요.");
      return false;
    }

    if(selectEnd == "" || selectEnd == null){
      alert("시/군/도 를 선택해 주세요.");
      return false;
    }

    /* 리셋 */
    var hiddenLat = $("#hiddenLat").val();
    var hiddenLng = $("#hiddenLng").val();
    kakaoInit(hiddenLat,hiddenLng);

    /* 키워드 다시 검색 */
    rSearchPlaces();

    if(select == "세종특별자치시"){
      var subSelect = select;
    }else {
      var subSelect = select+" "+selectEnd;
    }

    $.ajax({
      type: "get",
      url: "/search",
      async : false,
      data : { select : subSelect },
      dataType:"json",
      success: function (result){
        if(result == null || result == ""){
          alert("검색된 데이터가 없습니다.");
          return false;
        }

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
                image : markerImage             // 마커 이미지
              });

              var iwContent;
              if(!element.siteTel){
                iwContent = '<div class="winDiv" style="padding:5px;"><b>'+element.careNm+'</b></div> <div class="winDiv" style="padding:5px;">'+element.careAddr+'</div>';
              }else{
                iwContent = '<div class="winDiv" style="padding:5px;"><b>'+element.careNm+'</b></div> <div class="winDiv" style="padding:5px;">'+element.careAddr+'</div> <div class="winDiv" style="padding:5px;">'+element.careTel+'</div>';
              }
              // 인포윈도우를 생성합니다
              var infowindow = new kakao.maps.InfoWindow({
                content : iwContent
              });

              // 마커에 mouseover 이벤트를 등록한다
              kakao.maps.event.addListener(marker, 'mouseover', function() {
                infowindow.open(map, marker);
              });

              // 마커에 mouseout 이벤트 등록
              kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
              });

              // 마커에 클릭이벤트를 등록합니다
              kakao.maps.event.addListener(marker, 'click', function() {
                window.open(" https://map.kakao.com/link/to/"+element.careNm+","+result[0].y+","+result[0].x);
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
    var selectEnd = $("#selectEnd").val();
    if(select == "" || select == null){
      alert("시/도 를 선택해 주세요.");
      return false;
    }

    if(selectEnd == "" || selectEnd == null){
      alert("시/군/도 를 선택해 주세요.");
      return false;
    }

    /* 리셋 */
    var hiddenLat = $("#hiddenLat").val();
    var hiddenLng = $("#hiddenLng").val();
    kakaoInit(hiddenLat,hiddenLng);

    /* 키워드 다시 검색 */
    rSearchPlaces();

    if(select == "세종특별자치시"){
      var subSelect = select;
    }else {
      var subSelect = select+" "+selectEnd;
    }

    $.ajax({
      type: "get",
      url: "/localSearch",
      async : false,
      data : { gubun : gubun , select : subSelect},
      dataType:"json",
      success: function (result){
        if(result == null || result == ""){
          alert("검색된 데이터가 없습니다.");
          return false;
        }

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

              var iwContent;
              if(!element.siteTel){
                iwContent = '<div class="winDiv" style="padding:5px;"><b>'+element.bplcNm+'</b></div> <div class="winDiv" style="padding:5px;">'+element.siteWhlAddr+'</div>';
              }else{
                iwContent = '<div class="winDiv" style="padding:5px;"><b>'+element.bplcNm+'</b></div> <div class="winDiv" style="padding:5px;">'+element.siteWhlAddr+'</div> <div class="winDiv" style="padding:5px;">'+element.siteTel+'</div>';
              }

              // 인포윈도우를 생성합니다
              var infowindow = new kakao.maps.InfoWindow({
                content : iwContent
              });

              // 마커에 mouseover 이벤트를 등록한다
              kakao.maps.event.addListener(marker, 'mouseover', function() {
                infowindow.open(map, marker);
              });

              // 마커에 mouseout 이벤트 등록
              kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
              });

              // 마커에 클릭이벤트를 등록합니다
              kakao.maps.event.addListener(marker, 'click', function() {
                window.open(" https://map.kakao.com/link/to/"+element.bplcNm+","+result[0].y+","+result[0].x);
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

  /* 시/도 select 이벤트 */
  function selectEvent() {
    var select = $("#select");
    var selectEnd = $("#selectEnd");
    selectEnd.empty();
    if(select.val()){ //시도 군 값이 있을때만.
      if(select.val() == "서울특별시"){
        // 삭제 - append 할예정
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="중구">중구</option>');
        selectEnd.append('<option value="용산구">용산구</option>');
        selectEnd.append('<option value="성동구">성동구</option>');
        selectEnd.append('<option value="광진구">광진구</option>');
        selectEnd.append('<option value="동대문구">동대문구</option>');
        selectEnd.append('<option value="중랑구">중랑구</option>');
        selectEnd.append('<option value="성북구">성북구</option>');
        selectEnd.append('<option value="강북구">강북구</option>');
        selectEnd.append('<option value="도봉구">도봉구</option>');
        selectEnd.append('<option value="노원구">노원구</option>');
        selectEnd.append('<option value="은평구">은평구</option>');
        selectEnd.append('<option value="서대문구">서대문구</option>');
        selectEnd.append('<option value="마포구">마포구</option>');
        selectEnd.append('<option value="양천구">양천구</option>');
        selectEnd.append('<option value="강서구">강서구</option>');
        selectEnd.append('<option value="구로구">구로구</option>');
        selectEnd.append('<option value="금천구">금천구</option>');
        selectEnd.append('<option value="영등포구">영등포구</option>');
        selectEnd.append('<option value="동작구">동작구</option>');
        selectEnd.append('<option value="관악구">관악구</option>');
        selectEnd.append('<option value="서초구">서초구</option>');
        selectEnd.append('<option value="강남구">강남구</option>');
        selectEnd.append('<option value="송파구">송파구</option>');
        selectEnd.append('<option value="강동구">강동구</option>');
      }else if(select.val() == "부산광역시"){
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="중구">중구</option>');
        selectEnd.append('<option value="서구">서구</option>');
        selectEnd.append('<option value="동구">동구</option>');
        selectEnd.append('<option value="영도구">영도구</option>');
        selectEnd.append('<option value="부산진구">부산진구</option>');
        selectEnd.append('<option value="동래구">동래구</option>');
        selectEnd.append('<option value="남구">남구</option>');
        selectEnd.append('<option value="북구">북구</option>');
        selectEnd.append('<option value="해운대구">해운대구</option>');
        selectEnd.append('<option value="사하구">사하구</option>');
        selectEnd.append('<option value="금정구">금정구</option>');
        selectEnd.append('<option value="강서구">강서구</option>');
        selectEnd.append('<option value="연제구">연제구</option>');
        selectEnd.append('<option value="수영구">수영구</option>');
        selectEnd.append('<option value="사상구">사상구</option>');
        selectEnd.append('<option value="기장군">기장군</option>');
      }else if(select.val() == "대구광역시"){
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="중구">중구</option>');
        selectEnd.append('<option value="동구">동구</option>');
        selectEnd.append('<option value="서구">서구</option>');
        selectEnd.append('<option value="남구">남구</option>');
        selectEnd.append('<option value="북구">북구</option>');
        selectEnd.append('<option value="수성구">수성구</option>');
        selectEnd.append('<option value="달서구">달서구</option>');
        selectEnd.append('<option value="달성군">달성군</option>');
      }else if(select.val() == "인천광역시"){
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="중구">중구</option>');
        selectEnd.append('<option value="동구">동구</option>');
        selectEnd.append('<option value="미추홀구">미추홀구</option>');
        selectEnd.append('<option value="연수구">연수구</option>');
        selectEnd.append('<option value="남동구">남동구</option>');
        selectEnd.append('<option value="부평구">부평구</option>');
        selectEnd.append('<option value="계양구">계양구</option>');
        selectEnd.append('<option value="서구">서구</option>');
        selectEnd.append('<option value="강화군">강화군</option>');
        selectEnd.append('<option value="옹진군">옹진군</option>');
      }else if(select.val() == "광주광역시"){
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="동구">동구</option>');
        selectEnd.append('<option value="서구">서구</option>');
        selectEnd.append('<option value="남구">남구</option>');
        selectEnd.append('<option value="북구">북구</option>');
        selectEnd.append('<option value="광산구">광산구</option>');
      }else if(select.val() == "대전광역시"){
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="동구">동구</option>');
        selectEnd.append('<option value="중구">중구</option>');
        selectEnd.append('<option value="서구">서구</option>');
        selectEnd.append('<option value="유성구">유성구</option>');
        selectEnd.append('<option value="대덕구">대덕구</option>');
      }else if(select.val() == "울산광역시"){
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="중구">중구</option>');
        selectEnd.append('<option value="남구">남구</option>');
        selectEnd.append('<option value="동구">동구</option>');
        selectEnd.append('<option value="북구">북구</option>');
        selectEnd.append('<option value="울주군">울주군</option>');
      }else if(select.val() == "세종특별자치시"){
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="세종특별자치시">세종특별자치시</option>');
      }else if(select.val() == "경기도"){
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="수원시">수원시</option>');
        selectEnd.append('<option value="고양시">고양시</option>');
        selectEnd.append('<option value="용인시">용인시</option>');
        selectEnd.append('<option value="성남시">성남시</option>');
        selectEnd.append('<option value="부천시">부천시</option>');
        selectEnd.append('<option value="화성시">화성시</option>');
        selectEnd.append('<option value="안산시">안산시</option>');
        selectEnd.append('<option value="남양주시">남양주시</option>');
        selectEnd.append('<option value="안양시">안양시</option>');
        selectEnd.append('<option value="평택시">평택시</option>');
        selectEnd.append('<option value="시흥시">시흥시</option>');
        selectEnd.append('<option value="파주시">파주시</option>');
        selectEnd.append('<option value="의정부시">의정부시</option>');
        selectEnd.append('<option value="김포시">김포시</option>');
        selectEnd.append('<option value="광주시">광주시</option>');
        selectEnd.append('<option value="광명시">광명시</option>');
        selectEnd.append('<option value="군포시">군포시</option>');
        selectEnd.append('<option value="하남시">하남시</option>');
        selectEnd.append('<option value="오산시">오산시</option>');
        selectEnd.append('<option value="양주시">양주시</option>');
        selectEnd.append('<option value="이천시">이천시</option>');
        selectEnd.append('<option value="구리시">구리시</option>');
        selectEnd.append('<option value="안성시">안성시</option>');
        selectEnd.append('<option value="포천시">포천시</option>');
        selectEnd.append('<option value="의왕시">의왕시</option>');
        selectEnd.append('<option value="양평군">양평군</option>');
        selectEnd.append('<option value="여주시">여주시</option>');
        selectEnd.append('<option value="동두천시">동두천시</option>');
        selectEnd.append('<option value="가평군">가평군</option>');
        selectEnd.append('<option value="과천시">과천시</option>');
        selectEnd.append('<option value="연천군">연천군</option>');
      }else if(select.val() == "강원도") {
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="춘천시">춘천시</option>');
        selectEnd.append('<option value="원주시">원주시</option>');
        selectEnd.append('<option value="강릉시">강릉시</option>');
        selectEnd.append('<option value="동해시">동해시</option>');
        selectEnd.append('<option value="태백시">태백시</option>');
        selectEnd.append('<option value="속초시">속초시</option>');
        selectEnd.append('<option value="삼척시">삼척시</option>');
        selectEnd.append('<option value="홍천군">홍천군</option>');
        selectEnd.append('<option value="횡성군">횡성군</option>');
        selectEnd.append('<option value="영월군">영월군</option>');
        selectEnd.append('<option value="평창군">평창군</option>');
        selectEnd.append('<option value="정선군">정선군</option>');
        selectEnd.append('<option value="철원군">철원군</option>');
        selectEnd.append('<option value="화천군">화천군</option>');
        selectEnd.append('<option value="양구군">양구군</option>');
        selectEnd.append('<option value="인제군">인제군</option>');
        selectEnd.append('<option value="고성군">고성군</option>');
        selectEnd.append('<option value="양양군">양양군</option>');
      }else if(select.val() == "충청북도") {
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="청주시">청주시</option>');
        selectEnd.append('<option value="충주시">충주시</option>');
        selectEnd.append('<option value="제천시">제천시</option>');
        selectEnd.append('<option value="보은군">보은군</option>');
        selectEnd.append('<option value="옥천군">옥천군</option>');
        selectEnd.append('<option value="영동군">영동군</option>');
        selectEnd.append('<option value="증평군">증평군</option>');
        selectEnd.append('<option value="진천군">진천군</option>');
        selectEnd.append('<option value="괴산군">괴산군</option>');
        selectEnd.append('<option value="음성군">음성군</option>');
        selectEnd.append('<option value="단양군">단양군</option>');
      }else if(select.val() == "충청남도") {
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="천안시">천안시</option>');
        selectEnd.append('<option value="공주시">공주시</option>');
        selectEnd.append('<option value="보령시">보령시</option>');
        selectEnd.append('<option value="아산시">아산시</option>');
        selectEnd.append('<option value="서산시">서산시</option>');
        selectEnd.append('<option value="논산시">논산시</option>');
        selectEnd.append('<option value="계룡시">계룡시</option>');
        selectEnd.append('<option value="당진시">당진시</option>');
        selectEnd.append('<option value="금산군">금산군</option>');
        selectEnd.append('<option value="부여군">부여군</option>');
        selectEnd.append('<option value="서천군">서천군</option>');
        selectEnd.append('<option value="청양군">청양군</option>');
        selectEnd.append('<option value="홍성군">홍성군</option>');
        selectEnd.append('<option value="예산군">예산군</option>');
        selectEnd.append('<option value="태안군">태안군</option>');
      }else if(select.val() == "전라북도") {
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="전주시">전주시</option>');
        selectEnd.append('<option value="군산시">군산시</option>');
        selectEnd.append('<option value="익산시">익산시</option>');
        selectEnd.append('<option value="정읍시">정읍시</option>');
        selectEnd.append('<option value="남원시">남원시</option>');
        selectEnd.append('<option value="김제시">김제시</option>');
        selectEnd.append('<option value="완주군">완주군</option>');
        selectEnd.append('<option value="진안군">진안군</option>');
        selectEnd.append('<option value="무주군">무주군</option>');
        selectEnd.append('<option value="장수군">장수군</option>');
        selectEnd.append('<option value="임실군">임실군</option>');
        selectEnd.append('<option value="순창군">순창군</option>');
        selectEnd.append('<option value="고창군">고창군</option>');
        selectEnd.append('<option value="부안군">부안군</option>');
      }else if(select.val() == "전라남도") {
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="목포시">목포시</option>');
        selectEnd.append('<option value="여수시">여수시</option>');
        selectEnd.append('<option value="순천시">순천시</option>');
        selectEnd.append('<option value="나주시">나주시</option>');
        selectEnd.append('<option value="광양시">광양시</option>');
        selectEnd.append('<option value="담양군">담양군</option>');
        selectEnd.append('<option value="곡성군">곡성군</option>');
        selectEnd.append('<option value="구례군">구례군</option>');
        selectEnd.append('<option value="고흥군">고흥군</option>');
        selectEnd.append('<option value="보성군">보성군</option>');
        selectEnd.append('<option value="화순군">화순군</option>');
        selectEnd.append('<option value="장흥군">장흥군</option>');
        selectEnd.append('<option value="강진군">강진군</option>');
        selectEnd.append('<option value="해남군">해남군</option>');
        selectEnd.append('<option value="영암군">영암군</option>');
        selectEnd.append('<option value="무안군">무안군</option>');
        selectEnd.append('<option value="함평군">함평군</option>');
        selectEnd.append('<option value="영광군">영광군</option>');
        selectEnd.append('<option value="장성군">장성군</option>');
        selectEnd.append('<option value="완도군">완도군</option>');
        selectEnd.append('<option value="진도군">진도군</option>');
        selectEnd.append('<option value="신안군">신안군</option>');
      }else if(select.val() == "경상북도") {
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="포항시">포항시</option>');
        selectEnd.append('<option value="경주시">경주시</option>');
        selectEnd.append('<option value="김천시">김천시</option>');
        selectEnd.append('<option value="안동시">안동시</option>');
        selectEnd.append('<option value="구미시">구미시</option>');
        selectEnd.append('<option value="영주시">영주시</option>');
        selectEnd.append('<option value="영천시">영천시</option>');
        selectEnd.append('<option value="상주시">상주시</option>');
        selectEnd.append('<option value="문경시">문경시</option>');
        selectEnd.append('<option value="경산시">경산시</option>');
        selectEnd.append('<option value="군위군">군위군</option>');
        selectEnd.append('<option value="의성군">의성군</option>');
        selectEnd.append('<option value="청송군">청송군</option>');
        selectEnd.append('<option value="영양군">영양군</option>');
        selectEnd.append('<option value="영덕군">영덕군</option>');
        selectEnd.append('<option value="청도군">청도군</option>');
        selectEnd.append('<option value="고령군">고령군</option>');
        selectEnd.append('<option value="성주군">성주군</option>');
        selectEnd.append('<option value="칠곡군">칠곡군</option>');
        selectEnd.append('<option value="예천군">예천군</option>');
        selectEnd.append('<option value="봉화군">봉화군</option>');
        selectEnd.append('<option value="울진군">울진군</option>');
        selectEnd.append('<option value="울릉군">울릉군</option>');
      }else if(select.val() == "경상남도") {
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="창원시">창원시</option>');
        selectEnd.append('<option value="진주시">진주시</option>');
        selectEnd.append('<option value="통영시">통영시</option>');
        selectEnd.append('<option value="사천시">사천시</option>');
        selectEnd.append('<option value="김해시">김해시</option>');
        selectEnd.append('<option value="밀양시">밀양시</option>');
        selectEnd.append('<option value="거제시">거제시</option>');
        selectEnd.append('<option value="양산시">양산시</option>');
        selectEnd.append('<option value="의령군">의령군</option>');
        selectEnd.append('<option value="함안군">함안군</option>');
        selectEnd.append('<option value="창녕군">창녕군</option>');
        selectEnd.append('<option value="고성군">고성군</option>');
        selectEnd.append('<option value="남해군">남해군</option>');
        selectEnd.append('<option value="하동군">하동군</option>');
        selectEnd.append('<option value="산청군">산청군</option>');
        selectEnd.append('<option value="함양군">함양군</option>');
        selectEnd.append('<option value="거창군">거창군</option>');
        selectEnd.append('<option value="합천군">합천군</option>');
      }else if(select.val() == "제주특별자치도") {
        selectEnd.append('<option value="">시/군/도 선택</option>');
        selectEnd.append('<option value="제주시">제주시</option>');
        selectEnd.append('<option value="서귀포시">서귀포시</option>');
      }
    }
  }


  /* 시/군/도 map 이동 이벤트 */
  function selectEndEvent() {
    var select    = $("#select").val();
    var selectEnd = $("#selectEnd").val();
    if(select == "세종특별자치시"){
      var subSelect = select;
    }else {
      var subSelect = select+" "+selectEnd;
    }

    // 주소를 위도 경도로 변환 해줍니다.
    geocoder.addressSearch(subSelect, function(result, status) {
      // 정상적으로 검색이 완료됐으면
      if (status === kakao.maps.services.Status.OK) {
        $("#hiddenLat").val(result[0].y);
        $("#hiddenLng").val(result[0].x);
        var moveLatLon = new kakao.maps.LatLng(result[0].y, result[0].x);
        // 지도 중심을 부드럽게 이동시킵니다
        // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
        map.panTo(moveLatLon);
      }
    });
  }

  // 키워드 검색을 요청하는 함수입니다
  function searchPlaces() {
    var keyword = document.getElementById('keyword').value;
    if (!keyword.replace(/^\s+|\s+$/g, '')) {
      alert('키워드를 입력해주세요!');
      return false;
    }
    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB);
  }

  // 키워드 검색을 요청하는 함수입니다
  function rSearchPlaces() {
    var keyword = document.getElementById('keyword').value;
    if(keyword){
      ps.keywordSearch( keyword, placesSearchCB);
    }
  }

  // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
  function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {
      // 정상적으로 검색이 완료됐으면
      // 검색 목록과 마커를 표출합니다
      displayPlaces(data);
      // 페이지 번호를 표출합니다
      displayPagination(pagination);
    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
      alert('검색 결과가 존재하지 않습니다.');
      return;
    } else if (status === kakao.maps.services.Status.ERROR) {
      alert('검색 결과 중 오류가 발생했습니다.');
      return;
    }
  }

  // 검색 결과 목록과 마커를 표출하는 함수입니다
  function displayPlaces(places) {
    var listEl = document.getElementById('placesList'),
            menuEl = document.getElementById('menu_wrap'),
            fragment = document.createDocumentFragment(),
            bounds = new kakao.maps.LatLngBounds(),
            listStr = '';

    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();

    for ( var i=0; i<places.length; i++ ) {

      // 마커를 생성하고 지도에 표시합니다
      var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                 marker = addMarker(placePosition, i),
                 itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

      // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
      // LatLngBounds 객체에 좌표를 추가합니다
      bounds.extend(placePosition);

      // 마커와 검색결과 항목에 mouseover 했을때
      // 해당 장소에 인포윈도우에 장소명을 표시합니다
      // mouseout 했을 때는 인포윈도우를 닫습니다
      (function(marker, title) {
/*        kakao.maps.event.addListener(marker, 'mouseover', function() {
          //displayInfowindow(marker, title);
        });*/

/*        kakao.maps.event.addListener(marker, 'mouseout', function() {
          infowindow.close();
        });*/

        itemEl.onmouseover =  function () {
          displayInfowindow(marker, title);
        };

        itemEl.onmouseout =  function () {
          infowindow.close();
          panTo();
        };
      })(marker, places[i].place_name);

      fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;
    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    //map.setBounds(bounds);
  }

  // 검색결과 항목을 Element로 반환하는 함수입니다
  function getListItem(index, places) {

    var el = document.createElement('li'),
            itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                    '<div class="info">' +
                    '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
      itemStr += '    <span>' + places.road_address_name + '</span>' +
              '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
      itemStr += '    <span>' +  places.address_name  + '</span>';
    }

    itemStr += '  <span class="tel">' + places.phone  + '</span>' +
            '</div>';

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
  }

  // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
  function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
            imgOptions =  {
              spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
              spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
              offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            },
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
              position: position, // 마커의 위치
              image: markerImage
            });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
  }

  // 지도 위에 표시되고 있는 마커를 모두 제거합니다
  function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
      markers[i].setMap(null);
    }
    markers = [];
  }


  // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
  function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
            fragment = document.createDocumentFragment(),
            i;

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
      paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
      var el = document.createElement('a');
      el.href = "#";
      el.innerHTML = i;

      if (i===pagination.current) {
        el.className = 'on';
      } else {
        el.onclick = (function(i) {
          return function() {
            pagination.gotoPage(i);
          }
        })(i);
      }

      fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
  }

  // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
  // 인포윈도우에 장소명을 표시합니다
  function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
  }

  // 검색결과 목록의 자식 Element를 제거하는 함수입니다
  function removeAllChildNods(el) {
    while (el.hasChildNodes()) {
      el.removeChild (el.lastChild);
    }
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
      <div class="map_wrap">
        <div id="map" style="width:100%;height:850px;"></div>
        <div id="menu_wrap" class="bg_white">
          <div class="option">
            <div>
              <form onsubmit="searchPlaces(); return false;">
                키워드 : <input type="text" value="" id="keyword" size="15">
                <button type="submit">검색하기</button>
              </form>
            </div>
          </div>
          <hr>
          <ul id="placesList"></ul>
          <div id="pagination"></div>
        </div>
      </div>
    </div>

    <div class="right">
      <div class="text01">
        <ul>
          <li><strong>서버               :</strong> AWS[아마존 EC2]</li>
          <li><strong>아파치톰켓          :</strong> docker [개인설정톰켓]</li>
          <li><strong>DB                :</strong> docker [postgresql]</li>
          <li><strong>유기견api Data 링크 :</strong> <a href="https://www.data.go.kr/data/15035887/openapi.do"> 공공 데이터 </a> </li>
          <li><strong>Local api Data 링크  :</strong> <a href="https://www.localdata.go.kr/devcenter/dataDown.do?menuNo=20001">LOCAL DATA </a>  </li>
          <li><strong>지도 api      링크  :</strong> <a href="https://apis.map.kakao.com/"> 카카오 MAP </a> </li>
          <li><strong>참고 사이트 링크     :</strong> <a href="https://www.animal.go.kr/front/awtis/institution/institutionList.do">동물관리시스템</a> </li>

          <li><strong>유기견api 설 명 :</strong> 공공 데이터 api를 이용한 실시간 호출 </li>
          <li><strong>Local api 설 명 :</strong> LOCAL DATA 의 xml 파일 + LOCAL DATA api를 이용해 DB에 저장 후 쿼리 호출 </li>

        </ul>
      </div>
      <div class="text02">
        <ul>
          <li><strong>유기견 센터</strong></li>
          <li><strong>데이터 type :</strong> 공공 데이터 </li>
          <li><strong>총 데이터 건수 : </strong> 253 </li>
        </ul>
      </div>
      <div class="text03">
        <ul>
          <li> <strong> 동물 병원 </strong> </li>
          <li><strong>데이터 type :</strong> LOCAL DATA </li>
          <li><strong>총 데이터 건수 :</strong> 8255 </li>
        </ul>
      </div>
      <div class="text04">
        <ul>
          <li> <strong> 동물 약국 </strong> </li>
          <li><strong>데이터 type :</strong> LOCAL DATA </li>
          <li><strong>총 데이터 건수 :</strong> 9593 </li>
        </ul>
      </div>
      <div class="text05">
        <ul>
          <li> <strong>동물용 의료 용구 판매업 </strong> </li>
          <li><strong>데이터 type :</strong> LOCAL DATA </li>
          <li><strong>총 데이터 건수 :</strong> 1120 </li>
        </ul>
      </div>
      <div class="text06">
        <ul>
          <li><strong> 동물용의약품도매상 </strong> </li>
          <li><strong>데이터 type :</strong> LOCAL DATA </li>
          <li><strong>총 데이터 건수 :</strong> 1038 </li>
        </ul>
      </div>
      <div class="text07">
        <ul>
          <li><strong> 동물 장묘업</strong> </li>
          <li><strong>데이터 type :</strong> LOCAL DATA </li>
          <li><strong>총 데이터 건수 :</strong> 61 </li>
        </ul>
      </div>
      <div class="text08">
        <ul>
          <li><strong> 동물 판매업 </strong> </li>
          <li><strong>데이터 type :</strong> LOCAL DATA </li>
          <li><strong>총 데이터 건수 :</strong> 17233 </li>
        </ul>
      </div>
    </div>

      <div class="bottom">
        <select id="select" onchange="selectEvent()">
          <option value="">시/도 선택</option>
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

        <select id="selectEnd" onchange="selectEndEvent()">
          <option value="">시/군/도 선택</option>
        </select>

        <button onclick="event01();" >유기견 센터</button>
        <button onclick="event02('02_03_01_P');" >동물 병원</button>
        <button onclick="event02('02_03_02_P');" >동물 약국</button>
        <button onclick="event02('02_03_03_P');" >동물용 의료 용구 판매업</button>
        <button onclick="event02('02_03_04_P');" >동물용의약품도매상</button>
        <button onclick="event02('02_03_05_P');" >동물 장묘업</button>
        <button onclick="event02('02_03_06_P');" >동물 판매업</button>
      </div>

  </div>
  </body>
</html>