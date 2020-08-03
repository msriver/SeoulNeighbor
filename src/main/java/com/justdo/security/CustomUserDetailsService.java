package com.justdo.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.justdo.domain.MemberVO;
import com.justdo.mapper.MemberMapper;


@Service
public class CustomUserDetailsService implements UserDetailsService{
	
	@Autowired
	private MemberMapper memberMapper;

	@Override
	@Transactional
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// 아이디가 없을 시 예외 발생시킴
		if (username == null) {
			throw new UsernameNotFoundException(username);
		}
	
		
		MemberVO vo = memberMapper.read_auth(username);
		
		CustomUser user = new CustomUser(vo);
		
		
		return vo == null? null : user;
	}
	
	// 아이디를 넣으면 VO가 나오는 메소드 
	public MemberVO loadInfoByUsername(String username) throws UsernameNotFoundException {
		// 아이디가 없을 시 예외 발생시킴
		if (username == null) {
			throw new UsernameNotFoundException(username);
		}
		MemberVO vo = memberMapper.read_auth(username);
		return vo;
	}
	
	// 이메일을 넣으면 VO가 나오는 메소드
	public MemberVO loadInfoByEmail(String email) throws UsernameNotFoundException {
		// 아이디가 없을 시 예외 발생시킴
		if (email == null) {
			throw new UsernameNotFoundException(email);
		}
		MemberVO vo = memberMapper.read_userinfo(email);
		return vo;
	}
	
	// 아이디를 넣으면 닉네임이 나오는 메소드
	public String loadNicknameByUsername(String username) throws UsernameNotFoundException {
		if (username == null) {
			throw new UsernameNotFoundException(username);
		}
		
		MemberVO vo = memberMapper.read_auth(username);
		String nickname = vo.getNickname();
		
		return nickname;
	}
	
	// 아이디를 넣으면 '구'가 나오는 메소드
	public String loadLocationByUsername(String username) throws UsernameNotFoundException {
		if (username == null) {
			throw new UsernameNotFoundException(username);
		}
		
		MemberVO vo = memberMapper.read_auth(username);
		String[] location = vo.getMember_location().split("_");
		String location_gu = location[0];
		return location_gu;
	}
}
