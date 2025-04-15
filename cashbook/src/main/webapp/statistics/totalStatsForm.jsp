<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%
System.out.println("📌 totalStatsForm.jsp 들어옴!");
	// monthList에서 kind 값 받기
	String kind = request.getParameter("kind");
	System.out.println("넘어온 kind: " + kind); // ← 꼭 확인용으로 찍어보기
	
	// DAO 받아오기
	StatsDao statsDao = new StatsDao();
	ArrayList<CashStats> statsList = statsDao.selectCashStats();
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h2>수입/지출 통계</h2>
	<table border="1">
		<tr>
			<th>종류</th>
			<th>건수</th>
			<th>총액</th>
		</tr>
	<%
		for(CashStats s : statsList) {
			String totalWithComma = String.format("%,d", s.getTotal()); // 숫자에 콤마 찍는 객체
	%>
		<tr>
			<td><%=s.getKind() %></td>
			<td><%=s.getCnt() %>건</td>
			<td><%=totalWithComma %>원</td>
		</tr>
	<%
		}
	%>
	</table>
	<a href="/cashbook/monthList.jsp" class="btn btn-secondary mb-3">← 달력으로 돌아가기</a>
</body>
</html>










