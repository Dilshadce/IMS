<cfsetting showdebugoutput="no">
<cfset datefrom=url.datefrom>
<cfset dateto = url.dateto>
<cfif isdefined('url.sofrom')>
<cfset sofrom = url.sofrom>
</cfif>
<cfif isdefined('url.soto')>
<cfset soto = url.soto>
</cfif>
<cfinvoke component="cfc.Date" method="getDbDate" inputDate="#datefrom#" returnvariable="datefromnew" />
<cfinvoke component="cfc.Date" method="getDbDate" inputDate="#dateto#" returnvariable="datetonew" />
<cfquery name="selectsodropdown" datasource="#dts#">
SELECT refno from artran where type = "#url.tran#" and printed <> "Y" and wos_date >= "#datefromnew#" and wos_date <= "#datetonew#" order by refno limit 1000
</cfquery>
<cfoutput>
<table >
<tr>
<th>#url.tran# From</th><td>:</td><td>
<select id="SOfrom" name="SOfrom" >
<option value="">SELECT #url.tran# NUMBER</option>
<cfloop query="selectsodropdown">
<option value="#selectsodropdown.refno#" 
<cfif isdefined('url.sofrom')>
<cfif selectsodropdown.refno eq url.sofrom> 
selected="selected"
</cfif>
</cfif>>#selectsodropdown.refno#</option>
</cfloop>
</select></td> 
<td>&nbsp;

</td>
<th>#url.tran# To</th>
<td>:</td>
<td>
<select id="Soto" name="Soto" >
<option value="">SELECT #url.tran# NUMBER</option>
<cfloop query="selectsodropdown">
<option value="#selectsodropdown.refno#" 
<cfif isdefined('url.sofrom')>
<cfif selectsodropdown.refno eq url.sofrom> 
selected="selected"
</cfif>
</cfif>>#selectsodropdown.refno#</option>
</cfloop>
</select></td>
<td>&nbsp;</td>
<td><input type="button" name="Go" id="Go" value="GO" onClick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField2'),'printUnprintShowSoAjax.cfm?datefrom='+document.getElementById('datefrom').value+'&dateto='+document.getElementById('dateto').value+'&sofrom='+document.getElementById('SOfrom').value+'&soto='+document.getElementById('Soto').value+'&tran=#url.Tran#');" ></td>
</tr>
</table>

</cfoutput>

