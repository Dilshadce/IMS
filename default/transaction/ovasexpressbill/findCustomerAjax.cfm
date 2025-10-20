
<cfset ptype = url.type >

	<cfquery name="getcustsupp" datasource="#dts#">
   		select custno as xcustno,name from #url.dbtype# WHERE custno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custno#%"> and name like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%"> and name like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.leftcustname#%"> order by custno limit 500
	</cfquery>
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#url.type# NO</font></th>
    <th width="300px">NAME</th>
    <cfif lcase(hcomid) neq "acht_i"><th width="80px">ACTION</th></cfif>
    </tr>
    <cfloop query="getcustsupp" >
    
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';" <cfif lcase(hcomid) eq "acht_i">onClick="document.getElementById('custno').value = '#getcustsupp.xcustno#';updateDetails('#getcustsupp.xcustno#');ColdFusion.Window.hide('findCustomer');"</cfif>>
    <td>#getcustsupp.xcustno#</td>
    <td>#getcustsupp.name#</td>
    <cfif lcase(hcomid) neq "acht_i">
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('custno').value = '#getcustsupp.xcustno#';updateDetails('#getcustsupp.xcustno#');ColdFusion.Window.hide('findCustomer');" >SELECT</a></td></cfif>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>