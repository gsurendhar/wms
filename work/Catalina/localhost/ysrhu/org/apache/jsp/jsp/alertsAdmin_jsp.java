/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.91
 * Generated at: 2024-10-17 07:05:14 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import java.sql.*;
import com. ConnectionProvider;

public final class alertsAdmin_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {


Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(7);
    _jspx_imports_packages.add("java.sql");
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("java.util");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.LinkedHashSet<>(2);
    _jspx_imports_classes.add("com. ConnectionProvider");
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
      out.write(" \r\n");
      out.write('\r');
      out.write('\n');

con =  ConnectionProvider.getCon();
stmt=con.createStatement();

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!-- Sesssion Management -->\r\n");
if(null == session.getAttribute("theName")){  
  // User is not logged in.
  out.println("your Session has expired");
  response.sendRedirect("../index.html?invalid=0");
}

      out.write("\r\n");
      out.write("<!-- End of Sesssion Management -->\r\n");

	String act = request.getParameter("act"); 
	String vID = request.getParameter("txtID");
	String vmin = request.getParameter("txtmin");
	String vmax = request.getParameter("txtmax");
	String valert = request.getParameter("chkAlert");
	String verror = request.getParameter("chkError");

	
	Integer oid	= (Integer) session.getAttribute("theOid");
 
      out.write("\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<link href=\"../styles/text.css\" rel=\"stylesheet\" type=\"text/css\">\r\n");
      out.write("\r\n");
      out.write("<title> Alert Management </title>\r\n");
      out.write("<script>\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");

Integer vid=0;
int DisRow=0;

if ("Add".equalsIgnoreCase(act)){ 
      out.write("\r\n");
      out.write("<form name=\"FrmAddList\" action=\"alertsAdmin.jsp\" method=\"post\">\r\n");
      out.write("<table class=\"mytable\" >\r\n");
      out.write("	<tr>\r\n");
      out.write("			<td align=\"right\" colspan=\"7\">\r\n");
      out.write("			<button type=\"submit\" class=\"button-image\" id=\"act\" name=\"act\" value=\"AddP\"> <img src=\"../images/icon_save.png\"  height=\"30\" width=\"30\" alt=\"Add\" /></button>  \r\n");
      out.write("			<button type=\"submit\" class=\"button-image\" id=\"act\" name=\"act\" value=\"DeleteP\"> <img src=\"../images/icon_delete.png\"  height=\"30\" width=\"30\" alt=\"Cancel\" /></button> \r\n");
      out.write("			</td>\r\n");
      out.write("	</tr>\r\n");
      out.write("</table>\r\n");
      out.write("<table class=\"mytable\">\r\n");
      out.write("<tr valign=\"top\"> \r\n");
      out.write("<td class=\"boxcontainer\">\r\n");
      out.write("<div class=\"\">\r\n");
      out.write("  <div class=\"titlebox\" id=\"\">\r\n");
      out.write("  <div class=\"titlebox-title\">\r\n");
      out.write("        <span class=\"left\">Add Alert Parameters</span>\r\n");
      out.write("  </div>\r\n");
      out.write("  <div class=\"titlebox-content \" id=\"t1\">\r\n");
      out.write("  <hr class=\"clear\" />\r\n");
      out.write("  <table class=\"ticket-list collection-as-table\">\r\n");
      out.write("  <tr class=\"collection-as-table\">\r\n");
      out.write("	<th class=\"collection-as-table\">ID</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Parameter</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Min Value</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Max	Value</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Alert</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Error</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Select</th>\r\n");
      out.write("</tr>\r\n");
      out.write("\r\n");
 rs=stmt.executeQuery("select * from alert_params where active!='Y' order by param");
	int x =0;
	while(rs.next()){
		x++;
				if ( (x%2) == 0 ) { 
      out.write("\r\n");
      out.write("<tr class=\"oddline\" > ");
} else { 
      out.write("<tr class=\"evenline\" >  ");
}
      out.write("\r\n");
      out.write("<td class=\"content style\">");
      out.print(x);
      out.write("</td>\r\n");
      out.write("\r\n");
      out.write("<td class=\"content style\">");
      out.print(rs.getString("Description"));
      out.write("</td>\r\n");
      out.write("<td class=\"content style\"><input type=\"text\" name=\"txtmin\" size=\"6\" maxlength=\"10\" value=\"");
      out.print(rs.getString("min_value"));
      out.write("\"></td>\r\n");
      out.write("<td class=\"content style\"><input type=\"text\" name=\"txtmax\" size=\"6\" maxlength=\"10\" value=\"");
      out.print(rs.getString("max_value"));
      out.write("\"></td>\r\n");
      out.write("<td><input type=\"checkbox\" name=\"chkAlert\"></td>\r\n");
      out.write("<td><input type=\"checkbox\"  name=\"chkError\"></td>\r\n");
      out.write("<td><input type=\"radio\" name=\"txtID\" value=");
      out.print(rs.getInt("id"));
      out.write("></td>\r\n");
      out.write("</tr>\r\n");
 } 
      out.write("\r\n");
      out.write("\r\n");
      out.write("</table>\r\n");
      out.write("</div>\r\n");
      out.write("</div>\r\n");
      out.write("</div>\r\n");
      out.write("</td>\r\n");
      out.write("</tr>\r\n");
      out.write("</table>\r\n");
      out.write("</form>\r\n");
      out.write("\r\n");
 } else if ("Edit".equalsIgnoreCase(act)){ 
      out.write("\r\n");
      out.write("<form name=\"FrmAddList\" action=\"alertsAdmin.jsp\" method=\"post\">\r\n");
      out.write("<table class=\"mytable\" >\r\n");
      out.write("	<tr>\r\n");
      out.write("			<td align=\"right\" colspan=\"7\">\r\n");
      out.write("			<button type=\"submit\" class=\"button-image\" id=\"act\" name=\"act\" value=\"AddP\"> <img src=\"../images/icon_save.png\"  height=\"30\" width=\"30\" alt=\"Add\" /></button>  \r\n");
      out.write("			<button type=\"submit\" class=\"button-image\" id=\"act\" name=\"act\" value=\"DeleteP\"> <img src=\"../images/icon_delete.png\"  height=\"30\" width=\"30\" alt=\"Cancel\" /></button> \r\n");
      out.write("			</td>\r\n");
      out.write("	</tr>\r\n");
      out.write("</table>\r\n");
      out.write("<table class=\"mytable\">\r\n");
      out.write("<tr valign=\"top\"> \r\n");
      out.write("<td class=\"boxcontainer\">\r\n");
      out.write("<div class=\"\">\r\n");
      out.write("  <div class=\"titlebox\" id=\"\">\r\n");
      out.write("  <div class=\"titlebox-title\">\r\n");
      out.write("        <span class=\"left\">Add Alert Parameters</span>\r\n");
      out.write("  </div>\r\n");
      out.write("  <div class=\"titlebox-content \" id=\"t1\">\r\n");
      out.write("  <hr class=\"clear\" />\r\n");
      out.write("  <table class=\"ticket-list collection-as-table\">\r\n");
      out.write("  <tr class=\"collection-as-table\">\r\n");
      out.write("	<th class=\"collection-as-table\">ID</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Parameter</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Min Value</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Max	Value</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Alert</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Error</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Select</th>\r\n");
      out.write("</tr>\r\n");
      out.write("\r\n");
 rs=stmt.executeQuery("select * from alert_params where id='"+vID+"'");
	int x =0;
	while(rs.next()){
		x++;
				if ( (x%2) == 0 ) { 
      out.write("\r\n");
      out.write("<tr class=\"oddline\" > ");
} else { 
      out.write("<tr class=\"evenline\" >  ");
}
      out.write("\r\n");
      out.write("<td class=\"content style\">");
      out.print(x);
      out.write("</td>\r\n");
      out.write("\r\n");
      out.write("<td class=\"content style\">");
      out.print(rs.getString("Description"));
      out.write("</td>\r\n");
      out.write("<td class=\"content style\"><input type=\"text\" name=\"txtmin\" size=\"6\" maxlength=\"10\" value=\"");
      out.print(rs.getString("min_value"));
      out.write("\"></td>\r\n");
      out.write("<td class=\"content style\"><input type=\"text\" name=\"txtmax\" size=\"6\" maxlength=\"10\" value=\"");
      out.print(rs.getString("max_value"));
      out.write("\"></td>\r\n");
      out.write("<td>\r\n");
if ("Y".equalsIgnoreCase(rs.getString("alert"))) { 
      out.write("\r\n");
      out.write("	<input type=\"checkbox\" name=\"chkAlert\" checked > ");
} else { 
      out.write(" <input type=\"checkbox\"  name=\"chkAlert\">");
} 
      out.write("\r\n");
      out.write("</td>\r\n");
      out.write("<td>\r\n");
if ("Y".equalsIgnoreCase(rs.getString("error"))) { 
      out.write("\r\n");
      out.write("	<input type=\"checkbox\" name=\"chkError\" checked > ");
} else { 
      out.write(" <input type=\"checkbox\"  name=\"chkError\">");
} 
      out.write("\r\n");
      out.write("</td>\r\n");
      out.write("<td><input type=\"radio\" name=\"txtID\" checked=\"checked\" value=");
      out.print(rs.getInt("id"));
      out.write("></td>\r\n");
      out.write("</tr>\r\n");
 } 
      out.write("\r\n");
      out.write("\r\n");
      out.write("</table>\r\n");
      out.write("</div>\r\n");
      out.write("</div>\r\n");
      out.write("</div>\r\n");
      out.write("</td>\r\n");
      out.write("</tr>\r\n");
      out.write("</table>\r\n");
      out.write("</form>\r\n");
} 
else if (act==null ||("DeleteP".equalsIgnoreCase(act)) ||("AddP".equalsIgnoreCase(act)) || 
("Update".equalsIgnoreCase(act)) || ("Cancel".equalsIgnoreCase(act))||("Insert".equalsIgnoreCase(act))||("Delete".equalsIgnoreCase(act))) 
	{  
			if ("AddP".equalsIgnoreCase(act)){
				if(vID==null){ 
      out.write("\r\n");
      out.write("				<script> alert(\"no Sensor selected!\"); \r\n");
      out.write("						history.go(-1);\r\n");
      out.write("				</script>\r\n");
      out.write("				");
 } else{	
				query="update alert_params set active='Y',min_value='"+vmin+"',max_value='"+vmax+"'";
				if ("on".equalsIgnoreCase(verror)){	query+=",error='Y'";}else {query+=",error='N'";}
				if ("on".equalsIgnoreCase(valert)){ query+=",alert='Y'";}else {query+=",alert='N'";}
					query+=" where id='"+vID+"'";
					//out.println(query);
					stmt.executeUpdate(query);
					}
				}
			if ("Update".equalsIgnoreCase(act)){
				query="update alert_params set min_value='"+vmin+"',max_value='"+vmax+"'";
				if ("on".equalsIgnoreCase(verror)){
					query+=",error='Y'";
				}
				else {query+=",error='N'";}
				if ("on".equalsIgnoreCase(valert)){
					query+=",alert='Y'";
				}
				else {query+=",alert='N'";}
				query+=" where id='"+vID+"'";
				//out.println(query);
				stmt.executeUpdate(query);
				}									
			
				if ("Insert".equalsIgnoreCase(act)){
				}
			if ("Delete".equalsIgnoreCase(act)){
					if(request.getParameter("txtID")==null){ 
      out.write("\r\n");
      out.write("						<script> alert(\"no record selected!\"); \r\n");
      out.write("								history.go(-1);\r\n");
      out.write("						</script>\r\n");
      out.write("			");
 } else{	
					query="update alert_params set active='N' where id='"+vID+"'";
			//out.println(query);
					stmt.executeUpdate(query);
					}
				}
act="";

      out.write("\r\n");
      out.write("\r\n");
      out.write("<form name=\"FrmUserList\" action=\"alertsAdmin.jsp\" method=\"post\">\r\n");
      out.write("<table class=\"mytable\" >\r\n");
      out.write("	<tr>\r\n");
      out.write("			<td align=\"right\" colspan=\"7\">\r\n");
      out.write("			<button type=\"submit\" class=\"button-image\" id=\"act\" name=\"act\" value=\"Add\"> <img src=\"../images/icon_add.png\"  height=\"30\" width=\"30\" alt=\"Add\" /></button>  \r\n");
      out.write("			<button type=\"submit\" class=\"button-image\" id=\"act\" name=\"act\" value=\"Edit\" > <img src=\"../images/icon_edit.png\"  height=\"30\" width=\"30\" alt=\"Edit\" /></button>\r\n");
      out.write("			<button type=\"submit\" class=\"button-image\" id=\"act\" name=\"act\" value=\"Delete\"> <img src=\"../images/icon_delete.png\"  height=\"30\" width=\"30\" alt=\"Delete\" /></button> \r\n");
      out.write("			</td>\r\n");
      out.write("	</tr>\r\n");
      out.write("</table>\r\n");
      out.write("<table class=\"mytable\">\r\n");
      out.write("<tr valign=\"top\"> \r\n");
      out.write("<td class=\"boxcontainer\">\r\n");
      out.write("<div class=\"\">\r\n");
      out.write("  <div class=\"titlebox\" id=\"\">\r\n");
      out.write("  <div class=\"titlebox-title\">\r\n");
      out.write("        <span class=\"left\">Alert List</span>\r\n");
      out.write("        \r\n");
      out.write("   \r\n");
      out.write("  </div>\r\n");
      out.write("  <div class=\"titlebox-content \" id=\"t1\">\r\n");
      out.write("  <hr class=\"clear\" />\r\n");
      out.write("  <table class=\"ticket-list collection-as-table\">\r\n");
      out.write("  <tr class=\"collection-as-table\">\r\n");
      out.write("	<th class=\"collection-as-table\">ID</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Parameter</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Min Value</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Max	Value</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Alert</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Error</th>\r\n");
      out.write("	<th class=\"collection-as-table\">Select</th>\r\n");
      out.write("</tr>\r\n");
      out.write("\r\n");
 rs=stmt.executeQuery("select * from alert_params where active='Y' order by param");
	int x =0;
	while(rs.next()){
		x++;
				if ( (x%2) == 0 ) { 
      out.write("\r\n");
      out.write("<tr class=\"oddline\" > ");
} else { 
      out.write("<tr class=\"evenline\" >  ");
}
      out.write("\r\n");
      out.write("<td class=\"content style\">");
      out.print(x);
      out.write("</td>\r\n");
      out.write("\r\n");
      out.write("<td class=\"content style\">");
      out.print(rs.getString("Description"));
      out.write("</td>\r\n");
      out.write("<td class=\"content style\"><input type=\"text\" name=\"txtmin\" size=\"6\" maxlength=\"10\" readonly value=\"");
      out.print(rs.getString("min_value"));
      out.write("\"></td>\r\n");
      out.write("<td class=\"content style\"><input type=\"text\" name=\"txtmax\" size=\"6\" maxlength=\"10\" readonly value=\"");
      out.print(rs.getString("max_value"));
      out.write("\"></td>\r\n");
      out.write("<td>\r\n");
if ("Y".equalsIgnoreCase(rs.getString("alert"))) { 
      out.write("\r\n");
      out.write("	<input type=\"checkbox\" name=\"chkAlert\" checked disabled> ");
} else { 
      out.write(" <input type=\"checkbox\" disabled name=\"chkAlert\">");
} 
      out.write("\r\n");
      out.write("</td>\r\n");
      out.write("<td>\r\n");
if ("Y".equalsIgnoreCase(rs.getString("error"))) { 
      out.write("\r\n");
      out.write("	<input type=\"checkbox\" name=\"chkError\" checked disabled> ");
} else { 
      out.write(" <input type=\"checkbox\" disabled name=\"chkError\">");
} 
      out.write("\r\n");
      out.write("</td>\r\n");
      out.write("<td><input type=\"radio\" name=\"txtID\" value=");
      out.print(rs.getInt("id"));
      out.write("></td>\r\n");
      out.write("</tr>\r\n");
}
      out.write("\r\n");
      out.write("\r\n");
      out.write("</table>\r\n");
      out.write("</div>\r\n");
      out.write("</div>\r\n");
      out.write("</div>\r\n");
      out.write("</td>\r\n");
      out.write("</tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("</form>\r\n");
} 
      out.write("\r\n");
      out.write("</body> \r\n");
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
