<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	// 변경 할 비밀번호 일치 여부 확인 //////////////////////////////
	var correct = false;
	
	$("#changePassword").on("propertychange change keyup paste",function(){
		if($("#changePasswordCheck").val()==$("#changePassword").val() && $("#changePasswordCheck").val().length >0 && $("#changePassword").val().length >0){
			$("#showCompareResult").text("일치합니다.").css("color","green");
			correct = true;
		}
		else{
			$("#showCompareResult").text("비밀번호를 확인해주세요.").css("color","red");
			correct = false;
		}
		verifyPW();
	})
	
	$("#changePasswordCheck").on("propertychange change keyup paste",function(){
		if($("#changePasswordCheck").val()==$("#changePassword").val() && $("#changePasswordCheck").val().length >0 && $("#changePassword").val().length >0){
			$("#showCompareResult").text("일치합니다.").css("color","green");
			correct = true;
		}
		else if($("#changePassword").val()==""){
			$("#showVerifyResult").text("");
			$("#showCompareResult").text("");
			correct = false;
		}
		else{
			$("#showCompareResult").text("비밀번호를 확인해주세요.").css("color","red");
			correct = false;
		}
	})
	var pwVerifyOk = false; // 비밀번호 확인용
	function verifyPW() {
	    var pwVal = $("#changePassword").val();
	    var regExp = /^.*(?=^.{6,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

	    if (pwVal.match(regExp) != null) {
	    	$("#showVerifyResult").text("");
	    	pwVerifyOk = true;
	    }
	    else {
	    	$("#showVerifyResult").text("비밀번호(영문 숫자 특수문자 섞어서 6~15자 이내)").css("color","red");
	    	pwVerifyOk= false;
	    }
	}
	// 변경 할 비밀번호 일치 여부 확인
	
	// 비밀번호 변경 버튼 클릭 //////////////////////////////////////
	$("#passwordChangeBtn").on("click",function(e){
		e.preventDefault();
		if(correct == true && pwVerifyOk == true){
			if(confirm("비밀번호를 변경 하시겠습니까?")){
				$("#changePasswordForm").submit();
			}
		}
		else{
			alert("변경 할 비밀번호를 확인해주세요");
		}
	})
	// 비밀번호 변경 버튼 클릭 //
	
	//비밀번호 변경 결과 확인/////////////////////////////////////////
	var changeResult = '${result}';
	if(changeResult == "success"){
		alert("비밀번호가 변경되었습니다.")
	}
	else if(changeResult == "fail"){
		$("#nowPassword").focus();
		$(".form-control:focus").css("border-color","red")
		$(".form-control:focus").css("box-shadow","inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px rgba(255, 0, 0, 0.6)")
		$("#showChangeResult").text("기존 비밀번호가 일치하지 않습니다.").css("color","red");
	}
	// 비밀번호 변경 결과 확인 //
	
	//추가
	$("#nowPassword").on("propertychange change keyup paste",function(){
      $("#showChangeResult").text("")
   })
	
</script>