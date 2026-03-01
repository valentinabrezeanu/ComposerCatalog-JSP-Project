<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add a Composers</title>
<link rel="stylesheet" href="style.css">
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
	<%
	String Last_name = request.getParameter("Last_name");
	String First_name = request.getParameter("First_name");
	String ageParam = request.getParameter("Age");
	String worksParam = request.getParameter("Nr_works");
	
	String errorMessage = null;
	int Age = 0;
	int Nr_works = 0;
	
	if (Last_name != null)
    { 
    	if (Last_name.isEmpty() || First_name.isEmpty() || ageParam.isEmpty() || worksParam.isEmpty())
    	{
                errorMessage = "Please fill in all fields.";
    	} 
    	else
    	{
			try
			{
				if (ageParam != null && !ageParam.isEmpty()) 
				{
					Age = Integer.parseInt(ageParam);
				}
			} 
			catch (NumberFormatException e)
			{
				errorMessage = "Age must be a valid integer.";
			}
			try
			{
				if (worksParam != null && !worksParam.isEmpty())
				{
					Nr_works = Integer.parseInt(worksParam);
				}
			} 
			catch (NumberFormatException e)
			{
				errorMessage = "Number of works must be a valid integer.";
			}
    	}
    }

	if (Last_name != null && errorMessage == null)
	{
		jb.connect();
		jb.addComposer(Last_name, First_name, Age, Nr_works);
		jb.disconnect();
		%>
			<h2 style="font-size:40px">Composer added successfully!</h2>
			<a href="table_Composers.jsp" class="btn">Back to the list</a>
		<%
	} else {
	%>
	<h2>Table Composers</h2>
	<% if (errorMessage != null) { %>
			    <h2 style="color:red; font-size:25px;">
			        <%= errorMessage %>
			    </h2>
			<% } %>
	<form action="new_Composers.jsp" method="post">
		<table>
			<tr>
				<td align="right">Last name:</td>
				<td><input type="text" name="Last_name" size="40" /></td>
			</tr>
			<tr>
				<td align="right">First name:</td>
				<td><input type="text" name="First_name" size="40" /></td>
			</tr>
			<tr>
				<td align="right">Age:</td>
				<td><input type="text" name="Age" size="40" /></td>
			</tr>
			<tr>
				<td align="right">Number of works:</td>
				<td><input type="text" name="Nr_works" size="40" /></td>
			</tr>
		</table>
				<div class="action-row">
							<input type="submit" class="btn" value="+ Add" />
				            <a href="table_Composers.jsp" class="btn">Back to the list</a>
				            <a href="index.html" class="btn"><b>Home</b></a>
				</div>
	</form>
	<% 
            } 
        %>
	
</body>
</html>
