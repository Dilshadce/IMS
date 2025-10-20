<cfquery name="getitemformat" datasource="#dts#">
select itemformat from dealer_menu
</cfquery>



<cfoutput>
<cfset nametype = url.type>

	<cfquery name="getattn" datasource="#dts#">
   		select attentionno, name  from attention limit 15
	</cfquery>
    <font style="text-transform:uppercase">
    
    ATTENTION NO.</font>&nbsp;<input type="text" name="itemno1" size="8" id="itemno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findattn2Ajax.cfm?nametype=#nametype#&itemno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value);" <cfif isdefined('url.custno')>value="#url.custno#"</cfif>  />&nbsp;LEFT NAME:&nbsp;<input type="text" name="custname1" id="custname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findattn2Ajax.cfm?nametype=#nametype#&itemno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value);" size="12" />&nbsp MIDDLE NAME:&nbsp;<input type="text" name="custname2" id="custname2" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findattn2Ajax.cfm?nametype=#nametype#&itemno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value);" size="12" />
    
    
    &nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField" name="ajaxField">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(nametype)# NO</font></th>
    <th width="400px">DESP</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getattn" >
    <tr>
    <td>#getattn.attentionno#</td>
    <td>#getattn.name#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('#nametype#').value='#getattn.attentionno#';ColdFusion.Window.hide('findattn2');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>




