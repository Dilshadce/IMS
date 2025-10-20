
<cfoutput>
<cfset nametype = url.type>
<cfset dts1 = replace(dts,'_i','_p','All')>
	<cfquery name="getitemno" datasource="#dts#">
   		select empno as xempno,nric as xnric,name as xname,sex as xsex from #dts1#.pmast limit 15
	</cfquery>
    <font style="text-transform:uppercase">#UCASE(nametype)# NO.</font>&nbsp;<input type="text" name="empno1" size="8" id="empno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField2'),'findempnoajax.cfm?nametype=#nametype#&empno='+document.getElementById('empno1').value+'&nric='+document.getElementById('nric1').value);"  />&nbsp;&nbsp;&nbsp;NRIC
    <input type="text" name="nric1" size="8" id="nric1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField2'),'findempnoajax.cfm?nametype=#nametype#&empno='+document.getElementById('empno1').value+'&nric='+document.getElementById('nric1').value);"  />
    <input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField2" name="ajaxField2">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(nametype)# NO</font></th>
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
    <td><a style="cursor:pointer" onClick="document.getElementById('empno').value='#getitemno.xempno#';document.getElementById('nric').value='#getitemno.xnric#';document.getElementById('sex').value='#getitemno.xsex#';document.getElementById('startdate').value='#dateformat(getitemno3.xdate_p,'DD/MM/YYYY')#';document.getElementById('clientrate').value='#getitemno2.xbrate#';document.getElementById('newrate').value='#getitemno2.xbrate#';ColdFusion.Window.hide('findempno');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>