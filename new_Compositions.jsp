<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add a compositions</title>
<link rel="stylesheet" href="style.css">
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
	<% 
    
            String Title = request.getParameter("Title"); 
            String Release_date = request.getParameter("Release_date");
            String durationParam = request.getParameter("Duration");
            String Genre = request.getParameter("Genre"); 
            
            String errorMessage = null;
            int Duration = 0;
            
            if (Title != null)
            { 
            	if (Title.isEmpty() || Release_date.isEmpty() || durationParam.isEmpty() || Genre.isEmpty())
            	{
                        errorMessage = "Please fill in all fields.";
            	} 
            	else
            	{
                    try {
                        Duration = Integer.parseInt(durationParam);
                    } catch (NumberFormatException e) {
                        errorMessage = "Duration must be a valid number.";
                    }
                 //4 cifre - 2 cifre - 2 cifre
                    if (errorMessage == null && !Release_date.matches("\\d{4}-\\d{2}-\\d{2}"))
                    {
                        errorMessage = "Date must be in format YYYY-MM-DD (ex: 1808-12-22).";
                    }
            	}
            }
            if (Title != null && errorMessage == null)
            {
                jb.connect(); 
                jb.addComposition(Title, Release_date, Duration, Genre); 
                jb.disconnect(); 
        		%>
				<h2 style="font-size:40px">Composition added successfully!</h2>
				<a href="table_Compositions.jsp" class="btn">Back to the list</a>
				<% 
				
        	} else { 
        	%>
			<h2>Table Compositions</h2>
			<% if (errorMessage != null) { %>
			    <h2 style="color:red; font-size:25px;">
			        <%= errorMessage %>
			    </h2>
			<% } %>
			<form action="new_Compositions.jsp" method="post">
				<table>
					<tr>
						<td align="right">Title:</td>
						<td><input type="text" name="Title" size="40" /></td>
					</tr>
					<tr>
						<td align="right">Release date:</td>
						<td><input type="text" name="Release_date" size="40" /></td>
					</tr>
					<tr>
						<td align="right">Duration:</td>
						<td><input type="text" name="Duration" size="40" /></td>
					</tr>
					<tr>
						<td align="right">Genre:</td>
						<td><input type="text" name="Genre" size="40" /></td>
					</tr>
				</table>
				
				<div class="action-row">
							<input type="submit" class="btn" value="+ Add" />
				            <a href="table_Compositions.jsp" class="btn">Back to the list</a>
				            <a href="index.html" class="btn"><b>Home</b></a>
				</div>
			</form>
	<% 
            } 
        %>
</body>
</html>
