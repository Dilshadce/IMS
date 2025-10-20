
<cfoutput>
<cfset nametype = url.type>

	<cfquery name="getitemno" datasource="#dts#">
   		select itemno as xitemno,desp from icitem where itemtype <> "SV" limit 15
	</cfquery>
    <font style="text-transform:uppercase">#UCASE(nametype)# NO.</font>&nbsp;<input type="text" name="itemno1" size="8" id="itemno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditem'),'finditemAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemno='+encodeURIComponent(document.getElementById('itemno1').value)+'&custname='+document.getElementById('itemname1').value+'&leftcustname='+document.getElementById('itemname2').value);" <cfif isdefined('url.custno')>value="#url.custno#"</cfif>  />&nbsp;MID DESP:&nbsp;<input type="text" name="itemname1" id="itemname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditem'),'finditemAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemno='+encodeURIComponent(document.getElementById('itemno1').value)+'&custname='+document.getElementById('itemname1').value+'&leftcustname='+document.getElementById('itemname2').value);" size="12" />&nbsp;LEFT DESP:&nbsp;<input type="text" name="itemname2" id="itemname2" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditem'),'finditemAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemno='+encodeURIComponent(document.getElementById('itemno1').value)+'&custname='+document.getElementById('itemname1').value+'&leftcustname='+document.getElementById('itemname2').value);" size="12" />&nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxFielditem" name="ajaxFielditem">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">ITEM NO</font></th>
    <th width="400px">DESP</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    <tr>
    <td>#getitemno.xitemno#</td>
    <td>#getitemno.desp#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getitemno.xitemno#','#nametype##url.fromto#');ColdFusion.Window.hide('finditem');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>