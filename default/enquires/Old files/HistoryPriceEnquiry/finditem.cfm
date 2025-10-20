<cfquery name="getitemformat" datasource="#dts#">
select itemformat from dealer_menu
</cfquery>

<cfif getitemformat.itemformat eq '2'>

<cfoutput>
<cfset nametype = url.type>

	<cfquery name="getitemno" datasource="#dts#">
   		select itemno as xitemno,desp from icitem limit 15
	</cfquery>
    <font style="text-transform:uppercase">
    PRODUCT CODE:&nbsp;<input type="text" name="itemname2" id="itemname2" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField2'),'finditemAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemno='+document.getElementById('itemno1').value+'&itemname='+document.getElementById('name1').value+'&leftitemname='+document.getElementById('itemname2').value);" size="12" />
    &nbsp;#UCASE(nametype)# NO.</font>&nbsp;<input type="text" name="itemno1" size="8" id="itemno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField2'),'finditemAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemno='+document.getElementById('itemno1').value+'&itemname='+document.getElementById('itemname1').value+'&leftitemname='+document.getElementById('itemname2').value);"  />&nbsp;MID DESP:&nbsp;<input type="text" name="itemname1" id="itemname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField2'),'finditemAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemno='+document.getElementById('itemno1').value+'&itemname='+document.getElementById('itemname1').value+'&leftitemname='+document.getElementById('itemname2').value);" size="12" />&nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField2">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(nametype)# NO #nametype##url.fromto#</font></th>
    <th width="400px">DESP</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    <tr>
    <td>#getitemno.xitemno#</td>
    <td>#getitemno.desp#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getitemno.xitemno#','#nametype##url.fromto#');ColdFusion.Window.hide('finditem');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>




<cfelse>

<cfoutput>
<cfset nametype = url.type>

	<cfquery name="getitemno" datasource="#dts#">
   		select itemno as xitemno,desp from icitem limit 15
	</cfquery>
    <font style="text-transform:uppercase">#UCASE(nametype)# NO.</font>&nbsp;<input type="text" name="itemno1" size="8" id="itemno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField2'),'finditemAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemno='+document.getElementById('itemno1').value+'&itemname='+document.getElementById('itemname1').value+'&leftitemname='+document.getElementById('itemname2').value);" <cfif isdefined('url.itemno')>value="#url.itemno#"</cfif>  />&nbsp;MID DESP:&nbsp;<input type="text" name="itemname1" id="itemname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField2'),'finditemAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemno='+document.getElementById('itemno1').value+'&itemname='+document.getElementById('itemname1').value+'&leftitemname='+document.getElementById('itemname2').value);" size="12" />&nbsp;LEFT DESP:&nbsp;<input type="text" name="itemname2" id="itemname2" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField2'),'finditemAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemno='+document.getElementById('itemno1').value+'&itemname='+document.getElementById('itemname1').value+'&leftitemname='+document.getElementById('itemname2').value);" size="12" />&nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField2" name="ajaxField2">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(nametype)# NO</font></th>
    <th width="400px">DESP</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    <tr>
    <td>#getitemno.xitemno#</td>
    <td>#getitemno.desp#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getitemno.xitemno#','#lcase(nametype)##lcase(url.fromto)#');ColdFusion.Window.hide('finditem');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>
	
    </cfif>