package com.justdo.util;

import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.justdo.domain.MemberVO;

public class JoinValidator implements Validator {
	
	private static final String userIdRegExp = 
			"^[0-9a-z]{5,20}$";
	
	private static final String userPwRegExp = 
			"^.*(?=^.{6,15}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$";
	
	private static final String nickNameRegExp =
			"^[\\wㄱ-ㅎㅏ-ㅣ가-힣0-9a-zA-Z]{2,10}$";
	
	private static final String emailRegExp = 
			"^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";
	
	//private static final String locationRegExp = "^[가-힣]*$";
			
	
	//검증할 객체(MemberVO)의 클래스 타입 명시
	@Override
	public boolean supports(Class<?> clazz) {
		return MemberVO.class.isAssignableFrom(clazz);
	}
	
	//유효성 검사
	@Override
	public void validate(Object target, Errors errors) {
		System.out.println("서버단 검증 시작합니다...");
		MemberVO vo = (MemberVO) target;
		
		System.out.println("검증할 대상 : " + vo.toString());
		
		String userId = vo.getUserid();
		String userPw = vo.getUserpw();
		String nickName = vo.getNickname();
		String email = vo.getEmail();
		String memberLocation = vo.getMember_location();
		
		if(userId == null || userId.trim().isEmpty() || !Pattern.matches(userIdRegExp, userId)) {
			System.out.println("아이디가 비었거나 적절하지 않습니다.");
			errors.rejectValue("userId", "trouble");
		}
		
		if(userPw == null || userPw.trim().isEmpty() || !Pattern.matches(userPwRegExp, userPw)) {
			System.out.println("비밀번호가 비었거나 적절하지 않습니다.");
			errors.rejectValue("userPw", "trouble");
		}
		
		if(nickName == null || nickName.trim().isEmpty() || !Pattern.matches(nickNameRegExp, nickName)) {
			System.out.println("닉네임이 비었거나 적절하지 않습니다.");
			errors.rejectValue("nickName", "trouble");
		}
		
		if(email == null || email.trim().isEmpty() || !Pattern.matches(emailRegExp, email)) {
			System.out.println("이메일이 비었거나 적절하지 않습니다.");
			errors.rejectValue("email", "trouble");
		}
		
		if(memberLocation == null || memberLocation.trim().isEmpty()) {
			System.out.println("지역선택이 비었거나 적절하지 않습니다.");
			errors.rejectValue("memberLocation", "trouble");
		}
		
	}

}
