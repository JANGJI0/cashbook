package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Category;
import dto.Paging;

public class CategoryDao {
	// 수정 메소드
	public int updateCategory(Category category) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// mysql 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 페이징 쿼리
		String sql = "UPDATE category SET kind = ?, title = ? WHERE category_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getKind());
		stmt.setString(2, category.getTitle());
		stmt.setInt(3, category.getCategory_no());
		
		int row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
				
		
		return row;
	}
	
	// 한개 조회 메소드
	public Category selectCategoryOne(int categoryNo) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// mysql 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 페이징 쿼리
		String sql = "SELECT category_no, kind, title FROM category WHERE category_no =?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		
		rs = stmt.executeQuery();
		
		Category category = null;
		    if (rs.next()) {
		        category = new Category();
		        category.setCategory_no(rs.getInt("category_no"));
		        category.setKind(rs.getString("kind"));
		        category.setTitle(rs.getString("title"));
		    }

		    rs.close();
		    stmt.close();
		    conn.close();

		    return category;
	}
	
	//삭제 메소드
	public int deleteCategory(int categoryNo) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// mysql 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 페이징 쿼리
		String sql = "DELETE FROM category WHERE category_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		
		int row = stmt.executeUpdate();
		return categoryNo;
	}
	
	// 리스트 조회
	public ArrayList<Category> selectCategoryList(Paging p) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// mysql 연결
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 페이징 쿼리
		String sql = "SELECT * FROM category ORDER BY category_no DESC LIMIT ?, ? ";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());
		
		rs = stmt.executeQuery();
		ArrayList<Category> list = new ArrayList<>();
		
		while(rs.next()) {
			Category category = new Category();
			category.setCategory_no(rs.getInt("category_no"));
			category.setKind(rs.getString("kind"));
			category.setTitle(rs.getString("title"));
			category.setCreatedate(rs.getString("createdate"));
			list.add(category); // 여기서 list가 생겨야 categoryList에 받는다.
			
			// 쿼리에 ALTER TABLE category
			// MODIFY createdate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP; 변경
		}
		return list;
	}
	// insertCategory 글입력
	public Category insertCategory(Category c) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		// 1단계: 현재 비밀번호가 맞는지 확인
		String sql = "INSERT INTO category(kind, title) values(?, ?)";
		stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setString(1,  c.getKind());
		stmt.setString(2,  c.getTitle());
		
		int row = stmt.executeUpdate();
		
		// 자동 생성된 category_no 값 가져오기
		rs = stmt.getGeneratedKeys(); // DB에서 자동 생성된 키값(PK)을 가져올 때 사용하는 메서드
		if(rs.next()) {
			c.setCategory_no(rs.getInt(1)); // auto_increment된 키 값 주입 
			// 오직 생성된 키 하나만 반환하며, 그것이 첫 번째 컬럼이기 때문
		}
		
		// 자원 정리
		rs.close();
		stmt.close();
		conn.close();
		
		return c;
	}
	
	// 글입력시 중복 확인
	public boolean isDuplicateTitle(String title) throws Exception {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

	    String sql = "SELECT COUNT(*) FROM category WHERE title = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setString(1, title);

	    ResultSet rs = stmt.executeQuery();
	    boolean result = false;
	    if (rs.next()) {
	        result = rs.getInt(1) > 0; // 1개 이상이면 중복!
	    }

	    rs.close();
	    stmt.close();
	    conn.close();
	    return result;
	}
	
}
