<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title>Netiquette Help Center</title>
    <link rel="stylesheet" type="text/css" href="resources/collapser.css"></link>
	<link rel="stylesheet" type="text/css" href="resources/docs.css"></link>
	<link rel="shortcut icon" href="http://www.jackslocum.com/favicon.ico" />
	<link rel="icon" href="http://www.jackslocum.com/favicon.ico" />
	<!-- GC -->
	<style type="text/css">
	html, body {
        margin:0;
        padding:0;
        border:0 none;
        overflow:hidden;
        height:100%;
    }
	</style>
</head>
<body scroll="no" id="docs">
  	<div id="loading-mask" style="width:100%;height:100%;background:#c3daf9;position:absolute;z-index:20000;left:0;top:0;">&#160;</div>
  <div id="loading">
    <div class="loading-indicator"><img src="../resources/images/default/grid/loading.gif" style="width:16px;height:16px;" align="absmiddle">&#160;Loading...</div>
  </div>
    <!-- include everything after the loading indicator -->
    <script type="text/javascript" src="../adapter/ext/ext-base.js"></script>
    <script type="text/javascript" src="../ext-all.js"></script>
    <link rel="stylesheet" type="text/css" href="../resources/css/ext-all.css" />

    <script type="text/javascript" src="resources/docs.js"></script>

  <div id="header">

	<table bourder="1" width="100%">
	<tr>
		<td>Netiquette Help Center</td>
		<td align="right">
			<form action="contentlayout.cfm?menu_id=search" method="post" name="Search" id="Search" target="main">
				<input name="keyword" type="text" id="keyword" size="30"><input type="submit" name="Submit" value="Search">
			</form>
		</td>
	<tr>
	</table>
  </div>

<cfset link1='main'>

<cfquery datasource="#link1#" name="gethelp">
 select * from help
</cfquery>
<cfquery datasource="#link1#" name="gethelp1">
 select * from help where menu_level= '1' order by menu_order
</cfquery>
<cfoutput>





  <div id="classes">
 <a id="welcome-link" href="welcome.html">HELP HOME</a>
	  <!-- BEGIN TREE --><cfloop query="gethelp1">
	 
	 
	  <div class="pkg"> <cfif #gethelp1.title# eq ""><h3>#gethelp1.menu_name#</h3><cfelse><a href="contentlayout.cfm?menu_id=#menu_id#">#gethelp1.menu_name#</a></cfif>
	  <div class="pkg-body">
	   <cfset parentID = gethelp1.menu_id>
		<cfquery datasource="#link1#" name="gethelp2">
			select*from help where menu_parent_id = '#parentID#' order by menu_order
		</cfquery>
			
            <div class="pkg">
			<Cfloop query="gethelp2">
                <cfif #gethelp2.title# eq ""><h3>#gethelp2.menu_name#</h3><cfelse><a href="contentlayout.cfm?menu_id=#menu_id#">#gethelp2.menu_name#</a></cfif>
				
                <div class="pkg-body">
					<cfset parentID = gethelp2.menu_id>
					<cfquery datasource="#link1#" name="gethelp3">
					select*from help where menu_parent_id = '#parentID#' order by menu_order
					</cfquery>
					
					<div class="pkg">
					<cfloop query="gethelp3">
						<cfif #gethelp3.title# eq ""><h3>#gethelp3.menu_name#</h3><cfelse><a href="contentlayout.cfm?menu_id=#menu_id#">#gethelp3.menu_name#</a></cfif>
						
						<cfset parentID = gethelp3.menu_id>
						<cfquery datasource="#link1#" name="gethelp4">
							select*from help where menu_parent_id = '#parentID#' order by menu_order
						</cfquery>
						<!--- level 4 --->
						
						<div class="pkg-body">
						<Cfloop query="gethelp4">
						<a href="contentlayout.cfm?menu_id=#menu_id#">#gethelp4.menu_name#</a>
						</cfloop>
						
						</div>
						</cfloop>
					</div>
					
                
				</div>	
			</cfloop>
            </div>
		
        </div>
        

      </div>
      <!-- END TREE --> </cfloop>
	
  </div>
<!--try-->

  <iframe id="main" name="main" frameborder="no"></iframe>
  </body>
</html>
</cfoutput>


