<cfoutput>
  <cfset ptype = url.type >
  <cfquery name="getcustsupp" datasource="#dts#">
   		SELECT * FROM artran
        WHERE type='#ptype#' LIMIT 15
	</cfquery>
  <table>
    <tr>
      <td>REF NO:<input type="text" name="custno1" id="custno1"  onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findRefnoAjax.cfm?type=#url.type#&custno='+document.getElementById('custno1').value+'&custname='+document.getElementById('custname1').value+'&vehino='+document.getElementById('vehino').value+'&invoiceDate='+document.getElementById('invoiceDate').value+'&endContractDate='+document.getElementById('endContractDate').value);" /></td>
      <td>INV DATE:<input type="text" name="invoiceDate" id="invoiceDate"  onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findRefnoAjax.cfm?type=#url.type#&custno='+document.getElementById('custno1').value+'&custname='+document.getElementById('custname1').value+'&vehino='+document.getElementById('vehino').value+'&invoiceDate='+document.getElementById('invoiceDate').value+'&endContractDate='+document.getElementById('endContractDate').value);"/></td>
      <td>VEHICLE:<input type="text" name="vehino" id="vehino" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findRefnoAjax.cfm?type=#url.type#&custno='+document.getElementById('custno1').value+'&custname='+document.getElementById('custname1').value+'&vehino='+document.getElementById('vehino').value+'&invoiceDate='+document.getElementById('invoiceDate').value+'&endContractDate='+document.getElementById('endContractDate').value);" /></td>
    </tr>
    <tr>
      <td>CUSTOMER:<input type="text" name="custname1" id="custname1"  onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findRefnoAjax.cfm?type=#url.type#&custno='+document.getElementById('custno1').value+'&custname='+document.getElementById('custname1').value+'&vehino='+document.getElementById('vehino').value+'&invoiceDate='+document.getElementById('invoiceDate').value+'&endContractDate='+document.getElementById('endContractDate').value);" /></td>
      <td nowrap="nowrap">END CONTRACT DATE:<input type="text" name="endContractDate" id="endContractDate" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findRefnoAjax.cfm?type=#url.type#&custno='+document.getElementById('custno1').value+'&custname='+document.getElementById('custname1').value+'&vehino='+document.getElementById('vehino').value+'&invoiceDate='+document.getElementById('invoiceDate').value+'&endContractDate='+document.getElementById('endContractDate').value);" /></td>
      <td><input type="button" name="Searchbtn" value="Go"></td>
    </tr>
  </table>
  <div id="loading" style="visibility:hidden">
    <div class="loading-indicator"> Loading.... </div>
  </div>
  <div id="ajaxField" name="ajaxField">
    <table width="680px">
      <tr>
        <th width="100px"><font style="text-transform:uppercase">REF NO</font></th>
        <th width="105px"><font style="text-transform:uppercase">INVOICE DATE</font></th>
        <th width="105px"><font style="text-transform:uppercase">END CONTRACT DATE</font></th>
        <th width="300px">CUSTOMER</th>
        <th width="300px">VEHICLE NO</th>
        <th width="80px">ACTION</th>
      </tr>
      <cfloop query="getcustsupp" >
        <tr>
          <td>#getcustsupp.refno#</td>
          <td>#DateFormat(getcustsupp.wos_date,"dd/mm/yyyy")#</td>
          <cfset endContractDate = DateAdd("m",12,getcustsupp.wos_date)>
          <td>#DateFormat(endContractDate,"dd/mm/yyyy")#</td>
          <td>#getcustsupp.custno# - #getcustsupp.name#</td>
          <td>#getcustsupp.rem5#</td>
          <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="javascript:ColdFusion.Window.hide('findRefno');selectlist('#getcustsupp.refno#','refno');"><u>SELECT</u></a></td>
        </tr>
      </cfloop>
    </table>
  </div>
</cfoutput>