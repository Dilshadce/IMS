<cfquery name="getcfsprofilelist" datasource="#dts#">
SELECT * FROM paybillprofile
</cfquery>

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
            CFS Profile List
            <div class="pull-right">
                            
                <button type="button" class="btn btn-default" onclick="window.open('/CFSpaybill/createCFSpaybillProfile.cfm?action=create','_self');">
                    <span class="glyphicon glyphicon-plus"></span> Add CFS Profile
                </button>
                
            </div>
        </h2>
    </div>
    <div class="container">
    <table class="table table-bordered table-hover" id="resultTable" style="table-layout:fixed">
        <tr>
            <th>Profile Name</th>
            <th>Customer</th>
            <th>Pay Rate</th>
            <th>Bill Rate</th>
            <th>Administration Fee</th>
            <th>Action</th>
        </tr>        
        <cfif getcfsprofilelist.recordcount eq 0>
            <tr>
                <td valign="top" colspan="6" class="dataTables_empty">No data available in table</td>                    
            </tr>
        <cfelse>
        	<cfloop query="getcfsprofilelist">
                <tr>
                    <td>#getcfsprofilelist.profilename#</td>
                    <cfquery name="getcustlist" datasource="#dts#">
                    SELECT * FROM arcust WHERE custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcfsprofilelist.custno#">
                    </cfquery>
                    <td>#getcfsprofilelist.custno# - #getcustlist.name#</td>
                    <td>#getcfsprofilelist.payrate#</td>
                    <td>#getcfsprofilelist.billrate#</td>
                    <td>#getcfsprofilelist.adminfee#</td>
                    <td>
                    <span class="glyphicon glyphicon-plus" onclick="window.open('/CFSpaybill/addCFSEmployee2profile.cfm?id=#getcfsprofilelist.id#','_self');"></span>
                    <span class="glyphicon glyphicon-pencil btn btn-link" onclick="window.open('/CFSpaybill/editCFSprofile.cfm?type=Edit&id=#getcfsprofilelist.id#','_self');"></span>
                    <span class="glyphicon glyphicon-remove btn btn-link" onclick="if(confirm('Are you sure you wish to delete this profile?')){window.open('/CFSpaybill/editCFSprofile.cfm?type=Delete&id=#getcfsprofilelist.id#','_self');}"></span>
                    </td>
                </tr>
            </cfloop>
        </cfif>
    </table>
</div>
</cfoutput>