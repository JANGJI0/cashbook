<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="dto.*" %>
<%
		//로그인 되었는지 아닌지?
			Admin admin = (Admin)session.getAttribute("loginAdmin");
				
		if(admin == null) { // 로그아웃 상태라면
			response.sendRedirect("/cashbook/login/loginForm.jsp");
			return;
		}
		
		String inputPw = request.getParameter("adminPw");
		int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
		
		AdminDao adminDao = new AdminDao();
		boolean pwMatch = adminDao.checkPassword(admin.getAdmin_id(), inputPw);
		
		if(pwMatch) {
			CategoryDao categoryDao = new CategoryDao();
			int row = categoryDao.deleteCategory(categoryNo);
			response.sendRedirect("/cashbook/category/categoryList.jsp");
		} else {
			out.println("<script>alert('비밀번호가 틀립니다.'); history.back();</script>");
		}
%>