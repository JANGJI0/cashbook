<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	// 로그인 되었는지 아닌지?
			Admin  admin = new Admin();
			admin.setAdmin_id("admin"); // admin 고정
			session.setAttribute("loginAdmin", admin);
				
		if(admin == null) { // 로그아웃 상태라면
			response.sendRedirect("/cashbook/loginForm.jsp");
			return;
		}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<body>
	<div>
		<%=admin %>님 반갑습니다.
		<a href="/cashbook/logout.jsp">로그아웃</a>
		<a href="/cashbook/updatePwForm.jsp">비밀번호 수정</a>
	</div>
</body>
</html>