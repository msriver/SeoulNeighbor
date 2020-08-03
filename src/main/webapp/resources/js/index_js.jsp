<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	/* 제이쿼리 사용 */
	(function ($) {
	    "use strict";
		/* 로그인 유호값 검사 ////////////////////////////////////////*/
	    var input = $('.validate-input .input-text');
	
	    $('.validate-form').on('submit',function(){
	        var check = true;
	
	        for(var i=0; i<input.length; i++) {
	            if(validate(input[i]) == false){
	                showValidate(input[i]);
	                check=false;
	            }
	        }
	
	        return check;
	    });
	
	
	    $('.validate-form .input-text').each(function(){
	        $(this).focus(function(){
	           hideValidate(this);
	        });
	    });
	
	    function validate (input) {
	        if($(input).attr('type') == 'email' || $(input).attr('name') == 'email') {
	            if($(input).val().trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/) == null) {
	                return false;
	            }
	        }
	        else {
	            if($(input).val().trim() == ''){
	                return false;
	            }
	        }
	    }
	
	    function showValidate(input) {
	        var thisAlert = $(input).parent();

	        $(thisAlert).addClass('alert-validate');

	        $(thisAlert).append('<span class="btn-hide-validate">&#xf057;</span>')
	        $('.btn-hide-validate').each(function(){
	            $(this).on('click',function(){
	               hideValidate(this);
	            });
	        });
	    }

	    function hideValidate(input) {
	        var thisAlert = $(input).parent();
	        $(thisAlert).removeClass('alert-validate');
	        $(thisAlert).find('.btn-hide-validate').remove();
	    }
	    /* 로그인 유호값 검사  */
	})(jQuery);
</script>
