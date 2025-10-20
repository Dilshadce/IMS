
<head>
<title>Timesheet Report</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
    
    <link rel="stylesheet" href="/latest/css/jqueryui/smoothness/jquery-ui-1.10.3.custom.min.css" />
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/jqueryui/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>

	<cfinclude template="filterEmployee.cfm">
	<cfinclude template="filterCustomer.cfm">

</head>
<cfoutput>
<body class="container">
<cfquery name="comp_detail" datasource="payroll_main">
    SELECT mmonth, myear FROM gsetup WHERE comp_id = "#ListFirst(getHQstatus.userBranch, '_')#"
</cfquery>

<p><h2>Timesheet Reports</h2></p>
<cfform class="formContainer form2Button" name="form" id="form" action="listtimesheetreport.cfm">
<table border="0" align="center" width="100%" class="data">
	<tr>
    	<th>
        	Employee
        </th>
    	<td>
        	From
        </td>
        <td colspan="2">
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
           <input type="text" name="clientto" id="clientto"  class="customerFilter" >
        </td>
    </tr>
    <tr>
    	<th>
        	Month
        </th>
    	<td>
        	:
        </td>
        <td colspan="2">
            <select name="reportmonth" id="reportmonth">
                <cfloop from="1" to="12" index="month">
                    <option value="#month#" <cfif #month# EQ #comp_detail.mmonth#>Selected</cfif>>#MonthAsString(month)#</option>                    
                </cfloop>
            </select>
        </td>
    </tr>
    <tr>
    	<th>
        	Year
        </th>
    	<td>
        	:
        </td>
        <td colspan="2">
            <select name="reportyear" id="reportyear">
                <cfloop from="2017" to="#comp_detail.myear#" index="year">
                    <option value="#year#" <cfif #year# EQ #comp_detail.myear#>Selected</cfif>>#year#</option>                    
                </cfloop>
            </select>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <p style="color: red">Choose client or employee for filter else it will generate all.</p>
        </td>
    </tr>      
    <tr>        
        <td colspan="3" align="center">
        <input type="submit" name="subbtn" id="subbtn" value="HTML">&nbsp;&nbsp;&nbsp; 
        </td>		
        
    </tr>
</table>
</cfform>

<p><h2>Timesheet View</h2></p>
<cfform class="formContainer form2Button" name="form2" id="form2" action="timesheetPrint.cfm" target="_blank">
<table border="0" align="center" width="100%" class="data">
    <tr>
    	<th>
        	Client
        </th>
    	<td>
        	From
        </td>
        <td colspan="2">
            <input type="text" name="fromClient" id="fromClient" class="customerFilter">
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
           <input type="text" name="toClient" id="toClient"  class="customerFilter" >
        </td>
    </tr>
    
    <tr>
    	<th>
        	Employee
        </th>
    	<td>
        	From
        </td>
        <td colspan="2">
          <input type="text" name="fromEmp" id="fromEmp" class="employeeFilter">
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
          <input type="text" name="toEmp" id="toEmp" class="employeeFilter">
        </td>
    </tr> 
    <tr>
        <th>
            Client
        </th>
        <td>
            List
        </td>
        <td colspan="2">
          <input name="custlist" id="custlist" type="text" style="max-width: 350px;" size="90"
                                       placeholder="300033881,300033991,300033771,300033111,...">
        </td>
    </tr> 
    <tr>
        <th>
            Employee
        </th>
        <td>
            List
        </td>
        <td colspan="2">
          <input name="emplist" id="emplist" type="text" style="max-width: 350px;" size="90"
                                       placeholder="100130476,100131212,100131229,100131215,...">
        </td>
    </tr> 
    <tr>
        <th>
            Employee
        </th>
        <td>
            Excluding
        </td>
        <td colspan="2">
          <input name="filteremplist" id="filteremplist" type="text" style="max-width: 350px;" size="90"
                                       placeholder="100130476,100131212,100131229,100131215,...">
        </td>
    </tr>      
    
    <tr>
        <th>
            Filter Type
        </th>
        <td colspan="2">
            <cfquery name="getstatus" datasource="#Replace(dts, '_i', '_p')#">
                SELECT status FROM timesheet GROUP BY status
            </cfquery>
            
            <cfloop query="getstatus">
                <input type="checkbox" name="status" id="status" value="#getstatus.status#"><cfif "#getstatus.status#" EQ "">
                    SAVED
                <cfelse>
                    #UCase(getstatus.status)#
                </cfif>
                <cfif "#getstatus.currentrow#" NEQ "#getstatus.recordcount#"><br/></cfif>
            </cfloop>
        </td>
    </tr>
    
    <tr>
    	<th>
        	Month
        </th>
    	<td>
        	:
        </td>
        <td colspan="2">
            <select name="monthselected" id="selected">
                <cfloop from="1" to="12" index="month">
                    <option value="#month#" <cfif #month# EQ #comp_detail.mmonth#>Selected</cfif>>#MonthAsString(month)#</option>                    
                </cfloop>
            </select>
        </td>
    </tr>

    <tr>
    	<th>
        	Year
        </th>
    	<td>
        	:
        </td>
        <td colspan="2">
            <select name="yearselected" id="yearselected">
                <cfloop from="2016" to="#comp_detail.myear#" index="year">
                    <option value="#year#" <cfif #year# EQ #comp_detail.myear#>Selected</cfif>>#year#</option>                    
                </cfloop>
            </select>
        </td>
    </tr>
   
    <tr>        
        <td colspan="3" align="center">
            <input type="submit" name="subbtn" id="subbtn" value="Generate Timesheet">
        </td>
    </tr>

    <tr>
        <td colspan="3" align="center">
            <input type="submit" name="subbtn" id="subbtn2" value="Generate Excel Timesheet" onClick="document.form2.action = 'timesheetExcel.cfm';">
            <input type="submit" name="subbtn" id="subbtn3" value="Generate Excel OT" onClick="document.form2.action = 'timesheetExcel.cfm';">
        </td>
    </tr>
    
</table>
</cfform>

</body>
</cfoutput>