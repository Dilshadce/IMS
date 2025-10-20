<cfset runningfr = "1"&form.runningnumfr>
<cfset runningto = "1"&form.runningnumto>
<cfif abs(runningfr - runningto) gt 10000>
<cfoutput>
The maximum limit of generate voucher is 10000 piece each time, limit exceed.
<br/>
</cfoutput>
<cfabort />
</cfif>

<cfset steploop = 1>

<cfif runningfr gt runningto>
<cfset steploop = -1>
</cfif>

<cfset type = form.type>
<cfset value = form.value>
<cfset custno = form.custno>
<cfset desp = form.desp>
<cfset batch = form.prefix&form.runningnumfr&form.endfix&"-"&form.prefix&form.runningnumto&form.endfix>


<cfset prefixlen = len(form.prefix)>
<cfset runningfrlen = len(form.runningnumfr)>
<cfset runningtolen = len(form.runningnumto)>
<cfset endfixlen = len(form.endfix)>


<cfquery name="checkvoucher" datasource="#dts#">
SELECT * FROM voucher where 0=0
<cfif prefixlen neq 0>
and left(voucherno,#prefixlen#) = "#form.prefix#" 
</cfif>
<cfif endfixlen neq 0>
and right(voucherno,#endfixlen#) = "#form.endfix#" 
</cfif>
and mid(voucherno,#prefixlen+1#,#runningfrlen#) between "#form.runningnumfr#" and "#form.runningnumto#"
</cfquery>

<cfif checkvoucher.recordcount neq 0>
<cfoutput>
Voucher number existed. Insert Failed.
<cfform action="createvoucher.cfm" method="post" name="recreate">
<input type="submit" value="Create another voucher" />&nbsp;&nbsp;&nbsp;<input type="button" value="close"  onclick="closenref();">
</cfform>
</cfoutput>
<cfabort />
</cfif>


<cfloop from="#runningfr#" to="#runningto#" step="#steploop#" index="i">
<cfset nolength = len(i) -1>
<cfset runno = right(i,nolength)>
<cfset vouchernum = form.prefix&runno&form.endfix>
<cfquery name="insertvoucher" datasource="#dts#">
insert into voucher (voucherno,type,value,desp,batch,created_by,created_on,custno)
values
('#vouchernum#','#type#','#value#','#desp#','#batch#','#HUserID#',now(),<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#">)
</cfquery>
</cfloop>

<cfoutput>
<cfform action="createvoucher.cfm" method="post" name="recreate">
<input type="submit" value="Create another voucher" />&nbsp;&nbsp;&nbsp;<input type="button" value="close"  onclick="closenref();">
</cfform>
</cfoutput>
