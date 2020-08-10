<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue="${_csrf.token}";
//ajax요청시 마다 csrf 토큰 자동 적용
$(document).ajaxSend(function(e, xhr, options){
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

var replyService = (function(){


	
//댓글 등록
	function add(reply, callback, error) {
		
		$.ajax({
			type: "post",
			url : "/reply/new",
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});
	}
	
	//대댓글 등록
	function reAdd(reply, callback, error) {
		
		$.ajax({
			type: "post",
			url : "/reply/newRe",
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});
	}
	
	//댓글 목록 사져오기
	function getList(param, callback, error) {
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/reply/pages/" + bno + "/" + page + ".json",
				function(data) {
			if(callback){
				callback(data);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				error();
			}
		});
	}
	
	//댓글 삭제
	function remove(data, callback, error) {
		
		var no = data.no;
		var type = data.type;
		var exist = data.exist;
				
		$.ajax({
			type:"delete",
			url:"/reply/delete/" + no + "/" + type + "/" + exist,
			dataType: "text",
			success : function(deleteResult, status, xhr) {
				if(callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er);
				}
			}
		});
	}
	
	//댓글 수정
	function update(reply, type, callback, error) {
		$.ajax({
			type : 'put',
			url : '/reply/update/' + reply.no +"/" + type,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er);
				}
			}
		});
	}
		
	return {
		add : add,
		reAdd : reAdd,
		getList : getList,
		remove : remove,
		update : update
	};
})();


	$(document).ready(function(){
		
		var actionForm = $("#actionForm");
		
		$(".btn-box button").click(function(e){
			e.preventDefault();
			var thisid = $(this).attr('id');
			
			if(thisid == 'listButton') {
				actionForm.attr('action', '/board/list');
			} else if(thisid == 'modfiyButton') {
				actionForm.attr('action', '/board/modify');
			} else if(thisid == 'deleteButton') {
				if(confirm("삭제하시겠습니까?")){
					actionForm.append('<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />');
					actionForm.attr('action', '/board/remove').attr('method', 'post').submit();
				}
				else{
					return;
				}

			} else if(thisid == 'registerButton') {
				actionForm.attr('action', '/board/register');
			}
			
			actionForm.submit();
		});

		
		// 빠른 게시판 이동
		var pre_select = null; 
		$("#selectGu").focus(function(){
			pre_select = $(this).val();
		}).change(function(){
			if(confirm($(this).val()+"로 이동하시겠습니까?")){
				location.href = "/board/list?gu="+$(this).val();
			}
			else{
				$(this).val(pre_select);
			}
		});

		
		//좋아요 눌렀는지 확인
		function likeCheck(){
	            var form = {
 	            		bno: '${board.bno}',
 	            		userid: '${member.userid}'
 	            }
 		  	      $.ajax({
 		  	    	 data: form,
 		 	         url: "/board/likeCheck", 
 		 	         type: "GET",
 		 	         success: function(result){
	 	        		 $(".fa-thumbs-up").addClass("likeButton");
		 	        	 $(".fa-thumbs-down").addClass("unLikeButton");
		 	        	 $(".fa-thumbs-down").removeClass("likeClicked");
		 	        	 $(".fa-thumbs-up").removeClass("likeClicked");
 		 	        	
 		 	        	 if(result=="L" || result =="U"){
 		 	        		 $(".fa-thumbs-up").removeClass("likeButton");
 		 	        		 $(".fa-thumbs-down").removeClass("unLikeButton");
 		 	        	 }
 		 	        	 if(result =="L"){
 		 	        		$(".fa-thumbs-up").addClass("likeClicked");
 		 	        	 }
 		 	        	 else if(result == "U"){
 		 	        		$(".fa-thumbs-down").addClass("likeClicked");
 		 	        	 }
 		 	         }
 		 	      });
		}
		
		likeCheck();
		//좋아요 눌렀는지 확인 //
		
		// 좋아요 싫어요 ////////////////////////////////////
	    $(document).on("click",".likeButton",function(){
	    	if('${member.userid}' == ""){
	    		alert("로그인한 회원만 이용할 수 있습니다");
	    	}
	    	else{
	  	      $.ajax({
	 	         url: "/board/read/plusLike/${board.bno}", 
	 	         type: "GET",
	 	         dataType: "text",
	 	         success: function(result, status, xhr){
	 	            $(".likeCount").html(result);
	 	            $("#likeCount").html("추천 "+result);
	 	            var form = {
	 	            		bno: '${board.bno}',
	 	            		userid: '${member.userid}',
	 	            		type:'L'
	 	            }
	 		  	      $.ajax({
	 		  	    	 data: form,
	 		 	         url: "/board/insertLikeAjax", 
	 		 	         type: "POST",
	 		 			 beforeSend: function(xhr){
	 						xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}')
	 					 },
	 		 	         success: function(result, status, xhr){
	 		 	        	likeCheck()
	 		 	         }
	 		 	      });
	 	         }
	 	      });
	    	}
	   });
	   
	   $(document).on("click",".unLikeButton",function(){
	    	if('${member.userid}' == ""){
	    		alert("로그인한 회원만 이용할 수 있습니다");
	    	}
	    	else{
	  	      $.ajax({
	 	         url: "/board/read/plusUnlike/${board.bno}", 
	 	         type: "GET",
	 	         dataType: "text",
	 	         success: function(result, status, xhr){
		 	            $(".unlikeCount").html(result);
		 	            var form = {
		 	            		bno: '${board.bno}',
		 	            		userid: '${member.userid}',
		 	            		type:'U'
		 	            }
		 		  	      $.ajax({
		 		  	    	 data: form,
		 		 	         url: "/board/insertLikeAjax", 
		 		 	         type: "POST",
		 		 			 beforeSend: function(xhr){
		 						xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}')
		 					 },
		 		 	         success: function(result, status, xhr){
		 		 	        	likeCheck()
		 		 	         }
		 		 	      });
		 	         }
	 	      });	
	    	}

	   });
		// 좋아요 싫어요 //
		
		// 좋아요 싫어요 취소 ///////////////////////////
		$(document).on("click",".likeClicked",function(){
			if($(this)[0].dataset.icon == "thumbs-up"){
 	            var form = {
 	            		bno: '${board.bno}',
 	            		userid: '${member.userid}',
 	            		type:'L'
 	            }
 		  	      $.ajax({
 		  	    	 data: form,
 		 	         url: "/board/cancelLike", 
 		 	         type: "POST",
 		 			 beforeSend: function(xhr){
 						xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}')
 					 },
 		 	         success: function(result, status, xhr){
 		 	        	likeCheck()
 		 	        	$("#likeCount").empty();
 		 	        	$("#likeCount").append("추천 ");
 		 	        	$("#likeCount").append(parseInt($(".likeCount").text()) -1);
 		 	        	$(".likeCount").html(parseInt($(".likeCount").text()) -1)
 		 	         }
 		 	      });
			}
			else if($(this)[0].dataset.icon == "thumbs-down"){
 	            var form = {
 	            		bno: '${board.bno}',
 	            		userid: '${member.userid}',
 	            		type:'U'
 	            }
 		  	      $.ajax({
 		  	    	 data: form,
 		 	         url: "/board/cancelLike", 
 		 	         type: "POST",
 		 			 beforeSend: function(xhr){
 						xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}')
 					 },
 		 	         success: function(result, status, xhr){
 		 	        	likeCheck()
 		 	        	$(".unlikeCount").html(parseInt($(".unlikeCount").text()) -1)
 		 	         }
 		 	      });
			}
		})
		// 좋아요 싫어요 취소 //
	
		var bnoValue = <c:out value="${board.bno}"/>;
		var replyList = $("#commentList");
		
		//댓글 기능은 기본적으로 로그인한 유저만 작성이 가능하므로 로그인된 정보 중 닉네임을 replyer로 기본 설정
		var replyer = null;
		<sec:authorize access="isAuthenticated()">
			replyer = '${member.userid}'
		</sec:authorize>
			
		//대댓글 입력칸 토글 변수, true : 생성이 안됬으니 생성해라, false : 생성되었으니 없애라
		var reReplyToggle = true;
		
		showList(1);
		
		//댓글목록 불러오기 함수
		function showList(page) {
			
			var dataObj = {
				bno : bnoValue, 
				page : page || 1,
			}
			
			replyService.getList(dataObj, 
			function(result) {
				
				if(page == -1) {
					pageNum = Math.ceil(result.replyCount/10.0);
					showList(pageNum);
					return;
				}
				
				var str = "";	
				
				if(result.replyList == null || result.replyList.length == 0) {
					replyList.html("");
					return;
				}
				replyList.html("");
				//먼저 댓글들을 생성해주고
				for(var i = 0, len = result.replyList.length || 0; i<len; i++) {
					
					if(result.replyList[i].exist == 0) {
						str += '<div class="reply-container container">';
						str += '	<div class="d-flex row">';
						str += '		<div class="col-md-12">';
						str += '			<div class="d-flex flex-column comment-section">';
						str += '				<div class="reply-container p-2">';
						str += '					<div class="d-flex flex-row user-info">';
						if(result.replyList[i].member_filename == null) {
			                  var fileName = 'profile_sample.png';
			                  str += '                  <img class="rounded-circle" src="/resources/img/mypage/' + fileName + '" width="40" height="40">';
			               } else {
			                  var fileName = result.replyList[i].member_filename;
			                  str += '                  <img class="rounded-circle" src="/profile/image/' + fileName + '" width="40" height="40">';
			               }
						str += '						<div class="d-flex flex-column justify-content-start ml-2">';
						str += '							<span class="d-block font-weight-bold name" data-toggle="dropdown">'+result.replyList[i].replyer+'</span>';
						str += '							<div class="dropdown-menu">'
		                str += '							<a class="dropdown-itme sendMessageToUser">쪽지 보내기</a></div>'
						str += '							<span class="date text-black-50">'+result.replyList[i].replyDate+'</span>';
						str += '						</div>';
						str += '						<div class="reply-content mt-2">';
						str += '							<p class="comment-text"><pre>'+result.replyList[i].reply+'</pre></p>';
						str += '						</div>';
						str += '						<div class="re-reply ml-auto mt-2" data-rno="'+result.replyList[i].rno+'" data-type="0">';
						str += '							<sec:authorize access="isAuthenticated()">';
						str += '								<span class="re-reply-create cursor">댓글달기</span>';
						if('${member.nickname}' == result.replyList[i].replyer) {
							str += '									<span class="reply-update cursor">수정</span>';
							str += '									<span class="reply-delete cursor">삭제</span>';
						} else {
							str += '								<span class="reply-report">신고하기</span>';
						}
						str += '							</sec:authorize>';
						str += '						</div>';
						str += '					</div>';
						str += '				</div>';
						str += '				<div id="re-reply'+result.replyList[i].rno+'">';			
						str += '				</div>';			
						str += '				<div id="point'+result.replyList[i].rno+'">';		
						str += '				</div>';		
						str += '			</div>';
						str += '		</div>';
						str += '	</div>';
						str += '</div>';
					} else {
						str += '<div class="reply-container container">';
						str += '	<div class="d-flex row">';
						str += '		<div class="col-md-12">';
						str += '			<div class="d-flex flex-column comment-section">';
						str += '				<div class="reply-container p-2">';
						str += '					<div class="d-flex flex-row user-info">';
						str += '						<div class="re-reply ml-auto mt-2" data-rno="'+result.replyList[i].rno+'" data-type="0">';
						str += '						</div>';
						str += '					</div>';
						str += '					<div>';
						str += '						<p>[삭제된 댓글입니다.]</p>';
						str += '					</div>';
						str += '				</div>';
						str += '				<div id="re-reply'+result.replyList[i].rno+'">';			
						str += '				</div>';			
						str += '				<div id="point'+result.replyList[i].rno+'">';		
						str += '				</div>';		
						str += '			</div>';
						str += '		</div>';
						str += '	</div>';
						str += '</div>';
					}
					
					
				}
				
				replyList.html(str);
				//대댓글을 만들어줍니다.
				for(var i = 0, len = result.reReplyList.length || 0; i<len; i++) {
					var re_str = "";
					re_str += '<div class="reply-container container">';
					re_str += '	<div class="d-flex row">';
					re_str += '		<div class="col-md-12">';
					re_str += '			<div class="d-flex flex-column comment-section">';
					re_str += '				<div class="r_reply-container p-2">';
					re_str += '					<div class="d-flex flex-row user-info">';
		            re_str += '                 	<img src="/resources/img/board/replyArrow.png" width="30" height="30">';
					if(result.reReplyList[i].member_filename == null) {
		                  var fileName = 'profile_sample.png';
			                re_str += '                  <img class="rounded-circle" src="/resources/img/mypage/' + fileName + '" width="40" height="40">';
		               } else {
		                  var fileName = result.reReplyList[i].member_filename;
			                re_str += '                  <img class="rounded-circle" src="/profile/image/' + fileName + '" width="40" height="40">';
		               }
					re_str += '						<div class="d-flex flex-column justify-content-start ml-2">';
					re_str += '							<span class="d-block font-weight-bold name userNickname" data-toggle="dropdown">'+result.reReplyList[i].r_replyer+'</span>';
					re_str += '							<div class="dropdown-menu">'
                    re_str += '							<a class="dropdown-itme sendMessageToUser">쪽지 보내기</a></div>'
					re_str += '							<span class="date text-black-50">'+result.reReplyList[i].r_replyDate+'</span>';
					re_str += '						</div>';
					re_str += '						<div class="reply-content mt-2">';
					re_str += '							<p class="comment-text"><pre>'+result.reReplyList[i].r_reply+'</pre></p>';
					re_str += '						</div>';
					re_str += '						<div class="re-reply ml-auto mt-2" data-rno="'+result.reReplyList[i].r_rno+'" data-type="1">';
					re_str += '							<sec:authorize access="isAuthenticated()">';
					if('${member.nickname}' == result.reReplyList[i].r_replyer) {
						re_str += '									<span class="reply-update cursor">수정</span>';
						re_str += '									<span class="reply-delete cursor">삭제</span>';
					} else {
						re_str += '								<span class="reply-report cursor">신고하기</span>';
					}
					re_str += '							</sec:authorize>';
					re_str += '						</div>';
					re_str += '					</div>';
					re_str += '				</div>';					
					re_str += '			</div>';
					re_str += '		</div>';
					re_str += '	</div>';
					re_str += '</div>';
					
					$("#re-reply" + result.reReplyList[i].rno).append(re_str);
				}
				
				$("#replyCount").text("댓글 " + result.displayCommentCount);
				showReplyPage(result.replyCount);
			});
		}
		
		var pageNum = 1;
		var replyPaging = $("#replyPaging");
		
		//페이징 부분 만드는 함수
		function showReplyPage(replyCnt) {
			if(replyCnt == 0) {
				replyPaging.html("");
				return;
			}
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;
			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= replyCnt) {
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			if(endNum * 10 < replyCnt) {
				next = true;
			}
			
			var str = '<ul class="pagination justify-content-center mb-3">';
			
			if(prev) {
				str += '<li class="page-item"><a class="page-link" href="'+(startNum - 1)+'">Previous</a></li>';
			}
			
			for(var i = startNum; i<=endNum; i++) {
				var active = pageNum == i? "active" : "";
				str += '<li class="page-item '+active+'"><a class="page-link" href="'+i+'">'+i+'</a></li>';
			}
			
			if(next) {
				str += '<li class="page-item"><a class="page-link" href="'+(endNum + 1)+'">Next</a></li>';
			}
			
			str += '</ul>';
			
			replyPaging.html(str);
		}
		
		var blank_pattern = /^\s+|\s+$/g;
		
		//등록버튼을 눌렀을 시 (댓글 입력)
		$("#replyBtn").on("click", function(e){
			
			var reply = $("#replyInput").val();
			
	    	if('${member.userid}' == ""){
	    		alert("로그인한 회원만 이용할 수 있습니다");
	    	} else if(!reply || reply.replace(blank_pattern, '') == "") {
	    		alert("댓글을 입력 후 등록해주세요.");
	    	} else{
				var reply = {
						reply : reply,
						replyer : replyer,
						bno : bnoValue
				};
				
				replyService.add(reply, function(result){
					$("#replyInput").val("");
					showList(-1);
				});
	    	}
		});
		
		//등록버튼을 눌렀을 시 (대댓글 입력)
		replyList.on("click", ".re-reply-submit", function(e){
			
			var rno = $(this).data("what");
			var r_reply = $("#re-replyInput"+rno).val();
			
	    	if('${member.userid}' == ""){
	    		alert("로그인한 회원만 이용할 수 있습니다");
	    	} else if(!r_reply || r_reply.replace(blank_pattern, '') == "") {
	    		alert("댓글을 입력하지 않았습니다.");
	    	} else{
				var re_reply = {
					rno : rno,
					r_reply : r_reply,
					r_replyer : replyer
				};
				
				var point = $("#point"+rno);
				
				replyService.reAdd(re_reply, function(result){
					showList(pageNum);
					point.html("");
					reReplyToggle = true;
				});
	    	}
	    	

		});
		
		//페이징 링크 눌렀을 시
		replyPaging.on("click", "ul li a", function(e){
			e.preventDefault();
			
			var targetPageNum = $(this).attr("href");
			
			pageNum = targetPageNum;
			showList(pageNum);
		});
		
		//댓글달기 누를시 대댓글 입력 창 생성
		replyList.on("click", ".re-reply-create", function(e){
			var rno = $(this).closest("div").data("rno");
			//var point = $(".re-reply-box");
			var point = $("#point"+rno);
			
			var str = "";
			str += '<div id="re-commentWrite">';
			str += '	<div class="input-group mb-3">';
			str += '		<textarea id="re-replyInput'+rno+'" class="form-control" placeholder="남에게 상처주는 말을 하지 맙시다."></textarea>';
			str += '		<div class="input-group-append">';
			str += '			<button id="re-replyBtn'+rno+'" class="re-reply-submit btn btn-outline-secondary" data-what="'+rno+'">댓글등록하기</button>';
			str += '		</div>';
			str += '	</div>';
			str += '</div>';
			
			if(reReplyToggle){
				point.html(str);
				reReplyToggle = false;
			} else {
				point.html("");
				reReplyToggle = true;
			}
			
		});
		
		//삭제
		replyList.on("click", ".reply-delete", function(e){
			
			if(!confirm("삭제하시겠습니까?")) {
				return;
			}
			
			//data.type이 0이면 댓글, 1이면 대댓글
			var data = {
					no : $(this).closest("div").data("rno"),
					type : $(this).closest("div").data("type"),
					exist : 0
			};
			
			//삭제하는 녀석이 type = 0 (댓글) 이고 댓글에 대댓글이 달려있을때
			if(data.type == 0 && $("#re-reply"+data.no).children().length != 0){
				 data.exist = 1;
			}
			
			replyService.remove(data, function(deleteResult){
				showList(pageNum);
				alert("삭제되었습니다.");
			});
		});
		
		//수정하기 누를 시 수정하는 입력칸
		replyList.on("click", ".reply-update", function(e){
			var rno = $(this).closest("div").data("rno");
			var point = $(this).closest(".reply-container");
			
			var type = $(this).closest("div").data("type");
			
			var temp = $(this).parent().prev().children("p").text();
			
			var str = "";
			str += '<div id="re-commentWrite">';
			str += '	<div class="input-group mb-3">';
			str += '		<textarea id="updateInput'+rno+'" class="form-control">'+temp+'</textarea>';
			str += '		<div class="input-group-append">';
			str += '			<button id="updateBtn'+rno+'" class="update-submit btn btn-outline-secondary" data-type="'+type+'" data-what="'+rno+'">댓글등록하기</button>';
			str += '		</div>';
			str += '	</div>';
			str += '</div>';
			point.html(str);
		});
		
		//수정처리
		replyList.on("click", ".update-submit", function(e){
			e.preventDefault();
			var rno = $(this).data("what");
			var type = $(this).data("type");
			var reply = $("#updateInput"+rno).val();
			var point = $("#point"+rno);
			
			if(!reply || reply.replace(blank_pattern, '') == "") {
	    		alert("댓글을 입력하지 않았습니다.");
	    		return;
	    	}
			
			//보낼 데이터
			var data = {
					no : rno,
					reply : reply
			};
			replyService.update(data, type, function(result){
				showList(pageNum);
				point.html("");
				reReplyToggle = true;
			});
		});		
		
	});
</script>