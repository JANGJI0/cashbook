package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.CashStats;

public class StatsDao {
	// 수입/ 지출별 건수와 총액을 조회하는 메소드
	public ArrayList<CashStats> selectCashStats() throws ClassNotFoundException, SQLException { // 빈괄호 인 이유 : 조건 없이 전체 통계를 가져오기 때문
			ArrayList<CashStats> list = new ArrayList<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// mysql 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		// sql 작성
		String sql = "SELECT kind, COUNT(*) cnt, SUM(amount) total "
						+ "FROM category ct "
						+ "INNER JOIN cash cs ON ct.category_no = cs.category_no "
						+ "GROUP BY kind "
						+ "ORDER BY FIELD(ct.kind, '수입', '지출')";
		
		// 3. sql 실행 준비
		stmt= conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		// 4. 결과 처리
		while(rs.next()) {
			CashStats stats = new CashStats(); // 한 행(row)에 대한 객체 생성
			stats.setKind(rs.getString("kind")); // 수입 / 지출
			stats.setCnt(rs.getInt("cnt")); 		// 건수
			stats.setTotal(rs.getInt("total"));		// 총액
			
			list.add(stats); // 리스트에 추가
		}
		
		// 자원정리
		rs.close();
		stmt.close();
		conn.close();
		
		// 결과 반환
		return list;
	}
	
	// 년도별 수입/지출 총액 메소드
	public ArrayList<CashStats> selectYearlyStats() throws ClassNotFoundException, SQLException {
		// 객체 선언
		ArrayList<CashStats> list = new ArrayList<>();
		// 1. DB 연결
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// 2. sql 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 3. sql 준비 (연도별 수입/지출 총액)
		String sql = "SELECT year(cash_date) year, kind, COUNT(*) cnt, SUM(amount) total "
						+ "FROM category ct "
						+ "INNER JOIN cash c ON ct.category_no = c.category_no "
						+ "GROUP BY year(cash_date), ct.kind "
						+ "ORDER BY year(cash_date)";
		
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		// 3. 결과 처리
		while(rs.next()) {
			CashStats yearStats = new CashStats();
			yearStats.setYear(rs.getInt("year"));
			yearStats.setKind(rs.getString("kind"));
			yearStats.setCnt(rs.getInt("cnt"));
			yearStats.setTotal(rs.getInt("total"));
			
			list.add(yearStats);
			
		}
		// 자원 정리
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
		
	}
	
	// 전체 월별 수입/지출 총액 메소드
		public ArrayList<CashStats> selectMonthlyStats() throws ClassNotFoundException, SQLException {
			// 객체 선언
			ArrayList<CashStats> list = new ArrayList<>();
			// 1. DB 연결
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 2. sql 연결
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
			
			// 3. sql 준비 (연도별 수입/지출 총액)
			String sql = "SELECT MONTH(cash_date) month, kind, COUNT(*) cnt, SUM(amount) total "
							+ "FROM category ct "
							+ "INNER JOIN cash c ON ct.category_no = c.category_no "
							+ "GROUP BY month(cash_date), ct.kind "
							+ "ORDER BY month(cash_date)";
			
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			// 3. 결과 처리
			while(rs.next()) {
				CashStats monthStats = new CashStats();
				monthStats.setMonth(rs.getInt("month"));
				monthStats.setKind(rs.getString("kind"));
				monthStats.setCnt(rs.getInt("cnt"));
				monthStats.setTotal(rs.getInt("total"));
				
				list.add(monthStats);
				
			}
			// 자원 정리
			rs.close();
			stmt.close();
			conn.close();
			
			return list;
		}
		
		// 특정년도 월별 수입/지출 총액 메소드
				public ArrayList<CashStats> selectMonthlyByYear(int year) throws ClassNotFoundException, SQLException {
					// 객체 선언
					ArrayList<CashStats> list = new ArrayList<>();
					// 1. DB 연결
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection conn = null;
					PreparedStatement stmt = null;
					ResultSet rs = null;
					
					// 2. sql 연결
					conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
					
					// 3. sql 준비 (연도별 수입/지출 총액)
					String sql = "SELECT MONTH(cash_date) month, kind, COUNT(*) cnt, SUM(amount) total "
									+ "FROM category ct "
									+ "INNER JOIN cash c ON ct.category_no = c.category_no "
									+ "WHERE YEAR(c.cash_date) = ? "
									+ "GROUP BY month(cash_date), ct.kind "
									+ "ORDER BY month(cash_date)";
					
					stmt = conn.prepareStatement(sql);
					stmt.setInt(1, year);
					rs = stmt.executeQuery();
					
					// 3. 결과 처리
					while(rs.next()) {
						CashStats monYerStats = new CashStats();
						monYerStats.setMonth(rs.getInt("month"));
						monYerStats.setKind(rs.getString("kind"));
						monYerStats.setCnt(rs.getInt("cnt"));
						monYerStats.setTotal(rs.getInt("total"));
						
						list.add(monYerStats);
						
					}
					// 자원 정리
					rs.close();
					stmt.close();
					conn.close();
					
					return list;
				}
}










