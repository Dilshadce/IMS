<cfoutput>
<cfquery name="getlist" datasource="#dts#">
SELECT custno,name,phone,add1,add2,add3,add4,add5,contact,phone,phonea,e_mail FROM #target_arcust#
WHERE 1 = 1
<cfif url.contact neq "">
and contact like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.contact)#%"> or name like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.contact)#%"> or add1 like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.contact)#%"> or add2 like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.contact)#%"> or add3 like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.contact)#%">or phone like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.contact)#%">or phonea like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.contact)#%">or e_mail like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.contact)#%">
</cfif>
order by custno
</cfquery>

<table>
<tr>
<th width="100px">Customer No</th>
<th width="150px">Name</th>
<th width="100px">Contact</th>
<th width="100px">Tel</th>
<th width="100px">Hp</th>
<th width="100px">Email</th>
<th width="300px">Address</th>
<th width="100px">Action</th>
</tr>
<cfloop query="getlist">
<tr>
<td>#getlist.custno#</td>
<td>#getlist.name#</td>
<td>#getlist.contact#</td>
<td>#getlist.phone#</td>
<td>#getlist.phonea#</td>
<td>#getlist.e_mail#</td>
<td>
#getlist.add1# #getlist.add2# #getlist.add3# #getlist.add4# #getlist.add5#
</td>
<td align="right">
<a style="cursor:pointer" onClick="ajaxFunction(document.getElementById('searchmemberajax'),'selectmemberajax.cfm?custno=#getlist.custno#');">Select</a>

</td>
</tr>
</cfloop>
<cfif getlist.recordcount eq 0>
<tr><td colspan="100%">No result found! Click <input  type="button" style="background:none;" name="newcustbtn" id="newcustbtn" onclick="ColdFusion.Window.show('createCustomer');" value="here"/> to create new customer</td></tr>
</cfif>
</table>
</cfoutput>