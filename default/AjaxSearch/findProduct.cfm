<cfoutput>

	<cfset nametype = 'product'>
    
    <cfquery name="getProductCode" datasource="#dts#">
        SELECT aitemno AS xaitemno,desp 
        FROM icitem 
        ORDER BY aitemno;
    </cfquery>
    
    PRODUCT CODE&nbsp;
	<input type="text" name="aitemno" id="aitemno" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldProduct'),'/default/AjaxSearch/findProductAjax.cfm?type=#url.type#&nametype=#nametype#&fromto=#url.fromto#&aitemno='+document.getElementById('aitemno').value+'&midDesp='+document.getElementById('midDesp').value+'&leftDesp='+document.getElementById('leftDesp').value);" size="8" />
    
    &nbsp;MID DESP:&nbsp;
    <input type="text" name="midDesp" id="midDesp" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldProduct'),'/default/AjaxSearch/findProductAjax.cfm?type=#url.type#&nametype=#nametype#&fromto=#url.fromto#&aitemno='+document.getElementById('aitemno').value+'&midDesp='+document.getElementById('midDesp').value+'&leftDesp='+document.getElementById('leftDesp').value);" size="8" />
    
    &nbsp;LEFT DESP:&nbsp;
    <input type="text" name="leftDesp" id="leftDesp" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldProduct'),'/default/AjaxSearch/findProductAjax.cfm?type=#url.type#&nametype=#nametype#&fromto=#url.fromto#&aitemno='+document.getElementById('aitemno').value+'&midDesp='+document.getElementById('midDesp').value+'&leftDesp='+document.getElementById('leftDesp').value);" size="8" />
    
    &nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    
    <div id="loading" style="visibility:hidden">
        <div class="loading-indicator">
        Loading....
        </div>
    </div>
    
    <div id="ajaxFieldProduct" name="ajaxFieldProduct">
        <table width="480px">
            <tr>
                <th width="100px">PRODUCT CODE</th>
                <th width="400px">DESP</th>
                <th width="80px">ACTION</th>
            </tr>
            <cfloop query="getProductCode" >
                <tr>
                    <td>#getProductCode.xaitemno#</td>
                    <td>#getProductCode.desp#</td>
                    <td><a onMouseOver="JavaScript:this.style.cursor='pointer';" onClick="selectlist('#getProductCode.xaitemno#','product#url.fromto#');ColdFusion.Window.hide('findProduct');"><u>SELECT</u></a></td>
                </tr>
            </cfloop>
        </table>
    </div>
</cfoutput>