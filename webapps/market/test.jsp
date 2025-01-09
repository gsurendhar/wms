<%@ page import="java.sql.*, javax.sql.*, java.io.*, javax.naming.*" %>
<html>
<head><title>Hello world from JSP</title></head>
<body>
<%
  InitialContext ctx;
  DataSource ds;
  Connection conn;
  Statement stmt;
  ResultSet rs;

  try {
    ctx = new InitialContext();
    ds = (DataSource) ctx.lookup("java:comp/env/jdbc/MyDB");
    //ds = (DataSource) ctx.lookup("jdbc/MyDB");
    conn = ds.getConnection();
    stmt = conn.createStatement();
    rs = stmt.executeQuery("SELECT * FROM scrip_code");

    while(rs.next()) {
%>
    <h3>Name: <%= rs.getString(1) %></h3>
    <h3>Population: <%= rs.getString(2) %></h3>
<%  
    }
  }
  catch (SQLException se) {
%>
    <%= se.getMessage() %>
<%    
  }
  catch (NamingException ne) {
%>
    <%= ne.getMessage() %>
<%
  }
%>
</body>
</html>