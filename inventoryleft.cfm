<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Menu</title>
<link rel="stylesheet" type="text/css" href="/newinterface2/css1.css" />
<script language="javascript" type="text/javascript" src="/scripts/change_left_menunew.js"></script>
<script type="text/javascript" src="/scripts/prototypenew.js" ></script>
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
// -->
</script>
</head>
<cfquery name="getgeneral" datasource="#dts#">
	select * from gsetup
</cfquery>
<cfquery name="getlanguage" datasource="#dts#">
select * from main.menulang
</cfquery>
<cfquery name="getGeneralInfo" datasource="#dts#">
	select * 
	from gsetup;
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
	select * 
	from modulecontrol;
</cfquery>
<cfset menutitle=StructNew()>
<cfloop query="getlanguage">
<cfif getGeneralInfo.dflanguage eq 'english'>
<cfset menutitle['#getlanguage.no#']=getlanguage.eng>
<cfelseif getGeneralInfo.dflanguage eq 'sim_ch'>
<cfset menutitle['#getlanguage.no#']=getlanguage.sim_ch>
<cfelseif getGeneralInfo.dflanguage eq 'tra_ch'>
<cfset menutitle['#getlanguage.no#']=getlanguage.tra_ch>
</cfif>
</cfloop>
<cfoutput>

<body class="netiquette">
<div style="overflow:hidden;">
<div class="secondary_menu">
<div id="masterdiv">
<li onClick="SwitchMenu('sub1')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="Warehouse"><cfoutput>Warehouse</cfoutput></a></li>
<span class="submenu" id="sub1" style="display:block">
  
    	<cfif getpin2.h28A0 eq 'T'>
        <li>
				<a class="oe_secondary_submenu_item" href="/default/transaction/siss.cfm?tran=TR" target="mainFrame">
					<cfoutput>Transfer</cfoutput>
                </a></li>
			
		</cfif>
        <cfif getpin2.h28E0 eq 'T'>
        <li>
				<a class="oe_secondary_submenu_item" href="/default/transaction/siss.cfm?tran=TR&consignment=out" target="mainFrame">
					<cfoutput>#getgeneral.lconsignout#</cfoutput>
                </a></li>
            </cfif>
 	
    <cfif getpin2.h28F0 eq 'T'>
    	<li>
				<a class="oe_secondary_submenu_item" href="/default/transaction/siss.cfm?tran=TR&consignment=return" target="mainFrame">
					<cfoutput>#getgeneral.lconsignin#</cfoutput>
                </a></li>
        </cfif>
        <cfif getpin2.h2300 eq "T">
        <li>
				<a class="oe_secondary_submenu_item" href="/default/transaction/transaction.cfm?tran=do" target="mainFrame">
					<cfoutput>#getgeneral.lDO#</cfoutput>
                </a></li>

        </cfif>
        
        <cfif getpin2.h2820 eq 'T'>
        <li>
				<a class="oe_secondary_submenu_item" href="/default/transaction/siss.cfm?tran=ISS" target="mainFrame">
					<cfoutput>#getgeneral.lISS#</cfoutput>
                </a></li>

        </cfif>
        
        <cfif getpin2.h2830 eq 'T'>
        <li>
				<a class="oe_secondary_submenu_item" href="/default/transaction/siss.cfm?tran=OAI" target="mainFrame">
					<cfoutput>#getgeneral.lOAI#</cfoutput>
                </a></li>

        </cfif>
        
        <cfif getpin2.h2840 eq 'T'>
        <li>
				<a class="oe_secondary_submenu_item" href="/default/transaction/siss.cfm?tran=OAR" target="mainFrame">
					<cfoutput>#getgeneral.lOAR#</cfoutput>
                </a></li>

        </cfif>
        
        <cfif getpin2.h2830 eq 'T'>
        <li>
				<a class="oe_secondary_submenu_item" href="/default/transaction/expressadjustmenttran/index.cfm" target="mainFrame">
					<cfoutput>Express Adjustment</cfoutput>
                </a></li>

        </cfif>
</span>
<li onClick="SwitchMenu('sub2')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="Inventory Report"><cfoutput>Inventory Report</cfoutput></a></li>
<span class="submenu" id="sub2">
   <cfif getpin2.h4210 eq "T">
			<cftry>
				<cfquery name="getrecord" datasource="#dts#">
					SELECT lastaccdate FROM icitem_last_year limit 1
				</cfquery>
                <li>
				<a class="oe_secondary_submenu_item" href="/default/report-stock/stockcard0.cfm?type=1" target="mainFrame">
					<cfoutput>Stock Card</cfoutput>
                </a></li>
				
			<cfcatch type="any">
            <li>
				<a class="oe_secondary_submenu_item" href="/default/report-stock/stockcard.cfm?type=1" target="mainFrame">
					<cfoutput>Stock Card</cfoutput>
                </a></li>
				
			</cfcatch>
			</cftry>
			<!--- <cfif hcomid eq "idi_i" or hcomid eq "demo_i" or hcomid eq "saehan_i" or hcomid eq "ge_i" or hcomid eq "redd_i" or lcase(hcomid) eq "mhsl_i">
				<li><a href="../report-stock/stockcard0.cfm?type=1" target="mainFrame">Stock Card</a></li>
			<cfelse>
				<li><a href="../report-stock/stockcard.cfm?type=1" target="mainFrame">Stock Card</a></li>
			</cfif> --->
		</cfif>
        
    	<cfif getpin2.h4220 eq "T">
        <li>
				<a class="oe_secondary_submenu_item" href="/default/report-stock/reorderadvise.cfm?type=2" target="mainFrame">
					<cfoutput>Reorder Advice</cfoutput>
                </a></li>
			
		</cfif>
        <cfif getpin2.h4260 eq "T">
        <li>
				<a class="oe_secondary_submenu_item" href="/default/report-stock/stockaging.cfm" target="mainFrame">
					<cfoutput>Stock Aging</cfoutput>
                </a></li>
            </cfif>
 	
    <cfif getpin2.h4270 eq "T">
    	<li>
				<a class="oe_secondary_submenu_item" href="/default/report-stock/physical_worksheet_menu.cfm" target="mainFrame">
					<cfoutput>Physical Worksheet</cfoutput>
                </a></li>
        </cfif>
        <cfif getpin2.h4280 eq "T">
        <li>
				<a class="oe_secondary_submenu_item" href="/default/report-stock/transsummary.cfm?type=Quantity" target="mainFrame">
					<cfoutput>Summary By Quantity</cfoutput>
                </a></li>

        </cfif>
        <cfif getpin2.h4290 eq "T">
        <li>
				<a class="oe_secondary_submenu_item" href="/default/report-stock/transsummary.cfm?type=Value" target="mainFrame">
					<cfoutput>Summary By Value</cfoutput>
                </a></li> 
		</cfif>
         <cfif getpin2.h4210 eq "T">
         <li>
				<a class="oe_secondary_submenu_item" href="/default/report-stock/dailystockcard.cfm" target="mainFrame">
					<cfoutput>Daily stock card</cfoutput>
                </a></li>
		</cfif>
    
    <!---<cfif getpin2.h4270 eq "T">
		<li><a href="../report-stock/expressadjustment/" target="_blank">Express Quantity Adjustment</a></li>
        </cfif>--->
    
    
    <cfif getpin2.h4210 eq "T">
    <li>
				<a class="oe_secondary_submenu_item" href="/report-stock/itemstockcard1.cfm" target="mainFrame">
					<cfoutput>Items Stock Check</cfoutput>
                </a></li>
		
        </cfif>
    
</span>
</div>	
</div>
</div>
</body>
</cfoutput>
</html>