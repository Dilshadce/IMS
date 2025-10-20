<cfquery name="getcfsprofilelist" datasource="#dts#">
SELECT * FROM paybillprofile
</cfquery>

<cfquery name="getCFSlist" datasource="#dts#">
SELECT * FROM cfsemp 
</cfquery>

<cfquery name="getcustlist" datasource="#dts#">
SELECT * FROM arcust 
</cfquery>

<h1>CFS Profile List</h1>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfoutput>
<table>
	<tr>
    	<th>Name</th>
        <th>Customer</th>
        <th>Employee</th>
        <th>Pay Rate</th>
        <th>Bill Rate</th>
        <th>Administration Fee</th>
        <th>Action</th>
    </tr>
    <cfloop query="getcfsprofilelist">
    	<tr>
        	<td>#getcfsprofilelist.profilename#</td>
            <td>#getcfsprofilelist.custno# #getcustlist.name#</td>
            <cfquery name="getempinfo" datasource="#dts#">
            SELECT name,name2 FROM cfsemp WHERE <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcfsprofilelist.icno#">
            </cfquery>
            <td>#getempinfo.name# #getempinfo.name2#</td>
            <td>#getcfsprofilelist.payrate#</td>
            <td>#getcfsprofilelist.billrate#</td>
            <td>#getcfsprofilelist.adminfee#</td>
            <td><a href="/CFSpaybill/editCFSprofile.cfm?type=Edit&id=#getcfsprofilelist.id#"><input type="button" id="editbtn" name="editbtn" value="Edit"></a>&nbsp;&nbsp;
            <a href="/CFSpaybill/editCFSprofile.cfm?type=Delete&id=#getcfsprofilelist.id#"><input type="button" id="deletebtn" name="deletebtn" value="Delete"></a></td>
        </tr>
    </cfloop>
</table>
</cfoutput>