
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

<cfif getmodule.auto eq "1">

<cfquery name="getcustomervehi" datasource="#dts#">
    select custcode from vehicles where entryno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custvehi#%">
</cfquery>
<cfset vehicustlist=valuelist(getcustomervehi.custcode)>

</cfif>

	<cfquery name="getcustsupp" datasource="#dts#">
   		select custno as xcustno,name,name2,add1,add2,add3,add4,agent,area,business,arrem1,arrem2,arrem3,arrem4,comuen from #url.dbtype# WHERE custno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custno#%"> and name like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%"> and name like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.leftcustname#%">
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
           			and (ucase(agent)='#ucase(huserid)#' or ucase(agent)='#ucase(huserid)#' or (ucase(agent) in (SELECT agent FROM #target_icagent# WHERE ucase(agentid) like "%#ucase(huserid)#%")))  
					</cfif>
					<cfelse>
                    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mika_i">
                    
                    <cfelse>
					<cfif Huserloc neq "All_loc" and getgeneral.locarap eq "Y">
					and (agent in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
                    </cfif>
                    </cfif>
                    <cfif getmodule.auto eq "1">
                    and custno in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#vehicustlist#">)
                    </cfif>

         order by custno limit 500
	</cfquery>
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#url.type# NO</font></th>
    <cfif url.displaytype eq 'name'>
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
    <cfelseif url.displaytype eq 'name2'>
    <th width="400px">NAME</th>
    <th width="400px">NAME 2</th>
    <cfif getmodule.auto eq "1">
    <th width="100px">Vehicle No</th>
    </cfif>
    <th width="80px">ACTION</th>
    <cfelseif url.displaytype eq 'name3'>
    <th width="400px">NAME</th>
    <th width="400px">AREA</th>
    <th width="400px">AGENT</th>
    <cfif getmodule.auto eq "1">
    <th width="100px">Vehicle No</th>
    </cfif>
    <th width="80px">ACTION</th>
    <cfelseif url.displaytype eq 'name4'>
    <th width="400px">NAME</th>
    <th width="400px">ADDRESS</th>
    <cfif getmodule.auto eq "1">
    <th width="100px">Vehicle No</th>
    </cfif>
    <th width="80px">ACTION</th>
    </cfif>
    </tr>
    <cfloop query="getcustsupp" >
    
    <tr>
    <td>#getcustsupp.xcustno#</td>
    <cfif url.displaytype eq 'name'>
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
    <td><cfloop query="getallvehi"><cfif getallvehi.currentrow gt 1>,</cfif>#getallvehi.entryno#</cfloop></td>
    </cfif>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getcustsupp.xcustno#');ColdFusion.Window.hide('findCustomer');" >SELECT</a></td>
    <cfelseif url.displaytype eq 'name2'>
    <td>#getcustsupp.name#</td>
    <td>#getcustsupp.name2#</td>
     <cfif getmodule.auto eq "1">
    <cfquery name="getallvehi" datasource="#dts#">
    select entryno from vehicles where custcode='#getcustsupp.xcustno#'
    </cfquery>
    <td><cfloop query="getallvehi"><cfif getallvehi.currentrow gt 1>,</cfif>#getallvehi.entryno#</cfloop></td>
    </cfif>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getcustsupp.xcustno#');ColdFusion.Window.hide('findCustomer');" >SELECT</a></td>
    <cfelseif url.displaytype eq 'name3'>
    <td>#getcustsupp.name#</td>
    <td>#getcustsupp.area#</td>
    <td>#getcustsupp.agent#</td>
     <cfif getmodule.auto eq "1">
    <cfquery name="getallvehi" datasource="#dts#">
    select entryno from vehicles where custcode='#getcustsupp.xcustno#'
    </cfquery>
    <td><cfloop query="getallvehi"><cfif getallvehi.currentrow gt 1>,</cfif>#getallvehi.entryno#</cfloop></td>
    </cfif>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getcustsupp.xcustno#');ColdFusion.Window.hide('findCustomer');" >SELECT</a></td>
    <cfelseif url.displaytype eq 'name4'>
    <td>#getcustsupp.name#</td>
    <td>#getcustsupp.add1# #getcustsupp.add2#<br />#getcustsupp.add3# #getcustsupp.add4#</td>
     <cfif getmodule.auto eq "1">
    <cfquery name="getallvehi" datasource="#dts#">
    select entryno from vehicles where custcode='#getcustsupp.xcustno#'
    </cfquery>
    <td><cfloop query="getallvehi"><cfif getallvehi.currentrow gt 1>,</cfif>#getallvehi.entryno#</cfloop></td>
    </cfif>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getcustsupp.xcustno#');ajaxFunction(document.getElementById('attnajax'),'attentionajax.cfm?custno=#getcustsupp.xcustno#');ColdFusion.Window.hide('findCustomer');" >SELECT</a></td>
    </cfif>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>