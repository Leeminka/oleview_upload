package Contents;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SaveContents
 */
@WebServlet("/SaveContent")
public class SaveContent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveContent() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String para_data = request.getParameter("para_data");	 
			String para_top = request.getParameter("para_top");
			String para_left = request.getParameter("para_left");
			
			Connection conn = null;
			PreparedStatement stmt = null;
			String driverName = "com.mysql.jdbc.Driver";
			Class.forName(driverName);	
			String sql_top = "update contents set top_int = " + para_top + " where title = \"" + para_data + "\"";
			String sql_left = "update contents set left_int = " + para_left + " where title = \"" + para_data + "\"";
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leeminka2", "leeminka2", "oleview1");
			
			stmt = (PreparedStatement) conn.prepareStatement(sql_top);
			stmt.executeUpdate();
			
			stmt = (PreparedStatement) conn.prepareStatement(sql_left);
			stmt.executeUpdate();
			
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			response.getWriter().print("success");
		} catch (ClassNotFoundException e) {
			// TODO Auto-geynerated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
