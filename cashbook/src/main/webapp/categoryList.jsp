<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.ArrayList" %>
<%
	// 로그인 되었는지 아닌지?
			Admin admin = new Admin();
			admin.setAdmin_id("admin"); // 또는 DB에서 불러온 값
			session.setAttribute("loginAdmin", admin);
				
		if(admin == null) { // 로그아웃 상태라면
			response.sendRedirect("/cashbook/loginForm.jsp");
			return;
		}
		
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		CategoryDao categoryDao = new CategoryDao();
		Paging p = new Paging();
		p.setCurrentPage(currentPage);
		p.setRowPerPage(10);
		ArrayList<Category> list = categoryDao.selectCategoryList(p);
		
		
		
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
<body class="d-flex justify-content-center align-items-start vh-100 bg-light">
	<div>
		<%=admin.getAdmin_id() %>님 반갑습니다.
		<a href="/cashbook/logout.jsp">로그아웃</a>
		<a href="/cashbook/updatePwForm.jsp">비밀번호 수정</a>
	</div>
	<div  class="card p-4 shadow mt-5" style="width: 400px;">
	<h4 class="text-center">가계부 리스트</h4>
	<form action="/cashbook/categoryList.jsp">
		<table class="text-center">
		<tr>
			<td>번호</td>
			<td>수입/지출</td>
			<td>항목</td>
			<td>수정</td>
			<td>삭제</td>
		</tr>
		<%
			for(Category c : list) {
		%>
		<tr>
			<td><%=c.getCategory_no() %></td><!--  required: 꼭입력해야하는 속성 -->
			<td><%=c.getKind() %></td>
			<td><%=c.getTitle() %></td> 
			<td><a href="/cashbook/updateCategoryForm.jsp?categoryNo=<%=c.getCategory_no()%>">수정</a></td> 
			<td><a href="/cashbook/deleteCategoryForm.jsp?categoryNo=<%=c.getCategory_no()%>">삭제</a></td> 
		</tr>
		<%
			}
		%>
	</table>
	</form>
	</div>
</body>
</html>