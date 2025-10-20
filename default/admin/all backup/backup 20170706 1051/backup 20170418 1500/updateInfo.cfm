
<cfset value = "">
<cfset tabchr = Chr(13) & Chr(10)> 

<cfquery name="getpreviousdata" datasource="#dts#">
    select #url.fieldname# as changefield from refnoset
    where type = '#url.type#'
    and counter = '#url.counter#'
</cfquery>

<cfquery name="insertaudittrait" datasource="#dts#">
    insert into refnoset_audittrait(edittype,editfield,beforeedit,afteredit,edited_by,edited_on,counter) values
   	('#url.type#','#url.fieldname#','#getpreviousdata.changefield#','#fieldvalue#','#huserid#',now(),'#url.counter#')
</cfquery>

<cfquery name="update" datasource="#dts#">
    update refnoset 
    set #url.fieldname# = UPPER('#fieldvalue#')
    where type = '#url.type#'
    and counter = '#url.counter#'
</cfquery>




<!---
<script>
	window.close();
	window.opener.location="/default/admin/LastUsedNo.cfm";
</script>--->
	