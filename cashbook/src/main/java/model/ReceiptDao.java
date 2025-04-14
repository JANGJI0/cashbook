package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Receipt;

public class ReceiptDao {
	
	// 영수증 보여주기 메소드
	public Receipt selectReceiptByCashNo(int cashNo) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		String sql = "SELECT filename FROM receipt WHERE cash_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		rs = stmt.executeQuery();

		Receipt receipt = null;
		if (rs.next()) {
			receipt = new Receipt();
			receipt.setFilename(rs.getString("filename"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return receipt;
	}
	
	
	// 영수증 등록 메소드
	public int insertReceipt(Receipt receipt) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		String sql = "INSERT INTO receipt(cash_no, filename, createdate) VALUES(?, ?, now())";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, receipt.getCash_no());
		stmt.setString(2, receipt.getFilename());
		
		row = stmt.executeUpdate(); // 성공여부 확인 성공시 1 실패시 0 반환
		
		
				
		return row;
		
	}
	
	// 기존 영수증 삭제
	public int deleteReceiptByCashNo(int cashNo) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "DELETE FROM receipt WHERE cash_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
	}
	
		// 영수증 존재 여부 체크
	public boolean hasReceipt(int cashNo) throws Exception {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		String sql = "SELECT COUNT(*) cnt FROM receipt WHERE cash_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		
		rs = stmt.executeQuery();
		
		boolean result = false;
		if (rs.next()) {
			result = rs.getInt("cnt") > 0;
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return result;
	}
	
}
