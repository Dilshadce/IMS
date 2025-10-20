<cfoutput>

<cfquery name="getprofilelist" datasource="#dts#">
SELECT icno FROM paybillprofile
WHERE profilename = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profilename#">
</cfquery>

<cfquery name="getemplist" datasource="#dts#">
SELECT * FROM cfsemp
WHERE icno IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#valuelist(getprofilelist.icno)#">)
</cfquery>



<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<style>
table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 60%;
}

td, th {
    border: 1px solid ##dddddd;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: ##dddddd;
}
</style>

<cfform action="/CFSpaybill/generateInvoiceBankfileprocess.cfm?profilename=#url.profilename#" name="form">
<table>
	<tr>
        <th>Name</th>
        <th>IC No.</th>
        <th>Total Work Days</th>
    </tr>
	<cfloop query="getemplist">
    <tr>
        <td>#getemplist.name# #getemplist.name2#</td>
        <td>#getemplist.icno#</td>
        <td>
        	<cfinput type="text" id="workdays#getemplist.icno#"  name="workdays#getemplist.icno#" value="0">
            
        </td>
    </tr>
    </cfloop>
    <tr>
    	<td>
        </td>
        <td>
        </td>
        <td style="text-align:center">
            <cfif getemplist.recordcount eq 0><cfelse><cfinput  type="submit" name="Submit" value="Generate" validate="submitonce"/></cfif>
        </td>
      </tr>
</table>
</cfform>

</cfoutput>