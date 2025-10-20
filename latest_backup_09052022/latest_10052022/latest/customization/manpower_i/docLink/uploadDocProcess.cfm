<cfsetting showdebugoutput="no">
<cfoutput>
<cfif IsDefined("url.action")>
	<cfif url.action EQ "upload">	
        <cftry>
        	<cfif form.hidId EQ "">
                <cfquery name="createDocLink" datasource="#dts#">
                    INSERT INTO doclink (doctype, client, associate, docuuid, expirydate, docowner, email, startdate, monthsbefore, frequency, created_by, created_on)
                    VALUES(
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidDocType#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidClient#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidAssociate#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidUuid#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(form.hidExpiryDate, 'yyyy-mm-dd')#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidDocOwner#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidEmail#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(form.hidStartDate, 'yyyy-mm-dd')#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#Val(form.hidMonthsBefore)#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#Val(form.hidFrequency)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(now(), 'yyyy-mm-dd HH:nn:ss')#">
                    )
                </cfquery>
                
                <cfquery name="getId" datasource="#dts#">
                    SELECT id
                    FROM doclink
                    ORDER BY created_on DESC
                    LIMIT 1
                </cfquery>
                
                <cfset form.hidId = getId.id>
            <cfelse>
                <cfquery name="updateDocType" datasource="#dts#">
                    UPDATE doclink
                    SET doctype = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidDocType#">,
                        client = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidClient#">, 
                        associate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidAssociate#">, 
                        expirydate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(form.hidExpiryDate, 'yyyy-mm-dd')#">, 
                        docowner = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidDocOwner#">, 
                        email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidEmail#">, 
                        startdate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateFormat(form.hidStartDate, 'yyyy-mm-dd')#">, 
                        monthsbefore = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Val(form.hidMonthsBefore)#">, 
                        frequency = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidFrequency#">
                        <!---updated_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">, 
                        updated_on = <cfqueryparam cfsqltype="cf_sql_varchar" value="#DateTimeFormat(now(), 'yyyy-mm-dd HH:nn:ss')#">--->
                    WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidId#">;
                </cfquery>
            </cfif>
        
			<cfset thisPath = ExpandPath("/docUpload/#dts#/*.*")>
			<cfset thisDirectory = GetDirectoryFromPath(thisPath)>
			<cfif DirectoryExists(thisDirectory) eq 'NO'>
            	<cfdirectory action="create" directory="#thisDirectory#">
			</cfif>
			
			<cfif IsDefined("form.fileUpload")>
                <cffile action="upload" 
                    filefield="fileUpload" 
                    destination="#thisDirectory#\#form.fileName#" 
                    nameconflict="overwrite" 
                    accept="image/gif,image/jpeg,image/pjpeg,image/png,image/x-png,application/pdf,application/msword,application/msexcel,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
                    
                <cfquery name="uploadDoc" datasource="#dts#">
                    INSERT INTO docupload (uuid, name, desp, path, uploaded_by, uploaded_on)
                    Values (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidUuid#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fileName#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="/docupload/#dts#/#form.fileName#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(now(), 'yyyy-mm-dd HH:nn:ss')#">
                    )
                </cfquery>
                
                <cfquery name="getNewID" datasource="#dts#">
                	SELECT *
                    FROM docupload
                    ORDER BY uploaded_on DESC
                    LIMIT 1
                </cfquery>

				<cfif getNewID.RecordCount EQ 0>
                    <cfset getNewID.id = "">
                </cfif>
                
                <cfquery name="uploadDoc" datasource="#dts#">
                    INSERT INTO docuploadat (docupload_id, uuid, name, desp, path, uploaded_by, uploaded_on, remark)
                    Values (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getNewID.id#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidUuid#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fileName#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="/docupload/#dts#/#form.fileName#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(now(), 'yyyy-mm-dd HH:nn:ss')#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="UPLOAD">
                    )
                </cfquery>
                
                <script type="text/javascript">
                    alert('New document has been uploaded successfully!');
                    window.location.href = "/latest/customization/manpower_i/docLink/docLinkDetail.cfm?action=#form.hidAction#&id=#form.hidId#";
                </script>
            </cfif>	
        <cfcatch type="any">
			<script type="text/javascript">
				alert('Wrong file format. Only \n.GIF .JPEG .PJPEG .PNG .X-PNG \n.PDF .DOC .DOCX .XLS .XLSX\n are allowed')
				window.location.href = "/latest/customization/manpower_i/docLink/docLinkDetail.cfm?action=#form.hidAction#&id=#form.hidId#";
			</script>
        </cfcatch>
        </cftry>
	<cfelseif url.action EQ "delete">
		<cftry>
        	<cfquery name="getOldID" datasource="#dts#">
                SELECT *
                FROM docupload
                WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#"> AND id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
            </cfquery>
			<cfquery name="deleteDocLink" datasource="#dts#">
				DELETE FROM docupload
				WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#"> AND id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
			</cfquery>
            <cfquery name="uploadDoc" datasource="#dts#">
                INSERT INTO docuploadat (docupload_id, uuid, name, desp, path, uploaded_by, uploaded_on, updated_by, updated_on, remark)
                Values (
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.id#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.uuid#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.name#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.desp#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="/docupload/#dts#/#getOldID.name#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getOldID.uploaded_by#">,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(getOldID.uploaded_on, 'yyyy-mm-dd HH:nn:ss')#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#DateTimeFormat(now(), 'yyyy-mm-dd HH:nn:ss')#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="DELETE">
                )
            </cfquery>
        <cfcatch type="any">
            <script type="text/javascript">
                alert('Failed to delete doc linkeage!\nError Message: #cfcatch.message#');
                window.open('/latest/customization/manpower_i/docLink/docLink.cfm','_self');
            </script>
        </cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted doc successfully!');
			window.location.href = "/latest/customization/manpower_i/docLink/docLinkDetail.cfm?action=#url.action2#&id=#url.id2#";
		</script>
	</cfif>
</cfif>
</cfoutput>