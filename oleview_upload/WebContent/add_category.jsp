<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.io.*"%>
<%
	Connection conn = null; // null로 초기화 한다.
	PreparedStatement pstmt = null;

	try {
		String url = "jdbc:mysql://localhost:3306/leeminka2"; // 사용하려는 데이터베이스명을 포함한 URL 기술
		String id = "leeminka2"; // 사용자 계정
		String pw = "oleview1"; // 사용자 계정의 패스워드

		Class.forName("com.mysql.jdbc.Driver"); // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
		conn = DriverManager.getConnection(url, id, pw); // DriverManager 객체로부터 Connection 객체를 얻어온다.
		String userIDString = request.getParameter("user_id");
		//카테고리 갯수확인
		String cnt_sql = "select count(*) from my_category where ID="
				+ userIDString;
		pstmt = conn.prepareStatement(cnt_sql);
		ResultSet rs = pstmt.executeQuery();
		int rowcount = 0;
		while (rs.next()) {
			rowcount++;
		}
		if (rowcount == 3) {
			out.println("카테고리는 최대 3개까지!!");
		} else {

			String categoryID = request.getParameter("input_category");
			String insert_sql = "insert into my_category values('"
					+ userIDString + "', '" + categoryID + "')";
			out.println(insert_sql);
			pstmt = conn.prepareStatement(insert_sql);
			pstmt.executeUpdate();
			out.println("successssssssss");

			//int userID= request.getParameter(arg0); 
			//String insert_sql = "insert user value('이수민', '"+ +"')";
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {

	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>