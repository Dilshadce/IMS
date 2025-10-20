<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1,102,104,5,4,6,7,8,9,10,11,2,103,3,299">
<cfinclude template="/latest/words.cfm">
<cfinclude template="/latest/pageTitle/pageTitle.cfm">

<cfquery name="getGsetup" datasource="#dts#">
	SELECT ctycode 
    FROM gsetup;
</cfquery>

<cfquery name="getdisplaysetup" datasource="#dts#">
    select * 
    from displaysetup;
</cfquery>

<cfif url.target EQ "Supplier">
	<cfset targetTitle="Supplier">
	<cfset targetTable=target_apvend>
    <cfset formAction="supplierProcess.cfm?action=print&pageTitle=#targetTitle#">
    <cfset displayEditDelete=getUserPin2.H10102_3b>
    <cfset urlMenuID=url.menuID>
	<cfset targetWords="#words[104]#">
	<cfset pageTitle="#words[102]#">
<cfelseif url.target EQ "Customer">
	<cfset targetTitle="Customer">
	<cfset targetTable=target_arcust>
    <cfset formAction="customerProcess.cfm?action=print&pageTitle=#targetTitle#">
    <cfset displayEditDelete=getUserPin2.H10101_3b>
    <cfset urlMenuID=url.menuID>
	<cfset targetWords="#words[5]#">
	<cfset pageTitle="#words[1]#">
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/dataTables/dataTables_bootstrap.css" />
     <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-multiselect/bootstrap-multiselect.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/profile.css" />
    <!--[if lt IE 9]>
        <script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
        <script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/dataTables_bootstrap.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap-multiselect/bootstrap-multiselect.js"></script>				
    <script type="text/javascript" src="/latest/js/bootstrap-multiselect/bootstrap-multiselect-collapsible-groups.js"></script>
		
		<cfoutput>
        <script type="text/javascript">
            var dts='#dts#';
            var target='#url.target#';
            var targetTitle='#targetTitle#';
            var targetTable='#targetTable#';
            var ctycode='#getGsetup.ctycode#';
			var display='#displayEditDelete#';
			var menuID='#urlMenuID#';
			var account="#words[4]#";
			var targerWords="#targetWords#";
			var address="#words[6]#";
			var telephone="telephone"
			var contact="#words[7]#";
			var agent="agent";
			var endUser = "End User";
			var currency="#words[9]#";
			var attention="#words[8]#";
			var fax="fax";
			var term="term";
			var area="area";
			var business="business";
			var createdOn="created on";
			<cfif lcase(husergrpid) eq "admin" or lcase(husergrpid) eq "super">
			var displaymultiselect="T"
			<cfelse>
			var displaymultiselect=""
			</cfif>
			var displaycost="#getpin2.h1360#"
			
			var action="#words[10]#";
			var SEARCH="#words[11]#";
 			
			<cfif IsDefined('url.message')>
				window.setTimeout(function() {
					$(".alert").fadeTo(500, 0).slideUp(500, function(){
						$(this).remove(); 
					});
				}, 3000);
			</cfif>
        </script>
    </cfoutput>
    <script type="text/javascript" src="/latest/js/maintenance/custSuppProfile.js"></script>
</head>
<body>
<cfoutput>
<div class="container">
	<div class="page-header">
		<h2>
			#pageTitle#
			<span class="glyphicon glyphicon-question-sign btn-link"></span>
			<span class="glyphicon glyphicon-facetime-video btn-link"></span>
			<div class="pull-right">
            	<cfif getUserPin2.H10101_3a EQ 'T' AND targetTitle EQ 'Customer'>
<!---                     <button type="button" class="btn btn-default" onclick="window.open('/latest/maintenance/target.cfm?target=#url.target#&action=create&menuID=#url.menuID#','_self');">
                        <span class="glyphicon glyphicon-plus"></span> #words[2]#
                    </button> --->
                </cfif>
                <cfif getUserPin2.H10102_3a EQ 'T' AND targetTitle EQ 'Supplier'>
                    <button type="button" class="btn btn-default" onclick="window.open('/latest/maintenance/target.cfm?target=#url.target#&action=create&menuID=#url.menuID#','_self');">
                        <span class="glyphicon glyphicon-plus"></span> #words[103]#
                    </button>
                </cfif>
                <cfif getUserPin2.H10101_3c EQ 'T' AND targetTitle EQ 'Customer'>  
                	<!---<cfif HUSERID EQ 'ultraprinesh'>--->
                    <button type="button" class="btn btn-default" onclick="window.open('../../../../default/maintenance/p_suppcust.cfm?type=Customer','_blank');">
                   <!--- <cfelse>
                    <button type="button" class="btn btn-default" onclick="window.open('/latest/maintenance/#formAction#','_blank');">
                    </cfif>--->
                        <span class="glyphicon glyphicon-print"></span> #words[3]#
                    </button>
                </cfif>
                <cfif getUserPin2.H10102_3c EQ 'T' AND targetTitle EQ 'Supplier'>  
                    <button type="button" class="btn btn-default" onclick="window.open('../../../../default/maintenance/p_suppcust.cfm?type=Supplier','_blank');">
                        <span class="glyphicon glyphicon-print"></span> #words[3]#
                    </button>
                </cfif>
				
                <select id="example-multiple-selected" multiple="multiple" <cfif lcase(husergrpid) eq "admin" or lcase(husergrpid) eq "super"><cfelse> style="display:none"</cfif>>
                	<option id="0" name="0" value="0" <cfif getdisplaysetup.cust_custno eq 'Y'>selected</cfif>>Customer No</option>
                	<option id="1" name="1" value="1" <cfif getdisplaysetup.cust_name eq 'Y'>selected</cfif>>Customer Name</option>
                    <option id="2" name="2" value="2" <cfif getdisplaysetup.cust_add eq 'Y'>selected</cfif>>Address</option>
                	<option id="3" name="3" value="3" <cfif getdisplaysetup.cust_tel eq 'Y'>selected</cfif>>Telephone</option>
                    <option id="4" name="4" value="4" <cfif getdisplaysetup.cust_contact eq 'Y'>selected</cfif>>Contact</option>
                    <option id="5" name="5" value="5" <cfif getdisplaysetup.cust_agent eq 'Y'>selected</cfif>>Agent</option>
                    <option id="6" name="6" value="6" <cfif getdisplaysetup.cust_driver eq 'Y'>selected</cfif>>End User</option>
                    <option id="7" name="7" value="7" <cfif getdisplaysetup.cust_currcode eq 'Y'>selected</cfif>>Curr Code</option>
                    <option id="8" name="8" value="8" <cfif getdisplaysetup.cust_attn eq 'Y'>selected</cfif>>Attention</option>
                    <option id="9" name="9" value="9" <cfif getdisplaysetup.cust_fax eq 'Y'>selected</cfif>>Fax</option>
                	<option id="10" name="10" value="10" <cfif getdisplaysetup.cust_term eq 'Y'>selected</cfif>>Term</option>                 
                    <option id="11" name="11" value="11" <cfif getdisplaysetup.cust_area eq 'Y'>selected</cfif>>Area</option>
                	<option id="12" name="12" value="12" <cfif getdisplaysetup.cust_business eq 'Y'>selected</cfif>>Business</option>
                    <option id="13" name="13" value="13" <cfif getdisplaysetup.cust_createdate eq 'Y'>selected</cfif>>Created Date</option>
    			</select>
				
			</div>
		</h2>
	</div>
	<div class="container">
    	<cfif IsDefined('url.message')>
        	<div class="alert alert-danger alert-dismissable">
              <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
              <strong>#url.custno# #words[299]#</strong> 
            </div>
    	</cfif>
		<table class="table table-bordered table-hover" id="resultTable" style="table-layout:fixed">
			<thead>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>
</cfoutput>
</body>
</html>