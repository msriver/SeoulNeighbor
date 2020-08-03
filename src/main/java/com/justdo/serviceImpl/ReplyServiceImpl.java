package com.justdo.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.justdo.domain.Criteria;
import com.justdo.domain.ReReplyVO;
import com.justdo.domain.ReplyVO;
import com.justdo.mapper.ReplyMapper;
import com.justdo.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@Service("replyService")
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_= @Autowired)
	private ReplyMapper mapper;

	//댓글 등록
	@Override
	public int register(ReplyVO vo) {
		return mapper.insert(vo);
	}
	
	//대댓글 등록
	@Override
	public int reRegister(ReReplyVO vo) {
		
		return mapper.reInsert(vo);
	}

	//댓글 조회 1개
	@Override
	public ReplyVO get(int bno) {
		return mapper.read(bno);
	}

	//댓글 수정
	@Override
	public int modify(ReplyVO vo) {

		return mapper.update(vo);
	}
	
	//대댓글 수정
	@Override
	public int modifyRe(ReplyVO vo) {
		return mapper.updateRe(vo);
	}

	//댓글 삭제
	@Override
	public int remove(int rno) {
		return mapper.delete(rno);
	}
	
	//대댓글이 달린 댓글 삭제
	@Override
	public int removeExist(int no) {
		return mapper.deleteExist(no);
	}
	
	//대댓글 삭제
	@Override
	public int removeRe(int no) {
		return mapper.deleteRe(no);
	}

	//댓글 리스트 with paging
	@Override
	public List<ReplyVO> getList(Criteria cri, int bno) {
		return mapper.getListWithPaging(cri, bno);
	}
	
	//대댓글 리스트
	@Override
	public List<ReReplyVO> getReList(Criteria cri, int bno) {
		return mapper.getReReplyList(cri, bno);
	}

	//댓글 총 갯수 구하기 (페이징처리 위함)
	@Override
	public int getReplyCount(int bno) {
		return mapper.getCountByBno(bno);
	}

	
}
