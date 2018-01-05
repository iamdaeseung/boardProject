package com.spring.boardservice;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.boarddao.BoardDao;
import com.spring.boardvo.BoardVO;

@Service
@Transactional
public class BoardServiceImpl implements BoardService{
		Logger logger = Logger.getLogger(BoardServiceImpl.class);
		
		@Autowired
		private BoardDao boardDao;

		
	//게시판 리스트	
	@Override
	public List<BoardVO> boardList(BoardVO pvo) throws Exception{
			List<BoardVO> myList = new ArrayList<BoardVO>();
			myList = boardDao.boardList(pvo);
			
		return myList;
	}

	//글쓰기
	@Override
	public int boardInsert(BoardVO pvo) throws Exception {
		int result = 0;
		result = boardDao.boardInsert(pvo);
		return result;
	}

	//글 조회
	@Override
	public BoardVO boardDetail(BoardVO pvo) throws Exception {
		BoardVO detail = null;
		detail = boardDao.boardDetail(pvo);
		return detail;
	}

	
	//비밀번호 확인
	@Override
	public int pwdConfirm(BoardVO pvo) throws Exception {
		int result = 0;
		result = boardDao.pwdConfirm(pvo);
		return result;
	}

	//글 수정
	@Override
	public int boardUpdate(BoardVO pvo) throws Exception {
			int result = 0;
			result = boardDao.boardUpdate(pvo);
		return result;
	}

	//글 삭제
	@Override
	public int boardDelete(int b_num) throws Exception {
			int result = 0 ;
			result = boardDao.boardDelete(b_num);
		return result;
	}

}
