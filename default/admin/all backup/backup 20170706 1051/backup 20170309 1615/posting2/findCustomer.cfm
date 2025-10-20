
<cfquery name="getcustformat" datasource="#dts#">
select custformat from dealer_menu
</cfquery>

<cfoutput>
<cfset tran = url.type >
<cfset nametype = "cust">

	<cfquery name="getcustsupp" datasource="#dts#">
   		select custno as xcustno,name from #listfirst(tran)# limit 15
	</cfquery>
    <font style="text-transform:uppercase">#UCASE(nametype)# NO.</font>&nbsp;<input type="text" name="customerNo" size="8" id="customerNo" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField1'),'findCustomerAjax.cfm?type=#url.type#&nametype=#nametype#&fromto=#url.fromto#&customerNo='+document.getElementById('customerNo').value+'&customerMidName='+document.getElementById('customerMidName').value+'&customerLeftName='+document.getElementById('customerLeftName').value);" <cfif isdefined('url.custno')>value="#url.custno#"</cfif>  />
    
    &nbsp;MID NAME:&nbsp;<input type="text" name="customerMidName" size="8" id="customerMidName" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField1'),'findCustomerAjax.cfm?type=#url.type#&nametype=#nametype#&fromto=#url.fromto#&customerNo='+document.getElementById('customerNo').value+'&customerMidName='+document.getElementById('customerMidName').value+'&customerLeftName='+document.getElementById('customerLeftName').value);" />
    
    
    &nbsp;LEFT NAME:&nbsp;<input type="text" name="customerLeftName" size="8" id="customerLeftName" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField1'),'findCustomerAjax.cfm?type=#url.type#&nametype=#nametype#&fromto=#url.fromto#&customerNo='+document.getElementById('customerNo').value+'&customerMidName='+document.getElementById('customerMidName').value+'&customerLeftName='+document.getElementById('customerLeftName').value);"/>
    <br />
    
    &nbsp;&nbsp;<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxField1" name="ajaxField1">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(nametype)# NO</font></th>
    <th width="400px">NAME</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getcustsupp" >
    <tr>
    <td>#getcustsupp.xcustno#</td>
    <td>#getcustsupp.name#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('custno#listfirst(url.fromto)#').value='#getcustsupp.xcustno#';ColdFusion.Window.hide('findCustomer');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>
