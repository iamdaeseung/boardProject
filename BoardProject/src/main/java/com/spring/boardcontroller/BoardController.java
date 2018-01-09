package com.spring.boardcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.boardservice.BoardService;
import com.spring.boardvo.BoardVO;
import com.sun.istack.internal.logging.Logger;

@Controller //컨트롤러 어노테이션 
//컨트롤러와 메서드에 어노테이션을 모두 사용하면, 클래스에 적용한 값과 메서드에 적용한 값을 조합해서 매핑될 경로를 결정한다.
@RequestMapping(value = "/board") //기본경로 localhost:8090/board
public class BoardController {

		Logger logger = Logger.getLogger(BoardController.class);
		
		@Autowired
		private BoardService boardService;
		
		
		//게시판 리스트
		
		/**
		 * @ModelAttribute는 다른말로 커맨드 오브젝트라고도 불린다. 클라이언트가 전달하는 파라미터를 1:1로 전담 프로퍼티에 
		 * 담아내는 방식이 커맨드 패턴 그 자체이기 때문이다. 자동으로 바인딩해주고 중간 과정은 모두 자동으로 생략해준다.
		 **/
		@RequestMapping(value = "/boardList") //경로지정 localhost:8090/board/boardList -->클래스 매핑 + 메서드 매핑 
		public String boardList(@ModelAttribute BoardVO bvo, Model model) throws Exception{
			logger.info("게시판 리스트 호출"); //로그 확인
			
			//정렬에 대한 기본값 설정
			if(bvo.getOrder_by() == null) bvo.setOrder_by("b_num");
			if(bvo.getOrder_sc() == null) bvo.setOrder_sc("DESC");
			
			
			//정렬에 대한 데이터 확인
			logger.info("order_by = "+bvo.getOrder_by());
			logger.info("order_sc = "+bvo.getOrder_sc());
			
			//검색에 대한 데이터 확인
			logger.info("search = " +bvo.getSearch());
			logger.info("keyword = " + bvo.getKeyword());
			
			
			
			
			List<BoardVO> boardList = boardService.boardList(bvo);
			model.addAttribute("boardList",boardList);
			model.addAttribute("data",bvo);
			
			return "board/boardList";
		}
		
		//글쓰기 폼 
		@RequestMapping(value ="/writeForm", method=RequestMethod.GET) //클라이언트 요청처리시 GET방식
		public String wirteForm() throws Exception{
			logger.info("글쓰기 폼 호출");
			
			return "board/writeForm";
			
		}
		
		
		//글쓰기 구현
		@RequestMapping(value = "/boardInsert", method=RequestMethod.POST)
		public String boardInsert(@ModelAttribute BoardVO bvo) throws Exception{
			logger.info("글쓰기 성공");
			
			int result = 0;
			String url ="";
			
			result = boardService.boardInsert(bvo);
			if(result == 1) {
				url = "/board/boardList.do";
			}
			
			return "redirect:" + url ;
		
		}
		
		//글 상세 조회
		@RequestMapping(value = "/boardDetail", method=RequestMethod.GET)
		public String boardDetail(@ModelAttribute BoardVO pvo, Model model) throws Exception{
			logger.info("글 조회 호출");
			logger.info("게시글 번호 >>>>" + pvo.getB_num());
			
			BoardVO detail = new BoardVO();
			detail = boardService.boardDetail(pvo);
			
			if(detail != null && (!detail.equals(""))) {
				detail.setB_content(detail.getB_content().toString().replaceAll("\n", "<br>"));
			}
			
			model.addAttribute("detail", detail);
			
			return "board/boardDetail";
		}
		
		
		/**
		 * 비밀번화 확인
		 * @param b_num
		 * @param b_pwd
		 * @return int
		 * 참고 @ResponseBody는 전달된 뷰를 통해서 출력하는 것이 아니라
		 * 			HTTP Response Body에 직접 출력하는 방식
		 * */
		@ResponseBody
		@RequestMapping(value = "/pwdConfirm", method=RequestMethod.POST)
		public String pwdConfirm(@ModelAttribute BoardVO bvo) throws Exception{
			logger.info("비밀번호확인 호출");
			
			//아래 변수에는 입력 성공에 대한 상태값 저장 (1 or 0)
			int result = 0;
			result = boardService.pwdConfirm(bvo);
			logger.info("result = " + result);
			return "";
		}
		
		
		/**
		 * 글 수정 폼 
		 * @param :  b_num
		 * @return : BoardVO
		 */
		
		@RequestMapping(value = "updateForm", method=RequestMethod.POST)
		public String updateForm(@ModelAttribute BoardVO pvo, Model model) throws Exception{
			logger.info("수정 폼 호출");
			
			logger.info("게시글 번호 = " + pvo.getB_num());
			
			BoardVO updateData = new BoardVO();
			updateData = boardService.boardDetail(pvo);
			
			model.addAttribute("updateData" , updateData);
			
			return "board/updateForm";
		}
		
		/**
		 *글 수정 구현 
		 */
		@RequestMapping(value="/boardUpdate", method=RequestMethod.POST)
		public String boardUpdate(@ModelAttribute BoardVO bvo) throws Exception{
			logger.info("글수정 호출");
			
			int result = 0;
			String url = "";
			
			result = boardService.boardUpdate(bvo);
			
			if(result == 1) {
				url = "/boardboardList.do"; // 수정 후 목록으로 이동
				
				//url = "/board/boardDetail.do?b_num=" + bvo.getB_num(); //수정 후 상세페이지로 이동
			}
			return "redirect:"+url;
			
		}
		
		
		/**
		 * 글삭제
		 * */
		@RequestMapping(value="/boardDelete")
		public String boardDelete(@ModelAttribute BoardVO bvo) throws Exception {
			
			logger.info("삭제호출");
			
			//아래 변수에는 입력 성공에 대한 상태값을 담는다. (1 or 0)
			int result = 0;
			String url = "";
			
			result = boardService.boardDelete(bvo.getB_num());
			if(result ==1) {
						url="/board/boardList.do";
			}
			return " redirect:"+url;
			
		}
		
		
		
		
}
