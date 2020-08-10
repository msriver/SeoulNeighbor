<!-- register.jsp ---------------->
<!-- 
1. 메인
1.1 왼쪽 사이드
1.1.1 이름으로 지역선택
1.1.1.1 구선택
1.1.1.2 동선택
1.1.2 지도
1.2 작성 폼
1.2.1 타이틀
1.2.1.1 카테고리 선택
2. javaScript -->
<!-- register.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<!-- customStyle ------------>
<link rel="stylesheet" href="/resources/css/mypage/profile-basic.css">
<link rel="stylesheet" href="/resources/css/mypage/profile-formpage.css">
<link rel="stylesheet" href="/resources/css/common/basic.css">
<link rel="stylesheet" href="/resources/css/board/style.css">
<!-- include summernote css -->
<link rel="stylesheet" type="text/css" href="/resources/css/summernote/summernote-lite.css">

</head>
<body>
<!-- header include ------------>
<%@include file="../common/header.jsp"%>
<!-- header include -->
<!-- 1. 메인 ------------------------>
	<main class="container">
		<div class="row">
			<div class="col-xl-3">
				<!-- 1.1 왼쪽 사이드 ------------------->
				<div id="leftside_wrap">
					<h4>글 작성하기</h4>
					<!-- 1.1.1 이름으로 지역선택 --------------->
				<div id="gudongchoice_wrap">
					<!-- 1.1.1.1 구선택 ------------->
					<div class="dropdown">
					    <button class="btn dropdown-toggle" type="button" id="selectGu" data-toggle="dropdown">구
					    <span class="caret"></span></button>
				    	<div id="gu" class="dropdown-menu" aria-labelledby="dropdownMenuButton">
							<a class="dropdown-item" href="#">강남구</a>
							<a class="dropdown-item" href="#">강동구</a>
							<a class="dropdown-item" href="#">강북구</a>
							<a class="dropdown-item" href="#">강서구</a>
							<a class="dropdown-item" href="#">관악구</a>
							<a class="dropdown-item" href="#">광진구</a>
							<a class="dropdown-item" href="#">구로구</a>
							<a class="dropdown-item" href="#">금천구</a>
							<a class="dropdown-item" href="#">노원구</a>
							<a class="dropdown-item" href="#">도봉구</a>
							<a class="dropdown-item" href="#">동대문구</a>
							<a class="dropdown-item" href="#">동작구</a>
							<a class="dropdown-item" href="#">마포구</a>
							<a class="dropdown-item" href="#">서대문구</a>
							<a class="dropdown-item" href="#">서초구</a>
							<a class="dropdown-item" href="#">성동구</a>
							<a class="dropdown-item" href="#">성북구</a>
							<a class="dropdown-item" href="#">송파구</a>
							<a class="dropdown-item" href="#">양천구</a>
							<a class="dropdown-item" href="#">영등포구</a>
							<a class="dropdown-item" href="#">용산구</a>
							<a class="dropdown-item" href="#">은평구</a>
							<a class="dropdown-item" href="#">종로구</a>
							<a class="dropdown-item" href="#">중구</a>
							<a class="dropdown-item" href="#">중랑구</a>
						</div>
					</div>
					<!-- 1.1.1.1 구선택 -->
					<!-- 1.1.1.2 동선택 ------------->
					<div class="dropdown">
					    <button class="btn dropdown-toggle" type="button" id="selectDong" data-toggle="dropdown">동
					    	<span class="caret"></span>
					    </button>
				    	<div id="dong" class="dropdown-menu" aria-labelledby="dropdownMenuButton">
						</div>
					</div>
					<!-- 1.1.1.2 동선택 -->
				</div>
				<!-- 1.1.1 이름으로 지역선택 -->	
				<div>
					<p id="gu_notice" class="board_notice">다른 지역구에 작성하려면 구를 선택하세요!</p>
					<p id="dong_notice" class="board_notice">동을 직접 선택하거나 지도를 클릭해보세요!</p>
				</div>
				<!-- 1.1.2 지도 ------------------------>
				<div class="map_wrap">
				    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
				    <!-- 카카오 지도 앱키 -->
					<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a12736a6f1b3f9306ad9531ab47e6e4&libraries=services"></script>
				</div>
				<!-- 1.1.2 지도 -->
				</div>
				<!-- 1.1 왼쪽 사이드 -->		
			</div>
			<div class="col-xl-9">
				<!-- 1.2 작성 폼 ------------------>
		        <form name="frm" role="form" action="/board/register" method="Post">
       				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
       				<!-- 1.2.1 타이틀 ----------------------->
       				<div id="title_wrap">
	       				<!-- 1.2.1.1 카테고리 선택 -------->
			        	<div class="dropdown" id="category_wrap">
			        		<input type="hidden" id="category" name="category" value="<c:out value='${board.category}'/>">
						    <button class="btn dropdown-toggle" type="button" id="selectcategory" data-toggle="dropdown">카테고리
						    	<span class="caret"></span>
						    </button>
					    	<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
						    	<a class="dropdown-item" href="#">소통해요</a>
						    	<a class="dropdown-item" href="#">불만있어요</a>
						    	<a class="dropdown-item" href="#">모여요</a>
							</div>
						</div>
						<!-- 1.2.1.1 카테고리 선택 -->
						<input type="text" id="title" name="title" placeholder="제목" maxlength="60"><br><!-- 글제목 -->
       				</div>
       				<!-- 1.2.1 타이틀 -->
		            <input type="hidden" name="userid" value="<c:out value='${member.userid}'/>"><!-- 유저아이디 -->
		            <input type="hidden" name="nickname" value="<c:out value='${member.nickname}'/>"><!-- 유저아이디 -->
					<textarea name="content" id="content" class="summernote" cols="80" rows="15"></textarea><br><!-- 글내용 -->
					<input type="hidden" id="location" name="location" value="<c:out value="${member.member_location}"/>"><!-- 지역 -->
					<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'> 
					<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
					<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>'>
					<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'>
					<input type='hidden'id="criteria_gu" name='gu' value='<c:out value="${criteria.gu}"/>'>
					<button type="submit" id="register_btn" class="btn button-colored bottomButton" onclick="return boardCheck()">작성</button><!-- 작성버튼 -->
					<button type="button" class="btn button-gray bottomButton"  onClick="history.go(-2)">취소</button><!-- 취소버튼 -->
		        </form>
		        <!-- 1.2 수정 폼 -->
			</div>
		</div>
	</main>
<!-- 1. 메인 -->
</body>
<!-- 2. javaScript ------------------------------>
<%@include file="/resources/js/map/map_js.jsp"%>
<%@include file="/resources/js/board/board_js.jsp"%>
<!-- include summernote js-->
<script src="/resources/js/summernote/summernote-lite.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>
<!-- 2. javaScirpt -->
</html>