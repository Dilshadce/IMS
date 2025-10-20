<cfif isdefined('form.sub_btn')>
<cfif form.sub_btn eq "Create">
    <cfquery name="checkexist" datasource="main">
    SELECT id from automailer WHERE comid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comid#">
    </cfquery>
    <cfif checkexist.recordcount neq 0>
    <cfoutput>
    <script type="text/javascript">
    alert('These company id has been add into list of auto email already');
    history.go(-1);
    </script>
    <cfabort>
    </cfoutput>
    <cfelse>
    <cfquery name="insert" datasource="main">
    Insert Into AutoMailer (comid,emailaddress,created_by,created_on)
    VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comid#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.emailaddress#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">,
    now()
    )
    </cfquery>
    </cfif>
    
<cfelseif form.sub_btn eq "Update">
	<cfquery name="updatelist" datasource="main">
    Update Automailer
    SET
    comid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comid#">,
    emailaddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.emailaddress#">
    WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidid#">
    </cfquery>

<cfelseif form.sub_btn eq "Delete">
	<cfquery name="deletelist" datasource="main">
    Delete From automailer WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hidid#">
    </cfquery>    
</cfif>
<cfoutput>
<script type="text/javascript">
alert('Record #form.sub_btn# Success!');
window.location.href='emaildb.cfm';
</script>
</cfoutput>
</cfif>
