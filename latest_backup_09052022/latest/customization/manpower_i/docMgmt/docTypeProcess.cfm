<cfoutput>
<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfquery name="checkExist" datasource="#dts#">
			SELECT doctype 
            FROM doctype
			WHERE doctype=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.docType)#">
		</cfquery>
		<cfif checkExist.recordcount>
			<script type="text/javascript">
				alert('This #trim(form.docType)# already exist!');
				window.open('/latest/customization/manpower_i/docMgmt/docTypeDetail.cfm?action=create','_self');
			</script>
		<cfelse>
			<cftry>
				<cfquery name="createDocType" datasource="#dts#">
					INSERT INTO docType (docType, created_by, created_on)
					VALUES(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.docType#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(now(), 'yyyy-mm-dd HH:nn:ss')#">
					)
				</cfquery>
                <cfquery name="getNewID" datasource="#dts#">
                	SELECT id 
                    FROM docType
                    ORDER BY created_on DESC
                    LIMIT 1
                </cfquery>
                <cfquery name="createAT" datasource="#dts#">
					INSERT INTO docTypeAT (doctype_id, doctype, remark, created_by, created_on)
					VALUES(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getNewID.id#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.docType#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="CREATE">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(now(), 'yyyy-mm-dd HH:nn:ss')#">
					)
				</cfquery>
				<cfcatch type="any">
					<script type="text/javascript">
						alert('Failed to create #trim(form.docType)#!\nError Message: #cfcatch.message#');
						window.open('/latest/customization/manpower_i/docMgmt/docTypeDetail.cfm?action=create','_self');
					</script>
				</cfcatch>
			</cftry>
			<script type="text/javascript">
				alert('#trim(form.docType)# has been created successfully!');
				window.open('/latest/customization/manpower_i/docMgmt/docType.cfm','_self');
			</script>
		</cfif>
	<cfelseif url.action EQ "update">	
		<cftry>
			<cfquery name="updateDocType" datasource="#dts#">
				UPDATE docType
				SET docType=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.docType#">,
					updated_by=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                    updated_on=<cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(now(), 'yyyy-mm-dd HH:nn:ss')#">
				WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.id#">;
			</cfquery>
            <cfquery name="getOldID" datasource="#dts#">
                SELECT * 
                FROM docType
                WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.id#">;
            </cfquery>
            <cfquery name="updateAT" datasource="#dts#">
                INSERT INTO docTypeAT (doctype_id, doctype, remark, created_by, created_on, updated_by, updated_on)
                VALUES(
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.id#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.docType#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="UPDATE">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.created_by#">,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(getOldId.created_on, 'yyyy-mm-dd HH:nn:ss')#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(now(), 'yyyy-mm-dd HH:nn:ss')#">
                )
            </cfquery>
		<cfcatch type="any">
			<script type="text/javascript">
				alert('Failed to update #trim(form.docType)#!\nError Message: #cfcatch.message#');
				window.open('/latest/customization/manpower_i/docMgmt/docTypeDetail.cfm?action=update&id=#form.id#','_self');
			</script>
		</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Updated #trim(form.docType)# successfully!');
			window.open('/latest/customization/manpower_i/docMgmt/docType.cfm','_self');
		</script>	
	<cfelseif url.action EQ "delete">
		<cftry>
        	<cfquery name="getOldID" datasource="#dts#">
                SELECT * 
                FROM docType
                WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
            </cfquery>
			<cfquery name="deleteDocType" datasource="#dts#">
				DELETE FROM doctype
				WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
			</cfquery>
            <cfquery name="deleteAT" datasource="#dts#">
                INSERT INTO docTypeAT (doctype_id, doctype, remark, created_by, created_on, updated_by, updated_on)
                VALUES(
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.id#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.docType#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="DELETE">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.created_by#">,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(getOldId.created_on, 'yyyy-mm-dd HH:nn:ss')#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(now(), 'yyyy-mm-dd HH:nn:ss')#">
                )
            </cfquery>
			<cfcatch type="any">
				<script type="text/javascript">
					alert('Failed to delete #getOldID.doctype#!\nError Message: #cfcatch.message#');
					window.open('/latest/customization/manpower_i/docMgmt/docType.cfm','_self');
				</script>
			</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted #getOldID.doctype# successfully!');
			window.open('/latest/customization/manpower_i/docMgmt/docType.cfm','_self');
		</script>
	<cfelseif url.action EQ "print">   
		<cfquery name="getGsetup" datasource="#dts#">
			SELECT compro 
            FROM gsetup;
		</cfquery>
        
		<cfquery name="printDocType" datasource="#dts#">
			SELECT id, doctype
			FROM doctype
			ORDER BY id;
		</cfquery>
        <cfoutput>
        <cfset pageTitle = "Document Type Listing">
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
           <!--- <meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
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
                <p class="lead">Company: #getGsetup.compro#</p>
            </div>
            <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>#UCase("id")#</th>
                        <th>#UCase("document type")#</th>
                    </tr>
                </thead>
                <tbody>
                    <cfloop query="printDocType">
                    <tr>
                        <td>#id#</td>
                        <td>#doctype#</td>
                    </tr>
                    </cfloop>
                </tbody>
            </table>
            </div>
            <div class="panel-footer">
                <p>Printed On: #DateFormat(NOW(),'dd-mm-yyyy')#, #TimeFormat(NOW(),'HH:MM:SS')#</p>
            </div>
		</div>		
		
		</body>
		</html>
        </cfoutput>
	<cfelse>
		<script type="text/javascript">
			window.open('/latest/customization/manpower_i/docMgmt/docType.cfm','_self');
		</script>		
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/latest/customization/manpower_i/docMgmt/docType.cfm','_self');
	</script>
</cfif>
</cfoutput>