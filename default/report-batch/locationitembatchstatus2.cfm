<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1=createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2=createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>

<cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">
	<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
	<cfset stDecl_UPrice = "">

	<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
		<cfset stDecl_UPrice = stDecl_UPrice & "0">
	</cfloop>	
		
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
	<Style ss:ID="s34">
	<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
	</Style>
	<Style ss:ID="s36">
	<Borders>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<NumberFormat ss:Format="0"/>
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
		<Cell ss:MergeAcross="4" ss:StyleID="s22"><Data ss:Type="String">Print Location Stock Balance Report</Data></Cell>
	</Row>

	<cfif form.batchcodefrom neq "" and form.batchcodeto neq "">
    	<cfif checkcustom.customcompany eq "Y">
        	<cfset varbatch="LOT NUMBER">
		<cfelse>
        	<cfset varbatch="BATCH CODE">
		</cfif>
		<cfwddx action = "cfml2wddx" input = "#varbatch#: #form.batchcodefrom# - #form.batchcodeto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="4" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
	<cfwddx action = "cfml2wddx" input = "CATEGORY: #form.catefrom# - #form.cateto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="4" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<cfwddx action = "cfml2wddx" input = "GROUP: #form.groupfrom# - #form.groupto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="4" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		<cfwddx action = "cfml2wddx" input = "ITEM NO: #form.itemfrom# - #form.itemto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="4" ss:StyleID="s24"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>

	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="3" ss:StyleID="s26"><Data ss:Type="String"><cfif getgeneral.compro neq "">#getgeneral.compro#</cfif></Data></Cell>
		<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
	</Row>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:StyleID="s27"><Data ss:Type="String">ITEM NO.</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">DESCRIPTION</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>ITEM BATCH</cfif></Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">UOM</Data></Cell>
		<Cell ss:StyleID="s27"><Data ss:Type="String">BALANCE</Data></Cell>
	</Row>

	<cfloop query="getlocation">
		<cfwddx action = "cfml2wddx" input = "LOCATION: #getlocation.location#" output = "wddxText1">
		<cfwddx action = "cfml2wddx" input = "#getlocation.desp#" output = "wddxText2">

		<Row ss:AutoFitHeight="0" ss:Height="12">
			<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1#</Data></Cell>
			<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText2#</Data></Cell>
			<Cell ss:StyleID="s29"/>
			<Cell ss:StyleID="s29"/>
		</Row>
		<Row ss:AutoFitHeight="0" ss:Height="12"/>
		<cfquery name="getitem" datasource="#dts#">
			select a.itemno,d.desp as itemdesp,d.unit,d.unit2,d.factor1,d.factor2,d.sizeid,d.category,
			a.batchcode<cfif checkcustom.customcompany eq "Y">,a.permit_no</cfif>,a.location,a.expdate,a.bth_qob,b.qin,c.qout,
			(ifnull(a.bth_qob,0)+ifnull(b.qin,0)-ifnull(c.qout,0)) as balance
			from lobthob as a

			left join
			(	select sum(qty) as qin,itemno,batchcode,location 
				from ictran
				where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') 
				and (void = '' or void is null) and batchcode<>''  and location<>''
				and location='#getlocation.location#'
                <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between "#date1#" and "#date2#"
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
			) as b on (a.itemno=b.itemno and a.batchcode=b.batchcode)

			left join
			(	select sum(qty) as qout,itemno,batchcode,location 
				from ictran
				where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
				and (void = '' or void is null) and toinv='' and batchcode<>''  and location<>''
				and location='#getlocation.location#'
               <cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between "#date1#" and "#date2#"
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
			) as c on (a.itemno=c.itemno and a.batchcode=c.batchcode)
			
			left join (select itemno,desp,unit,unit2,factor1,factor2,category,colorid,sizeid from icitem)as d on a.itemno = d.itemno

			where a.itemno<>'' and a.batchcode<>'' and a.location='#getlocation.location#'
			<cfif isdefined("form.figure") and form.figure eq "yes">
			<cfelse>
				and (ifnull(a.bth_qob,0)+ifnull(b.qin,0)-ifnull(c.qout,0)) > 0
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
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				and a.itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
				and d.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and d.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
			<cfif checkcustom.customcompany eq "Y">
				<cfif trim(form.permitno) neq "">
					and a.permit_no='#form.permitno#'
				</cfif>
			</cfif>
			group by a.itemno,a.batchcode,location order by a.itemno,a.batchcode
		</cfquery>

		<cfset thisitem="">
		<cfset itemtotal=0>
		<cfloop query="getitem">
			<cfif getitem.itemno neq thisitem>
				<cfif thisitem neq "">
					<cfif val(xfactor1) neq 0>
						<cfif val(itemtotal) gte 0>
							<cfset xbal=val(itemtotal)/val(xfactor1)*val(xfactor2)>
						<cfelse>
							<cfset xbal=-(val(itemtotal)/val(xfactor1)*val(xfactor2))>
						</cfif>
						<cfset xbal=Int(xbal)>
						<cfif val(xfactor2) neq 0>
							<cfset ybal=val(itemtotal)-(xbal*val(xfactor1)/val(xfactor2))>
						<cfelse>
							<cfset ybal=0>
						</cfif>
					<cfelse>
						<cfset xbal=0>
						<cfset ybal=val(itemtotal)>
					</cfif>
					<cfwddx action = "cfml2wddx" input = "#xbal# #xunit2# #ybal# #xunit#" output = "wddxText1">
					<Row ss:AutoFitHeight="0" ss:Height="12">
						<Cell ss:StyleID="s30"><Data ss:Type="String">TOTAL:</Data></Cell>
						<Cell ss:StyleID="s30"/>
						<Cell ss:StyleID="s30"/>
						<Cell ss:StyleID="s30"><Data ss:Type="String">#wddxText1#</Data></Cell>
						<Cell ss:StyleID="s31"><Data ss:Type="Number">#itemtotal#</Data></Cell>
					</Row>
					<Row ss:AutoFitHeight="0" ss:Height="12"/>
					<cfset itemtotal=0>
				</cfif>
				<cfwddx action = "cfml2wddx" input = "#getitem.itemno# #getitem.itemdesp# #getitem.category# (#getitem.sizeid#)" output = "wddxText1">
				<Row ss:AutoFitHeight="0" ss:Height="12">
					<Cell ss:MergeAcross="4" ss:StyleID="s28"><Data ss:Type="String">#wddxText1#</Data></Cell>
				</Row>
				<cfset thisitem=getitem.itemno>
			</cfif>
			<cfwddx action = "cfml2wddx" input = "#getitem.batchcode#" output = "wddxText1">
			<cfif checkcustom.customcompany eq "Y">
				<cfwddx action = "cfml2wddx" input = "#getitem.permit_no#" output = "wddxText2">
			</cfif>

			<Row ss:AutoFitHeight="0" ss:Height="12">
				<Cell ss:StyleID="s28"/>
				<Cell ss:StyleID="s28"><Data ss:Type="String"><cfif checkcustom.customcompany eq "Y">#wddxText2#</cfif></Data></Cell>
				<cfif checkcustom.customcompany eq "Y"><Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1#</Data></Cell></cfif>
				<Cell ss:StyleID="s28"><Data ss:Type="String">#getitem.unit#</Data></Cell>
				<Cell ss:StyleID="s29"><Data ss:Type="Number">#getitem.balance#</Data></Cell>
				<cfset itemtotal=itemtotal+val(getitem.balance)>
			</Row>
			<cfset xfactor1=getitem.factor1>
			<cfset xfactor2=getitem.factor2>
			<cfset xunit=getitem.unit>
			<cfset xunit2=getitem.unit2>
		</cfloop>
		<cfif getitem.recordcount neq 0>
			<cfif val(xfactor1) neq 0>
				<cfif val(itemtotal) gte 0>
					<cfset xbal=val(itemtotal)/val(xfactor1)*val(xfactor2)>
				<cfelse>
					<cfset xbal=-(val(itemtotal)/val(xfactor1)*val(xfactor2))>
				</cfif>
				
				<cfset xbal=Int(xbal)>
				<cfif val(xfactor2) neq 0>
					<cfset ybal=val(itemtotal)-(xbal*val(xfactor1)/val(xfactor2))>
				<cfelse>
					<cfset ybal=0>
				</cfif>
			<cfelse>
				<cfset xbal=0>
				<cfset ybal=val(itemtotal)>
			</cfif>
			<cfwddx action = "cfml2wddx" input = "#xbal# #xunit2# #ybal# #xunit#" output = "wddxText1">
			<Row ss:AutoFitHeight="0" ss:Height="12">
				<Cell ss:StyleID="s30"><Data ss:Type="String">TOTAL:</Data></Cell>
				<Cell ss:StyleID="s30"/>
				<Cell ss:StyleID="s30"/>
				<Cell ss:StyleID="s30"><Data ss:Type="String">#wddxText1#</Data></Cell>
				<Cell ss:StyleID="s31"><Data ss:Type="Number">#itemtotal#</Data></Cell>
			</Row>
		</cfif>
		
		<Row ss:AutoFitHeight="0" ss:Height="12"/>
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
		<cfif checkcustom.customcompany eq "Y">
			<cfif trim(form.permitno) neq "">
				and (b.permit_no='#form.permitno#' or b.permit_no2='#form.permitno#')
			</cfif>
		</cfif>
		group by a.location 
		order by a.location
	</cfquery>

	<cfoutput>
	<table width="80%" border="0" cellspacing="1" cellpadding="2" align="center">
		<tr>
			<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Print Location Stock Balance Report</strong></font></div></td>
		</tr>
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
		<cfif form.datefrom neq "" and form.dateto neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(date1,"dd/mm/yyyy")# - #dateformat(date2,"dd/mm/yyyy")#</font></div></td>
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
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO - DESCRIPTION</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><cfif checkcustom.customcompany eq "Y">LOT NUMBER<cfelse>ITEM BATCH</cfif></font></div></td>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">UOM</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif checkcustom.customcompany eq "Y">LOT </cfif>QTY</font></div></td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<cfloop query="getlocation">
			<tr>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><u>LOCATION: #getlocation.location#</u></strong></font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><u>#getlocation.desp#</u></strong></font></div></td>
			</tr>
			<cfquery name="getitem" datasource="#dts#">
				select a.itemno,d.desp as itemdesp,d.unit,d.unit2,d.factor1,d.factor2,d.category,(select desp from icsizeid where sizeid=d.sizeid) as sizeid,
				a.batchcode<cfif checkcustom.customcompany eq "Y">,a.permit_no,a.permit_no2</cfif>,a.location,a.expdate,a.bth_qob,b.qin,c.qout,
				(ifnull(a.bth_qob,0)+ifnull(b.qin,0)-ifnull(c.qout,0)) as balance
				from lobthob as a

				left join
				(	select sum(qty) as qin,itemno,batchcode,location 
					from ictran
					where (type = 'RC' or type = 'CN' or type = 'OAI' or type = 'TRIN') 
					and (void = '' or void is null) and batchcode<>'' and location<>''
					and location='#getlocation.location#'
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between "#date1#" and "#date2#"
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
					<cfif lcase(hcomid) eq "jaynbtrading_i">
						<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
							and custno between '#form.custfrom#' and '#form.custto#'
						</cfif>
					</cfif> 
					group by itemno,batchcode,location
				) as b on (a.itemno=b.itemno and a.batchcode=b.batchcode)

				left join
				(	select sum(qty) as qout,itemno,batchcode,location 
					from ictran
					where (type = 'INV' or type = 'PR' or type = 'CS' or type = 'DN' or type = 'ISS' or type = 'OAR' or type = 'TROU' or type = 'DO')
					and (void = '' or void is null) and toinv='' and batchcode<>''  and location<>''
					and location='#getlocation.location#'
					<cfif form.datefrom neq "" and form.dateto neq "">
						and wos_date between "#date1#" and "#date2#"
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
					<cfif lcase(hcomid) eq "jaynbtrading_i">
						<cfif trim(form.custfrom) neq "" and trim(form.custto) neq "">
							and custno between '#form.custfrom#' and '#form.custto#'
						</cfif>
					</cfif> 
					group by itemno,batchcode,location
				) as c on (a.itemno=c.itemno and a.batchcode=c.batchcode)
				
				left join (select itemno,desp,unit,unit2,factor1,factor2,category,colorid,sizeid from icitem)as d on a.itemno = d.itemno

				where a.itemno<>'' and a.batchcode<>'' and a.location='#getlocation.location#'
				<cfif isdefined("form.figure") and form.figure eq "yes">
				<cfelse>
					and (ifnull(a.bth_qob,0)+ifnull(b.qin,0)-ifnull(c.qout,0)) > 0
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
				<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
					and a.itemno between '#form.itemfrom#' and '#form.itemto#'
				</cfif>
				<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
					and d.category between '#form.catefrom#' and '#form.cateto#'
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and d.wos_group between '#form.groupfrom#' and '#form.groupto#'
				</cfif>
				<cfif checkcustom.customcompany eq "Y">
					<cfif trim(form.permitno) neq "">
						and (a.permit_no='#form.permitno#' or a.permit_no2='#form.permitno#')
					</cfif>
				</cfif>
				group by a.itemno,a.batchcode,location order by a.itemno,a.batchcode
			</cfquery>

			<cfset thisitem="">
			<cfset itemtotal=0>
			<cfloop query="getitem">
				<cfif getitem.itemno neq thisitem>
					<cfif thisitem neq "">
						<tr>
							<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL : #thisitem#</strong></font></div></td>
							<td></td>
							<cfif val(xfactor1) neq 0>
								<cfif val(itemtotal) gte 0>
									<cfset xbal=val(itemtotal)/val(xfactor1)*val(xfactor2)>
								<cfelse>
									<cfset xbal=-(val(itemtotal)/val(xfactor1)*val(xfactor2))>
								</cfif>
								
								<cfset xbal=Int(xbal)>
								<cfif val(xfactor2) neq 0>
									<cfset ybal=val(itemtotal)-(xbal*val(xfactor1)/val(xfactor2))>
								<cfelse>
									<cfset ybal=0>
								</cfif>
							<cfelse>
								<cfset xbal=0>
								<cfset ybal=val(itemtotal)>
							</cfif>
							<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#xbal# #xunit2# #ybal# #xunit#</font></div></td>
							<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(itemtotal,"0")#</font></div></td>
						</tr>
						<tr><td colspan="100%"><hr></td></tr>
						<tr><td height="10"></td></tr>
						<cfset itemtotal=0>
					</cfif>
					<tr>
						<td colspan="100%"><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.itemno#&nbsp;&nbsp;&nbsp;#getitem.itemdesp# #getitem.category# <cfif getitem.sizeid neq "">(#getitem.sizeid#)</cfif></font></div></td>
					</tr>
					<cfset thisitem=getitem.itemno>
				</cfif>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<cfif checkcustom.customcompany eq "Y">
						<td><div align="center"><font size="2" face="Times New Roman, Times, serif">
							<cfif getitem.permit_no neq "">#getitem.permit_no#<cfelseif getitem.permit_no2 neq "">#getitem.permit_no2#</cfif>
						</font></div></td>
					<cfelse>
						<td></td>
					</cfif>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getitem.batchcode#</font></div></td>
					<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getitem.unit#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getitem.balance,"0")#</font></div></td>
					<cfset itemtotal=itemtotal+val(getitem.balance)>
				</tr>
				<cfset xfactor1=getitem.factor1>
				<cfset xfactor2=getitem.factor2>
				<cfset xunit=getitem.unit>
				<cfset xunit2=getitem.unit2>
			</cfloop>
			<cfif getitem.recordcount neq 0>
				<tr>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL : #thisitem#</strong></font></div></td>
					<td></td>
					<cfif val(xfactor1) neq 0>
						<cfif val(itemtotal) gte 0>
							<cfset xbal=val(itemtotal)/val(xfactor1)*val(xfactor2)>
						<cfelse>
							<cfset xbal=-(val(itemtotal)/val(xfactor1)*val(xfactor2))>
						</cfif>
						
						<cfset xbal=Int(xbal)>
						<cfif val(xfactor2) neq 0>
							<cfset ybal=val(itemtotal)-(xbal*val(xfactor1)/val(xfactor2))>
						<cfelse>
							<cfset ybal=0>
						</cfif>
					<cfelse>
						<cfset xbal=0>
						<cfset ybal=val(itemtotal)>
					</cfif>
					<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#xbal# #xunit2# #ybal# #xunit#</font></div></td>
					<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(itemtotal,"0")#</font></div></td>
				</tr>
			</cfif>
			
			<tr><td colspan="100%"><hr></td></tr>
			<tr><td height="10"></td></tr>
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