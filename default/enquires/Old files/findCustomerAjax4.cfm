
<cfset ptype = url.type >

	<cfquery name="getcustsupp" datasource="#dts#">
   		select custno as xcustno,name from #url.type# WHERE custno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custno#%"> and name like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%"> and name like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.leftcustname#%"> order by custno limit 500
	</cfquery>
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(url.nametype)# NO</font></th>
    <th width="300px">NAME</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getcustsupp" >
    
    <tr>
    <td>#getcustsupp.xcustno#</td>
    <td>#getcustsupp.name#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist2('#getcustsupp.xcustno#','custno');ColdFusion.Window.hide('findCustomer');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>