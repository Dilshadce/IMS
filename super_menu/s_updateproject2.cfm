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
		var projbybill='N';
		var tran=document.getElementById("tran").value;
		var source=document.getElementById("source_"+refno+"_"+itemcount).value;
		var job=document.getElementById("job_"+refno+"_"+itemcount).value;
		
		var gltradac=document.getElementById("gltradac_"+refno+"_"+itemcount).value;
		
		document.getElementById("row_"+refno+"_"+itemcount).style.backgroundColor = 'red';
		DWREngine._execute(_tranflocation, null, 'updateProject', projbybill, tran, escape(refno), itemcount, source, job, gltradac, showResult);	
	}
		
	function showResult(FieldObject){	
		document.getElementById("row_"+FieldObject.REFNO+"_"+FieldObject.ITEMCOUNT).style.backgroundColor  = '';
	}
</script>
</head>
<body>

<cfquery datasource='#dts#' name="getData">
	Select a.type,a.refno,a.custno,a.name,a.source as xsource,a.job,a.gltradac,itemcount,itemno
	from ictran a
	where (void = '' or void is null) 
	and type='#tran#' and refno='#refno#'
	order by a.itemcount
</cfquery>

<form name="itemform" action="" method="post">
	<cfoutput>
		<input type="hidden" name="tran" id="tran" value="#tran#">
	</cfoutput>
	<table align="center" class="data" width="80%">							
		<tr>
			<th>Type</th>
			<th>Reference No.</th>
			<th>Customer No</th>
			<th>Name</th>
			<th>Item No</th>
			<th>Project</th>
			<th>Job</th>
			<th>GL A/C</th>
			<th>Action</th>
		</tr>
		<cfoutput query="getData">
			<tr id="row_#getData.refno#_#getData.itemcount#" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td>#getData.type#</td>
				<td>#getData.refno#</td>
				<td>#getData.custno#</td>
				<td>#getData.name#</td>
				<td>#getData.itemno#</td>
				<td>
					<input type="text" name="source_#getData.refno#_#getData.itemcount#" id="source_#getData.refno#_#getData.itemcount#" value="#getData.xsource#" disabled>
				</td>
				<td>
					<input type="text" name="job_#getData.refno#_#getData.itemcount#" id="job_#getData.refno#_#getData.itemcount#" value="#getData.job#" disabled>
				</td>
				<td>
					<input type="text" name="gltradac_#getData.refno#_#getData.itemcount#" id="gltradac_#getData.refno#_#getData.itemcount#" value="#getData.gltradac#" size="10">
				</td>
				<td>
					<img src="/images/userdefinedmenu/iedit.gif" alt="Save" style="cursor: hand;" onclick="updateProject('#getData.refno#','#getData.itemcount#');">
				</td>
			</tr>
		</cfoutput>
	</table>
	<br>
	<div align="center"><input type="button" name="Submit2" value="Back" onclick="history.go(-1);"></div>
</form>
</body>
</html>
