<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html> 
    <head> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <title>Compositions</title> 
        <link rel="stylesheet" href="style.css">
    </head> 
    <jsp:useBean id="jb" scope="session" class="db.JavaBean" /> 
    <jsp:setProperty name="jb" property="*" /> 
    <body> 
    
        <h2>Compositions</h2> 
       
        <form action="delete_Compositions.jsp" method="post"> 
            <table border="1" align="center"> 
                <tr> 
                    <td><b>Mark:</b></td> 
                    <td><b>IdComposition:</b></td> 
                    <td><b>Title:</b></td> 
                    <td><b>Release date:</b></td> 
                    <td><b>Duration:</b></td> 
                    <td><b>Genre:</b></td> 
 
                </tr> 
                <% 
                    jb.connect(); 
                    ResultSet rs = jb.viewTable("Compositions"); 
                    long x; 
                    while (rs.next()) { 
                        x = rs.getInt("idcomposition"); 
                %> 
                <tr> 
                    <td><input type="checkbox" name="primarykey" value="<%= x%>" /></td><td><%= x%></td> 
                    <td><%= rs.getString("Title")%></td> 
                    <td><%= rs.getString("Release_date")%></td> 
                    <td><%= rs.getString("Duration")%></td> 
                    <td><%= rs.getString("Genre")%></td> 
                    <% 
                        } 
                    %> 
                </tr> 
            </table><br/> 
            <div class="form-container">
            	  <p class="title">Manage compositions:</p>
		          <div class="action-row">
		            <a href="new_Compositions.jsp" class="btn">+ Add</a>
		            <a href="modify_Compositions.jsp" class="btn">Edit/Modify</a>
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