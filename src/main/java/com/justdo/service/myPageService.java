package com.justdo.service;

import java.util.List;

import com.justdo.domain.BoardVO;
import com.justdo.domain.MemberVO;
import com.justdo.domain.MessageVO;
import com.justdo.domain.QAVO;

public interface myPageService {

	//유저 정보 가져오기
	public MemberVO selectUser(String id);
	
	//유저 정보 수정
	public void updateUser(MemberVO vo);
	
	//원래 파일 이름 가져오기
	public String getOriginalFileName(String userid);
	
	//비밀번호 변경
	public void updatePassword(MemberVO vo);
	
	//쪽지함 리스트 가져오기
	public List<MessageVO> selectMessageList(String userid, int pageNum);
	
	//미니 쪽지함 리스트 가져오기
	public List<MessageVO> selectMiniMessageList(String userid);
	
	//쪽지 총 개수
	public int selectCountMessage(String userid);
	
	//쪽지 답장하기
	public void sendMessage(MessageVO vo);
	
	//쪽지 사람 선택해서 보내기
	public void sendMessageToUser(MessageVO vo);
	
	//쪽지 받는사람 아이디 가져오기
	public String selectFindReceiver(int mno);
	
	//쪽지 삭제
	public void deleteMessage(int mno);
	
	//나의 게시글 불러오기
	public List<BoardVO> selectMyBoardList(String userid, int pageNum);
	
	//나의 게시글 총 개수
	public int selectCountMyBoardList(String userid);
	
	//1:1 문의 불러오기
	public List<QAVO> selectQAList(String userid, int pageNum);
	
	//1:1 문의 총 개수
	public int selectCountQAList(String userid);
	
	//1:1 문의 올리기
	public void insertQA(QAVO qvo);
	
	//쪽지 읽음 업데이트
	public void updateReadCheck(int mno);
	
	//비밀번호 변경 위한 비밀번호 가져오기
	public String selectUserPw(String userid);
}
