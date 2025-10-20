<cfsetting showdebugoutput="no">
<cfoutput>
<input type="button" name="timesheetbtn1" id="timesheetbtn1" value="View Time Sheet" onClick="ColdFusion.Window.show('timesheet');">
</cfoutput>
<cfset dsname = replace(dts,'_i','_p')>
<cfset dts2=replace(dts,'_i','','all')>
<cfquery name="getplacement" datasource="#dts#">
SELECT * FROM placement WHERE placementno = "#url.placementno#"
</cfquery>

 <cfquery name="company_details" datasource="payroll_main">
        SELECT * FROM gsetup WHERE comp_id = "#dts2#"
        </cfquery>
        
        <cfif val(company_details.mmonth) eq "13">
        <cfset company_details.mmonth = 12 >
        </cfif>
        
        <cfset currentdate = createdate(val(company_details.myear),val(company_details.mmonth),1)>
		
        <cfquery name="gettimesheet" datasource="#dsname#">
    SELECT * FROM timesheet WHERE empno = "#url.empno#" and tmonth = "#company_details.mmonth#" and editable = "Y" and stcol <> "" and stcol is not null and stcol <> "PH" ORDER BY tsrowcount
    </cfquery>
    
    <cfloop query="gettimesheet">

	<cfset noofdays = 0>
    <cfset dateclaimto = gettimesheet.pdate>
    <cfset dateclaimfrom = gettimesheet.pdate>
    
    <cfquery name="holiday_qry" datasource="#replace(dts,'_i','_p')#">
SELECT count(entryno) as totalholidays FROM holtable WHERE hol_date >= "#dateformat( dateclaimfrom,'YYYY-MM-DD')#" and hol_date <="#dateformat( dateclaimto,'YYYY-MM-DD')#"
</cfquery>
    
    <cfset startcount = 1>
	<cfquery name="getplacementdetail" datasource="#dts#">
    SELECT 
    <cfloop list="Sun,Mon,Tues,Wednes,Thurs,Fri,Satur" index="i">
    #i#totalhour as th#startcount#,
    #i#halfday as hd#startcount#,
    <cfset startcount = startcount + 1>
    </cfloop>
    placementno FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.placementno#">
    </cfquery>
    
    <cfset fulldaylist = ''>
    <cfset halfdaylist = ''>
    
    <cfloop from="1" to="7" index="a">
    <cfif val(evaluate('getplacementdetail.th#a#')) neq 0>
		<cfif evaluate('getplacementdetail.hd#a#') neq "Y">
        	<cfset fulldaylist = fulldaylist&a&",">
        <cfelse>
        	<cfset halfdaylist = halfdaylist&a&",">
        </cfif>    
	</cfif>
    </cfloop>
    
    <cfif holiday_qry.recordcount neq 0>
    <cfset holidaycount = 0>
     <cfquery name="gethollist" datasource="#replace(dts,'_i','_p')#">
SELECT hol_date FROM holtable WHERE hol_date >= "#dateformat( dateclaimfrom,'YYYY-MM-DD')#" and hol_date <="#dateformat( dateclaimto,'YYYY-MM-DD')#"
</cfquery>
    <cfloop query="gethollist">
    <cfif listfind(fulldaylist,DayOfWeek(gethollist.hol_date)) neq 0>
            <cfset holidaycount = holidaycount+1>
            <cfelseif listfind(halfdaylist,DayOfWeek(gethollist.hol_date)) neq 0>
            <cfset holidaycount = holidaycount+0.5>
            </cfif>
    </cfloop>
    
    <cfset holiday_qry.totalholidays = val(holidaycount)>
    
	</cfif>
    
    <cfset countdays = 0>
    
    <cfset noofdayscount = datediff('d',dateclaimfrom,dateclaimto)>
    <cfloop from="0" to="#noofdayscount#" index="i">
        <cfset currentdate = dateadd('d','#i#',dateclaimfrom)>
			<cfif listfind(fulldaylist,DayOfWeek(currentdate)) neq 0>
            <cfset countdays = countdays+1>
            <cfelseif listfind(halfdaylist,DayOfWeek(currentdate)) neq 0>
            <cfset countdays = countdays+0.5>
            </cfif>
        </cfloop>
   	    <cfset noofdays = countdays>
      
    <cfif gettimesheet.ampm neq "FULL DAY">
    <cfset noofdays = noofdays - 0.5>
	</cfif>

    <cfif noofdays lt 0>
    <cfset noofdays = 0 >
	</cfif>
	
    <cfif noofdays eq 0>
    <cfabort showerror="Time Sheet Not Tally With Placement! (#gettimesheet.stcol# submited on #dateformat(gettimesheet.pdate,'dd/mm/yyyy')# is not working days) Please do manual Calculation!">
	</cfif>

    </cfloop>
    
      <cfquery name="getleavegroup" datasource="#dsname#">
    SELECT stcol,sum(workhours) as totalwh FROM timesheet WHERE empno = "#url.empno#" and tmonth = "#company_details.mmonth#" and editable = "Y" and stcol <> "" and stcol is not null and stcol <> "PH" and stcol <> "NPL" GROUP BY stcol ORDER BY tsrowcount
    </cfquery>
    
    <cfloop query="getleavegroup">
    
    <cfif getleavegroup.stcol eq "AL">
    <cfset cf = evaluate('getplacement.#getleavegroup.stcol#bfdays')>
	<cfelse>
	<cfset cf = 0 >
	</cfif>
    
    
    
    <cfquery name="gettotaltaken" datasource="#dts#">
        SELECT sum(days) as takendays FROM leavelist WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.placementno#"> and leavetype = "#getleavegroup.stcol#"
        and contractenddate = "#dateformat(getplacement.completedate,'YYYY-MM-DD')#"
        </cfquery>
        
    <cfset balance = numberformat(evaluate('getplacement.#getleavegroup.stcol#days'),'.__') + numberformat(cf,'.__') - numberformat(gettotaltaken.takendays,'.__')>
    <cfset "#getleavegroup.stcol#bal" = balance>
    <cfset "#getleavegroup.stcol#hours" = val(getleavegroup.totalwh)>
    <cfquery name="getleave" datasource="#dsname#">
    SELECT * FROM timesheet WHERE empno = "#url.empno#" and tmonth = "#company_details.mmonth#" and editable = "Y" and stcol = "#getleavegroup.stcol#" ORDER BY tsrowcount
    </cfquery>
    <cfset startcount = 0 >
    
    <cfloop query="getleave">
    <cfif getleave.ampm eq "FULL DAY" or getleave.ampm eq "">
    <cfset startcount = startcount + 1>
    <cfelse>
    <cfset startcount = startcount + 0.5>
	</cfif>
    </cfloop>
    
    <cfset "#getleavegroup.stcol#days" = startcount>
    
    <cfif numberformat(startcount,'.__') gt numberformat(val(balance),'.__')>
     <cfabort showerror="Time Sheet Not Tally With Placement! (#gettimesheet.stcol# submited is over the entitle allowed) Please do manual Calculation!">
    </cfif>
    
    </cfloop>
    
    
      <cfloop query="gettimesheet">

	<cfset noofdays = 0>
    <cfset dateclaimto = gettimesheet.pdate>
    <cfset dateclaimfrom = gettimesheet.pdate>
    
    <cfquery name="holiday_qry" datasource="#replace(dts,'_i','_p')#">
SELECT count(entryno) as totalholidays FROM holtable WHERE hol_date >= "#dateformat( dateclaimfrom,'YYYY-MM-DD')#" and hol_date <="#dateformat( dateclaimto,'YYYY-MM-DD')#"
</cfquery>
    
    <cfset startcount = 1>
	<cfquery name="getplacementdetail" datasource="#dts#">
    SELECT 
    <cfloop list="Sun,Mon,Tues,Wednes,Thurs,Fri,Satur" index="i">
    #i#totalhour as th#startcount#,
    #i#halfday as hd#startcount#,
    <cfset startcount = startcount + 1>
    </cfloop>
    placementno FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.placementno#">
    </cfquery>
    
    <cfset fulldaylist = ''>
    <cfset halfdaylist = ''>
    
    <cfloop from="1" to="7" index="a">
    <cfif val(evaluate('getplacementdetail.th#a#')) neq 0>
		<cfif evaluate('getplacementdetail.hd#a#') neq "Y">
        	<cfset fulldaylist = fulldaylist&a&",">
        <cfelse>
        	<cfset halfdaylist = halfdaylist&a&",">
        </cfif>    
	</cfif>
    </cfloop>
    
    <cfif holiday_qry.recordcount neq 0>
    <cfset holidaycount = 0>
     <cfquery name="gethollist" datasource="#replace(dts,'_i','_p')#">
SELECT hol_date FROM holtable WHERE hol_date >= "#dateformat( dateclaimfrom,'YYYY-MM-DD')#" and hol_date <="#dateformat( dateclaimto,'YYYY-MM-DD')#"
</cfquery>
    <cfloop query="gethollist">
    <cfif listfind(fulldaylist,DayOfWeek(gethollist.hol_date)) neq 0>
            <cfset holidaycount = holidaycount+1>
            <cfelseif listfind(halfdaylist,DayOfWeek(gethollist.hol_date)) neq 0>
            <cfset holidaycount = holidaycount+0.5>
            </cfif>
    </cfloop>
    
    <cfset holiday_qry.totalholidays = val(holidaycount)>
    
	</cfif>
    
    <cfset countdays = 0>
    
    <cfset noofdayscount = datediff('d',dateclaimfrom,dateclaimto)>
    <cfloop from="0" to="#noofdayscount#" index="i">
        <cfset currentdate = dateadd('d','#i#',dateclaimfrom)>
			<cfif listfind(fulldaylist,DayOfWeek(currentdate)) neq 0>
            <cfset countdays = countdays+1>
            <cfelseif listfind(halfdaylist,DayOfWeek(currentdate)) neq 0>
            <cfset countdays = countdays+0.5>
            </cfif>
        </cfloop>
   	    <cfset noofdays = countdays>
      
    <cfif gettimesheet.ampm neq "FULL DAY">
    <cfset noofdays = noofdays - 0.5>
	</cfif>

    <cfif noofdays lt 0>
    <cfset noofdays = 0 >
	</cfif>
	
    <cfif noofdays neq 0>
    
    <cfquery name="checkexist" datasource="#dts#">
    SELECT id from placementleave WHERE placementno = "#url.placementno#" ORDER BY created_on desc
    </cfquery>
    
    <cfif checkexist.recordcount eq 0>
    <cfquery datasource="#dts#" name="insertartran">
    	Insert into placementleave(
        						placementno,
                                created_by,
                                created_on
                                )
                                
        value(
        		<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.placementno#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getAuthUser()#">,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">
                )  
    	</cfquery>
        
     <cfquery name="getlastid" datasource="#dts#">
            SELECT LAST_INSERT_ID() as lastid
          </cfquery>
          
          <cfset lastid = getlastid.lastid>
          
    <cfelse>
    
    <cfset lastid = checkexist.id>   
	</cfif>
    
     <cfquery name="checkclaim" datasource="#dts#">
        Select claimable from iccostcode order by costcode
        </cfquery>
    
    
     <cfquery name="insertleave" datasource="#dts#">
                    INSERT INTO leavelist
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
                    placementleaveid,
                    contractenddate
                    )
                    VALUES
                    (
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.placementno#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettimesheet.stcol#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(noofdays)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#checkclaim.claimable#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettimesheet.remarks#">,
                    "#dateformat(gettimesheet.pdate,'YYYY-MM-DD')#",
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettimesheet.ampm#">,
                    "#dateformat(gettimesheet.pdate,'YYYY-MM-DD')#",
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettimesheet.ampm#">,
                    <cfif isdefined('#gettimesheet.stcol#bal')>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(evaluate('#gettimesheet.stcol#bal'))#">,
                    <cfelse>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                    </cfif>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#lastid#">,
                    "#dateformat(getplacement.completedate,'YYYY-MM-DD')#"
                    )
                    </cfquery>
	</cfif>

    </cfloop>
    
    
    <cfoutput>
    <cfquery name="getall" datasource="#dsname#">
    SELECT sum(workhours) as wh FROM timesheet WHERE empno = "#url.empno#" and tmonth = "#company_details.mmonth#" and editable = "Y" AND (stcol = "" or stcol is null)
    </cfquery>
    
    <cfquery name="getot" datasource="#dsname#">
    SELECT sum(othour) as oth FROM timesheet WHERE empno = "#url.empno#" and tmonth = "#company_details.mmonth#" and editable = "Y"
    </cfquery>
    
    <cfquery name="getalldays" datasource="#dsname#">
    SELECT * FROM timesheet WHERE empno = "#url.empno#" and tmonth = "#company_details.mmonth#" and editable = "Y"
    </cfquery>
    
    <cfset daycount = 0 >
    <cfset daycountwork = 0 >
    <cfset daycountwork2 = 0 >
    <cfloop query="getalldays">
    
    <cfif val(getalldays.workhours) neq 0>
		<cfif getalldays.halfday eq "Y">
        <cfset daycount = daycount + 0.5 > 
			<cfif getalldays.stcol eq "">
            <cfset daycountwork = daycountwork + 0.5 >
            </cfif>
			<cfif getalldays.stcol neq "NPL">
            <cfset daycountwork2 = daycountwork2 + 0.5 >
            </cfif>
        <cfelse>
        <cfset daycount = daycount + 1 > 
        
        	<cfif getalldays.stcol eq "">
            <cfset daycountwork = daycountwork + 1 >
            </cfif>
             <cfif getalldays.stcol neq "" and getalldays.ampm neq "FULL DAY" and getalldays.ampm neq "">
            <cfset daycountwork = daycountwork + 0.5 >
            </cfif>
			<cfif getalldays.stcol neq "NPL">
            <cfset daycountwork2 = daycountwork2 + 1 >
            </cfif>
        </cfif>
        
    </cfif>
    
    </cfloop>
    
    <table>
    <tr>
    <th colspan="100%">TIME SHEET RECORDS</th>
    </tr>
    <cfif getplacement.clienttype eq "hr">
    <tr>
    <th>Hours Worked</th>
    <td> <input type="text" name="tstotalhour" id="tstotalhour" value="#val(getall.wh)#" readonly="readonly"></td>
    </tr>
    <cfelse>
    <tr>
    <th>Days Worked</th>
    <td> <cfif getplacement.clienttype eq "mth"><input type="text" name="tstotaldw" id="tstotaldw" value="#val(daycountwork2)#" readonly="readonly"><cfelse><input type="text" name="tstotaldaysw" id="tstotaldaysw" value="#val(daycountwork)#" readonly="readonly"></cfif></td>
    </tr>
    </cfif>
    <tr>
    <th>Over Time</th>
    <td><input type="text" name="tstotalovertime" id="tstotalovertime" value="#val(getot.oth)#" readonly="readonly"></td>
    </tr>
    
    <cfloop query="getleavegroup">
    <cfif getplacement.clienttype eq "hr">
    <cfif isdefined("#getleavegroup.stcol#hours")>
    <tr>
    <th>#getleavegroup.stcol# Hours</th>
    <td><input type="text" readonly="readonly" name="ts#getleavegroup.stcol#hours" id="ts#getleavegroup.stcol#hours" value="#val(evaluate("#getleavegroup.stcol#hours"))#"></td>
    </tr>
    
	</cfif>
    </cfif>
    <cfif getplacement.clienttype eq "day">
     <cfif isdefined("#getleavegroup.stcol#days")>
     <tr>
    <th>#getleavegroup.stcol# Days</th>
    <td><input type="text" name="ts#getleavegroup.stcol#days" id="ts#getleavegroup.stcol#days" value="#val(evaluate("#getleavegroup.stcol#days"))#" readonly="readonly"></td>
    </tr>
    
	</cfif>
    </cfif>
    </cfloop>
    
    </table>
    <input type="hidden" name="tstotalhour" id="tstotalhour" value="#val(getall.wh)#" readonly="readonly">
    <input type="hidden" name="tstotalovertime" id="tstotalovertime" value="#val(getot.oth)#">
    <input type="hidden" name="tstotalwd" id="tstotalwd" value="#val(daycount)#">
     <input type="hidden" name="tstotaldw" id="tstotaldw" value="#val(daycountwork2)#">
    <input type="hidden" name="tstotaldaysw" id="tstotaldaysw" value="#val(daycountwork)#">
    <cfloop query="getleavegroup">
    <cfif isdefined("#getleavegroup.stcol#hours")>
    <input type="hidden" name="ts#getleavegroup.stcol#hours" id="ts#getleavegroup.stcol#hours" value="#val(evaluate("#getleavegroup.stcol#hours"))#">
	</cfif>
     <cfif isdefined("#getleavegroup.stcol#days")>
    <input type="hidden" name="ts#getleavegroup.stcol#days" id="ts#getleavegroup.stcol#days" value="#val(evaluate("#getleavegroup.stcol#days"))#">
	</cfif>
    </cfloop>
    
    <cfquery name="locktimesheet" datasource="#dsname#">
    UPDATE timesheet SET editable = "N" WHERE empno = "#url.empno#" and tmonth = "#company_details.mmonth#" and editable = "Y"
    </cfquery>
    
    </cfoutput>
    
    
    
   
    