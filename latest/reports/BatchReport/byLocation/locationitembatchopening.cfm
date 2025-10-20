<cfinclude template="/object/dateobject.cfm">
<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
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
	<cfcase value="EXCEL">
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
	<NumberFormat ss:Format="0"/>
	</Style>
	<Style ss:ID="s30">
	<Borders>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<NumberFormat ss:Format="@"/>
	</Style>
	<Style ss:ID="s32">
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
	</Style>
	<Style ss:ID="s34">
	<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
	</Style>
	</Styles>
	<Worksheet ss:Name="Batch Code Report">
	<cfoutput>
	<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
	<Column ss:AutoFitWidth="0" ss:Width="103.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="103.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="120.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="80.5" ss:Span="4"/>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s22"><Data ss:Type="String">Print Location Product <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Opening Report</Data></Cell>
	</Row>

	<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
    	<cfif checkcustom.customcompany eq "Y">
        	<cfset varbatch="LOT NUMBER">
		<cfelse>
        	<cfset varbatch="BATCH CODE">
		</cfif>
		<cfwddx action = "cfml2wddx" input = "#varbatch#: #form.batchcodefrom# - #form.batchcodeto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif form.locationfrom neq "" and form.locationto neq "">
		<cfwddx action = "cfml2wddx" input = "LOCATION: #form.locationfrom# - #form.locationto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif form.datefrom neq "" and form.dateto neq "">
	<cfwddx action = "cfml2wddx" input = "DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
	<cfwddx action = "cfml2wddx" input = "CATEGORY: #form.categoryfrom# - #form.categoryto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
	<cfwddx action = "cfml2wddx" input = "GROUP: #form.groupfrom# - #form.groupto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
	<cfwddx action = "cfml2wddx" input = "PRODUCT NO: #form.productfrom# - #form.productto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>

	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="6" ss:StyleID="s26"><Data ss:Type="String"><cfif getgeneral.compro neq "">#getgeneral.compro#</cfif></Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
	</Row>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:StyleID="s27"><Data ss:Type="String">LOCATION</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">PRODUCT NO.</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">DESCRIPTION</Data></Cell>
		<cfif checkcustom.customcompany eq "Y"><Cell ss:StyleID="s27"><Data ss:Type="String">PERMIT NO</Data></Cell></cfif>
		<Cell ss:StyleID="s27"><Data ss:Type="String"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>BATCH CODE</cfif></Data></Cell>
        <Cell ss:StyleID="s27"><Data ss:Type="String"><cfif lcase(hcomid) eq "marquis_i">Lot Number<cfelse>Mil Cert</cfif></Data></Cell>
        <Cell ss:StyleID="s27"><Data ss:Type="String">Import Permit</Data></Cell>
        
		<Cell ss:StyleID="s27"><Data ss:Type="String">QTY B/F</Data></Cell>
        
        <Cell ss:StyleID="s27"><Data ss:Type="String">UNTIS</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">EXPIRY DATE</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">TYPE</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">REF.NO</Data></Cell>
	</Row>

	<!--- <cfquery name="getbatchitem" datasource="#dts#">
		select a.location,b.itemno,a.batchcode,a.bth_qob,a.expdate,a.type,a.refno from lobthob a,icitem b where a.bth_qob <> 0
		and a.itemno=b.itemno
		<cfif form.categoryfrom neq "" and form.categoryto neq "">
		and b.category between '#form.categoryfrom#' and '#form.categoryto#'
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and b.itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and b.wos_group between"#form.groupfrom#" and "#form.groupto#"
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
		and a.exp_date between "#form.datefrom#" and "#form.dateto#"
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
		and a.batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
		and a.location between "#form.locationfrom#" and "#form.locationto#"
		</cfif>
		order by itemno,batchcode
	</cfquery> --->
	<cfquery name="getbatchitem" datasource="#dts#">
		select a.location,b.itemno,b.desp as itemdesp,a.batchcode,a.milcert,a.importpermit,a.bth_qob,b.unit,a.expdate,a.type,a.refno<cfif checkcustom.customcompany eq "Y">,a.permit_no</cfif> 
		from lobthob a,icitem b 
		where a.bth_qob <> 0
		and a.itemno=b.itemno
		<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
			and b.category between '#form.categoryfrom#' and '#form.categoryto#'
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and b.itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and b.wos_group between"#form.groupfrom#" and "#form.groupto#"
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
			and a.exp_date between '#dateformatnew(form.datefrom,'YYYY-MM-DD')#' and '#dateformatnew(form.dateto,'YYYY-MM-DD')#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and a.batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
		</cfif>
        <cfif form.milcert neq "">
				and a.milcert = "#form.milcert#"
			</cfif>
            <cfif form.importpermit neq "">
				and a.importpermit = "#form.importpermit#"
			</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and a.location between "#form.locationfrom#" and "#form.locationto#"
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and a.permit_no='#form.permitno#'
			</cfif>
		</cfif>
		order by itemno,batchcode
	</cfquery>

	<cfif getbatchitem.recordcount gt 0>
		<cfloop query="getbatchitem">
			<cfwddx action = "cfml2wddx" input = "#getbatchitem.currentrow#. #getbatchitem.location#" output = "wddxText1">
			<cfwddx action = "cfml2wddx" input = "#getbatchitem.itemno#" output = "wddxText2">
			<cfwddx action = "cfml2wddx" input = "#getbatchitem.batchcode#" output = "wddxText3">
			<cfwddx action = "cfml2wddx" input = "#getbatchitem.type#" output = "wddxText4">
			<cfwddx action = "cfml2wddx" input = "#getbatchitem.refno#" output = "wddxText5">
			<cfwddx action = "cfml2wddx" input = "#getbatchitem.itemdesp#" output = "wddxText6">
            <cfwddx action = "cfml2wddx" input = "#getbatchitem.milcert#" output = "wddxText8">
            <cfwddx action = "cfml2wddx" input = "#getbatchitem.importpermit#" output = "wddxText9">
            
            <cfwddx action = "cfml2wddx" input = "#getbatchitem.unit#" output = "wddxText10">
			<cfif checkcustom.customcompany eq "Y">
				<cfwddx action = "cfml2wddx" input = "#getbatchitem.permit_no#" output = "wddxText7">
			</cfif>

			<Row ss:AutoFitHeight="0" ss:Height="12">
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1#</Data></Cell>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText2#</Data></Cell>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText6#</Data></Cell>
				<cfif checkcustom.customcompany eq "Y"><Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText7#</Data></Cell></cfif>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText3#</Data></Cell>
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText8#</Data></Cell>
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText9#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#getbatchitem.bth_qob#</Data></Cell>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#dateformat(getbatchitem.expdate,"dd-mm-yyyy")#</Data></Cell>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText4#</Data></Cell>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText5#</Data></Cell>
                
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText10#</Data></Cell>
			</Row>
		</cfloop>
	</cfif>
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

	<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\BatchCodeR_LIBOpening_#huserid#.xls" output="#tostring(data)#">
    <cfheader name="Content-Disposition" value="inline; filename=BatchCodeR_LIBOpening_#huserid#.xls">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\BatchCodeR_LIBOpening_#huserid#.xls">
<!---
	<cffile action="write" nameconflict="overwrite" file="C:\Inetpub\wwwroot\WOS\Excel_Report\#dts#\BatchCodeR_LIBOpening_#huserid#.xls" output="#tostring(data)#">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="C:\Inetpub\wwwroot\WOS\Excel_Report\#dts#\BatchCodeR_LIBOpening_#huserid#.xls">
--->
	</cfcase>

	<cfcase value="HTML">
	<html>
	<head>
	<title>Location Product Batch Opening Report</title>
	<link href = "/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
	<style type="text/css" media="print">
		.noprint { display: none; }
	</style>
	</head>

	<body>
	<cfoutput>
	<table width="100%" border="0" cellspacing="0" cellpadding="2">
		<tr>
			<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Print Location Product <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Opening Report</strong></font></div></td>
		</tr>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>BATCH CODE</cfif>: #form.batchcodefrom# - #form.batchcodeto#</font></div></td>
			</tr>
		</cfif>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">LOCATION: #form.locationfrom# - #form.locationto#</font></div></td>
			</tr>
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(form.datefrom,"dd/mm/yyyy")# - #dateformat(form.dateto,"dd/mm/yyyy")#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATEGORY: #form.categoryfrom# - #form.categoryto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">PRODUCT NO: #form.productfrom# - #form.productto#</font></div></td>
			</tr>
		</cfif>
		<tr>
			<td colspan="5"><font size="2" face="Times New Roman, Times, serif"><cfif getgeneral.compro neq "">#getgeneral.compro#</cfif></font></td>
			<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">LOCATION</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">PRODUCT NO.</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></div></td>
			<cfif checkcustom.customcompany eq "Y">
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">PERMIT NO</font></div></td>
			</cfif>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>BATCH CODE</cfif></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "marquis_i">Lot Number<cfelse>Mil Cert</cfif></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Import Permit</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY B/F</font></div></td>
            
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">UNITS</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">EXPIRY DATE</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TYPE</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">REF.NO</font></div></td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>

		<cfquery name="getbatchitem" datasource="#dts#">
			select a.location,b.itemno,b.desp as itemdesp,a.batchcode,a.milcert,a.importpermit,a.bth_qob,b.unit,a.expdate,a.type,a.refno<cfif checkcustom.customcompany eq "Y">,a.permit_no,a.permit_no2</cfif> 
			from lobthob a,icitem b 
			where a.bth_qob <> 0
			and a.itemno=b.itemno
			<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
				and b.category between '#form.categoryfrom#' and '#form.categoryto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and b.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and b.wos_group between"#form.groupfrom#" and "#form.groupto#"
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and a.exp_date between '#dateformatnew(form.datefrom,'YYYY-MM-DD')#' and '#dateformatnew(form.dateto,'YYYY-MM-DD')#'
			</cfif>
			<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
				and a.batchcode between "#form.batchcodefrom#" and "#form.batchcodeto#"
			</cfif>
            <cfif form.milcert neq "">
				and a.milcert = "#form.milcert#"
			</cfif>
            <cfif form.importpermit neq "">
				and a.importpermit = "#form.importpermit#"
			</cfif>
			<cfif form.locationfrom neq "" and form.locationto neq "">
				and a.location between "#form.locationfrom#" and "#form.locationto#"
			</cfif>
			<cfif checkcustom.customcompany eq "Y">
				<cfif trim(form.permitno) neq "">
					and (a.permit_no='#form.permitno#' or a.permit_no2='#form.permitno#')
				</cfif>
			</cfif>
			order by itemno,batchcode
		</cfquery>

		<cfif getbatchitem.recordcount gt 0>
			<cfloop query="getbatchitem">
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getbatchitem.currentrow#. #getbatchitem.location#</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getbatchitem.itemno#</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getbatchitem.itemdesp#</font></div></td>
					<cfif checkcustom.customcompany eq "Y">
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">
							<cfif getbatchitem.permit_no neq "">
								#getbatchitem.permit_no#
							<cfelseif getbatchitem.permit_no2 neq "">
								#getbatchitem.permit_no2#
							</cfif>
						</font></div></td>
					</cfif>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getbatchitem.batchcode#</font></div></td>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getbatchitem.milcert#</font></div></td>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getbatchitem.importpermit#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#NumberFormat(getbatchitem.bth_qob,"0")#</font></div></td>
                    
                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getbatchitem.unit#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif"	>#dateformat(getbatchitem.expdate,"dd-mm-yyyy")#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getbatchitem.type#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getbatchitem.refno#</font></div></td>
				</tr>
			</cfloop>
		</cfif>
	</table>

	<cfif getbatchitem.recordcount eq 0>
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