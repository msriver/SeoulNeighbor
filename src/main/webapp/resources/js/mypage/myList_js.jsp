<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(document).ready(function(){
	// 게시글 페이지 번호 개수 지정 //////////////////////////
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
	// 게시글 페이지 번호 개수 지정 //	
	
	// 게시글 리스트 다음 버튼 ////////////////////////////////
	$(document).on("click","#messageNextBtn",function(){
		nowPageNum = parseInt(nowPageNum) +5;
		changePageList();
	})
	// 게시글 리스트 다음 버튼 //
		
	// 게시글 리스트 이전 버튼 ////////////////////////////////
	$(document).on("click","#messagePrevBtn",function(){
		nowPageNum = parseInt(nowPageNum) -5;
		changePageList();
	})
	// 게시글 리스트 이전 버튼 //
			
	// Ajax 게시글 페이지 이동 //////////////////////////////
	$(document).on("click",".pageBtn",function(){
		$(this).nextAll().removeClass("active");
		$(this).prevAll().removeClass("active");
		$(this).addClass("active");
        var form = {
                userid: '${member.userid}',
                pageNum: $(this).text()*8-8
        }
        $.ajax({
            url: "/myListAjax",
            type: "GET",
            data: form,
            success: function(data){
                $("#messageList").empty();
                $(data).each(function(i,board){
	                $("#messageList").append(
						"<tr>"+
						"<td style='display:none'>"+board.bno+"</td>"+
						"<td>"+board.location+"</td>"+
						"<td>"+board.category+"</td>"+
						"<td>"+"<span class='boardTitle'>"+board.title+"</span> ["+board.reply_count+"]</td>"+
						"<td>"+board.like_count+"</td>"+
						"<td>"+board.regdate+"</td>"+
						"</tr>"
	                )
	                cutContent();
                });
            },
            error: function(){
                alert("simpleWithObject err");
            }
        });
	})
	// Ajax 게시글 페이지 이동 //
	
	// 게시글 제목 길면 ...로 자르기 ////////////////////////////////////
	function cutContent(){
		var forCutMessageContent = $(".boardTitle")
		for(var i=0; i<8; i++){
			if($(forCutMessageContent[i]).text().length >15){
				var tempMessageContent = $(forCutMessageContent[i]).text();
				$(forCutMessageContent[i]).empty();
				$(forCutMessageContent[i]).append(tempMessageContent.substring(0,15)+" ...");
			}
		}
	}
	cutContent();
	// 게시글 제목 길면 ...로 자르기 //
	
	// 게시글 클릭 하면 상세페이지 이동 //////////////////////////////////
	$(document).on("click",".boardTitle",function(){
		var bno = $($(this).parents().siblings("td")[0]).text();
		var gu = $($(this).parents().siblings("td")[1]).text();
		location.href = "/board/read/"+bno+"?gu="+gu;
		
	})
	// 게시글 클릭 하면 상세페이지 이동 //
})

</script>