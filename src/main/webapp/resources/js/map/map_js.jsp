<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.575920, 126.976824), // 지도의 중심좌표 기본값 경복궁
        level: 6 // 지도의 확대 레벨
    };
        
// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 
// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();
var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
//지도를 클릭했을 때 클릭 위치 좌표에 대한 법정동 주소정보를 표시하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
        	        	
            var detailAddr = '<div>' + result[0].address.address_name + '</div>';
            
            var content = '<div class="bAddr">' + 
                            detailAddr + 
                        '</div>';   
                        
            // 마커를 클릭한 위치에 표시합니다 
            marker.setPosition(mouseEvent.latLng);
            marker.setMap(map);
            
            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
            infowindow.setContent(content);
            infowindow.open(map, marker);
            
          	//서울시 제거, 구 동만 표기
            var choice = (result[0].address.region_2depth_name+"_"+result[0].address.region_3depth_name);
            
          	//서울이 아닌곳 검열
            if(result[0].address.region_1depth_name != "서울"){
            	alert("서울특별시에 해당하는 지역을 선택해주세요");
            }else{
            	//주소정보를 DB로 전달
	            $("#location").val(choice);
	            
	         	//구와 동
	         	var before_gu = result[0].address.region_2depth_name;
	         	var before_dong = result[0].address.region_3depth_name;
	       
	         	//자른글자 드롭박스에 대입
	         	$("#selectGu").text(before_gu);
	         	$("#selectDong").text(before_dong);
	         	changeDong(before_gu);
	         	
	        	//알림글 변경
	        	$("#gu_notice").css("display","block");
	        	$("#dong_notice").css("display","none");
            }
        }   
    });
});
function searchDetailAddrFromCoords(coords, callback) {
    // 좌표로 법정동 상세 주소 정보를 요청합니다
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}
//좌표에 따라 지도위치 변경
function centerChange(gu_lat,gu_lng) {
    // 이동할 위도 경도 위치를 생성합니다 
    var moveLatLng = new kakao.maps.LatLng(gu_lat,gu_lng);
   
    // 지도 중심을 이동 시킵니다
    map.setCenter(moveLatLng);
    //마커와 인포윈도우 재설정
    searchDetailAddrFromCoords(moveLatLng, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
        	        	
            var detailAddr = '<div> ' + result[0].address.region_2depth_name + '청 주변 지역' +'</div>';
            
            var content = '<div class="bAddr">' + 
                            detailAddr + 
                        '</div>';
                        
            // 마커를 클릭한 위치에 표시합니다 
            marker.setPosition(moveLatLng);
            marker.setMap(map);
            
            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
            infowindow.setContent(content);
            infowindow.open(map, marker);
        }
    });
};
</script>