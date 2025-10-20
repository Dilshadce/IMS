
<html>
<head>
<title>Create Or Edit Or View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

	<!--- <cfset typeNo=#url.type# & "No"> 
	<cfset link = #url.type# &".cfm"> --->
	
	<!--- <cfif isdefined("URL.Type")> --->
		
<h1><cfoutput>Assignment Slip Selection Page</cfoutput></h1>
		
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
		
		<cfoutput>
		<form action="s_assignmentsliptable.cfm" method="post"></cfoutput>
			<cfoutput>
			<h1>Search By :
			
			<select name="searchType">
				<option value="refno">Ref no</option>
                <option value="assignmentslipdate">Invoice Date</option>
				<option value="placementno">Type</option>
                <option value="custno">Customer No</option>
                <option value="empno">Employee No</option>
			</select>
      Search for Assignment Slip : 
      <input type="text" name="searchStr" value=""> </h1>
			</cfoutput>
		</form>
		
		<cfif isdefined("url.process")>
				<cfoutput><h1>#form.status#</h1><hr></cfoutput>
		</cfif>
	
		<cfquery datasource='#dts#' name="type">
			Select * from assignmentslip order by created_on desc
		</cfquery>
		
		<cfif isdefined("form.searchStr")>
			<cfquery datasource='#dts#' name="exactResult">
				Select * from assignmentslip where #form.searchType# = '#form.searchStr#' order by #form.searchType#
			</cfquery>
			
			<cfquery datasource='#dts#' name="similarResult">
				Select * from assignmentslip where #form.searchType# LIKE '%#form.searchStr#%' order by #form.searchType#
			</cfquery>
			
			<h2>Exact Result</h2>
			<cfif #exactResult.recordCount# neq 0>
			
    <table align="center" class="data" width="600px">
      <tr> 
        <th><cfoutput>Ref No</cfoutput></th>
        <th>Invoice Date</th>
        <th>Placement No</th>
        <th>Customer no</th>
        <th>Employee no</th>
        <!---<cfif getpin2.h1H11 eq 'T'>---><th>Action</th><!---</cfif>--->
      </tr>
      <cfoutput query="exactResult"> 
        <tr> 
          <td>#exactResult.refno#</a></td>
          <td>#dateformat(exactResult.assignmentslipdate,'DD/MM/YYYY')#</td>
          <td>#exactResult.placementno#</td>
          <td>#exactResult.custno#</td>
          <td>#exactResult.empno#</td>
          <!---<cfif getpin2.h1H11 eq 'T'>---><td width="10%" nowrap> 
            <div align="center"><a href="assignmentsliptable2.cfm?type=Delete&refno=#exactResult.refno#"><img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
              <a href="assignmentsliptable2.cfm?type=Edit&refno=#exactResult.refno#"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a></div></td><!---</cfif>---->
        </tr>
      </cfoutput> 
    </table>
			<cfelse>
				<h3>No Exact Records were found.</h3>
			</cfif>
			
			<h2>Similar Result</h2>
			<cfif #similarResult.recordCount# neq 0>
			
    <table align="center" class="data" width="600px">
      <tr> 
        <th><cfoutput>Ref No</cfoutput></th>
        <th>Invoice Date</th>
        <th>Placement No</th>
        <th>Customer no</th>
        <th>Employee no</th>
        <cfif getpin2.h1H11 eq 'T'><th>Action</th></cfif>
      </tr>
      <cfoutput query="similarResult"> 
        <tr> 
          <td>#similarResult.refno#</a></td>
          <td>#dateformat(similarResult.assignmentslipdate,'DD/MM/YYYY')#</td>
          <td>#similarResult.placementno#</td>
          <td>#similarResult.custno#</td>
          <td>#similarResult.empno#</td>
          <td width="10%" nowrap> 
            <div align="center"><a href="assignmentsliptable2.cfm?type=Delete&refno=#similarResult.refno#"><img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
              <a href="assignmentsliptable2.cfm?type=Edit&refno=#similarResult.refno#"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a></div></td>
        </tr>
      </cfoutput> 
    </table>
			<cfelse>
				<h3>No Similar Records were found.</h3>
			</cfif>
		</cfif>
		
		<cfparam name="i" default="1" type="numeric">
		<hr>
		
		<fieldset>
		<legend style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;
		font-style: italic;line-height: normal;font-weight: bold;text-transform: capitalize;color: #0066FF;"> 
		<cfoutput>20 Newest assignmentslip :</cfoutput></legend>
		<br>
		<cfif #type.recordCount# neq 0>
		
  <table align="center" class="data" width="600px">
    <tr> 
      <th width="40">No</th>
      <th><cfoutput>Ref No</cfoutput></th>
        <th>Invoice Date</th>
        <th>Placement No</th>
        <th>Customer no</th>
        <th>Employee no</th>
     <th width="70">Action</th>
    </tr>
    <cfoutput query="type" maxrows="20"> 
      <tr> 
        <td>#i#</td>
        <td>#type.refno#</a></td>
          <td>#dateformat(type.assignmentslipdate,'DD/MM/YYYY')#</td>
          <td>#type.placementno#</td>
          <td>#type.custno#</td>
          <td>#type.empno#</td>
        <td width="10%" nowrap> 
          <div align="center"><a href="assignmentsliptable2.cfm?type=Delete&refno=#type.refno#"><img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
            <a href="assignmentsliptable2.cfm?type=Edit&refno=#type.refno#"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a></div></td>
      </tr>
      <cfset i = incrementvalue(#i#)>
    </cfoutput> 
  </table>
		<cfelse>
			<h3>No Records were found.</h3>
		</cfif>
		<br>
		</fieldset>
	<!--- <cfelse>
		<h1>URL Error. Please Click On The Correct Link.</h1>
	</cfif> --->	

</body>
</html>
