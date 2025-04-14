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
			response.sendRedirect("/cashbook/login/loginForm.jsp");
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
		
		String y = request.getParameter("y");
		String m = request.getParameter("m");
		String d = request.getParameter("d");
		
		
		
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
</head>
<body class="d-flex justify-content-center align-items-start vh-100">
	<div style="position: absolute; top: 20px; right: 200px; font-size: 14px;">
		<%=admin.getAdmin_id() %>님 반갑습니다.
		<a href="/cashbook/login/logout.jsp">로그아웃</a>
		<a href="/cashbook/login/updatePwForm.jsp">비밀번호 수정</a>
	</div>
	<div  class="card p-4 shadow mt-5" style="width: 80%;">
		 <a href="/cashbook/monthList.jsp?y=<%=y%>&m=<%=m%>&d=<%=d%>" class="btn btn-outline-success btn-sm position-absolute" style="top: 20px; right: 20px;">달력으로 돌아가기</a>
		 <a href="/cashbook/category/insertCategoryForm.jsp" class="btn btn-outline-success btn-sm position-absolute" style="top: 20px; right: 170px;">추가</a>
  <h4 class="text-center mb-4">가계부 리스트</h4>
	<form action="/cashbook/categroy/categoryList.jsp">
		<table class="table table-bordered  text-center align-middle">
		 <thead>
		<tr class="text-white">
			<th class="bg-secondary">번호</th>
			<th class="bg-secondary">수입/지출</th>
			<th class="bg-secondary">항목</th>
			<th class="bg-secondary">생성일</th>
			<th class="bg-secondary">수정</th>
			<th class="bg-secondary">삭제</th>
		</tr>
		</thead>
		<%
			for(Category c : list) {
		%>
		<tr>
			<td><%=c.getCategory_no() %></td><!--  required: 꼭입력해야하는 속성 -->
			<td class="text-center"> <span class="fs-5"><%= c.getKind().equals("지출") ? "💸 지출" : "💰 수입" %></span></td>
			<td><%=c.getTitle() %></td> 
			<td><%=c.getCreatedate() %></td> 
			<td><a href="/cashbook/category/updateCategoryForm.jsp?categoryNo=<%=c.getCategory_no()%>" class="btn btn-outline-primary">수정</a></td> 
			<td><a href="/cashbook/category/deleteCategoryForm.jsp?categoryNo=<%=c.getCategory_no()%>" class="btn btn-outline-danger">삭제</a></td> 
		</tr>
		<%
			}
		%>
	</table>
	</form>
	</div>
</body>
</html>