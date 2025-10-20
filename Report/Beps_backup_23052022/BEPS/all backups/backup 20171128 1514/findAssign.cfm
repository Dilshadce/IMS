
<cfoutput>
<cfset tran = url.type >

	<cfquery name="getassignment" datasource="#dts#">
   		select refno as xrefno,empno as xempno,empname as xempname,placementno as xplacementno,assignmentslipdate from #tran# order by refno desc limit 15
	</cfquery>
    &nbsp;&nbsp;<font style="text-transform:uppercase">Assignmentslip NO.</font>&nbsp;<input type="text" name="refno1" size="8" id="refno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField1'),'findAssignAjax.cfm?type=#url.type#&fromto=#url.fromto#&refno='+document.getElementById('refno1').value+'&empname='+document.getElementById('empname1').value+'&empno='+document.getElementById('empno1').value+'&placementno='+document.getElementById('placementno1').value);" <cfif isdefined('url.custno')>value="#url.custno#"</cfif>  />&nbsp;Employee No:&nbsp;<input type="text" name="empno1" id="empno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField1'),'findAssignAjax.cfm?type=#url.type#&fromto=#url.fromto#&refno='+document.getElementById('refno1').value+'&empname='+document.getElementById('empname1').value+'&empno='+document.getElementById('empno1').value+'&placementno='+document.getElementById('placementno1').value);" size="12" />
    <br>&nbsp;Employee NAME:&nbsp;<input type="text" name="empname1" id="empname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField1'),'findAssignAjax.cfm?type=#url.type#&fromto=#url.fromto#&refno='+document.getElementById('refno1').value+'&empname='+document.getElementById('empname1').value+'&empno='+document.getElementById('empno1').value+'&placementno='+document.getElementById('placementno1').value);" size="12" />
    &nbsp;Placement No:&nbsp;<input type="text" name="placementno1" id="placementno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField1'),'findAssignAjax.cfm?type=#url.type#&fromto=#url.fromto#&refno='+document.getElementById('refno1').value+'&empname='+document.getElementById('empname1').value+'&empno='+document.getElementById('empno1').value+'&placementno='+document.getElementById('placementno1').value);" size="12" />
    &nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField1" name="ajaxField1">
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