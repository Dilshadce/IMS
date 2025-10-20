<cfparam name="alcreate" default="0">
<cfparam name="aledit" default="0">
<cfparam name="aldelete" default="0">
<cfparam name="alown" default="0">

<cfif tran eq "ISS">
	<cfset tran = "ISS">
	<cfset tranname = "Issue">
	<cfset trancode = "issno">
	
	<cfif getpin2.h2821 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
  	
	<cfif getpin2.h2822 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>
  	
	<cfif getpin2.h2823 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>
 	
	<cfif getpin2.h2824 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
<cfelseif tran eq "TR">
	<cfset tran = "TR">
	<cfset tranname = "Transfer">
	<cfset trancode = "trno">
	
	<cfif getpin2.h28A1 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
  	
	<cfif getpin2.h28A2 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>
  	
	<cfif getpin2.h28A3 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>
 	
	<cfif getpin2.h28A4 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
<cfelseif tran eq "OAI">
	<cfset tran = "OAI">
	<cfset tranname = "Adjustment Increase">
	<cfset trancode = "oaino">
	
	<cfif getpin2.h2831 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
  	
	<cfif getpin2.h2832 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>
  	
	<cfif getpin2.h2833 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>
 	
	<cfif getpin2.h2834 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
<cfelseif tran eq "OAR">
	<cfset tran = "OAR">
	<cfset tranname = "Adjustment Reduce">
	<cfset trancode = "oarno">
	
	<cfif getpin2.h2841 eq 'T'>
  		<cfset alcreate = 1>
  	</cfif>
  	
	<cfif getpin2.h2842 eq 'T'>
  		<cfset aledit = 1>
  	</cfif>
  	
	<cfif getpin2.h2843 eq 'T'>
  		<cfset aldelete = 1>
 	</cfif>
 	
	<cfif getpin2.h2844 eq 'T'>
  		<cfset alown = 1>
 	</cfif>
</cfif>

<html>
<head>
<title><cfoutput>#tranname# </cfoutput>Main Page</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery datasource="#dts#" name="getGeneralInfo">
	Select #trancode# as result from GSetup
</cfquery>

<cfquery datasource='#dts#' name="gettransaction">
	Select * from artran where type = "#tran#" <cfif alown eq 1>and (userid = '#huserid#' or agenno = '#huserid#')</cfif> and fperiod <> '99' order by wos_date desc,refno desc
</cfquery>

<body>
<!---1. Match output at line 38 --->
<cfoutput>
<cfif husergrpid eq "Muser">
	<a href="../home2.cfm"><u>Home</u></a>
</cfif>

<h1>#tranname# Main Menu</h1>
<h4>
	<cfif alcreate eq 1>
		<a href="iss2.cfm?ttype=create&tran=#tran#">Create New #tranname#</a> ||
	</cfif> 
	<a href="iss.cfm?tran=#tran#">List all #tranname#</a> || 
	<a href="siss.cfm?tran=#tran#">Search For #tranname#</a>
</h4><hr>

<!---1. Match output at line 28 --->
</cfoutput>
<table align="center" class="data">
  	<tr> 
    	<td colspan="7"><div align="center"><font color="#336699" size="3" face="Arial, Helvetica, sans-serif"><strong>Newest 20 <cfoutput>#tranname#</cfoutput></strong></font></div></td>
	</tr>
  	<tr> 
    	<th><cfoutput>#tranname#</cfoutput> No</th>
		<th>Agent</th>
    	<th>Date</th>
    	<th>Period</th>
    	<th>Authorised By</th>
    	<th>User</th>
    	<th>Action</th>
  	</tr>
	
	<cfoutput query="gettransaction" startrow="1" maxrows="20"> 
    <tr> 
      	<td>#gettransaction.refno#</td>
	  	<td>#gettransaction.agenno#</td>
      	<td>#dateformat(gettransaction.wos_date,"dd-mm-yyyy")#</td>
      	<td>#gettransaction.fperiod#</td>
      	<td nowrap>#gettransaction.custno#</td>
      	<td>#gettransaction.userid#</td>
      	<td align="right" nowrap>
			<cfif lcase(hcomid) eq "migif_i" and tran eq "TR">
				<a href="../../billformat/#dts#/consignmentnote.cfm?tran=#tran#&nexttranno=#refno#" target="_blank">Print</a>&nbsp;
			<cfelse>
				<a href="issformat.cfm?tran=#tran#&nexttranno=#refno#" target="_blank">Print</a>&nbsp;
			</cfif>
			
			<cfif aledit eq 1>
				<a href="iss2.cfm?tran=#tran#&ttype=Edit&refno=#refno#&custno=#URLEncodedFormat(gettransaction.custno)#">
				<img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
			</cfif> 
        	<cfif aldelete eq 1>
				<a href="iss2.cfm?tran=#tran#&ttype=Delete&refno=#refno#&custno=#URLEncodedFormat(gettransaction.custno)#">
				<img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>
			</cfif>
		</td>
    </tr>
  	</cfoutput> 
</table>

<cfoutput>
<p><strong><br>Last Used #tran# No :</strong><font color="##FF0000"><strong>#getGeneralInfo.result#</strong></font></p>
</cfoutput>
</body>
</html>