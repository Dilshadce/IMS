<cfsetting showdebugoutput="no">
<cfset datefrom=url.datefrom>
<cfset dateto = url.dateto>
<cfset reftype = url.reftype>
<cfif isdefined('url.reffrom')>
<cfset reffrom = url.reffrom>
</cfif>
<cfif isdefined('url.refto')>
<cfset refto = url.refto>
</cfif>
<cfinvoke component="cfc.Date" method="getDbDate" inputDate="#datefrom#" returnvariable="datefromnew" />
<cfinvoke component="cfc.Date" method="getDbDate" inputDate="#dateto#" returnvariable="datetonew" />
<cfoutput>
<cfquery name="selectsodropdown" datasource="#dts#">
SELECT refno from artran where type = "#reftype#" and PACKED <> "Y" and wos_date >= "#datefromnew#" and wos_date <= "#datetonew#" order by refno limit 1000
</cfquery>
</cfoutput>
<cfoutput>
<table >
<tr>
<th>SO From</th><td>:</td><td>
<select id="reffrom" name="reffrom" >
<option value="">SELECT #reftype# NUMBER</option>
<cfloop query="selectsodropdown">
<option value="#selectsodropdown.refno#" 
<cfif isdefined('url.reffrom')>
<cfif selectsodropdown.refno eq url.reffrom> 
selected="selected"
</cfif>
</cfif>>#selectsodropdown.refno#</option>
</cfloop>
</select></td> 
<td>&nbsp;
<input type='hidden' id="reftype" name="reftype" value="#reftype#" />
</td>
<th>SO To</th>
<td>:</td>
<td>
<select id="refto" name="refto" >
<option value="">SELECT #reftype# NUMBER</option>
<cfloop query="selectsodropdown">
<option value="#selectsodropdown.refno#" 
<cfif isdefined('url.reffrom')>
<cfif selectsodropdown.refno eq url.reffrom> 
selected="selected"
</cfif>
</cfif>>#selectsodropdown.refno#</option>
</cfloop>
</select></td>
<td>&nbsp;</td>
<td><input type="button" name="Go" id="Go" value="GO" onClick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxField2'),'packinglistshowsoajax.cfm?datefrom='+document.getElementById('datefrom').value+'&dateto='+document.getElementById('dateto').value+'&reffrom='+document.getElementById('reffrom').value+'&refto='+document.getElementById('refto').value+'&reftype='+document.getElementById('reftype').value);" ></td>
</tr>
</table>

</cfoutput>

