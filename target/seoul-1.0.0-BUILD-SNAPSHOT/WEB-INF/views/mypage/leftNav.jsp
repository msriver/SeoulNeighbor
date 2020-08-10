<!-- leftNav.jsp ---------------->
<!-- 
1. 왼쪽 메뉴
1.1 프로필 이미지
1.2 메뉴바
2. 드롭다운 버튼
3. 프로필 사진 바꾸기 모달
4. 자바스크립트 -->
<!-- leftNav.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- leftNav.css -->
<link rel="stylesheet" type="text/css" href="/resources/css/mypage/left_nav.css">
<link rel="stylesheet" href="/resources/css/mypage/profile-formpage.css">
</head>
<body>
<!-- 1.왼쪽 메뉴 ---------------------------------------------->
	<div id="leftNavContainer" class="container-fluid pt-5">
	<!-- 1.1 프로필 이미지 --------------------------->
		<div></div>
		<div id="profileImg" class="card text-center">
			<c:choose>
				<c:when test = "${member.member_filename eq null }">
		  		<img class="card-img-top" src="/resources/img/mypage/profile_sample.png" alt="프로필 사진">
		  		</c:when>
		  		<c:when test = "${member.member_filename != null}">
		  		<img class="card-img-top leftnav-photo" src="/profile/image/<c:out value="${member.member_filename}"/>" onerror='this.src="/resources/img/mypage/profile_sample.png"' alt="프로필 사진">
		  		</c:when>
		  	</c:choose>
			<div class="card-body filebox text-center"  data-toggle="modal" data-target="#changePicture" style="overflow:hidden; top:-45px; position:relative">
				<label id="changeProfilePictureBtn"><i class="fas fa-camera"></i></label>
			</div>
		</div>
	<!-- 1.1 프로필 이미지 -->
	<h6 class="hello-msg">${member.nickname }님 반갑습니다.</h6>
	<!-- 1.2 메뉴바 ----------------------------->
	
		<div id="leftNavBar" class="container-fluid sidebar">
			<ul class="nav flex-column">
		    <li class="nav-item">
		    	<a class="nav-link" href="/profile">프로필</a>
		    </li>
		    <li class="nav-item">
		    	<a class="nav-link" href="/mylist">나의 게시글 보기</a>
		    </li>
		    <li class="nav-item">
		    	<a class="nav-link" href="/myMessage">쪽지함</a>
		    </li>
		    <li class="nav-item">
		    	<a class="nav-link" href="/myQA">1:1 문의</a>
		    </li>
		    <li class="nav-item">
		    	<a class="nav-link" href="/myPassword">비밀번호 변경</a>
		    </li>
		    </ul>
		</div>
	<!-- 1.2 메뉴바 -->
	</div>
<!-- 1.왼쪽 메뉴 -->

<!-- 2. 드롭다운 버튼 --------------------------------->
	<button id="dropDownBtn" class="btn btn-secondary justify-content-center"><i id="dropDownBtnIcon" class="fas fa-angle-right"></i></button>
<!-- 2. 드롭다운 버튼 -->

<!-- 4.자바스크립트------------------------>
<%@include file="/resources/js/mypage/profile_js.jsp"%>
<%@include file="/resources/js/mypage/left_nav_js.jsp"%>
<!-- 4.자바스크립트 -->
</body>
</html>