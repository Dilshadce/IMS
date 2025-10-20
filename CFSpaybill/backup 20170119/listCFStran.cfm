<cfquery name="getcfstrans" datasource="#dts#">
SELECT * FROM geninvbankfile
</cfquery>


<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/latest/css/maintenance/profile.css" />
<cfoutput>
<div class="container">
	<div class="page-header">
    	<h2>
            CFS Transactions List
            
        </h2>
    </div>
    <div class="container">
    <table class="table table-bordered table-hover" id="resultTable" style="table-layout:fixed;">
        <tr>
            <th>CFS No.</th>
            <th>Date</th>
            <th>Employee Name</th>
            <th>Employee IC</th>
            <th>Action</th>
        </tr>        
        <cfif getcfstrans.recordcount eq 0>
            <tr>
                <td valign="top" colspan="100%" class="dataTables_empty">No data available in table</td>                    
            </tr>
        <cfelse>
        	<cfloop query="getcfstrans">
                <tr>
                    <td>#getcfstrans.id#</td>
                    <td>#dateformat(getcfstrans.wos_date,'yyyy-mm-dd')#</td>
                    <cfquery name="getempdetail" datasource="#dts#">
                    SELECT name,name2 FROM cfsemp WHERE icno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcfstrans.icno#">
                    </cfquery>
                    <td>#getempdetail.name# #getempdetail.name2#</td>
                    <td>#getcfstrans.icno#</td>
                    <td>
                    <span class="glyphicon glyphicon-pencil btn btn-link" onclick="window.open('/CFSpaybill/editCFSprofile.cfm?type=Edit&id=#getcfstrans.id#','_self');"></span>
                    <span class="glyphicon glyphicon-remove btn btn-link" onclick="if(confirm('Are you sure you wish to delete this profile?')){window.open('/CFSpaybill/generateInvoiceBankfileprocess.cfm?type=Delete&id=#getcfstrans.id#','_self');}"></span>
                    </td>
                </tr>
            </cfloop>
        </cfif>
    </table>
</div>
</cfoutput>