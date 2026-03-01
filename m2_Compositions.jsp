<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Compositions</title>
<link href="table.css" rel="stylesheet" type="text/css" media="screen" />
<link rel="stylesheet" href="style.css">
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
	<h2>Compositions</h2>
	<%
	
	jb.connect();
	String pkParam = request.getParameter("idcomposition");
	String Title = request.getParameter("Title");
	String Release_date = request.getParameter("Release_date");
	String durationParam = request.getParameter("Duration"); // Preiau durata din formular
	String Genre = request.getParameter("Genre");
    
	int aux = 0;
    int Duration = 0;
    String errorMessage = null;
 	// Verificare dacă formularul a fost trimis
    boolean submitted = (pkParam != null);

    if (submitted) {
        if (Title == null || Title.isEmpty() ||
            Release_date == null || Release_date.isEmpty() ||
            durationParam == null || durationParam.isEmpty() ||
            Genre == null || Genre.isEmpty()) {

            errorMessage = "All fields must be completed.";

        } else {
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
        
     // Trimit eroare la m1 pentru afisare deasupra tabelului
        if (errorMessage != null) {
            jb.disconnect();
            response.sendRedirect("m1_Compositions.jsp?primarykey=" + pkParam + "&error=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
            return; // Oprim execuția pentru a face redirectul
        }
		if (errorMessage == null) {
			aux = java.lang.Integer.parseInt(request.getParameter("idcomposition"));
			String[] valori = { Title, Release_date, Duration + "", Genre };
			String[] campuri = { "Title", "Release_date", "Duration", "Genre" };
			jb.modifyTable("Compositions", "idcomposition", aux, campuri, valori);
			jb.disconnect();
		}
    }
	%>
    <h2 style="font-size:30px; ">The changes have been successfully made!</h2>
    <div class="action-row">
        <a href="table_Compositions.jsp" class="btn">Back to the list</a>
        <a href="index.html" class="btn"><b>Home</b></a>
    </div>
</body>
</html>