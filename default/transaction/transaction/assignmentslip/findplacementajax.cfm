
<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<cfset dts1 = replace(dts,'_i','_p','All')>
	<cfquery name="getitemno" datasource="#dts#">
   		select placementno as xplacementno,empno as xempno,custname as xcustname,custno as xcustno,empno as xempno ,clienttype,startdate,completedate,assignmenttype from placement WHERE 
        1=1
        <cfif url.placementno neq "">
        and placementno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.placementno#%">
        </cfif>
        <cfif isdefined('url.empname')>
		  <cfif url.empname neq "">
          and empno in (select empno FROM #dts1#.pmast WHERE name like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.empname#%">)
		  </cfif>
		</cfif>
         order by placementno DESC limit 100
	</cfquery>
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(url.nametype)# NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">EMPLOYEE NAME</font></th>
    <th width="100px"><font style="text-transform:uppercase">CUSTOMER NAME</font></th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    
    <tr>
    <td>#getitemno.xplacementno#</td>
    <cfquery name="getemployeename" datasource="#dts#">
	SELECT name
	FROM #dts1#.pmast where empno='#getitemno.xempno#'
	</cfquery>
    <td>#getemployeename.name#</td>
    <td>#getitemno.xcustname#</td>
    <input type=hidden name='xcustname' id='xcustname' value=''>
    <cfquery name="getlastworkingdate" datasource="#dts#">
        select assignmentslipdate from assignmentslip where empno='#getitemno.xempno#' order by assignmentslipdate desc
    </cfquery>
    <td><a style="cursor:pointer" onClick="document.getElementById('placementno').value='#getitemno.xplacementno#';document.getElementById('custno').value='#getitemno.xcustno#';document.getElementById('empno').value='#getitemno.xempno#';selectlist('#getitemno.clienttype#','paymenttype');document.getElementById('paymenttype2').value='#getitemno.clienttype#';document.getElementById('lastworkingdate').value='#dateformat(getlastworkingdate.assignmentslipdate,'DD/MM/YYYY')#';document.getElementById('empname').value='#getemployeename.name#';ajaxFunction(window.document.getElementById('itemDetail'),'getallowanceAjax.cfm?placementno='+encodeURI(document.getElementById('placementno').value));document.getElementById('xcustname').value='#URLEncodedFormat(getitemno.xcustname)#';document.getElementById('custname').value=unescape(document.getElementById('xcustname').value);setTimeout('setallowancerate()',1000);<!--- <cfif getitemno.startdate neq '' and getitemno.startdate neq '0000-00-00'>document.getElementById('startdate').value='#dateformat(getitemno.startdate,'DD/MM/YYYY')#';</cfif><cfif getitemno.completedate neq '' and getitemno.completedate neq '0000-00-00'>document.getElementById('completedate').value='#dateformat(getitemno.completedate,'DD/MM/YYYY')#';</cfif> --->selectlist('#getitemno.assignmenttype#','assignmenttype');ColdFusion.Window.hide('findplacement');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>