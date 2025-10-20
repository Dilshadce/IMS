<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Testing</title>
<link rel="stylesheet" type="text/css" href="/newinterface2/css1.css" />
<script language="javascript" type="text/javascript" src="/scripts/change_left_menunew.js"></script>

</head>

<body class="netiquette">
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
<cfelseif getgeneral.dflanguage eq 'Indonesian'>
<cfset menutitle['#getlanguage.no#']=getlanguage.Indonesian>
</cfif>
</cfloop>

<cfoutput>
<div style="overflow:hidden;">
<div class="secondary_menu">
<div id="masterdiv">
<cfif getpin2.h5000 eq "T">
<cfif getpin2.h5100 eq "T">
		<li onClick="SwitchMenu('sub1')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[105]#</cfoutput>">
            <cfoutput>#menutitle[105]#</cfoutput></a>
        </li>
            <span id="sub1" style="display:none;" class="submenu">
            <cfif getpin2.h5110 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/comprofile.cfm" target="mainFrame" title="<cfoutput>#menutitle[360]#</cfoutput>">
                	<cfoutput>#menutitle[360]#</cfoutput>   
                </a>
            </li>
            </cfif>
            <cfif getpin2.h5120 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/lastusedno.cfm" target="mainFrame" title="<cfoutput>#menutitle[361]#</cfoutput>">
                	<cfoutput>#menutitle[361]#</cfoutput>     
                </a>
            </li>
            </cfif>
            <cfif getpin2.h5130 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/transaction.cfm" target="mainFrame" title="<cfoutput>#menutitle[362]#</cfoutput>">
                   <cfoutput>#menutitle[362]#</cfoutput> 
                </a>
            </li>
            </cfif>
            <cfif getpin2.h5140 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/Accountno.cfm" target="mainFrame" title="<cfoutput>#menutitle[363]#</cfoutput>">
                   <cfif Hlinkams eq "Y">
				   <cfoutput>#menutitle[434]#</cfoutput>
                   <cfelse>
                   <cfoutput>#menutitle[363]#</cfoutput>
                   </cfif> 
                </a>
            </li>
            
            <li>
                <a class="oe_secondary_submenu_item" href="/stockbatches/stockbatches.cfm" target="mainFrame" title="<cfoutput>#menutitle[363]#</cfoutput>">
                   <cfoutput>#menutitle[433]#</cfoutput> 
                </a>
            </li>
            </cfif>
            <cfif getpin2.h5150 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/userdefine.cfm" target="mainFrame" title="<cfoutput>#menutitle[364]#</cfoutput>">
                    <cfoutput>#menutitle[364]#</cfoutput> 
                </a>
            </li>
            </cfif>
            <cfif getpin2.h5160 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/dealer_menu/dealer_menu.cfm" target="mainFrame" title="<cfoutput>#menutitle[365]#</cfoutput>">
                    <cfoutput>#menutitle[365]#</cfoutput> 
                </a>
            </li>
            </cfif>
            <cfif getpin2.h5170 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/transaction_menu/transaction_menu.cfm" target="mainFrame" title="<cfoutput>#menutitle[366]#</cfoutput>">
                    <cfoutput>#menutitle[366]#</cfoutput> 
                </a>
            </li>
            </cfif>
            <cfif getpin2.h5180 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/userdefineformula.cfm" target="mainFrame" title="<cfoutput>#menutitle[367]#</cfoutput>">
                   <cfoutput>#menutitle[367]#</cfoutput> 
                </a>
            </li>
            </cfif>
            
	</span>
    </cfif>

        <li onClick="SwitchMenu('sub2')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[368]#</cfoutput>">
        <cfoutput>#menutitle[368]#</cfoutput> </a></li>
        <span id="sub2" style="display:none;" class="submenu">
            <cfif getpin2.h5300 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/vuser.cfm" target="mainFrame" title="<cfoutput>#menutitle[106]#</cfoutput>">
                        <cfoutput>#menutitle[106]#</cfoutput>
                    </a>
                </li>
            </cfif>
            <cfif getpin2.h5500 eq "T">
                <li>
                    <!---a href="/#HDir#/admin/userdefinedmenu.cfm" target="mainFrame">
                        User Defined Menu
                    </a--->
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/userdefinedmenu/usergroup.cfm" target="mainFrame" title="<cfoutput>#menutitle[107]#</cfoutput>">
                        <cfoutput>#menutitle[107]#</cfoutput>
                    </a>
                </li>
        	</cfif>
            
                <li>
                    <a class="oe_secondary_submenu_item" href="/changepass/index.cfm" target="mainFrame" title="<cfoutput>#menutitle[431]#</cfoutput>">
                        <cfoutput>#menutitle[431]#</cfoutput>
                    </a>
                </li>
            
    </span>

	
        <cfif getpin2.h5400 eq "T" or getpin2.h5G00 eq "T">
        <li onClick="SwitchMenu('sub3')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[369]#</cfoutput>">
   		 <cfoutput>#menutitle[369]#</cfoutput> </a></li>
    <span id="sub3" style="display:none;" class="submenu">
            <cfif getpin2.h5400 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/currency/vcurrency.cfm" target="mainFrame" title="<cfoutput>#menutitle[108]#</cfoutput>">
                    <cfoutput>#menutitle[108]#</cfoutput>
                </a>
            </li>
            </cfif>
            <cfif getpin2.h5G00 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/tax/tax.cfm" target="mainFrame" title="<cfoutput>#menutitle[109]#</cfoutput>">
                    <cfoutput>#menutitle[109]#</cfoutput>
                </a>
            </li>
            </cfif>
	</span>
    </cfif>
    
	<cfif getpin2.h5600 eq "T" or hcomid eq "hairo_i">
		<li onClick="SwitchMenu('sub4')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[370]#</cfoutput>">
        <cfoutput>#menutitle[370]#</cfoutput> </a></li>
        <span id="sub4" style="display:none;" class="submenu">

			<cfif getpin2.h5600 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/posting2/postingacc.cfm?status=UNPOSTED" target="mainFrame" title="<cfif Hlinkams eq "Y"><cfoutput>#menutitle[110]#</cfoutput>
                         <cfelse>
                         <cfoutput>#menutitle[407]#</cfoutput> 
                         </cfif>">
                         <cfif Hlinkams eq "Y"><cfoutput>#menutitle[110]#</cfoutput>
                         <cfelse>
                         <cfoutput>#menutitle[407]#</cfoutput> 
                         </cfif>
                    </a>
                </li>
                
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/posting2/postingacc.cfm?status=UNPOSTED&ubs=yes" target="mainFrame" title="<cfoutput>#menutitle[111]#</cfoutput>">
                        <cfoutput>#menutitle[111]#</cfoutput>
                    </a>
                </li>
               
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/postingcontrol/armcancel.cfm" target="mainFrame" title="<cfoutput>#menutitle[112]#</cfoutput>">
                        <cfoutput>#menutitle[112]#</cfoutput>
                    </a>
                </li>	
            </cfif>	
    </span>
    </cfif>
	<cfif getpin2.h5200 eq "T" and (husergrpid eq "super" or hcomid eq 'aepl_i' or hcomid eq 'aeisb_i' or hcomid eq 'risb_i' or hcomid eq 'aespl_i'  or hcomid eq 'colorinc_i')>
        <li onClick="SwitchMenu('sub15')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="Year End">
    	<cfoutput>Year End</cfoutput></a></li>
    <span id="sub15" style="display:none;" class="submenu">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/admin/yearend.cfm" target="mainFrame" title="<cfoutput>#menutitle[371]#</cfoutput>">
				<cfoutput>#menutitle[371]#</cfoutput> 
			</a>
		</li>
        
        <li>
			<a class="oe_secondary_submenu_item" href="/super_menu/fifo_costing_recalculate.cfm" target="mainFrame">
				FIFO Costing Calculation After Year-End
			</a>
		</li>
		<li>
			<a class="oe_secondary_submenu_item" href="/super_menu/recalculatelocationqty.cfm" target="mainFrame">
				Location QtyBf Calculation After Year-End
			</a>
		</li>
       <li>
			<a class="oe_secondary_submenu_item" href="/super_menu/calculate_gradeqty.cfm" target="mainFrame">
				Grade QtyBf Calculation After Year-End
			</a>
		</li>
    </span>
	</cfif>
	<cfif getpin2.H5800 eq "T" or getpin2.H5810 eq "T" or getpin2.H5820 eq "T" or getpin2.H5830 eq "T">
        <li onClick="SwitchMenu('sub5')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[372]#</cfoutput>">
    	<cfoutput>#menutitle[372]#</cfoutput></a></li>
    <span id="sub5" style="display:none;" class="submenu">
    
            <cfif getpin2.H5810 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/viewaudit_trail.cfm" target="mainFrame" title="<cfoutput>#menutitle[113]#</cfoutput>">
                    <cfoutput>#menutitle[113]#</cfoutput>
                </a>
            </li>
            
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/lastusednoaudit_trail.cfm" target="_blank" title="<cfoutput>#menutitle[113]#</cfoutput>">
                    <cfoutput>Last Used No Audit Trail</cfoutput>
                </a>
            </li>
            </cfif>
            <cfif getpin2.H5820 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/viewaudit_trail_custsuppitem.cfm" target="mainFrame" title="<cfoutput>#menutitle[114]#</cfoutput>">
                    <cfoutput>#menutitle[114]#</cfoutput>
                </a>
            </li>
            </cfif>
            <cfif getpin2.H5830 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/viewaudit_bossmenu.cfm" target="mainFrame" title="<cfoutput>#menutitle[115]#</cfoutput>">
                    <cfoutput>#menutitle[115]#</cfoutput>
                </a>
            </li>
            </cfif>
	</span>
    </cfif>
    <cfif husergrpid eq "super" or husergrpid eq "admin">
    <cfif getpin2.H5H00 eq "T" or getpin2.H5H10 eq "T" or getpin2.H5H20 eq "T">
        <li onClick="SwitchMenu('sub6')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[373]#</cfoutput>">
    	<cfoutput>#menutitle[373]#</cfoutput></a></li>
    <span id="sub6" style="display:none;" class="submenu">
    
       		 <cfif getpin2.H5H10 eq "T">
             <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/viewloginhistory.cfm" target="mainFrame" title="<cfoutput>#menutitle[117]#</cfoutput>">
                    <cfoutput>#menutitle[117]#</cfoutput>
                </a>
            </li>
            </cfif>
            <cfif getpin2.H5H20 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/logoutreport.cfm" target="mainFrame" title="<cfoutput>#menutitle[119]#</cfoutput>">
                    <cfoutput>#menutitle[119]#</cfoutput>
                </a>
            </li>
            </cfif>
    </span>
    </cfif>
    </cfif>
    
    <cfif  getpin2.H5D00 eq "T" or getpin2.H5E00 eq "T" or getpin2.H5F00 eq "T" or lcase(HcomID) eq "kjcpl_i" or (lcase(HcomID) eq "thaipore_i" and findnocase("Priscillathaipore",HUserID)) or lcase(hcomid) eq "laihock_i" or getpin2.H5I00 eq "T" or getpin2.H5J00 eq "T">
        <li onClick="SwitchMenu('sub7')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[374]#</cfoutput>">
    	<cfoutput>#menutitle[374]#</cfoutput></a></li>
    <span id="sub7" style="display:none;" class="submenu">
    
            <cfif getpin2.H5D00 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/importtable/import.cfm" target="mainFrame" title="<cfoutput>#menutitle[375]#</cfoutput>">
                    <cfoutput>#menutitle[375]#</cfoutput>
                </a>
            </li>
            </cfif>
            <cfif getpin2.H5E00 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/importtable/import_excel.cfm" target="mainFrame" title="<cfoutput>#menutitle[118]#</cfoutput>">
                    <cfoutput>#menutitle[118]#</cfoutput>
                </a>
            </li>
            </cfif>
            <cfif getpin2.H5F00 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/export_to_csv_list.cfm" target="mainFrame" title="<cfoutput>#menutitle[376]#</cfoutput>">
                    <cfoutput>#menutitle[376]#</cfoutput>
                </a>
            </li>
            </cfif>
        <cfif lcase(HcomID) eq "kjcpl_i">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/admin/export_to_csvtransfer_list.cfm" target="mainFrame" title="<cfoutput>#menutitle[377]#</cfoutput>">
                    <cfoutput>#menutitle[377]#</cfoutput>
                </a>
            </li>
        </cfif>

		<cfif getpin2.H5I00 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/super_menu/recalculateqty.cfm" target="mainFrame" title="<cfoutput>#menutitle[120]#</cfoutput>">
				<cfoutput>#menutitle[120]#</cfoutput>
			</a>
		</li>
        </cfif>
        <cfif getpin2.H5J00 eq "T">
    	<li>
			<a class="oe_secondary_submenu_item" href="/super_menu/upload.cfm" target="mainFrame" title="<cfoutput>#menutitle[121]#</cfoutput>">
				<cfoutput>#menutitle[121]#</cfoutput>
			</a>
		</li>
        </cfif>
        <cfif getpin2.H5K00 eq "T">
          <li>
			<a class="oe_secondary_submenu_item" href="/super_menu/addbillformat.cfm" target="mainFrame" title="<cfoutput>#menutitle[442]#</cfoutput>">
				<cfoutput>#menutitle[442]#</cfoutput>
			</a>
		</li>
        </cfif>
    <cfif (lcase(HcomID) eq "thaipore_i" and findnocase("Priscillathaipore",HUserID)) or lcase(hcomid) eq "laihock_i">
		<li>
			<a class="oe_secondary_submenu_item" href="/super_menu/changeitemno.cfm" target="mainFrame" title="<cfoutput>#menutitle[378]#</cfoutput>">
				<cfoutput>#menutitle[378]#</cfoutput>
			</a>
		</li>
	</cfif>
    </span></cfif>

<!--- 	<cfif Hlinkams eq "Y">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/admin/posting2/irasPosting.cfm" target="mainFrame">
				Iras Posting
			</a>
		</li>
	</cfif> --->
	<cfif getpin2.H5900 eq "T">
		<li onClick="SwitchMenu('sub8')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[122]#</cfoutput>">
        <cfoutput>#menutitle[122]#</cfoutput></a></li>
        <span id="sub8" style="display:none;" class="submenu">
        
        <cfif getpin2.H5910 eq "T" or getmodule.auto eq "1" or getpin2.H5970 eq "T" or getpin2.H59M0 eq "T" or getpin2.H5990 eq "T" or getpin2.H5940 eq "T" or getpin2.H5930 eq "T" or getpin2.H5920 eq "T">
		<li onClick="SwitchMenu2('sub9')"><a class="oe_secondary_menu_item2" style="cursor:pointer" title="<cfoutput>#menutitle[379]#</cfoutput>">
		<cfoutput>#menutitle[379]#</cfoutput> </a></li>
        <span id="sub9" style="display:none;" class="submenu2">
                <cfif getpin2.H5910 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changeitemno.cfm" target="mainFrame" title="<cfoutput>#menutitle[378]#</cfoutput>">
                        <cfoutput>#menutitle[378]#</cfoutput>
                    </a>
                </li>
                <cfif left(dts,4) eq "tcds" or dts eq "demo_i">
                 <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/replaceitemno.cfm" target="mainFrame" title="<cfoutput>#menutitle[378]#</cfoutput>">
                        <cfoutput>Replace Item No</cfoutput>
                    </a>
                </li>
				</cfif>
                </cfif>
                <cfif getpin2.H5920 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changecategory.cfm" target="mainFrame" title="<cfoutput>#menutitle[380]#</cfoutput>">
                    <cfif getgeneral.dflanguage eq 'english'>
           Change <cfoutput>#getgeneral.lcategory#</cfoutput> 
            <cfelse>
                        <cfoutput>#menutitle[380]#</cfoutput>
                        </cfif>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H5930 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changegroup.cfm" target="mainFrame" title="<cfoutput>#menutitle[381]#</cfoutput>">
                    <cfif getgeneral.dflanguage eq 'english'>
           Change <cfoutput>#getgeneral.lgroup#</cfoutput> 
            <cfelse>
                        <cfoutput>#menutitle[381]#</cfoutput>
                        </cfif>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H5940 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changeservice.cfm" target="mainFrame" title="<cfoutput>#menutitle[382]#</cfoutput>">
                        <cfoutput>#menutitle[382]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H5990 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changebrand.cfm" target="mainFrame" title="<cfoutput>#menutitle[383]#</cfoutput>">
                    <cfif getgeneral.dflanguage eq 'english'>
           Change <cfoutput>#getgeneral.lbrand#</cfoutput> 
            <cfelse>
                        <cfoutput>#menutitle[383]#</cfoutput>
                        </cfif>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H59M0 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changecolorid.cfm" target="mainFrame" title="<cfoutput>#menutitle[384]#</cfoutput>">
                        <cfoutput>#menutitle[384]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H5970 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changeagent.cfm" target="mainFrame" title="<cfoutput>#menutitle[385]#</cfoutput>">
                        <cfoutput>#menutitle[385]#</cfoutput>
                    </a>
                </li>
                </cfif>
                
                <cfif getmodule.auto eq "1">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changevehicle.cfm" target="mainFrame" title="<cfoutput>#menutitle[429]#</cfoutput>">
                        <cfoutput>#menutitle[429]#</cfoutput>
                    </a>
                </li>
				</cfif>
                
                
    	</span>
        </cfif>
        <cfif getpin2.H5950 eq "T" or getpin2.H5960 eq "T">
        <li onClick="SwitchMenu2('sub10')"><a class="oe_secondary_menu_item2" style="cursor:pointer" title="<cfoutput>#menutitle[386]#</cfoutput>">
		<cfoutput>#menutitle[386]#</cfoutput> </a></li>
        <span id="sub10" style="display:none;" class="submenu2">
                <cfif getpin2.H5950 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changecustsupp.cfm?custtype=Customer" target="mainFrame" title="<cfoutput>#menutitle[387]#</cfoutput>">
                        <cfoutput>#menutitle[387]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H5960 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changecustsupp.cfm?custtype=Supplier" target="mainFrame" title="<cfoutput>#menutitle[388]#</cfoutput>">
                        <cfoutput>#menutitle[388]#</cfoutput>
                    </a>
                </li>
                </cfif>
                
    	</span>
        </cfif>
        <cfif getpin2.H5980 eq "T" or getpin2.H59I0 eq "T" or getpin2.H59H0 eq "T" or getpin2.H59G0 eq "T" or getpin2.H59F0 eq "T" or getpin2.H59E0 eq "T" or getpin2.H59C0 eq "T">
        <li onClick="SwitchMenu2('sub11')"><a class="oe_secondary_menu_item2" style="cursor:pointer" title="<cfoutput>#menutitle[389]#</cfoutput>">
		<cfoutput>#menutitle[389]#</cfoutput></a></li>
        <span id="sub11" style="display:none;" class="submenu2">
                <cfif getpin2.H5980 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changerefno.cfm" target="mainFrame" title="<cfoutput>#menutitle[390]#</cfoutput>">
                        <cfoutput>#menutitle[390]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H59C0 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/recovertransaction.cfm" target="mainFrame" title="<cfoutput>#menutitle[391]#</cfoutput>">
                        <cfoutput>#menutitle[391]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H59E0 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/enableedit.cfm" target="mainFrame" title="<cfoutput>#menutitle[392]#</cfoutput>">
                        <cfoutput>#menutitle[392]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H59F0 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changedate.cfm" target="mainFrame" title="<cfoutput>#menutitle[393]#</cfoutput>">
                        <cfoutput>#menutitle[393]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H59G0 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/costformula.cfm" target="mainFrame" title="<cfoutput>#menutitle[394]#</cfoutput>">
                        <cfoutput>#menutitle[394]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H59H0 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changeterm.cfm" target="mainFrame" title="<cfoutput>#menutitle[395]#</cfoutput>">
                        <cfoutput>#menutitle[395]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H59I0 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/recovervoid.cfm" target="mainFrame" title="<cfoutput>#menutitle[396]#</cfoutput>">
                        <cfoutput>#menutitle[396]#</cfoutput>
                    </a>
                </li>
                </cfif>
    	</span>
        </cfif>
        <cfif getpin2.H59A0 eq "T" or getpin2.H59B0 eq "T">
        <li onClick="SwitchMenu2('sub13')"><a class="oe_secondary_menu_item2" style="cursor:pointer" title="<cfoutput>#menutitle[397]#</cfoutput>">
        <cfif getgeneral.dflanguage eq 'english'>
           <cfoutput>#getgeneral.lproject#&#getgeneral.ljob#</cfoutput> 
            <cfelse>
		<cfoutput>#menutitle[397]#</cfoutput> 
        </cfif></a></li>
        <span id="sub13" style="display:none;" class="submenu2">
                <cfif getpin2.H59A0 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changeproject.cfm" target="mainFrame" title="<cfoutput>#menutitle[398]#</cfoutput>">
                    <cfif getgeneral.dflanguage eq 'english'>
           Change <cfoutput>#getgeneral.lproject#</cfoutput> 
            <cfelse>
                        <cfoutput>#menutitle[398]#</cfoutput>
                        </cfif>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H59B0 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changejob.cfm" target="mainFrame" title="<cfoutput>#menutitle[399]#</cfoutput>">
                    <cfif getgeneral.dflanguage eq 'english'>
           Change <cfoutput>#getgeneral.ljob#</cfoutput> 
            <cfelse>
                        <cfoutput>#menutitle[399]#</cfoutput>
                        </cfif>
                    </a>
                </li>
                </cfif>
    	</span>
        </cfif>

        <cfif getpin2.H59D0 eq "T" or getpin2.H59L0 eq "T" or getpin2.H59K0 eq "T" or getpin2.H59N0 eq "T" or getpin2.H59O0 eq "T">
        <li onClick="SwitchMenu2('sub12')"><a class="oe_secondary_menu_item2" style="cursor:pointer" title="<cfoutput>#menutitle[400]#</cfoutput>">
		<cfoutput>#menutitle[400]#</cfoutput></a></li>
        <span id="sub12" style="display:none;" class="submenu2">
                <cfif getpin2.H59D0 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changeenduser.cfm" target="mainFrame" title="<cfoutput>#menutitle[401]#</cfoutput>">
                        <cfoutput>#menutitle[401]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H59L0 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changeteam.cfm" target="mainFrame" title="<cfoutput>#menutitle[402]#</cfoutput>">
                        <cfoutput>#menutitle[402]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H59J0 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changebusiness.cfm" target="mainFrame" title="<cfoutput>#menutitle[403]#</cfoutput>">
                        <cfoutput>#menutitle[403]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H59K0 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changearea.cfm" target="mainFrame" title="<cfoutput>#menutitle[404]#</cfoutput>">
                        <cfoutput>#menutitle[404]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H59N0 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changeaddress.cfm" target="mainFrame" title="<cfoutput>#menutitle[405]#</cfoutput>">
                        <cfoutput>#menutitle[405]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.H59O0 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/bossmenu/changelocation.cfm" target="mainFrame" title="<cfoutput>#menutitle[406]#</cfoutput>">
                        <cfoutput>#menutitle[406]#</cfoutput>
                    </a>
                </li>
                </cfif>
                
    	</span>
        </cfif>
    </span>
    </cfif>
    
	<cfif getpin2.H5A00 eq "T" or getpin2.H5B00 eq "T" or getpin2.H5C00 eq "T">
    <li onClick="SwitchMenu('sub14')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[411]#</cfoutput>">
        <cfoutput>#menutitle[411]#</cfoutput></a></li>
        <span id="sub14" style="display:none;" class="submenu">
            <cfif getpin2.H5A00 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/super_menu/updateproject.cfm" target="mainFrame" title="<cfoutput>#menutitle[123]#</cfoutput>">
                        <cfoutput>#menutitle[123]#</cfoutput>
                    </a>
                </li>
            </cfif>
            <cfif getpin2.H5B00 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/sync/" target="mainFrame" title="<cfoutput>#menutitle[124]#</cfoutput>">
                        <cfoutput>#menutitle[124]#</cfoutput>
                    </a>
                </li>
            </cfif>
            <cfif getpin2.H5C00 eq "T">
                 <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/admin/MonthlyBackup.cfm" target="mainFrame" title="<cfoutput>#menutitle[125]#</cfoutput>">
                        <cfoutput>#menutitle[125]#</cfoutput>
                    </a>
                </li>
            </cfif>
    </span>
    </cfif>
</cfif>
<cfinclude template="/menunew2/chat.cfm">
<a class="oe_secondary_submenu_item" href="https://www.teamviewer.com/link/?url=505374&id=625664214" style="text-decoration:none; text-align:left">
    <img src="https://www.teamviewer.com/link/?url=979936&id=625664214" alt="TeamViewer for Remote Support" title="TeamViewer for Remote Support" border="0" width="130" height="50">
</a>

<a class="oe_secondary_submenu_item" href="https://showmypc.com/ShowMyPC3150.exe" style="text-decoration:none; text-align:left">
	<img src="https://showmypc.com/images/home/remote-support-logo2521.jpg" alt="ShowMyPc for Remote Support" title="Show My Pc for Remote Support" border="0" width="130" height="50">
</a>
</div>
</div>
</div>
</cfoutput>
</body>
</html>