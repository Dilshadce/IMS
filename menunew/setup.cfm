<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Testing</title>
<link rel="stylesheet" type="text/css" href="/newinterface/css1.css" />
<script language="javascript" type="text/javascript" src="/scripts/change_left_menunew.js"></script>

</head>

<body class="openerp">
<cfquery name="getGeneral" datasource="#dts#">
	select * 
	from gsetup;
</cfquery>
<cfquery name="getmodule" datasource="#dts#">
	select * 
	from modulecontrol;
</cfquery>

<cfquery name="getlanguage" datasource="#dts#">
select * from main.menulang
</cfquery>

<cfset menutitle=StructNew()>
<cfloop query="getlanguage">
<cfif getgeneral.dflanguage eq 'english'>
<cfset menutitle['#getlanguage.no#']=getlanguage.eng>
<cfelseif getgeneral.dflanguage eq 'sim_ch'>
<cfset menutitle['#getlanguage.no#']=getlanguage.sim_ch>
<cfelseif getgeneral.dflanguage eq 'tra_ch'>
<cfset menutitle['#getlanguage.no#']=getlanguage.tra_ch>
</cfif>
</cfloop>

<cfoutput>
<div style="overflow:hidden;">
<div class="secondary_menu">
<div id="masterdiv">
<cfif getpin2.h5000 eq "T">
<cfif getpin2.h5100 eq "T">
		<li onClick="SwitchMenu('sub1')"><a class="oe_secondary_menu_item" style="cursor:pointer">
            <cfoutput>#menutitle[105]#</cfoutput></a>
        </li>
            <span id="sub1" style="display:none;" class="submenu">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/comprofile.cfm" target="mainFrame">
                	<cfoutput>#menutitle[360]#</cfoutput>   
                </a>
            </li>
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/lastusedno.cfm" target="mainFrame">
                	<cfoutput>#menutitle[361]#</cfoutput>     
                </a>
            </li>
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/transaction.cfm" target="mainFrame">
                   <cfoutput>#menutitle[362]#</cfoutput> 
                </a>
            </li>
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/Accountno.cfm" target="mainFrame">
                   <cfoutput>#menutitle[363]#</cfoutput> 
                </a>
            </li>
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/userdefine.cfm" target="mainFrame">
                    <cfoutput>#menutitle[364]#</cfoutput> 
                </a>
            </li>
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/dealer_menu/dealer_menu.cfm" target="mainFrame">
                    <cfoutput>#menutitle[365]#</cfoutput> 
                </a>
            </li>
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/transaction_menu/transation_menu.cfm" target="mainFrame">
                    <cfoutput>#menutitle[366]#</cfoutput> 
                </a>
            </li>
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/userdefineformula.cfm" target="mainFrame">
                   <cfoutput>#menutitle[367]#</cfoutput> 
                </a>
            </li>
            
	</span>
    </cfif>
    <cfif getpin2.h5300 eq "T" or getpin2.h5500 eq "T">
        <li onClick="SwitchMenu('sub2')"><a class="oe_secondary_menu_item" style="cursor:pointer">
        <cfoutput>#menutitle[368]#</cfoutput> </a></li>
        <span id="sub2" style="display:none;" class="submenu">
            <cfif getpin2.h5300 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/vuser.cfm" target="mainFrame">
                        <cfoutput>#menutitle[106]#</cfoutput>
                    </a>
                </li>
            </cfif>
            <cfif getpin2.h5500 eq "T">
                <li>
                    <!---a href="/#HDir#/admin/userdefinedmenu.cfm" target="mainFrame">
                        User Defined Menu
                    </a--->
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/userdefinedmenu/usergroup.cfm" target="mainFrame">
                        <cfoutput>#menutitle[107]#</cfoutput>
                    </a>
                </li>
        </cfif>
    </span>
    </cfif>
	<cfif getpin2.h5400 eq "T">
        <li onClick="SwitchMenu('sub3')"><a class="oe_secondary_menu_item" style="cursor:pointer">
   		 <cfoutput>#menutitle[369]#</cfoutput> </a></li>
    <span id="sub3" style="display:none;" class="submenu">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/currency/vcurrency.cfm" target="mainFrame">
                    <cfoutput>#menutitle[108]#</cfoutput>
                </a>
            </li>
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/tax/tax.cfm" target="mainFrame">
                    <cfoutput>#menutitle[109]#</cfoutput>
                </a>
            </li>
	</span>
    </cfif>
	<cfif getpin2.h5600 eq "T" or hcomid eq "hairo_i">
		<li onClick="SwitchMenu('sub4')"><a class="oe_secondary_menu_item" style="cursor:pointer">
        <cfoutput>#menutitle[370]#</cfoutput> </a></li>
        <span id="sub4" style="display:none;" class="submenu">

			<cfif getpin2.h5600 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/posting2/postingacc.cfm?status=UNPOSTED" target="mainFrame">
                         <cfif Hlinkams eq "Y"><cfoutput>#menutitle[110]#</cfoutput>
                         <cfelse>
                         <cfoutput>#menutitle[407]#</cfoutput> 
                         </cfif>
                    </a>
                </li>
                <cfif hcomid eq "hairo_i">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/posting2/postingacc.cfm?status=UNPOSTED&ubs=yes" target="mainFrame">
                        <cfoutput>#menutitle[111]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/postingcontrol/armcancel.cfm" target="mainFrame">
                        <cfoutput>#menutitle[112]#</cfoutput>
                    </a>
                </li>	
            </cfif>	
    </span>
    </cfif>
	<cfif getpin2.h5200 eq "T" and husergrpid eq "super">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/admin/yearend.cfm" target="mainFrame">
				<cfoutput>#menutitle[371]#</cfoutput> 
			</a>
		</li>
	</cfif>
	<cfif getpin2.H5800 eq "T">
        <li onClick="SwitchMenu('sub5')"><a class="oe_secondary_menu_item" style="cursor:pointer">
    	<cfoutput>#menutitle[372]#</cfoutput></a></li>
    <span id="sub5" style="display:none;" class="submenu">
    
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/viewaudit_trail.cfm" target="mainFrame">
                    <cfoutput>#menutitle[113]#</cfoutput>
                </a>
            </li>
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/viewaudit_trail_custsuppitem.cfm" target="mainFrame">
                    <cfoutput>#menutitle[114]#</cfoutput>
                </a>
            </li>
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/viewaudit_bossmenu.cfm" target="mainFrame">
                    <cfoutput>#menutitle[115]#</cfoutput>
                </a>
            </li>
	</span>
    </cfif>
    <cfif husergrpid eq "super" or husergrpid eq "admin">
        <li onClick="SwitchMenu('sub6')"><a class="oe_secondary_menu_item" style="cursor:pointer">
    	<cfoutput>#menutitle[373]#</cfoutput></a></li>
    <span id="sub6" style="display:none;" class="submenu">
    
       		 <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/viewloginhistory.cfm" target="mainFrame">
                    <cfoutput>#menutitle[117]#</cfoutput>
                </a>
            </li>
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/logoutreport.cfm" target="mainFrame">
                    <cfoutput>#menutitle[119]#</cfoutput>
                </a>
            </li>
    </span>
    </cfif>
    <cfif husergrpid eq "super" or husergrpid eq "admin">
        <li onClick="SwitchMenu('sub7')"><a class="oe_secondary_menu_item" style="cursor:pointer">
    	<cfoutput>#menutitle[374]#</cfoutput></a></li>
    <span id="sub7" style="display:none;" class="submenu">
    
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/importtable/import.cfm" target="mainFrame">
                    <cfoutput>#menutitle[375]#</cfoutput>
                </a>
            </li>
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/importtable/import_excel.cfm" target="mainFrame">
                    <cfoutput>#menutitle[118]#</cfoutput>
                </a>
            </li>
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/export_to_csv_list.cfm" target="mainFrame">
                    <cfoutput>#menutitle[376]#</cfoutput>
                </a>
            </li>
        <cfif lcase(HcomID) eq "kjcpl_i">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/export_to_csvtransfer_list.cfm" target="mainFrame">
                    <cfoutput>#menutitle[377]#</cfoutput>
                </a>
            </li>
        </cfif>
    </span>
    </cfif>
	<cfif husergrpid eq "admin">
		<li>
			<a class="oe_secondary_submenu_item" href="/super_menu/recalculateqty.cfm" target="mainFrame">
				<cfoutput>#menutitle[120]#</cfoutput>
			</a>
		</li>
    	<li>
			<a class="oe_secondary_submenu_item" href="/super_menu/addbillformat.cfm" target="mainFrame">
				<cfoutput>#menutitle[121]#</cfoutput>
			</a>
		</li>
    </cfif>
    <cfif (lcase(HcomID) eq "thaipore_i" and findnocase("Priscillathaipore",HUserID)) or lcase(hcomid) eq "laihock_i">
		<li>
			<a class="oe_secondary_submenu_item" href="/super_menu/changeitemno.cfm" target="mainFrame">
				<cfoutput>#menutitle[378]#</cfoutput>
			</a>
		</li>
	</cfif>
<!--- 	<cfif Hlinkams eq "Y">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/admin/posting2/irasPosting.cfm" target="mainFrame">
				Iras Posting
			</a>
		</li>
	</cfif> --->
	<cfif getpin2.H5900 eq "T">
		<li onClick="SwitchMenu('sub8')"><a class="oe_secondary_menu_item" style="cursor:pointer">
        <cfoutput>#menutitle[122]#</cfoutput></a></li>
        <span id="sub8" style="display:none;" class="submenu">
		<li onClick="SwitchMenu2('sub9')"><a class="oe_secondary_menu_item" style="cursor:pointer">
		<cfoutput>#menutitle[379]#</cfoutput> </a></li>
        <span id="sub9" style="display:none;" class="submenu2">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changeitemno.cfm" target="mainFrame">
                        <cfoutput>#menutitle[378]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changecategory.cfm" target="mainFrame">
                        <cfoutput>#menutitle[380]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changegroup.cfm" target="mainFrame">
                        <cfoutput>#menutitle[381]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changeservice.cfm" target="mainFrame">
                        <cfoutput>#menutitle[382]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changebrand.cfm" target="mainFrame">
                        <cfoutput>#menutitle[383]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/" target="mainFrame">
                        <cfoutput>#menutitle[384]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changeagent.cfm" target="mainFrame">
                        <cfoutput>#menutitle[385]#</cfoutput>
                    </a>
                </li>
                
    	</span>
        <li onClick="SwitchMenu2('sub10')"><a class="oe_secondary_menu_item" style="cursor:pointer">
		<cfoutput>#menutitle[386]#</cfoutput> </a></li>
        <span id="sub10" style="display:none;" class="submenu2">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changecustsupp.cfm?custtype=Customer" target="mainFrame">
                        <cfoutput>#menutitle[387]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changecustsupp.cfm?custtype=Supplier" target="mainFrame">
                        <cfoutput>#menutitle[388]#</cfoutput>
                    </a>
                </li>
                
    	</span>
        <li onClick="SwitchMenu2('sub11')"><a class="oe_secondary_menu_item" style="cursor:pointer">
		<cfoutput>#menutitle[389]#</cfoutput></a></li>
        <span id="sub11" style="display:none;" class="submenu2">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changerefno.cfm" target="mainFrame">
                        <cfoutput>#menutitle[390]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/recovertransaction.cfm" target="mainFrame">
                        <cfoutput>#menutitle[391]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/enableedit.cfm" target="mainFrame">
                        <cfoutput>#menutitle[392]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changedate.cfm" target="mainFrame">
                        <cfoutput>#menutitle[393]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/costformula.cfm" target="mainFrame">
                        <cfoutput>#menutitle[394]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changeterm.cfm" target="mainFrame">
                        <cfoutput>#menutitle[395]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/recovervoid.cfm" target="mainFrame">
                        <cfoutput>#menutitle[396]#</cfoutput>
                    </a>
                </li>
    	</span>
        <li onClick="SwitchMenu2('sub13')"><a class="oe_secondary_menu_item" style="cursor:pointer">
		<cfoutput>#menutitle[397]#</cfoutput> </a></li>
        <span id="sub13" style="display:none;" class="submenu2">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changeproject.cfm" target="mainFrame">
                        <cfoutput>#menutitle[398]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changejob.cfm" target="mainFrame">
                        <cfoutput>#menutitle[399]#</cfoutput>
                    </a>
                </li>
    	</span>

        <li onClick="SwitchMenu2('sub12')"><a class="oe_secondary_menu_item" style="cursor:pointer">
		<cfoutput>#menutitle[400]#</cfoutput></a></li>
        <span id="sub12" style="display:none;" class="submenu2">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changeenduser.cfm" target="mainFrame">
                        <cfoutput>#menutitle[401]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changeteam.cfm" target="mainFrame">
                        <cfoutput>#menutitle[402]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changebusiness.cfm" target="mainFrame">
                        <cfoutput>#menutitle[403]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changearea.cfm" target="mainFrame">
                        <cfoutput>#menutitle[404]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changeaddress.cfm" target="mainFrame">
                        <cfoutput>#menutitle[405]#</cfoutput>
                    </a>
                </li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changelocation.cfm" target="mainFrame">
                        <cfoutput>#menutitle[406]#</cfoutput>
                    </a>
                </li>
                
    	</span>
    </span>
    </cfif>
    
	<cfif getpin2.H5A00 eq "T" or getpin2.H5B00 eq "T" or getpin2.H5C00 eq "T">
    <li onClick="SwitchMenu('sub13')"><a class="oe_secondary_menu_item" style="cursor:pointer">
        <cfoutput>#menutitle[175]#</cfoutput></a></li>
        <span id="sub13" style="display:none;" class="submenu">
            <cfif getpin2.H5A00 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/super_menu/updateproject.cfm" target="mainFrame">
                        <cfoutput>#menutitle[123]#</cfoutput>
                    </a>
                </li>
            </cfif>
            <cfif getpin2.H5B00 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/sync/" target="mainFrame">
                        <cfoutput>#menutitle[124]#</cfoutput>
                    </a>
                </li>
            </cfif>
            <cfif getpin2.H5C00 eq "T">
                 <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/MonthlyBackup.cfm" target="mainFrame">
                        <cfoutput>#menutitle[125]#</cfoutput>
                    </a>
                </li>
            </cfif>
    </span>
    </cfif>
</cfif>
</div>
</div>
</div>
</cfoutput>
</body>
</html>