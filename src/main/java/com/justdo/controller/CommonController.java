package com.justdo.controller;



import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.HashMap;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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

import com.justdo.domain.BoardVO;
import com.justdo.domain.Criteria;
import com.justdo.domain.MemberVO;
import com.justdo.security.CustomUserDetailsService;
import com.justdo.service.BoardService;
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
	 private JavaMailSender mailSender;
	 private BoardService boardService;
	 
	// test //
	// 메인 이동 //////////////////////////////////
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model,Principal principal) throws IOException {
		
		// 로그인 한 상태일 때는 principal 정보 담아서 board/list로 전송
		if (principal != null) {
			String username = principal.getName();
			String gu = loginService.loadLocationByUsername(username);
			String encodedGu = URLEncoder.encode(gu, "UTF-8");
			return "redirect:/board/list?gu="+encodedGu;
		}

		
		return "index";
	}
	// 메인 이동 //
	
	
	// 프로필 페이지 이동 ////////////////////////
	@GetMapping("profile")
	public String profile(Model model, Principal principal) {
		//날씨 정보 불러오는 구문 /////////////////////
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
		//날씨 정보 굴러오는 구문 //
		
		
	}
	// 프로필 페이지 이동 //
	
	//bno로 상세페이지 부르기   ---이 주석의 오른쪽 설명란은 볼 필요 없음.         board/read/*란 주소 board/read슬래쉬 뒤에 붙는 애들은 이녀석 적용이란 의미 -> httpServletRequest request는 clinet가 주소창에 입력한 요청을 담은 객체로 request.getRequestURI는 클라이언트가 친 주소창이고, 그걸 잘라서 http://localhost:8181/board/read/1의 bno인 1만 따로 bno라는 변수에 저장하고, vo에 bno=1담아서 jsp에 어트리뷰트 속성으로 보내서 jsp는 그 데이터로 클라이언트에게 보여줌/////////////////////
	@GetMapping("board/read/*")
	public String read(Model model, HttpServletRequest request,HttpServletResponse response,Principal principal,Criteria cri) {
		
		int bno =  Integer.parseInt(request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/")+1));
		BoardVO vo = service.read(bno);
		
		HttpSession sessions = request.getSession();
		
        // 비교하기 위해 새로운 쿠키
        String viewSession = null;

        
        // 쿠키가 있을 경우 
        if (sessions != null) {
        	if(sessions.getAttribute("readSession"+vo.getBno().toString()) != null) {
        		viewSession = sessions.getAttribute("readSession"+vo.getBno()).toString();
        	}
        }
		
		if(vo != null) {
		      model.addAttribute("board",vo);
		      model.addAttribute("fileName",boardService.selectWriterProfile(vo.getNickname()));
		      model.addAttribute("hotList",boardService.selectHotListFromRead(cri));
		      System.out.println(boardService.selectHotListFromRead(cri));
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
					
					  // 만일 viewCookie가 null일 경우 세션을 생성해서 조회수 증가 로직을 처리함.
					if (viewSession == null) {
					  // 세션 생성(이름, 값) 
					  sessions.setAttribute("readSession"+vo.getBno(), "test");
					  // 세션을 추가 시키고 조회수 증가시킴 
					  boardService.updateViewCount(vo.getBno());
					  }
				}
		      return "board/read";  
		}else {
			return "redirect:/board/list";
		}
	}
	//bno로 상세페이지 부르기 
	
	//좋아요+1 ////////////////////////////////
	@GetMapping(value="/read/plusLike/{bno}", produces= {MediaType.TEXT_PLAIN_VALUE})
	   @ResponseBody
	   public ResponseEntity<String> plusLike(@PathVariable("bno") int bno) {
	      
	      String result = Integer.toString(service.likeBoard(bno));
	      return new ResponseEntity<String>(result, HttpStatus.OK);
	   }
	
	//좋아요+1 ////////////////////////////////

	//싫어요+1 ////////////////////////////////board/read에서 싫어요 버튼 누르면 ajax로  url: "/read/plusUnlike/" + bno, 경로에 get 타입으로 요청하면 밑 GetMapping이 적용되서 service.unlikeBoard(bno)가 실행되어 해당 bno의  싫어요 1증가 후 싫어요 개수를 int로 result에 반환(컨트롤러는 할거다한거고) read.jsp가 그 result를 받아서 비동기적으로 싫어요 갯수를 리로딩.
	@GetMapping(value="/read/plusUnlike/{bno}", produces= {MediaType.TEXT_PLAIN_VALUE})
	   @ResponseBody
	   public ResponseEntity<String> plusUnlike(@PathVariable("bno") int bno) {
	      
	      String result = Integer.toString(service.unlikeBoard(bno));
	      return new ResponseEntity<String>(result, HttpStatus.OK);
	   }
	//싫어요+1 ////////////////////////////////
	
	//해당 bno의 board 삭제/////////////////////////////////////////////
	@PostMapping("/board/remove/{bno}")
	public String remove(@PathVariable("bno") int bno, RedirectAttributes rttr) {  
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/board/list";
	}
	
	//해당 bno의 board 삭제/////////////////////////////////////////////
	
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
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			messageHelper.setFrom(setfrom);
			messageHelper.setTo(tomail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			mailSender.send(message);
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
	
	// 안읽은 메시지 개수 가져오기 /////////////
	@GetMapping("getMessageCountAjax")
	@ResponseBody
	public int getMessageCountAjax(String userid) {
		return service.selectMessageReadCount(userid);
	}
	// 안읽은 메시지 개수 가져오기
	
}
