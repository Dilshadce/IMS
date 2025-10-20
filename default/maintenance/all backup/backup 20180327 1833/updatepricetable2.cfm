<html>
<head>
<title>Update Price & Foreign Price Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
			
		<cfoutput>
			<h1>Update Price & Foreign Price</h1>
			
  <h4>
	<cfif getpin2.h1310 eq 'T'>
		<a href="icitem2.cfm?type=Create">Creating a New Item</a> 
	</cfif>
	<cfif getpin2.h1320 eq 'T'>
		|| <a href="icitem.cfm?type=icitem">List all Item</a> 
	</cfif>
	<cfif getpin2.h1330 eq 'T'>
		|| <a href="s_icitem.cfm?type=icitem">Search For Item</a> 
	</cfif>
	<cfif getpin2.h1340 eq 'T'>
		|| <a href="p_icitem.cfm">Item Listing</a> 
	</cfif>
	|| <a href="icitem_setting.cfm">More Setting</a>
	<cfif getpin2.h1350 eq 'T'>|| <a href="printbarcode_filter.cfm">Print Barcode</a></cfif>
    <cfif getpin2.h1311 eq 'T' and getpin2.h13D0 eq 'T'>
		||<a href="edititemexpress.cfm">Edit Item Express</a> 
	</cfif>
    <cfif getpin2.h1311 eq 'T'>
    <cfquery name="checkitemnum" datasource="#dts#">
    select itemno from icitem
    </cfquery>
    <cfif checkitemnum.recordcount lt 400>
    ||<a href="edititemexpress2.cfm">Edit Item Express 2</a> 
    </cfif>
    </cfif>
    <cfif getpin2.h1310 eq 'T'>
    <cfif lcase(HcomID) eq "vsolutionspteltd_i">
    ||<a href="updatepricetable2.cfm">Update Price & Foreign Price</a> 
    </cfif>
    </cfif>
</h4>
</cfoutput>

<cfquery name="getgroup" datasource="#dts#">
select * from icgroup order by wos_group
</cfquery>

<cfform name="CustomerForm" action="updatepriceprocess.cfm" method="post">
	<cfoutput><input type="hidden" name="mode" value="Update">
					
	
  <h1 align="center">Update Price & Foreign Price</h1></cfoutput>
  	
  <table align="center" class="data" width="450">
    <cfoutput> 
    <tr>
    <td colspan="100%"><input type="radio" name="radio1" id="radio1" value="preview" checked>Preview Price Changes<br>
        <input type="radio" name="radio1" id="radio1" value="update">Update Price</td>
    </tr>
      <tr> 
        <td width="20%" nowrap>Group :</td>
        <td><select name="itemgroup">
        <option value="">Choose a group</option>
        <cfloop query="getgroup">
        <option value="#getgroup.wos_group#">#getgroup.wos_group# - #getgroup.desp#</option>
        </cfloop>
        </select>
        </td>
      </tr>
      <tr> 
        <td>Foreign Price to Local Price Rate :</td>
        <td><cfinput type="text" size="40" name="sellingrate" value="1" maxlength="40" validate="float"></td>
      </tr>
      <!---
      <tr> 
        <td>Foreign Rate :</td>
        <td><cfinput type="text" size="40" name="foreignrate" value="1" maxlength="40" validate="float"></td>
      </tr>--->
      <tr> 
        <td></td>
        <td>&nbsp;</td>
      </tr>
    </cfoutput>
	<cfoutput> 
      <tr> 
        <td></td>
        <td align="right"><cfoutput> 
            <input name="submit" type="submit" value="  Update  ">
          </cfoutput></td>
      </tr>
    </cfoutput> 
  </table>

</cfform>
			
</body>
</html>
