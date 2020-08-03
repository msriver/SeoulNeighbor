package com.justdo.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.justdo.domain.BoardVO;
import com.justdo.domain.MemberVO;
import com.justdo.domain.MessageVO;
import com.justdo.domain.QAVO;
import com.justdo.service.commonService;
import com.justdo.service.myPageService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/*")
@AllArgsConstructor
public class MyPageController {
	
	private commonService service;
	private myPageService myPageService;
	private BCryptPasswordEncoder pwdEncoder;
	
	// 나의 게시글 불러오기 ///////////////////////////////////////////
	@GetMapping("mylist")
	public String myList(Model model,MemberVO vo,Principal principal) {
		if (principal != null) {
		String username = principal.getName();
		vo = myPageService.selectUser(username);
		model.addAttribute("member", myPageService.selectUser(vo.getUserid())); 
		model.addAttribute("board",myPageService.selectMyBoardList(vo.getUserid(),0));
		model.addAttribute("pageTotalNum",myPageService.selectCountMyBoardList(vo.getUserid()));
		model.addAttribute("nowPageNum",1);
		
		//날씨 정보 불러오는 구문
		String weatherData[]=null;
		try {
			weatherData = service.getWeather(service.selectGuForWeather(principal.getName()));
		} catch (IOException e) {
			e.printStackTrace();
		}
		model.addAttribute("weather",weatherData[0]);
		model.addAttribute("temperature",weatherData[1]);
		model.addAttribute("weatherGu",weatherData[2]);
		//
		
		return "mypage/mylist";
		}else {
			return "/index";
		}
	}
	// 나의 게시글 불러오기 //
	
	// 나의 게시글 Ajax로 불러오기 //////////////////////////////////////////////
	@GetMapping("myListAjax")
	@ResponseBody
	public ResponseEntity<List<BoardVO>> myListAjax(Principal principal, int pageNum) {
		String username = principal.getName();
		return new ResponseEntity<List<BoardVO>>(myPageService.selectMyBoardList(username, pageNum),HttpStatus.OK);
	}
	// 나의 게시글 Ajax로 불러오기 //
	
	// 쪽지함 페이지 이동 ///////////////////////////////////////////
	@GetMapping("myMessage")
	public String myMessage(Model model, MemberVO vo, Principal principal) {
		if (principal != null) {
			String username = principal.getName();
			vo = myPageService.selectUser(username);
			model.addAttribute("member", vo); 
			model.addAttribute("message",myPageService.selectMessageList(vo.getUserid(),0));
			model.addAttribute("pageTotalNum",myPageService.selectCountMessage(vo.getUserid()));
			model.addAttribute("nowPageNum",1);
			
			//날씨 정보 불러오는 구문
			String weatherData[]=null;
			try {
				weatherData = service.getWeather(service.selectGuForWeather(principal.getName()));
			} catch (IOException e) {
				e.printStackTrace();
			}
			model.addAttribute("weather",weatherData[0]);
			model.addAttribute("temperature",weatherData[1]);
			model.addAttribute("weatherGu",weatherData[2]);
			//
			
			return "mypage/myMessage";
		} else {
			return "/index";
		}
	}
	// 쪽지함 페이지 이동 //
	
	//쪽지 Ajax로 불러오기 //////////////////////////////////////////////
	@GetMapping("myMessageAjax")
	@ResponseBody
	public ResponseEntity<List<MessageVO>> myMessageAjax(Principal principal, int pageNum) {
		String username = principal.getName();
		return new ResponseEntity<List<MessageVO>>(myPageService.selectMessageList(username, pageNum),HttpStatus.OK);
	}
	//쪽지 Ajax로 불러오기 //
	
	//미니쪽지 Ajax로 불러오기 //////////////////////////////////////////////
	@GetMapping("myMiniMessageAjax")
	@ResponseBody
	public ResponseEntity<List<MessageVO>> myMiniMessageAjax(Principal principal) {
		String username = principal.getName();
		return new ResponseEntity<List<MessageVO>>(myPageService.selectMiniMessageList(username),HttpStatus.OK);
	}
	//쪽지 Ajax로 불러오기 //

	// 쪽지 Ajax로 답장하기 ///////////////////////////////////////////////////
	@PostMapping("myMessageSendAjax")
	@ResponseBody public void myMessageSendAjax(MessageVO vo){
		vo.setReceiver(myPageService.selectFindReceiver(vo.getMno()));
		myPageService.sendMessage(vo); 
	}
	// 쪽지 답장하기 //
	
	// 쪽지 Ajax로 유저 선택해서 보내기 ///////////////////////////////////////////////////
	@PostMapping("myMessageSendToUserAjax")
	@ResponseBody public void myMessageSendToUserAjax(MessageVO vo){
		myPageService.sendMessageToUser(vo);
	}
	// 쪽지 유저 선택해서 보내기 //
	
	// 쪽지 삭제 Ajax ///////////////////////////////////////////////////
	@PostMapping("deleteMessageAjax")
	@ResponseBody public void deleteMessageAjax(int mno){
		myPageService.deleteMessage(mno);
	}
	// 쪽지 삭제 Ajax //
	
	// 쪽지 읽음 업데이트 /////////////////////////////////
	@PostMapping("updateReadCheckAjax")
	@ResponseBody public void updateReadCheck(int mno){
		myPageService.updateReadCheck(mno);
	}
	// 쪽지 읽음 업데이트 //
	  
	// 1:1 문의 이동 ///////////////////////////////////////////
	@GetMapping("myQA")
	public String myQA(Model model,MemberVO vo,Principal principal) {
		if (principal != null) {
			String username = principal.getName();		
			vo = myPageService.selectUser(username);
			model.addAttribute("member", myPageService.selectUser(vo.getUserid())); 
			model.addAttribute("QA",myPageService.selectQAList(vo.getUserid(),0));
			model.addAttribute("pageTotalNum",myPageService.selectCountQAList(vo.getUserid()));
			model.addAttribute("nowPageNum",1);
			
			//날씨 정보 불러오는 구문
			String weatherData[]=null;
			try {
				weatherData = service.getWeather(service.selectGuForWeather(principal.getName()));
			} catch (IOException e) {
				e.printStackTrace();
			}
			model.addAttribute("weather",weatherData[0]);
			model.addAttribute("temperature",weatherData[1]);
			model.addAttribute("weatherGu",weatherData[2]);
			//
			return "mypage/myQA";
			
		} else {
			return "/index";
		}
	}
	// 1:1 문의 이동 //
	
	// 1:1 문의 Ajax로 불러오기 //////////////////////////////////////////////
	@GetMapping("myQAAjax")
	@ResponseBody
	public ResponseEntity<List<QAVO>> myQAAjax(Principal principal, int pageNum) {
		String username = principal.getName();	
		return new ResponseEntity<List<QAVO>>(myPageService.selectQAList(username, pageNum),HttpStatus.OK);
	}
	// 1:1문의 Ajax로 불러오기 //
	
	// 1:1 문의 올리기 ////////////////////////////////////////////
	@PostMapping("QASendAjax")
	@ResponseBody public void QASend(QAVO qvo){
		myPageService.insertQA(qvo); 
	}
	// 1:1 문의 올리기
	
	
	// 비밀번호 변경 페이지 이동////////////////////////////////////////
	@GetMapping("myPassword")
	public String myPassword(Model model,Principal principal) {
		if (principal != null) {
			String username = principal.getName();	
			model.addAttribute("member", myPageService.selectUser(username));
			
			//날씨 정보 불러오는 구문
			String weatherData[]=null;
			try {
				weatherData = service.getWeather(service.selectGuForWeather(principal.getName()));
			} catch (IOException e) {
				e.printStackTrace();
			}
			model.addAttribute("weather",weatherData[0]);
			model.addAttribute("temperature",weatherData[1]);
			model.addAttribute("weatherGu",weatherData[2]);
			//
			return "mypage/myPassword";
		}
		return "/index";
	}
	// 비밀번호 변경 페이지 이동//
	
	
	
	
	//유저 정보 수정 //////////////////////////////////////
	@PostMapping("updateUser")
	public String profile(MemberVO vo, MultipartFile[] uploadFile, String isFileChanged, Principal principal) {
		File file;
		
		String uploadFolder = "c://Project/seoulneighbor/seoulNeighbor/src/main/webapp/resources/img/mypage";
		
		UUID uuid = UUID.randomUUID();
		
		String uploadFileName = vo.getMember_filename();
		
		String fileChanged = isFileChanged;
	
		if(fileChanged.equals("true")) { //프로필 이미지가 바뀌었을떼만
			for(MultipartFile multipartFile : uploadFile) {
				File saveFile = new File(uploadFolder,uuid.toString()+"_"+multipartFile.getOriginalFilename());
				try {
						uploadFileName = uuid.toString()+"_"+multipartFile.getOriginalFilename();
						try {
							file = new File(uploadFolder,myPageService.getOriginalFileName(vo.getUserid())); //기존에 있던 파일 이름을 가져와서
							file.delete(); //삭제
						}catch(NullPointerException e) {
							e.printStackTrace();
						}
						multipartFile.transferTo(saveFile); //새로운 파일 등록
						vo.setMember_filename(uploadFileName);

					if(vo.getMember_filename().equals("")) {
						vo.setMember_filename(null);
					}
					
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}

		myPageService.updateUser(vo); //데이터베이스 업데이트
		return "redirect:/profile";
	}
	//유저 정보 수정 //
	
	//비밀번호 변경 //////////////////////////////////////////////////
	@PostMapping("changePassword")
	public String changePassword(RedirectAttributes rttr, MemberVO vo, String changePw) {

			if(pwdEncoder.matches(vo.getUserpw(), myPageService.selectUserPw(vo.getUserid()))) {
				vo.setUserpw(pwdEncoder.encode(changePw));
				myPageService.updatePassword(vo);
				rttr.addFlashAttribute("result","success");
				return "redirect:/myPassword";
			}
			else {
				rttr.addFlashAttribute("result","fail");
				return"redirect:/myPassword"; 
			}


	}
	//비밀번호 변경//

	
}
