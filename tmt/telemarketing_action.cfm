<cfset entryno="">
<cfset sjob="">
<cfset sproject="">
<cfset ssex="">
<cfset sname="">
<cfset scontact="">
<cfset sreference="">
<cfset status="">

<cfswitch expression="#url.mode#">
	<cfcase value="create">
		<cfif isdefined("form.entryno")>
			<cftry>
				<cfquery name="insertData" datasource="#dts#">
					insert into telemarketinglist (job,source,sex,name,contact,reference,userid) 
					values ('#form.job#','#form.project#','#form.sex#','#form.name#','#form.contact#','#form.reference#','#HUserID#')
				</cfquery>
				<cfset status="Successfully Insert (#form.job#,#form.project#,#form.sex#,#form.name#,#form.contact#,#form.reference#).">
				<cfcatch type="any">
					<cfset status="Failed To Insert. Error Msg: #cfcatch.message#">
				</cfcatch>
			</cftry>
			<cflocation url="telemarketing_action.cfm?mode=create&status=#variables.status#&page=1&list=#url.list#" addtoken="no">
		</cfif>
	</cfcase>
	<cfcase value="edit">
		<cfif isdefined("form.entryno")>
			<cftry>
				<cfquery name="updateData" datasource="#dts#">
					update telemarketinglist set 
					job='#form.job#',
					source='#form.project#',
					sex='#form.sex#',
					name='#form.name#',
					contact='#form.contact#',
					reference='#form.reference#',
					userid='#HUserID#'
					where entryno='#form.entryno#' and deleted='0'
				</cfquery>
				<cfset status="Successfully Update.">
				<cfcatch type="any">
					<cfset status="Failed To Update. Error Msg: #cfcatch.message#">
				</cfcatch>
			</cftry>
			<cflocation url="telemarketing.cfm?status=#variables.status#&page=#url.page#&list=#url.list#" addtoken="no">
		<cfelse>
			<cfquery name="getData" datasource="#dts#">
				select * from telemarketinglist where entryno='#url.entryno#'
			</cfquery>
			<cfset entryno=url.entryno>
			<cfset sjob=getData.job>
			<cfset sproject=getData.source>
			<cfset ssex=getData.sex>
			<cfset sname=getData.name>
			<cfset scontact=getData.contact>
			<cfset sreference=getData.reference>
		</cfif>
	</cfcase>
	<cfcase value="delete">
		<cftry>
			<cfquery name="updateData" datasource="#dts#">
				update telemarketinglist set deleted='1' where entryno='#url.entryno#' and deleted='0'
			</cfquery>
			<cfset status="Successfully Delete.">
			<cfcatch type="any">
				<cfset status="Failed To Delete. Error Msg: #cfcatch.message#">
			</cfcatch>
		</cftry>
		<cflocation url="telemarketing.cfm?status=#variables.status#&page=#url.page#&list=#url.list#" addtoken="no">
	</cfcase>
	<cfcase value="print"><cflocation url="telemarketing_print.cfm" addtoken="no"></cfcase>
	<cfcase value="excel"><cflocation url="telemarketing_excel.cfm" addtoken="no"></cfcase>
</cfswitch>

<cfquery name="getJob" datasource="#dts#">
	select source,project from project where porj='J' order by source
</cfquery>
<cfquery name="getProject" datasource="#dts#">
	select source,project from project where porj='P' order by source
</cfquery>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Telemarketing - Action Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript">
function validation(){
	if(document.getElementById("job").value==''){
		alert("Please select a job.");document.getElementById("job").focus();
		return false;
	}
	/*else if(document.getElementById("project").value==''){
		alert("Please select a Project.");document.getElementById("project").focus();
		return false;
	}*/
	return true;
}
function init(){
	document.tform.job.focus();
}
</script>
</head>
<cfoutput>
<body onLoad="init()">
	<h1>Telemarketing - #ucase(url.mode)# Page</h1>
	<h4><a href="telemarketing.cfm?searchtype=&searchstr=">Telemarketing Main Menu</a></h4>
	<cfif isdefined("url.status")><h3><cfoutput>#url.status#</cfoutput></h3></cfif>
	<form name="tform" action="telemarketing_action.cfm?mode=#mode#&page=#url.page#&list=#url.list#" method="post" onSubmit="return validation()">
	<input type="hidden" name="entryno" value="#variables.entryno#">
	<table class="data">
	<tr>
		<th>Job</th>
		<td>
		<select name="job">
		<option value="">Please select</option>
		<cfloop query="getJob"><option value="#source#" #IIF(getJob.source eq variables.sjob,DE("selected"),DE(""))#>#source# - #project#</option></cfloop>
		</select>
		</td>
	</tr>
	<tr>
		<th>Project</th>
		<td>
		<select name="project">
		<option value="">Please select</option>
		<cfloop query="getProject"><option value="#source#" #IIF(getProject.source eq variables.sproject,DE("selected"),DE(""))#>#source# - #project#</option></cfloop>
		</select>
		</td>
	</tr>
	<tr>
		<th>Sex</th>
		<td><input type="text" name="sex" size="10" maxlength="8" value="#variables.ssex#"></td>
	</tr>
	<tr>
		<th>Name</th>
		<td><input type="text" name="name" size="40" maxlength="127" value="#variables.sname#"></td>
	</tr>
	<tr>
		<th>Contact</th>
		<td><input type="text" name="contact" size="40" maxlength="45" value="#variables.scontact#"></td>
	</tr>
	<tr>
		<th>Reference</th>
		<td><input type="text" name="reference" size="40" maxlength="255" value="#variables.sreference#"></td>
	</tr>
	<tr>
		<td colspan="2" align="right"><input type="submit" name="submit" value="Submit"></td>
	</tr>
	</table>
	</form>
</body>
</cfoutput>
</html>
