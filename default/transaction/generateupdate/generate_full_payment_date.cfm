<html>
<head>
<title>Generate Full Payment Date</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../../../stylesheet/reportprint.css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select compro from gsetup;
</cfquery>

<body>

<h2 align="center"><font face="Times New Roman, Times, serif">Generate Full Payment Date</font></h2>

<cfif Hlinkams eq "Y">
	<cfquery name="get_full_payment_date" datasource="#replacenocase(dts,'_i','_a','all')#">
		select 
		date_format(a.date,'%d-%m-%Y') as date,
		(case a.araptype when 'I' then 'INV' when 'H' then 'CS' when 'C' then 'CN' when 'D' then 'DN' end) as araptype,
		a.reference,
		a.accno,
		(select name from arcust where custno=a.accno) as cust_name,
		format(((if(a.araptype in ('I','H','D'),(ifnull(a.debitamt,0)),(ifnull(a.creditamt,0)*-1)))),2) as amt,
		(format((ifnull(a.paidamt,0)),2)) as paidamt 
		from arpost as a 
		where a.accext <> 'F' and araptype in ('I','H','C','D') 
		order by a.date;
	</cfquery>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="2">
		<tr>
			<cfoutput>
				<td colspan="6"><div align="left"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></div></td>
				<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
			</cfoutput>
		</tr>
		<tr>
			<td colspan="8"><hr></td>
		</tr>
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">NO.</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DATE</font></div></td>
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">TYPE</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">REF.NO.</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">CUST.NO.</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">NAME</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMOUNT</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">PAID AMT</font></div></td>
		</tr>
		<tr>
			<td colspan="8"><hr></td>
		</tr>
		
		<cfoutput query="get_full_payment_date">
			<tr>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#get_full_payment_date.currentrow#.</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#get_full_payment_date.date#</font></div></td>
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#get_full_payment_date.araptype#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#get_full_payment_date.reference#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#get_full_payment_date.accno#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#get_full_payment_date.cust_name#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#get_full_payment_date.amt#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#get_full_payment_date.paidamt#</font></div></td>
			</tr>
		</cfoutput>
	</table>
<cfelse>
	<h2 align="center">You Have No AMS Provided ! Please Contact Admistrator !</h2>
	<cfabort>
</cfif>

<br><br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>