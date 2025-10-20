<cfoutput>

	<cfquery datasource='#dts#' name="findaddress">
	  Select * from address 
	  where custno = '#url.custno#' or custno=""
	</cfquery>
    <table>
    <th>Address Code</th>
    <td><input type="text" name="addcode" size="8" id="addcode" value="" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('addajaxField'),'findaddressAjax.cfm?custno=#url.custno#&addtype=#url.addtype#&code='+document.getElementById('addcode').value+'&desp='+document.getElementById('adddesp').value);" /></td>
    
    <th>Address</th>
    <td><input type="text" name="adddesp" size="8" id="adddesp" value="" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('addajaxField'),'findaddressAjax.cfm?custno=#url.custno#&addtype=#url.addtype#&code='+document.getElementById('addcode').value+'&desp='+document.getElementById('adddesp').value);"  /></td>
    
    </table>
    
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="addajaxField" name="addajaxField">
    <table width="480px">
    <tr>
    <th width="100px">Address Code</th>
    <th width="400px">Address</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="findaddress" >
    <tr>
    <td>#findaddress.code#</td>
    <td>#findaddress.add1# #findaddress.add2# #findaddress.add3# #findaddress.add4#</td>
    <td>
    <cfif url.addtype eq 'bill'>
    <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('BCode').value='#findaddress.code#';document.getElementById('b_add1').value='#findaddress.add1#';document.getElementById('b_add2').value='#findaddress.add2#';document.getElementById('b_add3').value='#findaddress.add3#';document.getElementById('b_add4').value='#findaddress.add4#';ColdFusion.Window.hide('findaddress');"><u>SELECT</u></a></td>
    <cfelse>
    <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('DCode').value='#findaddress.code#';document.getElementById('d_add1').value='#findaddress.add1#';document.getElementById('d_add2').value='#findaddress.add2#';document.getElementById('d_add3').value='#findaddress.add3#';document.getElementById('d_add4').value='#findaddress.add4#';ColdFusion.Window.hide('findaddress');"><u>SELECT</u></a></td>
    </cfif>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>