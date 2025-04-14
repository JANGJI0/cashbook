<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%
	// String adminId = request.getParameter("adminId"); 비밀번호만 입력
	String adminPw = request.getParameter("adminPw");
	
		// 디버깅
		//System.out.println("adminId: " + adminId);
		System.out.println("adminPw: " + adminPw);
		// 디버깅 성공 adminId: null, adminPw: null 
		
	// 2. DAO 호출
	AdminDao adminDao = new AdminDao();
	Admin loginAdmin = adminDao.selectAdminId(adminPw);
	
	// 3. 로그인 성공 여부확인
	if(loginAdmin != null) {
		session.setAttribute("loginAdmin", loginAdmin); // 세션에 로그인 정보 저장
		response.sendRedirect("/cashbook/monthList.jsp"); // 로그인 성공 시 이동
	} else {
		out.println("<script>alert('로그인에 실패하였습니다.'); history.back();</script>");
		//response.sendRedirect("/cashbook/loginForm.jsp?"); // 실패시 로그인 폼
	}
		
	

%>