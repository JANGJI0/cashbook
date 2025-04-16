<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%
	// DAO 받기
	StatsDao statsDao = new StatsDao();
	ArrayList<CashStats> statsList = statsDao.selectYearlyStats();
	
	// 수입/지출을 연도별로 분리 저장할 Map
	Map<Integer, CashStats> incomeMap = new HashMap<>();
	Map<Integer, CashStats> expenseMap = new HashMap<>();
	
	// 연도 목록 저장(DB에서 정해진 순서 유지하기위해)
	Set<Integer> yearSet = new LinkedHashSet<>();
	
	for(CashStats s : statsList) {
		yearSet.add(s.getYear());
		
		if ("수입".equals(s.getKind())) {
			incomeMap.put(s.getYear(), s);
		} else if ("지출".equals(s.getKind())) {
			expenseMap.put(s.getYear(), s);
		}
	}
	
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>년도별 수입/지출 총액</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
  .bar-wrapper {
    position: relative;
    height: 30px;
    margin-bottom: 20px;
    background-color: #eee;
    border-radius: 5px;
  }
  .bar {
    height: 100%;
    border-radius: 5px;
    color: #fff;
    padding: 0 10px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: bold;
  }
  .bar-emoji {
    font-size: 24px;
  }
</style>
</head>
<body class="d-flex justify-content-center align-items-start vh-100 bg-light">
	<div class="card mt-5 shadow p-4" style="width: 600px;">
	<h3 class="text-center mb-4">📅년도별 수입/지출 총액</h3>
		<table class="table table-bordered text-center align-middle">
			<thead class="table-light">
		
				<tr>
					<th>년도</th>
					<th>수입🐢</th>
					<th>총액</th>
					<th>지출🐇</th>
					<th>총액</th>
					<th>합계</th>
				</tr>
			</thead>
				<tbody>
				<%
					for(Integer year : yearSet) {
						CashStats income = incomeMap.getOrDefault(year, new CashStats());
						CashStats expense = expenseMap.getOrDefault(year, new CashStats());
						
						
						// 총합 = 수입 - 지출
						int totalAmount = income.getTotal() - expense.getTotal();
						
						// 부호 포함해서 출력할 합계 포맷팅
						String formattedTotal = (totalAmount > 0 ? "+" : (totalAmount < 0 ? "-" : "")) 
											  + String.format("%,d", Math.abs(totalAmount));
						
				%>
				<tr>
					<td><%=year %>년</td>
					<%
						if(income.getCnt() > 0) {
					%>
						<td><%=income.getCnt() %>건</td>
						<td>+<%=String.format("%,d", income.getTotal())%>원</td>
					<% } else { %>
							
						<td style="text-align: center;">-</td>
						<td style="text-align: center;">-</td>
						
					<%
						}
					%>
					<%
						if(expense.getCnt() > 0) {
					%>
						<td><%=expense.getCnt() %>건</td>
						<td>-<%=String.format("%,d", expense.getTotal())%>원</td>
					
					<%
						} else { 
					%>
						
						<td style="text-align: center;">-</td>
						<td style="text-align: center;">-</td>
					
					<%
						}
					%>
					<td><%=formattedTotal %>원</td>
				</tr>
		<%
			}
		%>
		
			</tbody>
	</table>
	<!-- 💡 전체 연도별 묶음을 가로로 나열 -->
<div class="d-flex flex-wrap justify-content-center gap-4">
<%
	// 그래프에 나타내기위해 for문
	for(Integer year : yearSet) {
		CashStats income = incomeMap.getOrDefault(year, new CashStats());
		CashStats expense = expenseMap.getOrDefault(year, new CashStats());
		
		int incomeTotal = income.getTotal();
		int expenseTotal = expense.getTotal();
		int yearSum = incomeTotal + expenseTotal;

		double incomePercent = yearSum > 0 ? (int)(incomeTotal * 100.0 / yearSum) : 0;
		double expensePercent = 100 - incomePercent;
		
		int incomeRatio = (int) incomePercent;
		int expenseRatio = (int) expensePercent;
%>

	<!-- 하나의 연도 묶음 -->
	<div class="text-center">
		<div class="d-flex align-items-end justify-content-center gap-3" style="height: 160px;">
			
			<!-- ✅ 수입 막대 -->
			<div style="width: 30px; height: 100%; background-color: #eee; border-radius: 10px; position: relative; overflow: hidden;">
				<div style="
					position: absolute;
					bottom: 0;
					height: <%=incomeRatio%>%;
					width: 100%;
					background-color: #4caf50;
					border-radius: 10px 10px 0 0;
					display: flex;
					justify-content: center;
					align-items: flex-start;
					padding-top: 5px;
				">
					<span style="font-size: 22px;">🐢</span>
				</div>
			</div>

			<!-- ✅ 지출 막대 -->
			<div style="width: 30px; height: 100%; background-color: #eee; border-radius: 10px; position: relative; overflow: hidden;">
				<div style="
					position: absolute;
					bottom: 0;
					height: <%=expenseRatio%>%;
					width: 100%;
					background-color: #f44336;
					border-radius: 10px 10px 0 0;
					display: flex;
					justify-content: center;
					align-items: flex-start;
					padding-top: 5px;
				">
					<span style="font-size: 15px;">🐇</span>
				</div>
			</div>

		</div>

		<!-- ✅ 퍼센트 아래 표시 -->
		<div class="d-flex justify-content-center gap-4 mt-1" style="font-size: 13px;">
			<div><%=String.format("%.1f", incomePercent)%>%</div>
			<div><%=String.format("%.1f", expensePercent)%>%</div>
		</div>


	<!-- 연도 표기  수입/지출 아래 중앙에-->
	<div class="fw-bold mt-2">
		<%=year%>년
	</div>
</div>

<% } %>
</div>
	<div class="text-center">
		<br>
		<a href="/cashbook/monthList.jsp" class="btn btn-secondary mb-3">달력으로 돌아가기</a>
	</div>
</body>
</html>











