	<cfquery name="getcustsupp" datasource="#dts#">
   		select entryno as xentryno,model,make from vehicles WHERE entryno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.itemno#%"> and model like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%"> and make like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.leftcustname#%"> order by entryno limit 500
	</cfquery>
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">Vehicle NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">Make</font></th>
    <th width="100px"><font style="text-transform:uppercase">Model</font></th>
   <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getcustsupp" >
    
    <tr>
    <td>#getcustsupp.xentryno#</td>
    <td>#getcustsupp.make#</td>
    <td>#getcustsupp.model#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getcustsupp.xentryno#','#url.nametype##url.fromto#');ColdFusion.Window.hide('findvehicle');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>