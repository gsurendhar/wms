<%@page contentType="application/xml" %>
<%@ page import="java.io.*"%>
<%@ page language="java" import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %>


<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query=null;
%>


<%
String vid= request.getParameter("lid");
if (vid==null){vid="0";}
String vlimit= request.getParameter("limit");
if (vlimit==null){vlimit="100";}
if (Integer.parseInt(vlimit) >1000){vlimit="20000";}

//out.println(vid);

String strQuery="";

con = ConnectionProvider.getCon();
stmt=con.createStatement();

 //strQuery ="SELECT * FROM query_to_xml( 'SELECT id RunningID, clientid,packetno,packet_date,round(cast(rain as decimal),2) rain,round(cast(temp as decimal),2)as temparature,solar_rad from data_packets where id >="+vlid+" order by 1 limit "+vlimit+" ',true,false,'')";
 
strQuery="SELECT * FROM query_to_xml( 'SELECT id RunningID, clientid,packetno,packet_date,"; 
strQuery +="round(cast(temp_min as decimal),2) as temp_min,round(cast(temp as decimal),2)as temp,round(cast(temp_max as decimal),2)as temp_max,";
strQuery +="round(cast(humidity as decimal),2) as humidity,round(cast(humidity_avg as decimal),2) as  humidity_avg,";
strQuery +="round(cast(wind_min as decimal),2) as wind_min,round(cast(wind as decimal),2) as wind,round(cast(wind_max as decimal),2) as wind_max,round(cast(wind_avg as decimal),2) as wind_avg,round(cast(wind_direction_avg as decimal),2) as wind_direction_avg,";
strQuery +="round(cast(gust as decimal),2) as gust,round(cast(gust_direction as decimal),2) as gust_direction, ";
strQuery +="round(cast(local_pressure as decimal),2) as local_pressure,round(cast(mslp as decimal),2) as mslp,";
strQuery +="round(cast(rain as decimal),2) as rain,round(cast(hrain as decimal),2) as hrain,";
strQuery +="round(cast(solar_rad as decimal),2) as solar_rad,round(cast(battery as decimal),2) as battery ";
strQuery +=" from data_packets where id >= "+vid+" and id <= "+vid+"+"+vlimit+" order by 1 ',true,false,'')";
// out.println(strQuery);
 
 rs=stmt.executeQuery(strQuery);
 
 while(rs.next()){
 out.println(rs.getString(1));
 }
 
 rs.close();
 

 %>

