package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
	
	// cash detail 메소드
		// 특정 날짜 수입/지출 내역 리스트
		public ArrayList<Cash> selectCashListByDate(int year, int month, int day) throws Exception {
		    ArrayList<Cash> list = new ArrayList<>();
		    Class.forName("com.mysql.cj.jdbc.Driver");
		    PreparedStatement stmt = null;
		    ResultSet rs = null;
		    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

		    String sql = "SELECT c.cash_no, ct.kind, ct.title, c.amount, c.memo, c.createdate "
		               + "FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no "
		               + "WHERE YEAR(c.cash_date)=? AND MONTH(c.cash_date)=? AND DAY(c.cash_date)=? "
		               + "ORDER BY c.createdate DESC";
		    
		    stmt = conn.prepareStatement(sql);
		    stmt.setInt(1, year);
		    stmt.setInt(2, month);
		    stmt.setInt(3, day);

		     rs = stmt.executeQuery();
		    while(rs.next()) {
		        Cash cash = new Cash();
		        cash.setCash_no(rs.getInt("cash_no"));
		        cash.setKind(rs.getString("kind"));
		        cash.setCategoryTitle(rs.getString("title"));
		        cash.setAmount(rs.getInt("amount"));
		        cash.setMemo(rs.getString("memo"));
		        cash.setCreatedate(rs.getString("createdate"));
		        list.add(cash);
		    }

		    rs.close();
		    stmt.close();
		    conn.close();

		    return list;
		}
		
		//특정 cash_no의 수입/ 지출 상세정보 조회
		public Cash selectCashOne(int cashNo) throws Exception {
		    Cash cash = new Cash();

		    Class.forName("com.mysql.cj.jdbc.Driver");
		    PreparedStatement stmt = null;
		    ResultSet rs = null;
		    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

		    String sql = "SELECT c.cash_no, ct.kind, ct.category_no, ct.title, c.amount, c.memo, c.cash_date " +
		                 "FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no " +
		                 "WHERE c.cash_no = ?";

		    stmt = conn.prepareStatement(sql);
		    stmt.setInt(1, cashNo);

		    rs = stmt.executeQuery();
		    if(rs.next()) {
		        cash.setCash_no(rs.getInt("cash_no"));
		        cash.setKind(rs.getString("kind"));
		        cash.setCategory_no(rs.getInt("category_no"));
		        cash.setCategoryTitle(rs.getString("title"));
		        cash.setAmount(rs.getInt("amount"));
		        cash.setMemo(rs.getString("memo"));
		        cash.setCash_date(rs.getString("cash_date"));
		    }

		    rs.close();
		    stmt.close();
		    conn.close();

		    return cash;
		}
		
		
		// 금액 수정 메소드
		public int updateCash(Cash cash) throws Exception {
		    int row = 0;

		    Class.forName("com.mysql.cj.jdbc.Driver");
		    PreparedStatement stmt = null;
		    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

		    String sql = "UPDATE cash SET category_no = ?, memo = ?, amount = ?, updatedate = NOW() WHERE cash_no = ?";
		    stmt = conn.prepareStatement(sql);
		    
		    stmt.setInt(1, cash.getCategory_no());
		    stmt.setString(2, cash.getMemo());
		    stmt.setInt(3, cash.getAmount());
		    stmt.setInt(4, cash.getCash_no());

		    row = stmt.executeUpdate();

		    stmt.close();
		    conn.close();

		    return row;
		}
		
		
		// 삭제 메소드
		public int deleteCash(int cashNo) throws ClassNotFoundException, SQLException {
		    Class.forName("com.mysql.cj.jdbc.Driver");
		    Connection conn = DriverManager.getConnection(
		        "jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		    
		    String sql = "DELETE FROM cash WHERE cash_no = ?";
		    PreparedStatement stmt = conn.prepareStatement(sql);
		    stmt.setInt(1, cashNo);

		    int row = stmt.executeUpdate();

		    stmt.close();
		    conn.close();

		    return row;
		}
		
}
