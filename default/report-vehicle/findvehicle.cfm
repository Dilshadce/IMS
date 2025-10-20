
<cfoutput>
<cfset nametype = 'vehicle'>

	<cfquery name="getcustsupp" datasource="#dts#">
   		select entryno as xentryno,model,make from vehicles limit 15
	</cfquery>
    <font style="text-transform:uppercase">Vehicle NO.</font>&nbsp;<input type="text" name="itemno1" size="8" id="itemno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findvehicleAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value);" <cfif isdefined('url.custno')>value="#url.custno#"</cfif>  />&nbsp;Make:&nbsp;<input type="text" name="custname1" id="custname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findvehicleAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value);" size="12" />&nbsp;Model:&nbsp;<input type="text" name="custname2" id="custname2" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findvehicleAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value);" size="12" />&nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField" name="ajaxField">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">Vehicle NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">Vehicle Make</font></th>
    <th width="100px"><font style="text-transform:uppercase">Vehicle Model</font></th>
  	<th width="80px">ACTION</th>
    </tr>
    <cfloop query="getcustsupp" >
    <tr>
    <td>#getcustsupp.xentryno#</td>
    <td>#getcustsupp.make#</td>
    <td>#getcustsupp.model#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getcustsupp.xentryno#','#nametype##url.fromto#');ColdFusion.Window.hide('findvehicle');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>