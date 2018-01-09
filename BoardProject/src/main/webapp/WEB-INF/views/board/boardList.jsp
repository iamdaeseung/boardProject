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
			
		/* 검색 후 검색 대상과 검색 단어 출력 */
		if("<c:out value='${data.keyword}' />"!=""){
			$("#keyword").val("<c:out value='${data.keyword}' />");
			$("#search").val("<c:out value='${data.search}' />");
		}
		
		/* 검색 대상이 변경될 때마다 처리 이벤트 */
		$("#search").change(function() {
			if($("#search").val()=="all"){
					$("#keyword").val("글 목록 전체");
			}else if($("#search").val()!="all"){
				$("#keyword").val("");
				$("#keyword").focus();
			}
		});
		
		/* 검색 버튼 클릭 시 처리 이벤트 */
		$("#searchData").click(function(){
				if($("#search").val()=="all"){
						$("#keyword").val("");
			}else{
				if (!chkSubmit($('#keyword'),"검색어를")) return;
			}
			goPage(1);
		});	
		
		/* 글쓰기 버튼 클릭 시 처리 이벤트 */
		$("#writeForm").click(function(){
			location.href = "/board/writeForm.do";
		});
	});
	
	
	
	/* 정렬 버튼 클릭 시 처리 함수 */
	function setOrder(order_by){
		$("#order_by").val(order_by);
		if($("#order_sc").val()=='DESC'){
					$("#order_sc").val('ASC');
		} else{
					$("#order_sc").val('DESC');
		}
		goPage(1);
	}
		
	/*정렬 및 검색 시 실질적인 처리 함수*/
	function goPage(page){
			$("#page").val(page);
			$("#f_search").attr("method","get");
			$("#f_search").attr("action","/board/boardList.do");
			$("#f_search").submit();
	}	
	
	/* 상세 페이지 이동 함수 */
	function goDetail(b_num){
		location.href="/board/boardDetail.do?b_num="+b_num;
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
	
	<%-- ============== 검색기능 시작(이 부분을 추가하면 된다) =============--%>
	<div id="boardSearch">
		<form id="f_search" name="f_search">
			<input type="hidden" id="page" name="page" value="1"/>
			<input type="hidden" id="order_by" name="order_by" value="${data.order_by}"/>
			<input type="hidden" id="order_sc" name="order_sc" value="${data.order_sc}"/>
			<table border="0" summary="검색">
				<colgroup>
					<col width="70%"></col>
					<col width="30%"></col>
				</colgroup>
					<tr>
						<td id="btd1">
							<label>검색조건</label>
								<select id="search" name="search">
									<option value="all">전체</option>
									<option value="b_title">제목</option>
									<option value="b_content">내용</option>
									<option value="b_name">작성자</option>
								</select>
								<input type="text" name="keyword" id="keyword" placeholder="검색어를입력하세요" />
								<input type="button" value="검색" id="searchData" />
									</td>
								</tr>
						</table>
					</form>
				</div>
	<%-- ================== 검색기능 종료 =================--%>							
									
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
					<th>
						<a href="javascript:setOrder('b_num');">글번호
							<c:choose>
								<c:when test="${data.order_by=='b_num'
										and data.order_sc=='ASC'}">▲</c:when>
								<c:when test="${data.order_by=='b_num'
									and data.order_sc=='DESC'}">▼</c:when>
								<c:otherwise>▲</c:otherwise>
							</c:choose>
					</a>
				</th>			
					<th>글제목</th>
					<th>
						<a href="javascript:setOrder('b_date');">작성일
							<c:choose>
								<c:when test="${data.order_by=='b_date'
										and data.order_sc=='ASC'}">▲</c:when>
								<c:when test="${data.order_by=='b_date' 
										and data.order_sc=='DESC'}">▼</c:when>
										<c:otherwise>▲</c:otherwise>		
							</c:choose>
						</a>
					</th>								
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