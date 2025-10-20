
<cfloop list="#form.locationlist#" index="xlocation" delimiters=";">
<cfif evaluate('form.qty_#xlocation#') neq 0>
<cfset locationqty=evaluate('form.qty_#xlocation#')>
<cfset locationbrem=evaluate('form.brem1_#xlocation#')>

<cfquery name="checkexist" datasource="#dts#">
select itemno from multilocupdatetemp
			where type='#form.tran#'
			and refno='#form.refno#'
			and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#"> 
            and trancode = <cfqueryparam cfsqltype="cf_sql_char" value="#form.trancode#"> 
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#xlocation#"> 
            and uuid = <cfqueryparam cfsqltype="cf_sql_char" value="#form.uuid#"> 
</cfquery>
<cfif checkexist.recordcount eq 0>

            <cfquery name="insert" datasource="#dts#">
            insert into multilocupdatetemp (uuid,type,refno,itemno,trancode,location,qty,brem1) values 
            (<cfqueryparam cfsqltype="cf_sql_char" value="#form.uuid#">,
            <cfqueryparam cfsqltype="cf_sql_char" value="#form.tran#">,
            <cfqueryparam cfsqltype="cf_sql_char" value="#form.refno#">,
            <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#">,
            <cfqueryparam cfsqltype="cf_sql_char" value="#form.trancode#">,
            <cfqueryparam cfsqltype="cf_sql_char" value="#xlocation#">,
            <cfqueryparam cfsqltype="cf_sql_char" value="#locationqty#">,
            <cfqueryparam cfsqltype="cf_sql_char" value="#locationbrem#">
            )
			</cfquery>
<cfelse>
			<cfquery name="checkexist" datasource="#dts#">
			update multilocupdatetemp set qty=<cfqueryparam cfsqltype="cf_sql_char" value="#locationqty#">,
            brem1= <cfqueryparam cfsqltype="cf_sql_char" value="#locationbrem#">
			where type='#form.tran#'
			and refno='form.#refno#'
			and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#form.itemno#"> 
            and trancode = <cfqueryparam cfsqltype="cf_sql_char" value="#form.trancode#"> 
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#xlocation#"> 
            and uuid = <cfqueryparam cfsqltype="cf_sql_char" value="#form.uuid#"> 
			</cfquery>
</cfif>
</cfif>
</cfloop>

<script type="text/javascript">
<cfoutput>
opener.document.getElementById('fulfill_#form.tran#_#form.refno#_#form.trancode#').value = '#form.totqty#';
</cfoutput>
window.close()
</script>