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
<body class="d-flex justify-content-center align-items-start vh-100 bg-light">
<div class="card p-4 shadow mt-5" style="width: 400px;">
    <h4 class="text-center mb-4">🔒 비밀번호 수정하기</h4>

    <form action="/cashbook/login/updatePwAction.jsp" method="post">
        <div class="mb-3">
            <label for="currentPw" class="form-label">현재 비밀번호</label>
            <input type="password" name="currentPw" id="currentPw" class="form-control" required>
        </div>

        <div class="mb-3">
            <label for="newPw" class="form-label">새로운 비밀번호</label>
            <input type="password" name="newPw" id="newPw" class="form-control" required>
        </div>

        <div class="mb-3">
            <label for="pwCheck" class="form-label">비밀번호 확인</label>
            <input type="password" name="pwCheck" id="pwCheck" class="form-control" required>
        </div>

        <div class="d-grid mt-3">
            <button type="submit" class="btn btn-primary">🔐 비밀번호 변경</button>
        </div>
	</form>
	</div>
</body>
</html>