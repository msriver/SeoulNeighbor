<!-- myMessage.jsp ---------------->
<!-- 
1. 메인
1.1 왼쪽 메뉴
1.2 쪽지함 레이아웃
1.3 쪽지 내용 출력 부분
1.4 페이지 버튼 출력 부분
2. 답장 모달창
3. 쪽지내용 모달창
3. 자바스크립트 -->
<!-- myMessage.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>쪽지함</title>
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
		<!-- 1.2 쪽지함 레이아웃 ---------------------------------->
			<div id="rightDiv" class="col-lg-9 p-5">
				<h1>쪽지함</h1>
				<div id="rightDivContent" class="container mt-5">
				<div class="content-box">
				<!-- 1.3 쪽지 내용 출력 부분 ------------------------------->
					<table class="table text-center table-hover">
						<thead class="thead">
							<tr>
								<th style="width:20%">보낸사람</th>
								<th style="width:55%">쪽지 내용</th>
								<th style="width:15%">수신 날짜</th>
							</tr>
						</thead>
						<tbody id="messageList">
							<c:forEach items="${message}" var="message">
							<c:choose>
								<c:when test="${message.read_check eq 'N'.charAt(0) }">
									<tr>
										<td style="display:none"><input type="hidden" value="${message.mno }" /></td>
										<td>${message.nickname}</td>
										<td class="messageContent" data-toggle="modal" data-target="#readMessage">[읽지 않음] ${message.message_content}</td>
										<td>${message.writedate}</td>
										<td style="display:none"><input type="hidden" value="${message.message_content}" /></td>
									</tr>
								</c:when>
								<c:when test="${message.read_check eq 'Y'.charAt(0) }">
									<tr>
										<td style="display:none"><input type="hidden" value="${message.mno }" /></td>
										<td>${message.nickname}</td>
										<td class="messageContent" data-toggle="modal" data-target="#readMessage">${message.message_content}</td>
										<td>${message.writedate}</td>
										<td style="display:none"><input type="hidden" value="${message.message_content}" /></td>
									</tr>
								</c:when>
							</c:choose>
							</c:forEach>
						</tbody>
					</table>
				<!-- 1.3 쪽지 내용 출력 부분 -->
				
				<!-- 1.4 페이지 버튼 출력 부분 -------------------------------->
					<nav>
						<ul id="pageNumBtnList" class="pagination justify-content-center"></ul>
					</nav>
				<!-- 1.4 페이지 버튼 출력 부분 -->
				</div>
				</div>
			</div>
		<!-- 1.2 쪽지함 레이아웃 -->
		</div>
	</div>
	<!-- 1. 메인 -->
	
	<!-- 2. 답장 모달창 -------------------------------------->
	<div class="modal" id="sendMessage">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
        <!-- Modal Header -->
				<div class="modal-header">
				<h4 id="messageReplyHeader" class="modal-title">님에게 답장</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
        
        <!-- Modal body -->
				<div class="modal-body">
				<textarea class="form-control" rows="5" id="messageReplyContent" placeholder="내용을 입력하세요 (100자 미만)"></textarea>
				</div>
        <!-- Modal footer -->
				<div class="modal-footer">
				<span id="warn">(0/100)글자</span><button type="button" id="messageReplySendBtn" class="btn btn-info" data-dismiss="modal">답장</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 2. 답장 모달창 -->
	
	<!-- 3. 쪽지 내용 모달창 -------------------------------------->
	<div class="modal" id="readMessage">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
        <!-- Modal Header -->
				<div class="modal-header">
				<h4 id="messageShowHeader" class="modal-title">님의 쪽지</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
        <!-- Modal body -->
				<div class="modal-body">
					<p id="readMessageContent"></p>
				</div>
				<div class="modal-footer" style="display:initial">
					<button type="button" id="deleteMessageBtn" class="btn btn-danger float-left" data-toggle="modal" data-dismiss="modal">삭제</button>
					<button type="button" id="replyMessageBtn" class="btn btn-primary float-right" data-toggle="modal" data-dismiss="modal" data-target="#sendMessage">답장</button>
				</div>
				<div id="messageInfo"></div>
			</div>
		</div>
	</div>
	<!-- 3. 쪽지내용 모달창 -->
	
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
	
<!-- 4.자바스크립트------------------------>
<%@include file="/resources/js/mypage/myMessage_js.jsp"%>
<!-- 4.자바스크립트 -->
</body>
</html>