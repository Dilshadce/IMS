<html>
<head>
<title>Product Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>

<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>

<cfquery name="getdealer_menu" datasource="#dts#">
	select * from dealer_menu
</cfquery>
</head>

<cfquery name="getgsetup" datasource='#dts#'>
  Select * from gsetup
</cfquery>

<body>

<cfoutput>
<h4>
<a href="attendancetable.cfm">Staff Sign In</a> || 

<a href="attendancetableout.cfm">Staff Sign Out</a>||

<a href="attendancereport.cfm">Staff Attendance Report</a>

</h4>
</cfoutput>
<h1 align="center">Staff Attendance</h1>

<cfform action="attendancereport2.cfm" name="form" method="post" target="_blank">
<cfoutput>
<input type="hidden" name="fromto" id="fromto" value="" />
  <input type="hidden" name="Tick" value="0">
  <table border="0" align="center" class="data">
  	<tr>
    <td nowrap colspan="2">
			<input type="radio" name="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT<br/>		</td>
    </tr>
    	<tr>
      	<td colspan="5"><hr></td>
    </tr>
 	<tr> 
    	<th>Date From</th>
        <td><input type="text" name="datefrom" value="#dateformat(now(),'DD/MM/YYYY')#" maxlength="10" size="11"> (DD/MM/YYYY)</td>
    </tr>
    <tr> 
        <th>Date To</th>
        <td><input type="text" name="dateto"  value="#dateformat(now(),'DD/MM/YYYY')#" maxlength="10" size="11"> (DD/MM/YYYY)</td>
    </tr>
    <tr>
    <td colspan="100%"><hr></td>
    </tr>
    <tr>
    <td colspan="100%"><div align="center">
          <input type="Submit" name="Submit" value="Submit">
      </div></td>
  </tr>
  
  </table>
</cfoutput>
</cfform>
</body>
</html>