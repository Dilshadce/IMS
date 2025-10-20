
<html>
<head>
<title>View <cfoutput>assignmentslip</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
			
<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevFive" default="0">
<cfparam name="nextFive" default="0">
<cfoutput>
<h1>View assignmentslip Informations</h1>
</cfoutput>
<cfoutput>
	<h4>
		<a href="/default/transaction/assignmentslipnewnew/Assignmentsliptable2.cfm?type=Create">Creating a Assignment Slip</a> 
		|| <a href="/default/transaction/assignmentslipnewnew/Assignmentsliptable.cfm?">List all Assignment Slip</a> 
		|| <a href="/default/transaction/assignmentslipnewnew/s_Assignmentsliptable.cfm?type=Assignmentslip">Search For Assignment Slip</a> 
		|| <a href="/default/transaction/assignmentslipnewnew/assignbatches/batchassignment.cfm">Assign Batch Control</a>
        || <a href="/default/transaction/assignmentslipnewnew/assignbatches/s_batchtable.cfm">List Batch Control</a>
       <!---  || <a href="/default/transaction/assignmentslipnewnew/printcheque.cfm">Print Claim Cheque</a>
        || <a href="/default/transaction/assignmentslipnewnew/printclaim.cfm">Print Claim Voucher</a>
        || <a href="/default/transaction/assignmentslipnewnew/generatecheqno.cfm">Record Claim Cheque No</a>
         || <a href="/default/transaction/assignmentslipnewnew/definecheqno.cfm">Predefined Cheque No</a> --->
	</h4>
</cfoutput>

<cfquery name="getrecordcountassign" datasource="#dts#">
	select count(refno) as totalrecord 
	from assignmentslip 
	order by right(refno,7) desc
</cfquery>

<cfif getrecordcountassign.totalrecord neq 0>
	<cfif isdefined("form.skeypage")>
		<cfset noOfPage=round(getrecordcountassign.totalrecord/20)>
		<cfif getrecordcountassign.totalrecord mod 20 LT 10 and getrecordcountassign.totalrecord mod 20 neq 0>
			<cfset noOfPage=noOfPage+1>
		</cfif>
		<cfif form.skeypage gt noofpage OR form.skeypage lt 1>
			<h3 align="center"><font color="#FF0000">Wrong page number! Please try again.</font></h3>
			<cfabort>
		</cfif>
	</cfif>
	<cfform action="/default/transaction/assignmentslipnewnew/assignmentsliptable.cfm" method="post">
	<div align="right">Page <input name="skeypage" id="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
	

	<cfset noOfPage=round(getrecordcountassign.totalrecord/20)>
	
	<cfif getrecordcountassign.totalrecord mod 20 LT 10 and getrecordcountassign.totalrecord mod 20 neq 0>
		<cfset noOfPage=noOfPage+1>
	</cfif>
	
	<cfif isdefined("url.start")>
		<cfset start=url.start>
	</cfif>
	<cfif isdefined("form.skeypage")>				
		<cfset start = form.skeypage * 20 + 1 - 20>				
		<cfif form.skeypage eq "1">
			<cfset start = "1">					
		</cfif>  				
	</cfif> 

	<cfset prevFive=start -20>
	<cfset nextFive=start +20>
	<cfset page=round(nextFive/20)>
    
    <cfquery datasource='#dts#' name="type">
	Select * from assignmentslip order by created_on desc
    limit #start-1#,20
</cfquery>

			
	<cfif start neq 1>
		<cfoutput>|| <a href="/default/transaction/assignmentslipnewnew/assignmentsliptable.cfm?start=#prevFive#">Previous</a> ||</cfoutput>
	</cfif>
	
	<cfif page neq noOfPage>
		<cfoutput> <a href="/default/transaction/assignmentslipnewnew/assignmentsliptable.cfm?start=#evaluate(nextFive)#">Next</a> ||</cfoutput>
	</cfif>
	
	<cfoutput>Page #page# Of #noOfPage#</cfoutput>
</div>

<hr>

<cfif isdefined("url.process")>
	<cfoutput><h1>#form.status#</h1><hr></cfoutput>
</cfif>


	<cfoutput>
	<cfset strNo = "type.refno">
	<!--- QCH <cfset strNo = "start">  --->
				
      <cfif #type.recordCount# neq 0>
		
  <table align="center" class="data" width="800px">
    <tr> 
      <th>Ref No</th>
        <th>Invoice Date</th>
        <th>Placement No</th>
        <th>Customer no</th>
        <th>Employee no</th>
        <th>Employee Name</th>
        <th>Status</th>
		<th>Batch ID</th>
        <th>User ID</th>
     <th width="70">Action</th>
    </tr>
    <cfloop query="type"> 
      <tr> 
        <td>#type.refno#</a></td>
          <td>#dateformat(type.assignmentslipdate,'DD/MM/YYYY')#</td>
          <td>#type.placementno#</td>
          <td>#type.custno#</td>
          <td>#type.empno#</td>
          <td>#type.empname#</td>
          <td>#type.posted# <cfif type.locked eq "Y">#type.locked#</cfif> <cfif type.combine eq "Y">C</cfif></td>
		  <td>#type.batches#</td>
          <td>#type.created_by#</td>
        <td width="10%" nowrap> 
          <div align="center"><a href="/default/transaction/assignmentslipnewnew/assignmentsliptable2.cfm?type=Delete&refno=#type.refno#" ><img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0" >Delete</a>&nbsp; 
            <a href="/default/transaction/assignmentslipnewnew/assignmentsliptable2.cfm?type=Edit&refno=#type.refno#" ><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0" >Edit</a></div></td>
      </tr>
    </cfloop> 
  </table>
		<cfelse>
			<h3>No Records were found.</h3>
		</cfif>
							
				<br>
				<hr>
				
				</cfoutput>
				</cfform>
				<div align="right">
			
				<cfif start neq 1>
					<cfoutput>|| <a href="/default/transaction/assignmentslipnewnew/assignmentsliptable.cfm?start=#prevFive#">Previous</a> ||</cfoutput>
				</cfif>
				
			    <cfif page neq noOfPage>
					<cfoutput> <a href="/default/transaction/assignmentslipnewnew/assignmentsliptable.cfm?start=#evaluate(nextFive)#">Next</a> ||</cfoutput>
				</cfif>
				
				<cfoutput>Page #page# Of #noOfPage#</cfoutput>
				</div>
			
				<hr>
				<cfelse>
					<h3>Sorry, No records were found.</h3>
				</cfif>			
</body>
</html>
