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

<cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">
		<cfset iDecl_UPrice=getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice="">
		<cfset stDecl_UPrice2 = ",.">
		
		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice=stDecl_UPrice&"0">
			<cfset stDecl_UPrice2 = stDecl_UPrice2 & "_">
		</cfloop>
	
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
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
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
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s38">
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
		  		<Style ss:ID="s39">
		   			<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   			</Borders>
		   			<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
		  		</Style>
		  		<Style ss:ID="s41">
		   			<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  		</Style>
		 	</Styles>
			
			<Worksheet ss:Name="Customer Invoice Detail Listing">
				<cfoutput>
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="64.5"/>
					<Column ss:Width="60.25"/>
					<Column ss:Width="60.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
					<Column ss:Width="27.75"/>
					<Column ss:Width="47.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="9">
					<cfif lcase(HcomID) eq "topsteel_i">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
					</cfif>
		   
					<cfwddx action = "cfml2wddx" input = " Customer Invoice Detail Listing Report" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
			
					<cfif ndatefrom neq "" and ndateto neq "">
						<cfwddx action = "cfml2wddx" input = "#form.datefrom# - #form.dateto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
					</cfif>
			
					<cfif form.periodfrom neq "" and form.periodto neq "">
						<cfwddx action = "cfml2wddx" input = "Period From #form.periodfrom# To #form.periodto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
					</cfif>
			
					<cfif form.agentfrom neq "" and form.agentto neq "">
						<cfwddx action = "cfml2wddx" input = "#getgeneral.lAGENT# From #form.agentfrom# To #form.agentto#" output = "wddxText">
						<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
						</Row>
					</cfif>

					
					<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
			
					<Row ss:AutoFitHeight="0" ss:Height="20.0625">
						<Cell ss:MergeAcross="#c-1#" ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
					</Row>
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
				</cfoutput>
		
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<Cell ss:StyleID="s27"><Data ss:Type="String">Date</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Refno</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Item No</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Quantity</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">Price</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">GST 7%</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">Amount</Data></Cell>
                  
				</Row>
				   <cfset totalinv = 0>
			<cfset totalcs = 0>
			<cfset totaldn = 0>
			<cfset totalcn = 0>
			<cfset total = 0>
			<cfoutput>
				<cfloop query="getcustomer">
				<cfset subqty = 0>
				<cfset subamt = 0>
                <cfset subcn = 0>
                <cfset subcnqty = 0>
				
					<cfwddx action = "cfml2wddx" input = "#getcustomer.currentrow#" output = "wddxText">
					<cfwddx action = "cfml2wddx" input = "#getcustomer.custno#" output = "wddxText2">
					<cfwddx action = "cfml2wddx" input = "#getcustomer.name#" output = "wddxText3">
                    <cfwddx action = "cfml2wddx" input = "#getcustomer.agenno#" output = "wddxText4">
                    
				<Row ss:AutoFitHeight="0">
                
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxtext#.CUSTOMER NO: #wddxText2#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
					
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
					<cfif lcase(hcomid) eq "hfi_i">order by wos_date<cfelse>order by refno</cfif>
				</cfquery>

				<cfloop query="getdata">
					<cfset qty = 0>
					<cfset dn = 0>
					<cfset cs = 0>
					<cfset cn = 0>
					<cfset amt = 0>
                    <cfwddx action = "cfml2wddx" input = "#getdata.type#" output = "wddxText5">
					<cfwddx action = "cfml2wddx" input = "#getdata.refno#" output = "wddxText6">
					<cfwddx action = "cfml2wddx" input = "#getdata.itemno#" output = "wddxText7">
					<Row ss:AutoFitHeight="0">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#dateformat(getdata.wos_date,"dd-mm-yyyy")#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText5#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText6#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText7#</Data></Cell>
                        <cfif getdata.type eq "INV" or getdata.type eq "CS">
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#getdata.qty_bil#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#numberformat(getdata.price_bil,",.__")#</Data></Cell>
                        <cfif lcase(hcomid) eq "hfi_i">
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#numberformat((getdata.amt1_bil*getdata.taxpec1),",.__")#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#numberformat((getdata.amt1_bil+(getdata.amt1_bil*getdata.taxpec1)),",.__")#</Data></Cell>
                        <cfelse>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#numberformat(getdata.amt1_bil,",.__")#</Data></Cell>
                        </cfif>
                         <cfelseif getdata.type eq "CN">
                        <Cell ss:StyleID="s32"><Data ss:Type="String">-#getdata.qty_bil#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#numberformat(getdata.price_bil,",.__")#</Data></Cell>
                        <cfif lcase(hcomid) eq "hfi_i">

                         <Cell ss:StyleID="s32"><Data ss:Type="String">-#numberformat((getdata.amt1_bil*0.07),",.__")#</Data></Cell></cfif>
                         <cfif lcase(hcomid) eq "hfi_i">
                         <Cell ss:StyleID="s32"><Data ss:Type="String">-#numberformat((getdata.amt1_bil*1.07),",.__")#</Data></Cell>
                         <cfelse>
                         <Cell ss:StyleID="s32"><Data ss:Type="String">-#numberformat(getdata.amt1_bil,",.__")#</Data></Cell>
                         </cfif>
                         </cfif>
				</Row>                     
                      <cfif getdata.type eq "INV" or getdata.type eq "CS">
                      <cfset subamt=subamt+getdata.amt1_bil>
                      <cfset subqty=subqty+getdata.qty_bil>
                      <cfelseif getdata.type eq "CN">
                      <cfset subcn=subcn+getdata.amt1_bil>
                      <cfset subcnqty=subcnqty+getdata.qty_bil>
                      </cfif>
				</cfloop>
                <cfset subtotal=subamt - subcn>
                <cfset subtotalqty=subqty - subcnqty>
                <Row>
                 <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                 <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                 <Cell ss:StyleID="s32"><Data ss:Type="String">TOTAL:</Data></Cell>
                 <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                 <Cell ss:StyleID="s32"><Data ss:Type="String">#subtotalqty#</Data></Cell>
                 <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
                 <cfif lcase(hcomid) eq "hfi_i"><Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell></cfif>
                 <Cell ss:StyleID="s32"><Data ss:Type="String">#numberformat(subtotal,",.__")#</Data></Cell>
                </Row>

			</cfloop>
            </cfoutput>
<Row ss:AutoFitHeight="0" ss:Height="12"/>
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

		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls" output="#tostring(data)#">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
	</cfcase>
    <cfcase value="HTML">
		<html>
		<head>
		<title>CUSTOMER INVOICE DETAIL LISTING REPORT</title>
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
                <cfif lcase(hcomid) eq "hfi_i">
                <td><font size="2" face="Times New Roman, Times, serif">GST 7%</font></td>
                </cfif>
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
					<cfif lcase(hcomid) eq "hfi_i">order by wos_date<cfelse>order by refno</cfif>
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
                      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getdata.price_bil,",.__")#</font></div></td>
                      <cfif lcase(hcomid) eq "hfi_i">
                      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getdata.amt1_bil*0.07,",.__")#</font></div></td>
                      </cfif>
                      <cfif lcase(hcomid) eq "hfi_i">
                      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getdata.amt1_bil*1.07,",.__")#</font></div></td>
                      <cfelse>
                      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getdata.amt1_bil,",.__")#</font></div></td>
                      </cfif>
                      <cfelseif getdata.type eq "CN">
                                            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">-#getdata.qty_bil#</font></div></td>
                      <td><font size="2" face="Times New Roman, Times, serif"><div align="right">#numberformat(getdata.price_bil,",.__")#</div></font></td>
                      <cfif lcase(hcomid) eq "hfi_i">
                      <td><div align="right"><font size="2" face="Times New Roman, Times, serif">-#numberformat((getdata.amt1_bil*(getdata.taxpec1/100)),",.__")#</font></div></td>
                      </cfif>
                       <cfif lcase(hcomid) eq "hfi_i">
                      <td align="right"><div align="right"><font size="2" face="Times New Roman, Times, serif">-#numberformat((getdata.amt1_bil+(getdata.amt1_bil*(getdata.taxpec1/100))),",.__")#</font></div></td>
                      <cfelse>
                     <td><div align="right"><font size="2" face="Times New Roman, Times, serif">-#numberformat(getdata.amt1_bil,",.__")#</font></div></td>
                      </cfif>
                      
                      </cfif>
                      <cfif lcase(hcomid) eq "hfi_i">
                      <cfif getdata.type eq "INV" or getdata.type eq "CS">
                      <cfset subamt=subamt+(getdata.amt1_bil+(getdata.amt1_bil*(getdata.taxpec1/100)))>
                      <cfset subqty=subqty+getdata.qty_bil>
                      <cfelseif getdata.type eq "CN">
                      <cfset subcn=subcn+getdata.amt1_bil>
                      <cfset subcnqty=subcnqty+getdata.qty_bil>
                      </cfif>
                      <cfelse>
					  <cfif getdata.type eq "INV" or getdata.type eq "CS">
                      <cfset subamt=subamt+getdata.amt1_bil>
                      <cfset subqty=subqty+getdata.qty_bil>
                      <cfelseif getdata.type eq "CN">
                      <cfset subcn=subcn+getdata.amt1_bil>
                      <cfset subcnqty=subcnqty+getdata.qty_bil>
                      </cfif>
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
                    <cfif lcase(hcomid) eq "hfi_i"><td></td></cfif>
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
