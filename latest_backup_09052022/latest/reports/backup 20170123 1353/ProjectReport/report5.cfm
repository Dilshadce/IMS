<cfswitch expression="#form.result#">
<cfcase value="HTML">
<cfquery name="getgeneral" datasource="#dts#">
	select compro,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lPROJECT,lJOB from gsetup
</cfquery>

<cfparam name="form.usecostiniss" default="">
<cfparam name="totalin" default="0">
<cfparam name="totalout" default="0">
<cfparam name="totalamt" default="0">
<html>
<head>
<title><cfoutput>#getgeneral.lPROJECT#</cfoutput> Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgsetup2" datasource='#dts#'>
	Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<cfset countdecl = ".">
<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset countdecl = countdecl & "_">
</cfloop>
<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>


		<cfset title = ucase(getgeneral.lPROJECT)&" COST & SALES">
		<cfquery name="getinfo" datasource="#dts#">
			select type,refno,amt,taxamt,disamt,refno2,itemno,qty,wos_date,category,wos_group,job,source,custno,name,wos_date FROM ictran
				where 
                (void = '' or void is null) 
                and (source <>'' and source is not null)
                and type in ('RC','OAI','CN','INV','DO','CS','DN','ISS','OAR','PR')
                and (toinv='' or toinv is null) 
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
                </cfif>
                <cfif trim(form.customerFrom) neq "" and trim(form.customerTo) neq "">
					and custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerFrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerTo#">
				</cfif>
				<cfif IsDefined ('form.productFrom') and IsDefined ('form.productTo')>
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
				</cfif>
                <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
					and job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
				</cfif>
				<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
					and category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.categoryFrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.categoryTo#">
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
				</cfif>
				<cfif form.projectfrom neq "" and form.projectto neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
				</cfif>
				order by source,trdatetime,type,refno,itemno
		</cfquery>
<body>
<table align="center" width="90%" border="0" cellspacing="0" cellpadding="1">
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
	<cfif IsDefined ('form.productFrom') and IsDefined ('form.productTo')>
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Product From #form.productfrom# To #form.productto#</font></div></td>
		</tr>
	</cfif>
    <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Job From #form.jobfrom# To #form.jobto#</font></div></td>
		</tr>
	</cfif>
	<cfif IsDefined('form.categoryFrom') and IsDefined('form.categoryTo')>
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lCATEGORY# From #form.categoryFrom# To #form.categoryTo#</font></div></td>
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
		<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td colspan="8"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
	</tr>
	</cfoutput>
	<tr><td height="5" colspan="100%"><hr></td></tr>
	<tr>
		<td><font size="2" face="Times New Roman, Times, serif"><cfoutput>#ucase(getgeneral.lPROJECT)#</cfoutput></font></td>
		<td><font size="2" face="Times New Roman, Times, serif">TYPE</font></td>
		<td><font size="2" face="Times New Roman, Times, serif">REFNO</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">REFNO 2</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">DATE</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">CUSTNO-NAME</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">ITEMNO</font></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">DISCOUNT</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">TAX</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMT</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
	</tr>
	<tr><td height="5" colspan="100%"><hr></td></tr> 
	<cfset project = "">
    <cfset totalgroupin = 0>
    <cfset totalgroupout = 0>
    <cfset totalgroupamt = 0>
	<cfoutput query="getinfo">
   	
   <cfif project neq getinfo.source and getinfo.currentrow neq 1>
   <tr><td colspan="100%"><hr></td></tr>
	<tr>
		<td colspan="6"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL PROJECT:</strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong></strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong></strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong></strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalgroupamt,",.__")#</strong></font></div></td>
        <cfif lcase(hcomid) neq "decor_i">
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalgroupin,",.__")#</strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalgroupout,",.__")#</strong></font></div></td>
        </cfif>
	</tr>
    <tr>
    <td height="10px" colspan="100%"></td>
    </tr>
	<cfset project = getinfo.source>
    <cfset totalgroupin = 0>
    <cfset totalgroupout = 0>
    <cfset totalgroupamt = 0>
   </cfif>
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.source#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.type#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.refno#</font></div></td>
             <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.refno2#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#dateformat(getinfo.wos_date,'YYYY-MM-DD')#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.custno# - #getinfo.name#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.itemno#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(getinfo.qty)#</font></div></td>
            <cfquery name="getdetail" datasource="#dts#">
            SELECT grand,discount FROM artran WHERE 
            type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getinfo.type#">
            and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getinfo.refno#">
            </cfquery>
            <cfquery name="geticdetail" datasource="#dts#">
            SELECT sum(amt) as samt FROM ictran WHERE 
            type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getinfo.type#">
            and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getinfo.refno#">
            </cfquery>
            <cfset discamt = getinfo.disamt>
            <cfset itemamt = getinfo.amt>
            <cfset cost = getinfo.amt + getinfo.taxamt>
            
			<cfif val(getdetail.grand) neq 0 and val(geticdetail.samt) neq 0>
            <cfset discamt = (numberformat(val(getinfo.amt),countdecl)/numberformat(val(geticdetail.samt),countdecl)) * numberformat(val(getdetail.discount),countdecl)>
            <cfset cost = (numberformat(val(getinfo.amt),countdecl)/numberformat(val(geticdetail.samt),countdecl)) * numberformat(val(getdetail.grand),countdecl)>
			</cfif>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(discamt),stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getinfo.taxamt),stDecl_UPrice)#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfif (type eq "RC" or type eq "CN") and (lcase(hcomid) eq 'gorgeous_i' or lcase(hcomid) eq 'mastercare_i' )>(#numberformat(val(getinfo.amt),stDecl_UPrice)#)<cfelse>#numberformat(val(getinfo.amt),stDecl_UPrice)#</cfif></font></div></td>
            <cfif type eq "RC" or type eq "OAI" or type eq "CN">
			<cfset totalgroupamt = totalgroupamt-numberformat(val(getinfo.amt),countdecl)>
            <cfset totalamt=totalamt-numberformat(val(getinfo.amt),countdecl)>
            <cfelse>
            <cfset totalgroupamt = totalgroupamt+numberformat(val(getinfo.amt),countdecl)>
            <cfset totalamt=totalamt+numberformat(val(getinfo.amt),countdecl)>
            </cfif>
            <cfif type eq "RC" or type eq "OAI" or type eq "CN">
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(cost),stDecl_UPrice)#</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">0.00</font></div></td>
			<cfset totalin=totalin+numberformat(val(cost),countdecl)>
            <cfset totalgroupin = totalgroupin+numberformat(val(cost),countdecl)>
            <cfelse>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">0.00</font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(cost),stDecl_UPrice)#</font></div></td>
            <cfset totalout=totalout+numberformat(val(cost),countdecl)>
            <cfset totalgroupout = totalgroupout+numberformat(val(cost),countdecl)>
            
			</cfif>
		</tr>
		<cfset project = getinfo.source>
        <cfif getinfo.currentrow eq getinfo.recordcount>
   <tr><td colspan="100%"><hr></td></tr>
	<tr>
		<td colspan="7"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL PROJECT:</strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong></strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong></strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong></strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalgroupamt,",.__")#</strong></font></div></td>
        <cfif lcase(hcomid) neq "decor_i">
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalgroupin,",.__")#</strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(totalgroupout,",.__")#</strong></font></div></td>
        </cfif>
	</tr>
   </cfif>
	</cfoutput>
	<tr><td colspan="100%"><hr></td></tr>
	<tr>
		<td colspan="7"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>TOTAL:</strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong></strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong></strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong></strong></font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totalamt,stDecl_UPrice)#</cfoutput></strong></font></div></td>
        <cfif lcase(hcomid) neq "decor_i">
		
		<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totalin,stDecl_UPrice)#</cfoutput></strong></font></div></td>
        
        <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(totalout,stDecl_UPrice)#</cfoutput></strong></font></div></td>
        </cfif>
	</tr>
</table>
</body>
</html>
</cfcase>

<cfcase value="EXCEL">
<cfquery name="getgeneral" datasource="#dts#">
	select compro,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lPROJECT,lJOB from gsetup
</cfquery>

<cfparam name="form.usecostiniss" default="">
<cfparam name="totalin" default="0">
<cfparam name="totalout" default="0">
<cfparam name="totalamt" default="0">
<html>
<head>
<title><cfoutput>#getgeneral.lPROJECT#</cfoutput> Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgsetup2" datasource='#dts#'>
	Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<cfset countdecl = ".">
<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset countdecl = countdecl & "_">
</cfloop>
<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>


		<cfset title = ucase(getgeneral.lPROJECT)&" COST & SALES">
		<cfquery name="getinfo" datasource="#dts#">
			select type,refno,amt,taxamt,disamt,itemno,refno2,qty,wos_date,category,wos_group,job,source,custno,name,wos_date FROM ictran
				where 
                (void = '' or void is null) 
                and (source <>'' and source is not null)
                and type in ('RC','OAI','CN','INV','DO','CS','DN','ISS','OAR','PR')
                and (toinv='' or toinv is null) 
				<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
                </cfif>
                <cfif trim(form.customerFrom) neq "" and trim(form.customerTo) neq "">
					and custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerFrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerTo#">
				</cfif>
				<cfif IsDefined ('form.productFrom') and IsDefined ('form.productTo')>
					and itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
				</cfif>
                <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
					and job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
				</cfif>
				<cfif trim(form.categoryFrom) neq "" and trim(form.categoryTo) neq "">
					and category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.categoryFrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.categoryTo#">
				</cfif>
				<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
					and wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
				</cfif>
				<cfif form.projectfrom neq "" and form.projectto neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
				</cfif>
				order by source,trdatetime,type,refno,itemno
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
                 <Style ss:ID="s56">
		   			<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
		   			<Borders>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
		   			</Borders>
		  		</Style>
            <Style ss:ID="s57">
				<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
				<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="9" ss:Bold="1"/>
		  		</Style>
		 	</Styles>
			
			<Worksheet ss:Name="Print Profit Margin Report">
				<cfoutput>
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="70.5"/>
					<Column ss:Width="300.25"/>
					<Column ss:Width="150.75"/>

					<Column ss:AutoFitWidth="0" ss:Width="200.75"/>
					<Column ss:Width="50.75"/>
					<Column ss:Width="80.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="13">
                    <cfset d="9">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>
                         <cfset d=d-0>
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
	<cfif IsDefined ('form.productFrom') and IsDefined ('form.productTo')>
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
	<cfif IsDefined('form.categoryFrom') and IsDefined('form.categoryTo')>
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
        <cfwddx action = "cfml2wddx" input = "#getgeneral.lCATEGORY# From #form.categoryFrom# To #form.categoryTo#" output = "wddxText">
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
     <Cell ss:StyleID="s27"><Data ss:Type="String"></Data></Cell>
      <Cell ss:StyleID="s27"><Data ss:Type="String"></Data></Cell>
       <Cell ss:StyleID="s27"><Data ss:Type="String"></Data></Cell>
        <Cell ss:StyleID="s27"><Data ss:Type="String"></Data></Cell>
         <Cell ss:StyleID="s27"><Data ss:Type="String"></Data></Cell>
          <Cell ss:StyleID="s27"><Data ss:Type="String"></Data></Cell>
           <Cell ss:StyleID="s27"><Data ss:Type="String"></Data></Cell>
            <Cell ss:StyleID="s27"><Data ss:Type="String"></Data></Cell>
    <Cell ss:StyleID="s53"><Data ss:Type="String">#wddxText2#</Data></Cell>
	</Row>
	</cfoutput>
    
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
        <cfwddx action = "cfml2wddx" input = "#ucase(getgeneral.lPROJECT)#" output = "wddxText">
		<Cell ss:StyleID="s50"><Data ss:Type="String"><cfoutput>#wddxText#</cfoutput></Data></Cell>
		<Cell ss:StyleID="s50"><Data ss:Type="String">TYPE</Data></Cell>
					<Cell ss:StyleID="s56"><Data ss:Type="String">REFNO</Data></Cell>
                    <Cell ss:StyleID="s56"><Data ss:Type="String">REFNO 2</Data></Cell>
					<Cell ss:StyleID="s56"><Data ss:Type="String">DATE</Data></Cell>
                    <Cell ss:StyleID="s56"><Data ss:Type="String">CUSTNO-NAME</Data></Cell>
                    <Cell ss:StyleID="s56"><Data ss:Type="String">ITEMNO</Data></Cell>
                    <Cell ss:StyleID="s56"><Data ss:Type="String">QTY</Data></Cell>
                    <Cell ss:StyleID="s56"><Data ss:Type="String">DISCOUNT</Data></Cell>
                    <Cell ss:StyleID="s56"><Data ss:Type="String">TAX</Data></Cell>
                    <Cell ss:StyleID="s56"><Data ss:Type="String">AMT</Data></Cell>
                    <Cell ss:StyleID="s56"><Data ss:Type="String">IN</Data></Cell>
                    <Cell ss:StyleID="s56"><Data ss:Type="String">OUT</Data></Cell>
</Row>
	
	<!--- INITIALIZE thisproj,thisgroup --->
	<cfset project = "">
    <cfset totalgroupin = 0>
    <cfset totalgroupout = 0>
    <cfset totalgroupamt = 0>
	<cfoutput query="getinfo">
   	
   <cfif project neq getinfo.source and getinfo.currentrow neq 1>
			<Row ss:AutoFitHeight="0" ss:Height="23.0625">
				 <Cell ss:StyleID="s52"><Data ss:Type="String">TOTAL PROJECT:</Data></Cell>
                  <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
                 <cfwddx action = "cfml2wddx" input = "#numberformat(totalgroupamt,",.__")#" output = "wddxText">
                 <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText#</Data></Cell>
                 <cfif lcase(hcomid) neq "decor_i">
                 <cfwddx action = "cfml2wddx" input = "#numberformat(totalgroupin,",.__")#" output = "wddxText2">
                 <cfwddx action = "cfml2wddx" input = "#numberformat(totalgroupout,",.__")#" output = "wddxText3">
				<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText2#</Data></Cell>
                <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText3#</Data></Cell>
                </cfif>
			</Row>
			<cfset project = getinfo.source>
    <cfset totalgroupin = 0>
    <cfset totalgroupout = 0>
    <cfset totalgroupamt = 0>
		</cfif>
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
         <cfwddx action = "cfml2wddx" input = "#getinfo.source#" output = "wddxText">
          <cfwddx action = "cfml2wddx" input = "#getinfo.type#" output = "wddxText2">
           <cfwddx action = "cfml2wddx" input = "#getinfo.refno#" output = "wddxText3">
            <cfwddx action = "cfml2wddx" input = "#dateformat(getinfo.wos_date,'YYYY-MM-DD')#" output = "wddxText4">
             <cfwddx action = "cfml2wddx" input = "#getinfo.custno# - #getinfo.name#" output = "wddxText5">
              <cfwddx action = "cfml2wddx" input = "#getinfo.itemno#" output = "wddxText6">
               <cfwddx action = "cfml2wddx" input = "#val(getinfo.qty)#" output = "wddxText7">
               <cfwddx action = "cfml2wddx" input = "#getinfo.refno2#" output = "wddxText8">
               <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText#</Data></Cell>
				<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText2#</Data></Cell>
                <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText3#</Data></Cell>
                <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText8#</Data></Cell>
				<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText4#</Data></Cell>
                <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText5#</Data></Cell>
				<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText6#</Data></Cell>
                <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText7#</Data></Cell>
               <cfquery name="getdetail" datasource="#dts#">
            SELECT grand,discount FROM artran WHERE 
            type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getinfo.type#">
            and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getinfo.refno#">
            </cfquery>
            <cfquery name="geticdetail" datasource="#dts#">
            SELECT sum(amt) as samt FROM ictran WHERE 
            type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getinfo.type#">
            and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getinfo.refno#">
            </cfquery>
            <cfset discamt = getinfo.disamt>
            <cfset itemamt = getinfo.amt>
            <cfset cost = getinfo.amt + getinfo.taxamt>
            
			<cfif val(getdetail.grand) neq 0 and val(geticdetail.samt) neq 0>
            <cfset discamt = (numberformat(val(getinfo.amt),countdecl)/numberformat(val(geticdetail.samt),countdecl)) * numberformat(val(getdetail.discount),countdecl)>
            <cfset cost = (numberformat(val(getinfo.amt),countdecl)/numberformat(val(geticdetail.samt),countdecl)) * numberformat(val(getdetail.grand),countdecl)>
			</cfif>
            <cfwddx action = "cfml2wddx" input = "#numberformat(val(discamt),stDecl_UPrice)#" output = "wddxText8">
		 <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText8#</Data></Cell>
          <cfwddx action = "cfml2wddx" input = "#numberformat(val(getinfo.taxamt),stDecl_UPrice)#" output = "wddxText9">
			<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText9#</Data></Cell>
            <cfwddx action = "cfml2wddx" input = "#numberformat(val(getinfo.amt),stDecl_UPrice)#" output = "wddxText10">
			<Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText10#</Data></Cell>
             <cfset totalgroupamt = totalgroupamt+numberformat(val(getinfo.amt),countdecl)>
            <cfset totalamt=totalamt+numberformat(val(getinfo.amt),countdecl)>
            <cfif type eq "RC" or type eq "OAI" or type eq "CN">
            <cfwddx action = "cfml2wddx" input = "#numberformat(val(cost),stDecl_UPrice)#" output = "wddxText11">
           <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText11#</Data></Cell>
           <Cell ss:StyleID="s52"><Data ss:Type="String">0.00</Data></Cell>
			<cfset totalin=totalin+numberformat(val(cost),countdecl)>
            <cfset totalgroupin = totalgroupin+numberformat(val(cost),countdecl)>
            <cfelse>
            
            <Cell ss:StyleID="s52"><Data ss:Type="String">0.00</Data></Cell>

<cfwddx action = "cfml2wddx" input = "#numberformat(val(cost),stDecl_UPrice)#" output = "wddxText11">
           <Cell ss:StyleID="s52"><Data ss:Type="String">#wddxText11#</Data></Cell>
            <cfset totalout=totalout+numberformat(val(cost),countdecl)>
            <cfset totalgroupout = totalgroupout+numberformat(val(cost),countdecl)>
            
            </cfif>
            </Row>
            <cfset project = getinfo.source>
        <cfif getinfo.currentrow eq getinfo.recordcount>
        <Row ss:AutoFitHeight="0" ss:Height="23.0625">
        <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
        <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
        <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
        <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
        <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
        <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
        <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
      <Cell ss:StyleID="s57"><Data ss:Type="String"><b>TOTAL PROJECT :</b></Data></Cell>
		<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
		
        <cfwddx action = "cfml2wddx" input = "#numberformat(totalgroupamt,",.__")#" output = "wddxText13">
        <Cell ss:StyleID="s57"><Data ss:Type="String"><b>#wddxText13#</b></Data></Cell>
        <cfif lcase(hcomid) neq "decor_i">
        <cfwddx action = "cfml2wddx" input = "#numberformat(totalgroupin,",.__")#" output = "wddxText14">
        <cfwddx action = "cfml2wddx" input = "#numberformat(totalgroupout,",.__")#" output = "wddxText15">
		 <Cell ss:StyleID="s57"><Data ss:Type="String"><b>#wddxText14#</b></Data></Cell>
		 <Cell ss:StyleID="s57"><Data ss:Type="String"><b>#wddxText15#</b></Data></Cell>
        </cfif>
		
        </Row>
        </cfif>
	</cfoutput>
	

	<Row ss:AutoFitHeight="0" ss:Height="23.0625">
    <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
    <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
    <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
    <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
    <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
    <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
    <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
    <Cell ss:StyleID="s57"><Data ss:Type="String">TOTAL:</Data></Cell>
   
		 
		 <Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
		<Cell ss:StyleID="s52"><Data ss:Type="String"></Data></Cell>
        <cfwddx action = "cfml2wddx" input = "#numberformat(totalamt,stDecl_UPrice)#" output = "wddxText">
		<Cell ss:StyleID="s57"><Data ss:Type="String"><cfoutput>#wddxText#</cfoutput></Data></Cell>
        <cfif lcase(hcomid) neq "decor_i">
		<cfwddx action = "cfml2wddx" input = "#numberformat(totalin,stDecl_UPrice)#" output = "wddxText2">
        <cfwddx action = "cfml2wddx" input = "#numberformat(totalout,stDecl_UPrice)#" output = "wddxText3">
		<Cell ss:StyleID="s57"><Data ss:Type="String"><cfoutput>#wddxText2#</cfoutput></Data></Cell>
        
        <Cell ss:StyleID="s57"><Data ss:Type="String"><cfoutput>#wddxText3#</cfoutput></Data></Cell>
        </cfif>
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