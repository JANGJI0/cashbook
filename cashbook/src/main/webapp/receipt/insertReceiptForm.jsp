<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
	
	String filename = request.getParameter("filename");
	String cashNoStr = request.getParameter("cashNo");
	int cashNo = 0;
	
	if (cashNoStr != null && !cashNoStr.equals("")) {
		cashNo = Integer.parseInt(cashNoStr);
	} else {
		out.println("⚠️ cashNo 파라미터가 null이거나 빈 문자열입니다.");
		return; // 또는 response.sendRedirect("/error.jsp");
	}
	String yStr = request.getParameter("y");
	String mStr = request.getParameter("m");
	String dStr = request.getParameter("d");

	int y = 0, m = 0, d = 0;

	if (yStr != null && !yStr.equals("") &&
	    mStr != null && !mStr.equals("") &&
	    dStr != null && !dStr.equals("")) {
	    y = Integer.parseInt(yStr);
	    m = Integer.parseInt(mStr);
	    d = Integer.parseInt(dStr);
	} else {
	    out.println("<h3 style='color:red;'>❗ 날짜 정보가 없습니다. (y/m/d)</h3>");
	    return;
	}
		
	
%>
<!--  금액입력 후 나중에 따로 영수증을 첨부 하게 될 경우가 있으니 따로 만든다. -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<body class="bg-light d-flex justify-content-center align-items-start vh-100">
  <form action="/cashbook/receipt/insertReceiptAction.jsp" method="post" enctype="multipart/form-data" 
        class="card shadow p-4 mt-5" style="width: 350px;">
    
    <h2 class="text-center mb-4">📎 영수증 등록하기</h2>

    <input type="hidden" name="cashNo" value="<%=cashNo %>">
    <input type="hidden" name="y" value="<%=y%>">
    <input type="hidden" name="m" value="<%=m%>">
    <input type="hidden" name="d" value="<%=d%>">

        <img id="previewImage" src="#" alt="미리보기" style="max-width: 100%; max-height: 100%; display: none;">
      </div>
    </div>

    <!-- 파일 선택 -->
    <div class="mb-3">
      <input type="file" name="filename" id="fileInput" class="form-control">
    </div>

    <!-- 제출 버튼 -->
    <button type="submit" class="btn btn-primary w-100">첨부하기</button>
  </form>
</body>
</html>