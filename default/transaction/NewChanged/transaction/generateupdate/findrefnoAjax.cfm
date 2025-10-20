<cfif isdate(url.date)>
<cftry>
<cfset xdate=createdate(right(url.date,4),mid(url.date,4,2),left(url.date,2))>
<cfcatch>
<cfset xdate=url.date>
</cfcatch>
</cftry>
<cfelse>
<cfset xdate=url.date>
</cfif>
	<cfquery name="getrefno2" datasource="#dts#">
   		SELECT * FROM artran WHERE refno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.refno#%"> 
        AND custno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%"> 
        AND name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.leftcustname#%"> 
        AND refno2 LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.refno2#%">
        AND fperiod LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.period#%">
        AND wos_date LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#dateformat(xdate,'yyyy-mm-dd')#%"> 
        AND type='RC' 
        ORDER BY refno LIMIT 50
	</cfquery>
    
	<cfoutput>  
    <table width="950px">
    <tr>
    	<th width="100px">REF NO</th>
        <th width="100px">REF NO.2</th>
        <th width="400px">CUSTOMER</th>
        <th width="100px">PERIOD</th>
        <th width="65px">DATE</th>
        <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getrefno2" >
    
    <tr>
        <td>#getrefno2.refno#</td>
        <td>#getrefno2.refno2#</td>
        <td>#getrefno2.custno# - #getrefno2.name#</td>
        <td>#getrefno2.fperiod#</td>
        <td>#dateformat(getrefno2.wos_date,"dd/mm/yyyy")#</td>
        <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('enterref#fromto#').value='#getrefno2.refno#';ColdFusion.Window.hide('findrefno');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>