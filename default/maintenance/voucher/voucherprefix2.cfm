<html>
<head>
<title>Voucher Maintenance</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<script language="JavaScript">

function validate(){
  if(document.voucherform.voucherprefixno.value==''){
	alert("Your Voucher Prefix No. cannot be blank.");
	document.voucherform.voucherprefixno.focus();
	return false;
  }
  else if(document.voucherform.voucherprefixno.value.length!=3)
  {
  alert("Your Voucher Prefix No. Must Be 3 Letter");
	document.voucherform.voucherprefixno.focus();
	return false;
  }

  return true;
}

	
</script>

<body>
<cfoutput>
	<cfif url.type eq "Edit">
		<cfquery datasource='#dts#' name="getitem">
			Select * from voucherprefix 
		</cfquery>
		
		<cfset voucherprefixno=getitem.voucherprefixnono>
		<cfset mode="Edit">
		<!--- <cfset title="Edit Item"> --->
		<cfset title="Edit Voucher Prefix">
		<cfset button="Edit">
	
	<cfelseif url.type eq "Delete">
		<cfquery datasource='#dts#' name="getitem">
			Select * from voucherprefix 
		</cfquery>
		
		<cfset voucherprefixno=getitem.voucherprefixno>
		
		<cfset mode="Delete">
		<!--- <cfset title="Delete Item"> --->
		<cfset title="Delete Voucher Prefix">
		<cfset button="Delete">
	
	<cfelseif url.type eq "Create">
		<cfset voucherprefixno="">
		
		<cfset mode="Create">
		<!--- <cfset title="Create Item"> --->
		<cfset title="Create Voucher Prefix">
		<cfset button="Create">
	</cfif>

<title>Voucher Maintenance</title>
			
	<h4>
<a onClick="ColdFusion.Window.show('createvoucher');" onMouseOver="this.style.cursor='hand'">Create Voucher</a>|<a href="p_voucher.cfm">Voucher Listing</a>|<a href="vouchermaintenance.cfm">Voucher Maintenance</a><cfif getpin2.h1R10 eq "T">|<a href="voucherapprove.cfm">Voucher Approval</a></cfif>|<a href="voucherusage.cfm">Voucher Usage Report</a>|<a href="voucherprefix2.cfm?type=Create">Create Voucher Prefix</a></h4>	

</cfoutput> 

<cfform name="voucherform" action="voucherprefixprocess.cfm" method="post" onsubmit="return validate()">
  <cfoutput> 
    <input type="hidden" name="mode" value="#mode#">
  </cfoutput> 
  <h1 align="center">Voucher Prefix Maintenance</h1>
  <table align="center" class="data" width="400">
    <cfoutput> 
      <tr> 
        <td width="80">Voucher Prefix :</td>
        <td colspan="4"> <cfif mode eq "Delete" or mode eq "Edit">
            <input type="text" size="10" name="voucherprefixno" value="#url.voucherprefixno#" readonly>
            <cfelse>
            <input type="text" size="20" name="voucherprefixno" value="#voucherprefixno#" maxlength="3" >
          </cfif> </td>
      </tr>
    </cfoutput> 
    <tr> 
      <td height="23"></td>
      <td colspan="4" align="right"><cfoutput> 
          <input name="submit" type="submit" value="  #button#  ">
        </cfoutput></td>
    </tr>
  </table>
</cfform>
</body>
</html>
