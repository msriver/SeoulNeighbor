package com.justdo.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.justdo.domain.BoardVO;
import com.justdo.domain.Criteria;
import com.justdo.domain.LikeVO;
import com.justdo.domain.ReportVO;
import com.justdo.mapper.BoardMapper;
import com.justdo.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Log4j
@Service
@AllArgsConstructor
public class BoardServicelmpl implements BoardService{
	@Setter(onMethod_= @Autowired)
	private BoardMapper mapper;//자동주입
	
	
//	@Override
//	public List<BoardVO> getList() {
//		return mapper.getList();
//	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public List<BoardVO> getListWithPagingTabs(Criteria cri) {
		return mapper.getListWithPagingTabs(cri);
	}


	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}


	@Override
	public List<BoardVO> getLocationList(Criteria cri) {
		return mapper.getLocationList(cri);
	}
	
	// 등록
	@Override
	public void register(BoardVO board) {
		log.info("register......" + board);
		mapper.insert(board);
	}
	
	//상세보기
	@Override
	public BoardVO get(int bno) {
		log.info("get......" + bno);
		return mapper.read(bno);
	}

	//수정
	@Override
	public boolean modify(BoardVO board) {
		log.info("modify......" + board);
		return mapper.update(board)==1;
	}

	//삭제
	@Override
	public boolean remove(Long bno) {
		log.info("remove......" + bno);
		return mapper.delete(bno)==1;
	}

	//목록
	@Override
	public List<BoardVO> getList() {
		log.info("getList......");
		return mapper.getList();
	}

	@Override
	public String selectWriterProfile(String nickname) {
		return mapper.selectWriterProfile(nickname);
	}

	@Override
	public void reportBoard(ReportVO rvo) {
		mapper.reportBoard(rvo);
	}

	@Override
	public List<BoardVO>selectHotListFromRead(Criteria cri) {
		return mapper.selectHotListFromRead(cri);
	}

	@Override
	public void updateViewCount(Long bno) {
		mapper.updateViewCount(bno);
	}

	@Override
	public void insertLike(LikeVO vo) {
		mapper.insertLike(vo);
	}

	@Override
	public String likeCheck(LikeVO vo) {
		return mapper.likeCheck(vo);
	}

	@Override
	public void cancelLike(LikeVO vo) {
		mapper.cancelLike(vo);
	}

	@Override
	public void downLike(int bno) {
		mapper.downLike(bno);
	}

	@Override
	public void downUnLike(int bno) {
		mapper.downUnLike(bno);
	}

}
