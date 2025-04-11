package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Cash;

public class CashDao {
	
	// 금액입력
	public int insertCash(Cash cash) throws SQLException, ClassNotFoundException {
		int row = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// mysql 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 페이징 쿼리
		String sql = "INSERT INTO cash (cash_date, memo, amount, category_no) VALUES(?, ?, ?, ?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, cash.getCash_date());
		stmt.setString(2, cash.getMemo());
		stmt.setInt(3, cash.getAmount());
		stmt.setInt(4, cash.getCategory_no());
		
		row = stmt.executeUpdate();
		return row;
		
	}
}
