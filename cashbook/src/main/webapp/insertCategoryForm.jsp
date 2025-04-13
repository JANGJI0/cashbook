<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 입력</title>
</head>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<body class="d-flex justify-content-center align-items-start vh-100 bg-light">
<div class="card shadow p-4 mt-5" style="width: 400px;">
    <h3 class="text-center mb-4">📋 카테고리 입력</h3>

    <form action="/cashbook/insertCategoryAction.jsp" method="post">
        <!-- 수입/지출 버튼식 선택 -->
        <div class="mb-3">
            <label class="form-label">수입/지출 구분</label>
            <div class="btn-group w-100" role="group" aria-label="수입지출선택">
                <input type="radio" class="btn-check" name="kind" id="btn-income" value="수입" autocomplete="off">
                <label class="btn btn-outline-primary" for="btn-income">수입</label>
                
                 <input type="radio" class="btn-check" name="kind" id="btn-expense" value="지출" autocomplete="off" checked>
                <label class="btn btn-outline-danger" for="btn-expense">지출</label>
            </div>
        </div>

        <div class="mb-3">
            <label for="title" class="form-label">항목명</label>
            <input type="text" name="title" id="title" class="form-control" placeholder="예: 식비, 월급 등" required>
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-primary">저장하기</button>
        </div>
		</form>
	</div>
</body>
</html>