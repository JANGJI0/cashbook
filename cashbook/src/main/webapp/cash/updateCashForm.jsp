<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
	String y = request.getParameter("y");
	String m = request.getParameter("m");
	String d = request.getParameter("d");

	int cashNo = 0;
	try {
	    cashNo = Integer.parseInt(request.getParameter("cashNo"));
	} catch(Exception e) {
	    out.println("<h3 style='color:red;'>cashNo가 유효하지 않습니다.</h3>");
	    return;
	} // null 체크
	
    CashDao cashDao = new CashDao();
    CategoryDao categoryDao = new CategoryDao();
    ReceiptDao receiptDao = new ReceiptDao();
    
    Cash cash = cashDao.selectCashOne(cashNo);
    ArrayList<Category> categoryList = categoryDao.selectCategoryListByKind(cash.getKind());
    
    Receipt receipt = receiptDao.selectReceiptByCashNo(cashNo); // 영수증 가져오기
    
    System.out.println("📌 y = " + request.getParameter("y"));
    System.out.println("📌 m = " + request.getParameter("m"));
    System.out.println("📌 d = " + request.getParameter("d"));
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

    <form action="/cashbook/cash/updateCashAction.jsp" method="post">
        <input type="hidden" name="cashNo" value="<%=cash.getCash_no()%>">
        <input type="hidden" name="y" value="<%=y%>">
    	<input type="hidden" name="m" value="<%=m%>">
    	<input type="hidden" name="d" value="<%=d%>">

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
                <% 
               		 for(Category c : categoryList) {
                %>
                    <option value="<%=c.getCategory_no()%>" <%= (c.getCategory_no() == cash.getCategory_no()) ? "selected" : "" %>><%=c.getTitle()%></option>
                <% 
               		 } 
                %>
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
 <!-- 📎 영수증 이미지 영역 -->
    <% 
    	if (receipt != null && receipt.getFilename() != null && !receipt.getFilename().equals("")) { 
    %>
        <div class="text-center mb-4">
            <h5>영수증</h5>
            <img src="<%=request.getContextPath()%>/upload/<%=receipt.getFilename()%>" alt="영수증 이미지" class="img-thumbnail" style="max-width: 500px; max-height: 300px;">
        </div>
    <% 
   		 } else { 
    %>
        <div class="text-center mb-4 text-muted">📎 첨부된 영수증이 없습니다.</div>
    <% 
  		 } 
    %>
        <div class="d-flex justify-content-between">
            <a href="/cashbook/monthList.jsp?targetMonth=<%=Integer.parseInt(cash.getCash_date().split("-")[1]) - 1%>" class="btn btn-secondary">← 돌아가기</a>
			 <!-- 영수증이 있는 경우: 수정/삭제 -->
    <% 
   		 if (receipt != null && receipt.getFilename() != null && !receipt.getFilename().equals("")) { 
    %>
        <div class="d-flex gap-2">
            <a href="/cashbook/receipt/insertReceiptForm.jsp?cashNo=<%=cash.getCash_no()%>&y=<%=y%>&m=<%=m%>&d=<%=d%>" class="btn btn-warning">영수증 수정</a>
            <a href="/cashbook/receipt/deleteReceiptAction.jsp?cashNo=<%=cash.getCash_no()%>&y=<%=y%>&m=<%=m%>&d=<%=d%>" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">영수증 삭제</a>
        </div>
    <% 
    	} else { 
    %>
        <!-- 영수증이 없을 경우: 첨부만 -->
        <a href="/cashbook/receipt/insertReceiptForm.jsp?cashNo=<%=cash.getCash_no()%>&y=<%=y%>&m=<%=m%>&d=<%=d%>" class="btn btn-secondary">영수증 첨부</a>
    <% 
   		 } 
    %>
            <button type="submit" class="btn btn-primary">수정 완료</button>
        </div>
    </form>
   
</div>
</body>
</html>