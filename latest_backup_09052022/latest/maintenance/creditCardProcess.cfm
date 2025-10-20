<cfif IsDefined('url.cardName')>
	<cfset URLcardName = trim(urldecode(url.cardName))>
</cfif>
<cfif IsDefined('url.menuID')>
	<cfset URLmenuID = url.menuID>
</cfif>
<cfoutput>
<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfquery name="checkExist" datasource="#dts#">
			SELECT cardName 
            FROM creditCard
			WHERE cardName=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.cardName)#">
		</cfquery>
		<cfif checkExist.recordcount>
			<script type="text/javascript">
				alert('This #trim(form.cardName)# already exist!');
				window.open('/latest/maintenance/creditCard.cfm?action=create&menuID=#URLmenuID#','_self');
			</script>
		<cfelse>
			<cftry>
				<cfquery name="createCreditCard" datasource="#dts#">
					INSERT INTO creditCard (cardName,cardDesp)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.cardName)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.cardDesp)#">
					)
				</cfquery>
				<cfcatch type="any">
					<script type="text/javascript">
						alert('Failed to create #trim(form.cardName)#!\nError Message: #cfcatch.message#');
						window.open('/latest/maintenance/creditCard.cfm?action=create&menuID=#URLmenuID#','_self');
					</script>
				</cfcatch>
			</cftry>
			<script type="text/javascript">
				alert('#trim(form.cardName)# has been created successfully!');
				window.open('/latest/maintenance/creditCardProfile.cfm?menuID=#URLmenuID#','_self');
			</script>
		</cfif>
	<cfelseif url.action EQ "update">
   		
		<cftry>
			<cfquery name="updateCreditCard" datasource="#dts#">
				UPDATE creditCard
				SET
					cardName=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cardName#">,
					cardDesp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cardDesp#">
				WHERE cardName=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.cardName)#">;
			</cfquery>
		<cfcatch type="any">
			<script type="text/javascript">
				alert('Failed to update #trim(form.cardName)#!\nError Message: #cfcatch.message#');
				window.open('/latest/maintenance/creditCard.cfm?action=update&menuID=#URLmenuID#&cardName=#form.cardName#','_self');
			</script>
		</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Updated #trim(form.cardName)# successfully!');
			window.open('/latest/maintenance/creditCardProfile.cfm?menuID=#URLmenuID#','_self');
		</script>	
	<cfelseif url.action EQ "delete">
		<cftry>
			<cfquery name="deleteCreditCard" datasource="#dts#">
				DELETE FROM creditCard
				WHERE cardName=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLcardName#">
			</cfquery>
			<cfcatch type="any">
				<script type="text/javascript">
					alert('Failed to delete #URLcardName#!\nError Message: #cfcatch.message#');
					window.open('/latest/maintenance/creditCardProfile.cfm?menuID=#URLmenuID#','_self');
				</script>
			</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted #URLcardName# successfully!');
			window.open('/latest/maintenance/creditCardProfile.cfm?menuID=#URLmenuID#','_self');
		</script>
	<cfelseif url.action EQ "print">
    
		<cfquery name="getGsetup" datasource="#dts#">
			SELECT compro 
            FROM gsetup;
		</cfquery>
        
		<cfquery name="printCreditCard" datasource="#dts#">
			SELECT cardName,cardDesp
			FROM creditCard
			ORDER BY cardName;
		</cfquery>
        
        <cfoutput>		
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
           <!--- <meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
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
                <p class="lead">Company: #getGsetup.compro#</p>
            </div>
            <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>CREDIT CARD NAME</th>
                        <th>CREDIT CARD DESCRIPTION</th>
                    </tr>
                </thead>
                <tbody>
                    <cfloop query="printCreditCard">
                    <tr>
                        <td>#cardName#</td>
                        <td>#cardDesp#</td>
                    </tr>
                    </cfloop>
                </tbody>
            </table>
            </div>
            <div class="panel-footer">
                <p>Printed at #DateFormat(NOW(),'dd-mm-yyyy')#, #TimeFormat(NOW(),'HH:MM:SS')#</p>
            </div>
		</div>		
		
		</body>
		</html>
        </cfoutput>
	<cfelse>
		<script type="text/javascript">
			window.open('/latest/maintenance/creditCardProfile.cfm?menuID=#URLmenuID#','_self');
		</script>		
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/latest/maintenance/creditCardProfile.cfm?menuID=#URLmenuID#','_self');
	</script>
</cfif>
</cfoutput>