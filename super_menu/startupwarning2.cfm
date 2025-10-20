<cfif isdefined("url.type")>
	<cfif url.type eq "create">
		<cfset title="Create Startup Warning">
		<cfset mode = "Create">
		<cfquery name="check" datasource="main">
			select * from startupwarning
			where ComID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.ComID#">
		</cfquery>
		<cfif check.recordcount neq 0>
			Company ID: <cfoutput>#url.ComID#</cfoutput> already exist! <cfabort>
		</cfif>
		<cfquery name="insert" datasource="main">
			insert into startupwarning
			(ComID,CREATED_BY)
			values
			('#url.ComID#','#HUserID#')
		</cfquery>
		<cfquery name="getData" datasource="main">
			select * from startupwarning
			where ComID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.ComID#">
		</cfquery>	
		<cfset ID=getData.ID>
		<cfset ComID=getData.ComID>
		<cfset Message=getData.Message>
		<cfset Details=getData.Details>
		<cfset File=getData.File>
		<cfset Disp_Time="5">
		<cfset Disp_Height="200">
		<cfset Disp_Width="300">
		<cfset Duedate=now()>
	<cfelse>
		<cfquery name="getData" datasource="main">
			Select * from startupwarning
			where ID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.id#">
		</cfquery>
		
		<cfset ID=getData.ID>
		<cfset ComID=getData.ComID>
		<cfset Message=getData.Message>
		<cfset Details=getData.Details>
		<cfset File=getData.File>
		<cfset Duedate=getData.Duedate>
		<cfset Disp_Time=getData.Disp_Time>
		<cfset Disp_Height=getData.Disp_Height>
		<cfset Disp_Width=getData.Disp_Width>
		<cfif url.type eq "edit">
			<cfset title="Edit Startup Warning">
			<cfset mode = "Edit">
		<cfelseif url.type eq "delete">
			<cfset title="Delete Startup Warning">
			<cfset mode = "Delete">
		</cfif>
	</cfif>
<cfelse>
	<cflocation url="startupwarning.cfm?status=Type undefined." addtoken="no">
</cfif>

<cfoutput>
<html>
<head>
<title>infomation - #variables.title#</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="/stylesheet/stylesheet.css"/>

<script language="javascript" src="../scripts/date_format.js"></script>

</head>

<body>
	<div id="container">

		<h1 align="center">#variables.title#</h1>
	
		<div align="center">
			<hr><br>
			<form name="Form" action="startupwarning_process.cfm?type=#url.type#" method="post" enctype="multipart/form-data">
				<cfif isdefined("url.status")><div class="pageMessage">#url.status#</div></cfif>
            	<input type="hidden" name="ID" value="#variables.ID#">
             
				<table align="center" class="data" width="600px">
				<tr>
					<td width="80">ComID :</td>
					<td align="left"><input type="text" name="ComID" value="#variables.ComID#" maxlength="50" readonly></td>			
				</tr>
				<tr>
					<td width="80">Message :</td>
					<td align="left"><input type="text" name="Message" value="#variables.Message#" maxlength="50"></td>			
				</tr>				
				<tr>
					<td>Details :</td>
					<td align="left"><textarea name="Details" rows="5" cols="70" >#variables.Details#</textarea></td>			
				</tr>
				<tr>
					<td width="80">File :</td>
					<cfif variables.File eq "">
					  	<td>
						  	<input name="File" type="FILE" size="40">&nbsp;
					  		<input class="buttons" type="submit" name="submit" value="UploadFile">
						</td>
				  	<cfelse>
				  		<td>
					  		<a href="download.cfm?rf=#variables.File#" target="_blank">#variables.File#</a>&nbsp;
					  		<input type="hidden" name="File" value="#variables.File#">
				  			<input class="buttons" type="submit" name="submit" value="DeleteFile">
						</td>
					</cfif>	
				</tr>
				<tr>
					<td width="80">Due Date :</td>
					<td align="left"><input type="text" name="duedate" value="#dateformat(duedate,"dd/mm/yyyy")#" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');">(dd/mm/yyyy)</td>			
				</tr>
				<tr>
					<td>Display Mode :</td>
					<td align="left"><input type="text" name="disp_time" value="#disp_time#">&nbsp;second(s)</td>
				</tr>
				<tr>
					<td>Width :</td>
					<td align="left"><input type="text" name="disp_width" value="#disp_width#"></td>
				</tr>
				<tr>
					<td>Height :</td>
					<td align="left"><input type="text" name="disp_height" value="#disp_height#"></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="Back" onClick="javascript:history.back();">
						<input type="submit" name="submit" value="#mode#">
					</td>
				</tr>
				</table>
			</form>
		</div>
	</div>

</body>
</html>
</cfoutput>