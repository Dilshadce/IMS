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
		<cfif form.project neq "">
		and t.source='#form.project#'
		</cfif>
		<cfif form.job neq "">
		and t.job='#form.job#'
		</cfif> 
		ORDER BY p.porj desc,p.source
	</cfquery>
	
	<cfxml variable="data">
	<?mso-application progid="Excel.Sheet"?>
	<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
	<Styles>
		<Style ss:ID="Default" ss:Name="Normal">
			<Alignment ss:Vertical="Bottom"/>
			<Borders/>
			<Font/>
			<Interior/>
			<NumberFormat/>
			<Protection/>
		</Style>
		<Style ss:ID="s23">
			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="8" ss:Color="#000000"/>
		</Style>
		<Style ss:ID="s24">
			<Alignment ss:Vertical="Bottom"/>
			<Font x:Family="Swiss" ss:Bold="1"/>
		</Style>
		<Style ss:ID="s25">
			<Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
			<Borders/>
			<Font ss:FontName="Verdana" x:Family="Swiss" ss:Size="8" ss:Color="#000000" ss:Bold="1"/>
		</Style>
		<Style ss:ID="s27">
			<Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
			<Borders/>
			<Font x:Family="Swiss" ss:Bold="1"/>
		</Style>
	</Styles>
	<Worksheet ss:Name="Telemarketing_List">
		<Table x:FullColumns="1" x:FullRows="1">
			<Row>
				<Cell ss:MergeAcross="8" ss:StyleID="s27"><Data ss:Type="String">Telemarketing List</Data></Cell>
				<Cell ss:StyleID="s24"/>
			</Row>
			<Row>
				<Cell ss:StyleID="s25"><Data ss:Type="String">Job Code</Data></Cell>
				<Cell ss:StyleID="s25"><Data ss:Type="String">Job Desc</Data></Cell>
				<Cell ss:StyleID="s25"><Data ss:Type="String">Project Code</Data></Cell>
				<Cell ss:StyleID="s25"><Data ss:Type="String">Project Desc</Data></Cell>
				<Cell ss:StyleID="s25"><Data ss:Type="String">Sex</Data></Cell>
				<Cell ss:StyleID="s25"><Data ss:Type="String">Name</Data></Cell>
				<Cell ss:StyleID="s25"><Data ss:Type="String">Contact</Data></Cell>
				<Cell ss:StyleID="s25"><Data ss:Type="String">Reference</Data></Cell>
				<Cell ss:StyleID="s25"><Data ss:Type="String">CustNo</Data></Cell>
			</Row>
			<cfoutput query="getData">
				<Row>
					<cfwddx action = "cfml2wddx" input = "#getData.job_code#" output = "wddxText">
					<Cell ss:StyleID="s23"><Data ss:Type="String">#wddxText#</Data></Cell>
					<cfwddx action = "cfml2wddx" input = "#getData.Job_Desc#" output = "wddxText">
					<Cell ss:StyleID="s23"><Data ss:Type="String">#wddxText#</Data></Cell>
					<cfwddx action = "cfml2wddx" input = "#getData.Project_Code#" output = "wddxText">
					<Cell ss:StyleID="s23"><Data ss:Type="String">#wddxText#</Data></Cell>
					<cfwddx action = "cfml2wddx" input = "#getData.Project_Desc#" output = "wddxText">
					<Cell ss:StyleID="s23"><Data ss:Type="String">#wddxText#</Data></Cell>
					<cfwddx action = "cfml2wddx" input = "#getData.Sex#" output = "wddxText">
					<Cell ss:StyleID="s23"><Data ss:Type="String">#wddxText#</Data></Cell>
					<cfwddx action = "cfml2wddx" input = "#getData.name#" output = "wddxText">
					<Cell ss:StyleID="s23"><Data ss:Type="String">#wddxText#</Data></Cell>
					<cfwddx action = "cfml2wddx" input = "#getData.Contact#" output = "wddxText">
					<Cell ss:StyleID="s23"><Data ss:Type="String">#wddxText#</Data></Cell>
					<cfwddx action = "cfml2wddx" input = "#getData.Reference#" output = "wddxText">
					<Cell ss:StyleID="s23"><Data ss:Type="String">#wddxText#</Data></Cell>
					<cfwddx action = "cfml2wddx" input = "#getData.custno#" output = "wddxText">
					<Cell ss:StyleID="s23"><Data ss:Type="String">#wddxText#</Data></Cell>
				</Row>
			</cfoutput>		   		
		</Table>
	</Worksheet>
	</Workbook>
	</cfxml>
	<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#\telemarketing_list_#huserid#.xls" output="#tostring(data)#">
	<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#\telemarketing_list_#huserid#.xls">
<cfelse>
	<html>
	<head>
	<title>Telemarketing Print</title>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	</head>
	
	<body>
	
	<h1>Telemarketing - Print Filter Page</h1>
	<h4><a href="telemarketing.cfm?searchtype=&searchstr=">Telemarketing Main Menu</a></h4>
		
	<cfquery name="getProject" datasource="#dts#">
		select 
		source,
		project 
		from project 
		where porj='P' 
		order by source;
	</cfquery>
		
	<cfquery name="getJob" datasource="#dts#">
		select 
		source,
		project 
		from project 
		where porj='J' 
		order by source;
	</cfquery>
			
	<form action="telemarketing_excel.cfm" target="_blank" method="post">
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
	
	</body>
	</html>
</cfif>