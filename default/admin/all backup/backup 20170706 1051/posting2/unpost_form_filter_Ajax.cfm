<cfsetting showdebugoutput="no">
<cfoutput>

<cfset sort = url.sort >
		
		<cfif sort eq "trxdate" >

			Date From 
			<input type="text" name="datefrom" id="datefrom" size="10" maxlength="10" onblur="checkrequired1();">
            
			Date To 
			<input type="text" name="dateto" id="dateto" size="10" maxlength="10" onblur="checkrequired1();">
            
            <input type="submit" name="submit" id="submit" value="Go" disabled="disabled">
		
		<cfelseif sort eq "period" >
			Period 
			<cfquery name="getgeneral" datasource="#dts#">
			select * from gsetup
			</cfquery>
            
				<select name="period" id="period">
					<option value="">Choose a period</option>
					<option value="01" <cfif xperiod eq '01'>selected</cfif>>Period 01 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="02" <cfif xperiod eq '02'>selected</cfif>>Period 02 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="03" <cfif xperiod eq '03'>selected</cfif>>Period 03 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="04" <cfif xperiod eq '04'>selected</cfif>>Period 04 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="05" <cfif xperiod eq '05'>selected</cfif>>Period 05 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="06" <cfif xperiod eq '06'>selected</cfif>>Period 06 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="07" <cfif xperiod eq '07'>selected</cfif>>Period 07 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="08" <cfif xperiod eq '08'>selected</cfif>>Period 08 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="09" <cfif xperiod eq '09'>selected</cfif>>Period 09 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="10" <cfif xperiod eq '10'>selected</cfif>>Period 10 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="11" <cfif xperiod eq '11'>selected</cfif>>Period 11 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="12" <cfif xperiod eq '12'>selected</cfif>>Period 12 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="13" <cfif xperiod eq '13'>selected</cfif>>Period 13 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="14" <cfif xperiod eq '14'>selected</cfif>>Period 14 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="15" <cfif xperiod eq '15'>selected</cfif>>Period 15 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="16" <cfif xperiod eq '16'>selected</cfif>>Period 16 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="17" <cfif xperiod eq '17'>selected</cfif>>Period 17 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="18" <cfif xperiod eq '18'>selected</cfif>>Period 18 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')#</option>
				</select>
            <input type="submit" name="submit2" id="submit2" value="Go" disabled="disabled">
		
		<cfelseif sort eq "trxbillno">
			Bill No From	<input type="text" name="billnofrom" id="billnofrom" size="10" maxlength="20" onblur="checkrequired3();" >
			Bill No To		<input type="text" name="billnoto" id="billnoto" size="10" maxlength="20" onblur="checkrequired3();">
			
			<br>

				<cfquery name="getcust" datasource="#dts#">
					select custno, name from #target_arcust# order by custno
				</cfquery>
			
			Customer No From 
			<select name="custnofrom">
				<option value="">Choose a customer</option>
				<cfloop query="getcust"> 
		  			<option value="#custno#">#custno# - #name#</option>
				</cfloop>
			</select>
			
			<br>
			Customer No To &nbsp;&nbsp; 
			<select name="custnoto">
				<option value="">Choose a customer</option>
				<cfloop query="getcust"> 
		 			<option value="#custno#">#custno# - #name#</option>
				</cfloop> 
			</select>
			<input type="submit" name="submit3" id="submit3" value="Go" disabled="disabled">
<cfelseif sort eq "Custno">
Customer No From 	<input type="text" name="custnofrom" id="custnofrom" size="10" value="" maxlength="8" onblur="checkrequired4();" >
Customer No To		<input type="text" name="custnoto" id="custnoto" size="10" value="" maxlength="8" onblur="checkrequired4();" >

<input type="submit" name="submit4" value="Go" disabled="disabled">

</cfif>

</cfoutput>