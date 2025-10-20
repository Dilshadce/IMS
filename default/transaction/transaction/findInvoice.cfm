<cfoutput>
<table>
<tr>
<th>Inv No:</th>
<td><input type="text" name="invno" id="invno" value="" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findInvoiceAjax.cfm?custno='+escape(document.getElementById('custnonew').value)+'&refno='+escape(document.getElementById('invno').value));" /></td>
<td></td>
<th>Cust No:</th>
<td>
<input type="text" name="custnonew" id="custnonew" value="" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findInvoiceAjax.cfm?custno='+escape(document.getElementById('custnonew').value)+'&refno='+escape(document.getElementById('invno').value));"/>
</td>
<td>&nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" ></td>
</tr>
</table>
 <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <cfquery name="getbill" datasource="#dts#">
    SELECT refno,custno,name FROM artran where type = "INV" limit 15
    </cfquery>
    
    <div id="ajaxField" name="ajaxField">
    <table>
    <tr><th width="100">Invoice No</th><th width="100">Cust No</th><th width="200">Cust Name</th><th width="100">Action</th></tr>
    <cfloop query="getbill">
    <tr><td>#getbill.refno#</td><td>#getbill.custno#</td><td>#getbill.name#</td><td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getbill.refno#');ColdFusion.Window.hide('findInvoice');"><u>SELECT</u></a></td></tr>
    </cfloop>
    </table>
    </div>
    </cfoutput>