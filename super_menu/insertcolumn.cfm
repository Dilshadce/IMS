<html>
<head>
<title>Insert User PIN</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="submit" default="">

<body>
	<H1>Add Column In Database</H1>
<p>

<form name="form1" method="post" action="">
	<table width="60%" border="0" cellspacing="0" cellpadding="2" class="data" align="center">
		<tr>
			<td>Table Name</td>
    		<td>Column Name</td>
			<td>Column Type</td>
			<td>Add After Column</td>
			<td></td>
  		</tr>
  		<tr>
    		<td><input type="text" name="tablename"></td>
			<td><input type="text" name="colname"></td>
			<td><input type="text" name="coltype"></td>
			<td><input type="text" name="addafter"></td>
			<td>
				<select name="altertype">
					<option value="1" selected>This Database</option>
					<option value="2">All Databases</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">
				<div align="right">
					<input type="submit" name="Submit" value="Submit">
        		</div>
			</td>
		</tr>
	</table>
</form>
</p>
<cfif submit eq 'Submit'>
	<cfif form.tablename eq "">
		Table Name cannot be empty!<cfabort>
	</cfif>
	<cfif form.colname eq "">
		Column Name cannot be empty!<cfabort>
	</cfif>
	<cfif form.coltype eq "">
		Column Type cannot be empty!<cfabort>
	</cfif>
	
	<cfif isdefined("altertype") and altertype eq "2">
		<cfquery name="getcompany" datasource="main">
			select userDept 
			from users 
			where userDept not in ('cyt_i','hom_i','mj_i','oilestates_a','pwd_i','steel05_i','steel_i','marujyu_i','floprints06_i')
			and userDept not like '%_a'
			group by userDept order by userDept
		</cfquery>
	
		<cfloop query="getcompany">
			<cfset dbname = getcompany.userDept>
			<cftry>
				<cfquery name="alter" datasource="#dbname#">
					alter table #form.tablename# add column #form.colname# #form.coltype# <cfif form.addafter neq "">after #form.addafter#</cfif>
				</cfquery>
			<cfcatch type="database">
				<cfoutput>#dbname# fail to alter table. #cfcatch.Message# - #cfcatch.SQLState#.</cfoutput><br>
			</cfcatch>
			</cftry>
		</cfloop>
		
	<cfelse>
		<cftry>
			<cfquery name="alter" datasource="#dts#">
				alter table #form.tablename# add column #form.colname# #form.coltype# <cfif form.addafter neq "">after #form.addafter#</cfif>
			</cfquery> 
		<cfcatch type="database">
			<cfoutput>Fail to alter table. #cfcatch.Message# - #cfcatch.SQLState#.</cfoutput>
		</cfcatch>
		</cftry>
	</cfif>
</cfif>
</body>
</html>