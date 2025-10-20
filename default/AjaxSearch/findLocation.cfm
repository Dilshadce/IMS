<cfoutput>
<cfset nametype = url.type>

<cfquery name="getLocation" datasource="#dts#">
    SELECT * 
    FROM iclocation
    LIMIT 15;
</cfquery>
    
<font style="text-transform:uppercase">LOCATION</font>&nbsp;
<input type="text" name="location" id="location" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldLocation'),'findLocationAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&location='+document.getElementById('location').value+'&desp1='+document.getElementById('desp1').value+'&desp2='+document.getElementById('desp2').value);" size="8" />&nbsp;MID DESP:&nbsp;
<input type="text" name="desp1" id="desp1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldLocation'),'findLocationAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&location='+document.getElementById('location').value+'&desp1='+document.getElementById('desp1').value+'&desp2='+document.getElementById('desp2').value);" size="12" />&nbsp;LEFT DESP:&nbsp;
<input type="text" name="desp2" id="desp2" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldLocation'),'findLocationAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&location='+document.getElementById('location').value+'&desp1='+document.getElementById('desp1').value+'&desp2='+document.getElementById('desp2').value);" size="12" />&nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxFieldLocation" name="ajaxFieldLocation">
    <table width="480px">
    <tr>
        <th width="100px"><font style="text-transform:uppercase">LOCATION</font></th>
        <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getLocation" >
    <tr>
        <td>#getLocation.location#</td>
        <td><a onMouseOver="JavaScript:this.style.cursor='pointer';" onClick="document.getElementById('loc#url.fromto#').value='#getLocation.location#';ColdFusion.Window.hide('findLocation');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>