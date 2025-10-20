<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "362,100,123,65,101">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.cate')>
	<cfset URLcate = trim(urldecode(url.cate))>
</cfif>
<cfif IsDefined('url.menuID')>
	<cfset URLmenuID = url.menuID>
</cfif>
<cfoutput>
<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfquery name="checkExist" datasource="#dts#">
			SELECT cate 
            FROM iccate
			WHERE cate=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.category)#">
		</cfquery>
		<cfif checkExist.recordcount>
			<script type="text/javascript">
				alert('This #trim(form.category)# already exist!');
				window.open('/latest/maintenance/category.cfm?action=create&menuID=#URLmenuID#','_self');
			</script>
		<cfelse>
			<cftry>
				<cfquery name="createCategory" datasource="#dts#">
					INSERT INTO iccate (cate,desp)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.category)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.desp)#">
					)
				</cfquery>
				<cfcatch type="any">
					<script type="text/javascript">
						alert('Failed to create #trim(form.category)#!\nError Message: #cfcatch.message#');
						window.open('/latest/maintenance/category.cfm?action=create&menuID=#URLmenuID#','_self');
					</script>
				</cfcatch>
			</cftry>
			<script type="text/javascript">
				alert('#trim(form.category)# has been created successfully!');
				window.open('/latest/maintenance/categoryProfile.cfm?menuID=#URLmenuID#','_self');
			</script>
		</cfif>
	<cfelseif url.action EQ "update">
   		
		<cftry>
			<cfquery name="updateCategory" datasource="#dts#">
				UPDATE iccate
				SET
					cate=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.category#">,
					desp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">
				WHERE cate=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.category)#">;
			</cfquery>
		<cfcatch type="any">
			<script type="text/javascript">
				alert('Failed to update #trim(form.category)#!\nError Message: #cfcatch.message#');
				window.open('/latest/maintenance/category.cfm?action=update&menuID=#URLmenuID#&cate=#form.category#','_self');
			</script>
		</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Updated #trim(form.category)# successfully!');
			window.open('/latest/maintenance/categoryProfile.cfm?menuID=#URLmenuID#','_self');
		</script>	
	<cfelseif url.action EQ "delete">
		<cftry>
			<cfquery name="deleteCategory" datasource="#dts#">
				DELETE FROM iccate
				WHERE cate=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLcate#">
			</cfquery>
			<cfcatch type="any">
				<script type="text/javascript">
					alert('Failed to delete #URLcate#!\nError Message: #cfcatch.message#');
					window.open('/latest/maintenance/categoryProfile.cfm?menuID=#URLmenuID#','_self');
				</script>
			</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted #URLcate# successfully!');
			window.open('/latest/maintenance/categoryProfile.cfm?&menuID=#URLmenuID#','_self');
		</script>
	<cfelseif url.action EQ "print">
    
		<cfquery name="getGsetup" datasource="#dts#">
			SELECT compro 
            FROM gsetup;
		</cfquery>
        
		<cfquery name="printCategory" datasource="#dts#">
			SELECT cate,desp
			FROM iccate
			ORDER BY cate;
		</cfquery>
        <cfoutput>
        <cfset pageTitle = "#words[362]#">	
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
            <!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <title>#pageTitle#</title>
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
                    <h1 class="text">#pageTitle#</h1>
                    <p class="lead">#words[100]#: #getGsetup.compro#</p>
                </div>
                <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>#UCase(words[123])#</th>
                            <th>#UCase(words[65])#</th>
                        </tr>
                    </thead>
                    <tbody>
                        <cfloop query="printCategory">
                        <tr>
                            <td>#cate#</td>
                            <td>#desp#</td>
                        </tr>
                        </cfloop>
                    </tbody>
                </table>
                </div>
                <div class="panel-footer">
                    <p>#words[101]# #DateFormat(NOW(),'dd-mm-yyyy')#, #TimeFormat(NOW(),'HH:MM:SS')#</p>
                </div>
            </div>		
		</body>
		</html>
        </cfoutput>
	<cfelse>
		<script type="text/javascript">
			window.open('/latest/maintenance/categoryProfile.cfm?menuID=#URLmenuID#','_self');
		</script>		
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/latest/maintenance/categoryProfile.cfm?menuID=#URLmenuID#','_self');
	</script>
</cfif>
</cfoutput>