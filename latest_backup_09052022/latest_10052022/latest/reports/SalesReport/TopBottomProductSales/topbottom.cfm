<cfquery name="getgeneral" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfquery name="getitemlist" datasource='#dts#'>
select itemno from icitem where 1=1
<cfif form.brandfrom neq "" and form.brandto neq "">
and brand >='#form.brandfrom#' and brand <='#form.brandto#'
</cfif>

<cfif form.sizefrom neq "" and form.sizeto neq "">
and sizeid >='#form.sizefrom#' and sizeid <='#form.sizeto#'
</cfif>

<cfif form.materialfrom neq "" and form.materialto neq "">
and colorid >='#form.materialfrom#' and colorid <='#form.materialto#'
</cfif>

</cfquery>

<cfset itemlist=valuelist(getitemlist.itemno)>


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
	<cfcase value="EXCEL">
		<cfset rangenum = 50>
		<cfif form.showby eq "qty">
			<cfset msg = "By Sales Quantity">
		<cfelse>
			<cfset msg = "By Sales Value">
		</cfif>

		<cfxml variable="data">
		<?mso-application progid="Excel.Sheet"?>
		<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
		<Styles>
 			<Style ss:ID="Default" ss:Name="Normal">
		   		<Alignment ss:Vertical="Bottom"/>
		   		<Borders/>
		   		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9"/>
		   		<Interior/>
		   		<NumberFormat/>
		   		<Protection/>
		  	</Style>
		  	<Style ss:ID="s24">
		   		<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
					<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		  	</Style>
		  	<Style ss:ID="s28">
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		   		<NumberFormat ss:Format="#,###,###,##0"/>
		  	</Style>
		  	<Style ss:ID="s29">
		   		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  	</Style>
		  	<Style ss:ID="s30">
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		   		<NumberFormat ss:Format="@"/>
		  	</Style>
		  	<Style ss:ID="s31">
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   		</Borders>
		   		<NumberFormat ss:Format="#,###,###,##0"/>
		  	</Style>
		  	<Style ss:ID="s32">
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
		   		</Borders>
		   		<NumberFormat ss:Format="#,###,###,##0.00"/>
		  	</Style>
			<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
			<cfset stDecl_UPrice = "">

			<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
				<cfset stDecl_UPrice = stDecl_UPrice & "0">
			</cfloop>
		  	<Style ss:ID="s33">
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		   		<NumberFormat ss:Format="#,###,###,##0.<cfoutput>#trim(stDecl_UPrice)#</cfoutput>"/>
		  	</Style>
		  	<Style ss:ID="s34">
		   		<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   		<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="12" ss:Bold="1"/>
		  	</Style>
		  	<Style ss:ID="s35">
		   		<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  	</Style>
		  	<Style ss:ID="s37">
		   		<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  	</Style>
		  	<Style ss:ID="s39">
		   		<Alignment ss:Vertical="Center"/>
		   		<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   		</Borders>
		   		<Font ss:FontName="Verdana" x:Family="Swiss"/>
		  	</Style>
		</Styles>
		<cfoutput>
		<Worksheet ss:Name="Product_Sales_Report">
        			<cfset c="8">
					<cfif getdisplaydetail.report_aitemno eq 'Y'>
                    <cfset c=c+1>
                    </cfif>
                    <cfif getdisplaydetail.report_brand eq 'Y'>
                    <cfset c=c+1>
                    </cfif>
                    <cfif getdisplaydetail.report_category eq 'Y'>
                    <cfset c=c+1>
                    </cfif>
                    <cfif getdisplaydetail.report_group eq 'Y'>
                    <cfset c=c+1>
                    </cfif>
                    <cfif getdisplaydetail.report_sizeid eq 'Y'>
                    <cfset c=c+1>
                    </cfif>
                    <cfif getdisplaydetail.report_colorid eq 'Y'>
                    <cfset c=c+1>
                    </cfif>
                    <cfif getdisplaydetail.report_costcode eq 'Y'>
                    <cfset c=c+1>
                    </cfif>
                    <cfif getdisplaydetail.report_shelf eq 'Y'>
                    <cfset c=c+1>
                    </cfif>
  		<Table ss:ExpandedColumnCount="#20#" x:FullColumns="1" x:FullRows="1">
   			<Column ss:Width="21"/>
   			<Column ss:AutoFitWidth="0" ss:Width="123.75"/>
            <Column ss:AutoFitWidth="0" ss:Width="123.75"/>
   			<Column ss:AutoFitWidth="0" ss:Width="243.75"/>
   			<Column ss:AutoFitWidth="0" ss:Width="75.75" ss:Span="1"/>

            <Row ss:AutoFitHeight="0" ss:Height="23.0625">
                <Cell ss:MergeAcross="#c#" ss:StyleID="s34"><Data ss:Type="String">#trantype# #rangenum# PRODUCT SALES REPORT - #msg#</Data></Cell>
            </Row>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
    				<Cell ss:MergeAcross="#c#" ss:StyleID="s35"><Data ss:Type="String">PERIOD: #form.periodfrom# - #form.periodto#</Data></Cell>
   				</Row>
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "AGENT: #form.agentfrom# - #form.agentto#" output = "wddxText">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s35"><Data ss:Type="String">#wddxText#</Data></Cell>
			   	</Row>
			</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
				<Row ss:AutoFitHeight="0" ss:Height="20.0625">
					<cfwddx action = "cfml2wddx" input = "AREA: #form.areafrom# - #form.areato#" output = "wddxText">
					<Cell ss:MergeAcross="#c#" ss:StyleID="s35"><Data ss:Type="String">#wddxText#</Data></Cell>
		   		</Row>
			</cfif>
			<Row ss:AutoFitHeight="0" ss:Height="20.0625">
				<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
				<Cell ss:MergeAcross="#c-2#" ss:StyleID="s37"><Data ss:Type="String">#wddxText#</Data></Cell>
				<Cell ss:StyleID="s39"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
		   	</Row>
			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
				<Cell ss:StyleID="s24"><Data ss:Type="String">No.</Data></Cell>
				<Cell ss:StyleID="s24"><Data ss:Type="String">Item No.</Data></Cell>
                <cfif getdisplaydetail.report_aitemno eq 'Y'>
                <Cell ss:StyleID="s24"><Data ss:Type="String">Product Code.</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_brand eq 'Y'>
                <Cell ss:StyleID="s24"><Data ss:Type="String">#getgeneral.lbrand#.</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_category eq 'Y'>
                <Cell ss:StyleID="s24"><Data ss:Type="String">#getgeneral.lcategory#.</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_group eq 'Y'>
                <Cell ss:StyleID="s24"><Data ss:Type="String">#getgeneral.lgroup#.</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_sizeid eq 'Y'>
                <Cell ss:StyleID="s24"><Data ss:Type="String">#getgeneral.lsize#.</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_colorid eq 'Y'>
                <Cell ss:StyleID="s24"><Data ss:Type="String">#getgeneral.lmaterial#.</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_costcode eq 'Y'>
                <Cell ss:StyleID="s24"><Data ss:Type="String">#getgeneral.lrating#.</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_shelf eq 'Y'>
                <Cell ss:StyleID="s24"><Data ss:Type="String">#getgeneral.lmodel#.</Data></Cell>
                </cfif>
				<Cell ss:StyleID="s24"><Data ss:Type="String">Item Description</Data></Cell>
				<Cell ss:StyleID="s24"><Data ss:Type="String">Qty Sold</Data></Cell>
				<Cell ss:StyleID="s24"><Data ss:Type="String">Sales</Data></Cell>
		   	</Row>

			<cfset totalqty =0>
			<cfset totalamt =0>

			<cfquery name="getitem" datasource="#dts#">
			select a.itemno, desp, despa, sum(qty) as sumqty, sum(amt) as sumamt,b.sizeid,b.colorid,b.supp,b.wos_group,b.brand,b.category,b.shelf,b.aitemno,b.costcode from ictran as a
            left join (select supp,sizeid,colorid,itemno,aitemno,wos_group,brand,category,costcode,shelf from icitem) as b on a.itemno=b.itemno
			where (type = 'INV' <!---or type = 'DN'---> or type = 'CS') and wos_date > #getgeneral.lastaccyear# and (void = '' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
            and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
            <cfelse>
            and wos_date > #getgeneral.lastaccyear#
            </cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and agenno in(select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and area >='#form.areafrom#' and area <='#form.areato#'
			</cfif>
            <cfif form.customerfrom neq "" and form.customerto neq "">
			and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
			</cfif>
             and a.itemno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#itemlist#">)
            
			group by itemno
			<cfif form.showby eq "amt">
			order by sumamt
			<cfelse>
			order by sumqty
			</cfif>
			<cfif url.trantype eq "top">
			desc
			</cfif>
            ,itemno
            
		</cfquery>

			<cfif rangenum neq 0>
				<cfloop query="getitem" startrow="1" endrow="#rangenum#">
					<Row ss:Height="12">
						<Cell ss:StyleID="s28"><Data ss:Type="Number">#getitem.currentrow#.</Data></Cell>
						<cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText">
						<Cell ss:StyleID="s30"><Data ss:Type="String">#wddxText#</Data></Cell>
                        <cfif getdisplaydetail.report_aitemno eq 'Y'>
                        <cfwddx action = "cfml2wddx" input = "#getitem.aitemno#" output = "wddxText">
						<Cell ss:StyleID="s30"><Data ss:Type="String">#wddxText#</Data></Cell>
                        </cfif>
                        <cfif getdisplaydetail.report_brand eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getitem.brand#" output = "wddxText">
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_category eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getitem.category#" output = "wddxText">
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_group eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getitem.wos_group#" output = "wddxText">
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_sizeid eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getitem.sizeid#" output = "wddxText">
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_colorid eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getitem.colorid#" output = "wddxText">
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_costcode eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getitem.costcode#" output = "wddxText">
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
                <cfif getdisplaydetail.report_shelf eq 'Y'>
                <cfwddx action = "cfml2wddx" input = "#getitem.shelf#" output = "wddxText">
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
                </cfif>
						<cfwddx action = "cfml2wddx" input = "#getitem.desp##getitem.despa#" output = "wddxText">
						<Cell ss:StyleID="s30"><Data ss:Type="String">#wddxText#</Data></Cell>
						<cfset totalqty = totalqty + val(getitem.sumqty)>
						<Cell ss:StyleID="s28"><Data ss:Type="Number">#val(getitem.sumqty)#</Data></Cell>
						<cfset totalamt = totalamt + val(getitem.sumamt)>
						<Cell ss:StyleID="s33"><Data ss:Type="Number">#val(getitem.sumamt)#</Data></Cell>
		   			</Row>
				</cfloop>
			<cfelse>
				<cfloop query="getitem">
					<Row ss:Height="12">
						<Cell ss:StyleID="s28"><Data ss:Type="Number">#getitem.currentrow#.</Data></Cell>
						<cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText">
						<Cell ss:StyleID="s30"><Data ss:Type="String">#wddxText#</Data></Cell>
						<cfwddx action = "cfml2wddx" input = "#getitem.desp##getitem.despa#" output = "wddxText">
						<Cell ss:StyleID="s30"><Data ss:Type="String">#wddxText#</Data></Cell>
                        <cfif getdisplaydetail.report_aitemno eq 'Y'>
                        <cfwddx action = "cfml2wddx" input = "#getitem.aitemno#" output = "wddxText">
						<Cell ss:StyleID="s30"><Data ss:Type="String">#wddxText#</Data></Cell>
                        </cfif>
						<cfset totalqty = totalqty + val(getitem.sumqty)>
						<Cell ss:StyleID="s28"><Data ss:Type="Number">#val(getitem.sumqty)#</Data></Cell>
						<cfset totalamt = totalamt + val(getitem.sumamt)>
						<Cell ss:StyleID="s33"><Data ss:Type="Number">#val(getitem.sumamt)#</Data></Cell>
		   			</Row>
				</cfloop>
			</cfif>
			<Row ss:Height="12">
				<Cell ss:StyleID="s29"/>
                <Cell ss:StyleID="s29"/>
                <Cell ss:StyleID="s29"/>
                <Cell ss:StyleID="s29"/>
                <cfif getdisplaydetail.report_aitemno eq 'Y'>
            <Cell ss:StyleID="s29"/>
            </cfif>
            <cfif getdisplaydetail.report_brand eq 'Y'>
            <Cell ss:StyleID="s29"/>
            </cfif>
            <cfif getdisplaydetail.report_category eq 'Y'>
            <Cell ss:StyleID="s29"/>
            </cfif>
            <cfif getdisplaydetail.report_group eq 'Y'>
            <Cell ss:StyleID="s29"/>
            </cfif>
            <cfif getdisplaydetail.report_sizeid eq 'Y'>
            <Cell ss:StyleID="s29"/>
            </cfif>
            <cfif getdisplaydetail.report_colorid eq 'Y'>
            <Cell ss:StyleID="s29"/>
            </cfif>
            <cfif getdisplaydetail.report_costcode eq 'Y'>
            <Cell ss:StyleID="s29"/>
            </cfif>
            <cfif getdisplaydetail.report_shelf eq 'Y'>
            <Cell ss:StyleID="s29"/>
            </cfif>
				<Cell ss:StyleID="s31"><Data ss:Type="Number">#totalqty#</Data></Cell>
				<Cell ss:StyleID="s32"><Data ss:Type="Number">#totalamt#</Data></Cell>
		   	</Row>
			
		   	<Row ss:Height="12"/>
  		</Table>
		</Worksheet>
        </cfoutput>
		</Workbook>
		</cfxml>
		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\#trantype#_Product_Sales_Report_#msg#_#huserid#.xls" output="#tostring(data)#">
        <cfheader name="Content-Disposition" value="inline; filename=#trantype#_Product_Sales_Report_#msg#_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\#trantype#_Product_Sales_Report_#msg#_#huserid#.xls">
	</cfcase>

	<cfcase value="HTML">
		<html>
		<head>
		<title>Top/Bottom Sales Report</title>
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
        
		<cfset rangenum = 50>

		<cfif form.showby eq "qty">
			<cfset msg = "By Sales Quantity">
		<cfelse>
			<cfset msg = "By Sales Value">
		</cfif>

		<cfset totalqty =0>
		<cfset totalamt =0>

		<cfquery name="getitem" datasource="#dts#">
			select a.itemno, desp, despa, sum(qty) as sumqty, sum(amt) as sumamt,b.sizeid,b.colorid,b.supp,b.wos_group,b.brand,b.category,b.shelf,b.aitemno,b.costcode from ictran as a
            left join (select supp,sizeid,colorid,itemno,aitemno,wos_group,brand,category,costcode,shelf from icitem) as b on a.itemno=b.itemno
			where (type = 'INV' <!---or type = 'DN'---> or type = 'CS') and wos_date > #getgeneral.lastaccyear# and (void = '' or void is null)
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif>
            <cfif form.datefrom neq "" and form.dateto neq "">
            and wos_date >= '#ndatefrom#' and wos_date <= '#ndateto#'
            <cfelse>
            and wos_date > #getgeneral.lastaccyear#
            </cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
			and agenno >='#form.agentfrom#' and agenno <= '#form.agentto#'
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				and agenno in(select agent from #target_icagent# where team >= '#form.teamfrom#' and team <= '#form.teamto#')
				</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
			and area >='#form.areafrom#' and area <='#form.areato#'
			</cfif>
            <cfif form.customerfrom neq "" and form.customerto neq "">
			and custno >='#form.customerfrom#' and custno <= '#form.customerto#'
			</cfif>
             and a.itemno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#itemlist#">)
            
			group by itemno
			<cfif form.showby eq "amt">
			order by sumamt
			<cfelse>
			order by sumqty
			</cfif>
			<cfif url.trantype eq "top">
			desc
			</cfif>
            ,itemno
		</cfquery>

		<body>
		<cfoutput>
		  <table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
                <td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>#trantype# #rangenum# PRODUCT SALES REPORT - #msg#</strong></font></div></td>
			</tr>
			<cfif form.periodfrom neq "" and form.periodto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.agentfrom neq "" and form.agentto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">AGENT: #form.agentfrom# - #form.agentto#</font></div></td>
				</tr>
			</cfif>
            <cfif form.teamfrom neq "" and form.teamto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">TEAM: #form.teamfrom# - #form.teamto#</font></div></td>
				</tr>
			</cfif>
			<cfif form.areafrom neq "" and form.areato neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">AREA: #form.areafrom# - #form.areato#</font></div></td>
				</tr>
			</cfif>
            <cfif form.brandfrom neq "" and form.brandto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">BRAND: #form.brandfrom# - #form.brandto#</font></div></td>
				</tr>
			</cfif>
            <cfif form.sizefrom neq "" and form.sizeto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lsize#: #form.sizefrom# - #form.sizeto#</font></div></td>
				</tr>
			</cfif>
            
            <cfif form.materialfrom neq "" and form.materialto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lmaterial#: #form.materialfrom# - #form.materialto#</font></div></td>
				</tr>
			</cfif>
            
            
            <cfif form.customerfrom neq "" and form.customerto neq "">
				<tr>
					<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">CUSTOMER: #form.customerfrom# - #form.customerto#</font></div></td>
				</tr>
			</cfif>
			<tr>
				<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
			</tr>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<tr>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">NO</font></div></td>
				<td></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
                <cfif getdisplaydetail.report_aitemno eq 'Y'>
                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">PRODUCT CODE.</font></div></td>
                </cfif>
                <cfif lcase(hcomid) eq 'tcds_i'>
                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">SUPPLIER</font></div></td>
                </cfif>
                <cfif getdisplaydetail.report_brand eq 'Y'>
                <td><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lbrand#</font></td>
                </cfif>
                <cfif getdisplaydetail.report_category eq 'Y'>
                <td><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lcategory#</font></td>
                </cfif>
                <cfif getdisplaydetail.report_group eq 'Y'>
                <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lgroup#</font></td>
                </cfif>
                <cfif getdisplaydetail.report_sizeid eq 'Y'>
                <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lsize#</font></td>
                </cfif>
                <cfif getdisplaydetail.report_colorid eq 'Y'>
                <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lmaterial#</font></td>
                </cfif>
                <cfif getdisplaydetail.report_costcode eq 'Y'>
                <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lrating#</font></td>
                </cfif>
                <cfif getdisplaydetail.report_shelf eq 'Y'>
                <td  ><font size="2" face="Arial, Helvetica, sans-serif">#getgeneral.lmodel#</font></td>
                </cfif>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESP</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY SOLD</font></div></td>
				<td></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">SALES</font></div></td>
			</tr>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>

			<cfif rangenum neq 0>
				<cfloop query="getitem" startrow="1" endrow="#rangenum#">
                
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></div></td>
						<td></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
                        <cfif getdisplaydetail.report_aitemno eq 'Y'>
                <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.aitemno#</font></div></td>
                </cfif>
                        <cfif lcase(hcomid) eq 'tcds_i'>
                        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.supp#</font></div></td>
                        </cfif>
                        <cfif getdisplaydetail.report_brand eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.brand#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_category eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.category#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_group eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.wos_group#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_sizeid eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.sizeid#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_colorid eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.colorid#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_costcode eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.costcode#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_shelf eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.shelf#</font></div></td>
                    </cfif>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.desp##getitem.despa#</font></div></td>
						<cfset totalqty = totalqty + val(getitem.sumqty)>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getitem.sumqty),"0")#</font></div></td>
						<td></td>
						<cfset totalamt = totalamt + val(getitem.sumamt)>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getitem.sumamt),stDecl_UPrice)#</font></div></td>
					</tr>
				</cfloop>
			<cfelse>
				<cfloop query="getitem">
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.currentrow#.</font></div></td>
						<td></td>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
                        <cfif getdisplaydetail.report_aitemno eq 'Y'>
                        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.aitemno#</font></div></td>
                        </cfif>
                        <cfif lcase(hcomid) eq 'tcds_i'>
                        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.supp#</font></div></td>
                        </cfif>
                        <cfif getdisplaydetail.report_brand eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.brand#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_category eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.category#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_group eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.wos_group#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_sizeid eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.sizeid#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_colorid eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.colorid#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_costcode eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.costcode#</font></div></td>
                    </cfif>
                    <cfif getdisplaydetail.report_shelf eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.shelf#</font></div></td>
                    </cfif>
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.desp##getitem.despa#</font></div></td>
						<cfset totalqty = totalqty + val(getitem.sumqty)>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getitem.sumqty),"0")#</font></div></td>
						<td></td>
						<cfset totalamt = totalamt + val(getitem.sumamt)>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getitem.sumamt),stDecl_UPrice)#</font></div></td>
					</tr>
				</cfloop>
			</cfif>
			<tr>
				<td colspan="100%"><hr></td>
			</tr>
			<tr>
            <cfif lcase(hcomid) eq 'tcds_i'>
            <td></td>
            </cfif>
            <cfif getdisplaydetail.report_brand eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_category eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_group eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_sizeid eq 'Y'>
               <td></td>
                </cfif>
                <cfif getdisplaydetail.report_colorid eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_costcode eq 'Y'>
                <td></td>
                </cfif>
                <cfif getdisplaydetail.report_shelf eq 'Y'>
                <td></td>
                </cfif>
				<td></td>
				<td></td>
				<td></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalqty,"0")#</strong></font></div></td>
				<td></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalamt,",___.__")#</strong></font></div></td>
			</tr>
		</table>

		<cfif getitem.recordcount eq 0>
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