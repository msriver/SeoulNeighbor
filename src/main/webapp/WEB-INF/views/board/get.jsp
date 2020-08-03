<!-- modify.jsp ---------------->
<!-- 
1. 메인
1.1 지도
1.1.1 이름으로 지역선택
1.1.1.1 구선택
1.1.1.2 동선택
1.2 수정 폼
1.2.1 카테고리 선택
1.3 취소버튼
2. javaScript -->
<!-- modify.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<!-- customStyle ------------>
<link rel="stylesheet" type="text/css" href="/resources/css/map/style.css">
<link rel="stylesheet" type="text/css" href="/resources/css/board/style.css">
<!-- include summernote css -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote-bs4.css" rel="stylesheet">
</head>
<body>
<!-- header include ------------>
<%@include file="../common/header.jsp"%>
<!-- header include -->
<!-- 1. 메인 ------------------------>
	<main class="container">
		<div class="row">
			<div class="col-md-4" id="leftside">	
			</div>
			<div class="col-md-8">
		<input type="text" id="title" name="title" value="<c:out value='${board.title}'/>" readonly><br><!-- 글제목 --> 			
		<input type="hidden" name="userid" value="<c:out value='${board.userid}'/>"><br><!-- 유저아이디 -->			
		<textarea name="content" id="content" class="summernote summernote_readonly" cols="80" rows="15"><c:out value='${board.content}'/></textarea><br><!-- 글내용 -->
		<input type="hidden" name="category" value="<c:out value='${board.category}'/>">
		<input type="hidden" id="location" name="location" value="<c:out value='${board.location}'/>"><!-- 지역 -->
		
		<!-- 1.1 조회 폼 ------------------>
		<form role="form" action="/board/modify" method="get">		
			<input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno}'/>"><!-- 글번호 -->
			<button>수정하기</button>			
			<button formmethod="POST" formaction="/board/remove">삭제</button>			
			<button formaction="/board/list">목록으로</button>
		</form>
		<!-- 1.1 조회 폼 -->
			</div>
		</div>
	</main>
<!-- 1. 메인 -->
</body>
<!-- 2. javaScript ------------------------------>
<%@include file="/resources/js/map/map_js.jsp"%>
<%@include file="/resources/js/board/board_js.jsp"%>
<!-- include summernote js-->
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/board/summernote-ko-KR.js"></script>
<!-- 2. javaScirpt -->
</html>