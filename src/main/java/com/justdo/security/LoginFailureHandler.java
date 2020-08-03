package com.justdo.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;


public class LoginFailureHandler implements AuthenticationFailureHandler {
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		
		
		String errorMessage = "가입하지 않은 아이디이거나, 잘못된 비밀번호입니다."; 
		request.setAttribute("message", errorMessage); // 로그인 실패시 뜰 문구
		
		response.sendRedirect("/subLogin?error=true");
	}

}
