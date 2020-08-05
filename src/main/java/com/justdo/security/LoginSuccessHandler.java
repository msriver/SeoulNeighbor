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
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import lombok.extern.log4j.Log4j;


@Log4j
public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	
	@Autowired
	private CustomUserDetailsService loginService;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		
		RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
		RequestCache requestCache = new HttpSessionRequestCache();

		SavedRequest savedRequest = requestCache.getRequest(request, response); 
		
		// 이전 요청이 있을시(작성, 수정 등) 로그인 후 요청된 주소로 이동
		if (savedRequest != null) {
			
				String targetUrl = savedRequest.getRedirectUrl();
				
				log.warn("savesRequest"+savedRequest);
				log.warn("targetUrl"+targetUrl);
				
				redirectStrategy.sendRedirect(request, response, targetUrl);
		} else {
			
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
			response.sendRedirect("/"); // 요청 따로 없을시 메인 페이지로 이동
		}
	}
}