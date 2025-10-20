<cfsetting showdebugoutput="no">
<cfset datefrom=url.datefrom>
<cfset dateto = url.dateto>
<cfset sofrom = url.sofrom>
<cfset soto = url.soto>
<cfinvoke component="cfc.Date" method="getDbDate" inputDate="#datefrom#" returnvariable="datefromnew" />
<cfinvoke component="cfc.Date" method="getDbDate" inputDate="#dateto#" returnvariable="datetonew" />
<cfquery name="getso" datasource="#dts#">
SELECT refno,wos_date,custno,FREM0,created_by from artran where type = "#url.tran#" and printed <> "Y" and wos_date >= "#datefromnew#" and wos_date <= "#datetonew#" 
<cfif url.sofrom neq "">
and refno >= "#url.sofrom#"
</cfif>
<cfif url.soto neq "">
and refno <= "#url.soto#"
</cfif>
 order by refno limit 1000
</cfquery>
<cfquery name="getformat" datasource="#dts#">
				select * from customized_format
				where type='#url.tran#'
				order by counter
			</cfquery>
<cfoutput>
<form action="/billformat/#dts#/preprintedformat.cfm?tran=#url.tran#&BillName=#getformat.file_name#&doption=#getformat.d_option#" method="post" id="packinglist" name="packinglist">
</cfoutput><cfoutput>
<table width="800">
<tr>
<th>#url.tran# NO</th>
<th>DATE</th>
<th>CUSTOMER NAME</th>
<th>USER</th>
<th>ACTION&nbsp;&nbsp;<input type="checkbox" name="checkall" id="checkall" onClick="checkalllist(document.packinglist.sono)" value="uncheckall" checked="checked" ></th>
</tr>

<cfloop query="getso">
<tr>
<td>#getso.refno#</td>
<td>#dateformat(getso.wos_date,'yyyy-mm-dd')#</td>
<td>#getso.custno#-#getso.FREM0#</td>
<td>#getso.created_by#</td>
<td>PRINT <input type="checkbox" name="sono" value="#getso.refno#" checked ></td>
</tr>
</cfloop>
</cfoutput>
</table>
<input type="submit" name="submit" value="PRINT" /> 
</form>