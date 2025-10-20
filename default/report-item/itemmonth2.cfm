<cfset monthtotal = arraynew(1)>
<cfset vtotal = arraynew(1)>
<cfset m = arraynew(1)>

<cfif form.period neq "4">
	<cfset start = 1>
	<cfset end = 6>
<cfelse>
	<cfset start = 1>
	<cfset end = 18>
</cfif>

<cfloop index="a" from="#start#" to="#end#">
	<cfset vtotal[a] = 0>
</cfloop>

<cfif form.period eq "1">
	<cfset startperiod = 1>
	<cfset endperiod = 6>
<cfelseif form.period eq "2">
	<cfset startperiod = 7>
	<cfset endperiod = 12>
<cfelseif form.period eq "3">
	<cfset startperiod = 13>
	<cfset endperiod = 18>
<cfelse>
	<cfset startperiod = 1>
	<cfset endperiod = 18>
</cfif>

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,agentlistuserid from gsetup
</cfquery>

<cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">

	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = "">

	<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		<cfset stDecl_UPrice = stDecl_UPrice & "0">
	</cfloop>

	<cfquery name="getagent" datasource="#dts#">
		select agenno from ictran where wos_date > #getgeneral.lastaccyear#
		and (type = 'INV' or type = 'CS' or type = 'DN') and (void = '' or void is null)
		<cfif form.agentfrom neq "" and form.agentto neq "">
		and agenno >='#form.agentfrom#' and agenno <='#form.agentto#'
		</cfif>
        
        <cfif alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
        
		<cfif form.period eq "1">
		and fperiod >= 1 and fperiod <= 6
		<cfelseif form.period eq "2">
		and fperiod >= 7 and fperiod <= 12
		<cfelseif form.period eq "3">
		and fperiod >= 13 and fperiod <= 18
		<cfelse>
		and fperiod >= 1 and fperiod <= 18
		</cfif>
		group by agenno order by agenno
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
	<Worksheet ss:Name="ITEM SALES REPORT BY MONTH">
	<cfoutput>
	<Table ss:ExpandedColumnCount="9" x:FullColumns="1" x:FullRows="1">
	<Column ss:AutoFitWidth="0" ss:Width="83.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="170.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="80.5" ss:Span="6"/>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:MergeAcross="8" ss:StyleID="s22"><Data ss:Type="String">#trantype# REPORT</Data></Cell>
	</Row>

	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="8" ss:StyleID="s24">
		<Data ss:Type="String">
		<cfif form.period eq "1">
		PERIOD 1 - 6
		<cfelseif form.period eq "2">
		PERIOD 7 - 12
		<cfelseif form.period eq "3">
		PERIOD 13 - 18
		<cfelse>
		ONE YEAR
		</cfif>
		</Data>
		</Cell>
	</Row>

	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		<cfwddx action = "cfml2wddx" input = "ITEM NO: #form.itemfrom# - #form.itemto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="8" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif form.agentfrom neq "" and form.agentto neq "">
		<cfwddx action = "cfml2wddx" input = "AGENT NO: #form.agentfrom# - #form.agentto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="8" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>

	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s26"><Data ss:Type="String"><cfif getgeneral.compro neq "">#getgeneral.compro#</cfif></Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
	</Row>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:StyleID="s27"><Data ss:Type="String">CUST.NO</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">NAME</Data></Cell>

		<cfif form.period eq "1">
			<cfloop index="l" from="1" to="6">
				<cfset reportmonth = month(getgeneral.lastaccyear) + l>
				<cfif reportmonth gt 12>
					<cfset reportmonth1 = reportmonth mod 12>
					<cfif reportmonth1 eq 0>
						<cfset reportmonth = 12>
					<cfelse>
						<cfset reportmonth = reportmonth1>
					</cfif>
					<cfwddx action = "cfml2wddx" input = "#dateformat(createdate(2002,reportmonth,1),"mmm")#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
				<cfelse>
					<cfset reportmonth1 = reportmonth mod 12>
					<cfif reportmonth1 eq 0>
						<cfset reportmonth = 12>
					<cfelse>
						<cfset reportmonth = reportmonth1>
					</cfif>
					<cfwddx action = "cfml2wddx" input = "#dateformat(createdate(2002,reportmonth,1),"mmm")#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
				</cfif>
			</cfloop>
		<cfelseif form.period eq "2">
			<cfloop index="l" from="7" to="12">
				<cfset reportmonth = month(getgeneral.lastaccyear) + l>
				<cfif reportmonth gt 12>
					<cfset reportmonth1 = reportmonth mod 12>
					<cfif reportmonth1 eq 0>
						<cfset reportmonth = 12>
					<cfelse>
						<cfset reportmonth = reportmonth1>
					</cfif>
					<cfwddx action = "cfml2wddx" input = "#dateformat(createdate(2002,reportmonth,1),"mmm")#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
				<cfelse>
					<cfset reportmonth1 = reportmonth mod 12>
					<cfif reportmonth1 eq 0>
						<cfset reportmonth = 12>
					<cfelse>
						<cfset reportmonth = reportmonth1>
					</cfif>
					<cfwddx action = "cfml2wddx" input = "#dateformat(createdate(2002,reportmonth,1),"mmm")#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
				</cfif>
			</cfloop>
		<cfelseif form.period eq "3">
			<cfloop index="l" from="13" to="18">
				<cfset reportmonth = month(getgeneral.lastaccyear) + l>
				<cfif reportmonth gt 12>
					<cfset reportmonth1 = reportmonth mod 12>
					<cfif reportmonth1 eq 0>
						<cfset reportmonth = 12>
					<cfelse>
						<cfset reportmonth = reportmonth1>
					</cfif>
					<cfwddx action = "cfml2wddx" input = "#dateformat(createdate(2002,reportmonth,1),"mmm")#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
				<cfelse>
					<cfset reportmonth1 = reportmonth mod 12>
					<cfif reportmonth1 eq 0>
						<cfset reportmonth = 12>
					<cfelse>
						<cfset reportmonth = reportmonth1>
					</cfif>
					<cfwddx action = "cfml2wddx" input = "#dateformat(createdate(2002,reportmonth,1),"mmm")#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
				</cfif>
			</cfloop>
		<cfelse>
			<cfloop index="l" from="1" to="18">
				<cfset reportmonth = month(getgeneral.lastaccyear) + l>
				<cfif reportmonth gt 12>
					<cfset reportmonth1 = reportmonth mod 12>
					<cfif reportmonth1 eq 0>
						<cfset reportmonth = 12>
					<cfelse>
						<cfset reportmonth = reportmonth1>
					</cfif>
					<cfwddx action = "cfml2wddx" input = "#dateformat(createdate(2002,reportmonth,1),"mmm")#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
				<cfelse>
					<cfset reportmonth1 = reportmonth mod 12>
					<cfif reportmonth1 eq 0>
						<cfset reportmonth = 12>
					<cfelse>
						<cfset reportmonth = reportmonth1>
					</cfif>
					<cfwddx action = "cfml2wddx" input = "#dateformat(createdate(2002,reportmonth,1),"mmm")#" output = "wddxText">
					<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
				</cfif>
			</cfloop>
		</cfif>
		<Cell ss:StyleID="s27"><Data ss:Type="String">TOTAL</Data></Cell>
	</Row>
	<cfloop query="getagent">
		<cfset agenno = getagent.agenno>

		<cfloop index="a" from="#start#" to="#end#">
			<cfset monthtotal[a] = 0>
		</cfloop>

		<Row ss:AutoFitHeight="0" ss:Height="12">


			<cfif getagent.agenno eq "">
				<Cell ss:StyleID="s34"><Data ss:Type="String">No - Agent</Data></Cell>
				<Cell ss:StyleID="s34"><Data ss:Type="String">No - Agent</Data></Cell>
			<cfelse>
				<cfquery name="getagentdesp" datasource="#dts#">
					select desp from icagent where agent = '#getagent.agenno#'
				</cfquery>
				<cfwddx action = "cfml2wddx" input = "#getagent.agenno#" output = "wddxText1">
				<cfwddx action = "cfml2wddx" input = "#getagentdesp.desp#" output = "wddxText2">
				<Cell ss:StyleID="s34"><Data ss:Type="String">#wddxText1#</Data></Cell>
				<Cell ss:StyleID="s34"><Data ss:Type="String">#wddxText2#</Data></Cell>
			</cfif>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
		</Row>

		<cfquery name="getcust" datasource="#dts#">
			select custno,name from ictran where wos_date > #getgeneral.lastaccyear#
			and (type = 'INV' or type = 'CS' or type = 'DN') and agenno = '#agenno#' and (void = '' or void is null)
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno >='#form.itemfrom#' and itemno <= '#form.itemto#'
			</cfif>
			<cfif form.period eq "1">
			and fperiod >= 1 and fperiod <= 6
			<cfelseif form.period eq "2">
			and fperiod >= 7 and fperiod <= 12
			<cfelseif form.period eq "3">
			and fperiod >= 13 and fperiod <= 18
			<cfelse>
			and fperiod >= 1 and fperiod <= 18
			</cfif>
			group by custno order by custno
		</cfquery>

		<cfloop query="getcust">
			<cfset custno = getcust.custno>
			<cfset subtotal = 0>

			<cfwddx action = "cfml2wddx" input = "#getcust.custno#" output = "wddxText1">
			<cfwddx action = "cfml2wddx" input = "#getcust.name#" output = "wddxText2">

			<Row ss:AutoFitHeight="0" ss:Height="12">
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1#</Data></Cell>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText2#</Data></Cell>

				<cfloop index="i" from="#startperiod#" to="#endperiod#">
					<cfquery name="getresult" datasource="#dts#">
						select fperiod,sum(amt) as sumamt, sum(qty) as sumqty from ictran
						where custno = '#custno#' and agenno = '#agenno#' and (type='inv' or type='dn' or type='cs')
						and fperiod = #i# and wos_date > #getgeneral.lastaccyear# and (void = '' or void is null)
						<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
						and itemno >='#form.itemfrom#' and itemno <= '#form.itemto#'
						</cfif>
						group by fperiod
					</cfquery>

					<cfif form.label neq "salesqty">
						<cfif form.period eq "1" or form.period eq "4">
							<cfset m[i] = val(getresult.sumamt)>
						<cfelseif form.period eq "2">
							<cfset m[i-6] = val(getresult.sumamt)>
						<cfelseif form.period eq "3">
							<cfset m[i-12] = val(getresult.sumamt)>
						</cfif>
					<cfelse>
						<cfif form.period eq "1" or form.period eq "4">
							<cfset m[i] = val(getresult.sumqty)>
						<cfelseif form.period eq "2">
							<cfset m[i-6] = val(getresult.sumqty)>
						<cfelseif form.period eq "3">
							<cfset m[i-12] = val(getresult.sumqty)>
						</cfif>
					</cfif>
				</cfloop>

				<cfloop index="j" from="#start#" to="#end#">
					<cfif form.label neq "salesqty">
						<Cell ss:StyleID="s29"><Data ss:Type="Number">#m[j]#</Data></Cell>
					<cfelse>
						<Cell ss:StyleID="s35"><Data ss:Type="Number">#m[j]#</Data></Cell>
					</cfif>

					<cfset subtotal = subtotal + m[j]>
					<cfset monthtotal[j] = monthtotal[j] + m[j]>
					<cfset vtotal[j] = vtotal[j] + m[j]>
				</cfloop>

				<cfif form.label neq "salesqty">
					<Cell ss:StyleID="s29"><Data ss:Type="Number">#subtotal#</Data></Cell>
				<cfelse>
					<Cell ss:StyleID="s35"><Data ss:Type="Number">#subtotal#</Data></Cell>
				</cfif>
			</Row>
		</cfloop>
		<cfif isdefined("form.includesubtotal")>
		<Row ss:AutoFitHeight="0" ss:Height="12">
			<Cell ss:StyleID="s30"><Data ss:Type="String">SUB-TOTAL:</Data></Cell>
			<Cell ss:StyleID="s30"/>

			<cfloop index="q" from="#start#" to="#end#">
				<cfif form.label neq "salesqty">
					<Cell ss:StyleID="s31"><Data ss:Type="Number">#monthtotal[q]#</Data></Cell>
				<cfelse>
					<Cell ss:StyleID="s36"><Data ss:Type="Number">#monthtotal[q]#</Data></Cell>
				</cfif>
			</cfloop>

			<cfif form.label neq "salesqty">
				<Cell ss:StyleID="s31"><Data ss:Type="Number">#arraysum(monthtotal)#</Data></Cell>
			<cfelse>
				<Cell ss:StyleID="s36"><Data ss:Type="Number">#arraysum(monthtotal)#</Data></Cell>
			</cfif>
		</Row>
		<Row ss:AutoFitHeight="0" ss:Height="12"/>
		</cfif>
	</cfloop>

	<Row ss:AutoFitHeight="0" ss:Height="12">
		<Cell ss:StyleID="s32"><Data ss:Type="String">TOTAL:</Data></Cell>
		<Cell ss:StyleID="s32"/>
		<cfloop index="q" from="#start#" to="#end#">
			<cfif form.label neq "salesqty">
				<Cell ss:StyleID="s33"><Data ss:Type="Number">#vtotal[q]#</Data></Cell>
			<cfelse>
				<Cell ss:StyleID="s37"><Data ss:Type="Number">#vtotal[q]#</Data></Cell>
			</cfif>
		</cfloop>

		<cfif form.label neq "salesqty">
			<Cell ss:StyleID="s33"><Data ss:Type="Number">#arraysum(vtotal)#</Data></Cell>
		<cfelse>
			<Cell ss:StyleID="s37"><Data ss:Type="Number">#arraysum(vtotal)#</Data></Cell>
		</cfif>
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

	<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\ItemSaleRMonth_AC_Sales_#huserid#.xls" output="#tostring(data)#">
    <cfheader name="Content-Disposition" value="inline; filename=ItemSaleRMonth_AC_Sales_#huserid#.xls">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\ItemSaleRMonth_AC_Sales_#huserid#.xls">
<!---
	<cffile action="write" nameconflict="overwrite" file="C:\Inetpub\wwwroot\WOS\Excel_Report\#dts#\ItemSaleRMonth_AC_Sales_#huserid#.xls" output="#tostring(data)#">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="C:\Inetpub\wwwroot\WOS\Excel_Report\#dts#\ItemSaleRMonth_AC_Sales_#huserid#.xls">
--->

	</cfcase>

	<cfcase value="HTML">
	<html>
	<head>
	<title>Cust/Supp/Agent/Area Item Report By Month - Agent-Customer Sales</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
	<style type="text/css" media="print">
		.noprint { display: none; }
	</style>
	</head>

	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = ",___.">

	<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	  <cfset stDecl_UPrice = stDecl_UPrice & "_">
	</cfloop>

	<cfquery name="getagent" datasource="#dts#">
		select agenno from ictran where wos_date > #getgeneral.lastaccyear#
		and (type = 'INV' or type = 'CS' or type = 'DN') and (void = '' or void is null)
		<cfif form.agentfrom neq "" and form.agentto neq "">
		and agenno >='#form.agentfrom#' and agenno <='#form.agentto#'
		</cfif>
        
        <cfif alown eq 1>
					<cfif getgeneral.agentlistuserid eq "Y">and ucase(agenno) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(userid)='#ucase(huserid)#' or ucase(agenno)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
					<cfif Huserloc neq "All_loc">
					and (userid in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
					</cfif>
        
		<cfif form.period eq "1">
		and fperiod >= 1 and fperiod <= 6
		<cfelseif form.period eq "2">
		and fperiod >= 7 and fperiod <= 12
		<cfelseif form.period eq "3">
		and fperiod >= 13 and fperiod <= 18
		<cfelse>
		and fperiod >= 1 and fperiod <= 18
		</cfif>
		group by agenno order by agenno
	</cfquery>

	<body>
	<cfoutput>
	  <table width="100%" border="0" cellspacing="0" cellpadding="2">
		<tr>
			<td colspan="9"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>#trantype# REPORT</strong></font></div></td>
		</tr>
		<tr>
		  <td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">
			<cfif form.period eq "1">
			PERIOD 1 - 6
			<cfelseif form.period eq "2">
			PERIOD 7 - 12
			<cfelseif form.period eq "3">
			PERIOD 13 - 18
			<cfelse>
			ONE YEAR
			</cfif>
		  </font></div>
		  </td>
		</tr>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			<tr>
			  <td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM NO: #form.itemfrom# - #form.itemto#</font></div></td>
			</tr>
		</cfif>
		<cfif form.agentfrom neq "" and form.agentto neq "">
			<tr>
			  <td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT NO: #form.agentfrom# - #form.agentto#</font></div></td>
			</tr>
		</cfif>
		<tr>
		  <td colspan="4"><font size="2" face="Times New Roman, Times, serif"><cfif getgeneral.compro neq "">#getgeneral.compro#</cfif></font></td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		<tr>
		  <td colspan="21"><hr></td>
		</tr>
		<tr>
		  <td><font size="2" face="Times New Roman, Times, serif">CUST.NO</font></td>
		  <td><font size="2" face="Times New Roman, Times, serif">NAME</font></td>

			<cfif form.period eq "1">
				<cfloop index="l" from="1" to="6">
					<cfset reportmonth = month(getgeneral.lastaccyear) + l>
					<cfif reportmonth gt 12>
						<cfset reportmonth1 = reportmonth mod 12>
						<cfif reportmonth1 eq 0>
							<cfset reportmonth = 12>
						<cfelse>
							<cfset reportmonth = reportmonth1>
						</cfif>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(createdate(2002,reportmonth,1),"mmm")#</font></div></td>
					<cfelse>
						<cfset reportmonth1 = reportmonth mod 12>
						<cfif reportmonth1 eq 0>
							<cfset reportmonth = 12>
						<cfelse>
							<cfset reportmonth = reportmonth1>
						</cfif>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(createdate(2002,reportmonth,1),"mmm")#</font></div></td>
					</cfif>
				</cfloop>
			<cfelseif form.period eq "2">
				<cfloop index="l" from="7" to="12">
					<cfset reportmonth = month(getgeneral.lastaccyear) + l>
					<cfif reportmonth gt 12>
						<cfset reportmonth1 = reportmonth mod 12>
						<cfif reportmonth1 eq 0>
							<cfset reportmonth = 12>
						<cfelse>
							<cfset reportmonth = reportmonth1>
						</cfif>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(createdate(2002,reportmonth,1),"mmm")#</font></div></td>
					<cfelse>
						<cfset reportmonth1 = reportmonth mod 12>
						<cfif reportmonth1 eq 0>
							<cfset reportmonth = 12>
						<cfelse>
							<cfset reportmonth = reportmonth1>
						</cfif>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(createdate(2002,reportmonth,1),"mmm")#</font></div></td>
					</cfif>
				</cfloop>
			<cfelseif form.period eq "3">
				<cfloop index="l" from="13" to="18">
					<cfset reportmonth = month(getgeneral.lastaccyear) + l>
					<cfif reportmonth gt 12>
						<cfset reportmonth1 = reportmonth mod 12>
						<cfif reportmonth1 eq 0>
							<cfset reportmonth = 12>
						<cfelse>
							<cfset reportmonth = reportmonth1>
						</cfif>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(createdate(2002,reportmonth,1),"mmm")#</font></div></td>
					<cfelse>
						<cfset reportmonth1 = reportmonth mod 12>
						<cfif reportmonth1 eq 0>
							<cfset reportmonth = 12>
						<cfelse>
							<cfset reportmonth = reportmonth1>
						</cfif>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(createdate(2002,reportmonth,1),"mmm")#</font></div></td>
					</cfif>
				</cfloop>
			<cfelse>
				<cfloop index="l" from="1" to="18">
					<cfset reportmonth = month(getgeneral.lastaccyear) + l>
					<cfif reportmonth gt 12>
						<cfset reportmonth1 = reportmonth mod 12>
						<cfif reportmonth1 eq 0>
							<cfset reportmonth = 12>
						<cfelse>
							<cfset reportmonth = reportmonth1>
						</cfif>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(createdate(2002,reportmonth,1),"mmm")#</font></div></td>
					<cfelse>
						<cfset reportmonth1 = reportmonth mod 12>
						<cfif reportmonth1 eq 0>
							<cfset reportmonth = 12>
						<cfelse>
							<cfset reportmonth = reportmonth1>
						</cfif>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(createdate(2002,reportmonth,1),"mmm")#</font></div></td>
					</cfif>
				</cfloop>
			</cfif>
		  <td><div align="right"><font size="2" face="Times New Roman, Times, serif">TOTAL</font></div></td>
		</tr>
		<tr>
		  <td colspan="21"><hr></td>
		</tr>

	<cfloop query="getagent">
		<cfset agenno = getagent.agenno>

		<cfloop index="a" from="#start#" to="#end#">
			<cfset monthtotal[a] = 0>
		</cfloop>

		<tr>
			<cfif getagent.agenno eq "">
				<td><div align="left"><u><strong>No - Agent</strong></u></div></td>
				<td><div align="left"><u><strong>No - Agent</strong></u></div></td>
			<cfelse>
				<cfquery name="getagentdesp" datasource="#dts#">
					select desp from icagent where agent = '#getagent.agenno#'
				</cfquery>
				<td><div align="left"><u><strong>#getagent.agenno#</strong></u></div></td>
				<td><div align="left"><u><strong>#getagentdesp.desp#</strong></u></div></td>
			</cfif>
		</tr>

		<cfquery name="getcust" datasource="#dts#">
			select custno,name from ictran where wos_date > #getgeneral.lastaccyear#
			and (type = 'INV' or type = 'CS' or type = 'DN') and agenno = '#agenno#' and (void = '' or void is null)
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno >='#form.itemfrom#' and itemno <= '#form.itemto#'
			</cfif>
			<cfif form.period eq "1">
			and fperiod >= 1 and fperiod <= 6
			<cfelseif form.period eq "2">
			and fperiod >= 7 and fperiod <= 12
			<cfelseif form.period eq "3">
			and fperiod >= 13 and fperiod <= 18
			<cfelse>
			and fperiod >= 1 and fperiod <= 18
			</cfif>
			group by custno order by custno
		</cfquery>

		<cfloop query="getcust">
			<cfset custno = getcust.custno>
			<cfset subtotal = 0>
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><font size="2" face="Times New Roman, Times, serif">#getcust.custno#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getcust.name#</font></td>

				<cfloop index="i" from="#startperiod#" to="#endperiod#">
					<cfquery name="getresult" datasource="#dts#">
						select fperiod,sum(amt) as sumamt, sum(qty) as sumqty from ictran
						where custno = '#custno#' and agenno = '#agenno#' and (type='inv' or type='dn' or type='cs')
						and fperiod = #i# and wos_date > #getgeneral.lastaccyear# and (void = '' or void is null)
						<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
						and itemno >='#form.itemfrom#' and itemno <= '#form.itemto#'
						</cfif>
						group by fperiod
					</cfquery>

					<cfif form.label neq "salesqty">
						<cfif form.period eq "1" or form.period eq "4">
							<cfset m[i] = val(getresult.sumamt)>
						<cfelseif form.period eq "2">
							<cfset m[i-6] = val(getresult.sumamt)>
						<cfelseif form.period eq "3">
							<cfset m[i-12] = val(getresult.sumamt)>
						</cfif>
					<cfelse>
						<cfif form.period eq "1" or form.period eq "4">
							<cfset m[i] = val(getresult.sumqty)>
						<cfelseif form.period eq "2">
							<cfset m[i-6] = val(getresult.sumqty)>
						<cfelseif form.period eq "3">
							<cfset m[i-12] = val(getresult.sumqty)>
						</cfif>
					</cfif>
				</cfloop>

				<cfloop index="j" from="#start#" to="#end#">
					<cfif form.label neq "salesqty">
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(m[j],(stDecl_UPrice))#</font></div></td>
					<cfelse>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(m[j],"0")#</font></div></td>
					</cfif>

					<cfset subtotal = subtotal + m[j]>
					<cfset monthtotal[j] = monthtotal[j] + m[j]>
					<cfset vtotal[j] = vtotal[j] + m[j]>
				</cfloop>

				<cfif form.label neq "salesqty">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subtotal,(stDecl_UPrice))#</font></div></td>
				<cfelse>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(subtotal,"0")#</font></div></td>
				</cfif>
			</tr>
		</cfloop>
		
		<cfif isdefined("form.includesubtotal")>
			<tr>
				<td colspan="22"><hr></td>
			</tr>
			<tr>
				<td></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">SUB-TOTAL:</font></div></td>
	
				<cfloop index="q" from="#start#" to="#end#">
					<cfif form.label neq "salesqty">
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(monthtotal[q],(stDecl_UPrice))#</font></div></td>
					<cfelse>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(monthtotal[q],"0")#</font></div></td>
					</cfif>
				</cfloop>
	
				<cfif form.label neq "salesqty">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(arraysum(monthtotal),(stDecl_UPrice))#</font></div></td>
				<cfelse>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(arraysum(monthtotal),"0")#</font></div></td>
				</cfif>
			</tr>
			<tr><td><br></td></tr>
		</cfif>
		
	</cfloop>
		<tr>
			<td colspan="22"><hr></td>
		</tr>
		<tr>
			<td></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>

			<cfloop index="q" from="#start#" to="#end#">
				<cfif form.label neq "salesqty">
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(vtotal[q],",.__")#</strong></font></div></td>
				<cfelse>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(vtotal[q],"0")#</strong></font></div></td>
				</cfif>
			</cfloop>

			<cfif form.label neq "salesqty">
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(arraysum(vtotal),",.__")#</strong></font></div></td>
			<cfelse>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(arraysum(vtotal),"0")#</strong></font></div></td>
			</cfif>
		</tr>
	</table>

	<cfif getcust.recordcount eq 0>
		<h3>Sorry, No records were found.</h3>
	</cfif>
	<br>
	<br>
	<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
	<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
	</cfoutput>
	</body>
	</html>
	</cfcase>
</cfswitch>