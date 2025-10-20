
<head>
<title>Tiemsheet Report</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<!---<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
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
    <cfinclude template="/CFC/LastDayOfMonth.cfm">--->
    
    <link rel="stylesheet" href="/latest/css/jqueryui/smoothness/jquery-ui-1.10.3.custom.min.css" />
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>

	<cfinclude template="filterEmployee.cfm">
	<cfinclude template="filterCustomer.cfm">
    <cfinclude template="/latest/date/datePickerFunction.cfm"> 
    <cfinclude template="/CFC/LastDayOfMonth.cfm">


</head>
<cfoutput>
<body class="container">
<!---<cfset dts_p=replace(dts,'_i', '_p')>

<cfquery name="getemplist" datasource="#dts_p#" cachedWithin="#CreateTimeSpan(0,0,2,0)#">
SELECT empno,name FROM pmast 
ORDER BY empno
</cfquery>

<cfquery name="getcustlist" datasource="#dts#" cachedWithin="#CreateTimeSpan(0,0,2,0)#">
SELECT custno,name FROM arcust 
ORDER BY name
</cfquery>

<cfquery name="getworkhour" datasource="#dts_p#">
SELECT workhours FROM timesheet 
WHERE workhours<>0.00 
GROUP BY workhours 
ORDER BY length(workhours),workhours
</cfquery>
--->
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
            <!---<select name="empfrom" id="empfrom" >
                <option value="">Choose an Employee</option>
                <cfloop query="getemplist">
                <option value="#empno#">#empno# - #name#</option>
                </cfloop>
            </select>--->
            <input type="text" name="empfrom" id="empfrom" class="employeeFilter">
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
          <!---<select name="empto" id="empto" >
              <option value="">Choose an Employee</option>
              <cfloop query="getemplist">
              <option value="#empno#">#empno# - #name#</option>
              </cfloop>
          </select>--->
          <input type="text" name="empto" id="empto" class="employeeFilter">
        </td>
    </tr>
    <tr>
    	<th>
        	Client
        </th>
    	<td>
        	From
        </td>
        <td colspan="2">
            <!---<select name="clientfrom" id="clientfrom" >
                <option value="">Choose an Client</option>
                <cfloop query="getcustlist">
                <option value="#custno#">#custno# - #name#</option>
                </cfloop>
            </select>--->
            <input type="text" name="clientfrom" id="clientfrom" class="customerFilter">
        </td>
    </tr>
    <tr>
    	<th>
        	Client
        </th>
    	<td>
        	To
        </td>
        <td colspan="2">
          <!---<select name="clientto" id="clientto" >
              <option value="">Choose an Client</option>
              <cfloop query="getcustlist">
              <option value="#custno#">#custno# - #name#</option>
              </cfloop>
          </select>--->
           <input type="text" name="clientto" id="clientto"  class="customerFilter" >
        </td>
    </tr>      
    <tr>        
        <td colspan="3" align="center"><input type="submit" name="subbtn" id="subbtn" value="HTML"></td>		
        
    </tr>
</table>
</cfform>
</body>
</cfoutput>