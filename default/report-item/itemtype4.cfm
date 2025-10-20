<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,agentlistuserid from gsetup
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
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = "">

	<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		<cfset stDecl_UPrice = stDecl_UPrice & "0">
	</cfloop>

	<cfquery name="getarea" datasource="#dts#">
		select * from #target_arcust# where custno in (select custno from artran group by custno) group by area
	</cfquery>

	<cfxml variable="data">
	<?xml version="1.0"?>
	<?mso-application progid="Excel.Sheet"?>
	<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
	xmlns:o="urn:schemas-microsoft-com:office:office"
	xmlns:x="urn:schemas-microsoft-com:office:excel"
	xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
	xmlns:html="http://www.w3.org/TR/REC-html40">
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
	<Style ss:ID="s28">
	<NumberFormat ss:Format="@"/>
	</Style>
	<Style ss:ID="s29">
	<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
	</Style>
	<Style ss:ID="s30">
	<Borders>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<NumberFormat ss:Format="@"/>
	</Style>
	<Style ss:ID="s31">
	<Borders>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
	</Style>
	<Style ss:ID="s32">
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
	</Style>
	<Style ss:ID="s33">
	<Borders>
	<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
	</Borders>
	<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
	</Style>
	<Style ss:ID="s34">
	<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
	</Style>
	<Style ss:ID="s35">
	<NumberFormat ss:Format="0"/>
	</Style>
	<Style ss:ID="s36">
	<Borders>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<NumberFormat ss:Format="0"/>
	</Style>
	<Style ss:ID="s37">
	<Borders>
	<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
	</Borders>
	<NumberFormat ss:Format="0"/>
	</Style>
	</Styles>
	<Worksheet ss:Name="Area-Category">
	<cfoutput>
    <cfif isdefined('form.foc')>
    <cfset columncount = 10>
    <cfset rowcom = 8>
    <cfset comcom = 7>
    <cfelse>
    <cfset columncount = 9>
    <cfset rowcom = 7>
    <cfset comcom = 6>
	</cfif>
	<Table ss:ExpandedColumnCount="#columncount#" x:FullColumns="1" x:FullRows="1">
	<Column ss:AutoFitWidth="0" ss:Width="93.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="80.5" ss:Span="5"/>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s22"><Data ss:Type="String">#trantype# REPORT</Data></Cell>
	</Row>

	<cfif form.periodfrom neq "" and form.periodto neq "">
		<cfwddx action = "cfml2wddx" input = "PERIOD: #form.periodfrom# - #form.periodto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif form.datefrom neq "" and form.dateto neq "">
		<cfwddx action = "cfml2wddx" input = "DATE: #form.datefrom# - #form.dateto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif form.agentfrom neq "" and form.agentto neq "">
		<cfwddx action = "cfml2wddx" input = "AGENT: #form.agentfrom# - #form.agentto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif form.areafrom neq "" and form.areato neq "">
		<cfwddx action = "cfml2wddx" input = "AREA: #form.areafrom# - #form.areato#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
		<cfwddx action = "cfml2wddx" input = "CUST_NO: #form.custfrom# - #form.custto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		<cfwddx action = "cfml2wddx" input = "CATEGORY: #form.catefrom# - #form.cateto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<cfwddx action = "cfml2wddx" input = "GROUP: #form.groupfrom# - #form.groupto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		<cfwddx action = "cfml2wddx" input = "ITEM_NO: #form.itemfrom# - #form.itemto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#rowcom#" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>

	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#comcom#" ss:StyleID="s26"><Data ss:Type="String">#getgeneral.compro#</Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
	</Row>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:StyleID="s27"><Data ss:Type="String">AREA</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">CATEGORY</Data></Cell>
        <Cell ss:StyleID="s27"><Data ss:Type="String">LOCAL SUB TOTAL</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">QTY</Data></Cell>
		
	</Row>

	<cfset totalamt = 0>
	<cfset totalqty = 0>
    <cfset totalamt2 = 0>
	<cfset totalqty2 = 0>
	

	<cfloop query="getarea">
		<cfset subamt = 0>
        <cfset subqty = 0>
        <cfset subamt2 = 0>
        <cfset subqty2 = 0>

		<cfwddx action = "cfml2wddx" input = "#getarea.area#" output = "wddxText1">

		<Row ss:AutoFitHeight="0" ss:Height="12">
			<Cell ss:StyleID="s34"><Data ss:Type="String">#wddxText1#</Data></Cell>
            <Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
		</Row>
		<cfquery name="getitem" datasource="#dts#">
					select 
					itemno,category,
					sum(qty) as qty,
					sum(amt) as amt 
					from ictran 
					where type in ('INV','CS','DN')
					and (void = '' or void is null)
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear# 
					</cfif>
                    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
                    <cfif form.agentfrom neq "" and form.agentto neq "">
					and agenno between '#form.agentfrom#' and '#form.agentto#'
					</cfif>
                    and custno in (select custno from #target_arcust# where area='#getarea.area#')
					group by category 
					order by category
			</cfquery>
		

		<cfloop query="getitem">
			<cfwddx action = "cfml2wddx" input = "#getitem.category#" output = "wddxText2">

			<Row ss:AutoFitHeight="0" ss:Height="12">
				<Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText2#</Data></Cell>
                <Cell ss:StyleID="s29"><Data ss:Type="Number">#getitem.amt#</Data></Cell>
				<Cell ss:StyleID="s35"><Data ss:Type="Number">#getitem.qty#</Data></Cell>
				<cfset subamt = subamt + getitem.amt>
                    <cfset subqty = subqty + getitem.qty>
                    
                    <cfset totalamt = totalamt + getitem.amt>
                    <cfset totalqty = totalqty + getitem.qty>
			</Row>
		</cfloop>
		<Row ss:AutoFitHeight="0" ss:Height="12">
			<Cell ss:StyleID="s30"><Data ss:Type="String">CATEGORY SUB-TOTAL</Data></Cell>
			<Cell ss:StyleID="s30"/>
            <Cell ss:StyleID="s31"><Data ss:Type="Number">#subamt#</Data></Cell>
			<Cell ss:StyleID="s36"><Data ss:Type="Number">#subqty#</Data></Cell>
		</Row>
		<Row ss:AutoFitHeight="0" ss:Height="12"/>
        
        <cfquery name="getitem2" datasource="#dts#">
					select 
					itemno,wos_group,
					sum(qty) as qty,
					sum(amt) as amt 
					from ictran 
					where type in ('INV','CS','DN')
					and (void = '' or void is null)
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear# 
					</cfif>
                    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
                    <cfif form.agentfrom neq "" and form.agentto neq "">
					and agenno between '#form.agentfrom#' and '#form.agentto#'
					</cfif>
                    and custno in (select custno from #target_arcust# where area='#getarea.area#')
					group by wos_group 
					order by wos_group
			</cfquery>
		

		<cfloop query="getitem2">
			<cfwddx action = "cfml2wddx" input = "#getitem2.wos_group#" output = "wddxText2">

			<Row ss:AutoFitHeight="0" ss:Height="12">
				<Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText2#</Data></Cell>
                <Cell ss:StyleID="s29"><Data ss:Type="Number">#getitem2.amt#</Data></Cell>
				<Cell ss:StyleID="s35"><Data ss:Type="Number">#getitem2.qty#</Data></Cell>
				<cfset subamt2 = subamt2 + getitem2.amt>
                    <cfset subqty2 = subqty2 + getitem2.qty>
                    
                    <cfset totalamt2 = totalamt2 + getitem2.amt>
                    <cfset totalqty2 = totalqty2 + getitem2.qty>
			</Row>
		</cfloop>
		<Row ss:AutoFitHeight="0" ss:Height="12">
			<Cell ss:StyleID="s30"><Data ss:Type="String">GROUP SUB-TOTAL</Data></Cell>
			<Cell ss:StyleID="s30"/>
            <Cell ss:StyleID="s31"><Data ss:Type="Number">#subamt2#</Data></Cell>
			<Cell ss:StyleID="s36"><Data ss:Type="Number">#subqty2#</Data></Cell>
		</Row>
		<Row ss:AutoFitHeight="0" ss:Height="12"/>
        
	</cfloop>
	<Row ss:AutoFitHeight="0" ss:Height="12">
		<Cell ss:StyleID="s32"><Data ss:Type="String">CATEGORY TOTAL</Data></Cell>
		<Cell ss:StyleID="s32"/>
        <Cell ss:StyleID="s33"><Data ss:Type="Number">#totalamt#</Data></Cell>
		<Cell ss:StyleID="s37"><Data ss:Type="Number">#totalqty#</Data></Cell>
		
	</Row>
    <Row ss:AutoFitHeight="0" ss:Height="12">
		<Cell ss:StyleID="s32"><Data ss:Type="String">GROUP TOTAL</Data></Cell>
		<Cell ss:StyleID="s32"/>
        <Cell ss:StyleID="s33"><Data ss:Type="Number">#totalamt2#</Data></Cell>
		<Cell ss:StyleID="s37"><Data ss:Type="Number">#totalqty2#</Data></Cell>
		
	</Row>
	</Table>
	</cfoutput>
	<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
	<Unsynced/>
	<Print>
	<ValidPrinterInfo/>
	<HorizontalResolution>600</HorizontalResolution>
	<VerticalResolution>600</VerticalResolution>
	</Print>
	<Selected/>
	<Panes>
	<Pane>
	<Number>3</Number>
	<ActiveRow>12</ActiveRow>
	<ActiveCol>1</ActiveCol>
	</Pane>
	</Panes>
	<ProtectObjects>False</ProtectObjects>
	<ProtectScenarios>False</ProtectScenarios>
	</WorksheetOptions>
	</Worksheet>
	</Workbook>
	</cfxml>

	<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\ItemSaleRType_CP_Sales_#huserid#.xls" output="#tostring(data)#" >
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\ItemSaleRType_CP_Sales_#huserid#.xls">
<!---
	<cffile action="write" nameconflict="overwrite" file="C:\Inetpub\wwwroot\WOS\Excel_Report\#dts#\ItemSaleRType_CP_Sales_#huserid#.xls" output="#tostring(data)#">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="C:\Inetpub\wwwroot\WOS\Excel_Report\#dts#\ItemSaleRType_CP_Sales_#huserid#.xls">
--->
	</cfcase>

	<cfcase value="HTML">
	<html>
	<head>
	<title> Area - Category Item Report</title>
	<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
	</head>

	<body>
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = ",___.">

	<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		<cfset stDecl_UPrice = stDecl_UPrice & "_">
	</cfloop>

	<cfquery name="getarea" datasource="#dts#">
		select * from #target_arcust# where custno in (select custno from artran group by custno) group by area
	</cfquery>
	
	<cfoutput>
    <cfif isdefined('form.foc')>
    <cfset columncount = 10>
    <cfset rowcom = 8>
    <cfset comcom = 4>
    <cfelse>
    <cfset columncount = 9>
    <cfset rowcom = 7>
    <cfset comcom = 3>
    </cfif>
	<table width="100%" border="0" cellspacing="0" cellpadding="2">
		<tr>
			<td colspan="#columncount#"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>#trantype# REPORT</strong></font></div></td>
		</tr>
		<cfif form.periodfrom neq "" and form.periodto neq "">
			<tr>
				<td colspan="#columncount#"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
			</tr>
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
			<tr>
				<td colspan="#columncount#"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #form.datefrom# - #form.dateto#</font></div></td>
			</tr>
		</cfif>
		<cfif form.agentfrom neq "" and form.agentto neq "">
			<tr>
				<td colspan="#columncount#"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
			</tr>
		</cfif>
		<cfif form.areafrom neq "" and form.areato neq "">
			<tr>
				<td colspan="#columncount#"><div align="center"><font size="2" face="Times New Roman, Times, serif">AREA: #form.areafrom# - #form.areato#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
			<tr>
				<td colspan="#columncount#"><div align="center"><font size="2" face="Times New Roman, Times, serif">CUST_NO: #form.custfrom# - #form.custto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			<tr>
				<td colspan="#columncount#"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATEGORY: #form.catefrom# - #form.cateto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			<tr>
				<td colspan="#columncount#"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			<tr>
				<td colspan="#columncount#"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM_NO: #form.itemfrom# - #form.itemto#</font></div></td>
			</tr>
		</cfif>
		<tr>
			<td colspan="2"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td colspan="#comcom#"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		<tr>
			<td colspan="#columncount#"><hr></td>
		</tr>
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">AREA</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">CATEGORY</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">LOCAL SUB TOTAL</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
		</tr>
		<tr>
			<td colspan="#columncount#"><hr></td>
		</tr>

		<cfset totalamt = 0>
		<cfset totalqty = 0>
        <cfset totalamt2 = 0>
		<cfset totalqty2 = 0>

		<cfloop query="getarea">
			<cfset subamt = 0>
			<cfset subqty = 0>
            <cfset subamt2 = 0>
			<cfset subqty2 = 0>

			<tr>
				<td><div align="left"><strong><u>#getarea.area#</u></strong></div></td>
			</tr>

			<cfquery name="getitem" datasource="#dts#">
					select 
					itemno,category,
					sum(qty) as qty,
					sum(amt) as amt 
					from ictran 
					where type in ('INV','CS','DN')
					and (void = '' or void is null)
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear# 
					</cfif>
                    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
                    <cfif form.agentfrom neq "" and form.agentto neq "">
					and agenno between '#form.agentfrom#' and '#form.agentto#'
					</cfif>
                    and custno in (select custno from #target_arcust# where area='#getarea.area#')
					group by category 
					order by category
			</cfquery>

			<cfloop query="getitem">

				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td>&nbsp;</td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.category#</font></div></td>
                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitem.amt#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitem.qty#</font></div></td>
					<cfset subamt = subamt + getitem.amt>
                    <cfset subqty = subqty + getitem.qty>
                    
                    <cfset totalamt = totalamt + getitem.amt>
                    <cfset totalqty = totalqty + getitem.qty>
				 <cfflush>
			</cfloop>

			<tr>
				<td colspan="#columncount#"><hr></td>
			</tr>
			<tr>
				<td><div align="right"></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">CATEGORY SUB_TOTAL:</strong></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subamt,stDecl_UPrice)#</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subqty,"0")#</font></div></td>
				
			</tr>
			<tr><td colspan="100%"><hr></td></tr>
			<cfflush>
            <cfquery name="getitem2" datasource="#dts#">
					select 
					itemno,wos_group,
					sum(qty) as qty,
					sum(amt) as amt 
					from ictran 
					where type in ('INV','CS','DN')
					and (void = '' or void is null)
                    <cfif isdefined('form.foc')>
                    and (foc = '' or foc = 'N' or foc is null)
                    </cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod between '#form.periodfrom#' and '#form.periodto#'
					</cfif>
					<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between '#ndatefrom#' and '#ndateto#'
					<cfelse>
					and wos_date > #getgeneral.lastaccyear# 
					</cfif>
                    <cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and category between '#form.catefrom#' and '#form.cateto#'
					</cfif> 
                    <cfif form.agentfrom neq "" and form.agentto neq "">
					and agenno between '#form.agentfrom#' and '#form.agentto#'
					</cfif>
                    and custno in (select custno from #target_arcust# where area='#getarea.area#')
					group by wos_group 
					order by wos_group
			</cfquery>

			<cfloop query="getitem2">

				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td>&nbsp;</td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem2.wos_group#</font></div></td>
                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitem2.amt#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getitem2.qty#</font></div></td>
					<cfset subamt2 = subamt2 + getitem2.amt>
                    <cfset subqty2 = subqty2 + getitem2.qty>
                    
                    <cfset totalamt2 = totalamt2 + getitem2.amt>
                    <cfset totalqty2 = totalqty2 + getitem2.qty>
				 <cfflush>
			</cfloop>

			<tr>
				<td colspan="#columncount#"><hr></td>
			</tr>
			<tr>
				<td><div align="right"></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">GROUP SUB_TOTAL:</strong></font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subamt2,stDecl_UPrice)#</font></div></td>
                <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subqty2,"0")#</font></div></td>
				
			</tr>
            <tr><td colspan="100%"><hr></td></tr>
			<tr><td><br></td></tr>
			<cfflush>
            
            
		</cfloop>
		<tr>
			<td colspan="#columncount#"><hr></td>
		</tr>
		<tr>
			<td><div align="right"></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>CATEGORY TOTAL:</strong></font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalamt,",___.__")#</strong></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalqty,"0")#</strong></font></div></td>

		</tr>
        <tr>
			<td colspan="#columncount#"><hr></td>
		</tr>
		<tr>
			<td><div align="right"></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>GROUP TOTAL:</strong></font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalamt2,",___.__")#</strong></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalqty2,"0")#</strong></font></div></td>

		</tr>
        <tr>
			<td colspan="#columncount#"><hr></td>
		</tr>
	  </table>
	</cfoutput>

	<cfif getarea.recordcount eq 0>
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