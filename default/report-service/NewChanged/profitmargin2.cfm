<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear from gsetup
</cfquery>

<cfif getgeneral.cost eq "FIXED">
	<cfset costingmethod = "Fixed Cost Method">
<cfelseif getgeneral.cost eq "MONTH">
	<cfset costingmethod = "Month Average Method">
<cfelseif getgeneral.cost eq "MOVING">
	<cfset costingmethod = "Moving Average Method">
<cfelseif getgeneral.cost eq "FIFO">
	<cfset costingmethod = "First In First Out Method">
<cfelse>
	<cfset costingmethod = "Last In First Out Method">
</cfif>

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
                
                           <Style ss:ID="s91">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>


		 	</Styles>
			
			<Worksheet ss:Name="Print Profit Margin Report">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="300.25"/>
					<Column ss:Width="80.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="80.75"/>
					<Column ss:Width="90.75"/>
					<Column ss:Width="90.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
 <cfoutput>
 
 			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
							<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Print Service Profit Margin - Service Report</Data></Cell>
		</Row>
        
		 <Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Calculated by #costingmethod#</Data></Cell>
		</Row>
        
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                   <cfwddx action = "cfml2wddx" input = "#form.periodfrom# - #form.periodto#" output = "wddxText">
                    <Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">PERIOD: #wddxText#</Data></Cell>
			</Row>
			</cfif>
            
			<cfif form.datefrom neq "" and form.dateto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                   <cfwddx action = "cfml2wddx" input = "#dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#" output = "wddxText">
                    <Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">DATE: #wddxText#</Data></Cell>
			</Row>
			</cfif>
            
			<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
                   <cfwddx action = "cfml2wddx" input = "#form.servicefrom# - #form.serviceto#" output = "wddxText">
                    <Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">SERVICE: #wddxText#</Data></Cell>
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
				<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
			</Row>
			
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<Cell ss:StyleID="s50"><Data ss:Type="String">SERVICE CODE</Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String">DESCRIPTION</Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String">AMT</Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String">COST</Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String">GROSS PROFIT</Data></Cell>
				<Cell ss:StyleID="s50"><Data ss:Type="String">MARGIN (%)</Data></Cell>
			</Row>
			
			<cfquery name="gettran" datasource="#dts#"><!---service No--->
				select b.type as type,b.refno as refno, a.servi as itemno,b.linecode as linecode,b.desp as desp from icservi as a left join ictran  as b on a.servi = b.itemno
				where (type = 'INV' or type = 'DN' or type = 'CS') and (void = '' or void is null) and linecode='SV'
				<cfif form.servicefrom neq "" and form.serviceto neq "">
				and itemno >= '#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and b.fperiod >= '#form.periodfrom#' and b.fperiod <= '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and b.wos_date >= '#ndatefrom#' and b.wos_date <= '#ndateto#'
				<cfelse>
				and b.wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by itemno order by itemno
			</cfquery>

			<cfset totalsales = 0>
			<cfset totalcost = 0>
			<cfset totalprofit = 0>

			<cfloop query="gettran">
				<cfset desp = gettran.desp>
				<cfset sales = 0>
				<cfset cost = 0>
				<cfset profit = 0>

				<cfquery name="getsales" datasource="#dts#">
					
					select itemno,refno,sum(sercost) as sumcost,sum(amt) as sumamt,linecode from ictran
					where (type = 'INV' or type = 'CS' or type = 'DN') and itemno = '#gettran.itemno#' and linecode='SV'
	<cfif form.servicefrom neq "" and form.serviceto neq "">
				and itemno >= '#form.servicefrom#' and itemno <= '#form.serviceto#'
                
				</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear#
					</cfif>
                    
					group by itemno
				</cfquery>

				<cfset cost = cost + val(getsales.sumcost)>
				<cfset sales = sales + val(getsales.sumamt)>
				<cfset totalsales = totalsales + val(getsales.sumamt)>
				<cfset totalcost = totalcost + val(getsales.sumcost)>
				<cfset profit = sales - cost>
				<cfset totalprofit = totalprofit + profit>

			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<cfwddx action = "cfml2wddx" input = "#gettran.itemno#" output = "wddxText3">
			<cfwddx action = "cfml2wddx" input = "#gettran.desp#" output = "wddxText4">
			<cfwddx action = "cfml2wddx" input = "#NumberFormat(sales,stDecl_UPrice)#" output = "wddxText5">
			<cfwddx action = "cfml2wddx" input = "#NumberFormat(cost,stDecl_UPrice)#" output = "wddxText6">
			<cfwddx action = "cfml2wddx" input = "#NumberFormat(profit,stDecl_UPrice)#" output = "wddxText7">
			<cfwddx action = "cfml2wddx" input = "#NumberFormat(profit / sales * 100,"0.00")#" output = "wddxText8">
			<cfwddx action = "cfml2wddx" input = "#NumberFormat(0,"0.00")#" output = "wddxText9">
            
					<cfif gettran.refno eq "">
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
					<cfelse>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText3#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText4#</Data></Cell>
						
					</cfif>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText7#</Data></Cell>
					<cfif sales neq 0 and profit neq 0 and sales neq "">
					<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText8#</Data></Cell>
					<cfelse>
					<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText9#</Data></Cell>
					</cfif>
				</Row>
			</cfloop>
			
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<cfwddx action = "cfml2wddx" input = "#NumberFormat(totalsales,",.__")#" output = "wddxText10">
			<cfwddx action = "cfml2wddx" input = "#NumberFormat(totalcost,",.__")#" output = "wddxText11">
			<cfwddx action = "cfml2wddx" input = "#NumberFormat(totalprofit,",.__")#" output = "wddxText12">
			<cfwddx action = "cfml2wddx" input = "#NumberFormat(0,"0.00")#" output = "wddxText14">
            
				<Cell ss:StyleID="s91"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s91"><Data ss:Type="String">TOTAL:</Data></Cell>
				<Cell ss:StyleID="s91"><Data ss:Type="String">#wddxText10#</Data></Cell>
				<Cell ss:StyleID="s91"><Data ss:Type="String">#wddxText11#</Data></Cell>
				<Cell ss:StyleID="s91"><Data ss:Type="String">#wddxText12#</Data></Cell>
				<cfif totalsales neq 0 and totalprofit neq 0 and totalsales neq "">
				<Cell ss:StyleID="s91"><Data ss:Type="String">#NumberFormat(totalprofit / totalsales * 100,"0.00")#</Data></Cell>
				<cfelse>
				<Cell ss:StyleID="s91"><Data ss:Type="String">#wddxText14#</Data></Cell>
				</cfif>
			</Row>

		<cfif gettran.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
		</cfif>
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
		<title>Profit Margin By Service Report</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href = "../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
		<style type="text/css" media="print">
			.noprint { display: none; }
		</style>
		</head>

		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ",___.">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

		<body>
		<cfoutput>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				<td colspan="11"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Print Service Profit Margin - Service Report</strong></font></div></td>
			</tr>
			<tr>
				<td colspan="11"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Calculated by #costingmethod#</strong></font></div></td>
			</tr>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				<tr>
					<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#</font></div></td>
				</tr>
			</cfif>
			<cfif trim(form.servicefrom) neq "" and trim(form.serviceto) neq "">
				<tr>
					<td colspan="6"><div align="center"><font size="2" face="Times New Roman, Times, serif">SERVICE: #form.servicefrom# - #form.serviceto#</font></div></td>
				</tr>
			</cfif>
			<tr>
				<td colspan="2"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
			<tr>
				<td colspan="6"><hr></td>
			</tr>
			<tr>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">SERVICE CODE</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMT</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">COST</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">GROSS PROFIT</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">MARGIN (%)</font></div></td>
			</tr>
			<tr>
				<td colspan="6"><hr></td>
			</tr>

			<cfquery name="gettran" datasource="#dts#"><!---service No--->
				select b.type as type,b.refno as refno, a.servi as itemno,b.linecode as linecode,b.desp as desp from icservi as a left join ictran  as b on a.servi = b.itemno
				where (type = 'INV' or type = 'DN' or type = 'CS') and (void = '' or void is null) and linecode='SV'
				<cfif form.servicefrom neq "" and form.serviceto neq "">
				and itemno >= '#form.servicefrom#' and itemno <= '#form.serviceto#'
				</cfif>
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and b.fperiod >= '#form.periodfrom#' and b.fperiod <= '#form.periodto#'
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
				and b.wos_date >= '#ndatefrom#' and b.wos_date <= '#ndateto#'
				<cfelse>
				and b.wos_date > #getgeneral.lastaccyear#
				</cfif>
				group by itemno order by itemno
			</cfquery>

			<cfset totalsales = 0>
			<cfset totalcost = 0>
			<cfset totalprofit = 0>

			<cfloop query="gettran">
				<cfset desp = gettran.desp>
				<cfset sales = 0>
				<cfset cost = 0>
				<cfset profit = 0>

				<cfquery name="getsales" datasource="#dts#">
					
					select itemno,refno,sum(sercost) as sumcost,sum(amt) as sumamt,linecode from ictran
					where (type = 'INV' or type = 'CS' or type = 'DN') and itemno = '#gettran.itemno#' and linecode='SV'
	<cfif form.servicefrom neq "" and form.serviceto neq "">
				and itemno >= '#form.servicefrom#' and itemno <= '#form.serviceto#'
                
				</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear#
					</cfif>
                    
					group by itemno
				</cfquery>

				<cfset cost = cost + val(getsales.sumcost)>
				<cfset sales = sales + val(getsales.sumamt)>
				<cfset totalsales = totalsales + val(getsales.sumamt)>
				<cfset totalcost = totalcost + val(getsales.sumcost)>
				<cfset profit = sales - cost>
				<cfset totalprofit = totalprofit + profit>

				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<cfif gettran.refno eq "">
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif"></font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif"></font></div></td>
					<cfelse>
<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#gettran.itemno#</font></div></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#gettran.desp#</font></div></td>
						
					</cfif>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(sales,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(cost,stDecl_UPrice)#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(profit,stDecl_UPrice)#</font></div></td>
					<cfif sales neq 0 and profit neq 0 and sales neq "">
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(profit / sales * 100,"0.00")#</font></div></td>
					<cfelse>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(0,"0.00")#</font></div></td>
					</cfif>
				</tr>
				<cfflush>
			</cfloop>
			<tr>
				<td colspan="6"><hr></td>
			</tr>
			<tr>
				<td><div align="left"></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#NumberFormat(totalsales,",.__")#</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#NumberFormat(totalcost,",.__")#</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#NumberFormat(totalprofit,",.__")#</strong></font></div></td>
				<cfif totalsales neq 0 and totalprofit neq 0 and totalsales neq "">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#NumberFormat(totalprofit / totalsales * 100,"0.00")#</strong></font></div></td>
				<cfelse>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#NumberFormat(0,"0.00")#</strong></font></div></td>
				</cfif>
			</tr>
		</table>

		<cfif gettran.recordcount eq 0>
			<h3>Sorry, No records were found.</h3>
		</cfif>
		</cfoutput>
		<br>
		<br>
		<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
		<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
		</body>
		</html>
        
  </cfcase>
</cfswitch>