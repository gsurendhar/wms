/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.91
 * Generated at: 2024-12-02 04:19:51 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.text.*;
import java.util.*;
import com.orgDao;
import com.locationDao;
import com.locationBean;

public final class orgprofile_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(7);
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("java.text");
    _jspx_imports_packages.add("java.util");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.LinkedHashSet<>(4);
    _jspx_imports_classes.add("com.locationDao");
    _jspx_imports_classes.add("com.locationBean");
    _jspx_imports_classes.add("com.orgDao");
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

      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      com.orgBean obj = null;
      obj = (com.orgBean) _jspx_page_context.getAttribute("obj", javax.servlet.jsp.PageContext.PAGE_SCOPE);
      if (obj == null){
        obj = new com.orgBean();
        _jspx_page_context.setAttribute("obj", obj, javax.servlet.jsp.PageContext.PAGE_SCOPE);
      }
      out.write('\r');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.introspect(_jspx_page_context.findAttribute("obj"), request);
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      com.locationBean objL = null;
      objL = (com.locationBean) _jspx_page_context.getAttribute("objL", javax.servlet.jsp.PageContext.PAGE_SCOPE);
      if (objL == null){
        objL = new com.locationBean();
        _jspx_page_context.setAttribute("objL", objL, javax.servlet.jsp.PageContext.PAGE_SCOPE);
      }
      out.write('\r');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.introspect(_jspx_page_context.findAttribute("objL"), request);
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

//Sesssion Management
if(null == session.getAttribute("theName")){  
 response.sendRedirect("timeout.jsp");
}

String act=request.getParameter("act");
Integer oid	= (Integer) session.getAttribute("theOid");

locationDao location = new locationDao();


if ("Update".equalsIgnoreCase(act)){
	obj.setOid((Integer) session.getAttribute("theOid"));
	obj.setName(request.getParameter("txtorg"));
	obj.setAddress1(request.getParameter("txtaddr1"));
	obj.setAddress2(request.getParameter("txtaddr2"));
	obj.setCity(request.getParameter("txtcity"));
	obj.setEmail(request.getParameter("txtemail"));
	obj.setEmail(request.getParameter("txtemail"));
	obj.setDstateid(Integer.parseInt(request.getParameter("cmbstate")));
	orgDao org = new orgDao();
	org.update(obj);
	}

      out.write("\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<link href=\"../styles/text.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n");
      out.write("<script language=\"javascript\">\r\n");
      out.write("			function validate(objForm){\r\n");
      out.write("				\r\n");
      out.write("				if(objForm.txtorg.value.length==0){\r\n");
      out.write("					alert(\"Please enter  Organization Name!\");\r\n");
      out.write("					objForm.txtorg.focus();\r\n");
      out.write("					return false;\r\n");
      out.write("				}\r\n");
      out.write("				\r\n");
      out.write("				if(objForm.txtaddr.value.length==0){\r\n");
      out.write("					alert(\"Please enter Address !\");\r\n");
      out.write("					objForm.txtaddr.focus();\r\n");
      out.write("					return false;\r\n");
      out.write("				}\r\n");
      out.write("				if(objForm.txtemail.value.length==0){\r\n");
      out.write("					alert(\"Please enter Email address !\");\r\n");
      out.write("					objForm.txtaddr.focus();\r\n");
      out.write("					return false;\r\n");
      out.write("				}\r\n");
      out.write("				return true;\r\n");
      out.write("			}\r\n");
      out.write("</script>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\r\n");
      out.write("<form name=\"frmorg\" action=\"orgprofile.jsp\" method=\"post\">\r\n");
      out.write("<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"stretch\"> \r\n");
      out.write("<tr>\r\n");
      out.write("			<td  align=\"right\" colspan=\"2\">\r\n");
      out.write("			<button type=\"submit\" class=\"button-image\" name=\"act\" value=\"Update\"> <img src=\"../images/icon_save.png\"  height=\"30\" width=\"30\" alt=\"Add\" /></button>\r\n");
      out.write("			<!-- <button type=\"submit\" class=\"button-image\" name=\"act\" value=\"Edit\"> <img src=\"../images/icon_edit.png\"  height=\"30\" width=\"30\" alt=\"Add\" /></button>\r\n");
      out.write("			<button type=\"submit\" class=\"button-image\" name=\"act\" value=refresh> <img src=\"../images/icon_refresh.png\"  height=\"30\" width=\"30\" alt=\"reset\" /></button> -->\r\n");
      out.write("			</td>\r\n");
      out.write("</tr>\r\n");
      out.write("<tr><td class=\"Blue-content\">Organization Details</td></tr>\r\n");
      out.write("	");

	
	obj.setOid(oid);	
	orgDao org = new orgDao();
	org.findOrg(obj);
					
	 
      out.write("\r\n");
      out.write("	<tr><td class=\"label\">Name:</td><td><input class=\"content style1\" type=text name=txtorg size=\"30\"  maxlength=\"50\" value=\"");
      out.print(obj.getName());
      out.write("\" /></td></tr>\r\n");
      out.write("	<tr><td class=\"label\">Address1:</td><td><input class=\"content style1\" type=text name=txtaddr1 size=\"30\"  maxlength=\"50\" value=\"");
      out.print(obj.getAddress1());
      out.write("\" /></td></tr>\r\n");
      out.write("	<tr><td class=\"label\">Address2:</td><td><input class=\"content style1\" type=text name=txtaddr2 size=\"30\"  maxlength=\"50\" value=\"");
      out.print(obj.getAddress2());
      out.write("\" /></td></tr>\r\n");
      out.write("	<tr><td class=\"label\">City:</td><td><input class=\"content style1\" type=text name=txtcity size=\"30\"  maxlength=\"50\" value=\"");
      out.print(obj.getCity());
      out.write("\" /></td></tr>\r\n");
      out.write("	<tr><td class=\"label\">Email:</td><td><input class=\"content style1\" type=text name=txtemail size=\"30\"  maxlength=\"50\" value=\"");
      out.print(obj.getEmail());
      out.write("\" /></td></tr>\r\n");
      out.write("	<tr><td class=\"label\">Default State for Site:</td>\r\n");
      out.write("	<td>\r\n");
      out.write("		<select id=\"state\" name=cmbstate  class=\"content style1\">\r\n");
      out.write("			<option value=\"0\">--Please Select--</option>\r\n");
      out.write("			");
 
			List<locationBean> list1 =location.viewStates();
			Iterator<locationBean> S = list1.iterator(); 
			while (S.hasNext()) {
			objL = (locationBean)S.next();
			
      out.write("\r\n");
      out.write("			<option value=\"");
      out.print(objL.getStateid());
      out.write('"');
      out.write('>');
      out.print(objL.getSname());
      out.write("</option>\r\n");
      out.write("			");
 if(objL.getStateid()==obj.getDstateid()){
      out.write("\r\n");
      out.write("			<option value=\"");
      out.print(obj.getDstateid());
      out.write("\" selected >");
      out.print(objL.getSname());
      out.write("</option> \r\n");
      out.write("			");
			}	 
				}
      out.write("\r\n");
      out.write("			</select> </td>\r\n");
      out.write("</tr>\r\n");
      out.write("\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</form>\r\n");
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
