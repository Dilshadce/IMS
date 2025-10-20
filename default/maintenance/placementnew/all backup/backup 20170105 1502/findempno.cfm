
<cfoutput>
<cfset nametype = url.type>
<cfset dts1 = replace(dts,'_i','_p','All')>
	<cfquery name="getitemno" datasource="#dts#">
   		select empno as xempno,nric as xnric,name as xname,sex as xsex,iname,paystatus from #dts1#.pmast limit 15
	</cfquery>
    <font style="text-transform:uppercase">#UCASE(nametype)# NO.</font>&nbsp;<input type="text" name="empno1" size="8" id="empno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldempno'),'findempnoajax.cfm?nametype=#nametype#&empno='+document.getElementById('empno1').value+'&nric='+document.getElementById('nric1').value+'&name='+document.getElementById('name1').value);"  />&nbsp;&nbsp;&nbsp;NRIC
    <input type="text" name="nric1" size="8" id="nric1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldempno'),'findempnoajax.cfm?nametype=#nametype#&empno='+document.getElementById('empno1').value+'&nric='+document.getElementById('nric1').value+'&name='+document.getElementById('name1').value);"  />
    &nbsp;&nbsp;&nbsp;Name
    <input type="text" name="name1" size="15" id="name1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldempno'),'findempnoajax.cfm?nametype=#nametype#&empno='+document.getElementById('empno1').value+'&nric='+document.getElementById('nric1').value+'&name='+document.getElementById('name1').value);"  />
    <input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxFieldempno" name="ajaxFieldempno">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(nametype)# NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">EMPLOYEE NAME</font></th>
    <th width="100px"><font style="text-transform:uppercase">NRIC</font></th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    <tr>
    <td>#getitemno.xempno#</td>
    <td>#getitemno.xname#</td>
    <td>#getitemno.xnric#</td>
    <td><a style="cursor:pointer" onClick="document.getElementById('empno').value='#getitemno.xempno#';document.getElementById('nric').value='#getitemno.xnric#';document.getElementById('sex').value='#getitemno.xsex#';document.getElementById('empname').value='#getitemno.xname#';document.getElementById('iname').value='#getitemno.iname#';<cfif getitemno.paystatus neq "A">alert('Emplyee Pay Status is Not Active');</cfif>ColdFusion.Window.hide('findempno');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>