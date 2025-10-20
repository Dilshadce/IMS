
<cfset ptype = url.type >
<cfquery name="getgeneral" datasource="#dts#">
select agentlistuserid from gsetup
</cfquery>
	<cfquery name="getcustsupp" datasource="#dts#">
   		select custno as xcustno,name,name2,add1,add2,add3,add4,agent,area from #target_apvend# WHERE custno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custno#%"> and name like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%"> and name like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.leftcustname#%">
        <cfif url.type eq "Customer" and getpin2.h1t00 eq 'T'>
<cfif getgeneral.agentlistuserid eq "Y">and ucase(agent) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(agent)='#ucase(huserid)#' or ucase(agent)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
                    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i">
                    
                    <cfelse>
					<cfif Huserloc neq "All_loc">
					and (agent in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
                    </cfif>
                    </cfif>
         order by custno limit 500
	</cfquery>
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#url.type# NO</font></th>
    <cfif url.displaytype eq 'name'>
    <th width="400px">NAME</th>
    <th width="80px">ACTION</th>
    <cfelseif url.displaytype eq 'name2'>
    <th width="400px">NAME</th>
    <th width="400px">NAME 2</th>
    <th width="80px">ACTION</th>
    <cfelseif url.displaytype eq 'name3'>
    <th width="400px">NAME</th>
    <th width="400px">AREA</th>
    <th width="400px">AGENT</th>
    <th width="80px">ACTION</th>
    <cfelseif url.displaytype eq 'name4'>
    <th width="400px">NAME</th>
    <th width="400px">ADDRESS</th>
    <th width="80px">ACTION</th>
    </cfif>
    </tr>
    <cfloop query="getcustsupp" >
    
    <tr>
    <td>#getcustsupp.xcustno#</td>
    <cfif url.displaytype eq 'name'>
    <td>#getcustsupp.name#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getcustsupp.xcustno#');document.getElementById('DCode').value='';document.getElementById('BCode').value='';ColdFusion.Window.hide('findsupp');" >SELECT</a></td>
    <cfelseif url.displaytype eq 'name2'>
    <td>#getcustsupp.name#</td>
    <td>#getcustsupp.name2#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getcustsupp.xcustno#');document.getElementById('DCode').value='';document.getElementById('BCode').value='';ColdFusion.Window.hide('findsupp');" >SELECT</a></td>
    <cfelseif url.displaytype eq 'name3'>
    <td>#getcustsupp.name#</td>
    <td>#getcustsupp.area#</td>
    <td>#getcustsupp.agent#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getcustsupp.xcustno#');document.getElementById('DCode').value='';document.getElementById('BCode').value='';ColdFusion.Window.hide('findsupp');" >SELECT</a></td>
    <cfelseif url.displaytype eq 'name4'>
    <td>#getcustsupp.name#</td>
    <td>#getcustsupp.add1# #getcustsupp.add2#<br />#getcustsupp.add3# #getcustsupp.add4#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getcustsupp.xcustno#');document.getElementById('DCode').value='';document.getElementById('BCode').value='';ColdFusion.Window.hide('findsupp');" >SELECT</a></td>
    </cfif>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>