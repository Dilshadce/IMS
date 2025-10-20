
<cfset ptype = url.type >

	<cfquery name="getemp" datasource="#replace(dts,'_i','_p')#">
   		select empno as xempno,name from #url.type# 
        WHERE 1=1
        <cfif url.empno neq ''>
            and empno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.empno#%"> 
        </cfif>     
        <cfif url.empname neq ''>
            and name like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.empname#%"> 
        </cfif>  
        <cfif url.leftempname neq ''>
            and name like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.leftempname#%"> 
        </cfif>  
        and empno in (select empno from #dts#.assignmentslip)
        order by name 
        limit 500
	</cfquery>
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(url.nametype)# NO</font></th>
    <th width="400px">NAME</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getemp" >
    
    <tr>
    <td>#getemp.xempno#</td>
    <td>#getemp.name#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist2('#getemp.xempno#','getemp#url.fromto#');document.getElementById('monthtotag').style.visibility='visible';document.getElementById('monthfromtag').style.visibility='visible';ColdFusion.Window.hide('findEmployee');" >SELECT</a></td>
    </tr>
        
    </cfloop>
    
    </table>
    </div>
    </cfoutput>