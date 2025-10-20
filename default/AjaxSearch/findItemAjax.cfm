
	<cfquery name="getItemNo" datasource="#dts#">
   		SELECT itemno as xitemno,desp 
        FROM icitem 
        WHERE itemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.itemno#%"> 
        AND desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.itemMidDesp#%"> 
        AND desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemLeftDesp#%"> 
        AND (itemtype <> 'SV' or itemtype is null) 
        ORDER BY itemno 
        LIMIT 500;
	</cfquery>
    
	<cfoutput>  
    <table width="480px">
        <tr>
            <th width="100px">ITEM NO</th>
            <th width="300px">DESP</th>
            <th width="80px">ACTION</th>
        </tr>
        
        <cfloop query="getItemNo" >   
            <tr>
                <td>#getItemNo.xitemno#</td>
                <td>#getItemNo.desp#</td>
                <td><a onMouseOver="JavaScript:this.style.cursor='pointer';" onClick="selectlist('#getItemNo.xitemno#','#url.nametype##url.fromto#');ColdFusion.Window.hide('findItem');" >SELECT</a></td>
            </tr>
        </cfloop>
    
    </table>
    </div>
    </cfoutput>