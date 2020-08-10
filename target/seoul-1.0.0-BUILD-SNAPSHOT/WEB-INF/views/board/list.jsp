<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/board/list.css">
<link rel="stylesheet" href="/resources/css/common/basic.css">
<title>서울이웃 :: I SEOUL U</title>
</head>
<body>

	<!-- header include ------------>
	<%@include file="../common/header.jsp"%>
	<!-- header include -->

	<!-- 그라데이션 배경 -------------------->
	<div id="bg-box">
		<div class="shape"></div>
	</div>
	<!-- 그라데이션 배경 -->
	
	<main id="#content" class="site-main" role="main">
		<!-- 물결 위 컨테이너(추천 및 인기글 목록 테이블) ---------------------------------------------------------------------------------------------->
		<div id="top-container" class="container">
			<!-- 상단 영역(지역선택 + 서울시 새소식 + 서울의 문화공연 소식) --------------------------------------------------------->
			<div class="row pb-3 pt-3">
				<!-- 지역선택 --------------------------------------------------------------------->
				<div id="locationSelect" class="col-xl-12 p-3">
						<div class="form-row">
							<div class="title-box">
								<h4 class="select-span pr-2 mb-0">지역선택 </h4>
								<select id="selectGu" style="Width: 150px" name="gu"
									class="form-control selectBox"
									onchange="document.location='list?amount=<c:out value="${pageMaker.cri.amount}"/>&gu='+this.value;">
									<option selected><c:out value="${criteria.gu}" /></option>
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
						</div>
					</div>
				<!-- 지역선택 -->
				<div class="col-xl-12 card-deck ml-0">
					<!-- 서울시 새소식 --------------------->
					<div id="seoulNews" class="card text-center p-4">
						<div class="card-title">
							<img class="icon pb-2" src="/resources/img/board/heart.png"
								alt="아이콘" /> <label>서울시 새소식</label>
						</div>
						<div class="newsImageBox">
							<img src="/resources/img/board/image1.png"> <img
								src="/resources/img/board/image2.png"> <img
								src="/resources/img/board/image3.png"> <img
								src="/resources/img/board/image4.png"> <img
								src="/resources/img/board/image5.png">
						</div>
					</div>
					<!-- 서울시 새소식 -->

					<!-- 서울 문화공연 ---------------------------->
					<div id="seoulCulture" class="card text-center p-4">
						<div class="card-title">
							<img class="icon pb-2" src="/resources/img/board/popcorn.png"
								alt="아이콘" /> <label>서울시 문화공연</label>
						</div>
						<div class="card-body p-0">
							<div class="c-content-container">
								<div class="text-container">
									<p class="m-0">
										<a class="c-link" href="${cultureLink }">${cultureTitle}</a>
									</p>
									<p class="m-0">
										<i class="fas fa-map-marker-alt"></i> 장소: ${culturePlace }<br>
										<i class="far fa-calendar-alt"></i> 기간: ${cultureDate}
									</p>
								</div>
							</div>
							<div class="image-container">
								<img class="pic" src=${cultureImg }
									onerror="this.src='/resources/img/common/noimage.gif'">
							</div>
						</div>
					</div>
					<!-- 서울 문화공연 -->
				</div>
			</div>
			<!-- 상단 영역(지역선택 + 서울시 새소식 + 서울의 문화공연 소식) -->

			<!-- 중간 테이블 --------------------------------------------------------------------->
			<div class="row">
				<div class="col-xl-12">
					<div class="panel panel-default">
						<div class="panel-heading title-box">
							<!-- 로그인 하지 않은 상태에서 노출 ::: 목록  -------------------------------------------------->
							<sec:authorize access="isAnonymous()">
								<h4 class="select-span">서울이웃에 방문해주셔서 감사합니다.</h4>
							</sec:authorize>
							<!-- 로그인 하지 않은 상태에서 노출 ::: 목z록  -->

							<!-- 로그인 한 상태에서 노출 ::: 목록  -------------------------------------------------->
							<sec:authorize access="isAuthenticated()">
								<h4 class="select-span">
									<span class="font-recipe" style="color: #827ffe;"><c:out value="${member.nickname}"/></span>님,
									<span class="font-recipe" style="color: #827ffe;"><c:out value="${criteria.gu}" /></span>의 이야기를 들어보세요!
								</h4>
							</sec:authorize>
							<!-- 로그인 한 상태에서 노출 ::: 목록  -->
						</div>
					</div>
				</div>
				
				<!-- 추천수가 많은 소식 ~ 테이블 시작 -------------------------------->
	            <div class="col-xl-12">
					<div class="row pt-3">
						<div class="col-xl-4 best-row">
							<!-- 선택된 지역의 추천수가 많은 테이블 ---------------------------------------------------------------------------------------------->
							<div class="best-content-title">
								<h5>추천 수가 많은 소식</h5>
							</div>
							<ol class="best-ol pt-3">
								<c:forEach items="${locationlist}" var="board" begin="0" end="3" step="1" varStatus="i">
									<li style="width:100%">
										<div><b>[<c:out value="${board.location}"/>]</b></div>
										<div><a class='move' href='<c:out value="${board.bno}"/>'><c:out value="${board.title}"/></a></div>
										<div><i class="far fa-thumbs-up"></i> <c:out value="${board.like_count}"/></div>
									</li>
								</c:forEach>
							</ol>
							<!-- 선택된 지역의 추천수가 많은 테이블 -->
						</div>
						
						<div class="col-xl-4 best-row">
							<!-- 선택된 지역의 댓글수가 많은 테이블 ---------------------------------------------------------------------------------------------->
							<div class="best-content-title">
								<h5>댓글 수가 많은 소식</h5>
							</div>
							<ol class="best-ol pt-3">
								<c:forEach items="${locationlist}" var="board" begin="4" end="7" step="1" varStatus="i">
									<li style="line-height: 20px;">
										<div><b>[<c:out value="${board.location}"/>]</b></div>
										<div><a class='move' href='<c:out value="${board.bno}"/>'><c:out value="${board.title}"/></a></div>
										<div><i class="far fa-comment"></i> <c:out value="${board.reply_count}"/></div>
									</li>
								</c:forEach>
							</ol>
								<!-- 선택된 지역의 댓글수가 많은 테이블 -->
						</div>
						
						<div class="col-xl-4 best-row">
							<!-- 서울 전지역의 인기글 테이블 ---------------------------------------------------------------------------------------------->
							<div class="best-content-title">
								<h5>서울전체 인기 소식</h5>
							</div>
							<ol class="best-ol pt-3">
								<c:forEach items="${locationlist}" var="board" begin="8" end="11" step="1" varStatus="i">
									<li>
										<div><b>[<c:out value="${board.location}"/>]</b></div>
										<div><a class='move' href='<c:out value="${board.bno}"/>'><c:out value="${board.title}"/></a></div>
										<div><i class="far fa-comment"></i> <c:out value="${board.reply_count}"/></div>
									</li>
								</c:forEach>
							</ol>
							<!-- 서울 전지역의 인기글 테이블 -->
						</div>
					</div>
				</div>
			
			<!-- 상단 영역(추천 및 인기글 목록 테이블) -->
				
				
				
			</div>
			<!-- 물결 위 컨테이너(추천 및 인기글 목록 테이블) -->
				
			</div>
			<!-- 중간 테이블 -->
 			
		
		<!-- 물결 ------------------------------------------------->
		<svg class="editorial mt-5 mb-3" xmlns="http://www.w3.org/2000/svg"
			xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 24 150 28 "
			preserveAspectRatio="none">
	    	<defs>
	    		<path id="gentle-wave"
				       d="M-160 44c30 0 
		      			  58-18 88-18s
	   				      58 18 88 18 
	   			 	      58-18 88-18 
	      				  58 18 88 18
	    			 	  v44h-352z" />
	     	</defs>
	     	<g class="parallax1"><use xlink:href="#gentle-wave" x="50" y="3" fill="#827FFE"/></g>
	     	<g class="parallax2"><use xlink:href="#gentle-wave" x="50" y="0" fill="#6866CC"/></g>
	        <g class="parallax3"><use xlink:href="#gentle-wave" x="50" y="9" fill="#9B99FF"/></g>
	        <g class="parallax4"><use xlink:href="#gentle-wave" x="50" y="6" fill="#FFF"/></g>
	    </svg>
		<!-- 물결 -->
		
		<!-- 하단 영역(선택지역 카테고리별 목록 테이블) ---------------------------------------------------------------------------------------------->
		<div id="page-wrapper" class="container">
			<div class="row">
				<div class="col-lg-12 pt-5">
						<div class="panel-heading title-box"><h4><span class="font-recipe" style="color: #827ffe;"><c:out value="${criteria.gu}"/></span>의 전체이야기</h4></div>
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
						
						<div class="pull-right pt-3 pb-3">
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
								<table class="table table-hover tabtable" id="dataTables-example">
									<thead>
										<tr style="text-align: center;">
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
												<td><i class='far fa-eye'></i> <c:out value="${board.view_count}"/></td>
												<td><i class="far fa-thumbs-up"></i> <c:out value="${board.like_count}"/></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								
								<!-- 선택지역의 카테고리(전체) 글목록-->
							</div>
							<div id="menu1" class="navlinktab tab-pane fade">
								<table style="Width:100%"
									class="table table-hover tabtable" id="dataTables-example">
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
									class="table table-hover tabtable" id="dataTables-example">
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
									class="table table-hover tabtable" id="dataTables-example">
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
						<button id="regBtn" type="button" class="btn button-colored btn-xs float-right">글쓰기</button>
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
						<input type='hidden' id="pageNum" name='pageNum' value='${pageMaker.cri.pageNum}'> 
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
		</div>
		<!--page-wrapper end  -->
	</main>
	<div class="container" style="text-align:center;">
		<div class='row pt-3 pb-3'>
			<div class="col-lg-12">
				<!-- 검색---------------------------------------------------------------------------------------------->
				<form id='searchForm' action="/board/list" method='get'>
					<select name='type'>
						<%-- <option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>---</option>
						<option value="A" <c:out value="${pageMaker.cri.type eq 'A'?'selected':''}"/>>전체</option> --%>
						<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
						<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
						<option value="N" <c:out value="${pageMaker.cri.type eq 'N'?'selected':''}"/>>작성자</option>
						<option value="L" <c:out value="${pageMaker.cri.type eq 'L'?'selected':''}"/>>지역</option>
					</select> 
					
					<input type='text' name='keyword' id='keyword' style="border: 1px solid #c3c3c3;"/> 
					<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'> 
					<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
					<input type='hidden' name='gu' value='<c:out value="${criteria.gu}"/>'>
					<button class='btn btn-default' id="searchFormBtn">검색</button>
				</form>
				<!-- 검색-->
			</div>
			<!-- col end -->
		</div>
		<!-- row end -->
	</div>
	
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