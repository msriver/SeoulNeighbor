<!-- subLogin.jsp ---------------->
<!-- 
sub login page 
수정해야할 것
1) 로그인 실패시 main으로 돌아감
2) 주석 정리 X
-->
<!-- subLogin.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
<title>서울이웃 :: I SEOUL U</title>
<!-- jQuery library ------------>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- 3. CSS ------------------------------>
<link rel="stylesheet" href="/resources/css/common/index.css">
<!-- 3. CSS -->
<!-- Latest compiled and minified CSS ------------>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<!-- Latest compiled JavaScript ------------>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<!-- fontawesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
</head>

<body>
	
	<!-- 1. Landing page ------------------------------>	
	<div class="container-simple">
		<div class="wrap-login">
			<form class="container-form validate-form p-3" action="/login" method="post" role="form">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<span class="login-form-title pt-3 pb-4">
					<a href="/"><img class="m-5" src="../resources/img/common/logoblack-borderw.png" width="220px" alt="logo"></a>
				</span>
				<!-- 1.1 로그인 폼 ------------------------------>
				<div class="login-body pb-3">
					<div class="wrap-input validate-input mb-3" data-validate="아이디를 입력해주세요">
						<input class="input-text" type="text" name="username" placeholder="아이디"> <span class="focus-on-input"></span>
					</div>
					<div class="wrap-input validate-input mb-3" data-validate="비밀번호를 입력해주세요">
						<input class="input-text" type="password" name="password" placeholder="비밀번호"> <span class="focus-on-input"></span>
					</div>
					<c:if test="${param.error}">
						<div class="error-message pb-3">
							<c:out value="${message}">가입하지 않은 아이디이거나, 잘못된 비밀번호입니다.</c:out>
						</div>
					</c:if>
					<div class="container-login-button pb-3">
						<button type="submit" class="button-colored login-button">로그인</button>
					</div>
					<div class="row">
						<div class="col-md-6">
							<input class="input-checkbox" id="remember-me-checkbox" type="checkbox" name="remember-me">
							<label class="label-checkbox" for="remember-me-checkbox">로그인 상태 유지</label>
						</div>
						<div class="col-md-6 text-right">
							<a href="/find_id_pw" class="text-colored"> 비밀번호 찾기 </a>
						</div>
					</div>
				</div>
				<div class="add-border-top text-center pt-4 pb-1">
					<p>아직 서울이웃의 회원이 아니신가요?</p>
					<a href="/join" class="text-colored">회원가입 하기</a>
				</div>
			</form>
			<!-- 1.1 로그인 폼 -->
			
			<!-- 1.2 비회원 입장 ------------------------------>
				<div class="text-center pr-3 pl-3 pb-3">
					<p class="mb-1">비회원으로 입장하시겠어요?</p>
					<form action="/list">
						<div class="row">
							<div class="col-xl-8 pr-0">
								<div class="form-row">
									<select id="selectGu" name="gu" class="form-control selectBox">
										<option selected>지역을 선택하세요</option>
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
							<div class="col-xl-4">
								<div class="container-login-button">
									<button class="mini-button pass-button">입장</button>
								</div>
							</div>
						</div>
					</form>
				</div>
				<!-- 1.2 비회원 입장 -->
		</div>
	</div>
	<!-- 1. Landing page -->	

</body>

<!-- 2. javaScript ------------------------------>
<%@include file="/resources/js/index_js.jsp"%>
<!-- 2. javaScirpt -->
</html>