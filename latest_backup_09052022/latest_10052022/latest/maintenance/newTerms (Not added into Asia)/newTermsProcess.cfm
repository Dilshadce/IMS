<cfif IsDefined('url.id')>
	<cfset URLid = trim(urldecode(url.id))>
</cfif>

<cfoutput>
<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfquery name="checkExist" datasource="#dts#">
			SELECT * 
            FROM termsAndConditions
			WHERE billType=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.billType)#">
            AND desp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.desp)#">
		</cfquery>
		<cfif checkExist.recordcount>
			<script type="text/javascript">
				alert('This #trim(form.billType)# - #trim(form.desp)# already exist!');
				window.open('/latest/maintenance/newTerms/newTerms.cfm?action=create','_self');
			</script>
		<cfelse>
			<cftry>
				<cfquery name="createCategory" datasource="#dts#">
					INSERT INTO termsAndConditions (billType,desp)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.billType)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.desp)#">
					)
				</cfquery>
				<cfcatch type="any">
					<script type="text/javascript">
						alert('Failed to create #trim(form.billType)#!\nError Message: #cfcatch.message#');
						window.open('/latest/maintenance/newTerms/newTerms.cfm?action=create','_self');
					</script>
				</cfcatch>
			</cftry>
			<script type="text/javascript">
				alert('#trim(form.billType)# has been created successfully!');
				window.open('/latest/maintenance/newTerms/newTermsProfile.cfm','_self');
			</script>
		</cfif>
	<cfelseif url.action EQ "update">
   		
		<cftry>
			<cfquery name="updateCategory" datasource="#dts#">
				UPDATE termsAndConditions
				SET
					billType=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billType#">,
					desp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">
				WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.id)#">;
			</cfquery>
		<cfcatch type="any">
			<script type="text/javascript">
				alert('Failed to update #trim(form.billType)#!\nError Message: #cfcatch.message#');
				window.open('/latest/maintenance/newTerms/newTerms.cfm?action=update&id=#form.id#','_self');
			</script>
		</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Updated #trim(form.billType)# successfully!');
			window.open('/latest/maintenance/newTerms/newTermsProfile.cfm','_self');
		</script>	
	<cfelseif url.action EQ "delete">
		<cftry>
			<cfquery name="deleteCategory" datasource="#dts#">
				DELETE FROM termsAndConditions
				WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLid#">
			</cfquery>
			<cfcatch type="any">
				<script type="text/javascript">
					alert('Failed to delete #form.billType#!\nError Message: #cfcatch.message#');
					window.open('/latest/maintenance/newTerms/newTermsProfile.cfm','_self');
				</script>
			</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted successfully!');
			window.open('/latest/maintenance/newTerms/newTermsProfile.cfm','_self');
		</script>
	<cfelseif url.action EQ "print">
    
		<cfquery name="getGsetup" datasource="#dts#">
			SELECT compro 
            FROM gsetup;
		</cfquery>
        
		<cfquery name="printBillType" datasource="#dts#">
			SELECT billType,desp
			FROM termsAndConditions
			ORDER BY id;
		</cfquery>
        		
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>New Terms Listing</title>
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
			<h1 class="text">New Terms Listing</h1>
			<p class="lead">Company: #getGsetup.compro#</p>
		</div>
        
		<div class="table-responsive">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>BILL TYPE</th>
					<th>DESCRIPTION</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="printBillType">
				<tr>
					<td>#billType#</td>
					<td>#desp#</td>
				</tr>
				</cfloop>
			</tbody>
		</table>
		</div>
		<div class="panel-footer">
		<p>Printed at #DateFormat(Now(),'dd-mm-yyyy')#, #TimeFormat(Now(),'HH:MM:SS')#</p>
		</div>
		</div>		
		
		</body>
		</html>
	<cfelse>
		<script type="text/javascript">
			window.open('/latest/maintenance/newTerms/newTermsProfile.cfm','_self');
		</script>		
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/latest/maintenance/newTerms/newTermsProfile.cfm','_self');
	</script>
</cfif>
</cfoutput>