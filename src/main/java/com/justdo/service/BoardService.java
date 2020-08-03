package com.justdo.service;

import java.util.List;

import com.justdo.domain.BoardVO;
import com.justdo.domain.Criteria;
import com.justdo.domain.LikeVO;
import com.justdo.domain.ReportVO;

public interface BoardService {
	public List<BoardVO> getLocationList(Criteria cri);
	
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public List<BoardVO> getListWithPagingTabs(Criteria cri);
	
	//등록
	public void register(BoardVO board);
	
	//상세보기
	public BoardVO get(int bno);
	
	//수정
	public boolean modify(BoardVO board);
	
	//삭제
	public boolean remove(Long bno);
	
	//목록
	public List<BoardVO> getList();
	
	//글쓴이 프로필 사진 가져오기
	public String selectWriterProfile(String nickname);
	
	//글 신고하기
	public void reportBoard(ReportVO rvo);
	
	//상세글에서 인기글
	public List<BoardVO> selectHotListFromRead(Criteria cri);
	
	//조회수 증가
	public void updateViewCount(Long bno);
	
	//좋아요 테이블 추가
	public void insertLike(LikeVO vo);
	
	//좋아요 체크
	public String likeCheck(LikeVO vo);
	
	//좋아요 취소
	public void cancelLike(LikeVO vo);
	
	//좋아요 감소
	public void downLike(int i);
	
	//싫어요 감소
	public void downUnLike(int bno);
}
