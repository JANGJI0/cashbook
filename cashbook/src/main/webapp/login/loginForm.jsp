<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<body class="d-flex justify-content-center align-items-start vh-100 bg-light"> <!-- bootstrap에서 웹사이트 가운데 정렬 -->
<div  class="card p-4 shadow mt-5" style="width: 350px;">
	<h1 class="text-center">로그인</h1>
	 	<form action="/cashbook/login/loginAction.jsp" method="post" class="d-inline-block">
		<table class="text-center">
			<tr>
				<td>아이디</td>
				<td><input type="text" name="adminId" value="admin" readonly class="form-control"></td>
			</tr>
		
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="adminPw" class="form-control"></td>
			</tr>
		</table>
		<div style="margin-top: 5px;" class="text-center">
		<button type="submit" class="btn btn-outline-primary">로그인</button>
		</div>
		</form>
	</div>
</body>
</html>