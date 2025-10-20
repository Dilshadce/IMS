<html>
<head>
<title>Generate Customer Outstanding Balance</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../../../stylesheet/reportprint.css">
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select compro from gsetup;
</cfquery>

<body>

<h2 align="center"><font face="Times New Roman, Times, serif">Generate Customer Outstanding Balance</font></h2>

	<cfquery name="get_customer_outstanding_balance" datasource="#dts#">
		select custno,name
		from #target_arcust# 
		order by custno;
	</cfquery>
	
	<table width="100%" border="0" cellspacing="0" cellpadding="2">
		<tr>
			<cfoutput>
				<td colspan="2"><div align="left"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></div></td>
				<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
			</cfoutput>
		</tr>
		<tr>
			<td colspan="4"><hr></td>
		</tr>
		<tr>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">NO.</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">CUST.NO.</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">NAME</font></div></td>
			<td><div align="right"><font size="2" face="Times New Roman, Times, serif">OUTSTANDING</font></div></td>
		</tr>
		<tr>
			<td colspan="4"><hr></td>
		</tr>
		
		<cfoutput query="get_customer_outstanding_balance">
        
        <cfquery name="get_dealer_menu_info" datasource="#dts#">
				select 
				(
					select 
					selling_above_credit_limit 
					from dealer_menu 
				) as selling_above_credit_limit, 
				(
					select 
					crlimit 
					from #target_arcust#
					where custno='#jsstringformat(preservesinglequotes(get_customer_outstanding_balance.custno))#' 
				) as credit_limit,
				(
					ifnull(
						(
							select 
							ifnull(sum(grand_bil),0)
							from artran 
							where custno='#jsstringformat(preservesinglequotes(get_customer_outstanding_balance.custno))#'
							and type in ('INV','DN','CS')
							and posted='' 
							group by custno 
						)
					,0)
                    -
                    ifnull(
						(
							select 
							ifnull(sum(grand_bil),0)
							from artran 
							where custno='#jsstringformat(preservesinglequotes(get_customer_outstanding_balance.custno))#'
							and type='CN'
							and posted='' 
							group by custno 
						)
					,0)
					+<!--- - --->
                    <cfif Hlinkams eq 'Y'>
					ifnull(
						(
							select 
							ifnull((sum(debitamt)- sum(creditamt)),0)
							from #replacenocase(dts,"_i","_a","all")#.glpost 
							where accno='#jsstringformat(preservesinglequotes(get_customer_outstanding_balance.custno))#'  and fperiod <> '99'
							group by accno
						) 
					,0) 
                    
                    +
                    ifnull(
						(
							select 
							ifnull(lastybal,0)
							from #replacenocase(dts,"_i","_a","all")#.gldata 
							where accno='#jsstringformat(preservesinglequotes(get_customer_outstanding_balance.custno))#' 
							group by accno
						) 
					,0) 
                    <cfelse>
                    0
                    </cfif>
				) as credit_balance;
			</cfquery>
        
        
			<tr>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#get_customer_outstanding_balance.currentrow#.</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#get_customer_outstanding_balance.custno#</font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#get_customer_outstanding_balance.name#</font></div></td>
				<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#get_dealer_menu_info.credit_balance#</font></div></td>
			</tr>
		</cfoutput>
	</table>


<br><br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>

</body>
</html>