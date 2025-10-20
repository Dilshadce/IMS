<cfset ptype = url.type >

<cfquery name="getcustformat" datasource="#dts#">
	SELECT custformat 
    FROM dealer_menu;
</cfquery>

	<cfquery name="getcustsupp" datasource="#dts#">
   		SELECT custno as xcustno,name,name2,add1,add2,add3,add4,agent,area 
        FROM #listfirst(url.type)# 
        WHERE custno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.customerNo#%"> 
        AND name like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.customerMidName#%"> 
        AND name like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.customerLeftName#%"> 
        ORDER BY custno 
        LIMIT 500;
	</cfquery>
    

<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(url.nametype)# NO</font></th>
    <th width="400px">NAME</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getcustsupp" >
        <tr>
            <td>#getcustsupp.xcustno#</td>
            <td>#getcustsupp.name#</td>
            <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('custno#listfirst(url.fromto)#').value='#getcustsupp.xcustno#';ColdFusion.Window.hide('findCustomer');" >SELECT</a>
            </td>
        </tr>
    </cfloop>
    
    </table>
</cfoutput>