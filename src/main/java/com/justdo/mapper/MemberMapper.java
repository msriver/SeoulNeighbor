package com.justdo.mapper;

import com.justdo.domain.MemberVO;

public interface MemberMapper {
	// 로그인용 result map
	public MemberVO read_auth(String userid);
	
	// 비밀번호 찾기용 정보
	public MemberVO read_userinfo(String email);
}
