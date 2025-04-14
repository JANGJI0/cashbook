<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto. *"%>
<%@ page import="model. *"%>
<%@ page import="java.util. *"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%
	String yStr = request.getParameter("y");
	String mStr = request.getParameter("m");
	String dStr = request.getParameter("d");
	
	if (yStr == null || mStr == null || dStr == null ||
		yStr.equals("") || mStr.equals("") || dStr.equals("")) {
		 out.println("<h3 style='color:red;'>잘못된 접근입니다. 날짜 정보가 없습니다.</h3>");
		    return;
	}
	
	int y = Integer.parseInt(yStr);
	int m = Integer.parseInt(mStr);
	int d = Integer.parseInt(dStr);



	Part part = request.getPart("filename"); // 파일 받는 API
	String cashNoStr = request.getParameter("cashNo");
	int cashNo = 0;

	if (cashNoStr != null && !cashNoStr.equals("")) {
	    cashNo = Integer.parseInt(cashNoStr);
	} else {
	    out.println("⚠️ cashNo가 전달되지 않았습니다.");
	    return;
	}
	
	String originalName = part.getSubmittedFileName(); // 이미지 파일
	
	System.out.println("originalName: " + originalName);
	
	// 1) 중복되지 않는 새로운 파일이름 생성 - java.uitl.UUID API 사용
	UUID uuid = UUID.randomUUID();
	String fileImage = uuid.toString();
	fileImage = fileImage.replace("-", "");
	System.out.println("uuid fileImage: " + fileImage);
	
	// 2) 1의 결과에 확장자 추가
	int dotLastPos = originalName.lastIndexOf("."); // 마지막 . 의 인덱스값 반환
	System.out.println("dotlastPos: " + dotLastPos);
	
	fileImage = fileImage + originalName.substring(dotLastPos);
	System.out.println("fileImage: " + fileImage);
	
	Receipt receipt= new Receipt();
	receipt.setFilename(fileImage);
	receipt.setCash_no(cashNo);
	
	// 3) 파일저장
	// 빈 파일 생성
	// Fil emptFil = new File("c:/upload/a:png")
	String path = request.getServletContext().getRealPath("/upload");
	//톰켓안헤 poll 프로젝타 안 upload폴더 실제 물리적주소를 반환
	System.out.println("path: " + path);
	File emptyFile = new File(path, fileImage);
	// 파일 보낼 inputstream 설정
	InputStream is = part.getInputStream(); // 파트안의 스트링(이미지파일의 바이너리 파일)
	// 파일 받을  outputstream 설정
	OutputStream os = Files.newOutputStream(emptyFile.toPath());
	is.transferTo(os); // inputstream bianary -> 반복(1byte씩) -> outputstream
	
	// 4) db에 저장
	Receipt r = new Receipt();
	r.setCash_no(cashNo);
	r.setFilename(fileImage);
	ReceiptDao dao = new ReceiptDao();
	dao.deleteReceiptByCashNo(cashNo); // 기존 거 있으면 삭제
	dao.insertReceipt(r);
	response.sendRedirect("/cashbook/cash/updateCashForm.jsp?cashNo=" + cashNo + "&y=" + y + "&m=" + m + "&d=" + d);
%>















