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
	String pkParam = request.getParameter("idcollaboration");
	String idcomposition = request.getParameter("idcomposition");
	String idcomposer = request.getParameter("idcomposer");
	String Role_composer = request.getParameter("Role_composer");
	String Start_date = request.getParameter("Start_date");
	
	int aux = 0;
    String errorMessage = null;
    
 // Verificare dacă formularul a fost trimis
    boolean submitted = (pkParam != null);

    if (submitted) {
        if (idcomposition == null || idcomposition.isEmpty() ||
        	idcomposer == null || idcomposer.isEmpty() ||
        	Role_composer == null || Role_composer.isEmpty() ||
        	Start_date == null || Start_date.isEmpty()) {

            errorMessage = "All fields must be completed.";

        } else
    	{
            //4 cifre - 2 cifre - 2 cifre
               if (errorMessage == null && !Start_date.matches("\\d{4}-\\d{2}-\\d{2}"))
               {
                   errorMessage = "Date must be in format YYYY-MM-DD (ex: 1808-12-22).";
               }
       	}
     // Trimit eroare la m1 pentru afisare deasupra tabelului
        if (errorMessage != null) {
            jb.disconnect();
            response.sendRedirect("m1_Collaborations.jsp?primarykey=" + pkParam + "&error_4=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
            return; // Oprim execuția pentru a face redirectul
        }
		if (errorMessage == null) {
			aux = java.lang.Integer.parseInt(request.getParameter("idcollaboration"));
			String[] valori = { idcomposition, idcomposer, Role_composer, Start_date };
			String[] campuri = { "idcomposition", "idcomposer", "Role_composer", "Start_date" };
			jb.modifyTable("Collaborations", "idcollaboration", aux, campuri, valori);
			jb.disconnect();
		}
            
    }
	%>
	<h2 style="font-size:30px; ">The changes have been successfully made!</h2>
    <div class="action-row">
        <a href="table_Collaborations.jsp" class="btn">Back to the list</a>
        <a href="index.html" class="btn"><b>Home</b></a>
    </div>
</body>
</html>