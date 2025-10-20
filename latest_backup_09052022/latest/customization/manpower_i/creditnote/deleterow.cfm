
<cfif isdefined('form.uuid')>
    
<cfif isdefined('form.deletelist')>
    <cfif form.deletelist neq ''>
        <cfset form.uuid = URLDECODE(form.uuid)>

        <cfquery name="updaterow" datasource="#dts#">
        DELETE FROM ictrantempcn 
        WHERE 
        id in (#URLDECODE(form.deletelist)#)
        and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#">
        </cfquery>

        <cfquery name="getsum" datasource="#dts#">
        SELECT SUM(amt1_bil) as sumsubtotal,count(trancode) as notran,sum(taxamt_bil) as sumtaxtotal FROM ictrantempcn where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#" />
        </cfquery>

        <cfoutput>
        <input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
        <input type="hidden" name="hidtaxtotal" id="hidtaxtotal" value="#numberformat(getsum.sumtaxtotal,'.__')#" />
        <input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.notran#" />
        </cfoutput>
    </cfif>
    
<cfelse>
    <cfif isdefined('form.trancode')>
        <cfset form.uuid = URLDECODE(form.uuid)>
        <cfquery name="updaterow" datasource="#dts#">
        DELETE FROM ictrantempcn 
        WHERE 
        id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.trancode#">
        and uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#">
        </cfquery>


        <cfquery name="getsum" datasource="#dts#">
        SELECT SUM(amt1_bil) as sumsubtotal,count(trancode) as notran,sum(taxamt_bil) as sumtaxtotal FROM ictrantempcn where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.uuid#" />
        </cfquery>

        <cfoutput>
        <input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
        <input type="hidden" name="hidtaxtotal" id="hidtaxtotal" value="#numberformat(getsum.sumtaxtotal,'.__')#" />
        <input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.notran#" />
        </cfoutput>
    </cfif>
    
</cfif>


</cfif>