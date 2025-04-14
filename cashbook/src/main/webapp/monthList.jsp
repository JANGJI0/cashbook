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
			response.sendRedirect("/cashbook/login/loginForm.jsp");
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
		// 날짜별 메모 이모지 메소드 가져오기
		HashMap<Integer, String> memoMap = dao.selectMemoMapBy(year, month);
		// 날짜별 영수증 메소드 가져오기
		 HashMap<Integer, Boolean> receiptMap = dao.selectReceiptMapBy(year, month);
		 
		
	
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
		height: 150px;
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

	.calendar-day-line {
		position: absolute;
		top: 4px;
		left: 6px;
		width: calc(100% - 12px);
		font-weight: bold;
		font-size: 14px;
		border-bottom: 1px solid #ccc;
		padding-bottom: 2px;
		margin-bottom: 4px;
		text-align: left;
	}
	.calendar-content {
		margin-top: 24px;
		font-size: 12px;
	}
</style>
</head>
<body class="bg-light">
<!--  전체를 감싸는 테이블 -->
	<table class="w-100" style="table-layout: fixed; margin: 20px 40px 40px 5px;">
	<tr>
	<!--  왼쪽 로그인 상태창 -->
	<td style="width: 230px;  height: 200px; border-right: 1px solid #ccc; vertical-align: top; text-align: center;  padding-top: 50px;">
		<h5 class="mb-3" style="font-weight: bold;">관리자님 반갑습니다.</h5>
		<p><%=admin.getAdmin_id() %></p><!-- <p> 쓰는 이유 : 문단을 나타내는 태그 -->
		<div style="display: flex; flex-direction: column; gap: 10px; margin-top: 40px;">
		 <!-- 가로 버튼 -->
	  		<div class="d-flex justify-content-center gap-2 mb-2">
				<a href="/cashbook/login/logout.jsp" class="btn btn-outline-danger btn-sm">로그아웃</a> 
				<a href="/cashbook/login/updatePwForm.jsp" class="btn btn-outline-danger btn-sm">정보수정</a>
			</div>
				<hr>
				<div class="d-flex flex-column align-items-center gap-2">
				  <a href="/cashbook/category/categoryList.jsp" class="btn btn-outline-primary btn-sm" style="padding: 3px 15px; font-size: 13px; width: 150px;">카테고리 리스트</a>
				  </div>
				<!-- 수입/지출 총액 제목 -->
				<hr>
				<h6 class="text-center mt-1 mb-1" style="font-weight: bold;">수입/지출 총액</h6>
				<!-- 버튼 목록 -->
				<div class="d-flex flex-column align-items-center gap-2">
				  <a href="/cashbook/statistics/talAll.jsp" class="btn btn-outline-primary btn-sm" style="padding: 3px 15px; font-size: 13px; width: 150px;">전체</a>
				  <a href="/cashbook/statistics/totalYear.jsp" class="btn btn-outline-primary btn-sm" style="padding: 3px 15px; font-size: 13px; width: 150px;">년도별</a>
				  <a href="/cashbook/statistics/totalMonth.jsp" class="btn btn-outline-primary btn-sm" style="padding: 3px 15px; font-size: 13px; width: 150px;">월별</a>
				  <a href="/cashbook/statistics/totalCustom.jsp" class="btn btn-outline-primary btn-sm" style="padding: 3px 15px; font-size: 13px; width: 150px;">특정년도</a>
				</div>
		</div>
	</td>
	
	<!-- 오른쪽 달력 전체 -->
	<td style="padding: 1px 30px; vertical-align: top;">	
		<h2 class="text-left mb-2">가계부 달력</h2>
		
		<div class="d-flex justify-content-between align-items-center mb-2">
			<div class="d-flex align-items-left">
				<a href="/cashbook/monthList.jsp?targetMonth=<%=firstDate.get(Calendar.MONTH) - 1%>" class="btn btn-outline-secondary btn-sm me-3">◀</a>
				<h3 class="m-0"><%=firstDate.get(Calendar.YEAR)%>년 <%=firstDate.get(Calendar.MONTH)+1%>월</h3>
				<a href="/cashbook/monthList.jsp?targetMonth=<%=firstDate.get(Calendar.MONTH) + 1%>"  class="btn btn-outline-secondary btn-sm ms-2">▶</a>
			</div>
				<div>
				<a href="/cashbook/category/insertCategoryForm.jsp?y=<%=year%>&m=<%=month %>" class="btn btn-outline-success btn-sm me-1">항목 추가</a>
				<a href="/cashbook/category/insertCashForm.jsp?y=<%=year%>&m=<%=month %>" class="btn btn-outline-success btn-sm me-1">+ 수입/지출 등록</a>
			</div>
		</div>
      <!-- 이슈 : 1월이면 이전이면 -1, 12월에 다음이면 12가 넘어가는데? Calendar API안에서 자동으로 계산 -->
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
				<td class="calendar-cell"
					<%
						
						if(d > 0 && d <= lastDate) {
							out.print(" onclick=\"location.href='/cashbook/cash/cashOne.jsp?y=" + year + "&m=" + month + "&d=" + d + "'\" style=\"cursor:pointer; position: relative;\"");
						}
					%>
						>
					<%
						if(d > 0 && d <= lastDate) {
					%>
							<div class="calendar-day-line"><%=d %>
							<%
								// 예시: 메모가 있을 경우 (가정: memoMap에 해당 날짜에 메모 여부 저장)
								  if(memoMap.containsKey(d)) { 
							%>
								<span title="메모 있음" class="float-end">📝</span>
							<%
								}    if(receiptMap.containsKey(d)) { // 영수증이 있을 경우
							%>
								    <span title="영수증 있음" class="float-end">🧾</span>
							<%
								    }
							%>
							</div>
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
	</td>
	</tr>
</table>
</body>
</html>












