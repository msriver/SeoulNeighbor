<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
/* 빈칸확인 */
function boardCheck() {
	if (document.frm.title.value.length == 0) {
		alert("제목을 입력하세요.");
		return false;
	}
	if (document.frm.content.value.length == 0) {
		alert("내용을 입력하세요.");
		return false;
	}
	if (document.frm.category.value.length == 0) {
		alert("카테고리를 선택하세요.");
		return false;
	}
	if (document.frm.location.value.length == 0) {
		alert("지역을 선택하세요.");
		return false;
	}
	return true;
}
/* 카테고리선택 */
$("#selectcategory ~ div a").on("click", function() {
    // 버튼에 선택된 항목 텍스트 넣기 
    $("#selectcategory").text($(this).text());
    $("#category").val($(this).text());
});
// 구 -> 동 선택하기 /////////////////////////////////////
var gu = "";
var dong = "";
//구가 바뀔때 동 옵션값 바뀌는 함수
function changeDong(gu){	
	var dong = $("#dong");
	
	dong.empty();
	if(gu=="강남구"){
		dong.append(
				"<a class='dropdown-item' href='#'>신사동</a>"+
				"<a class='dropdown-item' href='#'>논현동</a>"+
				"<a class='dropdown-item' href='#'>압구정동</a>"+
				"<a class='dropdown-item' href='#'>청담동</a>"+
				"<a class='dropdown-item' href='#'>삼성동</a>"+
				"<a class='dropdown-item' href='#'>대치동</a>"+
				"<a class='dropdown-item' href='#'>역삼동</a>"+
				"<a class='dropdown-item' href='#'>도곡동</a>"+
				"<a class='dropdown-item' href='#'>개포동</a>"+
				"<a class='dropdown-item' href='#'>세곡동</a>"+
				"<a class='dropdown-item' href='#'>일원동</a>"+
				"<a class='dropdown-item' href='#'>수서동</a>"
				)
	}
	else if(gu=="강동구"){
		dong.append(
				"<a class='dropdown-item' href='#'>강일동</a>"+
				"<a class='dropdown-item' href='#'>고덕동</a>"+
				"<a class='dropdown-item' href='#'>길동</a>"+
				"<a class='dropdown-item' href='#'>둔촌동</a>"+
				"<a class='dropdown-item' href='#'>명일동</a>"+
				"<a class='dropdown-item' href='#'>상일동</a>"+
				"<a class='dropdown-item' href='#'>성내동</a>"+
				"<a class='dropdown-item' href='#'>암사동</a>"+
				"<a class='dropdown-item' href='#'>천호동</a>"		
		)
	}
	else if(gu=="강북구"){
		dong.append(
				"<a class='dropdown-item' href='#'>미아동</a>"+
				"<a class='dropdown-item' href='#'>번동</a>"+
				"<a class='dropdown-item' href='#'>삼각산동</a>"+
				"<a class='dropdown-item' href='#'>삼양동</a>"+
				"<a class='dropdown-item' href='#'>송중동</a>"+
				"<a class='dropdown-item' href='#'>송천동</a>"+
				"<a class='dropdown-item' href='#'>수유동</a>"+
				"<a class='dropdown-item' href='#'>우이동</a>"+
				"<a class='dropdown-item' href='#'>인수동</a>"		
		)
	}
	else if(gu=="강서구"){
		dong.append(
				"<a class='dropdown-item' href='#'>가양동</a>"+
				"<a class='dropdown-item' href='#'>공항동</a>"+
				"<a class='dropdown-item' href='#'>등촌동</a>"+
				"<a class='dropdown-item' href='#'>발산동</a>"+
				"<a class='dropdown-item' href='#'>방화동</a>"+
				"<a class='dropdown-item' href='#'>염창동</a>"+
				"<a class='dropdown-item' href='#'>우장산동</a>"+
				"<a class='dropdown-item' href='#'>화곡동</a>"
		)
	}
	else if(gu=="관악구"){
		dong.append(
				"<a class='dropdown-item' href='#'>낙성대동</a>"+
				"<a class='dropdown-item' href='#'>난곡동</a>"+
				"<a class='dropdown-item' href='#'>난향동</a>"+
				"<a class='dropdown-item' href='#'>남현동</a>"+
				"<a class='dropdown-item' href='#'>대학동</a>"+
				"<a class='dropdown-item' href='#'>미성동</a>"+
				"<a class='dropdown-item' href='#'>보라매동</a>"+
				"<a class='dropdown-item' href='#'>삼성동</a>"+
				"<a class='dropdown-item' href='#'>서림동</a>"+
				"<a class='dropdown-item' href='#'>서원동</a>"+
				"<a class='dropdown-item' href='#'>성현동</a>"+
				"<a class='dropdown-item' href='#'>신림동</a>"+
				"<a class='dropdown-item' href='#'>신사동</a>"+
				"<a class='dropdown-item' href='#'>신원동</a>"+
				"<a class='dropdown-item' href='#'>은천동</a>"+
				"<a class='dropdown-item' href='#'>인현동</a>"+
				"<a class='dropdown-item' href='#'>조원동</a>"+
				"<a class='dropdown-item' href='#'>중앙동</a>"+
				"<a class='dropdown-item' href='#'>청룡동</a>"+
				"<a class='dropdown-item' href='#'>청림동</a>"+
				"<a class='dropdown-item' href='#'>행운동</a>"
		)
	}
	else if(gu=="광진구"){
		dong.append(
				"<a class='dropdown-item' href='#'>광장동</a>"+
				"<a class='dropdown-item' href='#'>구의동</a>"+
				"<a class='dropdown-item' href='#'>군자동</a>"+
				"<a class='dropdown-item' href='#'>능동</a>"+
				"<a class='dropdown-item' href='#'>자양동</a>"+
				"<a class='dropdown-item' href='#'>중곡동</a>"+
				"<a class='dropdown-item' href='#'>희양동</a>"
		)
	}
	else if(gu=="구로구"){
		dong.append(
				"<a class='dropdown-item' href='#'>가리봉동</a>"+
				"<a class='dropdown-item' href='#'>개봉동</a>"+
				"<a class='dropdown-item' href='#'>고척동</a>"+
				"<a class='dropdown-item' href='#'>구로동</a>"+
				"<a class='dropdown-item' href='#'>수궁동</a>"+
				"<a class='dropdown-item' href='#'>신도림동</a>"+
				"<a class='dropdown-item' href='#'>오류동</a>"+
				"<a class='dropdown-item' href='#'>항동</a>"
		)
	}
	else if(gu=="금천구"){
		dong.append(
				"<a class='dropdown-item' href='#'>가산동</a>"+
				"<a class='dropdown-item' href='#'>독산동</a>"+
				"<a class='dropdown-item' href='#'>시흥동</a>"
		)
	}
	else if(gu=="노원구"){
		dong.append(
				"<a class='dropdown-item' href='#'>공릉동</a>"+
				"<a class='dropdown-item' href='#'>상계동</a>"+
				"<a class='dropdown-item' href='#'>월계동</a>"+
				"<a class='dropdown-item' href='#'>중계동</a>"+
				"<a class='dropdown-item' href='#'>하계동</a>"
		)
	}
	else if(gu=="도봉구"){
		dong.append(
				"<a class='dropdown-item' href='#'>도봉동</a>"+
				"<a class='dropdown-item' href='#'>방학동</a>"+
				"<a class='dropdown-item' href='#'>쌍문동</a>"+
				"<a class='dropdown-item' href='#'>창동</a>"
		)
	}
	else if(gu=="동대문구"){
		dong.append(
				"<a class='dropdown-item' href='#'>답십리동</a>"+
				"<a class='dropdown-item' href='#'>용신동</a>"+
				"<a class='dropdown-item' href='#'>이문동</a>"+
				"<a class='dropdown-item' href='#'>장안동</a>"+
				"<a class='dropdown-item' href='#'>제기동</a>"+
				"<a class='dropdown-item' href='#'>진농동</a>"+
				"<a class='dropdown-item' href='#'>청량리동</a>"+
				"<a class='dropdown-item' href='#'>회기동</a>"+
				"<a class='dropdown-item' href='#'>휘경동</a>"
		)
	}
	else if(gu=="동작구"){
		dong.append(
				"<a class='dropdown-item' href='#'>노량진동</a>"+
				"<a class='dropdown-item' href='#'>대방동</a>"+
				"<a class='dropdown-item' href='#'>사당동</a>"+
				"<a class='dropdown-item' href='#'>상도동</a>"+
				"<a class='dropdown-item' href='#'>신대방동</a>"+
				"<a class='dropdown-item' href='#'>흑석동</a>"
		)
	}
	else if(gu=="마포구"){
		dong.append(
				"<a class='dropdown-item' href='#'>공덕동</a>"+
				"<a class='dropdown-item' href='#'>대흥동</a>"+
				"<a class='dropdown-item' href='#'>도화동</a>"+
				"<a class='dropdown-item' href='#'>망원동</a>"+
				"<a class='dropdown-item' href='#'>상암동</a>"+
				"<a class='dropdown-item' href='#'>서강동</a>"+
				"<a class='dropdown-item' href='#'>성산동</a>"+
				"<a class='dropdown-item' href='#'>신수동</a>"+
				"<a class='dropdown-item' href='#'>아현동</a>"+
				"<a class='dropdown-item' href='#'>연남동</a>"+
				"<a class='dropdown-item' href='#'>염리동</a>"+
				"<a class='dropdown-item' href='#'>용강동</a>"+
				"<a class='dropdown-item' href='#'>합정동</a>"
		)
	}
	else if(gu=="서대문구"){
		dong.append(
				"<a class='dropdown-item' href='#'>남가좌동</a>"+
				"<a class='dropdown-item' href='#'>북가좌동</a>"+
				"<a class='dropdown-item' href='#'>북아현동</a>"+
				"<a class='dropdown-item' href='#'>신촌동</a>"+
				"<a class='dropdown-item' href='#'>연희동</a>"+
				"<a class='dropdown-item' href='#'>천연동</a>"+
				"<a class='dropdown-item' href='#'>충현동</a>"+
				"<a class='dropdown-item' href='#'>홍제동</a>"
		)
	}
	else if(gu=="서초구"){
		dong.append(
				"<a class='dropdown-item' href='#'>내곡동</a>"+
				"<a class='dropdown-item' href='#'>반포동</a>"+
				"<a class='dropdown-item' href='#'>방배동</a>"+
				"<a class='dropdown-item' href='#'>서초동</a>"+
				"<a class='dropdown-item' href='#'>양재동</a>"+
				"<a class='dropdown-item' href='#'>잠원동</a>"
		)
	}
	else if(gu=="성동구"){
		dong.append(
				"<a class='dropdown-item' href='#'>금호동</a>"+
				"<a class='dropdown-item' href='#'>마장동</a>"+
				"<a class='dropdown-item' href='#'>사근동</a>"+
				"<a class='dropdown-item' href='#'>성수동</a>"+
				"<a class='dropdown-item' href='#'>송정동</a>"+
				"<a class='dropdown-item' href='#'>옥수동</a>"+
				"<a class='dropdown-item' href='#'>왕십리동</a>"+
				"<a class='dropdown-item' href='#'>용답동</a>"+
				"<a class='dropdown-item' href='#'>응봉동</a>"+
				"<a class='dropdown-item' href='#'>행당동</a>"
		)
	}
	else if(gu=="성북구"){
		dong.append(
				"<a class='dropdown-item' href='#'>길음동</a>"+
				"<a class='dropdown-item' href='#'>돈암동</a>"+
				"<a class='dropdown-item' href='#'>동선동</a>"+
				"<a class='dropdown-item' href='#'>보문동</a>"+
				"<a class='dropdown-item' href='#'>삼선동</a>"+
				"<a class='dropdown-item' href='#'>석관동</a>"+
				"<a class='dropdown-item' href='#'>성북동</a>"+
				"<a class='dropdown-item' href='#'>안암동</a>"+
				"<a class='dropdown-item' href='#'>월곡동</a>"+
				"<a class='dropdown-item' href='#'>장위동</a>"+
				"<a class='dropdown-item' href='#'>정릉동</a>"+
				"<a class='dropdown-item' href='#'>종암동</a>"
		)
	}
	else if(gu=="송파구"){
		dong.append(
				"<a class='dropdown-item' href='#'>가락동</a>"+
				"<a class='dropdown-item' href='#'>거여동</a>"+
				"<a class='dropdown-item' href='#'>마천동</a>"+
				"<a class='dropdown-item' href='#'>문정동</a>"+
				"<a class='dropdown-item' href='#'>방이동</a>"+
				"<a class='dropdown-item' href='#'>삼전동</a>"+
				"<a class='dropdown-item' href='#'>석촌동</a>"+
				"<a class='dropdown-item' href='#'>송파동</a>"+
				"<a class='dropdown-item' href='#'>오륜동</a>"+
				"<a class='dropdown-item' href='#'>위례동</a>"+
				"<a class='dropdown-item' href='#'>잠실동</a>"+
				"<a class='dropdown-item' href='#'>장지동</a>"+
				"<a class='dropdown-item' href='#'>풍납동</a>"
		)
	}
	else if(gu=="양천구"){
		dong.append(
				"<a class='dropdown-item' href='#'>목동</a>"+
				"<a class='dropdown-item' href='#'>신월동</a>"+
				"<a class='dropdown-item' href='#'>신정동</a>"
		)
	}
	else if(gu=="영등포구"){
		dong.append(
				"<a class='dropdown-item' href='#'>당산동</a>"+
				"<a class='dropdown-item' href='#'>대림동</a>"+
				"<a class='dropdown-item' href='#'>도림동</a>"+
				"<a class='dropdown-item' href='#'>문래동</a>"+
				"<a class='dropdown-item' href='#'>신길동</a>"+
				"<a class='dropdown-item' href='#'>양평동</a>"+
				"<a class='dropdown-item' href='#'>여의동</a>"+
				"<a class='dropdown-item' href='#'>영등포동</a>"+
				"<a class='dropdown-item' href='#'>영등포본동</a>"
		)
	}
	else if(gu=="용산구"){
		dong.append(
				"<a class='dropdown-item' href='#'>남영동</a>"+
				"<a class='dropdown-item' href='#'>보광동</a>"+
				"<a class='dropdown-item' href='#'>서빙고동</a>"+
				"<a class='dropdown-item' href='#'>용문동</a>"+
				"<a class='dropdown-item' href='#'>용산2가동</a>"+
				"<a class='dropdown-item' href='#'>원효로동</a>"+
				"<a class='dropdown-item' href='#'>이촌동</a>"+
				"<a class='dropdown-item' href='#'>이태원동</a>"+
				"<a class='dropdown-item' href='#'>청파동</a>"+
				"<a class='dropdown-item' href='#'>한강로동</a>"+
				"<a class='dropdown-item' href='#'>한남동</a>"+
				"<a class='dropdown-item' href='#'>효창동</a>"+
				"<a class='dropdown-item' href='#'>후암동</a>"
		)
	}
	else if(gu=="은평구"){
		dong.append(
				"<a class='dropdown-item' href='#'>갈현동</a>"+
				"<a class='dropdown-item' href='#'>구산동</a>"+
				"<a class='dropdown-item' href='#'>녹번동</a>"+
				"<a class='dropdown-item' href='#'>대조동</a>"+
				"<a class='dropdown-item' href='#'>불광동</a>"+
				"<a class='dropdown-item' href='#'>수색동</a>"+
				"<a class='dropdown-item' href='#'>신사동</a>"+
				"<a class='dropdown-item' href='#'>역촌동</a>"+
				"<a class='dropdown-item' href='#'>응암동</a>"+
				"<a class='dropdown-item' href='#'>증산동</a>"+
				"<a class='dropdown-item' href='#'>진관동</a>"
		)
	}
	else if(gu=="종로구"){
		dong.append(
				"<a class='dropdown-item' href='#'>가회동</a>"+
				"<a class='dropdown-item' href='#'>교남동</a>"+
				"<a class='dropdown-item' href='#'>무악동</a>"+
				"<a class='dropdown-item' href='#'>부암동</a>"+
				"<a class='dropdown-item' href='#'>사직동</a>"+
				"<a class='dropdown-item' href='#'>삼청동</a>"+
				"<a class='dropdown-item' href='#'>숭인동</a>"+
				"<a class='dropdown-item' href='#'>이화동</a>"+
				"<a class='dropdown-item' href='#'>종로1·2·3·4가동</a>"+
				"<a class='dropdown-item' href='#'>종로5·6가동</a>"+
				"<a class='dropdown-item' href='#'>창신동</a>"+
				"<a class='dropdown-item' href='#'>청운효지동</a>"+
				"<a class='dropdown-item' href='#'>평창동</a>"+
				"<a class='dropdown-item' href='#'>혜화동</a>"
		)
	}
	else if(gu=="중구"){
		dong.append(
				"<a class='dropdown-item' href='#'>광희동</a>"+
				"<a class='dropdown-item' href='#'>다산동</a>"+
				"<a class='dropdown-item' href='#'>동화동</a>"+
				"<a class='dropdown-item' href='#'>명동</a>"+
				"<a class='dropdown-item' href='#'>소곡동</a>"+
				"<a class='dropdown-item' href='#'>신당동</a>"+
				"<a class='dropdown-item' href='#'>신당동</a>"+
				"<a class='dropdown-item' href='#'>약수동</a>"+
				"<a class='dropdown-item' href='#'>을지로동</a>"+
				"<a class='dropdown-item' href='#'>장충동</a>"+
				"<a class='dropdown-item' href='#'>중림동</a>"+
				"<a class='dropdown-item' href='#'>청구동</a>"+
				"<a class='dropdown-item' href='#'>필동</a>"+
				"<a class='dropdown-item' href='#'>황학동</a>"+
				"<a class='dropdown-item' href='#'>회현동</a>"
		)
	}
	else if(gu=="중랑구"){
		dong.append(
				"<a class='dropdown-item' href='#'>망우동</a>"+
				"<a class='dropdown-item' href='#'>면목동</a>"+
				"<a class='dropdown-item' href='#'>묵동</a>"+
				"<a class='dropdown-item' href='#'>상봉동</a>"+
				"<a class='dropdown-item' href='#'>신내동</a>"+
				"<a class='dropdown-item' href='#'>중화동</a>"
		)
	}
}
/* 드롭다운으로 지역선택 */
//구
$("#gu a").on("click", function() {
    // 드롭다운에 선택된 항목 텍스트 넣기 
    $("#selectGu").text($(this).text());
    gu = $(this).text()
    
    //구선택시 동추가
    changeDong($(this).text());
    //구선택시 첫번째 클릭
    $("#dong a")[0].click();
    //구선택시 지도변경
    gu_coordinate($(this).text());
	//알림글 변경
	$("#gu_notice").css("display","none");
	$("#dong_notice").css("display","block");
});
//동
$("#dong").on("click",".dropdown-item", function() {
    // 드롭다운에 선택된 항목 텍스트 넣기 
    $("#selectDong").text($(this).text());
   dong = $(this).text()
   
	//주소정보를 전달
	$("#location").val(gu+"_"+dong);
	//알림글 변경
	$("#gu_notice").css("display","block");
	$("#dong_notice").css("display","none");
});
// 작성/수정 페이지 진입시 지역정보 자동선택
var before_location = document.getElementById("location").value
if(before_location == ""){
}else{
	//수정
	//글자자르기
	var after_location = before_location.split("_");
	var before_gu = after_location[0]
	var before_dong = after_location[1]
	//자른글자 대입
	$("#selectGu").text(before_gu);
	$("#selectDong").text(before_dong);
	
	//구선택시 동추가
    changeDong($("#selectGu").text());
	//지도에도 표시한다
	gu_coordinate(before_gu)
};
//구선택시 지도변경 함수
function gu_coordinate(gu){
	$.ajax({
		url:"/resources/js/board/gu_coordinate.json",
		dataType:"json",
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function (data){
			for(var i in data.DATA){
				if(data.DATA[i].sig_kor_nm.toString() == gu){
					//지도 위치 재설정
					centerChange(data.DATA[i].lat,data.DATA[i].lng);
					break;
				}
			}
		}
	});
};
// 구 -> 동 선택하기 //
//스마트에디터 summernote
$(function() {
  $("#content").summernote({
	    placeholder: "내용을 입력하세요",
        height: 400,
        focus: true,
        lang : "ko-KR",
        toolbar: [
        	// [groupName, [list of button]]
        	["fontname", ["fontname"]],
        	["fontsize", ["fontsize"]],
        	["style", ["bold", "italic", "underline", "strikethrough", "clear"]],
        	["color", ["forecolor", "color"]],
        	["table", ["table"]],
        	["para", ["ul", "ol", "paragraph"]],
        	["height", ["height"]],
        	["insert", ["picture", "link", "video"]],
        	["view", ["fullscreen", "help"]]
        ],
        fontNames: ["Arial", "Arial Black", "Comic Sans MS", "Courier New", "맑은고딕", "궁서", "굴림체", "굴림", "돋움체", "바탕체"],
        fontSizes: ["8", "9", "10", "11", "12", "13", "14", "15", "16", "18", "20", "22", "24", "28", "30", "36", "50", "72"],
        	callbacks: {	//여기 부분이 이미지를 첨부하는 부분
				onImageUpload : function(files) {
					uploadSummernoteImageFile(files[0],this);
				}
			}
	});
	/**
	* 이미지 파일 업로드
	*/
	function uploadSummernoteImageFile(file, editor) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			beforeSend: function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			url : "/board/uploadSummernoteImageFile",
			contentType : false,
			processData : false,
			success : function(data) {
	        	//항상 업로드된 파일의 url이 있어야 한다.
				$(editor).summernote("insertImage", data.url);
			}
		});
	}
});
</script>