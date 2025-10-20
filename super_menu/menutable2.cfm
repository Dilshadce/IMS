<cfif isdefined("url.type")>
	<cfif url.type eq "create">
		<cfset title="Create Information">
		<cfset mode = "Create">
		<cfset menuId="">
		<cfset menuName="">
		<cfset menuName2 = "">
		<cfset menuName3 = "">
		<cfset menuURL="">
		<cfset menuStatus="">
		<cfset menuLevel="">
		<cfset menuNo="">
		<cfset userDirectory="">
		<cfset userpin ="">
	<cfelse>
		<cfquery name="getData" datasource="main">
			select * from menu
			where menu_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
		</cfquery>
		
		<cfset menuId=getData.menu_id>
		<cfset menuName=getData.menu_name>
		<cfset menuName2 = getData.menu_name2>
		<cfset menuName3 = getData.menu_name3>
		<cfset menuURL=getData.menu_url>
		<cfset menuStatus=getData.menu_status>
		<cfset menuLevel=getData.menu_level>
		<cfset menuNo=getData.menu_no>
		<cfset userDirectory=getData.userdirectory>
		<cfset userpin =getData.userpin>
		<cfif url.type eq "edit">
			<cfset title="Edit Information">
			<cfset mode = "Edit">
		<cfelseif url.type eq "delete">
			<cfset title="Delete Information">
			<cfset mode = "Delete">
		</cfif>
	</cfif>
<cfelse>
	<cflocation url="menutable.cfm?status=Type undefined." addtoken="no">
</cfif>

<cfquery name="getuserpin" datasource="#dts#">
	select code,desp from userpin order by code 
</cfquery>

<cfoutput>
<html>
<head>
<title>Menu - #variables.title#</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="/stylesheet/stylesheet.css"/>

<script language="javascript" src="../scripts/date_format.js"></script>

<script language="javascript">
	function validation(){
		if(document.clForm.menuNo.value==''){
			alert("Please fill in the Menu No.");
			document.clForm.menuNo.focus();
			return false;
		}
		else if(document.clForm.menuName.value==''){
			alert("Please fill in the Menu Name.");
			document.clForm.menuName.focus();
			return false;
		}
		return true;
	}
</script>
</head>

<body>
	<div id="container">
		<h1 align="center">Menu Maintenance - #variables.title#</h1>
	
		<div align="center">
			<hr><br>
			<form name="clForm" action="menutable_process.cfm?type=#url.type#" method="post" onSubmit="return validation();">
				<input type="hidden" name="menuId" value="#menuId#" size="4" maxlength="4">
				<cfif isdefined("url.status")><div class="pageMessage">#url.status#</div></cfif>
             
				<table align="center" class="data" width="600px">
					<tr>
						<td width="80">Menu No :</td>
						<td><input type="text" name="menuNo" value="#menuNo#"></td>			
					</tr>
				<tr>
					<td>Menu Name :</td>
					<td><input type="text" name="menuName" value="#menuName#"></td>			
				</tr>
				<tr>
					<td>Menu Name2:</td>
					<td><input type="text" name="menuName2" value="#menuName2#" size="50"></td>			
				</tr>
				<tr>
					<td>Menu Name3:</td>
					<td><input type="text" name="menuName3" value="#menuName3#" size="50"></td>			
				</tr>
				<tr>
					<td>Menu URL:</td>
					<td><input type="text" name="menuURL" value="#menuURL#" size="50"></td>			
				</tr>				
				<tr>
					<td>Menu Level :</td>
					<td>
						<select name="menulvl">
							<option value="1" <cfif menuLevel eq "1">selected</cfif>>1</option>
							<option value="2" <cfif menuLevel eq "2">selected</cfif>>2</option>
							<option value="3" <cfif menuLevel eq "3">selected</cfif>>3</option>
							<option value="4" <cfif menuLevel eq "4">selected</cfif>>4</option>
						</select>
					</td>			
				</tr>
				<tr>
					<td>User Pin :</td>
					<td>
						<select name="userpin">
							<option value="">-</option>
							<cfloop query="getuserpin">
								<option value="#getuserpin.code#" <cfif userpin eq getuserpin.code>selected</cfif>>#getuserpin.code# - #getuserpin.desp#</option>
							</cfloop>
						</select>
					</td>			
				</tr>	
				<tr>
					<td>User Directory :</td>
					<td>
						<input type="checkbox" name="userDirectory" <cfif userDirectory eq "1">checked</cfif>>
					</td>			
				</tr>	
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="Back" onClick="javascript:history.back();">
						<input type="submit" value="#variables.mode#">
					</td>
				</tr>
				</table>
			</form>
		</div>
	</div>

</body>
</html>
</cfoutput>