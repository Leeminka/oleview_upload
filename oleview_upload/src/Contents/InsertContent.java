package Contents;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import DBO.ContentDAO;
import DBO.ContentDTO;

/**
 * Servlet implementation class InsertContent
 */
@WebServlet("/InsertContent")
public class InsertContent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public InsertContent() {
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
		String jData = request.getParameter("jData");
		request.setCharacterEncoding("UTF-8");
		System.out.print(jData);
		JSONParser jsonParser = new JSONParser();
		JSONObject retObject =new JSONObject();
		HttpSession session = request.getSession();
		try {
			//파싱 String -> JSON
			JSONObject jsonObject = (JSONObject) jsonParser.parse(jData);

			// DB IO를 위한 객체
			ContentDAO dao = new ContentDAO();

			// Data
			String title = (String) jsonObject.get("title");
			
			//String user_id = (String) jsonObject.get("user_id");
			String user_id = (String)session.getAttribute("userID");
			String categoryName = (String)session.getAttribute("categoryName");
			//String user_id = "gilyoung"; //임시로
			
			String url = (String) jsonObject.get("url");
			String dom_data = (String) jsonObject.get("dom_data");
			int width = Integer.parseInt(jsonObject.get("width").toString());
			int height = Integer.parseInt(jsonObject.get("height").toString());
			int left = Integer.parseInt(jsonObject.get("left").toString());
			int top = Integer.parseInt(jsonObject.get("top").toString());

			// DATA 객채
			ContentDTO dto = new ContentDTO(title, user_id, categoryName, url, dom_data,
					width, height, left, top);
			
			if(dao.insert(dto)){
				retObject.put("result", "success");
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			retObject.put("result", "fail");
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(retObject.toString());
	}
}
