<html>
<head>
<title>AMS User</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<h4>
	<cfif husergrpid eq "Muser">
		<a href="/home2.cfm"><u>Home</u></a>
	</cfif>
</h4>

<cfif isdefined("form.submit")>
	<cfif isdefined("form.linked_to_ams")>
		<cfquery name="update_selected_ams_link" datasource="main">
			update users set 
			linktoams='Y' 
			where userbranch in (<cfqueryparam cfsqltype="cf_sql_char" list="yes" separator="," value="#form.linked_to_ams#">);
		</cfquery>
		
		<cfquery name="update_unselected_ams_link" datasource="main">
			update users set 
			linktoams='' 
			where userbranch not in (<cfqueryparam cfsqltype="cf_sql_char" list="yes" separator="," value="#form.linked_to_ams#">);
		</cfquery>

		<script language="javascript" type="text/javascript">
			alert("IMS Users <cfoutput>#linked_to_ams#</cfoutput> Have Been Linked !");
		</script>
	<cfelse>
		<cfquery name="update_unselected_ams_link" datasource="main">
			update users set 
			linktoams='';
		</cfquery>
		
		<script language="javascript" type="text/javascript">
			alert("No IMS Users Link To AMS !");
		</script>
	</cfif>
	
	<script language="javascript" type="text/javascript">
		alert("Your Setting Has Been Saved !");
		//top.frames[1].location.href=top.frames[1].location.href;
		top.frames[0].frames[1].location.href=top.frames[0].frames[1].location.href;
	</script>
</cfif>

<cfquery name="getdatabase" datasource="main">
	select ucase(userbranch) as userbranch,linktoams  
	from users 
	group by userbranch order by linktoams desc,userbranch;
</cfquery>

<form name="amsdatabase" action="amsuser.cfm" method="post">
	<table align="center" class="data" width="50%" cellpadding="0" cellspacing="0">
    	<tr align="center">
      		<td colspan="2"><h2>Please Tick If The Company ID Is An AMS user.</h2></td>
    	</tr>
    	<tr align="center">
      		<td colspan="2"><h2>IMS Will Link TO AMS.</h2></td>
    	</tr>
    	<cfoutput query="getdatabase">
			<cfif getdatabase.linktoams eq "Y">
				<tr bgcolor="FFFFFF" onMouseOut="JavaScript:this.style.backgroundColor='';" onMouseOver="JavaScript:this.style.backgroundColor='99FF00';">
					<td align="center"><font face="Times New Roman, Times, serif" size="2">#getdatabase.userbranch#</font></td>
					<td align="left"><input name="linked_to_ams" type="checkbox" value="#getdatabase.userbranch#" checked></td>
				</tr>
				<tr>
					<td></td>
				</tr>
			<cfelse>
				<tr bgcolor=#iif((getdatabase.currentrow mod 2) eq 1,DE('"9999FF"'),DE('"99FF99"'))# onMouseOut="JavaScript:this.style.backgroundColor='';" onMouseOver="JavaScript:this.style.backgroundColor='99FF00';">
					<td align="center"><font face="Times New Roman, Times, serif" size="2">#getdatabase.userbranch#</font></td>
					<td align="left"><input name="linked_to_ams" type="checkbox" value="#getdatabase.userbranch#"></td>
				</tr>
				<tr>
					<td></td>
				</tr>
			</cfif>
    	</cfoutput>
  	</table>
	<table align="center" class="data" width="50%" cellpadding="0" cellspacing="0">
		<tr align="center">
			<td>
				<input name="submit" type="submit" value="Submit">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="reset" type="reset" value="Reset">
			</td>
		</tr>
	</table>
</form>
	
</body>
</html>