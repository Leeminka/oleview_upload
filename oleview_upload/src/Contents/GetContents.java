package Contents;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import DBO.ContentDAO;
import DBO.ContentDTO;

/**
 * Servlet implementation class GetContents
 */
@WebServlet("/GetContents")
public class GetContents extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetContents() {
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
		//DB IO를 위한 객체
		ContentDAO dao = new ContentDAO();
		
		//디비에서 모든 컨텐츠들을 가지고오
		List<ContentDTO> contents = dao.getAllContents();
		
		//리턴할 JSON_ARRAY 오브젝트
		JSONArray retObj = new JSONArray();
		
		//List 에 있는 데이터를 JSON오브젝트로 만들어서 추가
		Iterator<ContentDTO> iter = contents.iterator();
		while (iter.hasNext()) {
			ContentDTO tmpDTO = iter.next();
			JSONObject tmp = new JSONObject();
			tmp.put("title", tmpDTO.getTitle());
			tmp.put("url", tmpDTO.getUrl());
			tmp.put("dom_data", tmpDTO.getDom_data());
			tmp.put("width", tmpDTO.getWidth());
			tmp.put("height", tmpDTO.getHeight());
			tmp.put("top", tmpDTO.getTop());
			tmp.put("left", tmpDTO.getLeft());
			retObj.add(tmp);
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		response.getWriter().print(retObj);
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
