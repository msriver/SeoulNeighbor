<!-- index.jsp ---------------->
<!-- 
-CSS 적용
0. 상단 네비게이션 바
1. 메인 페이지 전체
	1.1 로그인 폼 (자동로그인/비밀번호 찾기, 회원가입)
	1.2 비회원 접속
-자바스크립트 적용
-->
<!-- index.jsp -->


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
<title>서울이웃 :: I SEOUL U</title>
<!-- CSS style ------------------------------>
<link rel="stylesheet" href="/resources/css/common/index.css">
</head>

<body>
	<!-- 0. 상단 네비게이션 바 ------------>
	<%@include file="common/header.jsp"%>
	<!-- 0. 상단 네비게이션 바 -->

	<!-- 1. 메인 페이지 전체 ------------------------------>	
	<div class="container">
		<div class="wrap-login">
			<!-- 1.1 로그인 폼 ------------------------------>
			<form class="container-form validate-form p-3" action="/login" method="post" role="form">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<span class="login-form-title pt-3 pb-4">Login</span>
				<div class="login-body pb-3">
					<div class="wrap-input validate-input mb-3" data-validate="아이디를 입력해주세요">
						<input class="input-text" type="text" name="username" placeholder="아이디"> <span class="focus-on-input"></span>
					</div>
					<div class="wrap-input validate-input mb-3" data-validate="비밀번호를 입력해주세요">
						<input class="input-text" type="password" name="password" placeholder="비밀번호"> <span class="focus-on-input"></span>
					</div>
					<div class="container-login-button pb-3">
						<button type="submit" class="button-colored login-button">로그인</button>
					</div>
					<!-- 자동로그인/비밀번호 찾기  ---------------------------------------->
					<div class="row">
						<div class="col-md-6">
							<input class="input-checkbox" id="remember-me-checkbox" type="checkbox" name="remember-me">
							<label class="label-checkbox" for="remember-me-checkbox">로그인 상태 유지</label>
						</div>
						<div class="col-md-6 text-right">
							<a href="/find_id_pw" class="text-colored"> 비밀번호 찾기 </a>
						</div>
					</div>
					<!-- 자동로그인/비밀번호 찾기  -->
				</div>
				<!-- 회원가입  ---------------------------------->
				<div class="add-border-top text-center pt-4">
					<p>아직 서울이웃의 회원이 아니신가요?</p>
					<a href="/join" class="text-colored">회원가입 하기</a>
				</div>
				<!-- 회원가입  -->
			</form>
			<!-- 1.1 로그인 폼 -->
			
			<!-- 1.2 비회원 입장 ------------------------------>
				<div class="text-center pr-3 pl-3 pb-3">
					<p class="mb-1">비회원으로 입장하시겠어요?</p>
					<form action="board/list">
						<div class="row pr-3 pl-3">
							<div class="col-xl-8">
								<div class="form-row mr-0 ml-0">
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
	<!-- 1. 메인 페이지 -->	
	
</body>

<!-- javaScript ------------------------------>
<%@include file="/resources/js/index_js.jsp"%>
<!-- javaScirpt -->

</html>