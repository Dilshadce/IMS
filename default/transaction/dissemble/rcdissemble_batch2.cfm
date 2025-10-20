<cfif sodate neq ''>
<cfset ndate1 = createdate(right(form.sodate,4),mid(form.sodate,4,2),left(form.sodate,2))>
<cfset sodate = dateformat(ndate1,'yyyy-mm-dd')>
<cfelse>
<cfset sodate = '0000-00-00'>
</cfif>
<cfif dodate neq ''>
<cfset ndate2 = createdate(right(form.dodate,4),mid(form.dodate,4,2),left(form.dodate,2))>
<cfset dodate = dateformat(ndate2,'yyyy-mm-dd')>
<cfelse>
<cfset dodate = '0000-00-00'>
</cfif>
<cfif expdate neq ''>
<cfset ndate3 = createdate(right(form.expdate,4),mid(form.expdate,4,2),left(form.expdate,2))>
<cfset expdate = dateformat(ndate3,'yyyy-mm-dd')>
<cfelse>
<cfset expdate = '0000-00-00'>
</cfif>






<cfquery name="getbatchname" datasource="#dts#">
update receivetemp set 
batchcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.enterbatch#">,
defective=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.defective#">,
mc1_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.mc1bil)#">,
mc2_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.mc2bil)#">,
sodate=<cfqueryparam cfsqltype="cf_sql_varchar" value="#sodate#">,
dodate=<cfqueryparam cfsqltype="cf_sql_varchar" value="#dodate#">,
expdate=<cfqueryparam cfsqltype="cf_sql_varchar" value="#expdate#">,
milcert=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.milcert#">,
pallet="#val(form.pallet)#",
importpermit="#val(form.importpermit)#"

where 
uuid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rcdissembleuuid#"> 
and trancode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rcdissembletrancode#">

</cfquery>

<script type="text/javascript">
ColdFusion.Window.hide('rcbatch');
</script>