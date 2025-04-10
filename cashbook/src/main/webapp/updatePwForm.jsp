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
<div  class="card p-4 shadow mt-5" style="width: 400px;">
	<h4 class="text-center">비밀번호 수정하기</h4>
<form action="/cashbook/updatePwAction.jsp">
	<table class="text-center">
		<tr>
			<td>현재 비밀번호</td>
			<td><input type="password" name="currentPw"required></td><!--  required: 꼭입력해야하는 속성 -->
		</tr>
		<tr>
			<td>새로운 비밀번호</td>
			<td><input type="password" name="newPw"required></td>
		</tr>
		<tr>
			<td>비밀번호 확인</td>
			<td><input type="password" name="pwCheck" required></td> 
		</tr>
	</table>
	<div style="margin-top: 5px;" class="text-center">
	<button type="submit" class="btn btn-outline-primary">비밀번호 변경</button>
	</div>
	</form>
	</div>
</body>
</html>