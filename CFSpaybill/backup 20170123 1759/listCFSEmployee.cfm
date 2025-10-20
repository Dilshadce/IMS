<cfquery name="getCFSlist" datasource="#dts#">
SELECT * FROM cfsemp
</cfquery>


<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/latest/css/maintenance/profile.css" />

<cfoutput>
<div class="container">
	<div class="page-header">
    	<h2>
            CFS Employee List
            <div class="pull-right">
                            
                <button type="button" class="btn btn-default" onclick="window.open('/CFSpaybill/createCFS.cfm?type=create','_self');">
                    <span class="glyphicon glyphicon-plus"></span> Add CFS Employee
                </button>
                
            </div>
        </h2>
    </div>
    <div class="container">
        <table class="table table-bordered table-hover" id="resultTable" style="table-layout:fixed">
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
            
            <cfif getCFSlist.recordcount eq 0>
                <tr>
                    <td valign="top" colspan="10" class="dataTables_empty">No data available in table</td>                    
                </tr>
            <cfelse>
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
                        <td>
                        <span class="glyphicon glyphicon-pencil btn btn-link" onclick="window.open('/CFSpaybill/editCFS.cfm?type=Edit&id=#getCFSlist.id#','_self');"></span>
                        <span class="glyphicon glyphicon-remove btn btn-link" onclick="if(confirm('Are you sure you wish to delete this profile?')){window.open('/CFSpaybill/cfsprocess.cfm?type=Delete&id=#getCFSlist.id#&icno=#getCFSlist.icno#','_self');}"></span>
                        </td>
                    </tr>
                </cfloop>
            </cfif>
        </table>
    </div>
    
</div>
</cfoutput>