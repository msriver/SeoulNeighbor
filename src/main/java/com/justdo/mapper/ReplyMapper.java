package com.justdo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.justdo.domain.Criteria;
import com.justdo.domain.ReReplyVO;
import com.justdo.domain.ReplyVO;

public interface ReplyMapper {
	
	//댓글 등록
	public int insert(ReplyVO vo);
	
	//대댓글 등록
	public int reInsert(ReReplyVO vo);
	
	//댓글 하나 조회
	public ReplyVO read(int bno);
	
	//댓글 삭제
	public int delete(int no);
	
	//대댓글이 달린 댓글 삭제
	public int deleteExist(int no);
	
	//대댓글 삭제
	public int deleteRe(int no);
	
	//댓글 수정
	public int update(ReplyVO vo);
	
	//댓글 수정
	public int updateRe(ReplyVO vo);
	
	//댓글 목록 조회
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") int bno);
	
	//대댓글 가져오기
	public List<ReReplyVO> getReReplyList(@Param("cri") Criteria cri, @Param("bno") int bno);
	
	
	//댓글 전체 개수 가져오기
	public int getCountByBno(int bno);
	
}