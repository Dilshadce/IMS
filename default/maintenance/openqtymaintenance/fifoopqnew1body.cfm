
<cfset location = URLDecode(url.location)>
<cfset itemno = URLDecode(url.itemno)>

<cfif trim(location) eq "">

<cfquery name="checkexist" datasource="#dts#">
	select itemno from fifoopq where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" />
</cfquery>

<cfif checkexist.recordcount eq 0>
<cfquery name="insertfifoopq" datasource="#dts#">
	insert into fifoopq (itemno) values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" />)
</cfquery>

</cfif>

<cfquery name="getfifoopq" datasource="#dts#">
	select * from fifoopq where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" />
</cfquery>
<cfelse>

<cfquery name="checkexist" datasource="#dts#">
	select itemno from fifoopqlocation where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" />
	and location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#location#" />
</cfquery>

<cfif checkexist.recordcount eq 0>
<cfquery name="insertfifoopq" datasource="#dts#">
	insert into fifoopqlocation (itemno,location) values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" />,<cfqueryparam cfsqltype="cf_sql_varchar" value="#location#" />)
</cfquery>

</cfif>


<cfquery name="getfifoopq" datasource="#dts#">
	select * from fifoopqlocation where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#" />
    and location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#location#" />
</cfquery>
</cfif>

<cfoutput>

<table border="0" class="data" align="center">
<tr>
<th>Location : </th>
<td>#location#</td>
</tr>
<tr>
<th><div align="left">No</div></th>
<th><div align="left">Quantity</div></th>
<th><div align="left">Unit Price</div></th>
<th><div align="left">Date</div></th>
</tr>
<cfloop from="50" to="11" index="i" step="-1">
<tr>
<td>Oldest #i#</td>
<td><input type="text" name="fifoqty" id="fifoqty" value="#evaluate('getfifoopq.ffq#i#')#" onBlur="updateqty('ffq#i#',this.value,'qty');" size="4"></td>
<td><input type="text" name="fifoprice" id="fifoprice" value="#evaluate('getfifoopq.ffc#i#')#" onBlur="updateqty('ffc#i#',this.value,'price');" size="4"></td>
<td><input type="text" name="fifodate" id="fifodate" value="#evaluate('dateformat(getfifoopq.ffd#i#,"dd/mm/yyyy")')#" size="10" onBlur="updateqty('ffd#i#',this.value,'date');">(DD/MM/YYYY)</td>

</tr>
</cfloop>
</table>
</cfoutput>
