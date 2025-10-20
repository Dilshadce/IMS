<cfoutput>
<cfset url.type = Customer>
<cfset ptype = url.type >
<cfquery name="getgeneral" datasource="#dts#">
select agentlistuserid,locarap,grpinitem from gsetup
</cfquery>

<cfquery name="getdisplay" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
    select * from modulecontrol
</cfquery>

	<cfquery name="getcustsupp" datasource="#dts#">
   		select custno as xcustno,name,agent,business,arrem1,arrem2,arrem3,arrem4,comuen from #url.dbtype# WHERE 0=0 
        and (status <>"B" or status is null)
		<cfif url.type neq "Customer">
        <cfif getgeneral.grpinitem eq "Y">
         <cfif Hitemgroup neq ''>
        and name='#Hitemgroup#'
        </cfif>
		</cfif>
		</cfif>
		<cfif url.type eq "Customer" and getpin2.h1t00 eq 'T'>
<cfif getgeneral.agentlistuserid eq "Y">and ucase(agent) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(created_by)='#ucase(huserid)#' or ucase(agent)='#ucase(huserid)#' or (ucase(agent) in (SELECT agent FROM #target_icagent# WHERE ucase(agentid) like "%#ucase(huserid)#%")))  
					</cfif>
					<cfelse>
                    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mika_i">
                   
                    <cfelse>
					<cfif Huserloc neq "All_loc" and getgeneral.locarap eq "Y">
					and (created_by in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
                    </cfif>
                    </cfif>

		<!---<cfif isdefined('url.custno')>and custno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custno#%"></cfif>---> limit 15
	</cfquery>
    <font style="text-transform:uppercase">#url.type# NO.</font>&nbsp;<input type="text" name="custno1" id="custno1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findCustomerAjax.cfm?type=#url.type#&dbtype=#url.dbtype#&custno='+document.getElementById('custno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value+'&custvehi='+document.getElementById('custvehi').value+'&displaytype='+document.getElementById('displaytype').value);" value=""  />
    <cfif lcase(HcomID) neq "taftc_i" >
      &nbsp;LEFT NAME:&nbsp;
    </cfif>
    <input <cfif lcase(HcomID) neq "taftc_i" >type="text"<cfelse>type="hidden"</cfif> name="custname2" id="custname2" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findCustomerAjax.cfm?type=#url.type#&amp;dbtype=#url.dbtype#&amp;custno='+document.getElementById('custno1').value+'&amp;custname='+document.getElementById('custname1').value+'&amp;leftcustname='+document.getElementById('custname2').value+'&custvehi='+document.getElementById('custvehi').value+'&displaytype='+document.getElementById('displaytype').value);" size="12" />
    &nbsp;<cfif lcase(HcomID) neq "taftc_i" >MID</cfif> NAME:&nbsp;<input type="text" name="custname1" id="custname1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField'),'findCustomerAjax.cfm?type=#url.type#&dbtype=#url.dbtype#&custno='+document.getElementById('custno1').value+'&custname='+document.getElementById('custname1').value+'&leftcustname='+document.getElementById('custname2').value+'&custvehi='+document.getElementById('custvehi').value+'&displaytype='+document.getElementById('displaytype').value);" <cfif lcase(HcomID) neq "taftc_i" >size="12"</cfif> /><cfif lcase(HcomID) neq "taftc_i" ></cfif>&nbsp;&nbsp;
    <br />
    
<input type="button" name="Searchbtn" value="Go" >
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....    </div>
    </div>
    <div id="ajaxField" name="ajaxField">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#url.type# NO</font></th>
    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i">
    <th width="100px"><font style="text-transform:uppercase">Agent</font></th>
    </cfif>
    <th width="400px">NAME</th>
    <cfif getdisplay.custsearch_business eq 'Y'>
    <th width="100px">Business</th>
    </cfif>
    <cfif getdisplay.custsearch_rem1 eq 'Y'>
    <th width="120px" nowrap>Remark 1</th>
    </cfif>
    <cfif getdisplay.custsearch_rem2 eq 'Y'>
    <th width="120px" nowrap>Remark 2</th>
    </cfif>
    <cfif getdisplay.custsearch_rem3 eq 'Y'>
    <th width="120px" nowrap>Remark 3</th>
    </cfif>
    <cfif getdisplay.custsearch_rem4 eq 'Y'>
    <th width="120px" nowrap>Remark 4</th>
    </cfif>
    <cfif lcase(hcomid) eq "rpi270505_i">
    <th width="120px" nowrap>Company UEN</th>
    </cfif>
    <cfif getmodule.auto eq "1">
    <th width="100px">Vehicle No</th>
    </cfif>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getcustsupp" >
    <tr>
    <td>#getcustsupp.xcustno#</td>
    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i">
    <td>#getcustsupp.agent#</td>
    </cfif>
    <td>#getcustsupp.name#</td>
    <cfif getdisplay.custsearch_business eq 'Y'>
    <td>#getcustsupp.business#</td>
    </cfif>
    <cfif getdisplay.custsearch_rem1 eq 'Y'>
    <td>#getcustsupp.arrem1#</td>
    </cfif>
    <cfif getdisplay.custsearch_rem2 eq 'Y'>
    <td>#getcustsupp.arrem2#</td>
    </cfif>
    <cfif getdisplay.custsearch_rem3 eq 'Y'>
    <td>#getcustsupp.arrem3#</td>
    </cfif>
    <cfif getdisplay.custsearch_rem4 eq 'Y'>
    <td>#getcustsupp.arrem4#</td>
    </cfif>
    <cfif lcase(hcomid) eq "rpi270505_i">
    <td>#getcustsupp.comuen#</td>
    </cfif>
    <cfif getmodule.auto eq "1">
    <cfquery name="getallvehi" datasource="#dts#">
    select entryno from vehicles where custcode='#getcustsupp.xcustno#'
    </cfquery>
    <td><cfloop query="getallvehi"><cfif getallvehi.currentrow gt 1>, </cfif>#getallvehi.entryno#</cfloop></td>
    </cfif>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getcustsupp.xcustno#');ajaxFunction(document.getElementById('attnajax'),'attentionajax.cfm?custno=#getcustsupp.xcustno#');ColdFusion.Window.hide('findEmp');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    </table>
    </div>
    </cfoutput>