<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="/resources/include/css/board.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript">
		$(document).ready(function() {
			/* 수정 버튼 클릭 시 처리 이벤트 */
			$("#boardUpdate").click(function() {
				//입력값 체크
				if (!chkSubmit($('#b_name'), "이름을"))
					return;
				else if (!chkSubmit($('#b_title'), "제목을"))
					return;
				else if (!chkSubmit($('#b_content'), "작성할 내용을"))
					return;
				else {
					$("#f_writeForm").attr("method", "POST");
					$("#f_writeForm").attr("action", "/board/boardUpdate.do");
					$("#f_writeForm").submit();
				}
			});
				/* 목록 버튼 클릭 시 처리 이벤트 */
				$("#boardList").click(function() {
					location.href = "/board/boardList.do";
				});
		});
</script>
</head>
<body>
		<div id="boardTit">
			<h3>글수정</h3>
		</div>
		<form id="f_writeForm" name="f_writeForm">
			<input type="hidden" id="b_num" name="b_num" value="${updateData.b_num}" />
			<table cellspacing="0" cellpadding="0" id="boardWrite">
				<tr>
					<td>작성자</td>
					<td><input type="text" name="b_name" id="b_name" value="${updateData.b_name}" /></td>
				</tr>
				<tr>
						<td>글제목</td>
						<td><input type="text" name="b_title" id="b_title" value="${updateData.b_title}" /></td>
				</tr>	
				<tr>
						<td>내용</td>
						<td height="200">
						<td height="200"> <textarea name="b_content" id="b_content" rows="10"
							cols="70">${updateData.b_content}</textarea></td>
				</tr>
				<tr>
				<td>비밀번호</td>
				<td><input type="password" name="b_pwd" id="b_pwd" />
				 <label>수정할 비밀번호를 입력해 주세요.</label></td>
				</tr>
			</table>
		</form>		
		
		<div id="boardBut">
			<input type="button" value="수정" class="but" id="boardUpdate" />
			<input type="button" value="목록" class="but" id="boardList" />
		</div>	
				
</body>
</html>