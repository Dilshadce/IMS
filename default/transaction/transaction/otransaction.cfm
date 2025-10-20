<html>
<head>
<title>Credit Note Main Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>

<h1 align="center">Other Transactions</h1>

<cfquery name="gettranname" datasource="#dts#">
select lconsignin,lconsignout,lISS,lOAI,lOAR from gsetup
</cfquery> 
<cfquery datasource="#dts#" name="getGeneralInfo">
				Select *
				from GSetup
			</cfquery>
<table width="75%" border="0" align="center" class="data">
	<tr> 
    	<td height="30" colspan="4"><div align="center">OTHER TRANSACTIONS</div></td>
  	</tr>  
  	<tr> 
    	<cfif getpin2.h2810 eq 'T'>
			
			<td>
				<cfif getGeneralInfo.assm_oneset neq '1'>
					<a href="assm0.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Item Assembly</a>
				<cfelse>
					<a href="assm1.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Item Assembly</a>
				</cfif>
			</td>
		</cfif>
    	<cfif getpin2.h2820 eq 'T'>
			<td>
				<a href="siss.cfm?tran=ISS" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#gettranname.lISS#</cfoutput></a>
			</td>
		</cfif>
    	<cfif getpin2.h2830 eq 'T'>
			<td>
				<a href="siss.cfm?tran=OAI" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#gettranname.lOAI#</cfoutput></a>
			</td>
		</cfif>
    	<cfif getpin2.h2840 eq 'T'>
			<td>
				<a href="siss.cfm?tran=OAR" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#gettranname.lOAR#</cfoutput></a>
			</td>
		</cfif>
	</tr>
  	<tr> 
		<cfif lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i">	<!--- Modified on 29-12-2009 --->
		    <cfif getpin2.h2200 eq 'T'>
				<td width="25%">
					<a href="transaction.cfm?tran=pr" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Purchase Return</a>
				</td>
			</cfif>
			<cfif getpin2.h2600 eq 'T'>
				<td width="25%">
					<a href="transaction.cfm?tran=cn" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Credit Note</a>
				</td>
			</cfif>
			<cfif getpin2.h2700 eq 'T'>
				<td width="25%">
					<a href="transaction.cfm?tran=dn" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Debit Note</a>
				</td>
			</cfif>
		</cfif>
    	
        <td>
			<cfif getpin2.h28B0 eq 'T'>
				<a href="../transaction/historicalrecords/historicalmenu.cfm" target="mainFrame">
					<img name="Cash Sales" src="../../images/reportlogo.gif">Historical Records
				</a>
			</cfif>
		</td>
         
        <td>
			<cfif getpin2.h2830 eq 'T'>
				<a href="../transaction/expressadjustmenttran/index.cfm" target="mainFrame">
					<img name="Cash Sales" src="../../images/reportlogo.gif">Express Adjustment
				</a>
			</cfif>
		</td>
        <td>
			<cfif getpin2.h2810 eq 'T'>
				<a href="/default/transaction/dissemble/" target="mainFrame">
					<img name="Cash Sales" src="../../images/reportlogo.gif">Assemble / Dissemble
				</a>
			</cfif>
		</td>
        <td>
        <cfif getpin2.h28G0 eq "T">
			
				<a href="/default/transaction/transaction.cfm?tran=rq" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
					<cfoutput>#getGeneralInfo.lRQ#</cfoutput>
				</a>
			
		</cfif>
        </td>
        
  	</tr>

  	<tr> 
    	<td colspan="4" height="16"></td>
  	</tr>
	<tr> 
    	<td height="30" colspan="4"><div align="center">NON-ACCOUNTING TRANSACTION</div></td>
  	</tr>
    <cfquery name="getGeneralInfo" datasource="#dts#">
	select * 
	from gsetup;
	</cfquery>
	<cfif lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i">	<!--- Modified on 29-12-2009 --->
		<tr> 
	    	<cfif getpin2.h2850 eq 'T'>
				<td width="25%">
					<a href="transaction.cfm?tran=sam" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#getGeneralInfo.lSAM#</cfoutput></a>
				</td>
			</cfif>
			<cfif getpin2.h28C0 eq 'T'>
				<td width="25%">
					<a href="writeoff.cfm?tran=po" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Write Off Purchase Order</a>
				</td>
			</cfif>
			<cfif getpin2.h28D0 eq 'T'>
				<td width="25%">
					<a href="writeoff.cfm?tran=so" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Write Off Sales Order</a>
				</td>
			</cfif>
			<cfif getpin2.h28B0 eq 'T'>
				<td><a href="../transaction/HistoricalRecords/historicalrecordsmenu.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Historical Records</a></td>
			</cfif>
		</tr>
	<cfelse>
		<tr> 
	    	<cfif getpin2.h2860 eq 'T'>
				<td width="25%">
					<a href="transaction.cfm?tran=po" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#getGeneralInfo.lPO#</cfoutput></a>
				</td>
			</cfif>
	    	<cfif getpin2.h2870 eq 'T'>
				<td width="25%">
					<a href="transaction.cfm?tran=quo"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#getGeneralInfo.lQUO#</cfoutput></a>
				</td>
			</cfif>
	    	<cfif getpin2.h2880 eq 'T'>
				<td width="25%">
					<a href="transaction.cfm?tran=so" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#getGeneralInfo.lSO#</cfoutput></a>
				</td>
			</cfif>	  
	    	<cfif getpin2.h2850 eq 'T'>
				<td width="25%">
					<a href="transaction.cfm?tran=sam" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#getGeneralInfo.lSAM#</cfoutput></a>
				</td>
			</cfif>
           
		</tr>
		<tr>
        	
			<cfif getpin2.h28C0 eq 'T'>
				<td width="25%">
					<a href="writeoff.cfm?tran=po" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Write Off <cfoutput>#getGeneralInfo.lPO#</cfoutput></a>
				</td>
			</cfif>
			<cfif getpin2.h28D0 eq 'T'>
				<td width="25%">
					<a href="writeoff.cfm?tran=so" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Write Off <cfoutput>#getGeneralInfo.lSO#</cfoutput></a>
				</td>
			</cfif>
			<cfif getpin2.h28B0 eq 'T'>
				<td><a href="../transaction/HistoricalRecords/historicalrecordsmenu.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Historical Records</a></td>
			</cfif>
            <cfif lcase(hcomid) eq "hunting_i">
            <cfif getpin2.h2850 eq 'T'>
				<td width="25%">
					<a href="transaction.cfm?tran=samm" target="mainFrame"><img name="Sales Order" src="../../images/reportlogo.gif">Sales Order</a>
				</td>
			</cfif>
			</cfif>
		</tr>
	</cfif>
  	<tr> 
    	<td colspan="4" height="16"></td>
  	</tr>
	<tr> 
    	<td height="30" colspan="4"><div align="center">GENERATE/UPDATE TRANSACTION</div></td>
  	</tr>
  	<tr>
		<cfif getpin2.h2890 eq 'T'>
			<td><a href="copy.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Copy  Bill</a></td>
		</cfif>
		<cfif getpin2.h28A0 eq 'T'>
			<td><a href="siss.cfm?tran=TR" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Transfer</a></td>
		</cfif>
        <cfif getpin2.h28E0 eq 'T'>
			<td><a href="siss.cfm?tran=TR&consignment=out" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#gettranname.lconsignout#</cfoutput></a></td>
		</cfif>
        <cfif getpin2.h28F0 eq 'T'>
			<td><a href="siss.cfm?tran=TR&consignment=return" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif"><cfoutput>#gettranname.lconsignin#</cfoutput></a></td>
		</cfif>
		
    	<td><cfif (lcase(HcomID) eq "glenn_i" or lcase(HcomID) eq "glenndemo_i") and variables.HUserGrpID eq "super"><a href="../../report/glenn/fchangeItemno.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">Change Item No</a></cfif></td>
    	<td></td>
	</tr>
</table>

</body>
</html>