
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="wms.dbconnect.DBPostgres" %> 

<%@ page import="java.io.*" %>  
<%@ page import="org.jfree.chart.JFreeChart" %>  
<%@ page import="org.jfree.chart.ChartUtilities" %>  

<%@ page  import="java.awt.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import ="org.jfree.data.general.*"%>
<%@ page  import="org.jfree.data.category.*"%>

<%@ page  import ="org.jfree.chart.ChartFactory" %>
<%@ page  import ="org.jfree.chart.ChartPanel" %>
<%@ page  import ="org.jfree.chart.axis.NumberAxis" %>
<%@ page  import ="org.jfree.chart.plot.PlotOrientation" %>
<%@ page  import ="org.jfree.chart.plot.XYPlot" %>
<%@ page  import ="org.jfree.chart.renderer.xy.XYLineAndShapeRenderer" %>
<%@ page  import ="org.jfree.data.xy.XYDataset" %>
<%@ page  import ="org.jfree.data.xy.XYSeries" %>
<%@ page  import ="org.jfree.data.xy.XYSeriesCollection" %>
<%@ page  import ="org.jfree.ui.ApplicationFrame" %>
<%@ page  import ="org.jfree.ui.RefineryUtilities" %>

<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";
%>

<!-- Sesssion Management -->
<%if(null == session.getAttribute("theName")){  
  // User is not logged in.
  out.println("your Session has expired");
  response.sendRedirect("../index.html?invalid=0");
}
%>
<!-- End of Sesssion Management -->

<html>
<head>
<TITLE> Station Statistics </TITLE>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
con = DBPostgres.getConnection();
stmt=con.createStatement();

query="select count(1) as Total,sum(case when percent is null then 1 end) as Norep,sum(case when percent >=90 then 1 end)as reporting90,sum(case when percent >=80 and percent <90 then 1 end)as reporting80,sum(case when percent >=70 and percent <80 then 1 end)as reporting70, sum(case when percent >=60 and percent <70 then 1 end)as reporting60, sum(case when percent >=50 and percent <60 then 1 end)as reporting50, sum(case when percent <50  then 1 end)as rep50less from (select st.clientid, st.datafreq,packet_count,minutes, minutes/st.datafreq,cast(packet_count*100/(minutes/st.datafreq) as integer) as Percent  from station_configs_det as st left outer join (select clientid,count(distinct (to_Char(packet_date,'YYYYMMDD HH24'))) as packet_count,((EXTRACT(epoch FROM CURRENT_TIMESTAMP)-EXTRACT(epoch FROM CURRENT_TIMESTAMP - Interval '1 DAY'))/60) as minutes from data_packets  where packet_date >= CURRENT_TIMESTAMP - Interval '1 DAY' group by clientid) as a on (st.clientid=a.clientid) where st.activate!=0) as x";


rs=stmt.executeQuery(query);
Integer vTotal=0;
Integer vNorep=0;
Integer v90=0;
Integer v80=0;
Integer v70=0;
Integer v60=0;
Integer v50=0;
Integer v40=0;


int DisRow=0;
while(rs.next()){ 
	vTotal=rs.getInt(1);
	vNorep=rs.getInt(2) ;
	v90= rs.getInt(3) ;
	v80= rs.getInt(4) ;
	v70= rs.getInt(5) ;
    v60= rs.getInt(6) ;
    v50= rs.getInt(7) ;
    v40= rs.getInt(8) ;

	DisRow++;
	}
rs.close();
con.close();
	%>





<table width="100" border="1" cellpadding="0" cellspacing="0" >
 <tr><td colspan=4>
<img src="getChart.jsp?v1=<%=v90*100/vTotal%>&&d1=90per&&v2=<%=v80*100/vTotal%>&&d2=80&&v3=<%=v70*100/vTotal%>&&d3=70&&v4=<%=v60*100/vTotal%>&&d4=60&&v5=<%=v50*100/vTotal%>&&d5=50&&v6=<%=v40*100/vTotal%>&&d6=50-&&v7=<%=vNorep*100/vTotal%>&&d7=NoRep" alt="Progress chart" />
</td></tr>
</td></tr>
<tr><td><a href="stnlist.jsp?v1=t" target="_blank" class="Blue-content">90-100%</td><td class="content style1"><a href="stnlist.jsp?v1=t" target="_blank" class="Blue-content"><%=v90%></td> 
<!--</tr><tr> -->
<td><a href="stnlist.jsp?v1=w" target="_blank" class="Blue-content">80-90%</td><td class="content style1"><a href="stnlist.jsp?v1=w" target="_blank" class="Blue-content"><%=v80%></td> 
</tr><tr>
<td><a href="stnlist.jsp?v1=n" target="_blank" class="Blue-content">70-80%</td><td class="content style1"><a href="stnlist.jsp?v1=n" target="_blank" class="Blue-content"><%=v70%></td> 
<!--</tr><tr> -->
<td><a href="stnlist.jsp?v1=n" target="_blank" class="Blue-content">60-70%</td><td class="content style1"><a href="stnlist.jsp?v1=n" target="_blank" class="Blue-content"><%=v60%></td> 
</tr><tr><td><a href="stnlist.jsp?v1=n" target="_blank" class="Blue-content">50-60%</td><td class="content style1"><a href="stnlist.jsp?v1=n" target="_blank" class="Blue-content"><%=v50%></td> 
<!--</tr><tr> -->
<td><a href="stnlist.jsp?v1=n" target="_blank" class="Blue-content">0-50%</td><td class="content style1"><a href="stnlist.jsp?v1=n" target="_blank" class="Blue-content"><%=v40%></td> </tr>
<td><a href="stnlist.jsp?v1=n" target="_blank" class="Blue-content">Not Reporting%</td><td class="content style1"><a href="stnlist.jsp?v1=n" target="_blank" class="Blue-content"><%=vNorep%></td> </tr> 



</table>
</body>
</html>