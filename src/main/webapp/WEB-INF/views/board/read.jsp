<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>서울이웃</title>

<!-- CSS style ------------------------------>
<link rel="stylesheet" href="/resources/css/board/read.css">


</head>

<body>
	<!-- header include ------------>
	<%@include file="../common/header.jsp"%>
	<!-- header include -->


    <div class="container" style="margin-top:30px">
        <div class="row">
        
        	<!-- 왼쪽 사이드메뉴 ---------------------------------------->
            <div class="col-sm-2 left-menu">
                <div id="speedMove">
                    <h5><b>빠른 게시판 이동</b></h5>
                    <div class="input-group mb-3">
                        <select id="selectGu" name="gu" class="form-control custom-select">
                            <option>지역선택</option>
                            <option>강남구</option>
                            <option>강동구</option>
                            <option>강북구</option>
                            <option>강서구</option>
                            <option>관악구</option>
                            <option>광진구</option>
                            <option>구로구</option>
                            <option>금천구</option>
                            <option>노원구</option>
                            <option>도봉구</option>
                            <option>동대문구</option>
                            <option>동작구</option>
                            <option>마포구</option>
                            <option>서대문구</option>
                            <option>서초구</option>
                            <option>성동구</option>
                            <option>성북구</option>
                            <option>송파구</option>
                            <option>양천구</option>
                            <option>영등포구</option>
                            <option>용산구</option>
                            <option>은평구</option>
                            <option>종로구</option>
                            <option>중구</option>
                            <option>중랑구</option>
                        </select>
                    </div>
                </div>

                <h5><b>우리동네 인기글</b></h5>
                <ul>
				<c:forEach items="${hotList}" var="board" begin="0" end="5" step="1" varStatus="i">
				    <li class="nav-item">
                        <a class="nav-link" href='<c:out value="${board.bno}"/>?gu=${criteria.gu}'><c:out value="${board.title}"/></a>
                    </li>
				</c:forEach>
				</ul>
                <hr class="d-sm-none">
            </div>
            <!-- 왼쪽 사이드메뉴 -->

			<!-- 상세보기 본문 ------------------------------------------------------->
            <div class="col-sm-10">
                <div id="contentTitle">
                    <div id="writer" class="d-flex justify-content-between">
                        <div id="contentInfo">
                            <div>
                                <h2><c:out value="${board.title}"/></h2>
                            </div>
                            <div>
                                <span><c:out value="${board.regdate}"/></span>
                                <span>조회 <c:out value="${board.view_count}"/></span>
                                <span  id="likeCount">추천 <c:out value="${board.like_count}"/></span>
                                <span>댓글 <c:out value="${board.reply_count}"/></span>
                                <span id="reportBoard">신고하기</span>
                            </div>

                        </div>
	
                        <div id="writerProfile">
                            <span> 
                            	<c:choose>
									<c:when test="${fileName eq null }">
										<img id="profileChangeImg"
											class="card-img-top"
											src="/resources/img/mypage/profile_sample.png" alt="프로필 사진">
									</c:when>
									<c:when test="${fileName != null }">
										<img id="profileChangeImg" class="card-img-top"
											src="/resources/img/mypage/<c:out value="${fileName}"/>"
											alt="프로필 이미지">
									</c:when>
								</c:choose>
							</span>
                            <span class="userNickname" data-toggle="dropdown">${board.nickname }</span>
                            <div class="dropdown-menu">
							<a class="dropdown-item sendMessageToUser">쪽지 보내기</a>
                        </div>
                    </div>

                </div>

                <div id="contentBody">
               		${board.content}
                </div>


                <div class="recomend_box d-flex justify-content-between">
                    <div>
                        <span class="likeCount"><c:out value="${board.like_count}"/></span>
                        <i class="likeButton likeIcon far fa-thumbs-up"></i>
                    </div>
                    <div>
                        <span class="unlikeCount"><c:out value="${board.unlike_count}"/></span>
                        <i class="unLikeButton likeIcon far fa-thumbs-down"></i>
                    </div>
                </div>
                
				<!-- 댓글창 ----------------------------------------------------->
                <div id="commentDiv">
                     
                    <!--댓글 목록--------------------------------------->
                    <div id="commentList">

                    </div>
                    <!--댓글목록-->

                    <!--댓글페이징------------------------>
                    <div id="replyPaging">

					</div>
                    <!--댓글페이징-->

                    <!--댓글 입력---------------------------------------->
                    <div id="commentWrite">
                        <div class="input-group mb-3">
                            <textarea id="replyInput" class="form-control" placeholder="남에게 상처주는 말을 하지 맙시다."></textarea>
                            <div class="input-group-append">
                              <button id="replyBtn" class="btn btn-outline-secondary">댓글등록하기</button>
                            </div>
                        </div>
                    </div>
                    <!--댓글입력-->

                </div>
                <!-- 댓글창 -->

                <!-- 버튼 모음 -------------------------------->
                <div class="btn-box d-flex">
                    <button class="btn btn-primary mr-auto m-1">목록으로</button>
                    <button class="btn btn-warning m-1">수정하기</button>
                    <button class="btn btn-warning m-1">삭제하기</button>
                    <button class="btn btn-primary m-1">글쓰기</button>
                </div>
                <!-- 버튼모음 -->

            </div>
            <!-- 상세보기 본문 -->
        </div>
    </div>
</div>

<!-- reply 모듈 -->
<!-- <script src="/resources/js/board/reply.js"></script> -->

<!-- read javascript -->
<%-- <%@include file="/resources/js/board/read_js.jsp"%> --%>
<%@include file="/resources/js/report_js.jsp"%>
<%@include file="/resources/js/board/userClick_js.jsp"%>

<script>

var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue="${_csrf.token}";
//ajax요청시 마다 csrf 토큰 자동 적용
$(document).ajaxSend(function(e, xhr, options){
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});

var replyService = (function(){

	
	// 빠른 게시판 이동 ////////////////////////////////
	$("#selectGu").change(function(){
		location.href = "/board/list?gu="+$(this).val();
	})
	// 빠른 게시판 이동 //
	
//댓글 등록
	function add(reply, callback, error) {
		console.log("reply......");
		
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
		console.log("reply......");
		
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
				console.log(data);
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
		//좋아요 눌렀는지 확인 ////////////////////////////
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
	    		alert("로그인 해주세요");
	    	}
	    	else{
	  	      $.ajax({
	 	         url: "/read/plusLike/${board.bno}", 
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
	    		alert("로그인 해주세요");
	    	}
	    	else{
	  	      $.ajax({
	 	         url: "/read/plusUnlike/${board.bno}", 
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
			replyer = '${member.nickname}'
		</sec:authorize>
			
		//대댓글 입력칸 토글 변수, true : 생성이 안됬으니 생성해라, false : 생성되었으니 없애라
		var reReplyToggle = true;
		
		showList(1);
		
		//댓글목록 불러오기 함수
		function showList(page) {
			
			console.log("show list " + page);
			
			var dataObj = {
				bno : bnoValue, 
				page : page || 1,
			}
			
			console.log(dataObj);
			
			replyService.getList(dataObj, 
			function(result) {
				
				console.log("replyCnt " + result.replyCount);
				console.log("replyList " + result.replyList);
				console.log("reReplyList : " +result.reReplyList);
				
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
						str += '				<div class="bg-white p-2">';
						str += '					<div class="d-flex flex-row user-info">';
						str += '						<img class="rounded-circle" src="/resources/img/mypage/'+result.replyList[i].member_filename+'" width="40" height="40">';
						str += '						<div class="d-flex flex-column justify-content-start ml-2">';
						str += '							<span class="d-block font-weight-bold name">'+result.replyList[i].replyer+'</span>';
						str += '							<span class="date text-black-50">'+result.replyList[i].replyDate+'</span>';
						str += '						</div>';
						str += '						<div class="reply-content mt-2">';
						str += '							<p class="comment-text">'+result.replyList[i].reply+'</p>';
						str += '						</div>';
						str += '						<div class="re-reply ml-auto mt-2" data-rno="'+result.replyList[i].rno+'" data-type="0">';
						str += '							<sec:authorize access="isAuthenticated()">';
						str += '								<span class="re-reply-create">댓글달기</span>';
						if(replyer == result.replyList[i].replyer) {
							str += '									<span class="reply-update">수정</span>';
							str += '									<span class="reply-delete">삭제</span>';
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
						str += '				<div class="bg-white p-2">';
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
					re_str += '				<div class="bg-white p-2">';
					re_str += '					<div class="d-flex flex-row user-info">';
					re_str += '						<img src="/resources/img/board/replyArrow.png" width="30" height="30">';
					re_str += '						<img class="rounded-circle" src="/resources/img/mypage/'+result.reReplyList[i].member_filename+'" width="40" height="40">';
					re_str += '						<div class="d-flex flex-column justify-content-start ml-2">';
					re_str += '							<span class="d-block font-weight-bold name userNickname" data-toggle="dropdown">'+result.reReplyList[i].r_replyer+'</span>';
					re_str += '							<div class="dropdown-menu">'
                    re_str += '							<a class="dropdown-itme sendMessageToUser">쪽지 보내기</a></div>'
					re_str += '							<span class="date text-black-50">'+result.reReplyList[i].r_replyDate+'</span>';
					re_str += '						</div>';
					re_str += '						<div class="reply-content mt-2">';
					re_str += '							<p class="comment-text">'+result.reReplyList[i].r_reply+'</p>';
					re_str += '						</div>';
					re_str += '						<div class="re-reply ml-auto mt-2" data-rno="'+result.reReplyList[i].r_rno+'" data-type="1">';
					re_str += '							<sec:authorize access="isAuthenticated()">';
					if(replyer == result.reReplyList[i].r_replyer) {
						re_str += '									<span class="reply-update">수정</span>';
						re_str += '									<span class="reply-delete">삭제</span>';
					} else {
						re_str += '								<span class="reply-report">신고하기</span>';
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
		
		//등록버튼을 눌렀을 시 (댓글 입력)
		$("#replyBtn").on("click", function(e){
	    	if('${member.userid}' == ""){
	    		alert("로그인 해주세요");
	    	}
	    	else{
				var reply = {
						reply : $("#replyInput").val(),
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
	    	if('${member.userid}' == ""){
	    		alert("로그인 해주세요");
	    	}
	    	else{
				var rno = $(this).data("what");
				
				var re_reply = {
					rno : rno,
					r_reply : $("#re-replyInput"+rno).val(),
					r_replyer : replyer
				};
				
				var rno = $(this).closest("div").data("rno");
				var point = $("#point"+rno);
				
				replyService.reAdd(re_reply, function(result){
					console.log("result");
					showList(pageNum);
					point.html("");
					reReplyToggle = true;
				});
	    	}

		});
		
		//페이징 링크 눌렀을 시
		replyPaging.on("click", "ul li a", function(e){
			e.preventDefault();
			console.log("page click");
			
			var targetPageNum = $(this).attr("href");
			
			console.log("targetPageNum : " + targetPageNum);
			pageNum = targetPageNum;
			showList(pageNum);
		});
		//댓글달기 누를시 대댓글 입력 창 생성
		replyList.on("click", ".re-reply-create", function(e){
			var rno = $(this).closest("div").data("rno");
			//var point = $(".re-reply-box");
			var point = $("#point"+rno);
			console.log(rno);
			
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
			console.log(data);
			
			//삭제하는 녀석이 type = 0 (댓글) 이고 댓글에 대댓글이 달려있을때
			if(data.type == 0 && $("#re-reply"+data.no).children().length != 0){
				 data.exist = 1;
				console.log("얘는 대댓글이 달린 댓글이네");
			} else {
				console.log("대댓글이 없는 댓글이거나 대댓글이네");
			}
			
			replyService.remove(data, function(deleteResult){
				showList(pageNum);
				alert("삭제되었습니다.");
			});
		});
		
		//수정
		replyList.on("click", ".reply-update", function(e){
			var rno = $(this).closest("div").data("rno");
			var point = $(this).closest(".bg-white");
			
			var type = $(this).closest("div").data("type");
			
			var temp = $(this).parent().prev().children("p").text();
			
			console.log(temp);
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
		
		replyList.on("click", ".update-submit", function(e){
			e.preventDefault();
			var rno = $(this).data("what");
			var type = $(this).data("type");
			
			var point = $("#point"+rno);
			
			//보낼 데이터
			var data = {
					no : rno,
					reply : $("#updateInput"+rno).val()
			};
			replyService.update(data, type, function(result){
				alert(result);
				showList(pageNum);
				point.html("");
				reReplyToggle = true;
			});
		});		
		
	});
</script>

</body>

</html>