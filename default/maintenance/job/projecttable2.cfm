<cfquery datasource="#dts#" name="getgeneral">
	Select lJOB as layer from gsetup
</cfquery>
<html>
<head>
<title><cfoutput>#getgeneral.layer#</cfoutput> Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<script language="JavaScript">

function validate(){
  if(document.ProjectForm.source.value==''){
	alert("Your Project's No. cannot be blank.");
	document.ProjectForm.source.focus();
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
			Select * FROM #target_project# where source=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.source)#"> and porj = "J"
		</cfquery>
		
		<cfset source=getitem.source>
		<cfset project=getitem.project>
		<cfset porj=getitem.porj>
        <cfset creditsales = getitem.creditsales>
        <cfset cashsales = getitem.cashsales>
        <cfset salesreturn = getitem.salesreturn>
        <cfset purchase = getitem.purchase>
        <cfset purchasereturn = getitem.purchasereturn>
		
        
		<cfif lcase(HcomID) eq 'taftc_i'>
			<cfset d5=getitem.DETAIL5>
			<cfset d6=getitem.DETAIL6>
			<cfset d7=getitem.DETAIL7>
			<cfset d8=getitem.DETAIL8>
			<cfset postingtimes=getitem.postingtimes>
		</cfif>
        
		<cfif lcase(HcomID) eq "pls_i">
			<cfset d4=getitem.DETAIL4>
			<cfset d5=getitem.DETAIL5>
			<cfset d6=getitem.DETAIL6>
			<cfset d7=getitem.DETAIL7>
			<cfset d8=getitem.DETAIL8>
			<cfset d9=getitem.DETAIL9>
			<cfset d10=getitem.DETAIL10>
			<cfset d11=getitem.DETAIL11>
			<cfset d12=getitem.DETAIL12>
			<cfset d13=getitem.DETAIL13>
		</cfif>
		
		<cfset mode="Edit">
		<!--- <cfset title="Edit Item"> --->
		<cfset title="Edit "&getgeneral.layer>
		<cfset button="Edit">
	
	<cfelseif url.type eq "Delete">
		<cfquery datasource='#dts#' name="getitem">
			Select * FROM #target_project# where source=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.source)#"> and porj = "J"
		</cfquery>
		
		<cfset source=getitem.source>
		<cfset project=getitem.project>
		<cfset porj=getitem.porj>
        <cfset creditsales = getitem.creditsales>
        <cfset cashsales = getitem.cashsales>
        <cfset salesreturn = getitem.salesreturn>
        <cfset purchase = getitem.purchase>
        <cfset purchasereturn = getitem.purchasereturn>
		
        	<cfif lcase(HcomID) eq 'taftc_i'>
			<cfset d5=getitem.DETAIL5>
			<cfset d6=getitem.DETAIL6>
			<cfset d7=getitem.DETAIL7>
			<cfset d8=getitem.DETAIL8>
			<cfset postingtimes=getitem.postingtimes>
		</cfif>
        
		<cfif lcase(HcomID) eq "pls_i">
			<cfset d4=getitem.DETAIL4>
			<cfset d5=getitem.DETAIL5>
			<cfset d6=getitem.DETAIL6>
			<cfset d7=getitem.DETAIL7>
			<cfset d8=getitem.DETAIL8>
			<cfset d9=getitem.DETAIL9>
			<cfset d10=getitem.DETAIL10>
			<cfset d11=getitem.DETAIL11>
			<cfset d12=getitem.DETAIL12>
			<cfset d13=getitem.DETAIL13>
		</cfif>
		
		<cfset mode="Delete">
		<!--- <cfset title="Delete Item"> --->
		<cfset title="Delete "&getgeneral.layer>
		<cfset button="Delete">
	
	<cfelseif url.type eq "Create">
		<cfset source="">
		<cfset project="">
		<cfset porj="">
        <cfset creditsales = "">
        <cfset cashsales = "">
        <cfset salesreturn = "">
        <cfset purchase = "">
        <cfset purchasereturn = "">
		
        	<cfif lcase(HcomID) eq 'taftc_i'>
			<cfset d5="">
			<cfset d6="">
			<cfset d7="">
			<cfset d8="">
			<cfset postingtimes=1>
		</cfif>
        
		<cfif lcase(HcomID) eq "pls_i">
			<cfset d4="">
			<cfset d5="">
			<cfset d6="">
			<cfset d7="">
			<cfset d8="">
			<cfset d9="">
			<cfset d10="">
			<cfset d11="">
			<cfset d12="">
			<cfset d13="">
		</cfif>
		
		<cfset mode="Create">
		<!--- <cfset title="Create Item"> --->
		<cfset title="Create "&getgeneral.layer>
		<cfset button="Create">
	</cfif>

  <h1>#title#</h1>
			
	<h4>
		<cfif getpin2.h1H10 eq 'T'><a href="Projecttable2.cfm?type=Create">Creating a #getgeneral.layer#</a> </cfif>
		<cfif getpin2.h1H20 eq 'T'>|| <a href="Projecttable.cfm?">List all #getgeneral.layer#</a> </cfif>
		<cfif getpin2.h1H30 eq 'T'>|| <a href="s_Projecttable.cfm?type=project">Search For #getgeneral.layer#</a></cfif>||<a href="p_project.cfm">#getgeneral.layer# Listing report</a>
	</h4>
</cfoutput> 

<cfform name="ProjectForm" action="Projecttableprocess.cfm" method="post" onsubmit="return validate()">
  <cfoutput> 
    <input type="hidden" name="mode" value="#mode#">
  </cfoutput> 
  <h1 align="center"><cfoutput>#getgeneral.layer#</cfoutput> File Maintenance</h1>
  <table align="center" class="data" width="400">
    <cfoutput> 
      <tr> 
        <td width="80">#getgeneral.layer# :</td>
        <td colspan="4"> <cfif mode eq "Delete" or mode eq "Edit">
            <!--- <h2>#url.source#</h2> --->
            <input type="text" size="10" name="source" value="#URLDECODE(url.source)#" readonly>
            <cfelse>
            <input type="text" size="20" name="source" value="#source#" maxlength="<cfif lcase(hcomid) eq 'tmt_i' or lcase(hcomid) eq 'taff_i'>8<cfelseif lcase(hcomid) eq 'taftc_i'>15<cfelseif lcase(hcomid) eq 'pls_i'>10<cfelseif lcase(hcomid) eq 'topsteel_i'>30<cfelse>40</cfif>">
          </cfif> </td>
      </tr>
      <tr> 
        <td>Description :</td>
        <td colspan="4">
			<cfif lcase(HcomID) eq 'taff_i' or lcase(HcomID) eq 'taftc_i'>
				<textarea name="project" id="project" cols="40" rows="3" onKeyDown="limitText(this.form.project,200);" onKeyUp="limitText(this.form.project,200);">#project#</textarea>
			<cfelse>
				<input type="text" size="40" name="project" value="#project#" maxlength="#IIf((lcase(HcomID) eq 'tmt_i'),DE('80'),DE('40'))#">
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
      
      <cfif lcase(HcomID) eq 'taftc_i'>
      
      <tr> 
			<td>Course Start Date :</td>
			<td colspan="4"><input type="text" size="40" name="d5" value="#d5#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Course End Date :</td>
			<td colspan="4"><input type="text" size="40" name="d6" value="#d6#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Course Start Time :</td>
			<td colspan="4"><input type="text" size="40" name="d7" value="#d7#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Course End Time :</td>
			<td colspan="4"><input type="text" size="40" name="d8" value="#d8#" maxlength="80"></td>
		</tr>
        <tr> 
			<td>Posting Times :</td>
			<td colspan="4"><input type="text" size="40" name="postingtimes" value="#val(postingtimes)#" maxlength="80"></td>
		</tr>
      
      </cfif>
	  <cfif lcase(HcomID) eq "pls_i">
		<tr> 
			<td>Engine No :</td>
			<td colspan="4"><input type="text" size="40" name="d5" value="#d5#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Chassis No :</td>
			<td colspan="4"><input type="text" size="40" name="d6" value="#d6#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Make :</td>
			<td colspan="4"><input type="text" size="40" name="d7" value="#d7#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Model :</td>
			<td colspan="4"><input type="text" size="40" name="d8" value="#d8#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Y.O.M :</td>
			<td colspan="4"><input type="text" size="40" name="d9" value="#d9#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Propellant :</td>
			<td colspan="4"><input type="text" size="40" name="d10" value="#d10#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Color :</td>
			<td colspan="4"><input type="text" size="40" name="d11" value="#d11#" maxlength="80"></td>
		</tr>
		<tr> 
			<td>Location :</td>
			<td colspan="4"><input type="text" size="40" name="d12" value="#d12#" maxlength="80"></td>
		</tr>
	  </cfif>
    </cfoutput> 
    <tr> 
      <td height="23"></td>
      <td colspan="4" align="right"><cfoutput> 
          <input name="submit" type="submit" value="  #button#  ">
        </cfoutput></td>
    </tr>
  </table>
</cfform>
<cfif lcase(HcomID) eq "tmt_i" or lcase(HcomID) eq "taff_i" or lcase(HcomID) eq "taftc_i">
<center><font color="#FF0000">* Description : <cfoutput>#getgeneral.layer#</cfoutput> Name @ Location @ Duration (dd - dd/mm/yyyy) @ time @ Speaker</font></center>
</cfif>
</body>
</html>
