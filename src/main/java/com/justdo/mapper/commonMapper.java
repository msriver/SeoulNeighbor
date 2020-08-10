package com.justdo.mapper;

import org.apache.ibatis.annotations.Param;

import com.justdo.domain.MemberVO;

public interface commonMapper {

	//로그인
	public MemberVO login(MemberVO vo);
	
	
	// tbl_member에 insert
	public void insertUser(MemberVO vo);
	
	// tbl_member_auth에 권한 추가
	public void insertUserAuth(String userid);
	
	//중복된 아이디가 있는지 체크
	public int checkID(String userId);
	
	//중복된 닉네임이 있는지 체크
	public int checkNickName(String nickName);
	
	//중복된 이메일이 있는지 체크
	public int checkEmail(String email);
	
	//안읽은 메시지 개수 가져오기
	public int selectMessageReadCount(String userid);
	
	//날씨 정보 위한 구 가져오기
	public String selectGuForWeather(String userid);
	
	//이메일로 회원 아이디 찾기
		public String findID(String email);
		
	//아이디 이메일이 맞는 회원의 비밀번호 변경하기
	public void updateNewPassword(@Param("userid") String userid, @Param("email") String email, @Param("userpw") String userpw);
	
}


