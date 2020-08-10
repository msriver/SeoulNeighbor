<!-- mylist.jsp ---------------->
<!-- 
1. 메인
1.1 왼쪽 메뉴
1.2 나의 게시글 레이아웃
2. 자바스크립트 -->
<!-- profile.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>나의 게시글 보기</title>
<link rel="stylesheet" href="/resources/css/common/basic.css">
<link rel="stylesheet" href="/resources/css/mypage/profile-basic.css">
<link rel="stylesheet" href="/resources/css/mypage/profile-tablepage.css">
</head>
<body>
	<!-- header include ------------>
	<%@include file="../common/header.jsp"%>
	<!-- header include -->
	
	<!-- 1. 메인 ------------------------------------------------->
	<div class="container pt-0">
		<div class="row">
		<!-- 1.1 왼쪽 메뉴 ---------------------------->
			<div id="leftNav" class="col-lg-3">
				<!-- header include ------------>
				<%@include file="leftNav.jsp"%>
				<!-- header include -->
			</div>
		<!-- 1.1 왼쪽 메뉴 -->
		<!-- 1.2 나의 게시글 레이아웃 ---------------------------------->
			<div id="rightDiv" class="col-lg-9 p-5">
				<h1>나의 게시글</h1>
				<div id="rightDivContent" class="wrap-table mt-5">
					<table class="table text-center">
						<thead>
							<tr>
								<th>지역</th>
								<th>카테고리</th>
								<th>제목</th>
								<th>추천</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody id="messageList">
							<c:forEach items="${board}" var="board">
							<tr>
								<td style="display:none">${board.bno}</td>
								<td>${board.location }</td>
								<td>${board.category}</td>
								<td><span class="boardTitle">${board.title}</span> [${board.reply_count}]</td>
								<td>${board.like_count}</td>
								<td>${board.regdate}</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				<!-- 1.3 페이지 버튼 출력 부분 -------------------------------->
					<nav>
						<ul id="pageNumBtnList" class="pagination justify-content-center"></ul>
					</nav>
				<!-- 1.3 페이지 버튼 출력 부분 -->
				</div>
			</div>
		<!-- 1.2 나의 게시글 레이아웃 -->
		</div>
	</div>
	<!-- 1. 메인 -->
	<!-- 3. 프로필 사진 바꾸기 모달 ----------------------->
	<div class="modal" id="changePicture">
		<div class="modal-dialog modal-sm modal-dialog-centered">
			<div class="modal-content">
        <!-- Modal Header -->
				<div class="modal-header">
				<h4 id="pictureHeader" class="modal-title">프로필 이미지 변경</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
        <!-- Modal body -->
				<div class="modal-body">
						<div id="profileChangeImgBox" class="card">
						<form class="form-group" method="post" action="updateUser" enctype="multipart/form-data">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<c:choose>
								<c:when test="${member.member_filename eq null }">
									<img id="profileChangeImg"
										class="card-img-top"
										src="/resources/img/mypage/profile_sample.png" alt="프로필 사진">
								</c:when>
								<c:when test="${member.member_filename != null }">
									<img id="profileChangeImg" class="card-img-top"
										src="/profile/image/<c:out value="${member.member_filename}"/>"
										alt="프로필 이미지">
								</c:when>
							</c:choose>
	
							<div class="card-body filebox text-center">
								<label id="uploadBtn" for="uploadFile">업로드</label> <input
									type="file" id="uploadFile" name="uploadFile" /> <input
									type="hidden" id="isFileChanged" name="isFileChanged"
									value="false" />
							</div>
							<div id="fileNameContainer">
								<input type="hidden" name="member_filename"
									value="${member.member_filename }">
							</div>
							<input type="hidden" name="userid" value="${member.userid }">
							<input type="hidden" name="nickname" value="${member.nickname }">
							<input type="hidden" name="email" value="${member.email }">
							<input type="hidden" name="member_location" value="${member.member_location }">
							<input type="submit" class="btn" value="프로필 저장" style="background-color:#827FFE; color:white">
						</form>
						</div>
				</div>
			</div>
		</div>
	</div>
<!-- 3. 프로필 사진 바꾸기 모달 -->
<!-- 2.자바스크립트------------------------>
<%@include file="/resources/js/mypage/myList_js.jsp"%>
<!-- 2.자바스크립트 -->
</body>
</html>