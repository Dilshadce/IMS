<html>
<head>
	<title>Search Invoice</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<!--- <cfquery datasource="#dts#" name="getGeneralInfo">
	Select invno from GSetup
</cfquery> --->
<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevTwenty" default="0">
<cfparam name="nextTwenty" default="0">

<cfquery datasource='#dts#' name="getjob">
	Select * from artran where type = "INV" order by refno desc
</cfquery>

<body>

  <h1>Search Invoice</h1>

  <h4><a href="invoice1.cfm?ttype=create">Create New Invoice</a>
    || <a href="invoice.cfm">List all Invoice</a> ||
    <a href="sinvoice.cfm">Search For Invoice</a></h4>


<form action="sinvoice.cfm" method="post">

	<h1>Search By :
	<select name="searchType">
		<option value="refno">Invoice No</option>
		<option value="custno">Customer No</option>
		<!--- <option value="wos_date">Invoice Date</option> --->
	</select>
	Search for <input type="text" name="searchStr" value=""> </h1>
</form>

<cfif isdefined("form.searchStr")>
		<cfquery dbtype="query" name="exactResult">
			Select * from getjob where #form.searchType# = '#form.searchStr#' order by #form.searchType#
		</cfquery>

		<cfquery dbtype="query" name="similarResult">
			Select * from getjob where #form.searchType# LIKE '#form.searchStr#' order by #form.searchType#
		</cfquery>

		<h2>Exact Result</h2>
			<cfif #exactResult.recordCount# neq 0>
				<table align="center" class="data">

			  <tr>
 			  <th>Invoice No</th>
 			  <th>Date</th>
  			  <th>Period</th>
  			  <th>Customer Name</th>
  			  <th>User</th>
  			  <th>Action</th>
 			 </tr>
  			<cfoutput query="exactresult">
  			<cfquery name="getcust" datasource="#dts#">
				select name from #target_arcust# where custno = '#custno#'
			</cfquery>
   			 <tr>
   			   <td>#exactresult.refno#</td>
   			   <td>#dateformat(exactresult.wos_date,"dd-mm-yyyy")#</td>
   			   <td>#exactresult.fperiod#</td>
    			  <td nowrap>#exactresult.custno# - #getcust.name#</td>
    			  <td>#exactresult.userid#</td>
   			   <td align="right"><a href="invoice1.cfm?ttype=Edit&refno=#refno#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
				   <a href="invoice1.cfm?ttype=Delete&refno=#refno#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">
   			     Delete</a>
				</td>
  			  </tr>
 			 </cfoutput>
			</table>
			<cfelse>
				<h3>No Exact Records were found.</h3>
			</cfif>

			<h2>Similar Result</h2>
			<cfif #similarResult.recordCount# neq 0>
			 <table align="center" class="data">
			  <tr>
 			  <th>Invoice No</th>
 			  <th>Date</th>
  			  <th>Period</th>
  			  <th>Customer Name</th>
  			  <th>User</th>
  			  <th>Action</th>
 			 </tr>
  			<cfoutput query="similarResult">
  			<cfquery name="getcust" datasource="#dts#">
				select name from #target_arcust# where custno = '#custno#'
			</cfquery>
   			 <tr>
			<td>#similarResult.refno#</td>
			<td>#dateformat(similarResult.wos_date,"dd-mm-yyyy")#</td>
			<td>#similarResult.fperiod#</td>
			<td nowrap>#similarResult.custno# - #getcust.name#</td>
			<td>#similarResult.userid#</td>
			<td align="right"><a href="invoice1.cfm?ttype=Edit&refno=#refno#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
			<a href="invoice1.cfm?ttype=Delete&refno=#refno#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">
			Delete</a>
			</td>
  			  </tr>
 			 </cfoutput>
			</table>
			<cfelse>
				<h3>No Similar Records were found.</h3>
			</cfif>
</cfif>
<cfif getjob.recordcount neq 0>

		<cfif isdefined("form.skeypage")>
  					<cfset noOfPage=round(#getJob.recordcount#/20)>
					<cfif #getJob.recordcount# mod 20 LT 10 and #getJob.recordcount# mod 20 neq 0>
						<cfset noOfPage=#noOfPage#+1>
					</cfif>
					<cfif form.skeypage gt noofpage OR form.skeypage lt 1>
						<h3 align="center"><font color="#FF0000">Wrong page number! Please try again.</font></h3>
						<cfabort>
					</cfif>
 		</cfif>

			<cfform action="sinvoice.cfm" method="post">
				<div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">


			<cfset noOfPage=round(#getJob.recordcount#/20)>

			<cfif #getJob.recordcount# mod 20 LT 10 and #getJob.recordcount# mod 20 neq 0>
				<cfset noOfPage=#noOfPage#+1>
			</cfif>

			<cfif isdefined("url.start")>
				<cfset start=#url.start#>
			</cfif>

			<cfif isdefined("form.skeypage")>
				<cfset start = #form.skeypage# * 20 + 1 - 20>
				<cfif form.skeypage eq "1">
					<cfset start = "1">
				</cfif>
			</cfif>

				<cfset prevTwenty=#start# -20>
				<cfset nextTwenty=#start# +20>
				<cfset page=round(#nextTwenty#/20)>

				<cfif #start# neq 1>
					<cfoutput>|| <a href="sinvoice.cfm?start=#prevTwenty#">Previous</a> ||</cfoutput>
				</cfif>

			    <cfif #page# neq #noOfPage#>
					<cfoutput> <a href="sinvoice.cfm?start=#evaluate(nextTwenty)#">Next</a> ||</cfoutput>
				</cfif>

				<cfoutput>Page #page# Of #noOfPage#</cfoutput>
			</div>

			<hr>
<table align="center" class="data">
  <tr>
    <td colspan="6"><div align="center"><font color="#336699" size="3" face="Arial, Helvetica, sans-serif"><strong>
        Invoices</strong></font></div></td>
  </tr>
  <tr>
    <th>Invoice No</th>
    <th>Date</th>
    <th>Period</th>
    <th>Customer Name</th>
    <th>User</th>
    <th>Action</th>
  </tr>


  <cfoutput query="getjob" startrow="#start#" maxrows="20">
  	<cfquery name="getcust" datasource="#dts#">
		select name from #target_arcust# where custno = '#custno#'
	</cfquery>
    <tr>
      <td>#getjob.refno#</td>
      <td>#dateformat(getjob.wos_date,"dd-mm-yyyy")#</td>
      <td>#getjob.fperiod#</td>
      <td nowrap>#getjob.custno# - #getcust.name#</td>
      <td>#getjob.userid#</td>
      <td align="right"><a href="invoice1.cfm?ttype=Edit&refno=#refno#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
	   <a href="invoice1.cfm?ttype=Delete&refno=#refno#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">
        Delete</a>
      </td>
    </tr>
  </cfoutput>
</table>
	<hr>
    <div align="right">
      <cfif #start# neq 1>
        <cfoutput><a href="sinvoice.cfm?start=#prevTwenty#">Previous</a>
          ||</cfoutput>
      </cfif>
      <cfif #page# neq #noOfPage#>
        <cfoutput> <a href="sinvoice.cfm?start=#evaluate(nextTwenty)#">Next</a>
          ||</cfoutput>
      </cfif>
      <cfoutput>Page #page# Of #noOfPage#</cfoutput> </div>
  </cfform>
<cfelse>
	<h3>No Records were found.</h3>
</cfif>

<!--- <p><strong><br>
  Last Used Invoice No :</strong> <font color="#FF0000"><strong><cfoutput>#getGeneralInfo.invno#</cfoutput>   </strong></font>

</p>
<p><br>
  <strong>To Invoice from Delivery Order: </strong><h2><a href="">Click Here!</a></h2>
  <br>
</p>
<p><br>
  <strong>To Invoice from Sales Order: </strong><h2><a href="">Click Here!</a></h2>
</p> --->
</body>
</html>
