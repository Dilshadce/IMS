<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<cfoutput>
<cfset nametype = url.type>
<cfset dts1 = replace(dts,'_i','_p','All')>
	<cfquery name="getitemno" datasource="#dts#">
   		select placementno as xplacementno,empno as xempno,custname as xcustname,custno as xcustno,empno as xempno ,clienttype,startdate,completedate,assignmenttype from placement
        ORDER BY PLACEMENTNO DESC
         limit 15
	</cfquery>
    <font style="text-transform:uppercase">#UCASE(nametype)# NO.</font>&nbsp;<input type="text" name="placementno1" size="8" id="placementno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findplacementAjax.cfm?nametype=#nametype#&placementno='+document.getElementById('placementno1').value+'&empname='+document.getElementById('sempname').value);"  />&nbsp;&nbsp;Employee Name : <input type="text" name="sempname" id="sempname" value="" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findplacementAjax.cfm?nametype=#nametype#&placementno='+document.getElementById('placementno1').value+'&empname='+document.getElementById('sempname').value);" />
    <input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField" name="ajaxField">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(nametype)# NO</font></th>
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
        select completedate as assignmentslipdate from assignmentslip where empno='#getitemno.xempno#' order by assignmentslipdate desc
    </cfquery>
    <td><a style="cursor:pointer" onClick="document.getElementById('placementno').value='#getitemno.xplacementno#';document.getElementById('custno').value='#getitemno.xcustno#';selectlist('#getitemno.clienttype#','paymenttype');document.getElementById('paymenttype2').value='#getitemno.clienttype#';document.getElementById('lastworkingdate').value='#dateformat(getlastworkingdate.assignmentslipdate,'DD/MM/YYYY')#';document.getElementById('empno').value='#getitemno.xempno#';document.getElementById('xcustname').value='#URLEncodedFormat(getitemno.xcustname)#';document.getElementById('custname').value=unescape(document.getElementById('xcustname').value);document.getElementById('empname').value='#getemployeename.name#';ajaxFunction(window.document.getElementById('itemDetail'),'getallowanceAjax.cfm?placementno='+encodeURI(document.getElementById('placementno').value));setTimeout('setallowancerate()',1000);<!--- <cfif getitemno.startdate neq '' and getitemno.startdate neq '0000-00-00'>document.getElementById('startdate').value='#dateformat(getitemno.startdate,'DD/MM/YYYY')#';</cfif><cfif getitemno.completedate neq '' and getitemno.completedate neq '0000-00-00'>document.getElementById('completedate').value='#dateformat(getitemno.completedate,'DD/MM/YYYY')#';</cfif> --->selectlist('#getitemno.assignmenttype#','assignmenttype');ColdFusion.Window.hide('findplacement');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>