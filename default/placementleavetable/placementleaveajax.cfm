<cfsetting showdebugoutput="no">
<cfif isdefined('url.placementno')>
<cfoutput>
<cfinclude template="/object/dateobject.cfm">
<cfset newuuid = url.uuid >
<cfset getplacementno.placementno = url.placementno>

<cfif isdefined('url.action')>
	<cfif url.action eq "delete">
    	<cfquery name="deletelist" datasource="#dts#">
        	DELETE from leavelisttemp WHERE id = "#url.id#"
        </cfquery>
    <cfelseif url.action eq "add">
    	<cfset leavetype1 = URLDECODE(url.leavetype)>
        <cfset startdate1 = URLDECODE(url.startdate)>
        <cfset startampm1 = URLDECODE(url.startampm)>
        <cfset enddate1 = URLDECODE(url.enddate)>
        <cfset endampm1 = URLDECODE(url.endampm)>
        <cfset leavedays1 = URLDECODE(url.leavedays)>
        <cfset leavebal1 = URLDECODE(url.leavebal)>
        <cfset claimableamt1 = URLDECODE(url.claimableamt)>
        <cfset remarks1 = URLDECODE(url.remarks)>
        
        <cfset datestartleave = createdate(listlast(startdate1,'/'),listgetat(startdate1,'2','/'),listfirst(startdate1,'/'))>
        <cfset dateendleave = createdate(listlast(enddate1,'/'),listgetat(enddate1,'2','/'),listfirst(enddate1,'/'))>
        <cfset datestartampm = startampm1>
        <cfset dateendampm = endampm1>
        
        <cfquery name="getleavecheck" datasource="#dts#">
        SELECT * FROM leavelisttemp WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.placementno#">
        and ((startdate > "#dateformat(datestartleave,'yyyy-mm-dd')#" and enddate < "#dateformat(dateendleave,'yyyy-mm-dd')#")
        or (startdate < "#dateformat(datestartleave,'yyyy-mm-dd')#" and enddate > "#dateformat(datestartleave,'yyyy-mm-dd')#")
        or (startdate < "#dateformat(dateendleave,'yyyy-mm-dd')#" and enddate > "#dateformat(dateendleave,'yyyy-mm-dd')#")
        or (startdate < "#dateformat(datestartleave,'yyyy-mm-dd')#" and enddate > "#dateformat(dateendleave,'yyyy-mm-dd')#")
        or (startdate = "#dateformat(datestartleave,'yyyy-mm-dd')#" and (startampm = "#datestartampm#" or startampm = "FULL DAY" or "#datestartampm#" = "FULL DAY")) 
        or (enddate = "#dateformat(dateendleave,'yyyy-mm-dd')#" and (endampm = "#dateendampm#" or endampm = "FULL DAY" or "#dateendampm#" = "FULL DAY"))
        or (enddate = "#dateformat(datestartleave,'yyyy-mm-dd')#" and (endampm = "#datestartampm#" or endampm = "FULL DAY" or "#datestartampm#" = "FULL DAY")) 
        or (startdate = "#dateformat(dateendleave,'yyyy-mm-dd')#" and (startampm = "#dateendampm#" or startampm = "FULL DAY" or "#dateendampm#" = "FULL DAY"))
        )
        </cfquery>
        
        <cfquery name="getleavecheck2" datasource="#dts#">
        SELECT * FROM leavelisttemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newuuid#"> 
        and ((startdate > "#dateformat(datestartleave,'yyyy-mm-dd')#" and enddate < "#dateformat(dateendleave,'yyyy-mm-dd')#")
        or (startdate < "#dateformat(datestartleave,'yyyy-mm-dd')#" and enddate > "#dateformat(datestartleave,'yyyy-mm-dd')#")
        or (startdate < "#dateformat(dateendleave,'yyyy-mm-dd')#" and enddate > "#dateformat(dateendleave,'yyyy-mm-dd')#")
        or (startdate < "#dateformat(datestartleave,'yyyy-mm-dd')#" and enddate > "#dateformat(dateendleave,'yyyy-mm-dd')#")
        or (startdate = "#dateformat(datestartleave,'yyyy-mm-dd')#" and (startampm = "#datestartampm#" or startampm = "FULL DAY" or "#datestartampm#" = "FULL DAY")) 
        or (enddate = "#dateformat(dateendleave,'yyyy-mm-dd')#" and (endampm = "#dateendampm#" or endampm = "FULL DAY" or "#dateendampm#" = "FULL DAY"))
        or (enddate = "#dateformat(datestartleave,'yyyy-mm-dd')#" and (endampm = "#datestartampm#" or endampm = "FULL DAY" or "#datestartampm#" = "FULL DAY")) 
        or (startdate = "#dateformat(dateendleave,'yyyy-mm-dd')#" and (startampm = "#dateendampm#" or startampm = "FULL DAY" or "#dateendampm#" = "FULL DAY"))
        )
        </cfquery>
        
        <cfif getleavecheck2.recordcount neq 0 or getleavecheck2.recordcount neq 0>
        <cfabort showerror="Duplicate Leave Entry found">
        </cfif>
        
                    
        <cfquery name="getplacementdetails" datasource="#dts#">
        SELECT * FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.placementno#">
        </cfquery>
        <cfif evaluate('getplacementdetails.#leavetype1#entitle') neq "Y">
        <input type="hidden" name="alerttext" id="alerttext" value="#leavetype1# IS NOT ENTITLED FOR PLACEMENT #url.placementno#">
        <cfabort showerror="#evaluate('#leavetype1#entitle')# IS NOT ENTITLED FOR PLACEMENT #url.placementno#">
        <cfelse>
        	
            <cfset currentleaveclaimdate = evaluate('getplacementdetails.#leavetype1#date')>
            <cfif currentleaveclaimdate eq "">
             <cfset dateclaimfrom = createdate('1986','7','11')>
			<cfelse>
            <cfset dateclaimfrom = createdate(year(currentleaveclaimdate),month(currentleaveclaimdate),day(currentleaveclaimdate))>
            </cfif>
            <cfset dateclaimto = createdate(listlast(startdate1,'/'),listgetat(startdate1,'2','/'),listfirst(startdate1,'/'))>
        	
            <cfif dateclaimfrom gt dateclaimto>
            <input type="hidden" name="alerttext" id="alerttext" value="">
        	<cfabort showerror="Leave start date is earlier than claimable date">
			<cfelse>
            
                <cfquery name="gettotalleavetaken" datasource="#dts#">
                SELECT sum(days) as takendays FROM leavelist WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#"> and leavetype = "#leavetype1#"<cfif isdefined('url.id')> and id = "#url.id#"</cfif>
                </cfquery>
                
                <cfquery name="gettotalleavetakentemp" datasource="#dts#">
                SELECT sum(days) as takendays FROM leavelisttemp WHERE 
                uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newuuid#"> 
                and leavetype = "#leavetype1#"
                and placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.placementno#"> 
                </cfquery>
                
                <cfif leavetype1 eq "AL">
                <cfset cf = evaluate('getplacementdetails.#leavetype1#bfdays')>
                <cfelse>
                <cfset cf = 0 >
                </cfif>
                
                <cfset entitledays = numberformat(evaluate('getplacementdetails.#leavetype1#days'),'.__')>
                
                <cfif evaluate('getplacementdetails.#leavetype1#earndays') eq "Y">
                	<cfset contractstartdate = createdate(year(getplacementdetails.startdate),month(getplacementdetails.startdate),day(getplacementdetails.startdate))>
           			<cfset contractenddate = createdate(year(getplacementdetails.completedate),month(getplacementdetails.completedate),day(getplacementdetails.completedate))>         
                    <cfset contractlength = datediff('m',contractstartdate,contractenddate)>
                    
                    <cfset currentmonth = datediff('m',contractstartdate,dateclaimto)>
                    
                    <cfif val(contractlength) neq 0 and contractlength gte currentmonth>
                    <cfset entitledays = val(entitledays) * (val(currentmonth)/val(contractlength))>
                    <cfset entitledays = ceiling(entitledays)>
					</cfif> 
                    <cfif leavetype1 eq "AL" and evaluate('getplacementdetails.#leavetype1#type') neq "lmwd">
                    	<cfif entitledays lt numberformat(evaluate('getplacementdetails.#leavetype1#days'),'.__')>
                        	<cfif val(entitledays) + 1 lte numberformat(evaluate('getplacementdetails.#leavetype1#days'),'.__')>
                            	<cfset 	entitledays = entitledays + 1>
							<cfelse>
                            	<cfset entitledays = numberformat(evaluate('getplacementdetails.#leavetype1#days'),'.__')>
							</cfif>
						</cfif>
					</cfif>
				</cfif>
                
                <cfset balance = numberformat(entitledays,'.__') + numberformat(cf,'.__') - numberformat(gettotalleavetaken.takendays,'.__')-numberformat(gettotalleavetakentemp.takendays,'.__')>
                
                <cfif val(balance) lt val(leavedays1) and numberformat(evaluate('getplacementdetails.#leavetype1#days'),'.__') neq 0>
                <input type="hidden" name="alerttext" id="alerttext" value="Insufficient leave: Leave balance = #val(balance)# and leave applied = #val(leavedays1)#">
                <cfabort showerror="Insufficient leave: Leave balance = #val(balance)# and leave applied = #val(leavedays1)#">
                <cfelse>
                
                    
                    <cfquery name="insertleave" datasource="#dts#">
                    INSERT INTO leavelisttemp
                    (
                    placementno,
                    leavetype,
                    days,
                    claimamount,
                    remarks,
                    startdate,
                    startampm,
                    enddate,
                    endampm,
                    leavebalance,
                    uuid,
                    contractenddate
                    )
                    VALUES
                    (
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.placementno#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#leavetype1#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(leavedays1)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#claimableamt1#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#remarks1#">,
                    "#dateformatnew(startdate1,'YYYY-MM-DD')#",
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#startampm1#">,
                    "#dateformatnew(enddate1,'YYYY-MM-DD')#",
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#endampm1#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(balance)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#newuuid#">,
                    "#dateformat(getplacementdetails.completedate,'YYYY-MM-DD')#"
                    )
                    </cfquery>
               
                </cfif>
            </cfif>
            
        	
            
        </cfif>
        
	</cfif>
</cfif>

<cfquery name="getplacementinfo" datasource="#dts#">
        SELECT * FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#">
        </cfquery>

      <table align="center" width="100%">
        <tr>
        <td></td>
        <th><div align="left">Claimable From</div></th>
        <th>Entitlement</th>
        <th>Carry Forward</th>
        <th>Taken</th>
        <th>Balance</th>
        <th>Outstanding Claimables</th>
        </tr>
        <cfquery name="getleave" datasource="#dts#">
        Select * from iccostcode order by costcode
        </cfquery>
		<cfset leavearray = arraynew(1)>
        <cfset leavedesparray = arraynew(1)>
        <cfset leavebalarray = arraynew(1)>
		<cfset leaveclaimablearray = arraynew(1)>
        <cfloop query="getleave">
        
        
        <cfif evaluate('getplacementinfo.#getleave.costcode#entitle') eq "Y">
        <cfquery name="gettotaltaken" datasource="#dts#">
        SELECT sum(days) as takendays,sum(if(claimed = "N",claimamount,0)) as outstandingclaim FROM leavelist WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#"> and leavetype = "#getleave.costcode#" <cfif isdefined('url.id')> and id = "#url.id#"</cfif>
        and contractenddate = "#dateformat(getplacementinfo.completedate,'YYYY-MM-DD')#"
        </cfquery>
        
         <cfquery name="gettotaltaken2" datasource="#dts#">
        SELECT sum(days) as takendays FROM leavelisttemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#newuuid#">  and leavetype = "#getleave.costcode#"
        and contractenddate = "#dateformat(getplacementinfo.completedate,'YYYY-MM-DD')#"
        </cfquery>
        
        <th><input type="hidden" name="getcontractenddate" id="getcontractenddate" value="#dateformat(getplacementinfo.completedate,'dd/mm/yyyy')#" /><input type="hidden" name="getcontractstartdate" id="getcontractstartdate" value="#dateformat(getplacementinfo.startdate,'dd/mm/yyyy')#" />#getleave.desp#</th>
        <td align="left">#dateformat(evaluate('getplacementinfo.#getleave.costcode#date'),'dd/mm/yyyy')#</td>
        <td align="right">#numberformat(evaluate('getplacementinfo.#getleave.costcode#days'),'.__')#</td>
        <td align="right"><cfif getleave.costcode eq "AL"><cfset cf = evaluate('getplacementinfo.#getleave.costcode#bfdays')><cfelse><cfset cf = 0 ></cfif><cfif numberformat(evaluate('getplacementinfo.#getleave.costcode#days'),'.__') neq 0>#numberformat(cf,'.__')#<cfelse></cfif></td>
        <td align="right">#numberformat(gettotaltaken.takendays,'.__')+ numberformat(gettotaltaken2.takendays,'.__')#</td>
        
        <cfset balance = numberformat(evaluate('getplacementinfo.#getleave.costcode#days'),'.__') + numberformat(cf,'.__') - numberformat(gettotaltaken.takendays,'.__') - numberformat(gettotaltaken2.takendays,'.__')>
        <td align="right"><cfif numberformat(evaluate('getplacementinfo.#getleave.costcode#days'),'.__') neq 0>#numberformat(balance,'.__')#<cfelse></cfif></td>
        <td align="right"><cfif claimable eq "Y"><cfset arrayappend(leaveclaimablearray,'Y')>#numberformat(gettotaltaken.outstandingclaim,'.__')#<cfelse>N/A<cfset arrayappend(leaveclaimablearray,'N')></cfif></td>
        </tr>
        <cfset arrayappend(leavearray,'#getleave.costcode#')>
        <cfset arrayappend(leavedesparray,'#getleave.desp#')>
        <cfif numberformat(evaluate('getplacementinfo.#getleave.costcode#days'),'.__') eq 0>
         <cfset arrayappend(leavebalarray,'999')>
        <cfelse>
        <cfset arrayappend(leavebalarray,'#numberformat(balance,'.__')#')>
        </cfif>
        
		</cfif>
        </cfloop>
        </table>
        <cfif ArrayLen(leavearray) neq 0>
        <table width="100%">
        <tr>
        <th colspan="100%" align="center"><div align="center">Leave Entry</div></th>
        </tr>
        <tr>
        <th>Type of Leave</th>
        <th>Start Date</th>
        <th>Start Date AM/PM</th>
        <th>End Date</th>
        <th>End Date AM/PM</th>
        <th>Leave Taken</th>
        <th>Leave Balance</th>
        <th>Claimable</th>
        <th>Remarks</th>
        <th>Contract End Date</th>
        <th>Action</th>
        </tr>
        <tr>
        
        <td>
        <select name="leavetype" id="leavetype" onchange="if(parseFloat(this.options[this.selectedIndex].id) == 999){document.getElementById('leavebal').style.display = 'none';} else {document.getElementById('leavebal').style.display = 'block';}document.getElementById('leavebal').value=parseFloat(this.options[this.selectedIndex].id)-parseFloat(document.getElementById('leavedays').value);if(this.options[this.selectedIndex].title == 'Y'){document.getElementById('claimableamt').style.display='block';document.getElementById('claimableamt').selectedIndex=1;}else{document.getElementById('claimableamt').style.display='none';document.getElementById('claimableamt').selectedIndex=0;}dateajaxfunction();">
        <cfloop from="1" to="#arraylen(leavearray)#" index="i">
        <option value="#leavearray[i]#" id="#leavebalarray[i]#" title="#leaveclaimablearray[i]#">#leavedesparray[i]#</option>
        </cfloop>
        </select>
        </td>
        <td>
        <input type="text" name="startdate" id="startdate"  size="12" />&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('startdate'));">
        </td>
        <td>
        <select name="startampm" id="startampm" onchange="dateajaxfunction();">
        <option value="FULL DAY">FULL DAY</option>
        <option value="AM">AM</option>
        <option value="PM">PM</option>
        </select>
        </td>
        <td>
        <input type="text" name="enddate" id="enddate" size="12" />&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('enddate'));">
        </td>
        <td>
        <select name="endampm" id="endampm" onchange="dateajaxfunction();">
        <option value="FULL DAY">FULL DAY</option>
        <option value="AM">AM</option>
        <option value="PM">PM</option>
        </select>
        </td>
        <td>
        <input type="text" name="leavedays" id="leavedays" size="5" value="0.00" onkeyup="document.getElementById('leavebal').value=(parseFloat(document.getElementById('leavetype').options[document.getElementById('leavetype').selectedIndex].id)-parseFloat(this.value)).toFixed(2);" />
        </td>
         <td>
        <input type="text" name="leavebal" id="leavebal" size="5" readonly="readonly" value="#numberformat(leavebalarray[1],'.__')#" <cfif leavebalarray[1] eq "999"> style="display:none"</cfif>/>
        </td>
        <td>
        <select name="claimableamt" id="claimableamt"   <cfif leaveclaimablearray[1] eq "N">style="display:none"</cfif>>
        <option value="N"  <cfif leaveclaimablearray[1] eq "N">Selected</cfif>>N</option>
        <option value="Y" <cfif leaveclaimablearray[1] eq "Y">Selected</cfif>>Y</option>
        </select>
        </td>
        <td>
        <input type="text" name="remarks" id="remarks" value="" /></td>
        <td></td>
        <td><input type="button" name="add_btn" id="add_btn" value="Add" onclick="addleave('','add');document.getElementById('search_btn').disabled==true;" /></td>
        </tr> 
        <cfquery name="getleavelist" datasource="#dts#">
        SELECT * FROM (
        SELECT * FROM leavelisttemp WHERE uuid = "#newuuid#" order by id) as a
        LEFT JOIN
        (SELECT desp, costcode FROM iccostcode) as b
        on a.leavetype = b.costcode
        ORDER BY a.contractenddate desc, a.leavetype, a.startdate desc
        </cfquery>
        <cfloop query="getleavelist">
        <tr>
        <td>#getleavelist.desp#</td>
        <td>#dateformat(getleavelist.startdate,'dd/mm/yyyy')#</td>
        <td>#getleavelist.startampm#</td>
        <td>#dateformat(getleavelist.enddate,'dd/mm/yyyy')#</td>
        <td>#getleavelist.endampm#</td>
        <td>#numberformat(getleavelist.days,'.__')#</td>
        <td></td>
        <td>#getleavelist.claimamount#</td>
        <td>#getleavelist.remarks#</td>
         <td <cfif huserid eq "adminbeps" or huserid eq "ultracai"> style="cursor:pointer"  onclick="editdate('#getleavelist.id#')"</cfif>>#dateformat(getleavelist.contractenddate,'dd/mm/yyyy')#</td>
        <td><a style="cursor:pointer" onclick="if(confirm('Are You Sure You Want To Delete?')){addleave('#getleavelist.id#','delete')}"><u>Delete</u></a></td>
        </tr>
        </cfloop>
        </table>
        <cfelse>
		<h1>No Any Entitle Leave Found</h1>
		</cfif>
        </cfoutput>
        </cfif>
