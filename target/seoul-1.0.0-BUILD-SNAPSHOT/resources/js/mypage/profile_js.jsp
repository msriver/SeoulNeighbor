<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script>
   $(document).ready(function() {
      
      // 프로필 이미지 미리보기 ///////////////////////////////////
      var sel_file;
      
       $("#uploadFile").on("change", handleImgFileSelect); //이미지가 바뀌었을때

        function handleImgFileSelect(e) {
            var files = e.target.files;
            var filesArr = Array.prototype.slice.call(files);
            
            $("#isFileChanged").val("true");
 
            filesArr.forEach(function(f) {
                if(!f.type.match("image.*")) {
                    alert("이미지 파일만 가능합니다."); //이미지 파일 검증
                    return;
                }
                
                if(f.size > 5242880){
                   alert("사이즈 초과") //이미지 사이즈 검증
                   return;
                }
 
                sel_file = f;
 
                var reader = new FileReader();
                reader.onload = function(e) {
                    $("#profileChangeImg").attr("src", e.target.result);
                    $("#fileNameContainer").empty();
                    $("#fileNameContainer").append("<input type=hidden name='member_filename' value='"+f.name+"'/>");
                }
                reader.readAsDataURL(f);
            });
        }
      // 프로필 이미지 미리보기 //
      
      // 닉네임 중복 검증 //////////////////////////
      $("#nickName-duplicated-text").hide();
      $("#nickName-wrong-text").hide();
      var orginalNickName = $("#nickName").val();
      var nickNameValid = true;
      var regExp = /^[\wㄱ-ㅎㅏ-ㅣ가-힣0-9a-zA-Z]{2,10}$/;
      
      
      $("#nickName").on("propertychange change keyup paste",function(){
          var nameStatus;
          var nickNameVal = $("#nickName").val();
          
          if (nickNameVal.match(regExp) != null) {
              nickNameValid = true;
              $("#nickName-wrong-text").hide();
          }
          else {
              nickNameValid = false;
              $("#nickName-wrong-text").show();
          }
          if(orginalNickName == nickNameVal){
             $("#nickName-duplicated-text").hide();
             nickNameValid = true;
          }
          
          if(orginalNickName != nickNameVal){
             $.ajax({
                url: "/checkNickName/" + nickNameVal,
                type: "GET",
                dataType: "text",
                success: function(result, status, xhr){
                   nameStatus = result;
                   if(nameStatus == 'duplicated'){
                       $("#nickName-duplicated-text").show();
                       nickNameValid = false;
                    } else {
                       $("#nickName-duplicated-text").hide();
                       nickNameValid = true;
                    }
                }
             });
          }
      })
      
      // 닉네임 중복 검증 //
      
      // 구 -> 동 선택하기 /////////////////////////////////////
      guValid = true;
      function changeDong(gu){ //구가 바뀔때 동 옵션값 바뀌는 함수
         var dong = $("#selectDong");
         
         dong.empty();
         if(gu=="강남구"){
            dong.append(
                  "<option>신사동</option>"+
                  "<option>논현동</option>"+
                  "<option>압구정동</option>"+
                  "<option>청담동</option>"+
                  "<option>삼성동</option>"+
                  "<option>대치동</option>"+
                  "<option>역삼동</option>"+
                  "<option>도곡동</option>"+
                  "<option>개포동</option>"+
                  "<option>세곡동</option>"+
                  "<option>일원동</option>"+
                  "<option>수서동</option>"
                  )
                  guValid = true;
         }
         else if(gu=="강동구"){
            dong.append(
                  "<option>강일동</option>"+
                  "<option>고덕동</option>"+
                  "<option>길동</option>"+
                  "<option>둔촌동</option>"+
                  "<option>명일동</option>"+
                  "<option>상일동</option>"+
                  "<option>성내동</option>"+
                  "<option>암사동</option>"+
                  "<option>천호동</option>"      
            )
         }
         else if(gu=="강북구"){
            dong.append(
                  "<option>미아동</option>"+
                  "<option>번동</option>"+
                  "<option>삼각산동</option>"+
                  "<option>삼양동</option>"+
                  "<option>송중동</option>"+
                  "<option>송천동</option>"+
                  "<option>수유동</option>"+
                  "<option>우이동</option>"+
                  "<option>인수동</option>"         
            )
            guValid = true;
         }
         else if(gu=="강서구"){
            dong.append(
                  "<option>가양동</option>"+
                  "<option>공항동</option>"+
                  "<option>등촌동</option>"+
                  "<option>발산동</option>"+
                  "<option>방화동</option>"+
                  "<option>염창동</option>"+
                  "<option>우장산동</option>"+
                  "<option>화곡동</option>"
            )
            guValid = true;
         }
         else if(gu=="관악구"){
            dong.append(
                  "<option>낙성대동</option>"+
                  "<option>난곡동</option>"+
                  "<option>난향동</option>"+
                  "<option>남현동</option>"+
                  "<option>대학동</option>"+
                  "<option>미성동</option>"+
                  "<option>보라매동</option>"+
                  "<option>삼성동</option>"+
                  "<option>서림동</option>"+
                  "<option>서원동</option>"+
                  "<option>성현동</option>"+
                  "<option>신림동</option>"+
                  "<option>신사동</option>"+
                  "<option>신원동</option>"+
                  "<option>은천동</option>"+
                  "<option>인현동</option>"+
                  "<option>조원동</option>"+
                  "<option>중앙동</option>"+
                  "<option>청룡동</option>"+
                  "<option>청림동</option>"+
                  "<option>행운동</option>"
            )
            guValid = true;
         }
         else if(gu=="광진구"){
            dong.append(
                  "<option>광장동</option>"+
                  "<option>구의동</option>"+
                  "<option>군자동</option>"+
                  "<option>능동</option>"+
                  "<option>자양동</option>"+
                  "<option>중곡동</option>"+
                  "<option>희양동</option>"
            )
            guValid = true;
         }
         else if(gu=="구로구"){
            dong.append(
                  "<option>가리봉동</option>"+
                  "<option>개봉동</option>"+
                  "<option>고척동</option>"+
                  "<option>구로동</option>"+
                  "<option>수궁동</option>"+
                  "<option>신도림동</option>"+
                  "<option>오류동</option>"+
                  "<option>항동</option>"
            )
            guValid = true;
         }
         else if(gu=="금천구"){
            dong.append(
                  "<option>가산동</option>"+
                  "<option>독산동</option>"+
                  "<option>시흥동</option>"
            )
            guValid = true;
         }
         else if(gu=="노원구"){
            dong.append(
                  "<option>공릉동</option>"+
                  "<option>상계동</option>"+
                  "<option>월계동</option>"+
                  "<option>중계동</option>"+
                  "<option>하계동</option>"
            )
            guValid = true;
         }
         else if(gu=="도봉구"){
            dong.append(
                  "<option>도봉동</option>"+
                  "<option>방학동</option>"+
                  "<option>쌍문동</option>"+
                  "<option>창동</option>"
            )
            guValid = true;
         }
         else if(gu=="동대문구"){
            dong.append(
                  "<option>답십리동</option>"+
                  "<option>용신동</option>"+
                  "<option>이문동</option>"+
                  "<option>장안동</option>"+
                  "<option>제기동</option>"+
                  "<option>진농동</option>"+
                  "<option>청량리동</option>"+
                  "<option>회기동</option>"+
                  "<option>휘경동</option>"
            )
            guValid = true;
         }
         else if(gu=="동작구"){
            dong.append(
                  "<option>노량진동</option>"+
                  "<option>대방동</option>"+
                  "<option>사당동</option>"+
                  "<option>상도동</option>"+
                  "<option>신대방동</option>"+
                  "<option>흑석동</option>"
            )
            guValid = true;
         }
         else if(gu=="마포구"){
            dong.append(
                  "<option>공덕동</option>"+
                  "<option>대흥동</option>"+
                  "<option>도화동</option>"+
                  "<option>망원동</option>"+
                  "<option>상암동</option>"+
                  "<option>서강동</option>"+
                  "<option>성산동</option>"+
                  "<option>신수동</option>"+
                  "<option>아현동</option>"+
                  "<option>연남동</option>"+
                  "<option>염리동</option>"+
                  "<option>용강동</option>"+
                  "<option>합정동</option>"
            )
            guValid = true;
         }
         else if(gu=="서대문구"){
            dong.append(
                  "<option>남가좌동</option>"+
                  "<option>북가좌동</option>"+
                  "<option>북아현동</option>"+
                  "<option>신촌동</option>"+
                  "<option>연희동</option>"+
                  "<option>천연동</option>"+
                  "<option>충현동</option>"+
                  "<option>홍제동</option>"
            )
            guValid = true;
         }
         else if(gu=="서초구"){
            dong.append(
                  "<option>내곡동</option>"+
                  "<option>반포동</option>"+
                  "<option>방배동</option>"+
                  "<option>서초동</option>"+
                  "<option>양재동</option>"+
                  "<option>잠원동</option>"
            )
            guValid = true;
         }
         else if(gu=="성동구"){
            dong.append(
                  "<option>금호동</option>"+
                  "<option>마장동</option>"+
                  "<option>사근동</option>"+
                  "<option>성수동</option>"+
                  "<option>송정동</option>"+
                  "<option>옥수동</option>"+
                  "<option>왕십리동</option>"+
                  "<option>용답동</option>"+
                  "<option>응봉동</option>"+
                  "<option>행당동</option>"
            )
            guValid = true;
         }
         else if(gu=="성북구"){
            dong.append(
                  "<option>길음동</option>"+
                  "<option>돈암동</option>"+
                  "<option>동선동</option>"+
                  "<option>보문동</option>"+
                  "<option>삼선동</option>"+
                  "<option>석관동</option>"+
                  "<option>성북동</option>"+
                  "<option>안암동</option>"+
                  "<option>월곡동</option>"+
                  "<option>장위동</option>"+
                  "<option>정릉동</option>"+
                  "<option>종암동</option>"
            )
            guValid = true;
         }
         else if(gu=="송파구"){
            dong.append(
                  "<option>가락동</option>"+
                  "<option>거여동</option>"+
                  "<option>마천동</option>"+
                  "<option>문정동</option>"+
                  "<option>방이동</option>"+
                  "<option>삼전동</option>"+
                  "<option>석촌동</option>"+
                  "<option>송파동</option>"+
                  "<option>오륜동</option>"+
                  "<option>위례동</option>"+
                  "<option>잠실동</option>"+
                  "<option>장지동</option>"+
                  "<option>풍납동</option>"
            )
            guValid = true;
         }
         else if(gu=="양천구"){
            dong.append(
                  "<option>목동</option>"+
                  "<option>신월동</option>"+
                  "<option>신정동</option>"
            )
            guValid = true;
         }
         else if(gu=="영등포구"){
            dong.append(
                  "<option>당산동</option>"+
                  "<option>대림동</option>"+
                  "<option>도림동</option>"+
                  "<option>문래동</option>"+
                  "<option>신길동</option>"+
                  "<option>양평동</option>"+
                  "<option>여의동</option>"+
                  "<option>영등포동</option>"+
                  "<option>영등포본동</option>"
            )
            guValid = true;
         }
         else if(gu=="용산구"){
            dong.append(
                  "<option>남영동</option>"+
                  "<option>보광동</option>"+
                  "<option>서빙고동</option>"+
                  "<option>용문동</option>"+
                  "<option>용산2가동</option>"+
                  "<option>원효로동</option>"+
                  "<option>이촌동</option>"+
                  "<option>이태원동</option>"+
                  "<option>청파동</option>"+
                  "<option>한강로동</option>"+
                  "<option>한남동</option>"+
                  "<option>효창동</option>"+
                  "<option>후암동</option>"
            )
            guValid = true;
         }
         else if(gu=="은평구"){
            dong.append(
                  "<option>갈현동</option>"+
                  "<option>구산동</option>"+
                  "<option>녹번동</option>"+
                  "<option>대조동</option>"+
                  "<option>불광동</option>"+
                  "<option>수색동</option>"+
                  "<option>신사동</option>"+
                  "<option>역촌동</option>"+
                  "<option>응암동</option>"+
                  "<option>증산동</option>"+
                  "<option>진관동</option>"
            )
            guValid = true;
         }
         else if(gu=="종로구"){
            dong.append(
                  "<option>가회동</option>"+
                  "<option>교남동</option>"+
                  "<option>무악동</option>"+
                  "<option>부암동</option>"+
                  "<option>사직동</option>"+
                  "<option>삼청동</option>"+
                  "<option>숭인동</option>"+
                  "<option>이화동</option>"+
                  "<option>종로1·2·3·4가동</option>"+
                  "<option>종로5·6가동</option>"+
                  "<option>창신동</option>"+
                  "<option>청운효지동</option>"+
                  "<option>평창동</option>"+
                  "<option>혜화동</option>"
            )
            guValid = true;
         }
         else if(gu=="중구"){
            dong.append(
                  "<option>광희동</option>"+
                  "<option>다산동</option>"+
                  "<option>동화동</option>"+
                  "<option>명동</option>"+
                  "<option>소곡동</option>"+
                  "<option>신당동</option>"+
                  "<option>신당동</option>"+
                  "<option>약수동</option>"+
                  "<option>을지로동</option>"+
                  "<option>장충동</option>"+
                  "<option>중림동</option>"+
                  "<option>청구동</option>"+
                  "<option>필동</option>"+
                  "<option>황학동</option>"+
                  "<option>회현동</option>"
            )
            guValid = true;
         }
         else if(gu=="중랑구"){
            dong.append(
                  "<option>망우동</option>"+
                  "<option>면목동</option>"+
                  "<option>묵동</option>"+
                  "<option>상봉동</option>"+
                  "<option>신내동</option>"+
                  "<option>중화동</option>"
            )
            guValid = true;
         }
         else{
            alert("서울지역을 선택해주세요");
            dong.append("<option></option>");
            guValid = false;
         }
      }
      
      function changeGu(gu,dong){
         $("#selectGu").val(gu);
         $("#selectDong").val(dong);
         if($("#selectDong").val() == null){
            $("#selectDong").append("<option>"+dong+"</option>")
            $("#selectDong").val(dong);
         }
      }
      
      var location = "${member.member_location}"; //기본 값 선택
      var locationArr = location.split("_");
       $("#member_location").empty();
      $("#member_location").append("<input type='hidden' name='member_location' value='"+locationArr[0]+"_"+locationArr[1]+"' />");   
      changeDong(locationArr[0]);
      changeGu(locationArr[0],locationArr[1]);
      
      $("#selectGu").change(function(){ // 구 바뀜
         gu = $("#selectGu option:selected");
         changeDong(gu.val());
         dong = $("#selectDong option:selected");   
         $("#member_location").empty();
         $("#member_location").append("<input type='hidden' name='member_location' value='"+gu.val()+"_"+dong.val()+"' />");   
      })
      
      $("#selectDong").change(function(){ // 동 바뀜
         gu = $("#selectGu option:selected");
         dong = $("#selectDong option:selected");
         $("#member_location").empty();
         $("#member_location").append("<input type='hidden' name='member_location' value='"+gu.val()+"_"+dong.val()+"' />");      
      })
      // 구 -> 동 선택하기 //
      
      // 카카오 주소 검색 ///////////////////////////////////////////
      $("#searchPost").on("click",function(){
           new daum.Postcode({
               oncomplete: function(data) {
                   gu = data.sigungu; // 구
               dong = data.bname; // 동
                   
                   // 주소 정보를 해당 필드에 넣는다.
                   changeDong(gu);
                   $("#selectGu").val(gu).attr("seleceted","seleceted");
                   $("#selectDong").append("<option>"+dong+"</option>");
                   $("#selectDong").val(dong).attr("seleceted","seleceted");
                $("#member_location").empty();
                $("#member_location").append("<input type='hidden' name='member_location' value='"+gu+"_"+dong+"' />");   
               }
           }).open();
      })
      // 카카오 주소 검색 //
      
      // 변경사항 저장 버튼 클릭 /////////////////////////////////
      $("#saveChangeBtn").on("click",function(e){
         e.preventDefault();
         if(nickNameValid == true && guValid == true){
            profileForm.submit();
         }
         else if(nickNameValid == false){
            alert("닉네임을 확인해주세요");
         }
         else if(guValid == false){
            alert("서울지역을 선택해주세요");
         }
      })
      // 변경사항 저장 버튼 클릭 //
   });
</script>