<cfoutput>

<cfquery name="getCFSEmpProfile" datasource="#dts#">
SELECT * FROM cfsempinprofile 
WHERE profileid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">
</cfquery>

<cfquery name="getprofilelist" datasource="#dts#">
SELECT profilename FROM paybillprofile
WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">
</cfquery>

<cfquery name="getemplist" datasource="#dts#">
SELECT icno,name,name2 FROM cfsemp
WHERE icno IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#valuelist(getCFSEmpProfile.icno)#">)
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

<cfform action="/CFSpaybill/generateInvoiceBankfileprocess.cfm?profileid=#url.profileid#" name="form">
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
    <cfif getemplist.recordcount eq 0> 
    	<tr>
            <td valign="top" colspan="3" class="dataTables_empty">No data available in table</td>                    
        </tr>
    <cfelse>
    <tr>
    	<td>
        </td>
        <td>
        </td>
        <td style="text-align:center">
            <cfif getemplist.recordcount eq 0><cfelse><cfinput  type="submit" name="Submit" value="Generate" validate="submitonce"/></cfif>
        </td>
      </tr>
      </cfif>
</table>
</cfform>

</cfoutput>