<html>
<head>
<title>View Assignment Slip Report</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
</head>
<body>
<cfoutput>
<cfform name="dump1" id="dump1" method="post" action="opprocess.cfm">
<h1>Employee Portal Records</h1>
<table>
<tr>
<th>Date From</th>
<td><cfinput type="text" name="datefrom" maxlength="10" validate="eurodate" size="10" required="yes" validateat="onsubmit" value="#dateformat(dateadd('m','-1',now()),'dd/mm/yyyy')#">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('datefrom'));"></td>
</tr>
<tr>
<th>Date to</th>
<td><cfinput type="text" name="dateto" maxlength="10" validate="eurodate" size="10" required="yes" validateat="onsubmit" value="#dateformat(now(),'dd/mm/yyyy')#">&nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('dateto'));"></td>
</tr>
<tr>
<td colspan="2"><input type="submit" name="sub_btn" id="sub_btn" value="Generate"></td>
</tr>
</table>
</cfform>
</cfoutput>
</body>
</html>
