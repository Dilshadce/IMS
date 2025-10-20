<html>
<head>
<title>CSO Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<script language="JavaScript">
	function validate()
	{
		if(document.form.csoid.value=='')
		{
			alert("CSO Id cannot be blank.");
			document.form.csoid.focus();
			return false;
		}
		if(document.form.desp.value=='')
		{
			alert("CSO Description cannot be blank.");
			document.form.desp.focus();
			return false;
		}
		return true;
	}
	
</script>

<cfif type neq "Create">
	<cfif type eq "Edit" or type eq "Delete">
		<cfquery datasource='#dts#' name="getcso">
			Select * from cso 
			where csoid='#csoid#'
		</cfquery>
		<cfset csoid = listfirst(getcso.csoid)>
		<cfset desp=getcso.desp>		
	</cfif>

	<cfif type eq "Edit">
		<cfset mode="Edit">
		<cfset title="Edit CSO">
		<cfset button="Edit">
	<cfelse>
		<cfset mode="Delete">
		<cfset title="Delete CSO">
		<cfset button="Delete">
	</cfif>
<cfelse>	
	<cfset csoid = "">
	<cfset desp = "">	
	
	<cfset mode="Create">
	<cfset title="Create CSO">
	<cfset button="Create">
</cfif>

<body>
<cfoutput>
<h1>#title#</h1>

<h4>
	<a href="csotable2.cfm?type=Create">Creating a New CSO</a>
	|| <a href="csotable.cfm">List all CSO</a>
	|| <a href="s_cso.cfm">Search For CSO</a>
</h4>

<form name="form" action="csotableprocess.cfm" method="post" onSubmit="return validate()">
	<input type="hidden" name="mode" value="#mode#">
	<h1 align="center">CSO Maintenance</h1>
  	
	<table align="center" class="data" width="600">
      	<tr>
			<td width="15%" nowrap>CSO Id:</td>
			<td colspan="4">
			<cfif mode eq "Delete" or mode eq "Edit">
            	<input type="text" size="15" name="csoid" value="#csoid#" maxlength="20" readonly>
            <cfelse>
            	<input type="text" size="15" name="csoid" value="#csoid#" maxlength="20">
          	</cfif>
			</td>
		</tr>
      	<tr> 
        	<td>Description:</td>
        	<td colspan="4"><input type="text" size="40" name="desp" value="#desp#" maxlength="40"></td>
      	</tr>
		<tr align="center"> 
			<td colspan="5" align="center">
			<input name="submit" type="submit" value="#button#">
			</td>
		</tr>
	</table>
</form>
</cfoutput>

</body>
</html>