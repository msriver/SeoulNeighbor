<!-- myQA.jsp ---------------->
<!-- 
1. 메인
1.1 왼쪽 메뉴
1.2 1:1 문의 레이아웃
2. 자바스크립트 -->
<!-- myQA.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>1:1 문의</title>
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
		<!-- 1.2 1:1 문의 레이아웃 ---------------------------------->
			<div id="rightDiv" class="col-md-9 p-5">
				<h3>1:1 문의</h3>
				<p>서울이웃 서비스에 대해 궁금한 모든 것을 물어보세요!</p>
				<button type="button" id="QABtn" class="btn form-control" data-toggle="modal" data-dismiss="modal" data-target="#sendQA">1:1 문의 하기</button>
				<div id="rightDivContent" class="mt-5">
				<div class="content-box">
					<table class="table text-center table-hover">
						<thead class="thead">
							<tr>
								<th>처리 상태</th>
								<th>문의 사항</th>
								<th>문의 날짜</th>
							</tr>
						</thead>
						<tbody id="QAList">
							<c:forEach items="${QA}" var="QA">
							<tr>
								<td><c:choose><c:when test="${QA.q_check eq 'N' }">접수 중</c:when><c:when test="${QA.q_check eq 'Y' }">처리 완료</c:when></c:choose></td>
								<td class="QATitle" data-toggle="modal" data-dismiss="modal" data-target="#readQA">${QA.q_title}</td>
								<td>${QA.q_regdate}</td>
								<td style="display:none">${QA.q_content}</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<nav>
						<ul id="pageNumBtnList" class="pagination justify-content-center"></ul>
					</nav>
				</div>
				</div>
			</div>
		<!-- 1.2 1:1 문의 레이아웃 -->
		</div>
	</div>
	<!-- 1. 메인 -->
	<!-- 2. 문의하기 모달창 -------------------------------------->
	<div class="modal" id="sendQA">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
        <!-- Modal Header -->
				<div class="modal-header">
				<h4 class="modal-title">무엇을 도와드릴까요?</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
        <!-- Modal body -->
				<div class="modal-body">
					<input id="writeQATitle" type="text" class="form-control" placeholder="문의 제목">
					<textarea id="writeQAContent" class="form-control" rows="10" placeholder="문의 내용(1000자 이내)"></textarea>
				</div>
				<div class="modal-footer">
					<span id="qaWarn">(0/1000)글자</span><button type="button" id="insertQABtn" class="btn" data-toggle="modal" data-dismiss="modal">문의하기</button>
				</div>
				<div id="messageInfo"></div>
			</div>
		</div>
	</div>
	<!-- 2. 문의하기 모달창 -------------------------------------->
	<!-- 3. 문의내용 모달창 -->
		
	<div class="modal" id="readQA">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
        <!-- Modal Header -->
				<div class="modal-header">
				<h4 id="QAheader" class="modal-title"></h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
        <!-- Modal body -->
				<div class="modal-body">
					<h5 id="QAStatus">처리상태: </h5>
					<h4>문의 내용</h4>
					<p id="QAContent" style="word-break: break-all;"></p>
				</div>
			</div>
		</div>
	</div>
	<!-- 3. 문의내용 모달창 -->
	
	<!-- 3. 프로필 사진 바꾸기 모달 ----------------------->
	<div class="modal" id="changePicture">
		<div class="modal-dialog modal-sm modal-dialog-centered">
			<div class="modal-content">
        <!-- Modal Header -->
				<div class="modal-header">
				<h4 id="pictureHeader" class="modal-title">프로필 이미지 바꾸기</h4>
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
										src="/resources/img/mypage/<c:out value="${member.member_filename}"/>"
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
<!-- 4.자바스크립트------------------------>
<%@include file="/resources/js/mypage/myQA_js.jsp"%>
<!-- 4.자바스크립트 -->
</body>
</html>