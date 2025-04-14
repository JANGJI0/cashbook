<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dto.*" %>
<%
	int y = Integer.parseInt(request.getParameter("y"));
	int m = Integer.parseInt(request.getParameter("m"));
	int d = Integer.parseInt(request.getParameter("d"));

	CashDao dao = new CashDao();
	ArrayList<Cash> list = dao.selectCashListByDate(y, m, d);
	
	// 영수증 확인 여부 체크
	ReceiptDao receiptDao = new ReceiptDao();
	HashMap<Integer, Boolean> receiptMap = new HashMap<>();

	for (Cash c : list) {
		boolean hasReceipt = receiptDao.hasReceipt(c.getCash_no());
		receiptMap.put(c.getCash_no(), hasReceipt);
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title><%=y%>년 <%=m%>월 <%=d%>일 내역</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
		body {
			background-color: #f8f9fa;
			padding: 30px;
		}
		.card {
			max-width: 900px;
			margin: 0 auto;
		}
	</style>
</head>
<body>
<div class="card shadow p-4">
	<h2 class="mb-4 text-center"><%=y %>년 <%=m %>월 <%=d %>일 수입/지출 내역</h2>
	<a href="/cashbook/monthList.jsp?y=<%=y%>&m=<%=m%>&d=<%=d%>" class="btn btn-secondary mb-3">← 달력으로 돌아가기</a>

	<table class="table table-bordered text-center align-middle">
		<thead class="table-light">
			<tr>
				<th>항목</th>
				<th>수입/지출</th>
				<th>금액</th>
				<th>메모</th>
				<th>작성일</th>
				<th>수정</th>
				<th>삭제</th>
				<th>영수증</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Cash c : list){
					System.out.println("cash_no 확인: " + c.getCash_no()); // 디버깅 // 3
			%>
			<tr>
				<td><%=c.getCategoryTitle()%></td>
				<td><%=c.getKind()%></td>
				<td><%=String.format("%,d", c.getAmount())%>원</td>
				<td><%=c.getMemo()%></td>
				<td><%=c.getCreatedate()%></td>
				<td>
					<a href="/cashbook/cash/updateCashForm.jsp?cashNo=<%=c.getCash_no()%>&y=<%=y%>&m=<%=m%>&d=<%=d%>" class="btn btn-outline-primary btn-sm">수정</a>
				</td>
				<td>
					<form action="/cashbook/cash/deleteCashAction.jsp" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
						<input type="hidden" name="cashNo" value="<%=c.getCash_no()%>">
						<input type="hidden" name="y" value="<%=y%>">
						<input type="hidden" name="m" value="<%=m%>">
						<input type="hidden" name="d" value="<%=d%>">
						<button type="submit" class="btn btn-outline-danger btn-sm">삭제</button>
					</form>
				</td>
				<td>
					<%
						boolean hasReceipt = receiptMap.getOrDefault(c.getCash_no(), false);
						if (hasReceipt) {
					%>
						<a href="/cashbook/receipt/receiptView.jsp?cashNo=<%=c.getCash_no()%>" class="text-success text-decoration-none">✅ 있음
					<%
						} else {
					%>
						<span class="text-muted">❌ 없음</span>
					<%
						}
					%>
					
				</td>
			</tr>
			<%
				}
				if(list.size() == 0){
			%>
			<tr><td colspan="8">입력된 내역이 없습니다.</td></tr>
			<%
				}
			%>
		</tbody>
	</table>
</div>
</body>
</html>