/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.91
 * Generated at: 2024-10-17 07:05:30 UTC
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
import com.jobsDao;
import com.jobsBean;

public final class jobs_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_imports_classes.add("com.jobsDao");
    _jspx_imports_classes.add("com.jobsBean");
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
      com.jobsBean obj = null;
      obj = (com.jobsBean) _jspx_page_context.getAttribute("obj", javax.servlet.jsp.PageContext.PAGE_SCOPE);
      if (obj == null){
        obj = new com.jobsBean();
        _jspx_page_context.setAttribute("obj", obj, javax.servlet.jsp.PageContext.PAGE_SCOPE);
      }
      out.write('\r');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.introspect(_jspx_page_context.findAttribute("obj"), request);
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

								
			String ndate=request.getParameter("ndate");
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			String formattedDate = df.format(new java.util.Date());
			//out.println(formattedDate);

			if(ndate == null){ ndate=formattedDate;	 
			}
			

			int	urec=0;
			
			String jobid =request.getParameter("txtJobid");
	 		String act = request.getParameter("act");
			String jname = request.getParameter("txtName");
			String jinterval = request.getParameter("txtInterval");
			String cmbinterval = request.getParameter("cmbInterval");
			String sqlcode = request.getParameter("txtSqlcode");
			String broken = request.getParameter("cmbEnable");
				

      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<link href=\"../styles/text.css\" rel=\"stylesheet\" type=\"text/css\">\r\n");
      out.write("<script type=\"text/javascript\" src=\"../Script/datepicker.js\"></script>\r\n");
      out.write("<BODY bgcolor=\"#DBEBFF\">\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
 	if ("Edit".equalsIgnoreCase(act) ) { 
      out.write("\r\n");
      out.write("<form action=\"jobs.jsp\" method=\"post\" name=\"frmedit\" >\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellpadding=\"1\" >\r\n");
      out.write("	<tr>\r\n");
      out.write("			<td  align=\"right\" colspan=\"2\">\r\n");
      out.write("			<button type=\"submit\" class=\"button-image\" name=\"act\" value=\"Update\"> <img src=\"../images/icon_save.png\"  height=\"30\" width=\"30\" alt=\"Update\" /></button>\r\n");
      out.write("			<button type=\"submit\" class=\"button-image\" name=\"act\" value=\"Cancel\"> <img src=\"../images/icon_home.png\"  height=\"30\" width=\"30\" alt=\"Cancel\" /></button>\r\n");
      out.write("			</td>\r\n");
      out.write("	</tr>\r\n");
      out.write("	");
 if ((jobid == null)){
      out.write("\r\n");
      out.write("		<script>\r\n");
      out.write("		alert(\"no record selected!\");\r\n");
      out.write("		 history.go(-1);\r\n");
      out.write("		</script>\r\n");
      out.write("	");
 } else{
		obj.setJobid(Integer.parseInt(jobid));
		jobsDao job = new jobsDao();
		job.getJob(obj); 
		
      out.write(" \r\n");
      out.write("<tr> <td colspan=\"2\" align=\"Center\" class=\"maintitle\">");
      out.print(act);
      out.write(" Job</td><tr> \r\n");
      out.write("	<tr><td class=\"Blue-content\">Job ID</td><td><input type=\"text\" readonly name=\"txtJobid\" class=\"content style1\" size=\"1\" value=\"");
      out.print(obj.getJobid());
      out.write("\" ></td></tr>\r\n");
      out.write("	<tr><td class=\"Blue-content\">Name</td><td><input type=\"text\" name=\"txtName\" class=\"content style1\" size=\"50\" value=\"");
      out.print(obj.getName());
      out.write("\"> </td></tr>\r\n");
      out.write("	<tr><td class=\"Blue-content\">Interval</td><td class=\"Blue-content\"><input type=\"text\" name=\"txtInterval\" class=\"content style1\" size=\"10\"  maxlength=\"20\" value=\"");
      out.print(obj.getInterval());
      out.write("\">Minutes</td></tr>\r\n");
      out.write("	<tr><td class=\"Blue-content\">Disabled Job</td>\r\n");
      out.write("	<td>\r\n");
      out.write("		<select id=\"cmbEnable\"  name=\"cmbEnable\"  class=\"content style1\">\r\n");
      out.write("			 <option value=\"N\">N</option> \r\n");
      out.write("			<option value=\"Y\">Y</option>\r\n");
      out.write("			");
 if(obj.getBroken().equalsIgnoreCase("N")){
      out.write("\r\n");
      out.write("					<option value=\"N\" selected >");
      out.print("N");
      out.write("</option>\r\n");
      out.write("					");
}
      out.write("\r\n");
      out.write("			");
 if(obj.getBroken().equalsIgnoreCase("Y")){
      out.write("\r\n");
      out.write("					<option value=\"Y\" selected >");
      out.print("Y");
      out.write("</option>\r\n");
      out.write("					");
}
      out.write("\r\n");
      out.write("			</select>\r\n");
      out.write("	</td>\r\n");
      out.write("	</tr>\r\n");
      out.write("	<tr><td class=\"Blue-content\">SQL Code</td><td> <TEXTAREA id=\"txtSqlcode\" Name=\"txtSqlcode\" class=\"content style1\" rows=\"4\" cols=\"50\" >");
      out.print(obj.getWhat());
      out.write("</TEXTAREA></td></tr>\r\n");
      out.write("	<tr><td class=\"Blue-content\">Last Run</td><td><input type=\"text\" readonly name=\"txtLastdate\" class=\"content style1\" size=\"25\" maxlength=\"100\" value=\"");
      out.print(obj.getLdate());
      out.write("\"> </td></tr>\r\n");
      out.write("	<tr><td class=\"Blue-content\">Next Run Date</td>\r\n");
      out.write("		");
 ndate=obj.getNdate(); 
      out.write("\r\n");
      out.write("		<td class=\"content style1\"><input id=\"ndate\" name=\"ndate\" class=\"content style1\" type=\"text\" size=\"10\" maxlength=\"12\" value=");
      out.print(ndate);
      out.write(">\r\n");
      out.write("		<a href=\"javascript:NewCal('ndate','ddmmyyyy',false)\"><img src=\"../images/calendar.JPG\" width=\"16\" height=\"16\" border=\"0\" alt=\"Pick a date\"></a>\r\n");
      out.write("		<input type=\"text\" name=\"txtHrs\" class=\"content style1\" size=\"2\"  maxlength=\"2\" value=\"");
      out.print(obj.getNhour());
      out.write("\">:\r\n");
      out.write("		<input type=\"text\" name=\"txtMin\" class=\"content style1\" size=\"2\"  maxlength=\"2\" value=\"");
      out.print(obj.getNmin());
      out.write("\"> Hrs\r\n");
      out.write("</td></tr>\r\n");
      out.write("	\r\n");
      out.write("	");
 } 
      out.write("\r\n");
      out.write("</table>\r\n");
      out.write("</form>\r\n");
      out.write("	\r\n");
 } else if ("Add".equalsIgnoreCase(act) ) { 
      out.write("\r\n");
      out.write("<form action=\"jobs.jsp\" method=\"post\" name=\"frmadd\" >\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellpadding=\"1\" >\r\n");
      out.write("<tr>\r\n");
      out.write("			<td  align=\"right\" colspan=\"2\">\r\n");
      out.write("			<button type=\"submit\" class=\"button-image\" name=\"act\" value=\"Insert\"> <img src=\"../images/icon_save.png\"  height=\"30\" width=\"30\" alt=\"Add\" /></button>\r\n");
      out.write("			<button type=\"submit\" class=\"button-image\" name=\"act\" value=\"Cancel\"> <img src=\"../images/icon_home.png\"  height=\"30\" width=\"30\" alt=\"Home\" /></button>\r\n");
      out.write("			</td>\r\n");
      out.write("</tr>\r\n");
      out.write("\r\n");
      out.write("<tr> <td colspan=\"2\" align=\"Center\" class=\"maintitle\">");
      out.print(act);
      out.write(" Job</td><tr> \r\n");
      out.write("<tr><td class=\"Blue-content\">Name</td><td><input type=\"text\" name=\"txtName\" class=\"content style1\" size=\"30\"  maxlength=\"50\" > </td></tr>\r\n");
      out.write("<tr>\r\n");
      out.write("	<td class=\"Blue-content\">Interval</td>\r\n");
      out.write("	<td><input type=\"text\" name=\"txtInterval\" class=\"content style1\" size=\"3\"  maxlength=\"5\" value=\"0\">\r\n");
      out.write("	 \r\n");
      out.write("		<select id=\"cmbInterval\" name=\"cmbInterval\"  class=\"content style1\">\r\n");
      out.write("			<option value=\"Minutes\">Minutes</option>\r\n");
      out.write("			<option value=\"Hours\">Hours</option>\r\n");
      out.write("			<option value=\"Days\">Days</option>\r\n");
      out.write("		</select> </td>\r\n");
      out.write("	</tr>\r\n");
      out.write("<tr><td class=\"Blue-content\">Next Run Date</td>\r\n");
      out.write("		<td class=\"content style1\"><input id=\"ndate\" name=\"ndate\" class=\"content style1\" type=\"text\" size=\"10\" maxlength=\"12\" value=");
      out.print(ndate);
      out.write(">\r\n");
      out.write("		<a href=\"javascript:NewCal('ndate','ddmmyyyy',false)\"><img src=\"../images/calendar.JPG\" width=\"16\" height=\"16\" border=\"0\" alt=\"Pick a date\"></a>\r\n");
      out.write("		<input type=\"text\" name=\"txtHrs\" class=\"content style1\" size=\"2\"  maxlength=\"2\" value=\"00\">:\r\n");
      out.write("		<input type=\"text\" name=\"txtMin\" class=\"content style1\" size=\"2\"  maxlength=\"2\" value=\"00\"> Hrs\r\n");
      out.write("</td></tr>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<tr><td class=\"Blue-content\">Disabled</td>\r\n");
      out.write("<td><select id=\"cmbEnable\" name=\"cmbEnable\"  class=\"content style1\">\r\n");
      out.write("			<option value=\"N\">N</option>\r\n");
      out.write("			<option value=\"Y\">Y</option>\r\n");
      out.write("		</select> </td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr><td class=\"Blue-content\">SQL Code</td><td> <TEXTAREA id = \"txtSqlcode\" Name=\"txtSqlcode\" class=\"content style1\" rows=\"4\" cols=\"50\" ></TEXTAREA></td></tr>\r\n");
      out.write("</table>\r\n");
      out.write("</form>\r\n");
 } else if (act==null || ("Update".equalsIgnoreCase(act))||("Cancel".equalsIgnoreCase(act))||("Insert".equalsIgnoreCase(act))||("Delete".equalsIgnoreCase(act))) 
	{
	
	if ("Update".equalsIgnoreCase(act)){
		
		obj.setJobid(Integer.parseInt(jobid));
		obj.setName(jname);
		obj.setInterval(Integer.parseInt(jinterval));
		//obj.setInterval_param(cmbinterval);
		obj.setBroken(broken);
		obj.setWhat(sqlcode);
		obj.setNdate(request.getParameter("ndate")+" "+request.getParameter("txtHrs")+":"+request.getParameter("txtMin"));
		jobsDao job = new jobsDao();
		job.updateJob(obj);
	}

	if ("Insert".equalsIgnoreCase(act)){ 
      out.write("\r\n");
      out.write("		\r\n");
      out.write("		");
if ((jname.equalsIgnoreCase(""))||(sqlcode.equalsIgnoreCase(""))){ 
      out.write("\r\n");
      out.write("		<script>\r\n");
      out.write("		alert(\"Enter job name and query!\");\r\n");
      out.write("		 history.go(-1);\r\n");
      out.write("		</script>\r\n");
      out.write("		");
}else { 
			obj.setName(jname);
			obj.setInterval(Integer.parseInt(jinterval));
			obj.setInterval_param(cmbinterval);
			obj.setWhat(sqlcode);
			obj.setBroken(broken);
			obj.setNdate(request.getParameter("ndate")+" "+request.getParameter("txtHrs")+":"+request.getParameter("txtMin"));
			jobsDao job = new jobsDao();
			job.addjob(obj);
			}
		}
	
	if ("Delete".equalsIgnoreCase(act)){ 
      out.write('\r');
      out.write('\n');
      out.write('	');
 if ((jobid == null)){
      out.write("\r\n");
      out.write("	<script>\r\n");
      out.write("	alert(\"no record selected!\");\r\n");
      out.write("	 history.go(-1);\r\n");
      out.write("	</script>\r\n");
      out.write("	");
} else {
			jobsDao job = new jobsDao();
			job.delete(Integer.parseInt(jobid));
		}
	}
	
	
act=""; 
      out.write("\r\n");
      out.write("<form action=\"jobs.jsp\" method=\"post\" name=\"frmeDisplay\" >\r\n");
      out.write("<table width=\"100%\" border=\"0\"  >\r\n");
      out.write("<tr>\r\n");
      out.write("			<td  align=\"right\">\r\n");
      out.write("			<button type=\"submit\" class=\"button-image\" name=\"act\" value=\"Add\"> <img src=\"../images/icon_add.png\"  height=\"30\" width=\"30\" alt=\"Add\" /></button>\r\n");
      out.write("			<button type=\"submit\" class=\"button-image\" name=\"act\" value=\"Edit\"> <img src=\"../images/icon_edit.png\"  height=\"30\" width=\"30\" alt=\"Edit\" /></button>\r\n");
      out.write("			<button type=\"submit\" class=\"button-image\" name=\"act\" value=\"Delete\"> <img src=\"../images/icon_delete.png\"  height=\"30\" width=\"30\" alt=\"Delete\" /></button>\r\n");
      out.write("			</td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr> <td colspan=\"9\" align=\"Center\" class=\"Headings\">Jobs List</td><tr>\r\n");
      out.write("<tr><td>\r\n");
      out.write("	<table width=\"100%\" border=\"1\" class=\"queue-summary\" >\r\n");
      out.write("		<tr class=\"Blue-content\" align=\"center\"><td >ID</td><td>Job Name</td>\r\n");
      out.write("		<td>Interval(Minutes)</td><td>Next Run</td><td>Last Run</td><td>Broken?</td><td>SQL Code</td>\r\n");
      out.write("		<td>Added Date</td>\r\n");
      out.write("		<td>Select</td></tr>\r\n");
      out.write("		\r\n");
      out.write("		");
 jobsDao job = new jobsDao();
			List<jobsBean> list =job.viewAlljobs();
			Iterator<jobsBean> i = list.iterator();
			int x =0;
			while (i.hasNext())	{
				x++;
				obj = (jobsBean)i.next();
				if ( (x%2) == 0 ) { 
      out.write("\r\n");
      out.write("			<tr class=\"oddline\" > ");
} else { 
      out.write("<tr class=\"evenline\" >  ");
}
      out.write("\r\n");
      out.write("			<tr class=\"content style1\" align=\"center\"> \r\n");
      out.write("		<td>");
      out.print(x);
      out.write("</td><td>");
      out.print(obj.getName());
      out.write("</td><td align=\"center\">");
      out.print(obj.getInterval());
      out.write("</td><td>");
      out.print(obj.getNdate());
      out.write("</td>\r\n");
      out.write("		\r\n");
      out.write("		");
if (obj.getLdate()==null){ 
      out.write("<td>-</td>");
} else{ 
      out.write(" <td>");
      out.print(obj.getLdate());
      out.write("</td>");
} 
      out.write("\r\n");
      out.write("		\r\n");
      out.write("		<td align=\"center\">");
      out.print(obj.getBroken());
      out.write("</td><td>");
      out.print(obj.getWhat());
      out.write("</td>\r\n");
      out.write("		<td>");
      out.print(obj.getIdate());
      out.write("</td>\r\n");
      out.write("		<td><input type=\"radio\" name=\"txtJobid\" value=");
      out.print(obj.getJobid());
      out.write("></td>\r\n");
      out.write("		</tr>\r\n");
      out.write("		");
 }
			if(x==0)  {	/*To write to the server if the resultset is null*/
		
      out.write("\r\n");
      out.write("				<tr><th colspan=6 class=\"content style1\">No jobs found</th></tr>		\r\n");
      out.write("		");
} 
      out.write("\r\n");
      out.write("		\r\n");
      out.write("		 ");
 } 
		
		
      out.write("\r\n");
      out.write("		</table>\r\n");
      out.write("</tr>\r\n");
      out.write("</table>\r\n");
      out.write("</form>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
      out.write("\r\n");
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
