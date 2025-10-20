<cfoutput>
<cfset nametype = url.type>

	<cfquery name="getgsetup" datasource="#dts#">
   		select lproject from gsetup
	</cfquery>
    
	<cfquery name="getproject" datasource="#dts#">
   		select source as xsource,project from project where porj='P' limit 100
	</cfquery>
    <font style="text-transform:uppercase"><cfoutput>#getgsetup.lproject#</cfoutput> NO.</font>&nbsp;<input type="text" name="project1" size="20" id="project1" value="" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findprojectajax.cfm?fromto=#url.fromto#&project='+document.getElementById('project1').value+'&custname='+document.getElementById('custname1').value);"/>&nbsp;
    #getgsetup.lproject# Name:&nbsp;<input type="text" name="custname1" id="custname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findprojectajax.cfm?fromto=#url.fromto#&project='+document.getElementById('project1').value+'&custname='+document.getElementById('custname1').value);" size="12" />&nbsp;
    &nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField" name="ajaxField">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(getgsetup.lproject)# NO</font></th>
    <th width="400px">Name</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getproject" >
    <tr>
    <td>#getproject.xsource#</td>
    <td>#getproject.project#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getproject.xsource#','project#url.fromto#');ColdFusion.Window.hide('findproject');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>