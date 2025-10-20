
<cfoutput>

	<cfquery name="getrefno" datasource="#dts#">
   		select * from artran where type='RC' limit 50
	</cfquery>

    <table>
        <tr>
            <td>
                <font style="text-transform:uppercase">Ref NO. :</font>
            </td>
            <td>
                <input type="text" name="itemno1" id="itemno1" size="12" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findrefnoAjax.cfm?fromto=#url.fromto#&refno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value+'&refno2='+document.getElementById('refno2').value+'&period='+document.getElementById('period').value+'&date='+document.getElementById('date').value);" <cfif isdefined('url.custno')>value="#url.custno#"</cfif> />
            </td>
            
            <td>
            	<font style="text-transform:uppercase">Supplier NO :</font>
            </td>
            <td>
           		<input type="text" name="custname1" id="custname1" size="12" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findrefnoAjax.cfm?fromto=#url.fromto#&refno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value+'&refno2='+document.getElementById('refno2').value+'&period='+document.getElementById('period').value+'&date='+document.getElementById('date').value);" />
            </td>
            
            <td>
            	<font style="text-transform:uppercase">Name :</font>
            </td>
            <td>
            	<input type="text" name="custname2" id="custname2" size="12" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findrefnoAjax.cfm?fromto=#url.fromto#&refno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value+'&refno2='+document.getElementById('refno2').value+'&period='+document.getElementById('period').value+'&date='+document.getElementById('date').value);"/>
            </td>
        </tr>

        <tr>
            <td>
            	<font style="text-transform:uppercase">Ref NO.2 :</font>
            </td>
            <td>
            	<input type="text" name="refno2" id="refno2" size="12" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findrefnoAjax.cfm?fromto=#url.fromto#&refno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value+'&refno2='+document.getElementById('refno2').value+'&period='+document.getElementById('period').value+'&date='+document.getElementById('date').value);"  />
            </td>
             <td>
            	<font style="text-transform:uppercase">Period :</font>
            </td>
            <td>
            	<input type="text" name="period" id="period" size="12" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findrefnoAjax.cfm?fromto=#url.fromto#&refno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value+'&refno2='+document.getElementById('refno2').value+'&period='+document.getElementById('period').value+'&date='+document.getElementById('date').value);"  />
            </td>
             <td>
            	<font style="text-transform:uppercase">Date :</font>
            </td>
            <td>
            	<input type="text" name="date" id="date" size="12" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findrefnoAjax.cfm?fromto=#url.fromto#&refno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value+'&refno2='+document.getElementById('refno2').value+'&period='+document.getElementById('period').value+'&date='+document.getElementById('date').value);" />
            </td>
            <td>
            	<input type="button" name="Searchbtn" value="Go" >
            </td>
        </tr>
    </table>
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField" name="ajaxField">
    <table width="950px">
    <tr>
        <th width="100px">REF NO</th>
        <th width="100px">REF NO.2</th>
        <th width="400px">CUSTOMER</th>
        <th width="100px">PERIOD</th>
        <th width="65px">DATE</th>
        <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getrefno" >
    <tr>
    	<td>#getrefno.refno#</td>
        <td>#getrefno.refno2#</td>
        <td>#getrefno.custno# - #getrefno.name#</td>
        <td>#getrefno.fperiod#</td>
        <td>#dateformat(getrefno.wos_date,"dd/mm/yyyy")#</td>
   		<td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('enterref#fromto#').value='#getrefno.refno#';ColdFusion.Window.hide('findrefno');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>