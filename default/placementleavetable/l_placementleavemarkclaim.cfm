<html>
<head>
<title>Leave Claim Status Report</title>
<cfinclude template="/object/dateobject.cfm">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script type="text/javascript" src="/scripts/ajax.js"></script>
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControlbeps.js"></script>
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script type="text/javascript">

 function dateajaxfunction()
{
	getmark(document.getElementById('typefield').value);
}

function appearresult(response){
		document.getElementById("returnMsg").innerHTML = response;
		
		// First, determine how much the visitor has scrolled
		var scrolledX, scrolledY;
		if( self.pageYOffset ) {
			scrolledX = self.pageXOffset;
			scrolledY = self.pageYOffset;
		} else if( document.documentElement && document.documentElement.scrollTop ) {
			scrolledX = document.documentElement.scrollLeft;
			scrolledY = document.documentElement.scrollTop;
		} else if( document.body ) {
			scrolledX = document.body.scrollLeft;
			scrolledY = document.body.scrollTop;
		}
		// Next, determine the coordinates of the center of browser's window
		var centerX, centerY;
		if( self.innerHeight ) {
			centerX = self.innerWidth;
			centerY = self.innerHeight;
		} else if( document.documentElement && document.documentElement.clientHeight ) {
			centerX = document.documentElement.clientWidth;
			centerY = document.documentElement.clientHeight;
		} else if( document.body ) {
			centerX = document.body.clientWidth;
			centerY = document.body.clientHeight;
		}
		// Xwidth is the width of the div, Yheight is the height
		Xwidth = 260; Yheight = 100;
		var leftOffset = scrolledX + (centerX - Xwidth) / 2;
		var topOffset = scrolledY + (centerY - Yheight) / 2;
		// The initial width and height of the div can be set in the style sheet with display:none
		var o=document.getElementById("popupMsg");
		var r=o.style;
		r.position='absolute';
		r.top = topOffset + 'px';
		r.left = leftOffset + 'px';
		r.display = "block"; 
		
		window.setTimeout("closeMarkingMsg();", 3000);
	}
		
	
	function closeMarkingMsg(){
		document.getElementById("popupMsg").style.display="none";
	}
	
function getmark(id)
{
	var marked = document.getElementById('claimid'+id).checked;
	var leavedayid = document.getElementById('leaveday'+id).value;
	var leaveremark = document.getElementById('remark'+id).value;
	if(marked == true)
	{
		ajaxFunction(document.getElementById('markajax'),'markunmark.cfm?type=marked&id='+id+'&submitdate='+leavedayid+'&leaveremark='+escape(leaveremark));
	}
	else
	{
		ajaxFunction(document.getElementById('markajax'),'markunmark.cfm?type=nomarked&id='+id+'&submitdate='+leavedayid+'&leaveremark='+escape(leaveremark));
	}
	appearresult("Changes Done");
}
</script>
</head>

<cfquery name="getmonthyear" datasource="payroll_main">
SELECT myear,mmonth FROM gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
<cfset datelastnow = daysinmonth(createdate("#getmonthyear.myear#","#getmonthyear.mmonth#","1"))>
<cfset datenow = createdate("#getmonthyear.myear#","#getmonthyear.mmonth#","#datelastnow#")>
<cfquery name="getplacementlist" datasource="#dts#">
SELECT * FROM placement
WHERE 1=1
<cfif form.custfrom neq "" and form.custto neq "">
AND custno Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custfrom#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custto#">
</cfif>
<cfif form.departmentfrom neq "" and form.departmentto neq "">
AND department Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.departmentfrom#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.departmentto#">
</cfif>
<cfif form.supervisorfrom neq "" and form.supervisorto neq "">
AND supervisor Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.supervisorfrom#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.supervisorto#">
</cfif>
<cfif form.empfrom neq "" and form.empto neq "">
AND empno Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empfrom#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empto#">
</cfif>
ORDER BY custname,empname,custno
</cfquery>

<cfquery name="getclaimableleave" datasource="#dts#">
SELECT costcode from iccostcode where claimable = "Y"
<cfif form.leavetype neq "">
 and costcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.leavetype#">
</cfif>
</cfquery>

<cfquery name="getleavelist" datasource="#dts#">
SELECT * FROM (
SELECT leavetype, placementno,startdate,enddate,days,id,claimed,submit_date,claimremark FROM leavelist WHERE 
leavetype in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getclaimableleave.costcode)#" separator="," list="yes">) 
and placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getplacementlist.placementno)#" list="yes" separator=",">)
<cfif form.datefrom neq "" and form.dateto neq "">
and startdate BETWEEN "#dateformatnew(form.datefrom,'yyyy-mm-dd')#" and "#dateformatnew(form.dateto,'yyyy-mm-dd')#"
</cfif>
<cfif form.claimdatefrom neq "" and form.claimdateto neq "">
and submit_date BETWEEN "#dateformatnew(form.claimdatefrom,'yyyy-mm-dd')#" and "#dateformatnew(form.claimdateto,'yyyy-mm-dd')#"
</cfif>
<cfif form.result eq "marked">
and claimed = "Y"
<cfelseif form.result eq "nomarked">
and claimed = "N"
</cfif>
ORDER BY placementno, startdate) as a
LEFT JOIN
(SELECT empname, placementno as pno, nric,empno,custname from placement ) as b
on a.placementno = b.pno
LEFT JOIN
(SELECT desp, costcode FROM iccostcode) as c
on a.leavetype = c.costcode
</cfquery>

<body>
<cfoutput>
<div id="markajax">
</div>
<div align="center"><font color="##000000" size="3" face="Arial, Helvetica, sans-serif"><strong><cfoutput>Leave Claim Status Report</cfoutput></strong></font></div>
<cfset startcustno  = "">
<input type="hidden" name="typefield" id="typefield" value="">
    <table width="100%" class="" align="center" border="1">
      <tr>
      <th>Placement No</th>
      <th>Emp No</th>
      <th>Name</th>
      <th>Customer</th>
      <th>Leave Type</th>
      <th>Start Date</th>
      <th>End Date</th>
      <th>Days</th>
      <th>Submited</th>
      <th>Claim Date</th>
      <th>Remark</th>
      </tr> 
	  <cfloop query="getleavelist">
      <tr>
      <td>#getleavelist.placementno#</td>
      <td>#getleavelist.empno#</td>
      <td>#getleavelist.empname#</td>
      <td>#getleavelist.custname#</td>
	  <td>#getleavelist.desp#</td>
      <td>#dateformat(getleavelist.startdate, 'dd/mm/yyyy')#</td>
      <tD>#dateformat(getleavelist.enddate,'dd/mm/yyyy')#</tD>
      <td>#val(getleavelist.days)#</td>
      <td>
      <input type="checkbox" name="claimid" id="claimid#getleavelist.id#" onChange="getmark('#getleavelist.id#')" value="#getleavelist.id#" <cfif getleavelist.claimed eq "Y">Checked</cfif> >
      </td>
      <td>
      <input type="text" name="leaveday" id="leaveday#getleavelist.id#" onBlur="getmark('#getleavelist.id#')" value="#dateformat(getleavelist.submit_date, 'dd/mm/yyyy')#" size="12" readonly>&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="document.getElementById('typefield').value='#getleavelist.id#';showCalendarControl(document.getElementById('leaveday#getleavelist.id#'));">
      </td>
      <td>
      <input type="text" name="remark" id="remark#getleavelist.id#" onBlur="getmark('#getleavelist.id#')" value="#getleavelist.claimremark#">
      </td>
      </tr>
      </cfloop>
    </table>
  
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div> </cfoutput>
<form name="bankReconForm" id="bankReconForm">
<div id="popupMsg" style="display:none; width:260px; text-align:center;">
	<table width="100%" class="data">
		<tr>
			<td id="returnMsg" style="background-color:#FF0000 text-align:center; vertical-align:middle;"></td>
		</tr>
	</table>
</div>
<div id="outputTable" width="100%"></div>
</form>
    

</body>
</html>
