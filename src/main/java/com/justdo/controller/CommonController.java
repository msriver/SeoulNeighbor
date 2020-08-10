package com.justdo.controller;



import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.justdo.domain.MemberVO;
import com.justdo.security.CustomUserDetailsService;
import com.justdo.service.commonService;
import com.justdo.service.myPageService;
import com.justdo.util.JoinValidator;

import lombok.AllArgsConstructor;


@Controller
@RequestMapping("/*")
@AllArgsConstructor
public class CommonController {
	
	 private CustomUserDetailsService loginService;
	 private myPageService myPageService;
	 private commonService service;
	 private BCryptPasswordEncoder pwdEncoder;
	 
	// 메인 이동
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Principal principal) throws IOException {
		
		// 로그인 한 상태일 때는 principal 정보 담아서 board/list로 전송
		if (principal != null) {
			String username = principal.getName();
			String gu = loginService.loadLocationByUsername(username);
			String encodedGu = URLEncoder.encode(gu, "UTF-8");

			return "redirect:/board/list?gu=" + encodedGu;
		}

		
		return "index";
	}
	
	//비회원 입장 시
	@RequestMapping(value="/nonMember", method = RequestMethod.GET)
	public String nonMemberEnter(@RequestParam("nonMemGu") String gu,  HttpServletResponse response) throws UnsupportedEncodingException {
		if(gu.equals("지역을 선택하세요")) {
			gu = "중구";
		}
		return "redirect:/board/list?gu=" + URLEncoder.encode(gu, "UTF-8");
	}
	
	
	// 프로필 페이지 이동
	@GetMapping("profile")
	public String profile(Model model, Principal principal) {
		
		//날씨 정보 불러오는 구문 
		if(principal != null) {
			String username = principal.getName();
			model.addAttribute("member", myPageService.selectUser(username));
			String weatherData[]=null;
			try {
				weatherData = service.getWeather(service.selectGuForWeather(principal.getName()));
			} catch (IOException e) {
				e.printStackTrace();
			}
			model.addAttribute("weather",weatherData[0]);
			model.addAttribute("temperature",weatherData[1]);
			model.addAttribute("weatherGu",weatherData[2]);
			
			return "mypage/profile";
		}else {
			return "/index";
		}
	}
	

	//회원가입 페이지 호출
	@GetMapping("join")
	public String joinForm() {
		return "joinpage/join";
	}
	
	//회원가입 진행
	@PostMapping("/join")
	public String join(MemberVO vo, BindingResult result, RedirectAttributes rttr) {
		
		boolean isDuplicated = 
				service.isUniqueID(vo.getUserid()) && service.isUniqueNickName(vo.getNickname());
		
		try {
			if(!isDuplicated) {
				rttr.addFlashAttribute("warning", "회원가입에 실패하였습니다.");
				return "redirect:/join";
			} else {
				JoinValidator validator = new JoinValidator();
				validator.validate(vo, result);
				if(result.hasErrors()) {
					rttr.addFlashAttribute("warning", "당신은 거절당했습니다. 가입불가");
					return "redirect:/join";
				}
			}
			String encodedPassword = pwdEncoder.encode(vo.getUserpw());
			vo.setUserpw(encodedPassword);
			service.join(vo);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/";
	}
	
	//유저 ID 중복됬는지 체크
	@GetMapping(value="/checkId/{userId}",
			produces={MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> checkUserId(@PathVariable("userId") String userId){
		if(service.isUniqueID(userId)) {
			return new ResponseEntity<String>("new",HttpStatus.OK);
		}
		return new ResponseEntity<String>("duplicated",HttpStatus.OK);
	}
	
	//유저 닉네임 중복됬는지 체크
	@GetMapping(value="/checkNickName/{nickName}",
			produces={MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> checkNickName(@PathVariable("nickName") String nickName){
		if(service.isUniqueNickName(nickName)) {
			return new ResponseEntity<String>("new",HttpStatus.OK);
		}
		return new ResponseEntity<String>("duplicated",HttpStatus.OK);
	}
	
	//이메일 중복됬는지 체크
	@RequestMapping(value = "/checkEmail" , method = RequestMethod.GET, produces = "application/text; charset=utf-8")
	public @ResponseBody ResponseEntity<String> checkEmail(@RequestParam("email") String email) throws UnsupportedEncodingException{
		String responseMsg;
		if(service.isUniqueEmail(email.trim())) {
			responseMsg = "new";
		} else {
			responseMsg = "duplicated";
		}
		//URLEncoder.encode(responseMsg, "UTF-8");
		
		return new ResponseEntity<String>(responseMsg, HttpStatus.OK);
		
	}
	
	//회원가입시 이메일로 인증번호 전송
	@GetMapping(value="/sendAuthMail", produces = "application/text; charset=utf-8")
	@ResponseBody
	public ResponseEntity<String> sendEmail(@RequestParam("email") String email) {
		
		int randNumber = (int)(Math.random() * 10000); // 난수 범위 0~9999
		
		String setfrom = "justdo0812@gmail.com";
		String tomail = email;
		String title = "[서울이웃 회원가입]인증번호 발송";
		String content = String.format("%04d", randNumber);
		
		try {
			service.commonMailSender(setfrom, tomail, title, content);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<String>(content, HttpStatus.OK);
	}
	
	//이메일로 보낸 인증번호와 사용자가 입력한 인증번호 비교
	@PostMapping(value="/compareEmailAuth",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> compareEmailAuth(@RequestBody HashMap<String, Object> map){
		
		String userNumber = (String) map.get("userNumber"); //유저가 입력한 번호
		String originNumber = (String) map.get("originNumber"); //서버에서 만들어 유저에게 보내준 번호
		
		if(originNumber.equals(userNumber)) {
			return new ResponseEntity<String>("same", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>("different", HttpStatus.OK);
		}
	}
	
	// 안읽은 메시지 개수 가져오기
	@GetMapping("getMessageCountAjax")
	@ResponseBody
	public int getMessageCountAjax(String userid) {
		return service.selectMessageReadCount(userid);
	}

	
}
