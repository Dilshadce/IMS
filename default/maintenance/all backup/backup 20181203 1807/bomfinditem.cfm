
<cfoutput>
<cfset nametype = 'Item'>

	<cfquery name="getitemno" datasource="#dts#">
   		select itemno as xitemno,desp from icitem limit 15
	</cfquery>
    <font style="text-transform:uppercase">#UCASE(nametype)# NO.</font>&nbsp;<input type="text" name="itemno1" size="8" id="itemno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'bomfinditemAjax.cfm?nametype=#nametype#&itemno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value);" <cfif isdefined('url.custno')>value="#url.custno#"</cfif>  />&nbsp;MID DESP:&nbsp;<input type="text" name="custname1" id="custname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'bomfinditemAjax.cfm?nametype=#nametype#&itemno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value);" size="12" />&nbsp;LEFT DESP:&nbsp;<input type="text" name="custname2" id="custname2" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'bomfinditemAjax.cfm?nametype=#nametype#&itemno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value);" size="12" />&nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField" name="ajaxField">
    <table width="780px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(nametype)# NO</font></th>
    <th width="400px">DESP</th>
    <th width="300px">Existing Bom No</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    <cfquery name="getbomdata" datasource="#dts#">
	SELECT bomno FROM billmat where itemno='#getitemno.xitemno#' group by bomno ORDER BY bomno
	</cfquery>
    
    <tr>
    <td>#getitemno.xitemno#</td>
    <td>#getitemno.desp#</td>
    <td>#valuelist(getbomdata.bomno)#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist2('#getitemno.xitemno#','sitemno');ColdFusion.Window.hide('finditem2');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>