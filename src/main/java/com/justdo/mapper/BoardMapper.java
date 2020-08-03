package com.justdo.mapper;

import java.util.List;

import com.justdo.domain.BoardVO;
import com.justdo.domain.Criteria;
import com.justdo.domain.LikeVO;
import com.justdo.domain.ReportVO;

public interface BoardMapper {
	
	//지역 정보 가져오기
	public List<BoardVO> getLocationList(Criteria cri);
	
	//페이징된 리스트 가져오기
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public List<BoardVO> getListWithPagingTabs(Criteria cri);
	
	//게시글 전체 개수 가져오기
	public int getTotalCount(Criteria cri);
	
	//목록
	public List<BoardVO> getList();
	
	//등록
	public void insert(BoardVO board);
	
	//조회
	public BoardVO read(int bno);
	
	//삭제
	public int delete(Long bno);
	
	//수정
	public int update(BoardVO board);
	
	//like좋아요
	public int like(int bno);
	
	//해당 bno의 좋아요 숫자를 가져옵니다.
    public int selectLikeCount(int bno);
	   
	//unlike 싫어요
	public int unlike(int bno);
	
	//해당 bno의 싫어요 숫자를 가져옵니다.
    public int selectUnlikeCount(int bno);	
    
    //해당 bno의 board 삭제.
	public int delete(int bno);
	
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
	public void downLike(int bno);
	
	//싫어요 감소
	public void downUnLike(int bno);
}
