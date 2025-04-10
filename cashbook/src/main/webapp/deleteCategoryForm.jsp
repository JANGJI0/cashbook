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
<body>
	<h3>비밀번호를 입력해 주세요</h3>
	<form action="/cashbook/deleteCategoryAction.jsp" method="post">
		<input type="hidden" name="categoryNo" value="<%=categoryNo%>">
		<input type="password" name="adminPw" placeholder="관리자 비밀번호"> 
		<!-- placeholder="관리자 비밀번호 회색으로 보이게, 사용자가 입력을 시작하면 그 텍스트는 사라집니다. -->
		<button type="submit">삭제</button>
	</form>
</body>
</html>