<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script>

$(document).ready(function(){
	// 1:1문의 페이지 번호 개수 지정 //////////////////////////
	var pageTotalNum = '${pageTotalNum}'
	var nowPageNum = '${nowPageNum}'


	function changePageList(){
		$("#pageNumBtnList").empty();

		for(var i=nowPageNum ; i<pageTotalNum/8+1 ; i++){
			$("#pageNumBtnList").append(
				"<li class='page-item pageBtn'><a class='page-link'>"+i+"</a></li>"
			)
			if(i%5==0){
				break;
			}
		}
		
		if(pageTotalNum/8-nowPageNum >= 5){
			$("#pageNumBtnList").append(
				"<li id='messageNextBtn' class='page-item'><a class='page-link'>Next</a></li>"
			)
		}
		if(nowPageNum>5){
			$("#pageNumBtnList").prepend(
				"<li id='messagePrevBtn' class='page-item'><a class='page-link'>Prev</a></li>"
			)
		}
	}
	changePageList();
	$("#pageNumBtnList :first-child").addClass("active");
	// 1:1문의 페이지 번호 개수 지정 //	
	
	// 1:1문의 리스트 다음 버튼 ////////////////////////////////
	$(document).on("click","#messageNextBtn",function(){
		nowPageNum = parseInt(nowPageNum) +5;
		changePageList();
	})
	// 1:1문의 리스트 다음 버튼 //
		
	// 1:1문의 리스트 이전 버튼 ////////////////////////////////
	$(document).on("click","#messagePrevBtn",function(){
		nowPageNum = parseInt(nowPageNum) -5;
		changePageList();
	})
	// 1:1문의 리스트 이전 버튼 //
	
	// Ajax 1:1문의 페이지 이동 //////////////////////////////
	$(document).on("click",".pageBtn",function(){
		$(this).nextAll().removeClass("active");
		$(this).prevAll().removeClass("active");
		$(this).addClass("active");
        var form = {
                userid: '${member.userid}',
                pageNum: $(this).text()*8-8
        }
        $.ajax({
            url: "/myQAAjax",
            type: "GET",
            data: form,
            success: function(data){
                $("#QAList").empty();
                $(data).each(function(i,QA){
					if(QA.q_check == 'Y'){
		                $("#QAList").append(
								"<tr>"+
								"<td>처리 완료</td>"+
								"<td class='QATitle' data-toggle='modal' data-dismiss='modal' data-target='#readQA'>"+QA.q_title+"</td>"+
								"<td>"+QA.q_regdate+"</td>"+
								"<td style='display:none'>"+QA.q_content+"</td>"+
								"</tr>"
			                )
					}else{
		                $("#QAList").append(
								"<tr>"+
								"<td>접수 중</td>"+
								"<td class='QATitle' data-toggle='modal' data-dismiss='modal' data-target='#readQA'>"+QA.q_title+"</td>"+
								"<td>"+QA.q_regdate+"</td>"+
								"<td style='display:none'>"+QA.q_content+"</td>"+
								"</tr>"
			                )
					}
	                cutContent();
                });
            },
            error: function(){
                alert("simpleWithObject err");
            }
        });
	})
	// Ajax 1:1문의 페이지 이동 //
	
	// 1:1문의 등록 ////////////////////////////////////////////
  		$(document).on("click","#insertQABtn",function(){
        var form = {
        		userid: '${member.userid}',
                q_title: $("#writeQATitle").val(),
                q_content: $("#writeQAContent").val()
        }
        $.ajax({
            url: "/QASendAjax",
            type: "POST",
            beforeSend: function(xhr){
            	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            data: form,
            success: function(data){
            	location.reload(true)
            	alert("문의사항이 접수 되었습니다. 빠른 시일내에 답변드리겠습니다.");
            },
            error: function(){
                alert("simpleWithObject err");
            }
        });
	})
	// 1:1문의 등록 //
	
	// 1:1문의 제목 길면 ...로 자르기 ////////////////////////////////////
	function cutContent(){
		var forCutMessageContent = $(".QATitle")
		for(var i=0; i<8; i++){
			if($(forCutMessageContent[i]).text().length >15){
				var tempMessageContent = $(forCutMessageContent[i]).text();
				$(forCutMessageContent[i]).empty();
				$(forCutMessageContent[i]).append(tempMessageContent.substring(0,15)+" ...");
			}
		}
	}
	cutContent();
	// 1:1문의 제목 길면 ...로 자르기 //
	
	// 1:1문의 작성 문자 길이 제한 ////////////////////////////////////
	function cutTitleLength(){
		var forCutTitleLength = $("#writeQATitle")
		
		if($(forCutTitleLength).val().length >30){
			var tempMessageContent = $(forCutTitleLength).val();
			$(forCutTitleLength).val(forCutTitleLength.val().substring(0,30));
		}
	}
	
	function cutContentLength(){
		var writeQAContent = $("#writeQAContent").val();
		stringLength = writeQAContent.length
		if(stringLength>1000){
			$("#qaWarn").empty();
			writeQAContent = writeQAContent.substring(0,1000);
			$("#writeQAContent").val("");
			$("#writeQAContent").val(writeQAContent);
			$("#qaWarn").append("1000글자를 초과했습니다.");
			$("#writeQAContent").addClass("warn");
		}
		else{
			$("#writeQAContent").removeClass("warn");
			$("#qaWarn").empty();
			$("#qaWarn").append("("+stringLength+"/1000) 글자");
		}
	}
	
	
	// 1:1문의 작성 문자 길이 제한 //
	
	
	// 1:1문의 폼 입력 감지 //////////////////////////////////////////////
	$("#writeQATitle").on("propertychange change keyup paste",function(){
		cutTitleLength();
	})
	
	$("#writeQAContent").on("propertychange change keyup paste",function(){
		cutContentLength();
	})
	// 1:1문의 폼 입력 감지 //
	
	// 문의 사항 보기 ////////////////////////////////////////////////////
	$(document).on("click",".QATitle",function(){
		if($($(this).siblings()[0]).text() == "접수 중"){
			$("#QAStatus").text("처리 상태: "+$($(this).siblings()[0]).text());
			$("#QAStatus").css("color","#228be6").css("border-bottom","1px solid #e9ecef");
		}
		else if($($(this).siblings()[0]).text() == "처리 완료"){
			$("#QAStatus").text("처리 상태: "+$($(this).siblings()[0]).text());
			$("#QAStatus").css("color","#40c057").css("border-bottom","1px solid #e9ecef");
		}
		console.log($(this))
		$("#QAheader").text("문의 사항: "+$($(this)[0]).text());
		$("#QAContent").text($($(this).siblings()[2]).text())
	})
	// 문의 사항 보기
})
	
</script>