 <cfquery name="getlocation" datasource="#dts#">
   		select location as xlocation,desp from iclocation WHERE location like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.location#%"> and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%"> and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.leftcustname#%"> order by location limit 500
	</cfquery>



	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(url.nametype)# NO</font></th>
    <th width="300px">DESP</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getlocation" >
    
    <tr>
    <td>#getlocation.xlocation#</td>
    <td>#getlocation.desp#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getlocation.xlocation#','loc6');ColdFusion.Window.hide('findlocation');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>