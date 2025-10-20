<html>
<head>
<title>Sales Transactions Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>

<h1 align="center">Sales Transactions</h1>

<cfquery name="gettranname" datasource="#dts#">
select lconsignin,lconsignout,lISS,lOAI,lOAR from gsetup
</cfquery> 

<table width="75%" border="0" align="center" class="data">
	<tr> 
    	<td height="30" colspan="4"><div align="center">SALES TRANSACTION</div></td>
  	</tr>
    <cfquery name="getGeneralInfo" datasource="#dts#">
	select * 
	from gsetup;
	</cfquery>
		<tr> 
        	<cfif getpin2.h2870 eq 'T'>
				<td width="25%">
					<a href="/default/transaction/transaction.cfm?tran=quo"><img name="Cash Sales" src="/images/reportlogo.gif"><cfoutput>#getGeneralInfo.lQUO#</cfoutput></a>
				</td>
			</cfif>
            <cfif getpin2.h2880 eq 'T'>
				<td width="25%">
					<a href="/default/transaction/transaction.cfm?tran=so" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif"><cfoutput>#getGeneralInfo.lSO#</cfoutput></a>
				</td>
			</cfif>	 
            <cfif getpin2.h2300 eq "T">
			<td width="25%">
					<a href="/default/transaction/transaction.cfm?tran=DO" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif"><cfoutput>#getGeneralInfo.lDO#</cfoutput></a>
			</td>
		</cfif>
            <cfif getpin2.h2400 eq "T">
			<td width="25%">
					<a href="/default/transaction/transaction.cfm?tran=INV" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif"><cfoutput>#getGeneralInfo.lINV#</cfoutput></a>
				</td>
			</cfif>
          </tr>
          <tr>
            <cfif getpin2.h2500 eq "T">
			<td width="25%">
					<a href="/default/transaction/transaction.cfm?tran=CS" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif"><cfoutput>#getGeneralInfo.lCS#</cfoutput></a>
			</td>
			</cfif>
	    	<cfif getpin2.h2700 eq "T">
			<td width="25%">
					<a href="/default/transaction/transaction.cfm?tran=DN" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif"><cfoutput>#getGeneralInfo.lDN#</cfoutput></a>
			</td>
			</cfif>
        	<cfif getpin2.h2600 eq "T">
			<td width="25%">
					<a href="/default/transaction/transaction.cfm?tran=CN" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif"><cfoutput>#getGeneralInfo.lCN#</cfoutput></a>
			</td>
			</cfif>	

</table>

</body>
</html>