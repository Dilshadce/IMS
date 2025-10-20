<html>
<head>
<title>Importing Batch Of Transactionss</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfoutput>
<h3 align="center">
	<a href="postingacc.cfm?status=Unposted<cfif isdefined('url.ubs')>&ubs=yes</cfif>">Unposted Transaction</a>&nbsp;
    <cfif getpin2.h5610 eq 'T'>
    || <a href="postingacc.cfm?status=Posted<cfif isdefined('url.ubs')>&ubs=yes</cfif>">Posted Transaction</a> 
    </cfif>
    <cfif getpin2.h5620 eq 'T'>
    || <a href="postingcheck.cfm<cfif isdefined('url.ubs')>?ubs=yes</cfif>">Posting Check</a> 
    </cfif>
    || 
	<cfif Hlinkams neq "Y" or isdefined('url.ubs')>
		<a href="..\..\..\download\#dts#\ver9.0\glpost9.csv" target="_blank">Download Exported File Accounting Ver 9.0</a> || 
		<a href="..\..\..\download\#dts#\ver9.1\glpost9.csv" target="_blank">Download Exported File Accounting Ver 9.1</a> ||
	</cfif>
    <cfif getpin2.h5630 eq 'T'>
	<a href="glpost.cfm<cfif isdefined('url.ubs')>?ubs=yes</cfif>">List Not Exported</a> </cfif>
    <cfif getpin2.h5640 eq 'T'>|| 
	<a href="unpost.cfm<cfif isdefined('url.ubs')>?ubs=yes</cfif>">Unpost Bill</a>
    </cfif>
    <cfif getpin2.h5650 eq 'T'>
	<cfif Hlinkams eq "Y"  and isdefined('url.ubs') eq false>
		|| <a href="import_to_ams.cfm"><i>Import To AMS</i></a>
	</cfif>
    </cfif>
</h3>
</cfoutput>
<cfquery name="getglpostdata" datasource="#dts#">
	select * from (select
	entry,
	date,
	acc_code,
	reference,
	accno,
	(ifnull(debitamt,0)) as debitamt,
	(ifnull(creditamt,0)) as creditamt,
	job,
	rem4,
	fperiod
	from glpost91<cfif isdefined('url.ubs')>ubs</cfif>
	) as a left join
(select b.sumcd,c.erroraccno,b.reference as referenceno from (SELECT sum(creditamt)- sum(debitamt) as sumcd,reference from glpost91<cfif isdefined('url.ubs')>ubs</cfif> group by reference ) as b left join (select reference,"Y" as erroraccno from glpost91<cfif isdefined('url.ubs')>ubs</cfif> where accno = "0000/000" or accno = "" ) as c on b.reference = c.reference) as d on a.reference = d.referenceno order by fperiod,reference,entry
</cfquery>

<cfquery name="getposttotal" datasource="#dts#">
	select sum(debitamt) as debittotal,sum(creditamt) as credittotal
	from glpost91<cfif isdefined('url.ubs')>ubs</cfif>
</cfquery>

<cfif getglpostdata.recordcount eq 0>
	<h2 align="center">No Posted Bill(s) Found !!</h2>
	<cfabort>
</cfif>

<cfset totaldebit = 0>
<cfset totalcredit = 0>

<cfquery name="geterrorexist" dbtype="query">
SELECT * from getglpostdata where sumcd <> 0 and erroraccno IS NOT null
</cfquery>

<cfif geterrorexist.recordcount neq 0>
<h3>Attention!!! Error Existed! Please kindly check!</h3>

</cfif>

<cfif getpin2.h5650 eq 'T'>
	<cfif Hlinkams eq "Y"  and isdefined('url.ubs') eq false>
      <div style="color:#FF0000; font-size:24px;" align="center"><input type="button" style="font-size:24;" name="button" value="Import To Accounting" onClick="location.href='import_to_ams.cfm'"></div>
	</cfif>
    </cfif>

<table>
<tr>
<td bgcolor="##0000FF" >&nbsp;&nbsp;&nbsp;</td>     <td>Debit Amount is not tally with Credit Amount</td>
</tr>
<tr>
<td bgcolor="##FFFF00"  >&nbsp;&nbsp;&nbsp;</td><td>Account No have Error</td>
</tr>
<tr>
<td bgcolor="##FF0000"  >&nbsp;&nbsp;&nbsp;</td><td>Debit Amount is not tally with Credit Amount AND Account No Error</td>
</tr>
</table>
<table class="data" align="center" width="100%">
	<tr>
		<th>Date</th>
		<th>Type</th>
		<th>Ref.No</th>
		<th>A/C No</th>
		<th>Debit</th>
		<th>Credit</th>
		<th>Job</th>
		<th>Note</th>
		<th>Rec</th>
		<th>Pd.</th>
	</tr>
	<cfoutput query="getglpostdata">
		<tr  
		<cfif getglpostdata.sumcd neq "0" and getglpostdata.erroraccno eq "">
        style="background:##0000FF" 
		<cfelseif getglpostdata.sumcd eq "0" and getglpostdata.erroraccno neq "">
        style="background:##FFFF00"
        <cfelseif getglpostdata.sumcd neq "0" and getglpostdata.erroraccno neq "">
        style="background:##FF0000"
		</cfif>
        >
			<td><div align="center"><font size="2" face="Times New Roman,Times,serif"><cftry>#dateformat(getglpostdata.date,"dd-mm-yyyy")#<cfcatch type="any">#getglpostdata.date#</cfcatch></cftry></font></div></td>
			<td><div align="center"><font size="2" face="Times New Roman,Times,serif">#getglpostdata.acc_code#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getglpostdata.reference#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getglpostdata.accno#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(getglpostdata.debitamt,",.__")#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#numberformat(getglpostdata.creditamt,",.__")#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getglpostdata.job#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getglpostdata.rem4#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#getglpostdata.entry#</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman,Times,serif">#getglpostdata.fperiod#</font></div></td>
		</tr>
	</cfoutput>
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td><div align="right"><font size="2" color="FF0000" face="Times New Roman,Times,serif"><strong>Total:</strong></font></div></td>
		<cfoutput>
			<td bgcolor="3366CC"><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>#numberformat(getposttotal.debittotal,",.__")#</strong></font></div></td>
			<td bgcolor="3366CC"><div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>#numberformat(getposttotal.credittotal,",.__")#</strong></font></div></td>
		</cfoutput>
		<td></td>
		<td></td>
		<td></td>
	</tr>
</table>
</body>
</html>