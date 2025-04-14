<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 현재 세션을 초기화
	session.invalidate();
	response.sendRedirect("/cashbook/login/loginForm.jsp");
%>