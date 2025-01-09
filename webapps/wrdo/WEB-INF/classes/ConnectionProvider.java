package com;

import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class ConnectionProvider
{
  static Connection con = null;
  
  static
  {
    try
    {
      Properties props = new Properties();
      InputStream fis = ConnectionProvider.class.getResourceAsStream("/jdbc.properties");
      
      props.load(fis);
      
      String USERNAME = props.getProperty("jdbc.username");
      String PASSWORD = props.getProperty("jdbc.password");
      String DRIVER = props.getProperty("jdbc.driver");
      String HOST = props.getProperty("jdbc.host");
      String PORT = props.getProperty("jdbc.port");
      String DB = props.getProperty("jdbc.db");
      
      String CONNECTION_URL = "jdbc:postgresql://" + HOST + ":" + PORT + "/" + DB;
      
      Class.forName(DRIVER);
      con = DriverManager.getConnection(CONNECTION_URL, USERNAME, PASSWORD);
    }
    catch (Exception localException) {}
  }
  
  public static Connection getCon()
  {
    return con;
  }
  
  public static void closeResources(Connection conn, Statement stmt, ResultSet rs)
  {
    closeResource(rs);
    closeResource(stmt);
    closeResource(conn);
  }
  
  public static void closeResources(Connection conn, PreparedStatement pstmt, ResultSet rs)
  {
    closeResource(rs);
    closeResource(pstmt);
    closeResource(conn);
  }
  
  public static void closeResources(Connection conn, CallableStatement cstmt, ResultSet rs)
  {
    closeResource(rs);
    closeResource(cstmt);
    closeResource(conn);
  }
  
  public static void closeResource(PreparedStatement pstmt)
  {
    try
    {
      if (pstmt != null) {
        pstmt.close();
      }
    }
    catch (SQLException sqle)
    {
      sqle.printStackTrace();
    }
    pstmt = null;
  }
  
  public static void closeResource(CallableStatement cstmt)
  {
    try
    {
      if (cstmt != null) {
        cstmt.close();
      }
    }
    catch (SQLException sqle)
    {
      sqle.printStackTrace();
    }
    cstmt = null;
  }
  
  public static void closeResource(Statement stmt)
  {
    try
    {
      if (stmt != null) {
        stmt.close();
      }
    }
    catch (SQLException sqle)
    {
      sqle.printStackTrace();
    }
    stmt = null;
  }
  
  public static void closeResource(Connection conn)
  {
    try
    {
      if (conn != null) {
        conn.close();
      }
    }
    catch (SQLException sqle)
    {
      sqle.printStackTrace();
    }
    conn = null;
  }
  
  public static void closeResource(ResultSet rs)
  {
    try
    {
      if (rs != null) {
        rs.close();
      }
    }
    catch (SQLException sqle)
    {
      sqle.printStackTrace();
    }
    rs = null;
  }
}
