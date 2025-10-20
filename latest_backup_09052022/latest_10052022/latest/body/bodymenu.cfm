<cfif IsDefined("url.id")>
	<cfif husergrpid EQ "super">
        <cfset pin="super">
    <cfelseif husergrpid EQ "admin">
        <cfset pin="Admin">
    <cfelseif husergrpid EQ "guser">
        <cfset pin="General">
    <cfelseif husergrpid EQ "luser">
        <cfset pin="Limited">
    <cfelseif husergrpid EQ "muser">
        <cfset pin="Mobile">
    <cfelseif husergrpid EQ "suser">
        <cfset pin="Standard">
    <cfelse>
        <cfset pin="#husergrpid#">
    </cfif>
    
    <cfquery name="getGsetup" datasource="#dts#">
        SELECT dflanguage 
        FROM gsetup;
    </cfquery>
    
    <script type="text/javascript">
		<!--
		function popup(url) 
		{
		 params  = 'width='+screen.width;
		 params += ', height='+screen.height;
		 params += ', top=0, left=0, status=yes,menubar=no , location = no'
		 params += ', fullscreen=yes,scrollbars=yes';
		
		 newwin=window.open(url,'expressbill', params);
		 if (window.focus) {newwin.focus()}
		 return false;
		}
		
		function popup2(url) 
		{
		 params  = 'width='+screen.width;
		 params += ', height='+screen.height;
		 params += ', top=0, left=0, status=yes,menubar=no , location = no'
		 params += ', fullscreen=yes,scrollbars=yes';
		
		 newwin=window.open(url,'expressbill', params);
		 if (window.focus) {newwin.focus()}
		 return false;
		}
		// -->
	</script>
    
    
    <!---Perform checking for new MENU added in MAIN table --->
    <!--- <cfquery name="insertUserDefinedMenu" datasource="#dts#">
       INSERT IGNORE INTO userDefinedMenu(menu_id,menu_name,new_menu_name,menu_level)
       SELECT menu_id, menu_name AS a,menu_name AS b,menu_level AS c
       FROM main.menunew2;
    </cfquery> --->
    
	<cfif getGsetup.dflanguage NEQ "english">
        <cfset menuname=getGsetup.dflanguage>
        <cfset titledesp="titledesp_"&getGsetup.dflanguage>	
    <cfelse>
        <cfset menuname="menu_name">
        <cfset titledesp="titledesp">
    </cfif>
    
    <cfif hlang neq "">
<cfif hlang neq "english">
<cfset menuname=hlang>
<cfset titledesp="titledesp_"&hlang>	
<cfelse>
<cfset menuname="menu_name">
<cfset titledesp="titledesp">
</cfif>
</cfif>
	
    <!--- Updating MENU NAME if not changed according to MAIN TABLE --->
<!--- 	<cfquery name="updateUserDefinedMenu" datasource="#dts#">
		UPDATE userDefinedMenu a,main.menunew2 b
		SET 
			a.new_menu_name = b.#menuname#,
			a.menu_name = b.menu_name
		WHERE a.menu_id = b.menu_id
		AND changed != '1';
    </cfquery> --->
    
    <cfset parentID = trim(url.id)>

    <cfquery name="getMenu" datasource="#dts#">
       SELECT DISTINCT  udm.menu_id AS menu_id,
                        udm.menu_name AS menu_name,
                        IF(udm.menu_url = '',m.menu_url,udm.menu_url) AS menu_url,
                        m.#titledesp# AS titledesp,
                        IFNULL(m.userpin_id,'h#parentID#') AS userpin_id,
                        udm.new_menu_name AS newMenuName
        FROM main.menunew2 AS m
        RIGHT JOIN userdefinedmenu AS udm ON m.menu_id = udm.menu_id
        WHERE m.menu_parent_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#parentID#">
        OR udm.menu_parent_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#parentID#">
        ORDER BY IF(udm.menu_order = 0,m.menu_order,udm.menu_order);
    </cfquery>

    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
            <!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <title>Inventory Management System</title>
            <cfif husergrpid EQ "super">
                <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
                <script type="text/javascript" src="/latest/js/jeditable/jquery.jeditable.mini.js"></script>
                <cfoutput>
					<script type="text/javascript">
                        var dts='#dts#';
                        var authUser='#getAuthUser()#';
                    </script>
                </cfoutput>
                <script type="text/javascript" src="/latest/js/body/bodymenu.js"></script>
            </cfif>
            <style>
                body{
                    margin:0;
                }
                .content{
                    margin:0;
                    padding:0;
                }
                .content_body{
                    margin:0;
                    padding:0;
                    width:100%;
                }
                .menulist ul{
                    max-width:905px;
                    padding:0;
                    margin:25px;
                }
                .menulist li{
                    display:inline-block;
                    text-decoration:none;
                    list-style-type:none;
                    font-family:Segoe UI;
                    margin-left:25px;
                    margin-top:25px;
                    border-left:8px solid #f0606d;
                    box-shadow: 0px 0px 10px #CCCCCC;
                    background-color:#FFFFFF;
                    cursor:pointer;
                    behavior: url(/latest/css/pie/PIE.htc);
                }
                .menulist li:hover,.menulist li:active{
                    color:#1D2835;
                    border-left:8px solid #1D2835;
                    background-color:#f0606d;
                }
                .menulist a{
                    text-decoration:none;
                }
                .submenu{
                    margin:10px 24px 10px 16px;
                    width:367px;
                }
                .title{
                    vertical-align:top;
                    font-family:"Franklin Gothic Book";
                    font-size:22px;
                    font-weight:bold;
                    letter-spacing:0.025em;
                    color:#1D2835;
                    border-bottom:1px solid #666666;
                    overflow:hidden;
                    word-wrap:break-word;
                    min-height:35px;
                }
                .desp{
                    margin-top:7px;
                    font-family:"Segoe UI";
                    font-size:12px;
                    font-style:italic;
                    color:#666666;
                    min-height:35px;
                    overflow:hidden;
                    word-wrap:break-word;
                }
                .menulist li:hover .title,.menulist li:active .title{
                    color:#1D2835;
                    border-bottom:1px solid #1D2835;
                }
                .menulist li:hover .desp,.menulist li:active .desp{
                    color:#1D2835;
                }
            </style>
        
        </head>
        <cfoutput>
            <body>
                <div class="content">
                    <div class="content_body">
                        <div class="menulist">
                            <ul>
                                <cfloop query="getMenu">
									<cfif getMenu.userpin_id neq "">
                                        <cfif evaluate('getpin2.#userpin_id#') eq "T">
                                            <li>
                                                <cfif husergrpid NEQ "super">
                                                    <cfif menu_id eq "20715"><a href="../body/overview.cfm" onClick="popup('../#getMenu.menu_url#')"><cfelse><a href="../#getMenu.menu_url#"></cfif>
                                                </cfif>
                                                <div class="submenu">
                                                    <cfif husergrpid EQ "super">
                                                        <cfif menu_id eq "20715"><a href="../body/overview.cfm" onClick="popup('../#getMenu.menu_url#')"><cfelse><a href="../#getMenu.menu_url#"></cfif>
                                                    </cfif>
                                                    <div class="title">#getMenu.newMenuName#</div>
                                                        <cfif husergrpid EQ "super">
                                                            </a>
                                                        </cfif>
                                                    <div id="#getMenu.menu_id#" class="desp">#getMenu.titledesp#</div>
                                                </div>
                                                <cfif husergrpid NEQ "super">
                                                	</a>
                                                </cfif>
                                            </li>
                                        </cfif>
                                    <cfelse>
                                        <li>
                                            <cfif husergrpid NEQ "super">
                                                <cfif menu_id eq "20715"><a href="../body/overview.cfm" onClick="popup('../#getMenu.menu_url#')"><cfelse><a href="../#getMenu.menu_url#"></cfif>
                                            </cfif>
                                            <div class="submenu">
                                                <cfif husergrpid EQ "super">
                                                    <cfif menu_id eq "20715"><a href="../body/overview.cfm" onClick="popup('../#getMenu.menu_url#')"><cfelse><a href="../#getMenu.menu_url#"></cfif>
                                                </cfif>
                                                <div class="title">#getMenu.newMenuName#</div>
                                                    <cfif husergrpid EQ "super">
                                                        </a>
                                                    </cfif>
                                                <div id="#getMenu.menu_id#" class="desp">#getMenu.titledesp#</div>
                                            </div>
                                            <cfif husergrpid NEQ "super">
                                            	</a>
                                            </cfif>
                                        </li>
                                    </cfif>
                                </cfloop>  
                                	<cfif trim(url.id) eq "10300" and lcase(hcomid) eq "keminates_i">
                                    	<li>
                                                <a href="/customized/keminates_i/firmProfile.cfm">
                                            <div class="submenu">
                                                <div class="title">Firm Profile</div>
                                                <div id="firmProfile" class="desp">Firm Profile</div>
                                            </div>
                                            	</a>
                                        </li>
                                    </cfif>
                                    <cfif trim(url.id) eq "50300" and lcase(hcomid) eq "keminates_i">
                                    	<li>
                                                <a href="/Report/KEMINATES/commReport.cfm">
                                            <div class="submenu">
                                                <div class="title">Designer Commission Report</div>
                                                <div id="firmProfile" class="desp">Designer Commission Report</div>
                                            </div>
                                            	</a>
                                        </li>
                                    </cfif>      
                                    <cfif trim(url.id) eq "10300" and lcase(hcomid) eq "hamari_i">
                                    	<li>
                                                <a href="/customized/hamari_i/buscommProfile.cfm">
                                            <div class="submenu">
                                                <div class="title">Business Commission Profile</div>
                                                <div id="firmProfile" class="desp">Business Commission Profile</div>
                                            </div>
                                            	</a>
                                        </li>
                                    </cfif>
                                    <cfif trim(url.id) eq "50300" and lcase(hcomid) eq "hamari_i">
                                    	<li>
                                                <a href="/customized/hamari_i/commissionReport.cfm">
                                            <div class="submenu">
                                                <div class="title">Business Commission Report</div>
                                                <div id="firmProfile" class="desp">Business Commission Report</div>
                                            </div>
                                            	</a>
                                        </li>
                                    </cfif>     
                                    <cfif trim(url.id) eq "10400">
                                    	<cfif getpin2.h10412 eq "T">
                                    	<li>
                                                <a href="/default/transaction/attendance/attendancetable.cfm">
                                            <div class="submenu">
                                                <div class="title">Cashier Login Profile</div>
                                                <div id="firmProfile" class="desp">Cashier Login Profile</div>
                                            </div>
                                            	</a>
                                        </li>
                                        </cfif>
                                    </cfif>  
                                    
                                    <cfif trim(url.id) eq "10300" and lcase(hcomid) eq "haikhim_i">
                                    	<li>
                                                <a href="/customized/haikhim_i/projectProfile.cfm">
                                            <div class="submenu">
                                                <div class="title">Project Profile</div>
                                                <div id="firmProfile" class="desp">Project Profile</div>
                                            </div>
                                            	</a>
                                        </li>
                                    </cfif>  
                                    <cfif trim(url.id) eq "50300" and lcase(hcomid) eq "lextravel_i">
                                    	<li>
                                                <a href="/report/lextravel/ticketcollectionreport.cfm">
                                            <div class="submenu">
                                                <div class="title">Ticket Collection Report</div>
                                                <div id="ticketcollection" class="desp">Ticket Collection Report</div>
                                            </div>
                                            	</a>
                                        </li>
                                        <li>
                                                <a href="/report/lextravel/dispatchreport.cfm">
                                            <div class="submenu">
                                                <div class="title">Dispatch Report</div>
                                                <div id="dispatchreport" class="desp">Dispatch Report</div>
                                            </div>
                                            	</a>
                                        </li>
                                    </cfif> 
                                    
                                    <cfif trim(url.id) eq "50300" and lcase(hcomid) eq "netilung_i">
                                    	<li>
                                                <a href="/report/tcds/memberitemhistory.cfm">
                                            <div class="submenu">
                                                <div class="title">Member Item History Report</div>
                                                <div id="memberitem" class="desp">Member Item History Report</div>
                                            </div>
                                            	</a>
                                        </li>
                                        <li>
                                                <a href="/report/tcds/memberpointhistory.cfm">
                                            <div class="submenu">
                                                <div class="title">Member Point History Report</div>
                                                <div id="memberpoint" class="desp">Member Point History Report</div>
                                            </div>
                                            	</a>
                                        </li>
                                    </cfif> 
                                    
                                    <cfif trim(url.id) eq "20100" and lcase(hcomid) eq "haikhim_i">
                                    	<li>
                                        <a href="/latest/body/overview.cfm" target="mainFrame" onClick="window.open('/default/transaction/expresshaikhim/index.cfm?first=true&type=rq','','fullscreen=yes,scrollbars=yes')">
											<div class="submenu">
                                                <div class="title">New Purchase Requsition</div>
                                                <div id="ticketcollection" class="desp">New Purchase Requsition</div>
                                            </div>
                                        </li>
                                    </cfif> 
                                    
                                    <cfif trim(url.id) eq "20700">
                                    	<li>
                                        <a href="/latest/body/overview.cfm" target="mainFrame" onClick="popup('/default/transaction/newpos/interface.cfm?first=true')">
											<div class="submenu">
                                                <div class="title">New POS</div>
                                                <div id="ticketcollection" class="desp">New POS(BETA)</div>
                                            </div>
                                        </li>
                                        <li>
                                        <a href="/latest/body/overview.cfm" target="mainFrame" onClick="popup2('/latest/transaction/checkprice.cfm?first=true')" >
											<div class="submenu">
                                                <div class="title">Check Price</div>
                                                <div id="ticketcollection" class="desp">Check Price</div>
                                            </div>
                                        </li>
                                    </cfif> 
                                    
                                    <cfif trim(url.id) eq "20300" and (lcase(hcomid) eq "emjay_i" or lcase(hcomid) eq "bigtree_i")>
                                    	<li>
                                        <a href="/latest/customization/emjay_i/importOAI.cfm" target="mainFrame">
											<div class="submenu">
                                                <div class="title">Import Adjustment</div>
                                                <div id="ticketcollection" class="desp">Import Adjustment</div>
                                            </div>
                                        </li>
                                    </cfif> 
                                    
                                    <cfif trim(url.id) eq "10300" and lcase(hcomid) eq "mika_i">
                                    	<li>
                                                <a href="/default/maintenance/dailyopening/s_dailycountertable.cfm">
                                            <div class="submenu">
                                                <div class="title">Cash Recording</div>
                                                <div id="firmProfile" class="desp">Cash Recording</div>
                                            </div>
                                            	</a>
                                        </li>
                                    </cfif>
                                    
                                    <cfif trim(url.id) eq "50300" and lcase(hcomid) eq "newapparel_i">
                                    	<li>
                                                <a href="/report/newapparel/mot.cfm">
                                            <div class="submenu">
                                                <div class="title">MOT Report</div>
                                                <div id="ticketcollection" class="desp">MOT Report</div>
                                            </div>
                                            	</a>
                                        </li>
                                        <li>
                                                <a href="/report/newapparel/stockanalysis.cfm">
                                            <div class="submenu">
                                                <div class="title">Stock Analysis</div>
                                                <div id="dispatchreport" class="desp">Stock Analysis Report</div>
                                            </div>
                                            	</a>
                                        </li>
                                        <li>
                                                <a href="/report/newapparel/stockmatrix.cfm">
                                            <div class="submenu">
                                                <div class="title">Stock Matrix Report</div>
                                                <div id="dispatchreport" class="desp">Stock Matrix Report</div>
                                            </div>
                                            	</a>
                                        </li>
                                        <li>
                                                <a href="/report/newapparel/stockmatrixsummary.cfm">
                                            <div class="submenu">
                                                <div class="title">Stock Matrix Summary Report</div>
                                                <div id="dispatchreport" class="desp">Stock Matrix Summary Report</div>
                                            </div>
                                            	</a>
                                        </li>
                                    </cfif>
                                    
                                    <cfif trim(url.id) eq "50300" and lcase(hcomid) eq "renowngift_i">
                                    	<li>
                                                <a href="/report/renowngift/eventlisting.cfm">
                                            <div class="submenu">
                                                <div class="title">Event Listing</div>
                                                <div id="eventlisting" class="desp">Event Listing</div>
                                            </div>
                                            	</a>
                                        </li>
                                    </cfif>
                                    
                                    <cfif trim(url.id) eq "50100" and lcase(hcomid) eq "rpi270505_i" and getpin2.h4140 eq "T">
                                    	<li>
                                                <a href="/report/RPI/billListingForm.cfm">
                                            <div class="submenu">
                                                <div class="title">Invoice Payment Listing</div>
                                                <div id="eventlisting" class="desp">Invoice Payment Listing</div>
                                            </div>
                                            	</a>
                                        </li>
                                    </cfif>
                                    
                                    <cfif trim(url.id) eq "60100" and lcase(husergrpid) eq "super">
                                    	<li>
                                                <a href="/default/admin/modulecontrol.cfm">
                                            <div class="submenu">
                                                <div class="title">Module control</div>
                                                <div id="eventlisting" class="desp">Module control</div>
                                            </div>
                                            	</a>
                                        </li>
                                    </cfif>
                                     
                            </ul>
                        </div>
                    </div>
                </div>
            </body>
        </cfoutput>
    </html>
</cfif>