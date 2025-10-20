<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "100,294,65,101">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.accno')>
	<cfset URLaccno = trim(urldecode(url.accno))>
</cfif>
<cfif IsDefined('url.menuID')>
	<cfset URLmenuID = url.menuID>
</cfif>
<cfoutput>
<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfquery name="checkExist" datasource="#dts#">
			SELECT accno
            FROM locationmap
			WHERE accno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.accno#">
		</cfquery>
		<cfif checkExist.recordcount>
			<script type="text/javascript">
				alert('#trim(form.accno)# already exist!');
				window.open('/default/maintenance/locationmapping/accno.cfm?action=create?menuID=#URLmenuID#','_self');
			</script>
		<cfelse>
			<!--- <cftry> --->
				<cfquery name="createService" datasource="#dts#">
					INSERT INTO locationmap (accno, newaccno,created_on,created_by)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.accno)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newaccno)#">,
                        now(),
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">
					)
				</cfquery>
				<!--- <cfcatch type="any">
					<script type="text/javascript">
						alert('Fail to create #trim(form.accno)#.\nError Message: #cfcatch.message#');
						window.open('/latest/maintenance/accno.cfm?action=create?menuID=#URLmenuID#','_self');
					</script>
				</cfcatch>
			</cftry> --->
			<script type="text/javascript">
				alert('Created new #trim(form.accno)# successfully!');
				window.open('/default/maintenance/locationmapping/accnoMapProfile.cfm?menuID=#URLmenuID#','_self');
			</script>
		</cfif>
	<cfelseif url.action EQ "update">
		<cftry>
			<cfquery name="updateService" datasource="#dts#">
				UPDATE locationmap
				SET
					newaccno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.newaccno)#">,
                    updated_on = now(),
                    updated_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">
				WHERE accno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.accno)#">
			</cfquery>
		<cfcatch type="any">
			<script type="text/javascript">
				alert('Fail to update #trim(form.accno)#.\nError Message: #cfcatch.message#');
				window.open('/default/maintenance/locationmapping/accno.cfm?action=update&menuID=#URLmenuID#&accno=#form.accno#','_self');
			</script>
		</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Updated #trim(form.accno)# successfully!');
			window.open('/default/maintenance/locationmapping/accnomapProfile.cfm?menuID=#URLmenuID#','_self');
		</script>
	<cfelseif url.action EQ "delete">
		<cftry>
			<cfquery name="deleteService" datasource="#dts#">
				DELETE FROM locationmap
				WHERE accno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLaccno#">
			</cfquery>
			<cfcatch type="any">
				<script type="text/javascript">
					alert('Fail to delete #URLaccno#.\nError Message: #cfcatch.message#');
					window.open('/default/maintenance/locationmapping/accnomapProfile.cfm?menuID=#URLmenuID#&accno=#URLaccno#','_self');
				</script>
			</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted #URLaccno# successfully!');
			window.open('/default/maintenance/locationmapping/accnomapProfile.cfm?menuID=#URLmenuID#','_self');
		</script>
	<cfelseif url.action EQ "print">

		<cfquery name="getGsetup" datasource="#dts#">
			SELECT compro
            FROM gsetup;
		</cfquery>

		<cfquery name="printService" datasource="#dts#">
			SELECT accno,newaccno
			FROM locationmap
			ORDER BY accno;
		</cfquery>
        <cfoutput>
<!---        <cfset pageTitle = "#words[]#">	--->
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <title>#url.pageTitle# Listing</title>
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
                <h1 class="text">#url.pageTitle# Listing</h1>
                <p class="lead">#words[100]#: #getGsetup.compro#</p>
            </div
            ><div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>ACCNO</th>
                        <th>NEW ACCNO</th>
                    </tr>
                </thead>
                <tbody>
                    <cfloop query="printService">
                    <tr>
                        <td>#accno#</td>
                        <td>#newaccno#</td>
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
			window.open('/default/maintenance/locationmapping/accnoMapProfile.cfm','_self');
		</script>
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/default/maintenance/locationmapping/accnoMapProfile.cfm','_self');
	</script>
</cfif>
</cfoutput>