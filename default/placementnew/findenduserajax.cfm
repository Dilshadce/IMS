<cfset dts1 = replace(dts,'_i','_p','All')>
	<cfquery name="getitemno2" datasource="#dts#">
   		SELECT * FROM driver  WHERE driverno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.empno#%"> and name like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.name#%"> order by driverno limit 500
	</cfquery>
    
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(url.nametype)# NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">NAME</font></th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno2" >
    
    <tr>
    <td>#getitemno2.driverno#</td>
    <td>#getitemno2.name#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getitemno2.driverno#','jobcode');document.getElementById('position').value='#getitemno2.name#';ColdFusion.Window.hide('findenduser');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>