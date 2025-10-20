<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "640,100,65,634,638,101">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.groupID')>
	<cfset URLrecurringID = trim(urldecode(url.groupID))>
</cfif>

<cfoutput>
<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
	<cfset ndate = createdate(right(form.date,4),mid(form.date,4,2),left(form.date,2))>
		<cfquery name="checkExist" datasource="#dts#">
			SELECT groupID 
            FROM recurrgroup
			WHERE groupID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.reccuringID)#">
		</cfquery>
		<cfif checkExist.recordcount>
			<script type="text/javascript">
				alert('This #trim(form.reccuringID)# already exist!');
				window.open('/latest/maintenance/recurringGroup.cfm?action=create','_self');
			</script>
		<cfelse>
			<cftry>
				<cfquery name="createRecurringGroup" datasource="#dts#">
					INSERT INTO recurrgroup (desp,recurrtype,nextdate)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.desp)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.recurringType)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(ndate,'YYYY-MM-DD')#">
					)
				</cfquery>
				<cfcatch type="any">
					<script type="text/javascript">
						alert('Failed to create #trim(form.reccuringID)#!\nError Message: #cfcatch.message#');
						window.open('/latest/maintenance/recurringGroup.cfm?action=create','_self');
					</script>
				</cfcatch>
			</cftry>
			<script type="text/javascript">
				alert('#trim(form.reccuringID)# has been created successfully!');
				window.open('/latest/maintenance/recurringGroupProfile.cfm','_self');
			</script>
		</cfif>
	<cfelseif url.action EQ "update">
   		<cfset ndate = createdate(right(form.date,4),mid(form.date,4,2),left(form.date,2))>
		<cftry>
			<cfquery name="updateRecurringGroup" datasource="#dts#">
				UPDATE recurrgroup
				SET
					desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
                    recurrtype = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.recurringType#">,
                    nextDate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(ndate,'YYYY-MM-DD')#">
				WHERE groupID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.reccuringID)#">;
			</cfquery>
			
		<cfcatch type="any">
			<script type="text/javascript">
				alert('Failed to update #trim(form.reccuringID)#!\nError Message: #cfcatch.message#');
				window.open('/latest/maintenance/recurringGroup.cfm?action=update&groupID=#form.reccuringID#','_self');
			</script>
		</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Updated #trim(form.reccuringID)# successfully!');
			window.open('/latest/maintenance/recurringGroupProfile.cfm','_self');
		</script>	
	<cfelseif url.action EQ "delete">
		<cftry>
			<cfquery name="deleteRecurringGroup" datasource="#dts#">
				DELETE FROM recurrgroup
				WHERE groupID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLrecurringID#">
			</cfquery>
			<cfcatch type="any">
				<script type="text/javascript">
					alert('Failed to delete #URLrecurringID#!\nError Message: #cfcatch.message#');
					window.open('/latest/maintenance/recurringGroupProfile.cfm','_self');
				</script>
			</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted #URLrecurringID# successfully!');
			window.open('/latest/maintenance/recurringGroupProfile.cfm','_self');
		</script>
	<cfelseif url.action EQ "print">
    
		<cfquery name="getGsetup" datasource="#dts#">
			SELECT compro 
            FROM gsetup;
		</cfquery>
        
		<cfquery name="printRecurringGroup" datasource="#dts#">
			SELECT groupID,desp,recurrtype,nextdate
			FROM recurrgroup
			ORDER BY groupID;
		</cfquery>
        		
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>#words[640]#</title>
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
			<h1 class="text">#words[640]#</h1>
			<p class="lead">#words[100]#: #getGsetup.compro#</p>
		</div>
        
		<div class="table-responsive">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>#UCase(words[65])#</th>
					<th>#UCase(words[634])#</th>
                    <th>#UCase(words[638])#</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="printRecurringGroup">
				<tr>
					<td>#desp#</td>
					<td>#recurrtype#</td>
                    <td>#nextdate#</td>
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
			window.open('/latest/maintenance/recurringGroupProfile.cfm','_self');
		</script>		
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/latest/maintenance/recurringGroupProfile.cfm','_self');
	</script>
</cfif>
</cfoutput>