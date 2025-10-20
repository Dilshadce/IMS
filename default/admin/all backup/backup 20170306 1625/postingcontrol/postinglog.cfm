<html>
<head>
<title>Posting Log</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<h1 align="center">Posting Log</h1>
<cfoutput>
<h3 align="center">
<a href="armcancel.cfm">Cancel Import Arm</a>&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;<a href="postinglog.cfm">Posting Log</a>||&nbsp;&nbsp;&nbsp;<a href="postinglogreport.cfm">Posting Log Report</a><cfif hlinkams eq "Y">&nbsp;&nbsp;&nbsp;||&nbsp;&nbsp;&nbsp;<a href="postingcheck.cfm">Check Inexistence at AMS</a></cfif>
</h3>
</cfoutput><cfform name="userlog" method="post" action="">
<table align="center">
<tr>
					<td>
						Filer By: <cfselect id="filtercolumn" name="filtercolumn" bind="cfc:posting.getlogColumns('#dts#')"
							display="ColumnName" value="ColumnName" bindOnLoad="true" />
						Filter Text: <cfinput type="text" id="filter" name="filter">
						<cfinput type="button" name="filterbutton" value="Go" id="filterbutton"
							onclick="ColdFusion.Grid.refresh('usersgrid',false)">
					</td>
					
				</tr>
<tr><td>

<cfgrid name="usersgrid" pagesize="10" format="html" height="255"
bind="cfc:posting.getlog({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{filtercolumn},{filter},'#dts#')" selectmode="row">
	<cfgridcolumn name="action" header="Action" width="150">
    <cfgridcolumn name="billtype" header="Bill TYPE" width="50" >
    <cfgridcolumn name="actiondata" header="Bill List" width="300" >
    <cfgridcolumn name="user" header="User " width="100">
    <cfgridcolumn name="timeaccess" header="Time Accessed" width="200">
</cfgrid>
</td>
</tr>

</table></cfform>
</body>
</html>