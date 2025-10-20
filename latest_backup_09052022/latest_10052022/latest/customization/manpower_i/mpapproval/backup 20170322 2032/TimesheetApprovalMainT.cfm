<cfif not len(getAuthUser())>
	<cfoutput>
        <script type="text/javascript">
            window.open('/security/login.cfm?logout=2','_parent');
        </script>
    </cfoutput>
</cfif>

<cfquery name="company_details" datasource="payroll_main">
	SELECT * 
    FROM gsetup 
    WHERE comp_id = "#HcomID#"
</cfquery>

<cfset dts2 = replace(dts,'_i','_p')>
<cfset targetTable="timesheet">
<cfset huserid="#huserid#">



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Timesheet Approval</title>
    
    <link rel="stylesheet" type="text/css" href="/menulist/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/menulist/css/dataTables/dataTables_bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="/menulist/css/maintenance/profile.css" />
    <!--[if lt IE 9]>
        <script type="text/javascript" src="/menulist/js/html5shiv/html5shiv.js"></script>
        <script type="text/javascript" src="/menulist/js/respond/respond.min.js"></script>
    <![endif]-->
 
    <script type="text/javascript" src="/menulist/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/menulist/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/menulist/js/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/menulist/js/dataTables/dataTables_bootstrap.js"></script>
    
    <link rel="shortcut icon" href="/PMS.ico" />
    <link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">	
    <link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen" >
	    
    <script type="text/javascript">

	/*==================================================
	  Set the tabber options (must do this before including tabber.js)
	  ==================================================*/
	var tabberOptions = {
	
	  'cookie':"tabber", /* Name to use for the cookie */
	
	  'onLoad': function(argsObj)
	  {
		var t = argsObj.tabber;
		var i;
	
		/* Optional: Add the id of the tabber to the cookie name to allow
		   for multiple tabber interfaces on the site.  If you have
		   multiple tabber interfaces (even on different pages) I suggest
		   setting a unique id on each one, to avoid having the cookie set
		   the wrong tab.
		*/
		if (t.id) {
		  t.cookie = t.id + t.cookie;
		}
	
		/* If a cookie was previously set, restore the active tab */
		i = parseInt(getCookie(t.cookie));
		if (isNaN(i)) { return; }
		t.tabShow(i);
	
	  },
	
	  'onClick':function(argsObj)
	  {
		var c = argsObj.tabber.cookie;
		var i = argsObj.index;
	
		setCookie(c, i);
		location.reload();
	  }
	};
	
	/*==================================================
	  Cookie functions
	  ==================================================*/
	function setCookie(name, value, expires, path, domain, secure) {
		document.cookie= name + "=" + escape(value) +
			((expires) ? "; expires=" + expires.toGMTString() : "") +
			((path) ? "; path=" + path : "") +
			((domain) ? "; domain=" + domain : "") +
			((secure) ? "; secure" : "");
	}
	
	function getCookie(name) {
		var dc = document.cookie;
		var prefix = name + "=";
		var begin = dc.indexOf("; " + prefix);
		if (begin == -1) {
			begin = dc.indexOf(prefix);
			if (begin != 0) return null;
		} else {
			begin += 2;
		}
		var end = document.cookie.indexOf(";", begin);
		if (end == -1) {
			end = dc.length;
		}
		return unescape(dc.substring(begin + prefix.length, end));
	}
	function deleteCookie(name, path, domain) {
		if (getCookie(name)) {
			document.cookie = name + "=" +
				((path) ? "; path=" + path : "") +
				((domain) ? "; domain=" + domain : "") +
				"; expires=Thu, 01-Jan-70 00:00:01 GMT";
		}
	}
	
<!---	function confirmDecline(type,id,pno) {
		var answer = confirm("Confirm Cancel?")
		if (answer){
			var textbox_id = "management_"+id+"_"+pno;
			var remark_text = document.getElementById(textbox_id).value;		
			
			window.location = "TimesheetApprovalProcess.cfm?type="+type+ "&id="+id+"&remarks="+escape(remark_text)+"&pno="+pno;
		}
		else{
			
		}
	}
	function confirmDelete(type,id,pno) {
		
			var answer = confirm("Confirm Delete?")
			if (answer){
				window.location = "TimesheetApprovalProcess.cfm?type="+type+"&id="+id+"&pno="+pno;
				}
			else{
				
				}
			}
			--->
	
	function confirmApprove(type,id,pno) {
		var answer = confirm("Confirm Validate?")
		if (answer){
			window.location = "/default/transaction/assignmentslipnewnew/Assignmentsliptable2.cfm?type=Create&id="+id+"&pno="+pno;
		}
		else{
			
		}
	}
	
	function confirmApprove2(type,id,pno) {
		window.location = "TimesheetApproval2.cfm?id="+id+"&placementno="+pno;
	}
	
	function confirmApprove3(type,id,pno) {
		window.location = "TimesheetApproval3.cfm?id="+id+"&placementno="+pno;
	}
	
	</script>	
	<script src="/javascripts/tabber.js" type="text/javascript">
	</script>
    
    <cfoutput>
    <script type="text/javascript">
        var dts='#dts#';
		var dts2='#dts2#';
		var targetTable='#targetTable#';
		var huserid='#huserid#';
    </script>
    </cfoutput>
    
    <script type="text/javascript" src="/latest/customization/manpower_i/mpapproval/TimesheetApprovalMainT.js"></script>
    <script type="text/javascript" src="/latest/customization/manpower_i/mpapproval/TimesheetApprovalMainS.js"></script>

</head>

<body>
<cfoutput>
<div class="container">
	
    <h3>Timesheet Validation</h3>
    
	<div class="tabber">
	<div class="tabbertab">
		<h3>Approved for Validation</h3>
        <cfform method="post" action="TimesheetApprovalProcess.cfm">
		<table class="table table-bordered table-hover" id="resultTable" style="table-layout: fixed">
			<thead>
			</thead>
			<tbody>
			</tbody>
		</table>
        </cfform>
	</div>
    
    <div class="tabbertab">
	<h3>Validated</h3>
	<cfform method="post" action="process.cfm">	
    	<table class="table table-bordered table-hover" id="resultTable1" style="table-layout: fixed">
			<thead>
			</thead>
			<tbody>
			</tbody>
		</table>
    </cfform>
    </div>
    </div>
    
    
</div>
</cfoutput>
</body>
</html>