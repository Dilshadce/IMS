<cfsetting showdebugoutput="no">
<cfoutput>

<cfset sort = url.sort >
		
		<cfif sort eq "trxdate" >


			Date From 
			<input type="text" name="datefrom" id="datefrom" size="10" maxlength="10" onblur="checkrequired1();" >
            
			Date To 
			<input type="text" name="dateto" size="10" maxlength="10" onblur="checkrequired1();">
            <br />
            Customer No From 	<input type="text" name="custnofrom" id="custnofrom" size="10" value="" maxlength="8" onblur="checkrequired4();" >
            
			Customer No To		<input type="text" name="custnoto" id="custnoto" size="10" value="" maxlength="8" onblur="checkrequired4();" >
            
            <input type="submit" name="submit" id="submit" value="Go" disabled="disabled">
		
		<cfelseif sort eq "period" >
			Period 
			<input type="text" name="period" id="period" size="10" maxlength="2"  onblur="checkrequired2();"> (e.g. 01)
            
            <input type="submit" name="submit2" id="submit2" value="Go" disabled="disabled">
		
		<cfelseif sort eq "trxbillno">
        
        Bill No From 
		<input type="text" name="billnofrom" id="billnofrom" size="10" maxlength="20"  value="" onblur="checkrequired3();">
		
        Bill No To 
		<input type="text" name="billnoto" id="billnoto" size="10" maxlength="20" value="" onblur="checkrequired3();">
                        
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
		<input type="submit" name="submit3" id="submit3" value=" Go " disabled="disabled">

<cfelseif sort eq "Custno">
Customer No From 	<input type="text" name="custnofrom" id="custnofrom" size="10" value="" maxlength="8" onblur="checkrequired4();" >
Customer No To		<input type="text" name="custnoto" id="custnoto" size="10" value="" maxlength="8" onblur="checkrequired4();" >

<input type="submit" name="submit4" id="submit4" value="Go" disabled="disabled">

</cfif>

</cfoutput>