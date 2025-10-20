<html>
<head>
<title>Module Control</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<cfquery name="getremarkInfo" datasource="#dts#">
	select * 
	from gsetup;
</cfquery>

<cfif isdefined("url.type")>
<cfquery datasource="#dts#" name="checkrecordcount">
select * from modulecontrol
</cfquery>
<cfif checkrecordcount.recordcount eq 0>
<cfquery datasource="#dts#" name="SaveGeneralInfo">
		insert into modulecontrol (companyid,postran,matrixtran,simpletran,project,job,auto,location,serialno,grade,matrix,manufacturing,batchcode,package,repairtran,customtax,malaysiagst) values ('IMS',
		<cfif isdefined ("form.postran")>
			'1'
		<cfelse>
			'0'
		</cfif>
        ,
        <cfif isdefined ("form.matrixtran")>
			'1'
		<cfelse>
			'0'
		</cfif>
        ,
        <cfif isdefined ("form.simpletran")>
			'1'
		<cfelse>
			'0'
		</cfif>
        ,
        <cfif isdefined ("form.project")>
			'1'
		<cfelse>
			'0'
		</cfif>
        ,
        <cfif isdefined ("form.job")>
			'1'
		<cfelse>
			'0'
		</cfif>
        ,
        <cfif isdefined ("form.auto")>
			'1'
		<cfelse>
			'0'
		</cfif>
        ,
        <cfif isdefined ("form.location")>
			'1'
		<cfelse>
			'0'
		</cfif>
        ,
        <cfif isdefined ("form.serialno")>
			'1'
		<cfelse>
			'0'
		</cfif>
        ,
        <cfif isdefined ("form.grade")>
			'1'
		<cfelse>
			'0'
		</cfif>
        ,
        <cfif isdefined ("form.matrix")>
			'1'
		<cfelse>
			'0'
		</cfif>
        ,
        <cfif isdefined ("form.manufacturing")>
			'1'
		<cfelse>
			'0'
		</cfif>
        ,
         <cfif isdefined ("form.batchcode")>
			'1'
		<cfelse>
			'0'
		</cfif>
        ,
        <cfif isdefined ("form.package")>
			'1'
		<cfelse>
			'0'
		</cfif>
		,
        <cfif isdefined ("form.repairtran")>
			'1'
		<cfelse>
			'0'
		</cfif>
		,
		<cfif isdefined ("form.customtax")>
			'1'
		<cfelse>
			'0'
		</cfif>
        ,
		<cfif isdefined ("form.malaysiagst")>
			'1'
		<cfelse>
			'0'
		</cfif>


        ) 
	</cfquery>
<cfelse>
	<cfquery datasource="#dts#" name="SaveGeneralInfo">
		update modulecontrol set 
		<cfif isdefined ("form.postran")>
			postran='1'
		<cfelse>
			postran='0'
		</cfif>,
        <cfif isdefined ("form.matrixtran")>
			matrixtran='1'
		<cfelse>
			matrixtran='0'
		</cfif>,
        <cfif isdefined ("form.simpletran")>
			simpletran='1'
		<cfelse>
			simpletran='0'
		</cfif>
        ,
        <cfif isdefined ("form.project")>
			project='1'
		<cfelse>
			project='0'
		</cfif>
        ,
         <cfif isdefined ("form.job")>
			job='1'
		<cfelse>
			job='0'
		</cfif>
        ,
        <cfif isdefined ("form.auto")>
			auto='1'
		<cfelse>
			auto='0'
		</cfif>
     	,
        <cfif isdefined ("form.location")>
			location='1'
		<cfelse>
			location='0'
		</cfif>
        ,
        <cfif isdefined ("form.serialno")>
			serialno='1'
		<cfelse>
			serialno='0'
		</cfif>
        ,
        <cfif isdefined ("form.grade")>
			grade='1'
		<cfelse>
			grade='0'
		</cfif>
        ,
        <cfif isdefined ("form.matrix")>
			matrix='1'
		<cfelse>
			matrix='0'
		</cfif>
        ,
        <cfif isdefined ("form.manufacturing")>
			manufacturing='1'
		<cfelse>
			manufacturing='0'
		</cfif>
        ,
        <cfif isdefined ("form.batchcode")>
			batchcode='1'
		<cfelse>
			batchcode='0'
		</cfif>
        ,
         <cfif isdefined ("form.package")>
			package='1'
		<cfelse>
			package='0'
		</cfif>
        ,
        <cfif isdefined ("form.repairtran")>
			repairtran='1'
		<cfelse>
			repairtran='0'
		</cfif>
        ,
        <cfif isdefined ("form.customtax")>
			customtax='1'
		<cfelse>
			customtax='0'
		</cfif>
        ,
        <cfif isdefined ("form.malaysiagst")>
			malaysiagst='1'
		<cfelse>
			malaysiagst='0'
		</cfif>
        
		where companyid='IMS';
	</cfquery>
</cfif>   
</cfif>
<cfquery name="getremarkdetail" datasource="#dts#">
	select * 
	from extraremark;
</cfquery>
<cfquery name="getGeneralInfo" datasource="#dts#">
	select * 
	from modulecontrol;
</cfquery>

<cfset postran = getGeneralInfo.postran>
<cfset matrixtran = getGeneralInfo.matrixtran>
<cfset simpletran = getGeneralInfo.simpletran>
<cfset project = getGeneralInfo.project>
<cfset job = getGeneralInfo.job>
<cfset auto = getGeneralInfo.auto>
<cfset location = getGeneralInfo.location>
<cfset serialno = getGeneralInfo.serialno>
<cfset grade = getGeneralInfo.grade>
<cfset matrix = getGeneralInfo.matrix>
<cfset manufacturing = getGeneralInfo.manufacturing>
<cfset batchcode = getGeneralInfo.batchcode>
<cfset package = getGeneralInfo.package>
<cfset repairtran = getGeneralInfo.repairtran>
<cfset customtax = getGeneralInfo.customtax>
<cfset malaysiagst = getGeneralInfo.malaysiagst>
<body>


<h1>General Setup - Module Control</h1>

<cfform action="modulecontrol.cfm?type=save" method="post">
	<table width="500" align="center" class="data" cellspacing="0">
		<tr> 
      		<td colspan="2"><div align="center"><strong>Module Control</strong></div></td>
    	</tr>
		<tr> 
		  	<th>POS Transaction</th>
		  	<td><input name="postran" id="postran" type="checkbox" value="1" <cfif postran eq '1'>checked</cfif>></td>
		</tr>  
		<tr> 
		  	<th>Matrix Transaction</th>
		  	<td><input name="matrixtran" id="matrixtran" type="checkbox" value="1" <cfif matrixtran eq '1'>checked</cfif>></td>
		</tr>       
        <tr> 
		  	<th>Simple Transaction</th>
		  	<td><input name="simpletran" id="simpletran" type="checkbox" value="1" <cfif simpletran eq '1'>checked</cfif>></td>
		</tr> 
        <tr> 
		  	<th>Project</th>
		  	<td><input name="project" id="project" type="checkbox" value="1" <cfif project eq '1'>checked</cfif>></td>
		</tr>
         <tr> 
		  	<th>Job</th>
		  	<td><input name="job" type="checkbox" value="1" <cfif job eq '1'>checked</cfif>></td>
		</tr>
        <tr> 
		  	<th>Automobile</th>
		  	<td><input name="auto" id="auto" type="checkbox" value="1" <cfif auto eq '1'>checked</cfif>></td>
		</tr>
         <tr> 
		  	<th>Location</th>
		  	<td><input name="location" id="location" type="checkbox" value="1" <cfif location eq '1'>checked</cfif>></td>
		</tr>               
         <tr> 
		  	<th>Serial No</th>
		  	<td><input name="serialno" id="serialno" type="checkbox" value="1" <cfif serialno eq '1'>checked</cfif>></td>
		</tr>       
         <tr> 
		  	<th>Grade</th>
		  	<td><input name="grade" id="grade" type="checkbox" value="1" <cfif grade eq '1'>checked</cfif>></td>
		</tr>       
         <tr> 
		  	<th>Matrix</th>
		  	<td><input name="matrix" id="matrix" type="checkbox" value="1" <cfif matrix eq '1'>checked</cfif>></td>
		</tr>       
        
         <tr> 
		  	<th>Manufacturing</th>
		  	<td><input name="manufacturing" id="manufacturing" type="checkbox" value="1" <cfif manufacturing eq '1'>checked</cfif>></td>
		</tr>       
        
         <tr> 
		  	<th>Batch Code</th>
		  	<td><input name="batchcode" id="batchcode" type="checkbox" value="1" <cfif batchcode eq '1'>checked</cfif>></td>
		</tr>  
        
        <tr> 
		  	<th>Package</th>
		  	<td><input name="package" id="package" type="checkbox" value="1" <cfif package eq '1'>checked</cfif>></td>
		</tr>  
        <tr> 
		  	<th>Repair Module</th>
		  	<td><input name="repairtran" id="repairtran" type="checkbox" value="1" <cfif repairtran eq '1'>checked</cfif>></td>
		</tr> 
        
        <tr> 
		  	<th>Custom Tax</th>
		  	<td><input name="customtax" id="customtax" type="checkbox" value="1" <cfif customtax eq '1'>checked</cfif>></td>
		</tr>  
        <tr> 
		  	<th>Malaysia GST</th>
		  	<td><input name="malaysiagst" id="malaysiagst" type="checkbox" value="1" <cfif malaysiagst eq '1'>checked</cfif>></td>
		</tr>  
        
		<tr> 
		  	<td colspan="2" align="center">
				<input name="submit" type="submit" value="Save">
			  	<input name="reset" type="reset" value="Reset">
			</td>
		</tr>
	</table>
</cfform>

</body>
</html>