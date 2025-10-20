<html>
<head>
<title>Cashier</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<script language="JavaScript">
	function validate()
	{
		if(document.form1.cashier.value=='')
		{
			alert("Your Cashier ID cannot be blank.");
			document.form1.cashierid.focus();
			return false;
		}
		return true;
	}
	
</script>
<body>
			
<cfif url.type eq "Edit">
	<cfquery datasource='#dts#' name="getitem">
		Select * from cashier where cashierid='#url.cashier#'
	</cfquery>
	<cfset cashierid=getitem.cashierid>
	<cfset name=getitem.name>
    <cfset password=getitem.password>
	<cfif lcase(HComID) eq "ugateway_i">
		<cfset rangeForDisc=val(getitem.rangeForDisc)>
		<cfset dispec=val(getitem.dispec)>
	</cfif>
				
	<cfset mode="Edit">
	<cfset title="Edit Brand">
	<cfset button="Edit">
</cfif>

<cfif url.type eq "Delete">
	<cfquery datasource='#dts#' name="getitem">
		Select * from cashier where cashierid='#url.cashier#'
	</cfquery>
	<cfset casheirid=getitem.cashierid>
	<cfset name=getitem.name>
	<cfset password=getitem.password>
	<cfif lcase(HComID) eq "ugateway_i">
		<cfset rangeForDisc=val(getitem.rangeForDisc)>
		<cfset dispec=val(getitem.dispec)>
	</cfif>
				
	<cfset mode="Delete">
	<cfset title="Delete Brand">
	<cfset button="Delete">
</cfif>
			
<cfif url.type eq "Create">   
    <cfset cashier="">
	<cfset name="">
    <cfset password="">
	<cfif lcase(HComID) eq "ugateway_i">
		<cfset rangeForDisc=0>
		<cfset dispec=0>
	</cfif>
				
	<cfset mode="Create">
	<cfset title="Create Brand">
	<cfset button="Create">
</cfif>

<cfoutput>
	<h1>#title#</h1>
	<h4>
		<cfif getpin2.h1P10 eq 'T'><a href="cashiertable2.cfm?type=Create">Creating a New Cashier</a> </cfif>
		<cfif getpin2.h1P20 eq 'T'>|| <a href="cashiertable.cfm">List all Cashier</a> </cfif>
		<cfif getpin2.h1P30 eq 'T'>|| <a href="s_cashiertable.cfm?type=brand">Search For Cashier</a></cfif>
        <cfif getpin2.h1630 eq 'T'>|| <a href="p_cashier.cfm">Cashier Listing</a>
        || <a href="attendancereport.cfm">Staff Attendance Report</a>
        </cfif>
	</h4>
</cfoutput>

<cfform name="form1" action="cashierprocess.cfm" method="post" onsubmit="return validate()">
	<cfoutput><input type="hidden" name="mode" value="#mode#"></cfoutput>
  	<h1 align="center">Cashier File Maintenance</h1>
  	
  	
  	<table align="center" class="data" width="500">
    <cfoutput> 
		<tr> 
        	<td width="80" nowrap>Cashier ID:</td>
        	<td width="420"> 
			<cfif mode eq "Delete" or mode eq "Edit">
        		<input type="text" size="40" name="cashierid" id="cashierid" value="#url.cashier#" readonly>
       		<cfelse>
            	<cfinput type="text" size="40" name="cashier" id="cashier" value="#cashier#" maxlength="40" required="yes">
        	</cfif> 
			</td>
      	</tr>
		<tr> 
        	<td>Name :</td>
        	<td>
				<input type="text" size="40" name="name" id="name" value="#name#" maxlength="100">
			</td>
      	</tr>
        <tr> 
	        	<td>Password :</td>
	        	<td><cfinput type="password" size="40" name="password" id="password" value="#password#" maxlength="100" required="yes"></td>
	      	</tr>
		<cfif lcase(HComID) eq "ugateway_i">
			
			
		</cfif>
      	<tr> 
       		<td></td>
        	<td>&nbsp;</td>
      	</tr>
      	<tr> 
        	<td></td>
        	<td align="right"><input name="submit" type="submit" value="  #button#  "></td>
      	</tr>
    </cfoutput> 
  	</table>
</cfform>
			
</body>
</html>
