
<cfoutput>
<cfset nametype = "Vehicles">
	<cfquery name="getcustsupp" datasource="#dts#">
   		select entryno as xentryno,model,make from vehicles limit 15
	</cfquery>
    <font style="text-transform:uppercase">Vehicle NO.</font>&nbsp;<input type="text" name="vehino1" size="8" id="vehino1" onfocus="clearTimeout(t1);clearTimeout(t11);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findvehicleAjax.cfm?type=#url.type#&custno='+document.getElementById('vehino1').value+'&custname='+document.getElementById('model1').value+'&leftcustname='+document.getElementById('make1').value);if(event.keyCode==13){document.getElementById('make1').focus();}} else if (event.keyCode==40){document.getElementById('b1').focus()} " <cfif isdefined('url.custno')>value="#url.custno#"</cfif>  />
    &nbsp;Make:&nbsp;
    <input type="text" name="make1" id="make1" onfocus="clearTimeout(t1);clearTimeout(t11);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findvehicleAjax.cfm?type=#url.type#&custno='+document.getElementById('vehino1').value+'&custname='+document.getElementById('model1').value+'&leftcustname='+document.getElementById('make1').value);if(event.keyCode==13){document.getElementById('model1').focus();}} else if (event.keyCode==40){document.getElementById('b1').focus()}" size="12" />
    &nbsp;Model:&nbsp;<input type="text" name="model1" id="model1" onfocus="clearTimeout(t1);clearTimeout(t11);"  size="12" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findvehicleAjax.cfm?type=#url.type#&custno='+document.getElementById('vehino1').value+'&custname='+document.getElementById('model1').value+'&leftcustname='+document.getElementById('make1').value);if(event.keyCode==13){document.getElementById('Searchbtn').focus();}}  else if (event.keyCode==40){document.getElementById('b1').focus()}" />&nbsp;&nbsp;
<input type="button" name="Searchbtn" id="Searchbtn" value="Go" onclick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findvehicleAjax.cfm?type=#url.type#&custno='+document.getElementById('vehino1').value+'&custname='+document.getElementById('model1').value+'&leftcustname='+document.getElementById('make1').value);" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....    </div>
    </div>
    <div id="ajaxField" name="ajaxField">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">Vehicle NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">Vehicle Make</font></th>
    <th width="100px"><font style="text-transform:uppercase">Vehicle Model</font></th>
   <cfif lcase(hcomid) neq "acht_i"> <th width="80px">ACTION</th></cfif>
    </tr>
    <cfloop query="getcustsupp" >
    <tr id="t#getcustsupp.currentrow#" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';" >
    <td>#getcustsupp.xentryno#</td>
    <td>#getcustsupp.make#</td>
    <td>#getcustsupp.model#</td>
    <td><input name="b#getcustsupp.currentrow#" id="b#getcustsupp.currentrow#" type="button" style="background:none; border:none; cursor:pointer;" onClick="document.getElementById('rem5').value='#getcustsupp.xentryno#';getvehicles();ColdFusion.Window.hide('findvehicle');" value="SELECT" onfocus="document.getElementById('t#getcustsupp.currentrow#').bgColor='##CCCCCC'" onblur="document.getElementById('t#getcustsupp.currentrow#').bgColor='##FFFFFF'" onkeyup="<cfif getcustsupp.currentrow neq getcustsupp.recordcount>if(event.keyCode==40){document.getElementById('b#val(getcustsupp.currentrow)+1#').focus()}</cfif> <cfif getcustsupp.currentrow neq 1>if(event.keyCode==38){document.getElementById('b#val(getcustsupp.currentrow)-1#').focus()}<cfelse>if(event.keyCode==38){document.getElementById('vehino1').focus()}</cfif> "></td>
    </tr>
    </cfloop>
    </table>
    </div>
    </cfoutput>
