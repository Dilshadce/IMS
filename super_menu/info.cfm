<cfset title="">
<cfset codeId="">
<cfset codeName="">
<cfset codeStatus="">
<cfif isdefined("url.type")>
	<cfif url.type eq "create">
		<cfset title="Create Information">
		<cfset mode = "Create">
		<cfset codeId="">
		<cfset codeName="">
		<cfset codeStatus="">
		<cfset codeRemark="">
		<cfset codeDate="">
	<cfelse>
		<cfquery name="getData" datasource="main">
			select * from info
			where info_Id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
		</cfquery>
		
		<cfset codeId=getData.info_ID>
		<cfset codeName=getData.info_desp>
		<cfset codeStatus=getData.info_status>
		<cfset codeRemark=getData.info_remark>
		<cfset codeDate=DateFormat(getData.info_date,'dd/mm/yyyy')>	
		<cfif url.type eq "edit">
			<cfset title="Edit Information">
			<cfset mode = "Edit">
		<cfelseif url.type eq "delete">
			<cfset title="Delete Information">
			<cfset mode = "Delete">
		</cfif>
	</cfif>
<cfelse>
	<cflocation url="info_view.cfm?status=Type undefined." addtoken="no">
</cfif>

<cfoutput>
<html>
<head>
<title>infomation - #variables.title#</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="/stylesheet/stylesheet.css"/>

<script language="javascript" src="../scripts/date_format.js"></script>

<script language="javascript">
	function validation(){
		if(document.clForm.infoDate.value==''){
			alert("Please fill in the Date.");
			document.clForm.infoDate.focus();
			return false;
		}
		else if(document.clForm.codeName.value==''){
			alert("Please fill in the Desp.");
			document.clForm.codeName.focus();
			return false;
		}
		return true;
	}
</script>
</head>

<body>
	<div id="container">

		<h1 align="center">Infomation Profile - #variables.title#</h1>
	
		<div align="center">
			<hr><br>
			<cfform name="clForm" action="info_process.cfm?type=#url.type#" method="post" onSubmit="return validation();">
				<cfif isdefined("url.status")><div class="pageMessage">#url.status#</div></cfif>
            	<input type="hidden" name="codeId" value="#variables.codeId#">
             
				<table align="center" class="data" width="600px">
				<tr>
					<td width="80">Date :</td>
					<td align="left"><cfinput type="text" name="infoDate" value="#codeDate#" validate="eurodate">(dd/mm/yyyy)</td>			
				</tr>
				<tr>
					<td width="80">Remark :</td>
					<td align="left"><input type="text" name="infoRemark" value="#codeRemark#"></td>			
				</tr>				
				<tr>
					<td>Code Name :</td>
					<td align="left"><textarea name="codeName" rows="5" cols="70" >#variables.codeName#</textarea></td>			
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="Back" onClick="javascript:history.back();">
						<input type="submit" value="#mode#">
					</td>
				</tr>
				</table>
			</cfform>
		</div>
	</div>

</body>
</html>
</cfoutput>