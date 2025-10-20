
<head>
<title>Tiemsheet Report</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js">
</script>
    
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <link rel="stylesheet" href="/latest/css/jqueryui/smoothness/jquery-ui-1.10.3.custom.min.css" />
    <script type="text/javascript" src="/latest/js/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">

</head>
<cfoutput>
<body class="container">
<cfset dts_p=replace(dts,'_i', '_p')>

<cfquery name="getemplist" datasource="#dts_p#">
SELECT * FROM pmast 
ORDER BY empno
</cfquery>

<cfquery name="getworkhour" datasource="#dts_p#">
SELECT workhours FROM timesheet 
WHERE workhours<>0.00 
GROUP BY workhours 
ORDER BY length(workhours),workhours
</cfquery>

<cfform class="formContainer form2Button" name="form" action="listtimesheetreport.cfm">
<table border="0" align="center" width="80%" class="data">
	<tr>
    	<th>
        	Employee
        </th>
    	<td>
        	From
        </td>
        <td colspan="2">
            <select name="empfrom" id="empfrom" >
                <option value="">Choose an Employee</option>
                <cfloop query="getemplist">
                <option value="#empno#">#empno# - #name#</option>
                </cfloop>
            </select>
        </td>
    </tr>
    <tr>
    	<th>
        	Employee
        </th>
    	<td>
        	To
        </td>
        <td colspan="2">
          <select name="empto" id="empto" >
              <option value="">Choose an Employee</option>
              <cfloop query="getemplist">
              <option value="#empno#">#empno# - #name#</option>
              </cfloop>
          </select>
        </td>
    </tr>
    <!---<tr>
    	<th>
        	Work Hour (/day)
        </th>
    	<td></td>
        <td colspan="2">
          <select name="empfrom" id="empfrom" >
              <option value="">Choose an work hours</option>
              <cfloop query="getworkhour">
              <option value="#workhours#">#workhours#</option>
              </cfloop>
          </select>
        </td>
    </tr>--->
    <tr>
    	<td colspan="4"><hr></td>
    </tr>
    <!---<tr>
    	<th>
        	Submission status
        </th>
    	<td>        	
        </td>
        <td>
            <select name="timesheetstatus" id="timesheetstatus" >
                <option value="Submitted">Submitted</option>
                <option value="Not Submit">Not Submit</option>                                                
            </select>
        </td>
    </tr>--->
    <tr>
    	<th>
        	Month
        </th>
        <td>
        From
        </td>
    	<td>
            <select name="monthfrom" id="monthfrom">
            	<option value="">Please choose a month</option>
            <cfloop from="1" to="12" index="a">
            <option value="#a#">#dateformat(createdate(year(now()),'#a#','1'),'mmmm')#</option>
            </cfloop>
            </select>
        </td>
    </tr>   
    <tr>
    	<th>
        	Month
        </th>
        <td>
        To
        </td>
    	<td>
            <select name="monthto" id="monthto">
            	<option value="">Please choose a month</option>
            <cfloop from="1" to="12" index="a">
            <option value="#a#">#dateformat(createdate(year(now()),'#a#','1'),'mmmm')#</option>
            </cfloop>
            </select>
        </td>
    </tr>   
    <tr>        
        <td colspan="3" align="center"><input type="submit" name="subbtn" id="subbtn" value="HTML"></td>		
        
    </tr>
</table>
</cfform>
</body>
</cfoutput>