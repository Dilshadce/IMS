<cfoutput>

	<cfquery name="getitemno" datasource="#dts#">
   		SELECT * 
        FROM iserial 
        GROUP BY serialno  
        LIMIT 15;
	</cfquery>
    <font style="text-transform:uppercase">Serial NO.</font>&nbsp;<input type="text" name="serialNo" size="8" id="serialNo" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldSerial'),'findserialAjax.cfm?fromto=#url.fromto#&serialNo='+document.getElementById('serialNo').value);" /><input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxFieldSerial" name="ajaxFieldSerial">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">SERIAL NO</font></th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    <tr>
    <td>#getitemno.serialno#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('serial#url.fromto#').value='#getitemno.serialno#';ColdFusion.Window.hide('findserial');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>