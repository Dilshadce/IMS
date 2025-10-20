<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset pageTitle="New Hiring Manager">
		<cfset pageAction="Create">		
        <cfset entryID = "">   
		<cfset userID = "">
        <cfset userName = "">   
		<cfset userEmail = "">      
        <cfset custno = ""> 
        <cfset isLogin = "">
        <cfset comID = "">  
                   
	<cfelseif url.action EQ "update">
		<cfset pageTitle="Update Hiring Manager">
		<cfset pageAction="Update">
		
        <cfquery name="getHM" datasource='payroll_main'>
            SELECT * 
            FROM hmusers 
            WHERE entryID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDecode(url.id)#">;
		</cfquery>
		
		<cfset entryID = getHM.entryID>
		<cfset userID = getHM.userID>
        <cfset userName = getHM.userName>   
		<cfset userEmail = getHM.userEmail>      
        <cfset custno = getHM.custno>
        <cfset isLogin = getHM.status>
        <cfset comID = getHM.userCmpID>
    </cfif>      
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <!---<link rel="stylesheet" href="/latest/css/form.css" />--->
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    
    <cfinclude template="select2Filter.cfm">
</head>

<cfoutput>
<body>
<div class="container">
	<div class="page-header">
      <h3>#pageTitle#</h3>
    </div>
    <cfform class="form-horizontal" action="/latest/customization/manpower_i/hrMgrProfile/hrMgrProcess.cfm?action=#url.action#" method="post" enctype="multipart/form-data">
        <div class="row">
        	<div class="col-sm-6">
            	<div class="form-group">
                    <label class="col-sm-4 control-label">Customer No</label>
                    <div class="col-sm-8">
                        <input type="hidden" id="custno" name="custno" class="custnoFilter" data-placeholder="Customer No"/>          
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-sm-4 control-label">Name</label>
                    <div class="col-sm-8">
                        <input type="text" id="userName" name="userName" class="form-control input-sm" value="#userName#" />               
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-sm-4 control-label">Email</label>
                    <div class="col-sm-8">
                        <cfinput type="text" id="userEmail" name="userEmail" class="form-control input-sm" value="#userEmail#" validate="email" message="Email format is incorrect" required="yes" />               
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-sm-4 control-label">Portal Access</label>
                    <div class="col-sm-8">
                        <input type="checkbox" class="form-control input-sm" id="isLogin" name="isLogin" <cfif isLogin EQ "Y">checked</cfif> />               
                    </div>
                </div>
                
                <!---<div class="form-group">
                    <label class="col-sm-4 control-label">Company ID</label>
                    <div class="col-sm-8">
                        <input type="hidden" id="comID" name="comID" class="comIDFilter" data-placeholder="Company ID"/>            
                    </div>
                </div>--->
                <!---<cfif url.action EQ "update">
                    <div class="form-group">
                        <label class="col-sm-4 control-label">Reset Password</label>
                        <div class="col-sm-8">
                            <Button type="button" class="btn" onclick="resetPwd()">Click Here To Reset Password</Button>
                        </div>
                    </div>
                </cfif>--->
            </div>
        </div>
        <div class="pull-right">
        	<input type="hidden" id="id" name="id" value="#entryID#" />
            <input type="hidden" id="comID" name="comID" value="manpower" />
            <input type="submit" value="#pageAction#" class="btn btn-primary" />
            <input type="button" value="Cancel"  class="btn btn-default" onclick="window.location='/latest/customization/manpower_i/hrMgrProfile/hrMgrProfile.cfm'" />
		</div>
    </cfform>
</div>
</body>
</cfoutput>
</html>