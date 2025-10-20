
<cfquery name="getLocation" datasource="#dts#">
	SELECT * 
    FROM iclocation
    WHERE location LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.location#%"> 
    AND location LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.desp1#%"> 
    AND location LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.desp2#%">
    ORDER BY location 
    LIMIT 200;
</cfquery>

	<cfoutput>  
    <table width="480px">
        <tr>	
            <th width="100px"><font style="text-transform:uppercase">Location</font></th>
            <th width="80px">ACTION</th>
        </tr>
        
        <cfloop query="getLocation" >
        <tr>
            <td>#getLocation.location#</td>
            <td><a onMouseOver="JavaScript:this.style.cursor='pointer';" onClick="document.getElementById('loc#url.fromto#').value='#getLocation.location#';ColdFusion.Window.hide('findLocation');" >SELECT</a></td>
        </tr>
        </cfloop>
        
     </table>
     </div>
    </cfoutput>