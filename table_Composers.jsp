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
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
	<h2>Composers</h2>
	
	<form action="delete_Composers.jsp" method="post">
		<table border="1" align="center">
			<tr>
				<td><b>Mark:</b></td>
				<td><b>IdComposer:</b></td>
				<td><b>Last name:</b></td>
				<td><b>First name:</b></td>
				<td><b>Age :</b></td>
				<td><b>Number of works :</b></td>
			</tr>
			<% 
                    jb.connect(); 
                    ResultSet rs = jb.viewTable("Composers"); 
                    long x; 
                    while (rs.next()) { 
                        x = rs.getInt("idcomposer"); 
                %>
			<tr>
				<td><input type="checkbox" name="primarykey" value="<%= x%>" /></td>
				<td><%= x%></td>
				<td><%= rs.getString("Last_name")%></td>
				<td><%= rs.getString("First_name")%></td>
				<td><%= rs.getString("Age")%></td>
				<td><%= rs.getString("Nr_works")%></td>
				<% 
                        } 
                    %>
			</tr>
		</table>
			
		 <div class="form-container">
		 		<p class="title">Manage composers:</p>
				<div class="action-row">
		            <a href="new_Composers.jsp" class="btn">+ Add</a>
		            <a href="modify_Composers.jsp" class="btn">Edit/Modify</a>
		            <a href="index.html" class="btn">Home</a>
        		</div>
        		<input type="submit" class="btn delete-btn" value="Delete Selected Records">
        </div>
    </form>
	<% 
            rs.close(); 
            jb.disconnect(); 
        %>
</body>
</html>
