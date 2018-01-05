package com.spring.boarddao;

import java.util.List;

import com.spring.boardvo.BoardVO;

public interface BoardDao {

	public List <BoardVO> boardList(BoardVO pvo) throws Exception;

	public int boardInsert(BoardVO pvo) throws Exception;

	public BoardVO boardDetail(BoardVO pvo) throws Exception;

	public int pwdConfirm(BoardVO pvo) throws Exception;
	
	public int boardUpdate(BoardVO pvo) throws Exception;
	
	public int boardDelete(int b_num) throws Exception;
	
}
