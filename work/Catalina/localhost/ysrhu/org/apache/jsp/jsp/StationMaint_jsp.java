/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.91
 * Generated at: 2024-10-17 07:09:12 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.*;
import java.text.*;
import java.util.*;
import com.locationDao;
import com.locationBean;

public final class StationMaint_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(8);
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("java.text");
    _jspx_imports_packages.add("java.util");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("java.io");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.LinkedHashSet<>(3);
    _jspx_imports_classes.add("com.locationDao");
    _jspx_imports_classes.add("com.locationBean");
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

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      com.locationBean obj = null;
      obj = (com.locationBean) _jspx_page_context.getAttribute("obj", javax.servlet.jsp.PageContext.PAGE_SCOPE);
      if (obj == null){
        obj = new com.locationBean();
        _jspx_page_context.setAttribute("obj", obj, javax.servlet.jsp.PageContext.PAGE_SCOPE);
      }
      out.write('\r');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.introspect(_jspx_page_context.findAttribute("obj"), request);
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("\r\n");
      out.write("function getDistrict(){\r\n");
      out.write("	var vid1 = document.getElementById(\"state\").value;\r\n");
      out.write("	window.location.replace(\"StationMaint.jsp?value1=\"+vid1);\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function getCounty(){\r\n");
      out.write("	var vid1 = document.getElementById(\"state\").value;\r\n");
      out.write("	var vid2 = document.getElementById(\"district\").value;\r\n");
      out.write("	window.location.replace(\"StationMaint.jsp?value1=\"+vid1+\"&&value2=\"+vid2);\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("function getLocations(){\r\n");
      out.write("	var vid1 = document.getElementById(\"state\").value;\r\n");
      out.write("	var vid2 = document.getElementById(\"district\").value;\r\n");
      out.write("	var vid3 = document.getElementById(\"county\").value;\r\n");
      out.write("	window.location.replace(\"StationMaint.jsp?value1=\"+vid1+\"&&value2=\"+vid2+\"&&value3=\"+vid3);\r\n");
      out.write("	}\r\n");
      out.write("\r\n");
      out.write("function getStation(){\r\n");
      out.write("	var vid1 = document.getElementById(\"state\").value;\r\n");
      out.write("	var vid2 = document.getElementById(\"district\").value;\r\n");
      out.write("	var vid3 = document.getElementById(\"county\").value;\r\n");
      out.write("	var vid4 = document.getElementById(\"location\").value;\r\n");
      out.write("window.location.replace(\"StationMaint.jsp?value1=\"+vid1+\"&&value2=\"+vid2+\"&&value3=\"+vid3+\"&&value4=\"+vid4);\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("function search(){\r\n");
      out.write("	var vid1 = document.getElementById(\"txtSearch\").value;\r\n");
      out.write("	window.location.replace(\"StationMaint.jsp?search=\"+vid1);\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\r\n");


locationDao location = new locationDao();

String value1=request.getParameter("value1");
String value2=request.getParameter("value2");
String value3=request.getParameter("value3");
String value4=request.getParameter("value4");
String search=request.getParameter("txtSearch");
if (search==null){search="0";}

if (!search.equalsIgnoreCase("0")){
	obj.setLocation_id(Integer.parseInt(search));
	locationDao loc = new locationDao();
	loc.searchLocation(obj);
	int Location_id=obj.getLocation_id();
	String Lname=obj.getLname();
		value1=String.valueOf(obj.getStateid());
		value2=String.valueOf(obj.getDistrict_id());
		value3=String.valueOf(obj.getCounty_id());
		value4=String.valueOf(obj.getLocation_id());
	}

String mid=request.getParameter("mid");
if (mid != null){	

      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("	alert('Sending Message');\r\n");
      out.write("</script>\r\n");

locationDao updateLoc = new locationDao();
//updateLoc.SendMaintCmd(Integer.parseInt(value4),Integer.parseInt(mid));
}


if (value1==null){value1="0";}
if (value2==null){value2="0";}
if (value3==null){value3="0";}
if (value4==null){value4="0";}
if (search==null){search="0";}

mid="";


      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<link href=\"../styles/text.css\" rel=\"stylesheet\" type=\"text/css\">\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<form action=\"StationMaint.jsp\" method=\"post\" name=\"frmrSearch\" >\r\n");
      out.write("\r\n");
      out.write("<table  Style=\"width:100%;\">\r\n");
      out.write("<tr><td width=\"10%\" VALIGN=TOP>\r\n");
      out.write("	<table class=\"border\">\r\n");
      out.write("		<tr><td class=\"Blue-content\" colspan=\"6\" align=\"left\">Select Station</td></tr>\r\n");
      out.write("		<tr><td class=\"content style1\"><b> ID </b></td><td><input type=text id=txtSearch name=txtSearch  class=\"content style1\" value=\"");
      out.print(search);
      out.write("\" size=\"5\">\r\n");
      out.write("		<button type=\"submit\" class=\"button-image\" id=\"act\" name=\"act\" value=\"Find\"> <img src=\"../images/icon_search.png\"  height=\"20\" width=\"20\" alt=\"Search\" /></button>\r\n");
      out.write("		</tr>\r\n");
      out.write("\r\n");
      out.write("		<tr><td class=\"content style1\"><b> State </b></td>\r\n");
      out.write("			<td>\r\n");
      out.write("				<select id=\"state\" onchange=\"getDistrict()\" class=\"content style1\">\r\n");
      out.write("				<option value=\"0\">--Please Select--</option>\r\n");
      out.write("					");
 
					List<locationBean> list1 =location.viewStates();
					Iterator<locationBean> S = list1.iterator(); 
					while (S.hasNext()) {
					obj = (locationBean)S.next();
					
      out.write("\r\n");
      out.write("					<option value=\"");
      out.print(obj.getStateid());
      out.write('"');
      out.write('>');
      out.print(obj.getSname());
      out.write("</option>\r\n");
      out.write("					");
 if(obj.getStateid()==Integer.parseInt(value1)){
      out.write("\r\n");
      out.write("					<option value=\"");
      out.print(value1);
      out.write("\" selected >");
      out.print(obj.getSname());
      out.write("</option> \r\n");
      out.write("					");
} 
							}
      out.write("\r\n");
      out.write("				</select>\r\n");
      out.write("			</td>\r\n");
      out.write("		</tr>\r\n");
      out.write("\r\n");
      out.write("		<tr><td class=\"content style1\"><b> District</b> </td>\r\n");
      out.write("			<td>\r\n");
      out.write("				<select id=\"district\" onchange=\"getCounty()\" class=\"content style1\">\r\n");
      out.write("				<option value=\"0\">--Please Select--</option>\r\n");
      out.write("							");
 
							List<locationBean> list2 =location.viewDistrict(Integer.parseInt(value1));
							Iterator<locationBean> D = list2.iterator(); 
							while (D.hasNext()) {
							obj = (locationBean)D.next();
							
      out.write("\r\n");
      out.write("							<option value=\"");
      out.print(obj.getDistrict_id());
      out.write('"');
      out.write(' ');
      out.write('>');
      out.print(obj.getDname());
      out.write("</option>\r\n");
      out.write("							");
 if(obj.getDistrict_id()==Integer.parseInt(value2)){
      out.write("\r\n");
      out.write("							<option value=\"");
      out.print(value2);
      out.write("\" selected >");
      out.print(obj.getDname());
      out.write("</option>\r\n");
      out.write("							");
}
									}
      out.write("\r\n");
      out.write("				\r\n");
      out.write("				</select>\r\n");
      out.write("			</td>\r\n");
      out.write("		</tr>\r\n");
      out.write("\r\n");
      out.write("		<tr><td class=\"content style1\"><b>Mandal</b> </td>\r\n");
      out.write("			<td>\r\n");
      out.write("				<select id=\"county\" onchange=\"getLocations()\" class=\"content style1\">\r\n");
      out.write("				<option value=\"0\">--Please Select--</option>\r\n");
      out.write("				");

							List<locationBean> list3 =location.viewCounty(Integer.parseInt(value2));
							Iterator<locationBean> C = list3.iterator(); 
							while (C.hasNext()) {
								obj = (locationBean)C.next();
							
      out.write("\r\n");
      out.write("						<option value=\"");
      out.print(obj.getCounty_id());
      out.write('"');
      out.write(' ');
      out.write('>');
      out.print(obj.getCname());
      out.write("</option>\r\n");
      out.write("						");
 if(obj.getCounty_id()==Integer.parseInt(value3)){
      out.write("\r\n");
      out.write("						<option value=\"");
      out.print(value3);
      out.write("\" selected >");
      out.print(obj.getCname());
      out.write("</option>\r\n");
      out.write("						");
}
						}
      out.write("\r\n");
      out.write("				\r\n");
      out.write("				</select>\r\n");
      out.write("			</td>\r\n");
      out.write("		</tr>\r\n");
      out.write("\r\n");
      out.write("		<tr><td class=\"content style1\"><b> Stations</b> </td>\r\n");
      out.write("			<td>\r\n");
      out.write("				<select id=\"location\" onchange=\"getStation()\" class=\"content style1\" size=\"20\">\r\n");
      out.write("					<option value=\"0\">--Please Select--</option>\r\n");
      out.write("					");

							List<locationBean> list4;		
							if(value3.equalsIgnoreCase("0")) {
								list4 =location.viewStations(Integer.parseInt(value1),Integer.parseInt(value2));
								}
							else{
								list4 =location.viewStations(Integer.parseInt(value1),Integer.parseInt(value2),Integer.parseInt(value3));
								}	
								Iterator<locationBean> V = list4.iterator(); 
								while (V.hasNext()) {
									obj = (locationBean)V.next();
								
      out.write("\r\n");
      out.write("							<option value=\"");
      out.print(obj.getLocation_id());
      out.write('"');
      out.write(' ');
      out.write('>');
      out.print(obj.getLname());
      out.write("</option>\r\n");
      out.write("							");
 if(obj.getLocation_id()==Integer.parseInt(value4)){
      out.write("\r\n");
      out.write("							<option value=\"");
      out.print(value3);
      out.write("\" selected >");
      out.print(obj.getLname());
      out.write("</option>\r\n");
      out.write("							");
}
							}
      out.write("\r\n");
      out.write("					\r\n");
      out.write("				</select>\r\n");
      out.write("			</td>\r\n");
      out.write("		</tr>\r\n");
      out.write("	</table>\r\n");
      out.write("	</td>\r\n");
      out.write("\r\n");
      out.write("	");

	if (!value4.equalsIgnoreCase("0")){
		obj.setLocation_id(Integer.parseInt(value4));
		locationDao loc = new locationDao();
		loc.searchLocation(obj);
	
      out.write("\r\n");
      out.write("  <td width=\"80%\" VALIGN=TOP>\r\n");
      out.write("		<table    Style=\"width:100%;\">\r\n");
      out.write("				<tr><td class=\"Blue-content\">ID</td><td><input type=text  class=\"readonly\" name=\"value4\" size=\"7\" value=\"");
      out.print(obj.getLocation_id());
      out.write("\"></td>\r\n");
      out.write("					<td class=\"Blue-content\">District</td><td class=\"readonly\">");
      out.print(obj.getDname());
      out.write("</td>\r\n");
      out.write("					<td class=\"Blue-content\">Mandal</td><td class=\"readonly\">");
      out.print(obj.getCname());
      out.write("</td>\r\n");
      out.write("				</tr>\r\n");
      out.write("				<tr><td class=\"Blue-content\">Location</td><td class=\"readonly\">");
      out.print(obj.getLname());
      out.write("</td>	\r\n");
      out.write("					<td class=\"Blue-content\">Station SIM #</td><td class=\"readonly\">");
      out.print(obj.getStn_sim());
      out.write("</td>\r\n");
      out.write("					<td class=\"Blue-content\">Server SIM</td><td class=\"readonly\">");
      out.print(obj.getSrv_sim());
      out.write("</td>\r\n");
      out.write("				</tr>\r\n");
      out.write("				<tr><td class=\"Blue-content\">Contact Person</td><td class=\"readonly\">");
      out.print(obj.getCname());
      out.write("</td>\r\n");
      out.write("					<td class=\"Blue-content\">Email</td><td class=\"readonly\">");
      out.print(obj.getCemail());
      out.write("</td>\r\n");
      out.write("					<td class=\"Blue-content\">Last Reported</td><td class=\"readonly\" >");
      out.print(obj.getLsignal());
      out.write("</td>\r\n");
      out.write("				</tr>\r\n");
      out.write("		</table>\r\n");

} 
if (!"0".equalsIgnoreCase(value4)){
	
      out.write("\r\n");
      out.write("<table   class=border Style=\"width:100%;\">\r\n");
      out.write("	<tr class=\"Blue-content\"><td>ID</td><td>Task</td><td>Command</td><td>Send<br>SMS</td></tr>\r\n");
 
locationDao cmd = new locationDao();
List<locationBean> cmdlist =cmd.getMaintCmd();
Iterator<locationBean> CL = cmdlist.iterator(); 

while (CL.hasNext()) {
obj = (locationBean)CL.next();

      out.write("\r\n");
      out.write("	<tr class=\"readonly\">\r\n");
      out.write("			<td>");
      out.print(obj.getCmd_id());
      out.write("</td><td>");
      out.print(obj.getCmd_desc());
      out.write("</td><td>");
      out.print(obj.getCmd());
      out.write("</td>\r\n");
      out.write("			<td><button type=\"submit\" class=\"button-image\" id=\"mid\" name=\"mid\" value=\"");
      out.print(obj.getCmd_id());
      out.write("\" > <img src=\"../images/icon_send.png\"  height=\"20\" width=\"20\" alt=\"Cancel\" /></button>\r\n");
      out.write("			</td>\r\n");
      out.write("		</tr>\r\n");
      out.write("	\r\n");
} 
      out.write("\r\n");
      out.write("	<tr><td colspan=\"2\" align=\"center\"><a href=\"commlog.jsp?v1=");
      out.print(value4);
      out.write("\" target=\"_blank\" class=\"Blue-content\">Communication Log</a></td>\r\n");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("</table>\r\n");
      out.write("</td></tr>\r\n");
      out.write("\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("</form>\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
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
