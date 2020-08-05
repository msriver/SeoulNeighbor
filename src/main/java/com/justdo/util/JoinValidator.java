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
		MemberVO vo = (MemberVO) target;
		
		
		String userId = vo.getUserid();
		String userPw = vo.getUserpw();
		String nickName = vo.getNickname();
		String email = vo.getEmail();
		String memberLocation = vo.getMember_location();
		
		if(userId == null || userId.trim().isEmpty() || !Pattern.matches(userIdRegExp, userId)) {
			errors.rejectValue("userId", "trouble");
		}
		
		if(userPw == null || userPw.trim().isEmpty() || !Pattern.matches(userPwRegExp, userPw)) {
			errors.rejectValue("userPw", "trouble");
		}
		
		if(nickName == null || nickName.trim().isEmpty() || !Pattern.matches(nickNameRegExp, nickName)) {
			errors.rejectValue("nickName", "trouble");
		}
		
		if(email == null || email.trim().isEmpty() || !Pattern.matches(emailRegExp, email)) {
			errors.rejectValue("email", "trouble");
		}
		
		if(memberLocation == null || memberLocation.trim().isEmpty()) {
			errors.rejectValue("memberLocation", "trouble");
		}
		
	}

}
