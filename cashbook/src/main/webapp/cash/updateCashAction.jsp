<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>

<%

	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String memo = request.getParameter("memo");
	int amount = Integer.parseInt(request.getParameter("amount"));
	String kind = request.getParameter("kind");
	String cashDate = request.getParameter("cashDate");
	
	String y = request.getParameter("y");
	String m = request.getParameter("m");
	String d = request.getParameter("d");
	
	
	System.out.println("cashNo: " + request.getParameter("cashNo"));
	System.out.println("categoryNo: " + request.getParameter("categoryNo"));
	System.out.println("amount: " + request.getParameter("amount"));
	System.out.println("y: " + request.getParameter("y"));
	System.out.println("m: " + request.getParameter("m"));
	System.out.println("d: " + request.getParameter("d"));

	Cash cash = new Cash();
	cash.setCash_no(cashNo);
	cash.setCategory_no(categoryNo);
	cash.setMemo(memo);
	cash.setAmount(amount);
	cash.setKind(kind);
	cash.setCash_date(cashDate);

	CashDao dao = new CashDao();
	int row = dao.updateCash(cash);

	response.sendRedirect("/cashbook/cash/cashOne.jsp?y=" + y + "&m=" + m + "&d=" + d);
%>