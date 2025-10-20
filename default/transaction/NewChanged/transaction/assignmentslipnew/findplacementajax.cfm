
<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<cfset dts1 = replace(dts,'_i','_p','All')>
	<cfquery name="getitemno" datasource="#dts#">
   		select placementno as xplacementno,empno as xempno,custname as xcustname,custno as xcustno,empno as xempno ,clienttype,startdate,completedate,assignmenttype,iname,supervisor from placement WHERE 
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
    <table width="780px">
    <tr>
    <th width="120px"><font style="text-transform:uppercase">#UCASE(url.nametype)# NO</font></th>
    <th width="200px"><font style="text-transform:uppercase">EMPLOYEE NAME</font></th>
    <th width="3800px"><font style="text-transform:uppercase">CUSTOMER NAME</font></th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    
    <tr  onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    <td>#getitemno.xplacementno#</td>
    <cfquery name="getemployeename" datasource="#dts#">
	SELECT name,paystatus,dbirth
	FROM #dts1#.pmast where empno='#getitemno.xempno#'
	</cfquery>
    <td>#getemployeename.name#</td>
    <td>#getitemno.xcustname#</td>
    <input type=hidden name='xcustname' id='xcustname' value=''>
    <cfquery name="getlastworkingdate" datasource="#dts#">
        select completedate as assignmentslipdate from assignmentslip where empno='#getitemno.xempno#' order by assignmentslipdate desc
    </cfquery>
    <td><a style="cursor:pointer" onClick="<cfif getemployeename.paystatus neq "A">alert('Emplyee Pay Status is Not Active');<cfelseif getemployeename.dbirth eq "" or  getemployeename.dbirth eq "0000-00-00">alert('Emplyee Date Of Birth is Empty');<cfelse>document.getElementById('placementno').value='#getitemno.xplacementno#';document.getElementById('custno').value='#getitemno.xcustno#';document.getElementById('empno').value='#getitemno.xempno#';selectlist('#getitemno.clienttype#','paymenttype');document.getElementById('paymenttype2').value='#getitemno.clienttype#';document.getElementById('lastworkingdate').value='#dateformat(getlastworkingdate.assignmentslipdate,'DD/MM/YYYY')#';document.getElementById('empname').value='#getemployeename.name#';selectlist('#getitemno.assignmenttype#','assignmenttype');document.getElementById('xcustname').value='#URLEncodedFormat(getitemno.xcustname)#';document.getElementById('custname').value=unescape('#URLEncodedFormat(getitemno.xcustname)#');document.getElementById('custname2').value=unescape('#URLEncodedFormat(getitemno.xcustname)#');document.getElementById('iname').value='#getitemno.iname#';document.getElementById('supervisor').value='#getitemno.supervisor#';getpanel('#getitemno.xplacementno#');ColdFusion.Window.hide('findplacement');</cfif>" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>