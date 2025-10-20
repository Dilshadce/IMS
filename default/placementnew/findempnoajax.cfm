<cfset dts1 = replace(dts,'_i','_p','All')>
	<cfquery name="getitemno" datasource="#dts#">
   		select empno as xempno,nric as xnric,name as xname,sex as xsex,iname,paystatus from #dts1#.pmast WHERE 1=1
        <cfif trim(url.empno) neq "">
        and empno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.empno#%"> 
        </cfif>
        <cfif trim(url.nric) neq "">
        and nric like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.nric#%"> 
        </cfif>
        <cfif trim(url.name) neq "">
        and name like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.name#%"> 
        </cfif>
        order by empno limit 500
	</cfquery>
    
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(url.nametype)# NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">EMPLOYEE NAME</font></th>
    <th width="100px"><font style="text-transform:uppercase">NRIC</font></th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    
    <tr>
    <td>#getitemno.xempno#</td>
    <td>#getitemno.xname#</td>
    <td>#getitemno.xnric#</td>
    <td><a style="cursor:pointer" onClick="document.getElementById('empno').value='#getitemno.xempno#';document.getElementById('nric').value='#getitemno.xnric#';document.getElementById('sex').value='#getitemno.xsex#';document.getElementById('empname').value='#getitemno.xname#';document.getElementById('iname').value='#getitemno.iname#';<cfif getitemno.paystatus neq "A">alert('Emplyee Pay Status is Not Active');</cfif>ColdFusion.Window.hide('findempno');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>