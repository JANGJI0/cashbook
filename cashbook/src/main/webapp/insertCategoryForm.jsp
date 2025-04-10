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
	<h3 class="text-center">가계부 입력하기</h3>
	 	<form action="/cashbook/insertCategoryAction.jsp" method="post" class="d-inline-block">
		<table class="text-center">
			<tr>
				<td colspan="2" style="text-align: center;">
				<label><input type="radio" name="kind" value="지출" checked> 지출</label> <!--  <label>: 텍스트에 선택해도 클릭되는 코드 -->
				&nbsp;&nbsp;
				<label><input type="radio" name="kind" value="수입"> 수입</label>
				</td>
			</tr>
			<tr>
				<td>항목</td>
				<td><input type="text" name="title" class="form-control"></td>
			</tr>
		</table>
		<div style="margin-top: 5px;" class="text-center">
		<button type="submit" class="btn btn-outline-primary">저장</button>
		</div>
		</form>
	</div>
</body>
</html>