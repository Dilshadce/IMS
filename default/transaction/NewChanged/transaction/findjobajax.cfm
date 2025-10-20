 	<cfquery name="getgsetup" datasource="#dts#">
   		select ljob from gsetup
	</cfquery>
    
    <cfquery name="getproject" datasource="#dts#">
   		select source as xsource,project FROM #target_project# where porj='J' and source like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.project#%"> and project like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%">  order by source limit 500
	</cfquery>



	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(getgsetup.ljob)# NO</font></th>
    <th width="300px">NAME</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getproject" >
    
    <tr>
    <td>#getproject.xsource#</td>
    <td>#getproject.project#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getproject.xsource#','Job');ColdFusion.Window.hide('findjob');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>