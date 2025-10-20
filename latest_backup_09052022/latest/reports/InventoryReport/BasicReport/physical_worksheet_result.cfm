<cfswitch expression="#form.result#">
	<cfcase value="EXCEL">
    
    <cfquery name="getgeneral" datasource="#dts#">
	select compro,lmodel from gsetup;
</cfquery>
<cfif form.datefrom neq "">
<cfset ndate = createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2))>
<cfset form.datefrom = ndate >
</cfif>
<cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
</cfif>

<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
<cfif form.productfrom neq "" and form.productto neq "">
	and itemno between '#form.productfrom#' and '#form.productto#'
</cfif> group by frrefno
</cfquery>

<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfset billupdated=valuelist(getdoupdated.frrefno)>

<cfset totalqty=0>
<cfset totalact=0>

<cfquery name="getgroup" datasource="#dts#">
	select distinct ifnull(a.wos_group,'') as wos_group,(select desp from icgroup where wos_group=a.wos_group) as groupdesp
	from icitem as a 
	
	left join
	(
		select a.itemno,(ifnull(a.qtybf,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance
		from icitem as a
		
		left join
		(
			select itemno,sum(qty) as sum_in 
			from ictran
			where type in (#PreserveSingleQuotes(intrantype)#) 
            and (void = '' or void is null)
			and (linecode <> 'SV' or linecode is null)
			<cfif form.periodfrom neq "">
				and fperiod <='#form.periodfrom#' and fperiod<>'99'
			<cfelse>
				and fperiod<>'99'
			</cfif>
			<cfif form.datefrom neq "">
				and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#'  
			</cfif>
			group by itemno
			order by itemno
		) as b on a.itemno=b.itemno
		
		left join
		(
			select itemno,sum(qty) as sum_out 
			from ictran
			where (type in (#PreserveSingleQuotes(outtrantype)#) or 
            (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
            and (void = '' or void is null)
			and (linecode <> 'SV' or linecode is null)
			<cfif form.periodfrom neq "">
				and fperiod <='#form.periodfrom#' and fperiod<>'99'
			<cfelse>
				and fperiod<>'99'
			</cfif>
			<cfif form.datefrom neq "">
				and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' 
			</cfif>
			group by itemno
			order by itemno
		) as c on a.itemno=c.itemno
		
		where a.itemno=a.itemno 
		<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
			and a.category between '#form.categoryfrom#' and '#form.categoryto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and a.itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
		<cfif form.modelfrom neq "" and form.modelto neq "">
			and a.shelf between '#form.modelfrom#' and '#form.modelto#'
		</cfif>
		order by a.itemno
	) as b on a.itemno=b.itemno 

	where a.itemno=a.itemno 
	<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
		and a.category between '#form.categoryfrom#' and '#form.categoryto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
	</cfif>
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and a.itemno between '#form.productfrom#' and '#form.productto#'
	</cfif>
	<cfif form.modelfrom neq "" and form.modelto neq "">
		and a.shelf between '#form.modelfrom#' and '#form.modelto#'
	</cfif>
	<cfif not isdefined("form.include_stock")>
		and b.balance<>0
	</cfif>
	group by a.wos_group
	order by a.wos_group;
</cfquery>

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
		   			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1" ss:Underline="Single"/>
		  		</Style>
                
                <Style ss:ID="s90">
		   			<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
		 	</Styles>
            <Worksheet ss:Name="Inventory Physical Worksheet">
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="220.5"/>
					<Column ss:Width="200.25"/>
					<Column ss:Width="250.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="250.75"/>
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
	<cfwddx action = "cfml2wddx" input = "Inventory Physical Worksheet" output = "wddxText">
    <Row ss:AutoFitHeight="0" ss:Height="20.0625">
    	<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">Inventory Physical Worksheet</Data></Cell>
	</Row>
	<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
    	<cfwddx action = "cfml2wddx" input = "#form.categoryfrom# - #form.categoryto#" output = "wddxText">
       <Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:StyleID="s26"><Data ss:Type="String">CATE: #wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
    	<cfwddx action = "cfml2wddx" input = "#form.groupfrom# - #form.groupto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:StyleID="s26"><Data ss:Type="String">GROUP: #wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
  		<cfwddx action = "cfml2wddx" input = "ITEM NO: #form.productfrom# - #form.productto#" output = "wddxText">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s26"><Data ss:Type="String">ITEM.NO. #form.productfrom# - #form.productto#</Data></Cell>
		</Row>
	</cfif>
	<cfif form.periodfrom neq "">
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">PERIOD: #form.periodfrom#</Data></Cell>
		</Row>
	</cfif>
	<cfif form.datefrom neq "">
    
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:MergeAcross="#c#" ss:StyleID="s24"><Data ss:Type="String">DATE: #form.datefrom#</Data></Cell>
		</Row>
	</cfif>
   
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
    <cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
    <cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd-mm-yyyy")#" output = "wddxText2">
	<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
      			  <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
      			  <Cell ss:StyleID="s26"><Data ss:Type="String"></Data></Cell>
	<Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
	</Row>
	</cfoutput>
	
	<Row ss:AutoFitHeight="0" ss:Height="20.0625">
		<Cell ss:StyleID="s50"><Data ss:Type="String">NO.</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">ITEM NO.</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">ITEM DESCRIPTION</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">UNIT MEASURED</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">BOOK QTY</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">ACTUAL QTY</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">ADJ.QTY</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>#getgeneral.lmodel#</cfoutput></Data></Cell>
	</Row>
	
	<cfoutput query="getgroup">
		<cfset wos_group = getgroup.wos_group>
		<Row ss:AutoFitHeight="0" ss:Height="20.0625">
			<Cell ss:StyleID="s51"><Data ss:Type="String"><u>GROUP: #getgroup.wos_group#</u></Data></Cell>
			<Cell ss:StyleID="s51"><Data ss:Type="String"><u>#getgroup.groupdesp#</u></Data></Cell>
		</Row>
		<cfquery name="getiteminfo" datasource="#dts#">
			select a.itemno,a.aitemno,a.desp,a.despa,a.unit,b.balance,a.qtyactual,a.shelf 
			from icitem as a 
			
			left join
			(
				select a.itemno,a.aitemno,(ifnull(a.qtybf,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance
				from icitem as a
				
				left join
				(
					select itemno,sum(qty) as sum_in 
					from ictran
					where type in (#PreserveSingleQuotes(intrantype)#) 
                    and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "">
						and fperiod <='#form.periodfrom#' and fperiod<>'99'
					<cfelse>
						and fperiod<>'99'
					</cfif>
					<cfif form.datefrom neq "">
						and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' 
					</cfif>
					group by itemno
					order by itemno
				) as b on a.itemno=b.itemno
				
				left join
				(
					select itemno,sum(qty) as sum_out 
					from ictran
					where (type in (#PreserveSingleQuotes(outtrantype)#) or 
            (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "">
					and fperiod <='#form.periodfrom#' and fperiod<>'99'
					<cfelse>
					and fperiod<>'99'
					</cfif>
					<cfif form.datefrom neq "">
					and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' 
					</cfif>
					group by itemno
					order by itemno
				) as c on a.itemno=c.itemno
				
				where a.itemno=a.itemno 
				and <cfif wos_group eq "">(a.wos_group = '#wos_group#' or a.wos_group is null)<cfelse>a.wos_group = '#wos_group#'</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
				and a.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif form.modelfrom neq "" and form.modelto neq "">
				and a.shelf between '#form.modelfrom#' and '#form.modelto#'
				</cfif>
				order by a.itemno
			) as b on a.itemno=b.itemno 
		
			where a.itemno=a.itemno 
			and <cfif wos_group eq "">(a.wos_group = '#wos_group#' or a.wos_group is null)<cfelse>a.wos_group = '#wos_group#'</cfif>
			<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
			and a.category between '#form.categoryfrom#' and '#form.categoryto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif form.modelfrom neq "" and form.modelto neq "">
			and a.shelf between '#form.modelfrom#' and '#form.modelto#'
			</cfif>
			<cfif not isdefined("form.include_stock")>
			and b.balance<>0
			</cfif>
            <cfif lcase(HcomID) eq "simplysiti_i">
            order by a.itemno
            <cfelse>
			order by a.itemno,a.shelf;
            </cfif>
		</cfquery>
		
		<cfloop query="getiteminfo">
         <Row ss:AutoFitHeight="0" ss:Height="23.0625">	
                  <cfwddx action = "cfml2wddx" input = "#getiteminfo.currentrow#." output = "wddxText1">
                  <cfwddx action = "cfml2wddx" input = "#getiteminfo.itemno#" output = "wddxText2">
                  <cfwddx action = "cfml2wddx" input = "#getiteminfo.desp##getiteminfo.despa#" output = "wddxText3">
                  <cfwddx action = "cfml2wddx" input = "#getiteminfo.desp##getiteminfo.despa#" output = "wddxText4">
                  <cfwddx action = "cfml2wddx" input = "#getiteminfo.balance#" output = "wddxText5">
                  <cfwddx action = "cfml2wddx" input = "#getiteminfo.qtyactual#" output = "wddxText6">
                  <cfwddx action = "cfml2wddx" input = "#val(getiteminfo.balance)-val(getiteminfo.qtyactual)#" output = "wddxText7">
                  <cfwddx action = "cfml2wddx" input = "#getiteminfo.shelf#" output = "wddxText8">
                    <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText1#.</Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText2#</Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText3#</Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText4#</Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText5#</Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText6#</Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText7#</Data></Cell>
                    <Cell ss:StyleID="s26"><Data ss:Type="String">#wddxText8#</Data></Cell>
			</Row>
            <cfset totalqty=totalqty+val(getiteminfo.balance)>
            <cfset totalact=totalact+val(getiteminfo.qtyactual)>
            
		</cfloop>
		
	</cfoutput>
    <cfoutput>
    <Row ss:AutoFitHeight="0" ss:Height="20.0625">
    <cfwddx action = "cfml2wddx" input = "Total :" output = "wddxText">
    <cfwddx action = "cfml2wddx" input = "#totalqty#" output = "wddxText9">
    <cfwddx action = "cfml2wddx" input = "#totalact#" output = "wddxText10">
    <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>
        <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>
    <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>

    <Cell ss:StyleID="s90"><Data ss:Type="String">Total :</Data></Cell>
    <Cell ss:StyleID="s90"><Data ss:Type="String">#wddxText9#</Data></Cell>
    <Cell ss:StyleID="s90"><Data ss:Type="String">#wddxText10#</Data></Cell>
        <Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>

    </Row>
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
        <cfheader name="Content-Disposition" value="inline; filename=#dts#_BL_#huserid#.xls">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
	</cfcase>
	
<cfcase value="HTML">

<html>
<head>
<title>Physical Worksheet Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>
<cfif form.datefrom neq "">
<cfset ndate = createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2))>
<cfset form.datefrom = ndate >
</cfif>
<cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
</cfif>

<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
<cfif form.productfrom neq "" and form.productto neq "">
	and itemno between '#form.productfrom#' and '#form.productto#'
</cfif> group by frrefno
</cfquery>
<cfset billupdated=valuelist(getdoupdated.frrefno)>

<cfset totalqty=0>
<cfset totalact=0>

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lmodel from gsetup;
</cfquery>

<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfquery name="getgroup" datasource="#dts#">
	select distinct ifnull(a.wos_group,'') as wos_group,(select desp from icgroup where wos_group=a.wos_group) as groupdesp
	from icitem as a 
	
	left join
	(
		select a.itemno,(ifnull(a.qtybf,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance
		from icitem as a
		
		left join
		(
			select itemno,sum(qty) as sum_in 
			from ictran
			where type in (#PreserveSingleQuotes(intrantype)#) 
            and (void = '' or void is null)
			and (linecode <> 'SV' or linecode is null)
			<cfif form.periodfrom neq "">
				and fperiod <='#form.periodfrom#' and fperiod<>'99'
			<cfelse>
				and fperiod<>'99'
			</cfif>
			<cfif form.datefrom neq "">
				and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#'  
			</cfif>
			group by itemno
			order by itemno
		) as b on a.itemno=b.itemno
		
		left join
		(
			select itemno,sum(qty) as sum_out 
			from ictran
			where (type in (#PreserveSingleQuotes(outtrantype)#) or 
            (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
            and (void = '' or void is null)
			and (linecode <> 'SV' or linecode is null)
			<cfif form.periodfrom neq "">
				and fperiod <='#form.periodfrom#' and fperiod<>'99'
			<cfelse>
				and fperiod<>'99'
			</cfif>
			<cfif form.datefrom neq "">
				and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' 
			</cfif>
			group by itemno
			order by itemno
		) as c on a.itemno=c.itemno
		
		where a.itemno=a.itemno 
		<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
			and a.category between '#form.categoryfrom#' and '#form.categoryto#'
		</cfif>
		<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and a.itemno between '#form.productfrom#' and '#form.productto#'
		</cfif>
		<cfif form.modelfrom neq "" and form.modelto neq "">
			and a.shelf between '#form.modelfrom#' and '#form.modelto#'
		</cfif>
		order by a.itemno
	) as b on a.itemno=b.itemno 

	where a.itemno=a.itemno 
	<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
		and a.category between '#form.categoryfrom#' and '#form.categoryto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
	</cfif>
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		and a.itemno between '#form.productfrom#' and '#form.productto#'
	</cfif>
	<cfif form.modelfrom neq "" and form.modelto neq "">
		and a.shelf between '#form.modelfrom#' and '#form.modelto#'
	</cfif>
	<cfif not isdefined("form.include_stock")>
		and b.balance<>0
	</cfif>
	group by a.wos_group
	order by a.wos_group;
</cfquery>
<body>

<table align="center" width="100%" border="0" cellspacing="0">
	<cfoutput>
	<tr>
		<td colspan="8"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Inventory Physical Worksheet</strong></font></div></td>
	</tr>
	<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATE: #form.categoryfrom# - #form.categoryto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM.NO. #form.productfrom# - #form.productto#</font></div></td>
		</tr>
	</cfif>
	<cfif form.periodfrom neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom#</font></div></td>
		</tr>
	</cfif>
	<cfif form.datefrom neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(form.datefrom,"dd-mm-yyyy")#</font></div></td>
		</tr>
	</cfif>
	<tr>
		<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
        <td></td>
		<td colspan="4"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
	</tr>
	</cfoutput>
	<tr>
		<td colspan="9"><hr/></td>
	</tr>
	<tr>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">NO.</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">ITEM NO.</font></div></td>
        <cfif getdisplaydetail.report_aitemno eq 'Y'>
        	<td><div align="left"><font size="2" face="Times New Roman,Times,serif">PRODUCT CODE</font></div></td>
        </cfif>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">ITEM DESCRIPTION</font></div></td>
		<td><div align="center"><font size="2" face="Times New Roman,Times,serif">UNIT MEASURED</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif">BOOK QTY</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif">ACTUAL QTY</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif">ADJ.QTY</font></div></td>
		<td><div align="center"><font size="2" face="Times New Roman,Times,serif"><cfoutput>#getgeneral.lmodel#</cfoutput></font></div></td>
	</tr>
	<tr>
		<td colspan="9"><hr/></td>
	</tr>
	<cfoutput query="getgroup">
		<cfset wos_group = getgroup.wos_group>
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong><u>GROUP: #getgroup.wos_group#</u></strong></font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong><u>#getgroup.groupdesp#</u></strong></font></div></td>
		</tr>
		<cfquery name="getiteminfo" datasource="#dts#">
			select a.itemno,a.aitemno,a.desp,a.despa,a.unit,b.balance,a.qtyactual,a.shelf 
			from icitem as a 
			
			left join
			(
				select a.itemno,a.aitemno,(ifnull(a.qtybf,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance
				from icitem as a
				
				left join
				(
					select itemno,sum(qty) as sum_in 
					from ictran
					where type in (#PreserveSingleQuotes(intrantype)#) 
                    and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "">
						and fperiod <='#form.periodfrom#' and fperiod<>'99'
					<cfelse>
						and fperiod<>'99'
					</cfif>
					<cfif form.datefrom neq "">
						and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' 
					</cfif>
					group by itemno
					order by itemno
				) as b on a.itemno=b.itemno
				
				left join
				(
					select itemno,sum(qty) as sum_out 
					from ictran
					where (type in (#PreserveSingleQuotes(outtrantype)#) or 
            (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                    and (void = '' or void is null)
					and (linecode <> 'SV' or linecode is null)
					<cfif form.periodfrom neq "">
					and fperiod <='#form.periodfrom#' and fperiod<>'99'
					<cfelse>
					and fperiod<>'99'
					</cfif>
					<cfif form.datefrom neq "">
					and wos_date <= '#lsdateformat(form.datefrom,"yyyy-mm-dd")#' 
					</cfif>
					group by itemno
					order by itemno
				) as c on a.itemno=c.itemno
				
				where a.itemno=a.itemno 
				and <cfif wos_group eq "">(a.wos_group = '#wos_group#' or a.wos_group is null)<cfelse>a.wos_group = '#wos_group#'</cfif>
				<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
				and a.category between '#form.categoryfrom#' and '#form.categoryto#'
				</cfif>
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
				</cfif>
				<cfif form.modelfrom neq "" and form.modelto neq "">
				and a.shelf between '#form.modelfrom#' and '#form.modelto#'
				</cfif>
				order by a.itemno
			) as b on a.itemno=b.itemno 
		
			where a.itemno=a.itemno 
			and <cfif wos_group eq "">(a.wos_group = '#wos_group#' or a.wos_group is null)<cfelse>a.wos_group = '#wos_group#'</cfif>
			<cfif trim(form.categoryfrom) neq "" and trim(form.categoryto) neq "">
			and a.category between '#form.categoryfrom#' and '#form.categoryto#'
			</cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			<cfif form.modelfrom neq "" and form.modelto neq "">
			and a.shelf between '#form.modelfrom#' and '#form.modelto#'
			</cfif>
			<cfif not isdefined("form.include_stock")>
			and b.balance<>0
			</cfif>
            <cfif lcase(HcomID) eq "simplysiti_i">
            order by a.itemno
            <cfelse>
			order by a.itemno,a.shelf;
            </cfif>
		</cfquery>
		
		<cfloop query="getiteminfo">
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.currentrow#.</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.itemno#</font></div></td>		
                <cfif getdisplaydetail.report_aitemno eq 'Y'>
                	<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.aitemno#</font></div></td>
                </cfif>
				<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.desp##getiteminfo.despa#</font></div></td>
				<td><div align="center"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.unit#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.balance#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.qtyactual#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#val(getiteminfo.balance)-val(getiteminfo.qtyactual)#</font></div></td>
				<td><div align="center"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.shelf#</font></div></td>
			</tr>
            <cfset totalqty=totalqty+val(getiteminfo.balance)>
            <cfset totalact=totalact+val(getiteminfo.qtyactual)>
            
		</cfloop>
		<tr>
			<td><br/></td>
		</tr>
	</cfoutput>
    <cfoutput>
    <tr><td colspan="100%"><hr></td></tr>
    <tr>
    <td colspan="3"></td>
    <cfif getdisplaydetail.report_aitemno eq 'Y'>
    	<td></td>
    </cfif>
    <td>Total :</td>
    <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#totalqty#</font></div></td>
    <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#totalact#</font></div></td>
    </tr>
    </cfoutput>
</table>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>
</cfcase>
</cfswitch>