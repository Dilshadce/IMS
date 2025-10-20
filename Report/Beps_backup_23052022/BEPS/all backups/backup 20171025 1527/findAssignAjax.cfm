
<cfset ptype = url.type >

	<cfquery name="getassignment" datasource="#dts#">
   		select refno as xrefno,empno as xempno,empname as xempname,placementno as xplacementno,assignmentslipdate from #url.type# 
        WHERE 1=1
        <cfif url.refno neq ''>
            and refno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.refno#%"> 
        </cfif>
        <cfif url.empname neq ''>
            and empname like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.empname#%"> 
        </cfif>
        <cfif url.empno neq ''>
            and empno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.empno#%"> 
        </cfif>
        <cfif url.empno neq ''>
            and placementno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.placementno#%">
        </cfif>
        order by refno desc limit 500
	</cfquery>
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">Assignmentslip NO</font></th>
    <th width="400px">Placement No</th>
    <th width="400px">Empno</th>
    <th width="400px">NAME</th>
    <th width="400px">Date</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getassignment" >
    <tr>
    <td>#getassignment.xrefno#</td>
    <td>#getassignment.xplacementno#</td>
    <td>#getassignment.xempno#</td>
    <td>#getassignment.xempname#</td>
    <td>#dateformat(getassignment.assignmentslipdate,'YYYY-MM-DD')#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist2('#getassignment.xrefno#','bill#url.fromto#');ColdFusion.Window.hide('findAssign');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>