<cfquery name="getCFSlist" datasource="#dts#">
SELECT * FROM cfsemp
</cfquery>


<h1>CFS Employee List</h1>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfoutput>
<table>
	<tr>
    	<th>Name</th>
        <th>IC No.</th>
        <th>Address</th>
        <th>Phone</th>
        <th>Bank IC No.</th>
        <th>Bank Person Name</th>
        <th>Bank Company Reg No.</th>
        <th>Bank Type</th>
        <th>Bank Account Number</th>
        <th>Action</th>
    </tr>
    <cfloop query="getCFSlist">
    	<tr>
        	<td>#getCFSlist.name# #getCFSlist.name2#</td>
            <td>#getCFSlist.icno#</td>
            <td>#getCFSlist.add1#<br>#getCFSlist.add2#<br>#getCFSlist.add3#</td>
            <td>#getCFSlist.phone#</td>
            <td>#getCFSlist.bankicno#</td>
            <td>#getCFSlist.bankpersonname#</td>
            <td>#getCFSlist.bankcompregno#</td>
            <cfquery name="getbankname" datasource="#dts#">
            SELECT bankcode,bankname FROM payroll_main.bankcode 
            WHERE bankcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getCFSlist.banktype#">
            </cfquery>
            <td>#getbankname.bankname#</td>
            <td>#getCFSlist.bankaccno#</td>
            <td><cfif getCFSlist.recordcount eq 0><a href="/CFSpaybill/create.cfm"><input type="button" id="createbtn" name="createbtn" value="Create User"></a><cfelse><a href="/CFSpaybill/editCFS.cfm?type=Edit&id=#getCFSlist.id#"><input type="button" id="editbtn" name="editbtn" value="Edit"></a>
            <a href="/CFSpaybill/editCFS.cfm?type=Delete&id=#getCFSlist.id#"><input type="button" id="deletebtn" name="deletebtn" value="Delete"></a></cfif></td>
        </tr>
    </cfloop>
</table>
</cfoutput>