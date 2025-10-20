<cfoutput>
<cfquery name="getcfsprofilelist" datasource="#dts#">
SELECT * FROM paybillprofile WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
</cfquery>

<cfquery name="getbankfileinfo" datasource="#dts#">
SELECT * FROM geninvbankfile WHERE paybillprofileid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
</cfquery>

<cfquery name="getcfsempprofilelist" datasource="#dts#">
SELECT * FROM cfsempinprofile WHERE profileid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
</cfquery>

<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/latest/css/maintenance/profile.css" />

<div class="container">
	<div class="page-header">
    	<h2>
            CFS Profile: #getcfsprofilelist.profilename#
      </h2>
    </div>
    <div class="container">
    	<h2>
        	CFS Employee Added
        </h2>
        <table class="table table-bordered table-hover" id="resultTable" style="table-layout:fixed">
            <tr>
                <th>Employee Name</th>
                <th>Bank Type</th> 
                <th>Action</th>               
            </tr> 
            <cfif getcfsempprofilelist.recordcount eq 0>
                <tr>
                    <td valign="top" colspan="3" class="dataTables_empty">No data available in table</td>                    
                </tr>
            <cfelse>
                <cfloop query="getcfsempprofilelist">                    
                    <cfquery name="getemplist" datasource="#dts#">
                    SELECT name,name2,banktype FROM cfsemp WHERE icno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getcfsempprofilelist.icno#">
                    </cfquery>
                    <cfquery name="getbankname" datasource="payroll_main">
                    SELECT bankcode,bankname FROM bankcode WHERE bankcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getemplist.banktype#">
                    </cfquery>
                  <tr>
                        <td>#getemplist.name# #getemplist.name2#</td>
                        <td>#getbankname.bankname#</td>
                        <td>
                        <span class="glyphicon glyphicon-remove btn btn-link" onclick="if(confirm('Are you sure you wish to delete this profile?')){window.open('/CFSpaybill/CFSEmployee2profileprocess.cfm?type=Delete&id=#getcfsempprofilelist.id#&profileid=#getcfsempprofilelist.profileid#','_self');}"></span>
                        </td>
                    </tr>
                </cfloop>
            </cfif>
            
        </table>
    </div>
    <div>
    	<cfquery name="getCFSEmplist2" datasource="#dts#">
        SELECT id,icno,name,name2 FROM cfsemp
        </cfquery>
    	<cfform action="/CFSpaybill/CFSEmployee2profileprocess.cfm?type=add&profileid=#url.id#" name="form">
    	  
    	<table>
        	<tr>
            	<td>
                	Choose CFS Employee to add
                    <br>
                </td>
            </tr>
            <tr>
                <td>
                	<cfselect name="getCFSEmplist2" id="getCFSEmplist2">
                        <option value="">Please select a Employee</option>
                        <cfloop query="getCFSEmplist2">
                            <option value="#getCFSEmplist2.icno#" >#getCFSEmplist2.name# #getCFSEmplist2.name2#</option>
                        </cfloop>                 
                    </cfselect>
                </td>
                <!---<td><input type="button" name="Scust1" value="Employee Search" onClick=""></td>--->
            </tr>
            <tr>
                <td>
                	<br>
                	<cfinput type="submit" name="Submit" value="Add Employee " validate="submitonce"/>
                    <a href="/CFSpaybill/listCFSprofile.cfm"><input type="button" id="donebtn" name="donebtn" value="Done"></a>
                </td>
            </tr>
        </table>
        </cfform>
    </div>
</div>


<!---<cfwindow center="true" width="580" height="400" name="findEmp" refreshOnShow="true"
        title="Find CFS Employee" initshow="false"
        source="/CFS/findEmp.cfm?type=Customer&dbtype=#dts#.arcust&custno={custno}" />--->
</cfoutput>
