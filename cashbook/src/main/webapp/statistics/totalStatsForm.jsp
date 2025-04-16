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
	
	// 차트에 필요한 수입 수출 합
	int incomeTotalSum = 0;
	int expenseTotalSum = 0;
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 통계</title>
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
    padding-left: 10px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: bold;
  }

  .bar-emoji {
    margin-right: 8px;
    font-size: 22px;
  }
</style>
</head>
<body class="d-flex justify-content-center align-items-start vh-100 bg-light">
	<div class="card mt-5 shadow p-4" style="width: 600px;">
		<h3 class="text-center mb-4">📊 수입/지출 통계</h3>

		<table class="table table-bordered text-center align-middle">
			<thead class="table-light">
				<tr>
					<th>종류</th>
					<th>건수</th>
					<th>총액</th>
				</tr>
			</thead>
	<tbody>
	<%
		for(CashStats s : statsList) {
			 if (s.getKind().equals("수입")) {
			        incomeTotalSum += s.getTotal();
			    } else if (s.getKind().equals("지출")) {
			        expenseTotalSum += s.getTotal();
			    }
			String totalWithComma = String.format("%,d", s.getTotal()); // 숫자에 콤마 찍는 객체
			String emoji = s.getKind().equals("수입") ? "🐢" : "🐇"; // 수입/지출별 이모지 다르게
	%>
		<tr>
			<td><span style="font-size: 15px;"><%=emoji %></span><%=s.getKind() %></td>
			<td><%=s.getCnt() %>건</td>
			<td><%=totalWithComma %>원</td>
		</tr>
	<%
		}
	%>
		</tbody>
	</table>
	
	<%
		int totalAmount = incomeTotalSum + expenseTotalSum;
	  	double incomePercent = (totalAmount > 0) ? (incomeTotalSum * 100.0 / totalAmount) : 0;
	  	double expensePercent = (totalAmount > 0) ? (expenseTotalSum * 100.0 / totalAmount) : 0;
		
		int incomeRatio = (int)incomePercent;
		int expenseRatio = (int)expensePercent;
	%>
	<div>
  <div class="bar-wrapper">
    <div class="bar" style="width: <%= incomeRatio %>%; background-color: #4CAF50;">
      <span><%= String.format("%.1f", incomePercent) %>%</span> <!-- double에는 "%.1f" -->
      <span style="font-size: 30px; display: inline-block; transform: scaleX(-1);" class="bar-emoji">🐢</span>
    </div>
  </div>

  <div class="bar-wrapper">
    <div class="bar" style="width: <%= expenseRatio %>%; background-color: #F44336;">
      <span><%= String.format("%.1f", expensePercent) %>%</span>
      <span style="font-size: 20px; display: inline-block; transform: scaleX(-1);" class="bar-emoji">🐇</span>
    </div>
  </div>
</div>
	<div class="text-center">
		<br>
		<a href="/cashbook/monthList.jsp" class="btn btn-secondary mb-3">달력으로 돌아가기</a>
	</div>
</body>
</html>










