<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%
	String y = request.getParameter("y");
	String m = request.getParameter("m");
	String d = request.getParameter("d");	

	int cashNo = Integer.parseInt(request.getParameter("cashNo"));

	ReceiptDao dao = new ReceiptDao();
	dao.deleteReceiptByCashNo(cashNo); // DAO에서 delete 메서드 필요

	// 삭제 후 돌아가기
	response.sendRedirect("/cashbook/cash/updateCashForm.jsp?cashNo=" + cashNo + "&y=" + y + "&m=" + m + "&d=" + d);
%>