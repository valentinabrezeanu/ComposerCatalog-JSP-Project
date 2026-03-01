<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add a new collaborations!</title>
<link rel="stylesheet" href="style.css">
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
	<%
	int idcomposition, idcomposer;
	String id1, id2, Title, Release_date, Duration, Genre, Last_name, First_name, Age, Nr_works, Role_composer, Start_date;
	id1 = request.getParameter("idcomposition");
	id2 = request.getParameter("idcomposer");
	Role_composer = request.getParameter("Role_composer");
	Start_date = request.getParameter("Start_date");
	
	String errorMessage = null;
	
	if (id1 != null)
    { 
    	if (id1.isEmpty() || id2.isEmpty() || Role_composer.isEmpty() || Start_date.isEmpty())
    	{
                errorMessage = "Please fill in all fields.";
    	} 
    	else
    	{
         //4 cifre - 2 cifre - 2 cifre
            if (errorMessage == null && !Start_date.matches("\\d{4}-\\d{2}-\\d{2}"))
            {
                errorMessage = "Date must be in format YYYY-MM-DD (ex: 1808-12-22).";
            }
    	}
    }
	if (id1 != null && errorMessage == null)
	{
		jb.connect();
		jb.addCollaboration(java.lang.Integer.parseInt(id1), java.lang.Integer.parseInt(id2), Role_composer, Start_date);
		jb.disconnect();
		%>
		<h2 style="font-size:40px">Collaboration added successfully!</h2>
		<a href="table_Collaborations.jsp" class="btn">Back to the list</a>
		<% 
	} else {
	jb.connect();
	ResultSet rs1 = jb.viewTable("Compositions");
	ResultSet rs2 = jb.viewTable("Composers");
	%>
	<h2>Table Collaborations</h2>
	<% if (errorMessage != null) { %>
			    <h2 style="color:red; font-size:25px;">
			        <%= errorMessage %>
			    </h2>
			<% } %>
	<form action="new_Collaborations.jsp" method="post">
		<table>
			<tr>
				<td align="right">Select a composition:</td>
				<td><SELECT NAME="idcomposition" style="width:370px;">
						<%
						while (rs1.next()) {
							idcomposition = rs1.getInt("idcomposition");
							Title = rs1.getString("Title");
							Release_date = rs1.getString("Release_date");
							Duration = rs1.getString("Duration");
							Genre = rs1.getString("Genre");
						%>
						<OPTION VALUE="<%= idcomposition %>"><%= idcomposition %> , <%= Title %> , <%= Release_date %> , <%= Duration %> , <%= Genre %></OPTION>
						<%
						}
						%>
				</SELECT>

				</td>
			</tr>
			<tr>
				<td align="right">Select a composer:</td>
				<td><SELECT NAME="idcomposer" style="width:370px;">
						<!-- OPTION selected="yes" VALUE="iris1">Iris 1</OPTION -->
						<%
						while (rs2.next()) {
							idcomposer = rs2.getInt("idcomposer");
							Last_name = rs2.getString("Last_name");
							First_name = rs2.getString("First_name");
							Age = rs2.getString("Age");
							Nr_works = rs2.getString("Nr_works");
						%>
						<OPTION VALUE="<%=idcomposer%>"><%=idcomposer%> , <%=Last_name %> , <%=First_name%> , <%=Age%> , <%=Nr_works%></OPTION>
						<%
						}
						%>
				</SELECT>
				</td>
			</tr>
			<tr>
				<td align="right">Role of composer:</td>
				<td><input type="text" name="Role_composer" size="50" /></td>
			</tr>
			<tr>
				<td align="right">Start date:</td>
				<td><input type="text" name="Start_date" size="50" /></td>
			</tr>
		</table>
				<div class="action-row">
							<input type="submit" class="btn" value="+ Add" />
				            <a href="table_Collaborations.jsp" class="btn">Back to the list</a>
				            <a href="index.html" class="btn"><b>Home</b></a>
				</div>
	</form>
	<%
	}
	%>
</body>
</html>
