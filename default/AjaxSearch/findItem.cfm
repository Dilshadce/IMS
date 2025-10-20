<cfoutput>
<cfset nametype = url.type>

<cfquery name="getItemNo" datasource="#dts#">
    SELECT itemno as xitemno,desp 
    FROM icitem 
    WHERE itemtype <> "SV" 
    LIMIT 15;
</cfquery>

    ITEM NO.&nbsp;
    <input type="text" name="itemNo" id="itemNo" size="8"  onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldItem'),'/default/AjaxSearch/findItemAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemNo='+encodeURIComponent(document.getElementById('itemNo').value)+'&itemMidDesp='+document.getElementById('itemMidDesp').value+'&itemLeftDesp='+document.getElementById('itemLeftDesp').value);" <cfif isdefined('url.custno')>value="#url.custno#"</cfif>  />
    
    &nbsp;MID DESP:&nbsp;
   <input type="text" name="itemMidDesp" id="itemMidDesp" size="8"  onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldItem'),'/default/AjaxSearch/findItemAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemNo='+encodeURIComponent(document.getElementById('itemNo').value)+'&itemMidDesp='+document.getElementById('itemMidDesp').value+'&itemLeftDesp='+document.getElementById('itemLeftDesp').value);"/>
    
    &nbsp;LEFT DESP:&nbsp;
    <input type="text" name="itemLeftDesp" id="itemLeftDesp" size="8"  onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldItem'),'/default/AjaxSearch/findItemAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemNo='+encodeURIComponent(document.getElementById('itemNo').value)+'&itemMidDesp='+document.getElementById('itemMidDesp').value+'&itemLeftDesp='+document.getElementById('itemLeftDesp').value);"/>
    
    &nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    
    <div id="loading" style="visibility:hidden">
        <div class="loading-indicator">
       		Loading....
        </div>
    </div>
    
    <div id="ajaxFieldItem" name="ajaxFieldItem">
    	<table width="480px">
            <tr>
                <th width="100px"><font style="text-transform:uppercase">ITEM NO</font></th>
                <th width="400px">DESP</th>
                <th width="80px">ACTION</th>
            </tr>
            <cfloop query="getItemNo" >
                <tr>
                    <td>#getItemNo.xitemno#</td>
                    <td>#getItemNo.desp#</td>
                    <td><a onMouseOver="JavaScript:this.style.cursor='pointer';" onClick="selectlist('#getItemNo.xitemno#','#nametype##url.fromto#');ColdFusion.Window.hide('findItem');"><u>SELECT</u></a></td>
                </tr>
            </cfloop>  
        </table>
    </div>
</cfoutput>