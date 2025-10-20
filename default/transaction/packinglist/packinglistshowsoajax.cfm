<cfsetting showdebugoutput="no">
<cfset datefrom=url.datefrom>
<cfset dateto = url.dateto>
<cfset reffrom = url.reffrom>
<cfset refto = url.refto>
<cfset reftype = url.reftype>
<cfinvoke component="cfc.Date" method="getDbDate" inputDate="#datefrom#" returnvariable="datefromnew" />
<cfinvoke component="cfc.Date" method="getDbDate" inputDate="#dateto#" returnvariable="datetonew" />
<cfoutput>
<cfquery name="getso" datasource="#dts#">
SELECT refno,wos_date,custno,FREM0,created_by from artran where type = "#reftype#" and PACKED <> "Y" and wos_date >= "#datefromnew#" and wos_date <= "#datetonew#" 
<cfif url.reffrom neq "">
and refno >= "#url.reffrom#"
</cfif>
<cfif url.refto neq "">
and refno <= "#url.refto#"
</cfif>
 order by refno limit 1000
</cfquery>
</cfoutput>
<form action="/default/transaction/packinglist/packlistprocess.cfm" method="post" id="packinglist" name="packinglist" onsubmit="document.getElementById('packno').value = document.getElementById('packno1').value">
<cfoutput>
<input type="hidden" name="packno" id="packno" />
<input type="hidden" name="reftype" id="reftype" value="#reftype#" />
</cfoutput>
<table width="800">
<tr>
<th>REF NO</th>
<th>DATE</th>
<th>CUSTOMER NAME</th>
<th>USER</th>
<th>ACTION&nbsp;&nbsp;<input type="checkbox" name="checkall" id="checkall" onClick="checkalllist(document.packinglist.sono)" value="uncheckall" checked="checked" ></th>
</tr>
<cfoutput>
<cfloop query="getso">
<tr>
<td>#getso.refno#</td>
<td>#dateformat(getso.wos_date,'yyyy-mm-dd')#</td>
<td>#getso.custno#-#getso.FREM0#</td>
<td>#getso.created_by#</td>
<td>PACK <input type="checkbox" name="sono" value="#getso.refno#" checked ></td>
</tr>
</cfloop>
</cfoutput>
</table>
<input type="submit" name="submit" value="PACK" /> 
</form>