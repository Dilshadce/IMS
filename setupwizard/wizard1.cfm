<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/stylesheet/jquery-ui.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/scripts/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/scripts/jquery-ui.js"></script>
<script>

  $( document ).tooltip({ position: { my: "left top", at: "left bottom" } });

</script>
<cfquery name="getgsetup" datasource="#dts#">
SELECT * from gsetup
</cfquery>

<cfquery name="getCurrency" datasource="#dts#">
	select * from #target_currency#
	order by CurrCode 
</cfquery>

<cfoutput>
<cfform name="wizard1form" id="wizard1form" method="post" action="wizard2.cfm?type=w2">
<cfinclude template="header_wizard.cfm">
<br />
<br />
<h1 align="center">Company Profile</h1>   
<table width="800" height="500" border="0" cellpadding="3" cellspacing="1"  align="center" style="border: 1px solid black ;">

		<tr>
        <td><div align="left"><strong>Company Name</strong></div></td><td><cfinput name="compro" id="compro" type="text" value="#getgsetup.compro#" size="80" maxlength="80" required="yes" message="Error in field 'COMPANY NAME'. This field must be filled." onchange="javascript:this.value=this.value.toUpperCase();">
        <br />&nbsp;Name as it should appear in Netiquette</td>
    	</tr>
    	<tr>
        <td colspan="100%"><div align="left"><strong>Company Address</strong></div></td>
    </tr>
    <tr>
        <td><div align="left"><cfloop from="1" to="5" index="i">&nbsp;</cfloop>Street Address</div></td><td><cfinput name="compro2" id="compro2" type="text" value="#getgsetup.compro2#" size="80" maxlength="80" onchange="javascript:this.value=this.value.toUpperCase();"></td>
    </tr>
    <tr>
        <td><div align="left"><cfloop from="1" to="5" index="i">&nbsp;</cfloop>or PO Box</div></td><td><cfinput name="compro3" id="compro3" type="text" value="#getgsetup.compro3#" size="80" maxlength="80" onchange="javascript:this.value=this.value.toUpperCase();"></td>
    </tr>
    <tr>
        <td><div align="left"><cfloop from="1" to="5" index="i">&nbsp;</cfloop>Town / City</div></td><td><cfinput name="compro4" id="compro4" type="text" value="#getgsetup.compro4#" size="80" maxlength="80" onchange="javascript:this.value=this.value.toUpperCase();"></td>
    </tr>
    <tr>
        <td><div align="left"><cfloop from="1" to="5" index="i">&nbsp;</cfloop>State / Region</div></td><td><cfinput name="compro5" id="compro5" type="text" value="#getgsetup.compro5#" size="80" maxlength="80" onchange="javascript:this.value=this.value.toUpperCase();"></td>
    </tr>
    <tr>
        <td><div align="left"><cfloop from="1" to="5" index="i">&nbsp;</cfloop>Postal / Zip Code</div></td><td><cfinput name="compro6" id="compro6" type="text" value="#getgsetup.compro6#" size="80" maxlength="80" onchange="javascript:this.value=this.value.toUpperCase();"></td>
    </tr>
    <tr>
        <td><div align="left"><cfloop from="1" to="5" index="i">&nbsp;</cfloop>Country</div></td><td><cfinput name="compro7" id="compro7" type="text" value="#getgsetup.compro7#" size="80" maxlength="80" onchange="javascript:this.value=this.value.toUpperCase();"></td>
    </tr>
    	<tr> 
      		<td colspan="2">
				<div align="left"><strong>Company UEN</strong></div>
			</td>
    	</tr>
        <tr>
        <td><div align="left"><cfloop from="1" to="5" index="i">&nbsp;</cfloop></div></td><td><cfinput name="comuen" id="comuen" type="text" value="#getgsetup.comuen#" size="80" maxlength="80" onchange="javascript:this.value=this.value.toUpperCase();" title="Unique Entity Number - identification number for all entities registered in Singapore"></td>
    	</tr>
    	<tr> 
      		<td colspan="2">
				<div align="left"><strong>GST Registration No.</strong></div>
			</td>
    	</tr>
        
        <tr>
        <td><div align="left"><cfloop from="1" to="5" index="i">&nbsp;</cfloop></div></td><td><cfinput name="gstno" id="gstno" type="text" value="#getgsetup.gstno#" size="80" maxlength="80" onchange="javascript:this.value=this.value.toUpperCase();" title="Identification number for GST registered company."></td>
    	</tr>
        <tr> 
		  	<td colspan="2">
				<div align="left"><strong>Financial Information</strong></div>
			</td>
		</tr>
		<tr> 
		  	<td width="250"><cfloop from="1" to="5" index="i">&nbsp;</cfloop>Last A/C Year Closing Date</td>
		  	<td width="250">
				<cfinput name="LastAccYear" type="text" value="#dateformat(getgsetup.lastaccyear, "dd/mm/yyyy")#" validate="eurodate" required="yes" message="Last Account Year Can Not Be Blank !" title="The last year closing of the completion of a listed company's financial results">
			</td>
		</tr>
		<tr> 
		  	<td><cfloop from="1" to="5" index="i">&nbsp;</cfloop>This A/C Year Closing Period</td>
		  	<td><cfinput name="Period" type="text" value="#getgsetup.period#" validate="integer" required="yes" message="The A/C Year Closing Period Be Blank !" title="The current time period between the completion of a listed company's financial results. One period is equivalent to one month."></td>
		</tr>
        <tr> 
      		<td width="250"><cfloop from="1" to="5" index="i">&nbsp;</cfloop>Currency Used</td>
      		<td width="250">
				<cfoutput>
				<select name="bcurr" id="bcurr">	
					<option value="">Choose a Currency Code</option>
					<cfloop query="getCurrency">
						<option value="#getCurrency.CurrCode#" <cfif getgsetup.bcurr eq getCurrency.CurrCode>selected</cfif>>#getCurrency.CurrCode# - #getCurrency.Currency1#</option>
					</cfloop>
					</select>
				</cfoutput>
			</td>
		</tr>
		<tr>
			<td colspan="2" nowrap="nowrap">&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">

					
				<input type="button" name="skip_btn" id="skip_btn" value="Skip Wizard Setup" onclick="window.location.href='skipwizard.cfm'" />		&nbsp;&nbsp;&nbsp;
				<input type="submit" name="sub_btn" id="sub_btn" value="Next" />
               
			</td>
		</tr>
</table>

</cfform>
</cfoutput>
