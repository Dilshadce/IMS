<html>
<head>
	<title>View Audit Trail For Customer/Supplier/Product</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
	<style type="text/css" media="print">
		.noprint { display: none; }
	</style>
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>
<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>
<cfswitch expression="#form.result#">
	<cfcase value="deleted_apvend">
		<cfquery name="getinfo" datasource="#dts#">
			select custno as code,concat(name,' ',name2) as desp,deleted_by,deleted_on from #form.result#
			where custno=custno
			<cfif form.datefrom neq "" and form.dateto neq "">
				and deleted_on >= #date1# and deleted_on <= #date2#
			</cfif>
			<cfif IsDefined('form.supplier') AND form.supplier NEQ ''>
				and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.supplier#">
			</cfif>
			order by custno,deleted_on
		</cfquery>
		<cfset title="SUPPLIER">
		<cfset label1="SUPPLIER NO.">
		<cfset label2="NAME">
	</cfcase>
	
	<cfcase value="deleted_icitem">
		<cfquery name="getinfo" datasource="#dts#">
			select itemno as code,concat(desp,' ',despa) as desp,deleted_by,deleted_on from #form.result#
			where itemno=itemno
			<cfif form.datefrom neq "" and form.dateto neq "">
				and deleted_on >= #date1# and deleted_on <= #date2#
			</cfif>
			<cfif IsDefined('form.item') AND form.item NEQ ''>
				and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.item#">
			</cfif>
			order by itemno,deleted_on
		</cfquery>
		<cfset title="PRODUCT">
		<cfset label1="ITEM NO.">
		<cfset label2="DESCRIPTION">
	</cfcase>
    
    <cfcase value="edited_arcust">
		<cfquery name="getinfo" datasource="#dts#">
			select custno as code,concat(name,' ',name2) as desp,deleted_by,deleted_on,crlimit,dispec1 from #form.result#
			where custno=custno
			<cfif form.datefrom neq "" and form.dateto neq "">
				and deleted_on >= #date1# and deleted_on <= #date2#
			</cfif>
			<cfif IsDefined('form.customer') AND form.customer NEQ ''>
				and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customer#">
			</cfif>
			order by custno,deleted_on
		</cfquery>
		<cfset title="CUSTOMER">
		<cfset label1="CUSTOMER NO.">
		<cfset label2="NAME">
	</cfcase>
	
	<cfdefaultcase>
		<cfquery name="getinfo" datasource="#dts#">
			select custno as code,concat(name,' ',name2) as desp,deleted_by,deleted_on from #form.result#
			where custno=custno
			<cfif form.datefrom neq "" and form.dateto neq "">
				and deleted_on >= #date1# and deleted_on <= #date2#
			</cfif>
			<cfif IsDefined('form.customer') AND form.customer NEQ ''>
				and custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customer#">
			</cfif>
			order by custno,deleted_on
		</cfquery>
		<cfset title="CUSTOMER">
		<cfset label1="CUSTOMER NO.">
		<cfset label2="NAME">
	</cfdefaultcase>
</cfswitch>


<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<cfoutput>
		<tr>
			<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>VIEW AUDIT TRAIL FOR <cfoutput>#title#</cfoutput></strong></font></div></td>
		</tr>
		<tr>
			<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
			<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		<tr>
			<td colspan="10"><hr></td>
		</tr>
		<tr>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">NO.</font></div></td>
			<td><font size="2" face="Times New Roman, Times, serif"><cfoutput>#label1#</cfoutput></font></td>
			<td><font size="2" face="Times New Roman, Times, serif"><cfoutput>#label2#</cfoutput></font></td>
            <cfif form.result eq 'edited_arcust'>
            <td><div align="center"><font size="2" face="Times New Roman, Times, serif">Credit Limit</font></div></td>
            <td><div align="center"><font size="2" face="Times New Roman, Times, serif">Discount</font></div></td>
            </cfif>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">USERID</font></div></td>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif"><cfif form.result eq 'edited_icitem'>EDITED ON<cfelse>DELETED ON</cfif></font></div></td>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">TIME</font></div></td>
            
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<cfloop query="getinfo">
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.currentrow#.</font></div></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getinfo.code#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getinfo.desp#</font></td>
                <cfif form.result eq 'edited_arcust'>
                <td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.crlimit#</font></div></td>
                <td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.dispec1#</font></div></td>
                </cfif>
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#getinfo.deleted_by#</font></div></td>
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#dateformat(getinfo.deleted_on,"dd/mm/yyyy")#</font></div></td>
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#TimeFormat(getinfo.deleted_on, "hh:mm:ss tt")#</font></div></td>
			</tr>
		</cfloop>
	</cfoutput>
	</table>
</body>
</html>