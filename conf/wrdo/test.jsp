<%@ page language="java" import="wms.dbconnect.DBPostgres" %>




<%@ page import="java.sql.*"%>
<%@ page language="java" import="java.util.*"%>
<%
	response.setContentType("text/html");
	String query = "";
	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;

	try
	{
		Class.forName("org.postgresql.Driver");
        //con = DBPostgres.getConnection();
		//stmt=con.createStatement();
		con = DriverManager.getConnection("jdbc:postgresql://192.168.1.76:5432/wrdo","postgres","obel123");
			stmt =  con.createStatement();

		query="select * from users";
		rs=stmt.executeQuery(query);
	
		while(rs.next()) {
		out.println("<tr><td>test");
		out.println(rs.getString(1));
		out.println("</td><td>");
		out.println(rs.getString(2));
		out.println("</td></tr>");
		
		}

	}

catch(Exception ex)
	{
		out.println(ex);
		
	}


//rs.close();
//con.close();

 %>
