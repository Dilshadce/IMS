<cfset dts1 = replace(dts,'_i','_p','All')>
	<cfquery name="getitemno" datasource="#dts#">
   		select placementno as xplacementno,custname as xcustname,empname as xempname, custname as xcustname, empname as xempname,empno,custno,startdate,completedate,clienttype from placement WHERE 1=1
        <cfif trim(url.placementno) neq "">
        and placementno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.placementno#%"> 
        </cfif>
        <cfif trim(url.custname) neq "">
        and custname like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%"> 
        </cfif>
        <cfif trim(url.empname) neq "">
        and (empname like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.empname#%"> 
        OR empno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.empname#%">) 
        </cfif>
        order by placementno limit 500
	</cfquery>
    
	<cfoutput>  
    <table width="600px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">PLACEMENT NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">EMPLOYEE NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">EMPLOYEE NAME</font></th>
    <th width="100px"><font style="text-transform:uppercase">CUSTOMER NAME</font></th>
    
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    
    <tr>
    <td>#getitemno.xplacementno#</td>
    <td>#getitemno.empno#</td>
    <td>#getitemno.xempname#</td>
    <td>#getitemno.xcustname#</td>
    
    <td><a style="cursor:pointer" onClick="selectlist('#getitemno.empno#','#url.nametype#');ColdFusion.Window.hide('findplacementno');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>