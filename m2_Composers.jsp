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
            String pkParam = request.getParameter("idcomposer");
            String Last_name = request.getParameter("Last_name"); 
            String First_name = request.getParameter("Last_name"); 
            String AgeParam = request.getParameter("Age");
            String Nr_worksParam = request.getParameter("Nr_works");
            
            int aux = 0;
            int Age=0;
            int Nr_works=0;
            String errorMessage = null;
            
         	// Verificare dacă formularul a fost trimis
            boolean submitted = (pkParam != null);

            if (submitted) {
                if (Last_name == null || Last_name.isEmpty() ||
                    First_name == null || First_name.isEmpty() ||
                    AgeParam == null || AgeParam.isEmpty() ||
                    Nr_worksParam == null || Nr_worksParam.isEmpty()) {

                    errorMessage = "All fields must be completed.";

                } else {
                    try {
                        Age = Integer.parseInt(AgeParam);
                    } catch (NumberFormatException e) {
                        errorMessage = "Age must be a valid number.";
                    }
                    if (errorMessage == null) {
                        try {
                            Nr_works = Integer.parseInt(Nr_worksParam);
                        } catch (NumberFormatException e) {
                            errorMessage = "Number of works must be a valid number.";
                        }
                    }
                    
                }
         // Trimit eroare la m1 pentru afisare deasupra tabelului
            if (errorMessage != null) {
                jb.disconnect();
                response.sendRedirect("m1_Composers.jsp?primarykey=" + pkParam + "&error_2=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
                return; // Oprim execuția pentru a face redirectul
            }
    		if (errorMessage == null) {
    			aux = java.lang.Integer.parseInt(request.getParameter("idcomposer"));
    			String[] valori = {Last_name, Last_name, Age + "", Nr_works + "" }; 
                String[] campuri = {"Last_name", "Last_name", "Age", "Nr_works"}; 
                jb.modifyTable("Composers", "idcomposer", aux, campuri, valori); 
                jb.disconnect();
    		}
     }
     %>
	<h2 style="font-size:30px; ">The changes have been successfully made!</h2>
    <div class="action-row">
        <a href="table_Composers.jsp" class="btn">Back to the list</a>
        <a href="index.html" class="btn"><b>Home</b></a>
    </div>
</body>
</html>
