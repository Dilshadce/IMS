<cfoutput>
<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">	
        <cftry>
			<cfif form.id EQ "">
                <cfquery name="createDocLink" datasource="#dts#">
                    INSERT INTO doclink (doctype, client, associate, docuuid, expirydate, docowner, email, startdate, monthsbefore, frequency, created_by, created_on)
                    VALUES(
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.docType#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.client#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.associate#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.docUuid#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(form.expiryDate, 'yyyy-mm-dd')#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ownerDetail#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#email#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(form.startDate, 'yyyy-mm-dd')#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#Val(monthsBefore)#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#Val(frequency)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(now(), 'yyyy-mm-dd HH:nn:ss')#">
                    )
                </cfquery>
                
                <cfquery name="getNewID" datasource="#dts#">
                	SELECT id 
                    FROM doclink
                    ORDER BY created_on DESC
                    LIMIT 1 
                </cfquery>
                
                <cfquery name="createDocLinkAT" datasource="#dts#">
                	INSERT INTO doclinkat (doclink_id, doctype, client, associate, docuuid, expirydate, docowner, email, startdate, monthsbefore, frequency, created_by, created_on, remark)
                    VALUES(
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getNewID.id#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.doctype#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.client#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.associate#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.docUuid#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(form.expiryDate, 'yyyy-mm-dd')#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ownerDetail#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(form.startDate, 'yyyy-mm-dd')#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#Val(form.monthsBefore)#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#Val(form.frequency)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(now(), 'yyyy-mm-dd HH:nn:ss')#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="CREATE">
                    )
                </cfquery>
            <cfelse>
            	<cfquery name="updateDocType" datasource="#dts#">
                    UPDATE doclink
                    SET doctype = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.docType#">,
                        client = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.client#">, 
                        associate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.associate#">, 
                        expirydate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(form.expiryDate, 'yyyy-mm-dd')#">, 
                        docowner = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ownerDetail#">, 
                        email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">, 
                        startdate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(form.startDate, 'yyyy-mm-dd')#">, 
                        monthsbefore = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Val(form.monthsBefore)#">, 
                        frequency = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.frequency#">
                    WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.id#">;
				</cfquery>
                
                <cfquery name="createDocLinkAT" datasource="#dts#">
                	INSERT INTO doclinkat (doclink_id, doctype, client, associate, docuuid, expirydate, docowner, email, startdate, monthsbefore, frequency, created_by, created_on, remark)
                    VALUES(
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getNewID.id#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.doctype#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.client#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.associate#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.docUuid#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(form.expiryDate, 'yyyy-mm-dd')#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ownerDetail#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(form.startDate, 'yyyy-mm-dd')#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#Val(form.monthsBefore)#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#Val(form.frequency)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(now(), 'yyyy-mm-dd HH:nn:ss')#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="CREATE">
                    )
                </cfquery>
            </cfif>
        <cfcatch type="any">
            <script type="text/javascript">
                alert('Failed to create new document linkeage!\nError Message: #cfcatch.message#');
                window.open('/latest/customization/manpower_i/docLink/docLinkDetail.cfm?action=create','_self');
            </script>
        </cfcatch>
        </cftry>
		<script type="text/javascript">
			alert('New document linkeage has been created successfully!');
			window.open('/latest/customization/manpower_i/docLink/docLink.cfm','_self');
		</script>
	<cfelseif url.action EQ "update">	
		<cftry>
			<cfquery name="updateDocType" datasource="#dts#">
				UPDATE doclink
                SET doctype = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.docType#">,
                    client = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.client#">, 
                    associate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.associate#">, 
                    expirydate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(form.expiryDate, 'yyyy-mm-dd')#">, 
                    docowner = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ownerDetail#">, 
                    email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">, 
                    startdate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(form.startDate, 'yyyy-mm-dd')#">, 
                    monthsbefore = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Val(form.monthsBefore)#">, 
                    frequency = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.frequency#">, 
                    updated_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">, 
                    updated_on = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateTimeFormat(now(), 'yyyy-mm-dd HH:nn:ss')#">
				WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.id#">;
			</cfquery>
            
            <cfquery name="getOldID" datasource="#dts#">
                SELECT *
                FROM doclink
                WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.id#">;
            </cfquery>
            
            <cfquery name="updateDocLinkAT" datasource="#dts#">
                	INSERT INTO doclinkat (doclink_id, doctype, client, associate, docuuid, expirydate, docowner, email, startdate, monthsbefore, frequency, created_by, created_on, updated_by, updated_on, remark)
                    VALUES(
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.id#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.doctype#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.client#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.associate#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.docUuid#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(form.expiryDate, 'yyyy-mm-dd')#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ownerDetail#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(form.startDate, 'yyyy-mm-dd')#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#Val(form.monthsBefore)#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#Val(form.frequency)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.created_by#">,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(getOldID.created_on, 'yyyy-mm-dd HH:nn:ss')#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(now(), 'yyyy-mm-dd HH:nn:ss')#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="UPDATE">
                    )
                </cfquery>
		<cfcatch type="any">
        	<script type="text/javascript">
                alert('Failed to create new document linkeage!\nError Message: #cfcatch.message#');
                window.open('/latest/customization/manpower_i/docLink/docLinkDetail.cfm?action=update&id=#form.id#','_self');
            </script>
		</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Updated document linkeage successfully!');
			window.open('/latest/customization/manpower_i/docLink/docLink.cfm','_self');
		</script>	
	<cfelseif url.action EQ "delete">
		<cftry>
        	<cfquery name="getOldID" datasource="#dts#">
                SELECT * 
                FROM doclink
                WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
            </cfquery>
			<cfquery name="deleteDocLink" datasource="#dts#">
				DELETE FROM doclink
				WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
			</cfquery>
            <cfquery name="createDocLinkAT" datasource="#dts#">
                INSERT INTO doclinkat (doclink_id, doctype, client, associate, docuuid, expirydate, docowner, email, startdate, monthsbefore, frequency, created_by, created_on, updated_by, updated_on, remark)
                VALUES(
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.id#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.doctype#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.client#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.associate#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.docUuid#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(getOldID.expiryDate, 'yyyy-mm-dd')#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.docOwner#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.email#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(getOldID.startDate, 'yyyy-mm-dd')#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#Val(getOldID.monthsBefore)#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#Val(getOldID.frequency)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.created_by#">,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(getOldID.created_on, 'yyyy-mm-dd HH:nn:ss')#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(now(), 'yyyy-mm-dd HH:nn:ss')#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="DELETE">
                )
            </cfquery>          
        <cfcatch type="any">
            <script type="text/javascript">
                alert('Failed to delete document linkeage!\nError Message: #cfcatch.message#');
                window.open('/latest/customization/manpower_i/docLink/docLink.cfm','_self');
            </script>
        </cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted document linkeage successfully!');
			window.open('/latest/customization/manpower_i/docLink/docLink.cfm','_self');
		</script>
	<cfelse>
		<script type="text/javascript">
			window.open('/latest/customization/manpower_i/docLink/docLink.cfm','_self');
		</script>		
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/latest/customization/manpower_i/docLink/docLink.cfm','_self');
	</script>
</cfif>
</cfoutput>