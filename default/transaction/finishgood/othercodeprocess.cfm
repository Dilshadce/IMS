<cfsetting  showdebugoutput="no">
<cfif url.type eq "ADD">
<cfquery name="insertrow" datasource="#dts#">
INSERT INTO tempfgic
(itemno,qty,created_by,created_on,uuid,siid)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(url.qty)#">,
"#huserid#",
now(),
<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.otheruuid#">,
"#id#"
)
</cfquery>
<cfelseif url.type eq "Delete">
<cfquery name="deleterow" datasource="#dts#">
DELETE FROM tempfgic WHERE id = "#url.icid#"
</cfquery>

</cfif>
<cfquery name="getlist" datasource="#dts#">
SELECT * FROM tempfgic WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.otheruuid#"> ORDER BY Itemno
</cfquery>

<cfoutput>
<table >
<tr>
<th width="40px">No</th>
<th width="400px">Itemno</th>
<th width="80px">Qty</th>
<th width="100px">Action</th>
</tr>
<cfloop query="getlist">
<tr>
<td>#getlist.currentrow#</td>
<td>#getlist.itemno#</td>
<td>#getlist.qty#</td>
<td><a onclick="if(confirm('Are You Sure You Want To Delete')){ajaxFunction(document.getElementById('othercodefield'),'othercodeprocess.cfm?type=delete&icid=#getlist.id#&otheruuid=#url.otheruuid#')}" style="cursor:pointer">Delete</a></td>
</tr>
</cfloop>
<tr>
<td align="center" colspan="4"><input type="submit" name="sub_btn" value="Process" /></td>
</tr>
</table>
</cfoutput>
