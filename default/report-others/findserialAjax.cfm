	<cfquery name="getitemno" datasource="#dts#">
   		SELECT * 
        FROM iserial  
        WHERE serialno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.serialNo#%"> 
        GROUP BY serialno 
        ORDER BY serialno 
        LIMIT 500;
	</cfquery>
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">SERIAL NO</font></th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >    
    <tr>
    <td>#getitemno.serialno#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('serial#url.fromto#').value='#getitemno.serialno#';ColdFusion.Window.hide('findserial');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>