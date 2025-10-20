
<html>
<head>
<title>View <cfoutput>assignmentslip</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfquery datasource='#dts#' name="getPersonnel">
	Select * from assignmentslip order by created_on desc
</cfquery>
			
<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevFive" default="0">
<cfparam name="nextFive" default="0">
<cfoutput>
<h1>View assignmentslip Informations</h1>
</cfoutput>
<cfoutput>
	<h4>
		<a href="Assignmentsliptable2.cfm?type=Create">Creating a Assignment Slip</a> 
		|| <a href="Assignmentsliptable.cfm?">List all Assignment Slip</a> 
		|| <a href="s_Assignmentsliptable.cfm?type=Assignmentslip">Search For Assignment Slip</a>
        || <a href="printcheque.cfm">Print Claim Cheque</a>
        || <a href="printclaim.cfm">Print Claim Voucher</a>
        || <a href="generatecheqno.cfm">Record Claim Cheque No</a>
         || <a href="definecheqno.cfm">Predefined Cheque No</a>
	</h4>
</cfoutput>

<cfif getPersonnel.recordcount neq 0>
	<cfif isdefined("form.skeypage")>
		<cfset noOfPage=round(getPersonnel.recordcount/5)>
		<cfif getPersonnel.recordcount mod 5 LT 3 and getPersonnel.recordcount mod 5 neq 0>
			<cfset noOfPage=noOfPage+1>
		</cfif>
		<cfif form.skeypage gt noofpage OR form.skeypage lt 1>
			<h3 align="center"><font color="#FF0000">Wrong page number! Please try again.</font></h3>
			<cfabort>
		</cfif>
	</cfif>
	<cfform action="assignmentsliptable.cfm" method="post">
	<div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
	

	<cfset noOfPage=round(getPersonnel.recordcount/5)>
	
	<cfif getPersonnel.recordcount mod 5 LT 3 and getPersonnel.recordcount mod 5 neq 0>
		<cfset noOfPage=noOfPage+1>
	</cfif>
	
	<cfif isdefined("url.start")>
		<cfset start=url.start>
	</cfif>
	<cfif isdefined("form.skeypage")>				
		<cfset start = form.skeypage * 5 + 1 - 5>				
		<cfif form.skeypage eq "1">
			<cfset start = "1">					
		</cfif>  				
	</cfif> 

	<cfset prevFive=start -5>
	<cfset nextFive=start +5>
	<cfset page=round(nextFive/5)>

			
	<cfif start neq 1>
		<cfoutput>|| <a href="assignmentsliptable.cfm?start=#prevFive#">Previous</a> ||</cfoutput>
	</cfif>
	
	<cfif page neq noOfPage>
		<cfoutput> <a href="assignmentsliptable.cfm?start=#evaluate(nextFive)#">Next</a> ||</cfoutput>
	</cfif>
	
	<cfoutput>Page #page# Of #noOfPage#</cfoutput>
</div>

<hr>

<cfif isdefined("url.process")>
	<cfoutput><h1>#form.status#</h1><hr></cfoutput>
</cfif>


	<cfoutput query="getPersonnel" startrow="#start#" maxrows="5">
	<cfset strNo = "getPersonnel.refno">
	<!--- QCH <cfset strNo = "start">  --->
				
      <table align="center" class="data" width="550px">
        <!--- <tr> 
          <th width="20%">No</th>
          <td>#evaluate(strNo)#</td>
        </tr> --->
        <tr> 
          <th width="20%">assignmentslip</th>
          <td>#getPersonnel.refno#</td>
        </tr>
        <tr> 
          <th>Invoice Date</th>
          <td>#dateformat(getPersonnel.assignmentslipdate,'DD/MM/YYYY')#</td>
        </tr>
        <tr> 
          <th>Placement No</th>
          <td>#getPersonnel.placementno#</td>
        </tr>
        
        <tr> 
          <th>Customer No</th>
          <td>#getPersonnel.custno#</td>
        </tr>
        <tr> 
          <th>Employee No</th>
          <td>#getPersonnel.empno#</td>
        </tr>
		<!---<cfif getpin2.h1H11 eq 'T'>---->
        <tr> 
          <td colspan="2"><div align="right"><a href="assignmentsliptable2.cfm?type=Delete&refno=#evaluate(strNo)#"><img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0"> 
              Delete</a> <a href="assignmentsliptable2.cfm?type=Edit&refno=#evaluate(strNo)#"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a></div></td>
        </tr><!---</cfif>---->
      </table>
							
				<br>
				<hr>
				
				</cfoutput>
				</cfform>
				<div align="right">
			
				<cfif start neq 1>
					<cfoutput>|| <a href="assignmentsliptable.cfm?start=#prevFive#">Previous</a> ||</cfoutput>
				</cfif>
				
			    <cfif page neq noOfPage>
					<cfoutput> <a href="assignmentsliptable.cfm?start=#evaluate(nextFive)#">Next</a> ||</cfoutput>
				</cfif>
				
				<cfoutput>Page #page# Of #noOfPage#</cfoutput>
				</div>
			
				<hr>
				<cfelse>
					<h3>Sorry, No records were found.</h3>
				</cfif>			
</body>
</html>
