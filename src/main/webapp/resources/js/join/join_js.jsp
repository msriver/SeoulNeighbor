<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	$(document).ready(function(){
		//최종적으로 submit 하기 위해 점검 변수(클라이언트측 입력형식 검증)
		var id, email, pw, name, location;
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		var isEmailDuplicated = true; //이메일 주소가 중복되었는가? 중복이다 = true || 중복아니다 = false
		var isSendEmail = false; // 이메일로 인증번호 발송 여부 체크
		var isEmailCompleted = false // 이메일 인증이 완료되었는가? 완료 = true || 노완료 = false
				
				
		//의도치 않은 백스페이스 이벤트 방지
		$(document).keydown(function(e) {
	        if(e.target.nodeName != "INPUT"){
	            if(e.keyCode == 8){
	                return false;
	           }
	        }
	 
	        if(e.target.readOnly){ // readonly일 경우 true
	            if(e.keyCode == 8){
	                return false;
	           }
	        }
	    });
		
		
		//아이디 입력 검증
		verifyID = function () {
		    
		    var userIDVal = $("#userId").val();
		    var regExp = /^[0-9a-z]{5,20}$/;
		    
		    if (userIDVal.match(regExp) != null) {
		    	$("#userId-wrong-text").removeClass("wrong-text-show");
			    $("#userId").parent().removeClass("wrong-input");
		        id = true; //아이디가 형식에 맞게 작성이 되있음
		    }
		    else {
		        $("#userId").parent().addClass("wrong-input");
		        $("#userId-wrong-text").addClass("wrong-text-show");
		        id = false; //아이디가 형식에 맞지 않음
		    }
		    
		    //id가 형식에 맞다면 ajax로 중복된 값인지 체크
		    if(id){
		    	var idStatus;
		    	$.ajax({
		    		url: "/checkId/" + userIDVal,
		    		type: "GET",
		    		dataType: "text",
		    		success: function(result, status, xhr){
		    			idStatus = result;
		    			if(idStatus == 'duplicated'){
		    	    		$("#userId").parent().addClass("wrong-input");
		    	    		$("#userId-duplicated-text").addClass("wrong-text-show");
		    	    	} else {
		    	    		$("#userId-duplicated-text").removeClass("wrong-text-show");
		    	    	}
		    		}
		    	});
		    }
		}
		
		// 닉네임 입력 검증
		verifyNickName = function () {

		    var nickNameVal = $("#nickName").val();
		    var regExp = /^[\wㄱ-ㅎㅏ-ㅣ가-힣0-9a-zA-Z]{2,10}$/;
		    
		    if (nickNameVal.match(regExp) != null) {
		    	$("#nickName-wrong-text").removeClass("wrong-text-show");
			    $("#nickName").parent().removeClass("wrong-input");
		        name = true;
		    }
		    else {
		        $("#nickName").parent().addClass("wrong-input");
		        $("#nickName-wrong-text").addClass("wrong-text-show");
		        name = false;
		    }
		    
		  //닉네임이 형식에 맞다면 ajax로 중복된 값인지 체크
		    if(name){
		    	var nameStatus;
		    	$.ajax({
		    		url: "/checkNickName/" + nickNameVal,
		    		type: "GET",
		    		dataType: "text",
		    		success: function(result, status, xhr){
		    			nameStatus = result;
		    			if(nameStatus == 'duplicated'){
		    	    		$("#nickName").parent().addClass("wrong-input");
		    	    		$("#nickName-duplicated-text").addClass("wrong-text-show");
		    	    	} else {
		    	    		$("#nickName-duplicated-text").removeClass("wrong-text-show");
		    	    	}
		    		}
		    	});
		    }
		}
		
		// 이메일 검증 스크립트 작성
		verifyEmail = function () {
		    
		    var emailVal = $("#email").val();
		    var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		    
		    if (emailVal.match(regExp) != null) {
		    	$("#email-wrong-text").removeClass("wrong-text-show");
			    $("#email").parent().removeClass("wrong-input");
		        email = true;
		    }
		    else {
		        $("#email").parent().addClass("wrong-input");
		        $("#email-wrong-text").addClass("wrong-text-show");
		        email = false;
		    }
		    
		  //이메일이 형식에 맞다면 ajax로 중복된 값인지 체크
		    if(email){
		    	var emailStatus;
		    	$.ajax({
		    		url: "/checkEmail",
		    		type: "GET",
		    		beforeSend: function(xhr){
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
					},
		    		data: {'email' : emailVal},
		    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		    		dataType: "text",
		    		success: function(result, status, xhr){
		    			emailStatus = result;
		    			if(emailStatus == 'duplicated'){
		    	    		isEmailDuplicated = true;
		    	    		$("#email").parent().addClass("wrong-input");
		    	    		$("#email-duplicated-text").addClass("wrong-text-show");
		    	    	} else {
		    	    		$("#email-duplicated-text").removeClass("wrong-text-show");
		    	    		isEmailDuplicated = false;
		    	    	}
		    		}
		    	});
		    }
		}
		
		//이메일 인증번호전송 버튼을 눌렀을 때
		$("#emailSend").on("click",function(e){
			e.preventDefault();
			verifyEmail();
			
			var toSend = $("#email").val();
			var temp = "";
			
			temp += '<div id="emailAuthContainer" class="wrap-input email-wrap-input validate-input" style="margin-top: 10px;">';
	   		temp += '	<input id="emailAuthInput" name="emailAuth" type="text" class="input-text" placeholder="이메일로 인증번호가 발송되었습니다.">';
	   		temp += '	<button id="emailAuthBtn" type="button" class="button-colored email-button">인증</button>';
	   		temp += '	<input id="originEmailNum" type="hidden" value="">';
	   		temp += '</div>';
	   		temp += '<p id="auth-wrong-text" class="wrong-text">인증실패! 인증번호를 다시 확인해주세요.</p>';
	   		
			if(email && !isEmailDuplicated){
				$("#email-input-group").append(temp);
				$("#email").attr("readonly", true);
				$("#emailSend").off("click");
				$("#certification-not-text").removeClass("wrong-text-show");
				$.ajax({
					url: "/sendAuthMail",
					type: "GET",
					data: {
						'email' : toSend
					},
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					dataType: "text",
					success: function(result, status, xhr){
		    			$("#originEmailNum").val(result);
		    			isSendEmail = true;
		    		}
				});
			}
		});
		
		
		//사용자가 자신 이메일에 발송된 인증번호를 입력하고 인증 버튼을 누를 시
		$("#email-input-group").delegate("#emailAuthBtn", "click", function(e){
			e.preventDefault();
			var userNumber = $("#emailAuthInput").val(); //사용자가 입력한 인증번호
			var originNumber = $("#originEmailNum").val(); //서버에서 넘겨받은 인증번호 정답
			
			var dataForCompare = {"userNumber" : userNumber, "originNumber" : originNumber};
			
			if(userNumber){
				$.ajax({
					url: "/compareEmailAuth",
					type: "POST",
					beforeSend: function(xhr){
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
					},
					data: JSON.stringify(dataForCompare),
					dataType: "text", //서버에서 클라이언트로 받는 타입
					contentType: "application/json", //서버로 전송할 타입
					success: function(result){
						if(result === 'same'){
							$("#email-input-group").undelegate("#emailAuthBtn", "click");
							$("#auth-wrong-text").removeClass("wrong-text-show");
							$("#email-input-group").append("<p class='nice-text'>*인증이 정상적으로 완료되었습니다.</p>");
							$("#emailAuthInput").attr("readonly", true);
							isEmailCompleted = true;
						} else if(result === 'different'){
							$("#auth-wrong-text").addClass("wrong-text-show");
						}
					}
				});
			} else {
				$("#auth-wrong-text").addClass("wrong-text-show");
			}
		});
		
		
		verifyEmailCertification = function() {
			if(!isSendEmail || !isEmailCompleted){
		        $("#certification-not-text").addClass("wrong-text-show");
			} else {
				$("#certification-not-text").removeClass("wrong-text-show");
			}
		}
		
		// 비밀번호 검증 스크립트 작성
		var pwVerifyOk = false; // 비밀번호 확인용
		verifyPW = function () {
		    var pwVal = $("#pw").val();
		    var regExp = /^.*(?=^.{6,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

		    if (pwVal.match(regExp) != null) {
		        $("#pw").parent().removeClass("wrong-input");
		        $("#pw-wrong-text").removeClass("wrong-text-show");
		        pwVerifyOk=true;
		    }
		    else {
		        $("#pw").parent().addClass("wrong-input");
		        $("#pw-wrong-text").addClass("wrong-text-show");
		        pwVerifyOk=false;
		    }
		}

		// 비밀번호 확인 검증 스크립트 작성
		verifyPWcheck = function () {
		    
		    var pwVal = $("#pw").val();
		    var pwCheck = $("#pwcheck").val();

		    if (pwVerifyOk&&pwVal == pwCheck) {
		        $("#pwcheck").parent().removeClass("wrong-input");
		        $("#pwc-wrong-text").removeClass("wrong-text-show");
		        pw = true;
		    }
		    else {
		        $("#pwcheck").parent().addClass("wrong-input");
		        $("#pwc-wrong-text").addClass("wrong-text-show");
		        pw = false;
		    }
		}
		
		// 지역선택 검증 스크립트
		verifyLocation = function () {
		    
		    var locationVal = $("#memberLocation").val();
		    var locationCheck = locationVal.trim().split("_")[0];

		    if (locationVal && locationCheck != '-1') {
		        $("#memberLocation").parent().removeClass("wrong-input");
		        $("#location-wrong-text").removeClass("wrong-text-show");
		        location = true;
		    }
		    else {
		        $("#memberLocation").parent().addClass("wrong-input");
		        $("#location-wrong-text").addClass("wrong-text-show");
		        location = false;
		    }
		}
		
		$("#selectGu").change(function(){ // 구 바뀜
			gu = $("#selectGu option:selected");
			changeDong(gu.val());
			dong = $("#selectDong option:selected");
			$("#memberLocation").val(gu.val()+"_"+dong.val());	
		})
		
		$("#selectDong").change(function(){ // 동 바뀜
			gu = $("#selectGu option:selected");
			dong = $("#selectDong option:selected");
			$("#memberLocation").val(gu.val()+"_"+dong.val());		
		})
		
		function changeDong(selectGu){ //구가 바뀔때 동 옵션값 바뀌는 함수
			var selectDong = $("#selectDong");
			
			selectDong.empty();
			if(selectGu=="강남구"){
				selectDong.append(
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
			}
			else if(selectGu=="강동구"){
				selectDong.append(
						"<option>강일동</option>"+
						"<option>상일동</option>"+
						"<option>명일동</option>"+
						"<option>고덕동</option>"+
						"<option>암사동</option>"+
						"<option>천호동</option>"+
						"<option>성내동</option>"+
						"<option>길동</option>"+
						"<option>둔촌동</option>"		
				)
			}
			else if(selectGu=="강북구"){
				selectDong.append(
						"<option>삼양동</option>"+
						"<option>미아동</option>"+
						"<option>송중동</option>"+
						"<option>송천동</option>"+
						"<option>삼각산동</option>"+
						"<option>번동</option>"+
						"<option>수유동</option>"+
						"<option>우이동</option>"+
						"<option>인수동</option>"		
				)
			}
			else if(selectGu=="강서구"){
				selectDong.append(
						"<option>염창동</option>"+
						"<option>등촌동</option>"+
						"<option>화곡동</option>"+
						"<option>우장산동</option>"+
						"<option>가양동</option>"+
						"<option>발산동</option>"+
						"<option>공항동</option>"+
						"<option>방화동</option>"
				)
			}
			else if(selectGu=="관악구"){
				selectDong.append(
						"<option>보라매동</option>"+
						"<option>청림동</option>"+
						"<option>행운동</option>"+
						"<option>낙성대동</option>"+
						"<option>중앙동</option>"+
						"<option>인현동</option>"+
						"<option>남현동</option>"+
						"<option>서원동</option>"+
						"<option>신원동</option>"+
						"<option>서림동</option>"+
						"<option>신사동</option>"+
						"<option>신림동</option>"+
						"<option>난향동</option>"+
						"<option>조원동</option>"+
						"<option>대학동</option>"+
						"<option>은천동</option>"+
						"<option>성현동</option>"+
						"<option>청룡동</option>"+
						"<option>난곡동</option>"+
						"<option>삼성동</option>"+
						"<option>미성동</option>"
				)
			}
			else if(selectGu=="광진구"){
				selectDong.append(
						"<option>중곡동</option>"+
						"<option>능동</option>"+
						"<option>구의동</option>"+
						"<option>광장동</option>"+
						"<option>자양동</option>"+
						"<option>희양동</option>"+
						"<option>군자동</option>"
				)
			}
			else if(selectGu=="구로구"){
				selectDong.append(
						"<option>신도림동</option>"+
						"<option>구로동</option>"+
						"<option>가리봉동</option>"+
						"<option>고척동</option>"+
						"<option>개봉동</option>"+
						"<option>오류동</option>"+
						"<option>항동</option>"+
						"<option>수궁동</option>"
				)
			}
			else if(selectGu=="금천구"){
				selectDong.append(
						"<option>가산동</option>"+
						"<option>독산동</option>"+
						"<option>시흥동</option>"
				)
			}
			else if(selectGu=="노원구"){
				selectDong.append(
						"<option>월계동</option>"+
						"<option>공릉동</option>"+
						"<option>하계동</option>"+
						"<option>중계동</option>"+
						"<option>상계동</option>"
				)
			}
			else if(selectGu=="도봉구"){
				selectDong.append(
						"<option>쌍문동</option>"+
						"<option>방학동</option>"+
						"<option>창동</option>"+
						"<option>도봉동</option>"
				)
			}
			else if(selectGu=="동대문구"){
				selectDong.append(
						"<option>용신동</option>"+
						"<option>제기동</option>"+
						"<option>진농동</option>"+
						"<option>답십리동</option>"+
						"<option>장안동</option>"+
						"<option>청량리동</option>"+
						"<option>회기동</option>"+
						"<option>휘경동</option>"+
						"<option>이문동</option>"
				)
			}
			else if(selectGu=="동작구"){
				selectDong.append(
						"<option>노량진동</option>"+
						"<option>상도동</option>"+
						"<option>흑석동</option>"+
						"<option>사당동</option>"+
						"<option>대방동</option>"+
						"<option>신대방동</option>"
				)
			}
			else if(selectGu=="마포구"){
				selectDong.append(
						"<option>공덕동</option>"+
						"<option>아현동</option>"+
						"<option>도화동</option>"+
						"<option>용강동</option>"+
						"<option>대흥동</option>"+
						"<option>염리동</option>"+
						"<option>신수동</option>"+
						"<option>서강동</option>"+
						"<option>합정동</option>"+
						"<option>망원동</option>"+
						"<option>연남동</option>"+
						"<option>성산동</option>"+
						"<option>상암동</option>"
				)
			}
			else if(selectGu=="서대문구"){
				selectDong.append(
						"<option>충현동</option>"+
						"<option>천연동</option>"+
						"<option>북아현동</option>"+
						"<option>신촌동</option>"+
						"<option>연희동</option>"+
						"<option>홍제동</option>"+
						"<option>남가좌동</option>"+
						"<option>북가좌동</option>"
				)
			}
			else if(selectGu=="서초구"){
				selectDong.append(
						"<option>서초동</option>"+
						"<option>잠원동</option>"+
						"<option>반포동</option>"+
						"<option>방배동</option>"+
						"<option>양재동</option>"+
						"<option>내곡동</option>"
				)
			}
			else if(selectGu=="성동구"){
				selectDong.append(
						"<option>왕십리동</option>"+
						"<option>마장동</option>"+
						"<option>사근동</option>"+
						"<option>행당동</option>"+
						"<option>응봉동</option>"+
						"<option>금호동</option>"+
						"<option>성수동</option>"+
						"<option>송정동</option>"+
						"<option>용답동</option>"+
						"<option>옥수동</option>"
				)
			}
			else if(selectGu=="성북구"){
				selectDong.append(
						"<option>성북동</option>"+
						"<option>삼선동</option>"+
						"<option>동선동</option>"+
						"<option>돈암동</option>"+
						"<option>안암동</option>"+
						"<option>보문동</option>"+
						"<option>정릉동</option>"+
						"<option>길음동</option>"+
						"<option>종암동</option>"+
						"<option>월곡동</option>"+
						"<option>장위동</option>"+
						"<option>석관동</option>"
				)
			}
			else if(selectGu=="송파구"){
				selectDong.append(
						"<option>풍납동</option>"+
						"<option>거여동</option>"+
						"<option>마천동</option>"+
						"<option>방이동</option>"+
						"<option>오륜동</option>"+
						"<option>송파동</option>"+
						"<option>석촌동</option>"+
						"<option>삼전동</option>"+
						"<option>가락동</option>"+
						"<option>문정동</option>"+
						"<option>장지동</option>"+
						"<option>위례동</option>"+
						"<option>잠실동</option>"
				)
			}
			else if(selectGu=="양천구"){
				selectDong.append(
						"<option>목동</option>"+
						"<option>신월동</option>"+
						"<option>신정동</option>"
				)
			}
			else if(selectGu=="영등포구"){
				selectDong.append(
						"<option>영등포동</option>"+
						"<option>영등포본동</option>"+
						"<option>당산동</option>"+
						"<option>여의동</option>"+
						"<option>문래동</option>"+
						"<option>양평동</option>"+
						"<option>신길동</option>"+
						"<option>대림동</option>"+
						"<option>도림동</option>"
				)
			}
			else if(selectGu=="용산구"){
				selectDong.append(
						"<option>후암동</option>"+
						"<option>용산2가동</option>"+
						"<option>남영동</option>"+
						"<option>청파동</option>"+
						"<option>원효로동</option>"+
						"<option>효창동</option>"+
						"<option>용문동</option>"+
						"<option>한강로동</option>"+
						"<option>이촌동</option>"+
						"<option>이태원동</option>"+
						"<option>한남동</option>"+
						"<option>서빙고동</option>"+
						"<option>보광동</option>"
				)
			}
			else if(selectGu=="은평구"){
				selectDong.append(
						"<option>녹번동</option>"+
						"<option>불광동</option>"+
						"<option>갈현동</option>"+
						"<option>구산동</option>"+
						"<option>대조동</option>"+
						"<option>응암동</option>"+
						"<option>역촌동</option>"+
						"<option>신사동</option>"+
						"<option>증산동</option>"+
						"<option>수색동</option>"+
						"<option>진관동</option>"
				)
			}
			else if(selectGu=="종로구"){
				selectDong.append(
						"<option>청운효지동</option>"+
						"<option>사직동</option>"+
						"<option>삼청동</option>"+
						"<option>부암동</option>"+
						"<option>평창동</option>"+
						"<option>무악동</option>"+
						"<option>교남동</option>"+
						"<option>가회동</option>"+
						"<option>종로1·2·3·4가동</option>"+
						"<option>종로5·6가동</option>"+
						"<option>이화동</option>"+
						"<option>창신동</option>"+
						"<option>숭인동</option>"+
						"<option>혜화동</option>"
				)
			}
			else if(selectGu=="중구"){
				selectDong.append(
						"<option>소곡동</option>"+
						"<option>회현동</option>"+
						"<option>명동</option>"+
						"<option>필동</option>"+
						"<option>장충동</option>"+
						"<option>광희동</option>"+
						"<option>을지로동</option>"+
						"<option>신당동</option>"+
						"<option>다산동</option>"+
						"<option>약수동</option>"+
						"<option>청구동</option>"+
						"<option>신당동</option>"+
						"<option>동화동</option>"+
						"<option>황학동</option>"+
						"<option>중림동</option>"
				)
			}
			else if(selectGu=="중랑구"){
				selectDong.append(
						"<option>면목동</option>"+
						"<option>상봉동</option>"+
						"<option>중화동</option>"+
						"<option>묵동</option>"+
						"<option>망우동</option>"+
						"<option>신내동</option>"
				)
			}
		}

		
		
		
		$("#submit-btn").click(function(e){
			e.preventDefault();
			verifyID()
		    verifyEmail();
			verifyNickName();
		    verifyPW();
		    verifyPWcheck();
		    verifyLocation();
		    verifyEmailCertification();
		    if(email && pw && pwVerifyOk && name && location && isSendEmail && isEmailCompleted){
		        $("#joinForm").submit();
		    }
		})
		
	})
</script>