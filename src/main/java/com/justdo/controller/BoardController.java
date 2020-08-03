package com.justdo.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.security.Principal;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.justdo.domain.BoardVO;
import com.justdo.domain.Criteria;
import com.justdo.domain.LikeVO;
import com.justdo.domain.PageDTO;
import com.justdo.domain.ReportVO;
import com.justdo.security.CustomUserDetailsService;
import com.justdo.service.BoardService;
import com.justdo.service.commonService;
import com.justdo.service.myPageService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	private commonService commonService;
	private BoardService service;
	private CustomUserDetailsService loginService;
	private myPageService myPageService;

	// 목록 페이지 이동
	@GetMapping("list")
	public void list(Criteria cri, Model model, Principal principal) {

		model.addAttribute("locationlist", service.getLocationList(cri));
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotal(cri)));

		// 서울 문화 정보 넘기기
		try {
			String[] cultureInfo = commonService.getCulture();
			model.addAttribute("cultureTitle", cultureInfo[0]);
			model.addAttribute("cultureDate", cultureInfo[1]);
			model.addAttribute("culturePlace", cultureInfo[2]);
			model.addAttribute("cultureLink", cultureInfo[3]);
			model.addAttribute("cultureImg", cultureInfo[4]);
		} catch (IOException e1) {
			e1.printStackTrace();
		}

		// 서울 새소식 넘기기
		try {
			model.addAttribute("newsInfo", commonService.getNews());

		} catch (IOException e1) {
			e1.printStackTrace();
		}

		// 로그인 확인 후 닉네임 넘기기
		if (principal != null) {
			String username = principal.getName();
			model.addAttribute("member", loginService.loadInfoByUsername(username));

			// 날씨 정보 불러오는 구문 /////////////////////
			String weatherData[] = null;
			try {
				weatherData = commonService.getWeather(commonService.selectGuForWeather(principal.getName()));
			} catch (IOException e) {
				e.printStackTrace();
			}
			model.addAttribute("weather", weatherData[0]);
			model.addAttribute("temperature", weatherData[1]);
			model.addAttribute("weatherGu", weatherData[2]);

		} else {
			log.warn("로그인 하지 않았음!");
		}
	}

	// 탭별로 게시글 가져오기
	@GetMapping("BoardTabListAjax")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> BoardTabListAjax(Criteria cri) {
		// 카테고리 별 탭 선택 시 해당 글목록 및 페이징 정보 넘기기
		Map<String, Object> map = new HashMap<>();

		map.put("voList", service.getListWithPagingTabs(cri));
		map.put("pagedto", new PageDTO(cri, service.getTotal(cri)));

		return new ResponseEntity<>(map, HttpStatus.OK);

	}

	// 등록화면
	@GetMapping("/register")
	public String register(Model model, Principal principal) {
		if (principal != null) {
			String username = principal.getName();
			model.addAttribute("member", myPageService.selectUser(username));
			return "/board/register";
		} else {
			return "/login/subLogin";
		}
	}

	// 등록처리
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		service.register(board);

		rttr.addFlashAttribute("result", board.getBno());

		return "redirect:/";
	};

	// 상세보기
	@GetMapping("/read/*")
	public String read(Model model, HttpServletRequest request, HttpServletResponse response, Principal principal,
			Criteria cri) {
		int bno = Integer.parseInt(request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/") + 1));
		BoardVO vo;

		try {
			vo = service.get(bno);
		} catch (Exception e) {
			return "/board/list";
		}
		System.out.println("vo출력");
		System.out.println(vo);

		HttpSession sessions = request.getSession();

		// 비교하기 위해 새로운 쿠키
		String viewSession = null;

		if (vo != null) {

			// 쿠키가 있을 경우
			if (sessions != null) {
				if (sessions.getAttribute("readSession" + vo.getBno().toString()) != null) {
					viewSession = sessions.getAttribute("readSession" + vo.getBno()).toString();
				}
			}

			model.addAttribute("board", vo);
			model.addAttribute("fileName", service.selectWriterProfile(vo.getNickname()));
			model.addAttribute("hotList", service.selectHotListFromRead(cri));
			System.out.println(service.selectHotListFromRead(cri));
			if (principal != null) {
				String username = principal.getName();
				model.addAttribute("member", myPageService.selectUser(username));
				String weatherData[] = null;
				try {
					weatherData = commonService.getWeather(commonService.selectGuForWeather(principal.getName()));
				} catch (IOException e) {
					e.printStackTrace();
				}
				model.addAttribute("weather", weatherData[0]);
				model.addAttribute("temperature", weatherData[1]);
				model.addAttribute("weatherGu", weatherData[2]);

				// 만일 viewCookie가 null일 경우 세션을 생성해서 조회수 증가 로직을 처리함.
				if (viewSession == null) {
					// 세션 생성(이름, 값)
					sessions.setAttribute("readSession" + vo.getBno(), "test");
					// 세션을 추가 시키고 조회수 증가시킴
					service.updateViewCount(vo.getBno());
				}
			}
			return "board/read";
		} else {
			return "/board/list";
		}
	}

	// 수정화면불러오기
	@GetMapping("/modify")
	public void modify(@RequestParam("bno") int bno, Model model) {
		model.addAttribute("board", service.get(bno));
	}

	// 수정처리
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}

	// 삭제
	@PostMapping("/remove")
	public String remoce(@RequestParam("bno") Long bno, RedirectAttributes rttr) {
		if (service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}

	// 이미지업로드
	@PostMapping(value = "/uploadSummernoteImageFile", produces = "application/json")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {

		JsonObject jsonObject = new JsonObject();

		String fileRoot = "C:\\summernote_image\\"; // 저장될 외부 파일 경로
		String originalFileName = multipartFile.getOriginalFilename(); // 오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자

		String savedFileName = UUID.randomUUID() + extension; // 저장될 파일 명

		File targetFile = new File(fileRoot + savedFileName);

		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
			jsonObject.addProperty("url", "/upload/image/" + savedFileName);
			// jsonObject.addProperty("responseCode", "success");

		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile); // 저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}

		return jsonObject.toString();
	}

	// 글신고하기
	@PostMapping("reportAjax")
	@ResponseBody
	public void reportAjax(ReportVO rvo) {
		service.reportBoard(rvo);
	}


	// 좋아요+1
	@GetMapping(value = "/read/plusLike/{bno}", produces = { MediaType.TEXT_PLAIN_VALUE })
	@ResponseBody
	public ResponseEntity<String> plusLike(@PathVariable("bno") int bno) {

		String result = Integer.toString(commonService.likeBoard(bno));
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}

	// 싫어요+1
	@GetMapping(value = "/read/plusUnlike/{bno}", produces = { MediaType.TEXT_PLAIN_VALUE })
	@ResponseBody
	public ResponseEntity<String> plusUnlike(@PathVariable("bno") int bno) {

		String result = Integer.toString(commonService.unlikeBoard(bno));
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}

	// 좋아요 테이블 넣기
	@PostMapping("insertLikeAjax")
	@ResponseBody
	public void insertLikeAjax(LikeVO vo) {
		service.insertLike(vo);
	}


	// 좋아요한지 체크
	@GetMapping("likeCheck")
	@ResponseBody
	public String likeCheck(LikeVO vo) {
		return service.likeCheck(vo);
	}


	// 좋아요 취소 
	@PostMapping("cancelLike")
	@ResponseBody
	void likeCancel(LikeVO vo) {
		service.cancelLike(vo);
		if (vo.getType() == 'L') {
			service.downLike(vo.getBno());
		} else if (vo.getType() == 'U') {
			service.downUnLike(vo.getBno());
		}
	}


}
