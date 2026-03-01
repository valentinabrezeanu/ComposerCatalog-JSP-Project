<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Composers</title>
<link rel="stylesheet" href="style.css">
<link href="table.css" rel="stylesheet" type="text/css" media="screen" />
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
	<h2>Composers</h2>
	<%
	jb.connect();
	String pkParam = request.getParameter("primarykey");
	int aux = 0;

	try {
		if (pkParam != null && !pkParam.isEmpty()) {
			aux = Integer.parseInt(pkParam);
		} else {
			response.sendRedirect("modify_Composers.jsp?error_3=" + java.net.URLEncoder.encode("You have not selected the line you want to modify!", "UTF-8"));
			return; // Oprește execuția paginii m1
		}
	} catch (NumberFormatException e) {
		response.sendRedirect("modify_Composers.jsp?error_3=" + java.net.URLEncoder.encode("Invalid ID format!", "UTF-8"));
		return;
	}
	ResultSet rs = jb.addrRowId("Composers", "idcomposer", aux);
	rs.first();
	String Last_name = rs.getString("Last_name");
	String First_name = rs.getString("First_name");
	int Age = rs.getInt("Age");
	int Nr_works = rs.getInt("Nr_works");
	rs.close();
	jb.disconnect();
	%>
	<form action="m2_Composers.jsp" method="post">
	<% if (request.getParameter("error_2") != null) { %>
    <p style="color:red; font-size:20px; text-align:center; font-weight:bold;">
        <%= request.getParameter("error_2") %>
    </p>
	<% } %>
		<table align="center">
			<tr>
				<td align="right">IdComposer:</td>
				<td><input type="text" name="idcomposer" size="30"
					value="<%=aux%>" readonly /></td>
			</tr>
			<tr>
				<td align="right">Last name:</td>
				<td><input type="text" name="Last_name" size="30"
					value="<%=Last_name%>" /></td>
			</tr>
			<tr>
				<td align="right">First name:</td>
				<td><input type="text" name="First_name" size="30"
					value="<%=First_name%>" /></td>
			</tr>
			<tr>
				<td align="right">Age:</td>
				<td><input type="text" name="Age" size="30" value="<%=Age%>" /></td>
			</tr>
			<tr>
				<td align="right">Number of works:</td>
				<td><input type="text" name="Nr_works" size="30"
					value="<%=Nr_works%>" /></td>
			</tr>
		</table>
		<div class="action-row">
				<input type="submit" class="btn" value="Modify this line">
				<a href="modify_Composers.jsp" class="btn">Back to the edit list</a>
				<a href="index.html" class="btn"><b>Home</b></a>
		</div>
	</form>
	
</body>
</html>