<cfset targetTitle="Document Linkeage Profile">
<cfset targetTable="docupload">
<cfset pageTitle="Document Linkeage Profile">

<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset pageTitle="New Document Linkeage">
		<cfset pageAction="Create">	
        <cfif IsDefined("url.id")>
            <cfquery name="getDocLink" datasource='#dts#'>
                SELECT * 
                FROM docLink 
                WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">;
			</cfquery>
		
			<cfset id = getDocLink.id>   
            <cfset docType = getDocLink.docType>
            <cfset xclient = getDocLink.client>
            <cfset associate = getDocLink.associate>
            <cfset docUuid = getDocLink.docuuid>       
            <cfset expiryDate = getDocLink.expirydate>  
            <cfset docOwner = getDocLink.docowner>
            <cfset email = getDocLink.email>
            <cfset startDate = getDocLink.startDate>   
            <cfset monthsBefore = getDocLink.monthsBefore>    
            <cfset frequency = getDocLink.frequency>
        <cfelse>
        	<cfset id = "">   
			<cfset docType = "">
            <cfset xclient = "">
            <cfset associate = "">
            <cfset docUuid = CreateUuid()> 
            <cfset expiryDate = Now()>  
            <cfset docOwner = "">
            <cfset email = "">
            <cfset startDate = Now()>
            <cfset monthsBefore = 0>
            <cfset frequency = 0>           
        </cfif>	
	<cfelseif url.action EQ "update">
		<cfset pageTitle="Update Document Linkeage">
		<cfset pageAction="Update">
		
        <cfquery name="getDocLink" datasource='#dts#'>
            SELECT * 
            FROM docLink 
            WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">;
		</cfquery>
		
		<cfset id = getDocLink.id>   
		<cfset docType = getDocLink.docType>
        <cfset xclient = getDocLink.client>
        <cfset associate = getDocLink.associate>
        <cfset docUuid = getDocLink.docuuid>       
        <cfset expiryDate = getDocLink.expirydate>  
        <cfset docOwner = getDocLink.docowner>
        <cfset email = getDocLink.email>
        <cfset startDate = getDocLink.startDate>   
		<cfset monthsBefore = getDocLink.monthsBefore>    
        <cfset frequency = getDocLink.frequency>                
    <cfelseif url.action EQ "delete">
    	<cfset pageTitle="Delete Document Linkeage">
		<cfset pageAction="Delete">   
        
       	<cfquery name="getDocLink" datasource='#dts#'>
            SELECT * 
            FROM docLink 
            WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">;
		</cfquery>
		
        <cfset id = getDocLink.id>   
		<cfset docType = getDocLink.docType>   
	</cfif>   
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/target.css">
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/dataTables/dataTables_bootstrap.css" />
    
    <style>
		.btn-file {
			position: relative;
			overflow: hidden;
		}
		
		.btn-file input[type=file] {
			position: absolute;
			top: 0;
			right: 0;
			min-width: 100%;
			min-height: 100%;
			font-size: 100px;
			text-align: right;
			filter: alpha(opacity=0);
			opacity: 0;
			outline: none;
			background: white;
			cursor: inherit;
			display: block;
		}
	</style>
    
    <script type="text/javascript" src="/latest/js/maintenance/target.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/dataTables_bootstrap.js"></script>   
    <script type="text/javascript" src="/scripts/ajax.js"></script>
    <cfoutput>
		<script type="text/javascript">
            var dts='#dts#';
            var display='T';
            var targetTable='#targetTable#';
            var fileName ='file name';
			var uploadedBy ='uploaded by';
			var uploadedOn ='uploaded on';
            var action='action';
            var SEARCH='search';
			var docUuid="#docUuid#";
			var action2="#action#";
			var id2="#id#";
        </script>
    </cfoutput>
    <cfinclude template="select2Filter.cfm">
    <script type="text/javascript" src="/latest/customization/manpower_i/docLink/docUpload.js"></script>
    <script type="text/javascript" src="/scripts/ajax.js"></script>
</head>
<cfoutput>

<body>
<div class="container">
	<div class="page-header">
      <h3>#pageTitle#</h3>
    </div>
    <cfform class="form-horizontal" role="form" id="docLinkForm" name="docLinkForm" action="/latest/customization/manpower_i/docLink/docLinkProcess.cfm?action=#url.action#" method="post" enctype="multipart/form-data">
    	<div class="panel">
        	<div class="panel panel-default">
            	<div class="panel-heading" data-toggle="collapse" href="##docLinkDetail">
          			<h4 class="panel-title accordion-toggle">Doc Linkeage Detail</h4>
        		</div>                
                <div class="panel-collapse collapse in" id="docLinkDetail" >
          			<div class="panel-body">
                    	<div class="row">
                        	<div class="col-sm-6">
                            	<div class="form-group">
                                	<label class="col-sm-4 control-label" for="docType">Doc Type</label>
                                    <div class="col-sm-8">
                                    	<input type="hidden" id="docType" name="docType" class="docTypeFilter" data-placeholder="Document Type" />
								    </div>
                                </div>
                                <div class="form-group">
                                	<label class="col-sm-4 control-label" for="docType">Client</label>
                                    <div class="col-sm-8">
                                    	<input type="hidden" id="client" name="client" class="clientFilter" data-placeholder="Client" />
								    </div>
                                </div>
                                <div class="form-group">
                                	<label class="col-sm-4 control-label" for="docType">Associate</label>
                                    <div class="col-sm-8">
                                    	<input type="hidden" id="associate" name="associate" class="associateFilter" data-placeholder="Associate" />
								    </div>
                                </div>
                                <div class="form-group">
                                	<label class="col-sm-4 control-label" for="docType">Doc Owner Detail</label>
                                    <div class="col-sm-8">
                                    	<textarea class="form-control" id="ownerDetail" name="ownerDetail">#docOwner#</textarea>
								    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                            	<div class="form-group">
                                	<label class="col-sm-4 control-label" for="memberName">Expiry Date</label>
                                    <div class="col-sm-8">
                                    	<div class="input-group date">
                                            <input class="form-control input-sm" type="text" id="expiryDate" name="expiryDate" placeholder="ExpiryDate" value="#DateFormat(expiryDate, 'DD/MM/YYYY')#" />
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>
								    </div>
                                </div>
                                <div class="form-group">
                                	<label class="col-sm-4 control-label" for="email">Email</label>
                                    <div class="col-sm-8">
                                    	<cfinput type="text" class="form-control input-sm" id="email" name="email" placeholder="Email" validate="email" message="Email format is incorrect" value="#email#"/>
								    </div>
                                </div>
                                <div class="form-group">
                                	<label class="col-sm-4 control-label" for="memberName">Notification Setting</label>
                                    <div class="col-sm-8">
                                    	<div class="input-group">
                                            <input class="form-control input-sm" type="text" id="startDate" name="startDate" placeholder="Start Date" value="#DateFormat(startDate, 'DD/MM/YYYY')#" readonly />
                                            <span class="input-group-addon">
                                                <span>Start Date</span>
                                            </span> 
                                        </div> 
                                        <div class="input-group">										
                                        	 <input type="number" class="form-control input-sm" id="monthsBefore" name="monthsBefore" placeholder="Month(s) Before Expire" value="#monthsBefore#" onblur="calStartDate()" />
                                            <span class="input-group-addon">
                                                <span>Month(s) Before Expiry</span>
                                            </span>                                       
                                        </div> 								                                     
                                        <div class="input-group">										
                                        	<input type="number" class="form-control input-sm" id="frequency" name="frequency" placeholder="Frequency" value="#frequency#" />
                                            <span class="input-group-addon">
                                                <span>Time(s) a Day</span>
                                            </span>                                       
                                        </div> 
								    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>          
            <div class="panel panel-default">
                <div class="panel-heading" data-toggle="collapse" href="##transactionDetail">
                    <h4 class="panel-title accordion-toggle">Upload Document</h4>
                </div>                
                <div class="panel-collapse collapse in" id="transactionDetail" >
                	<div class="page-header" align="right">	
                        <button type="button" class="btn btn-default" onClick="uploadDoc()">
							<span class="glyphicon glyphicon-cloud-upload"></span> Upload Document
						</button>
                        <span>&nbsp;&nbsp;</span> 
    				</div>                  	                  
                    <div class="panel-body">
                        <table class="table table-bordered table-hover" id="resultTable" style="width:100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="pull-right">
        	<input type="hidden" id="id" name="id" value="#id#" />
            <input type="hidden" id="docUuid" name="docUuid" value="#docUuid#" />
			<button type="submit" class="btn btn-primary" id="submit" name="submit">#pageAction#</button>
    		<button type="button" class="btn btn-default" onClick="window.open('docLink.cfm', '_self')">Cancel</button>
		</div>
    </cfform>
</div>

<div id="calStartDateAjax">
</div>

<script type="text/javascript">	
	function calStartDate(){
		var ajaxUrl = "calStartDate.cfm?expiryDate=" + document.getElementById("expiryDate").value + "&monthsBefore=" + document.getElementById("monthsBefore").value;
		
		jQuery.noConflict();
		(function( $ ) {
			$(function() {
				$.ajax({
					type:'POST',
					url:ajaxUrl,
					data:'',
					dataType:'html',
					cache:false,
					async: false,
					success: function(result){
						$("##calStartDateAjax").html(result);
						document.getElementById("startDate").value = document.getElementById("hidStartDate").value;
					},
					error: function(jqXHR,textStatus,errorThrown){
						alert(errorThrown);
					},
					complete: function(){
						
					}
				});
			});
		})(jQuery);
	}
	
	function uploadDoc(){
		ColdFusion.Window.show("uploadDoc");
		<!---var id = document.getElementById('id').value;		
		var docType = document.getElementById('docType').value;
		var client = document.getElementById('docType').value;
		var associate = document.getElementById('associate').value;
		var docOwner = document.getElementById('ownerDetail').value;
		var expiryDate = document.getElementById('expiryDate').value;
		var email = document.getElementById('email').value;
		var startDate = document.getElementById('startDate').value;
		var monthsBefore = document.getElementById('monthsBefore').value;
		var frequency = document.getElementById('frequency').value;
		
		window.open("/latest/customization/manpower_i/docLink/uploadDoc.cfm?" 
		+ "id=" + id
		+ "&uuid=#docUuid#"
		+ "&docType=" + docType
		+ "&client=" + client
		+ "&associate=" + associate
		+ "&docOwner=" + docOwner
		+ "&expiryDate=" + expiryDate
		+ "&email=" + email
		+ "&startDate=" + startDate
		+ "&monthsBefore=" + monthsBefore
		+ "&frequency=" + frequency
		, "Upload Document", "height=200,width=500,scrollbars=no");--->
	}
	
	function uploadingDoc(docName){
		var newDocName = new String(docName);
		var newDocName2 = newDocName.split(/[-,/,\\]/g);
		document.getElementById("filePath").value = newDocName;
		document.getElementById("fileName").value = newDocName2[newDocName2.length-1];
	}
	
	function closeWindow(){
		ColdFusion.Window.hide("uploadDoc");
	}
	
	function isUpload(){
		if(document.getElementById("fileUpload").files.length == 0){
			alert("No file is chosen");
			return false;
		}
		return true;
	}
</script>
</body>
</cfoutput>
</html>

<cfwindow center="true" width="600" height="200" name="uploadDoc" refreshOnShow="true" closable="true" modal="true" title="Upload Document" initshow="false" source="uploadDoc.cfm?id={id}&uuid={docUuid}&docType={docType}&client={client}&associate={associate}&docOwner={ownerDetail}&expiryDate={expiryDate}&email={email}&startDate={startDate}&monthsBefore={monthsBefore}&frequency={frequency}&action=#action#" />

