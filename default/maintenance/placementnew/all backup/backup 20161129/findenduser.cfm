
<cfoutput>
<cfset nametype = url.type>

	<cfquery name="getitemno" datasource="#dts#">
   		SELECT * FROM driver limit 15
	</cfquery>
    <font style="text-transform:uppercase">#UCASE(nametype)# NO.</font>&nbsp;<input type="text" name="empno1" size="8" id="empno2" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField3'),'findenduserajax.cfm?nametype=#nametype#&empno='+document.getElementById('empno2').value+'&name='+document.getElementById('name2').value);"  />&nbsp;&nbsp;&nbsp;NAME
    <input type="text" name="name1" size="8" id="name2" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField3'),'findenduserajax.cfm?nametype=#nametype#&empno='+document.getElementById('empno2').value+'&name='+document.getElementById('name2').value);"  />
    <input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField3" name="ajaxField3">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(nametype)# NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">NAME</font></th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    <tr>
    <td>#getitemno.driverno#</td>
    <td>#getitemno.name#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getitemno.driverno#','jobcode');document.getElementById('position').value='#getitemno.name#';ColdFusion.Window.hide('findenduser');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>