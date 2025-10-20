<cfquery name="getarcust" datasource="#dts#">
SELECT custno,name FROM arcust
</cfquery>

<h1>Create CFS Pay & Bill profile</h1>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
<link rel="stylesheet" href="/latest/css/select2/select2.css" />
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">
<script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="/CFSpaybill/css/cfspaybill.css">
<script type="text/javascript" src="/CFSpaybill/js/cfs.js"></script>
<cfinclude template="/CFSpaybill/filter/filterCustomer.cfm">
<cfinclude template="/CFSpaybill/filter/filterContractor.cfm">

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
  
  <cfform name="cfsform" action="/CFSpaybill/CFSpaybillProfileprocess.cfm?type=create">
    <table>
      <tr>
        <td><label>Profile Name</label></td>
        <td><input type="text" class="inputtext" id="profilename" name="profilename" placeholder="Enter a profile name here" value=""></td>
      </tr>
      <tr>
        <td><label>Choose Client</label></td>
        <td><input type="hidden" class="custprofile inputtext" name="custprofile" id="custprofile">
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
        <td><label>Rate for Pay</label></td>
        <td><input type="text" class="inputtext" id="payrate" name="payrate" value="" ></td>
      </tr>
      <tr>
        <td><label>Rate for Bill</label></td>
        <td><input type="text" class="inputtext" id="billrate" name="billrate" value="" ></td>
      </tr>
      <tr>
        <td><label>Rate Type</label></td>
        <td><select class="inputtext" name="ratetype" id="ratetype" >
            <option value="">Please choose a rate type</option>
            <option value="mth">Month</option>
            <option value="day">Day</option>
            <option value="hour">Hr</option>
          </select></td>
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
					<input type="text" class="form-control input-sm" id="completedate" name="completedate" placeholder="Date" value="#dateformat(now(),'dd/mm/yyyy')#" >
					<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
				</div>
			</td>
        </tr>
      <tr>
        	<td>
        		<label>Administration fee</label>
            </td>
            <td>
                <input type="text" class="inputtext" id="adminfee" name="adminfee" placeholder="Enter % / Amount only for fixed Admin Fee" value="" >
            </td>
            <td>
            	<input type="checkbox" id="adminfeecap" name="adminfeecap" value="2500">
                <label>Admin Fee Cap (Max. 2500)</label>
            </td>
        </tr>
      <tr>
        <td></td>
        <td><br>
          <input type="button" id="Submit" name="Submit" value="Create" onclick="validate();"/>
        </td>
      </tr>
    </table>
  </cfform>
	</body>
</cfoutput>