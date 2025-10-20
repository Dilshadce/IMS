<cfswitch expression="#form.result#">
	<cfcase value="HTML">
<cfquery name="getgeneral" datasource="#dts#">
	select compro,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lPROJECT,lJOB from gsetup
</cfquery>

<cfparam name="form.marktype" default="rc,pr,inv,do,cs,cn,dn,iss,oai,oar,trin,trou">
<cfparam name="form.sortbycustno" default="">
<cfparam name="form.usecostiniss" default="">
<cfparam name="grouptotal" default="0">
<cfparam name="projtotal" default="0">
<cfparam name="custtotal" default="0">
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
    <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Job From #form.jobfrom# To #form.jobto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Product From #form.productfrom# To #form.productto#</font></div></td>
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
		<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td colspan="5"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
	</tr>
	</cfoutput>
	<tr><td height="5" colspan="100%"><hr></td></tr>
	<cfif url.type eq "listprojitem">
    <cfif isdefined('form.seperatebilltype')>
   	<cfquery name="getinfo" datasource="#dts#">
    <cfloop list="#marktype#" delimiters="," index="i">
    select * from (
			select ic.type,ic.refno,ic.fperiod,ic.wos_date,ic.custno,ic.name,
			ic.itemno,ic.desp,ic.despa,ic.qty,ic.price,ic.unit,ic.it_cos,ic.amt,ic.wos_group,ic.category,
			ic.source,ic.job,proj.project,j.jobdesp
			from ictran ic
			
			left join (
				select source,project
				from project
				where porj='P'
				<cfif form.projectfrom neq "" and form.projectto neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
			)as proj on ic.source=proj.source
			
			left join (
				select source,project as jobdesp
				from project
				where porj='J'
			)as j on ic.job=j.source
			
			where (ic.void = '' or ic.void is null) and ic.type = "#i#"
            <cfif trim(form.periodfrom) neq "" and trim(form.periodto) neq "">
			and ic.fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
            </cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and ic.itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
			</cfif>
            <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
				and ic.job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
			</cfif>
			<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
				and ic.category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Catefrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cateto#">
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and ic.wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
			</cfif>
			<cfif form.projectfrom neq "" and form.projectto neq "">
				and ic.source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and ic.wos_date between #date1# and #date2# 
			</cfif>
			<cfif form.sortbycustno neq "">
				order by ic.source,ic.custno,ic.itemno
			<cfelse>
				order by ic.source,ic.job,ic.refno,ic.wos_group,ic.wos_date
			</cfif>) as #i#
            <cfif i neq listlast(marktype)>
            union all
            </cfif>
            </cfloop>
		</cfquery>
    <cfelse>
    <cfquery name="getinfo" datasource="#dts#">
			select ic.type,ic.refno,ic.fperiod,ic.wos_date,ic.custno,ic.name,
			ic.itemno,ic.desp,ic.despa,ic.qty,ic.price,ic.unit,ic.it_cos,ic.amt,ic.wos_group,ic.category,
			ic.source,ic.job,proj.project,j.jobdesp
			from ictran ic
			
			left join (
				select source,project
				from project
				where porj='P'
				<cfif form.projectfrom neq "" and form.projectto neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
			)as proj on ic.source=proj.source
			
			left join (
				select source,project as jobdesp
				from project
				where porj='J'
			)as j on ic.job=j.source
			
			where (ic.void = '' or ic.void is null) and ic.type in (#ListQualify(marktype,"'")#)
            <cfif trim(form.periodfrom) neq "" and trim(form.periodto) neq "">
			and ic.fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
            </cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and ic.itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
			</cfif>
            <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
				and ic.job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
			</cfif>
			<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
				and ic.category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Catefrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cateto#">
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and ic.wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
			</cfif>
			<cfif form.projectfrom neq "" and form.projectto neq "">
				and ic.source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and ic.wos_date between #date1# and #date2# 
			</cfif>
			<cfif form.sortbycustno neq "">
				order by ic.source,ic.custno,ic.itemno
			<cfelse>
				order by ic.source,ic.job,ic.refno,ic.wos_group,ic.wos_date
			</cfif>
		</cfquery>
	</cfif>
		<tr>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">PD</font></div></td>
            <cfif lcase(hcomid) eq "mphcranes_i" or lcase(hcomid) eq "mphcs_i">
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">CUST NAME</font></div></td>
            <cfelse>
            <td><div align="center"><font size="2" face="Times New Roman, Times, serif">CUSTNO</font></div></td>
            </cfif>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">TYPE</font></div></td>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">REFNO</font></div></td>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
            <td><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM DESPCRIPTION.</font></div></td>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">UNIT</font></div></td>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">U.PRICE</font></div></td>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">AMOUNT</font></div></td>
		</tr>
		<tr><td height="5" colspan="100%"><hr></td></tr>
		
		<cfif form.sortbycustno neq "">
			<!--- INITIALIZE thisproj,thiscust --->
			<cfset thisproj="ZZZZZZZZZZ">
			<cfset thiscust="ZZZZZZZZZZ">
            <cfset thistype ="ZZZZZZZZZZ"> 
			<cfoutput query="getinfo">
            <cfif thistype neq getinfo.type and isdefined('form.seperatebilltype')>>
            <cfset thistype = getinfo.type>
            <cfset thisproj="ZZZZZZZZZZ">
			</cfif>
				<cfif thiscust neq "ZZZZZZZZZZ" and thiscust neq getinfo.custno and thisproj eq getinfo.source>
					<tr><td colspan="100%"><hr></td></tr>
					<tr>
						<td colspan="8"></td>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(custtotal,",.__")#</font></div></td>
					</tr>
					<tr><td colspan="100%"><br></td></tr>
					<cfset custtotal=0>
				</cfif>
				<cfif thisproj neq getinfo.source>
					<cfif thiscust neq "ZZZZZZZZZZ">
						<tr><td colspan="100%"><hr></td></tr>
						<tr>
							<td colspan="8"></td>
							<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(custtotal,",.__")#</font></div></td>
						</tr>
					</cfif>
					<cfset custtotal=0>
					<cfif thisproj neq "ZZZZZZZZZZ">
						<tr><td colspan="100%"><hr></td></tr>
						<tr>
							<td colspan="8"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#ucase(getgeneral.lPROJECT)# TOTAL:</strong></font></div></td>
							<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(projtotal,",.__")#</strong></font></div></td>
						</tr>
					</cfif>
					<cfset thisproj=getinfo.source>
					<cfset thiscust="ZZZZZZZZZZ">
					<cfset projtotal=0>
					<cfset custtotal=0>
					<tr>
						<td colspan="2"><font size="2" face="Times New Roman, Times, serif"><b>#ucase(getgeneral.lPROJECT)# : #getinfo.source#</b></font></td>
						<td colspan="7"><font size="2" face="Times New Roman, Times, serif"><b>#getinfo.project#</b></font></td>
					</tr>
				</cfif>
				<cfif thiscust neq getinfo.custno>
					<cfset thiscust=getinfo.custno>
				</cfif>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.fperiod#</font></div></td>
                    <cfif lcase(hcomid) eq "mphcranes_i" or lcase(hcomid) eq "mphcs_i">
					<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.name#</font></div></td>
                    <cfelse>
                    <td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.custno#</font></div></td>
                    </cfif>
					<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.type#</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.refno#</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.itemno#</font></div></td>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.desp# #getinfo.despa#</font></div></td>
					<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.qty#</font></div></td>
					<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.unit#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getinfo.price),stDecl_UPrice)#</font></div></td>
					<cfif form.usecostiniss neq "" and getinfo.type eq "ISS">
						<cfset thisamt=val(getinfo.qty)*val(getinfo.it_cos)>
					<cfelse>
						<cfset thisamt=val(getinfo.amt)>
					</cfif>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(thisamt),stDecl_UPrice)#</font></div></td>
				</tr>
				<cfset projtotal=projtotal+thisamt>
				<cfset custtotal=custtotal+thisamt>
			</cfoutput>
			<tr><td colspan="100%"><hr></td></tr>
			<tr>
				<td colspan="8"></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><cfoutput>#numberformat(custtotal,",.__")#</cfoutput></font></div></td>
			</tr>
			<tr><td colspan="100%"><hr></td></tr>
			<tr>
				<td colspan="8"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#ucase(getgeneral.lPROJECT)#</cfoutput> TOTAL:</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(projtotal,",.__")#</cfoutput></strong></font></div></td>
			</tr>
		<cfelse>
			<!--- INITIALIZE thisproj,thisjob & thisgroup --->
			<cfset thisproj="ZZZZZZZZZZ">
			<cfset thisjob="ZZZZZZZZZZ">
			<cfset thisgroup="ZZZZZZZZZZ">
            <cfset thistype = "ZZZZZZZZZZ">
			<cfoutput query="getinfo">
            <cfif thistype neq getinfo.type and isdefined('form.seperatebilltype')>
            <cfset thistype = getinfo.type>
            <cfset thisproj="ZZZZZZZZZZ">
			</cfif>
				<cfif thisgroup neq "ZZZZZZZZZZ" and thisgroup neq getinfo.wos_group and thisproj eq getinfo.source>
					<tr><td colspan="100%"><hr></td></tr>
					<tr>
						<td colspan="8"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>GROUP TOTAL:</strong></font></div></td>
						<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(grouptotal,",.__")#</strong></font></div></td>
					</tr>
					<cfset grouptotal=0>
				</cfif>
				<cfif thisproj neq getinfo.source or thisjob neq getinfo.job>
					<cfif thisgroup neq "ZZZZZZZZZZ">
						<tr><td colspan="100%"><hr></td></tr>
						<tr>
							<td colspan="8"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>GROUP TOTAL:</strong></font></div></td>
							<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(grouptotal,",.__")#</strong></font></div></td>
						</tr>
						<cfset grouptotal=0>
					</cfif>
					<cfif thisproj neq "ZZZZZZZZZZ">
						<tr><td colspan="100%"><hr></td></tr>
						<tr>
							<td colspan="8"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#ucase(getgeneral.lPROJECT)# TOTAL:</strong></font></div></td>
							<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>#numberformat(projtotal,",.__")#</strong></font></div></td>
						</tr>
					</cfif>
					<cfset thisproj=getinfo.source>
					<cfset thisjob="ZZZZZZZZZZ">
					<cfset thisgroup="ZZZZZZZZZZ">
					<cfset projtotal=0>
					<cfset grouptotal=0>
					<tr>
						<td colspan="2"><font size="2" face="Times New Roman, Times, serif"><b>#ucase(getgeneral.lPROJECT)# : #getinfo.source#</b></font></td>
						<td colspan="7"><font size="2" face="Times New Roman, Times, serif"><b>#getinfo.project#</b></font></td>
					</tr>
					<cfif thisjob neq getinfo.job>
						<cfset thisjob=getinfo.job>
						<cfif getinfo.job neq "">
							<tr>
								<td colspan="2"><font size="2" face="Times New Roman, Times, serif"><b>#ucase(getgeneral.lJOB)# : #getinfo.job#</b></font></td>
								<td colspan="7"><font size="2" face="Times New Roman, Times, serif"><b>#getinfo.jobdesp#</b></font></td>
							</tr>
						</cfif>
					</cfif>
				</cfif>
				<cfif thisjob neq getinfo.job>
					<cfset thisjob=getinfo.job>
					<cfset thisproj="ZZZZZZZZZZ">
					<cfset thisgroup="ZZZZZZZZZZ">
					<cfset projtotal=0>
					<cfset grouptotal=0>
					<cfif getinfo.job neq "">
						<tr>
							<td colspan="2"><font size="2" face="Times New Roman, Times, serif"><b>#ucase(getgeneral.lJOB)# : #getinfo.job#</b></font></td>
							<td colspan="7"><font size="2" face="Times New Roman, Times, serif"><b>#getinfo.jobdesp#</b></font></td>
						</tr>
					</cfif>
				</cfif>
				<cfif thisgroup neq getinfo.wos_group>
					<cfset thisgroup=getinfo.wos_group>
					<tr>
						<td colspan="2"><font size="2" face="Times New Roman, Times, serif"><u>GROUP : #getinfo.wos_group#</u></font></td>
					</tr>
				</cfif>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.fperiod#</font></div></td>
                    <cfif lcase(hcomid) eq "mphcranes_i" or lcase(hcomid) eq "mphcs_i">
					<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.name#</font></div></td>
                    <cfelse>
                    <td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.custno#</font></div></td>
                    </cfif>
					<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.type#</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.refno#</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.itemno#</font></div></td>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getinfo.desp# #getinfo.despa#</font></div></td>
					<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.qty#</font></div></td>
					<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.unit#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(getinfo.price),stDecl_UPrice)#</font></div></td>
					<cfif form.usecostiniss neq "" and getinfo.type eq "ISS">
						<cfset thisamt=val(getinfo.qty)*val(getinfo.it_cos)>
					<cfelse>
						<cfset thisamt=val(getinfo.amt)>
					</cfif>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(val(thisamt),stDecl_UPrice)#</font></div></td>
				</tr>
				<cfset projtotal=projtotal+thisamt>
				<cfset grouptotal=grouptotal+thisamt>
			</cfoutput>
			<tr><td colspan="100%"><hr></td></tr>
			<tr>
				<td colspan="8"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>GROUP TOTAL:</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(grouptotal,",.__")#</cfoutput></strong></font></div></td>
			</tr>
			<tr><td colspan="100%"><hr></td></tr>
			<tr>
				<td colspan="8"><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#ucase(getgeneral.lPROJECT)#</cfoutput> TOTAL:</strong></font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong><cfoutput>#numberformat(projtotal,",.__")#</cfoutput></strong></font></div></td>
			</tr>
		</cfif>
	</cfif>
</table>
</body>
</html>
</cfcase>


<cfcase value="EXCELDEFAULT">
	
	<cfquery name="getgeneral" datasource="#dts#">
	select compro,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lPROJECT,lJOB from gsetup
</cfquery>

<cfparam name="form.marktype" default="rc,pr,inv,do,cs,cn,dn,iss,oai,oar,trin,trou">
<cfparam name="form.sortbycustno" default="">
<cfparam name="form.usecostiniss" default="">
<cfparam name="grouptotal" default="0">
<cfparam name="projtotal" default="0">
<cfparam name="custtotal" default="0">

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
		 	</Styles>
			
			<Worksheet ss:Name="Print Profit Margin Report">
				<cfoutput>
				<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
					<Column ss:Width="64.5"/>
					<Column ss:Width="60.25"/>
					<Column ss:Width="60.75"/>

					<Column ss:AutoFitWidth="0" ss:Width="183.75"/>
					<Column ss:Width="27.75"/>
					<Column ss:Width="47.25"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
					<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
					<cfset c="12">
						<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
						<cfset c=c+1>

		   
					<cfwddx action = "cfml2wddx" input = "#title#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
                    
				<cfif isdefined("form.projectfrom") and form.projectfrom neq "" and form.projectto neq "">
		<cfwddx action = "cfml2wddx" input = "#getgeneral.lPROJECT# From #form.projectfrom# To #form.projectto#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
	</cfif>	    
     <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
		<cfwddx action = "cfml2wddx" input = "Job From #form.jobfrom# To #form.jobto#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
	</cfif>
    
    <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
		<cfwddx action = "cfml2wddx" input = "Product From #form.productfrom# To #form.productto#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
	</cfif>
    
			<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
                <cfwddx action = "cfml2wddx" input = "#getgeneral.lCATEGORY# From #form.Catefrom# To #form.Cateto#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
                <cfwddx action = "cfml2wddx" input = "#getgeneral.lGROUP# From #form.groupfrom# To #form.groupto#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
			</cfif>
             <cfif periodfrom neq "" and periodto neq "">
      	 <cfwddx action = "cfml2wddx" input = "Period From #periodfrom# To #periodto#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
    </cfif>
            <cfif datefrom neq "" and dateto neq "">
<cfwddx action = "cfml2wddx" input = "Date From #datefrom# To #dateto#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
    </cfif>
					<cfwddx action = "cfml2wddx" input = "#getgeneral.compro#" output = "wddxText">
			
					<Row ss:AutoFitHeight="0" ss:Height="20.0625">
						<Cell ss:MergeAcross="#c-1#" ss:StyleID="s26"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s26"><Data ss:Type="String">#dateformat(now(),"dd-mm-yyyy")#</Data></Cell>
					</Row>
				</cfoutput>
                <cfif url.type eq "listprojitem">
    <cfif isdefined('form.seperatebilltype')>
   	<cfquery name="getinfo" datasource="#dts#">
    <cfloop list="#marktype#" delimiters="," index="i">
    select * from (
			select ic.type,ic.refno,ic.fperiod,ic.wos_date,ic.custno,ic.name,
			ic.itemno,ic.desp,ic.despa,ic.qty,ic.price,ic.unit,ic.it_cos,ic.amt,ic.wos_group,ic.category,
			ic.source,ic.job,proj.project,j.jobdesp
			from ictran ic
			
			left join (
				select source,project
				from project
				where porj='P'
				<cfif form.projectfrom neq "" and form.projectto neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
			)as proj on ic.source=proj.source
			
			left join (
				select source,project as jobdesp
				from project
				where porj='J'
			)as j on ic.job=j.source
			
			where (ic.void = '' or ic.void is null) and ic.type = "#i#"
            <cfif trim(form.periodfrom) neq "" and trim(form.periodto) neq "">
			and ic.fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
            </cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and ic.itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
			</cfif>
            <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
				and ic.job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
			</cfif>
			<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
				and ic.category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Catefrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cateto#">
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and ic.wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
			</cfif>
			<cfif form.projectfrom neq "" and form.projectto neq "">
				and ic.source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and ic.wos_date between #date1# and #date2# 
			</cfif>
			<cfif form.sortbycustno neq "">
				order by ic.source,ic.custno,ic.itemno
			<cfelse>
				order by ic.source,ic.job,ic.refno,ic.wos_group,ic.wos_date
			</cfif>) as #i#
            <cfif i neq listlast(marktype)>
            union all
            </cfif>
            </cfloop>
		</cfquery>
    <cfelse>
    <cfquery name="getinfo" datasource="#dts#">
			select ic.type,ic.refno,ic.fperiod,ic.wos_date,ic.custno,ic.name,
			ic.itemno,ic.desp,ic.despa,ic.qty,ic.price,ic.unit,ic.it_cos,ic.amt,ic.wos_group,ic.category,
			ic.source,ic.job,proj.project,j.jobdesp
			from ictran ic
			
			left join (
				select source,project
				from project
				where porj='P'
				<cfif form.projectfrom neq "" and form.projectto neq "">
					and source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
					and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
				</cfif>
			)as proj on ic.source=proj.source
			
			left join (
				select source,project as jobdesp
				from project
				where porj='J'
			)as j on ic.job=j.source
			
			where (ic.void = '' or ic.void is null) and ic.type in (#ListQualify(marktype,"'")#)
            <cfif trim(form.periodfrom) neq "" and trim(form.periodto) neq "">
			and ic.fperiod >= '#form.periodfrom#' and fperiod <= '#form.periodto#'
            </cfif>
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and ic.itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.productto#">
			</cfif>
            <cfif trim(form.jobfrom) neq "" and trim(form.jobto) neq "">
				and ic.job between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobto#">
			</cfif>
			<cfif trim(form.Catefrom) neq "" and trim(form.Cateto) neq "">
				and ic.category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Catefrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Cateto#">
			</cfif>
			<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
				and ic.wos_group between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.groupto#">
			</cfif>
			<cfif form.projectfrom neq "" and form.projectto neq "">
				and ic.source between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectfrom#">
				and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.projectto#">
			</cfif>
			<cfif form.datefrom neq "" and form.dateto neq "">
				and ic.wos_date between #date1# and #date2# 
			</cfif>
			<cfif form.sortbycustno neq "">
				order by ic.source,ic.custno,ic.itemno
			<cfelse>
				order by ic.source,ic.job,ic.refno,ic.wos_group,ic.wos_date
			</cfif>
		</cfquery>
	</cfif>
		
				<Row ss:AutoFitHeight="0" ss:Height="23.0625">
					<Cell ss:StyleID="s27"><Data ss:Type="String">PD</Data></Cell>
                     <cfif lcase(hcomid) eq "mphcranes_i" or lcase(hcomid) eq "mphcs_i">
				    <Cell ss:StyleID="s27"><Data ss:Type="String">CUST NAME</Data></Cell>
                    <cfelse>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">CUSTNO</Data></Cell>
                    </cfif>
					<Cell ss:StyleID="s27"><Data ss:Type="String">TYPE</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">REFNO</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">ITEM NO.</Data></Cell>
					<Cell ss:StyleID="s27"><Data ss:Type="String">ITEM DESPCRIPTION.</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">QTY</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">UNIT</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">U.PRICE</Data></Cell>
                    <Cell ss:StyleID="s27"><Data ss:Type="String">AMOUNT</Data></Cell>
				</Row>
				   <Row ss:AutoFitHeight="0" ss:Height="23.0625"></row>
                   <cfif form.sortbycustno neq "">
			<!--- INITIALIZE thisproj,thiscust --->
			<cfset thisproj="ZZZZZZZZZZ">
			<cfset thiscust="ZZZZZZZZZZ">
            <cfset thistype ="ZZZZZZZZZZ"> 
			<cfoutput query="getinfo">
            <cfif thistype neq getinfo.type and isdefined('form.seperatebilltype')>>
            <cfset thistype = getinfo.type>
            <cfset thisproj="ZZZZZZZZZZ">
			</cfif>
            
            <cfif thiscust neq "ZZZZZZZZZZ" and thiscust neq getinfo.custno and thisproj eq getinfo.source>
           <Row ss:AutoFitHeight="0" ss:Height="23.0625"></row>
           <Row ss:AutoFitHeight="0" ss:Height="23.0625">
           <cfwddx action = "cfml2wddx" input = "#numberformat(custtotal,",.__")#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
           </row>
					 <Row ss:AutoFitHeight="0" ss:Height="23.0625"></row>
					<cfset custtotal=0>
				</cfif>
				<cfif thisproj neq getinfo.source>
					<cfif thiscust neq "ZZZZZZZZZZ">
						 <Row ss:AutoFitHeight="0" ss:Height="23.0625"></row>
						<Row ss:AutoFitHeight="0" ss:Height="23.0625">
							<Row ss:AutoFitHeight="0" ss:Height="20.0625"></row>
                            <cfwddx action = "cfml2wddx" input = "#numberformat(custtotal,",.__")#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
							</row>
					</cfif>
                    <cfset custtotal=0>
                    <cfif thisproj neq "ZZZZZZZZZZ">
						<Row ss:AutoFitHeight="0" ss:Height="23.0625"></row>
						<Row ss:AutoFitHeight="0" ss:Height="23.0625">
                        <cfwddx action = "cfml2wddx" input = "#ucase(getgeneral.lPROJECT)#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String"> TOTAL: #wddxText#</Data></Cell>
					</Row>
                    <cfwddx action = "cfml2wddx" input = "#numberformat(projtotal,",.__")#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String"> TOTAL: #wddxText#</Data></Cell>
					</Row>
						</row>
                         <cfwddx action = "cfml2wddx" input = "#numberformat(projtotal,",.__")#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
					</cfif>
                    <cfset thisproj=getinfo.source>
					<cfset thiscust="ZZZZZZZZZZ">
					<cfset projtotal=0>
					<cfset custtotal=0>
                  <Row ss:AutoFitHeight="0" ss:Height="23.0625">
                  <cfwddx action = "cfml2wddx" input = "#ucase(getgeneral.lPROJECT)# : #getinfo.source#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
                    <cfwddx action = "cfml2wddx" input = "#getinfo.project#" output = "wddxText">
					<Row ss:AutoFitHeight="0" ss:Height="23.0625">
						<Cell ss:MergeAcross="#c#" ss:StyleID="s22"><Data ss:Type="String">#wddxText#</Data></Cell>
					</Row>
					</cfif>
                    <cfif thiscust neq getinfo.custno>
					<cfset thiscust=getinfo.custno>
				</cfif>
				<cfoutput>
					<cfwddx action = "cfml2wddx" input = "#getinfo.fperiod#" output = "wddxText">
                    <cfif lcase(hcomid) eq "mphcranes_i" or lcase(hcomid) eq "mphcs_i">
					<cfwddx action = "cfml2wddx" input = "#getinfo.name#" output = "wddxText2">
                    <cfelse>
                    <cfwddx action = "cfml2wddx" input = "#getinfo.custno#" output = "wddxText2">
                    </cfif>
					<cfwddx action = "cfml2wddx" input = "#getinfo.type#" output = "wddxText3">
                    <cfwddx action = "cfml2wddx" input = "#getinfo.refno#" output = "wddxText4">
                    <cfwddx action = "cfml2wddx" input = "#getinfo.itemno#" output = "wddxText5">
                    <cfwddx action = "cfml2wddx" input = "#getinfo.desp# #getinfo.despa#" output = "wddxText6">
                    <cfwddx action = "cfml2wddx" input = "#getinfo.qty#" output = "wddxText7">
                    <cfwddx action = "cfml2wddx" input = "#getinfo.unit#" output = "wddxText8">
                    <cfwddx action = "cfml2wddx" input = "#numberformat(val(getinfo.price),stDecl_UPrice)#" output = "wddxText9">

<cfwddx action = "cfml2wddx" input = "#numberformat(val(thisamt),stDecl_UPrice)#" output = "wddxText10">
					<Row ss:AutoFitHeight="0">
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
						<Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText3#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText4#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText5#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText6#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText7#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText8#</Data></Cell>
                        <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText9#</Data></Cell>
						<cfif form.usecostiniss neq "" and getinfo.type eq "ISS">
						<cfset thisamt=val(getinfo.qty)*val(getinfo.it_cos)>
					<cfelse>
						<cfset thisamt=val(getinfo.amt)>
					</cfif>
                    <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText10#</Data></Cell>
                    </row>
                    <cfset projtotal=projtotal+thisamt>
				<cfset custtotal=custtotal+thisamt>
			</cfoutput>
            <Row ss:AutoFitHeight="0" ss:Height="23.0625"><Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell></row>
            <Row ss:AutoFitHeight="0" ss:Height="23.0625">
             <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
             <cfwddx action = "cfml2wddx" input = "#numberformat(custtotal,",.__")#" output = "wddxText">
             <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
            </row>
             <Row ss:AutoFitHeight="0" ss:Height="23.0625"><Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell></row>
              <Row ss:AutoFitHeight="0" ss:Height="23.0625">
             <Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell>
             <cfwddx action = "cfml2wddx" input = "#ucase(getgeneral.lPROJECT)#" output = "wddxText">
             <Cell ss:StyleID="s32"><Data ss:Type="String">TOTAL:#wddxText#</Data></Cell>
             <cfwddx action = "cfml2wddx" input = "#numberformat(projtotal,",.__")#" output = "wddxText2">
             <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
            </row>
            <cfelse>
            <cfset thisproj="ZZZZZZZZZZ">
			<cfset thisjob="ZZZZZZZZZZ">
			<cfset thisgroup="ZZZZZZZZZZ">
            <cfset thistype = "ZZZZZZZZZZ">
			<cfoutput query="getinfo">
            <cfif thistype neq getinfo.type and isdefined('form.seperatebilltype')>
            <cfset thistype = getinfo.type>
            <cfset thisproj="ZZZZZZZZZZ">
			</cfif>
            <cfif thisgroup neq "ZZZZZZZZZZ" and thisgroup neq getinfo.wos_group and thisproj eq getinfo.source>
            <Row ss:AutoFitHeight="0" ss:Height="23.0625"><Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell></row>
             <Row ss:AutoFitHeight="0" ss:Height="23.0625">
             <Cell ss:StyleID="s32"><Data ss:Type="String">GROUP TOTAL:</Data></Cell>
              <cfwddx action = "cfml2wddx" input = "#numberformat(grouptotal,",.__")#" output = "wddxText">
             <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText#</Data></Cell>
             </row>
             <cfset grouptotal=0>
             </cfif>
             <cfif thisproj neq getinfo.source or thisjob neq getinfo.job>
             <cfif thisgroup neq "ZZZZZZZZZZ">
              <Row ss:AutoFitHeight="0" ss:Height="23.0625"><Cell ss:StyleID="s32"><Data ss:Type="String"></Data></Cell></row>
			 <Row ss:AutoFitHeight="0" ss:Height="23.0625">
             <cfwddx action = "cfml2wddx" input = "#ucase(getgeneral.lPROJECT)#" output = "wddxText">
             <Cell ss:StyleID="s32"><Data ss:Type="String">TOTAL:#wddxText#</Data></Cell>
             <cfwddx action = "cfml2wddx" input = "#numberformat(projtotal,",.__")#" output = "wddxText2">
             <Cell ss:StyleID="s32"><Data ss:Type="String">#wddxText2#</Data></Cell>
             </row>
             </cfif>
                 <!---       
	
					
					</Row>
				</cfoutput>
				<Row ss:AutoFitHeight="0" ss:Height="12"/>
				
				<cfoutput>
				<Row ss:AutoFitHeight="0" ss:Height="12">
					<Cell ss:StyleID="s38"><Data ss:Type="String">GROUP TOTAL:</Data></Cell>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#subqty#</Data></Cell>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#subsales#</Data></Cell>
                    <Cell ss:StyleID="s39"><Data ss:Type="Number">#subcost#</Data></Cell>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#subprofit#</Data></Cell>
                    <cfif subsales neq 0 and subprofit neq 0>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">#(subprofit / subsales)* 100#</Data></Cell>
					<cfelse>
					<Cell ss:StyleID="s39"><Data ss:Type="Number">0</Data></Cell>
                    </cfif>
					<Cell ss:StyleID="s38"/>
					
				</Row>
				</cfoutput>
		
				<Row ss:AutoFitHeight="0" ss:Height="12"/>
				
				<cfoutput>
				<Row ss:AutoFitHeight="0" ss:Height="12">
					<Cell ss:StyleID="s38"><Data ss:Type="String">Grand Total</Data></Cell>
					<Cell ss:Index="5" ss:StyleID="s39"><Data ss:Type="Number"></Data></Cell>
					<Cell ss:StyleID="s39"><Data ss:Type="Number"></Data></Cell>
                    <Cell ss:StyleID="s39"><Data ss:Type="Number"></Data></Cell>
					<Cell ss:StyleID="s39"><Data ss:Type="Number"></Data></Cell>
					<Cell ss:StyleID="s39"><Data ss:Type="Number"></Data></Cell>
					
					<Cell ss:StyleID="s39"><Data ss:Type="Number"></Data></Cell>
					<Cell ss:StyleID="s38"/>
					
				</Row>
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

		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls" output="#tostring(data)#" charset="utf-8">
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_BL_#huserid#.xls">
	</cfcase>
</cfswitch>