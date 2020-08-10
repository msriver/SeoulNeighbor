<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- CSS style -------------------------------------------------------------------------------->
<link rel="stylesheet" href="../resources/css/common/basic.css">
<link rel="stylesheet" href="../resources/css/common/find-form.css">
<!-- CSS style -->
</head>

<body>
	<!-- 상단 네비게이션 바 ----------------------------------------------->
	<%@include file="../common/header.jsp"%>
	<!-- 상단 네비게이션 바 -->
	
	<div class="container p-5">
		<!-- 아이디 / 비밀번호 찾기 탭 ------------------------------------------------------>
		<ul class="nav nav-tabs">
			<li><a class="nav-link" data-toggle="tab" href="#find-id">아이디 찾기</a></li>
			<li><a class="nav-link" data-toggle="tab" href="#find-pw">비밀번호 찾기</a></li>
		</ul>
		<!-- 아이디 / 비밀번호 찾기 탭 -->
		
		<div class="tab-content">
			<!-- 아이디 찾기 탭 ------------------------------------------------------>
			<div id="find-id" class="tab-pane active">
				<div id="id-fieldset" class="p-5">
					<label for="email">이메일</label> 
					<input type="email" id="email" name="email" />
					<div class="float-right pt-3 pb-1">
						<button type="reset" class="btn button-gray" onclick=" location.href='/subLogin'">취소</button>
						<button id="id-find-button" class="btn button-colored">확인</button>
					</div>
				</div>
			</div>
			<!-- 아이디 찾기 탭 -->
			
			<!-- 비밀번호 찾기 탭 ------------------------------------------------------>
			<div id="find-pw" class="tab-pane">
				<div id="pw-fieldset" class="p-5">
					<label for="email">아이디</label> 
					<input type="text" id="username" name="username"/><br>
					<label for="email">이메일</label> 
					<input type="email"	id="pwemail" name="email"/>
					<div class="float-right pt-3 pb-1">
						<button type="reset" class="btn button-gray" onclick="location.href='/subLogin'">취소</button>
						<button id="pw-find-button" class="btn button-colored">확인</button>
					</div>
				</div>
			</div>
			<!-- 비밀번호 찾기 탭 -->
		</div>
	</div>
</body>

	<!-- javaScript ------------------------------>
	<%@include file="/resources/js/find_id_pw_js.jsp"%>
	<!-- javaScirpt -->

</html>