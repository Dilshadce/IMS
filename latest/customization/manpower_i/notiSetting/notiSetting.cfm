<cfset targetTitle="Notification Setting">
<cfset targetTable="doctype">
<cfset pageTitle="Notification Setting">

<cfquery name="getNotiSetting" datasource="#dts#">
	SELECT * FROM notisetting
</cfquery>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/target.css">
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/dataTables/dataTables_bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/profile.css" />
    <link rel="stylesheet" type="text/css" href="https://gitcdn.github.io/bootstrap-toggle/2.2.0/css/bootstrap-toggle.min.css" rel="stylesheet">
    <!--[if lt IE 9]>
        <script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
        <script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" src="tinymce/js/tinymce/tinymce.min.js"></script>
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/dataTables_bootstrap.js"></script>
    <script type="text/javascript" src="https://gitcdn.github.io/bootstrap-toggle/2.2.0/js/bootstrap-toggle.min.js"></script>
    
    <script type="text/javascript" src="tinymce/js/tinymce/tinymce.min.js"></script>
	<script type="text/javascript">
		tinymce.init({
    		selector: "textarea",
   			plugins: [
        		"advlist autolink lists link image charmap print preview anchor",
        		"searchreplace visualblocks code fullscreen",
        		"insertdatetime media table contextmenu paste"
    		],
    		toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image"
		});
	</script>
    
    <script type="text/javascript">
	$(document).ready(function(){

		$('#submit').click(function(){
			$(':input, :button').prop('disabled',false);
			
		});

	});	
	</script>
    
    <style>
		@media screen and (min-width: 768px) {
			.modal-dialog  {width:45%}
		}
		
		.disabled {
			color: #999;
		}
	</style>
</head>

<cfoutput>
<body>
	<div class="container">
		<div class="page-header">
			<h2>#pageTitle#</h2>
        </div>
        
        <cfset tabList = "Timesheet,Leave,Claim">
        <cfset cateList = "Notify to Hiring Manager Upon Submission,Notify to Associate Upon Approval By Hiring Manager,Notify to MP Upon Approval By Hiring Manager,Notify to Associate Upon Validation By MP,Notify to Hring Manager 3 Days Prior Closing If Not Approved,Notify to MP 3 Days Prior Closing If Not Approved,Notify to MP supervisor 2/3 Days Prior Closing If Not Approve">
        <cfset thList = "Category,Email Template,On / Off,Day(s) Before Closing,Frequency">
        <cfset settingNo = 1>
        <cfset settingNo2 = 1>
        
        <form id="notiForm" name="notiForm" action="notiSettingProcess.cfm" method="post" enctype="multipart/form-data">
            <div class="tabbable">
                <ul role="tablist" class="nav nav-tabs" id="notiSetTab">
                	<cfloop list="#tabList#" delimiters="," index="i">         
                      	<li role="presentation" <cfif i EQ "Timesheet">class="active"</cfif>><a href="###i#" data-toggle="tab">#i#</a></li>
                    </cfloop>
                </ul>
                <div class="tab-content">
                	<cfloop list="#tabList#" delimiters="," index="i">
                        <div role="tabpanel" class="tab-pane <cfif i EQ "Timesheet">active</cfif>" id="#i#" style="margin-top:50px">        		
                            <table class="table table-bordered table-hover" style="width:100%">
                                <thead>
                                    <cfloop list="#thList#" delimiters="," index="i">
                                        <cfif i EQ "Category">
                                            <cfset perc = "40">
                                        <cfelseif i EQ "Email Template">
                                            <cfset perc = "14">
										<cfelseif i EQ "On / Off">
                                            <cfset perc = "10">
                                        <cfelseif i EQ "Day(s) Before Closing">
                                            <cfset perc = "15">
                                        <cfelseif i EQ "Frequency">
                                            <cfset perc = "21">
                                        <cfelse>
                                            <cfset perc = "18">
                                        </cfif>
                                                                                                                     
                                        <th style="width:#perc#%" align="center">#i#</th>
                                    </cfloop>
                                </thead>   
                                <!---to disable few option which is not ready, [20170324, Alvin]--->
                                <cfset disable1 = 'Notify to Hring Manager 3 Days Prior Closing If Not Approved'> 
                                <cfset disable2 = 'Notify to MP 3 Days Prior Closing If Not Approved'> 
                                <cfset disable3 = 'Notify to MP supervisor 2/3 Days Prior Closing If Not Approve'>                              
                                <!---disable--->
                                <tbody>                                              
                                    <cfloop list="#cateList#" delimiters="," index="i">
                                        <tr>
                                            <td>#i#</td>
                                            <td align="center"><button <cfif #i# eq #disable1# OR #i# eq #disable2# OR #i# eq #disable3# OR #settingNo# eq '11' OR #settingNo# eq '18'> disabled="disabled" </cfif>
                                             	type="button" class="btn btn-default " data-toggle="modal" data-target="##template#settingNo#">Edit</button>
                                            </td>
                                            <td  align="center"><input <cfif #i# eq #disable1# OR #i# eq #disable2# OR #i# eq #disable3# OR #settingNo# eq '11' OR #settingNo# eq '18'> disabled="disabled" </cfif>
                                             type="checkbox" id="setting#settingNo#" name="setting#settingNo#" data-toggle="toggle" <cfif Evaluate("getNotiSetting.setting#settingNo#") EQ "Y">checked</cfif>>
                                            </td>
                                            <td> <input type="number" readonly="readonly" class="form-control" id="days#settingNo#" name="days#settingNo#" placeholder="Day(s) Before Closing" value="#Evaluate('getNotiSetting.days#settingNo#')#" style="text-align:right" /></td>
                                            <td>
                                                <div class="input-group">
                                                    <span class="input-group-addon">
                                                        <span>Every</span>
                                                    </span>                                       										
                                                    <input type="number" readonly="readonly" class="form-control input-sm" id="hours#settingNo#" name="hours#settingNo#" placeholder="Frequency" value="#Evaluate('getNotiSetting.hours#settingNo#')#" style="text-align:right" />
                                                    <span class="input-group-addon">
                                                        <span>Hour(s)</span>
                                                    </span>
                                                </div>                                           
                                            </td>
                                        </tr>
                                        <cfset settingNo += 1>
                                    </cfloop> 
                                </tbody>
                            </table>                                     
                        </div>                        
                    </cfloop>
                </div>
            </div>
            <div class="pull-right">
            	<button type="submit" class="btn btn-primary" id="submit" name="submit">Save</button>
    			<button type="button" class="btn btn-default" onClick="javascript: window.history.go(-1)">Cancel</button>
			</div>
            <cfloop list="#tabList#" delimiters="," index="i">
            	<cfloop list="#cateList#" delimiters="," index="j">      
                    <!-- Modal -->
                    <div id="template#settingNo2#" class="modal fade" role="dialog" style="width:100%">
                        <div class="modal-dialog">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Email Template (#i# - #j#)</h4>
                                </div>
                                <div class="modal-body">
                                    <textarea class="form-control" id="template#settingNo2#" name="template#settingNo2#" style="width:100%">#Evaluate('getNotiSetting.template#settingNo2#')#</textarea>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" data-dismiss="modal">Done</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <cfset settingNo2 += 1>
                </cfloop>
            </cfloop>
        </form>
    </div>
</body>
</cfoutput>
</html>



						