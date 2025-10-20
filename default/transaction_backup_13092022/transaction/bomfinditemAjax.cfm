
	<cfquery name="getitemno" datasource="#dts#">
    	select * from (select itemno,(select desp from icitem where itemno=a.itemno)as desp from billmat as a group by itemno order by itemno limit 500)as a WHERE itemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.itemno#%"> and a.desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%"> and a.desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.leftcustname#%">
    
    
   		<!---select itemno as xitemno,desp from icitem WHERE itemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.itemno#%"> and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%"> and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.leftcustname#%"> order by itemno limit 500--->
	</cfquery>
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(url.nametype)# NO</font></th>
    <th width="300px">DESP</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    
    <tr>
    <td>#getitemno.itemno#</td>
    <td>#getitemno.desp#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getitemno.itemno#','itemno');ColdFusion.Window.hide('finditem');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>