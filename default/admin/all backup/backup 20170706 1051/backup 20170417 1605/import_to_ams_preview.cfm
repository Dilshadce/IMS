<html>
<head>
<title>Importing Batch Of Transactionss</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfquery name="getglpostdata" datasource="#dts#">
	select 
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
	from glpost91 
	order by fperiod,reference,entry;
</cfquery>

<cfquery name="getposttotal" datasource="#dts#">
	select sum(debitamt) as debittotal,sum(creditamt) as credittotal
	from glpost91
</cfquery>

<cfif getglpostdata.recordcount eq 0>
	<h2 align="center">No Posted Bill(s) Found !!</h2>
	<cfabort>
</cfif>

<cfset totaldebit = 0>
<cfset totalcredit = 0>

<table class="data" align="center">
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
		<tr>
			<td><div align="center"><font size="2" face="Times New Roman,Times,serif">#getglpostdata.date#</font></div></td>
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