<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>

<%
	String y = request.getParameter("y");
	String m = request.getParameter("m");
	
	System.out.println("y: " + y); // ★ 이거 확인해
	System.out.println("m: " + m);
	
	// 방어 코드: y 또는 m이 없으면 리턴
			if (y == null || m == null) {
				out.println("<p style='color:red;'>잘못된 접근입니다. 다시 시도해주세요.</p>");
				return;
			}
		
	
	int year = Integer.parseInt(y);
	int month = Integer.parseInt(m);
	
	
	// 해당 월의 마지막 날 계산
	java.util.Calendar cal = java.util.Calendar.getInstance();
	cal.set(Calendar.YEAR, year);
	cal.set(Calendar.MONTH, month - 1); // 0부터 시작
	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

	// dateList.jsp  -> 수입/지출 입력(String cashDate ->
	
	String cashDate = request.getParameter("cashDate"); 
	
	// 수입인지 지출인지 넘어오게 kind
	// insertCashForm.jsp -> kind 선택(String kind)넘어오게
	String kind = request.getParameter("kind");
	String title = request.getParameter("title");
	ArrayList<Category> list = null;
	if(kind != null) { // insertCashForm.jsep에서 kind 선택 후 재요청
		// DB : 선택된 kind의 title 목록 (pk값을 들고오는거)
		CategoryDao categoryDao = new CategoryDao();
		list = categoryDao.selectCategoryListByKind(kind);
		System.out.println("넘어온 kind: " + kind); // 콘솔 확인
		
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>수입/지출 선택</h1>
	<form action="/cashbook/insertCashForm.jsp" method="post">
	<input type="hidden" name="y" value="<%=year%>">
	<input type="hidden" name="m" value="<%=month%>">
		<input type="hidden" name="cashDate" value="<%=cashDate%>"> <!-- 그냥 넘어가면 cashDate가 안넘어오기때문 hidden값으로 받아온다 -->
		<select name="kind" onchange="this.form.submit()">
			<option value="" >:::선택:::</option> <!-- 같은 값으면 옵션값 생략 가능 --> <!--  선택하고 고정되게 -->
			<option value="수입"<%= "수입".equals(kind) ? "selected" : "" %>>수입</option> <!-- 같은 값으면 옵션값 생략 가능 -->
			<option value="지출"<%= "지출".equals(kind) ? "selected" : "" %>>지출</option> <!-- 같은 값으면 옵션값 생략 가능 -->
		</select>
		<button type="submit">수입/지출 선택</button>
	</form>
	<h1>금액 이력 추가</h1>
	<form action="/cashbook/insertCashAction.jsp" method="post">
	<input type="hidden" name="y" value="<%=year%>">
	<input type="hidden" name="m" value="<%=month%>">
	<input type="hidden" name="kind" value="<%=kind %>">
		날짜 : <select name="d" required>
				<option value="">:::일 선택:::</option>
				<%
					for(int d = 1; d <= lastDay; d++) {
				%>
					<option value="<%=d%>"><%=d %>일</option>
				<%
					}
				%>
		</select><br> <!-- 날짜 수정안되고 그날짜에만 하니까 readyonly-->
		항목 : <select name="categoryNo" required>
				<%
					if (list != null) {
						for(Category c : list) {
				%>
				 <option value="<%=c.getCategory_no()%>"><%=c.getTitle() %></option>
				<%
						}
					}
				%>
		</select>
		메모 : <input type="text" name="memo"><br>
		금액 : <input type="number" name="amount" required> 원<br>
		<button type="submit">수입/지출 입력</button>
	</form>
</body>
</html>