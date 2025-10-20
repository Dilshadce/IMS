<html>
<head>
<title>Customer Relationship Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

</head>
<body>
<cfquery datasource='#dts#' name="getHeaderInfo">
	select * from service_tran where serviceid ='#serviceid#' 
</cfquery>	
<h1>Update Job</h1>
<h4>
<a href="createjob.cfm?type=Create">Creating New Job Sheet</a> || 
<a href="viewjob.cfm">List all Job Sheet</a> || 
<a href="s_createjob.cfm">Search For Job Sheet</a> ||
</h4>
<hr>

<cfquery datasource='#dts#' name="getcustinfo">
	Select * from #target_arcust# where custno = "#url.custno#"
</cfquery>

<cfquery name="getct" datasource="#dts#">
	Select * from ictran where custno = "#url.custno#" and itemno = "MAINTENANCE-1Y" and type = "INV"
</cfquery>

<cfif getct.recordcount GT 0 >
  
	<cfset duedate = DateAdd("d", 372 , getct.wos_date)>
	<cfset duedate2 = datediff("d", now(), duedate)>
	
<cfelse>
	<cfset duedate = 0>
	<cfset duedate2 =0>
</cfif>

<div align="center"></div>
<cfform name="createjob" action="updatejobprocess.cfm" method="post">
	<cfoutput>
	<input type="hidden" name="serviceid" value="#url.serviceid#">
	</cfoutput>
  <table align="center" class="data">
    <tr> 
      <th colspan="2">Update Job Information</th>
    </tr>
    <tr> 
      <th width="121">Customer ID</th>
      <td width="162"><cfoutput> 
          <input name="custno" type="text" value="#url.custno#">
        </cfoutput> </tr>
    <tr> 
      <th>Status</th>
      <td><select name="s_status">
          <option value="4">Unsolved</option>
          <option value="3">Closed</option>
          <option value="5">Cancel</option>
        </select></td>
    </tr>
	<cfset xcomments = tostring(#getheaderinfo.comments#)>
    <tr> 
      <th>Comments</th>
      <td align="right" nowrap><textarea name="comments" cols="50" rows="5"><cfoutput>#xcomments#</cfoutput></textarea></td>
    </tr>
    <tr> 
      <td></td>
      <td align="right" nowrap><input name="submit" type="submit" value="Submit"></td>
    </tr>
  </table>
</cfform>
</body>
</html>
