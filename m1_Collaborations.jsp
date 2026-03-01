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
<link href="table.css" rel="stylesheet" type="text/css" media="screen" />
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
	<h2>Collaborations</h2>
	<%
	jb.connect();
	String pkParam = request.getParameter("primarykey");
	int aux = 0;

	try {
		if (pkParam != null && !pkParam.isEmpty()) {
			aux = Integer.parseInt(pkParam);
		} else {
			response.sendRedirect("modify_Collaborations.jsp?error_5=" + java.net.URLEncoder.encode("You have not selected the line you want to modify!", "UTF-8"));
			return; // Oprește execuția paginii m1
		}
	} catch (NumberFormatException e) {
		response.sendRedirect("modify_Collaborations.jsp?error_5=" + java.net.URLEncoder.encode("Invalid ID format!", "UTF-8"));
		return;
	}
	
	String Title, Release_date, Genre, Last_name, First_name, Role_composer, Start_date;
	int Duration, Age, Nr_works;
	
	ResultSet rs = jb.addCollaborationsId(aux);
	if (!rs.first()) {
	    out.println("No data found for the selected composition.");
	    return;
	}

	int id1 = rs.getInt("idcomposition_composer");
	int id2 = rs.getInt("idcomposer_composition");

	Title = rs.getString("Title");
	Release_date = rs.getString("Release_date");
	Duration = rs.getInt("Duration");
	Genre = rs.getString("Genre");
	Last_name = rs.getString("Last_name");
	First_name = rs.getString("First_name");
	Age = rs.getInt("Age");
	Nr_works = rs.getInt("Nr_works");
	Role_composer = rs.getString("Role_composer");
	Start_date = rs.getString("Start_date");

	ResultSet rs1 = jb.viewTable("Compositions");
	ResultSet rs2 = jb.viewTable("Composers");
	int idcomposition, idcomposer;
	
	%>
	<form action="m2_Collaborations.jsp" method="post">
	<% if (request.getParameter("error_4") != null) { %>
    <p style="color:red; font-size:20px; text-align:center; font-weight:bold;">
        <%= request.getParameter("error_4") %>
    </p>
	<% } %>
		<table align="center">
			<tr>
				<td align="right">IdCollaboration:</td>
				<td><input type="text" name="idcollaboration" size="50"
					value="<%=aux%>" readonly /></td>
			</tr>
			<tr>
				<td align="right">IdComposition:</td>
				<td><SELECT NAME="idcomposition" style="width:370px;">
						<%
						while (rs1.next()) {
							idcomposition = rs1.getInt("idcomposition");
							Title = rs1.getString("Title");
							Release_date = rs1.getString("Release_date");
							Duration = rs1.getInt("Duration");
							Genre = rs1.getString("Genre");
							if (idcomposition != id1) {
						%>
						<OPTION VALUE="<%=idcomposition%>">
    							<%=idcomposition%> , <%=Title%> , <%=Release_date%> , <%=Duration%> , <%=Genre%>
						</OPTION>
						<%
						} else {
						%>
						<OPTION VALUE="<%=idcomposition%>" selected>
							<%=idcomposition%>, <%=idcomposition%>, <%=Title%>, <%=Release_date%>, <%=Duration%>, <%=Genre%>
						</OPTION>
						<%
						}
						}
						%>
				</SELECT></td>
			</tr>
			<tr>
				<td align="right">IdComposer:</td>
				<td><SELECT NAME="idcomposer" style="width:370px;">
						<%
						while (rs2.next()) {
							idcomposer = rs2.getInt("idcomposer");
							Last_name = rs2.getString("Last_name");
							First_name = rs2.getString("First_name");
							Age = rs2.getInt("Age");
							Nr_works = rs2.getInt("Nr_works");
							if (idcomposer != id2) {
						%>
						<OPTION VALUE="<%=idcomposer%>"><%=idcomposer%> , <%=Last_name%> , <%=First_name%>,<%=Age%>,<%=Nr_works%>
						</OPTION>
						<%
						} else {
						%>
						<OPTION VALUE="<%=idcomposer%>" selected>
    							<%=idcomposer%>, <%=Last_name%>, <%=First_name%>, <%=Age%>, <%=Nr_works%>
						</OPTION>
						<%
						}
						}
						%>
				</SELECT></td>
			</tr>
			<tr>
				<td align="right">Role of composer:</td>
				<td><input type="text" name="Role_composer" size="50"
					value="<%=Role_composer%>" /></td>
			</tr>
			<tr>
				<td align="right">Start date:</td>
				<td><input type="text" name="Start_date" size="50"
					value="<%=Start_date%>" /></td>
			</tr>

		</table>
		<div class="action-row">
				<input type="submit" class="btn" value="Modify this line">
				<a href="modify_Collaborations.jsp" class="btn">Back to the edit list</a>
				<a href="index.html" class="btn"><b>Home</b></a>
		</div>
	</form>
</body>
<%
rs.close();
rs1.close();
rs2.close();
jb.disconnect();
%>
</html>
