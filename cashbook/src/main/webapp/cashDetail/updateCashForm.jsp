<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
    int cashNo = Integer.parseInt(request.getParameter("cashNo"));
    CashDao cashDao = new CashDao();
    CategoryDao categoryDao = new CategoryDao();

    Cash cash = cashDao.selectCashOne(cashNo);
    ArrayList<Category> categoryList = categoryDao.selectCategoryListByKind(cash.getKind());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>수정하기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding: 30px;
        }
        .card {
            max-width: 600px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
<div class="card shadow p-4">
    <h2 class="mb-4 text-center">✏️ 수입/지출 수정</h2>

    <form action="/cashbook/cashDetail/updateCashAction.jsp" method="post">
        <input type="hidden" name="cashNo" value="<%=cash.getCash_no()%>">
        <input type="hidden" name="y" value="<%=cash.getCash_date().split("-")[0]%>">
		<input type="hidden" name="m" value="<%=Integer.parseInt(cash.getCash_date().split("-")[1])%>">
		<input type="hidden" name="d" value="<%=Integer.parseInt(cash.getCash_date().split("-")[2])%>">

        <!-- 수입/지출 구분은 수정하지 못하게 readonly -->
        <div class="mb-3">
            <label class="form-label">구분</label>
            <input type="text" class="form-control" value="<%=cash.getKind()%>" readonly>
            <input type="hidden" name="kind" value="<%=cash.getKind()%>">
        </div>

        <div class="mb-3">
            <label class="form-label">날짜</label>
            <input type="date" name="cashDate" class="form-control" value="<%=cash.getCash_date()%>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">항목</label>
            <select name="categoryNo" class="form-select" required>
                <% for(Category c : categoryList) { %>
                    <option value="<%=c.getCategory_no()%>" <%= (c.getCategory_no() == cash.getCategory_no()) ? "selected" : "" %>><%=c.getTitle()%></option>
                <% } %>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">메모</label>
            <input type="text" name="memo" class="form-control" value="<%=cash.getMemo()%>">
        </div>

        <div class="mb-3">
            <label class="form-label">금액</label>
            <input type="number" name="amount" class="form-control" value="<%=cash.getAmount()%>" required>
        </div>

        <div class="d-flex justify-content-between">
            <a href="/cashbook/monthList.jsp?targetMonth=<%=Integer.parseInt(cash.getCash_date().split("-")[1]) - 1%>" class="btn btn-secondary">← 돌아가기</a>
            <button type="submit" class="btn btn-primary">수정 완료</button>
        </div>
    </form>
</div>
</body>
</html>