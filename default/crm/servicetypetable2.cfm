<html>
<head>
<title>Service Type Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<script language="JavaScript">
	function validate()
	{
		if(document.form.servicetypeid.value=='')
		{
			alert("Service Type cannot be blank.");
			document.form.servicetypeid.focus();
			return false;
		}
		if(document.form.desp.value=='')
		{
			alert("Your Description cannot be blank.");
			document.form.desp.focus();
			return false;
		}
		return true;
	}
	
</script>

<cfif type neq "Create">	
	<cfif type eq "Edit" or type eq "Delete">
		<cfquery datasource='#dts#' name="getservicetype">
			Select * from service_type 
			where servicetypeid='#servicetypeid#'
		</cfquery>
		<cfset servicetypeid = listfirst(getservicetype.servicetypeid)>
		<cfset desp=getservicetype.desp>
		<cfset xservi=getservicetype.servi>		
	</cfif>

	<cfif type eq "Edit">
		<cfset mode="Edit">
		<cfset title="Edit Service Type">
		<cfset button="Edit">
	<cfelse>
		<cfset mode="Delete">
		<cfset title="Delete Service Type">
		<cfset button="Delete">
	</cfif>
<cfelse>	
	<cfset servicetypeid="">
	<cfset desp="">	
	<cfset xservi="">
	
	<cfset mode="Create">
	<cfset title="Create Service Type">
	<cfset button="Create">
</cfif>

<cfquery name="getservi" datasource="#dts#">
	select * from icservi
</cfquery>

<body>
<cfoutput>
<h1>#title#</h1>

<h4>
	<a href="servicetypetable2.cfm?type=Create">Creating a New Service Type</a>
	|| <a href="servicetypetable.cfm">List all Service Type</a>
	|| <a href="s_servicetype.cfm">Search For Service Type</a>
</h4>

<form name="form" action="servicetypetableprocess.cfm" method="post" onSubmit="return validate()">
	<input type="hidden" name="mode" value="#mode#">
	<h1 align="center">Service Type Maintenance</h1>
  	
	<table align="center" class="data" width="600">
      	<tr>
			<td width="15%" nowrap>Service Type:</td>
			<td>
			<cfif mode eq "Delete" or mode eq "Edit">
            	<input type="text" size="15" name="servicetypeid" value="#servicetypeid#" maxlength="20" readonly>
            <cfelse>
            	<input type="text" size="15" name="servicetypeid" value="#servicetypeid#" maxlength="20">
          	</cfif>
			</td>
		</tr>
      	<tr> 
        	<td>Description:</td>
        	<td><input type="text" size="40" name="desp" value="#desp#" maxlength="50"></td>
      	</tr>
		<tr> 
        	<td>Service:</td>
        	<td>
				<select name="servi">
					<option value="">Select a Service</option>
					<cfloop query="getservi">
						<option value="#getservi.servi#" <cfif xservi eq getservi.servi>selected</cfif>>#getservi.desp#</option>
					</cfloop>
				</select>
			</td>
      	</tr>
		<tr align="center"> 
			<td colspan="100%" align="center">
			<input name="submit" type="submit" value="#button#">
			</td>
		</tr>
	</table>
</form>
</cfoutput>

</body>
</html>