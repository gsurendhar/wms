/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.91
 * Generated at: 2024-10-05 11:22:26 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(4);
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
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
      response.setContentType("text/html; charset=ISO-8859-1");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=ISO-8859-1\">\r\n");
      out.write("		<title>Login Page</title>\r\n");
      out.write("\r\n");
      out.write("<link href=\"styles/text.css\" rel=\"stylesheet\" type=\"text/css\">\r\n");
      out.write("<!-- <style type=\"text/css\">\r\n");
      out.write("html,body {\r\n");
      out.write("       background-image: url(../images/topbanner.jpg);\r\n");
      out.write("       background-repeat: no-repeat;\r\n");
      out.write("        background-size: 100%;\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write("</style> -->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<style type=\"text/css\">\r\n");
      out.write("table.background { background: url(\"images/topbanner.jpg\") no-repeat; background-size: 100%; }\r\n");
      out.write("</style>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\r\n");
      out.write("<form action=\"loginprocess.jsp\" method=\"post\">\r\n");
      out.write("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"stretch\" class=\"background\"   style=\"width:100%;height:100px;\"> \r\n");
      out.write("	<tr><td valign=\"middle\" height=\"100%\"><img src=\"images/Logo.jpg\" width=\"100\" height=\"50\"></img></td>  \r\n");
      out.write("	<td align=\"right\" class=\"content\">\r\n");
      out.write("		<script type=\"text/javascript\">\r\n");
      out.write("			var currentTime = new Date()\r\n");
      out.write("			var month = currentTime.getMonth() + 1\r\n");
      out.write("			var day = currentTime.getDate()\r\n");
      out.write("			var year = currentTime.getFullYear()\r\n");
      out.write("			document.write(day + \"/\" + month + \"/\" + year)\r\n");
      out.write("		</script>\r\n");
      out.write("		</td>\r\n");
      out.write("		</tr>\r\n");
      out.write("<tr><td background=\"images/Logo_bottom.jpg\" scope=\"col\" colspan=2><img src=\"images/Logo_bottom.jpg\" width=\"3\" height=\"4\"/></td></tr>\r\n");
      out.write("	 \r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("<table width=\"390\"  align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("  <tr><th colspan=\"3\" scope=\"col\"><img src=\"images/top-login.jpg\" width=\"390\" height=\"40\"></th> </tr> \r\n");
      out.write("     <tr><th height=\"113\" colspan=\"3\"  background=\"images/mid.jpg\">\r\n");
      out.write("		<table width=\"80%\"  border=\"0\" cellspacing=\"2\" cellpadding=\"2\">\r\n");
      out.write("             <tr><th width=\"43%\" scope=\"col\">&nbsp;</th> <th width=\"57%\" scope=\"col\">&nbsp;</th> </tr>\r\n");
      out.write("             <tr><td align=\"right\" class=\"content\">User Name : </td><td><input id=uname name=\"uname\" type=\"text\" size=\"15\" tabindex=\"1\"></td> </tr>\r\n");
      out.write("             <tr><td align=\"right\" class=\"content\">Password : </td><td><input id=pass name=\"pass\" type=\"password\" size=\"15\" maxlength=\"10\" tabindex=\"1\"></td></tr>\r\n");
      out.write("             <tr align=\"center\"><td colspan=\"2\">&nbsp;</td></tr>\r\n");
      out.write("        </table></th>\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr>\r\n");
      out.write("           <td><img src=\"images/BLeft.jpg\" width=\"106\" height=\"41\"></td>\r\n");
      out.write("           <td><input type=\"image\" src=\"images/Submit.jpg\" name=\"submit\" value=\"login\" ></td>\r\n");
      out.write("           <td width=\"206\"><img src=\"images/BRight.jpg\" width=\"206\" height=\"41\"></td>\r\n");
      out.write("      </tr>\r\n");
      out.write("</table> \r\n");
      out.write("</form>\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
      out.write("\r\n");
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
