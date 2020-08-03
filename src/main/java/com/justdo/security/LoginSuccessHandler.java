package com.justdo.security;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;



public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	
	@Autowired
	private CustomUserDetailsService loginService;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

	
		
		List<String> roleNames = new ArrayList<>();
		
		authentication.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		}); // 권한 목록 받아옴
		
		
		// 지역 정보 받아옴
		String username = authentication.getName();
		
		String gu = loginService.loadLocationByUsername(username);
		
		String encodedGu = URLEncoder.encode(gu, "UTF-8");
		
		if (roleNames.contains("ROLE_USER")) {
			response.sendRedirect("board/list?gu="+encodedGu);
			return;
		}
		response.sendRedirect("/"); // 권한 없을시 메인 페이지로 이동
	}
}
