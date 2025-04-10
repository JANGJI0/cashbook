<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>
<%
  int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
  String kind = request.getParameter("kind");
  String title = request.getParameter("title");

  Category category = new Category();
  category.setCategory_no(categoryNo);
  category.setKind(kind);
  category.setTitle(title);

  CategoryDao dao = new CategoryDao();
  int row = dao.updateCategory(category);

  if(row == 1) {
    response.sendRedirect("/cashbook/categoryList.jsp");
  } else {
    out.println("<script>alert('수정 실패'); history.back();</script>");
  }
%>