<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="/resources/include/css/board.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript">
			
			var butChk = 0; // 수정버튼과 삭제버튼을 구별하기 위한 변수
			$(document).ready(function(){
				$("#pwdChk").hide();
				
				/* 수정 버튼 클릭 시 처리 이벤트 */	
				$("#updateForm").click(function(){
					$("#pwdChk").show();
					$("#msg").text("작성시 입력한 비밀번호를 입력해 주세요.")
					.css("color","#000099");
						butChk = 1;
				});	
				
				
				/* 삭제 버튼 클릭 시 처리 이벤트 */
				$("#boardDelete").click(function(){
					$("#pwdChk").show();
					$("#msg").text("작성시 입력한 비밀번호를 입력해 주세요.")
					.css("color","#000099");
					butChk = 2;
				});
				
				
				/* 비밀번호 확인 버튼 클릭 시 처리 이벤트 */
				$("#pwdBut").click(function(){
					pwdConfirm();
					
				});
				
				/* 목록 버튼 클릭 시 처리 이벤트 */
				$("#boardList").click(function(){
					location.href="/board/boardList.do";
				});
			});	
			
			/* 비밀번호 클릭시 실질적인 처리 함수 */
			function pwdConfirm(){
				if (!chkSubmit($('#b_pwd'),"비밀번호를")) return;
				else {
							$.ajax({
								url : "/board/pwdConfirm.do", //전송 url
								type : "POST", // 전송 시 method 방식
								data : $("#f_pwd").serialize(), //폼전체 데이터 전송
								error : function(){ //실행시 오류가 발생하였을 경우
									alert('시스템 오류 입니다. 관리자에게 문의 하세요');
								}, 							//정상적으로 실행이 되었을 경우
								success : function(resultData){
									var goUrl=""; // 이동할 경로를 저장할 변수
									if(resultData==0){ // 일치하지 않는 경우
										$("#msg").text("작성시 입력한 비밀번호가 일치하지 않습니다.").css("color","red");
										$("#b_pwd").select();
									}else if(resultData==1){ // 일치할 경우
										$("#msg").text("");
										if(butChk==1){
											goUrl = "/board/updateForm.do";
										}else if(butChk==2){
											goUrl = "/board/boardDelete.do";
										}
										$("#f_data").attr("action",goUrl);
										$("#f_data").submit();
											
								}
							}
						});
				    }
				}
</script>
</head>
<body>

		<div id="boardTit"><h3>글상세</h3></div>
		<form name="f_data" id="f_data" method="POST">
				<input type="hidden" name="b_num" id="b_num" value="${detail.b_num}"/>
		</form>
		<%-- ========= 비밀번호 확인 버튼 및 버튼 추가 시작 ====== --%>
		<table id="boardPwdBut">
			<tr>
					<td id="btd1">
						<div id="pwdChk">
							<form name="f_pwd" id="f_pwd">
								<input type="hidden" name="b_num" id="b_num" value="${detail.b_num}"/>
								<label for="b_pwd" id="l_pwd">비밀번호 : </label>
								<input type="password" name="b_pwd" id="b_pwd" />	
								<input type="button" id="pwdBut" value="확인" />
								<span id="msg"></span>
								</form>
						</div>
					</td>
					
				<td id="btd2">
					<input type="button" value="수정" id="updateForm">	
					<input type="button" value="삭제" id="boardDelete">
					<input type="button" value="목록" id="boardList">	
			  </td>
			</tr>
		</table>
		<%-- ========= 비밀번호 확인 버튼 및 버튼 추가 종료 ====== --%>
		
		<%-- =============== 상세 정보 보여주기 시작 ============ --%>
		<div id="boardDetail">
			<table cellspacing="0" cellpadding="0" >
				<colgroup>
						<col width="25%" />
						<col width="25%" />
						<col width="25%" />
						<col width="25%" />
				</colgroup>
				<tbody>
					<tr>
						<td class="ac">작성자</td>
						<td>${detail.b_name}</td>
						<td class="ac">작성일</td>
						<td>${detail.b_date}</td>
					</tr>
					
					<tr>
						<td class="ac">제목</td>
						<td colspan="3">${detail.b_title}</td>
					</tr>
					
					<tr class="ctr">
					<td class="ac">내용</td>
					<td colspan="3">${detail.b_content}</td>
				   </tr>
				</tbody>
			</table>					   	
		</div>
</body>
</html>