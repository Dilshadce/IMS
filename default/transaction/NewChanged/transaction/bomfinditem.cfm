
<cfoutput>
<cfset nametype = 'Item'>

	<cfquery name="getitemno" datasource="#dts#">
   		select itemno,(select desp from icitem where itemno=a.itemno)as desp from billmat as a group by itemno order by itemno limit 15
        
        <!---select itemno as xitemno,desp from icitem limit 15--->
	</cfquery>
    <font style="text-transform:uppercase">#UCASE(nametype)# NO.</font>&nbsp;<input type="text" name="itemno1" size="8" id="itemno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'bomfinditemAjax.cfm?nametype=#nametype#&itemno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value);" <cfif isdefined('url.custno')>value="#url.custno#"</cfif>  />&nbsp;MID DESP:&nbsp;<input type="text" name="custname1" id="custname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'bomfinditemAjax.cfm?nametype=#nametype#&itemno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value);" size="12" />&nbsp;LEFT DESP:&nbsp;<input type="text" name="custname2" id="custname2" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'bomfinditemAjax.cfm?nametype=#nametype#&itemno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value);" size="12" />&nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField" name="ajaxField">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(nametype)# NO</font></th>
    <th width="400px">DESP</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    <tr>
    <td>#getitemno.itemno#</td>
    <td>#getitemno.desp#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getitemno.itemno#','itemno');ColdFusion.Window.hide('finditem');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>