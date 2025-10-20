
<cfoutput>
<cfset nametype = url.type>

	<cfquery name="getitemno" datasource="#dts#">
   		select placementno as xplacementno, custname as xcustname, empname as xempname,empno,custno,startdate,completedate from assignmentslip limit 15
	</cfquery>
    
    <font style="text-transform:uppercase">PLACEMENT NO23.</font>&nbsp;<input type="text" name="placementno1" size="8" id="placementno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findplacementnoajaxnew.cfm?nametype=#nametype#&placementno='+document.getElementById('placementno1').value+'&custname='+document.getElementById('custname1').value+'&empname='+document.getElementById('empname1').value);"  />
    &nbsp;&nbsp;&nbsp;EMPLOYEE NAME/NO 
    <input type="text" name="empname1" size="8" id="empname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findplacementnoajaxnew.cfm?nametype=#nametype#&placementno='+document.getElementById('placementno1').value+'&custname='+document.getElementById('custname1').value+'&empname='+document.getElementById('empname1').value);" />
    
    &nbsp;&nbsp;&nbsp;CUSTOMER NAME
    <input type="text" name="custname1" size="8" id="custname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findplacementnoajaxnew.cfm?nametype=#nametype#&placementno='+document.getElementById('placementno1').value+'&custname='+document.getElementById('custname1').value+'&empname='+document.getElementById('empname1').value);" />
    
    <input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField" name="ajaxField">

    <table width="600px">
    <tr> 123
    <th width="100px"><font style="text-transform:uppercase">PLACEMENT NO 1</font></th>
    <th width="100px"><font style="text-transform:uppercase">EMPLOYEE NO  2</font></th>
    <th width="100px"><font style="text-transform:uppercase">EMPLOYEE NAME</font></th>
    <th width="100px"><font style="text-transform:uppercase">CUSTOMER NAME</font></th>
    
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno">
    <tr>
    <td>#getitemno.xplacementno#</td>
    <td>#getitemno.empno#</td>
    <td>#getitemno.xempname#</td>
    <td>#getitemno.xcustname#</td>
    
    <td><a style="cursor:pointer" onClick="selectlist('#getitemno.empno#','#nametype#');<cfif url.type eq "empfrom">selectlist('#getitemno.empno#','empto');</cfif>ColdFusion.Window.hide('findplacementno');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>    
    </table>
    </div>
    </cfoutput>
	