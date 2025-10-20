<cfparam name="i" default="1" type="numeric">
<cfparam name="RCqty" default="0">
<cfparam name="PRqty" default="0">
<cfparam name="DOqty" default="0">
<cfparam name="invqty" default="0">
<cfparam name="CNqty" default="0">
<cfparam name="DNqty" default="0">
<cfparam name="CSqty" default="0">
<cfparam name="ISSqty" default="0">
<cfparam name="OAIqty" default="0">
<cfparam name="OARqty" default="0">
<cfparam name="CTqty" default="0">
<cfparam name="balonhand" default="0">

<cfquery name="getgeneral" datasource="#dts#">
	select cost,compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>


<cfquery name="getitem" datasource="#dts#">
	select a.itemno,a.aitemno, a.desp, if((a.qtybf='' or a.qtybf is null),0,a.qtybf) as qtybf, 
	if((a.minimum='' or a.minimum is null),0,a.minimum) as minimum, a.itemno 
	from icitem a
    where 0=0
	group by a.itemno
</cfquery>

<cfquery name="getitem" datasource="#dts#">
        select 
			a.itemno,
            a.aitemno,
			a.desp,
			a.unit,
            a.qtybf,
            a.minimum,
            a.aitemno,
			ifnull(d.qin,0) as qin,
			ifnull(e.qout,0) as qout,
            ifnull(g.qoutct,0) as qoutct,
			ifnull(f.sqty,0) as sqty,
			ifnull(f.sumamt,0) as sumamt,
			
			(ifnull(a.qtybf,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance,
            (ifnull(a.qtybf,0)+ifnull(d.qin,0)-ifnull(e.qout,0)-ifnull(g.qoutct,0)) as balance2
		
			from icitem as a
	
			left join
			(
				select itemno,sum(qty) as qin 
				from ictran 
				where type in ('RC','CN','OAI','TRIN')
				and fperiod<>'99' 
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				<cfif form.period neq "">
					and fperiod+0 < '#form.period#'
	   			</cfif>
	    		 
				group by itemno
			) as d on a.itemno = d.itemno
	
			left join
			(
				select itemno,sum(qty) as qout 
				from ictran 
				where type in ('INV','DO','DN','PR','CS','ISS','OAR','TROU') 
				and fperiod<>'99' 
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and (toinv='' or toinv is null) 
	   			
	    			<cfif form.period neq "">
					and fperiod+0 < '#form.period#'
	   			</cfif>
	   			
	    		 
				group by itemno
			) as e on a.itemno=e.itemno
            
            left join
			(
				select itemno,sum(qty) as qoutct 
				from ictran 
				where type in ('CT') 
				and fperiod<>'99' 
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and (toinv='' or toinv is null) 
	   			
	    			<cfif form.period neq "">
					and fperiod+0 < '#form.period#'
	   			</cfif>
	   			
	    		 
				group by itemno
			) as g on a.itemno=g.itemno
            
	
			left join
			(
				select itemno,sum(qty) as sqty,sum(amt) as sumamt 
				from ictran 
				where type in ('INV','CS','DN') 
				and fperiod<>'99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null) 
				
				<cfif form.period neq "">
					and fperiod+0 < '#form.period#'
	   			</cfif>
				
				 
				group by itemno
			) as f on a.itemno = f.itemno 
			
			
	
			where 0=0
            <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
                and a.itemno>='#form.productfrom#' and a.itemno <='#form.productto#'
            </cfif>
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                and a.category>='#form.catefrom#' and a.category<='#form.cateto#'
            </cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
                and a.wos_group>='#form.groupfrom#' and a.wos_group<='#form.groupto#'
            </cfif>
			<cfif trim(form.suppfrom) neq "" and trim(form.suppto) neq "">
                and a.supp>='#form.suppfrom#' and a.supp<='#form.suppto#'
            </cfif>
        </cfquery>


<cfswitch expression="#form.result#">
	<cfcase value="EXCELDEFAULT">
	
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
	<Style ss:ID="s27">
	<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
	<Borders>
	<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
	<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	</Style>
	<Style ss:ID="s28">
	<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
	</Style>
	<Style ss:ID="s29">
	<NumberFormat ss:Format="#,###,###,##0"/>
	</Style>
	<Style ss:ID="s30">
	<Borders>
	<Border ss:Position="Bottom" ss:LineStyle="Double" ss:Weight="3"/>
	</Borders>
	<NumberFormat ss:Format="#,###,###,##0"/>
	</Style>
	<Style ss:ID="s32">
	<Alignment ss:Vertical="Center"/>
	<Borders>
	<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<Font ss:FontName="Verdana" x:Family="Swiss"/>
	</Style>
	<Style ss:ID="s34">
	<Alignment ss:Horizontal="Left" ss:Vertical="Center"/>
	<Borders>
	<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
	</Borders>
	<Font ss:FontName="Verdana" x:Family="Swiss"/>
	</Style>
	</Styles>
	<Worksheet ss:Name="Reorder Advice">
	<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
	<Column ss:AutoFitWidth="0" ss:Width="43.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="253.75"/>
	<Column ss:AutoFitWidth="0" ss:Width="73.75" ss:Span="3"/>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
	<Cell ss:MergeAcross="4" ss:StyleID="s22"><Data ss:Type="String">Reorder Advice</Data></Cell>
	</Row>
	<cfoutput>
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
	<Cell ss:MergeAcross="3" ss:StyleID="s34"><Data ss:Type="String"><cfif getgeneral.compro neq "">#getgeneral.compro#</cfif></Data></Cell>
	<Cell ss:StyleID="s32"><Data ss:Type="String">#dateformat(now(),"dd/mm/yyyy")#</Data></Cell>
	</Row>
	</cfoutput>
	
	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
	<Cell ss:StyleID="s27"><Data ss:Type="String">No</Data></Cell>
	<Cell ss:StyleID="s27"><Data ss:Type="String">Product</Data></Cell>
    <cfif getdisplaydetail.report_aitemno eq 'Y'>
    <Cell ss:StyleID="s27"><Data ss:Type="String">Product Code</Data></Cell>
    </cfif>
	<Cell ss:StyleID="s27"><Data ss:Type="String">Balance</Data></Cell>
	<Cell ss:StyleID="s27"><Data ss:Type="String">Minimum</Data></Cell>
	<Cell ss:StyleID="s27"><Data ss:Type="String">Reorder</Data></Cell>
	</Row>
	
	<Row ss:AutoFitHeight="0" ss:Height="20.0625"/>
	
	<cfoutput query="getitem">
		<cfset rcqty=0>
		<cfset invqty=0><cfset cnqty=0>
		<cfset prqty=0><cfset dnqty=0>
		<cfset doqty=0><cfset csqty=0>
		<cfset issqty=0>
		<cfset oaiqty=0><cfset oarqty=0>
		<cfset ctqty=0>
		<cfset reorder=0>
		<cfset itembal=0>
		<cfset minqty=0>
			
		<cfset itembal=getitem.qtybf>
		<cfset minqty=getitem.minimum>
		

		<cfif lcase(HcomID) eq "eocean_i">
			<cfset balonhand=getitem.balance2>
		<cfelse>
			<cfset balonhand=getitem.balance>
		</cfif>
        
		<cfif balonhand lt minqty>
			<cfset reorder=minqty-balonhand>
			<cfwddx action = "cfml2wddx" input = "#itemno# - #desp#" output = "wddxText">
			<cfwddx action = "cfml2wddx" input = "#aitemno#" output = "wddxText2">
			<Row ss:AutoFitHeight="0" ss:Height="12">
			<Cell ss:StyleID="s29"><Data ss:Type="Number">#i#</Data></Cell>
			<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText#</Data></Cell>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
            <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText2#</Data></Cell>
            </cfif>
			<Cell ss:StyleID="s29"><Data ss:Type="Number">#balonhand#</Data></Cell>
			<Cell ss:StyleID="s29"><Data ss:Type="Number">#minqty#</Data></Cell>
			<Cell ss:StyleID="s29"><Data ss:Type="Number">#reorder#</Data></Cell>
			</Row>
			<cfset i=incrementvalue(i)>
		</cfif>
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

	<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#_IL_RA_#huserid#.xls" output="#tostring(data)#">
    <cfheader name="Content-Disposition" value="inline; filename=#dts#_IL_RA_#huserid#.xls">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_IL_RA_#huserid#.xls">
	</cfcase>

	<cfcase value="HTML">
	<html>
	<head>
	<title>Reorder Advise</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
	</head>
	
	<body>
	<h1 align="center">Reorder Advise</h1>
	<table width="100%" border="0" align="center">
		<cfoutput>
		<tr>
			<td colspan="3"><font size="2" face="Times New Roman, Times, serif"><cfif getgeneral.compro neq "">#getgeneral.compro#</cfif></font></td>
			<td>&nbsp;</td>
			<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		</cfoutput>
		<tr><td colspan="100%"><hr></td></tr>
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">No</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">Item No.</font></div></td>
            <cfif getdisplaydetail.report_aitemno eq 'Y'>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">Product Code</font></div></td>
            </cfif>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">Description</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Balance</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Minimum</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">Reorder</font></div></td>
		</tr>
		<tr><td colspan="100%"><hr></td></tr>
		<cfoutput query="getitem">
			<cfset rcqty=0>
			<cfset invqty=0><cfset cnqty=0>
			<cfset prqty=0><cfset dnqty=0>
			<cfset doqty=0><cfset csqty=0>
			<cfset issqty=0>
			<cfset oaiqty=0><cfset oarqty=0>
			<cfset ctqty=0>
			<cfset reorder=0>
			<cfset itembal=0>
			<cfset minqty=0>
			
			<cfset itembal=getitem.qtybf>
			<cfset minqty=getitem.minimum>
		
			<cfif lcase(HcomID) eq "eocean_i">
			<cfset balonhand=getitem.balance2>
			<cfelse>
			<cfset balonhand=getitem.balance>
			</cfif>
            
			<cfif balonhand lt minqty>
				<cfset reorder=minqty-balonhand>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><!--- #getbal.qtybf#, #getbal.qin#, #getbal.qout# --->#i#.</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#itemno#</font></div></td>
                    <cfif getdisplaydetail.report_aitemno eq 'Y'>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#aitemno#</font></div></td>
                    </cfif>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#desp#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#balonhand#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#minqty#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#reorder#</font></div></td>
				</tr>
				<cfset i=incrementvalue(i)>
			</cfif>
		</cfoutput>
	</table>
	
	<cfif getitem.recordcount eq 0><h3>Sorry, No records were found.</h3></cfif>
	<br>
	<br>
	<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
	<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
	</body>
	</html>
	</html>
	</cfcase>
</cfswitch>