<%@ page language="java" import="com.ConnectionProvider" %>




<%@ page import="java.sql.*"%>
<%@ page language="java" import="java.util.*"%>
<%
	response.setContentType("text/html");
	String query ="";
	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;

	try
	{
		//Class.forName("org.postgresql.Driver");
          con = ConnectionProvider.getCon();
		//stmt=con.createStatement();
		//con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/apwms","postgres","abc123");
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
