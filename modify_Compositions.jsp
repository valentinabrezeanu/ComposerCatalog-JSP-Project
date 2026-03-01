<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Compositions</title>
<link rel="stylesheet" href="style.css">
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
	<h2>Compositions</h2>
	<p class="quote">!Select the line you want to edit again to confirm. Once saved, these changes are final.!</p>
	<form action="m1_Compositions.jsp" method="post">
	<% if (request.getParameter("error_1") != null) { %>
    <p style="color:red; font-size:20px; text-align:center; font-weight:bold;">
        <%= request.getParameter("error_1") %>
    </p>
<% } %>
		<table border="1" align="center">
			<tr>
				<td><b>Mark:</b></td>
				<td><b>IdComposition:</b></td>
				<td><b>Title:</b></td>
				<td><b>Release_date:</b></td>
				<td><b>Duration:</b></td>
				<td><b>Genre:</b></td>

			</tr>
			<% 
                    jb.connect(); 
                    ResultSet rs = jb.viewTable("Compositions");
                    long x; 
                    while (rs.next()) { 
                        x = rs.getLong("idcomposition"); 
                %>
			<tr>
				<td><input type="checkbox" name="primarykey" value="<%= x%>" /></td>
				<td><%= x%></td>



				<td><%= rs.getString("Title")%></td>
				<td><%= rs.getString("Release_date")%></td>
				<td><%= rs.getString("Duration")%></td>
				<td><%= rs.getString("Genre")%></td>
				<% 
                        } 
                    %>
			</tr>
		</table>
		<div class="action-row">
				<input type="submit" class="btn" value="Edit/Modify">
				<a href="table_Compositions.jsp" class="btn">Back to the list</a>
				<a href="index.html" class="btn"><b>Home</b></a>
		</div>
	</form>
	<% 
    jb.disconnect();%>
</body>
</html>
