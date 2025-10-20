<cfquery name="getitemno" datasource="#dts#">
    SELECT itemno as xitemno,desp FROM icitem 
    WHERE itemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.itemno#%"> 
    AND desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%"> 
    AND desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.leftcustname#%">
    ORDER BY itemno limit 500
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
    <td>#getitemno.xitemno#</td>
    <td>#getitemno.desp#</td>
    <td>
    <cfif itemtext eq 1>
    <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('productfrom').value='#getitemno.xitemno#';ColdFusion.Window.hide('finditem');" >SELECT</a>
    <cfelse>
    <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist2('#getitemno.xitemno#','#url.nametype##url.fromto#');ColdFusion.Window.hide('finditem');" >SELECT</a>
    </cfif></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>