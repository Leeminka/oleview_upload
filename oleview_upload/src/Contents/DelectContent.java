package Contents;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DBO.ContentDTO;

/**
 * Servlet implementation class DelectContent
 */
@WebServlet("/DelectContent")
public class DelectContent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DelectContent() {
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
			System.out.println("para = " + para_data);
			Connection conn = null;
			PreparedStatement stmt = null;
			String driverName = "com.mysql.jdbc.Driver";
			Class.forName(driverName);	
			String sql = "delete from contents where title=\"" + para_data + "\""; 
			System.out.println("sql = " + sql);
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leeminka2", "leeminka2", "oleview1");
			
			stmt = (PreparedStatement) conn.prepareStatement(sql);
			stmt.executeUpdate();
			
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			response.getWriter().print("success");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
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
