<cfsetting showdebugoutput="no">
<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<cfoutput>

<cfset sort = url.sort >
		
		<cfif sort eq "trxdate" >


			Date From 
			<input type="text" name="datefrom" id="datefrom" size="10" maxlength="10" onblur="checkrequired1();" >
            <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(datefrom);">
			Date To 
			<input type="text" name="dateto" size="10" maxlength="10" onblur="checkrequired1();">
            <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateto);">
            <br />
            Customer No From 	
            <input type="text" name="custnofrom" id="custnofrom" size="10" value="" maxlength="8" onblur="checkrequired4();" >
          

			Customer No To		<input type="text" name="custnoto" id="custnoto" size="10" value="" maxlength="8" onblur="checkrequired4();" >
         
            <input type="submit" name="submit" id="submit" value="Go">
		
		<cfelseif sort eq "period" >
			Period 
            
            <cfquery name="getgeneral" datasource="#dts#">
			select * from gsetup
			</cfquery>
            
				<select name="period" id="period">
					<option value="">Choose a period</option>
					<option value="01" >Period 01 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="02" >Period 02 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="03" >Period 03 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="04" >Period 04 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="05" >Period 05 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="06" >Period 06 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="07" >Period 07 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="08" >Period 08 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="09" >Period 09 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="10" >Period 10 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="11" >Period 11 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="12" >Period 12 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="13" >Period 13 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="14" >Period 14 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="15" >Period 15 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="16" >Period 16 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="17" >Period 17 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')#</option>
					<option value="18" >Period 18 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')#</option>
				</select>
			<!---<input type="text" name="period" id="period" size="10" maxlength="2"  onblur="checkrequired2();"> (e.g. 01)--->
            
            <input type="submit" name="submit2" id="submit2" value="Go" onclick="ColdFusion.Window.show('processing');">
		
		<cfelseif sort eq "trxbillno">
        
        Bill No From 
		<input type="text" name="billnofrom" id="billnofrom" size="10" maxlength="20"  value="" onblur="checkrequired3();"><img src="/images/find.jpg" width="20" height="14.5" onMouseOver="this.style.cursor='hand'" onClick="document.getElementById('fromto').value='from';javascript:ColdFusion.Window.show('findRefno');" />
		
        Bill No To 
		<input type="text" name="billnoto" id="billnoto" size="10" maxlength="20" value="" onblur="checkrequired3();"><img src="/images/find.jpg" width="20" height="14.5" onMouseOver="this.style.cursor='hand'" onClick="document.getElementById('fromto').value='to';javascript:ColdFusion.Window.show('findRefno');" />
                        
                        <cfquery name="getcust" datasource="#dts#">
                            select 
                            custno,
                            name 
                            from #target_arcust# 
                            order by custno;
                        </cfquery>
                
		
		<br>
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
		<input type="submit" name="submit3" id="submit3" value=" Go " disabled="disabled" onclick="ColdFusion.Window.show('processing');">

<cfelseif sort eq "trxbillno2">
        
        Ref no 2 From 
		<input type="text" name="billno2from" id="billno2from" size="10" maxlength="20"  value="" onblur="checkrequired5();">
		
        Ref no 2 To 
		<input type="text" name="billno2to" id="billno2to" size="10" maxlength="20" value="" onblur="checkrequired5();">
                        
		<input type="submit" name="submit5" id="submit5" value=" Go " disabled="disabled" onclick="ColdFusion.Window.show('processing');">

<cfelseif sort eq "Custno">
Customer No From 	
<input type="text" name="custnofrom" id="custnofrom" size="10" value="" maxlength="8" onblur="checkrequired4();" >
  <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />
Customer No To		
<input type="text" name="custnoto" id="custnoto" size="10" value="" maxlength="8" onblur="checkrequired4();" >
   <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />
<br />
			<cfif isdefined("form.period")>
				<cfset xperiod = form.period>
			<cfelse>
				<cfset xperiod = "">
			</cfif>
			Period 
			<input type="text" name="period" size="10" maxlength="2" value="#xperiod#" required="yes" validate="integer"> (e.g. 01)
<input type="submit" name="submit4" id="submit4" value="Go" disabled="disabled" onclick="ColdFusion.Window.show('processing');">


<cfelseif form.sort eq "billpay">

		Bill Status
        <select name="billstatus" id="billstatus">
        <option value="fullypaid">Fully paid</option>
        <option value="unpaid">Not Full Paid</option>
        </select>

		<input type="submit" name="submit6" value=" Go " onclick="ColdFusion.Window.show('processing');">


</cfif>

</cfoutput>