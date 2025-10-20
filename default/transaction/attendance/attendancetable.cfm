<html>
<title>Staff Attendance</title>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<head>

<script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>

<script type="text/javascript">
function checkpassword()
	{
	if(document.getElementById('cashierlist').value == '' || document.getElementById('cashierpasswordhash').value == '')
	{
	alert('Pls Key in cashier and password');
	}
	else
	{
	if(document.getElementById('cashierpasswordhash').value == document.getElementById('hidcashierpassword').value)
    {
        choosecounter.submit();
    }
    else
    {
    alert('Wrong cashier or password');
    }
	};
	}
</script>
</head>

<h4>
<a href="attendancetable.cfm">Staff Sign In</a> || 

<a href="attendancetableout.cfm">Staff Sign Out</a>||

<a href="attendancereport.cfm">Staff Attendance Report</a>

</h4>

<body>

<cfquery name="checksigninstaff" datasource="#dts#">
select * from (select a.cashier,ifnull(b.countlogin,0) as countlogin,ifnull(c.countlogout,0) as countlogout from staffattendance as a

left join (select count(cashier) as countlogin,cashier from staffattendance where wos_date='#dateformat(now(),'yyyy-mm-dd')#' and logintype="login" group by cashier)as b on a.cashier=b.cashier

left join (select count(cashier) as countlogout,cashier from staffattendance where wos_date='#dateformat(now(),'yyyy-mm-dd')#' and logintype="logout" group by cashier)as c on a.cashier=c.cashier

where wos_date='#dateformat(now(),'yyyy-mm-dd')#'
group by cashier)as aa
where countlogin-countlogout > 0
</cfquery>

<cfset stafflist=valuelist(checksigninstaff.cashier)>

<cfquery name="getsigninstaff" datasource="#dts#">
select cashierid as cashier,name from cashier where cashierid not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#stafflist#">)
</cfquery>

<cfoutput>
<h1 align="center">Staff Sign In</h1>
<cfform name="choosecounter" id="choosecounter" action="attendancetableprocess.cfm" method="post">
<table align="center">
<tr>
<th width="100px">Cashier</th>
<td width="15px">:</td>
<td width="200px">
<!---<cfquery name="getcounter" datasource="#dts#">
SELECT "" as cashierid,"Choose a Cashier" as cashierdesp
union all
SELECT * from (
SELECT counterid, concat(counterid,' - ',counterdesp) as counterdesp FROM counter order by counterid) as a
</cfquery>
<cfquery name="getbond" datasource="#dts#">
Select counterid FROM counter WHERE bonduser = <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">
</cfquery>

<cfselect name="cashierlist" id="cashierlist" query="getcashier" value="counterid" display="counterdesp" selected="#getbond.counterid#">
</cfselect>
<cfinput type="text" name="cashierlist" id="cashierlist" value="" onBlur="ajaxFunction(document.getElementById('getpasswordajax'),'choosecashier2.cfm?cashierid='+document.getElementById('cashierlist').value);" required="yes" message="cashier cannot be empty">--->
<cfinput type="text" name="cashierlist" id="cashierlist" onBlur="ajaxFunction(document.getElementById('getpasswordajax'),'choosecashier2.cfm?cashierid='+document.getElementById('cashierlist').value);" required="yes" message="cashier cannot be empty">
<!---
<cfselect name="cashierlist" id="cashierlist" onChange="ajaxFunction(document.getElementById('getpasswordajax'),'choosecashier2.cfm?cashierid='+document.getElementById('cashierlist').value);" required="yes" message="cashier cannot be empty">
<option value="">Choose Staff</option>
<cfloop query="getsigninstaff">
<option value="#getsigninstaff.cashier#">#getsigninstaff.cashier# - #getsigninstaff.name#</option>
</cfloop>
</cfselect>
--->
</td>
</tr>
<tr>
<th>Password</th>
<td width="15px">:</td>
<td><cfinput type="password" name="cashierpassword" id="cashierpassword" value="" required="yes" message="Password cannot be empty">

</td>
</tr>
<tr>
<td colspan="3" align="center">
<input type="button" name="counter_btn" id="counter_btn" value="Login In" onClick="document.getElementById('logtype').value='login';ajaxFunction(document.getElementById('getpasswordajax2'),'choosecashier3.cfm?password='+document.getElementById('cashierpassword').value);setTimeout('checkpassword();',200);">
<!---&nbsp;&nbsp;&nbsp;<input type="button" name="counter_btn" id="counter_btn" value="Login Out" onClick="document.getElementById('logtype').value='logout';ajaxFunction(document.getElementById('getpasswordajax2'),'choosecashier3.cfm?password='+document.getElementById('cashierpassword').value);setTimeout('checkpassword();',200);">--->
<input type="hidden" name="logtype" id="logtype" value="" />
</td>
</tr>
<tr><td>
<div id="getpasswordajax2">
<input type="hidden" name="cashierpasswordhash" id="cashierpasswordhash" value="" required>
</div>
 <div id="getpasswordajax">
 <input type="hidden" name="hidcashierpassword" id="hidcashierpassword" value="">
 </div>
</td></tr>
</table>
</cfform>
</cfoutput>
</body>
</html>