
	<cfquery name="getitemno" datasource="#dts#">
   		SELECT itemno as xitemno,aitemno as xaitemno,desp 
        FROM icitem 
        WHERE itemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.itemno1#%"> 
        AND desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.itemMid#%"> 
        AND desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemLeft#%">
        ORDER BY itemno 
        LIMIT 500;
	</cfquery>
	<cfoutput>  
    <table width="500px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">PRODUCT NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">PRODUCT CODE</font></th>
    <th width="300px">DESP</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    
    <tr>
    <td>#getitemno.xitemno#</td>
    <td>#getitemno.xaitemno#</td>
    <td>#getitemno.desp#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('#nametype##url.fromto#').value='#getitemno.xitemno#';ColdFusion.Window.hide('finditem');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>