package db;

import java.sql.*;


public class JavaBean {
	String error;
	Connection con;

	public JavaBean() {
	}

	public void connect() throws ClassNotFoundException, SQLException, Exception { 
		try { 
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/muzica?useSSL=false", "proiect_pibd", "PrOiEcT121529!"); 
		} catch (ClassNotFoundException cnfe) { 
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date."; 
			throw new ClassNotFoundException(error); 
		} catch (SQLException cnfe) { 
			error = "SQLException: Nu se poate conecta la baza de date."; 
			throw new SQLException(error); 
		} catch (Exception e) { 
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date."; 
			throw new Exception(error); 
		} 
	} // connect()

	public void connect(String bd) throws ClassNotFoundException, SQLException, Exception { 
		try { 
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + bd, "root", 
					"parola"); 
		} catch (ClassNotFoundException cnfe) { 
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date."; 
			throw new ClassNotFoundException(error); 
		} catch (SQLException cnfe) { 
			error = "SQLException: Nu se poate conecta la baza de date."; 
			throw new SQLException(error); 
		} catch (Exception e) { 
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date."; 
			throw new Exception(error); 
		} 
	} // connect(String bd)

	public void connect(String bd, String ip) throws ClassNotFoundException, SQLException, 
	Exception { 
		try { 
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			con = DriverManager.getConnection("jdbc:mysql://" + ip + ":3306/" + bd, "root", 
					"parola"); 
		} catch (ClassNotFoundException cnfe) { 
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date."; 
			throw new ClassNotFoundException(error); 
		} catch (SQLException cnfe) { 
			error = "SQLException: Nu se poate conecta la baza de date."; 
			throw new SQLException(error); 



		} catch (Exception e) { 
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date."; 
			throw new Exception(error); 
		} 
	} // connect(String bd, String ip)

	public void disconnect() throws SQLException {
		try {
			if (con != null) {
				con.close();
			}
		} catch (SQLException sqle) {
			error = ("SQLException: Nu se poate inchide conexiunea la baza de date.");
			throw new SQLException(error);
		}
	} // disconnect()

	public void addComposition(String Title, String Release_date, int Duration,String Genre) throws SQLException, Exception {
		if (con != null) {
			try {
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate("insert into Compositions(Title, Release_date, Duration, Genre) values('" + Title + "'  , '" + Release_date + "', '" + Duration + "', '" + Genre +"');");

			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	}// end of addComposition()

	public void addComposer(String Last_name, String First_name, int Age, int Nr_works) throws SQLException, Exception {
		if (con != null) {
			try {
				// creaza un "prepared SQL statement" 
				Statement stmt;

				stmt = con.createStatement();
				stmt.executeUpdate("insert into Composers(Last_name, First_name, Age, Nr_works) values('" + Last_name + "', '" + First_name + "'  , '" + Age + "', '" + Nr_works + "');");

			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	}// end of addComposer()

	public void addCollaboration(int idcomposition, int idcomposer, String Role_composer, String Start_date) throws SQLException, Exception { 
		if (con != null) { 
			try { 
				// creaza un "prepared SQL statement" 
				Statement stmt; 
				stmt = con.createStatement(); 
				stmt.executeUpdate("insert into Collaborations(idcomposition, idcomposer, Role_composer, Start_date) values('" + idcomposition + "'  , '" + idcomposer + "', '" + Role_composer + "', '" + Start_date + "');"); 

			} catch (SQLException sqle) { 
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate."; 
				throw new SQLException(error); 
			} 
		} else { 
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta."; 
			throw new Exception(error); 
		} 
	}// end of addCollaboration()

	public ResultSet viewTable(String tabel) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("select * from `muzica`.`" + tabel + "`;");

			Statement stmt = con.createStatement(/*
			 * ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY
			 */);
			rs = stmt.executeQuery(queryString);
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	}// end of viewTable()

	public ResultSet viewCollaborations() throws SQLException, Exception { 
		ResultSet rs = null; 
		try { 
			String queryString = ("select a.Title, a.Release_date, a.Duration, a.Genre, b.Last_name, b.First_name, b.Age, b.Nr_works, c.idcollaboration, c.idcomposition idcomposition_composer, c.idcomposer idcomposer_composition, c.Role_composer, c.Start_date from Compositions a, Composers b, Collaborations c where a.idcomposition = c.idcomposition and b.idcomposer = c.idcomposer;"); 																								
			Statement stmt = con.createStatement(/*ResultSet.TYPE_SCROLL_INSENSITIVE, 
ResultSet.CONCUR_READ_ONLY*/); 
			rs = stmt.executeQuery(queryString); 
		} catch (SQLException sqle) { 
			error = "SQLException: Interogarea nu a fost posibila."; 
			throw new SQLException(error); 
		} catch (Exception e) { 
			error = "A aparut o exceptie in timp ce se extrageau datele."; 
			throw new Exception(error); 
		} 
		return rs; 
	}// end of viewCollaborations()

	public void deleteTableData(String[] primaryKeys, String tabela, String dupaID) throws SQLException, Exception {
		if (con != null) {
			try {
				// creaza un "prepared SQL statement" 
				long aux;
				PreparedStatement delete;
				delete = con.prepareStatement("DELETE FROM " + tabela + " WHERE " + dupaID + "=?;");
				for (int i = 0; i < primaryKeys.length; i++) {
					aux = java.lang.Long.parseLong(primaryKeys[i]);
					delete.setLong(1, aux);

					delete.execute();
				}
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			} catch (Exception e) {
				error = "A aparut o exceptie in timp ce erau sterse inregistrarile.";
				throw new Exception(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of deleteTableData()

	public void deleteTable(String tabela) throws SQLException, Exception {
		if (con != null) {
			try {
				// creaza un "prepared SQL statement" 
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate("delete from " + tabela + ";");
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Stergere nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of deleteTableData()

	public void modifyTable(String tabela, String IDTabela, int ID, String[] campuri, String[] valori) throws SQLException, Exception { 
		String update = "update " + tabela + " set "; 
		String temp = ""; 
		if (con != null) { 
			try { 
				for (int i = 0; i < campuri.length; i++) { 
					if (i != (campuri.length - 1)) { 
						temp = temp + campuri[i] + "='" + valori[i] + "', "; 
					} else { 
						temp = temp + campuri[i] + "='" + valori[i] + "' where " + IDTabela + " = '" + ID + "';"; 

					} 
				} 
				update = update + temp; 
				// creaza un "prepared SQL statement" 
				Statement stmt; 
				stmt = con.createStatement(); 
				stmt.executeUpdate(update); 
			} catch (SQLException sqle) { 
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate."; 
				throw new SQLException(error); 
			} 
		} else { 
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta."; 
			throw new Exception(error); 
		} 
	} // end of modifyTable()

	public ResultSet addrRow(String tabela, int ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			// Executa interogarea 
			String queryString = ("SELECT * FROM " + tabela + " where idpacient=" + ID + ";");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString); // sql exception
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // end of addrRow()

	public ResultSet addrRowId(String tabela, String denumireId, int ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			// Executa interogarea 
			String queryString = ("SELECT * FROM " + tabela + " where " + denumireId + "=" + ID + ";");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString); // sql exception
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // end of addrRowId()

	public ResultSet addCollaborationsId(int ID) throws SQLException, Exception { 
		ResultSet rs = null; 
		try { 
			// Executa interogarea 
			String queryString = ("select a.Title, a.Release_date, a.Duration, a.Genre, b.Last_name, b.First_name, b.Age, b.Nr_works, c.idcollaboration, c.idcomposition idcomposition_composer, c.idcomposer idcomposer_composition, c.Role_composer, c.Start_date from Compositions a, Composers b, Collaborations c where a.idcomposition = c.idcomposition and b.idcomposer = c.idcomposer and idcollaboration = '" + ID + "';"); 
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, 
					ResultSet.CONCUR_READ_ONLY); 
			rs = stmt.executeQuery(queryString); //sql exception 
		} catch (SQLException sqle) { 
			error = "SQLException: Interogarea nu a fost posibila."; 
			throw new SQLException(error); 
		} catch (Exception e) { 
			error = "A aparut o exceptie in timp ce se extrageau datele."; 
			throw new Exception(error); 
		} 
		return rs; 
	} // end of addCollaborationsId()
}