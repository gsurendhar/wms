<%@ page import="java.io.*" %>
<%@page import="java.sql.*,java.util.*,jxl. *, jxl.read.biff.BiffException"%> 

<%
String saveFile="";
Connection con = null; 
Statement pst = null; 
String line = null; 
String value = null;
String query = "";
Integer n = 0;

//Class.forName("oracle.jdbc.driver.OracleDriver"); 
// con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.213.27:1521:GDAT1","spboardv2","spboard#12"); 
// pst = con.createStatement(); 

        //to get the content type information from JSP Request Header
        String contentType = request.getContentType();
        //here we are checking the content type is not equal to Null and as well as the passed data from mulitpart/form-data is greater than or  equal to 0
        if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
                DataInputStream in = new DataInputStream(request.getInputStream());
                //we are taking the length of Content type data
                int formDataLength = request.getContentLength();
                byte dataBytes[] = new byte[formDataLength];
                int byteRead = 0;
                int totalBytesRead = 0;
                //this loop converting the uploaded file into byte code
                while (totalBytesRead < formDataLength) {
                        byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                        totalBytesRead += byteRead;
                        }
                             String file = new String(dataBytes);
                //for saving the file name
                saveFile = file.substring(file.indexOf("filename=\"") + 10);
                saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
                saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,saveFile.indexOf("\""));
                int lastIndex = contentType.lastIndexOf("=");
                String boundary = contentType.substring(lastIndex + 1,contentType.length());
                int pos;
                //extracting the index of file 
                pos = file.indexOf("filename=\"");
                pos = file.indexOf("\n", pos) + 1;
                pos = file.indexOf("\n", pos) + 1;
                pos = file.indexOf("\n", pos) + 1;
                int boundaryLocation = file.indexOf(boundary, pos) - 4;
                int startPos = ((file.substring(0, pos)).getBytes()).length;
                int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
                // creating a new file with the same name and writing the content in new file
                FileOutputStream fileOut = new FileOutputStream(saveFile);
                fileOut.write(dataBytes, startPos, (endPos - startPos));
                fileOut.flush();
                fileOut.close();
                                %>
<Br><table border="2"><tr><td><b>You have successfully upload the file by the name of:</b> <% out.println(saveFile); %></td></tr></table> 
<%
               }
 //  



Cell rowData[] = null; 
int rowCount = 0; 
int columnCount = 0; 

try{
WorkbookSettings ws = new WorkbookSettings(); 
ws.setLocale(new Locale("en", "EN")); 
Workbook workbook = Workbook.getWorkbook(new File(saveFile), ws); 	

Sheet s = workbook.getSheet(0); 
rowCount = s.getRows(); 
columnCount = s.getColumns();

for(int i = 2; i < rowCount; i++){ 
	rowData = s.getRow(i);
	query="insert into tmp_seg_change values ";
	for(int j = 0; j < columnCount ;j++){
		if (j == 0){ 
				//out.println("('"+rowData[j].getContents()+"'"); 
				query=query+" ('"+rowData[j].getContents()+"'"; 			
				}
		else if(j == columnCount-1) {
				//out.println(",'"+rowData[j].getContents()+"');");}
				query=query+",'"+rowData[j].getContents()+"');";
				}
		else  {
				//out.println(",'"+rowData[j].getContents()+"'");
				query=query+",'"+rowData[j].getContents()+"'";
				}
									}
out.println(query);	
}

workbook.close(); 

}   catch (Exception e) {
out.println(e);} 

%> 
