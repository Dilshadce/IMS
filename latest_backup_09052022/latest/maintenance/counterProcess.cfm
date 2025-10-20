<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "589,100,585,65,101">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.counterID')>
	<cfset URLcounter = trim(urldecode(url.counterID))>
</cfif>

<cfoutput>
<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfquery name="checkExist" datasource="#dts#">
			SELECT counterid 
            FROM counter
			WHERE counterid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.counter)#">
		</cfquery>
		<cfif checkExist.recordcount>
			<script type="text/javascript">
				alert('This #trim(form.counter)# already exist!');
				window.open('/latest/maintenance/counter.cfm?action=create','_self');
			</script>
		<cfelse>
			<cftry>
				<cfquery name="createCounter" datasource="#dts#">
					INSERT INTO counter (counterid,counterdesp,bonduser)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.counter)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.desp)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.bondUser)#">  
					)
				</cfquery>
				<cfcatch type="any">
					<script type="text/javascript">
						alert('Failed to create #trim(form.counter)#!\nError Message: #cfcatch.message#');
						window.open('/latest/maintenance/counter.cfm?action=create','_self');
					</script>
				</cfcatch>
			</cftry>
			<script type="text/javascript">
				alert('#trim(form.counter)# has been created successfully!');
				window.open('/latest/maintenance/counterProfile.cfm','_self');
			</script>
		</cfif>
	<cfelseif url.action EQ "update">
   		
		<cftry>
			<cfquery name="updateCounter" datasource="#dts#">
				UPDATE counter
				SET
					counterid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.counter#">,
					counterdesp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
                    bondUser = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.bondUser)#">
				WHERE counterid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.counter)#">;
			</cfquery>
		<cfcatch type="any">
			<script type="text/javascript">
				alert('Failed to update #trim(form.counter)#!\nError Message: #cfcatch.message#');
				window.open('/latest/maintenance/counter.cfm?action=update&counterid=#form.counter#','_self');
			</script>
		</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Updated #trim(form.counter)# successfully!');
			window.open('/latest/maintenance/counterProfile.cfm','_self');
		</script>	
	<cfelseif url.action EQ "delete">
		<cftry>
			<cfquery name="deleteCounter" datasource="#dts#">
				DELETE FROM counter
				WHERE counterid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLcounter#">
			</cfquery>
			<cfcatch type="any">
				<script type="text/javascript">
					alert('Failed to delete #URLcounter#!\nError Message: #cfcatch.message#');
					window.open('/latest/maintenance/counterProfile.cfm','_self');
				</script>
			</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted #URLcounter# successfully!');
			window.open('/latest/maintenance/counterProfile.cfm','_self');
		</script>
	<cfelseif url.action EQ "print">
    
		<cfquery name="getGsetup" datasource="#dts#">
			SELECT compro 
            FROM gsetup;
		</cfquery>
        
		<cfquery name="printCounter" datasource="#dts#">
			SELECT counterid,counterdesp
			FROM counter
			ORDER BY counterid;
		</cfquery>
        		
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>#words[589]#</title>
		<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
		<!--[if lt IE 9]>
			<script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
			<script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
		<![endif]-->
		<script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
		</head>
		<body>
		
		<div class="container">
		<div class="page-header">
			<h1 class="text">#words[589]#</h1>
			<p class="lead">#words[100]#: #getGsetup.compro#</p>
		</div>
        
		<div class="table-responsive">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>#UCase(words[585])#</th>
					<th>#UCase(words[65])#</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="printCounter">
				<tr>
					<td>#counterid#</td>
					<td>#counterdesp#</td>
				</tr>
				</cfloop>
			</tbody>
		</table>
		</div>
		<div class="panel-footer">
		<p>#words[101]# #DateFormat(Now(),'dd-mm-yyyy')#, #TimeFormat(Now(),'HH:MM:SS')#</p>
		</div>
		</div>		
		
		</body>
		</html>
	<cfelse>
		<script type="text/javascript">
			window.open('/latest/maintenance/counterProfile.cfm','_self');
		</script>		
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/latest/maintenance/counterProfile.cfm','_self');
	</script>
</cfif>
</cfoutput>