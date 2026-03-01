<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Collaborations:</title>
<link rel="stylesheet" href="style.css">
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
	<%
		String[] s = request.getParameterValues("primarykey");
		if (s == null || s.length == 0)
		{
			%>
		    <h2 style="font-size:30px; color:red; ">
			        You have not selected any collaboration to delete!
			    </h2>
			    <div class="action-row">
				            <a href="table_Collaborations.jsp" class="btn">Back to the list</a>
				            <a href="index.html" class="btn"><b>Home</b></a>
				</div>
		<%
		    return;
		}
		jb.connect();
		jb.deleteTableData(s, "Collaborations", "idcollaboration");
		jb.disconnect();
	%>
	<h2 style="font-size:30px;">Collaboration deleted successfully!</h2>
		<div class="action-row">
			<a href="table_Collaborations.jsp" class="btn">Back to the list</a>
		    <a href="index.html" class="btn"><b>Home</b></a>
		</div>
</body>
</html>
