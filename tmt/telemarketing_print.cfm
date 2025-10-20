<html>
<head>
<title>Telemarketing Print</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfif isdefined("form.submit")>
	<cfquery name="getData" datasource="#dts#">
		select 
		t.job as job_code,
		j.project as job_desc,
		p.source as project_code,
		p.project as project_desc,
		t.sex,
		t.name,
		t.contact,
		t.reference,
		a.custno
		from telemarketinglist t 
		left join project p on p.source=t.source and p.porj='P'
		left join project j on j.source=t.job and j.porj='J'
		left join 
		(
			select 
			custno,
			name,
			attn,
			phonea 
			from #target_arcust#
			order by custno
		) as a on t.contact like a.phonea
		where t.deleted='0' 
		<cfif form.project neq "">and t.source='#form.project#'</cfif>
		<cfif form.job neq "">and t.job='#form.job#'</cfif> 
		ORDER BY p.porj desc,p.source
	</cfquery>
	
	<table align="center" width="90%">
		<tr>
			<th width="9%">Job Code</th>
			<th width="18%">Job Desc</th>
			<th width="9%">Project Code</th>
			<th width="18%">Project Desc</th>
			<th width="6%">Sex</th>
			<th>Name</th>
			<th width="10%">Contact</th>
			<th width="10%">Reference</th>
			<th>CustNo</th>
		</tr>
		<cfoutput query="getData">
		<tr>
			<td>#Job_Code#</td>
			<td>#Job_Desc#</td>
			<td>#Project_Code#</td>
			<td>#Project_Desc#</td>
			<td>#Sex#</td>
			<td>#Name#</td>
			<td>#Contact#</td>
			<td>#Reference#</td>
			<td>#custno#</td>
		</tr>
		</cfoutput>
	</table>
<cfelse>
	<h1>Telemarketing - Print Filter Page</h1>
	<h4><a href="telemarketing.cfm?searchtype=&searchstr=">Telemarketing Main Menu</a></h4>
	
	<cfquery datasource="#dts#" name="getProject">
		select 
		source,
		project 
		from project 
		where porj='P' 
		order by source
	</cfquery>
		
	<cfquery datasource="#dts#" name="getJob">
		select 
		source,
		project 
		from project 
		where porj='J' 
		order by source
	</cfquery>
	
	<form action="telemarketing_print.cfm" target="_blank" method="post">
		<table border="0" align="center" width="80%" class="data">
			<tr>
				<th width="16%">Project</th>
				<td width="5%"></td>
				<td colspan="2">
				<select name="project">
					<option value="">Choose a Project</option>
					<cfoutput query="getProject"><option value="#source#">#source# - #project#</option></cfoutput>
				</select>
				</td>
			</tr>
			<tr><td colspan="5"><hr></td></tr>
			<tr>
				<th width="16%">Job</th>
				<td width="5%"></td>
				<td colspan="2">
				<select name="job">
					<option value="">Choose a Job</option>
					<cfoutput query="getJob"><option value="#source#">#source# - #project#</option></cfoutput>
				</select>
				</td>
			</tr>
			<tr><td colspan="5"><hr></td></tr>
			<tr>
				<td colspan="5" width="10%" align="right"><input type="Submit" name="Submit" value="Submit"></td>
			</tr>
			</table>
	</form>
</cfif>

</body>
</html>