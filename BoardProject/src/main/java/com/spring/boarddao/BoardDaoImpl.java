package com.spring.boarddao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.boardvo.BoardVO;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Inject
	private SqlSession sqlSession;
	
	
	//게시판 리스트
	@Override
	public List<BoardVO> boardList(BoardVO pvo) throws Exception {
	
		return sqlSession.selectList("boardList",pvo);
	}


	//글쓰기
	@Override
	public int boardInsert(BoardVO pvo) throws Exception {
		
		return sqlSession.insert("boardInsert", pvo);
	}


	//글 조회
	@Override
	public BoardVO boardDetail(BoardVO pvo) throws Exception {
		
		return sqlSession.selectOne("boardDetail", pvo);
	}


	//비밀번호 확인
	@Override
	public int pwdConfirm(BoardVO pvo) throws Exception {
		
		return sqlSession.selectOne("pwdConfirm", pvo);
	}


	//글 수정
	@Override
	public int boardUpdate(BoardVO pvo) throws Exception  {
		
		return sqlSession.update("boardUpdate", pvo);
	}


	//삭제
	@Override
	public int boardDelete(int b_num) throws Exception {
		
		return sqlSession.delete("boardDelete", b_num);
	}
	

}
