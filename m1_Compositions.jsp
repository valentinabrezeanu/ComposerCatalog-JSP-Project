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
<link href="table.css" rel="stylesheet" type="text/css" media="screen" />
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
	<h2>Compositions</h2>
	<%
	jb.connect();
	String pkParam = request.getParameter("primarykey");
	int aux = 0;

	try {
		if (pkParam != null && !pkParam.isEmpty()) {
			aux = Integer.parseInt(pkParam);
		} else {
			response.sendRedirect("modify_Compositions.jsp?error_1=" + java.net.URLEncoder.encode("You have not selected the line you want to modify!", "UTF-8"));
			return; // Oprește execuția paginii m1
		}
	} catch (NumberFormatException e) {
		response.sendRedirect("modify_Compositions.jsp?error_1=" + java.net.URLEncoder.encode("Invalid ID format!", "UTF-8"));
		return;
	}
	
	String Title1 = "";
	String Release_date1 = "";
	int Duration1 = 0;
	String Genre1 = "";
	

		ResultSet rs = jb.addrRowId("Compositions", "idcomposition", aux);
		if (rs.first()) {
			Title1 = rs.getString("Title");
			Release_date1 = rs.getString("Release_date");
			Duration1 = rs.getInt("Duration");
			Genre1 = rs.getString("Genre");
		}
		rs.close();
	
	%>
	
	<form action="m2_Compositions.jsp" method="post">
	
	<% if (request.getParameter("error") != null) { %>
    <p style="color:red; font-size:20px; text-align:center; font-weight:bold;">
        <%= request.getParameter("error") %>
    </p>
	<% } %>
	
		<table align="center">
			<tr>
				<td align="right">IdComposition:</td>
				<td><input type="text" name="idcomposition" size="40"
					value="<%=aux%>" readonly /></td>
			</tr>
			<tr>
				<td align="right">Title:</td>
				<td><input type="text" name="Title" size="40"
					value="<%=Title1%>" /></td>
			</tr>
			<tr>
				<td align="right">Release_date:</td>
				<td><input type="text" name="Release_date" size="40"
					value="<%=Release_date1%>" /></td>
			</tr>
			<tr>
				<td align="right">Duration:</td>
				<td><input type="text" name="Duration" size="40"
					value="<%=Duration1%>" /></td>
			</tr>
			<tr>
				<td align="right">Genre:</td>
				<td><input type="text" name="Genre" size="40"
					value="<%=Genre1%>" /></td>
			</tr>
		</table>
		<div class="action-row">
				<input type="submit" class="btn" value="Modify this line">
				<a href="modify_Compositions.jsp" class="btn">Back to the edit list</a>
				<a href="index.html" class="btn"><b>Home</b></a>
		</div>
	</form>
</body>
</html>