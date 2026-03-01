<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Collaborations</title>
<link rel="stylesheet" href="style.css">
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
	<h2>Collaborations</h2>
	
	<form action="delete_Collaborations.jsp" method="post">
	<div class="table-container">
		<table border="1" align="center">
			<tr>
				<td><b>Mark:</b></td>
				<td><b>IdCollaboration:</b></td>
				<td><b>IdComposition:</b></td>
				<td><b>IdComposer:</b></td>
				<td><b>Title:</b></td>
				<td><b>Genre:</b></td>
				<td><b>Last name:</b></td>
				<td><b>First name:</b></td>
				<td><b>Nr_works:</b></td>
				<td><b>Role_composer:</b></td>
				<td><b>Start_date:</b></td>
			</tr>
			<% 
                    jb.connect(); 
                    ResultSet rs = jb.viewCollaborations(); 
                    long x; 
                    while (rs.next()) { 
                        x = rs.getInt("idcollaboration"); 
                %>
			<tr>
				<td><input type="checkbox" name="primarykey" value="<%= x%>" /></td>
				<td><%= x%></td>
				<td><%= rs.getInt("idcomposition_composer")%></td>
				<td><%= rs.getInt("idcomposer_composition")%></td>
				<td><%= rs.getString("Title")%></td>
				<td><%= rs.getString("Genre")%></td>
				<td><%= rs.getString("Last_name")%></td>
				<td><%= rs.getString("First_name")%></td>
				<td><%= rs.getInt("Nr_works")%></td>
				<td><%= rs.getString("Role_composer")%></td>
				<td><%= rs.getString("Start_date")%></td>
				<% 
                        } 
                    %>
			</tr>
		</table>
	</div>
	<div class="form-container">
			<p class="title">Manage collaborations:</p>
			<div class="action-row">
		           <a href="new_Collaborations.jsp" class="btn">+ Add</a>
		           <a href="modify_Collaborations.jsp" class="btn">Edit/Modify</a>
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
