<cfquery name="getGsetup" datasource="#dts#">
	SELECT dflanguage 
    FROM gsetup;
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
	SELECT * 
    FROM modulecontrol;
</cfquery>

<cfquery name="getUserDefinedMenu" datasource="#dts#">
	SELECT menu_id 
    FROM userDefinedMenu;
</cfquery>

<cfif getUserDefinedMenu.recordcount EQ 0>  
    <cfquery name="insertUserDefinedMenu" datasource="#dts#">
       INSERT IGNORE INTO userDefinedMenu(menu_id,menu_name,new_menu_name)
       SELECT menu_id, menu_name AS a,menu_name AS b
       FROM main.menunew2;
    </cfquery>
</cfif>

<cfif getGsetup.dflanguage NEQ "english">
	<cfset menuname=getGsetup.dflanguage>
<cfelse>
	<cfset menuname="menu_name">
</cfif>

<cfif hlang neq "">
	<cfif hlang neq "english">
    	<cfset menuname=hlang>
    <cfelse>
    	<cfset menuname="menu_name">
    </cfif>
</cfif>

<cfquery name="getLevel1Menu" datasource="#dts#">
	SELECT DISTINCT m.menu_id AS menu_id,m.#menuname# AS menu_name,m.menu_url AS menu_url,m.userpin_id as userpin_id,
    				udm.new_menu_name AS newMenuName
	FROM main.menunew2 AS m
    LEFT JOIN userdefinedmenu AS udm ON m.menu_id = udm.menu_id
	WHERE m.menu_level=1
    AND m.menu_id > 9999
	<cfif husergrpid NEQ "super">
    	AND m.menu_id < 70000
    </cfif>
	ORDER BY m.menu_order;
</cfquery>

<cfquery name="getCurrentActiveMenu" datasource="main">
	SELECT menu_id
	FROM menunew2
	WHERE menu_url LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#cgi.SCRIPT_NAME#%">;
</cfquery>

<cfif getCurrentActiveMenu.RecordCount GT 0>
	<cfset session.menuid = getCurrentActiveMenu.menu_id>
</cfif>
<style>
/* style 1 */
div.nav1 ul li
{
  display:inline;

  border: solid 1px black;
  padding: 8px;
  margin: 8px;

  list-style-type: none;
  line-height: 3em;
}

/* style 2 */
div.nav2 ul li
{
  float: left;
  border: solid 1px black;
  padding: 10px;
  margin: 10px;

  list-style-type: none;
}
</style>
</head>

<body>
<cfoutput>
<div class="nav1">
	<ul>
		<cfloop query="getLevel1Menu">
            	<cfif getLevel1Menu.userpin_id NEQ "">
                    <cfif evaluate('getPin2.#userpin_id#') EQ "T">
                    	<cfset parentUserPinID = userpin_id>
                        <li id="item#getLevel1Menu.menu_id#" class="item#getLevel1Menu.menu_id#">
                            <a href="/mobileheader2.cfm?parentUserPinID=#parentUserPinID#&lvl1menuid=#getLevel1Menu.menu_id#" target="topFrame">#getLevel1Menu.newMenuName#</a>    
                            
                        </li>	
                    </cfif>	
                </cfif>
      
		</cfloop>
         <li><a href="/latest/logout/logout.cfm">Logout</a></li>
 
	</ul>

</div>
</cfoutput>
</body>
</html>