<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<%
	String category = request.getParameter("categoryName");
	//out.println("category = " + category);
	session.setAttribute("categoryName", category);
	String tmp = (String)session.getAttribute("categoryName");
	//out.println("tmp = " + tmp);
%>
<script>location.href="main.jsp";</script>
