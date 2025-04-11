package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import dto.CalendarData;

public class CalendarDao {
	
	// 월별 지출/수입 건수 가져오기
	public HashMap<Integer, CalendarData> selectCashCountBy(int year, int month) throws ClassNotFoundException, SQLException {
		HashMap<Integer, CalendarData> map = new HashMap<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// mysql 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		
		String sql = "SELECT DAY(c.cash_date) day, ct.kind, COUNT(*) cnt "
					  + "FROM cash c "
					  + "INNER JOIN category ct ON c.category_no = ct.category_no "
					  + "WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? "
					  + "GROUP BY DAY(c.cash_date), ct.kind";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, year);
		stmt.setInt(2, month);
		
		rs = stmt.executeQuery();
		while (rs.next()) {
			int day = rs.getInt("day");
			String kind = rs.getString("kind");
			int cnt = rs.getInt("cnt");
			
			CalendarData data = map.getOrDefault(day, new CalendarData());
			data.setDay(day);
			if(kind.equals("수입")) {
				data.setIncomeCnt(cnt);
			} else if (kind.equals("지출")) {
				data.setExpenseCnt(cnt);
			}
				map.put(day, data);
			
			
		}
			stmt.close();
			rs.close();
			conn.close();
			
		return map;
	}
	
	// 날짜별 수입/지출 금액 합계를 가져오는 메소드
	//사용자가 달력을 보고 있는 특정 연도와 월에 해당하는 데이터를 필터링하기 위해 year, month, kind를 받음
	public HashMap<Integer, Integer> selectTotalAmountByDay(int year, int month, String kind) throws ClassNotFoundException, SQLException {
		  HashMap<Integer, Integer> map = new HashMap<>();
		  
			Class.forName("com.mysql.cj.jdbc.Driver");
		    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		    PreparedStatement stmt = null;
		    ResultSet rs = null;
		    
		    String sql = "SELECT DAY(cash_date) day, SUM(amount) total "
		    				+ "FROM cash c "
		    				+ "INNER JOIN category ct ON c.category_no = ct.category_no "
		    				+ "WHERE YEAR(cash_date) = ? AND MONTH(cash_date) = ? AND kind = ? "
		    				+ "GROUP BY DAY(cash_date)";
		    
		    stmt = conn.prepareStatement(sql);
		    stmt.setInt(1, year);
		    stmt.setInt(2, month);
		    stmt.setString(3, kind);
		    
		    rs = stmt.executeQuery();
		    while(rs.next()) {
		    	map.put(rs.getInt("day"), rs.getInt("total"));
		    }
		    
		    rs.close();
		    stmt.close();
		    conn.close();
		    
			return map;
		
	}
}












