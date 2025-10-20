
<cfoutput>
<cfset nametype = url.type>

	<cfquery name="getitemno" datasource="#dts#">
   		SELECT itemno as xitemno,aitemno as xaitemno,desp 
        FROM icitem 
        LIMIT 15;
	</cfquery>
    <font style="text-transform:uppercase">#UCASE(nametype)# NO.</font>&nbsp;<input type="text" name="itemno1" id="itemno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldItem'),'finditemAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemno1='+document.getElementById('itemno1').value+'&itemMid='+document.getElementById('itemMid').value+'&itemLeft='+document.getElementById('itemLeft').value);" size="8" />&nbsp;MID DESP:&nbsp;<input type="text" name="itemMid" id="itemMid" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldItem'),'finditemAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemno1='+document.getElementById('itemno1').value+'&itemMid='+document.getElementById('itemMid').value+'&itemLeft='+document.getElementById('itemLeft').value);" size="12" />&nbsp;LEFT DESP:&nbsp;<input type="text" name="itemLeft" id="itemMid" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldItem'),'finditemAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemno1='+document.getElementById('itemno1').value+'&itemMid='+document.getElementById('itemMid').value+'&itemLeft='+document.getElementById('itemLeft').value);" size="12" />&nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxFieldItem" name="ajaxFieldItem">
    <table width="500px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(nametype)# NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">PRODUCT CODE</font></th>
    <th width="400px">DESP</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    <tr>
    <td>#getitemno.xitemno#</td>
    <td>#getitemno.xaitemno#</td>
    <td>#getitemno.desp#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('#nametype##url.fromto#').value='#getitemno.xitemno#';ColdFusion.Window.hide('finditem');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>