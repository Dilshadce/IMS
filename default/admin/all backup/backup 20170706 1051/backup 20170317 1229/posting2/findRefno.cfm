<cfoutput>
<cfset ptype = url.type >

	<cfquery name="getcustsupp" datasource="#dts#">
   		select refno,name 
        from artran
        where type='#ptype#' 
        limit 15
	</cfquery>
    <font style="text-transform:uppercase">#url.type# NO.</font>&nbsp;<input type="text" name="custno1" id="custno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('custajaxField'),'findRefnoAjax.cfm?type=#url.type#&fromto=#url.fromto#&custno='+document.getElementById('custno1').value+'&custname='+document.getElementById('custname1').value+'&date='+document.getElementById('srefnodate').value+'&period='+document.getElementById('srefnoperiod').value);"  />&nbsp;&nbsp;Ref No 2:&nbsp;
    <input type="text" name="custname1" id="custname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('custajaxField'),'findRefnoAjax.cfm?type=#url.type#&fromto=#url.fromto#&custno='+document.getElementById('custno1').value+'&custname='+document.getElementById('custname1').value+'&date='+document.getElementById('srefnodate').value+'&period='+document.getElementById('srefnoperiod').value);" />
    &nbsp;&nbsp;
    <br />Date:&nbsp;
    <input type="text" name="srefnodate" id="srefnodate" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('custajaxField'),'findRefnoAjax.cfm?type=#url.type#&fromto=#url.fromto#&custno='+document.getElementById('custno1').value+'&custname='+document.getElementById('custname1').value+'&date='+document.getElementById('srefnodate').value+'&period='+document.getElementById('srefnoperiod').value);" />(DD/MM/YYYY)
    &nbsp;&nbsp;Period:&nbsp;
    <select name="srefnoperiod" id="srefnoperiod" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('custajaxField'),'findRefnoAjax.cfm?type=#url.type#&fromto=#url.fromto#&custno='+document.getElementById('custno1').value+'&custname='+document.getElementById('custname1').value+'&date='+document.getElementById('srefnodate').value+'&period='+document.getElementById('srefnoperiod').value);">
    <option value="">Choose a Period</option>
    <cfloop from="1" to="18" index="i">
    <option value="#numberformat(i,'00')#">#numberformat(i,'00')#</option>
    </cfloop>
    </select>
    
    &nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="custajaxField" name="custajaxField">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">REF NO #url.type#</font></th>
    <th width="300px">CUSTOMER NAME</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getcustsupp" >
    <tr>
    <td>#getcustsupp.refno#</td>
    <td>#getcustsupp.name#</td>
    <td>

    <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('billno#url.fromto#').value='#getcustsupp.refno#';javascript:ColdFusion.Window.hide('findRefno');"><u>SELECT</u></a>
   
   

    </td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>