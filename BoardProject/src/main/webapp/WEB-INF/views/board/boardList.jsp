<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>

<link rel="stylesheet" type="text/css" href="/resources/include/css/board.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript">

	$(document).ready(function() {

		/* 글쓰기 버튼 클릭 시 처리 이벤트*/$("#writeForm").click(function() {
			location.href = "/board/writeForm.do";
		});
	});

	/* 상세 페이지 이동 함수 */function goDetail(b_num) {
		location.href = "/board/boardDetail.do?b_num=" + b_num;
	}
</script>

</head>
<body>
	<div id="boardhome">
		<h2>
			<a href="/">HOME</a>
		</h2>
	</div>
	<div id="boardTit">
		<h3>글목록</h3>
	</div>
	<%-- =================== 리스트 시작 ================== --%>
	<div id="boardList">
		<table cellspacing="0" cellpadding="0" summary="게시판 리스트">
			<colgroup>
				<col width="10%" />
				<col width="62%" />
				<col width="15%" />
				<col width="13%" />
			</colgroup>
			<thead>
				<tr>
					<th>글번호</th>
					<th>글제목</th>
					<th>작성일</th>
					<th class="borcle">작성자</th>
				</tr>
			</thead>
			<tbody>
				<!-- 데이터 출력 -->
				<c:choose>
					<c:when test="${not empty boardList}">

						<c:forEach var="board" items="${boardList}" varStatus="status">
							<tr align="center">
								<td>${board.b_num}</td>
								<td align="left"><a
									href="javascript:goDetail(${board.b_num})">${board.b_title}</a></td>
								<td>${board.b_date}</td>
								<td>${board.b_name}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4" align="center">등록된 게시물이 존재하지 않습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
	<%-- =================== 리스트 종료 ================== --%>
	<%-- ================ 글쓰기 버튼 출력 시작 =============== --%>
	<div id="boardBut">
		<input type="button" value="글쓰기" id="writeForm">
	</div>
	<%-- ================ 글쓰기 버튼 출력 종료 =============== --%>
</body>
</html>