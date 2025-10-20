<cfoutput>
<cfsetting showdebugoutput="no">
<cfif isdefined('url.type')>
<cfif type eq "delete">
	<cfquery name="updateempty" datasource="#dts#">
    UPDATE assignmentslip SET batches = "" WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.batchno)#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.refno)#">
    </cfquery>
    
    <cfquery name="deletebatches" datasource="#dts#">
    DELETE FROM assignbatches WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.batchno)#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.refno)#">
    </cfquery>
    
    <cfquery name="checkbatch" datasource="#dts#">
    SELECT batches FROM assignmentslip WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.batchno)#">
    </cfquery>
    
    <cfif checkbatch.recordcount eq 0>
    <cfquery name="deletebatches" datasource="#dts#">
    DELETE FROM assignbatches WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.batchno)#">
    </cfquery>
    	</cfif>
    
    
<cfelse>
    <cfquery name="updatenew" datasource="#dts#">
    UPDATE assignmentslip SET batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.batchno)#"> WHERE (batches = "" or batches is null) and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.refno)#">
    </cfquery>
    
    <cfquery name="insertbatches" datasource="#dts#">
    INSERT INTO assignbatches (batches,refno,created_by,created_on) 
    VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.batchno)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.refno)#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">,
    now()
    )
    </cfquery>
</cfif>
</cfif>
<cfquery name="getbatches" datasource="#dts#">
SELECT * FROM assignmentslip WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.batchno)#"> ORDER BY refno
</cfquery>
<table>
<tr>
<th>No.</th>
<th>Ref No.</th>
<th>Customer</th>
<th>Emp No.</th>
<th>Name</th>
<th>Action</th>
</tr>
<cfloop query="getbatches">
<tr>
<td>#getbatches.currentrow#</td>
<td>#getbatches.refno#</td>
<td>#getbatches.custname#</td>
<td>#getbatches.empno#</td>
<td>#getbatches.empname#</td>
<td><u><a style="cursor:pointer" onclick="confirmdebatch('delete','#getbatches.refno#','#URLDECODE(url.batchno)#')" >Debatch</a></u></td>
</tr>
</cfloop>
</table>
</cfoutput>