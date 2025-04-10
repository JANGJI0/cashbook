<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="model.*" %>
<%
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정말로 삭제 하시겠습니까?</title>
</head>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<body class="d-flex justify-content-center align-items-start vh-100 bg-light">
	<div  class="card p-4 shadow mt-5" style="width: 800px;">
	<h3 class="text-center mb-4">비밀번호를 입력해 주세요</h3>
	
	<form action="/cashbook/deleteCategoryAction.jsp" method="post" class="d-inline-block">
		<input class="text-center align-middle" type="hidden" name="categoryNo" value="<%=categoryNo%>" >
		<div class="mb-3 text-center">
		<input type="password" name="adminPw" placeholder="관리자 비밀번호" class="text-center align-middle"> 
		</div>
		<!-- placeholder="관리자 비밀번호 회색으로 보이게, 사용자가 입력을 시작하면 그 텍스트는 사라집니다. -->
		<div style="margin-top: 5px;" class="text-center">
		<button type="submit" class="btn btn-outline-primary">삭제</button>
		</div>
	</form>
</body>
</html>