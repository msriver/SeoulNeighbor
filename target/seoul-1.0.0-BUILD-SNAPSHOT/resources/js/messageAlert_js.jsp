<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(document).ready(function(){
	//메시지 알림 함수 //////////////////////////////////////////////
	var isLinkChanged = true;
	function messageAlert(){
			var beforeCount = $("#noReadCount").text();
			var form = {
	               userid: '${member.userid}'
	               }
	       $.ajax({
	           url: "/getMessageCountAjax",
	           type: "GET",
	           data: form,
	           success: function(data){
	           	$("#noReadCount").text(data);
	           	if(beforeCount < data && isLinkChanged == false){
	               	$("#noReadCount").animate({
	               		top:'-10px'
	               	}).animate({
	               		top:'0px'
	               	});
	               	getMiniMessage();
	           	}
	           	isLinkChanged = false;
	           	beforeCount = 0;
	           }
	       });
	}

	function startMessageListen(){
		messageAlert();
		setInterval(messageAlert,1000); //1초마다 개수 불러옴
	}
	startMessageListen();
	//메시지 알림함수//

	// 미니 쪽지함 리스트 불러오기 //////////////////////////////////
	function getMiniMessage(){
	    var form = {
	            userid:'${member.userid}'
	    }
	    $.ajax({
	        url: "/myMiniMessageAjax",
	        type: "GET",
	        data: form,
	        success: function(data){
				$("#subMessageDiv").empty();
            	$("#subMessageDiv").append(
            			"<h5 class='dropdown-header'>최근 5개 메시지</h5>"
            	)
	            $(data).each(function(i,message){

	            	if(message.read_check =='N'){
	                	$("#subMessageDiv").append(
	                			"<a class='dropdown-item miniMessageContent' data-toggle='modal' data-target='#readMessage' style='background-color:#eebefa;color:white'>"+"<span>"+message.nickname+"</span>"+"<span>: </span>"+
	                			"<span class='realContent'>"+message.message_content+"</span>"+"<span style='display:none'>"+message.message_content+"</span>"+"<span style='display:none'>"+message.mno+"</span></a>"
						);
	            	}
	            	else{
	                	$("#subMessageDiv").append(
	                			"<a class='dropdown-item miniMessageContent' data-toggle='modal' data-target='#readMessage' style='background-color:white;color:black'>"+"<span>"+message.nickname+"</span>"+"<span>: </span>"+
	                			"<span class='subMsgContent'>"+message.message_content+"</span>"+"<span style='display:none'>"+message.message_content+"</span>"+"<span style='display:none'>"+message.mno+"</span></a>"
	    				);
	            	}
	                
	            });
	            $("#subMessageDiv").append(
	            		"<a href='/myMessage'><h5 class='dropdown-header'>더 보기<i class='fas fa-angle-right'></i></h5></a>"
				);
	            //cutContent();
	        }
	    });
	}
	$("#showMiniMessageBtn").on("click",function(){
		getMiniMessage();
	})
	
	$(document).on({
		mouseenter:function(){
			$($(this)[0]).addClass("subMessageDivHover");
		},
		mouseleave:function(){
			$(this).removeClass("subMessageDivHover");
		}
	},"#subMessageDiv a")

	// 미니 쪽지함 리스트 불러오기 //

	// 쪽지 내용 모달창 ////////////////////////////////////////////
	$(document).on("click",".miniMessageContent",function(){
		var messageInfo = $(this).children();
		$("#messageShowHeader").empty();
		$("#messageShowHeader").append(
			$(messageInfo[0]).text()+"님의 쪽지"
		);
		$("#readMessageContent").empty();
		$("#readMessageContent").append($(messageInfo[2]).text());
		
		$("#messageInfo").empty();
		$("#messageInfo").append(
			"<input type='hidden' id='mno' name='mno' value='"+$(messageInfo[4]).text()+"'>"+
			"<input type='hidden' name='nickname' value='"+$(messageInfo[0]).text()+"'>"		
		)
		
		var form = {
			mno: $("#mno").val()
	  		}
			$.ajax({
	       url: "/updateReadCheckAjax",
	       type: "POST",
	       beforeSend: function(xhr){
	       	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	       },
	       data: form,
	       success: function(data){
	       }
	   });
		
		
	})
	// 쪽지 답장 모달창 //

	// 쪽지 답장 모달창 ////////////////////////////////////////////
	var info;
	$(document).on("click","#replyMessageBtn",function(){
		info = $($(this).parent().siblings())[2];
		mno = $($($(info).children().eq(0)[0])[0]).val()
		
		$("#messageReplyHeader").empty();
		$("#messageReplyContent").val("");
		$("#warn").empty();
		$("#warn").append("(0/100) 글자");
		$("#messageReplyHeader").append(
				$($(info).children().eq(1)[0]).val()+"님에게 답장"	
		);
		
	})

	$("#messageReplyContent").on("propertychange change keyup keypress paste",function(){ //쪽지 내용 길이 바이트 검증
		var messageContent = $("#messageReplyContent").val();
		stringLength = messageContent.length
		if(stringLength>100){
			$("#warn").empty();
			messageContent = messageContent.substring(0,99);
			$("#messageReplyContent").val("");
			$("#messageReplyContent").val(messageContent);
			$("#warn").append("100글자를 초과했습니다.");
			$("#messageReplyContent").addClass("warn");
		}
		else{
			$("#messageReplyContent").removeClass("warn");
			$("#warn").empty();
			$("#warn").append("("+stringLength+"/100) 글자");
		}
	})

	// 쪽지 답장 모달창 //

	// 쪽지 답장 전송 ////////////////////////////////////////////
	 		$(document).on("click","#messageReplySendBtn",function(){
	       var form = {
	       		mno: $($($(info).children().eq(0)[0])[0]).val(),
	               sender: '${member.userid}',
	               message_content: $("#messageReplyContent").val()
	       }
	       $.ajax({
	           url: "/myMessageSendAjax",
	           type: "POST",
	           beforeSend: function(xhr){
	           	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	           },
	           data: form,
	           success: function(data){
	           	alert("답장했습니다!");
	           }
	       });
	})
	// 쪽지 답장 전송 //

	// 쪽지 내용 길면 ...로 자르기 ////////////////////////////////////
/* 	function cutContent(){
		var forCutMessageContent = $(".realContent")
		for(var i=0; i<5; i++){
			if($(forCutMessageContent[i]).text().length >15){
				var tempMessageContent = $(forCutMessageContent[i]).text();
				$(forCutMessageContent[i]).text(tempMessageContent.substring(0,15)+" ...");
			}
		}
	} */
	// 쪽지 내용 길면 ...로 자르기 //

	// 쪽지 삭제 /////////////////////////////////////////////////////
	$("#deleteMessageBtn").on("click",function(){
		if(confirm("삭제하시겠습니까?")){
	        var form = {
	        		mno: parseInt($("#mno").val()),
	        }
	        $.ajax({
	            url: "/deleteMessageAjax",
	            type: "POST",
	            data: form,
	            beforeSend: function(xhr){
	            	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	            },
	            success: function(data){
	            	alert("삭제했습니다!");
	    	        var form = {
	    	                userid: '${member.userid}',
	    	                pageNum: pageNum
	    	        }
	    	        $.ajax({
	    	            url: "/myMessageAjax",
	    	            type: "GET",
	    	            data: form,
	    	            success: function(data){ //리스트 다시 불러옴
	    	                $("#messageList").empty();
	    	                $(data).each(function(i,message){
	    	                	if(message.read_check == 'Y'){
	        		                $("#messageList").append(
	        								"<tr>"+
	        								"<td style='display:none'><input type='hidden' value='"+message.mno+"' /></td>"+
	        								"<td>"+message.nickname+"</td>"+
	        								"<td class='messageContent' data-toggle='modal' data-target='#readMessage'>"+message.message_content+"</td>"+
	        								"<td>"+message.writedate+"</td>"+
	        								"<td style='display:none'><input type='hidden' value='"+message.message_content+"' /></td>"+
	        								"</tr>"
	        			             )
	    	                	}
	    	                	else if(message.read_check == 'N'){
	        		                $("#messageList").append(
	        								"<tr>"+
	        								"<td style='display:none'><input type='hidden' value='"+message.mno+"' /></td>"+
	        								"<td>"+message.nickname+"</td>"+
	        								"<td class='messageContent' data-toggle='modal' data-target='#readMessage'>"+"[읽지 않음] "+message.message_content+"</td>"+
	        								"<td>"+message.writedate+"</td>"+
	        								"<td style='display:none'><input type='hidden' value='"+message.message_content+"' /></td>"+
	        								"</tr>"
	        			             )
	    	                	}
	    	                });
	    	                //cutContent();
	    	            }
	    	        });
	            }
	        });
		}
	})
	// 쪽지 삭제 //
})
</script>