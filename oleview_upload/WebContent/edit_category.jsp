<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<%
	Connection conn = null; // null로 초기화 한다.
	PreparedStatement pstmt = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	request.setCharacterEncoding("UTF-8");

	try {
		String url = "jdbc:mysql://localhost:3306/leeminka2"; // 사용하려는 데이터베이스명을 포함한 URL 기술
		String id = "leeminka2"; // 사용자 계정
		String pw = "oleview1"; // 사용자 계정의 패스워드

		Class.forName("com.mysql.jdbc.Driver"); // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
		conn = DriverManager.getConnection(url, id, pw); // DriverManager 객체로부터 Connection 객체를 얻어온다.
		String ID = (String) session.getAttribute("userID");
		String categoryName = request.getParameter("categoryName");
		String newName = request.getParameter("categorynew");

		//out.println("ID = " + ID);
		//out.println("categoryName = " + categoryName);
		//out.println("newName = " + newName);

		//카테고리 이름변경 sql

		String update_sql = "update my_category set title='" + newName
				+ "' where ID=" + ID + " and title='" + categoryName
				+ "'";
		String update_content_sql = "update contents set categoryName='"
				+ newName
				+ "' where user_id="
				+ ID
				+ " and categoryName='" + categoryName + "'";
		pstmt = conn.prepareStatement(update_sql);
		stmt = conn.prepareStatement(update_content_sql);
		pstmt.executeUpdate();
		stmt.executeUpdate();

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pstmt.close();
		stmt.close();
		conn.close();
%>
<script>
	location.href = "main.jsp"
</script>
<%
	}
%>