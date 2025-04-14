<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="dto.*, model.*" %>
<%
	String cashNoStr = request.getParameter("cashNo");
	if (cashNoStr == null || cashNoStr.equals("")) {
		out.println("cashNo가 없습니다.");
		return;
	}
	int cashNo = Integer.parseInt(cashNoStr);

	ReceiptDao receiptDao = new ReceiptDao();
	Receipt r = receiptDao.selectReceiptByCashNo(cashNo);
	if (r == null || r.getFilename() == null) {
		out.println("영수증이 없습니다.");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>영수증 보기</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex justify-content-center align-items-center vh-100">
	<div class="card p-4 shadow" style="max-width: 500px;">
		<h4 class="mb-3 text-center">영수증 이미지</h4>
		<img src="<%=request.getContextPath()%>/upload/<%=r.getFilename()%>" class="img-fluid" alt="영수증 이미지">
		<div class="text-center mt-3">
			<a href="javascript:history.back()" class="btn btn-secondary">← 뒤로가기</a>
		</div>
	</div>
</body>
</html>