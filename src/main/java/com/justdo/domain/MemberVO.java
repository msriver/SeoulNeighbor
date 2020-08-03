package com.justdo.domain;

import java.util.List;

import lombok.Data;

// 회원 테이블 속성을 나타냅니다 ////////////
@Data
public class MemberVO {
	
	private String userid; //회원 아이디
	private String nickname; //회원 닉네임
	private String userpw; //회원 비밀번호
	private String email;
	private String member_location;
	private String member_filename;
	private char member_enabled;
	
	private List<AuthVO> authList;
}
