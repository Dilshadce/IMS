<html>
<head>
<title>Item Assembly</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="currency" datasource="#dts#">
	select * 
	from #target_currency#
</cfquery>

<script language="JavaScript">
	function displayrate()
	{
		if(document.invoicesheet.refno3.value!='')
		{
			<cfoutput query ="currency">		
			if(document.invoicesheet.refno3.value=='#currency.currcode#')
			{	<cfquery datasource="#dts#" name="getGeneralInfo">
					Select * from GSetup
				</cfquery>
	
				<cfset lastaccyear = dateformat(getGeneralInfo.lastaccyear, "dd/mm/yyyy")>
				<cfset period = getGeneralInfo.period>
				<!--- Changed By Wee Siong (08-05-2008) 
				<cfset currentdate = dateformat(now(),"dd/mm/yyyy")>
				--->
				<cfset currentdate = now()>
				<cfset tmpYear = year(currentdate)>
				<cfset clsyear = year(lastaccyear)>
				<cfset tmpmonth = month(currentdate)>
				<cfset clsmonth = month(lastaccyear)>
				<cfset intperiod = (tmpyear - clsyear) * 12 + tmpmonth - clsmonth>
				
				<cfif intperiod gt 18 or intperiod lte 0>
					<cfset readperiod = 99>
				<cfelse>
					<cfset readperiod = numberformat(intperiod,"00")>
				</cfif>
				
				<cfif readperiod eq '01'>
					<cfset rates2 = currency.CurrP1>
				</cfif>
				<cfif readperiod eq '02'>
					<cfset rates2 = currency.CurrP2>
				</cfif>
				<cfif readperiod eq '03'>
					<cfset rates2 = currency.CurrP3>
				</cfif>
				<cfif readperiod eq '04'>
					<cfset rates2 = currency.CurrP4>
				</cfif>
				<cfif readperiod eq '05'>
					<cfset rates2 = currency.CurrP5>
				</cfif>
				<cfif readperiod eq '06'>
					<cfset rates2 = currency.CurrP6>
				</cfif>
				<cfif readperiod eq '07'>
					<cfset rates2 = currency.CurrP7>
				</cfif>
				<cfif readperiod eq '08'>
					<cfset rates2 = currency.CurrP8>
				</cfif>
				<cfif readperiod eq '09'>
					<cfset rates2 = currency.CurrP9>
				</cfif>
				<cfif readperiod eq '10'>
					<cfset rates2 = currency.CurrP10>
				</cfif>
				<cfif readperiod eq '11'>
					<cfset rates2 = currency.CurrP11>
				</cfif>
				<cfif readperiod eq '12'>
					<cfset rates2 = currency.CurrP12>
				</cfif>
				<cfif readperiod eq '13'>
					<cfset rates2 = currency.CurrP13>
				</cfif>
				<cfif readperiod eq '14'>
					<cfset rates2 = currency.CurrP14>
				</cfif>
				<cfif readperiod eq '15'>
					<cfset rates2 = currency.CurrP15>
				</cfif>
				<cfif readperiod eq '16'>
					<cfset rates2 = currency.CurrP16>
				</cfif>
				<cfif readperiod eq '17'>
					<cfset rates2 = currency.CurrP17>
				</cfif>
				<cfif readperiod eq '18'>
					<cfset rates2 = currency.CurrP18>
				</cfif>
				<cfif readperiod eq '99'>
					<cfset rates2 = "1">
				</cfif>
				document.invoicesheet.currrate.value='#numberformat(rates2,"._____")#';	
			}	
		</cfoutput>
		}
	}
	
	function test()	
	{
  		if(document.invoicesheet.nexttranno.value=='')
		{
    		alert("Your Transaction's No. cannot be blank.");
			document.invoicesheet.nexttranno.focus();
    		return false;
  		}
		
		if(document.invoicesheet.custno.value=='')
		{
			alert("Your Customer's No. cannot be blank.");
			document.invoicesheet.custno.focus();
			return false;
  		}
  		return true;
	}		
</script>

<!--- REMARK ON 240608 AND REPLACE WITH THE BELOW ONE --->
<!---cfquery datasource="#dts#" name="getGeneralInfo">
	Select assmno as tranno, assmarun as arun from GSetup
</cfquery--->

<cfquery name="getGsetup" datasource="#dts#">
	select bcurr from gsetup
</cfquery>

<cfif isdefined("form.invset") or isdefined("invset") and invset neq 0>
	<!--- <cfquery datasource="main" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where userDept = '#dts#'
		and type = 'ASSM'
		and counter = '#invset#'
	</cfquery> --->
	
	<cfquery datasource="#dts#" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where type = 'ASSM'
		and counter = '#invset#'
	</cfquery>
	<cfset counter = invset>
<cfelse>
	<!--- <cfquery datasource="main" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where userDept = '#dts#'
		and type = 'ASSM'
		and counter = 1
	</cfquery> --->
	
	<cfquery datasource="#dts#" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun from refnoset
		where type = 'ASSM'
		and counter = 1
	</cfquery>
	
	<cfset invset = 1>
	<cfset counter = 1>
</cfif>

<cfif getGeneralInfo.arun eq "1">
	<cfset refnocnt = len(getGeneralInfo.tranno)>	
	<cfset cnt = 0>
	<cfset yes = 0>
	
	<cfloop condition = "cnt lte refnocnt and yes eq 0">
		<cfset cnt = cnt + 1>			
		<cfif isnumeric(mid(getGeneralInfo.tranno,cnt,1))>				
			<cfset yes = 1>			
		</cfif>								
	</cfloop>
	
	<cfset nolen = refnocnt - cnt + 1>
	<cfset nextno = right(getGeneralInfo.tranno,nolen) + 1>
	
	<cfset nocnt = 1>
	<cfset zero = "">
	
	<cfloop condition = "nocnt lte nolen">
		<cfset zero = zero & "0">
		<cfset nocnt = nocnt + 1>	
	</cfloop>		
	
	<cfset limit = 8>
	
	<cfif cnt gt 1>
		<cfset nexttranno = left(getGeneralInfo.tranno,cnt-1)&numberformat(nextno,zero)>
		<cfif len(nexttranno) gt limit>
			<cfset nexttranno = '99999999'>
		</cfif>
	<cfelse>
		<cfset nexttranno = numberformat(nextno,zero)> 
		<cfif len(nexttranno) gt limit>
			<cfset nexttranno = '99999999'>
		</cfif>
	</cfif>
<cfelse>
	  <cfset nexttranno= "">	
</cfif>

<body>
<h1 align="center">Item Assembly</h1>
<cfform action="assm2.cfm?type=create" method="post" name="invoicesheet">
	<cfoutput><input type="hidden" name="invset" value="#listfirst(invset)#"></cfoutput>
	<table width="80%" border="0" cellspacing="0" cellpadding="0" align="center" class="data">
    	<cfoutput> 
    	<tr> 
        	<th height="21">Next Assembly No</th>
        	<td colspan="3">
			<cfif getGeneralInfo.arun eq "1">
            	  <h3>#nexttranno#</h3>
            <cfelse>
              	<input name="nexttranno" type="text" value="#nexttranno#" onValidate="javascript:test()" size="10" maxlength="8">
            </cfif>
			</td>
        	<td>&nbsp;</td>
      	</tr>
    	</cfoutput> 
    	<tr> 
      		<th>Assembly Date</th>
      		<td><cfinput type="text" name="invoicedate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" validate="eurodate" maxlength="10">(DD/MM/YYYY) </td>
      		<th>Currency</th>
      		<td><select name="refno3" onChange="javascript:displayrate()">
	  			<cfif currency.currcode neq "">
          			<cfoutput query="currency"> 
              			<option value="#currency.currcode#"<cfif currcode eq '#getGsetup.bcurr#'>selected</cfif>>#currency.currcode#</option>
            		</cfoutput> 
          		</cfif>
        		</select>
				<cfoutput><input name="currrate" type="text" size="10" value="#Numberformat(1, "._____")#"></cfoutput> </td>      
      		<td>&nbsp;</td>
    	</tr>
    	<tr> 
    		<th>Description</th>
      		<td colspan="3"><cfoutput><input name="desp" type="text" size="50" maxlength="40" value="Receive"></cfoutput></td>
      		<td>&nbsp;</td>
    	</tr>
    	<tr> 
      		<th>&nbsp;</th>
      		<td colspan="3">
			<cfoutput> 
          	<input name="despa" type="text" size="50" maxlength="40" value="Issue">
          	<input name="submit" type="submit" value="Create">
        	</cfoutput></td>
      		<td>&nbsp;</td>
    	</tr>
  	</table>
</cfform>

</body>
</html>