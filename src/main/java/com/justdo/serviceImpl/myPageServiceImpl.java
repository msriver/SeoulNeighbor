package com.justdo.serviceImpl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.justdo.domain.BoardVO;
import com.justdo.domain.MemberVO;
import com.justdo.domain.MessageVO;
import com.justdo.domain.QAVO;
import com.justdo.mapper.myPageMapper;
import com.justdo.service.myPageService;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service("myPageService")
public class myPageServiceImpl implements myPageService {
	
	private myPageMapper mapper;

	@Override
	public MemberVO selectUser(String id) {
		return mapper.selectUser(id);
	}

	@Override
	public void updateUser(MemberVO vo) {
		mapper.updateUser(vo);
	}

	@Override
	public String getOriginalFileName(String userid) {
		return mapper.getOriginalFileName(userid);
	}

	@Override
	public void updatePassword(MemberVO vo) {
		mapper.updatePassword(vo);
	}

	@Override
	public List<MessageVO> selectMessageList(String userid, int pageNum) {
		return mapper.selectMessageList(userid,pageNum);
	}

	@Override
	public int selectCountMessage(String userid) {
		return mapper.selectCountMessage(userid);
	}

	@Override
	public void sendMessage(MessageVO vo) {
		mapper.sendMessage(vo);
	}
	
	@Override
	public void sendMessageToUser(MessageVO vo) {
		mapper.sendMessageToUser(vo);
	}
	@Override
	public String selectFindReceiver(int mno) {
		return mapper.selectFindReceiver(mno);
	}
	
	@Override
	public void deleteMessage(int mno) {
		mapper.deleteMessage(mno);
	}

	@Override
	public List<BoardVO> selectMyBoardList(String userid, int pageNum) {
		return mapper.selectMyBoardList(userid, pageNum);
	}

	@Override
	public int selectCountMyBoardList(String userid) {
		return mapper.selectCountMyBoardList(userid);
	}

	@Override
	public List<QAVO> selectQAList(String userid, int pageNum) {
		return mapper.selectQAList(userid, pageNum);
	}

	@Override
	public int selectCountQAList(String userid) {
		return mapper.selectCountQAList(userid);
	}

	@Override
	public void insertQA(QAVO qvo) {
		mapper.insertQA(qvo);
	}

	@Override
	public List<MessageVO> selectMiniMessageList(String userid) {
		return mapper.selectMiniMessageList(userid);
	}

	@Override
	public void updateReadCheck(int mno) {
		mapper.updateReadCheck(mno);
	}

	@Override
	public String selectUserPw(String userid) {
		return mapper.selectUserPw(userid);
	}



}
