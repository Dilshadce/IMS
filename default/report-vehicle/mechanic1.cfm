<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear,agentlistuserid,lagent from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	Select * from gsetup2
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


	<html>
	<head>
	<title>Cust/Supp/Agent/Area Item Report</title>
	<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
	</head>

	<body>

	<cfquery name="getagent" datasource="#dts#">
		select agenno from artran
        where type='SO'
        and (void='' or void is null)
		<cfif trim(form.agentfrom) neq "" and trim(form.agentto) neq "">
		and agenno between '#form.agentfrom#' and '#form.agentto#'
		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
		and wos_date between '#ndatefrom#' and '#ndateto#'
		<cfelse>
		</cfif>
        and agenno != ''
		group by agenno 
        order by agenno;
	</cfquery>
	
	<cfoutput>


	<table width="100%" border="0" cellspacing="0" cellpadding="2">
		<tr>
			<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>#getgeneral.lagent# Performance Report</strong></font></div></td>
		</tr>
        
        <tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Date Printed : #dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
        <cfif form.agentfrom neq '' and form.agentto neq ''>
        <tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Agent : #form.agentfrom# To #form.agentto#</font></div></td>
		</tr>
        </cfif>
		
		<tr>
			<td colspan="100%"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		</tr>
		
        		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<tr>

        
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>No.</strong></font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>Job Sheet No.</strong></font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>Description</strong></font></div></td>
            <td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Start Time</strong></font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif"><strong>Finish Time</strong></font></div></td>
            		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<cfloop query="getagent">
        <tr>
			<td colspan="100%"><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong><u>#getgeneral.lagent# : #getagent.agenno#</u></strong></font></div></td>
			</tr>
			<cfquery name="getdate" datasource="#dts#">
			select wos_date from artran
        	where type='SO'
        	and (void='' or void is null)
			and agenno ='#getagent.agenno#'
			<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date between '#ndatefrom#' and '#ndateto#'
			<cfelse>
			</cfif>
			group by wos_date 
        	order by wos_date;
			</cfquery>

			<cfloop query="getdate">
            <cfset runingno=1>
			<tr>
			<td colspan="100%"><div align="left"><font size="2" face="Times New Roman, Times, serif"><strong>Date : #dateformat(getdate.wos_date,'DD/MM/YYYY')#</strong></font></div></td>
			</tr>
            
            <cfquery name="getbill" datasource="#dts#">
			select * from artran
        	where type='SO'
        	and (void='' or void is null)
			and agenno ='#getagent.agenno#'
			and wos_date =#getdate.wos_date#
        	order by refno;
			</cfquery>
            <cfloop query="getbill">

            
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#runingno#.</font></div></td>
					<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getbill.refno#</font></div></td>
                    <td><div align="left"><font size="2" face="Times New Roman, Times, serif">#getbill.desp#</font></div></td>
                    <td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getbill.rem6#</font></div></td>
					<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getbill.rem7#</font></div></td>
				
				 </tr>
            <cfset runingno=runingno+1>
			</cfloop>
	
			<cfflush>
		</cfloop>
        <tr><td colspan="100%"><hr></td></tr>
        <cfflush>
	</cfloop>
	  </table>
	</cfoutput>



	<br>
	<br>
	<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
	<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
	</body>
	</html>

