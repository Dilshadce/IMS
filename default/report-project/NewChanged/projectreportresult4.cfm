<cfswitch expression="#form.result#">
<cfcase value="HTML">
<cfquery name="getgeneral" datasource="#dts#">
	select compro,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lPROJECT,lJOB from gsetup
</cfquery>

<cfparam name="form.usecostiniss" default="">
<cfparam name="grouptotal" default="0">
<cfparam name="itemtotal" default="0">
<cfparam name="grandtotal" default="0">
<cfparam name="qtygrouptotal" default="0">
<cfparam name="qtyitemtotal" default="0">
<cfparam name="qtygrandtotal" default="0">
<html>
<head>
<title><cfoutput>#getgeneral.lPROJECT#</cfoutput> Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<!--- <cfquery name="getgeneral" datasource="#dts#">
	select compro,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION from gsetup
</cfquery> --->

<cfquery name="getgsetup2" datasource='#dts#'>
	Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>

<cfswitch expression="#url.type#">
	<cfcase value="listprojitem">
		<cfset title = ucase(getgeneral.lPROJECT)&" TRANSACTION LISTING">
	</cfcase>
	<cfcase value="salesiss">
		<cfset title = ucase(getgeneral.lPROJECT)&" SALES - ISSUE REPORT">
	</cfcase>
	<cfcase value="projitemiss">
		<cfset title = ucase(getgeneral.lPROJECT)&" PRODUCT ISSUE REPORT">
	</cfcase>
	<cfcase value="itemprojiss">
		<cfset title = "ITEM "&ucase(getgeneral.lPROJECT)&" ISSUE REPORT">
		<cfquery name="getinfo" datasource="#dts#">
			select p.source,p.project,ifnull(b.sumissamt,0) as sumissamt,ifnull(b.sumissqty,0) as sumissqty,b.itemno,b.desp,b.wos_group
			from project p
			
			left join(
				select <cfif form.usecostiniss neq "">sum(qty*it_cos)<cfelse>sum(amt)</cfif> as sumissamt,sum(qty) as sumissqty,source,itemno,desp,wos_group
				from ictran
				where (void = '' or void is null) and source<>'' and type='ISS'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
				</cfif>
                <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
					and job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
				</cfif>
				<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
					and category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Catefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cateto#">
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
				</cfif>
				group by source,itemno,desp,wos_group
			)as b on b.source=p.source
			
			where p.porj='P'
			and ifnull(b.sumissqty,0) <> 0
			order by b.wos_group,b.itemno,p.source
		</cfquery>
	</cfcase>
</cfswitch>
<body>
<table align="center" width="80%" border="0" cellspacing="0" cellpadding="1">
	<cfoutput>
	<tr>
		<td colspan="100%">
			<div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>#title#</strong></font></div>
		</td>
	</tr>
	<cfif isdefined("form.projectfrom") and form.projectfrom neq "" and form.projectto neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lPROJECT# From #form.projectfrom# To #form.projectto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Product From #form.productfrom# To #form.productto#</font></div></td>
		</tr>
	</cfif>
    <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Job From #form.jobfrom# To #form.jobto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lCATEGORY# From #form.Catefrom# To #form.Cateto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lGROUP# From #form.groupfrom# To #form.groupto#</font></div></td>
		</tr>
	</cfif>
    <cfif periodfrom neq "" and periodto neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Period From #periodfrom# To #periodto#</font></div></td>
      	</tr>
    </cfif>
    <cfif datefrom neq "" and dateto neq "">
      	<tr>
        	<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Date From #datefrom# To #dateto#</font></div></td>
      	</tr>
    </cfif>
	<tr>
		<td colspan="2"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
	</tr>
	</cfoutput>
	<tr><td height="5" colspan="100%"><hr></td></tr>
	<tr>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY ISSUE</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMT ISSUE</font></div></td>
	</tr>
	<tr><td height="5" colspan="100%"><hr></td></tr>
	<!--- INITIALIZE thisproj,thisgroup --->
	<cfset thisitem="ZZZZZZZZZZ">
	<cfset thisgroup="ZZZZZZZZZZ">
	<cfoutput query="getinfo">
		<cfif thisitem neq "ZZZZZZZZZZ" and thisitem neq getinfo.itemno and thisgroup eq getinfo.wos_group>
			<tr><td colspan="100%"><hr></td></tr>
			<tr>
				<td colspan="2"></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#qtyitemtotal#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(itemtotal,",.__")#</font></div></td>
			</tr>
			<cfset itemtotal=0>
			<cfset qtyitemtotal=0>
		</cfif>
		<cfif thisgroup neq getinfo.wos_group>
			<cfif thisgroup neq "ZZZZZZZZZZ">
				<tr><td colspan="100%"><hr></td></tr>
				<tr>
					<td colspan="2"></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#qtyitemtotal#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(itemtotal,",.__")#</font></div></td>
				</tr>
				<cfset itemtotal=0>
				<cfset qtyitemtotal=0>
			</cfif>
			<cfif thisgroup neq "ZZZZZZZZZZ">
				<tr><td colspan="100%"><hr></td></tr>
				<tr>
					<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">GROUP TOTAL:</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#qtygrouptotal#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(grouptotal,",.__")#</font></div></td>
				</tr>
			</cfif>
			<cfset thisgroup=getinfo.wos_group>
			<cfset thisitem="ZZZZZZZZZZ">
			<cfset grouptotal=0>
			<cfset itemtotal=0>
			<cfset qtygrouptotal=0>
			<cfset qtyitemtotal=0>
			<tr>
				<td colspan="4"><font size="2" face="Times New Roman, Times, serif"><b>GROUP : #getinfo.wos_group#</b></font></td>
			</tr>
		</cfif>
		<cfif thisitem neq getinfo.itemno>
			<cfset thisitem=getinfo.itemno>
			<tr>
				<td><font size="2" face="Times New Roman, Times, serif"><u>#getinfo.itemno#</u></font></td>
				<td colspan="3"><font size="2" face="Times New Roman, Times, serif"><u>#getinfo.desp#</u></font></td>
			</tr>
		</cfif>
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.source#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.project#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getinfo.sumissqty#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(sumissamt),stDecl_UPrice)#</font></div></td>
		</tr>
		<cfset grouptotal=grouptotal+val(sumissamt)>
		<cfset itemtotal=itemtotal+val(sumissamt)>
		<cfset grandtotal=grandtotal+val(sumissamt)>
		<cfset qtygrouptotal=qtygrouptotal+val(sumissqty)>
		<cfset qtyitemtotal=qtyitemtotal+val(sumissqty)>
		<cfset qtygrandtotal=qtygrandtotal+val(sumissqty)>
	</cfoutput>
	<tr><td height="2" colspan="100%"><hr></td></tr>
	<tr>
		<td colspan="2"></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#qtyitemtotal#</cfoutput></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(itemtotal,",.__")#</cfoutput></font></div></td>
	</tr>
	<tr><td height="2" colspan="100%"><hr></td></tr>
	<tr>
		<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">GROUP TOTAL:</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#qtygrouptotal#</cfoutput></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(grouptotal,",.__")#</cfoutput></font></div></td>
	</tr>
	<tr><td colspan="100%"><hr></td></tr>
	<tr>
		<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>GRAND TOTAL:</strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#qtygrandtotal#</cfoutput></strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(grandtotal,",.__")#</cfoutput></strong></font></div></td>
	</tr>
</table>
</body>
</html>
</cfcase>

<cfcase value="EXCELDEFAULT">
<cfquery name="getgeneral" datasource="#dts#">
	select compro,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lPROJECT,lJOB from gsetup
</cfquery>

<cfparam name="form.usecostiniss" default="">
<cfparam name="grouptotal" default="0">
<cfparam name="itemtotal" default="0">
<cfparam name="grandtotal" default="0">
<cfparam name="qtygrouptotal" default="0">
<cfparam name="qtyitemtotal" default="0">
<cfparam name="qtygrandtotal" default="0">
<cfoutput>
<cfwddx action = "cfml2wddx" input = "#getgeneral.lCATEGORY# From #getgeneral.lPROJECT#" output = "wddxText">
<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText# Report</Data></Cell></cfoutput>
<!--- <cfquery name="getgeneral" datasource="#dts#">
	select compro,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION from gsetup
</cfquery> --->

<cfquery name="getgsetup2" datasource='#dts#'>
	Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>

<cfswitch expression="#url.type#">
	<cfcase value="listprojitem">
		<cfset title = ucase(getgeneral.lPROJECT)&" TRANSACTION LISTING">
	</cfcase>
	<cfcase value="salesiss">
		<cfset title = ucase(getgeneral.lPROJECT)&" SALES - ISSUE REPORT">
	</cfcase>
	<cfcase value="projitemiss">
		<cfset title = ucase(getgeneral.lPROJECT)&" PRODUCT ISSUE REPORT">
	</cfcase>
	<cfcase value="itemprojiss">
		<cfset title = "ITEM "&ucase(getgeneral.lPROJECT)&" ISSUE REPORT">
		<cfquery name="getinfo" datasource="#dts#">
			select p.source,p.project,ifnull(b.sumissamt,0) as sumissamt,ifnull(b.sumissqty,0) as sumissqty,b.itemno,b.desp,b.wos_group
			from project p
			
			left join(
				select <cfif form.usecostiniss neq "">sum(qty*it_cos)<cfelse>sum(amt)</cfif> as sumissamt,sum(qty) as sumissqty,source,itemno,desp,wos_group
				from ictran
				where (void = '' or void is null) and source<>'' and type='ISS'
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
				<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
				</cfif>
                <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
					and job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
				</cfif>
				<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
					and category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Catefrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cateto#">
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
				</cfif>
				group by source,itemno,desp,wos_group
			)as b on b.source=p.source
			
			where p.porj='P'
			and ifnull(b.sumissqty,0) <> 0
			order by b.wos_group,b.itemno,p.source
		</cfquery>
	</cfcase>
</cfswitch>
				
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
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                <Style ss:ID="s51">
				<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
				<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                <Style ss:ID="s52">
		   			<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
                 <Style ss:ID="s53">
		   			<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
		  		</Style>
                
                <Style ss:ID="s55">
		   			<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
					<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
						
		   			</Borders>
		  		</Style>
            
		 	</Styles>
			
			<Worksheet ss:Name="Print Profit Margin Report">
				<cfoutput>
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="150.5"/>
					<Column ss:Width="300.25"/>
					<Column ss:Width="150.75"/>

					<Column ss:AutoFitWidth="0" ss:Width="200.75"/>
					<Column ss:Width="50.75"/>
					<Column ss:Width="80.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
                    <cfset d="8">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
                         <cfset d=d-3>
                         </cfoutput>
                        <cfoutput>
	 <Row ss:AutoFitHeight="0" ss:Height="23.0625">
     <cfwddx action = "cfml2wddx" input = "#title#" output = "wddxText">
		<Cell ss:MergeAcross="#d#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
	</Row>
	<cfif isdefined("form.projectfrom") and form.projectfrom neq "" and form.projectto neq "">
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
        <cfwddx action = "cfml2wddx" input = "#getgeneral.lPROJECT# From #form.projectfrom# To #form.projectto#" output = "wddxText">
			<Cell ss:MergeAcross="#d#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
        <cfwddx action = "cfml2wddx" input = "#form.productfrom# To #form.productto#" output = "wddxText">
			<Cell ss:MergeAcross="#d#" ss:StyleID="s22"><Data ss:Type="String">Product From #wddxText#</Data></Cell>
		</Row>
	</cfif>
    <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
         <cfwddx action = "cfml2wddx" input = "#form.jobfrom# To #form.jobto#" output = "wddxText">
         <Cell ss:MergeAcross="#d#" ss:StyleID="s22"><Data ss:Type="String">Job From #wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
        <cfwddx action = "cfml2wddx" input = "#getgeneral.lCATEGORY# From #form.Catefrom# To #form.Cateto#" output = "wddxText">
<Cell ss:MergeAcross="#d#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
        <cfwddx action = "cfml2wddx" input = "#getgeneral.lGROUP# From #form.groupfrom# To #form.groupto#" output = "wddxText">
        <Cell ss:MergeAcross="#d#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
		</Row>
	</cfif>
    <cfif periodfrom neq "" and periodto neq "">
      	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
        <cfwddx action = "cfml2wddx" input = "#periodfrom# To #periodto#" output = "wddxText">
         <Cell ss:MergeAcross="#d#" ss:StyleID="s22"><Data ss:Type="String">Period From #wddxText#</Data></Cell>
      	</Row>
    </cfif>
    <cfif datefrom neq "" and dateto neq "">
      	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
        <cfwddx action = "cfml2wddx" input = "#datefrom# To #dateto#" output = "wddxText">
        <Cell ss:MergeAcross="#d#" ss:StyleID="s22"><Data ss:Type="String">Date From #wddxText#</Data></Cell>
      	</Row>
    </cfif>
    
   
<Row ss:AutoFitHeight="0" ss:Height="23.0625">
<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
<cfwddx action = "cfml2wddx" input = "#dateformat(now(),"dd-mm-yyyy")#" output = "wddxText2">
	<Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell>
    <Cell ss:StyleID="s27"><Data ss:Type="String"></Data></Cell>
    <Cell ss:StyleID="s27"><Data ss:Type="String"></Data></Cell>
    <Cell ss:StyleID="s53"><Data ss:Type="String">#wddxText2#</Data></Cell>
	</Row>
	</cfoutput>
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:StyleID="s50"><Data ss:Type="String">ITEM NO</Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">DESCRIPTION</Data></Cell>
					<Cell ss:StyleID="s52"><Data ss:Type="String">QTY ISSUE</Data></Cell>
					<Cell ss:StyleID="s52"><Data ss:Type="String">AMT ISSUE</Data></Cell>
</Row>
	
	<!--- INITIALIZE thisproj,thisgroup --->
	<cfset thisitem="ZZZZZZZZZZ">
	<cfset thisgroup="ZZZZZZZZZZ">
	<cfoutput query="getinfo">
		<cfif thisitem neq "ZZZZZZZZZZ" and thisitem neq getinfo.itemno and thisgroup eq getinfo.wos_group>
			<Row ss:AutoFitHeight="0" ss:Height="23.0625"><Cell ss:StyleID="s27"><Data ss:Type="String"><cfoutput>#wddxText#</cfoutput></Data></Cell>
            </Row>
			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
				 <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
                 <cfwddx action = "cfml2wddx" input = "#qtyitemtotal#" output = "wddxText">
                 <cfwddx action = "cfml2wddx" input = "#numberformat(itemtotal,",.__")#" output = "wddxText2">
				<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText#</Data></Cell>
				<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText2#</Data></Cell>
			</Row>
			<cfset itemtotal=0>
			<cfset qtyitemtotal=0>
		</cfif>
		<cfif thisgroup neq getinfo.wos_group>
			<cfif thisgroup neq "ZZZZZZZZZZ">
<Row ss:AutoFitHeight="0" ss:Height="23.0625"><Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell></Row>
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
                    <cfwddx action = "cfml2wddx" input = "#qtyitemtotal#" output = "wddxText">
                 <cfwddx action = "cfml2wddx" input = "#numberformat(itemtotal,",.__")#" output = "wddxText2">
				<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText#</Data></Cell>
				<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText2#</Data></Cell>
				</Row>
				<cfset itemtotal=0>
				<cfset qtyitemtotal=0>
			</cfif>
			<cfif thisgroup neq "ZZZZZZZZZZ">
				<Row ss:AutoFitHeight="0" ss:Height="23.0625"><Cell ss:StyleID="s27"><Data ss:Type="String">#wddxText#</Data></Cell></Row>
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					 <Cell ss:StyleID="s52"><Data ss:Type="String">GROUP TOTAL:</Data></Cell>
                      <cfwddx action = "cfml2wddx" input = "#qtygrouptotal#" output = "wddxText">
                 <cfwddx action = "cfml2wddx" input = "#numberformat(grouptotal,",.__")#" output = "wddxText2">
					<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText#</Data></Cell>
				<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText2#</Data></Cell>
				</Row>
			</cfif>
			<cfset thisgroup=getinfo.wos_group>
			<cfset thisitem="ZZZZZZZZZZ">
			<cfset grouptotal=0>
			<cfset itemtotal=0>
			<cfset qtygrouptotal=0>
			<cfset qtyitemtotal=0>
			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
             <cfwddx action = "cfml2wddx" input = "#getinfo.wos_group#" output = "wddxText">
             <Cell ss:StyleID="s52"><Data ss:Type="String">GROUP : #wddxText#</Data></Cell>
			</Row>
		</cfif>
		<cfif thisitem neq getinfo.itemno>
			<cfset thisitem=getinfo.itemno>
			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
             <cfwddx action = "cfml2wddx" input = "#getinfo.itemno#" output = "wddxText">
              <cfwddx action = "cfml2wddx" input = "#getinfo.desp#" output = "wddxText2">
				<Cell ss:StyleID="s52"><Data ss:Type="String"><cfoutput>#wddxText#</cfoutput></Data></Cell>
                
				<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText2#</Data></Cell>
			</Row>
		</cfif>
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
         <cfwddx action = "cfml2wddx" input = "#getinfo.source#" output = "wddxText">
          <cfwddx action = "cfml2wddx" input = "#getinfo.project#" output = "wddxText2">
           <cfwddx action = "cfml2wddx" input = "#getinfo.sumissqty#" output = "wddxText3">
            <cfwddx action = "cfml2wddx" input = "#numberformat(val(sumissamt),stDecl_UPrice)#" output = "wddxText4">
            
			<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText#</Data></Cell>
				<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText2#</Data></Cell>
                <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText3#</Data></Cell>
				<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText4#</Data></Cell>
		</Row>
		<cfset grouptotal=grouptotal+val(sumissamt)>
		<cfset itemtotal=itemtotal+val(sumissamt)>
		<cfset grandtotal=grandtotal+val(sumissamt)>
		<cfset qtygrouptotal=qtygrouptotal+val(sumissqty)>
		<cfset qtyitemtotal=qtyitemtotal+val(sumissqty)>
		<cfset qtygrandtotal=qtygrandtotal+val(sumissqty)>
	</cfoutput>
				
	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
		<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
         <cfwddx action = "cfml2wddx" input = "#qtyitemtotal#" output = "wddxText">
         <cfwddx action = "cfml2wddx" input = "#numberformat(itemtotal,",.__")#" output = "wddxText2">
         <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s52"><Data ss:Type="String"><cfoutput>#wddxText#</cfoutput></Data></Cell>
		<Cell ss:StyleID="s52"><Data ss:Type="String"><cfoutput>#wddxText2#</cfoutput></Data></Cell>
</Row>

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
    <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s52"><Data ss:Type="String">GROUP : #wddxText#</Data></Cell>
        <cfwddx action = "cfml2wddx" input = "#qtygrouptotal#" output = "wddxText">
        <cfwddx action = "cfml2wddx" input = "#numberformat(grouptotal,",.__")#" output = "wddxText2">
		<Cell ss:StyleID="s52"><Data ss:Type="String"><cfoutput>#wddxText#</cfoutput></Data></Cell>
		<Cell ss:StyleID="s52"><Data ss:Type="String"><cfoutput>#wddxText2#</cfoutput></Data></Cell>
	</Row>
	
	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
    <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s52"><Data ss:Type="String">GROUP : #wddxText#</Data></Cell>
        <cfwddx action = "cfml2wddx" input = "#qtygrandtotal#" output = "wddxText">
        <cfwddx action = "cfml2wddx" input = "#numberformat(grouptotal,",.__")#" output = "wddxText2">
		<Cell ss:StyleID="s52"><Data ss:Type="String"><cfoutput>#wddxText#</cfoutput></Data></Cell>
		<Cell ss:StyleID="s52"><Data ss:Type="String"><cfoutput>#wddxText2#</cfoutput></Data></Cell>
	</Row>
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
	</cfcase></cfswitch>