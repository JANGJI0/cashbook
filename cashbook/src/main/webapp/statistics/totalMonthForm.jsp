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
	
	// 연도 목록 저장(DB에서 정해진 순서 유지하기위해)
	Set<Integer> monthSet = new LinkedHashSet<>();
	
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
</head>
<body>
	<h2>📅월별 수입/지출 총액(전체년도)</h2>
	<table border="1">
		
		<tr>
			<th>월</th>
			<th>수입</th>
			<th>총액</th>
			<th>지출</th>
			<th>총액</th>
			<th>합계</th>
		</tr>
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
	</table>
</body>
</html>











