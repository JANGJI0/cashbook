<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>
<%
	String y = request.getParameter("y");
	String m = request.getParameter("m");
	String d = request.getParameter("d");

	String memo = request.getParameter("memo");
	int amount = Integer.parseInt(request.getParameter("amount"));
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	out.println("categoryNo 파라미터: " + request.getParameter("categoryNo"));
	System.out.println("categoryNo: " + categoryNo);
	System.out.println("amount: " + amount);
	System.out.println("memo: " + memo);
	
	// 날짜 조립 (형식: yyyy-MM-dd)
    String cashDate = y + "-" + (m.length() == 1 ? "0" + m : m) + "-" + (d.length() == 1 ? "0" + d : d);
	
	Cash cash = new Cash();
	cash.setCash_date(cashDate);
	cash.setMemo(memo);
	cash.setAmount(amount);
	cash.setCategory_no(categoryNo);
	
	CashDao dao = new CashDao();
	int row = dao.insertCash(cash);
	
	if(row > 0) {
		response.sendRedirect("/cashbook/monthList.jsp?targetMonth=" + (Integer.parseInt(m)-1));
	} else {
		out.println("<p> 등록 실패</p>");
	}
	
%>