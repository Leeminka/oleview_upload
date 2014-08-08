package User;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Login() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		// ajax로 부터 userID 가져옴..
		String facebookID = request.getParameter("userID");

		// 세션에 넣기!
		HttpSession session = request.getSession(true);
		session.setAttribute("userID", facebookID);

		// DB에 넣기
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String driverName = "com.mysql.jdbc.Driver";
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/leeminka2", "leeminka2",
					"oleview1");

			// DB에 들어있는지 확인
			String checksql = "select count (*) from user where id="
					+ facebookID;
			stmt = conn.prepareStatement(checksql);
			rs = stmt.executeQuery();
			int rowcnt = 0;
			rs.next();
			rowcnt = rs.getInt(1);
			if (rowcnt == 0) {
				// DB에 등록되지 않은사용자
				String insertsql = "insert into user value('" + facebookID
						+ "')";
				stmt = conn.prepareStatement(insertsql);
				stmt.executeUpdate();
			} else {
				out.print("already regist user");
			}

		} catch (Exception E) {
			E.printStackTrace();
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

}
