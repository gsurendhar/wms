<html>
<head>
</head>
<body>
<%
String strXML= "";
strXML="<graph caption='Monthly Unit Sales' xAxisName='Month' yAxisName='Units' showNames='1' decimalPrecision='0' formatNumberScale='0'>";
strXML += " <set name='Jan' value='462' />";
strXML += " <set name='Feb' value='857' color='F6BD0F' />";
strXML += " <set name='Mar' value='671' color='8BBA00' />";
strXML += " <set name='Apr' value='494' color='FF8E46' />";
strXML += "    <set name='May' value='761' color='008E8E' />";
strXML += "    <set name='Jun' value='960' color='D64646' />";
strXML += "    <set name='Jul' value='629' color='8E468E' />";
strXML += "    <set name='Aug' value='622' color='588526' />";
strXML += "    <set name='Sep' value='376' color='B3AA00' />";
strXML += "    <set name='Oct' value='494' color='008ED6' />";
strXML += "    <set name='Nov' value='961' color='9D080D' />";
strXML += "    <set name='Dec' value='960' color='A186BE' />";
strXML += " </graph> ";
//out.println(strXML);


String strXML1= "<chart palette='1' caption='Sales' shownames='1' showvalues='0' numberPrefix='$' sYAxisValuesDecimals='2' connectNullData='0' PYAxisName='Revenue' SYAxisName='Quantity' numDivLines='4' formatNumberScale='0'>";
strXML1 +=  "<categories>";
strXML1 +=  "<category label='11/12'/>";
strXML1 +=  "<category label=''/>";
strXML1 +=  "<category label='13/12'/>";
strXML1 +=  "<category label='14/12'/>";
strXML1 +=  "<category label='15/12'/>";
strXML1 +=  "<category label='16/12'/>";
strXML1 +=  "<category label='17/12'/>";
strXML1 +=  "<category label='18/12'/>";
strXML1 +=  "<category label='19/12'/>";
strXML1 +=  "<category label='20/12'/>";
strXML1 +=  "<category label='21/12'/>";
strXML1 +=  "<category label='22/12'/>";
strXML1 +=  "<category label='23/12'/>";
strXML1 +=  "<category label='24/12'/>";
strXML1 +=  "<category label='25/12'/>";
strXML1 +=  "</categories>";
strXML1 +=  "<dataset seriesName='NSE Del' color='AFD8F8' showValues='0'>";
strXML1 +=  "<set value='25601.34'/>";
strXML1 +=  "<set value='20148.82'/>";
strXML1 +=  "<set value='17372.76'/>";
strXML1 +=  "<set value='35407.15'/>";
strXML1 +=  "<set value='38105.68'/>";
strXML1 +=  "</dataset>";
strXML1 +=  "<dataset seriesName='BSE Del' color='F6BD0F' showValues='0'>";
strXML1 +=  "<set value='57401.85'/>";
strXML1 +=  "<set value='41941.19'/>";
strXML1 +=  "<set value='45263.37'/>";
strXML1 +=  "<set value='117320.16'/>";
strXML1 +=  "<set value='114845.27' dashed='1'/>";
strXML1 +=  "</dataset>";
strXML1 +=  "<dataset seriesName='20DMA' color='8BBA00' showValues='0' parentYAxis='S'>";
strXML1 +=  "<set value='45000'/>";
strXML1 +=  "<set value='44835'/>";
strXML1 +=  "<set value='42835'/>";
strXML1 +=  "<set value='77557'/>";
strXML1 +=  "<set value='92633'/>";
strXML1 +=  "</dataset>";
strXML1 +=  "</chart>";


%>
<body bgcolor="#ffffff">
      <OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase=http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="600" height="500" id="Column3D" >
         <param name="movie" value="../../../FusionCharts/Charts/FCF_Candlestick.swf" />
         <param name="FlashVars" value="&dataURL=cs_Data.xml&chartWidth=600&chartHeight=500">
         <param name="quality" value="high" />
         <embed src="../../../FusionCharts/Charts/StackedColumn3DLineDY.swf" flashVars="&dataXML=<%=strXML1%>&chartWidth=600&chartHeight=500" quality="high" width="600" height="500" name="Column3D" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" /> 
         <embed src="../../../FusionCharts/Charts/FCF_Candlestick.swf" flashVars="&dataURL=cs_Data.xml&chartWidth=600&chartHeight=500" quality="high" width="600" height="500" name="Column3D"1 type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
      </object>

</body> 
</html>