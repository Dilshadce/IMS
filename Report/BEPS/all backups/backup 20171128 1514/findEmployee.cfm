
<cfoutput>
<cfset tran = url.type >
<cfset nametype = "Employee">
    
	<cfquery name="getemp" datasource="#replace(dts,'_i','_p')#">
   		select empno as xempno,name from #tran#
        where empno in (select empno from #dts#.assignmentslip)
        order by name
        limit 15
	</cfquery>
    <font style="text-transform:uppercase">Employee NO.</font>&nbsp;<input type="text" name="empno1" size="8" id="empno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField2'),'findEmployeeAjax.cfm?type=#url.type#&nametype=#nametype#&fromto=#url.fromto#&empno='+document.getElementById('empno1').value+'&empname='+document.getElementById('empname1').value+'&leftempname='+document.getElementById('empname2').value);"  />&nbsp;MID NAME:&nbsp;<input type="text" name="empname1" id="empname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField2'),'findEmployeeAjax.cfm?type=#url.type#&nametype=#nametype#&fromto=#url.fromto#&empno='+document.getElementById('empno1').value+'&empname='+document.getElementById('empname1').value+'&leftempname='+document.getElementById('empname2').value);" size="12" />&nbsp;LEFT NAME:&nbsp;<input type="text" name="empname2" id="empname2" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField2'),'findEmployeeAjax.cfm?type=#url.type#&nametype=#nametype#&fromto=#url.fromto#&empno='+document.getElementById('empno1').value+'&empname='+document.getElementById('empname1').value+'&leftempname='+document.getElementById('empname2').value);" size="12" />
    <br />
    &nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField2" name="ajaxField2">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">Employee NO</font></th>
    <th width="400px">NAME</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getemp" >
    <tr>
    <td>#getemp.xempno#</td>
    <td>#getemp.name#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist2('#getemp.xempno#','getemp#url.fromto#');document.getElementById('monthtotag').style.visibility='visible';document.getElementById('monthfromtag').style.visibility='visible';ColdFusion.Window.hide('findEmployee');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>