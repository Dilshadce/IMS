<cfif isdefined('url.type') eq false>
<cfabort>
</cfif>
<cfset bgcolor = "##FFFFBD">
<cfset dts1 = replace(dts,'_i','_p')>

<cfinclude template="/object/dateobject.cfm">
<cfif url.type eq "create">
<cfquery name="getplacement" datasource="#dts#">
SELECT * FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#">
</cfquery>




<cfquery name="getplacementleave" datasource="#dts#">
SELECT * FROM leavelist WHERE  placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#"> and leavetype <> "NS"
<cfif url.startdate neq "" and url.enddate neq "">
and startdate >= "#lsdateformat((url.startdate),'YYYY-MM-DD', 'en_AU')#"
and enddate <= "#lsdateformat((url.enddate),'YYYY-MM-DD', 'en_AU')#"
</cfif>
ORDER BY leavetype, startdate
</cfquery>

<cfquery name="holiday_qry" datasource="#replace(dts,'_i','_p')#">
SELECT entryno,Hol_Date,hol_desp FROM holtable WHERE 
hol_date >= "#lsdateformat((url.startdate),'YYYY-MM-DD', 'en_AU')#"
and hol_date <="#lsdateformat((url.enddate),'YYYY-MM-DD', 'en_AU')#"
</cfquery>




<cfset datestartof = createdate(listlast(URLDECODE(url.startdate),'/'),listgetat(URLDECODE(url.startdate),'2','/'),listfirst(URLDECODE(url.startdate),'/'))>
<cfset dateendof = createdate(listlast(URLDECODE(url.enddate),'/'),listgetat(URLDECODE(url.enddate),'2','/'),listfirst(URLDECODE(url.enddate),'/'))>


    <cfset startcount = 1>
	<cfquery name="getplacementdetail" datasource="#dts#">
    SELECT 
    <cfloop list="Sun,Mon,Tues,Wednes,Thurs,Fri,Satur" index="i">
    #i#totalhour as th#startcount#,
    #i#halfday as hd#startcount#,
    <cfset startcount = startcount + 1>
    </cfloop>
    placementno FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#">
    </cfquery>
    
    <cfset fulldaylist = '1,2,3,4,5,6,7'>
    <cfset halfdaylist = ''>
    
<!---     <cfloop from="1" to="7" index="a">
    <cfif val(evaluate('getplacementdetail.th#a#')) neq 0>
		<cfif evaluate('getplacementdetail.hd#a#') neq "Y">
        	<cfset fulldaylist = fulldaylist&a&",">
        <cfelse>
        	<cfset halfdaylist = halfdaylist&a&",">
        </cfif>    
	</cfif>
    </cfloop> --->
    
    <cfset holidaycount = 0>
    <cfif holiday_qry.recordcount neq 0>
    <cfset holidaycount = 0>
     <cfquery name="gethollist" datasource="#replace(dts,'_i','_p')#">
SELECT hol_date FROM holtable WHERE hol_date >= "#lsdateformat( datestartof,'YYYY-MM-DD', 'en_AU')#" and hol_date <="#lsdateformat( dateendof,'YYYY-MM-DD', 'en_AU')#"
</cfquery>
    <cfloop query="gethollist">
    <cfif listfind(fulldaylist,DayOfWeek(gethollist.hol_date)) neq 0>
            <cfset holidaycount = holidaycount+1>
            <cfelseif listfind(halfdaylist,DayOfWeek(gethollist.hol_date)) neq 0>
            <cfset holidaycount = holidaycount+0.5>
            </cfif>
    </cfloop>
    
    
	</cfif>
    



<!--- Basic Rate --->
<cfset firsteffdatelist = "">
<cfset secondeffdatelist = "">
<cfset firstemployeepay = 0>
<cfset firstemployerpay = 0>
<cfset secondemployeepay = 0>
<cfset secondemployerpay = 0>

<cfif evaluate('getplacement.eff_d_1') gt datestartof>
<cfoutput>
<h1 align="center" style="color:##F00">Check Pay Effective Date!</h1>
</cfoutput>
<cfabort>
</cfif>

<cfloop from="5" to="1" index="i" step="-1">
<cfif evaluate('getplacement.eff_d_#i#') neq "">
<cfset datestartwork = evaluate('getplacement.eff_d_#i#')>
<cfset datestartwork = createdate(year(datestartwork),month(datestartwork),day(datestartwork))>


	<cfif datestartwork lte dateendof>
    <cfset employeepay = evaluate('getplacement.employee_rate_#i#')>
    <cfset employerpay = evaluate('getplacement.employer_rate_#i#')>
    
   
    
		<cfif getplacement.clienttype eq "mth" and i neq 1 and month(datestartwork) eq month(datestartof) and year(datestartwork) eq year(datestartof) and day(datestartwork) neq day(datestartof)>
        <cfset activateeffcal = 1>
			<cfset totalday = abs(datediff('d',datestartof,dateendof)) + 1>
            <cfset countdays = 0>
            <cfset noofdayscount = abs(datediff('d',datestartof,datestartwork))-1>

            
            
            
            
            <cfloop from="0" to="#noofdayscount#" index="aa">
                <cfset currentdate = dateadd('d','#aa#',datestartof)>
                
         	<cfif listfind(fulldaylist,DayOfWeek(currentdate)) neq 0>
            <cfset countdays = countdays+1>
            <cfelseif listfind(halfdaylist,DayOfWeek(currentdate)) neq 0>
            <cfset countdays = countdays+0.5>
            </cfif>
            
               
            </cfloop>
            <cfset oldrateday = val(countdays)>
            
            <cfset noofdayscount = abs(datediff('d',datestartwork,dateendof))>
            <cfset countdays = 0>
            
            <cfloop from="0" to="#noofdayscount#" index="aa">
                <cfset currentdate = dateadd('d','#aa#',datestartwork)>
                <cfif listfind(fulldaylist,DayOfWeek(currentdate)) neq 0>
            <cfset countdays = countdays+1>
            <cfelseif listfind(halfdaylist,DayOfWeek(currentdate)) neq 0>
            <cfset countdays = countdays+0.5>
            </cfif>
            </cfloop>
            <cfset newrateday = countdays>
        
            <cfset oldratedaynew = abs(datediff('d',datestartwork,datestartof))>
            
            <cfloop from="0" to="#val(oldratedaynew)-1#" index="a">
            <cfset currentdate = dateadd('d','#a#',datestartof)>
            <cfset firsteffdatelist = firsteffdatelist&lsdateformat(currentdate,'dd/mm/yyyy', 'en_AU')>
            <cfif a neq val(oldratedaynew)-1>
            <cfset firsteffdatelist = firsteffdatelist&",">
			</cfif>
            </cfloop>
            <cfset firstemployeepay = evaluate('getplacement.employee_rate_#i-1#')>
            <cfset firstemployerpay = evaluate('getplacement.employer_rate_#i-1#')>
            
			<cfset employeepayold = evaluate('getplacement.employee_rate_#i-1#') * val(oldrateday)/(val(oldrateday) + val(newrateday))>
            <cfset employerpayold = evaluate('getplacement.employer_rate_#i-1#') * val(oldrateday)/(val(oldrateday) + val(newrateday))>

			<cfset newratedaynew = abs(datediff('d',dateendof,datestartwork))+1>
             <cfloop from="0" to="#val(newratedaynew)-1#" index="b">
            <cfset currentdate = dateadd('d','#b#',datestartwork)>
            <cfset secondeffdatelist = secondeffdatelist&lsdateformat(currentdate,'dd/mm/yyyy', 'en_AU')>
            <cfif i neq val(newratedaynew)-1>
            <cfset secondeffdatelist = secondeffdatelist&",">
			</cfif>
            </cfloop>
            
            <cfset employeepaynew = evaluate('getplacement.employee_rate_#i#') * val(newrateday)/(val(oldrateday) + val(newrateday))>
            <cfset employerpaynew = evaluate('getplacement.employer_rate_#i#') * val(newrateday)/(val(oldrateday) + val(newrateday))>
            <cfset employeepay = numberformat(employeepayold + employeepaynew,'.__')>
            <cfset employerpay = numberformat(employerpayold + employerpaynew,'.__')>
             <cfset secondemployeepay = evaluate('getplacement.employee_rate_#i#')>
            <cfset secondemployerpay = evaluate('getplacement.employer_rate_#i#')>
           <cfset realdatediff = val(oldrateday) + val(newrateday)> 
           
           
           <cfbreak>
            
        <cfelseif (getplacement.clienttype eq "day" or getplacement.clienttype eq "hr") and i neq 1 and month(datestartwork) eq month(datestartof) and year(datestartwork) eq year(datestartof) and day(datestartwork) gt day(datestartof)>
        <cfset activateeffcal = 1>
        
        <cfset oldrateday = abs(datediff('d',datestartwork,datestartof))>
            <cfloop from="0" to="#val(oldrateday)-1#" index="a">
            <cfset currentdate = dateadd('d','#a#',datestartof)>
            <cfset firsteffdatelist = firsteffdatelist&lsdateformat(currentdate,'dd/mm/yyyy', 'en_AU')>
            <cfif i neq val(oldrateday)-1>
            <cfset firsteffdatelist = firsteffdatelist&",">
			</cfif>
            </cfloop>
            <cfset firstemployeepay = evaluate('getplacement.employee_rate_#i-1#')>
            <cfset firstemployerpay = evaluate('getplacement.employer_rate_#i-1#')>
            
            <cfset newrateday = abs(datediff('d',dateendof,datestartwork))+ 1>
            <cfloop from="0" to="#val(newrateday)-1#" index="b">
            <cfset currentdate = dateadd('d','#b#',datestartwork)>
            <cfset secondeffdatelist = secondeffdatelist&lsdateformat(currentdate,'dd/mm/yyyy', 'en_AU')>
            <cfif i neq val(newrateday)-1>
            <cfset secondeffdatelist = secondeffdatelist&",">
			</cfif>
            </cfloop>
            <cfset secondemployeepay = evaluate('getplacement.employee_rate_#i#')>
            <cfset secondemployerpay = evaluate('getplacement.employer_rate_#i#')>
            
            <cfset realdatediff = abs(datediff('d',datestartof,dateendof))+1>
            
            <cfset countdays = 0>
            <cfset noofdayscount = abs(datediff('d',datestartof,datestartwork))-1>
            
            <cfloop from="0" to="#noofdayscount#" index="aa">
                <cfset currentdate = dateadd('d','#aa#',datestartof)>
                <cfif listfind(fulldaylist,DayOfWeek(currentdate)) neq 0>
            <cfset countdays = countdays+1>
            <cfelseif listfind(halfdaylist,DayOfWeek(currentdate)) neq 0>
            <cfset countdays = countdays+0.5>
            </cfif>
            </cfloop>
            <cfset oldrateday = val(countdays)>
            
            <cfset noofdayscount = abs(datediff('d',datestartwork,dateendof))>
            <cfset gethalfday = 0>
            <cfset countdays = 0>
           
            <cfloop from="0" to="#noofdayscount#" index="aa">
                <cfset currentdate = dateadd('d','#aa#',datestartwork)>
                <cfif listfind(fulldaylist,DayOfWeek(currentdate)) neq 0>
            <cfset countdays = countdays+1>
            <cfelseif listfind(halfdaylist,DayOfWeek(currentdate)) neq 0>
            <cfset countdays = countdays+0.5>
            </cfif>
            </cfloop>
            <cfset newrateday = countdays>
            
              <cfbreak>
        </cfif>
        <cfbreak>
	</cfif>
</cfif>	
</cfloop>

<cfif isdefined('activateeffcal') >
<cfset NPLdeductamount = 0>
<cfset firstnplval = 0>
<cfset secondnplval = 0 >
<cfset firstdaysval = 0>
<cfset seconddaysval = 0 >


<cfif getplacement.clienttype eq "mth">

    <cfquery name="getNPL" datasource="#dts#">
        SELECT * FROM leavelist WHERE  
        placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#"> 
        and startdate >= "#lsdateformat((url.startdate),'YYYY-MM-DD', 'en_AU')#"
        and enddate <= "#lsdateformat((url.enddate),'YYYY-MM-DD', 'en_AU')#"
        and leavetype = "NPL"
    </cfquery>
    
<cfelseif getplacement.clienttype eq "day">

<cfquery name="getNPL" datasource="#dts#">
    SELECT days,startdate FROM leavelist WHERE  
    placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#"> 
    and leavetype <> "NS"
    <cfif url.startdate neq "" and url.enddate neq "">
    and startdate >= "#lsdateformat((url.startdate),'YYYY-MM-DD', 'en_AU')#"
    and enddate <= "#lsdateformat((url.enddate),'YYYY-MM-DD', 'en_AU')#"
    </cfif>
</cfquery>
	
</cfif>    

<cfif  getplacement.clienttype eq "mth" or getplacement.clienttype eq "day" >
    <cfloop query="getNPL">
    	<cfif listfind(firsteffdatelist,lsdateformat(getNPL.startdate,'dd/mm/yyyy', 'en_AU')) neq 0>
        <cfset firstnplval = firstnplval + val(getNPL.days)>
        <cfelseif listfind(secondeffdatelist,lsdateformat(getNPL.startdate,'dd/mm/yyyy', 'en_AU')) neq 0>
        <cfset secondnplval = secondnplval + val(getNPL.days)>
        <cfelse>
        <cfset secondnplval = secondnplval + val(getNPL.days)>
		</cfif>
    </cfloop>
    
    
    
    
    <cfif getplacement.clienttype eq "mth">

    <cfset firsteepay = firstemployeepay * (val(oldrateday) - val(firstnplval)) / val(realdatediff)>
    <cfset firsterpay = firstemployerpay * (val(oldrateday) - val(firstnplval)) / val(realdatediff)>
     <cfset secondeepay = secondemployeepay * (val(newrateday) - val(secondnplval)) / val(realdatediff)>
    <cfset seconderpay = secondemployerpay * (val(newrateday) - val(secondnplval)) / val(realdatediff)>
    <cfset selfsalaryrecord = numberformat(firsteepay+0.0000001,'.__') + numberformat(secondeepay+0.0000001,'.__')>
    <cfset custsalaryrecord = numberformat(firsterpay+0.0000001,'.__') + numberformat(seconderpay+0.0000001,'.__')>
	<cfelseif getplacement.clienttype eq "day">
    
    <cfset noofdayscount = abs(datediff('d',datestartof,dateendof))>
    
		
        
        <cfloop query="holiday_qry">
        
			<cfif listfind(halfdaylist,DayOfWeek(holiday_qry.Hol_Date)) neq 0>
            
            <cfif listfind(firsteffdatelist,lsdateformat(holiday_qry.Hol_Date,'dd/mm/yyyy', 'en_AU')) neq 0>
                <cfset firstnplval = firstnplval + 0.5>
            <cfelseif listfind(secondeffdatelist,lsdateformat(holiday_qry.Hol_Date,'dd/mm/yyyy', 'en_AU')) neq 0>
                <cfset secondnplval = secondnplval + 0.5>
            <cfelse>
                <cfset secondnplval = secondnplval + 0.5>
            </cfif>
            
            <cfelseif listfind(fulldaylist,DayOfWeek(holiday_qry.Hol_Date)) neq 0>
            
             <cfif listfind(firsteffdatelist,lsdateformat(holiday_qry.Hol_Date,'dd/mm/yyyy', 'en_AU')) neq 0>
                <cfset firstnplval = firstnplval + 1>
            <cfelseif listfind(secondeffdatelist,lsdateformat(holiday_qry.Hol_Date,'dd/mm/yyyy', 'en_AU')) neq 0>
                <cfset secondnplval = secondnplval + 1>
            <cfelse>
                <cfset secondnplval = secondnplval + 1>
            </cfif>
            
            </cfif>
        
        </cfloop>
        
       
        
           <cfloop from="0" to="#noofdayscount#" index="i">
            <cfset currentdate = dateadd('d','#i#',datestartof)>
			<cfif listfind(halfdaylist,DayOfWeek(currentdate)) neq 0>
            
			<cfif listfind(firsteffdatelist,lsdateformat(currentdate,'dd/mm/yyyy', 'en_AU')) neq 0>
                <cfset firstdaysval = firstdaysval + 0.5>
            <cfelseif listfind(secondeffdatelist,lsdateformat(currentdate,'dd/mm/yyyy', 'en_AU')) neq 0>
                <cfset seconddaysval = seconddaysval + 0.5>
            <cfelse>
                <cfset seconddaysval = seconddaysval + 0.5>
            </cfif>
            
            <cfelseif listfind(fulldaylist,DayOfWeek(currentdate)) neq 0>
            
           	<cfif listfind(firsteffdatelist,lsdateformat(currentdate,'dd/mm/yyyy', 'en_AU')) neq 0>
                <cfset firstdaysval = firstdaysval + 1>
            <cfelseif listfind(secondeffdatelist,lsdateformat(currentdate,'dd/mm/yyyy', 'en_AU')) neq 0>
                <cfset seconddaysval = seconddaysval + 1>
            <cfelse>
                <cfset seconddaysval = seconddaysval + 1>
            </cfif>
           
            </cfif>
           </cfloop>
        
       
            
        
        <cfset firsteepay = firstemployeepay * (val(firstdaysval) - val(firstnplval))>
		<cfset firsterpay = firstemployerpay * (val(firstdaysval) - val(firstnplval))>
         <cfset secondeepay = secondemployeepay * (val(seconddaysval) - val(secondnplval))>
        <cfset seconderpay = secondemployerpay * (val(seconddaysval) - val(secondnplval))>
        <cfset selfsalaryrecord = numberformat(firsteepay+0.0000001,'.__') + numberformat(secondeepay+0.0000001,'.__')>
        <cfset custsalaryrecord = numberformat(firsterpay+0.0000001,'.__') + numberformat(seconderpay+0.0000001,'.__')>
	</cfif>
    </cfif>
</cfif>



<!--- Working Days --->

  <cfset countdays = 0>
    	<cfset noofdayscount = abs(datediff('d',datestartof,dateendof))>
        
  <cfloop from="0" to="#noofdayscount#" index="i">
        <cfset currentdate = dateadd('d','#i#',datestartof)>
			 <cfif listfind(fulldaylist,DayOfWeek(currentdate)) neq 0>
            <cfset countdays = countdays+1>
            <cfelseif listfind(halfdaylist,DayOfWeek(currentdate)) neq 0>
            <cfset countdays = countdays+0.5>
            </cfif>
        </cfloop>
   	    <cfset noofdays = countdays>
       
        

    <!---<cfquery name="getplacementleavenpl" datasource="#dts#">
SELECT sum(days) as days,leavetype FROM leavelist WHERE  placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#"> and leavetype = "NPL"
<cfif url.startdate neq "" and url.enddate neq "">
and startdate >= "#lsdateformat((url.startdate),'YYYY-MM-DD', 'en_AU')#"
and enddate <= "#lsdateformat((url.enddate),'YYYY-MM-DD', 'en_AU')#"
</cfif>
ORDER BY leavetype, startdate
</cfquery>--->

<!---added status filter, [20170222, Alvin]--->
    <cfquery name="getplacementleavenpl" datasource="#dts#">
    SELECT sum(days) as days,leavetype FROM leavelist WHERE  placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#"> and leavetype = "NPL"
    <cfif url.startdate neq "" and url.enddate neq "">
        and startdate >= "#lsdateformat(url.startdate,'YYYY-MM-DD', 'en_AU')#"
        and enddate <= "#lsdateformat(url.enddate,'YYYY-MM-DD', 'en_AU')#"
    </cfif>
    AND status = 'Approved'
    ORDER BY leavetype, startdate
    </cfquery>
<!---added status filter--->

<cfquery name="getplacementleavens" datasource="#dts#">
SELECT * FROM leavelist WHERE  placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#"> and leavetype = "NS"
<cfif url.startdate neq "" and url.enddate neq "">
and startdate >= "#lsdateformat((url.startdate),'YYYY-MM-DD', 'en_AU')#"
and enddate <= "#lsdateformat((url.enddate),'YYYY-MM-DD', 'en_AU')#"
</cfif>
ORDER BY leavetype, startdate
</cfquery>

<cfquery name="getleavedays" datasource="#dts#">
    SELECT sum(days) as days,leavetype FROM leavelist WHERE  placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#"> and leavetype <> "NS"
    <cfif url.startdate neq "" and url.enddate neq "">
    and startdate >= "#lsdateformat((url.startdate),'YYYY-MM-DD', 'en_AU')#"
    and enddate <= "#lsdateformat((url.enddate),'YYYY-MM-DD', 'en_AU')#"
    </cfif>
    ORDER BY leavetype, startdate
</cfquery>



<cfif getplacementleavenpl.recordcount neq 0>
	<cfset totalnpl = val(getplacementleavenpl.days)>
<cfelse>
	<cfset totalnpl = 0>
</cfif>

<cfif getplacementleavenpl.recordcount neq 0>
</cfif>

<cfset selfsalarydayrecord = noofdays>
<cfset custsalarydayrecord = noofdays>
<cfset nplrecord = 0>
<cfset custnplrecord = 0>
<cfif totalnpl neq 0>
<cfset selfsalarydayrecord = val(selfsalarydayrecord) - val(totalnpl)>
<cfset nplrecord = totalnpl>
<cfset custsalarydayrecord = val(custsalarydayrecord) - val(totalnpl)>
<cfset custnplrecord = totalnpl>
</cfif>

<cfif getplacement.clienttype eq "hr">
<cfset selfsalarydayrecord = val(noofdays) - val(getleavedays.days)-val(holidaycount)>
<cfset custsalarydayrecord = val(noofdays) - val(getleavedays.days)-val(holidaycount)>
<cfelseif  getplacement.clienttype eq "day">
<cfset dayholidayday =holidaycount >

<cfset selfsalarydayrecord = val(noofdays) - val(getleavedays.days)-val(dayholidayday)>
<cfset custsalarydayrecord = val(noofdays) - val(getleavedays.days)-val(dayholidayday)>

</cfif>




<cfset totalfirstdaysnpl = 0>
<cfset totalseconddaysnpl = 0>

<cfquery name="getnpldays" datasource="#dts#">
SELECT startdate,enddate,leavetype,days,startampm,endampm FROM leavelist WHERE  
placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#"> 
and leavetype <> "NS"
<cfif url.startdate neq "" and url.enddate neq "">
and startdate >= "#lsdateformat((url.startdate),'YYYY-MM-DD', 'en_AU')#"
and enddate <= "#lsdateformat((url.enddate),'YYYY-MM-DD', 'en_AU')#"
</cfif>
ORDER BY leavetype, startdate
</cfquery>

<cfset npldays = ""><cfset nplhour = 0><cfset monthnplhour = 0>
<cfif getnpldays.recordcount neq 0>
<cfset holidaylist = "">
<cfif getplacement.phdate eq "">
<cfset getplacement.phdate = createdate('1986','7',11)>
</cfif>
<cfif getplacement.phbillable eq "Y" or getplacement.phpayable eq "Y">
<cfloop query="holiday_qry">
<cfset holidaydate = createdate(year(holiday_qry.Hol_Date),month(holiday_qry.Hol_Date),day(holiday_qry.Hol_Date))>
<cfif holidaydate gte createdate(year(getplacement.phdate),month(getplacement.phdate),day(getplacement.phdate)) and (listfind(fulldaylist,DayOfWeek(holidaydate)) neq 0 or  listfind(halfdaylist,DayOfWeek(holidaydate)) neq 0)>
<cfset holidaylist = holidaylist&lsdateformat(holidaydate,'dd/mm/yyyy', 'en_AU')&",">
</cfif>

</cfloop>

</cfif>

        
		<cfset noofdayscount = abs(datediff('d',datestartof,dateendof))>
        
    <cfloop query="getnpldays">
    	<cfset "leavecount#getnpldays.currentrow#" = 0>
        <cfset "#getnpldays.leavetype#list" = "">
    	<cfset nplstartdate = createdate(year(getnpldays.startdate),month(getnpldays.startdate),day(getnpldays.startdate))>
        <cfset nplenddate = createdate(year(getnpldays.enddate),month(getnpldays.enddate),day(getnpldays.enddate))>
        <cfset nowcounthour = 0 >
    	<cfset nonplcount = abs(datediff('d',nplstartdate,nplenddate))>
         <cfloop from="0" to="#nonplcount#" index="i">
            <cfset currentdate = dateadd('d','#i#',nplstartdate)>
            <cfif  (listfind(fulldaylist,DayOfWeek(currentdate)) neq 0 or  listfind(halfdaylist,DayOfWeek(currentdate)) neq 0) and listfind(holidaylist,lsdateformat(currentdate,'dd/mm/yyyy', 'en_AU')) eq 0>
            <cfif DayOfWeek(currentdate) eq "1">
            <cfset ivar = "sun">
            <cfelseif DayOfWeek(currentdate) eq "2">
            <cfset ivar = "mon">
            <cfelseif DayOfWeek(currentdate) eq "3">
            <cfset ivar = "tues">
            <cfelseif DayOfWeek(currentdate) eq "4">
            <cfset ivar = "Wednes">
            <cfelseif DayOfWeek(currentdate) eq "5">
            <cfset ivar = "Thurs">
            <cfelseif DayOfWeek(currentdate) eq "6">
            <cfset ivar = "Fri">
            <cfelseif DayOfWeek(currentdate) eq "7">
            <cfset ivar = "Satur">
			</cfif>
            <cfif i eq 0 and getnpldays.startampm neq "FULL DAY" and listfind(halfdaylist,DayOfWeek(currentdate)) eq 0>
            	<cfset hourofleave = evaluate('getplacement.#ivar#totalhour') * 0.5 >
			<cfelseif i eq nonplcount and getnpldays.endampm neq "FULL DAY" and listfind(halfdaylist,DayOfWeek(currentdate)) eq 0>
           		<cfset hourofleave = evaluate('getplacement.#ivar#totalhour') * 0.5>
			<cfelse>
            	<cfset hourofleave = evaluate('getplacement.#ivar#totalhour')>
            </cfif>
            
             <cfset nowcounthour = nowcounthour +  hourofleave>
            
            <cfset "leavecount#getnpldays.currentrow#" = evaluate("leavecount#getnpldays.currentrow#") + hourofleave>
            <cfset nplhour = nplhour + hourofleave>
            <cfif getnpldays.leavetype eq "npl">
            <cfset monthnplhour = monthnplhour + hourofleave>
			</cfif>
            <cfset npldays = npldays&lsdateformat(currentdate,'yyyy-mm-dd', 'en_AU')>
            <cfset "#getnpldays.leavetype#list" = evaluate("#getnpldays.leavetype#list")&lsdateformat(currentdate,'yyyy-mm-dd', 'en_AU')>
            <cfif i neq nonplcount >
            <cfset npldays = npldays&",">
            <cfset "#getnpldays.leavetype#list" = "#getnpldays.leavetype#list"&",">
			</cfif>
            </cfif>
          </cfloop>
          <cfif getplacement.clienttype eq "hr">
          <cfif isdefined('activateeffcal')>
          
          	<cfif listfind(firsteffdatelist,lsdateformat(nplstartdate,'dd/mm/yyyy', 'en_AU')) neq 0>
            	<cfset totalfirstdaysnpl = totalfirstdaysnpl + val(getnpldays.days)>

                <cfset firstnplval = firstnplval + nowcounthour>
            <cfelseif listfind(secondeffdatelist,lsdateformat(nplstartdate,'dd/mm/yyyy', 'en_AU')) neq 0>		<cfset totalseconddaysnpl = totalseconddaysnpl + val(getnpldays.days)>
                <cfset secondnplval = secondnplval + nowcounthour>
            <cfelse>
				<cfset totalseconddaysnpl = totalseconddaysnpl + val(getnpldays.days)>
                <cfset secondnplval = secondnplval + nowcounthour>
            </cfif>
            
          </cfif>
          </cfif>
    </cfloop>
    
    
</cfif>



<cfloop query="holiday_qry">
<cfset holidaydate = createdate(year(holiday_qry.Hol_Date),month(holiday_qry.Hol_Date),day(holiday_qry.Hol_Date))>

<cfif listfind(fulldaylist,DayOfWeek(holidaydate)) neq 0 or listfind(halfdaylist,DayOfWeek(holidaydate)) neq 0 >

	<cfif DayOfWeek(holidaydate) eq "1">
	<cfset ivar = "sun">
    <cfelseif DayOfWeek(holidaydate) eq "2">
    <cfset ivar = "mon">
    <cfelseif DayOfWeek(holidaydate) eq "3">
    <cfset ivar = "tues">
    <cfelseif DayOfWeek(holidaydate) eq "4">
    <cfset ivar = "Wednes">
    <cfelseif DayOfWeek(holidaydate) eq "5">
    <cfset ivar = "Thurs">
    <cfelseif DayOfWeek(holidaydate) eq "6">
    <cfset ivar = "Fri">
    <cfelseif DayOfWeek(holidaydate) eq "7">
    <cfset ivar = "Satur">
    </cfif>
    <cfset leavedayscount= evaluate('getplacement.#ivar#totalhour')>
    <cfif getplacement.sps eq "Y">
		<cfif val(getplacement.pub_holiday_phpd) neq 0>
        <cfset leavedayscount = val(getplacement.pub_holiday_phpd)>
        </cfif>
	</cfif>  

<cfset nplhour = nplhour + val(leavedayscount)>
<cfif getplacement.clienttype eq "hr">
<cfif isdefined('activateeffcal')>
          
	<cfif listfind(firsteffdatelist,lsdateformat(holidaydate,'dd/mm/yyyy', 'en_AU')) neq 0>
        <cfset firstnplval = firstnplval + val(leavedayscount)>
        <cfset totalfirstdaysnpl = totalfirstdaysnpl + 1>
    <cfelseif listfind(secondeffdatelist,lsdateformat(holidaydate,'dd/mm/yyyy', 'en_AU')) neq 0>
        <cfset secondnplval = secondnplval + val(leavedayscount)>
        <cfset totalseconddaysnpl = totalseconddaysnpl + 1>
    <cfelse>
        <cfset secondnplval = secondnplval + val(leavedayscount)>
        <cfset totalseconddaysnpl = totalseconddaysnpl + 1>
    </cfif>
    
</cfif>
          
     
</cfif>
</cfif>
</cfloop>


		<cfset counthour = 0 >

       
  <cfloop from="0" to="#noofdayscount#" index="i">
            <cfset currentdate = dateadd('d','#i#',datestartof)>

            <cfif listfind(fulldaylist,DayOfWeek(currentdate)) neq 0 or  listfind(halfdaylist,DayOfWeek(currentdate)) neq 0>
            <cfif DayOfWeek(currentdate) eq "1">
            <cfset ivar = "sun">
            <cfelseif DayOfWeek(currentdate) eq "2">
            <cfset ivar = "mon">
            <cfelseif DayOfWeek(currentdate) eq "3">
            <cfset ivar = "tues">
            <cfelseif DayOfWeek(currentdate) eq "4">
            <cfset ivar = "Wednes">
            <cfelseif DayOfWeek(currentdate) eq "5">
            <cfset ivar = "Thurs">
            <cfelseif DayOfWeek(currentdate) eq "6">
            <cfset ivar = "Fri">
            <cfelseif DayOfWeek(currentdate) eq "7">
            <cfset ivar = "Satur">
			</cfif>
            <cfif getplacement.clienttype eq "hr">
            <cfif isdefined('activateeffcal')>
				<cfif listfind(firsteffdatelist,lsdateformat(currentdate,'dd/mm/yyyy', 'en_AU')) neq 0>
                    <cfset firstdaysval = firstdaysval + val(evaluate('getplacement.#ivar#totalhour'))>
                <cfelseif listfind(secondeffdatelist,lsdateformat(currentdate,'dd/mm/yyyy', 'en_AU')) neq 0>
                    <cfset seconddaysval = seconddaysval + val(evaluate('getplacement.#ivar#totalhour'))>
                <cfelse>
                    <cfset seconddaysval = seconddaysval + val(evaluate('getplacement.#ivar#totalhour'))>
                </cfif>
          	</cfif>
          </cfif>
          
            <cfset counthour = counthour+val(evaluate('getplacement.#ivar#totalhour'))>
            </cfif>
            
            
        </cfloop>

<cfset selfsalaryhrsrecord = counthour>
<cfif getplacement.clienttype neq "mth">
<cfset selfsalaryhrsrecord = selfsalaryhrsrecord - nplhour>
<cfelse>
<cfset selfsalaryhrsrecord = selfsalaryhrsrecord - monthnplhour>
</cfif>
<cfset custsalaryhrsrecord = counthour>

<cfif getplacement.clienttype neq "mth">
<cfset custsalaryhrsrecord = custsalaryhrsrecord - nplhour>
<cfelse>
<cfset custsalaryhrsrecord = custsalaryhrsrecord - monthnplhour>
</cfif>

<cfif isdefined('activateeffcal')>

<cfif getplacement.clienttype eq "hr">

		<cfset firsteepay = firstemployeepay * (val(firstdaysval) - val(firstnplval))>
		<cfset firsterpay = firstemployerpay * (val(firstdaysval) - val(firstnplval))>
        <cfset secondeepay = secondemployeepay * (val(seconddaysval) - val(secondnplval))>
        <cfset seconderpay = secondemployerpay * (val(seconddaysval) - val(secondnplval))>
        <cfset selfsalaryrecord = numberformat(firsteepay+0.0000001,'.__') + numberformat(secondeepay+0.0000001,'.__')>
        <cfset custsalaryrecord = numberformat(firsterpay+0.0000001,'.__') + numberformat(seconderpay+0.0000001,'.__')>

</cfif>
	
<cfelse>
<cfif getplacement.clienttype eq "hr">
	<cfset selfsalaryrecord = numberformat(employeepay,'.__') * numberformat(selfsalaryhrsrecord,'.__')>
    <cfset custsalaryrecord = numberformat(employerpay,'.__') * numberformat(custsalaryhrsrecord,'.__')>
<cfelseif getplacement.clienttype eq "day">
	<cfset selfsalaryrecord = numberformat(employeepay,'.__') * numberformat(selfsalarydayrecord,'.__')>
    <cfset custsalaryrecord = numberformat(employerpay,'.__') * numberformat(custsalarydayrecord,'.__')>
<cfelseif getplacement.clienttype eq "mth">
<cfif (daysinmonth(dateendof) neq day(dateendof) or day(datestartof) neq 1) and month(datestartof) eq month(dateendof)>
<cfset newdatestart = createdate(listlast(URLDECODE(url.startdate),'/'),listgetat(URLDECODE(url.startdate),'2','/'),1)>
<cfset newdateend = createdate(listlast(URLDECODE(url.enddate),'/'),listgetat(URLDECODE(url.enddate),'2','/'),daysinmonth(dateendof))>	
		<cfset countdays = 0>
		<cfset noofdayscount = abs(datediff('d',newdatestart,newdateend))>
		
		
        <cfloop from="0" to="#noofdayscount#" index="i">
            <cfset currentdate = dateadd('d','#i#',newdatestart)>
			 <cfif listfind(fulldaylist,DayOfWeek(currentdate)) neq 0>
            <cfset countdays = countdays+1>
            <cfelseif listfind(halfdaylist,DayOfWeek(currentdate)) neq 0>
            <cfset countdays = countdays+0.5>
            </cfif>
        </cfloop>
		<cfset noofdays = val(countdays)>

        <cfset activatedayntsame = 0 >     
</cfif>

            
<cfif getplacement.flexw eq "Y">
<cfset noofdays = 1>
<cfset selfsalarydayrecord = 1>
<cfset custsalarydayrecord = 1>
</cfif>

<cfif val(noofdays) eq 0>
<cfoutput>
<h1 align="center" style="color:##F00">Check Work Hour Pattern!</h1>
</cfoutput>
<cfabort>
</cfif>

	<cfset selfsalaryrecord = numberformat(employeepay,'.__') * numberformat(selfsalarydayrecord,'.__') / noofdays>
    <cfset custsalaryrecord = numberformat(employerpay,'.__') * numberformat(custsalarydayrecord,'.__') / noofdays>


</cfif>
</cfif>

<cfif getplacement.clienttype eq "hr" or getplacement.clienttype eq "day">

<cfquery name="getplgroup" datasource="#dts#">
SELECT leavetype FROM leavelist WHERE  placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#"> and leavetype <> "NS"
<cfif url.startdate neq "" and url.enddate neq "">
and startdate >= "#lsdateformat((url.startdate),'YYYY-MM-DD', 'en_AU')#"
and enddate <= "#lsdateformat((url.enddate),'YYYY-MM-DD', 'en_AU')#"
</cfif>
GROUP BY leavetype
ORDER BY leavetype, startdate
</cfquery>

<cfloop query="getplgroup"> 
<cfset "lvltype#getplgroup.leavetype#" = getplgroup.leavetype>
<cfset "lvldesp#getplgroup.leavetype#" = "">
<cfset "lvleedayhr#getplgroup.leavetype#" = 0>
<cfset "lvlerdayhr#getplgroup.leavetype#" = 0>
<cfset "lvltype#getplgroup.leavetype#2" = getplgroup.leavetype>
<cfset "lvldesp#getplgroup.leavetype#2" = "">
<cfset "lvleedayhr#getplgroup.leavetype#2" = 0>
<cfset "lvlerdayhr#getplgroup.leavetype#2" = 0>
</cfloop>

<cfloop query="getplacementleave">
			
        <cfif getplacementleave.startdate neq getplacementleave.enddate>
            <cfset leavedesp = lsdateformat(getplacementleave.startdate,'dd', 'en_AU')&"-"&lsdateformat(getplacementleave.enddate,'dd mmm', 'en_AU')>
        <cfelse>
        	<cfset leavedesp = lsdateformat(getplacementleave.enddate,'dd mmm', 'en_AU')>
        </cfif>
        
        
        
        <cfset leavedayscount = getplacementleave.days>
        
        <cfif getplacement.clienttype eq "hr">
        <cfset leavedayscount = evaluate("leavecount#getplacementleave.currentrow#")>
			<cfif getplacement.sps eq "Y">
                <cfif getplacementleave.leavetype eq "AL">
                	<cfif val(getplacement.ann_leav_phpd) neq 0>
                         <cfset leavedayscount = val(getplacementleave.days) * val(getplacement.ann_leav_phpd)>
                    </cfif>
                </cfif>
                  <cfif  getplacementleave.leavetype eq "MC">
                	<cfif val(getplacement.medic_leav_phpd) neq 0>
                         <cfset leavedayscount = val(getplacementleave.days) * val(getplacement.medic_leav_phpd)>
                    </cfif>
                </cfif>
                 <cfif  getplacementleave.leavetype eq "HPL">
                	<cfif val(getplacement.hosp_leav_phpd) neq 0>
                         <cfset leavedayscount = val(getplacementleave.days) * val(getplacement.hosp_leav_phpd)>
                    </cfif>
                </cfif>
            </cfif>
		</cfif>
        
        <cfif isdefined('activateeffcal')>
        <cfif listfind(firsteffdatelist,lsdateformat(getplacementleave.startdate,'dd/mm/yyyy', 'en_AU')) neq 0>
        	<cfset "lvleedayhr#getplacementleave.leavetype#" = val(evaluate("lvleedayhr#getplacementleave.leavetype#")) + val(leavedayscount)>
        	<cfset "lvlerdayhr#getplacementleave.leavetype#" = val(evaluate("lvlerdayhr#getplacementleave.leavetype#")) + val(leavedayscount)>
            <cfset "lvldesp#getplacementleave.leavetype#" = evaluate("lvldesp#getplacementleave.leavetype#")&leavedesp&", ">
        <cfelse>
        	<cfset "lvleedayhr#getplacementleave.leavetype#2" = val(evaluate("lvleedayhr#getplacementleave.leavetype#2")) + val(leavedayscount)>
        	<cfset "lvlerdayhr#getplacementleave.leavetype#2" = val(evaluate("lvlerdayhr#getplacementleave.leavetype#2")) + val(leavedayscount)>
            <cfset "lvldesp#getplacementleave.leavetype#2" = evaluate("lvldesp#getplacementleave.leavetype#2")&leavedesp&", ">
        </cfif>
        <cfelse>
			<cfset "lvleedayhr#getplacementleave.leavetype#" = val(evaluate("lvleedayhr#getplacementleave.leavetype#")) + val(leavedayscount)>
        	<cfset "lvlerdayhr#getplacementleave.leavetype#" = val(evaluate("lvlerdayhr#getplacementleave.leavetype#")) + val(leavedayscount)>
            <cfset "lvldesp#getplacementleave.leavetype#" = evaluate("lvldesp#getplacementleave.leavetype#")&leavedesp&", ">
        </cfif>
    	
        <cfif evaluate('getplacement.#getplacementleave.leavetype#payable1') eq "Y">
        	<cfif isdefined('activateeffcal')>
				<cfif listfind(firsteffdatelist,lsdateformat(getplacementleave.startdate,'dd/mm/yyyy', 'en_AU')) neq 0>
                	<cfset "lvleerate#getplacementleave.leavetype#" = numberformat(firstemployeepay,'.__')>
                <cfelse>
                 	<cfset "lvleerate#getplacementleave.leavetype#2" = numberformat(secondemployeepay,'.__')>
                </cfif>
            <cfelse>
                <cfset "lvleerate#getplacementleave.leavetype#" = numberformat(employeepay,'.__')>
            </cfif>
            
       <cfelse>
            	<cfset "lvleerate#getplacementleave.leavetype#" = 0>
                <cfif isdefined('activateeffcal')>
                <cfset "lvleerate#getplacementleave.leavetype#2" = 0>
                </cfif>
       </cfif>
        
         <cfif evaluate('getplacement.#getplacementleave.leavetype#billable1') eq "Y">
         <cfif isdefined('activateeffcal')>
				<cfif listfind(firsteffdatelist,lsdateformat(getplacementleave.startdate,'dd/mm/yyyy', 'en_AU')) neq 0>
                	<cfset "lvlerrate#getplacementleave.leavetype#" = numberformat(firstemployerpay,'.____')>
                <cfelse>
                 	<cfset "lvlerrate#getplacementleave.leavetype#2" = numberformat(secondemployerpay,'.____')>
                </cfif>
            <cfelse>
        <cfset "lvlerrate#getplacementleave.leavetype#" = numberformat(employerpay,'.____')>
        </cfif>
        <cfelse>
        <cfset "lvlerrate#getplacementleave.leavetype#" = 0>
        <cfif isdefined('activateeffcal')>
        <cfset "lvlerrate#getplacementleave.leavetype#2" = 0>
		</cfif>
        </cfif>
        

</cfloop>

<cfelse>
<!---proration rate for 2 month if timesheet cycle is not 01-31, [20170219, Alvin]--->
	<cfif month(lsdateformat(url.startdate, 'yyyy-mm-dd', "en_AU")) neq month(lsdateformat(url.enddate, 'yyyy-mm-dd', "en_AU"))>
        <cfset endStartDate = dateformat(createdate(val(year(#url.startdate#)),val(month(#url.startdate#)),val(daysinmonth(#url.startdate#))), 'yyyy-mm-dd')>
        <cfset beginEndDate = dateadd('d',1,endStartDate)>
        
        <cfquery name="getNplTaken1" datasource="#replace(dts,'_i','_p')#">
            SELECT sum(case ampm
                       when 'am' then 0.5
                       when 'pm' then 0.5
                       when 'full day' then 1
                       end) as npltaken
             FROM timesheet 
             WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#">
             AND pdate BETWEEN "#lsdateformat(url.startdate, 'yyyy-mm-dd', 'en_AU')#" AND "#lsdateformat(endStartDate, 'yyyy-mm-dd', 'en_AU')#"
             AND stcol = 'NPL'
     	</cfquery>
        
        <cfquery name="getNplTaken2" datasource="#replace(dts,'_i','_p')#">
            SELECT sum(case ampm
                       when 'am' then 0.5
                       when 'pm' then 0.5
                       when 'full day' then 1
                       end) as npltaken
             FROM timesheet 
             WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#">
             AND pdate BETWEEN '#lsdateformat(beginEndDate, 'yyyy-mm-dd', "en_AU")#' AND '#lsdateformat(url.enddate, 'yyyy-mm-dd', "en_AU")#'
             AND stcol = 'NPL'
     	</cfquery>
        
        <cfset lvltype1 = "NPL">
		<cfset lvldesp1 = "No Pay Leave for #lsdateformat(url.startdate, 'mmm', "en_AU")#">
        <cfset lvleedayhr1 = #getNplTaken1.npltaken#>
        <cfset lvlerdayhr1 = #getNplTaken1.npltaken#>
        <cfset lvleedayhr1 = 0>		<!---override the amount cuz MP is not using timesheet yet. Remove this code to enable npl calculation from timesheet--->
        <cfset lvlerdayhr1 = 0>		<!---override the amount cuz MP is not using timesheet yet. Remove this code to enable npl calculation from timesheet--->
        <cfif val(noofdays) neq 0> <!---if eq 0 means work for 0 days--->
			<cfset lvleerate1 = numberformat(employeepay/val(daysinmonth(#url.startdate#)),'.__')*-1>
            <cfset lvlerrate1 = numberformat(employerpay/val(daysinmonth(#url.startdate#)),'.__')*-1>
        <cfelse>
			<cfset lvleerate1 = 0>
            <cfset lvlerrate1 = 0>
        </cfif>
        
        <cfset lvltype2 = "NPL2">
		<cfset lvldesp2 = "No Pay Leave for #lsdateformat(url.enddate, 'mmm', "en_AU")#">
        <cfset lvleedayhr2 = #getNplTaken2.npltaken#>
        <cfset lvlerdayhr2 = #getNplTaken2.npltaken#>
        <cfset lvleedayhr2 = 0>		<!---override the amount cuz MP is not using timesheet yet. Remove this code to enable npl calculation from timesheet--->
        <cfset lvlerdayhr2 = 0>		<!---override the amount cuz MP is not using timesheet yet. Remove this code to enable npl calculation from timesheet--->
        <cfif val(noofdays) neq 0> <!---if eq 0 means work for 0 days--->
			<cfset lvleerate2 = numberformat(employeepay/val(daysinmonth(#url.enddate#)),'.__')*-1>
            <cfset lvlerrate2 = numberformat(employerpay/val(daysinmonth(#url.enddate#)),'.__')*-1>
        <cfelse>
			<cfset lvleerate2 = 0>
            <cfset lvlerrate2 = 0>
        </cfif>
        
        
    <cfelse> <!---cycle is 01-31--->
    
    	<!---added query to get npl and change the hour rate, [20170109, Alvin]--->
        <cfquery name="getnpltaken" datasource="#replace(dts,'_i','_p')#">
            SELECT sum(case ampm
                       when 'am' then 0.5
                       when 'pm' then 0.5
                       when 'full day' then 1
                       end) as npltaken
             FROM timesheet 
             WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.pno#">
             AND pdate BETWEEN '#lsdateformat(url.startdate, 'yyyy-mm-dd', "en_AU")#' AND '#lsdateformat(url.enddate, 'yyyy-mm-dd', "en_AU")#'
         	 ANd stcol = 'NPL'
        </cfquery>
        
        <cfset lvltype1 = "NPL">
        <cfset lvldesp1 = "No Pay Leave for #lsdateformat(url.startdate, 'mmm', "en_AU")#">
        <cfset lvleedayhr1 = #getnpltaken.npltaken#>
        <cfset lvlerdayhr1 = #getnpltaken.npltaken#>
        <cfset lvleedayhr1 = 0>		<!---override the amount cuz MP is not using timesheet yet. Remove this code to enable npl calculation from timesheet--->
        <cfset lvlerdayhr1 = 0>		<!---override the amount cuz MP is not using timesheet yet. Remove this code to enable npl calculation from timesheet--->
        <!---query and hour for npl--->
        <cfif val(noofdays) neq 0> <!---if eq 0 means work for 0 days--->
            <cfset lvleerate1 = numberformat(employeepay/val(noofdays),'.__')*-1>
            <cfset lvlerrate1 = numberformat(employerpay/val(noofdays),'.__')*-1>
        <cfelse>
            <cfset lvleerate1 = 0>
            <cfset lvlerrate1 = 0>
        </cfif>
    
    </cfif>
<!---proration for NPL--->
</cfif>

<cfset totalphlvlee = 0>
<cfset totalphlvler = 0>
<cfset getplgrouprowcount = 1>

<cfif getplacement.clienttype eq "hr" or getplacement.clienttype eq "day">
<cfloop query="getplgroup">
<cfif evaluate("lvldesp#getplgroup.leavetype#") neq "">
<cfset "lvltype#getplgrouprowcount#" = getplgroup.leavetype> 
<cfset "lvldesp#getplgrouprowcount#" = getplgroup.leavetype&" "&numberformat(val(evaluate("lvleedayhr#getplgroup.leavetype#")),'.__')&" #getplacement.clienttype#s ("&left(evaluate('lvldesp#getplgroup.leavetype#'),len(evaluate('lvldesp#getplgroup.leavetype#'))-2)&")">
<cfset "lvleedayhr#getplgrouprowcount#" = numberformat(val(evaluate("lvleedayhr#getplgroup.leavetype#")),'.__')>
<cfset "lvlerdayhr#getplgrouprowcount#" = numberformat(val(evaluate("lvlerdayhr#getplgroup.leavetype#")),'.__')>
<cfset "lvleerate#getplgrouprowcount#" = evaluate("lvleerate#getplgroup.leavetype#")>
<cfset "lvlerrate#getplgrouprowcount#" = evaluate("lvlerrate#getplgroup.leavetype#")>
<cfset getplgrouprowcount = getplgrouprowcount + 1>
</cfif>

<cfif evaluate("lvldesp#getplgroup.leavetype#2") neq "">
<cfset "lvltype#getplgrouprowcount#" = getplgroup.leavetype> 
<cfset "lvldesp#getplgrouprowcount#" = getplgroup.leavetype&" "&numberformat(val(evaluate("lvleedayhr#getplgroup.leavetype#2")),'.__')&" #getplacement.clienttype#s ("&left(evaluate('lvldesp#getplgroup.leavetype#2'),len(evaluate('lvldesp#getplgroup.leavetype#2'))-2)&")">
<cfset "lvleedayhr#getplgrouprowcount#" = numberformat(val(evaluate("lvleedayhr#getplgroup.leavetype#2")),'.__')>
<cfset "lvlerdayhr#getplgrouprowcount#" = numberformat(val(evaluate("lvlerdayhr#getplgroup.leavetype#2")),'.__')>
<cfset "lvleerate#getplgrouprowcount#" = evaluate("lvleerate#getplgroup.leavetype#2")>
<cfset "lvlerrate#getplgrouprowcount#" = evaluate("lvlerrate#getplgroup.leavetype#2")>
<cfset getplgrouprowcount = getplgrouprowcount + 1>
</cfif>

</cfloop>

<cfif holiday_qry.recordcount neq 0>
<cfloop query="holiday_qry">
<cfset holidaydate = createdate(year(holiday_qry.Hol_Date),month(holiday_qry.Hol_Date),day(holiday_qry.Hol_Date))>

<cfif getplacement.phdate eq "">
<cfset getplacement.phdate = createdate('1986','7',11)>
</cfif>
<cfif holidaydate gte createdate(year(getplacement.phdate),month(getplacement.phdate),day(getplacement.phdate))>

<cfif  listfind(fulldaylist,DayOfWeek(holidaydate)) neq 0 or listfind(halfdaylist,DayOfWeek(holidaydate)) neq 0 >

<cfset leavedayscount = 1>

<cfif getplacement.clienttype eq "hr">
	<cfif DayOfWeek(holidaydate) eq "1">
	<cfset ivar = "sun">
    <cfelseif DayOfWeek(holidaydate) eq "2">
    <cfset ivar = "mon">
    <cfelseif DayOfWeek(holidaydate) eq "3">
    <cfset ivar = "tues">
    <cfelseif DayOfWeek(holidaydate) eq "4">
    <cfset ivar = "Wednes">
    <cfelseif DayOfWeek(holidaydate) eq "5">
    <cfset ivar = "Thurs">
    <cfelseif DayOfWeek(holidaydate) eq "6">
    <cfset ivar = "Fri">
    <cfelseif DayOfWeek(holidaydate) eq "7">
    <cfset ivar = "Satur">
    </cfif>
    <cfset leavedayscount= evaluate('getplacement.#ivar#totalhour')>
    <cfif getplacement.sps eq "Y">
		<cfif val(getplacement.pub_holiday_phpd) neq 0>
        <cfset leavedayscount = val(getplacement.pub_holiday_phpd)>
        </cfif>
	</cfif>
</cfif>
<cfif getplgrouprowcount eq 1>
<cfset getplgrouprowcount = 0>
</cfif>
<cfset "lvltype#getplgrouprowcount + holiday_qry.currentrow#" = "PH">
<cfset "lvldesp#getplgrouprowcount + holiday_qry.currentrow#" = "PH "&numberformat(val(leavedayscount),'.__')&" #getplacement.clienttype#s ("
&lsdateformat(holiday_qry.hol_date,'dd mmm', 'en_AU')&")">

<cfset "lvleedayhr#getplgrouprowcount + holiday_qry.currentrow#" = val(leavedayscount)>
<cfif getplacement.phbillable eq "Y">
	<cfif isdefined('activateeffcal')>
		<cfif listfind(firsteffdatelist,lsdateformat(holidaydate,'dd/mm/yyyy', 'en_AU')) neq 0>
            <cfset "lvleerate#getplgrouprowcount + holiday_qry.currentrow#" = numberformat(firstemployeepay,'.__')>
        <cfelse>
            <cfset "lvleerate#getplgrouprowcount + holiday_qry.currentrow#" = numberformat(secondemployeepay,'.__')>
        </cfif>
    <cfelse>
    <cfset "lvleerate#getplgrouprowcount + holiday_qry.currentrow#" = numberformat(employeepay,'.__')>
    </cfif>
<cfelse>
<cfset "lvleerate#getplgrouprowcount + holiday_qry.currentrow#" = 0>
</cfif>

<cfif getplacement.phpayable eq "Y">
<cfif isdefined('activateeffcal')>
		<cfif listfind(firsteffdatelist,lsdateformat(holidaydate,'dd/mm/yyyy', 'en_AU')) neq 0>
            <cfset "lvlerrate#getplgrouprowcount + holiday_qry.currentrow#" = numberformat(firstemployerpay,'.__')>
        <cfelse>
            <cfset "lvlerrate#getplgrouprowcount + holiday_qry.currentrow#" = numberformat(secondemployerpay,'.__')>
        </cfif>
    <cfelse>
<cfset "lvlerrate#getplgrouprowcount + holiday_qry.currentrow#" = numberformat(employerpay,'.__')>
</cfif>
<cfelse>
<cfset "lvlerrate#getplgrouprowcount + holiday_qry.currentrow#" = 0>
</cfif>
<cfset "lvlerdayhr#getplgrouprowcount + holiday_qry.currentrow#" = val(leavedayscount)>
        
</cfif>
</cfif>
</cfloop>
</cfif>

</cfif>

<cfloop from="1" to="10" index="i">
      <cfif isdefined('lvltype#i#')>
      		<cfset "lvltotalee#i#" = numberformat(val(evaluate("lvleedayhr#i#")) * val(evaluate("lvleerate#i#")),'.__')>
            <cfset totalphlvlee = totalphlvlee + evaluate("lvltotalee#i#")>
            <cfset "lvltotaler#i#" = numberformat(val(evaluate("lvlerdayhr#i#")) * val(evaluate("lvlerrate#i#")),'.__')>
            <cfset totalphlvler = totalphlvler + evaluate("lvltotaler#i#")>
      </cfif>
</cfloop>

<cfset totalfixawamtee =0>
<cfset totalfixawamter =0>

  <cfloop from="1" to="6" index="i">
      <cfif evaluate('getplacement.aw#i#') neq "">
      <cfset "fixawcode#i#" = evaluate('getplacement.aw#i#')>
      <cfset "fixawdesp#i#" =  evaluate('getplacement.allowancedesp#i#')>
      <cfset "fixaworiamt#i#" = evaluate('getplacement.allowanceamt#i#')>
      <cfset "fixawee#i#" = 0>
      <cfif evaluate('getplacement.allowancepayable#i#') eq "Y">
      <cfset "fixawee#i#" = evaluate('getplacement.allowanceamt#i#')>
      	<cfif evaluate('getplacement.prorated#i#') eq "Y">
        	<cfif getplacement.clienttype eq "hr">
            <cfset "fixawee#i#" = numberformat(evaluate('getplacement.allowanceamt#i#') * val(selfsalaryhrsrecord) / val(counthour),'.__')>
            <cfelse>
            <cfset "fixawee#i#" = numberformat(evaluate('getplacement.allowanceamt#i#') * val(selfsalarydayrecord) / val(noofdays),'.__')>
			</cfif>
        </cfif>
        </cfif>
         <cfset "fixawer#i#" = 0>
      <cfif evaluate('getplacement.allowancebillable#i#') eq "Y">
      <cfset "fixawer#i#" = evaluate('getplacement.allowanceamt#i#')>
      	<cfif evaluate('getplacement.prorated#i#') eq "Y">
        	<cfif getplacement.clienttype eq "hr">
            <cfset "fixawer#i#" = numberformat(evaluate('getplacement.allowanceamt#i#') * val(selfsalaryhrsrecord) / val(counthour),'.__')>
            <cfelse>
            <cfset "fixawer#i#" = numberformat(evaluate('getplacement.allowanceamt#i#') * val(selfsalarydayrecord) / val(noofdays),'.__')>
			</cfif>
        </cfif>
	  </cfif>
      	<cfset totalfixawamtee =totalfixawamtee + numberformat(evaluate("fixawee#i#"),'.__')>
		<cfset totalfixawamter =totalfixawamter + numberformat(evaluate("fixawer#i#"),'.__')>
      </cfif>
      </cfloop>
      
      <cfset BONUSMISCTEXT = "">
      <cfset AWSMISCTEXT = "">
  <cfloop list="bonus,aws" index="a">
      	<cfloop list="cpf,sdf,wi,adm" index="i">
        	<cfif evaluate('getplacement.#a##i#able') eq "Y">
            	<cfset "#a#MISCTEXT" = evaluate("#a#MISCTEXT")&UCASE(i)&"+">
			</cfif>
        </cfloop>
      </cfloop>
      
  <cfif BONUSMISCTEXT neq "">
      <cfset BONUSMISCTEXT = left(BONUSMISCTEXT,len(BONUSMISCTEXT)-1)&" for PB">
	  </cfif>
  <cfif AWSMISCTEXT neq "">
      <cfset AWSMISCTEXT = left(AWSMISCTEXT,len(AWSMISCTEXT)-1)&" for AWS">
	  </cfif>
      
  <cfif getplacement.awsdate neq "">
      <cfset pawsdate = createdate(year(getplacement.awsdate),month(getplacement.awsdate),day(getplacement.awsdate))>
      <cfif pawsdate gte datestartof and pawsdate lte dateendof>
      
      	<cfset awstext = "Annual Wage Supplement">
        <cfset awseeamt = 0>
		<cfif getplacement.awspayable eq "Y">
        <cfset awseeamt = getplacement.awsamt>
        </cfif>
        <cfset awseramt = 0>
		<cfif getplacement.awsbillable eq "Y">
        <cfset awseramt = getplacement.awsamt>
        
        </cfif>
		<cfset awscpf = 0>
        <cfset awssdf = 0 >
        <cfif getplacement.awswiable eq "Y">
        <cfset awswi = numberformat(numberformat(getplacement.awsamt,'.__') * 1 / 100,'.__') >
		<cfelse>
        <cfset awswi = 0 >
        </cfif>
         <cfif getplacement.awsadmable eq "Y" and getplacement.admin_fee eq "No" and val(getplacement.admin_fee_fix_amt) neq 0>
         <cfset awsadm = numberformat(numberformat(getplacement.awsamt,'.__') *  val(getplacement.admin_fee_fix_amt) / 100,'.__') >
		<cfelse>
        <cfset awsadm = 0>
        </cfif>
	  </cfif>
	</cfif>
  <cfif isdefined('AWSTEXT') eq false>
        <cfset awstext = "">
        <cfset awseeamt = 0>
        <cfset awseramt = 0>
        <cfset awscpf = 0>
        <cfset awssdf = 0 >
        <cfset awswi = 0 >
        <cfset awsadm = 0>
        
      <cfset AWSMISCTEXT = "">
      </cfif>
      <cfset totalawsmisc = val(awscpf) + val(awssdf) + val(awswi) + val(awsadm)>
     
      
  <cfif getplacement.bonusdate neq "">
      <cfset pbdate = createdate(year(getplacement.bonusdate),month(getplacement.bonusdate),day(getplacement.bonusdate))>
      <cfif pbdate gte datestartof and pbdate lte dateendof>
      
      	<cfset pbtext = "PB">
        <cfset pbeeamt = 0>
		<cfif getplacement.bonuspayable eq "Y">
        <cfset pbeeamt = getplacement.bonusamt>
        </cfif>
        <cfset pberamt = 0>
		<cfif getplacement.bonusbillable eq "Y">
        <cfset pberamt = getplacement.bonusamt>
        </cfif>
        
         <cfset pbcpf = 0>
        <cfset pbsdf = 0 >
        <cfif getplacement.bonuswiable eq "Y">
        <cfset pbwi = numberformat(numberformat(getplacement.bonusamt,'.__') * 1 / 100,'.__') >
		<cfelse>
        <cfset pbwi = 0 >
        </cfif>
        <cfif getplacement.bonusadmable eq "Y" and getplacement.admin_fee eq "No" and val(getplacement.admin_fee_fix_amt) neq 0>
         <cfset pbadm = numberformat(numberformat(getplacement.bonusamt,'.__') *  val(getplacement.admin_fee_fix_amt) / 100,'.__') >
		<cfelse>
        <cfset pbadm = 0>
        </cfif>
	  </cfif>
      </cfif>
      
  <cfif isdefined('pbtext') eq false>
        <cfset pbtext = "">
        <cfset pbeeamt = 0>
        <cfset pberamt = 0>
        <cfset pbcpf = 0>
        <cfset pbsdf = 0 >
        <cfset pbwi = 0 >
        <cfset pbadm = 0>
        <cfset BONUSMISCTEXT = "">
      </cfif>
       <cfset totalpbmisc = val(pbcpf) + val(pbsdf) + val(pbwi) + val(pbadm)>
      
  <cfloop from="1" to="18" index="a">
          <cfset "aw#a#" = "">
          <cfset "allowancedesp#a#" = "">
          <cfset "awer#a#" = "">
          <cfset "awee#a#" = "">
  </cfloop>

      <cfset nsdeddesp = "">
      <cfset nsded = 0 >
      <cfset NSCUSTDED = 0 >
	  <cfset nshour = 0>
  <cfloop query="getplacementleavens">
      	<cfif nsdeddesp neq "">
        <cfset nsdeddesp = nsdeddesp&chr(10)>
		</cfif>
		<cfset nsdeddesp = nsdeddesp&"National Service "&lsdateformat(getplacementleavens.startdate,'dd/mm/yyyy', 'en_AU')&" - "&lsdateformat(getplacementleavens.enddate,'dd/mm/yyyy', 'en_AU')>
        
		  <cfif getplacement.clienttype eq "mth">
          		
                
          <cfif isdefined('activateeffcal')>
          	<cfif listfind(firsteffdatelist,lsdateformat(getplacementleavens.startdate,'dd/mm/yyyy', 'en_AU')) neq 0>
            	<cfset nsemployeepay = firstemployeepay>
                <cfset nsemployerpay = firstemployerpay>
			<cfelse>
            	<cfset nsemployeepay = secondemployeepay>
                <cfset nsemployerpay = secondemployerpay>
            </cfif>
            <cfset nsded = nsded + numberformat(numberformat(nsemployeepay,'.__') * numberformat(getplacementleavens.days,'.__') / noofdays,'.__')>
         		<cfset nscustded = nscustded + numberformat(numberformat(nsemployerpay,'.__') * numberformat(getplacementleavens.days,'.__') / noofdays,'.__')>
          <cfelse>
          	<cfset nsded = nsded + numberformat(numberformat(employeepay,'.__') * numberformat(getplacementleavens.days,'.__') / noofdays,'.__')>
         		<cfset nscustded = nscustded + numberformat(numberformat(employerpay,'.__') * numberformat(getplacementleavens.days,'.__') / noofdays,'.__')>
          </cfif>
          
          <cfelseif getplacement.clienttype eq "day">
          		
                
         <cfif isdefined('activateeffcal')>
          	<cfif listfind(firsteffdatelist,lsdateformat(getplacementleavens.startdate,'dd/mm/yyyy', 'en_AU')) neq 0>
            	<cfset nsemployeepay = firstemployeepay>
                <cfset nsemployerpay = firstemployerpay>
			<cfelse>
            	<cfset nsemployeepay = secondemployeepay>
                <cfset nsemployerpay = secondemployerpay>
            </cfif>
            <cfset nsded = nsded + numberformat(nsemployeepay,'.__') * numberformat(getplacementleavens.days,'.__')>
         		<cfset nscustded = nscustded + numberformat(nsemployerpay,'.__') * numberformat(getplacementleavens.days,'.__') >
          <cfelse>
          		<cfset nsded = nsded + numberformat(employeepay,'.__') * numberformat(getplacementleavens.days,'.__')>
           		<cfset nscustded = nscustded + numberformat(employerpay,'.__') * numberformat(getplacementleavens.days,'.__')>
		  </cfif>
          
          <cfelseif getplacement.clienttype eq "hr">
          		
                        <cfset nsstartdate = createdate(year(getplacementleavens.startdate),month(getplacementleavens.startdate),day(getplacementleavens.startdate))>
                        <cfset nsenddate = createdate(year(getplacementleavens.enddate),month(getplacementleavens.enddate),day(getplacementleavens.enddate))>
                        
                        <cfset nonscount = abs(datediff('d',nsstartdate,nsenddate))>
                         <cfloop from="0" to="#nonscount#" index="i">
                            <cfset currentdate = dateadd('d','#i#',nsstartdate)>
                            <cfif   listfind(fulldaylist,DayOfWeek(currentdate)) neq 0 or  listfind(halfdaylist,DayOfWeek(currentdate)) neq 0>
                            <cfif DayOfWeek(currentdate) eq "1">
                            <cfset ivar = "sun">
                            <cfelseif DayOfWeek(currentdate) eq "2">
                            <cfset ivar = "mon">
                            <cfelseif DayOfWeek(currentdate) eq "3">
                            <cfset ivar = "tues">
                            <cfelseif DayOfWeek(currentdate) eq "4">
                            <cfset ivar = "Wednes">
                            <cfelseif DayOfWeek(currentdate) eq "5">
                            <cfset ivar = "Thurs">
                            <cfelseif DayOfWeek(currentdate) eq "6">
                            <cfset ivar = "Fri">
                            <cfelseif DayOfWeek(currentdate) eq "7">
                            <cfset ivar = "Satur">
                            </cfif>
                            <cfif i eq 0 and getplacementleavens.startampm neq "FULL DAY" and listfind(halfdaylist,DayOfWeek(currentdate)) eq 0>
                                <cfset hourofleave = evaluate('getplacement.#ivar#totalhour') * 0.5 >
                            <cfelseif i eq nonscount and getplacementleavens.endampm neq "FULL DAY" and listfind(halfdaylist,DayOfWeek(currentdate)) eq 0>
                                <cfset hourofleave = evaluate('getplacement.#ivar#totalhour') * 0.5>
                            <cfelse>
                                <cfset hourofleave = evaluate('getplacement.#ivar#totalhour')>
                            </cfif>
                            
                            <cfset nshour =nshour +  hourofleave>
                            </cfif>
                          </cfloop>
    			
                
          <cfif isdefined('activateeffcal')>
          	<cfif listfind(firsteffdatelist,lsdateformat(getplacementleavens.startdate,'dd/mm/yyyy', 'en_AU')) neq 0>
            	<cfset nsemployeepay = firstemployeepay>
                <cfset nsemployerpay = firstemployerpay>
			<cfelse>
            	<cfset nsemployeepay = secondemployeepay>
                <cfset nsemployerpay = secondemployerpay>
            </cfif>
            <cfset nsded = nsded + numberformat(nsemployeepay,'.__') * numberformat(nshour,'.__')>
         		<cfset nscustded = nscustded + numberformat(nsemployerpay,'.__') * numberformat(nshour,'.__') >
                
          <cfelse>
            <cfset nsded = nsded + numberformat(employeepay,'.__') * numberformat(nshour,'.__')>
           		<cfset nscustded = nscustded + numberformat(employerpay,'.__') * numberformat(nshour,'.__')>    
          </cfif>
          
                
                <cfset nsdeddesp = nsdeddesp&" "&val(nshour)&" Hours">
          
          </cfif>
      </cfloop>
      
      
		<cfset SELFPBAWS = numberformat(val(pbeeamt),'.__')+ numberformat(val(awseeamt),'.__') >
        <cfset CUSTPBAWS = numberformat(val(pberamt),'.__')+ numberformat(val(awseramt),'.__') + numberformat(val(pbcpf)+val(pbsdf)+val(pbwi)+val(pbadm),'.__')+ numberformat(val(awscpf)+val(awssdf)+val(awswi)+val(awsadm),'.__')>
        <cfset adminfeepercent = 0>
        <cfset adminfeeminamt = 0 >
        <cfset ADMINFEE = 0 > 
  <cfif getplacement.admin_fee eq "yes">
        <cfset adminfee = numberformat(getplacement.admin_fee_fix_amt,'.__')>
        <cfelseif getplacement.admin_fee eq "no" >
        <cfset adminfeepercent = val(getplacement.admin_fee_fix_amt)>
        <cfset adminfeeminamt = numberformat(getplacement.admin_f_min_amt,'.__')>
		</cfif>
        
  <cfloop from="1" to="6" index="i">
			<cfif evaluate("getplacement.billableitem#i#") neq "">
            	 <cfquery name="getcate" datasource="#dts#">
                select desp from iccate WHERE cate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate("getplacement.billableitem#i#")#">
                </cfquery>
                <cfset "billitem#i#" = evaluate("getplacement.billableitem#i#")>
                <cfset "billitemdesp#i#" = getcate.desp>
                <cfif right(evaluate("getplacement.billableitemamt#i#"),1) eq "%">
                 <cfset "billitemamt#i#" = 0>
                 <cfset "billitempercent#i#" = left(evaluate("getplacement.billableitemamt#i#"),len(evaluate("getplacement.billableitemamt#i#"))-1)>
                <cfelse>
                <cfset "billitemamt#i#" = numberformat(evaluate("getplacement.billableitemamt#i#"),'.__')>
                <cfset "billitempercent#i#" = 0>
					<cfif evaluate('getplacement.billableprorated#i#') eq 'Y'>
						<cfif getplacement.clienttype eq "hr">
                        <cfset "billitemamt#i#" = evaluate('billitemamt#i#') * val(selfsalaryhrsrecord) / val(counthour)>
                        <cfelse>
                        <cfset "billitemamt#i#" = evaluate('billitemamt#i#') * val(selfsalarydayrecord) / val(noofdays)>
                        </cfif>
                    </cfif>
               </cfif>
            </cfif>
        </cfloop>
        
        <cfset rebate = 0>
  <cfif val(getplacement.rebate) neq 0>
        	<cfset rebate = numberformat(getplacement.rebate,'.__')>
            <cfif getplacement.rebate_pro_rate eq "Y">
            <cfif getplacement.clienttype eq "hr">
                        <cfset rebate = rebate * val(selfsalaryhrsrecord) / val(counthour)>
                        <cfelse>
                        <cfset rebate = rebate * val(selfsalarydayrecord) / val(noofdays)>
                        </cfif>
			</cfif>
		</cfif> 
                
        
        
        
        <cfset ADDCHARGECODE = "" >
        <cfset ADDCHARGECODE2 = "" >
        <cfset ADDCHARGECODE3  = "" >
        <cfset DEDCUST1 = 0>
        <cfset DEDCUST2 = 0>
        <cfset DEDCUST3 = 0>
		  <cfset posted = "">
          <cfset locked = "">
          <cfset combine = "">
  <cfif isdefined('url.typenew')>
          <cfset button=url.typenew>
          <cfelse>
          <cfset button=url.type>
          </cfif>
        <cfset firstrate = numberformat(selfsalaryrecord,'.__') >
        <cfset secondrate = 0>
		<cfset  selfusualpay= numberformat(employeepay,'.__')>
        <cfset  custusualpay= numberformat(employerpay,'.__')>
        
        <cfset  selfsalaryhrs= numberformat(selfsalaryhrsrecord,'.__')>
        <cfset  selfsalaryday= numberformat(selfsalarydayrecord,'.__')>
        <cfset  custsalaryhrs= numberformat(custsalaryhrsrecord,'.__')>
        <cfset  custsalaryday=  numberformat(custsalarydayrecord,'.__')>
        
        <cfset  selfsalary= numberformat(selfsalaryrecord,'.__')>
        <cfset  custsalary= numberformat(custsalaryrecord,'.__')>
        <cfset selfphnlsalary = numberformat(totalphlvlee,'.__')>
        <cfset custphnlsalary = numberformat(totalphlvler,'.__')>
        
        <cfset selfexceptionrate= "0.00">
        <cfset selfexceptionhrs= "0">
        <cfset selfexceptionday= "0">
        <cfset selfexception= "0.00">
        <cfset selfotrate1= "0.00">
        <cfset selfothour1= "0">
        <cfset custotrate1= "0.00">
        <cfset custothour1= "0">
        <cfset selfot1= "0.00">
        <cfset custot1= "0.00">
        <cfset selfotrate2= "0.00">
        <cfset selfothour2= "0">
        <cfset custotrate2= "0.00">
        <cfset custothour2= "0">
        <cfset selfot2= "0.00">
        <cfset custot2= "0.00">
        <cfset selfotrate3= "0.00">
        <cfset selfothour3= "0">
        <cfset custotrate3= "0.00">
        <cfset custothour3= "0">
        <cfset selfot3= "0.00">
        <cfset custot3= "0.00">
        <cfset selfotrate4= "0.00">
        <cfset selfothour4= "0">
        <cfset custotrate4= "0.00">
        <cfset custothour4= "0">
  <cfloop from="5" to="8" index="c">
        <cfset "selfot#c#"= "0.00">
        <cfset "custot#c#"= "0.00">
        <cfset "selfotrate#c#"= "0.00">
        <cfset "selfothour#c#"= "0">
        <cfset "custotrate#c#"= "0.00">
        <cfset "custothour#c#"= "0">
        </cfloop>
  <cfif getplacement.pm neq "">
        <cfquery name="getpm" datasource="#dts#">
        SELECT * FROM manpowerpricematrixdetail WHERE priceid = "#getplacement.pm#" and left(itemname,2) = "OT"
        </cfquery>
        <CFSET RATEYEE = selfusualpay>
        <CFSET RATEYER = custusualpay>
        <cfloop query="getpm">
			<cfif getpm.itemname eq "OT1">
                <cfif getpm.payable eq "Y">
                <cfset BASIC = selfusualpay>
                
                <cfset selfotrate1= numberformat(evaluate('#replace(replace(getpm.payableamt,'=',''),'%','/100','all')#'),'.__')>
                </cfif>
                
                <cfif getpm.billable eq "Y">
                <cfset BASIC = selfusualpay>
                <cfset custotrate1= numberformat(evaluate(replace(replace(getpm.billableamt,'=',''),'%','/100','all')),'.__')>
                </cfif>
            <cfelseif getpm.itemname eq "OT1.5">
                <cfif getpm.payable eq "Y">
                <cfset BASIC = selfusualpay>
                <cfset selfotrate2= numberformat(evaluate(replace(replace(getpm.payableamt,'=',''),'%','/100','all')),'.__')>
                </cfif>
                
                <cfif getpm.billable eq "Y">
                <cfset BASIC = selfusualpay>				
                <cfset custotrate2= numberformat(evaluate(replace(replace(getpm.billableamt,'=',''),'%','/100','all')),'.__')>
				
                </cfif>
            <cfelseif getpm.itemname eq "OT2">
                <cfif getpm.payable eq "Y">
                <cfset BASIC = selfusualpay>
                <cfset selfotrate3= numberformat(evaluate(replace(replace(getpm.payableamt,'=',''),'%','/100','all')),'.__')>
                </cfif>
                
                <cfif getpm.billable eq "Y">
                <cfset BASIC = selfusualpay>
                <cfset custotrate3= numberformat(evaluate(replace(replace(getpm.billableamt,'=',''),'%','/100','all')),'.__')>
                </cfif>
            <cfelseif getpm.itemname eq "OT3">
                <cfif getpm.payable eq "Y">
                <cfset BASIC = selfusualpay>
                <cfset selfotrate4= numberformat(evaluate(replace(replace(getpm.payableamt,'=',''),'%','/100','all')),'.__')>
                </cfif>
                
                <cfif getpm.billable eq "Y">
                <cfset BASIC = selfusualpay>
                <cfset custotrate4= numberformat(evaluate(replace(replace(getpm.billableamt,'=',''),'%','/100','all')),'.__')>
           		</cfif>
                
            <cfelseif getpm.itemname eq "OT5">
                <cfif getpm.payable eq "Y">
                <cfset BASIC = selfusualpay>
                <cfset selfotrate5= numberformat(evaluate(replace(replace(getpm.payableamt,'=',''),'%','/100','all')),'.__')>
                </cfif>
                
                <cfif getpm.billable eq "Y">
                <cfset BASIC = selfusualpay>
                <cfset custotrate5= numberformat(evaluate(replace(replace(getpm.billableamt,'=',''),'%','/100','all')),'.__')>
           		</cfif>
                
            <cfelseif getpm.itemname eq "OT6">
                <cfif getpm.payable eq "Y">
                <cfset BASIC = selfusualpay>
                <cfset selfotrate6= numberformat(evaluate(replace(replace(getpm.payableamt,'=',''),'%','/100','all')),'.__')>
                </cfif>
                
                <cfif getpm.billable eq "Y">
                <cfset BASIC = selfusualpay>
                <cfset custotrate6= numberformat(evaluate(replace(replace(getpm.billableamt,'=',''),'%','/100','all')),'.__')>
           		</cfif>
            <cfelseif getpm.itemname eq "OT7">
                <cfif getpm.payable eq "Y">
                <cfset BASIC = selfusualpay>
                <cfset selfotrate7= numberformat(evaluate(replace(replace(getpm.payableamt,'=',''),'%','/100','all')),'.__')>
                </cfif>
                
                <cfif getpm.billable eq "Y">
                <cfset BASIC = selfusualpay>
                <cfset custotrate7= numberformat(evaluate(replace(replace(getpm.billableamt,'=',''),'%','/100','all')),'.__')>
           		</cfif>
            <cfelseif getpm.itemname eq "OT8">
                <cfif getpm.payable eq "Y">
                <cfset BASIC = selfusualpay>
                <cfset selfotrate8= numberformat(evaluate(replace(replace(getpm.payableamt,'=',''),'%','/100','all')),'.__')>
                </cfif>
                
                <cfif getpm.billable eq "Y">
                <cfset BASIC = selfusualpay>
                <cfset custotrate8= numberformat(evaluate(replace(replace(getpm.billableamt,'=',''),'%','/100','all')),'.__')>
           		</cfif>
            </cfif>
        </cfloop>
		</cfif>
  <cfif getplacement.clienttype eq "hr">
        <cfset otstart = 1>
        <cfloop list="1,1.5,2,3" index="a">
        <cfset "selfotrate#otstart#"= numberformat(selfusualpay * a,'.__')>
        <cfset "custotrate#otstart#"= numberformat(custusualpay * a,'.__')>
       <!---  <cfif isdefined('activateeffcal') >
        <cfset "selfotrate#otstart#"= numberformat(firstemployeepay * a,'.__')>
        <cfset "custotrate#otstart#"= numberformat(firstemployerpay * a,'.__')>
        </cfif> --->
		<cfset otstart = otstart + 1>
        </cfloop>
		</cfif>
        <cfset selfot4= "0.00">
        <cfset custot4= "0.00">
        <cfset selfottotal= "0.00">
        <cfset custottotal= "0.00">
        <cfset selfcpf= "0.00">
        <cfset custcpf= "0.00">
        <cfset addchargedesp2= "">
        <cfset addchargeself2= "0.00">
        <cfset addchargecust2= "0.00">
        
        <cfset addchargedesp3= "">
        <cfset addchargeself3= "0.00">
        <cfset addchargecust3= "0.00">
        <cfset addchargedesp4= "">
        <cfset addchargeself4= "0.00">
        <cfset addchargecust4= "0.00">
        
        <cfset selfsdf= "0.00">
        <cfset custsdf= "0.00">
        <cfset selfallowancerate1= "0.00">
        <cfset selfallowancehour1= "0">
        <cfset custallowancerate1= "0.00">
        <cfset custallowancehour1= "0">
        <cfset selfallowancerate2= "0.00">
        <cfset selfallowancehour2= "0">
        <cfset custallowancerate2= "0.00">
        <cfset custallowancehour2= "0">
        <cfset selfallowancerate3= "0.00">
        <cfset selfallowancehour3= "0">
        <cfset custallowancerate3= "0.00">
        <cfset custallowancehour3= "0">
        <cfset selfallowancerate4= "0.00">
        <cfset selfallowancehour4= "0">
        <cfset custallowancerate4= "0.00">
        <cfset custallowancehour4= "0">
        <cfset selfallowance= "0.00">
        <cfset custallowance= "0.00">
  <cfif isdefined('totalfixawamtee')>
        <cfset selfallowance= totalfixawamtee>
        <cfset custallowance= totalfixawamter>
		</cfif>
        <cfset selfpayback= "0.00">
        <cfset custpayback= "0.00">
        <cfset selfdeduction= "0.00">
        <cfset custdeduction= "0.00">
        <cfset selfnet= "0.00">
        <cfset custnet= "0.00">
        <cfset taxcode="SR">
        <cfset taxper="6.00">
        <cfset taxamt="0.00">
        <cfset selftotal= "0.00">
        <cfset custtotal= "0.00">
        <cfset custtotalgross= "0.00">
        <cfset AL="0">
        <cfset MC="0">
        
        <cfset addchargedesp= "">
        <cfset addchargeself= "0.00">
        <cfset addchargecust= "0.00">
        
        
        <cfset aw101desp = "">
        <cfset aw102desp = "">
        <cfset aw103desp = "">
        <cfset aw104desp = "">
        <cfset aw105desp = "">
        <cfset aw106desp = "">
        <cfset selfallowancerate5 = "0.00">
        <cfset selfallowancerate6 = "0.00">
        <cfset custallowancerate5 = "0.00">
        <cfset custallowancerate6 = "0.00">
        <cfset addchargedesp5= "">
        <cfset addchargeself5= "0.00">
        <cfset addchargecust5= "0.00">
        <cfset addchargedesp6= "">
        <cfset addchargeself6= "0.00">
        <cfset addchargecust6= "0.00">
        <cfset claimadd1 = "">
        <cfset claimadd2 = "">
        <cfset claimadd3 = "">
        <cfset claimadd4 = "">
        <cfset claimadd5 = "">
        <cfset claimadd6 = "">
        <cfset CUSTEXCEPTION = "0.00">
        <cfset NPL=nplrecord>
         <CFSET CUSTNPL = custnplrecord>
                  
        <cfset workd = noofdays>
   
        <cfset ded1 ="0.00">
        <cfset ded1desp = "">
        <cfset ded2 = "0.00">
        <cfset ded2desp = "">
        <cfset ded3 = "0.00">
        <cfset ded3desp = "">
        
        <cfset invdesp = "">
        <cfset invdesp2 = "">
        <cfset paydesp = "">
        <cfset backpaydesp = "">
  <cfloop from="1" to="10" index="ao">
        <cfset "lvlhr#ao#" = 0>
        </cfloop>
  <cfif isdefined('activateeffcal')>
        
        <cfset firstrate = numberformat(val(firsterpay)+0.000001,'.__')>
        <cfset secondrate = numberformat(val(seconderpay)+0.000001,'.__')>
        
        <cfif getplacement.clienttype eq "mth">
        		<cfset invdesp = "Services from "&lsdateformat(datestartof,'dd/mm/yyyy', 'en_AU')&" to "&lsdateformat(dateadd('d',-1,datestartwork),'dd/mm/yyyy', 'en_AU')&" ( "&numberformat(val(oldrateday) - val(firstnplval),'.__')&"/"&numberformat(val(oldrateday) + val(newrateday),'.__')&" days * "&firstemployerpay&")">
                <cfset invdesp2 = "Services from "&lsdateformat(datestartwork,'dd/mm/yyyy', 'en_AU')&" to "&lsdateformat(dateendof,'dd/mm/yyyy', 'en_AU')&" ( "&numberformat(val(newrateday) - val(secondnplval),'.__')&"/"&numberformat(val(oldrateday) + val(newrateday),'.__')&" days * "&secondemployerpay&")">
                <cfset paydesp = "Being Salary from "&lsdateformat(datestartof,'dd/mm/yyyy', 'en_AU')&" to "&lsdateformat(dateendof,'dd/mm/yyyy', 'en_AU')&" ( "&numberformat(val(oldrateday) - val(firstnplval),'.__')&"/"&numberformat(val(oldrateday) + val(newrateday),'.__')&" days * "&firstemployeepay&" and "&numberformat(val(newrateday) - val(secondnplval),'.__')&"/"&numberformat(val(oldrateday) + val(newrateday),'.__')&" days * "&secondemployeepay&")">
			<cfelseif getplacement.clienttype eq "hr">
            
            	<cfset invdesp = "Services from "&lsdateformat(datestartof,'dd/mm/yyyy', 'en_AU')&" to "&lsdateformat(dateadd('d',-1,datestartwork),'dd/mm/yyyy', 'en_AU')&" "&numberformat(val(oldrateday)-val(totalfirstdaysnpl),'.__')&" days ("&numberformat(val(firstdaysval) - val(firstnplval),'.__')&" hrs *"&numberformat(firstemployerpay,'.__')&")">
                <cfset invdesp2 = "Services from "&lsdateformat(datestartwork,'dd/mm/yyyy', 'en_AU')&" to "&lsdateformat(dateendof,'dd/mm/yyyy', 'en_AU')&" "&numberformat(val(newrateday)-val(totalseconddaysnpl),'.__')&" days ("&numberformat(val(seconddaysval) - val(secondnplval),'.__')&" hrs *"&numberformat(secondemployerpay,'.__')&")">
                <cfset paydesp = "Being Salary from "&lsdateformat(datestartof,'dd/mm/yyyy', 'en_AU')&" to "&lsdateformat(dateendof,'dd/mm/yyyy', 'en_AU')&" "&selfsalaryday&" days ("&numberformat(val(firstdaysval) - val(firstnplval),'.__')&" hrs *"&numberformat(firstemployeepay,'.__')&" and "&numberformat(val(seconddaysval) - val(secondnplval),'.__')&" hrs *"&numberformat(secondemployeepay,'.__')&")">
                
			<cfelseif  getplacement.clienttype eq "day">
             <cfoutput>
            #firstdaysval# #seconddaysval#
            </cfoutput>
            	<cfset invdesp = "Services from "&lsdateformat(datestartof,'dd/mm/yyyy', 'en_AU')&" to "&lsdateformat(dateadd('d',-1,datestartwork),'dd/mm/yyyy', 'en_AU')&" "&numberformat(val(firstdaysval) - val(firstnplval),'.__')&" days ("&numberformat(val(firstdaysval) - val(firstnplval),'.__')&" days *"&numberformat(firstemployerpay,'.__')&")">
                <cfset invdesp2 = "Services from "&lsdateformat(datestartwork,'dd/mm/yyyy', 'en_AU')&" to "&lsdateformat(dateendof,'dd/mm/yyyy', 'en_AU')&" "&numberformat(val(seconddaysval) - val(secondnplval),'.__')&" days ("&numberformat(val(seconddaysval) - val(secondnplval),'.__')&" days *"&numberformat(secondemployerpay,'.__')&")">
                <cfset paydesp = "Being Salary from "&lsdateformat(datestartof,'dd/mm/yyyy', 'en_AU')&" to "&lsdateformat(dateendof,'dd/mm/yyyy', 'en_AU')&" "&selfsalaryday&" days ("&numberformat(val(firstdaysval) - val(firstnplval),'.__')&" days *"&numberformat(firstemployeepay,'.__')&" and "&numberformat(val(seconddaysval) - val(secondnplval),'.__')&" days *"&numberformat(secondemployeepay,'.__')&")">
                
			</cfif>
        
        <cfelse>
        	<cfif getplacement.clienttype eq "mth">
        		<cfset invdesp = "Services from "&lsdateformat(datestartof,'dd/mm/yyyy', 'en_AU')&" to "&lsdateformat(dateendof,'dd/mm/yyyy', 'en_AU')>
                <cfset paydesp = "Being Salary from "&lsdateformat(datestartof,'dd/mm/yyyy', 'en_AU')&" to "&lsdateformat(dateendof,'dd/mm/yyyy', 'en_AU')>
                <cfif isdefined('activatedayntsame')>
                 <cfset invdesp = invdesp&" ( "&custsalaryday&"/"&workd&" days * "&custusualpay&" )">
                 <cfset paydesp = paydesp&" ( "&selfsalaryday&"/"&workd&" days * "&selfusualpay&" )">
                 <cfelse>
                 <cfif val(CUSTNPL) neq 0>
                <cfset invdesp = invdesp&" ( "&custsalaryday&"/"&workd&" days * "&custusualpay&" )">
				</cfif>
                <cfif val(NPL) neq 0>
                <cfset paydesp = paydesp&" ( "&selfsalaryday&"/"&workd&" days * "&selfusualpay&" )">
				</cfif>
                 
				</cfif>
			<cfelseif getplacement.clienttype eq "hr">
            
            	<cfset invdesp = "Services from "&lsdateformat(datestartof,'dd/mm/yyyy', 'en_AU')&" to "&lsdateformat(dateendof,'dd/mm/yyyy', 'en_AU')&" "&custsalaryday&" days ("&custsalaryhrs&" hrs *"&custusualpay&")">
                <cfset paydesp = "Being Salary from "&lsdateformat(datestartof,'dd/mm/yyyy','en_AU')&" to "&lsdateformat(dateendof,'dd/mm/yyyy', 'en_AU')&" "&selfsalaryday&" days ("&selfsalaryhrs&" hrs *"&selfusualpay&")">
                
			<cfelseif  getplacement.clienttype eq "day">
            
            	<cfset invdesp = "Services from "&lsdateformat(datestartof,'dd/mm/yyyy', 'en_AU')&" to "&lsdateformat(dateendof,'dd/mm/yyyy', 'en_AU')&" "&custsalaryday&" days ("&custsalaryday&"*"&custusualpay&")">
                <cfset paydesp = "Being Salary from "&lsdateformat(datestartof,'dd/mm/yyyy','en_AU')&" to "&lsdateformat(dateendof,'dd/mm/yyyy','en_AU')&" "&selfsalaryday&" days ("&selfsalaryday&" days *"&selfusualpay&")">
                
			</cfif>
     	</cfif>

<cfelse>
		<cfquery name="getitem" datasource="#dts#">
        SELECT * FROM assignmentslip WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
        </cfquery>
        
		<cfquery name="getplacement" datasource="#dts#">
SELECT * FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.placementno#">
</cfquery>
 		
		<cfset  selfusualpay= getitem.selfusualpay>
        <cfset  custusualpay= getitem.custusualpay>
        <cfset  selfsalaryhrs= getitem.selfsalaryhrs>
        <cfset  selfsalaryday= getitem.selfsalaryday>
        <cfset  custsalaryhrs= getitem.custsalaryhrs>
        <cfset  custsalaryday= getitem.custsalaryday>
        <cfset  selfsalary= getitem.selfsalary>
        <cfset  custsalary= getitem.custsalary>
        <cfset selfexceptionrate= getitem.selfexceptionrate>
        <cfset selfexceptionhrs= getitem.selfexceptionhrs>
        <cfset selfexceptionday= getitem.selfexceptionday>
        <cfset selfexception= getitem.selfexception>
        <cfset selfotrate1= getitem.selfotrate1>
        <cfset selfothour1= getitem.selfothour1>
        <cfset custotrate1= getitem.custotrate1>
        <cfset custothour1= getitem.custothour1>
        <cfset selfot1= getitem.selfot1>
        <cfset custot1= getitem.custot1>
        <cfset selfotrate2= getitem.selfotrate2>
        <cfset selfothour2= getitem.selfothour2>
        <cfset custotrate2= getitem.custotrate2>
        <cfset custothour2= getitem.custothour2>
        <cfset selfot2= getitem.selfot2>
        <cfset custot2= getitem.custot2>
        <cfset selfotrate3= getitem.selfotrate3>
        <cfset selfothour3= getitem.selfothour3>
        <cfset custotrate3= getitem.custotrate3>
        <cfset custothour3= getitem.custothour3>
        <cfset selfot3= getitem.selfot3>
        <cfset custot3= getitem.custot3>
        <cfset selfotrate4= getitem.selfotrate4>
        <cfset selfothour4= getitem.selfothour4>
        <cfset custotrate4= getitem.custotrate4>
        <cfset custothour4= getitem.custothour4>
        <cfset selfot4= getitem.selfot4>
        <cfset custot4= getitem.custot4>
  <cfloop from="5" to="8" index="c">
        <cfset "selfot#c#"= evaluate('getitem.selfot#c#')>
        <cfset "custot#c#"= evaluate('getitem.custot#c#')>
        <cfset "selfotrate#c#"= evaluate('getitem.selfotrate#c#')>
        <cfset "selfothour#c#"= evaluate('getitem.selfothour#c#')>
        <cfset "custotrate#c#"= evaluate('getitem.custotrate#c#')>
        <cfset "custothour#c#"= evaluate('getitem.custothour#c#')>
        </cfloop>
        <cfset selfottotal= getitem.selfottotal>
        <cfset custottotal= getitem.custottotal>
        
        <cfset addchargedesp= getitem.addchargedesp>
        <cfset addchargeself= getitem.addchargeself>
        <cfset addchargecust= getitem.addchargecust>
        
        <cfset addchargedesp2= getitem.addchargedesp2>
        <cfset addchargeself2= getitem.addchargeself2>
        <cfset addchargecust2= getitem.addchargecust2>
        
        <cfset addchargedesp3= getitem.addchargedesp3>
        <cfset addchargeself3= getitem.addchargeself3>
        <cfset addchargecust3= getitem.addchargecust3>
        
        <cfset addchargedesp4= getitem.addchargedesp4>
        <cfset addchargeself4= getitem.addchargeself4>
        <cfset addchargecust4= getitem.addchargecust4>
        
        <cfset selfcpf= getitem.selfcpf>
        <cfset custcpf= getitem.custcpf>
        
        <cfset selfsdf= getitem.selfsdf>
        <cfset custsdf= getitem.custsdf>
        
        <cfset selfallowancerate1= getitem.selfallowancerate1>
        <cfset selfallowancehour1= getitem.selfallowancehour1>
        <cfset custallowancerate1= getitem.custallowancerate1>
        <cfset custallowancehour1= getitem.custallowancehour1>
        <cfset selfallowancerate2= getitem.selfallowancerate2>
        <cfset selfallowancehour2= getitem.selfallowancehour2>
        <cfset custallowancerate2= getitem.custallowancerate2>
        <cfset custallowancehour2= getitem.custallowancehour2>
        <cfset selfallowancerate3= getitem.selfallowancerate3>
        <cfset selfallowancehour3= getitem.selfallowancehour3>
        <cfset custallowancerate3= getitem.custallowancerate3>
        <cfset custallowancehour3= getitem.custallowancehour3>
        <cfset selfallowancerate4= getitem.selfallowancerate4>
        <cfset selfallowancehour4= getitem.selfallowancehour4>
        <cfset custallowancerate4= getitem.custallowancerate4>
        <cfset custallowancehour4= getitem.custallowancehour4>
        <cfset selfallowance= getitem.selfallowance>
        <cfset custallowance= getitem.custallowance>
        <cfset selfpayback= getitem.selfpayback>
        <cfset custpayback= getitem.custpayback>
        <cfset selfdeduction= getitem.selfdeduction>
        <cfset custdeduction= getitem.custdeduction>
        <cfset selfnet= getitem.selfnet>
        <cfset custnet= getitem.custnet>
        <cfset taxcode=getitem.taxcode>
        <cfset taxper=getitem.taxper>
        <cfset taxamt=getitem.taxamt>
        <cfset selftotal= getitem.selftotal>
        <cfset custtotal= getitem.custtotal>
        <cfset payrollperiod=getitem.payrollperiod>
        <cfset custname=getitem.custname>
        <cfset custname2 = getitem.custname2>
        <cfset iname = getitem.iname>
        <cfset supervisor = getitem.supervisor>
        <cfset assigndesp = getitem.assigndesp>
        <cfset empname=getitem.empname>
        <cfset assignmenttype=getitem.assignmenttype>
        <cfset paymenttype=getitem.paymenttype>
        <cfset AL=getitem.AL>
        <cfset MC=getitem.MC>
		
        <cfset aw101desp = getitem.aw101desp>
        <cfset aw102desp = getitem.aw102desp>
        <cfset aw103desp = getitem.aw103desp>
        <cfset aw104desp = getitem.aw104desp>
        <cfset aw105desp = getitem.aw105desp>
        <cfset aw106desp = getitem.aw106desp>
        <cfset selfallowancerate5 = getitem.selfallowancerate5>
        <cfset selfallowancerate6 = getitem.selfallowancerate6>
        <cfset custallowancerate5 = getitem.custallowancerate5>
        <cfset custallowancerate6 = getitem.custallowancerate6>
        <cfset addchargedesp5= getitem.addchargedesp5>
        <cfset addchargeself5= getitem.addchargeself5>
        <cfset addchargecust5= getitem.addchargecust5>
        <cfset addchargedesp6= getitem.addchargedesp6>
        <cfset addchargeself6= getitem.addchargeself6>
        <cfset addchargecust6= getitem.addchargecust6>
        <cfset claimadd1 = getitem.claimadd1>
        <cfset claimadd2 = getitem.claimadd2>
        <cfset claimadd3 = getitem.claimadd3>
        <cfset claimadd4 = getitem.claimadd4>
        <cfset claimadd5 = getitem.claimadd5>
        <cfset claimadd6 = getitem.claimadd6>
        <cfset CUSTEXCEPTION = getitem.CUSTEXCEPTION>
        <cfset NPL=getitem.NPL>
        <CFSET CUSTNPL = getitem.custnpl>
        <cfset workd = getitem.workd>
        <cfset nsded = getitem.nsded>
        <cfset nsdeddesp = getitem.nsdeddesp>
        <cfset ded1 = getitem.ded1>
        <cfset ded1desp = getitem.ded1desp>
        <cfset ded2 = getitem.ded2>
        <cfset ded2desp = getitem.ded2desp>
        <cfset ded3 = getitem.ded3>
        <cfset ded3desp = getitem.ded3desp>
        <cfset custname2 = getitem.custname2>
		<cfset iname = getitem.iname>
        <cfset supervisor = getitem.supervisor>
        <cfset assigndesp = getitem.assigndesp>
        <cfset invdesp = getitem.invdesp>
        <cfset invdesp2 = getitem.invdesp2>
        <cfset paydesp = getitem.paydesp>
        <cfset backpaydesp = getitem.backpaydesp>
  <cfloop from="1" to="10" index="i">
        <cfif evaluate('getitem.lvltype#i#') neq "">
        <cfset "lvltype#i#" = evaluate('getitem.lvltype#i#')>
        <cfset "lvldesp#i#" = evaluate('getitem.lvldesp#i#')>
        <cfset "lvleedayhr#i#" = evaluate('getitem.lvleedayhr#i#')>
        <cfset "lvleerate#i#" = numberformat(evaluate('getitem.lvleerate#i#'),'.____')>
        <cfset "lvlerdayhr#i#" = evaluate('getitem.lvlerdayhr#i#')>
        <cfset "lvlerrate#i#" = numberformat(evaluate('getitem.lvlerrate#i#'),'.____')>
        <cfset "lvltotalee#i#" = numberformat(evaluate('getitem.lvltotalee#i#'),'.__')>
        <cfset "lvltotaler#i#" = numberformat(evaluate('getitem.lvltotaler#i#'),'.__')>
         <cfset "lvlhr#i#" = numberformat(evaluate('getitem.lvlhr#i#'),'.__')>
        </cfif>
        </cfloop>
  <cfloop from="1" to="6" index="i">
        <cfif evaluate('getitem.fixawcode#i#') neq "">
        <cfset "fixawcode#i#" = evaluate('getitem.fixawcode#i#')>
        <cfset "fixawdesp#i#" = evaluate('getitem.fixawdesp#i#')>
        <cfset "fixawee#i#" = numberformat(evaluate('getitem.fixawee#i#'),'.__')>
        <cfset "fixawer#i#" = numberformat(evaluate('getitem.fixawer#i#'),'.__')>
        <cfset "fixaworiamt#i#" = numberformat(evaluate('getitem.fixaworiamt#i#'),'.__')>
        </cfif>
        </cfloop>
  <cfloop from="1" to="18" index="a">
        <cfset "aw#a#" = evaluate('getitem.allowance#a#')>
        <cfset "allowancedesp#a#" = evaluate('getitem.allowancedesp#a#')>
        <cfset "awee#a#" = numberformat(evaluate('getitem.awee#a#'),'.__')>
        <cfset "awer#a#" = numberformat(evaluate('getitem.awer#a#'),'.__')>
        </cfloop>
        <cfset pbtext = getitem.pbtext>
        <cfset pbeeamt = numberformat(getitem.pbeeamt,'.__')>
        <cfset pberamt = numberformat(getitem.pberamt,'.__')>
        <cfset awstext = getitem.awstext>
        <cfset awseeamt = numberformat(getitem.awseeamt,'.__')>
        <cfset awseramt = numberformat(getitem.awseramt,'.__')>
        <cfset bonusmisctext = getitem.bonusmisctext>
        <cfset pbcpf = numberformat(getitem.pbcpf,'.__')>
        <cfset pbsdf = numberformat(getitem.pbsdf,'.__')>
        <cfset pbwi = numberformat(getitem.pbwi,'.__')>
        <cfset pbadm = numberformat(getitem.pbadm,'.__')>
        <cfset totalpbmisc = numberformat(getitem.totalpbmisc,'.__')>
        <cfset awsmisctext = getitem.awsmisctext>
        <cfset awscpf = numberformat(getitem.awscpf,'.__')>
        <cfset awssdf = numberformat(getitem.awssdf,'.__')>
        <cfset awswi = numberformat(getitem.awswi,'.__')>
        <cfset awsadm = numberformat(getitem.awsadm,'.__')>
        <cfset totalawsmisc = numberformat(getitem.totalawsmisc,'.__')>
        <cfset selfpbaws = numberformat(getitem.selfpbaws,'.__')>
        <cfset custpbaws = numberformat(getitem.custpbaws,'.__')>
        <cfset nscustded = numberformat(getitem.nscustded,'.__')>
        <cfset adminfeepercent = numberformat(getitem.adminfeepercent,'.__')>
        <cfset adminfeeminamt = numberformat(getitem.adminfeeminamt,'.__')>
        <cfset adminfee = numberformat(getitem.adminfee,'.__')>
  <cfloop from="1" to="3" index="i">
        <cfif evaluate('getitem.billitem#i#') neq "">
        <cfset "billitem#i#" = evaluate('getitem.billitem#i#')>
        <cfset "billitemdesp#i#" = evaluate('getitem.billitemdesp#i#')>
        <cfset "billitemamt#i#" = numberformat(evaluate('getitem.billitemamt#i#'),'.__')>
        <cfset "billitempercent#i#" = numberformat(evaluate('getitem.billitempercent#i#'),'.__')>
        </cfif>
        </cfloop>
        <cfset rebate = numberformat(getitem.rebate,'.__')>
        <cfset custtotalgross = numberformat(getitem.custtotalgross,'.__')>
        <cfset SELFPHNLSALARY = numberformat(getitem.SELFPHNLSALARY,'.__')>
        <cfset CUSTPHNLSALARY = numberformat(getitem.CUSTPHNLSALARY,'.__')>
        <cfset ADDCHARGECODE = getitem.ADDCHARGECODE>
        <cfset ADDCHARGECODE2 = getitem.ADDCHARGECODE2>
        <cfset ADDCHARGECODE3 = getitem.ADDCHARGECODE3>
  <cfloop from="1" to="3" index="i">
        <cfset "dedcust#i#" = numberformat(evaluate('getitem.dedcust#i#'),'.__')>
        </cfloop>
        <cfset firstrate = numberformat(getitem.firstrate,'.__') >
        <cfset secondrate = numberformat(getitem.secondrate,'.__')>
        <cfset posted = getitem.posted>
       <cfset locked = getitem.locked>
       <cfset combine = getitem.combine>
        <cfset mode=url.type>
		<cfset title="#url.type# Assignmentslip">
		<cfset button=url.type>

</cfif>
        

<table align="center" class="data" >
      <cfoutput>
      
      <tr>
      
      <th>Working Day</th>
      <td><input type="text" size='10' name="workd" id="workd" value="#workd#" onKeyUp="selfnpl();custnpl();"></td>
      <td></td>
      <td></td>
      <td></td>
      <td></td>
      <td><strong><u>Employee</u></strong></td>
      <td style="background-color:#bgcolor#"><strong><u>Employer</u></strong></td>
      </tr>
	  
      <tr>
          <th colspan="6"><div align="right">Basic Rate</div></th>
                <td><input type="text" name="selfusualpay" id="selfusualpay" value="#numberformat(selfusualpay,'.__')#" onKeyUp="calculateselfhour();"  size='10'></td>
          <td style="background-color:#bgcolor#"><input type="text" name="custusualpay" id="custusualpay" value="#numberformat(custusualpay,'_.__')#" onKeyUp="calculatecusthour();"  size='10'></td>
      </tr>
      
      <tr>
      <td></td>
      <td></td>
      <th><div align="left">Employee</div></th>
      <th style="background-color:#bgcolor#"><div align="left">Employer</div></th>
      <cfif isdefined('activateeffcal')><td colspan="4" rowspan="4"><font color="##FF0000" size="3">There are multiple effective rates during pay period. <br />
Please verify to ensure amounts are correct. </font></td></cfif>
      </tr>
     <cfif isdefined('url.auto')>
     <cfquery name="getall" datasource="#replace(dts,'_i','_p')#">
    SELECT sum(workhours) as wh FROM timesheet WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.empno#"> 
    AND placementno = '#pno#'
    <!--- and tmonth = '#url.auto#'--->
    AND pdate between "#lsdateformat(url.startdate, 'yyyy-mm-dd', 'en_AU')#"
    AND "#lsdateformat(url.enddate,'yyyy-mm-dd', 'en_AU')#"
    ORDER by pdate    
    </cfquery>
    
    <cfquery name="getot" datasource="#replace(dts,'_i','_p')#">
    SELECT sum(ot1) as ot1
    ,sum(ot2) as ot2
    ,sum(ot3) as ot3
    ,sum(ot4) as ot4
    ,sum(ot5) as ot5
    ,sum(ot6) as ot6
    ,sum(ot7) as ot7
    ,sum(ot8) as ot8
     FROM timesheet WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.empno#"> 
    AND placementno = '#getplacement.placementno#'
    <!--- and tmonth = '#url.auto#'--->
    AND pdate between "#lsdateformat(url.startdate, 'yyyy-mm-dd', 'en_AU')#"
    AND "#lsdateformat(url.enddate,'yyyy-mm-dd', 'en_AU')#"
    order by pdate
    </cfquery>
    
   <cfset selfothour1 =val(getot.ot1)>
   <cfset selfothour2 =val(getot.ot2)>
   <cfset selfothour3 =val(getot.ot3)>
   <cfset selfothour4 =val(getot.ot4)>
   <cfset selfothour5 =val(getot.ot5)>
   <cfset selfothour6 =val(getot.ot6)>
   <cfset selfothour7 =val(getot.ot7)>
   <cfset selfothour8 =val(getot.ot8)>
   
   <cfset custothour1 =val(getot.ot1)>
   <cfset custothour2 =val(getot.ot2)>
   <cfset custothour3 =val(getot.ot3)>
   <cfset custothour4 =val(getot.ot4)>
   <cfset custothour5 =val(getot.ot5)>
   <cfset custothour6 =val(getot.ot6)>
   <cfset custothour7 =val(getot.ot7)>
   <cfset custothour8 =val(getot.ot8)>
    
    <cfquery name="getalldays" datasource="#replace(dts,'_i','_p')#">
    SELECT * FROM timesheet WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.empno#"> 
    AND placementno = '#getplacement.placementno#'
    <!--- and tmonth = '#url.auto#'--->
    AND pdate between "#lsdateformat(url.startdate, 'yyyy-mm-dd', 'en_AU')#"
    AND "#lsdateformat(url.enddate,'yyyy-mm-dd', 'en_AU')#"
    order by pdate
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
			<cfif getalldays.stcol eq "NPL">
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
			<cfif getalldays.stcol eq "NPL">
            <cfset daycountwork2 = daycountwork2 + 1 >
            </cfif>
        </cfif>
        
    </cfif>
    
    </cfloop>
	<cfset NPL = daycountwork2>
    <cfset CUSTNPL = daycountwork2>
    <cfset selfsalaryday = daycountwork>
    <cfset custsalaryday = daycountwork>
    <cfset selfsalaryhrs = numberformat(getall.wh,'.__')>
    <cfset custsalaryhrs = numberformat(getall.wh,'.__')>
	 </cfif>
     
     <cfif isdefined('url.auto2')>
     <cfquery name="getdetails" datasource="#dts#">
SELECT * fROM (
select id,D,E,F,L,M,N,O,P,Q,R from importdata.exceldata1 where f <> ""
and L not in ('Normal','Admin Fee','+EPF','+SOCSO','+Med Benefit Reimburse','+SOCSO OT')
and L not like "admin fee%"
and I <> ""
AND f = "#getplacement.placementno#"
AND id <= "#url.auto2#"
) as a
LEFT JOIN
(select  dballid,dballname from ftstdallow) as b
on a.L = b.dballname
order by  id
     </cfquery>
     
     <cfset varaw = 1>
     <cfloop query="getdetails">
     <cfif getdetails.dballid eq "22" or getdetails.dballid eq "23" or getdetails.dballid eq "24">
     <cfif getdetails.dballid eq "22">
     <cfset selfothour2 =val(getdetails.M)>
     <cfset custothour2 =val(getdetails.P)>
	 </cfif>
     
     <cfif getdetails.dballid eq "23">
     <cfset selfothour3 =val(getdetails.M)>
     <cfset custothour3 =val(getdetails.P)>
	 </cfif>
     
     <cfif getdetails.dballid eq "24">
     <cfset selfothour4 =val(getdetails.M)>
     <cfset custothour4 =val(getdetails.P)>
	 </cfif>
     
	 <cfelse>
         <cfset fixawcheck = 0>
         <cfset billitemcheck = 0>
         <cfloop from="1" to="6" index="a">
         	<cfif isdefined('fixawcode#a#') and evaluate('fixawcode#a#') eq getdetails.dballid>
           
            	<cfset fixawcheck = 1>
                <cfbreak>
			</cfif>
         </cfloop>
         <cfif fixawcheck eq 0>
         
         <cfloop from="1" to="6" index="a">
         	<cfif isdefined('getdetails.billitem#a#') and evaluate('getdetails.billitem#a#') eq getdetails.dballid>
            	<cfset billitemcheck = 1>
                <cfbreak>
			</cfif>
         </cfloop>
         
         <cfif billitemcheck eq 0>
         	<cfset "aw#varaw#" = getdetails.dballid>
            <cfset "allowancedesp#varaw#" = getdetails.dballname>
            <cfset "awee#varaw#" = getdetails.o>
            <cfset "awer#varaw#" = getdetails.r>
            <cfset varaw += 1>
		 </cfif>
         	
		 </cfif>
     </cfif>
     </cfloop>
     
	 </cfif>
     
      <tr style="display:none">
      <th>NPL</th>
      <td></td>
      <td><input type="text" size='10' name="NPL" id="NPL" value="#NPL#" onKeyUp="selfnpl()"></td>
      <td  style="background-color:#bgcolor#"><input type="text" size='10' name="CUSTNPL" id="CUSTNPL" value="#CUSTNPL#" onKeyUp="custnpl()"></td>
      </tr>
      <tr>
      <th>Days Worked</th>
      <td></td>
      <td><input type="text" size='10' name="selfsalaryday" id="selfsalaryday" value="#selfsalaryday#" onKeyUp="setselfallow();"></td>
      <td style="background-color:#bgcolor#">
      <input type="text" size='10' name="custsalaryday" id="custsalaryday" value="#custsalaryday#" onKeyUp="setcustallow();">
      </td>
      </tr>
      
      <tr>
      <th>Hours Worked</th>
      <td></td>
      <td><input type="text" size='10' name="selfsalaryhrs" id="selfsalaryhrs" value="#selfsalaryhrs#" onKeyUp="setselfallow();"></td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custsalaryhrs" id="custsalaryhrs" value="#custsalaryhrs#" onKeyUp="setcustallow();"></td>
      </tr>
      
      <tr style="display:none">
       <th>AL</th>
      <td><input type="text" size='10' name="AL" id="AL" value="#AL#"></td>
      <td></td><th>MC</th>
      <td><input type="text" size='10' name="MC" id="MC" value="#MC#"></td>
     
      <td></td>
      </tr>
    
      <tr>
      <th style="background-color:#bgcolor#">Invoice Desp 1:</th>
      <td style="background-color:#bgcolor#" colspan="3"><input type="text" name="invdesp" id="invdesp" value="#invdesp#" size="60" /></td>
      <td><input type="text" size="10" name="firstrate" id="firstrate" value="#numberformat(firstrate,'.__')#" onkeyup="calextra();" /></td>
      <th><div align="right">Basic Pay</div></th>
             <td><input type="text" size='10' name="selfsalary" id="selfsalary" value="#numberformat(selfsalary,'_.__')#" onKeyUp="calselftotal();"></td>
       <td style="background-color:#bgcolor#"><input type="text" size='10' name="custsalary" id="custsalary" value="#numberformat(custsalary,'_.__')#" onKeyUp="calcusttotal();"></td>
      </tr>
      <tr>
      <th style="background-color:#bgcolor#">Invoice Desp 2:</th>
      <td style="background-color:#bgcolor#" colspan="3"><input type="text" name="invdesp2" id="invdesp2" value="#invdesp2#" size="60" /></td>
      <td><input type="text" size="10" name="secondrate" id="secondrate" value="#numberformat(secondrate,'.__')#" onkeyup="calextra();"/></td>
      </tr>
      <tr>
      <th>Pay Slip Desp:</th>
      <td colspan="3"><input type="text" name="paydesp" id="paydesp" value="#paydesp#" size="60" /></td>
      </tr>
      <tr><td>&nbsp;</td></tr>
      <tr style="display:none">
      <th colspan="8"><div align="left">Paid PH & Leaves for Hourly/Daily Rated</div></th>
      </tr>
      <tr>
      <th><div align="left"><!--- PH and Leaves ---></div></th>
      <th></th>
      <th><div align="left">Hour/Day</div></th>
      <th><div align="left">Rate</div></th>
      <th style="background-color:#bgcolor#"><div align="left">Hour/Day</div></th>
      <th style="background-color:#bgcolor#"><div align="left">Rate</div></th>
      <th style="background-color:#bgcolor#"><!--- <div align="left">Hrs for D/M EE</div> ---></th>
      </tr>
      
      <cfloop from="1" to="10" index="i">
      <cfif isdefined('lvltype#i#')>
      <tr>
      <th>
      #evaluate('lvltype#i#')#
      <input type="hidden" name="lvltype#i#" id="lvltype#i#" value="#evaluate('lvltype#i#')#" size="10" readonly />
      </th>
      <td>
	  <input type="text" name="lvldesp#i#" id="lvldesp#i#" value="#evaluate('lvldesp#i#')#" size="30" />
      </td>
      <td>
      <input type="text" name="lvleedayhr#i#" id="lvleedayhr#i#" value="#evaluate('lvleedayhr#i#')#" size="10" onkeyup="leaveself();" />
      </td>
      <td>
      <input type="text" name="lvleerate#i#" id="lvleerate#i#" value="#evaluate('lvleerate#i#')#" size="10" onkeyup="leaveself();" />
      </td>
      <td style="background-color:#bgcolor#">
      <input type="text" name="lvlerdayhr#i#" id="lvlerdayhr#i#" value="#evaluate('lvlerdayhr#i#')#" size="10" onkeyup="leavecust();" />
      </td>
      <td style="background-color:#bgcolor#">
      <input type="text" name="lvlerrate#i#" id="lvlerrate#i#" value="#evaluate('lvlerrate#i#')#" size="10" onkeyup="leavecust();" />
      </td>
      <td>
      <input type="hidden" name="lvlhr#i#" id="lvlhr#i#" value="#evaluate('lvlhr#i#')#" size="10" />
      <input type="text" name="lvltotalee#i#" id="lvltotalee#i#" value="#evaluate('lvltotalee#i#')#" size="10" readonly />
      </td>
      <td>
      <input type="text" name="lvltotaler#i#" id="lvltotaler#i#" value="#evaluate('lvltotaler#i#')#" size="10" readonly />
      </td>
      </tr>
      <cfelseif isdefined('lvltype#i-1#') or i eq 1>
      <tr style="display:none">
      <td>
       <cfquery name="getleave" datasource="#dts#">
        Select * from iccostcode order by costcode
        </cfquery>
        <select name="lvltype#i#" id="lvltype#i#" style="width:100px" onchange="checklvl('#i#');">
        <option value="">Choose a Leave Type</option>
        <cfloop query="getleave">
        <option value="#getleave.costcode#">#getleave.costcode# - #getleave.desp#</option>
        </cfloop>
        </select>
      </td>
      <td>
	  <input type="text" name="lvldesp#i#" id="lvldesp#i#" value="" size="30" readonly />
      </td>
      <td>
      <input type="text" name="lvleedayhr#i#" id="lvleedayhr#i#" value="0.00" size="10" onkeyup="leaveself();" readonly />
      </td>
      <td>
      <input type="text" name="lvleerate#i#" id="lvleerate#i#" value="0.00" size="10" onkeyup="leaveself();" readonly />
      </td>
      <td style="background-color:#bgcolor#">
      <input type="text" name="lvlerdayhr#i#" id="lvlerdayhr#i#" value="0.00" size="10" onkeyup="leavecust();" readonly />
      </td>
      <td style="background-color:#bgcolor#">
      <input type="text" name="lvlerrate#i#" id="lvlerrate#i#" value="0.00" size="10" onkeyup="leavecust();" readonly />
      </td>
      <td>
      <input type="text" name="lvlhr#i#" id="lvlhr#i#" value="0.00" size="10" readonly />
      <input type="hidden" name="lvltotalee#i#" id="lvltotalee#i#" value="" />
      </td>
      <td>
      <input type="hidden" name="lvltotaler#i#" id="lvltotaler#i#" value="" />
      </td>
      </tr>
      <cfelse>
      <input type="hidden" name="lvltype#i#" id="lvltype#i#" value="" size="10" />
      <input type="hidden" name="lvldesp#i#" id="lvldesp#i#" value="" size="30" />
      <input type="hidden" name="lvleedayhr#i#" id="lvleedayhr#i#" value="" size="10" />
      <input type="hidden" name="lvleerate#i#" id="lvleerate#i#" value="" size="10" />
      <input type="hidden" name="lvlerdayhr#i#" id="lvlerdayhr#i#" value="" size="10" />
      <input type="hidden" name="lvlerrate#i#" id="lvlerrate#i#" value="" size="10" />
      <input type="hidden" name="lvltotalee#i#" id="lvltotalee#i#" value="" />
      <input type="hidden" name="lvltotaler#i#" id="lvltotaler#i#" value="" />
      <input type="hidden" name="lvlhr#i#" id="lvlhr#i#" value="" />
      </cfif>
      </cfloop>
	 
      <tr style="display:none">
       <th colspan="6"><div align="right">Paid PH and Leaves</div></th>
             <td><input type="text" size='10' name="selfphnlsalary" id="selfphnlsalary" value="#numberformat(selfphnlsalary,'_.__')#" onKeyUp="calselftotal();" readonly></td>
       <td style="background-color:#bgcolor#"><input type="text" size='10' name="custphnlsalary" id="custphnlsalary" value="#numberformat(custphnlsalary,'_.__')#" onKeyUp="calcusttotal();" readonly></td>
      </tr>
      <tr>
      <td>&nbsp;</td>
      </tr>
      <tr>
      <th colspan="8"><div align="left">Overtime</div></th>
      </tr>
      <tr>
      <td></td>
      <td></td>
      <th><div align="left">Employee</div></th>
      <td></td>
      <th style="background-color:#bgcolor#"><div align="left">Employer</div></th>
      <td></td>
      </tr>
       <tr>
       <td></td>
       <td></td>
      <th><div align="left">Rate</div></th>
      <th><div align="left">Hours</div></th>
      <th style="background-color:#bgcolor#"><div align="left">Rate</div></th>
      <th style="background-color:#bgcolor#"><div align="left">Hours&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></th>
      
      </tr>
      <tr style="display:none">
      <th>Exception</th>
      <td></td>
      <td>
      <input type="text" size='10' name="selfexceptionrate" id="selfexceptionrate" value="#selfexceptionrate#" onKeyUp="calselfexception();"> </td>
      <td>
      <input type="text" size='10' name="selfexceptionhrs" id="selfexceptionhrs" value="#selfexceptionhrs#" onKeyUp="calselfexception();"> Hrs / Days
      </td>
 
      <td ><input style="display:none" type="text" size='10' name="selfexceptionday" id="selfexceptionday" value="#selfexceptionday#"><!---  Days ---></td>
      <td></td>

       <td><input type="text" size='10' name="selfexception"  id="selfexception" value="#selfexception#"></td><td><input type="text" size='10' name="custexception"  id="custexception" value="#custexception#"></td>
      </tr>
      
      <tr>
      <th>OT 1.0</th>
      <td></td>
      <td>
      <input type="text" size='10' name="selfotrate1" id="selfotrate1" value="#selfotrate1#" onKeyUp="calselfot1();"> </td>
      <td><input type="text" size='10' name="selfothour1" id="selfothour1" value="#selfothour1#" onKeyUp="calselfot1();"> </td>
      
      <td style="background-color:#bgcolor#">
      <input type="text" size='10' name="custotrate1" id="custotrate1" value="#custotrate1#" onKeyUp="calcustot1();"> </td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custothour1" id="custothour1" value="#custothour1#" onKeyUp="calcustot1();"> </td>

       <td><input type="text" size='10' name="selfot1" id="selfot1" value="#numberformat(selfot1,'_.__')#"></td><td style="background-color:#bgcolor#"><input type="text" size='10' name="custot1" id="custot1" value="#numberformat(custot1,'_.__')#" readonly></td>
      </tr>
      
      <tr>
      <th>OT 1.5</th>
       <td></td>
      <td>
      <input type="text" size='10' name="selfotrate2" id="selfotrate2" value="#selfotrate2#" onKeyUp="calselfot2();"> </td>
      <td><input type="text" size='10' name="selfothour2" id="selfothour2" value="#selfothour2#" onKeyUp="calselfot2();"> </td>
      
      <td style="background-color:#bgcolor#">
      <input type="text" size='10' name="custotrate2" id="custotrate2" value="#custotrate2#" onKeyUp="calcustot2();"> </td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custothour2" id="custothour2" value="#custothour2#" onKeyUp="calcustot2();"> </td>

       <td><input type="text" size='10' name="selfot2"  id="selfot2" value="#numberformat(selfot2,'_.__')#"></td><td style="background-color:#bgcolor#"><input type="text" size='10' name="custot2" id="custot2" value="#numberformat(custot2,'_.__')#" readonly></td>
      </tr>
      
      <tr>
      <th>OT 2.0</th>
       <td></td>
      <td>
      <input type="text" size='10' name="selfotrate3" id="selfotrate3" value="#selfotrate3#" onKeyUp="calselfot3();"> </td>
      <td><input type="text" size='10' name="selfothour3" id="selfothour3" value="#selfothour3#" onKeyUp="calselfot3();"> </td>
      
      <td style="background-color:#bgcolor#">
      <input type="text" size='10' name="custotrate3" id="custotrate3" value="#custotrate3#" onKeyUp="calcustot3();"> </td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custothour3" id="custothour3" value="#custothour3#" onKeyUp="calcustot3();"> </td>

       <td><input type="text" size='10' name="selfot3" id="selfot3" value="#numberformat(selfot3,'_.__')#"></td><td style="background-color:#bgcolor#"><input type="text" size='10' name="custot3" id="custot3" value="#numberformat(custot3,'_.__')#" readonly></td>
      </tr>
      
      <tr>
      <th>OT 3.0</th>
       <td></td>
      <td>
      <input type="text" size='10' name="selfotrate4" id="selfotrate4" value="#selfotrate4#" onKeyUp="calselfot4();"> </td>
      <td><input type="text" size='10' name="selfothour4" id="selfothour4" value="#selfothour4#" onKeyUp="calselfot4();"> </td>
    
      <td style="background-color:#bgcolor#">
      <input type="text" size='10' name="custotrate4" id="custotrate4" value="#custotrate4#" onKeyUp="calcustot4();"> </td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custothour4" id="custothour4" value="#custothour4#" onKeyUp="calcustot4();"> </td>

       <td><input type="text" size='10' name="selfot4" id="selfot4" value="#numberformat(selfot4,'_.__')#"></td><td style="background-color:#bgcolor#"><input type="text" size='10' name="custot4" id="custot4" value="#numberformat(custot4,'_.__')#" readonly></td>
      </tr>
      <tr>
      <th>RD 1.0</th>
       <td></td>
      <td>
      <input type="text" size='10' name="selfotrate5" id="selfotrate5" value="#selfotrate5#" onKeyUp="calselfot(5);"> </td>
      <td><input type="text" size='10' name="selfothour5" id="selfothour5" value="#selfothour5#" onKeyUp="calselfot(5);"> </td>
    
      <td style="background-color:#bgcolor#">
      <input type="text" size='10' name="custotrate5" id="custotrate5" value="#custotrate5#" onKeyUp="calcustot(5);"> </td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custothour5" id="custothour5" value="#custothour5#" onKeyUp="calcustot(5);"> </td>

       <td><input type="text" size='10' name="selfot5" id="selfot5" value="#numberformat(selfot5,'_.__')#"></td><td style="background-color:#bgcolor#"><input type="text" size='10' name="custot5" id="custot5" value="#numberformat(custot5,'_.__')#" readonly></td>
      </tr>
      <tr>
      <th>RD 2.0</th>
       <td></td>
      <td>
      <input type="text" size='10' name="selfotrate6" id="selfotrate6" value="#selfotrate6#" onKeyUp="calselfot(6);"> </td>
      <td><input type="text" size='10' name="selfothour6" id="selfothour6" value="#selfothour6#" onKeyUp="calselfot(6);"> </td>
    
      <td style="background-color:#bgcolor#">
      <input type="text" size='10' name="custotrate6" id="custotrate6" value="#custotrate6#" onKeyUp="calcustot(6);"> </td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custothour6" id="custothour6" value="#custothour6#" onKeyUp="calcustot(6);"> </td>

       <td><input type="text" size='10' name="selfot6" id="selfot6" value="#numberformat(selfot6,'_.__')#"></td><td style="background-color:#bgcolor#"><input type="text" size='10' name="custot6" id="custot6" value="#numberformat(custot6,'_.__')#" readonly></td>
      </tr>
      
      <tr>
      <th>PH 1.0</th>
       <td></td>
      <td>
      <input type="text" size='10' name="selfotrate7" id="selfotrate7" value="#selfotrate7#" onKeyUp="calselfot(7);"> </td>
      <td><input type="text" size='10' name="selfothour7" id="selfothour7" value="#selfothour7#" onKeyUp="calselfot(7);"> </td>
    
      <td style="background-color:#bgcolor#">
      <input type="text" size='10' name="custotrate7" id="custotrate7" value="#custotrate7#" onKeyUp="calcustot(7);"> </td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custothour7" id="custothour7" value="#custothour7#" onKeyUp="calcustot(7);"> </td>

       <td><input type="text" size='10' name="selfot7" id="selfot7" value="#numberformat(selfot7,'_.__')#"></td><td style="background-color:#bgcolor#"><input type="text" size='10' name="custot7" id="custot7" value="#numberformat(custot7,'_.__')#" readonly></td>
      </tr>
      <tr>
      <th>PH 2.0</th>
       <td></td>
      <td>
      <input type="text" size='10' name="selfotrate8" id="selfotrate8" value="#selfotrate8#" onKeyUp="calselfot(8);"> </td>
      <td><input type="text" size='10' name="selfothour8" id="selfothour8" value="#selfothour8#" onKeyUp="calselfot(8);"> </td>
    
      <td style="background-color:#bgcolor#">
      <input type="text" size='10' name="custotrate8" id="custotrate8" value="#custotrate8#" onKeyUp="calcustot(8);"> </td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custothour8" id="custothour8" value="#custothour8#" onKeyUp="calcustot(8);"> </td>

       <td><input type="text" size='10' name="selfot8" id="selfot8" value="#numberformat(selfot8,'_.__')#"></td><td style="background-color:#bgcolor#"><input type="text" size='10' name="custot8" id="custot8" value="#numberformat(custot8,'_.__')#" readonly></td>
      </tr>
      
      
      
      <tr>
      <th colspan="6"><div align="right">Total Over Time</div></th>
      <td><input type="text" size='10' name="selfottotal" id="selfottotal" value="#numberformat(selfottotal,'_.__')#" readonly></td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custottotal" id="custottotal" value="#numberformat(custottotal,'_.__')#" readonly></td>
      </tr>
      <tr>
      <td>&nbsp;</td>
      </tr>
      <tr>
      <th colspan="8"><div align="left">Additional Payments & Deduction</div></th>
      </tr>
      <cfif isdefined('fixawcode1') or isdefined('fixawcode2') or isdefined('fixawcode3') or isdefined('fixawcode4')  or isdefined('fixawcode5')   or isdefined('fixawcode6')>
      <tr>
      <th colspan="2"><div align="left">Fixed Allowance Code</div></th>
      <th colspan="2"><div align="left">Description</div></th>
      <th><div align="left">Employee</div></th>
      <th><div align="left">Employer</div></th>
      </tr>
      </cfif>
      <cfloop from="1" to="6" index="i">
      <cfif isdefined('fixawcode#i#')>
      <cfquery name="checkepfable" datasource="#dts#">
      Select allowance from icshelf where shelf='#evaluate('fixawcode#i#')#'
      </cfquery>
      <input type="hidden" name="epffixawcode#i#" id="epffixawcode#i#" value="#val(checkepfable.allowance)#" />
      <tr>
      <td colspan="2"><input type="text" name="fixawcode#i#" id="fixawcode#i#" value="#evaluate('fixawcode#i#')#" /></td>
      <td colspan="2"><input type="text" name="fixawdesp#i#" id="fixawdesp#i#" value="#evaluate('fixawdesp#i#')#" /></td>
      <td><input type="text" name="fixawee#i#" id="fixawee#i#" value="#numberformat(evaluate('fixawee#i#'),'.__')#" onkeyup="calselfallow();" size='10' /></td>
       <td style="background-color:#bgcolor#"><input type="text" name="fixawer#i#" id="fixawer#i#" value="#numberformat(evaluate('fixawer#i#'),'.__')#" onkeyup="calcustallow();" size='10'  /></td>
       <input type="hidden" name="fixaworiamt#i#" id="fixaworiamt#i#" value="#numberformat(evaluate('fixaworiamt#i#'),'.__')#" />
      </tr>
      <cfelse>
      <input type="hidden" name="epffixawcode#i#" id="epffixawcode#i#" value="0" />
      <input type="hidden" name="fixawcode#i#" id="fixawcode#i#" value=""/>
      <input type="hidden" name="fixawdesp#i#" id="fixawdesp#i#"  value=""/>
      <input type="hidden" name="fixawee#i#" id="fixawee#i#"  value="0"/>
      <input type="hidden" name="fixawer#i#" id="fixawer#i#"  value="0"/>
      <input type="hidden" name="fixaworiamt#i#" id="fixaworiamt#i#" value="0" />
      </cfif>
      </cfloop>
      <tr>
      <th colspan="2"><div align="left">Variable Allowance Code</div></th>
      <th colspan="2"><div align="left">Description</div></th>
      </tr> 
      <cfset adminfeelist = "1,20,21">
<cfset otlist = "22,23,24,25,26,27">
<cfset govlist = "15,16,42">
      <cfquery name="getvarallowance" datasource="#dts#">
      SELECT * FROM ftjoballow WHERE dbjobno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.placementno#">
AND dballid NOT IN (#adminfeelist#,#otlist#,#govlist#)
AND dbjoballqty = 0
      </cfquery>
      <cfloop query="getvarallowance">
      <cfset "awerexp#getvarallowance.dballid#" = getvarallowance.dbjoballbillrate>
      <cfset "aweeexp#getvarallowance.dballid#" = getvarallowance.dbjoballpayrate>
      </cfloop>
      
      <cfif url.type eq "create">
      <cfloop query="getvarallowance">
      
      	<cfquery name="getdesp" datasource="#dts#">
        SELECT DESP FROM icshelf 
      WHERE shelf = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getvarallowance.dballid#">
        </cfquery>
      
      <cfset "aw#getvarallowance.currentrow#" = getvarallowance.dballid>
      <cfset "allowancedesp#getvarallowance.currentrow#" = getdesp.desp>
     
      </cfloop>
      
       <!---get claim from mp4u, [20170315, Alvin]---> 
       <cfif isDefined('url.auto')>  									<!---only applicable to validate timesheet--->
            <cfquery name="getClaim" datasource="#dts#"> 				<!---query to get claim between timesheet--->
            SELECT sum(claimamount) as claimamount FROM claimlist WHERE placementno = '#url.pno#'
            AND submit_date BETWEEN "#lsdateformat(url.startdate, 'yyyy-mm-dd', 'en_AU')#"
            AND "#lsdateformat(url.enddate, 'yyyy-mm-dd', 'en_AU')#"
            AND status = 'Approved'
            </cfquery>
            
            <cfquery name="getClaimReimbursement" datasource="#dts#">	<!---query to get reimbursement/claim only--->
            SELECT desp FROM icshelf WHERE shelf = '6'
            </cfquery>
            
            <cfif #getClaim.claimamount# gt 0>
                <cfloop from="1" to="18" index="a2">
                    <cfif evaluate('aw#a2#') eq ""> <!---no data found and havent insert claim--->
                        <cfset "aw#a2#" = 6>
                        <cfset "allowancedesp#a2#" = "#getClaimReimbursement.desp#">
                        <cfset "awer#a2#" = #val(getClaim.claimamount)#>
                        <cfset "awee#a2#" = #val(getClaim.claimamount)#>
                        <cfbreak>
                    </cfif>
                </cfloop>
            </cfif>
            <!---get claim--->
        </cfif>
      </cfif>
      
      <cfset adminfeelist = "1,20,21">
<cfset otlist = "22,23,24,25,26,27">
<cfset govlist = "15,16,42">
      <cfquery name="getaw" datasource="#dts#">
      SELECT shelf as aw_cou, desp as aw_desp,allowance FROM icshelf 
      WHERE shelf NOT IN (#adminfeelist#,#otlist#,#govlist#)
      <!--- <cfif isdefined('url.auto2') eq false>
      WHERE shelf in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getvarallowance.dballid)#" list="yes" separator=",">)
      </cfif> --->
       order by shelf
      </cfquery>
      <cfloop from="1" to="18" index="a">
      <tr>
            <td colspan="2">
            <cfset awnowdesp = "">
            <select style="width:200px" name="allowance#a#" id="allowance#a#" onChange="document.getElementById('allowancedesp#a#').value=this.options[this.selectedIndex].id;">
            <option value="">Choose an Allowance</option>
            <cfloop query="getaw">
            <option title="#getaw.allowance#" value="#getaw.aw_cou#"  <cfif evaluate('aw#a#') eq  getaw.aw_cou>Selected</cfif> id="#getaw.aw_desp#">#getaw.aw_desp#</option>
            </cfloop>
            </select></td>
<!---             <cfif awnowdesp neq "">
            <cfquery name="getawdesp" datasource="#dts#">
            SELECT dballname FROM ftstdallow WHERE dballid = "#awnowdesp#"
            </cfquery>
            </cfif> --->
            <td colspan="2">
            <input type="text" name="allowancedesp#a#" id="allowancedesp#a#" size="30" value="#evaluate('allowancedesp#a#')#">
            <cfif evaluate('aw#a#') neq "">
            <cfset awid = evaluate('aw#a#')>
            <cfif isdefined('aweeexp#awid#')>
            #numberformat(evaluate('aweeexp#awid#'),'.__')# / #numberformat(evaluate('awerexp#awid#'),'.__')#
            </cfif>
			</cfif>
            </td>
            <td>
             <input type="text" name="awee#a#" id="awee#a#" size="10" value="#numberformat(evaluate('awee#a#'),'.__')#" onKeyUp="document.getElementById('awer#a#').value=this.value;calselfallow();calcustallow();">
            </td>
             <td style="background-color:#bgcolor#">
             <input type="text" name="awer#a#" id="awer#a#" size="10" value="#numberformat(evaluate('awer#a#'),'.__')#" onkeyup="calcustallow();">
            </td>
      </tr>
      </cfloop>
      <tr>
      <td>&nbsp;</td>
      </tr>
      <tr style="display:none">
      <th colspan="8"><div align="left">Other Payments & Deductions</div></th>
      </tr>
       <tr style="display:none">
  
      <td colspan="2">
      <input type="text" name="aw104desp" id="aw104desp" size="50" value="#aw104desp#">
      </td>
      <td><input type="text" size='10' name="selfallowancerate4"  id="selfallowancerate4" value="#selfallowancerate4#" onKeyUp="document.getElementById('custallowancerate4').value=this.value;calselfallow();calcustallow();">
       </td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custallowancerate4" value="#custallowancerate4#" id="custallowancerate4" onKeyUp="calcustallow();"></td>
      </tr>
      <tr style="display:none">

      <td colspan="2">
      <input type="text" name="aw105desp" id="aw105desp" size="50" value="#aw105desp#">
      </td>
      <td><input type="text" size='10' name="selfallowancerate5"  id="selfallowancerate5" value="#selfallowancerate5#" onKeyUp="document.getElementById('custallowancerate5').value=this.value;calselfallow();calcustallow();">
       </td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custallowancerate5" value="#custallowancerate5#" id="custallowancerate5" onKeyUp="calcustallow();"></td>
      </tr>
      <tr style="display:none">

      <td colspan="2">
      <input type="text" name="aw106desp" id="aw106desp" size="50" value="#aw106desp#">
      </td>
      <td><input type="text" size='10' name="selfallowancerate6"  id="selfallowancerate6" value="#selfallowancerate6#" onKeyUp="document.getElementById('custallowancerate6').value=this.value;calselfallow();calcustallow();">
       </td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custallowancerate6" value="#custallowancerate6#" id="custallowancerate6" onKeyUp="calcustallow();"></td>
      </tr>
       <tr style="display:none">
      <th colspan="100%" align="center"><div align="center">Hour Rate Allowance</div></th>

      </tr>
      
      <tr style="display:none">
      <th>Allowance 1</th>
      <td>
      <input type="text" name="aw101desp" id="aw101desp" value="#aw101desp#">
      </td>
      <td colspan="2">
      <input type="text" size='5' name="selfallowancerate1" id="selfallowancerate1" value="#selfallowancerate1#"  onKeyUp="calselfallow();"> Rate&nbsp;&nbsp;&nbsp;<input type="text" size='5' name="selfallowancehour1" id="selfallowancehour1" value="#selfallowancehour1#" onKeyUp="calselfallow();"> Hrs</td>
      
      <td>
      <input type="text" size='5' name="custallowancerate1" id="custallowancerate1" value="#custallowancerate1#" onKeyUp="calcustallow();"> </td>
      <td><input type="text" size='5' name="custallowancehour1" id="custallowancehour1" value="#custallowancehour1#" onKeyUp="calcustallow();"> Hrs</td>

      <td></td>
      <td></td>
      </tr>
      <tr style="display:none">
      <th>Allowance 2</th>
      <td>
      <input type="text" name="aw102desp" id="aw102desp" value="#aw102desp#">
      </td>
      <td colspan="2">
      <input type="text" size='5' name="selfallowancerate2"  id="selfallowancerate2"value="#selfallowancerate2#" onKeyUp="calselfallow();"> Rate&nbsp;&nbsp;&nbsp;<input type="text" size='5' name="selfallowancehour2" id="selfallowancehour2" value="#selfallowancehour2#" onKeyUp="calselfallow();"> Hrs</td>
  
      <td>
      <input type="text" size='5' name="custallowancerate2"  id="custallowancerate2" value="#custallowancerate2#" onKeyUp="calcustallow();"> </td>
      <td><input type="text" size='5' name="custallowancehour2" id="custallowancehour2" value="#custallowancehour2#" onKeyUp="calcustallow();"> Hrs</td>

      <td></td>
      <td></td>
      </tr>
      
      <tr style="display:none">
      <th>Allowance 3</th>
      <td>
      <input type="text" name="aw103desp" id="aw103desp" value="#aw103desp#">
      </td>
      <td colspan="2">
      <input type="text" size='5' name="selfallowancerate3" id="selfallowancerate3" value="#selfallowancerate3#" onKeyUp="calselfallow();"> Rate&nbsp;&nbsp;&nbsp;<input type="text" size='5' name="selfallowancehour3" id="selfallowancehour3" value="#selfallowancehour3#" onKeyUp="calselfallow();"> Hrs</td>
      
      <td>
      <input type="text" size='5' name="custallowancerate3"  id="custallowancerate3" value="#custallowancerate3#" onKeyUp="calcustallow();"> </td>
      <td><input type="text" size='5' name="custallowancehour3" id="custallowancehour3" value="#custallowancehour3#" onKeyUp="calcustallow();"> Hrs</td>

      <td></td>
      <td></td>
      </tr>
      <tr>
      <th colspan="6"><div align="right">Total Payment & Deductions</div>
      </th>
      <td><input type="text" size='10' name="selfallowance"  id="selfallowance" value="#numberformat(selfallowance,'_.__')#"></td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custallowance"  id="custallowance" value="#numberformat(custallowance,'_.__')#"></td>
      </tr>
      
      <tr>
      <td>&nbsp;</td>
      </tr>
      <tr  style="display:none"><th colspan="8"><div align="left">AWS and PB</div></th></tr>
      <tr style="display:none">
      <td></td>
      <td></td>
      <th><div align="left">Employee</div></th>
      <th style="background-color:#bgcolor#"><div align="left">Employer</div></th>
      </tr>
      <tr style="display:none">
      <th>Performance Bonus</th>
      <td><input type="text" name="pbtext" id="pbtext" value="#pbtext#" size="35"></td>
      <td><input type="text" name="pbeeamt" id="pbeeamt" value="#numberformat(val(pbeeamt),'.__')#" size="10" onkeyup="pbawscal()"></td>
      <td style="background-color:#bgcolor#"><input type="text" name="pberamt" id="pberamt" value="#numberformat(val(pberamt),'.__')#" size="10" onkeyup="pbawscal()"></td>
      </tr>
       <tr style="display:none">
      <th>AWS</th>
      <td><input type="text" name="awstext" id="awstext" value="#awstext#"  size="35"></td>
      <td><input type="text" name="awseeamt" id="awseeamt" value="#numberformat(val(awseeamt),'.__')#" size="10" onkeyup="pbawscal()"></td>
      <td style="background-color:#bgcolor#"><input type="text" name="awseramt" id="awseramt" value="#numberformat(val(awseramt),'.__')#" size="10" onkeyup="pbawscal()"></td>
      </tr>
      <tr style="display:none">
      <td>&nbsp;</td>
      </tr>
      <tr style="display:none">
      <td></td>
      <td></td>
      <td style="background-color:#bgcolor#">Billable EPF</td>
      <td style="background-color:#bgcolor#">Billable SOCSO</td>
      <td style="background-color:#bgcolor#">Billable WI</td>
      <td style="background-color:#bgcolor#">Adm</td>
      </tr>
      <tr style="display:none">
      <th style="background-color:#bgcolor#">Performance Bonus</th>
      <td style="background-color:#bgcolor#"><input type="text" name="bonusmisctext" id="bonusmisctext" value="#bonusmisctext#" size="35"></td>
      <td style="background-color:#bgcolor#"><input type="text" name="pbcpf" id="pbcpf" value="#numberformat(val(pbcpf),'.__')#" size="10" onkeyup="pbawscal()"></td>
      <td style="background-color:#bgcolor#"><input type="text" name="pbsdf" id="pbsdf" value="#numberformat(val(pbsdf),'.__')#" size="10" onkeyup="pbawscal()"></td>
      <td style="background-color:#bgcolor#"><input type="text" name="pbwi" id="pbwi" value="#numberformat(val(pbwi),'.__')#" size="10" onkeyup="pbawscal()"></td>
       <td style="background-color:#bgcolor#"><input type="text" name="pbadm" id="pbadm" value="#numberformat(val(pbadm),'.__')#" size="10" onkeyup="pbawscal()"><input type="hidden" name="totalpbmiscfield" id="totalpbmiscfield" value="#numberformat(totalpbmisc,'.__')#" /></td>
      </tr>
       <tr style="display:none">
      <th style="background-color:#bgcolor#">AWS</th>
      <td style="background-color:#bgcolor#"><input type="text" name="awsmisctext" id="awsmisctext" value="#awsmisctext#" size="35"></td>
      <td style="background-color:#bgcolor#"><input type="text" name="awscpf" id="awscpf" value="#numberformat(val(awscpf),'.__')#" size="10" onkeyup="pbawscal()"></td>
      <td style="background-color:#bgcolor#"><input type="text" name="awssdf" id="awssdf" value="#numberformat(val(awssdf),'.__')#" size="10" onkeyup="pbawscal()"></td>
      <td style="background-color:#bgcolor#"><input type="text" name="awswi" id="awswi" value="#numberformat(val(awswi),'.__')#" size="10" onkeyup="pbawscal()"></td>
       <td style="background-color:#bgcolor#"><input type="text" name="awsadm" id="awsadm" value="#numberformat(val(awsadm),'.__')#" size="10" onkeyup="pbawscal()"><input type="hidden" name="totalawsmiscfield" id="totalawsmiscfield" value="#numberformat(totalawsmisc,'.__')#" /></td>
      </tr>
      <tr style="display:none">
      <th colspan="6"><div align="right">Total PB & AWS</div>
      </th>
      <td><input type="text" size='10' name="selfpbaws"  id="selfpbaws" value="#numberformat(selfpbaws,'_.__')#"></td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custpbaws"  id="custpbaws" value="#numberformat(custpbaws,'_.__')#"></td>
      </tr>
       <tr style="display:none">
       <th>Back / Over Pay Description</th>
       <td colspan="3">
       <input type="text" name="backpaydesp" id="backpaydesp" value="#backpaydesp#" size="50" />
       </td>
      <th colspan="2"><div align="right">Back Pay / Over Pay</div>
      </th>
      <td>
      <input type="text" size='10' name="selfpayback" id="selfpayback" value="#selfpayback#" onKeyUp="calselftotal();"><!---  Rate  --->     </td>
      <td style="background-color:#bgcolor#">
      <input type="text" size='10' name="custpayback"  id="custpayback" value="#custpayback#" onKeyUp="calcusttotal();"><!---  Rate   --->    </td>
      </tr>
      <tr>
      <th colspan="6"><div align="right">EPF</div><!--- <div align="right"><input type="button" name="followcpf" id="followcpf" value="Calculate CPF" onClick="getemployeecpf();setTimeout('calselftotal()',500);setTimeout('calcusttotal()',500);"></div> ---><div id="getcpfajax"></div><div id="getbasicajax"></div></th>
      
      <td><input type="text" size='10' name="selfcpf" id="selfcpf" value="#numberformat(selfcpf,'_.__')#" onKeyUp="calselftotal();"></td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custcpf" id="custcpf" value="#numberformat(custcpf,'_.__')#" onKeyUp="calcusttotal();"></td>
      </tr>
      <tr>
      <th colspan="6"><div align="right">SOCSO</div><div align="right"><!--- <input type="button" name="countsdf" id="countsdf" value="Calculate SDF" onClick="calculatesdf();setTimeout('calselftotal()',500);setTimeout('calcusttotal()',500);"> ---></div></th>
      <td><input type="Text" size='10' name="selfsdf" id="selfsdf" value="#numberformat(selfsdf,'_.__')#" onKeyUp="calselftotal();"></td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custsdf" id="custsdf" value="#numberformat(custsdf,'_.__')#" onKeyUp="calcusttotal();"></td>
      </tr>
      <tr style="display:none">
      <th colspan="100%"><div align="left">Additional Charges and Deductions</div></th>
      </tr>
       <tr style="display:none">
      <th>NS Deduction (Do Not Enter "-")</th>
      <td><input type="text" name="nsdeddesp" id="nsdeddesp" size="40" value="#nsdeddesp#"></td>
      <td><input type="text" name="nsded" id="nsded" value="#numberformat(nsded,'_.__')#" onKeyUp="dedcal();"  size='10' ></td>
       <td style="background-color:#bgcolor#"><input type="text" name="nscustded" id="nscustded" value="#numberformat(nscustded,'_.__')#" onKeyUp="dedcalcust();"  size='10' ></td>
      </tr>
      <tr>
      <th colspan="6"><div align="right">Admin Fee</div></th>

      <input type="hidden" id="adminfeepercent" name="adminfeepercent" value="#adminfeepercent#" />
      <input type="hidden" id="adminfeeminamt" name="adminfeeminamt" value="#adminfeeminamt#" />
      <td></td>
      <td style="background-color:#bgcolor#"><input type="text" name="adminfee" id="adminfee" value="#numberformat(adminfee,'_.__')#" onKeyUp="dedcalcust();"  size='10'  ></td>
      </tr>
      <tr>
      <td>&nbsp;</td>
      </tr>
      <tr>
      <th colspan="8" style="background-color:#bgcolor#"><div align="left">Monthly Billable Item</div></th>
      </tr>
       <cfquery name="getcate" datasource="#dts#">
                select * from iccate
                </cfquery>
      <cfloop from="1" to="6" index="i">
      <cfif isdefined('billitem#i#')>
      <tr>
      <td colspan="2" style="background-color:#bgcolor#"><input type="text" name="billitem#i#" id="billitem#i#" value="#evaluate('billitem#i#')#" readonly /></td>
      <td colspan="2" style="background-color:#bgcolor#">
      <input type="text" name="billitemdesp#i#" id="billitemdesp#i#" value="#evaluate('billitemdesp#i#')#" size="30" />
      </td>
      <td></td>
        <td style="background-color:#bgcolor#">
      <input type="text" name="billitemamt#i#" id="billitemamt#i#" value="#numberformat(evaluate('billitemamt#i#'),'.__')#"    size='10' onkeyup="dedcalcust()" />
      <input type="hidden" name="billitempercent#i#" id="billitempercent#i#" value="#numberformat(evaluate('billitempercent#i#'),'.__')#"/>
      </td>
      </tr>
      <cfelse>
    	<tr>
      <td  colspan="2" style="background-color:#bgcolor#">
                <select name="billitem#i#" id="billitem#i#" style="width:200px">
                <option value="">Select a Billable Item</option>
                <cfloop query="getcate">
                <option value="#getcate.cate#">#getcate.cate# - #getcate.desp#</option>
                </cfloop>
                </select>
                </td>
         <td  colspan="2" style="background-color:#bgcolor#">       
      <input type="text" name="billitemdesp#i#" id="billitemdesp#i#" size="30" />
      </td>
      <td></td>
      <td style="background-color:#bgcolor#"> 
      <input type="text" name="billitemamt#i#" id="billitemamt#i#" value="0"  size='10' onkeyup="dedcalcust()" />
      <input type="hidden" name="billitempercent#i#" id="billitempercent#i#" value="0"/>
      </td>
      </tr>
      </cfif>
      </cfloop>
       <tr>
      <td>&nbsp;</td>
      </tr>
      <tr>
      <th colspan="2"><div align="left">Additional Item (No Admin Fee)</div></th>
      <th><div align="left">Description</div></th>
      <td></td>
      <th><!--- <div align="left">Cap/visit & Cap/contract</div> ---></th>
      <th><!--- <div align="left">Total Consumed</div> ---></th>
      </tr>
      	<cfquery name="getclaimlist" datasource="#dts#">
		SELECT wos_group,desp FROM icgroup
		</cfquery>
      <tr>
      <td colspan="2">
      <select name="addchargecode" id="addchargecode" onChange="document.getElementById('addchargedesp').value=this.options[this.selectedIndex].id" style="width:200px">
      <option value="" id="">Choose an Item</option>
      <cfloop query="getaw">
      <option <cfif addchargecode eq getaw.aw_cou>Selected</cfif> value="#getaw.aw_cou#" id="#getaw.aw_desp#">#getaw.aw_desp#</option>
      </cfloop>
      </select>
      </td>
      <td colspan="2"><input type="text" name="addchargedesp" id="addchargedesp" value="#addchargedesp#"  size="30"></td>

       <td><input type="text" name="addchargeself" id="addchargeself" value="#numberformat(addchargeself,'_.__')#" onKeyUp="dedcal();"  size='10'  ><input type="checkbox" style="display:none" name="claimadd1" id="claimadd1" value="1" checked></td>
       <td style="background-color:#bgcolor#"><input type="text" name="addchargecust" id="addchargecust" value="#numberformat(addchargecust,'_.__')#" onKeyUp="dedcalcust();"  size='10'></td>
      </tr>
       <tr>
      <td colspan="2"> <select name="addchargecode2" id="addchargecode2" onChange="document.getElementById('addchargedesp2').value=this.options[this.selectedIndex].id" style="width:200px">
      <option value="">Choose an Item</option>
      <cfloop query="getaw">
      <option <cfif addchargecode2 eq getaw.aw_cou>Selected</cfif> value="#getaw.aw_cou#" id="#getaw.aw_desp#">#getaw.aw_desp#</option>
      </cfloop>
      </select></td>
      <td colspan="2"><input type="text" name="addchargedesp2" id="addchargedesp2"  value="#addchargedesp2#"  size="30"></td>

       <td><input type="text" name="addchargeself2" id="addchargeself2" value="#numberformat(addchargeself2,'_.__')#" onKeyUp="dedcal();"  size='10'  ><input type="checkbox" name="claimadd2" id="claimadd2" value="2" checked style="display:none"></td>
       <td style="background-color:#bgcolor#"><input type="text" name="addchargecust2" id="addchargecust2" value="#numberformat(addchargecust2,'_.__')#" onKeyUp="dedcalcust();"  size='10'></td>
      </tr>
      
       <tr >
      <td colspan="2"><select name="addchargecode3" id="addchargecode3" onChange="document.getElementById('addchargedesp3').value=this.options[this.selectedIndex].id" style="width:200px">
      <option value="">Choose an Item</option>
      <cfloop query="getaw">
      <option <cfif addchargecode3 eq getaw.aw_cou>Selected</cfif> value="#getaw.aw_cou#" id="#getaw.aw_desp#">#getaw.aw_desp#</option>
      </cfloop>
      </select></td>
      <td colspan="2" ><input type="text" name="addchargedesp3" id="addchargedesp3" value="#addchargedesp3#" size="30"></td>

       <td><input type="text" name="addchargeself3" id="addchargeself3" value="#numberformat(addchargeself3,'_.__')#" onKeyUp="dedcal();"  size='10' ><input type="checkbox" name="claimadd3" id="claimadd3" value="3" checked style="display:none"></td>
       <td style="background-color:#bgcolor#"><input type="text" name="addchargecust3" id="addchargecust3" value="#numberformat(addchargecust3,'_.__')#" onKeyUp="dedcalcust();"  size='10'></td>
      </tr>
      
       <tr style="display:none">
      <th>Description 4</th>
      <td colspan="3"><input type="text" name="addchargedesp4" id="addchargedesp4" size="50" value="#addchargedesp4#"></td>

       <td><input type="text" name="addchargeself4" id="addchargeself4" value="#numberformat(addchargeself4,'_.__')#" onKeyUp="calselftotal();"  size='10' ><input type="checkbox" name="claimadd4" id="claimadd4" value="4" <cfif claimadd4 eq "Y">checked</cfif>></td>
       <td><input type="text" name="addchargecust4" id="addchargecust4" value="#numberformat(addchargecust4,'_.__')#" onKeyUp="calcusttotal();"  size='10'></td>
       <td colspan="2"></td>
      </tr>
      <tr style="display:none">
      <th>Description 5</th>
      <td colspan="3"><input type="text" name="addchargedesp5" id="addchargedesp5" size="50" value="#addchargedesp5#"></td>

       <td><input type="text" name="addchargeself5" id="addchargeself5" value="#numberformat(addchargeself5,'_.__')#" onKeyUp="calselftotal();"  size='10' ><input type="checkbox" name="claimadd5" id="claimadd5" value="5" <cfif claimadd5 eq "Y">checked</cfif>></td>
       <td><input type="text" name="addchargecust5" id="addchargecust5" value="#numberformat(addchargecust5,'_.__')#" onKeyUp="calcusttotal();"  size='10'></td>
       <td colspan="2"></td>
      </tr>
       <tr style="display:none">
      <th>Description 6</th>
      <td colspan="3"><input type="text" name="addchargedesp6" id="addchargedesp6" size="50" value="#addchargedesp6#"></td>

       <td><input type="text" name="addchargeself6" id="addchargeself6" value="#numberformat(addchargeself6,'_.__')#" onKeyUp="calselftotal();"  size='10' ><input type="checkbox" name="claimadd6" id="claimadd6" value="6" <cfif claimadd6 eq "Y">checked</cfif>></td>
       <td><input type="text" name="addchargecust6" id="addchargecust6" value="#numberformat(addchargecust6,'_.__')#" onKeyUp="calcusttotal();"  size='10'></td>
       <td colspan="2"></td>
      </tr>
       <tr style="display:none">
      <th colspan="6"><div align="right">Total Addtional Charges</div></th>

       <td><input type="text" name="addchargeselftotal" id="addchargeselftotal" value="" onKeyUp="calselftotal();"  size='10'></td>
       <td><input type="text" name="addchargecusttotal" id="addchargecusttotal" value="" onKeyUp="calcusttotal();"  size='10'></td>
      </tr>
      <tr style="display:none">
      <th colspan="6">
      <div align="right">
      Gross Pay
      </div>
      </th>
      <td><input type="text" size='10' name="selfnet" id="selfnet" value="#numberformat(selfnet,'_.__')#"></td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custnet" id="custnet" value="#numberformat(custnet,'_.__')#"></td>
      </tr>
     <tr style="display:none">
     <td>&nbsp;</td>
     </tr>
    
     <tr style="display:none">
     <th style="background-color:#bgcolor#"><div align="left">Rebate (Do Not Enter "-")</div></th>
     <td></td>
     <td></td>
     <td style="background-color:#bgcolor#"><input type="text" size='10' name="rebate" id="rebate" value="#numberformat(rebate,'_.__')#" onkeyup="dedcalcust();"></td>
     </tr> 
     <tr style="display:none">
     <td>&nbsp;</td>
     </tr>
     <tr>
     <th colspan="5"><div align="left">Deductions (Do Not Enter "-")</div></th>
     </tr>
      <tr>
      <td colspan="4"><input type="text" name="ded1desp" id="ded1desp" size="65" value="#ded1desp#"></td>
      <td><input type="text" name="ded1" id="ded1" value="#numberformat(ded1,'_.__')#" onKeyUp="dedcal();"  size='10' ></td>
        <td style="background-color:#bgcolor#"><input type="text" name="dedcust1" id="dedcust1" value="#numberformat(dedcust1,'_.__')#" onkeyup="dedcalcust();"  size='10' ></td>
      </tr>
      <tr>
      <td colspan="4"><input type="text" name="ded2desp" id="ded2desp" size="65" value="#ded2desp#"></td>
      <td><input type="text" name="ded2" id="ded2" value="#numberformat(ded2,'_.__')#" onKeyUp="dedcal();"  size='10' ></td>
       <td style="background-color:#bgcolor#"><input type="text" name="dedcust2" id="dedcust2" value="#numberformat(dedcust2,'_.__')#"  onkeyup="dedcalcust();"  size='10' ></td>
      </tr>
      <tr>
      <td colspan="4"><input type="text" name="ded3desp" id="ded3desp" size="65" value="#ded3desp#"></td>
      <td><input type="text" name="ded3" id="ded3" value="#numberformat(ded3,'_.__')#" onKeyUp="dedcal();"  size='10' ></td>
       <td style="background-color:#bgcolor#"><input type="text" name="dedcust3" id="dedcust3" value="#numberformat(dedcust3,'_.__')#"  onkeyup="dedcalcust();"  size='10' ></td>
      </tr>
      <tr>
      <th colspan="6">
      <div align="right">
      Total Additional Charges / Deductions
      </div>
      </th>
<td><input type="text" size='10' name="selfdeduction" id="selfdeduction" value="#selfdeduction#" readonly > </td>
      <td style="background-color:#bgcolor#">
      <input type="text" size='10' name="custdeduction" id="custdeduction" value="#custdeduction#" onKeyUp="calcusttotal();" readonly>      </td>
      </tr>
      
      <tr style="display:none">
      <th>Back Pay</th>
      
      <th>Total Deduction<br><input type="button" name="followded" id="followded" value="Calc Deduction" onClick="getemployeeded();setTimeout('calselftotal()',500);setTimeout('calcusttotal()',500);"><div id="getdedajax"></div></th>
      
      
      <td></td>
      </tr>
      
      <tr>
      <th></th>
  <cfquery name="getTaxCode" datasource="#dts#">
  SELECT code,rate1*100 as rate FROM #target_taxtable# ORDER BY code
  </cfquery>
<input type="hidden" name="tran" id="tran" value="INV"> 
      
      <th colspan="5"><div align="right">Employee Net Pay Amount</div></th>
      <td><input type="text" size='10' name="selftotal" id="selftotal" value="#numberformat(selftotal,'_.__')#" readonly></td>
      <td></td>
      
      </tr>
    
      <th colspan="6" style="background-color:#bgcolor#"><div align="right">Customer Gross Pay Amount</div></th>
      <td></td>
       <td style="background-color:#bgcolor#"><input type="text" size='10' name="custtotalgross" id="custtotalgross" value="#numberformat(custtotalgross,'_.__')#" readonly></td>
      <tr>
      </tr>
      <tr style="display:none">
      <td>&nbsp;</td>
      <td></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <th style="background-color:#bgcolor#">Tax</th>
      <td style="background-color:#bgcolor#"><select name="taxcode" id="taxcode" onchange="document.getElementById('taxper').value=this.options[this.selectedIndex].id;calcusttotal();">
      <cfloop query="getTaxCode">
      <option value="#getTaxCode.code#" id="#numberformat(getTaxCode.rate,'.__')#" <cfif getTaxCode.code eq taxcode>Selected</cfif>>#getTaxCode.code#</option>
      </cfloop>
      </select>
      
      &nbsp;<input type="text" name="taxper" id="taxper" value="#taxper#" size="3" onKeyUp="caltax2();calcusttotal();" bindonload="yes"  /></td>
      <td style="background-color:#bgcolor#">
  <input type="text" name="taxamt" id="taxamt" value="#numberformat(taxamt,'.__')#" size="10" readonly/></td>
      </tr>
      <tr  style="display:none">
      <td>&nbsp;</td>
      <td></td>
      <td></td>
      <td>&nbsp;</td>
      <td></td>
      <th style="background-color:#bgcolor#"><div align="right">Customer Net Pay Amount</div></th>
      <td></td>
      <td style="background-color:#bgcolor#"><input type="text" size='10' name="custtotal" id="custtotal" value="#numberformat(custtotal,'_.__')#" readonly></td>
      </tr>
      <cfif url.type eq "Delete">
      <tr>
      <th colspan="100%"><div align="center">Reason : <input type="text" name="reason" id="reason" value="" size="100" maxlength="100"></div></th>
      </tr>
	  </cfif>
    </cfoutput> 
    <cfif isdefined('url.auto') and isdefined('url.pno') and url.type eq "create">
    <cfoutput>
    <input type="hidden" name="validatetimesheet" id="validatetimesheet" value="#url.auto#">
 <!---   <input type="hidden" name="startdate" id="startdate" value="#lsdateformat(url.startdate, 'yyyy-mm-dd', 'en_AU')#">
    <input type="hidden" name="enddate" id="enddate" value="#lsdateformat(url.enddate, 'yyyy-mm-dd', 'en_AU')#">--->
    </cfoutput>
     <tr> 
      <td height="23" colspan="8" align="center"><cfoutput> 
      <input type="button" name="calculateemppay" value="Validate TimeSheet" <cfif posted eq "P">disabled </cfif> onClick="<cfif locked eq "Y">alert('This Assignment Has Been Locked')<cfelseif combine eq "Y">alert('This Assignment Has Been Combine')<cfelseif posted neq "P">checkpay()<cfelse>alert('This assignment has been posted!')</cfif>;">
        </cfoutput></td>
    </tr>
    <cfelse>
    <tr> 
      <td height="23"></td>
      <td colspan="4" align="right"><cfoutput> 
      <cfif getauthuser() eq "mptest8">
	  <input type="button" name="test" id="test" onClick="adminfeecal()" value="test">
	  </cfif>
      <input type="button" name="calculateemppay" value="Calculate Employee Pay" <cfif posted eq "P">disabled </cfif> onClick="<cfif locked eq "Y">alert('This Assignment Has Been Locked')<cfelseif combine eq "Y">alert('This Assignment Has Been Combine')<cfelseif posted neq "P">checkpay()<cfelse>alert('This assignment has been posted!')</cfif>;">&nbsp;&nbsp;&nbsp;&nbsp;
      
        <input name="submit1" id="submit1" type="button" onClick="<cfif combine eq "Y">alert('This Assignment Has Been Combine')<cfelse>submitform()</cfif>;" value="  #button#  " <cfif url.type eq "create" or posted eq "P">disabled</cfif>>
          &nbsp;&nbsp;&nbsp;&nbsp;
          <input name="submit2" id="submit2" type="button" onClick="<cfif combine eq "Y">alert('This Assignment Has Been Combine')<cfelse>submitform2();</cfif>"  value="#button# and Create New"<cfif url.type eq "create" or posted eq "P">disabled</cfif>>
        </cfoutput></td>
    </tr>
    </cfif>
</table>