<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String cashNoStr = request.getParameter("cashNo");
    String y = request.getParameter("y");
    String m = request.getParameter("m");
    String d = request.getParameter("d");

    System.out.println("삭제 대상 cashNo: " + cashNoStr);

    if(cashNoStr != null && cashNoStr.matches("\\d+")) {
        int cashNo = Integer.parseInt(cashNoStr);

        CashDao dao = new CashDao();
        int row = dao.deleteCash(cashNo);

        if(row > 0){
            System.out.println("삭제 성공!");
        } else {
            System.out.println("삭제 실패");
        }
    }

    response.sendRedirect("/cashbook/cash/cashOne.jsp?y=" + y + "&m=" + m + "&d=" + d);
%>