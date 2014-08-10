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
		Connection conn = null; // null로 초기화 한다.
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			String url = "jdbc:mysql://localhost:3306/leeminka2"; // 사용하려는
																	// 데이터베이스명을
																	// 포함한 URL
																	// 기술
			String id = "leeminka2"; // 사용자 계정
			String pw = "oleview1"; // 사용자 계정의 패스워드

			Class.forName("com.mysql.jdbc.Driver"); // 데이터베이스와 연동하기 위해
													// DriverManager에 등록한다.
			conn = DriverManager.getConnection(url, id, pw); // DriverManager
																// 객체로부터
																// Connection					// 객체를 얻어온다.
			// 카테고리 갯수확인
			String cnt_sql = "select count(*) from user where id="
					+ facebookID;
			stmt = conn.prepareStatement(cnt_sql);
			rs = stmt.executeQuery();
			int rowcount = 0;
			rs.next();
			rowcount = rs.getInt(1);
			out.println("rowcount = " + rowcount + "\n");
			if (rowcount == 0) {
				//처음 로그인하는 사람은 user테이블에 추가
				String insertsql = "insert into user values('" + facebookID
						+ "', '0')";
				stmt = conn.prepareStatement(insertsql);
				stmt.executeUpdate();
			} else {
				//로그인 한적 있는 사람은 user테이블에서 배경값 설정한거 가져오기
				String checkbg = "select background from user where id=" + facebookID;
				stmt = conn.prepareStatement(checkbg);
				rs = stmt.executeQuery();
				String background = rs.getString("background");
				//가져온 배경값 세션에 넣기
				session.setAttribute("userBG", background);
				
			}
		} catch (Exception e) {
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

}
