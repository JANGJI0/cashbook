<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>
<%
  int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));

  CategoryDao dao = new CategoryDao();
  Category category = dao.selectCategoryOne(categoryNo); // 수정할 데이터 1개 조회
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
<div  class="card p-4 shadow mt-5" style="width: 350px;">
	<h3 class="text-center">카테고리 수정</h3>
	 	<form action="/cashbook/category/updateCategoryAction.jsp" method="post" class="d-inline-block">
	 	<input type="hidden" name="categoryNo" value="<%=category.getCategory_no()%>">
		<table class="text-center align-middle">
			<tr>
				<td colspan="2" style="text-align: center;">
				<label><input type="radio" name="kind" value="지출" <%=category.getKind().equals("지출") ? "checked" : ""%>> 지출</label> 
				<!--  <label>: 텍스트에 선택해도 클릭되는 코드 -->
				&nbsp;&nbsp;
				<label><input type="radio" name="kind" value="수입"<%=category.getKind().equals("수입") ? "checked" : ""%>>수입</label>
				</td>
			</tr>
			<tr>
				<td class="text-center align-middle">항목</td>
				<td><input type="text" name="title"  placeholder="<%=category.getTitle() %>" class="form-control"></td>
			</tr>
		</table>
		<div style="margin-top: 5px;" class="text-center">
		<button type="submit" class="btn btn-outline-primary">수정하기</button>
		<a href="/cashbook/category/categoryList.jsp" class="btn btn-outline-primary">돌아가기</a>
		</div>
		</form>
	</div>
</body>
</html>