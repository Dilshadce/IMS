<cfoutput>

<cfset type = urldecode(url.type)>
    
<cfquery name="getComp_qry" datasource="payroll_main">
	SELECT * FROM gsetup WHERE comp_id = "#rereplace(HcomID,'_i','')#"
</cfquery>

<cfif type eq "customer">
	<cfset column = 'custno as data, name'>
	<cfset table = '#target_arcust#'>	
<cfelseif type eq "employee">
	<cfset column = 'empno as data, name'>
    <cfset table = "#replace(dts,'_i','_p')#.pmast">	    
<cfelseif type eq "placement">
	<cfset column = 'placementno as data, placementdate'>
    <cfset table = 'placement'>
<cfelseif type eq "assignment">
	<cfset column = 'refno as data, assignmentslipdate'>
    <cfset table = 'assignmentslip'>
<cfelseif type eq "consultant">
	<cfset column = 'agent as data, desp'>
	<cfset table = '#target_icagent#'>
<cfelseif type eq 'project'>
	<cfset column = 'source as data, project'>
	<cfset table = '#target_project#'>
<cfelseif type eq "jobcode">
	<cfset column = 'driverno as data, name'>
	<cfset table = 'driver'>
<cfelseif type eq "user">
	<cfset column = 'userid as data'>
    <cfset table = "main.users where userbranch = @#dts#@ and usergrpid <> @super@"> 
</cfif>

<cfquery name="getdata" datasource="#dts#">
	select #column#
    from #replace(table, "@", "'", "all")#
    limit 20
</cfquery>

<form action="" method="post">
	<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <cfif type eq "customer">	
        Cust No <input type="text" id="search1" name="search1" value="" />
        Name <input type="text" id="search2" name="search2" value="" />
    <cfelseif type eq "employee">
        Emp No <input type="text" id="search1" name="search1" value="" />
        Name <input type="text" id="search2" name="search2" value="" />
    <cfelseif type eq "placement">
        Placement No <input type="text" id="search1" name="search1" value="" />
        <!---Contract Sign Date---> <input type="hidden" id="search2" name="search2" value="" />
    <cfelseif type eq "assignment">
        Assignment No <input type="text" id="search1" name="search1" value="" />
        <!---Assignment Date---> <input type="hidden" id="search2" name="search2" value="" />
    <cfelseif type eq "consultant">
        Consultant <input type="text" id="search1" name="search1" value="" />
        Description <input type="text" id="search2" name="search2" value="" />
    <cfelseif type eq 'project'>
        Project ID <input type="text" id="search1" name="search1" value="" />
        Description <input type="text" id="search2" name="search2" value="" />
    <cfelseif type eq "jobcode">
        Job Code <input type="text" id="search1" name="search1" value="" />
        Description <input type="text" id="search2" name="search2" value="" />
    <cfelseif type eq "user">
        User ID <input type="text" id="search1" name="search1" value="" />
        <!---User Name---> <input type="hidden" id="search2" name="search2" value="" />
    </cfif>
    <input type="button" id="search" name="search" value="Search" onclick="ajaxFunction1(document.getElementById('searchResult'),'searchAjax.cfm?type=#type#&search1='+document.getElementById('search1').value+'&search2='+document.getElementById('search2').value)" />
</form>

<br/>
<div id="searchResult">
<table width="90%" align="center">
	<tr>
		<cfif type eq "customer">
			<th>Cust No</th>
            <th>Name</th>
        <cfelseif type eq "employee">
           	<th>Emp No</th>
            <th>Name</th> 
        <cfelseif type eq "placement">
            <th>Placement No</th>
            <th>Contract Sign Date</th>
        <cfelseif type eq "assignment">
            <th>Assignment No</th>
            <th>Assignment Date</th>
        <cfelseif type eq "consultant">
           	<th>Consultant</th>
            <th>Description</th>
        <cfelseif type eq 'project'>
            <th>Project ID</th>
            <th>Description</th>
        <cfelseif type eq "jobcode">
            <th>Job Code</th>
            <th>Description</th>
        <cfelseif type eq "user">
            <th>User ID</th>
            <th><!---User Name---></th>
        </cfif>
        <th>Action</th>
    </tr>
    <cfloop query="getdata">
    	<tr>
			<cfif type eq "customer">
                <td>#getdata.data#</td>
                <td>#getdata.name#</td>
            <cfelseif type eq "employee">
                <td>#getdata.data#</td>
                <td>#getdata.name#</td> 
            <cfelseif type eq "placement">
                <td>#getdata.data#</td>
                <td>#dateformat(getdata.placementdate, 'dd-mm-yyyy')#</td>
            <cfelseif type eq "assignment">
                <td>#getdata.data#</td>
                <td>#dateformat(getdata.assignmentslipdate, 'dd-mm-yyyy')#</td>
            <cfelseif type eq "consultant">
                <td>#getdata.data#</td>
                <td>#getdata.desp#</td>
            <cfelseif type eq 'project'>
                <td>#getdata.data#</td>
                <td>#getdata.project#</td>
            <cfelseif type eq "jobcode">
                <td>#getdata.data#</td>
                <td>#getdata.name#</td>
            <cfelseif type eq "user">
                <td>#getdata.data#</td>
                <td></td>
            </cfif>
            <td>
            	<a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="setSelect('#getdata.data#')">Select</a>
            </td>
        </tr>
    </cfloop>
</table>
</div>

</cfoutput>