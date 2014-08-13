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
 * Servlet implementation class GetUrl
 */
@WebServlet("/GetUrl")
public class GetUrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetUrl() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			Connection conn = null;
			PreparedStatement stmt = null;
			String driverName = "com.mysql.jdbc.Driver";
			Class.forName(driverName);
			String sql = "select * from contents"; 
			ArrayList<ContentDTO> retArray = new ArrayList<ContentDTO>();
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leeminka2", "leeminka2", "oleview1");
			
			stmt = (PreparedStatement) conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery(); 
			while (rs.next()) {
				String title = rs.getString("title");
				String user_id = rs.getString("user_id");
				String categoryName = rs.getString("categoryName");
				String dom_data = rs.getString("dom_data");
				String url = rs.getString("url");
				int width = rs.getInt("width_int");
				int height = rs.getInt("height_int");
				int top = rs.getInt("top_int");
				int left = rs.getInt("left_int");
				ContentDTO tmp = new ContentDTO(title, user_id, categoryName, url, dom_data, width, height, left, top);
				retArray.add(tmp);
			}
			
			String para_data = request.getParameter("para_data");
			String ret_url = "";
			
			Iterator<ContentDTO> iter = retArray.iterator();
			while (iter.hasNext()) {
				ContentDTO tmpDTO = iter.next();
				System.out.println(tmpDTO.getTitle());
				if (tmpDTO.getTitle().equals(para_data)) {
					ret_url = tmpDTO.getUrl();
				}
			}
			
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(ret_url);
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
