<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen" >
<link href="/stylesheet/app.css" rel="stylesheet" type="text/css" >
<script src="/javascripts/tabber.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript" src="/javascripts/ajax.js"></script>
<script type="text/javascript" src="/javascripts/ajax.js"></script>
<title>Timesheet Approval</title>
<link rel="shortcut icon" href="/PMS.ico" /> 
<cfset dts2 = replace(dts,'_p','_i')>
<cfoutput>

<cfif isdefined("form.uploadfilefield")> 
    <cfset uploaddir = "/upload/#dts#/signature/timesheet/">
    <cfset uploaddir = expandpath("#uploaddir#")> 
    <cfif directoryexists(uploaddir) eq false>
        <cfdirectory action="create" directory="#uploaddir#" >
    </cfif>
    <cfif isdefined('form.uploadfilefield')>
        <cfif form.uploadfilefield neq "">
        <cffile action="upload" destination="#uploaddir#" nameconflict="makeunique" filefield="uploadfilefield" >
        </cfif>
    </cfif>
    <cfquery name="Approve" datasource="#dts#">
     UPDATE timesheet SET STATUS = "APPROVED",updated_by = "#HUserName#", mgmtremarks = "#form.remarks#", updated_on = now(), 
     signdoc = <cfqueryparam cfsqltype="cf_sql_varchar" value="/upload/#dts#/signature/timesheet/#file.serverfile#">     
     WHERE tmonth = #form.id# and placementno = '#form.placementno#'
    </cfquery>
    
    <cflocation url='/approval/timesheetapprovalmain.cfm'>
    
<cfelse>
    <cfform name="pform" method="post" action="timesheetapproval3.cfm" enctype="multipart/form-data">
    <table>
        <tr>
            <th width="200px">Timesheet ID</th>
            <td>#url.id#</td>
        </tr>
        <tr>
            <th>Remarks</th>
            <td><input type="text" id="remarks" name="remarks" value=""></td>
        </tr>   
        <tr>
        <th>Signed Document</th>
        <td>
            <cfinput type="file" name="uploadfilefield" id="uploadfilefield" required="yes" message="Must attach receipt">
            <input type="hidden" name="id" class="id" value="#url.id#">
            <input type="hidden" name="placementno" class="placementno" value="#url.placementno#">
        </td>     
        </tr>
        <tr>
            <td/>    
            <td><input type="submit" id="submit" name="submit" value="Approve">
                <input type="button" id="back" name="back" onclick="window.open('/approval/timesheetapprovalmain.cfm','_self')" value="Back"></td>
        </tr>

    </cfform>         
</cfif>
</cfoutput>
</body>
</html> 
