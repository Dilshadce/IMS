<html>
<head>
<title>Update Transaction Project</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
	
<script type="text/javascript">
	function updateProject(refno,itemcount){
		var projbybill=document.getElementById("projbybill").value;
		var tran=document.getElementById("tran").value;
		var source=document.getElementById("source_"+refno+"_"+itemcount).value;
		var job=document.getElementById("job_"+refno+"_"+itemcount).value;
		if(projbybill=='N'){
			var gltradac=document.getElementById("gltradac_"+refno+"_"+itemcount).value;
		}
		else{
			var gltradac='';
		}
		document.getElementById("row_"+refno+"_"+itemcount).style.backgroundColor = 'red';
		DWREngine._execute(_tranflocation, null, 'updateProject', projbybill, tran, escape(refno), itemcount, source, job, gltradac, showResult);	
	}
		
	function showResult(FieldObject){	
		document.getElementById("row_"+FieldObject.REFNO+"_"+FieldObject.ITEMCOUNT).style.backgroundColor  = '';
	}
</script>
</head>
<body>

<cfparam name="tran" default="INV">
<cfparam name="refno" default="">
<cfoutput>
	<cfparam name="datefrom" default="#dateformat(now(),'dd/mm/yyyy')#">
	<cfparam name="dateto" default="#dateformat(now(),'dd/mm/yyyy')#">
</cfoutput>

<cfif datefrom neq "">
	<cfset date1 = createDate(ListGetAt(datefrom,3,"/"),ListGetAt(datefrom,2,"/"),ListGetAt(datefrom,1,"/"))>
<cfelse>
	<cfset date1 = createDate(year(now()),month(now()),day(now()))>
</cfif>

<cfif dateto neq "">
	<cfset date2 = createDate(ListGetAt(dateto,3,"/"),ListGetAt(dateto,2,"/"),ListGetAt(dateto,1,"/"))>
<cfelse>
	<cfset date2 = createDate(year(now()),month(now()),day(now()))>
</cfif>

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfquery name="getProject" datasource="#dts#">
	select * from project where porj = "P" order by source
</cfquery>
	
<cfquery name="getJob" datasource="#dts#">
	select * from project where porj = "J" order by source
</cfquery>

<cfif getgsetup.projectbybill eq "1">
	<cfset projbybill="Y">
	<cfquery datasource='#dts#' name="getData">
		Select a.type,a.refno,a.custno,a.name,a.source as xsource,a.job,0 as itemcount
		from artran a
		where (void = '' or void is null) and type='#tran#'
		<cfif refno neq "" and refno neq "Reference No">
			and a.refno like '%#refno#%'
		</cfif>
		<cfif datefrom neq "" and dateto neq "">
			and a.wos_date between #date1# and #date2#
		</cfif>
		order by a.wos_date desc,a.refno desc
	</cfquery>
<cfelse>
	<cfset projbybill="N">
	<cfquery datasource='#dts#' name="getData">
		Select a.type,a.refno,a.custno,a.name,a.source as xsource,a.job,a.gltradac,itemcount,itemno
		from ictran a
		where (void = '' or void is null) and type='#tran#'
		<cfif refno neq "" and refno neq "Reference No">
			and a.refno like '%#refno#%'
		</cfif>
		<cfif datefrom neq "" and dateto neq "">
			and a.wos_date between #date1# and #date2#
		</cfif>
		order by a.wos_date desc,a.refno desc,a.itemcount
	</cfquery>
</cfif>


<form name="itemform" action="" method="post">
	<cfoutput>
		<input type="hidden" name="projbybill" id="projbybill" value="#projbybill#">
		<input type="hidden" name="tran" id="tran" value="#tran#">
	</cfoutput>
	<table align="center" class="data" width="80%">							
		<tr>
			<th>Type</th>
			<th>Reference No.</th>
			<th>Customer No</th>
			<th>Name</th>
			<cfif projbybill eq "N"><th>Item No</th></cfif>
			<th>Project</th>
			<th>Job</th>
			<cfif projbybill eq "N"><th>GL A/C</th></cfif>
			<th>Action</th>
		</tr>
		<cfoutput query="getData">
			<tr id="row_#getData.refno#_#getData.itemcount#" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td>#getData.type#</td>
				<td>#getData.refno#</td>
				<td>#getData.custno#</td>
				<td>#getData.name#</td>
				<cfif projbybill eq "N"><td>#getData.itemno#</td></cfif>
				<td>
					<select name="source_#getData.refno#_#getData.itemcount#" id="source_#getData.refno#_#getData.itemcount#">
						<option value="">Choose a Project</option>
		          		<cfloop query="getProject">
		            		<option value="#getProject.source#"<cfif getData.xsource eq getProject.source>Selected</cfif>>#getProject.source#</option>
		          		</cfloop>
					</select>
				</td>
				<td>
					<select name="job_#getData.refno#_#getData.itemcount#" id="job_#getData.refno#_#getData.itemcount#">
						<option value="">Choose a Job</option>
		          		<cfloop query="getJob">
		            		<option value="#getJob.source#"<cfif getData.job eq getJob.source>Selected</cfif>>#getJob.source#</option>
		          		</cfloop>
					</select>
				</td>
				<cfif projbybill eq "N">
					<td>
						<input type="text" name="gltradac_#getData.refno#_#getData.itemcount#" id="gltradac_#getData.refno#_#getData.itemcount#" value="#getData.gltradac#" size="10">
					</td>
				</cfif>
				<td>
					<img src="/images/userdefinedmenu/iedit.gif" alt="Save" style="cursor: hand;" onclick="updateProject('#getData.refno#','#getData.itemcount#');">
					<cfif projbybill eq "Y">
						<img src="/images/userdefinedmenu/view.gif" alt="Update GL A/C" style="cursor: hand;" onclick="window.location.href='s_updateproject2.cfm?tran=#getData.type#&refno=#getData.refno#';">
					</cfif>
				</td>
			</tr>
		</cfoutput>
	</table>
</form>
</body>
</html>
