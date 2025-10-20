<html>
<head>	
<title>Timesheet Approval</title>
<link rel="shortcut icon" href="/PMS.ico" />
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">	
<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen" >
<cfset dts2 = replace(dts,'_i','_p')>
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

function confirmDecline(type,id,pno) {
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
</head>
<body>
<cfoutput>

<cfquery name="company_details" datasource="payroll_main">
SELECT * FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>


    
<h3>Timesheet Validation</h3>
<div class="tabber">
	<div class="tabbertab">
		<h3>Approved for Validation</h3>
		
<!--- Submitted for approval --->
<cfform method="post" action="TimesheetApprovalProcess.cfm">
	<cfquery name="getempno" datasource="#dts#">
    SELECT placementno FROM placement WHERE (mppic = "#huserid#" or mpPIC2 = "#huserid#" or mpPicSp = "#huserid#")
    </cfquery>

	<cfquery name="getposlist" datasource="#dts#">
    SELECT * FROM(
    SELECT * FROM #dts2#.timesheet WHERE 
    status = "APPROVED" 
    AND placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getempno.placementno)#" separator="," list="yes">)
    GROUP BY empno, placementno, tmonth
    ORDER BY empno ) as a
    LEFT JOIN
    (
    SELECT empname,custname,custno,placementno as pno FROM placement
    ) as b
    on a.placementno = b.pno
    </cfquery>

<!--- <cfquery name="getposlist" datasource="#dts#">
	SELECT * FROM placement a INNER JOIN #dts2#.timesheet b on a.placementno = b.placementno 
    LEFT JOIN #dts2#.pmast c on a.empno = c.empno
    WHERE status IN ('Approved') 
    and (mppic = "#huserid#" or mpPIC2 = "#huserid#" or mpPicSp = "#huserid#")
    GROUP BY b.empno, a.placementno, tmonth
    ORDER BY b.empno
</cfquery> --->

<table align="center" width="100%">
    <tr>
        <th width="1%" valign="top"><center>No.</center></th>
        <th width="10%" valign="top"><div align="left">Employee</div></th>
        <th width="5%" valign="top"><div align="left">Placement No.</div></th>
         <th width="15%" valign="top"><div align="left">Customer</div></th>
        <th width="5%" valign="top"><center>Submited On</center></th>
        <th width="5%" valign="top"><center>Approved On</center></th>
        <th width="5%" valign="top"><center>Month</center></th>
        <th width="5%" valign="top"><center>Date Start</center></th>
        <th width="5%" valign="top"><center>Date End</center></th>
        <th width="5%" valign="top"><center>Timesheet</center></th>
       <!---  <th width="5%" valign="top"><center>Status</center></th> --->
        <th width="10%" valign="top"><center>HM Remarks</center></th>
        <th width="8%" valign="top"><center>Action</center></th>
        <th width="10%" valign="top"><center>Cancel<br>
Remarks</center></th>
    </tr> 
<center>
    <input type="hidden" name="id" id="id" value="#getposlist.id#">
    <cfinput type="hidden" name="rows" id="rows" value="#getposlist.CurrentRow#">
<cfloop query="getposlist">
<cfquery name="getflday" datasource="#dts#">
	SELECT min(pdate) as first,max(pdate) as last,tmonth,MGMTREMARKS FROM placement a INNER JOIN #dts2#.timesheet b on a.placementno = b.placementno 
    LEFT JOIN #dts2#.pmast c on b.empno = c.empno
    WHERE status IN ('Approved') and a.empno = '#getposlist.empno#' and a.placementno = '#getposlist.placementno#'
    AND tmonth = '#getposlist.tmonth#'
</cfquery>
  
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <td valign="top">#getposlist.CurrentRow#</td>
        <td valign="top">#getposlist.empno#<br>
#getposlist.empname#</td>
        <td valign="top" >#getposlist.placementno#</td>
        <td valign="top">#getposlist.custno#<br>
#getposlist.custname#</td>
        <td align="center" valign="top">#dateformat(getposlist.created_on,'dd/mm/yyyy')#</td>
        <td align="center" valign="top">#dateformat(getposlist.updated_on,'dd/mm/yyyy')#</td>
        <td align="center" valign="top">#monthasstring(getflday.tmonth)#</td>
        <td align="center" valign="top">#dateformat(getflday.first,'dd/mm/yyyy')#</td>
        <td align="center" valign="top">#dateformat(getflday.last,'dd/mm/yyyy')#</td>
        <td align="center" valign="top"><a href="TimesheetApprovalView.cfm?pno=#getposlist.placementno#&datestart=#dateformat(getflday.first,'yyyy-mm-dd')#&dateend=#dateformat(getflday.last,'yyyy-mm-dd')#&tmonth=#getflday.tmonth#" target="_blank">View</a></td>
<!---         <td align="center" valign="top">Pending</td> --->
        <td valign="top">#getflday.MGMTREMARKS#</td>
		<td align ="left" valign="top"><!---#getposlist.mgmtremarks#--->
        <table>
            <tr>

            <td valign="top">
                <a href="##" onclick="confirmApprove('app','#getposlist.tmonth#','#getposlist.placementno#')"><img height="30px" width="30px" src="/images/1.jpg" alt="Approve" border="0"><br/>Validate</a>
            </td>   
            <td valign="top">
            	 <a href="##" onclick="confirmDecline('dec','#getposlist.tmonth#','#getposlist.placementno#')"><img height="30px" width="30px" src="/images/2.jpg" alt="Approve" border="0"><br/>Cancel</a>
            </td>        
            </tr>
        </table>

<!---    <input type="checkbox" name="approvebox" id="approvebox#getposlist.tmonth#" value="#getposlist.tmonth#" onClick="if(this.checked == true){document.getElementById('rejectbox#getposlist.tmonth#').checked = false;}" <cfif getposlist.status eq "Approve">Checked</cfif>>Approve
    <input type="checkbox" name="rejectbox" id="rejectbox#getposlist.tmonth#"  value="#getposlist.tmonth#" onClick="if(this.checked == true){document.getElementById('approvebox#getposlist.tmonth#').checked = false;}" <cfif getposlist.status eq "Reject">Checked</cfif>>Reject
    <cfinput type="text" name="mgmtremarks#getposlist.tmonth#" id="mgmtremarks#getposlist.tmonth#" value="#getposlist.mgmtremarks#" size="30" maxlength="50">
--->    <input type="hidden" name="looprem" id="looprem" value="#getposlist.tmonth#">
    <input type="hidden" name="placementno" id="placementno" value="#getposlist.placementno#">
   </td>
<!---        <td align="center">#dateformat(getposlist.updated_on,"dd/mm/yyyy") & timeformat(getposlist.updated_on," hh:mmtt")#</td>--->
<td><textarea name="management_#getposlist.tmonth#_#getposlist.placementno#" id="management_#getposlist.tmonth#_#getposlist.placementno#" cols="15" rows="3" required></textarea></td>
    </tr>

</cfloop>
    <tr><td colspan=12><br></td></tr>
<!---	<tr><td align="right" colspan="11">Total Submitted For Approval = #numberformat(total1,',.__')#</td></tr>--->

<table><tr><td align="center">
<!---    <input type="submit" name="sub_btn" id="sub_but" value="Save & Submit">
---><!---    <select name="paymonth" id="paymonth">
        <cfloop from = "0" to = "11" index="m">
        <option value="#dateformat(dateadd("m",m,date),"mmm yyyy")#">#dateformat(dateadd("m",m,date),"mmm yyyy")#</option>
        </cfloop>
    </select>--->
</td></tr></table>

</center>
</table> 
</cfform>
</div>      
   
   <!--- Updated to Payroll --->     
<div class="tabbertab">
	<h3>Validated</h3>
	<cfform method="post" action="process.cfm">	
	<table align="center" width="100%">
    <cfquery name="getposlist" datasource="#dts#">
    SELECT * FROM(
    SELECT * FROM #dts2#.timesheet WHERE 
    status = "Validated" 
    AND placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getempno.placementno)#" separator="," list="yes">)
    GROUP BY empno, placementno, tmonth
    ORDER BY empno ) as a
    LEFT JOIN
    (
    SELECT empname,custname,custno,placementno as pno FROM placement
    ) as b
    on a.placementno = b.pno
    </cfquery>
    
	    <tr>
        <th width="1%" valign="top"><center>No.</center></th>
        <th width="10%" valign="top"><div align="left">Employee</div></th>
        <th width="5%" valign="top"><div align="left">Placement No.</div></th>
         <th width="15%" valign="top"><div align="left">Customer</div></th>
        <th width="5%" valign="top"><center>Submited On</center></th>
        <th width="5%" valign="top"><center>Approved On</center></th>
        <th width="5%" valign="top"><center>Validated On</center></th>
        <th width="5%" valign="top"><center>Month</center></th>
        <th width="5%" valign="top"><center>Date Start</center></th>
        <th width="5%" valign="top"><center>Date End</center></th>
        <th width="5%" valign="top"><center>Timesheet</center></th>
        <!--- <th width="5%" valign="top"><center>Status</center></th> --->
        <th width="10%" valign="top"><center>HM Remarks</center></th>
        <th width="10%" valign="top"><center>MP Remarks</center></th>
    </tr> 

	<center>
        <input type="hidden" name="id" id="id" value="#getposlist.id#">
	<cfinput type="hidden" name="rows" id="rows" value="#getposlist.CurrentRow#">
	    <cfloop query="getposlist">
        <cfquery name="getflday" datasource="#dts#">
            SELECT min(pdate) as first,max(pdate) as last,tmonth FROM placement a INNER JOIN #dts2#.timesheet b on a.placementno = b.placementno 
            LEFT JOIN #dts2#.pmast c on b.empno = c.empno
            WHERE status IN ('Validated') and a.empno = '#getposlist.empno#' and a.placementno = '#getposlist.placementno#'
            AND tmonth = '#getposlist.tmonth#'
        </cfquery>
	    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
            <td>#getposlist.CurrentRow#</td>
            <td valign="top">#getposlist.empno#<br>
#getposlist.empname#</td>
        <td valign="top" >#getposlist.placementno#</td>
        <td valign="top">#getposlist.custno#<br>
#getposlist.custname#</td>
            <td align="center" valign="top">#dateformat(getposlist.created_on,'dd/mm/yyyy')#</td>
            <td align="center" valign="top">#dateformat(getposlist.updated_on,'dd/mm/yyyy')#</td>
            <td align="center" valign="top">#dateformat(getposlist.validated_on,'dd/mm/yyyy')#</td>
            <td align="center" valign="top">#monthasstring(getflday.tmonth)#</td>
            <td align="center" valign="top">#dateformat(getflday.first,'dd/mm/yyyy')#</td>
            <td align="center" valign="top">#dateformat(getflday.last,'dd/mm/yyyy')#</td>
            <td align="center" valign="top"><a href="TimesheetApprovalView.cfm?pno=#getposlist.placementno#&datestart=#dateformat(getflday.first,'yyyy-mm-dd')#&dateend=#dateformat(getflday.last,'yyyy-mm-dd')#&tmonth=#getflday.tmonth#" target="_blank">View</a></td>
            <!--- <td align="center" valign="top">Approved<!--- #getposlist.status# ---></td> --->
           <!---  <td align="center"> <cfif getposlist.signdoc neq ''><a href="#getposlist.signdoc#" target="_blank">View</a></cfif></td> --->
            <td align ="left" valign="top">#getposlist.mgmtremarks#</td>
            <td>#getposlist.mpremarks#</td>
		</tr>
		</cfloop>
		<tr><td colspan=12><br></td></tr>
 		<!---<tr><td align="right" colspan="11" >Total Updated To Payroll = #numberformat(total2,',.__')#</td></tr> --->
	</center>
	</table> 
	</cfform>
    </div>
</div>

<!--- <cfwindow center="true" width="800" height="400" name="viewreceipt" title="Receipt" refreshOnShow="true"
            source="process.cfm?type=viewreceipt&id={id}" />  --->
</cfoutput>
</body>
</html>