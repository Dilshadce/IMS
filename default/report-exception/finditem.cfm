 <cfoutput>
  <cfset nametype = url.type>
  <cfif isdefined('url.itemtext')>
    <cfset itemtext=1>
    <cfelse>
    <cfset itemtext=''>
  </cfif>
  <cfquery name="getitemno" datasource="#dts#">
   		select itemno as xitemno,desp from icitem limit 15
	</cfquery>
  <font style="text-transform:uppercase">#UCASE(nametype)# NO.</font>&nbsp;
  <input type="text" name="itemno1" size="8" id="itemno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldItem'),'finditemAjax.cfm?nametype=#nametype#&itemtext=#itemtext#&fromto=#url.fromto#&itemno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('customerName1').value+'&leftcustname='+document.getElementById('customerName2').value);" <cfif isdefined('url.custno')>value="#url.custno#"</cfif>  />
  &nbsp;MID DESP:&nbsp;
  <input type="text" name="customerName1" id="customerName1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldItem'),'finditemAjax.cfm?nametype=#nametype#&itemtext=#itemtext#&fromto=#url.fromto#&itemno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('customerName1').value+'&leftcustname='+document.getElementById('customerName2').value);" size="12" />
  &nbsp;LEFT DESP:&nbsp;
  <input type="text" name="customerName2" id="customerName2" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFieldItem'),'finditemAjax.cfm?nametype=#nametype#&fromto=#url.fromto#&itemtext=#itemtext#&itemno='+document.getElementById('itemno1').value+'&custname='+document.getElementById('customerName1').value+'&leftcustname='+document.getElementById('customerName2').value);" size="12" />
  &nbsp;&nbsp;
  <input type="button" name="Searchbtn" value="Go" >
  <div id="loading" style="visibility:hidden">
    <div class="loading-indicator"> Loading.... </div>
  </div>
  <div id="ajaxFieldItem" name="ajaxFieldItem">
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
          <td><cfif isdefined('url.itemtext')>
              <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('productfrom').value='#getitemno.xitemno#';ColdFusion.Window.hide('finditem');"><u>SELECT</u></a>
              <cfelse>
              <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getitemno.xitemno#','#nametype##url.fromto#');ColdFusion.Window.hide('finditem');"><u>SELECT</u></a>
            </cfif></td>
        </tr>
      </cfloop>
    </table>
  </div>
</cfoutput>