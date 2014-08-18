<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<%
	Connection conn = null; // null로 초기화 한다.
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	request.setCharacterEncoding("UTF-8");
	
	try {
		String url = "jdbc:mysql://localhost:3306/leeminka2"; // 사용하려는 데이터베이스명을 포함한 URL 기술
		String id = "leeminka2"; // 사용자 계정
		String pw = "oleview1"; // 사용자 계정의 패스워드

		Class.forName("com.mysql.jdbc.Driver"); // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
		conn = DriverManager.getConnection(url, id, pw); // DriverManager 객체로부터 Connection 객체를 얻어온다.
		String userIDString = (String) session.getAttribute("userID");
		//카테고리 갯수확인
		String cnt_sql = "select count(*) from my_category where ID="
				+ userIDString;
		//out.println("sql :: " + cnt_sql);
		pstmt = conn.prepareStatement(cnt_sql);
		rs = pstmt.executeQuery();
		int rowcount = 0;
		rs.next();
		rowcount = rs.getInt(1);
		//out.println("rowcount = " + rowcount + "\n");
		if (rowcount == 3) {
%>
<script type="text/javascript">
	alert("카테고리는 최대 3개까지!");
</script>
<%
	} else {

			String categoryID = request.getParameter("input_category");
			String insert_sql = "insert into my_category values('"
					+ userIDString + "', '" + categoryID + "')";
			//out.println("sql :: " + insert_sql);
			pstmt = conn.prepareStatement(insert_sql);
			pstmt.executeUpdate();
			//int userID= request.getParameter(arg0); 
			//String insert_sql = "insert user value('이수민', '"+ +"')";
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException sqle) {
			} // Resultset 객체 해제
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException sqle) {
			} // PreparedStatement 객체 해제
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException sqle) {
			} // Connection 해제
%>
<script>
	location.href = "main.jsp";
</script>
<%
	}
%>
