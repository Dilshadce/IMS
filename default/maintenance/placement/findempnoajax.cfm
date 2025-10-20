<cfset dts1 = replace(dts,'_i','_p','All')>
	<cfquery name="getitemno" datasource="#dts#">
   		select empno as xempno,nric as xnric,name as xname,sex as xsex from #dts1#.pmast WHERE empno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.empno#%"> and nric like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.nric#%"> order by empno limit 500
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
    <cfquery name="getitemno2" datasource="#dts#">
   		select brate as xbrate from #dts1#.paytran WHERE empno='#getitemno.xempno#'
	</cfquery>
    <cfquery name="getitemno3" datasource="#dts#">
   		select date_p as xdate_p from #dts1#.proj_rcd WHERE empno='#getitemno.xempno#'
	</cfquery>
    
    <tr>
    <td>#getitemno.xempno#</td>
    <td>#getitemno.xname#</td>
    <td>#getitemno.xnric#</td>
    <td><a style="cursor:pointer" onClick="document.getElementById('empno').value='#getitemno.xempno#';document.getElementById('nric').value='#getitemno.xnric#';document.getElementById('sex').value='#getitemno.xsex#';document.getElementById('startdate').value='#dateformat(getitemno3.xdate_p,'DD/MM/YYYY')#';document.getElementById('clientrate').value='#getitemno2.xbrate#';document.getElementById('newrate').value='#getitemno2.xbrate#';ColdFusion.Window.hide('findempno');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>