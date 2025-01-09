<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="wms.dbconnect.DBPostgres" %> 

    <%
	Connection con=null;
	ResultSet rst=null;
	Statement stmt=null;



    try{
        con = DBPostgres.getConnection();
		stmt=con.createStatement();
	}catch(Exception e){
			System.out.println(e.getMessage());
		  }

    if(request.getParameter("action") != null){  

	  String bookname=request.getParameter("bookname");
      String author=request.getParameter("author");
      
	  stmt.executeUpdate("insert into books_details(book_name,author) values('"+bookname+"','"+author+"')");
	  rst=stmt.executeQuery("select * from books_details");

      %>


	  
<html>
   <body>
   <center><h2>Books List</h2>
   <table border="1" cellspacing="0" cellpadding="0">
      
	  <tr><td><b>S.No</b></td><td><b>Book Name</b></td><td><b>Author</.b></td></tr>
	  <%
          int no=1;

			while(rst.next()){
	  
      %>

            <tr><td><%=no%></td><td><%=rst.getString("book_name")%></td><td><%=rst.getString("author")%></td></tr>

	  <%    
		    no++;
			}
      
             rst.close();
			 stmt.close();
			 con.close();
            
	      
			
		%>
		<tr>
   </table>
   </center>
   <body>
<html>
<%}else{%>

<html>
		<head>
		<title>Book Entry FormDocument</title>

         <script language="javascript">
			function validate(objForm){
				
				if(objForm.bookname.value.length==0){
					alert("Please enter  Book Name!");
					objForm.bookname.focus();
					return false;
				}
				
				if(objForm.author.value.length==0){
					alert("Please enter Author name!");
					objForm.author.focus();
					return false;
				}

				return true;
			}
          </script>

		</head>
		<body><center>
		<form action="BookEntryForm.jsp" method="post" name="entry" onSubmit="return validate(this)">
		<input type="hidden" value="list" name="action">
		<table border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<table>
						<tr><td colspan="2" align="center"><h2>Book Entry Form</h2></td></tr>
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr><td>Book Name:</td><td><input name="bookname" type="text" size="50"></td></tr>
						<tr><td>Author:</td><td><input name="author" type="text" size="50"></td></tr>
						<tr><td colspan="2" align="center"><input type="submit" value="Submit"></td></tr>
					</table>
				</td>
			</tr>
		</table>
		</form>
		</center>

		</body>
  </html>



<%}%>




