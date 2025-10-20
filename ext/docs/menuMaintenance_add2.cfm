<link rel="stylesheet" href="../stylesheet/stylesheet.css">
<cfset menu_id="">
<cfset menu_name="">
<cfset menu_name2="">
<cfset menu_level="">
<cfset menu_parent_id="">
<cfset menu_order="">
<cfif isdefined("url.type")>
	<cfif url.type eq "create">
		<cfset title="Create Menu">
			<cfset menu_id="">		
			<cfset menu_name="">
			<cfset menu_name2="">
			<cfset menu_level=url.level>
			<cfset menu_parent_id=url.id>
			<cfset menu_order=val(url.order)+1>
	<cfelse>
		<cfquery name="getData" datasource="main">
			select * from help
			where menu_Id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.menu_id#">
		</cfquery>	
			<cfset menu_id=url.menu_id>	
			<cfset menu_name=getData.menu_name>
			<cfset menu_name2=getData.menu_name2>
			<cfset menu_level=getData.menu_level>
			<cfset menu_parent_id=getData.menu_parent_id>
			<cfset menu_order=getData.menu_order>
		<cfif url.type eq "edit">
			<cfset title="Edit Menu">
		<cfelseif url.type eq "delete">
			<cfset title="Delete Menu">
		</cfif>
	</cfif>
<cfelse>
	<cflocation url="menuMaintenance_view2.cfm?status=Type undefined." addtoken="no">
</cfif>

<cfoutput>
<html>
<head>
<title>Help Menu Maintenance-#variables.title#</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="/stylesheet/dms_main.css"/>
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
	<h1>Help Menu Maintenance</h1>
	<div id="container">

		<h1 align="center">Menu Maintenance-#variables.title#</h1>
	
		<div align="center">
			<hr><br>
			<form name="clForm" action="menuMaintenance_add2_process.cfm?type=#url.type#" method="post" onSubmit="return validation();">
			<cfif isdefined("url.status")><div class="pageMessage"><cfoutput>#url.status#</cfoutput></div></cfif>

				<table align="center" class="data" width="600">
				<tr>
					<td width="90">Menu Name :</td>
					<td align="left"><input type="text" name="menu_name" <cfif isdefined("url.type")><cfif url.type eq "edit" or url.type eq "delete">value="#variables.menu_name#"</cfif></cfif> size="40" ></td>			
				</tr>
				<tr>
					<td width="90">Menu Name2 :</td>
					<td align="left"><input type="text" name="menu_name2" <cfif isdefined("url.type")><cfif url.type eq "edit" or  url.type eq "delete">value="#variables.menu_name2#"</cfif></cfif> size="40" ></td>			
				</tr>				
										
				<tr>
					<td>Menu Level :</td>
					<td align="left"><input type="text" name="menu_level" value="#variables.menu_level#" size="4" ></td>			
				</tr>
					<input type="hidden" name="menuId" value="#variables.menu_Id#" size="4" maxlength="4" >
				<tr>
					<td width="110">Menu parent id :</td>
					<td align="left"><input type="text" name="menu_parent_id" value="#variables.menu_parent_id#" size="4" ></td>			
				</tr>
				<tr>
					<td width="90">Menu order :</td>
					<td align="left"><input type="text" name="menu_order" value="#variables.menu_order#" size="4" ></td>			
				</tr>									
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="Back" onClick="javascript:history.back();">
						<input type="submit" value="#variables.title#">
					</td>
				</tr>
				</table>
			</form>
		</div>
	</div>

</body>
</html>
</cfoutput>