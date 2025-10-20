<cfquery datasource="#dts#" name="getgeneral">
	Select lJOB as layer from gsetup
</cfquery>
<html>
<head>
<title><cfoutput>Identifier</cfoutput> Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<script language="JavaScript">

function validate(){
  if(document.despForm.source.value==''){
	alert("Your Identifier's No. cannot be blank.");
	document.despForm.identiferno.focus();
	return false;
  }

<!---   if(document.ProjectForm.PorJ.value==''){
	alert("You must choose P or J.");
	document.ProjectForm.PorJ.focus();
	return false;
  } --->
  return true;
}

function limitText(field,maxlimit){
	if (field.value.length > maxlimit) // if too long...trim it!
		field.value = field.value.substring(0, maxlimit);
		// otherwise, update 'characters left' counter
}
	
</script>

<body>
<cfoutput>
	<cfif url.type eq "Edit">
		<cfquery datasource='#dts#' name="getitem">
			Select * from identifier where identifierno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.identifierno)#"> 
		</cfquery>
		
		<cfset identifierno=getitem.identifierno>
		<cfset desp=getitem.desp>
		
       
		
        
		
        
		
		
		<cfset mode="Edit">
		<!--- <cfset title="Edit Item"> --->
		<cfset title="Edit "&getgeneral.layer>
		<cfset button="Edit">
	
	<cfelseif url.type eq "Delete">
		<cfquery datasource='#dts#' name="getitem">
			Select * from identifier where identifierno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.identifierno)#">
		</cfquery>
		
		<cfset identifierno=getitem.identifierno>
		<cfset desp=getitem.desp>
		
		
        	
        
		
		
		<cfset mode="Delete">
		<!--- <cfset title="Delete Item"> --->
		<cfset title="Delete "&getgeneral.layer>
		<cfset button="Delete">
	
	<cfelseif url.type eq "Create">
		<cfset identifierno="">
		<cfset desp="">
	
		
        	
        
		
		<cfset mode="Create">
		<!--- <cfset title="Create Item"> --->
		<cfset title="Create "&getgeneral.layer>
		<cfset button="Create">
	</cfif>

  <h1>Create Identifier</h1>
			
	<h4>
		<cfif getpin2.h1H10 eq 'T'><a href="identifiertable2.cfm?type=Create">Creating a Identifier</a> </cfif>
		<cfif getpin2.h1H20 eq 'T'>|| <a href="identifiertable.cfm?">List all Identifier</a> </cfif>
		<cfif getpin2.h1H30 eq 'T'>|| <a href="s_identifiertable.cfm?type=project">Search For Identifier</a></cfif>||  <a href="p_identifier.cfm">Identifier Listing report</a>
	</h4>
</cfoutput> 

<cfform name="despForm" action="identifiertableprocess.cfm" method="post" onsubmit="return validate()">
  <cfoutput> 
    <input type="hidden" name="mode" value="#mode#">
  </cfoutput> 
  <h1 align="center"><cfoutput>Identifier</cfoutput> File Maintenance</h1>
  <table align="center" class="data" width="400">
    <cfoutput> 
      <tr> 
        <td width="80">Identifier:</td>
        <td colspan="4"> <cfif mode eq "Delete" or mode eq "Edit">
            <!--- <h2>#url.source#</h2> --->
            <input type="text" size="10" name="identifierno" value="#URLDECODE(url.identifierno)#" readonly>
            <cfelse>
            <input type="text" size="20" name="identifierno" value="#identifierno#" maxlength="1">
          </cfif> </td>
      </tr>
      <tr> 
        <td>Description :</td>
        <td colspan="4">
			<cfif lcase(HcomID) eq 'taff_i' or lcase(HcomID) eq 'taftc_i'>
				<textarea name="desp" id="desp" cols="40" rows="3" onKeyDown="limitText(this.form.desp,200);" onKeyUp="limitText(this.form.desp,200);">#desp#</textarea>
			<cfelse>
				<input type="text" size="40" name="desp" value="#desp#" maxlength="#IIf((lcase(HcomID) eq 'tmt_i'),DE('80'),DE('40'))#">
			</cfif><input type="hidden" value="J" name="PORJ" id="PORJ" />
		</td>
      </tr>
<!--- <tr>
        <td>P or J</td>
        <td colspan="4"><select name="PorJ">
            <option value="">Choose P or J</option>
            <option value="P"<cfif porj eq "P">Selected</cfif>>P</option>
            <option value="J"<cfif porj eq "J">Selected</cfif>>J</option>
          </select>
        </td>
      </tr> 
      <tr>
      <td>Credit Sales :</td>
      <td><input type="text" name="creditsales" id="creditsales" value="#creditsales#" /></td>
      </tr>
        <tr>
      <td>Cash Sales :</td>
      <td><input type="text" name="cashsales" id="cashsales" value="#cashsales#" /></td>
      </tr>
        <tr>
      <td>Sales Return :</td>
      <td><input type="text" name="salesreturn" id="salesreturn" value="#salesreturn#" /></td>
      </tr>
      <tr>
      <td>Purchase :</td>
      <td><input type="text" name="purchase" id="purchase" value="#purchase#" /></td>
      </tr>
        <tr>
      <td>Purchase Return :</td>
      <td><input type="text" name="purchasereturn" id="purchasereturn" value="#purchasereturn#" /></td>
      </tr>--->
      
     
	  
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
