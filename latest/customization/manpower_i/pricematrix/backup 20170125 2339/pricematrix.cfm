<cfprocessingdirective pageencoding="UTF-8">

<cfif IsDefined('url.refno')>
	<cfset URLrefno = trim(urldecode(url.refno))>
</cfif>

<cfinclude template="/CFC/convert_single_double_quote_script.cfm">

<cfquery name="getgsetup" datasource='#dts#'>
    SELECT * 
    FROM gsetup;
</cfquery>

<cfquery name="getusers" datasource='main'>
    SELECT * 
    FROM users
	WHERE userbranch=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(dts)#">
	AND userid not like "ultra%"
	;
</cfquery>

<cfquery datasource="#dts#" name="getrefnoset">
	select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
    from refnoset
	where type = 'CPO'
	and counter = '1'
</cfquery>

<cfinvoke component="cfc.refno" method="processNum" oldNum="#getrefnoset.tranno#" returnvariable="custpono" />	

<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset pageTitle="Create Pay & Bill Structure">
		<cfset pageAction="Create">
     
	</cfif> 
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <!---<link rel="stylesheet" href="/latest/css/form.css" />--->
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/target.css">
	<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
	
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>

	
	<script>
	function validatefield(){
	
	if(document.getElementById('pricename').value == ""){
		alert('Please Key In Pay & Bill Structure Name!')
		return false;
	}
	
	}
	
	
	</script>
    
</head>

<body class="container">
<cfoutput>
<cfform id="form" name="form" class="form-horizontal" role="form" action="pricematrix2.cfm?action=#url.action#" method="post" onsubmit="return validatefield();" >
	<div class="page-header">
		<h3>#pageTitle#</h3>
	</div>
		<div class="panel-group">
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##panel1Collapse">
						<h4 class="panel-title accordion-toggle">Pay & Bill Structure</h4>
					</div>
                    <div id="panel1Collapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-12"> 
                                 	<div class="form-group">
										<label for="refno" class="col-sm-3 control-label">Pay & Bill Structure Name</label>
										<div class="col-sm-5">
											<cfinput type="text" class="form-control input-sm" id="pricename" name="pricename"  placeholder="Pay & Bill Structure Name" value="" required="true" message="Please Key In Pay & Bill Structure Name">									
										</div>
            					</div>
            				</div>
                		</div>
                	</div>					
				</div>
			
                
				 
			</div>
            <hr>
            <div class="pull-right">
				<input type="submit" value="#pageAction#" class="btn btn-primary">
				<input type="button" value="Cancel" onclick="window.location='pricematrixProfile.cfm'" class="btn btn-default" />
            </div>
        
</cfform>

</cfoutput>
</body>
</html>