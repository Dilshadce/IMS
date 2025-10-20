<cfoutput>
<cfset ptype = url.type >
<cfquery name="getgeneral" datasource="#dts#">
select agentlistuserid from gsetup
</cfquery>
	<cfquery name="getcustsupp" datasource="#dts#">
   		select custno as xcustno,name from #target_apvend# WHERE 0=0 
		<cfif url.type eq "Customer" and getpin2.h1t00 eq 'T'>
<cfif getgeneral.agentlistuserid eq "Y">and ucase(agent) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(created_by)='#ucase(huserid)#' or ucase(agent)='#ucase(huserid)#' or (ucase(agent) in (SELECT agent FROM #target_icagent# WHERE ucase(agentid) like "%#ucase(huserid)#%")))  
					</cfif>
					<cfelse>
                    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i">
                   
                    <cfelse>
					<cfif Huserloc neq "All_loc">
					and (created_by in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
                    </cfif>
                    </cfif>
		<cfif isdefined('url.custno')>and custno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custno#%"></cfif> limit 15
	</cfquery>
    <font style="text-transform:uppercase">#url.type# NO.</font>&nbsp;<input type="text" name="custno1" <cfif lcase(HcomID) neq "taftc_i" >size="8"<cfelse></cfif> id="custno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findsuppAjax.cfm?type=#url.type#&dbtype=#url.dbtype#&custno='+document.getElementById('custno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value+'&displaytype='+document.getElementById('displaytype').value);" <cfif isdefined('url.custno')>value="#url.custno#"</cfif>  />
    <cfif lcase(HcomID) neq "taftc_i" >
      &nbsp;LEFT NAME:&nbsp;
    </cfif>
    <input <cfif lcase(HcomID) neq "taftc_i" >type="text"<cfelse>type="hidden"</cfif> name="custname2" id="custname2" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findsuppAjax.cfm?type=#url.type#&amp;dbtype=#url.dbtype#&amp;custno='+document.getElementById('custno1').value+'&amp;custname='+document.getElementById('custname1').value+'&amp;leftcustname='+document.getElementById('custname2').value+'&displaytype='+document.getElementById('displaytype').value);" size="12" />
    &nbsp;<cfif lcase(HcomID) neq "taftc_i" >MID</cfif> NAME:&nbsp;<input type="text" name="custname1" id="custname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findsuppAjax.cfm?type=#url.type#&dbtype=#url.dbtype#&custno='+document.getElementById('custno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value+'&displaytype='+document.getElementById('displaytype').value);" <cfif lcase(HcomID) neq "taftc_i" >size="12"</cfif> /><cfif lcase(HcomID) neq "taftc_i" ></cfif>&nbsp;&nbsp;
    <br />
    <select name="displaytype" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findsuppAjax.cfm?type=#url.type#&dbtype=#url.dbtype#&custno='+document.getElementById('custno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value+'&displaytype='+document.getElementById('displaytype').value);">
    <option value="name">Debitor No - Name</option>
    <option value="name2">Debitor No - Name - Name 2</option>
    <option value="name3">Debitor No - Name -  Area - Agent</option>
    <option value="name4">Debitor No - Name - Address</option>
    </select>
<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....    </div>
    </div>
    <div id="ajaxField" name="ajaxField">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#url.type# NO</font></th>
    <th width="400px">NAME</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getcustsupp" >
    <tr>
    <td>#getcustsupp.xcustno#</td>
    <td>#getcustsupp.name#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getcustsupp.xcustno#');document.getElementById('DCode').value='';document.getElementById('BCode').value='';ColdFusion.Window.hide('findsupp');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    </table>
    </div>
    </cfoutput>