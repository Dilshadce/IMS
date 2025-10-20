<html>
<head>
<title>Purchase Transactions Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>

<h1 align="center">Purchase Transactions</h1>

<cfquery name="gettranname" datasource="#dts#">
select lconsignin,lconsignout,lISS,lOAI,lOAR from gsetup
</cfquery> 

<table width="75%" border="0" align="center" class="data">
	<tr> 
    	<td height="30" colspan="4"><div align="center">PURCHASE TRANSACTION</div></td>
  	</tr>
    <cfquery name="getGeneralInfo" datasource="#dts#">
	select * 
	from gsetup;
	</cfquery>
		<tr> 
        	<cfif getpin2.h2860 eq 'T'>
				<td width="25%">
					<a href="/default/transaction/transaction.cfm?tran=po" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif"><cfoutput>#getGeneralInfo.lPO#</cfoutput></a>
				</td>
			</cfif>
            <cfif getpin2.h2100 eq "T">
			<td width="25%">
					<a href="/default/transaction/transaction.cfm?tran=RC" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif"><cfoutput>#getGeneralInfo.lRC#</cfoutput></a>
				</td>
		</cfif>
        	<cfif getpin2.h2200 eq "T">
			<td width="25%">
					<a href="/default/transaction/transaction.cfm?tran=PR" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif"><cfoutput>#getGeneralInfo.lPR#</cfoutput></a>
				</td>
		</cfif>

</table>

</body>
</html>