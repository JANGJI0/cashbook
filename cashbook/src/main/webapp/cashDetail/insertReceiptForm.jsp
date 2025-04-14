<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>

<%
	
	String filename = request.getParameter("filename");
	String cashNoStr = request.getParameter("cashNo");
	int cashNo = 0;
	
	if (cashNoStr != null && !cashNoStr.equals("")) {
		cashNo = Integer.parseInt(cashNoStr);
	} else {
		out.println("⚠️ cashNo 파라미터가 null이거나 빈 문자열입니다.");
		return; // 또는 response.sendRedirect("/error.jsp");
}
	
%>
<!--  금액입력 후 나중에 따로 영수증을 첨부 하게 될 경우가 있으니 따로 만든다. -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영수증 첨부하기</title>
</head>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<body class="bg-light d-flex justify-content-center align-items-start vh-100">
	<form action="/cashbook/cashDetail/insertReceiptAction.jsp" method="post" enctype="multipart/form-data" class="mb-4">
	<input type="hidden" name="cashNo" value="<%=cashNo %>">
		<h1>영수증 등록하기</h1>
		<div style="width: 200px; height: 200px; border: 1px solid #ccc; border-radius: 8px; display: flex; align-items: center; justify-content: center; text-align: center; padding: 10px;">
		<%
			if(filename != null && !filename.equals("")) {
		%>
		<%
			} else {
		%>
			<span style="font-size: 14px; color: #888;"> 첨부된 영수증이 없습니다.</span>
		<%
			}
		%>
			영수증 : <input type="file" name="filename">
		</div>
		<button type="submit" class="btn btn-primary w-100">첨부하기</button>
	</form>
</body>
</html>