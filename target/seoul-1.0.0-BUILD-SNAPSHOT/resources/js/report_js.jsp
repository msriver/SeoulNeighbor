<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(document).ready(function(){
	// 신고하기 ////////////////////////////
	$("#reportBoard").on("click",function(){
		if('${member.userid}' == ""){
			alert("로그인한 회원만 이용할 수 있습니다");
		}
		else{
			$('#reportUserModal').modal("show");
			$("#reportContent").val("");
			$("#reportUserHeader").text("글 제목: ${board.title} 신고하기");
			$("#reportInfo").empty();
			$("#reportInfo").append(
				"<input type='hidden' id='target' value='"+${board.bno}+"'>"+		
				"<input type='hidden' id='group' value='b'>"		
			);
		}
	})
	
	$(document).on("click",".reply-report",function(){
		if('${member.userid}' == ""){
			alert("신고하려면 로그인 해주세요");
		}
		else{
			$('#reportUserModal').modal("show");
			$("#reportContent").val("");
			$("#reportUserHeader").text("댓글 내용: "+$($($(this).parents()[1]).children().children($(".reply-content"))[3]).text()+" 신고하기");
			$("#reportInfo").empty();
			$("#reportInfo").append(
				"<input type='hidden' id='target' value='"+${board.bno}+"'>"+		
				"<input type='hidden' id='group' value='r'>"		
			);
		}
	})
	// 신고하기 //
	
	
	$("#reportUserBtn").on("click",function(e){
		if($("#reportType option:selected").val()=="none"){
			alert("신고 사유를 선택해주세요");
		}
		else if($("#reportContent").val()==""){
			alert("신고 내용을 입력해주세요");
		}
		else{
			var form = {
		               userid:'${member.userid}',
		               rp_content:$("#reportContent").val() ,
		               rp_type:$("#reportType option:selected").val(),
		               rp_group:$("#group").val(),
		               rp_target:$("#target").val()
		               }
		       $.ajax({
		           url: "/board/reportAjax",
		           type: "POST",
		           data: form,
		           beforeSend: function(xhr){
		        	   xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		        		},
		           success: function(data){
						alert("신고되었습니다.");
						$('#reportUserModal').modal("hide");
		           },
		           error: function(){
		               alert("simpleWithObject err");
		           }
		       });
		}

	})
	
	$("#reportContent").on("propertychange change keyup keypress paste",function(){ //신고 내용 길이 바이트 검증
		var messageContent = $("#reportContent").val();
		stringLength = messageContent.length
		if(stringLength>100){
			$("#warnReport").empty();
			messageContent = messageContent.substring(0,99);
			$("#reportContent").val("");
			$("#reportContent").val(messageContent);
			$("#warnReport").append("100글자를 초과했습니다.");
			$("#reportContent").addClass("warn");
		}
		else{
			$("#reportContent").removeClass("warn");
			$("#warnReport").empty();
			$("#warnReport").append("("+stringLength+"/100) 글자");
		}
	})
})
</script>