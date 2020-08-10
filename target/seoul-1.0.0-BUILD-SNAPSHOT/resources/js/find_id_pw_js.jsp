<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(document).ready(function () {
    var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue = "${_csrf.token}";
    
    /* 아이디, 비밀번호 탭을 누를 때마다 원래의 form 불러오기 /////////////////////////////////////////////*/
    var tempIdForm = $("#id-fieldset").html();
    var tempPwForm = $("#pw-fieldset").html();
    
    $("a[href='#find-id']").click(function name() {
       $("#id-fieldset").html(tempIdForm);
    });
    $("a[href='#find-pw']").click(function name() {
       $("#pw-fieldset").html(tempPwForm);
    });
    /* 아이디, 비밀번호 탭을 누를 때마다 원래의 form 불러오기 */
    
    /* 아이디 찾기 버튼을 눌렀을 때! //////////////////////////////////*/
    $(document).on("click","#id-find-button",function (e) {
    	
        var raw_email = $("#email").val();
        
        var form = { email : raw_email };
        
        $.ajax({
            url: "/find_id_form",
            data: form,
            type: "POST",
            beforeSend: function(xhr){
                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
            },
            success: function (result) {
                
                if (result == "null") {
                    var string2 = "<p>입력하신 이메일과 일치하는 서울이웃 아이디가 없습니다.</p>"
                           + "<p>" + raw_email + "</p>";
                           + "<button class='btn button-colored float-right' onclick='location.href=\"\/subLogin\"'>로그인</button>";
                    $("#id-fieldset").html(string2);
                } else {
                    var string1 = "<p>입력하신 정보와 일치하는 서울이웃 아이디입니다.</p>"
                           + "<p>"+result+"</p>"
                           + "<button class='btn button-colored float-right' onclick='location.href=\"\/subLogin\"'>로그인</button>";
                
                    $("#id-fieldset").html(string1);
                } 
            },	
            error: function () {
            }
        });
        /* 아이디 찾기 버튼을 눌렀을 때! */
    });
    
    /* 비밀번호 찾기 버튼을 눌렀을 때! //////////////////////////////////*/
    $(document).on("click","#pw-find-button",function (e) {
        
        var raw_username = $("#username").val();
        var raw_email = $("#pwemail").val();
        
        var form = { username : raw_username,
                     email : raw_email 
                   };
        
        $.ajax({
            url: "/find_pw_form",
            data: form,
            type: "POST",
            beforeSend: function(xhr){
                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
            },
            success: function (result) {
                
                if (result == "fail_noUser") {
                    alert("가입정보가 없는 회원입니다. 정보를 다시 입력해주세요.");
                } else if (result == "fail_noID") {
                    alert("가입정보가 없는 아이디입니다. 정보를 다시 입력해주세요.");
                } else if (result == "fail_noEmail") {
                    alert("가입정보가 없는 이메일입니다. 정보를 다시 입력해주세요.");
                } else if (result == "fail_diffrentInfo") {
                    alert("아이디와 이메일 정보가 일치하지 않습니다. 정보를 다시 입력해주세요.");
                } else {
                    var string1 = "<p>입력하신 이메일로 임시 비밀번호가 발송되었습니다. <br>메일함을 확인해주세요. 발송이 완료될 때까지 시간이 걸릴 수 있습니다.</p>"
                           + "<p>"+raw_email+"</p>"
                           + "<button class='btn button-colored float-right' onclick='location.href=\"\/subLogin\"'>로그인</button>";
                
                    $("#pw-fieldset").html(string1);

                } 
                
                var form = { username : raw_username,
                        email : raw_email 
                    };
                $.ajax({
                    url: "/sendEmail",
                    data: form,
                    type: "POST",
                    beforeSend: function(xhr){
                        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
                    },
                    success: function (result) {}})
            }

        });
        /* 비밀번호 찾기 버튼을 눌렀을 때! */
    });
});
</script>