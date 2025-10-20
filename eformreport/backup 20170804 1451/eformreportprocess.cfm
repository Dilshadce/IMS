<cfif isdefined('form.empno')>
<cfquery name="getlist" datasource="#dts#">
SELECT * FROM (SELECT * FROM (SELECT empno,requested_on FROM manpower_p.pbupdated order by requested_on desc) as a group by empno) as a
LEFT JOIN
(
select dbcandupdate,dbcandno,dbcandnames from ftcandidate
) as b
on a.empno = b.dbcandno
<cfif form.empno neq "">
WHERE empno = "#form.empno#"
</cfif>
order by a.requested_on
</cfquery>
<cfoutput>
<table border="1" cellpadding="5" align="center">
<tr>
<th>No.</th>
<th align="left">Employee No</th>
<th align="left">Name</th>
<th align="left">Eform Updated On</th>
<th align="left">PB Updated On</th>
</tr>
<cfloop query="getlist">
<tr>
<td>#getlist.currentrow#</td>
<td>
#getlist.empno#
</td>
<td>
#getlist.dbcandnames#
</td>
<td>
#dateformat(getlist.requested_on,'dd/mm/yyyy')# #timeformat(getlist.requested_on,'HH:MM:SS')#
</td>
<td><cfif getlist.dbcandupdate gt getlist.requested_on>#dateformat(getlist.dbcandupdate,'dd/mm/yyyy')# #timeformat(getlist.dbcandupdate,'HH:MM:SS')#</cfif></td>
</tr>
</cfloop>
</table>
</cfoutput>
</cfif>