<html>
<head>
<title>User Id Location Profile</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfif isdefined("form.save")>
	<cfquery name="truncate_user_id_location" datasource="#dts#">
		truncate user_id_location;
	</cfquery>
		
	<cfif form.totalcount neq 0>
		<cfloop index="a" from="1" to="#form.totalcount#">
			<cfquery name="insert_record" datasource="#dts#">
				insert into user_id_location 
				(
					userid,
					location,
					invoice_set
				)
				values
				(
					'#evaluate("jsstringformat(preservesinglequotes(form.userid#a#))")#',
					'#evaluate("jsstringformat(preservesinglequotes(form.location#a#))")#',
					'#evaluate("jsstringformat(preservesinglequotes(form.invoice_set#a#))")#'
				);
			</cfquery>
		</cfloop>
	</cfif>

	<script language="javascript" type="text/javascript">
		alert("Process Done !");
	</script>
</cfif>

<cfquery name="get_main_user_id" datasource="main">
	select 
	userid,
	usergrpid,
	username 
	from users 
	where userbranch='#jsstringformat(preservesinglequotes(dts))#'
	order by userid;
</cfquery>

<cfquery name="get_user_id_location" datasource="#dts#">
	select 
	* 
	from user_id_location 
	order by userid;
</cfquery>

<cfquery name="get_location" datasource="#dts#">
	select 
	location,
	desp 
	from iclocation 
	order by location;
</cfquery>

<cfquery name="get_invoice_set" datasource="#dts#">
	(select "" as invno) 
	union
	(select invno from gsetup)
	union
	(select invno_2 from gsetup) 
	union
	(select invno_3 from gsetup) 
	union
	(select invno_4 from gsetup) 
	union
	(select invno_5 from gsetup) 
	union
	(select invno_6 from gsetup);
</cfquery>

<body>
<h1 align="center">User Id Location Profile</h1>
<cfform>
	<table align="center" class="data" width="50%" cellpadding="0" cellspacing="0">
		<tr>
			<th>User ID</th>
			<th>User Name</th>
			<th>User Group</th>
			<th>Location</th>
			<th>Invoice_Set</th>
		</tr>
		<cfinput name="totalcount" type="hidden" value="#get_main_user_id.recordcount#">
		
		<cfoutput query="get_main_user_id">
			<cfset mainuserid = get_main_user_id.userid>
			
			<cfquery name="get_user_id_location2" dbtype="query">
				select 
				* 
				from get_user_id_location 
				where userid='#jsstringformat(preservesinglequotes(get_main_user_id.userid))#'
			</cfquery>
			
			<tr>
				<td>
					<div align="center">#get_main_user_id.userid#</div>
					<cfinput name="userid#get_main_user_id.currentrow#" type="hidden" value="#get_main_user_id.userid#" readonly>
				</td>
				<td>
					<div align="center">#get_main_user_id.username#</div>
					<cfinput name="username#get_main_user_id.currentrow#" type="hidden" value="#get_main_user_id.username#" readonly>
				</td>
				<td>
					<div align="center">#get_main_user_id.usergrpid#</div>
					<cfinput name="usergrpid#get_main_user_id.currentrow#" type="hidden" value="#get_main_user_id.usergrpid#" readonly>
				</td>
				<td>
					<select name="location#get_main_user_id.currentrow#">
						<option value="">-</option>
						<cfloop query="get_location">
							<option value="#get_location.location#" #iif((mainuserid eq get_user_id_location2.userid) and (get_location.location eq get_user_id_location2.location),DE("selected"),DE(""))#>#get_location.location# - #get_location.desp#</option>
						</cfloop>
					</select>
				</td>
				<td>
					<select name="invoice_set#get_main_user_id.currentrow#">
						<cfloop query="get_invoice_set">
							<option value="#get_invoice_set.currentrow-1#" #iif((mainuserid eq get_user_id_location2.userid) and ((get_invoice_set.currentrow-1) eq get_user_id_location2.invoice_set),DE("selected"),DE(""))#>#get_invoice_set.invno#</option>
						</cfloop>
					</select>
				</td>
			</tr>
		</cfoutput>
		<tr>
			<td colspan="5"><hr></td>
		</tr>
		<tr align="center">
			<td colspan="5">
				<input name="Save" type="submit" value="Save">
				<input name="Reset" type="reset" value="Reset">
			</td>
		</tr>
	</table>
</cfform>

</body>
</html>