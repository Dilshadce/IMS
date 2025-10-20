<cfoutput>
	<cfquery name="getitem" datasource="#dts#">
   		select itemno,desp from icitem
        <cfif Hitemgroup neq ''>
            where wos_group='#Hitemgroup#'
        </cfif>
	</cfquery>
    <font style="text-transform:uppercase">Search</font>&nbsp;<input type="text" name="itemno1" id="itemno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'/default/transaction/searchitem/searchitemajax.cfm?itemno='+document.getElementById('itemno1').value+'&itemname='+document.getElementById('itemname1').value);"  />&nbsp;&nbsp;&nbsp; IN &nbsp;&nbsp;&nbsp;
    <select name="itemname1" id="itemname1" onchange="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'/default/transaction/searchitem/searchitemajax.cfm?itemno='+document.getElementById('itemno1').value+'&itemname='+document.getElementById('itemname1').value);">
    <option value="all">all</option>
    <option value="itemno">itemno</option>
    <option value="desp">name</option>
    </select>&nbsp;&nbsp;<input type="button" name="gobtn1" value="Go"  />
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
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="JavaScript:selectitem('#URLEncodedFormat(getitem.itemno)#');ColdFusion.Window.hide('searchitem');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>