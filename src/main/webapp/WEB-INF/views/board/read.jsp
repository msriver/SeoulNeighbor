<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
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
            <div class="col-sm-3">
            	<div class="left-menu">
	            	<!-- 인기글 ------------------->
	            	<div>
	            		<h5><b>우리동네 인기글</b></h5>
	            		<div id="popularity">
	            			<p>추천순</p>
	            			<ul>
							<c:forEach items="${hotList}" var="board" begin="0" end="2" step="1" varStatus="i">
							    <li class="nav-item">
			                        <span>[<c:out value='${board.category}'/>]</span> <a class="smallList" href='<c:out value="${board.bno}"/>?gu=${criteria.gu}'><c:out value="${board.title}"/></a>
			                    </li>
							</c:forEach>
							</ul>
							<p>댓글순</p>
							<ul>
							<c:forEach items="${hotList}" var="board" begin="3" end="5" step="1" varStatus="i">
							    <li class="nav-item">
			                        [<c:out value='${board.category}'/>] <a class="smallList" href='<c:out value="${board.bno}"/>?gu=${criteria.gu}'><c:out value="${board.title}"/></a>
			                    </li>
							</c:forEach>
							</ul>
	            		</div>
	            	</div>
					<!-- 인기글 -->
					<!-- 빠른 이동 ------------------>
					<div id="speedMove">
	                    <h5><b>빠른 게시판 이동</b></h5>
	                    <div id="select-wrap" class="input-group mb-3">
	                        <select id="selectGu" name="gu" class="form-control custom-select" >
	                            <option style="display:none"><c:out value="${criteria.gu}"/></option>
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
		                <!-- 빠른이동 -->
		                <hr class="d-sm-none">
		            </div>		           
            	</div>
            	<!-- 왼쪽 사이드메뉴 -->

         <!-- 상세보기 본문 ------------------------------------------------------->
            <div class="col-sm-9">
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
                                <span id = "replyCount">댓글 <c:out value="${board.reply_count}"/></span>
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

                    <button id="listButton" class="btn btn-primary mr-auto m-1">목록으로</button>
                    <c:set var = "userid" value ="${board.userid}" />
                    <sec:authorize access="isAuthenticated()">
	                    <sec:authentication property="principal.username" var="loginid"/> 
	                    	<c:if test ="${userid eq loginid}" >
	                    		<button id="modfiyButton" class="btn btn-warning m-1">수정하기</button>
	                    		<button id="deleteButton" class="btn btn-warning m-1">삭제하기</button>
	                    	</c:if>
	                    </sec:authorize>
                    <button id="registerButton" class="btn btn-primary m-1">글쓰기</button>
                </div>
                <!-- 버튼모음 -->
                
                <form id="actionForm" action='' method="get">
                	<input type="hidden" name='bno' value="${board.bno }">
                	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'> 
					<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
					<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>'>
					<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'>
					<input type='hidden' name='gu' value='<c:out value="${criteria.gu}"/>'>
                </form>
				
				<form id="deleteForm" action = '/board/remove' method = 'post'>
					<input type="hidden" name="bno" value="${board.bno }">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
            </div>
            <!-- 상세보기 본문 -->
        </div>
    </div>
</div>

<!-- reply 모듈 -->
<!-- <script src="/resources/js/board/reply.js"></script> -->

<!-- read javascript -->
<%@include file="/resources/js/board/read_js.jsp"%>
<%@include file="/resources/js/report_js.jsp"%>
<%@include file="/resources/js/board/userClick_js.jsp"%>



</body>

</html>