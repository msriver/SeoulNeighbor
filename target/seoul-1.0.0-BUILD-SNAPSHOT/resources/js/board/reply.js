console.log("reply.js 실행");

var replyService = (function(){
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	//댓글 추가
	function add(reply, callback, error) {
		console.log("add함수 실행")
		$.ajax({
			type: "POST",
			url: '/reply/new',
			data: JSON.stringify(reply),
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			},
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback){
					callback(result.list);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	//댓글 목록가져오기
	function getList(param, callback, error) {
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/reply/pages/" + bno + "/" + page + ".json",
			function(data) {
				if(callback) {
				callback(data);
			}
		}).fail(function(xhr, status, err){
			if (error) {
				error();
			}
		});
	}
	
	function remove(rno, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/reply/remove/' + rno,
			success : function(deleteResult, status, xhr) {
				if(callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er);
				}
			}
		});
	}
	
	function update(reply, callback, error) {
		$.ajax({
			type : "put",
			url : "reply" + reply.rno,
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			},
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});
	}
		
		
	
	
	
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update
	};
})();