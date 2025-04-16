<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%
	// DAO 받기
	StatsDao statsDao = new StatsDao();
	ArrayList<CashStats> statsList = statsDao.selectMonthlyStats();
	
	// 수입/지출을 연도별로 분리 저장할 Map
	Map<Integer, CashStats> incomeMap = new HashMap<>();
	Map<Integer, CashStats> expenseMap = new HashMap<>();
	
	// 연도 목록 저장(DB에서 정해진 순서 유지하기위해) / db에 데이터가 없어도 강제로 보여주기위해
	Set<Integer> monthSet = new LinkedHashSet<>();
		for (int i = 1; i <= 12; i++) {
		    monthSet.add(i);
			}
	
	for(CashStats s : statsList) {
		monthSet.add(s.getMonth());
		
		if ("수입".equals(s.getKind())) {
			incomeMap.put(s.getMonth(), s);
		} else if ("지출".equals(s.getKind())) {
			expenseMap.put(s.getMonth(), s);
		}
	}
	
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>월별 수입/지출 총액</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
	body {
		background-color: #f8f9fa;
	}
	.table-center {
    margin: 0 auto;
    max-width: 650px;
  	}
	.bar-wrapper {
		position: relative;
		height: 20px;
		margin: 6px auto;
		margin-bottom: 10px;
		background-color: #eee;
		border-radius: 5px;
		max-width: 300px;
	}
	.bar {
		height: 100%;
		border-radius: 5px;
		color: #fff;
		padding-left: 6px;
		display: flex;
		justify-content: space-between;
		align-items: center;
		font-weight: bold;
		font-size: 12px;
	}
	.bar-emoji {
		margin-right: 5px;
		font-size: 16px;
	}
	</style>
</head>
<body class="d-flex justify-content-center align-items-start vh-100 bg-light">
    <div class="card shadow p-4">
	<h3 class="text-center mb-4">📅월별 수입/지출 총액(전체년도)</h3>
		
		<div class="row">
			<div class="col-md-12">
			<table class="table table-bordered text-center align-middle table-center">
            <thead class="table-light">
				<tr>
					<th>월</th>
					<th>수입</th>
					<th>총액</th>
					<th>지출</th>
					<th>총액</th>
					<th>합계</th>
				</tr>
				</thead>
            <tbody>
		<%
			for(Integer month : monthSet) {
				CashStats income = incomeMap.getOrDefault(month, new CashStats());
				CashStats expense = expenseMap.getOrDefault(month, new CashStats());
				
				// 총합 = 수입 - 지출
				int totalAmount = income.getTotal() - expense.getTotal();
				
				// 부호 포함해서 출력할 합계 포맷팅
				String formattedTotal = (totalAmount > 0 ? "+" : (totalAmount < 0 ? "-" : "")) 
									  + String.format("%,d", Math.abs(totalAmount));
		%>
				<tr>
					<td><%=month %>월</td>
					<% if (income.getCnt() > 0) { %>
						<td><%=income.getCnt() %>건</td>
						<td class="text-success">+<%=String.format("%,d", income.getTotal()) %>원</td>
					<% } else { %>
						<td>-</td><td>-</td>
					<% } %>

					<% if (expense.getCnt() > 0) { %>
						<td><%=expense.getCnt() %>건</td>
						<td class="text-danger">-<%=String.format("%,d", expense.getTotal()) %>원</td>
					<% } else { %>
						<td>-</td><td>-</td>
					<% } %>

					<td><%=formattedTotal %>원</td>
				</tr>
				<% } %>
				</tbody>
			</table>
			</div>
			
			<!-- 그래프 -->
		<div class="row mt-3">
	  <!-- 좌측: 1~6월 -->
	  <div class="col-md-6 ">
	    <% for (int month = 1; month <= 6; month++) {
	      CashStats income = incomeMap.getOrDefault(month, new CashStats());
	      CashStats expense = expenseMap.getOrDefault(month, new CashStats());
	      int incomeTotal = income.getTotal();
	      int expenseTotal = expense.getTotal();
	      int total = incomeTotal + expenseTotal;
	      double incomePercent = (total > 0) ? incomeTotal * 100.0 / total : 0;
	      double expensePercent = (total > 0) ? expenseTotal * 100.0 / total : 0;
	    %>
	      <h6><%=month %>월</h6>
	      <div class="bar-wrapper">
	        <div class="bar" style="width: <%= (int)incomePercent %>%; background-color: #4CAF50;">
	          <span><%= String.format("%.1f", incomePercent) %>%</span>
	          <span class="bar-emoji" style="transform: scaleX(-1);">🐢</span>
	        </div>
	      </div>
	      <div class="bar-wrapper mb-3">
	        <div class="bar" style="width: <%= (int)expensePercent %>%; background-color: #F44336;">
	          <span><%= String.format("%.1f", expensePercent) %>%</span>
	          <span class="bar-emoji" style="transform: scaleX(-1);">🐇</span>
	        </div>
	      </div>
	    <% } %>
	  </div>
	
	  <!-- 우측: 7~12월 -->
	  <div class="col-md-6">
	    <% for (int month = 7; month <= 12; month++) {
	      CashStats income = incomeMap.getOrDefault(month, new CashStats());
	      CashStats expense = expenseMap.getOrDefault(month, new CashStats());
	      int incomeTotal = income.getTotal();
	      int expenseTotal = expense.getTotal();
	      int total = incomeTotal + expenseTotal;
	      double incomePercent = (total > 0) ? incomeTotal * 100.0 / total : 0;
	      double expensePercent = (total > 0) ? expenseTotal * 100.0 / total : 0;
	    %>
	      <h6><%=month %>월</h6>
	      <div class="bar-wrapper">
	        <div class="bar" style="width: <%= (int)incomePercent %>%; background-color: #4CAF50;">
	          <span><%= String.format("%.1f", incomePercent) %>%</span>
	          <span class="bar-emoji" style="transform: scaleX(-1);">🐢</span>
	        </div>
	      </div>
	      <div class="bar-wrapper mb-3">
	        <div class="bar" style="width: <%= (int)expensePercent %>%; background-color: #F44336;">
	          <span><%= String.format("%.1f", expensePercent) %>%</span>
	          <span class="bar-emoji" style="transform: scaleX(-1);">🐇</span>
	        </div>
	      </div>
	    <% } %>
		</div>
	  </div>
	</div>
	  <div class="text-center">
		<br>
		<a href="/cashbook/monthList.jsp" class="btn btn-secondary mb-3">달력으로 돌아가기</a>
	</body>
</html>











