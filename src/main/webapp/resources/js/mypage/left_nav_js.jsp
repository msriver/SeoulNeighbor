<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(document).ready(function(){
	
	//초기값 설정 ///////////////////////////////////	
	if($(window).width() < 988) { 
		$("#leftNav").css("left",-$("#leftNav").width()-100);
		$("#leftNav").css("position","fixed");
		$("#dropDownBtn").css("left","0px");
		$("#dontEditEmail").css("margin-left","0px");
		$(".label").css("float","none");
		$("#dropDownBtn").show();
	}else{
		$("#dropDownBtn").hide();
		$("#leftNav").css("position","relative");
		$("#leftNav").css("left","0");
		$("#dontEditEmail").css("margin-left","90px");
		$("#dropDownBtn").css("left","0px");
	}
	//초기값 설정
	
	// 반응형 //////////////////////////////////////////
	$(window).resize(function() {
		if($(window).width() < 988) { 
			$("#leftNav").css("left",-$("#leftNav").width()-100);
			$("#leftNav").css("position","fixed");
			$("#dropDownBtnIcon").css("transform","rotate(0deg)");
			$("#dropDownBtn").css("left","0px");
			$("#dontEditEmail").css("margin-left","0");
			$(".label").css("float","none");
			isDropDownClicked = false;
			$("#dropDownBtn").show();
		}else{
			$("#leftNav").css("position","relative");
			$("#leftNav").css("left","0");
			$("#dropDownBtn").css("left","0px");
			$(".label").css("float","left");
			$("#dropDownBtnIcon").css("transform","rotate(0deg)");
			$("#dontEditEmail").css("margin-left","90px");
			isDropDownClicked = false;
			$("#dropDownBtn").hide();
		}
	});
	// 반응형 //
	
	// 드롭다운 버튼 클릭 //////////////////////////////////
	var isDropDownClicked = false;
	$("#dropDownBtn").on("click",function(){
		if(isDropDownClicked == false){
			$("#dropDownBtn").animate({
				left : $("#leftNav").width()
			},450);
			$("#leftNav").animate({
				left : "0"
			},500).css("position","fixed");
			$("#dropDownBtnIcon").css({
				transform : "rotate(180deg)",
				transition: "0.7s"
			});
			isDropDownClicked = true;
		}
		else if(isDropDownClicked == true){
			
			$("#dropDownBtn").animate({
				left : "0px"
			},450);
			$("#leftNav").animate({
				left : -$("#leftNav").width()-100
			},500)
			$("#dropDownBtnIcon").css({
				transform : "rotate(0deg)",
				transition: "0.7s"
			});
			isDropDownClicked = false;
		}

	});
	// 드롭다운 버튼 클릭 //
	
	// 무슨 페이지인지 읽어오기 ///////////////////////
	var url = window.window.location.pathname;
	if(url == "/profile"){
		$(".flex-column").children().eq(0).css("border-left","solid 5px #827FFE").css("font-weight","bold");
	}
	else if(url == "/mylist"){
		$(".flex-column").children().eq(1).css("border-left","solid 5px #827FFE").css("font-weight","bold");
	}
	else if(url == "/myMessage"){
		$(".flex-column").children().eq(2).css("border-left","solid 5px #827FFE").css("font-weight","bold");
	}
	else if(url == "/myQA"){
		$(".flex-column").children().eq(3).css("border-left","solid 5px #827FFE").css("font-weight","bold");
	}
	else if(url == "/myPassword"){
		$(".flex-column").children().eq(4).css("border-left","solid 5px #827FFE").css("font-weight","bold");
	}
	// 무슨 페이지인지 읽어오기 //
	
	// 프로필 사진 모닫창 z-index ///////////////////////////
	$("#changePicture").on("click",function(){
		$("#changePicture").css("z-index","1500");
	})
	// 프로필 사진 모달창 z-index //
})
</script>