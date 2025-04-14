<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	// 로그인 되었는지 아닌지?
			Admin admin = (Admin)session.getAttribute("loginAdmin");
				
		if(admin == null) { // 로그아웃 상태라면
			response.sendRedirect("/cashbook/login/loginForm.jsp");
			return;
		}
		
		String currentPw = request.getParameter("currentPw");
		String newPw = request.getParameter("newPw");
		String pwCheck = request.getParameter("pwCheck");
		// 디버깅
		System.out.println("현재 비밀번호: " + currentPw);
		System.out.println("새로운 비밀번호: " + newPw);
		System.out.println("비밀번호 확인: " + pwCheck);
		
			
		if(currentPw == null || newPw == null || pwCheck == null) {
			out.println("<script>alert('입력값이 누락되었습니다.'); history.back();</script>");
			return;
		}
		
		//4. 새 비밀번호와 확인이 일치하는지 확인
		if(!newPw.equals(pwCheck)) {
			out.println("<script>alert('새 비밀번호와 비밀번호 확인이 일치하지 않습니다.'); history.back();</script>");
			return;
		}
		
		// 5. 비밀번호 변경 DAO 호출
		AdminDao adminDao = new AdminDao();
		boolean updatePw = adminDao.updatePw(currentPw, newPw);
		
		if(updatePw) {
			out.println("<script>alert('비밀번호가 성공적으로 변경되었습니다.'); location.href='/cashbook/login/loginForm.jsp';</script>");
		} else {
			out.println("<script>alert('현재 비밀번호가 일치하지 않습니다.'); history.back();</script>");
		}
		
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

</body>
</html>