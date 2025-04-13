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
<title>수입/지출 입력</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	body {
		background-color: #f8f9fa;
		padding: 30px;
	}
	.card {
		max-width: 600px;
		margin: 0 auto;
	}
</style>
</head>
<body>
<div class="card shadow p-4">
	<h2 class="mb-4 text-center">수입/지출 입력</h2>

	<!-- 수입/지출 선택 폼 -->
	<!-- 수입/지출 선택 폼 (버튼 형태로 바꿈) -->
<form action="/cashbook/insertCashForm.jsp" method="post" class="mb-4">
	<input type="hidden" name="y" value="<%=year%>">
	<input type="hidden" name="m" value="<%=month%>">
	<input type="hidden" name="cashDate" value="<%=cashDate%>"> <!-- 그냥 넘어가면 cashDate가 안넘어오기때문 hidden값으로 받아온다 -->

	<label class="form-label">수입/지출 선택</label>
	<div class="btn-group w-100 mb-3" role="group" aria-label="수입지출선택">
		<input type="radio" class="btn-check" name="kind" id="btn-income" value="수입" autocomplete="off" onchange="this.form.submit()" <%= "수입".equals(kind) ? "checked" : "" %>>
		<label class="btn btn-outline-primary" for="btn-income">수입</label>

		<input type="radio" class="btn-check" name="kind" id="btn-expense" value="지출" autocomplete="off" onchange="this.form.submit()" <%= "지출".equals(kind) ? "checked" : "" %>>
		<label class="btn btn-outline-danger" for="btn-expense">지출</label>
	</div>

</form>

	<!-- 금액 이력 추가 폼 -->
	<form action="/cashbook/insertCashAction.jsp" method="post">
		<input type="hidden" name="y" value="<%=year%>">
		<input type="hidden" name="m" value="<%=month%>">
		<input type="hidden" name="kind" value="<%=kind %>">

		<div class="mb-3">
			<label for="d" class="form-label">날짜</label>
			<select name="d" class="form-select" required>
				<option value="">:::일 선택:::</option>
				<% for(int d = 1; d <= lastDay; d++) { %>
					<option value="<%=d%>"><%=d %>일</option>
				<% } %>
			</select>
		</div>

		<div class="mb-3">
			<label for="categoryNo" class="form-label">항목</label>
			<select name="categoryNo" class="form-select" required>
				<% if (list != null) {
					for(Category c : list) { %>
						<option value="<%=c.getCategory_no()%>"><%=c.getTitle() %></option>
				<% } } %>
			</select>
		</div>

		<div class="mb-3">
			<label for="memo" class="form-label">메모</label>
			<input type="text" name="memo" class="form-control" placeholder="간단한 설명을 입력하세요">
		</div>

		<div class="mb-3">
			<label for="amount" class="form-label">금액</label>
			<input type="number" name="amount" class="form-control" required> 원
		</div>

		<button type="submit" class="btn btn-primary w-100">수입/지출 입력</button>
	</form>
</div>
</body>
</html>