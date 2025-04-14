<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	String kind = request.getParameter("kind");
	String title = request.getParameter("title");
	
	// 1. 객체 생성 및 값 세팅
	Category category = new Category();
	category.setKind(kind);
	category.setTitle(title);
	
	// 2. DAO 호출
	CategoryDao dao = new CategoryDao();
	
	if (!dao.isDuplicateTitle(category.getTitle())) {
	    dao.insertCategory(category);
	    response.sendRedirect("/cashbook/category/categoryList.jsp");
	} else {
	    out.println("<script>alert('이미 등록된 항목입니다.'); history.back();</script>");
}
%>