<cfsavecontent variable="actionLink">
	<a href="telemarketing_action.cfm?mode=edit&entryno=#entryno#&page=#begin_page#&list=#records_per_page#"><img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a>
	<a href="telemarketing_action.cfm?mode=delete&entryno=#entryno#&page=#begin_page#&list=#records_per_page#"><img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>
</cfsavecontent>

<cfsavecontent variable="qStr">
	select 
	t.entryno,
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
		from <cfoutput>#target_arcust#</cfoutput>
		order by custno
	) as a on t.contact like a.phonea
	
	where t.deleted='0' 
	<cfif searchtype neq "" and searchstr neq "">
	and <cfoutput>t.#searchtype# like '#searchstr#'</cfoutput>
	</cfif>
	ORDER BY p.porj desc,p.source
</cfsavecontent>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Telemarketing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
	function check_keyword()
	{
		if(document.getElementById("searchtype").value=="" && document.getElementById("searchstr").value!="")
		{
			alert("Please Select Search Type !");
			return false;
		}
		else
		{
			return true;
		}
	}
</script>

</head>

<body>
	<h1>Telemarketing Main Menu</h1>
	<h4>
		<a href="telemarketing_action.cfm?mode=create&page=&list=">Create New</a> || 
		<a href="telemarketing_action.cfm?mode=print">Print</a> ||
		<a href="telemarketing_action.cfm?mode=excel">Export To Excel Format</a> ||
	</h4>
	
	<cfif isdefined("url.status")>
		<h3><cfoutput>#url.status#</cfoutput></h3>
	</cfif>
	
	<cfoutput>
		<form action="telemarketing.cfm" method="post" onSubmit="javascript:return check_keyword();">
			<h1>Search By :
			<select name="searchtype">
				<option value="" <cfif searchtype eq "">selected</cfif>>-</option>
				<option value="Contact" <cfif searchtype eq "Contact">selected</cfif>>Contact No.</option>
			</select>
			Search for #searchtype#: 
			<input type="text" name="searchstr" value="#searchstr#"> 
			</h1>
		</form>
	</cfoutput>
	
	<cf_table
		searchtype="#searchtype#"
		searchstr="#searchstr#"
        QueryName="getCollectionN"
        DataSource="#dts#"
		QString="#variables.qStr#"
        TableFieldList="Job_Code!!7%||Job_Desc!!15%||Project_Code!!7%||Project_Desc!!15%||Sex!!5%||Name!!15%||Contact!!9%||Reference!!10%||Custno"
		ActionButton="#actionLink#">
</body>
</html>