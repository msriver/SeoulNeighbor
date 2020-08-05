<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(document).ready(function(){
	var temp;
	var typeoption;
    var keywordtext;
	
	//서울 새소식 json 파싱 //////////////////////////////////
	var newsInfo = ${newsInfo};
	var newsHeader;
	var newsContent;
	for(var i = 0; i < 5 ; i++){
		newsHeader = newsInfo[i].POST_TITLE;
		newsContent = newsInfo[i].POST_CONTENT;
		$("#seoulNews").append("<div class='newsDiv'><p data-toggle='modal' data-target='#newsModal'>"+newsInfo[i].POST_TITLE+"</p><div style='display:none'>"+newsInfo[i].POST_CONTENT+"</div>")
	}
	
	$(document).on("click",".newsDiv p",function(){
		$("#newsHeader").text($(this).text());
		$("#newsContent").html($(this).next().html());
	})
	// 서울 새소식 json 파싱 //
	
	//서울 새소식 애니메이션/////////////////////////////
	$(".newsDiv").hide();
	$(".newsImageBox img").hide();
	$(".newsDiv:nth(0)").show();
	$(".newsImageBox img:nth(0)").show();
	
	function newsAnimation(){
		setTimeout(function(){
			$(".newsDiv:nth(0)").slideUp();
			$(".newsImageBox img:nth(0)").fadeOut();
			$(".newsDiv:nth(1)").slideDown(1100);
			$(".newsImageBox img:nth(1)").fadeIn(1000);
			setTimeout(function(){
				$(".newsDiv:nth(1)").slideUp();
				$(".newsImageBox img:nth(1)").fadeOut();
				$(".newsDiv:nth(2)").slideDown(1100);
				$(".newsImageBox img:nth(2)").fadeIn(1000);
				setTimeout(function(){
					$(".newsDiv:nth(2)").slideUp();
					$(".newsImageBox img:nth(2)").fadeOut();
					$(".newsDiv:nth(3)").slideDown(1100);
					$(".newsImageBox img:nth(3)").fadeIn(1000);
					setTimeout(function(){
						$(".newsDiv:nth(3)").slideUp();
						$(".newsImageBox img:nth(3)").fadeOut();
						$(".newsDiv:nth(4)").slideDown(1100);
						$(".newsImageBox img:nth(4)").fadeIn(1000);
						setTimeout(function(){
							$(".newsDiv:nth(4)").slideUp();
							$(".newsImageBox img:nth(4)").fadeOut();
							$(".newsDiv:nth(0)").slideDown(1100);
							$(".newsImageBox img:nth(0)").fadeIn(1000);
						},5000)
					},5000)
				},5000)
			},5000)
		},5000)
	}
	
 	function startNewsAnimation(){
		newsAnimation();
		setInterval(newsAnimation,28000);
	}
	startNewsAnimation();
	//서울 새소식 애니메이션//
	
	//문화공연 제목 길면 패딩 없애기 ////////////////////////
	function longTitleNoPadding(){
		if($($(".text-container").children(1)[0]).innerHeight() >= 54){
			$(".text-container").css("padding","0");
		}
	}	
	longTitleNoPadding();
	//문화공연 제목 길면 패딩 없애기 //
	

	//하단 지역별 전체 소식 페이징/////////////////////////////
    var actionForm = $("#actionForm");
    
    $(".paginate_button a").on("click", function(e){
  	  e.preventDefault();
  	  
  	  actionForm.find("input[name='pageNum']").val($(this).attr("href"));
  	  actionForm.submit();
    });	
    //하단 지역별 전체 소식 페이징//
    
	//페이징 액티브 효과 주기 ///////////////
	function activePage(){
		$($(".pageNumber")[pageNumber%10-1]).addClass("page-item").addClass("active");
	}
	function firstActivePage(){ //탭누를때 1번페이지 무조건 액티브 주기
		$($(".pageNumber")[0]).addClass("page-item").addClass("active");
	}
	//페이징 액티브 효과 주기//
	
	//하단 지역별 소식 카테고리별 페이징(Ajax)/////////////////////////////
	var pageNumber;
    $(".pagination").on("click",".page-link", function(e){
  	  e.preventDefault();
  	  	pageNumber = $(this).html();
  	  	var lastNumber;
  	  	if(pageNumber == "Next"){
  	  		lastNumber = $($(this).parents().prev()[0]).text();
  	  		lastNumber = Number(lastNumber) + 1;
  	  		pageNumber = lastNumber;
  	  	} 
  	  	if(pageNumber == "Previous"){
  	  		lastNumber = $($(this).parents().next()[0]).text();
  	  		lastNumber = Number(lastNumber) - 1;
  	  		pageNumber = lastNumber;
  	  	}
  		var str="";
  	    var form = {
  	            category:temp,
  	            gu:'${criteria.gu}',
  	            pageNum:pageNumber,
  	         	type:typeoption,
  	          	keyword:keywordtext,
  	          	amount:'${criteria.amount}'
  	          	
  	    }
  	  
  	    if(temp=='소통해요'){
  	        $.ajax({
  	            url: "/board/BoardTabListAjax",
  	            type: "GET",
  	            data: form,
  	            success: function(data){
  	            	
  	                $("#menu1 tbody").empty();
  	                
  	                $(data.voList).each(function(i,board){
  	                     $("#menu1 tbody").append( 
  	                    			"<tr>"+
  	    							"<td>"+board.bno+"</td>"+
  	    							"<td>"+board.location+"</td>"+
  	    							"<td>"+board.category+"</td>"+
  	    							"<td><a class='move' href='"+board.bno+"'>"+board.title+"</a>"+
  	    							"<b>["+board.reply_count+"]</b>"+
  	    							"</td>"+
  	    							"<sec:authorize access='isAnonymous()'>"+
                    				"<td>"+board.nickname+"</td>"+ 
                 					"</sec:authorize>"+
                 					"<sec:authorize access='isAuthenticated()'>"+
                 					"<td><span class='userNickname' data-toggle='dropdown'>"+board.nickname+"</span>"+
									"<div class='dropdown-menu'>"+
									"<a class='dropdown-item sendMessageToUser' data-toggle='modal' data-target='#sendMessageUser'>쪽지 보내기</a></div></td></sec:authorize>"+
  	    							"<td><i class='far fa-eye'></i> "+board.view_count+"</td>"+
  	    							"<td><i class='far fa-thumbs-up'></i> "+board.like_count+"</td>"+
  	    							"</tr>" 
  	                    )                                                                        
  	                });
  	                if(data.pagedto.prev){
  	                    str += '<li class="paginate_button previous"><a class="page-link" href="${data.pagedto.startPage -1}">Previous</a></li>';
  	                 }
  	                 
  	                 for(var i = data.pagedto.startPage; i<=data.pagedto.endPage; i++){
  	                    str += '<li class="paginate_button pageNumber"><a class="page-link" href="'+i+'">'+i+'</a></li>';
  	                    
  	                 }
  	                 
  	                 if(data.pagedto.next){
  	                    str += '<li class="paginate_button"><a class="page-link" href="${data.pagedto.endPage +1}">Next</a></li>';
  	                 }
  	                 
  	                 
  	                $(".pagination").html(str);
  	              	activePage();
  	            },
  	            error: function(){
  	                alert("simpleWithObject err");
  	            }
  	        });
  	        
  	        
  	        }else if(temp=='불만있어요'){
  	            $.ajax({
  	                url: "/board/BoardTabListAjax",
  	                type: "GET",
  	                data: form,
  	                success: function(data){
  	                	
  	                    $("#menu2 tbody").empty();
  	                    $(data.voList).each(function(i,board){
  	                         $("#menu2 tbody").append(
  	                     			"<tr>"+
  	    							"<td>"+board.bno+"</td>"+
  	    							"<td>"+board.location+"</td>"+
  	    							"<td>"+board.category+"</td>"+
  	    							"<td><a class='move bigList' href='"+board.bno+"'>"+board.title+"</a>"+
  	    							"<b>["+board.reply_count+"]</b>"+
  	    							"</td>"+
  	    							"<sec:authorize access='isAnonymous()'>"+
                    				"<td>"+board.nickname+"</td>"+ 
                 					"</sec:authorize>"+
                 					"<sec:authorize access='isAuthenticated()'>"+
                 					"<td><span class='userNickname' data-toggle='dropdown'>"+board.nickname+"</span>"+
									"<div class='dropdown-menu'>"+
									"<a class='dropdown-item sendMessageToUser' data-toggle='modal' data-target='#sendMessageUser'>쪽지 보내기</a></div></td></sec:authorize>"+
  	    							"<td><i class='far fa-eye'></i> "+board.view_count+"</td>"+
  	    							"<td><i class='far fa-thumbs-up'></i> "+board.like_count+"</td>"+
  	    							"</tr>" 	
  	                        )    
  	                    });
  	                    if(data.pagedto.prev){
  	                        str += '<li class="paginate_button previous"><a class="page-link" href="${data.pagedto.startPage -1}">Previous</a></li>';
  	                     }
  	                     
  	                     for(var i = data.pagedto.startPage; i<=data.pagedto.endPage; i++){
  	                        str += '<li class="paginate_button pageNumber"><a class="page-link" href="'+i+'">'+i+'</a></li>';
  	                        
  	                     }
  	                     
  	                     if(data.pagedto.next){
  	                        str += '<li class="paginate_button"><a class="page-link" href="${data.pagedto.endPage +1}">Next</a></li>';
  	                     }
  	                     
  	                     
  	                    $(".pagination").html(str);
  	                  	activePage();
  	                },
  	                error: function(){
  	                    alert("simpleWithObject err");
  	                }
  	            });
  	        }else if(temp=='모여요'){
  	            $.ajax({
  	                url: "/board/BoardTabListAjax",
  	                type: "GET",
  	                data: form,
  	                success: function(data){
  	                	
  	                    $("#menu3 tbody").empty();
  	                    $(data.voList).each(function(i,board){
  	                         $("#menu3 tbody").append(
  	                     			"<tr>"+
  	    							"<td>"+board.bno+"</td>"+
  	    							"<td>"+board.location+"</td>"+
  	    							"<td>"+board.category+"</td>"+
  	    							"<td><a class='move bigList' href='"+board.bno+"'>"+board.title+"</a>"+
  	    							"<b>["+board.reply_count+"]</b>"+
  	    							"</td>"+
  	    							"<sec:authorize access='isAnonymous()'>"+
                    				"<td>"+board.nickname+"</td>"+ 
                 					"</sec:authorize>"+
                 					"<sec:authorize access='isAuthenticated()'>"+
                 					"<td><span class='userNickname' data-toggle='dropdown'>"+board.nickname+"</span>"+
									"<div class='dropdown-menu'>"+
									"<a class='dropdown-item sendMessageToUser' data-toggle='modal' data-target='#sendMessageUser'>쪽지 보내기</a></div></td></sec:authorize>"+
  	    							"<td><i class='far fa-eye'></i> "+board.view_count+"</td>"+
  	    							"<td><i class='far fa-thumbs-up'></i> "+board.like_count+"</td>"+
  	    							"</tr>" 	
  	                        )    
  	                    });
  	                    if(data.pagedto.prev){
  	                        str += '<li class="paginate_button previous"><a class="page-link" href="${data.pagedto.startPage -1}">Previous</a></li>';
  	                     }
  	                     
  	                     for(var i = data.pagedto.startPage; i<=data.pagedto.endPage; i++){
  	                        str += '<li class="paginate_button pageNumber"><a class="page-link" href="'+i+'">'+i+'</a></li>';
  	                        
  	                     }
  	                     
  	                     if(data.pagedto.next){
  	                        str += '<li class="paginate_button"><a class="page-link" href="${data.pagedto.endPage +1}">Next</a></li>';
  	                     }
  	                     
  	                    
  	                    $(".pagination").html(str);
  	                  	activePage();
  	                },
  	                error: function(){
  	                    alert("simpleWithObject err");
  	                }
  	            });
  	        }else if(temp=='전체'){
  	            $.ajax({
  	                url: "/board/BoardTabListAjax",
  	                type: "GET",
  	                data: form,
  	                success: function(data){
  	                	
  	                    $("#all tbody").empty();
  	                    $(data.voList).each(function(i,board){
  	                         $("#all tbody").append(
  	                     			"<tr>"+
  	    							"<td>"+board.bno+"</td>"+
  	    							"<td>"+board.location+"</td>"+
  	    							"<td>"+board.category+"</td>"+
  	    							"<td><a class='move bigList' href='"+board.bno+"'>"+board.title+"</a>"+
  	    							"<b>["+board.reply_count+"]</b>"+
  	    							"</td>"+
  	    							"<sec:authorize access='isAnonymous()'>"+
                    				"<td>"+board.nickname+"</td>"+ 
                 					"</sec:authorize>"+
                 					"<sec:authorize access='isAuthenticated()'>"+
                 					"<td><span class='userNickname' data-toggle='dropdown'>"+board.nickname+"</span>"+
									"<div class='dropdown-menu'>"+
									"<a class='dropdown-item sendMessageToUser' data-toggle='modal' data-target='#sendMessageUser'>쪽지 보내기</a></div></td></sec:authorize>"+
  	    							"<td><i class='far fa-eye'></i> "+board.view_count+"</td>"+
  	    							"<td><i class='far fa-thumbs-up'></i> "+board.like_count+"</td>"+
  	    							"</tr>" 
  	                        )    
  	                    });
  	                    if(data.pagedto.prev){
  	                        str += '<li class="paginate_button previous"><a class="page-link" href="${data.pagedto.startPage -1}">Previous</a></li>';
  	                     }
  	                     
  	                     for(var i = data.pagedto.startPage; i<=data.pagedto.endPage; i++){
  	                        str += '<li class="paginate_button pageNumber"><a class="page-link" href="'+i+'">'+i+'</a></li>';
  	                        
  	                     }
  	                     
  	                     if(data.pagedto.next){
  	                        str += '<li class="paginate_button"><a class="page-link" href="${data.pagedto.endPage +1}">Next</a></li>';
  	                     }
  	                     
  	                     
  	                    $(".pagination").html(str);
  	                  	activePage();
  	                },
  	                error: function(){
  	                    alert("simpleWithObject err");
  	                }
  	            });
  	        }else{
  	        $.ajax({
  	            url: "/board/BoardTabListAjax",
  	            type: "GET",
  	            data: form,
  	            success: function(data){
  	            	
  	                $("#all tbody").empty();
  	                $(data.voList).each(function(i,board){
  	                     $("#all tbody").append(
  	                 			"<tr>"+
  								"<td>"+board.bno+"</td>"+
  								"<td>"+board.location+"</td>"+
  								"<td>"+board.category+"</td>"+
  								"<td><a class='move bigList' href='"+board.bno+"'>"+board.title+" </a>"+
  								"<b>["+board.reply_count+"]</b>"+
  								"</td>"+
    							"<sec:authorize access='isAnonymous()'>"+
                   				"<td>"+board.nickname+"</td>"+ 
                				"</sec:authorize>"+
                				"<sec:authorize access='isAuthenticated()'>"+
                				"<td><span class='userNickname' data-toggle='dropdown'>"+board.nickname+"</span>"+
								"<div class='dropdown-menu'>"+
								"<a class='dropdown-item sendMessageToUser' data-toggle='modal' data-target='#sendMessageUser'>쪽지 보내기</a></div></td></sec:authorize>"+
    							"<td><i class='far fa-eye'></i> "+board.view_count+"</td>"+
 	    						"<td><i class='far fa-thumbs-up'></i> "+board.like_count+"</td>"+
  								"</tr>" 
  	                    )    
  	                });
  	                if(data.pagedto.prev){
  	                    str += '<li class="paginate_button previous"><a class="page-link" href="${data.pagedto.startPage -1}">Previous</a></li>';
  	                 }
  	                 
  	                 for(var i = data.pagedto.startPage; i<=data.pagedto.endPage; i++){
  	                    str += '<li class="paginate_button pageNumber"><a class="page-link" href="'+i+'">'+i+'</a></li>';
  	                    
  	                 }
  	                 
  	                 if(data.pagedto.next){
  	                    str += '<li class="paginate_button"><a class="page-link" href="${data.pagedto.endPage +1}">Next</a></li>';
  	                 }
  	                 
  	                $(".pagination").html(str);
  	              	activePage();
  	            },
  	            error: function(){
  	                alert("simpleWithObject err");
  	            }
  	        });
  	    }
    });
  //하단 지역별 소식 카테고리별 페이징(Ajax)//
  
  //키워드 검색(Ajax)/////////////////////////////
    var searchForm = $("#searchForm");
    $("#searchForm button").on("click", function(e){
    	
  	  if(!searchForm.find("option:selected").val()){
  		  alert("검색종류를 선택하세요");
  		  return false;
  	  }
  	  if(!searchForm.find("input[name='keyword']").val()){
  		  alert("키워드를 입력하세요");
  		  return false;
  	  }
  	  searchForm.find("input[name='pageNum']").val("1");
  	  e.preventDefault();
  	  
  	typeoption = $("select[name=type]").val(); 
  	keywordtext = $('#keyword').val();
  	var str="";
    var form = {
	            category:temp,
  	            gu:'${criteria.gu}',
  	          	pageNum:1,
  	            type:typeoption,
  	          	keyword:keywordtext,
  	          	amount:'${criteria.amount}'
    }
	
  	  
    if(temp=='소통해요'){
        $.ajax({
            url: "/board/BoardTabListAjax",
            type: "GET",
            data: form,
            success: function(data){
            	
                $("#menu1 tbody").empty();
                $(data.voList).each(function(i,board){
                     $("#menu1 tbody").append( 
                    			"<tr>"+
    							"<td>"+board.bno+"</td>"+
    							"<td>"+board.location+"</td>"+
    							"<td>"+board.category+"</td>"+
    							"<td><a class='move bigList' href='"+board.bno+"'>"+board.title+" </a>"+
    							"<b>["+board.reply_count+"]</b>"+
    							"</td>"+
	    						"<sec:authorize access='isAnonymous()'>"+
                    			"<td>"+board.nickname+"</td>"+ 
                 				"</sec:authorize>"+
                 				"<sec:authorize access='isAuthenticated()'>"+
                 				"<td><span class='userNickname' data-toggle='dropdown'>"+board.nickname+"</span>"+
								"<div class='dropdown-menu'>"+
								"<a class='dropdown-item sendMessageToUser' data-toggle='modal' data-target='#sendMessageUser'>쪽지 보내기</a></div></td></sec:authorize>"+
	    						"<td><i class='far fa-eye'></i> "+board.view_count+"</td>"+
  	    						"<td><i class='far fa-thumbs-up'></i> "+board.like_count+"</td>"+
    							"</tr>" 
                    )                                                                        
                });
                if(data.pagedto.prev){
                    str += '<li class="paginate_button previous"><a class="page-link" href="${data.pagedto.startPage -1}">Previous</a></li>';
                 }
                 
                 for(var i = data.pagedto.startPage; i<=data.pagedto.endPage; i++){
                    str += '<li class="paginate_button pageNumber"><a class="page-link" href="'+i+'">'+i+'</a></li>';
                    
                 }
                 
                 if(data.pagedto.next){
                    str += '<li class="paginate_button"><a class="page-link" href="${data.pagedto.endPage +1}">Next</a></li>';
                 }
                 
                $(".pagination").html(str);
                activePage();
            },
            error: function(){
                alert("simpleWithObject err");
            }
        });
    }else if(temp=='불만있어요'){
        $.ajax({
            url: "/board/BoardTabListAjax",
            type: "GET",
            data: form,
            success: function(data){
            	
                $("#menu2 tbody").empty();
                $(data.voList).each(function(i,board){
                     $("#menu2 tbody").append(
                 			"<tr>"+
							"<td>"+board.bno+"</td>"+
							"<td>"+board.location+"</td>"+
							"<td>"+board.category+"</td>"+
							"<td><a class='move bigList' href='"+board.bno+"'>"+board.title+" </a>"+
							"<b>["+board.reply_count+"]</b>"+
							"</td>"+
  							"<sec:authorize access='isAnonymous()'>"+
            				"<td>"+board.nickname+"</td>"+ 
         					"</sec:authorize>"+
         					"<sec:authorize access='isAuthenticated()'>"+
         					"<td><span class='userNickname' data-toggle='dropdown'>"+board.nickname+"</span>"+
							"<div class='dropdown-menu'>"+
							"<a class='dropdown-item sendMessageToUser' data-toggle='modal' data-target='#sendMessageUser'>쪽지 보내기</a></div></td></sec:authorize>"+
  							"<td><i class='far fa-eye'></i> "+board.view_count+"</td>"+
  							"<td><i class='far fa-thumbs-up'></i> "+board.like_count+"</td>"+
							"</tr>" 	
                    )    
                });
                if(data.pagedto.prev){
                    str += '<li class="paginate_button previous"><a class="page-link" href="${data.pagedto.startPage -1}">Previous</a></li>';
                 }
                 
                 for(var i = data.pagedto.startPage; i<=data.pagedto.endPage; i++){
                    str += '<li class="paginate_button pageNumber"><a class="page-link" href="'+i+'">'+i+'</a></li>';
                    
                 }
                 
                 if(data.pagedto.next){
                    str += '<li class="paginate_button"><a class="page-link" href="${data.pagedto.endPage +1}">Next</a></li>';
                 }
                 
                $(".pagination").html(str);
                activePage();
            },
            error: function(){
                alert("simpleWithObject err");
            }
        });
    }else if(temp=='모여요'){
        $.ajax({
            url: "/board/BoardTabListAjax",
            type: "GET",
            data: form,
            success: function(data){
            	
                $("#menu3 tbody").empty();
                $(data.voList).each(function(i,board){
                     $("#menu3 tbody").append(
                 			"<tr>"+
							"<td>"+board.bno+"</td>"+
							"<td>"+board.location+"</td>"+
							"<td>"+board.category+"</td>"+
							"<td><a class='move bigList' href='"+board.bno+"'>"+board.title+" </a>"+
							"<b>["+board.reply_count+"]</b>"+
							"</td>"+
  							"<sec:authorize access='isAnonymous()'>"+
            				"<td>"+board.nickname+"</td>"+ 
         					"</sec:authorize>"+
         					"<sec:authorize access='isAuthenticated()'>"+
         					"<td><span class='userNickname' data-toggle='dropdown'>"+board.nickname+"</span>"+
							"<div class='dropdown-menu'>"+
							"<a class='dropdown-item sendMessageToUser' data-toggle='modal' data-target='#sendMessageUser'>쪽지 보내기</a></div></td></sec:authorize>"+
  							"<td><i class='far fa-eye'></i> "+board.view_count+"</td>"+
  							"<td><i class='far fa-thumbs-up'></i> "+board.like_count+"</td>"+
							"</tr>" 	
                    )    
                });
                if(data.pagedto.prev){
                    str += '<li class="paginate_button previous"><a class="page-link" href="${data.pagedto.startPage -1}">Previous</a></li>';
                 }
                 
                 for(var i = data.pagedto.startPage; i<=data.pagedto.endPage; i++){
                    str += '<li class="paginate_button pageNumber"><a class="page-link" href="'+i+'">'+i+'</a></li>';
                    
                 }
                 
                 if(data.pagedto.next){
                    str += '<li class="paginate_button"><a class="page-link" href="${data.pagedto.endPage +1}">Next</a></li>';
                 }
                 
                $(".pagination").html(str);
                activePage();
            },
            error: function(){
                alert("simpleWithObject err");
            }
        });
    }else if(temp=='전체'){
        $.ajax({
            url: "/board/BoardTabListAjax",
            type: "GET",
            data: form,
            success: function(data){
            	
                $("#all tbody").empty();
                $(data.voList).each(function(i,board){
                     $("#all tbody").append(
                 			"<tr>"+
							"<td>"+board.bno+"</td>"+
							"<td>"+board.location+"</td>"+
							"<td>"+board.category+"</td>"+
							"<td><a class='move bigList' href='"+board.bno+"'>"+board.title+" </a>"+
							"<b>["+board.reply_count+"]</b>"+
							"</td>"+
  							"<sec:authorize access='isAnonymous()'>"+
            				"<td>"+board.nickname+"</td>"+ 
         					"</sec:authorize>"+
         					"<sec:authorize access='isAuthenticated()'>"+
         					"<td><span class='userNickname' data-toggle='dropdown'>"+board.nickname+"</span>"+
							"<div class='dropdown-menu'>"+
							"<a class='dropdown-item sendMessageToUser' data-toggle='modal' data-target='#sendMessageUser'>쪽지 보내기</a></div></td></sec:authorize>"+
  							"<td><i class='far fa-eye'></i> "+board.view_count+"</td>"+
  							"<td><i class='far fa-thumbs-up'></i> "+board.like_count+"</td>"+
							"</tr>" 
                    )    
                });
                if(data.pagedto.prev){
                    str += '<li class="paginate_button previous"><a class="page-link" href="${data.pagedto.startPage -1}">Previous</a></li>';
                 }
                 
                 for(var i = data.pagedto.startPage; i<=data.pagedto.endPage; i++){
                    str += '<li class="paginate_button pageNumber"><a class="page-link" href="'+i+'">'+i+'</a></li>';
                    
                 }
                 
                 if(data.pagedto.next){
                    str += '<li class="paginate_button"><a class="page-link" href="${data.pagedto.endPage +1}">Next</a></li>';
                 }
                 
                $(".pagination").html(str);
                activePage();
            },
            error: function(){
                alert("simpleWithObject err");
            }
        });
    }else{
        $.ajax({
            url: "/board/BoardTabListAjax",
            type: "GET",
            data: form,
            success: function(data){
            	
                $("#all tbody").empty();
                $(data.voList).each(function(i,board){
                     $("#all tbody").append(
                 			"<tr>"+
							"<td>"+board.bno+"</td>"+
							"<td>"+board.location+"</td>"+
							"<td>"+board.category+"</td>"+
							"<td><a class='move bigList' href='"+board.bno+"'>"+board.title+" </a>"+
							"<b>["+board.reply_count+"]</b>"+
							"</td>"+
  							"<sec:authorize access='isAnonymous()'>"+
            				"<td>"+board.nickname+"</td>"+ 
         					"</sec:authorize>"+
         					"<sec:authorize access='isAuthenticated()'>"+
         					"<td><span class='userNickname' data-toggle='dropdown'>"+board.nickname+"</span>"+
							"<div class='dropdown-menu'>"+
							"<a class='dropdown-item sendMessageToUser' data-toggle='modal' data-target='#sendMessageUser'>쪽지 보내기</a></div></td></sec:authorize>"+
  							"<td><i class='far fa-eye'></i> "+board.view_count+"</td>"+
  							"<td><i class='far fa-thumbs-up'></i> "+board.like_count+"</td>"+
							"</tr>" 
                    )    
                });
                if(data.pagedto.prev){
                    str += '<li class="paginate_button previous"><a class="page-link" href="${data.pagedto.startPage -1}">Previous</a></li>';
                 }
                 
                 for(var i = data.pagedto.startPage; i<=data.pagedto.endPage; i++){
                    str += '<li class="paginate_button pageNumber"><a class="page-link" href="'+i+'">'+i+'</a></li>';
                    
                 }
                 
                 if(data.pagedto.next){
                    str += '<li class="paginate_button"><a class="page-link" href="${data.pagedto.endPage +1}">Next</a></li>';
                 }
                 
                $(".pagination").html(str);
                activePage();
            },
            error: function(){
                alert("simpleWithObject err");
            }
        });
    }
    
    });
  //키워드 검색(Ajax)//
    
  //글쓰기 버튼 링크연결/////////////////////////////
    $("#regBtn").on("click", function(){
        self.location = "/board/register?gu="+'${criteria.gu}';
     });
  //글쓰기 버튼 링크연결//
    
  //지역별 전체 소식 글 상세보기 링크연결/////////////////////////////
    $("tbody").on('click', '.move',function(e){
        e.preventDefault();
        actionForm.attr("action","/board/read/"+$(this).attr('href'));
        actionForm.submit();
	 });
  //지역별 전체 소식 글 상세보기 링크연결//
    
  //게시판 에서 보여질 글 갯수 설정/////////////////////////////
    var searchFormNum = $("#searchFormNum");
    
    $("#searchFormNum").on("change", function(e){
  	  e.preventDefault();
  	  
  	  searchFormNum.submit();
  	  
    });
  //게시판 에서 보여질 글 갯수 설정//
  
  //카테고리별 게시판 탭(Ajax)/////////////////////////////
    $('a[data-toggle="tab"]').on('show.bs.tab',function(e){
    	typeoption = null;
      	keywordtext = null;
    	var str="";
    	temp = $(this).html();
        var form = {
                category :temp,
                gu:'${criteria.gu}',
                amount:'${criteria.amount}'
        }
    
    if(temp=='소통해요'){
        $.ajax({
            url: "/board/BoardTabListAjax",
            type: "GET",
            data: form,
            success: function(data){
            	
                $("#menu1 tbody").empty();
                
                $(data.voList).each(function(i,board){
                     $("#menu1 tbody").append( 
                    			"<tr>"+
    							"<td>"+board.bno+"</td>"+
    							"<td>"+board.location+"</td>"+
    							"<td>"+board.category+"</td>"+
    							"<td><a class='move bigList' href='"+board.bno+"'>"+board.title+" </a>"+
    							"<b>["+board.reply_count+"]</b>"+
    							"</td>"+
    							"<sec:authorize access='isAnonymous()'>"+
                   				"<td>"+board.nickname+"</td>"+ 
                				"</sec:authorize>"+
                				"<sec:authorize access='isAuthenticated()'>"+
                				"<td><span class='userNickname' data-toggle='dropdown'>"+board.nickname+"</span>"+
								"<div class='dropdown-menu'>"+
								"<a class='dropdown-item sendMessageToUser' data-toggle='modal' data-target='#sendMessageUser'>쪽지 보내기</a></div></td></sec:authorize>"+
	    						"<td><i class='far fa-eye'></i> "+board.view_count+"</td>"+
  	    						"<td><i class='far fa-thumbs-up'></i> "+board.like_count+"</td>"+
    							"</tr>" 
                    )                                                                        
                });
                if(data.pagedto.prev){
                    str += '<li class="paginate_button previous"><a class="page-link" href="${data.pagedto.startPage -1}">Previous</a></li>';
                 }
                 
                 for(var i = data.pagedto.startPage; i<=data.pagedto.endPage; i++){
                    str += '<li class="paginate_button pageNumber"><a class="page-link" href="'+i+'">'+i+'</a></li>';
                    
                 }
                 
                 if(data.pagedto.next){
                    str += '<li class="paginate_button"><a class="page-link" href="${data.pagedto.endPage +1}">Next</a></li>';
                 }
                 
                $(".pagination").html(str);
                firstActivePage();
            },
            error: function(){
                alert("simpleWithObject err");
            }
        });
    }else if(temp=='불만있어요'){
        $.ajax({
            url: "/board/BoardTabListAjax",
            type: "GET",
            data: form,
            success: function(data){
            	
                $("#menu2 tbody").empty();
                $(data.voList).each(function(i,board){
                     $("#menu2 tbody").append(
                 			"<tr>"+
							"<td>"+board.bno+"</td>"+
							"<td>"+board.location+"</td>"+
							"<td>"+board.category+"</td>"+
							"<td><a class='move bigList' href='"+board.bno+"'>"+board.title+" </a>"+
							"<b>["+board.reply_count+"]</b>"+
							"</td>"+
  							"<sec:authorize access='isAnonymous()'>"+
            				"<td>"+board.nickname+"</td>"+ 
         					"</sec:authorize>"+
         					"<sec:authorize access='isAuthenticated()'>"+
         					"<td><span class='userNickname' data-toggle='dropdown'>"+board.nickname+"</span>"+
							"<div class='dropdown-menu'>"+
							"<a class='dropdown-item sendMessageToUser' data-toggle='modal' data-target='#sendMessageUser'>쪽지 보내기</a></div></td></sec:authorize>"+
  							"<td><i class='far fa-eye'></i> "+board.view_count+"</td>"+
  							"<td><i class='far fa-thumbs-up'></i> "+board.like_count+"</td>"+
							"</tr>" 	
                    )    
                });
                if(data.pagedto.prev){
                    str += '<li class="paginate_button previous"><a class="page-link" href="${data.pagedto.startPage -1}">Previous</a></li>';
                 }
                 
                 for(var i = data.pagedto.startPage; i<=data.pagedto.endPage; i++){
                    str += '<li class="paginate_button pageNumber"><a class="page-link" href="'+i+'">'+i+'</a></li>';
                    
                 }
                 
                 if(data.pagedto.next){
                    str += '<li class="paginate_button"><a class="page-link" href="${data.pagedto.endPage +1}">Next</a></li>';
                 }
                 
                $(".pagination").html(str);
                firstActivePage();
            },
            error: function(){
                alert("simpleWithObject err");
            }
        });
    }else if(temp=='모여요'){
        $.ajax({
            url: "/board/BoardTabListAjax",
            type: "GET",
            data: form,
            success: function(data){
            	
                $("#menu3 tbody").empty();
                $(data.voList).each(function(i,board){
                     $("#menu3 tbody").append(
                 			"<tr>"+
							"<td>"+board.bno+"</td>"+
							"<td>"+board.location+"</td>"+
							"<td>"+board.category+"</td>"+
							"<td><a class='move bigList' href='"+board.bno+"'>"+board.title+" </a>"+
							"<b>["+board.reply_count+"]</b>"+
							"</td>"+
  							"<sec:authorize access='isAnonymous()'>"+
            				"<td>"+board.nickname+"</td>"+ 
         					"</sec:authorize>"+
         					"<sec:authorize access='isAuthenticated()'>"+
         					"<td><span class='userNickname' data-toggle='dropdown'>"+board.nickname+"</span>"+
							"<div class='dropdown-menu'>"+
							"<a class='dropdown-item sendMessageToUser' data-toggle='modal' data-target='#sendMessageUser'>쪽지 보내기</a></div></td></sec:authorize>"+
  							"<td><i class='far fa-eye'></i> "+board.view_count+"</td>"+
  							"<td><i class='far fa-thumbs-up'></i> "+board.like_count+"</td>"+
							"</tr>" 	
                    )    
                });
                if(data.pagedto.prev){
                    str += '<li class="paginate_button previous"><a class="page-link" href="${data.pagedto.startPage -1}">Previous</a></li>';
                 }
                 
                 for(var i = data.pagedto.startPage; i<=data.pagedto.endPage; i++){
                    str += '<li class="paginate_button pageNumber"><a class="page-link" href="'+i+'">'+i+'</a></li>';
                    
                 }
                 
                 if(data.pagedto.next){
                    str += '<li class="paginate_button"><a class="page-link" href="${data.pagedto.endPage +1}">Next</a></li>';
                 }
                 
                $(".pagination").html(str);
                firstActivePage();
            },
            error: function(){
                alert("simpleWithObject err");
            }
        });
    }else if(temp=='전체'){
        $.ajax({
            url: "/board/BoardTabListAjax",
            type: "GET",
            data: form,
            success: function(data){
            	
                $("#all tbody").empty();
                $(data.voList).each(function(i,board){
                     $("#all tbody").append(
                 			"<tr>"+
							"<td>"+board.bno+"</td>"+
							"<td>"+board.location+"</td>"+
							"<td>"+board.category+"</td>"+
							"<td><a class='move bigList' href='"+board.bno+"'>"+board.title+" </a>"+
							"<b>["+board.reply_count+"]</b>"+
							"</td>"+
  							"<sec:authorize access='isAnonymous()'>"+
            				"<td>"+board.nickname+"</td>"+ 
         					"</sec:authorize>"+
         					"<sec:authorize access='isAuthenticated()'>"+
         					"<td><span class='userNickname' data-toggle='dropdown'>"+board.nickname+"</span>"+
							"<div class='dropdown-menu'>"+
							"<a class='dropdown-item sendMessageToUser' data-toggle='modal' data-target='#sendMessageUser'>쪽지 보내기</a></div></td></sec:authorize>"+
  							"<td><i class='far fa-eye'></i> "+board.view_count+"</td>"+
  							"<td><i class='far fa-thumbs-up'></i> "+board.like_count+"</td>"+
							"</tr>" 
                    )    
                });
                if(data.pagedto.prev){
                    str += '<li class="paginate_button previous"><a class="page-link" href="${data.pagedto.startPage -1}">Previous</a></li>';
                 }
                 
                 for(var i = data.pagedto.startPage; i<=data.pagedto.endPage; i++){
                    str += '<li class="paginate_button pageNumber"><a class="page-link" href="'+i+'">'+i+'</a></li>';
                    
                 }
                 
                 if(data.pagedto.next){
                    str += '<li class="paginate_button"><a class="page-link" href="${data.pagedto.endPage +1}">Next</a></li>';
                 }
                 
                $(".pagination").html(str);
                firstActivePage();
            },
            error: function(){
                alert("simpleWithObject err");
            }
        });
    }
	
});
  //카테고리별 게시판 탭(Ajax)//
  
  //새로고침 시 기존 선택 카테고리별 탭 유지/////////////////////////////
$('a[data-toggle="tab"]').on('show.bs.tab', function(e) {
	localStorage.setItem('activeTab', $(e.target).attr('href'));
});
var activeTab = localStorage.getItem('activeTab');
if(activeTab){
	$('#mytab a[href="' + activeTab + '"]').tab('show');
}
	//새로고침 시 기존 선택 카테고리별 탭 유지//
});
</script>