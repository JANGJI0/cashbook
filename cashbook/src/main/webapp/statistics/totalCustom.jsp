<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%
	String yearParam = request.getParameter("year");
	int year; // 최족적으로 사용할 연도 변수
	
	if(yearParam != null && yearParam.matches("\\d+")) {  // "\\d+"는 "숫자로만 구성되어 있는지"를 검사하는 정규식
		// 사용자가 숫자형 연도를 보냈을 경우 (예: "2025")
		year = Integer.parseInt(yearParam);
	} else { // 아무 값도 없거나 숫자가 아닐 경우 기본값: 현재연도
		Calendar cal = Calendar.getInstance();
		year = cal.get(Calendar.YEAR);
		
	}

	// DAO 받기
	StatsDao statsDao = new StatsDao();
	ArrayList<CashStats> statsList = statsDao.selectMonthlyByYear(year);
	
	// 수입/지출을 연도별로 분리 저장할 Map
	Map<Integer, CashStats> incomeMap = new HashMap<>();
	Map<Integer, CashStats> expenseMap = new HashMap<>();
	
	// 연도 목록 저장(DB에서 정해진 순서 유지하기위해)
	Set<Integer> monYerStatsSet = new LinkedHashSet<>();
	
	for(CashStats s : statsList) {
		monYerStatsSet.add(s.getMonth());
		
		if ("수입".equals(s.getKind())) {
			incomeMap.put(s.getMonth(), s);
		} else if ("지출".equals(s.getKind())) {
			expenseMap.put(s.getMonth(), s);
		}
		
		
	}
	
			// 총합 구하기
			int incomeTotalSum = 0;
			int expenseTotalSum = 0;
			
			// 총합 건수 구하기
			int incomeTotalCnt = 0;
			int expenseTotalCnt = 0;
	
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=year %>년 월별 통계</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
  body {
    background-color: #f8f9fa;
  }
  .bar-wrapper {
    height: 20px;
    margin: 6px auto;
    margin-bottom: 10px;
    background-color: #eee;
    border-radius: 5px;
    max-width: 500px;
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
  .month-group {
    margin-bottom: 24px;
  }
</style>
</head>
<body>
	<div class="container mt-5  d-flex justify-content-center">
    <div class="card shadow p-4" style="max-width: 800px; width: 100%;">
	 <h3 class="text-center mb-3">📅<%=year %>년 월별 통계</h3>
		<!--  연도 선택 드롭다운 -->
		<form action="/cashbook/statistics/totalCustom.jsp" method="get"> <!-- post가 아닌이유: 간단한 조회용도로 하기때문 -->
			<select name="year" onchange="this.form.submit()">
			<%
				for(int y = 2020; y <= Calendar.getInstance().get(Calendar.YEAR); y++) {
			%>
				<option value="<%=y %>" <%=(y == year ? "selected" : "") %>><%=y %>년</option>
				<!-- y == year 이면 selected 선택됨 표시 / 아니면 아무 속성 없음 -->
			<%
				}
			%>
			</select>
		</form>
		<table class="table table-bordered text-center align-middle mx-auto">
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
			for(Integer month : monYerStatsSet) {
				CashStats income = incomeMap.getOrDefault(month, new CashStats());
				CashStats expense = expenseMap.getOrDefault(month, new CashStats());
				
				// 총합
				int incomeTotal = income.getTotal();
				int expenseTotal = expense.getTotal();
				int incomeCnt = income.getCnt();
				int expenseCnt = expense.getCnt();
				int diff = incomeTotal - expenseTotal;
				
					incomeTotalSum += incomeTotal;
					incomeTotalCnt += incomeCnt;
				    expenseTotalSum += expenseTotal;
					expenseTotalCnt += expenseCnt;
				
				// 월별 = 수입 - 지출
				int totalAmount = income.getTotal() - expense.getTotal();
				
				// 부호 포함해서 출력할 합계 포맷팅
				String formattedTotal = (totalAmount > 0 ? "+" : (totalAmount < 0 ? "-" : "")) 
									  + String.format("%,d", Math.abs(totalAmount));
		%>
		<tr>
			<td><%=month %>월</td>
			<%
				if(income.getCnt() > 0) {
			%>
				<td><%=income.getCnt() %>건</td>
				<td class="text-success">+<%=String.format("%,d", income.getTotal())%>원</td>
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
				<td class="text-danger">-<%=String.format("%,d", expense.getTotal())%>원</td>
			
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
		<!-- 총합 -->
		    <td colspan="6" style="text-align: center; font-weight: bold; background-color: #f2f2f2;">
		   		 <span style="display: inline-block; letter-spacing: 10px;">총합</span>
		   	</td>
			<tr>
				<td>➕</td>
				<td><%=incomeTotalCnt %>건</td>
			    <td colspan="1">+<%=String.format("%,d", incomeTotalSum)%>원</td>
			    <td><%=expenseTotalCnt %>건</td>
			    <td colspan="1">-<%=String.format("%,d", expenseTotalSum)%>원</td>
		    <%
		        int finalTotal = incomeTotalSum - expenseTotalSum;
		        String formattedFinal = (finalTotal > 0 ? "+" : (finalTotal < 0 ? "-" : "")) 
		                              + String.format("%,d", Math.abs(finalTotal));
		    %>
		    <td><%=formattedFinal %>원</td>
		</tr>
	</table>
	
	<!--  그래프 영역 -->
	<div class="text-center mt-2 mb-1">
		<!-- 왼쪽 1~6 -->
			<div class="d-flex flex-wrap justify-content-center">
				<%
					for(int m = 1; m <=12; m++) {
						CashStats income = incomeMap.getOrDefault(m, new CashStats());
						CashStats expense = expenseMap.getOrDefault(m, new CashStats());
						int total = income.getTotal() + expense.getTotal();
						double incomePercent = (total > 0) ? income.getTotal() * 100.0 / total : 0;
						double expensePercent = (total > 0) ? expense.getTotal() * 100.0 / total : 0;
						
						int incomeRatio = (int)incomePercent;
						int expenseRatio = (int)expensePercent;
				%>
					<div class="p-2 text-center" style="width: 23%; min-width: 140px; margin: 2px;">
						<h6><%=m %>월</h6>
						<div class="bar-wrapper">
							<div class="bar" style="width: <%=incomeRatio %>%; background-color: #4CAF50;">
								<span><%=String.format("%.1f", incomePercent) %>%</span>
								<span class="bar-emoji" style="transform: scaleX(-1);">🐢</span>
							</div>
						</div>
						<div class="bar-wrapper">
							<div class="bar" style="width: <%=expenseRatio %>%; background-color: #F44336;">
							<span><%=String.format("%.1f", expensePercent) %>%</span>
							<span class="bar-emoji" style="transform: scaleX(-1);">🐇</span>
							</div>
						</div>
					</div>
				<%
					}
				%>
		</div>
	</div>
	<div class="text-center mt-4">
        <a href="/cashbook/monthList.jsp" class="btn btn-secondary">달력으로 돌아가기</a>
      </div>
     </div>
    </div>
</body>
</html>











