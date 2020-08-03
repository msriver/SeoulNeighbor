<!-- 
	*회원가입페이지*
	작성자 강민성
	
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울이웃 회원가입1</title>

<!-- CSS style ------------------------------>
<!-- <link rel="stylesheet" href="/resources/css/common/index.css"> -->

<!-- 회원가입페이지 전용 css -->
<link rel="stylesheet" type="text/css" href="/resources/css/join/join.css">

</head>
<body>
	<!-- 0. 상단 네비게이션 바 ------------>
	<%@include file="../common/header.jsp"%>
	<!-- 0. 상단 네비게이션 바 -->

	<!-- 1. 메인 페이지 전체 ------------------------------>	
	<div class="container" style="margin-top : 60px;">
		<div class="wrap-login">
			<!-- 1.1 로그인 폼 ------------------------------>
			<form id="joinForm" class="container-form validate-form p-3" action="/join" method="post" role="form">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<span class="login-form-title pt-3 pb-4">회원가입</span>
				<div class="login-body pb-3">
				
					
						
						
					<div class="input-group mb-3">
						<div class="error-message pb-3">
							<c:out value="${warning}"></c:out>
						</div>
					</div>


					<div class="input-group mb-3">
	            		<label for="userId">아이디</label>
	            		<div class="wrap-input validate-input">
							<input id="userId" name="userid" class="input-text" type="text" placeholder="아이디(5~20자의 영소문자, 숫자)" 
							maxlength="20" onfocusout="verifyID()"> 
							<span class="focus-on-input"></span>
						</div>
						<p id="userId-wrong-text" class="wrong-text">*ID를 정확히 입력해 주세요.(5~20자의 영소문자, 숫자만 가능합니다.)</p>
	            		<p id="userId-duplicated-text" class="wrong-text">*이미 사용중인 아이디 입니다. 다시 작성해주세요</p>
	            	</div>
	            	
	            	<div class="input-group mb-3">
	            		<label for="nickName">닉네임</label>
	            		<div class="wrap-input validate-input">
							<input id="nickName" class="input-text" type="text" name="nickname" placeholder="닉네임(2~10글자)" 
							maxlength="10" onfocusout="verifyNickName()"> 
							<span class="focus-on-input"></span>
						</div>
						<p id="nickName-wrong-text" class="wrong-text">*닉네임을 정확히 입력하세요.(2~10글자)</p>
	            		<p id="nickName-duplicated-text" class="wrong-text">*중복된 닉네임입니다. 다른 닉네임을 입력하세요</p>
	            	</div>
	            	
	            	<div class="input-group mb-3">
	            		<label for="pw">비밀번호</label>
	            		<div class="wrap-input validate-input">
							<input id="pw" class="input-text" type="password" name="userpw" placeholder="비밀번호(영문 숫자 특수문자 섞어서 6~15자 이내)" 
							maxlength="15" onfocusout="verifyPW()"> 
							<span class="focus-on-input"></span>
						</div>
						<p id="pw-wrong-text" class="wrong-text">*비밀번호(영문 숫자 특수문자 섞어서 6~15자 이내)</p>
	            	</div>
	            	
	            	<div class="input-group mb-3">
	            		<label for="pwcheck">비밀번호 재확인</label>
	            		<div class="wrap-input validate-input">
							<input id="pwcheck" class="input-text" type="password" placeholder="비밀번호(영문 숫자 특수문자 섞어서 6~15자 이내)" 
							maxlength="15" onfocusout="verifyPWcheck()"> 
							<span class="focus-on-input"></span>
						</div>
	            		<p id="pwc-wrong-text" class="wrong-text">*비밀번호가 일치하지 않거나 형식에 맞지 않습니다.</p>
	            	</div>
	            	
	            	<div id="email-input-group" class="input-group mb-3">
	            		<label for="email">이메일</label>
	            		<div class="wrap-input email-wrap-input validate-input">
							<input id="email" class="input-text" type="text" name="email" placeholder="이메일 주소 입력" onfocusout="verifyEmail()"> 
							<button id="emailSend" type="button" class="button-colored email-button">인증번호 발송</button>
							<span class="focus-on-input"></span>
						</div>
						
		            	<p id="email-wrong-text" class="wrong-text">*이메일을 형식이 맞지 않습니다. </p>
		            	<p id="email-duplicated-text" class="wrong-text">*사용중인 이메일입니다. 다른 이메일을 입력하세요</p>
		            	<p id="certification-not-text" class="wrong-text">*이메일 인증이 이루어지지 않았습니다.</p>
	            	</div>
					
					<div class="input-group mb-3">
	            		<label for="userid">지역</label>
	            		<div class="wrap-input validate-input">
							<select id="selectGu" class="form-control selectBox">
								<option value="-1" selected>지역을 선택하세요</option>
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
							<select id="selectDong" class="form-control selectBox">
							</select>
							<span class="focus-on-input"></span>
						</div>
						<p id="location-wrong-text" class="wrong-text">*지역을 선택해 주세요</p>
						<input id="memberLocation" type="hidden" name="member_location" value=""> 
	            	</div>
	            	
					
					<c:if test="${param.error}">
						<div class="error-message pb-3">
							<c:out value="${message}"></c:out>
						</div>
					</c:if>
					<div class="container-login-button pb-3">
						<button id="submit-btn" type="submit" class="button-colored login-button">회원가입</button>
					</div>
					
				</div>
				
			</form>
			<!-- 1.1 로그인 폼 -->
			
			
		</div>
	</div>
	<!-- 1. 메인 페이지 -->	
	
	<!-- 2. javaScript ------------------------------>
	<%@include file="/resources/js/join/join_js.jsp"%>
	<!-- 2. javaScirpt -->
</body>
</html>