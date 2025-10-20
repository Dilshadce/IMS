<cfoutput>
<cfinclude template="/object/dateobject.cfm">
<h3>Employee Portal Login History</h3>
<cfquery name="getlist" datasource="#replace(dts,'_i','_p')#">
SELECT * FROM (
SELECT * FROM emp_users_log
WHERE logdt between "#dateformatnew(form.datefrom,'yyyy-mm-dd')# 00:00:00" and "#dateformatnew(form.dateto,'yyyy-mm-dd')# 11:59:59"
 ORDER BY logdt desc
 limit 300) as a
 LEFT JOIN
 (SELECT empno,username FROM emp_users) as aa
 on a.user_id = aa.username
 LEFT JOIN
 (
 SELECT * FROM (SELECT empno,empname,custname FROM #dts#.placement ORDER BY startdate desc) as bb GROUP BY bb.empno
 ) as b
 on aa.empno = b.empno
</cfquery>
<table>
<tr>
<th>User ID</th>
<th>Ip Address</th>
<th>Name</th>
<th>Customer</th>
<th>Log in Date Time</th>
</tr>
<cfloop query="getlist">
<tr>
<td>#getlist.user_id#</td>
<td>#getlist.log_ip#</td>
<td>#getlist.empname#</td>
<td>#getlist.custname#</td>
<td>#dateformat(getlist.logdt,'dd/mm/yyyy')# #timeformat(getlist.logdt,'HH:MM:SS')#</td>
</tr>
</cfloop>
</table>


<h3>Employee Timesheet Transactions</h3>

<cfquery name="gettimesheet" datasource="#replace(dts,'_i','_p')#">
SELECT * FROM (
SELECT empno,tmonth FROM timesheet GROUP BY empno,tmonth ORDER BY id desc limit 200) as a
 LEFT JOIN
 (
 SELECT * FROM (SELECT empno,empname,custname FROM #dts#.placement ORDER BY startdate desc) as bb GROUP BY bb.empno
 ) as b
 on a.empno = b.empno
</cfquery>
<table>
<tr>
<th>Month</th>
<th>Employee</th>
<th>Name</th>
<th>Customer</th>
</tr>
<cfloop query="gettimesheet">
<tr>
<td>#gettimesheet.tmonth#</td>
<td>#gettimesheet.empno#</td>
<td>#gettimesheet.empname#</td>
<td>#gettimesheet.custname#</td>
</tr>
</cfloop>
</table>
</cfoutput>