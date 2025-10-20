<html>
<head>
<title>Currency Code</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<cfoutput><link rel="stylesheet" href="/stylesheet/stylesheet.css"/></cfoutput>
</head>
<body>
<cfquery datasource="#dts#" name="getgsetup">
	select * from gsetup
</cfquery>	

<cfset realperiod=url.period>

<cfset getthismonth = dateadd("m",url.period,getgsetup.lastAccYear)>
<cfset getthisyear = dateformat(dateadd("m",url.period,getgsetup.lastAccYear),'yyyy')>

		<cfquery datasource='#dts#' name="currEdit2">
			SELECT * FROM #target_currency# where currcode='#url.currcode#'
		</cfquery>
        
		<cfquery datasource='#dts#' name="currEdit">
			SELECT * FROM #target_currencymonth# where currcode='#url.currcode#' and fperiod='#numberformat(url.period,'00')#'
		</cfquery>
		
		
				<cfset currcode='#currEdit2.currcode#'>
				<cfset currency='#currEdit2.Currency#'>
				<cfset CurrDollar='#currEdit2.Currency1#'>
				<cfset CurrCent='#currEdit2.Currency2#'>
		<cfif currEdit.recordcount neq 0>
			<cfif currEdit.currD1 eq 0>
				<cfset currD1 =''>
			<cfelse>
				<cfset currD1 ='#currEdit.currD1#'>
			</cfif>
			<cfif currEdit.currD2 eq 0>
				<cfset currD2 =''>
			<cfelse>
				<cfset currD2 ='#currEdit.currD2#'>
			</cfif>
			<cfif currEdit.currD3 eq 0>
				<cfset currD3 =''>
			<cfelse>
				<cfset currD3 ='#currEdit.currD3#'>
			</cfif>
			<cfif currEdit.currD4 eq 0>
				<cfset currD4 =''>
			<cfelse>
				<cfset currD4 ='#currEdit.currD4#'>
			</cfif>
			<cfif currEdit.currD5 eq 0>
				<cfset currD5 =''>
			<cfelse>
				<cfset currD5 ='#currEdit.currD5#'>
			</cfif>
			<cfif currEdit.currD6 eq 0>
				<cfset currD6 =''>
			<cfelse>
				<cfset currD6 ='#currEdit.currD6#'>
			</cfif>
			<cfif currEdit.currD7 eq 0>
				<cfset currD7 =''>
			<cfelse>
				<cfset currD7 ='#currEdit.currD7#'>
			</cfif>
			<cfif currEdit.currD8 eq 0>
				<cfset currD8 =''>
			<cfelse>
				<cfset currD8 ='#currEdit.currD8#'>
			</cfif>
			<cfif currEdit.currD9 eq 0>
				<cfset currD9 =''>
			<cfelse>
				<cfset currD9 ='#currEdit.currD9#'>
			</cfif>
			<cfif currEdit.currD10 eq 0>
				<cfset currD10 =''>
			<cfelse>
				<cfset currD10 ='#currEdit.currD10#'>
			</cfif>
			<cfif currEdit.currD11 eq 0>
				<cfset currD11 =''>
			<cfelse>
				<cfset currD11 ='#currEdit.currD11#'>
			</cfif>
			<cfif currEdit.currD12 eq 0>
				<cfset currD12 =''>
			<cfelse>
				<cfset currD12 ='#currEdit.currD12#'>
			</cfif>
			<cfif currEdit.currD13 eq 0>
				<cfset currD13 =''>
			<cfelse>
				<cfset currD13 ='#currEdit.currD13#'>
			</cfif>
			<cfif currEdit.currD14 eq 0>
				<cfset currD14 =''>
			<cfelse>
				<cfset currD14 ='#currEdit.currD14#'>
			</cfif>
			<cfif currEdit.currD15 eq 0>
				<cfset currD15 =''>
			<cfelse>
				<cfset currD15 ='#currEdit.currD15#'>
			</cfif>
			<cfif currEdit.currD16 eq 0>
				<cfset currD16 =''>
			<cfelse>
				<cfset currD16 ='#currEdit.currD16#'>
			</cfif>
			<cfif currEdit.currD17 eq 0>
				<cfset currD17 =''>
			<cfelse>
				<cfset currD17 ='#currEdit.currD17#'>
			</cfif>
			<cfif currEdit.currD18 eq 0>
				<cfset currD18 =''>
			<cfelse>
				<cfset currD18 ='#currEdit.currD18#'>
			</cfif>
			<cfif currEdit.currD19 eq 0>
				<cfset currD19 =''>
			<cfelse>
				<cfset currD19 ='#currEdit.currD19#'>
			</cfif>
			<cfif currEdit.currD20 eq 0>
				<cfset currD20 =''>
			<cfelse>
				<cfset currD20 ='#currEdit.currD20#'>
			</cfif>
				<cfif currEdit.currD21 eq 0>
				<cfset currD21 =''>
			<cfelse>
				<cfset currD21 ='#currEdit.currD21#'>
			</cfif>
			<cfif currEdit.currD22 eq 0>
				<cfset currD22 =''>
			<cfelse>
				<cfset currD22 ='#currEdit.currD22#'>
			</cfif>
			<cfif currEdit.currD23 eq 0>
				<cfset currD23 =''>
			<cfelse>
				<cfset currD23 ='#currEdit.currD23#'>
			</cfif>
			<cfif currEdit.currD24 eq 0>
				<cfset currD24 =''>
			<cfelse>
				<cfset currD24 ='#currEdit.currD24#'>
			</cfif>
			<cfif currEdit.currD25 eq 0>
				<cfset currD25 =''>
			<cfelse>
				<cfset currD25 ='#currEdit.currD25#'>
			</cfif>
			<cfif currEdit.currD26 eq 0>
				<cfset currD26 =''>
			<cfelse>
				<cfset currD26 ='#currEdit.currD26#'>
			</cfif>
			<cfif currEdit.currD27 eq 0>
				<cfset currD27 =''>
			<cfelse>
				<cfset currD27 ='#currEdit.currD27#'>
			</cfif>
			<cfif currEdit.currD28 eq 0>
				<cfset currD28 =''>
			<cfelse>
				<cfset currD28 ='#currEdit.currD28#'>
			</cfif>
			<cfif currEdit.currD29 eq 0>
				<cfset currD29 =''>
			<cfelse>
				<cfset currD29 ='#currEdit.currD29#'>
			</cfif>
			<cfif currEdit.currD30 eq 0>
				<cfset currD30 =''>
			<cfelse>
				<cfset currD30 ='#currEdit.currD30#'>
			</cfif>
			<cfif currEdit.currD31 eq 0>
				<cfset currD31 =''>
			<cfelse>
				<cfset currD31 ='#currEdit.currD31#'>
			</cfif>			
				
		<cfelse>
				<cfset currD1 =evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD2 =evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD3 =evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD4 =evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD5 =evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD6 =evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD7 =evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD8 =evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD9 =evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD10=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD11=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD12=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD13=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD14=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD15=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD16=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD17=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD18=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD19=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD20=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD21=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD22=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD23=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD24=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD25=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD26=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD27=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD28=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD29=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD30=evaluate('currEdit2.CURRP#realperiod#')>
				<cfset currD31=evaluate('currEdit2.CURRP#realperiod#')>

				
		</cfif>		
				

	<form action="currencyMonth2.cfm" method="post" name="createCurrency" preservedata="yes">
	
		<cfoutput>
		<input type="hidden" name="oriCode" value="#url.currcode#">
		<input type="hidden" name="oriPeriod" value="#numberformat(url.period,'00')#">
		<input type="hidden" name="dayofmonth" value="#DaysInMonth(getthismonth)#">
		</cfoutput>
	
		<cfoutput><h1>#url.type# Currency</h1></cfoutput>
	
		<!--- <cfoutput><h4>
		<a href="createCurrency.cfm?type=Create"> Create New Currency</a> || 
		<a href="vCurrency.cfm">List all Currency</a> 
		</h4></cfoutput> --->
		<cfif isdefined("form.status")>
			<cfoutput><h1>#form.status#</h1></cfoutput>
		</cfif>
	
		<table border="0" cellpadding="0" cellspacing="0">
		<cfoutput>
			<tr>
				<td>Currency Code :</td>
				<td><h2>#url.currcode#</h2></td>
                <td></td>
			</tr>
			<tr>
				<td>Country :</td>
				<td><h2>#currency#</h2></td>
                <td></td>		
			</tr>
			<tr>
				<td>Currency Dollars :</td>
				<td><h2>#CurrDollar#</h2></td>	
                <td></td>	
			</tr>
			<tr>
				<td>Currency Cents :</td>
				<td><h2>#CurrCent#</h2></td>	
                <td></td>	
			</tr>
			
			</cfoutput>
			<tr><td colspan="3"><hr></td></tr>
            <tr><td ></td><td></td></tr>
				<cfoutput>
				
				<cfloop index="mon" from="1" to="#DaysInMonth(getthismonth)#">	
					<tr><th>#numberformat(mon,'00')##dateformat(getthismonth,'/mm/')##getthisyear# <cfset thisdate ="#numberformat(mon,'00')#"&"#dateformat(getthismonth,'/mm/')##getthisyear#"></th>
					<td>	
					
					<cfset myVal = "currD" & mon>
                    <cfif evaluate(myVal) eq ''>
                    	<cfset myval2 = ''>
                    <cfelse>
                    	<cfset myval2 = numberformat(evaluate(myVal),'.____')>
                    </cfif>
                   
					
					<!--- <cfif evaluate("rem"&mon) neq ''> style="background-color:FF0000" readonly</cfif> --->
					<input type="text" name="#myVal#" id="#myVal#" value="#myval2#" >
					</td>
				</tr></cfloop></cfoutput>
			<tr>
				<td></td>
				<td><input type="submit" value="Save"></td>	
			</tr>
			
		</table>
	</form>
</body>
</html>
