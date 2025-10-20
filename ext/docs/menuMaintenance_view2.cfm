<link rel="stylesheet" href="../stylesheet/stylesheet.css">
    
<cfquery datasource="main" name="getmenu">
 select * from help
</cfquery>
<cfquery datasource="main" name="getmenu1">
 select * from help where menu_level= '1' order by menu_order
</cfquery>

<cfquery datasource="main" name="getmenuchild">
 select menu_parent_id from help group by menu_parent_id order by menu_order
</cfquery>
<cfquery datasource="main" name="getback">
select * from help where menu_id='#url.id#'
</cfquery>
<cfquery datasource="main" name="getadd">
	select * from help where menu_parent_id = '#url.id#' order by menu_order desc
</cfquery>
<h1>Help Menu Maintenance</h1>
<hr>
<cfif isdefined("form.status")>
<div align="center"><font color="FF0000"><cfoutput>#form.status#</cfoutput></font></div>
</cfif>
<table border="0" cellpadding="0" cellspacing="0" class="data" align="center" width="600">

	<tr><th >Menu Name</th><th colspan="2">action</th></tr>
	<!--- level 1 --->

		<cfquery datasource="main" name="getmenu2">
			select*from help where menu_parent_id = '#url.id#' order by menu_name
		</cfquery>
		<cfif getmenu2.recordcount eq 0>
		<cfquery datasource="main" name="getadd2">
			select * from help where menu_id = '#url.id#' order by menu_order desc
		</cfquery>
		<tr><td>There is no sub menu under this.</td><td align="right"><input type="button" onclick="window.location='menuMaintenance_view2.cfm?id=<cfoutput>#getback.menu_parent_id#</cfoutput>'" name="Back" value="Back" style="height :17px; width: 35px;">&nbsp;&nbsp;</td>
		<td><input type="button" onclick="window.location='menuMaintenance_add2.cfm?id=<cfoutput>#getadd2.menu_id#&level=#val(getadd2.menu_level)+1#&order=0</cfoutput>&type=create'" name="Add" value="Add" style="height :17px; width: 35px;"></td></tr>
		</tr>
		<cfelse>
		<cfif url.id neq "0">
		<cfquery datasource="main" name="gethead">
			select*from help where menu_id = '#url.id#' 
		</cfquery>
		<tr><td><b><cfoutput>#gethead.menu_name#</cfoutput><b></td>
		<td align="right"><input type="button" onclick="window.location='menuMaintenance_view2.cfm?id=<cfoutput>#getback.menu_parent_id#</cfoutput>'" name="Back" value="Back" style="height :17px; width: 35px;">&nbsp;&nbsp;</td>
		<td><input type="button" onclick="window.location='menuMaintenance_add2.cfm?id=<cfoutput>#getadd.menu_parent_id#&level=#getadd.menu_level#&order=#getadd.menu_order#</cfoutput>&type=create'" name="Add" value="Add" style="height :17px; width: 35px;"></td></tr>
		<cfelse>
		<tr><td></td><td></td><td><input type="button" onclick="window.location='menuMaintenance_add2.cfm?id=<cfoutput>#getadd.menu_parent_id#&level=#getadd.menu_level#&order=#getadd.menu_order#</cfoutput>&type=create'" name="Add" value="Add" style="height :17px; width: 35px;"></td></tr>
		</cfif>
		<!--- level 2 --->
		<cfloop query="getmenu2">
			<cfset menuid = getmenu2.menu_id>
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';"><td>&nbsp;&nbsp;<cfif getmenu2.menu_level gte "4" ><cfelse><a href="menuMaintenance_view2.cfm?id=<cfoutput>#getmenu2.menu_id#</cfoutput>"> </cfif>			
				<cfoutput>#getmenu2.menu_name#</cfoutput>
				
			</a>
			<cfloop query="getmenuchild">
				<cfif getmenuchild.menu_parent_id eq menuid>
				>>
				</cfif>
				</cfloop>
			</td>
			<td width="200"><a href="cr8content.cfm?menu_id=<cfoutput>#getmenu2.menu_id#</cfoutput>&type=Create"><cfif getmenu2.title eq "">Add<cfelse>Edit</cfif> Content</a> || <a href="menuMaintenance_add2.cfm?menu_id=<cfoutput>#getmenu2.menu_id#</cfoutput>&type=Edit">Edit</a> || <a href="menuMaintenance_add2.cfm?menu_id=<cfoutput>#getmenu2.menu_id#</cfoutput>&type=delete">Delete</a></td>
				<td width="20"><cfif getmenu2.menu_order eq "1">
					<cfelse>
					<img href="#" onclick="window.location='menuMaintenance_view2_process.cfm?parentid=<cfoutput>#url.id#</cfoutput>&id=<cfoutput>#getmenu2.menu_id#</cfoutput>&type=up&order=<cfoutput>#getmenu2.menu_order#</cfoutput>'" src="up.png"></cfif><br><cfif getmenu2.menu_order eq getmenu2.recordcount><cfelse><img href="#" onclick="window.location='menuMaintenance_view2_process.cfm?parentid=<cfoutput>#url.id#</cfoutput>&id=<cfoutput>#getmenu2.menu_id#</cfoutput>&type=down&order=<cfoutput>#getmenu2.menu_order#</cfoutput>'" src="dw.png">
					</cfif>
				</td></tr>


		</cfloop>
		<!--- level 2 end --->
		</cfif>

</table>
