<cfquery name="getarcust" datasource="#dts#">
SELECT custno,name FROM arcust
</cfquery>

<cfquery name="getCFSprofile" datasource="#dts#">
SELECT * FROM paybillprofile WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
</cfquery>

<cfquery name="getCFSEmplist" datasource="#dts#">
SELECT * FROM cfsemp
</cfquery>


<cfset custno = getCFSprofile.custno>
<cfset empno = getCFSprofile.empno>

<h1>Edit CFS Pay & Bill profile</h1>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<cfinclude template="/CFSpaybill/filter/filterCustomer.cfm">
<cfinclude template="/CFSpaybill/filter/filterContractor.cfm">
<script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
<link rel="stylesheet" href="/latest/css/select2/select2.css" />
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">
<script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
<script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="/CFSpaybill/css/cfspaybill.css">
<script type="text/javascript" src="/CFSpaybill/js/cfs.js"></script>
<script>
$(document).ready(function(e) {
	$('.input-group.date').datepicker({
		format: "dd/mm/yyyy",
		todayBtn: "linked",
		autoclose: true,
		todayHighlight: true
	});
});
</script>

<cfoutput>
<body>
	<!-- Modal -->
  <div class="modal fade" id="AlertModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Note</h4>
        </div>
        <div class="modal-body" id='Msg'>
          <p></p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
<cfform name="cfsform" action="/CFSpaybill/CFSpaybillProfileprocess.cfm?type=#url.type#&id=#url.id#">
    <table>
    	<tr>
        	<td>
        		<label>Profile Name</label>
            </td>
            <td>
            	<cfinput type="text" class="inputtext" id="profilename" name="profilename" value="#getCFSprofile.profilename#">
            </td>
        </tr>
    	<tr>
        	<td>
        		<label>Choose Client</label>
            </td>
            <td>
            	<!---<cfset default = getCFSprofile.custno>
            	<cfselect name="custprofile" id="custprofile">
                	<option value="">Please Select a Customer Profile</option>
                    <cfloop query="getarcust">
                        <option value="#getarcust.custno#" <cfif default eq getarcust.custno>Selected</cfif>>#getarcust.name#</option>
                    </cfloop>                 
                </cfselect>--->
                <input type="hidden" class="custprofile inputtext" name="custprofile" id="custprofile">
            </td>
        </tr>
        <tr>
        	<td>
        		<label>Choose Contractor</label>
            </td>
            <td>
                <input type="hidden" class="conprofile inputtext" name="empno" id="empno">
            </td>
        </tr>
         <tr>
        	<td>
        		<label>Pay Rate</label>
            </td>
            <td>
                <cfinput type="text" class="inputtext" id="payrate" name="payrate" value="#getCFSprofile.payrate#">
            </td>
        </tr>
        <tr>
        	<td>
        		<label>Bill Rate</label>
            </td>
            <td>
                <cfinput type="text" class="inputtext" id="billrate" name="billrate" value="#getCFSprofile.billrate#">
            </td>
        </tr>
        <tr>
        	<td>
        		<label>Rate Type</label>
            </td>
            <td>
                <select name="ratetype" id="ratetype" class="inputtext">
                	<option value="">Please choose a rate type</option>
                   	<option value="mth" <cfif getCFSprofile.ratetype eq "mth">selected</cfif>>Month</option>
                    <option value="day" <cfif getCFSprofile.ratetype eq "day">selected</cfif>>Day</option>
                    <option value="hour" <cfif getCFSprofile.ratetype eq "hour">selected</cfif>>Hr</option>
                </select>
            </td>
        </tr>
        <tr>
        	<td>
        		<label>Start Date</label>
        	</td>        	
			<td>
				<div class="input-group date">   
					<input type="text" class="form-control input-sm" id="startdate" name="startdate" placeholder="Date" value="#dateformat(now(),'dd/mm/yyyy')#">
					<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				</div>
			</td>
        </tr>
        <tr>
        	<td>
        		<label>End Date</label>
        	</td>        	
			<td>
				<div class="input-group date">   
					<input type="text" class="form-control input-sm" id="completedate" name="completedate" placeholder="Date" value="#dateformat(now(),'dd/mm/yyyy')#">
					<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				</div>
			</td>
        </tr>
        <tr>
        	<td>
        		<label>Administration fee</label>
            </td>
            <td>
                <input type="text" class="inputtext" id="adminfee" name="adminfee" value="#getCFSprofile.adminfee#">
            </td>
            <td>
            	<input type="checkbox" id="adminfeecap" name="adminfeecap" value="2500" <cfif getCFSprofile.adminFeeCap GT 0 >checked</cfif>>
                <label>Admin Fee Cap (Max. 2500)</label>
            </td>
        </tr>
        <tr>
        	<td>
            </td>
            <td>
            	<br>
            	<input type="button" id="Submit" name="Submit" value="Edit" onclick="validate();"/>
                <a href="/CFSpaybill/listCFSProfile.cfm"><input type="button" id="cancelbtn" name="cancelbtn" value="Cancel"></a>
            </td>
        </tr>
    </table>
</cfform>
</body>
</cfoutput>