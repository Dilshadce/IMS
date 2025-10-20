<html>
<head>
	<title>View Audit Trail</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
	<style type="text/css" media="print">
		.noprint { display: none; }
	</style>
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>

<cfswitch expression="#form.result#">
	<cfcase value="modified">
		<cfquery name="getinfo" datasource="#dts#">
			select * from artranat
			where 0=0 <cfif isdefined('form.include99')><cfelse>and fperiod <> '99'</cfif>
			and remark <> 'Deleted'
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 >= '#form.periodfrom#' and fperiod+0 <= '#form.periodto#'
			</cfif>
			<cfif form.billType neq "">
				and type = '#form.billType#'
			</cfif>
			<cfif form.sortby neq "">
				order by #form.sortby#
			</cfif>
		</cfquery>
	</cfcase>
	
	<cfcase value="deleted">
		<cfquery name="getinfo" datasource="#dts#">
			select * from artranat
			where 0=0 <cfif isdefined('form.include99')><cfelse>and fperiod <> '99'</cfif>
			and remark in ('Deleted','Voided')
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 >= '#form.periodfrom#' and fperiod+0 <= '#form.periodto#'
			</cfif>
			<cfif form.billType neq "">
				and type = '#form.billType#'
			</cfif>
			<cfif form.sortby neq "">
				order by #form.sortby#
			</cfif>
		</cfquery>
	</cfcase>
	
	<cfdefaultcase>
		<cfquery name="getinfo" datasource="#dts#">
			select artran.*,'' as remark from artran
			where 0=0 <cfif isdefined('form.include99')><cfelse>and fperiod <> '99'</cfif>
			and type not in ('SAM','PO','SO','QUO')
			<cfif form.periodfrom neq "" and form.periodto neq "">
				and fperiod+0 >= '#form.periodfrom#' and fperiod+0 <= '#form.periodto#'
			</cfif>
			<cfif form.billType neq "">
				and type = '#form.billType#'
			</cfif>
			<cfif form.sortby neq "">
				order by #form.sortby#
			</cfif>
		</cfquery>
	</cfdefaultcase>
</cfswitch>

<cfif form.result eq "modified">
<cfset edittime=1>
<cfset refno1=''>
<cfset type1=''>
</cfif>
<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<cfoutput>
		<tr>
			<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>VIEW AUDIT TRAIL</strong></font></div></td>
		</tr>
		<cfif form.periodfrom neq "" and form.periodto neq "">
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.periodfrom# - #form.periodto#</font></div></td>
			</tr>
		</cfif>
		<tr>
			<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<tr>
			<td width="3%"><font size="2" face="Times New Roman, Times, serif">PD.</font></td>
			<td width="5%"><font size="2" face="Times New Roman, Times, serif">TYPE</font></td>
			<td width="12%"><font size="2" face="Times New Roman, Times, serif">REFNO</font></td>
			<td width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE</font></div></td>
			<td width="10%"><font size="2" face="Times New Roman, Times, serif">CUST NO.</font></td>
			<td width="15%"><div align="center"><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></div></td>
			<td width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">USERID</font></div></td>
			<td width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">AMOUNT</font></div></td>
			<td width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">LAST UPDATE</font></div></td>
			<td width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">TIME</font></div></td>
            <td width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">CREATED BY</font></div></td>
            <td width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">CREATED ON</font></div></td>
			<td width="5%"><div align="center"><font size="2" face="Times New Roman, Times, serif">STATUS</font></div></td>
           <td></td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<cfloop query="getinfo">
        <!---
		<cfif form.result eq "modified">
        <cfif refno1 eq getinfo.refno and type1 eq getinfo.type>
        <cfset edittime=edittime+1>
        <cfelse>
        <cfset edittime=1>
        <cfquery name="getoriginal" datasource="#dts#">
			select * from artran where refno='#getinfo.refno#' and type='#getinfo.type#'
		</cfquery>
        
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><font size="2" face="Times New Roman, Times, serif">#getoriginal.fperiod#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getoriginal.type#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getoriginal.refno#</font></td>
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#dateformat(getoriginal.wos_date,"dd/mm/yyyy")#</font></div></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getoriginal.custno#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getoriginal.desp#</font></td>
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getoriginal.created_by#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">
					<cfif val(getoriginal.creditamt) neq 0>
						- #numberformat(val(getoriginal.creditamt),stDecl_UPrice)#
					<cfelse>
						#numberformat(val(getoriginal.debitamt),stDecl_UPrice)#
					</cfif>
				</font></div></td>
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#dateformat(getoriginal.created_on,"dd/mm/yyyy")#</font></div></td>
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#TimeFormat(getoriginal.created_on, "hh:mm:ss tt")#</font></div></td>
                <td></td>
                <td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getoriginal.created_by#</font></div></td>
                <td><div align="center"><font size="2" face="Times New Roman, Times, serif">#dateformat(getoriginal.created_on,"dd/mm/yyyy")# #TimeFormat(getoriginal.created_on,"hh:mm:ss tt")#</font></div></td>
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif">Original</font></div></td>
			</tr>
        </cfif>
        </cfif>--->
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><font size="2" face="Times New Roman, Times, serif">#getinfo.fperiod#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getinfo.type#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getinfo.refno#</font></td>
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#dateformat(getinfo.wos_date,"dd/mm/yyyy")#</font></div></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getinfo.custno#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getinfo.desp#</font></td>
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.updated_by#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">
					<cfif val(getinfo.creditamt) neq 0>
						- #numberformat(val(getinfo.creditamt),stDecl_UPrice)#
					<cfelse>
						#numberformat(val(getinfo.debitamt),stDecl_UPrice)#
					</cfif>
				</font></div></td>
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#dateformat(getinfo.updated_on,"dd/mm/yyyy")#</font></div></td>
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#TimeFormat(getinfo.updated_on, "hh:mm:ss tt")#</font></div></td>
                <td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.created_by#</font></div></td>
                <td><div align="center"><font size="2" face="Times New Roman, Times, serif">#dateformat(getinfo.created_on,"dd/mm/yyyy")# #TimeFormat(getinfo.created_on,"hh:mm:ss tt")#</font></div></td>
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfif getinfo.remark eq "Voided">Void</cfif></font></div></td>
                <cfif form.result eq "modified"><td><div align="center"><font size="2" face="Times New Roman, Times, serif">Edit #edittime#</font></div></td></cfif>
			</tr>
            <cfif form.result eq "modified">
            <cfset refno1=getinfo.refno>
			<cfset type1=getinfo.type>
			
			</cfif>
            
		</cfloop>
	</cfoutput>
	</table>
</body>
</html>