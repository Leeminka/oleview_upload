<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.io.*"%>
<%
	Connection conn = null; // null�� �ʱ�ȭ �Ѵ�.
	PreparedStatement pstmt = null;

	try {
		String url = "jdbc:mysql://localhost:3306/leeminka2"; // ����Ϸ��� �����ͺ��̽����� ������ URL ���
		String id = "leeminka2"; // ����� ����
		String pw = "oleview1"; // ����� ������ �н�����

		Class.forName("com.mysql.jdbc.Driver"); // �����ͺ��̽��� �����ϱ� ���� DriverManager�� ����Ѵ�.
		conn = DriverManager.getConnection(url, id, pw); // DriverManager ��ü�κ��� Connection ��ü�� ���´�.
		String userIDString = request.getParameter("user_id");
		//ī�װ� ����Ȯ��
		String cnt_sql = "select count(*) from my_category where ID="
				+ userIDString;
		pstmt = conn.prepareStatement(cnt_sql);
		ResultSet rs = pstmt.executeQuery();
		int rowcount = 0;
		while (rs.next()) {
			rowcount++;
		}
		if (rowcount == 3) {
			out.println("ī�װ��� �ִ� 3������!!");
		} else {

			String categoryID = request.getParameter("input_category");
			String insert_sql = "insert into my_category values('"
					+ userIDString + "', '" + categoryID + "')";
			out.println(insert_sql);
			pstmt = conn.prepareStatement(insert_sql);
			pstmt.executeUpdate();
			out.println("successssssssss");

			//int userID= request.getParameter(arg0); 
			//String insert_sql = "insert user value('�̼���', '"+ +"')";
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