<cfif IsDefined("form.submit")>
	<cfquery name="checkoldpass" datasource="#dts#">
		SELECT userid 
		FROM mainams.users 
		WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#"> 
		AND userpwd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(form.currentPassword)#"> 
		AND userbranch = "#dts#"
	</cfquery>
	<cfif checkoldpass.recordcount NEQ 1>
		<script type="text/javascript">
			alert('Please enter correct Current Password.');
		</script>
    <cfelse>
		<cfquery name="updatepass" datasource="#dts#">
			UPDATE mainams.users 
			SET userpwd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(form.password)#">
        	WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#"> 
			AND userpwd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(form.currentPassword)#"> 
			AND userbranch = "#dts#"
        </cfquery>
		<script type="text/javascript">
			alert('Change password successfully.');
		</script>
	</cfif>
</cfif>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Change Password</title>
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
<!--[if lt IE 9]>
	<script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
	<script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
<![endif]-->
<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(e) {	
	var re1 = new RegExp(/(?=.*\d)/);
	var re2 = new RegExp(/(?=.*[a-z])/);
	$('#currentPassword').on('change',function(e){
		if($(this).val()==''){
			$(this).parent().children('.help-block').html('This field is required.').show();
			$(this).parent().removeClass('has-success').addClass('has-error');
		}else{
			$(this).parent().children('.help-block').hide();
			$(this).parent().removeClass('has-error').addClass('has-success');
		}
	});
	
	$('#password').on('keyup',function(e){
		if($(this).val()==''){
			$(this).parent().children('.help-block').html('This field is required.').show();
			$(this).parent().removeClass('has-success').addClass('has-error');
		}else if(!re1.test($(this).val())){
			$(this).parent().children('.help-block').html('New Password required at least one numeric character.').show();
			$(this).parent().removeClass('has-success').addClass('has-error');			
		}else if(!re2.test($(this).val())){
			$(this).parent().children('.help-block').html('New Password required at least one alphabetic character.').show();
			$(this).parent().removeClass('has-success').addClass('has-error');			
		}else if($(this).val().length<12){
			$(this).parent().children('.help-block').html('New Password required at least 12 characters.').show();
			$(this).parent().removeClass('has-success').addClass('has-error');			
		}else if($(this).val().length>32){
			$(this).parent().children('.help-block').html('New Password cannot more than 32 characters.').show();
			$(this).parent().removeClass('has-success').addClass('has-error');			
		}else{
			$(this).parent().children('.help-block').hide();
			$(this).parent().removeClass('has-error').addClass('has-success');
		}
	});
	
	$('#passwordConfirm').on('keyup',function(e){
		if($(this).val()!=$('#password').val()){
			$(this).parent().children('.help-block').html('Confirmed Password does not match with New Password.').show();
			$(this).parent().removeClass('has-success').addClass('has-error');
		}else{
			$(this).parent().children('.help-block').hide();
			$(this).parent().removeClass('has-error').addClass('has-success');
		}
	});	
});
function validate(){
	var re = new RegExp(/(?=^.{12,32}$)(?=(?:.*?\d){1})(?=.*[a-z])(?=(?:.*?[!@#$%*()_+^&}{:;?.]){1})(?!.*\s)[0-9a-zA-Z!@#$%*()_+^&]*$/);	
	var re1 = new RegExp(/(?=.*\d)/);
	var re2 = new RegExp(/(?=.*[a-z])/);
	var re3 = new RegExp(/(?=^.{12,32}$)/);
	var errorMsg='';
	if($('#currentPassword').val()==''){
		errorMsg=errorMsg+'Please enter Current Password.\n';
	}
	if($('#password').val()==''){
		errorMsg=errorMsg+'Please enter New Password.\n';
	}
	if($('#password').val()==''){
		errorMsg=errorMsg+'Please enter New Password.\n';
	}
	if($('#passwordConfirm').val()==''){
		errorMsg=errorMsg+'Please enter Confirm Password.\n';
	}
	if($('#password').val()!=$('#passwordConfirm').val()){
		errorMsg=errorMsg+'Please enter same value for New Password and Confirm Password.\n';
	}
	if($('#password').val()!=''&&!re.test($('#password').val())){
		if(!re2.test($('#password').val())){
			errorMsg=errorMsg+'At least one alphabet\n';
		}else if(!re1.test($('#password').val())){
			errorMsg=errorMsg+'At least one numeric\n';
		}else if(!re3.test($('#password').val())){
			errorMsg=errorMsg+'At least 12 characters\n';
		}
	}	
	if(errorMsg!=''){
		alert(errorMsg);
		return false;
	}else{
		return true;
	}
}
</script>
</head>
<body>
<cfoutput>
	<div class="container">
		<div class="page-header">
			<h1>Change Password</h1>
		</div>
		<form role="form" action="/latest/admin/userpassword.cfm" method="post">
			<div class="form-group row">
				<div class="col-sm-6">
					<label for="currentPassword" class="control-label">Current Password</label>
					<input type="password" id="currentPassword" name="currentPassword" class="form-control" placeholder="Enter current password." />
					<p class="help-block" style="display:none;"></p>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6">
					<label for="password" class="control-label">New Password</label>
					<input type="password" id="password" name="password" class="form-control" placeholder="Enter new password." />
					<p class="help-block" style="display:none;"></p>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6">
					<input type="password" id="passwordConfirm" name="passwordConfirm" class="form-control" placeholder="Enter confirmed password." />
					<p class="help-block" style="display:none;"></p>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6">
					<button type="submit" id="submit" name="submit" class="btn btn-default">Submit</button>
					<button type="button" class="btn btn-default" onClick="window.location='/latest/body/bodymenu.cfm?id=255'">Cancel</button>
				</div>
			</div>
		</form>
	</div>
</cfoutput>
</body>
</html>