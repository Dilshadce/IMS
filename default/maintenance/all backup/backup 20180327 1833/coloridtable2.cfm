<html>
<head>
<title>Customer Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery datasource='#dts#' name="getgeneral">
	Select lmaterial as layer from gsetup
</cfquery>

<script language="JavaScript">

	function validate()
	{	<cfoutput>
		if(document.CustomerForm.colorid.value=='') <!--- QCH if(document.coloridtable2Form.colorid.value=='') --->
		{
			alert("Your #getgeneral.layer#'s No. cannot be blank.");
			document.CustomerForm.colorid.focus();
			return false;
		}
		</cfoutput>
		return true;
	}
	
</script>

<body>
			
		<cfoutput>
			<cfif #url.type# eq "Edit">
				<cfquery datasource='#dts#' name="getitem">
					Select * from iccolorid where colorid='#url.colorid#'
				</cfquery>
				<cfset colorid=#getitem.colorid#>
				<cfset desp=#getitem.desp#>
                <cfif left(dts,8) eq "manpower">
                <cfset term = getitem.term>
				</cfif>
                <cfif left(dts,6) eq "linsad">
                <cfset mainpaper = getitem.mainpaper>
				</cfif>
				
				<cfset mode="Edit">
				<cfset title="Edit Item">
				<cfset button="Edit">
						
				
			</cfif>
			<cfif #url.type# eq "Delete">
				<cfquery datasource='#dts#' name="getitem">
					Select * from iccolorid where colorid='#url.colorid#'
				</cfquery>
				<cfset colorid=#getitem.colorid#>
				<cfset desp=#getitem.desp#>
				<cfif left(dts,8) eq "manpower">
                <cfset term = getitem.term>
				</cfif>
                <cfif left(dts,6) eq "linsad">
                <cfset mainpaper = getitem.mainpaper>
				</cfif>
				<cfset mode="Delete">
				<cfset title="Delete Item">
				<cfset button="Delete">
						
				
			</cfif>
			
			
  <cfif #url.type# eq "Create">   
    
    			<cfset colorid="">
				<cfset desp="">
				<cfif left(dts,8) eq "manpower">
                <cfset term = "">
				</cfif>
                <cfif left(dts,6) eq "linsad">
                <cfset mainpaper = "">
				</cfif>
				<cfset mode="Create">
				<cfset title="Create Item">
				<cfset button="Create">
			
			</cfif>

			<h1>#title#</h1>
			
  <h4><cfif getpin2.h1810 eq 'T'><a href="coloridtable2.cfm?type=Create">Creating a #getgeneral.layer#</a> </cfif><cfif getpin2.h1820 eq 'T'>|| <a href="coloridtable.cfm?">List 
    all #getgeneral.layer#</a> </cfif><cfif getpin2.h1830 eq 'T'>|| <a href="s_coloridtable.cfm?type=iccolorid">Search For #getgeneral.layer#</a></cfif>
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_coloride.cfm">#getgeneral.layer# Listing </a></cfif></h4>
</cfoutput>

<cfform name="CustomerForm" action="coloridprocess.cfm" method="post" onsubmit="return validate()">
	<cfoutput><input type="hidden" name="mode" value="#mode#">
					
	
  <h1 align="center">#getgeneral.layer# Maintenance</h1></cfoutput>
  	
  <table align="center" class="data" width="450">
    <cfoutput> 
      <tr> 
        <td width="80" nowrap>#getgeneral.layer# :</td>
        <td width="370"> <cfif mode eq "Delete" or mode eq "Edit">
            <!--- <h2>#url.colorid#</h2> --->
            <input type="text" size="40" name="colorid" value="#url.colorid#" readonly>
            <cfelse>
            <input type="text" size="40" name="colorid" value="#colorid#" maxlength="40">
          </cfif> </td>
      </tr>
      <tr> 
        <td>Description :</td>
        <td><input type="text" size="40" name="desp" value="#desp#" maxlength="40"></td>
      </tr>
      <cfif left(dts,6) eq "linsad">
      <tr>
      <td>Belong To:</td>
	  <td>
      <cfquery name="getlist" datasource="#dts#">
      select cate from iccate ORDER BY cate
      </cfquery>
      <select name="mainpaper" id="mainpaper">
      <cfloop query="getlist">
      <option value="#getlist.cate#" <cfif mainpaper eq getlist.cate>Selected</cfif>>#getlist.cate#</option>
      </cfloop>
      </select>
      </td>
      </tr>
      </cfif>
      <cfif left(dts,8) eq "manpower">
      <tr>
      <td>Terms</td>
      <td>
      <textarea name="term" id="term" cols="100" rows="10">#term#</textarea>
      </td>
      </tr>
	  </cfif>
      <tr> 
        <td></td>
        <td>&nbsp;</td>
      </tr>
    </cfoutput> <!--- QCH <CFOUTPUT> </CFOUTPUT> <CFOUTPUT> </CFOUTPUT> <CFOUTPUT> </CFOUTPUT> 
    <CFOUTPUT> </CFOUTPUT> <cfoutput> </cfoutput> <cfoutput> </cfoutput> <cfoutput> 
    </cfoutput> <cfoutput> </cfoutput> <cfoutput> </cfoutput> ---> 
	<cfoutput> 
      <tr> 
        <td></td>
        <td align="right"><cfoutput> 
            <input name="submit" type="submit" value="  #button#  ">
          </cfoutput></td>
      </tr>
    </cfoutput> 
  </table>
</cfform>
			
</body>
</html>
