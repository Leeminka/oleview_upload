package User;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.*;

/**
 * Servlet implementation class GetCategory
 */
@WebServlet("/GetCategory")
public class GetCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetCategory() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		Connection conn = null;
		PreparedStatement stmt = null;
		String driverName = "com.mysql.jdbc.Driver";
		HttpSession session = request.getSession();
		ResultSet rs = null;
		ArrayList<String> titleArray = new ArrayList<String>();
		try {
			//DB에서 카테고리 이름 다 가져옴
			Class.forName(driverName);
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/leeminka2", "leeminka2",
					"oleview1");
			String ID = (String) session.getAttribute("userID");
			String selectSql = "select * from my_category where ID=" + ID;

			stmt = conn.prepareStatement(selectSql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				String title = rs.getString("title");
				titleArray.add(title);
			}
			
			//리턴할 json_array
			JSONArray returnObj = new JSONArray();
			//ArrayList에 잇는 카테고리 이름들을 JSON 오브젝트로 만들어서 추가..
			Iterator<String> iter = titleArray.iterator();
			while(iter.hasNext()){
				String title = iter.next();
				JSONObject tmp = new JSONObject();
				tmp.put("title", title);
				returnObj.add(tmp);
			}
			response.setContentType("application/json");
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(returnObj);
			

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException sqle) {
				} // Resultset 객체 해제
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException sqle) {
				} // PreparedStatement 객체 해제
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException sqle) {
				} // Connection 해제
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
