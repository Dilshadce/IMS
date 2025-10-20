<html>
<head>
<link rel="stylesheet" href="stylesheet/stylesheet.css"/>
</head>
<body>

<h1 align="center">Add Favorites</h1>
<h2 align="right"><a href="/newBody.cfm"><u>Exit</u></a></h2>
<cfoutput>
	<cfif isdefined("url.level")>
		<cfset menuLevel="#url.level#">
	<cfelse>
		<cfset menuLevel="#form.level#">
	</cfif>
</cfoutput>
<cfset status = "">		
<cfif isdefined("type")>
	<cfoutput>
		<cfif type eq "add">
			<cfquery datasource="main" name="getMenuCheck">
				select * from Menu
			</cfquery>
			<cfquery datasource="#dts#" name="getFavoriteCheck">
				select * from myFavorite
				where created_by = '#Huserid#'
			</cfquery>				
			<cfif getFavoriteCheck.recordcount eq "20">
				<cfset status="You can only have 20 Favorite">
			<cfelse>
				<cfloop query="getFavoriteCheck">
					<cfif getFavoriteCheck.menu_id eq "#form.mainmenu#">
						<cfset status="The Menu exsit at Favorite.Please Choose Another Menu">										
					</cfif>
				</cfloop>
				<cfif status eq "">
					<cfquery datasource="main" name="getAddMenu">
						select * from Menu where menu_id='#form.mainmenu#'
					</cfquery>
					<cfif getAddMenu.menu_url eq "">
						<cfset status="The Menu is a Main Menu.">
					<cfelse>
						<cfif getAddMenu.USERDIRECTORY eq "1">
							<cfset getAddMenu.menu_url = '/'&HDir&getAddMenu.menu_url>
						</cfif>
						<cfquery datasource="#dts#" name="add1">
				 			insert into MyFavorite 
				 			(menu_id,menu_name,menu_url,created_by)
				 			values
				 			('#getAddMenu.menu_id#','#getAddMenu.menu_name2#','#getAddMenu.menu_url#',
				 			<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">)
						</cfquery>
					</cfif>
				</cfif>	
			</cfif>	
		</cfif>
		<cfif type eq "del">
			<cfquery datasource="#dts#" name="getAddMenu">
				delete from MyFavorite where favorite_id = '#form.favoritemenu#'
			</cfquery>
		</cfif>
	</cfoutput>
</cfif>

<cfquery datasource="#dts#" name="getGeneral">
	select lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION from gsetup
</cfquery>

<cfquery datasource="#dts#" name="getFavorite">
	select * from Myfavorite
	where created_by = '#Huserid#'
</cfquery>	
<cfquery datasource="main" name="getMenu">
	select * from Menu where menu_level<="#menuLevel#" <cfloop query="getFavorite">and menu_id!='#getFavorite.menu_id#'</cfloop>
	order by length(SUBSTRING_INDEX(menu_no, '.', 1)) , SUBSTRING_INDEX(menu_no, '.', 1),
	length(SUBSTRING_INDEX(menu_no, '.', 2)), SUBSTRING_INDEX(menu_no, '.', 2),
	length(SUBSTRING_INDEX(menu_no, '.', 3)), SUBSTRING_INDEX(menu_no, '.', 3)
</cfquery>	
<script type="text/javascript">
	function add(){
		if(document.form.mainmenu.value==''){
			alert("Please Select a Menu to add into Favorite");
		}else{
				
			document.form.action='favorite.cfm?type=add';	
			document.form.submit();	
		}

	}
	
	function del(){
		if(document.form.favoritemenu.value==''){
			alert("Please Select Favorite to delete");
		}else{
					
			document.form.action='favorite.cfm?type=del';	
			document.form.submit();
		}
	}			
</script>

<form name="form" method="post">
	<cfoutput><div align="center"><font color="red">#status#</font></div></cfoutput>
	<table border="0" align="center">
		<tr>
			<td>
				<select size="25" name="mainmenu" STYLE="width: 300px">
					<cfoutput query="getMenu">
						<cfset menuname=Replace(getMenu.menu_name3,'mCategory',getGeneral.lCATEGORY)>
						<cfset menuname=Replace(menuname,'mGroup',getGeneral.lGROUP)>
						<cfset menuname=Replace(menuname,'mSize',getGeneral.lSIZE)>
						<cfset menuname=Replace(menuname,'mRating',getGeneral.lRATING)>
						<cfset menuname=Replace(menuname,'mMaterial',getGeneral.lMATERIAL)>
						<cfset menuname=Replace(menuname,'mShelf',getGeneral.lMODEL)>
						<cfset menuname=Replace(menuname,'mAgent',getGeneral.lAGENT)>
						<cfset menuname=Replace(menuname,'mEnd User',getGeneral.lDRIVER)>
						<cfset menuname=Replace(menuname,'mLocation',getGeneral.lLOCATION)>
						<cfif getMenu.userpin neq "">
							<cfset xcode = "H"&getMenu.userpin>
							<cfif getpin2[xcode][1] eq "T">
								<!--- <option value="#getMenu.menu_id#">#getMenu.menu_name3#</option> --->
								<option value="#getMenu.menu_id#">#menuname#</option>
							</cfif>
						<cfelse>
							<!--- <option value="#getMenu.menu_id#">#getMenu.menu_name3#</option> --->
							<option value="#getMenu.menu_id#">#menuname#</option>
						</cfif>
					</cfoutput>
				</select>						
			</td>
			<td align="center" valign="center">
				<br/><br/>
				<br/><br/>
				<br/><br/>
				<input type="button" name"add" value=">" onclick="add()">
				<br/><br/>
				<input type="button" name"del" value="<" onclick="del()"></td><td>
				<select size="25" name="favoritemenu" STYLE="width: 300px" >
					<cfoutput query="getFavorite">
						<cfset menuname2=Replace(getFavorite.menu_name,'mCategory',getGeneral.lCATEGORY)>
						<cfset menuname2=Replace(menuname2,'mGroup',getGeneral.lGROUP)>
						<cfset menuname2=Replace(menuname2,'mSize',getGeneral.lSIZE)>
						<cfset menuname2=Replace(menuname2,'mRating',getGeneral.lRATING)>
						<cfset menuname2=Replace(menuname2,'mMaterial',getGeneral.lMATERIAL)>
						<cfset menuname2=Replace(menuname2,'mShelf',getGeneral.lMODEL)>
						<cfset menuname2=Replace(menuname2,'mAgent',getGeneral.lAGENT)>
						<cfset menuname2=Replace(menuname2,'mEnd User',getGeneral.lDRIVER)>
						<cfset menuname2=Replace(menuname2,'mLocation',getGeneral.lLOCATION)>
						<!--- <option value="#getFavorite.favorite_id#">#getFavorite.menu_name#</option> --->
						<option value="#getFavorite.favorite_id#">#menuname2#</option>
					</cfoutput>
				</select>
				<input type="hidden" name="level" value="<cfoutput>#menuLevel#</cfoutput>">
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<a href="../favorite.cfm?level=1">Level1</a> || <a href="../favorite.cfm?level=2">Level2</a> || <a href="../favorite.cfm?level=3">Level3</a> || <a href="../favorite.cfm?level=4">Level4</a>
			</td>
		</tr>
	</table>
</form>
</body>
</html>