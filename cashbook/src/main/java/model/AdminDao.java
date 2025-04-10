package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Admin;

public class AdminDao {
	// 삭제시 비밀번호 확인 메소드
	public boolean checkPassword(String adminId, String inputPw) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 1단계: 현재 비밀번호가 맞는지 확인
		String sql = "SELECT admin_pw FROM admin WHERE admin_id = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,  "admin"); // 아이디는 admin으로 고정값으로 넘기기위해
		
		rs = stmt.executeQuery();
		
		boolean result = false;
		if(rs.next()) {
			String realPw = rs.getString("admin_pw");
			result = realPw.equals(inputPw); // 단순 비교
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return result;
	}
	
	// 비밀번호 수정
	public boolean updatePw(String currentPw, String newPw) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 1단계: 현재 비밀번호가 맞는지 확인
		String sql = "SELECT admin_id adminId, admin_pw adminPw FROM admin WHERE admin_id = ? AND admin_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,  "admin"); // 아이디는 admin으로 고정값으로 넘기기위해
		stmt.setString(2,  currentPw); // 입력된 현재 비밀번호
		
		rs = stmt.executeQuery();
		
		boolean updatePw = rs.next(); // 현재 비밀번호 일치 여부
		
		System.out.println(rs);
		
		if(updatePw) { 
			// 2단계: 비밀번호 업데이트
			String updatesql = "UPDATE admin SET admin_pw = ? WHERE admin_id = ?";
			stmt = conn.prepareStatement(updatesql);
			stmt.setString(1, newPw);	// 새 비밀번호
			stmt.setString(2, "admin"); // 고정된 아이디
			stmt.executeUpdate();
			
			stmt.close();
		}
		
		// 자원 정리
		rs.close();
		stmt.close();
		conn.close();
		
		return updatePw;
		
		
	}
	
	// 로그인 기능
	public Admin selectAdminId(String adminPw) throws ClassNotFoundException, SQLException { // select할때는 변수를 선언해야한다.
		// 로그인 성공/실패에 따라 처리해버리므로 변수는 필요없다.
		Admin admin = null;
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null; // select 조회할때만 받아서 쓰는경우
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		String sql = "SELECT admin_id adminId, admin_pw adminPw FROM admin WHERE admin_id = ? AND admin_pw = ?"; // 애칭 불가
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,  "admin"); // 아이디는 admin으로 고정값으로 넘기기위해
		stmt.setString(2,  adminPw);
		
		rs = stmt.executeQuery();
		
		if(rs.next()) { // while 말고 if로 쓰는이유가 값이 1개이냐 여러개 차이 로그인은 아이디,중복체크만
			admin = new Admin();
			// admin.setAdmin_id(rs.getString("admin_id"));
			admin.setAdmin_pw(rs.getString("adminPw"));
		
			
		}
		
		conn.close();
		stmt.close();
		rs.close();
		
		return admin;
	}
}
