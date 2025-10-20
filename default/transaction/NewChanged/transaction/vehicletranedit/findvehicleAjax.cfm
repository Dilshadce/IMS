
<cfset ptype = url.type >

	<cfquery name="getcustsupp" datasource="#dts#">
   		select entryno as xentryno,model,make from vehicles WHERE entryno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custno#%"> and model like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%"> and make like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.leftcustname#%"> order by entryno limit 500
	</cfquery>
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">Vehicle NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">Make</font></th>
    <th width="100px"><font style="text-transform:uppercase">Model</font></th>
    <cfif lcase(hcomid) neq "acht_i"><th width="80px">ACTION</th></cfif>
    </tr>
    <cfloop query="getcustsupp" >
    
    <tr id="t#getcustsupp.currentrow#" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    <td>#getcustsupp.xentryno#</td>
    <td>#getcustsupp.make#</td>
    <td>#getcustsupp.model#</td>
    <td><input name="b#getcustsupp.currentrow#" id="b#getcustsupp.currentrow#" type="button" style="background:none; border:none; cursor:pointer;" onClick="document.getElementById('rem5').value='#getcustsupp.xentryno#';getvehicles();ColdFusion.Window.hide('findvehicle');" value="SELECT" onfocus="document.getElementById('t#getcustsupp.currentrow#').bgColor='##CCCCCC'" onblur="document.getElementById('t#getcustsupp.currentrow#').bgColor='##FFFFFF'" onkeyup="<cfif getcustsupp.currentrow neq getcustsupp.recordcount>if(event.keyCode==40){document.getElementById('b#val(getcustsupp.currentrow)+1#').focus()}</cfif> <cfif getcustsupp.currentrow neq 1>if(event.keyCode==38){document.getElementById('b#val(getcustsupp.currentrow)-1#').focus()}<cfelse>if(event.keyCode==38){document.getElementById('custno1').focus()}</cfif> " /></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>