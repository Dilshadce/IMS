<cfoutput>

<cfset type = urldecode(url.type)>

<cfset condition = "where 1=1">  

<cfif type eq "customer">
	<cfset column = 'custno as data, name'>
	<cfset table = '#target_arcust#'> 
 	
    <cfif url.search1 neq "" and url.search2 neq "">
    	<cfset condition = condition & " and custno like @%#url.search1#%@ and name like @%#url.search2#%@">
    <cfelseif url.search1 neq "">
    	<cfset condition = condition & " and custno like @%#url.search1#%@">
    <cfelseif url.search2 neq "">
    	<cfset condition = condition & " and name like @%#url.search2#%@">
    </cfif>
<cfelseif type eq "employee">
	<cfset column = 'empno as data, name'>
    <cfset table = 'beps_p.pmast'>
    
    <cfif url.search1 neq "" and url.search2 neq "">
    	<cfset condition = condition & " and empno like @%#url.search1#%@ and name like @%#url.search2#%@">
    <cfelseif url.search1 neq "">
    	<cfset condition = condition & " and empno like @%#url.search1#%@">
    <cfelseif url.search2 neq "">
    	<cfset condition = condition & " and name like @%#url.search2#%@">
    </cfif>    
<cfelseif type eq "placement">
	<cfset column = 'placementno as data, placementdate'>
    <cfset table = 'placement'>
        
    <cfif url.search1 neq "" and url.search2 neq "">
    	<cfset condition = condition & " and placementno like @%#url.search1#%@">
    <cfelseif url.search1 neq "">
    	<cfset condition = condition & " and placementno like @%#url.search1#%@">
    <cfelseif url.search2 neq "">
    	<cfset condition = condition & " and placementno like @%#url.search2#%@">
    </cfif>	
<cfelseif type eq "assignment">
	<cfset column = 'refno as data, assignmentslipdate'>
    <cfset table = 'assignmentslip'>
    <cfset condition = "where refno like @%#url.search1#%@">
    
    <cfif url.search1 neq "" and url.search2 neq "">
    	<cfset condition = condition & " and refno like @%#url.search1#%@">
    <cfelseif url.search1 neq "">
    	<cfset condition = condition & " and refno like @%#url.search1#%@">
    <cfelseif url.search2 neq "">
    	<cfset condition = condition & " and refno like @%#url.search2#%@">
    </cfif>		
<cfelseif type eq "consultant">
	<cfset column = 'agent as data, desp'>
	<cfset table = '#target_icagent#'>
   	
    <cfif url.search1 neq "" and url.search2 neq "">
    	<cfset condition = condition & " and agent like @%#url.search1#%@ and desp like @%#url.search2#%@">
    <cfelseif url.search1 neq "">
    	<cfset condition = condition & " and agent like @%#url.search1#%@">
    <cfelseif url.search2 neq "">
    	<cfset condition = condition & " and desp like @%#url.search2#%@">
    </cfif>  
<cfelseif type eq 'project'>
	<cfset column = 'source as data, project'>
	<cfset table = '#target_project#'>
    <cfset condition = "where source like @%#url.search1#%@ or project like @%#url.search2#%@">
    
    <cfif url.search1 neq "" and url.search2 neq "">
    	<cfset condition = condition & " and source like @%#url.search1#%@ and project like @%#url.search2#%@">
    <cfelseif url.search1 neq "">
    	<cfset condition = condition & " and source like @%#url.search1#%@">
    <cfelseif url.search2 neq "">
    	<cfset condition = condition & " and project like @%#url.search2#%@">
    </cfif>
<cfelseif type eq "jobcode">
	<cfset column = 'driverno as data, name'>
	<cfset table = 'driver'>
    <cfset condition = "where driverno like @%#url.search1#%@ or name like @%#url.search2#%@">
    
    <cfif url.search1 neq "" and url.search2 neq "">
    	<cfset condition = condition & " and driverno like @%#url.search1#%@ and name like @%#url.search2#%@">
    <cfelseif url.search1 neq "">
    	<cfset condition = condition & " and driverno like @%#url.search1#%@">
    <cfelseif url.search2 neq "">
    	<cfset condition = condition & " and name like @%#url.search2#%@">
    </cfif>
<cfelseif type eq "user">
	<cfset column = 'userid as data'>
    <cfset table = "main.users where userbranch = @beps_i@ and usergrpid <> @super@">
    
	<cfif url.search1 neq "" and url.search2 neq "">
    	<cfset table = table & " and userid like @%#url.search1#%@ and userid like @%#url.search2#%@">
    <cfelseif url.search1 neq "">
    	<cfset table = table & " and userid like @%#url.search1#%@">
    <cfelseif url.search2 neq "">
    	<cfset table = table & " and userid like @%#url.search2#%@">
    </cfif>
</cfif>

<cfquery name="getdata" datasource="#dts#">
	select #column#
    from #replace(table, "@", "'", "all")#
    #replace(condition, "@", "'", "all")#
</cfquery>

<!---<form action="" method="post">
	<cfif type eq "customer">	
        Cust No <input type="text" id="search1" name="search1" value="" />
        Name <input type="text" id="search2" name="search2" value="" />
    <cfelseif type eq "employee">
        Emp No <input type="text" id="search1" name="search1" value="" />
        Name <input type="text" id="search2" name="search2" value="" />
    <cfelseif type eq "placement">
        Placement No <input type="text" id="search1" name="search1" value="" />
        <!---Contract Sign Date <input type="text" id="search2" name="search2" value="" />--->
    <cfelseif type eq "assignment">
        Assignment No <input type="text" id="search1" name="search1" value="" />
        <!---Assignment Date <input type="text" id="search2" name="search2" value="" />--->
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
        <!---User Name <input type="text" id="search2" name="search2" value="" />--->
    </cfif>
    <input type="button" id="search" name="search" value="Search" onclick="ajaxFunction1(document.getElementById('searchResult'),'searchAjax.cfm?type=#type#&search1='+document.getElementById('search1').value+'&search2='+document.getElementById('search2').value)" />
</form>--->

<!---<div id="searchResult">--->
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
<!---</div>--->

</cfoutput>