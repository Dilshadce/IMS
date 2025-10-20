<cfoutput>
<h1>Changes of Bank Information</h1>
<cfinclude template="/object/dateobject.cfm">
<cfquery name="getdetail" datasource="#replace(dts,'_i','_p')#">
SELECT * FROM (
SELECT * FROM bankaccnoat WHERE updated_on between "#dateformatnew(form.datefrom,'yyyy-mm-dd')# 00:00:00" and "#dateformatnew(form.dateto,'yyyy-mm-dd')# 23:59:59" ) as a
LEFT JOIN
(SELECT name,created_on,created_by,empno as emp FROM pmast ) as b
on a.empno = b.emp
ORDER BY a.updated_on
</cfquery>

<table border="1">
<tr>
<th align="left">Employee No</th>
<th align="left">Name</th>
<th align="left">Old Bank Code</th>
<th align="left">Old Branch Code</th>
<th align="left">Old Bank Accno</th>
<th align="left">New Bank Code</th>
<th align="left">New Branch Code</th>
<th align="left">New Bank Accno</th>
<th align="left">Created On</th>
<th align="left">Created By</th>
<th align="left">Updated On</th>
<th align="left">Updated By</th>
</tr>
<cfloop query="getdetail">
<tr>
<td>#getdetail.empno#</td>
<td>#getdetail.name#</td>
<td>#getdetail.oldbankcode#</td>
<td>#getdetail.oldbrancode#</td>
<td>#getdetail.oldbankaccno#</td>
<td>#getdetail.newbankcode#</td>
<td>#getdetail.newbrancode#</td>
<td>#getdetail.newbankaccno#</td>
<td>#dateformat(getdetail.created_on,'dd/mm/yyyy')# #timeformat(getdetail.created_on,'HH:MM:SS')#</td>
<td>#getdetail.created_by#</td>
<td>#dateformat(getdetail.updated_on,'dd/mm/yyyy')# #timeformat(getdetail.updated_on,'HH:MM:SS')#</td>
<td>#getdetail.updated_by#</td>
</tr>
</cfloop>
</table>
</cfoutput>