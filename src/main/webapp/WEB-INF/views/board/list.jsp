<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/board/list.css">
<title>Insert title here</title>
</head>
<body>
 <header id="parallax_main" class="collapsing-parallax">

<div id="includehe">
	<!-- header include ------------>
	<%@include file="../common/header.jsp"%>
	<!-- header include -->
</div>
</header>
<main id="#content" class="site-main" role="main">
	<div id="page-wrapper" class="container">
		<!-- 상단 영역(추천 및 인기글 목록 테이블) ---------------------------------------------------------------------------------------------->
		<div class="row pb-3 pt-5">
			<div id="listLeft" class="col-lg-6">
				<!-- 서울시 새소식 --------------------->
				<div id="seoulNews" class="text-center">
				<h5>서울시 새소식</h5>
				</div>
				<!-- 서울시 새소식 -->
				<div class="page-header">
					<!-- 상단 영역(추천 및 인기글 목록 테이블) ---------------------------------------------------------------------------------------------->
						<div class="form-row">
						<span class="mr-4" style="text-align: center; line-height:38px"><b>지역선택 : </b></span>
									<select id="selectGu" style="Width:150px" name="gu" class="form-control selectBox" 
									onchange="document.location='list?amount=<c:out value="${pageMaker.cri.amount}"/>&gu='+this.value;">
										<option selected><c:out value="${criteria.gu}"/></option>
										<option value="강남구">강남구</option>
										<option value="강동구">강동구</option>
										<option value="강북구">강북구</option>
										<option value="강서구">강서구</option>
										<option value="관악구">관악구</option>
										<option value="광진구">광진구</option>
										<option value="구로구">구로구</option>
										<option value="금천구">금천구</option>
										<option value="노원구">노원구</option>
										<option value="도봉구">도봉구</option>
										<option value="동대문구">동대문구</option>
										<option value="동작구">동작구</option>
										<option value="마포구">마포구</option>
										<option value="서대문구">서대문구</option>
										<option value="서초구">서초구</option>
										<option value="성동구">성동구</option>
										<option value="성북구">성북구</option>
										<option value="송파구">송파구</option>
										<option value="양천구">양천구</option>
										<option value="영등포구">영등포구</option>
										<option value="용산구">용산구</option>
										<option value="은평구">은평구</option>
										<option value="종로구">종로구</option>
										<option value="중구">중구</option>
										<option value="중랑구">중랑구</option>
									</select>
								</div>
								<!-- 지역선택 -->
					
      			</div>
     		 </div>
     		 <!-- 서울 문화공연 ---------------------------->
     		 <div id="seoulCulture" class="col-lg-6 text-center">
     		 <h5>서울의 문화공연 소식</h5>
     		 	<div style="float:left; width:fit-content; margin:0">
     		 		<h6><a href="${cultureLink }">${cultureTitle}</a></h6>
     		 		<h6><i class="fas fa-map-marker-alt"></i> 장소: ${culturePlace }</h6>
     		 		<h6><i class="far fa-calendar-alt"></i> 기간: ${cultureDate}</h6>
     		 	</div>
     		 	<div style="margin-left:30px">
     		 	    <img src=${cultureImg } onerror="this.src='/resources/img/common/noimage.gif'" style="height:113px;">
     		 	</div>
     		 </div>
     		 <!-- 서울 문화공연 -->
		</div>
		<div class="row">
			<div class="col-xl-8">
				<div class="panel panel-default ">
					<div class="panel-heading pb-3">
					     <!-- 로그인 하지 않은 상태에서 노출 ::: 목록  -------------------------------------------------->
		                 <sec:authorize access="isAnonymous()">
		                    <div>서울이웃에 방문해주셔서 감사합니다.</div>
		                 </sec:authorize>
		                 <!-- 로그인 하지 않은 상태에서 노출 ::: 목z록  -->
		
		                 <!-- 로그인 한 상태에서 노출 ::: 목록  -------------------------------------------------->
		                 <sec:authorize access="isAuthenticated()">
		                    <div>
		                       <c:out value="${member.nickname}"/>님,
		                       <c:out value="${criteria.gu}"/>의 이야기를 들어보세요!
		                    </div>
		                 </sec:authorize>
		                 <!-- 로그인 한 상태에서 노출 ::: 목록  -->
					</div>
				</div>
				<div class="panel panel-body">
					<div class="row">
						<div class="col-xl-6">
							<!-- 선택된 지역의 추천수가 많은 테이블 ---------------------------------------------------------------------------------------------->
							<table class="table table-striped table-bordered table-hover cardview" id="dataTables-example">
								<thead>
									<tr>
										<th colspan="3">추천 수가 많은 소식</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${locationlist}" var="board" begin="0" end="5" step="1" varStatus="i">
										<tr>
											<td>[<c:out value="${board.location}"/>]</td>
											<td><a class='move smallList' href='<c:out value="${board.bno}"/>'><c:out value="${board.title}"/></a>
												<b>[<c:out value="${board.reply_count}"/>]</b>
											</td>
											<td><i class="far fa-thumbs-up"></i> <c:out value="${board.like_count}"/></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- 선택된 지역의 추천수가 많은 테이블 -->
						</div>
						<div class="col-xl-6">
							<!-- 선택된 지역의 댓글수가 많은 테이블 ---------------------------------------------------------------------------------------------->
							<table class="table table-striped table-bordered table-hover cardview" id="dataTables-example">
								<thead>
									<tr>
										<th colspan="3">댓글 수가 많은 소식</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${locationlist}" var="board" begin="6" end="11" step="1" varStatus="i">
										<tr>
											<td>[<c:out value="${board.location}"/>]</td>
											<td><a class='move smallList' href='<c:out value="${board.bno}" />'><c:out value="${board.title}"/></a>
												<b>[<c:out value="${board.reply_count}"/>]</b>
											</td>
											<td><i class="far fa-thumbs-up"></i> <c:out value="${board.like_count}"/></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- 선택된 지역의 댓글수가 많은 테이블 -->
						</div>
					</div>
				</div>
			</div>
			<div class="col-xl-4">
				<div class="panel panel-default ">
					<div class="panel-heading pb-3">서울전체 인기 소식</div>
				</div>
				<div class="panel panel-body">
					<div class="row">
						<div class="col-xl-12">
							<!-- 서울 전지역의 인기글 테이블 ---------------------------------------------------------------------------------------------->
							<table class="table table-hover cardview" id="dataTables-example">
								<tbody>
									<c:forEach items="${locationlist}" var="board" begin="12" end="18" step="1" varStatus="i">
										<tr>
											<td>[<c:out value="${board.location}"/>]</td>
											<td><a class='move smallList' href='<c:out value="${board.bno}" />'><c:out value="${board.title}"/></a>
												<b>[<c:out value="${board.reply_count}"/>]</b>
											</td>
											<td><i class="far fa-thumbs-up"></i> <c:out value="${board.like_count}"/></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- 서울 전지역의 인기글 테이블 -->
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 상단 영역(추천 및 인기글 목록 테이블) -->

		<!-- 하단 영역(선택지역 카테고리별 목록 테이블) ---------------------------------------------------------------------------------------------->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default ">
					<div class="panel-heading pt-5 pb-3"><c:out value="${criteria.gu}"/>의 전체이야기</div>
				</div>
				<div class="panel panel-body">
					<!-- 카테고리별 네비게이션  목록---------------------------------------------------------------------------------------------->
					<ul class="nav nav-tabs" role="tablist" id="mytab">
						<li class="nav-item"><a class="nav-link active"
							data-toggle="tab" href="#all">전체</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab"
							href="#menu1">소통해요</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab"
							href="#menu2">불만있어요</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab"
							href="#menu3">모여요</a></li>
					</ul>
					<!-- 카테고리별 네비게이션  목록-->
					
					<div class="pull-right">
						<!-- 테이블 리스트 갯수 조절---------------------------------------------------------------------------------------------->
						<form id="searchFormNum" action="/board/list" method='get'>
							<select  name="amount" class="selectpicker float-right" data-style="text-right"  dir="rtl">
								<option value="20"<c:out value="${pageMaker.cri.amount == '20'?'selected':''}"/>>20개씩</option>
								<option value="30" <c:out value="${pageMaker.cri.amount == '30'?'selected':''}"/>>30개씩</option>
							</select>
							<input type='hidden' name='gu' value='<c:out value="${criteria.gu}"/>'>
						</form>
						<!-- 테이블 리스트 갯수 조절-->
					</div>
					<div class="tab-content pt-4">
						<div id="all" class="navlinktab tab-pane active">
							<!-- 선택지역의 카테고리(전체) 글목록---------------------------------------------------------------------------------------------->
							<table style="Width:100%"
								class="table table-striped table-bordered table-hover" id="dataTables-example">
								<thead>
									<tr>
										<th>글번호</th>
										<th>지역</th>
										<th>카테고리</th>
										<th>제목</th>
										<th>작성자</th>
										<th>조회수</th>
										<th>추천수</th>
									</tr>
								</thead>
								<tbody id="tbodyName">
									<c:forEach items="${list}" var="board">
										<tr>
											<td><c:out value="${board.bno}"/></td>
											<td><c:out value="${board.location}"/></td>
											<td><c:out value="${board.category}" /></td>
											<td><a class='move bigList' href='<c:out value="${board.bno}" />'><c:out value="${board.title}"/></a>
												<b>[<c:out value="${board.reply_count}"/>]</b>
											</td>
											<sec:authorize access="isAnonymous()">
		                    				<td><c:out value="${board.nickname}"/></td> <!-- 로그인 안하면 닉네임만 -->
		                 					</sec:authorize>
		                 					<sec:authorize access="isAuthenticated()"> <!-- 로그인 하면 닉네임 클릭시 쪽지보내기 가능 -->
		                 					<td><span class="userNickname" data-toggle="dropdown"><c:out value="${board.nickname}"/></span>
												<div class="dropdown-menu">
												<a class="dropdown-item sendMessageToUser" data-toggle='modal' data-target='#sendMessageUser'>쪽지 보내기</a>
												</div>
											</td>
		                 					</sec:authorize>
											<td><c:out value="${board.view_count}"/></td>
											<td><i class="far fa-thumbs-up"></i> <c:out value="${board.like_count}"/></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- 선택지역의 카테고리(전체) 글목록-->
						</div>
						
						<div id="menu1" class="navlinktab tab-pane fade">
							<table style="Width:100%"
								class="table table-striped table-bordered table-hover" id="dataTables-example">
								<thead>
									<tr>
										<th>글번호</th>
										<th>지역</th>
										<th>카테고리</th>
										<th>제목</th>
										<th>작성자</th>
										<th>조회수</th>
										<th>추천수</th>
									</tr>
								</thead>
								<tbody id="tbodyName">

									
								</tbody>
							</table>
						</div>
						<div id="menu2" class="navlinktab tab-pane fade">
							<table style="Width:100%"
								class="table table-striped table-bordered table-hover" id="dataTables-example">
								<thead>
									<tr>
										<th>글번호</th>
										<th>지역</th>
										<th>카테고리</th>
										<th>제목</th>
										<th>작성자</th>
										<th>조회수</th>
										<th>추천수</th>
									</tr>
								</thead>
								<tbody id="tbodyName">

									
								</tbody>
							</table>
						</div>
						<div id="menu3" class="navlinktab tab-pane fade">
							<table style="Width:100%"
								class="table table-striped table-bordered table-hover" id="dataTables-example">
								<thead>
									<tr>
										<th>글번호</th>
										<th>지역</th>
										<th>카테고리</th>
										<th>제목</th>
										<th>작성자</th>
										<th>조회수</th>
										<th>추천수</th>
									</tr>
								</thead>
								<tbody id="tbodyName">

									
								</tbody>
							</table>
						</div>
						
					</div>
				</div>
				<!-- 페이징---------------------------------------------------------------------------------------------->
				<div class='float-none'>
				<sec:authorize access="isAuthenticated()"><button id="regBtn" type="button" class="btn btn-success btn-xs float-right">글쓰기</button></sec:authorize>
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous"><a class="page-link" href="${pageMaker.startPage -1}">Previous</a></li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							<li class="paginate_button page-item ${pageMaker.cri.pageNum==num ? "active":""}"><a class="page-link" href="${num}">${num}</a></li>
						</c:forEach>
						<c:if test="${pageMaker.next}">
							<li class="paginate_button"><a class="page-link" href="${pageMaker.endPage +1}">Next</a></li>
						</c:if>
					</ul>
				</div>
				<form id='actionForm' action="/board/list" method="get">
					<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'> 
					<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
					<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type}"/>'>
					<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'>
					<input type='hidden' name='gu' value='<c:out value="${criteria.gu}"/>'>
				</form>
				<!-- 페이징-->
			</div>
			<!-- col end -->
		</div>
		<!-- 하단 영역(선택지역 카테고리별 목록 테이블) -->
		
		<div class='row'>
			<div class="col-lg-12">
				<!-- 검색---------------------------------------------------------------------------------------------->
				<form id='searchForm' action="/board/list" method='get'>
					<select name='type'>
						<option value="A" <c:out value="${pageMaker.cri.type eq 'A'?'selected':''}"/>>전체</option>
						<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
						<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
						<option value="N" <c:out value="${pageMaker.cri.type eq 'N'?'selected':''}"/>>작성자</option>
						<option value="L" <c:out value="${pageMaker.cri.type eq 'L'?'selected':''}"/>>지역</option>
					</select> 
					
					<input type='text' name='keyword' id='keyword' /> 
					<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'> 
					<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
					<input type='hidden' name='gu' value='<c:out value="${criteria.gu}"/>'>

									
					<button class='btn btn-default'>검색</button>
				</form>
				<!-- 검색-->
			</div>
			<!-- col end -->
		</div>
		<!-- row end -->
	</div>
	<!--page-wrapper end  -->
	</main>
	<!-- 뉴스 상세보기 모달 -->
	<div class="modal" id="newsModal">
	  <div class="modal-dialog modal-dialog-centered modal-xl">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 id="newsHeader" class="modal-title">Modal Heading</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div id="newsContent" class="modal-body">
	        Modal body..
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	<!--  자바 스크립트 ------------->
	<%@include file="/resources/js/board/userClick_js.jsp"%>
	<%@include file="/resources/js/board/list_js.jsp" %>
	<!-- 자바 스크립트 -->
</body>

</html>