<cfquery name="getProductCode" datasource="#dts#">
    SELECT aitemno AS xaitemno,desp 
    FROM icitem 
    WHERE aitemno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.aitemno#%"> 
    AND desp LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.midDesp#%"> 
    AND desp LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.leftDesp#%"> 
    ORDER BY aitemno 
    LIMIT 500;
</cfquery>

<cfoutput>  
    <table width="480px">
        <tr>
            <th width="100px">PRODUCT CODE</th>
            <th width="300px">DESP</th>
            <th width="80px">ACTION</th>
        </tr>
        <cfloop query="getProductCode" >
            <tr>
                <td>#getProductCode.xaitemno#</td>
                <td>#getProductCode.desp#</td>
                <td><a onMouseOver="JavaScript:this.style.cursor='pointer';" onClick="selectlist('#getProductCode.xaitemno#','product#url.fromto#');ColdFusion.Window.hide('findProduct');" >SELECT</a>
                </td>
            </tr>
        </cfloop>
    
    </table>
</cfoutput>