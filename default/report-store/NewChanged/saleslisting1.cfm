<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd = dateformat(form.datefrom, "DD")>
	<cfif dd greater than '12'>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYYDDMM")>
	</cfif>

	<cfset dd = dateformat(form.dateto, "DD")>
	<cfif dd greater than '12'>
		<cfset ndateto = dateformat(form.dateto,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYYDDMM")>
	</cfif>
</cfif>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		  	<cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>
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
                
                 <Style ss:ID="s51">
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>

		 	</Styles>
			
			<Worksheet ss:Name="CUSTOMER ITEM SALES LISTING REPORT">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="300.5"/>
					<Column ss:Width="300.25"/>
					<Column ss:Width="100.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="180.75"/>
					<Column ss:Width="60.75"/>
					<Column ss:Width="60.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
                        
				<cfoutput>
                
 	 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#trantype# REPORT</Data></Cell>
		</Row>
        
			<cfif form.periodfrom neq "" and form.periodto neq "">
 	 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#form.periodfrom# - #form.periodto#" output = "wddxText">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">PERIOD: #wddxText#</Data></Cell>
		</Row>
			</cfif>
            
			<cfif form.datefrom neq "" and form.dateto neq "">
 	 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#" output = "wddxText1">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">DATE: #wddxText1#</Data></Cell>
		</Row>
			</cfif>
            
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
 	 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#form.custfrom# - #form.custto#" output = "wddxText2">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">CUST_NO: #wddxText2#</Data></Cell>
		</Row>
			</cfif>
            
			<cfif form.agentfrom neq "" and form.agentto neq "">
 	 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#form.agentfrom# - #form.agentto#" output = "wddxText3">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">AGENT: #wddxText3#</Data></Cell>
		</Row>
			</cfif>
            
			<cfif form.areafrom neq "" and form.areato neq "">
 			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#form.areafrom# - #form.areato#" output = "wddxText4">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">AREA: #wddxText4#</Data></Cell>
		</Row>
			</cfif>
            
 			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText5">
                <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd/mm/yyyy")#" output = "wddxText6">
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
		</Row>
        
 			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
            	<Cell ss:StyleID="s50"><Data ss:Type="String">DATE</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">TYPE</Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String">REF NO.</Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String">ITEM NO.</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">Quantity</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">Price</Data></Cell>
                <Cell ss:StyleID="s50"><Data ss:Type="String">Amount</Data></Cell>
		</Row>
			

			<cfset totalinv = 0>
			<cfset totalcs = 0>
			<cfset totaldn = 0>
			<cfset totalcn = 0>
			<cfset total = 0>

			<cfquery name="getcustomer" datasource="#dts#">
				select custno,name,agenno from artran
				where (type = 'INV' or type = 'CN' or type = 'CS') and (void = '' or void is null)
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
				</cfif>
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <='#form.areato#'
				</cfif>
				<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno >='#form.custfrom#' and custno <= '#form.custto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno order by custno
			</cfquery>

			<cfloop query="getcustomer">
				<cfset subqty = 0>
				<cfset subamt = 0>
                <cfset subcn = 0>
                <cfset subcnqty = 0>
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#getcustomer.name#" output = "wddxText8">
                <cfwddx action = "cfml2wddx" input = "#getcustomer.agenno#" output = "wddxText9">

			<Cell ss:StyleID="s41"><Data ss:Type="String">#getcustomer.currentrow#.CUSTOMER NO: #getcustomer.custno#</Data></Cell>
			<Cell ss:StyleID="s41"><Data ss:Type="String">#wddxText8#</Data></Cell>
			<Cell ss:StyleID="s41"><Data ss:Type="String">#wddxText9#</Data></Cell>
				</Row>

				<cfquery name="getdata" datasource="#dts#">
					select * from ictran where (type = 'INV' or type = 'CN' or type = 'CS')
					and custno = '#getcustomer.custno#' and (void = '' or void is null)
					<cfif form.agentfrom neq "" and form.agentto neq "">
					and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
					</cfif>
					<cfif form.areafrom neq "" and form.areato neq "">
					and area >='#form.areafrom#' and area <='#form.areato#'
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear#
					</cfif>
					order by itemno
				</cfquery>

				<cfloop query="getdata">
					<cfset qty = 0>
					<cfset dn = 0>
					<cfset cs = 0>
					<cfset cn = 0>
					<cfset amt = 0>
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
     
                <cfwddx action = "cfml2wddx" input = "#dateformat(getdata.wos_date,"dd-mm-yyyy")#" output = "wddxText10">
                <cfwddx action = "cfml2wddx" input = "#getdata.type#" output = "wddxText11">
                <cfwddx action = "cfml2wddx" input = "#getdata.refno#" output = "wddxText12">
                <cfwddx action = "cfml2wddx" input = "#getdata.itemno#" output = "wddxText13">
                <cfwddx action = "cfml2wddx" input = "#getdata.qty_bil#" output = "wddxText14">
                <cfwddx action = "cfml2wddx" input = "#numberformat(getdata.price_bil,",.__")#" output = "wddxText15">
                <cfwddx action = "cfml2wddx" input = "#numberformat(getdata.amt1_bil,",.__")#" output = "wddxText16">
                <cfwddx action = "cfml2wddx" input = "#getdata.qty_bil#" output = "wddxText17">
                <cfwddx action = "cfml2wddx" input = "#numberformat(getdata.price_bil,",.__")#" output = "wddxText18">
                <cfwddx action = "cfml2wddx" input = "#numberformat(getdata.amt1_bil,",.__")#" output = "wddxText19">
                 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText10#</Data></Cell>
				 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText11#</Data></Cell>
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText12#</Data></Cell>
                 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText13#</Data></Cell>
                      <cfif getdata.type eq "INV" or getdata.type eq "CS">
                 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText14#</Data></Cell>
                 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText15#</Data></Cell>
                 <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText16#</Data></Cell>
                      <cfelseif getdata.type eq "CN">
                        <Cell ss:StyleID="s26"><Data ss:Type="String">-#wddxText17#</Data></Cell>
                      <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText18#</Data></Cell>
                      <Cell ss:StyleID="s26"><Data ss:Type="String">-#wddxText19#</Data></Cell>
                      
                      </cfif>
                      
                      <cfif getdata.type eq "INV" or getdata.type eq "CS">
                      <cfset subamt=subamt+getdata.amt1_bil>
                      <cfset subqty=subqty+getdata.qty_bil>
                      <cfelseif getdata.type eq "CN">
                      <cfset subcn=subcn+getdata.amt1_bil>
                      <cfset subcnqty=subcnqty+getdata.qty_bil>
                      </cfif>
					</Row>
				</cfloop>
				
                <cfset subtotal=subamt - subcn>
                <cfset subtotalqty=subqty - subcnqty>
     <Row ss:AutoFitHeight="0" ss:Height="20.0625">
                <cfwddx action = "cfml2wddx" input = "#subtotalqty#" output = "wddxText20">
                <cfwddx action = "cfml2wddx" input = "#numberformat(subtotal,",.__")#" output = "wddxText21">
		<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s51"><Data ss:Type="String">TOTAL:</Data></Cell>
		<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText20#</Data></Cell>
		<Cell ss:StyleID="s51"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s51"><Data ss:Type="String">#wddxText21#</Data></Cell>
                    
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
		<title>CUSTOMER ITEM SALES LISTING REPORT</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
		<style type="text/css" media="print">
			.noprint { display: none; }
		</style>
		</head>
		<body>

		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		  	<cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

		<cfoutput>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				<td colspan="8"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>#trantype# REPORT</strong></font></div></td>
			</tr>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">CUST_NO: #form.custfrom# - #form.custto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
				<tr>
					<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">AREA: #form.areafrom# - #form.areato#</font></div></td>
				</tr>
			</cfif>
			<tr>
				<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="6"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
			<tr>
				<td colspan="9"><hr></td>
			</tr>
			<tr>
            	<td><font size="2" face="Times New Roman, Times, serif">DATE</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">TYPE</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">REF NO.</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">Quantity</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">Price</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">Amount</font></td>
			</tr>
			<tr>
				<td colspan="9"><hr></td>
			</tr>

			<cfset totalinv = 0>
			<cfset totalcs = 0>
			<cfset totaldn = 0>
			<cfset totalcn = 0>
			<cfset total = 0>

			<cfquery name="getcustomer" datasource="#dts#">
				select custno,name,agenno from artran
				where (type = 'INV' or type = 'CN' or type = 'CS') and (void = '' or void is null)
				<cfif form.agentfrom neq "" and form.agentto neq "">
				and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
				</cfif>
				<cfif form.areafrom neq "" and form.areato neq "">
				and area >='#form.areafrom#' and area <='#form.areato#'
				</cfif>
				<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
				and custno >='#form.custfrom#' and custno <= '#form.custto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
				<cfelse>
				and wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by custno order by custno
			</cfquery>

			<cfloop query="getcustomer">
				<cfset subqty = 0>
				<cfset subamt = 0>
                <cfset subcn = 0>
                <cfset subcnqty = 0>
				<tr>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><u>#getcustomer.currentrow#.CUSTOMER NO: #getcustomer.custno#</u></strong></font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><u>#getcustomer.name#</u></strong></font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><u>#getcustomer.agenno#</u></strong></font></div></td>
				</tr>

				<cfquery name="getdata" datasource="#dts#">
					select * from ictran where (type = 'INV' or type = 'CN' or type = 'CS')
					and custno = '#getcustomer.custno#' and (void = '' or void is null)
					<cfif form.agentfrom neq "" and form.agentto neq "">
					and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
					</cfif>
					<cfif form.areafrom neq "" and form.areato neq "">
					and area >='#form.areafrom#' and area <='#form.areato#'
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear#
					</cfif>
					order by itemno
				</cfquery>

				<cfloop query="getdata">
					<cfset qty = 0>
					<cfset dn = 0>
					<cfset cs = 0>
					<cfset cn = 0>
					<cfset amt = 0>
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getdata.wos_date,"dd-mm-yyyy")#</font></div></td>
					  <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.type#</font></div></td>
					  <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.refno#</font></div></td>
                      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.itemno#</font></div></td>
                      <cfif getdata.type eq "INV" or getdata.type eq "CS">
                      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getdata.qty_bil#</font></div></td>
                      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(getdata.price_bil,",.__")#</font></div></td>
                      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(getdata.amt1_bil,",.__")#</font></div></td>
                      <cfelseif getdata.type eq "CN">
                                            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">-#getdata.qty_bil#</font></div></td>
                      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(getdata.price_bil,",.__")#</font></div></td>
                      <td><div align="left"><font size="2" face="Times New Roman, Times, serif">-#numberformat(getdata.amt1_bil,",.__")#</font></div></td>
                      
                      </cfif>
                      
                      <cfif getdata.type eq "INV" or getdata.type eq "CS">
                      <cfset subamt=subamt+getdata.amt1_bil>
                      <cfset subqty=subqty+getdata.qty_bil>
                      <cfelseif getdata.type eq "CN">
                      <cfset subcn=subcn+getdata.amt1_bil>
                      <cfset subcnqty=subcnqty+getdata.qty_bil>
                      </cfif>
					</tr>
				</cfloop>
				<tr>
					<td colspan="9"><hr></td>
				</tr>
                <cfset subtotal=subamt - subcn>
                <cfset subtotalqty=subqty - subcnqty>
				<tr>
					<td></td>
                    <td></td>
					<td><div align="center"><font size="2" face="Times New Roman, Times, serif">TOTAL:</strong></font></div></td>
					<td></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#subtotalqty#</font></div></td>
					<td></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#numberformat(subtotal,",.__")#</font></div></td>

                    
                    
				</tr>
				<tr><td><br></td></tr>
			</cfloop>
			<cfflush>

		  </table>
		</cfoutput>

		<cfif getcustomer.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
		</cfif>

		<br>
		<br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
		</body>
		</html>
        </cfcase>
</cfswitch>
