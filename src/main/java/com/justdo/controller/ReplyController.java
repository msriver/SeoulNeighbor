package com.justdo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.justdo.domain.Criteria;
import com.justdo.domain.ReReplyVO;
import com.justdo.domain.ReplyVO;
import com.justdo.service.ReplyService;

import lombok.AllArgsConstructor;

@RestController
@RequestMapping("/reply/")
@AllArgsConstructor
public class ReplyController {
	private ReplyService service;
	
	//댓글 등록
	@PostMapping(value = "/new", consumes = "application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
		int insertCount = service.register(vo);
		
		return insertCount == 1 ? 
				new ResponseEntity<String>("success", HttpStatus.OK) :
				new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//대댓글 등록
	@PostMapping(value = "/newRe", consumes = "application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> createRe(@RequestBody ReReplyVO vo) {
		int insertCount = service.reRegister(vo);
		
		return insertCount == 1 ? 
				new ResponseEntity<String>("success", HttpStatus.OK) :
				new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 한개 조회
	@GetMapping(value="/{rno}" , produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") int rno) {
		return new ResponseEntity<ReplyVO>(service.get(rno), HttpStatus.OK);
	}
	
	//댓글 삭제
	@DeleteMapping(value="/delete/{no}/{type}/{exist}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<String> remove(@PathVariable("no") int no,@PathVariable("exist") int exist, @PathVariable("type") int type) {
		
		int result = 0;
		
		if(type == 1) {
			result = service.removeRe(no); 
		} else if(type == 0) {
			
			if(exist == 0) {
				result = service.remove(no);
			} else if(exist == 1) {
				result = service.removeExist(no);
			}
			

		}
		return result == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 수정
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH}, 
			value = "/update/{no}/{type}",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("no") int no, @PathVariable("type") int type){
		vo.setRno(no);
		
		int result = 0;
		
		if(type == 1) {
			result = service.modifyRe(vo);
		} else if(type == 0) {
			result = service.modify(vo);
		}
		
		
		return result == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 목록 조회
	@GetMapping(value = "/pages/{bno}/{page}",
			produces = {
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<Map<String, Object>> getList(@PathVariable("page") int page, @PathVariable("bno") int bno){
		
		
		Map<String, Object> map = new HashMap<>();
		
		if(page <0) {
			map.put("replyCount", service.getReplyCount(bno));
			return new ResponseEntity<>(map, HttpStatus.OK);
		}
		
		Criteria cri = new Criteria();
		cri.setAmount(10);
		cri.setPageNum(page);
		
		map.put("replyCount", service.getReplyCount(bno));
		map.put("replyList", service.getList(cri, bno));
		map.put("reReplyList", service.getReList(cri, bno));
		
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	//댓글 총 개수 구하기 (tbl_reply 에서만 rno 개수를 셈, 페이징을 위한 갯수)
	@GetMapping(value = "/getCount/{bno}")
	public ResponseEntity<String> getCount(@PathVariable("bno") int bno) {
		int replyCount = service.getReplyCount(bno);
		
		return new ResponseEntity<>(Integer.toString(replyCount), HttpStatus.OK);
	}
	
	
}