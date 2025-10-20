<cfoutput>
	<cfquery name="getitem" datasource="#dts#">
   		select itemno,desp from icitem
        <cfif Hitemgroup neq ''>
            where wos_group='#Hitemgroup#'
        </cfif>
	</cfquery>
    <font style="text-transform:uppercase">ITEM NO.</font>&nbsp;<input type="text" name="itemno1" id="itemno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'/default/transaction/searchitem/searchitem2ajax.cfm?itemno='+document.getElementById('itemno1').value+'&itemname='+document.getElementById('itemname1').value);"  />&nbsp;&nbsp;NAME:&nbsp;<input type="text" name="itemname1" id="itemname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'/default/transaction/searchitem/searchitem2ajax.cfm?itemno='+document.getElementById('itemno1').value+'&itemname='+document.getElementById('itemname1').value);" />&nbsp;&nbsp;<input type="button" name="gobtn1" value="Go"  />
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxFielditm" name="ajaxFielditm">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">ITEM NO</font></th>
    <th width="300px">NAME</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitem" >
    <tr>
    <td>#getitem.itemno#</td>
    <td>#getitem.desp#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="JavaScript:document.getElementById('itm6').value='#(getitem.itemno)#';ColdFusion.Window.hide('searchitem');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>