<cfquery name="getgeneral" datasource="#dts#">
	select a.compro,date_format(a.lastaccyear,'%Y-%m-%d') as lastaccyear,concat(',.',repeat('_',b.decl_uprice))as decl_uprice
	from gsetup as a, gsetup2 as b;
</cfquery>

<cfset grandtotal = 0>
<cfset monthtotal = arraynew(1)>

<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>

		<cfset stDecl_UPrice = getgeneral.decl_uprice>
        
        
<cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">

		<cfxml variable="data">
			<?xml version="1.0"?>
			<?mso-application progid="Excel.Sheet"?>
			<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
			<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
				<Author>Netiquette Technology</Author>
				<LastAuthor>Netiquette Technology</LastAuthor>
				<Company>Netiquette Technology</Company>
			</DocumentProperties>
			<Styles>
		  		<Style ss:ID="Default" ss:Name="Normal">
			   		<Alignment ss:Vertical="Bottom"/>
			   		<Borders/>
			   		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9"/>
			   		<Interior/>
			   		<NumberFormat/>
			   		<Protection/>
		  		</Style>
		  		<Style ss:ID="s22">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="12" ss:Bold="1"/>
		  		</Style>
			 	<Style ss:ID="s24">
			   		<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
			   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
			  	</Style>
		  		<Style ss:ID="s26">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  		</Style>
		  		<Style ss:ID="s27">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
		  		<Style ss:ID="s30">
		   			<NumberFormat ss:Format="dd-mm-yy;@"/>
		  		</Style>
		  		<Style ss:ID="s31">
		  			<Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  		</Style>
		  		<Style ss:ID="s32">
		  	 		<NumberFormat ss:Format="@"/>
		  		</Style>
		  		<Style ss:ID="s33">
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s34">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="dd/mm/yyyy;@"/>
		  		</Style>
		  		<Style ss:ID="s35">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0"/>
		  		</Style>
		  		<Style ss:ID="s36">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="@"/>
		  		</Style>
		  		<Style ss:ID="s37">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s38">
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
		  		<Style ss:ID="s39">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>00</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s41">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  		</Style>
                
                  <Style ss:ID="s50">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>

		  		</Style>

		 	</Styles>
			
			<Worksheet ss:Name="Print Profit Margin Report">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="80.25"/>
					<Column ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="300.75"/>
					<Column ss:Width="60.75"/>
					<Column ss:Width="150.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
 <cfoutput>
 
 	 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">SERVICE REPORT BY PROJECT</Data></Cell>
	</Row>


    <cfquery name="getproject" datasource="#dts#">
    select source from ictran where 0=0 and linecode='SV'
    <cfif form.servicefrom neq "" and form.serviceto neq "">
    and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
    </cfif>
    <cfif form.projectfrom neq "" and form.projectto neq "">
    and source >='#form.projectfrom#' and source <= '#form.projectto#'
    </cfif>
    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
	</cfif>
    <cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
    </cfif>
    group by source
    </cfquery>
    
   
   <cfif form.servicefrom neq "" and form.serviceto neq "">
         <Row ss:AutoFitHeight="0" ss:Height="20.0625">
       		   <cfwddx action = "cfml2wddx" input = "#form.servicefrom# - #form.serviceto#" output = "wddxText">
      	<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Service: #wddxText#</Data></Cell>
    </Row>
    </cfif>
  
    <cfif form.projectfrom neq "" and form.projectto neq "">
        <Row ss:AutoFitHeight="0" ss:Height="20.0625">
       		   <cfwddx action = "cfml2wddx" input = "#form.projectfrom# - #form.projectto#" output = "wddxText">
      	<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Project: #wddxText#</Data></Cell>
    </Row>
    </cfif>

	
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
      			<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText1">
                <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText2">
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText1#</Data></Cell>
      	        <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      	        <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      			<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
    </Row>
   
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <Cell ss:StyleID="s50"><Data ss:Type="String">NO</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">DATE</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">TYPE</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">DESCRIPTION</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">REF No</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">Customer Name</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">Service Cost</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">Quantity</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">Price</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">Amount</Data></Cell>
   			</Row>
    

	<cfloop query="getproject">
    <cfset sumqty=0>
    <cfset sumamt=0>
   <cfquery name="getitem" datasource="#dts#">
    select * from ictran where linecode='SV'
    <cfif form.servicefrom neq "" and form.serviceto neq "">
    and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
    </cfif>
    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
	</cfif>
    <cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
    </cfif>
    and source = '#getproject.source#'
    </cfquery>
    
    <cfloop query="getitem">
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#getitem.currentrow#" output = "wddxText3">
                <cfwddx action = "cfml2wddx" input = "#dateformat(getitem.wos_date,'DD/MM/YYYY')#" output = "wddxText4">
                <cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText5">
                <cfwddx action = "cfml2wddx" input = "#getitem.desp#" output = "wddxText6">
                <cfwddx action = "cfml2wddx" input = "#getitem.refno#" output = "wddxText7">
                <cfwddx action = "cfml2wddx" input = "#getitem.name#" output = "wddxText8">
                <cfwddx action = "cfml2wddx" input = "#lsnumberformat(getitem.sercost,',_.__')#" output = "wddxText9">
                <cfwddx action = "cfml2wddx" input = "#getitem.qty_bil#" output = "wddxText10">
                <cfwddx action = "cfml2wddx" input = "#lsnumberformat(getitem.price_bil,',_.__')#" output = "wddxText11">
                <cfwddx action = "cfml2wddx" input = "#lsnumberformat(getitem.amt1_bil,',_.__')#" output = "wddxText12">
            
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText3#.</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText4#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText7#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText8#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText9#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText10#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText11#</Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText12#</Data></Cell>
		</Row>
         <cfset sumqty = sumqty + getitem.qty_bil>
          <cfset sumamt = sumamt + getitem.amt1_bil>
</cfloop>

            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#sumqty#" output = "wddxText13">
                <cfwddx action = "cfml2wddx" input = "#lsnumberformat(sumamt,',_.__')#" output = "wddxText14">
      	        <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
      	        <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
      	        <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
    			<Cell ss:StyleID="s50"><Data ss:Type="String">Total</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
      	        <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>                
    			<Cell ss:StyleID="s50"><Data ss:Type="String">#wddxText13#</Data></Cell>
      	        <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String">#wddxText14#</Data></Cell>
      	        <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
      	        <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
      	        <Cell ss:StyleID="s50"><Data ss:Type="String"></Data></Cell>
    	</Row>
    
            <Row ss:AutoFitHeight="0" ss:Height="20.0625">
      	        <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
    </Row>
	</cfloop>
    
    
	
</cfoutput>
        </Table>
		 	
			<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
		   	<Unsynced/>
		   	<Print>
				<ValidPrinterInfo/>
				<Scale>60</Scale>
				<HorizontalResolution>600</HorizontalResolution>
				<VerticalResolution>600</VerticalResolution>
		   	</Print>
		   	<Selected/>
		   	<Panes>
				<Pane>
					<Number>3</Number>
			 		<ActiveRow>20</ActiveRow>
			 		<ActiveCol>3</ActiveCol>
				</Pane>
		   	</Panes>
		   	<ProtectObjects>False</ProtectObjects>
		   	<ProtectScenarios>False</ProtectScenarios>
		  	</WorksheetOptions>
		 	</Worksheet>
			</Workbook>
		</cfxml>

		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls" output="#tostring(data)#" charset="utf-8">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
	</cfcase>

            <cfcase value="HTML">

<html>
<head>
<title>Product Service By Month Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<body>
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<tr>
		<td colspan="25"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong> SERVICE REPORT BY PROJECT</strong></font></div></td>
	</tr>
    <tr>
      	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">
	  		
	  	</font></div>
	  	</td>
    </tr>

    <cfquery name="getproject" datasource="#dts#">
    select source from ictran where 0=0 and linecode='SV'
    <cfif form.servicefrom neq "" and form.serviceto neq "">
    and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
    </cfif>
    <cfif form.projectfrom neq "" and form.projectto neq "">
    and source >='#form.projectfrom#' and source <= '#form.projectto#'
    </cfif>
    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
	</cfif>
    <cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
    </cfif>
    group by source
    </cfquery>
    
   
   <cfif form.servicefrom neq "" and form.serviceto neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">Service: #form.servicefrom# - #form.serviceto#</font></div></td>
        </tr>
    </cfif>
  
    <cfif form.projectfrom neq "" and form.projectto neq "">
        <tr>
          	<td colspan="25"><div align="center"><font size="2" face="Times New Roman, Times, serif">Project: #form.projectfrom# - #form.projectto#</font></div></td>
        </tr>
    </cfif>

	
    <tr>
      	<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td>&nbsp;</td>
      	<td colspan="19"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>
    <tr>
		<td><font size="2" face="Times New Roman, Times, serif">NO</font></td>
      	<td><font size="2" face="Times New Roman, Times, serif">DATE</font></td>
	  	<td><font size="2" face="Times New Roman, Times, serif">TYPE</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">REF No</font></td>
		<td><font size="2" face="Times New Roman, Times, serif">Customer Name</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Service Cost</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Quantity</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Price</font></td>
	  	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Amount</font></div></td>
    </tr>
    <tr>
      	<td colspan="25"><hr></td>
    </tr>

	<cfloop query="getproject">
    <cfset sumqty=0>
    <cfset sumamt=0>
    <td><font size="2" face="Times New Roman, Times, serif"><u><b>#getproject.source#</b></u></font></td>
   <cfquery name="getitem" datasource="#dts#">
    select * from ictran where linecode='SV'
    <cfif form.servicefrom neq "" and form.serviceto neq "">
    and itemno >='#form.servicefrom#' and itemno <= '#form.serviceto#'
    </cfif>
    <cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
	</cfif>
    <cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
    </cfif>
    and source = '#getproject.source#'
    </cfquery>
    
    <cfloop query="getitem">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.wos_date,'DD/MM/YYYY')#</font></td>
			<td><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.desp#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.refno#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.name#</font></td>
             <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.sercost,',_.__')#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#getitem.qty_bil#</font></td>
      
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.price_bil,',_.__')#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif">#lsnumberformat(getitem.amt1_bil,',_.__')#</font></td>
					
		</tr>
         <cfset sumqty = sumqty + getitem.qty_bil>
          <cfset sumamt = sumamt + getitem.amt1_bil>
</cfloop>
<tr>
    	<td colspan="25"><hr></td>
    </tr>
    <tr>
    <td></td>
    <td></td>
<td></td>
    <td colspan="3">Total</td>

    <td>#sumqty#</td>
<td></td>
<td>#lsnumberformat(sumamt,',_.__')#</td>
    </tr>
    <tr>
    <td colspan='10'>
    <hr>
    </td>
    </tr>
	</cfloop>
    
    
	
</table>
</cfoutput>

<cfif getproject.recordcount eq 0>
	<h3>Sorry, No records were found.</h3>
	<cfabort>
</cfif>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>

</cfcase>
</cfswitch>