/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.91
 * Generated at: 2024-10-15 11:41:25 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.jsp.reports;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import com.ConnectionProvider;
import java.text.*;

public final class dsummary830_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {


Connection con=null;
ResultSet rs=null;
Statement stmt=null;
Statement stmt2=null;
String query="";
int count;

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(7);
    _jspx_imports_packages.add("java.sql");
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("java.text");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.LinkedHashSet<>(2);
    _jspx_imports_classes.add("com.ConnectionProvider");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("\n");
      out.write(" \n");
      out.write("\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("\n");
      out.write("function params(){\n");
      out.write("var vid1 = document.getElementById(\"state\").value\n");
      out.write("var vid2 =document.getElementById(\"district\").value\n");
      out.write("var vfdate= document.getElementById(\"fdate\").value\n");
      out.write("var vtdate= document.getElementById(\"tdate\").value\n");
      out.write("window.location.replace(\"dsummary830.jsp?value1=\"+vid1+\"&&value2=\"+vid2+\"&&vfdate=\"+vfdate+\"&&vtdate=\"+vtdate);\n");
      out.write("}\n");
      out.write("</script>\n");
      out.write("\n");
      out.write('\n');

String value1=request.getParameter("value1");
String value2=request.getParameter("value2");
String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");
String vparam=request.getParameter("param");

if (value1==null){value1="0";}
if (value2==null){value2="0";}


DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());


if(vfdate == null){ 
 vfdate=formattedDate;
 vtdate=formattedDate;
}

con = ConnectionProvider.getCon();
stmt=con.createStatement();
stmt2=con.createStatement();
rs = stmt.executeQuery("select param_id as sid,group_value as state from parameter where active='Y' and group_family='LOCATION' and Group_name='STATE'");

      out.write("\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("<link href=\"../../styles/text.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write("<script type=\"text/javascript\" src=\"../../Script/datepicker.js\"></script>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("<table width=\"100%\" border=\"1\" cellpadding=\"1\"  bgcolor=\"#DBEBFF\" VALIGN=TOP>\n");
      out.write("<tr><td width=\"10%\" VALIGN=TOP>\n");
      out.write("<table width=\"10%\" border=\"1\" cellpadding=\"1\"  bgcolor=\"#DBEBFF\" VALIGN=TOP>\n");
      out.write("\n");
      out.write("<!--   date selection starts here -->\n");
      out.write("\n");
      out.write("<tr><td class=\"Blue-content\" colspan=\"4\"><b>Select Date Range</b></td></tr>\n");
      out.write("<tr><td class=\"content style1\" align=\"right\"><b>From</b></td>\n");
      out.write("<td><input id=\"fdate\"  class=\"content style1\" type=\"text\" name=\"fdate\" size=\"10\" maxlength=\"12\" value=");
      out.print(vfdate);
      out.write(">\n");
      out.write("<a href=\"javascript:NewCal('fdate','ddmmyyyy',false)\"><img src=\"../../images/calendar.JPG\" width=\"16\" height=\"16\" border=\"0\" alt=\"Pick a date\"></a></td>\n");
      out.write("</tr>\n");
      out.write("<tr><td class=\"content style1\" align=\"right\"><b>To</b></td>\n");
      out.write("<td><input id=\"tdate\"  class=\"content style1\" type=\"text\" name=\"tdate\" size=\"10\" maxlength=\"12\" value=");
      out.print(vtdate);
      out.write(">\n");
      out.write("<a href=\"javascript:NewCal('tdate','ddmmyyyy',false)\"><img src=\"../../images/calendar.JPG\" width=\"16\" height=\"16\" border=\"0\" alt=\"Pick a date\"></a></td>\n");
      out.write("</tr>\n");
      out.write(" <!-- date selection Ends here -->\n");
      out.write("\n");
      out.write("<tr><td class=\"Blue-content\" colspan=\"6\" align=\"left\">Select Station</td></tr>\n");
      out.write("<tr><td class=\"content style1\"><b> State </b></td>\n");
      out.write("<td>\n");
      out.write("<select id=\"state\" onchange=\"params()\" class=\"content style1\">\n");
      out.write("<option value=\"0\">--Please Select--</option>\n");
 while(rs.next()){ 
      out.write("\n");
      out.write("<option value=\"");
      out.print(rs.getInt("sid"));
      out.write('"');
      out.write('>');
      out.print(rs.getString("state"));
      out.write("</option>\n");
      out.write("\n");
 if(rs.getString("sid").equals(value1)){
      out.write("\n");
      out.write("<option value=\"");
      out.print(value1);
      out.write("\" selected disabled>");
      out.print(rs.getString("state"));
      out.write("</option> \n");

}

}

      out.write("\n");
      out.write("</select> </td></tr>\n");
      out.write("<tr><td class=\"content style1\"><b> District</b> </td><td>\n");
      out.write("<select id=\"district\" onchange=\"params()\" class=\"content style1\">\n");
      out.write("<option value=\"0\">--Please Select--</option>\n");
      out.write("<option value=\"-1\">All</option>\n");
      out.write("\n");

rs=stmt.executeQuery("select param_id as did,group_value as district from parameter where active='Y' and group_family='LOCATION' and Group_name='DISTRICT' and parent_group='"+value1+"' order by group_value");

while(rs.next()){

      out.write("\n");
      out.write("<option value=\"");
      out.print(rs.getInt("did"));
      out.write('"');
      out.write(' ');
      out.write('>');
      out.print(rs.getString("district"));
      out.write("</option>\n");
 if(rs.getString("did").equals(value2)){
      out.write("\n");
      out.write("<option value=\"");
      out.print(value2);
      out.write("\" selected disabled>");
      out.print(rs.getString("district"));
      out.write("</option>\n");

}
}

      out.write("\n");
      out.write("</select>\n");
      out.write("</td></tr>\n");
      out.write("</table>\n");
      out.write("</td>\n");
      out.write("<td valign=top>\n");
      out.write("\n");
      out.write("<!----\n");
      out.write("<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"stretch\" > \n");
      out.write("	<tr><td class=\"Headings\" align=\"center\">Data Summary 8:30AM - 8:30AM</td></tr>\n");
      out.write("--->\n");
      out.write("\n");
      out.write("<table width=\"100%\" border=\"0\" cacellpadding=\"0\" cellspacing=\"0\" id=\"stretch\" > \n");
      out.write("	<tr><td class=\"Headings\" align=\"center\" width=\"80%\">All Data Summary</td></tr>\n");
      out.write("	\n");
      out.write("<tr><td><table width=\"100%\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" id=\"stretch\" > \n");
      out.write("<tr class=\"Blue-content\" align=\"center\">\n");
      out.write("<td rowspan=\"2\">Day</td>\n");
      out.write("<td rowspan=\"2\">Client ID</td>\n");
      out.write("<td rowspan=\"2\">District</td>\n");
      out.write("<!-- <td rowspan=\"2\">Mandal</td> -->\n");
      out.write("<td rowspan=\"2\">Location</td>\n");
      out.write("<td colspan=\"3\">Temparature<br>(&nbsp;&deg;C&nbsp;)</td>\n");
      out.write("<td colspan=\"3\">Humidity<br>(&#37;)</td>\n");
      out.write("<td rowspan=\"2\">Accumulated<br>Rainfall (mm)</td>\n");
      out.write("<!--<td rowspan=\"2\">ET0</td> -->\n");
      out.write("<td rowspan=\"2\">Packet Count</td>\n");
      out.write("</tr>\n");
      out.write("\n");
      out.write("<tr class=\"Blue-content\">\n");
      out.write("<td>Min</td>\n");
      out.write("<td>Max</td>\n");
      out.write("<td>Avg</td>\n");
      out.write("<td>Min</td>\n");
      out.write("<td>Max</td>\n");
      out.write("<td>Avg</td>\n");
      out.write("<!-- <td>Min</td><td>Max</td><td>Avg</td>\n");
      out.write("<td>Min</td><td>Max</td><td>Avg</td>\n");
      out.write("-->\n");
      out.write("</tr>\n");
      out.write("\n");

//query="select pdate,st.clientid,latitude,longitude,location,(select group_value from parameter where param_id=state) as state,(select group_value from parameter where param_id=district) as district,coalesce((select group_value from parameter where param_id=county),'-') as county,pcount,temp_min,temp_max,temp_avg,humidity_min,humidity_max,humidity_avg,rain_max,pressure_min,pressure_max,pressure_avg,mslp_min,mslp_max,mslp_avg,wind_min,wind_max,wind_avg,winddir_min,winddir_max, winddir_avg from station_configs_det as st left outer join (select clientid,case when to_char(packet_date,'HH24MI') between '0000' and '0830' then to_char(packet_date ,'DD/MM/YYYY') else to_char(packet_date+ interval '1 Day','DD/MM/YYYY') end as pdate,count(1) as pcount,max(case when temp = 0 then null else temp end) as temp_max,min(case when temp = 0 then null else temp end) as temp_min,round(cast(avg(temp) as decimal),2) as temp_avg,max(case when humidity = 0 then null else humidity end) as humidity_max,min(case when humidity = 0 then null else humidity end) as humidity_min, round(cast(avg(humidity) as decimal),2) as humidity_avg,max(rain) as rain_max,max(case when local_pressure = 0 then null else local_pressure end) as pressure_max,min(case when local_pressure = 0 then null else local_pressure end) as pressure_min, round(cast(avg(case when local_pressure = 0 then null else local_pressure end) as decimal),2) as pressure_avg,max(case when mslp = 0 then null else mslp end) as mslp_max,min(case when mslp = 0 then null else mslp end) as mslp_min, round(cast(avg(case when mslp = 0 then null else mslp end) as decimal),2) as mslp_avg,max(wind)as wind_max,min(wind)as wind_min,round(cast(avg(wind) as decimal),2) as wind_avg, max(case when wind_direction = 0 then null else wind_direction end) as winddir_max,min(case when wind_direction= 0 then null else wind_direction end) as winddir_min,round(cast(avg(wind_direction) as decimal),1) as winddir_avg from data_packets"; 
//query+=" where  packet_date >= to_date('"+vfdate+"','DD/MM/YYYY')+INTERVAL '8.5 HOUR' ";
//query+=" and packet_date < to_date('"+vtdate+"','DD/MM/YYYY')+ INTERVAL '8.5 HOUR' ";
//query+=" and packet_type='D' group by clientid,pdate ) as dp on st.clientid=dp.clientid where st.activate!=0";

query="select pdate,st.clientid,latitude,longitude,location,(select group_value from parameter where param_id=state) as state,(select group_value from parameter where param_id=district) as district,coalesce((select group_value from parameter ";
query+=" where param_id=county),'-') as county,pcount,temp_min,temp_max,temp_avg,humidity_min,humidity_max,humidity_avg,rain_max,pressure_min,pressure_max,pressure_avg,mslp_min,mslp_max,mslp_avg,wind_min,wind_max,wind_avg,winddir_min,winddir_max, winddir_avg,et0 "; 
query+=" from station_configs_det as st left outer join (";
query+=" select x.*, (pmin.evop_pan-pmax.evop_pan-rain_max)*0.75  et0  from ( ";

//query+=" select clientid,to_char(packet_date,'DD/MM/YYYY') as pdate,";
query+=" select clientid,case when to_char(packet_date,'HH24MI') between '0000' and '0830' then to_char(packet_date ,'DD/MM/YYYY') else to_char(packet_date+ interval '1 Day','DD/MM/YYYY') end as pdate,";
query+=" count(1) as pcount,max(case when temp_max = 0 then null else temp_max end) as temp_max,min(case when temp_min = 0 then null else temp_min end) as temp_min,round(cast(avg(temp) as decimal),2) as temp_avg,";
query+=" max(case when humidity = 0 then null else humidity end) as humidity_max,min(case when humidity = 0 then null else humidity end) as humidity_min, round(cast(avg(humidity) as decimal),2) as humidity_avg,max(rain) as rain_max,";
query+=" max(case when local_pressure = 0 then null else local_pressure end) as pressure_max,min(case when local_pressure = 0 then null else local_pressure end) as pressure_min, round(cast(avg(case when local_pressure = 0 then null ";
query+=" else local_pressure end) as decimal),2) as pressure_avg,max(case when mslp = 0 then null else mslp end) as mslp_max,min(case when mslp = 0 then null else mslp end) as mslp_min, ";
query+=" round(cast(avg(case when mslp = 0 then null else mslp end) as decimal),2) as mslp_avg,max(wind)as wind_max,min(wind)as wind_min,round(cast(avg(wind) as decimal),2) as wind_avg, ";
query+=" max(case when wind_direction = 0 then null else wind_direction end) as winddir_max,min(case when wind_direction= 0 then null else wind_direction end) as winddir_min,round(cast(avg(wind_direction) as decimal),1) as winddir_avg,"; 
query+=" min(case when evop_pan !=999 then packet_date end) firstPacketDate,max(case when evop_pan !=999 then packet_date end) lastPacketDate";
query+=" from data_packets";
//query+=" where  packet_date >= to_date('"+vfdate+"','DD/MM/YYYY')   and packet_date < to_date('"+vtdate+"','DD/MM/YYYY')+ INTERVAL '1 DAY' ";
query+=" where  packet_date > to_date('"+vfdate+"','DD/MM/YYYY')+INTERVAL '8.5 HOUR' and packet_date <= to_date('"+vtdate+"','DD/MM/YYYY')+ INTERVAL '8.5 HOUR' ";

//query+=" and to_char(packet_date,'HH24MI') between '0830' and '1739' ";
//query+=" and packet_type='D' group by clientid,pdate ";  
query+=" and packet_type='D' group by clientid,(case when to_char(packet_date,'HH24MI') between '0000' and '0830' then to_char(packet_date ,'DD/MM/YYYY') else to_char(packet_date+ interval '1 Day','DD/MM/YYYY') end) ) as x ";
query+=" left outer join data_packets as Pmin on x.firstPacketDate=Pmin.packet_date and Pmin.packet_type='D' and pmin.clientid=x.clientid ";
query+=" left outer join data_packets as Pmax on x.lastPacketDate=Pmax.packet_date and Pmax.packet_type='D' and pmax.clientid=x.clientid ";
query+=" ) as dp on st.clientid=dp.clientid where st.activate!=0";


if(value2.equalsIgnoreCase("-1")) {	query=query+" and state='"+value1+"'";
  }
	else{ query=query+" and district='"+value2+"'";}

query=query+" order by clientid,pdate";
rs=stmt.executeQuery(query);


System.out.println(query);
//out.println(query);
	rs=stmt.executeQuery(query);
	while(rs.next()){

      out.write("\n");
      out.write("<tr  class=\"readonly\">\n");
      out.write("<!--------<td>");
      out.print(rs.getString("pdate"));
      out.write("</td>---------->\n");
 if (rs.getString("pdate")==null){ 
      out.write("<td align=\"right\">---</td>");
} else {
      out.write("<td align=\"right\">");
      out.print(rs.getString("pdate"));
      out.write("</td>");
}
      out.write("\n");
      out.write("<td>");
      out.print(rs.getString("clientid"));
      out.write("</td><td>");
      out.print(rs.getString("district"));
      out.write("</td>\n");
      out.write("<!-- <td>");
      out.print(rs.getString("county"));
      out.write("</td> -->\n");
      out.write("<td>");
      out.print(rs.getString("location"));
      out.write("</td>\n");
      out.write("\n");
 if (rs.getString("temp_min")==null){ 
      out.write("<td align=\"right\">N/A</td>");
} else {
      out.write("<td align=\"right\">");
      out.print(rs.getDouble("temp_min"));
      out.write("</td>");
}
      out.write('\n');
      out.write('\n');
 if (rs.getString("temp_max")==null){ 
      out.write("<td align=\"right\">N/A</td>");
} else {
      out.write("<td align=\"right\">");
      out.print(rs.getDouble("temp_max"));
      out.write("</td>");
}
      out.write('\n');
 if (rs.getString("temp_avg")==null){ 
      out.write("<td align=\"right\">N/A</td>");
} else {
      out.write("<td align=\"right\">");
      out.print(rs.getDouble("temp_avg"));
      out.write("</td>");
}
      out.write('\n');
 if (rs.getString("humidity_min")==null){ 
      out.write("<td align=\"right\">N/A</td>");
} else {
      out.write("<td align=\"right\">");
      out.print(rs.getDouble("humidity_min"));
      out.write("</td>");
}
      out.write('\n');
 if (rs.getString("humidity_max")==null){ 
      out.write("<td align=\"right\">N/A</td>");
} else {
      out.write("<td align=\"right\">");
      out.print(rs.getDouble("humidity_max"));
      out.write("</td>");
}
      out.write('\n');
 if (rs.getString("humidity_avg")==null){ 
      out.write("<td align=\"right\">N/A</td>");
} else {
      out.write("<td align=\"right\">");
      out.print(rs.getDouble("humidity_avg"));
      out.write("</td>");
}
      out.write("\n");
      out.write("\n");
      out.write("<!--\n");
 if (rs.getString("wind_min")==null){ 
      out.write("<td align=\"right\">N/A</td>");
} else {
      out.write("<td align=\"right\">");
      out.print(rs.getDouble("wind_min"));
      out.write("</td>");
}
      out.write('\n');
 if (rs.getString("wind_max")==null){ 
      out.write("<td align=\"right\">N/A</td>");
} else {
      out.write("<td align=\"right\">");
      out.print(rs.getDouble("wind_max"));
      out.write("</td>");
}
      out.write('\n');
 if (rs.getString("wind_avg")==null){ 
      out.write("<td align=\"right\">N/A</td>");
} else {
      out.write("<td align=\"right\">");
      out.print(rs.getDouble("wind_avg"));
      out.write("</td>");
}
      out.write('\n');
 if (rs.getString("winddir_min")==null){ 
      out.write("<td align=\"right\">N/A</td>");
} else {
      out.write("<td align=\"right\">");
      out.print(rs.getDouble("winddir_min"));
      out.write("</td>");
}
      out.write('\n');
 if (rs.getString("winddir_max")==null){ 
      out.write("<td align=\"right\">N/A</td>");
} else {
      out.write("<td align=\"right\">");
      out.print(rs.getDouble("winddir_max"));
      out.write("</td>");
}
      out.write('\n');
 if (rs.getString("winddir_avg")==null){ 
      out.write("<td align=\"right\">N/A</td>");
} else {
      out.write("<td align=\"right\">");
      out.print(rs.getDouble("winddir_avg"));
      out.write("</td>");
}
      out.write("\n");
      out.write("-->\n");
      out.write("\n");
 if (rs.getString("rain_max")==null){ 
      out.write("<td align=\"right\">N/A</td>");
} else {
      out.write("<td align=\"right\">");
      out.print(rs.getDouble("rain_max"));
      out.write("</td>");
}
      out.write("\n");
      out.write("\n");
      out.write("<!---- old code ---without N/A \n");
      out.write("<td>");
      out.print(rs.getDouble("temp_max"));
      out.write("</td><td>");
      out.print(rs.getDouble("temp_min"));
      out.write("</td><td>");
      out.print(rs.getDouble("temp_avg"));
      out.write("</td>\n");
      out.write("<td>");
      out.print(rs.getDouble("humidity_max"));
      out.write("</td><td>");
      out.print(rs.getDouble("humidity_min"));
      out.write("</td><td>");
      out.print(rs.getDouble("humidity_avg"));
      out.write("</td>\n");
      out.write("<td>");
      out.print(rs.getDouble("pressure_max"));
      out.write("</td><td>");
      out.print(rs.getDouble("pressure_min"));
      out.write("</td>\n");
      out.write("<td>");
      out.print(rs.getDouble("pressure_avg"));
      out.write("</td>\n");
      out.write("<td>");
      out.print(rs.getDouble("rain_max"));
      out.write("</td> ---->\n");
      out.write("<!--<td align=\"right\">");
      out.print(rs.getDouble("et0"));
      out.write("</td>  -->\n");
      out.write("<td align=\"center\">");
      out.print(rs.getInt("pcount"));
      out.write("</td> \n");
      out.write("</tr>\n");

}

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("</tr></table>\n");
      out.write("\n");
      out.write("</table>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("	</table>\n");
      out.write("</td></tr>\n");
      out.write("</table>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
