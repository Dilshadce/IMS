
<cfoutput>
<cfset nametype = 'Voucher'>

	<cfquery name="getitemno" datasource="#dts#">
   		select voucherno from voucher
	</cfquery>
    <font style="text-transform:uppercase">#UCASE(nametype)# NO.</font>&nbsp;<input type="text" name="voucher1" size="8" id="voucher1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findvoucherAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&voucher='+document.getElementById('voucher1').value);" />&nbsp;
<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField" name="ajaxField">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(nametype)# NO</font></th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    <tr>
    <td>#getitemno.voucherno#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getitemno.voucherno#','voucher#url.fromto#');ColdFusion.Window.hide('findvoucher');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>