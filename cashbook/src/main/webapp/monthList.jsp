<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
		//로그인 되었는지 아닌지?
			Admin admin = new Admin();
			admin.setAdmin_id("admin"); // 또는 DB에서 불러온 값
			session.setAttribute("loginAdmin", admin);
				
		if(admin == null) { // 로그아웃 상태라면
			response.sendRedirect("/cashbook/loginForm.jsp");
			return;
		}
		

	// 현재 월이 4.11 -> 4.1 (firstDate.set(Calendar.DATE, 1);) 바꿨기 때문에 1일로 된다.
	Calendar firstDate = Calendar.getInstance();
		firstDate.set(Calendar.DATE, 1);
		
	if(request.getParameter("targetMonth") !=null) {
		firstDate.set(Calendar.MONTH, Integer.parseInt(request.getParameter("targetMonth")));
	}
		
		// 디버깅
		System.out.println("targetMonth: " + request.getParameter("targetMonth"));
		// targetMonth: null
		
	// 시작되는 날짜 1일
	int lastDate = firstDate.getActualMaximum(Calendar.DATE);
		//디버깅
		System.out.println(lastDate);  // 30
		
	// 오늘날의 요일 -> 시작 공백
	int dayOfWeek = firstDate.get(Calendar.DAY_OF_WEEK);
	int startBlank = dayOfWeek - 1;
	// 디버깅
	System.out.println(dayOfWeek); // 3
	
	// 뒤 공백
	int endBlank = 0;
		// totalCell 은 7의 배수
	int totalCell = startBlank + lastDate + endBlank;
		if(totalCell % 7 != 0) {
			endBlank = 7 - (totalCell % 7);
			totalCell = totalCell + endBlank;
			// 디버깅
			System.out.println(totalCell); // 35
		}
			
		// DAO 호출
		CalendarDao dao = new CalendarDao();
		int year = firstDate.get(Calendar.YEAR);
		int month = firstDate.get(Calendar.MONTH) + 1; // 0부터 시작하니까 +1 해줘야 함
		HashMap<Integer, CalendarData> cashCountMap = dao.selectCashCountBy(year, month);
		
		HashMap<Integer, Integer> incomeAmountMap = dao.selectTotalAmountByDay(year, month, "수입");
		HashMap<Integer, Integer> expenseAmountMap = dao.selectTotalAmountByDay(year, month, "지출");
		
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
	.calendar-cell {
		position: relative;
		height: 100px;
		vertical-align: top;
		padding: 6px;
		font-size: 14px;
		vertical-align: top;
	}
	
	.calendar-cell:hover { background-color: #f0f8ff; }

	.calendar-day {
		position: absolute;
		top: 4px;
		left: 6px;
		font-weight: bold;
		font-size: 14px;
		margin-bottom: 6px;
	}

	.calendar-content {
		margin-top: 24px;
		font-size: 12px;
	}
</style>
</head>
<body class="bg-light">
	<div  class="container-fluid mt-4">
	<h1 class="text-center mb-4">가계부 달력</h1>
	
	<div class="d-flex justify-content-center align-items-center gap-3 mb-4">
	<a href="/cashbook/monthList.jsp?targetMonth=<%=firstDate.get(Calendar.MONTH) - 1%>">◀</a>
	<h3 class= class="mb-0"><%=firstDate.get(Calendar.YEAR)%>년 <%=firstDate.get(Calendar.MONTH)+1%>월</h3>
	<a href="/cashbook/monthList.jsp?targetMonth=<%=firstDate.get(Calendar.MONTH) + 1%>">▶</a>
	<a href="/cashbook/insertCashForm.jsp?y=<%=year%>&m=<%=month %>" class="btn btn-outline-success btn-sm position-absolute" style="right: 20px;">+ 수입/지출 등록</a>
      <!-- 이슈 : 1월이면 이전이면 -1, 12월에 다음이면 12가 넘어가는데? Calendar API안에서 자동으로 계산 -->
   </div>
	<form>
	<table class="table table-bordered text-center w-100" style="table-layout: fixed;">
	 <thead class="table-light">
		<tr>
		<td>일</td>
		<td>월</td>
		<td>화</td>
		<td>수</td>
		<td>목</td>
		<td>금</td>
		<td>토</td>
		</tr>
		</thead>
		<tbody>
		<tr>
			<%
				for(int i=1; i<=totalCell; i++) {
					if(i % 7 == 1 && i != 1) {
			%>
						</tr><tr>
			<%
					}
						int d = i - startBlank;
			%>
				<td class="calendar-cell">
					<%
						
						if(d > 0 && d <= lastDate) {
					%>
						<td onclick="location.onclick=href='/cashbook/insertCashForm.jsp?y=<%=year%>&m=<%=month%>&d=<%=d%>'"
								style="cursor:pointer; position: relative;"
					<%
						}
					%>>
					<%
						if(d > 0 && d <= lastDate) {
					%>
							<div class="calendar-day"><%=d %></div>
							<div class="calendar-content"></div>
						
					<%
						CalendarData data = cashCountMap.get(d);
						if(data != null) {
							if(data.getIncomeCnt() > 0) { // 데이터값이 널이 아닐때 수입이 0보다 크면
					%>
						<div class="text-primary mb-1">
							💰<%=data.getIncomeCnt() %>건 : + 
							<%=incomeAmountMap.getOrDefault(d, 0) %>원
						</div>
					<%
							} if(data.getExpenseCnt() > 0) { // 데이터 값이 널이 아닐때 지출이 0보다 크면
					%>
							<div class="text-danger">
							💸<%=data.getExpenseCnt() %>건 : -
							 <%= expenseAmountMap.getOrDefault(d, 0) %>원
							</div>
					<%
						
								}
							}
					%>
					</div>
				
			<%
						}
			%>
				</td>
			<%
					
				}
			%>
			</tr>
			</tbody>
		</table>
		</form>
	</div>
</body>
</html>












