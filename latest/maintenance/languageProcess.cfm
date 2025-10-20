<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "602,100,603,65,101">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.langno')>
	<cfset URLlanguageNo = trim(urldecode(url.langno))>
</cfif>

<cfoutput>
<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfquery name="checkExist" datasource="#dts#">
			SELECT langno 
            FROM iclanguage
			WHERE langno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.languageNo)#">
		</cfquery>
        
        
		<cfif checkExist.recordcount>
			<script type="text/javascript">
				alert('This #trim(form.languageNo)# already exist!');
				window.open('/latest/maintenance/language.cfm?action=create','_self');
			</script>
		<cfelse>
			<cftry>
				<cfquery name="createLanguage" datasource="#dts#">
					INSERT INTO iclanguage (english,chinese)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.english)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.chinese)#">
					)
				</cfquery>
				<cfcatch type="any">
					<script type="text/javascript">
						alert('Failed to create #trim(form.languageNo)#!\nError Message: #cfcatch.message#');
						window.open('/latest/maintenance/language.cfm?action=create','_self');
					</script>
				</cfcatch>
			</cftry>
			<script type="text/javascript">
				alert('#trim(form.languageNo)# has been created successfully!');
				window.open('/latest/maintenance/languageProfile.cfm','_self');
			</script>
		</cfif>
	<cfelseif url.action EQ "update">
   		
		<cftry>
			<cfquery name="updateLanguage" datasource="#dts#">
				UPDATE iclanguage
				SET
					english = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.english#">,
                   	chinese = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.chinese#">				
				WHERE langno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.languageNo)#">;
			</cfquery>
		<cfcatch type="any">
			<script type="text/javascript">
				alert('Failed to update #trim(form.languageNo)#!\nError Message: #cfcatch.message#');
				window.open('/latest/maintenance/language.cfm?action=update&langno=#form.languageNo#','_self');
			</script>
		</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Updated #trim(form.languageNo)# successfully!');
			window.open('/latest/maintenance/languageProfile.cfm','_self');
		</script>	
	<cfelseif url.action EQ "delete">
		<cftry>
			<cfquery name="deleteLanguage" datasource="#dts#">
				DELETE FROM iclanguage
				WHERE langno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLlanguageNo#">
			</cfquery>
			<cfcatch type="any">
				<script type="text/javascript">
					alert('Failed to delete #URLlanguageNo#!\nError Message: #cfcatch.message#');
					window.open('/latest/maintenance/languageProfile.cfm','_self');
				</script>
			</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted #URLlanguageNo# successfully!');
			window.open('/latest/maintenance/languageProfile.cfm','_self');
		</script>
	<cfelseif url.action EQ "print">
    
		<cfquery name="getGsetup" datasource="#dts#">
			SELECT compro 
            FROM gsetup;
		</cfquery>
        
		<cfquery name="printLanguage" datasource="#dts#">
			SELECT langno,english,chinese
			FROM iclanguage
			ORDER BY langno;
		</cfquery>
        		
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>#words[602]#</title>
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
			<h1 class="text">#words[602]#</h1>
			<p class="lead">#words[100]#: #getGsetup.compro#</p>
		</div>
        
		<div class="table-responsive">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>#UCase(words[603])#</th>
					<th>#UCase(words[65])#</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="printLanguage">
				<tr>
					<td>#english#</td>
					<td>#chinese#</td>
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
			window.open('/latest/maintenance/categoryProfile.cfm','_self');
		</script>		
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/latest/maintenance/categoryProfile.cfm','_self');
	</script>
</cfif>
</cfoutput>