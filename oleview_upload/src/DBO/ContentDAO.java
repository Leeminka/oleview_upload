package DBO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

public class ContentDAO {
	private Connection conn = null;
	private PreparedStatement stmt = null;
	private String driverName = "com.mysql.jdbc.Driver";

	public ContentDAO() {
		// TODO Auto-generated constructor stub
		try {
			Class.forName(driverName);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/leeminka2", "leeminka2",
					"oleview1");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public ArrayList<ContentDTO> getAllContents(String user_id,
			String categoryName) {
		// 세션에서 아이디 가져오기
		// String user_id = "gilyoung";

		String sql = "select * from contents where user_id = ? and categoryName = ?"; // sql
																						// 쿼리
		ArrayList<ContentDTO> retArray = new ArrayList<ContentDTO>();

		try {
			stmt = (PreparedStatement) conn.prepareStatement(sql);
			stmt.setString(1, user_id);
			stmt.setString(2, categoryName);
			ResultSet rs = stmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에
												// 담는다.
			while (rs.next()) {
				// ContentDTO
				// 결과를 한 행씩 돌아가면서 가져온다.
				String title = rs.getString("title");
				String dom_data = rs.getString("dom_data");
				String url = rs.getString("url");
				int width = rs.getInt("width_int");
				int height = rs.getInt("height_int");
				int top = rs.getInt("top_int");
				int left = rs.getInt("left_int");
				ContentDTO tmp = new ContentDTO(title, user_id, categoryName,
						url, dom_data, width, height, left, top);
				retArray.add(tmp);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // prepareStatement에서 해당 sql을 미리 컴파일한다.
		return retArray;
	}

	public boolean insert(ContentDTO dto) {
		String sql = "insert into contents(title,user_id,categoryName,dom_data,width_int,height_int,left_int,top_int,url) value(?,?,?,?,?,?,?,?,?)";
		try {
			stmt = (PreparedStatement) conn.prepareStatement(sql);
			stmt.setString(1, dto.getTitle());
			stmt.setString(2, dto.getUser_id());
			stmt.setString(3, dto.getCategoryName());
			stmt.setString(4, dto.getDom_data());
			stmt.setInt(5, dto.getWidth());
			stmt.setInt(6, dto.getHeight());
			stmt.setInt(7, dto.getLeft());
			stmt.setInt(8, dto.getTop());
			stmt.setString(9, dto.getUrl());
			stmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		return true;
	}
}
