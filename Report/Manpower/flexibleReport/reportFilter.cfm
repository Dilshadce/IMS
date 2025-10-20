<html>
<head>
<title>Report Filter Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">

<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<script src="/scripts/CalendarControl.js" language="javascript"></script>
<cfajaximport tags="cfwindow,cflayout-tab"> 

</head>

<cfquery name="getreport" datasource="#dts#">
	select * from flexireport where id = "#url.reportid#"
</cfquery>
    
<cfquery name="getComp_qry" datasource="payroll_main">
	SELECT * FROM gsetup WHERE comp_id = "#rereplace(HcomID,'_i','')#"
</cfquery>

<cfset filterlist = "Customer,Employee,Pay Period,Placement No,Assignment No,Contract Signed Date,Contract Start Date,Contract End Date,Consultant,Project,Job Code,User ID">

<cfoutput>
<body>
<cfform action="report.cfm?reportid=#url.reportid#" method="post" name="form123" target="_blank">
<h3>
	<a><font size="2">Print #getreport.reporttitle#</font></a>
</h3>
<br><br>

<table border="0" align="center" width="80%" class="data" style="dis">
	<cfloop list="#filterlist#" delimiters="," index="i">
    	<cfif i eq "Customer">
        	<cfif getreport.fcustomer eq 'y' or getreport.fplacement eq 'y' or getreport.fassignment eq 'y'>
            	<cfset display = "table-row">
            <cfelse>
            	<cfset display = "none">
            </cfif>
        <cfelseif i eq "Employee">
        	<cfif getreport.femployee eq 'y' or getreport.fplacement eq 'y' or getreport.fassignment eq 'y'>
            	<cfset display = "table-row">
            <cfelse>
            	<cfset display = "none">
            </cfif>
        <cfelseif i eq "Pay Period">
        	<cfif getreport.fassignment eq 'y'>
            	<cfset display = "table-row">
            <cfelse>
            	<cfset display = "none">
            </cfif>
        <cfelseif i eq "Placement No">
        	<cfif getreport.fplacement eq 'y' or getreport.fassignment eq 'y'>
            	<cfset display = "table-row">
            <cfelse>
            	<cfset display = "none">
            </cfif>
        <cfelseif i eq "Assignment No" or i eq "User ID">
        	<cfif getreport.fassignment eq 'y'>
            	<cfset display = "table-row">
            <cfelse>
            	<cfset display = "none">
            </cfif>
        <cfelseif i eq "Contract Start Date" or i eq "Contract End Date" or i eq "Contract Signed Date">
        	<cfif getreport.fplacement eq 'y'>
            	<cfset display = "table-row">
            <cfelse>
            	<cfset display = "none">
            </cfif>
        <cfelse>
        	<cfset display = "none">
        </cfif>
            
        <cfif findnocase('Date',i) eq 0 or i neq "Pay Period">
        <cfquery name="getdata" datasource="#dts#"  >       	 
            select	<!---<cfif i eq "Customer">
                        custno as data1, name as data2 
                    <cfelseif i eq "Employee">         
                        empno as data1, name as data2
                    <cfelseif i eq "Pay Period">  --->       
                        distinct payrollperiod as data1
                    <!---<cfelseif i eq "Placement No"> 
                        placementno as data1
                    <cfelseif i eq "Assignment No">
                        refno as data1
                    <cfelseif i eq "Consultant">    
                        agent as data1, desp as data2
                    <cfelseif i eq "Project">
                        source as data1, project as data2
                    <cfelseif i eq "Job Code">   
                        driverno as data1, name as data2      
                    <cfelse>
                        userid as data1
                    </cfif>--->
            from    <!---<cfif i eq "Customer">
                        #target_arcust#
                    <cfelseif i eq "Employee">
                        #replace(dts,'_i','_p')#.pmast
                    <cfelseif i eq "Placement No"> 
                        placement
                    <cfelseif i eq 'Pay Period' or i eq "Assignment No">--->
                        assignmentslip    
                    <!---<cfelseif i eq "Consultant">    
                        #target_icagent#
                    <cfelseif i eq "Project">
                        #target_project#
                    <cfelseif i eq "Job Code">   
                        driver          
                    <cfelse>
                        main.users where userbranch = "#dts#" and usergrpid <> "super"
                    </cfif>
            <cfif i eq "Customer">
                where custno IN (SELECT custno FROM assignmentslip WHERE year(assignmentslipdate)=#getComp_qry.myear#)
            <cfelseif i eq "Employee">
                where empno IN (SELECT empno FROM assignmentslip WHERE year(assignmentslipdate)=#getComp_qry.myear#)
            <cfelseif i eq "Placement No"> 
                where placementno IN (SELECT placementno FROM assignmentslip WHERE year(assignmentslipdate)=#getComp_qry.myear#)
            <cfelseif i eq 'Pay Period' or i eq "Assignment No">
                
            <cfelseif i eq "Consultant">    

            <cfelseif i eq "Project">

            <cfelseif i eq "Job Code">   

            <cfelse>
                AND userid IN (SELECT created_by FROM assignmentslip WHERE year(assignmentslipdate)=#getComp_qry.myear#)
            </cfif>--->
            order by	<!---<cfif i eq "Customer">
                            name
                        <cfelseif i eq "Employee">
                            name
                        <cfelseif i eq "Pay Period">--->
                            length(payrollperiod),payrollperiod
                        <!---<cfelseif i eq "Assignment No">
                            refno
                        <cfelseif i eq "Placement No"> 
                            placementno
                        <cfelseif i eq "Consultant">    
                            agent
                        <cfelseif i eq "Project">
                            source
                        <cfelseif i eq "Job Code">   
                            driverno
                        <cfelse>
                            userid
                        </cfif>--->
        </cfquery>
        </cfif>
			        
		<cfif findnocase('Date',i) neq 0>
        	<tr style="display:#display#">
                <th width="20%">#i#</th>
                <td width="30%">
                    From
                    &nbsp;&nbsp;&nbsp;
                    <input type="text" id="fr#replace(i, ' ', '_', 'all')#" name="fr#replace(i, ' ', '_','all')#" validate="eurodate" width="100%">
                    &nbsp;&nbsp;&nbsp;
                    <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(fr#replace(i, ' ', '_', 'all')#);">(DD/MM/YYYY)
                </td>
                <td width="30%">
                    To
                    &nbsp;&nbsp;&nbsp;
                    <input type="text" id="to#replace(i, ' ', '_', 'all')#" name="to#replace(i, ' ', '_', 'all')#" validate="eurodate" width="100%">
                    &nbsp;&nbsp;&nbsp;
                    <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(to#replace(i, ' ', '_', 'all')#);">(DD/MM/YYYY)
                </td>
            </tr>
        <cfelse>
            <tr style="display:#display#">
                <th width="20%">#i#</th>
                <td width="30%">
                    From
                    &nbsp;&nbsp;&nbsp;
                    <cfif i eq "Pay Period">
                        <select style="width:50%" id="fr#replace(i, ' ', '_', 'all')#" name="fr#replace(i, ' ', '_', 'all')#">
                            <option value="">Please select a #lcase(i)#</option>
                            <cfloop query="getdata">
                                <option value="#getdata.data1#">#getdata.data1#<cfif isdefined('getdata.data2')> - #getdata.data2#</cfif></option>
                            </cfloop>
                        </select>
                    <cfelse>
                        <input type="text" style="width:50%" id="fr#replace(i, ' ', '_', 'all')#" name="fr#replace(i, ' ', '_', 'all')#">
                    </cfif>
                    
                    
                    <cfif i neq 'Pay Period'>
                        &nbsp;&nbsp;&nbsp;
                        <input type="Button" value="Search" onClick="openSearch('#i#', 'fr#replace(i, ' ', '_', 'all')#', 'to#replace(i, ' ', '_', 'all')#')">
                    </cfif>
                </td>
                <td width="30%">
                    To
                    &nbsp;&nbsp;&nbsp;
                    <cfif i eq "Pay Period">
                        <select style="width:50%" id="to#replace(i, ' ', '_', 'all')#" name="to#replace(i, ' ', '_', 'all')#">
                            <option value="">Please select a #lcase(i)#</option>
                            <cfloop query="getdata">
                                <option value="#getdata.data1#">#getdata.data1#<cfif isdefined('getdata.data2')> - #getdata.data2#</cfif></option>
                            </cfloop>
                        </select>
                    <cfelse>
                        <input type="text" style="width:50%" id="to#replace(i, ' ', '_', 'all')#" name="to#replace(i, ' ', '_', 'all')#">
                    </cfif>
                    
                    <cfif i neq 'Pay Period'>
                        &nbsp;&nbsp;&nbsp;
                        <input type="Button" value="Search" onClick="openSearch('#i#', 'to#replace(i, ' ', '_', 'all')#', 'to#replace(i, ' ', '_', 'all')#')">
                    </cfif>
                </td>
            </tr>
        </cfif> 
    </cfloop>    
    <tr>
    	<td colspan="3"><br><br/></td>
    </tr>
	<tr>
    	<td colspan="3">
        	<div align="center">
                <input type="Submit" name="Submit" value="HTML">
                &nbsp;&nbsp;&nbsp;
                <input type="Submit" name="Submit" value="EXCEL">
                &nbsp;&nbsp;&nbsp;
                <input type="Button" value="Cancel" onClick="window.close()">
            </div>
        </td>
    </tr>
</table>
</cfform>

<script type="text/javascript">
var type="";
var input="";
var toInput="";

function openSearch(newType, newInput, newToinput){
	type = newType;
	input = newInput;
	toInput = newToinput;
		
	switch(type){
		case 'Customer':
			ColdFusion.Window.show('searchCust');
			break;
		case 'Employee':
			ColdFusion.Window.show('searchEmp');
			break;
		case 'Placement No':
			ColdFusion.Window.show('searchPlace');
			break;
		case 'Assignment No':
			ColdFusion.Window.show('searchAssign');
			break;
		case 'Consultant':
			ColdFusion.Window.show('searchConsult');
			break;
		case 'Project':
			ColdFusion.Window.show('searchProject');
			break;
		case 'Job Code':
			ColdFusion.Window.show('searchJob');
			break;
		case 'User ID':
			ColdFusion.Window.show('searchUser');
			break;
		default:
			alert(1); 
	}
}

function setSelect(data){
	switch(type){
		case 'Customer':
			ColdFusion.Window.hide("searchCust");
			break;
		case 'Employee':
			ColdFusion.Window.hide('searchEmp');
			break;
		case 'Placement No':
			ColdFusion.Window.hide('searchPlace');
			break;
		case 'Assignment No':
			ColdFusion.Window.hide('searchAssign');
			break;
		case 'Consultant':
			ColdFusion.Window.hide('searchConsult');
			break;
		case 'Project':
			ColdFusion.Window.hide('searchProject');
			break;
		case 'Job Code':
			ColdFusion.Window.hide('searchJob');
			break;
		case 'User ID':
			ColdFusion.Window.hide('searchUser');
			break;
		default:
			alert(1); 
	}
    
    document.getElementById(input).value = data;
    document.getElementById(toInput).value = data;
    
	/*var selectLength = document.getElementById(input).length;
	
	for(i=0;i<selectLength;i++){
		if(document.getElementById(input).options[i].value == data){
			document.getElementById(input).selectedIndex = i;
			document.getElementById(toInput).selectedIndex = i;
			break;
		}
        if(i == selectLength-1){
            alert("No Assignmentslips Created on the Selected "+type);
        }
	}*/
}
</script>
</body>
</cfoutput>
</html>

<cfwindow center="true" width="600" height="400" name="searchCust" refreshOnShow="true"closable="true" modal="false" title="Search Customer" initshow="false" source="search.cfm?type=customer" />

<cfwindow center="true" width="600" height="400" name="searchEmp" refreshOnShow="true"closable="true" modal="false" title="Search Employee" initshow="false" source="search.cfm?type=employee" />

<cfwindow center="true" width="600" height="400" name="searchPlace" refreshOnShow="true"closable="true" modal="false" title="Search Placement No" initshow="false" source="search.cfm?type=placement" />

<cfwindow center="true" width="600" height="400" name="searchAssign" refreshOnShow="true"closable="true" modal="false" title="Search Assignment No" initshow="false" source="search.cfm?type=assignment" />

<cfwindow center="true" width="600" height="400" name="searchConsult" refreshOnShow="true"closable="true" modal="false" title="Search Consultant" initshow="false" source="search.cfm?type=consultant" />

<cfwindow center="true" width="600" height="400" name="searchProject" refreshOnShow="true"closable="true" modal="false" title="Search Project" initshow="false" source="search.cfm?type=project" />

<cfwindow center="true" width="600" height="400" name="searchJob" refreshOnShow="true"closable="true" modal="false" title="Search Job" initshow="false" source="search.cfm?type=jobcode" />

<cfwindow center="true" width="600" height="400" name="searchUser" refreshOnShow="true"closable="true" modal="false" title="Search User" initshow="false" source="search.cfm?type=user" />