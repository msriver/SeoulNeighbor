package com.justdo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.justdo.domain.MemberVO;
import com.justdo.security.CustomUserDetailsService;
import com.justdo.serviceImpl.commonServiceImpl;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/*")
@AllArgsConstructor
public class LoginController {
	
	private CustomUserDetailsService loginService;
	private commonServiceImpl service;
	private BCryptPasswordEncoder pwEncoder;
	
	// 메인 로그인 페이지로 이동 //////////////////////////////////
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String mainLogin() {
		// 로그인 실패시 LoginFailureHandler 작동
		return "index";
	}
	// 메인 로그인 페이지로 이동 //
	
	// 서브 로그인 페이지로 이동 //////////////////////////////////
	@RequestMapping(value = "subLogin", method = RequestMethod.GET)
	public String subLogin() {
		return "/login/subLogin";
	}
	// 서브 로그인 페이지로 이동 //
	
	// 로그인 성공 - 목록 이동
	@RequestMapping(value = "list", method = RequestMethod.POST)
	public String loginSuccess(HttpSession session, HttpServletRequest request) {
		return "board/list";
	}
	// 로그인 성공 - 목록 이동 //
	
	// 권한 없음 페이지로 이동 
    @RequestMapping(value = "access_denied", method = RequestMethod.GET)
    public String accessDeniedPage() throws Exception {
        return "/login/access_denied";
    }
    
    
    
    // 아이디/비밀번호 찾기 페이지로 이동 //////////////////////////////
    @RequestMapping(value = "find_id_pw", method = RequestMethod.GET)
    public String find_id_pw() throws Exception {
    	return "/login/find_id_pw";
    }
    // 아이디/비밀번호 찾기 페이지로 이동 //
    
    
    // 아이디 찾기 form //////////////////////////////
    @RequestMapping(value = "find_id_form", method = RequestMethod.POST)
    @ResponseBody
    public String find_id_form(String email, Model model) throws Exception {
    	
		String username = service.findIdByEmail(email);
		
		if (username != null) {
			return username;
		} else {
			return "null";
		}

    }
    // 아이디 찾기 form //
    
    @SuppressWarnings("unused")
    // 비밀번호 찾기 form //////////////////////////////
    @RequestMapping(value = "find_pw_form", method = RequestMethod.POST, produces = "application/text; charset=utf-8")
     @ResponseBody
     public String find_pw_form(String username, String email, Model model) throws Exception {

        MemberVO idVO = loginService.loadInfoByUsername(username);
        MemberVO emailVO = loginService.loadInfoByEmail(email);
        
        // 아이디로 정보 확인하기
        if (idVO == null) {
           if (emailVO == null) {
              return "fail_noUser";
          } else {
             return "fail_noID";
          }
          
       } else if (idVO != null) {
          if (emailVO == null) {
             
             return "fail_noEmail";
          } else {
             
             if (!idVO.equals(emailVO)) {
                return "fail_diffrentInfo";
                
             } else {
                   return "success_send";
                }
             }
          }
       return "end";
     }
     // 비밀번호 찾기 form //
    
    //이메일 보내기 ///////////////////////////////
    @RequestMapping(value = "sendEmail", method = RequestMethod.POST, produces = "application/text; charset=utf-8")
    @ResponseBody
    public void sendEmail(String username, String email, Model model) throws Exception {
               // 임시비밀번호 생성하기
               String new_password = "";
               for (int i = 0; i < 12; i++) {
                  new_password += (char) ((Math.random() * 26) + 97);
               }
               String encoded_pw = pwEncoder.encode(new_password);
               
               // 메일 정보 설정하기
               String setfrom = "justdo0812@gmail.com";
               String tomail = email;
               String title = "[서울이웃 비밀번호 변경] 임시비밀번호가 발송되었습니다.";
               String content = "서울이웃 임시비밀번호입니다. [ "+ new_password +" ] 로그인 후 비밀번호를 변경해주세요.";
               
               // 생성한 비밀번호를 메일로 보내주기
               try {
                  service.commonMailSender(setfrom, tomail, title, content);
                  log.warn("메일전송 완료");
                  
                  // 메일 발송 성공시 입력한 아이디와 이메일을 가진 회원 비밀번호 변경하기
                  service.changePassword(username, email, encoded_pw);
                  
               } catch(Exception e) {
                  e.printStackTrace();
               }
            
    }
}
