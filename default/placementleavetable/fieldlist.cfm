<cfoutput><cfsetting showdebugoutput="no">
<cfif url.type eq "departmentfrom" or url.type eq "departmentto">
<cfquery name="getdepartment" datasource="#dts#">
SELECT department FROM placement WHERE 
custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.custfrom)#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.custto)#">
and department <> ""
 GROUP BY department ORDER BY department
</cfquery>
<select name="#url.type#" id="#url.type#" onChange="<cfif url.type eq 'departmentfrom'>document.getElementById('departmentto').selectedIndex=this.selectedIndex;</cfif>getfield();">
<option value="">Choose a Department</option>
<cfloop query="getdepartment">
<option <cfif url.deptfrom eq  getdepartment.department and url.type eq "departmentfrom">Selected</cfif><cfif url.deptto eq  getdepartment.department and url.type eq "departmentto">Selected</cfif> value="#getdepartment.department#">#getdepartment.department#</option>
</cfloop>
</select>
<cfelseif url.type eq "supervisorfrom" or url.type eq "supervisorto">
<cfquery name="getsupervisor" datasource="#dts#">
SELECT supervisor FROM placement WHERE 
custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.custfrom)#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.custto)#">
and supervisor <> ""
<cfif url.deptfrom neq "" and url.deptto neq "">
and department BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.deptfrom)#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.deptto)#">
</cfif>
GROUP BY supervisor ORDER BY supervisor
</cfquery>
<select name="#url.type#" id="#url.type#" onChange="<cfif url.type eq 'supervisorfrom'>document.getElementById('supervisorto').selectedIndex=this.selectedIndex;</cfif>getfield();">
<option value="">Choose a supervisor</option>
<cfloop query="getsupervisor">
<option <cfif url.suppfrom eq  getsupervisor.supervisor and url.type eq "supervisorfrom">Selected</cfif><cfif url.suppto eq  getsupervisor.supervisor and url.type eq "supervisorto">Selected</cfif>  value="#getsupervisor.supervisor#">#getsupervisor.supervisor#</option>
</cfloop>
</select>
<cfelseif url.type eq "empfrom" or url.type eq "empto">
<cfquery name="getemployee" datasource="#dts#">
SELECT empno,empname FROM placement WHERE 
custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.custfrom)#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.custto)#">
and empno <> ""
<cfif url.deptfrom neq "" and url.deptto neq "">
and department BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.deptfrom)#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.deptto)#">
</cfif>
<cfif url.suppfrom neq "" and url.suppto neq "">
and supervisor BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.suppfrom)#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.suppto)#">
</cfif> 
GROUP BY empno ORDER BY empno
</cfquery>
<select name="#url.type#" id="#url.type#" <cfif url.type eq 'empfrom'>onchange="document.getElementById('supervisorto').selectedIndex=this.selectedIndex;"</cfif>>
<option value="">Choose an Employee</option>
<cfloop query="getemployee">
<option value="#getemployee.empno#">#getemployee.empno# - #getemployee.empname#</option>
</cfloop>
</select>
</cfif>
</cfoutput>