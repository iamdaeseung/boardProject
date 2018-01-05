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
	public List<BoardVO> boardList(BoardVO pvo) {
	
		return sqlSession.selectList("boardList",pvo);
	}


	//글쓰기
	@Override
	public int boardInsert(BoardVO pvo) {
		
		return sqlSession.insert("boardInsert");
	}


	//글 조회
	@Override
	public BoardVO boardDetail(BoardVO pvo) {
		
		return sqlSession.selectOne("boardDetail", pvo);
	}


	//비밀번호 확인
	@Override
	public int pwdConfirm(BoardVO pvo) {
		
		return sqlSession.selectOne("pwdConfirm", pvo);
	}
	

}
