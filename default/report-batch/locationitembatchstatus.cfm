<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">
	<cfquery name="getlocation" datasource="#dts#">
		select a.location,a.desp from iclocation a,lobthob b where a.location=b.location
		<cfif form.locationfrom neq "" and form.locationto neq "">
		and a.location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		group by a.location order by a.location
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
	<Column ss:AutoFitWidth="0" ss:Width="120.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="103.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="80.5" ss:Span="4"/>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s22"><Data ss:Type="String">Print Location Item <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Status Report</Data></Cell>
	</Row>

	<cfif form.expdatefrom neq "" and form.expdateto neq "">
		<cfwddx action = "cfml2wddx" input = "EXPIRE DATE: #form.expdatefrom# - #form.expdateto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
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
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
	<cfwddx action = "cfml2wddx" input = "CATEGORY: #form.catefrom# - #form.cateto#" output = "wddxText">
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
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		<cfwddx action = "cfml2wddx" input = "ITEM NO: #form.itemfrom# - #form.itemto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="7" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>

	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="6" ss:StyleID="s26"><Data ss:Type="String"><cfif getgeneral.compro neq "">#getgeneral.compro#</cfif></Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
	</Row>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:StyleID="s27"><Data ss:Type="String">ITEM NO.</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">DESCRIPTION</Data></Cell>
		<cfif checkcustom.customcompany eq "Y"><Cell ss:StyleID="s27"><Data ss:Type="String">PERMIT NO</Data></Cell></cfif>
		<Cell ss:StyleID="s27"><Data ss:Type="String"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>ITEM BATCH</cfif></Data></Cell>
        <Cell ss:StyleID="s27"><Data ss:Type="String"><cfif lcase(hcomid) eq "marquis_i">Lot Number<cfelse>Mil Cert</cfif></Data></Cell>
        <Cell ss:StyleID="s27"><Data ss:Type="String">Import Permit</Data></Cell>

		<Cell ss:StyleID="s27"><Data ss:Type="String">EXPIRE DATE</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">B/F</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">IN</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">OUT</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">BALANCE</Data></Cell>
        <Cell ss:StyleID="s27"><Data ss:Type="String">UNITS</Data></Cell>
	</Row>

	<cfloop query="getlocation">
		<cfwddx action = "cfml2wddx" input = "LOCATION: #getlocation.location#" output = "wddxText1">
		<cfwddx action = "cfml2wddx" input = "#getlocation.desp#" output = "wddxText2">

		<Row ss:AutoFitHeight="0" ss:Height="12">
			<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1#</Data></Cell>
			<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText2#</Data></Cell>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
		</Row>

		<!--- <cfquery name="getitem" datasource="#dts#">
			select a.itemno,a.batchcode,a.location,a.expdate,a.bth_qob,b.lastin,c.lastout,d.qin,e.qout,
			(ifnull(a.bth_qob,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance
			from lobthob as a

			left join
			(select sum(qty) as lastin,itemno,batchcode,location from ictran
			where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') and (void = '' or void is null) and batchcode<>'' and location<>''
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod < '#form.periodfrom#'
			</cfif> group by itemno,batchcode,location) as b on a.itemno=b.itemno and a.batchcode=b.batchcode

			left join
			(select sum(qty) as lastout,itemno,batchcode,location from ictran
			where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
			and (void = '' or void is null) and toinv='' and batchcode<>'' and location<>''
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod < '#form.periodfrom#'
			</cfif> group by itemno,batchcode,location) as c on a.itemno=c.itemno and a.batchcode=c.batchcode

			left join
			(select sum(qty) as qin,itemno,batchcode,location from ictran
			where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') and (void = '' or void is null) and batchcode<>''  and location<>''
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif> group by itemno,batchcode,location) as d on a.itemno=d.itemno and a.batchcode=d.batchcode

			left join
			(select sum(qty) as qout,itemno,batchcode,location from ictran
			where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
			and (void = '' or void is null) and toinv='' and batchcode<>''  and location<>''
			<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
			</cfif> group by itemno,batchcode,location) as e on a.itemno=e.itemno and a.batchcode=e.batchcode

			where a.itemno<>'' and a.batchcode<>'' and a.location<>'' and a.location='#getlocation.location#'
			<cfif isdefined("form.figure") and form.figure eq "yes">
			<cfelse>
			and (ifnull(a.bth_qob,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) > 0
			</cfif>

			<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and a.batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
			</cfif>
			<cfif form.expdatefrom neq "" and form.expdateto neq "">
			and a.exp_date between '#form.expdatefrom#' and '#form.expdateto#'
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and a.itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			group by a.itemno,a.batchcode,location order by a.itemno,a.batchcode,location
		</cfquery> --->
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,f.desp as itemdesp,a.batchcode,a.milcert,a.importpermit<cfif checkcustom.customcompany eq "Y">,a.permit_no</cfif>,a.location,a.expdate,a.bth_qob,b.lastin,c.lastout,d.qin,e.qout,
			(ifnull(a.bth_qob,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance
			from lobthob as a

			left join
			(	select 0 as lastin,itemno,batchcode,location 
				from ictran
				where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') 
				and (void = '' or void is null) and batchcode<>'' and location<>''
				and location='#getlocation.location#'
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod < '#form.periodfrom#'
				</cfif> 
				<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
					and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
				</cfif>
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
				</cfif>
				<cfif checkcustom.customcompany eq "Y">
					<cfif trim(form.permitno) neq "">
						and brem5='#form.permitno#'
					</cfif>
				</cfif> 
				group by itemno,batchcode,location
			) as b on a.itemno=b.itemno and a.batchcode=b.batchcode

			left join
			(	select 0 as lastout,itemno,batchcode,location 
				from ictran
				where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
				and (void = '' or void is null) and toinv='' and batchcode<>'' and location<>''
				and location='#getlocation.location#'
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod < '#form.periodfrom#'
				</cfif> 
				<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
					and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
				</cfif>
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
				</cfif>
				<cfif checkcustom.customcompany eq "Y">
					<cfif trim(form.permitno) neq "">
						and brem5='#form.permitno#'
					</cfif>
				</cfif> 
				group by itemno,batchcode,location
			) as c on a.itemno=c.itemno and a.batchcode=c.batchcode

			left join
			(	select sum(qty) as qin,itemno,batchcode,location 
				from ictran
				where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') 
				and (void = '' or void is null) and batchcode<>''  and location<>''
				and location='#getlocation.location#'
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif> 
				<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
					and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
				</cfif>
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
				</cfif>
				<cfif checkcustom.customcompany eq "Y">
					<cfif trim(form.permitno) neq "">
						and brem5='#form.permitno#'
					</cfif>
				</cfif> 
				group by itemno,batchcode,location
			) as d on a.itemno=d.itemno and a.batchcode=d.batchcode

			left join
			(	select sum(qty) as qout,itemno,batchcode,location 
				from ictran
				where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
				and (void = '' or void is null) and toinv='' and batchcode<>''  and location<>''
				and location='#getlocation.location#'
				<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif> 
				<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
					and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
				</cfif>
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and itemno between '#form.itemfrom#' and '#form.itemto#'
				</cfif>
				<cfif checkcustom.customcompany eq "Y">
					<cfif trim(form.permitno) neq "">
						and brem5='#form.permitno#'
					</cfif>
				</cfif> 
				group by itemno,batchcode,location
			) as e on a.itemno=e.itemno and a.batchcode=e.batchcode
			
			left join (select itemno,desp,unit,unit2,factor1,factor2,category,colorid,sizeid from icitem)as f on a.itemno = f.itemno

			where a.itemno<>'' and a.batchcode<>'' and a.location<>'' and a.location='#getlocation.location#'
			<cfif isdefined("form.figure") and form.figure eq "yes">
			<cfelse>
				and (ifnull(a.bth_qob,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) > 0
			</cfif>

			<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
				and a.batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
			</cfif>
            <cfif form.milcert neq "">
				and a.milcert = "#form.milcert#"
			</cfif>
            <cfif form.importpermit neq "">
				and a.importpermit = "#form.importpermit#"
			</cfif>
			<cfif form.expdatefrom neq "" and form.expdateto neq "">
				and a.exp_date between '#form.expdatefrom#' and '#form.expdateto#'
			</cfif>
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and a.itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and f.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and f.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			<cfif checkcustom.customcompany eq "Y">
				<cfif trim(form.permitno) neq "">
					and a.permit_no='#form.permitno#'
				</cfif>
			</cfif>
			group by a.itemno,a.batchcode,location order by a.itemno,a.batchcode,location
		</cfquery>
        
		<cfloop query="getitem">
			<cfwddx action = "cfml2wddx" input = "#getitem.itemno#" output = "wddxText1">
			<cfwddx action = "cfml2wddx" input = "#getitem.batchcode#" output = "wddxText2">
			<cfwddx action = "cfml2wddx" input = "#dateformat(getitem.expdate,"dd-mm-yyyy")#" output = "wddxText3">
			<cfwddx action = "cfml2wddx" input = "#getitem.itemdesp#" output = "wddxText4">
            <cfwddx action = "cfml2wddx" input = "#getitem.milcert#" output = "wddxText6">
            <cfwddx action = "cfml2wddx" input = "#getitem.importpermit#" output = "wddxText7">
            <cfquery name="getunit" datasource="#dts#">
                    select unit from icitem where itemno='#getitem.itemno#'
                    </cfquery>

            <cfwddx action = "cfml2wddx" input = "#getunit.unit#" output = "wddxText8">
			<cfif checkcustom.customcompany eq "Y">
				<cfwddx action = "cfml2wddx" input = "#getitem.permit_no#" output = "wddxText5">
			</cfif>
<cfquery name="getunit" datasource="#dts#">
                    select unit from icitem where itemno='#getitem.itemno#'
                    </cfquery>

			<Row ss:AutoFitHeight="0" ss:Height="12">
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1#</Data></Cell>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText4#</Data></Cell>
				<cfif checkcustom.customcompany eq "Y"><Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText5#</Data></Cell></cfif>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText2#</Data></Cell>
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText6#</Data></Cell>
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText7#</Data></Cell>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText3#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#(val(getitem.bth_qob)+val(getitem.lastin)-val(getitem.lastout))#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#getitem.qin#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#getitem.qout#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#getitem.balance#</Data></Cell>
                <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText8#</Data></Cell>
			</Row>
		</cfloop>
		<Row ss:AutoFitHeight="0" ss:Height="12"/>
	</cfloop>
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

	<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\BatchCodeR_LIBStatus_#huserid#.xls" output="#tostring(data)#">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\BatchCodeR_LIBStatus_#huserid#.xls">
<!---
	<cffile action="write" nameconflict="overwrite" file="C:\Inetpub\wwwroot\WOS\Excel_Report\#dts#\BatchCodeR_LIBStatus_#huserid#.xls" output="#tostring(data)#">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="C:\Inetpub\wwwroot\WOS\Excel_Report\#dts#\BatchCodeR_LIBStatus_#huserid#.xls">
--->
	</cfcase>

	<cfcase value="HTML">
	<html>
	<head>
	<title>Location Item Batch Status Report</title>
	<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
	<style type="text/css" media="print">
		.noprint { display: none; }
	</style>
	</head>

	<body>
	<cfquery name="getlocation" datasource="#dts#">
		select a.location,a.desp 
		from iclocation a,lobthob b 
		where a.location=b.location
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and a.location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			and b.batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
		</cfif>
		<cfif form.expdatefrom neq "" and form.expdateto neq "">
			and b.exp_date between '#form.expdatefrom#' and '#form.expdateto#'
		</cfif>
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (b.permit_no='#form.permitno#' or b.permit_no2='#form.permitno#')
			</cfif>
		</cfif>
		group by a.location 
		order by a.location
	</cfquery>

	<cfoutput>
	<table width="100%" border="0" cellspacing="1" cellpadding="2">
		<tr>
			<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Print Location Item <cfif checkcustom.customcompany eq "Y">- Lot Number<cfelse>Batch</cfif> Status Report</strong></font></div></td>
		</tr>
		<cfif form.expdatefrom neq "" and form.expdateto neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">EXPIRE DATE: #form.expdatefrom# - #form.expdateto#</font></div></td>
			</tr>
		</cfif>
		<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>BATCH CODE</cfif>: #form.batchcodefrom# - #form.batchcodeto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATEGORY: #form.catefrom# - #form.cateto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
			</tr>
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM NO: #form.itemfrom# - #form.itemto#</font></div></td>
			</tr>
		</cfif>
		<tr>
			<td colspan="3"><font size="2" face="Times New Roman, Times, serif"><cfif getgeneral.compro neq "">#getgeneral.compro#</cfif></font></td>
			<td colspan="5"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></div></td>
			<cfif checkcustom.customcompany eq "Y">
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">PERMIT NO</font></div></td>
			</cfif>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>ITEM BATCH</cfif></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfif lcase(hcomid) eq "marquis_i">Lot Number<cfelse>Mil Cert</cfif></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Import Permit</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">EXPIRE DATE</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">B/F</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">BALANCE</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">UNITS</font></div></td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<cfloop query="getlocation">
			<tr>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>LOCATION: #getlocation.location#</strong></font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>#getlocation.desp#</strong></font></div></td>
			</tr>
			<cfquery name="getitem" datasource="#dts#">
				select a.itemno,f.desp as itemdesp,a.batchcode,a.milcert,a.importpermit<cfif checkcustom.customcompany eq "Y">,a.permit_no,a.permit_no2</cfif>,a.location,a.expdate,a.bth_qob,b.lastin,c.lastout,d.qin,e.qout,
				(ifnull(a.bth_qob,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance
				from lobthob as a

				left join
				(	select 0 as lastin,itemno,batchcode,location 
					from ictran
					where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') 
					and (void = '' or void is null) and batchcode<>'' and location<>''
					and location='#getlocation.location#'
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod < '#form.periodfrom#'
					</cfif> 
					<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
						and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
					</cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
						and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif checkcustom.customcompany eq "Y">
						<cfif trim(form.permitno) neq "">
							and (brem5='#form.permitno#' or brem7='#form.permitno#')
						</cfif>
					</cfif> 
					group by itemno,batchcode,location
				) as b on a.itemno=b.itemno and a.batchcode=b.batchcode

				left join
				(	select 0 as lastout,itemno,batchcode,location 
					from ictran
					where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
					and (void = '' or void is null) and toinv='' and batchcode<>'' and location<>''
					and location='#getlocation.location#'
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod < '#form.periodfrom#'
					</cfif> 
					<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
						and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
					</cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
						and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif checkcustom.customcompany eq "Y">
						<cfif trim(form.permitno) neq "">
							and (brem5='#form.permitno#' or brem7='#form.permitno#')
						</cfif>
					</cfif> 
					group by itemno,batchcode,location
				) as c on a.itemno=c.itemno and a.batchcode=c.batchcode

				left join
				(	select sum(qty) as qin,itemno,batchcode,location 
					from ictran
					where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') 
					and (void = '' or void is null) and batchcode<>''  and location<>''
					and location='#getlocation.location#'
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
					</cfif> 
					<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
						and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
					</cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
						and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif checkcustom.customcompany eq "Y">
						<cfif trim(form.permitno) neq "">
							and (brem5='#form.permitno#' or brem7='#form.permitno#')
						</cfif>
					</cfif> 
					group by itemno,batchcode,location
				) as d on a.itemno=d.itemno and a.batchcode=d.batchcode

				left join
				(	select sum(qty) as qout,itemno,batchcode,location 
					from ictran
					where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
					and (void = '' or void is null) and toinv='' and batchcode<>''  and location<>''
					and location='#getlocation.location#'
					<cfif form.periodfrom neq "" and form.periodto neq "">
						and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
					</cfif> 
					<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
						and batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
					</cfif>
					<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
						and itemno between '#form.itemfrom#' and '#form.itemto#'
					</cfif>
					<cfif checkcustom.customcompany eq "Y">
						<cfif trim(form.permitno) neq "">
							and (brem5='#form.permitno#' or brem7='#form.permitno#')
						</cfif>
					</cfif> 
					group by itemno,batchcode,location
				) as e on a.itemno=e.itemno and a.batchcode=e.batchcode
				
				left join (select itemno,desp,unit,unit2,factor1,factor2,category,colorid,sizeid from icitem)as f on a.itemno = f.itemno

				where a.itemno<>'' and a.batchcode<>'' and a.location<>'' and a.location='#getlocation.location#'
				<cfif isdefined("form.figure") and form.figure eq "yes">
				<cfelse>
					and (ifnull(a.bth_qob,0)+ifnull(b.lastin,0)-ifnull(c.lastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) > 0
				</cfif>

				<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
					and a.batchcode between '#form.batchcodefrom#' and '#form.batchcodeto#'
				</cfif>
                <cfif form.milcert neq "">
				and a.milcert = "#form.milcert#"
			</cfif>
            <cfif form.importpermit neq "">
				and a.importpermit = "#form.importpermit#"
			</cfif>
				<cfif form.expdatefrom neq "" and form.expdateto neq "">
					and a.exp_date between '#form.expdatefrom#' and '#form.expdateto#'
				</cfif>
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and a.itemno between '#form.itemfrom#' and '#form.itemto#'
				</cfif>
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and f.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and f.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				<cfif checkcustom.customcompany eq "Y">
					<cfif trim(form.permitno) neq "">
						and (a.permit_no='#form.permitno#' or a.permit_no2='#form.permitno#')
					</cfif>
				</cfif>
				group by a.itemno,a.batchcode,location order by a.itemno,a.batchcode,location
			</cfquery>

			<cfloop query="getitem">
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemdesp#</font></div></td>
					<cfif checkcustom.customcompany eq "Y">
						<td><div align="left"><font size="2" face="Times New Roman, Times, serif">
							<cfif getitem.permit_no neq "">
								#getitem.permit_no#
							<cfelseif getitem.permit_no2 neq "">
								#getitem.permit_no2#
							</cfif>
						</font></div></td>
					</cfif>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.batchcode#</font></div></td>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.milcert#</font></div></td>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.importpermit#</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getitem.expdate,"dd-mm-yyyy")#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getitem.bth_qob)+val(getitem.lastin)-val(getitem.lastout),"0")#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.qin,"0")#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.qout,"0")#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.balance,"0")#</font></div></td>
                    <cfquery name="getunit" datasource="#dts#">
                    select unit from icitem where itemno='#getitem.itemno#'
                    </cfquery>
                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getunit.unit#</font></div></td>
				</tr>
			</cfloop>
			<tr><td><br></td></tr>
		</cfloop>
	</table>
	</cfoutput>
	<br>
	<br>
	<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
	<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
	</body>
	</html>
	</cfcase>
</cfswitch>