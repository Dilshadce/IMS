<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Testing</title>
<link rel="stylesheet" type="text/css" href="/newinterface/css1.css" />
<script language="javascript" type="text/javascript" src="/scripts/change_left_menunew.js"></script>

</head>

<body class="openerp">
<cfquery name="getGeneralInfo" datasource="#dts#">
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
<cfif getGeneralInfo.dflanguage eq 'english'>
<cfset menutitle['#getlanguage.no#']=getlanguage.eng>
<cfelseif getGeneralInfo.dflanguage eq 'sim_ch'>
<cfset menutitle['#getlanguage.no#']=getlanguage.sim_ch>
<cfelseif getGeneralInfo.dflanguage eq 'tra_ch'>
<cfset menutitle['#getlanguage.no#']=getlanguage.tra_ch>
</cfif>
</cfloop>


<cfoutput>
<div style="overflow:hidden;">
<div class="secondary_menu">
<div id="masterdiv">


<cfif getpin2.h3000 eq "T">
	
    <cfif husergrpid eq "admin" or husergrpid eq "super" or getpin2.h3400 eq "T">
    <li onClick="SwitchMenu('sub1')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[148]#</cfoutput></a></li>
<span id="sub1" style="display:none;" class="submenu">


	<cfif husergrpid eq "admin" or husergrpid eq "super">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/billsummary.cfm" target="mainFrame">
				<cfoutput>#menutitle[79]#</cfoutput>
			</a>
		</li>
	</cfif>
    
    <cfif getpin2.h3400 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/inforecast.cfm?type=Inventory" target="mainFrame">
				<cfoutput>#menutitle[81]#</cfoutput>
			</a>
		</li>
	</cfif>
    
    </span>
    </cfif>
    
    
    
	<cfif getpin2.h3500 eq "T">
    <li onClick="SwitchMenu('sub2')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[80]#</cfoutput></a></li>
<span id="sub2" style="display:none;" class="submenu">

		<li onClick="SwitchMenu2('sub3')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[180]#</cfoutput></a></li>
                <span id="sub3" style="display:none;" class="submenu2">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/historypriceenquiry/historypriceform.cfm?history=customeritemlastpric" target="mainFrame">
				<cfoutput>#menutitle[181]#</cfoutput>
			</a>
		</li>
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/historypriceenquiry/historypriceform.cfm?history=customeritemtransactedprice" target="mainFrame">
				<cfoutput>#menutitle[182]#</cfoutput>
			</a>
		</li>
        </span>
        
        <li onClick="SwitchMenu2('sub4')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[183]#</cfoutput></a></li>
                <span id="sub4" style="display:none;" class="submenu2">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/historypriceenquiry/historypriceform.cfm?history=itemcustomertransactedprice" target="mainFrame">
				<cfoutput>#menutitle[184]#</cfoutput>
			</a>
		</li>
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/historypriceenquiry/historypriceform.cfm?history=itemsupplierlastprice" target="mainFrame">
				<cfoutput>#menutitle[185]#</cfoutput>
			</a>
		</li>
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/historypriceenquiry/historypriceform.cfm?history=itemsuppliertransactedprice" target="mainFrame">
				<cfoutput>#menutitle[186]#</cfoutput>
			</a>
		</li>
        </span>
        
        <li onClick="SwitchMenu2('sub5')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[187]#</cfoutput></a></li>
                <span id="sub5" style="display:none;" class="submenu2">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/enquires/historypriceenquiry/historypriceform.cfm?history=supplieritemtransactedprice" target="mainFrame">
                        <cfoutput>#menutitle[182]#</cfoutput>
                    </a>
                </li>
                </span>
        
        <li onClick="SwitchMenu2('sub6')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[175]#</cfoutput></a></li>
        <span id="sub6" style="display:none;" class="submenu2">
        <li>
            <a class="oe_secondary_submenu_item" href="/#HDir#/enquires/historypriceenquiry/historypriceform.cfm?history=adjustedtransactioncost" target="mainFrame">
                <cfoutput>#menutitle[188]#</cfoutput>
            </a>
        </li>
        </span>
        
        
    </span>
	</cfif>
	
	<cfif getpin2.h3200 eq "T">
        <li onClick="SwitchMenu('sub7')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[189]#</cfoutput></a></li>
    <span id="sub7" style="display:none;" class="submenu">
    	<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/outreport.cfm?type=DO" target="mainFrame">
				<cfoutput>#menutitle[66]#</cfoutput>
			</a>
		</li>
        
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/outreport.cfm?type=QUO" target="mainFrame">
				<cfoutput>#menutitle[70]#</cfoutput>
			</a>
		</li>
        
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/outreport.cfm?type=3" target="mainFrame">
				<cfoutput>#menutitle[68]#</cfoutput>
			</a>
		</li>
        
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/outreport.cfm?type=4" target="mainFrame">
				<cfoutput>#menutitle[68]#</cfoutput> Details
			</a>
		</li>
        
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/outreport.cfm?type=5" target="mainFrame">
				<cfoutput>#menutitle[156]#</cfoutput>
			</a>
		</li>
        
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/outreport.cfm?type=6" target="mainFrame">
				<cfoutput>#menutitle[190]#</cfoutput>
			</a>
		</li>
        
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/outreport.cfm?type=7" target="mainFrame">
				<cfoutput>#menutitle[191]#</cfoutput>
			</a>
		</li>
        
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/outreport.cfm?type=8" target="mainFrame">
				<cfoutput>#menutitle[192]#</cfoutput>
			</a>
		</li>    
    </span>
	</cfif>

	<cfif getpin2.h3200 eq "T">
        <li onClick="SwitchMenu('sub8')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[193]#</cfoutput></a></li>
    <span id="sub8" style="display:none;" class="submenu">
    	<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/updatedbill_form.cfm?frtype=SO&totype=INV" target="mainFrame">
				<cfoutput>#menutitle[194]#</cfoutput>
			</a>
		</li>
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/updatedbill_form.cfm?frtype=SO&totype=PO" target="mainFrame">
				<cfoutput>#menutitle[195]#</cfoutput>
			</a>
		</li>
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/updatedbill_form.cfm?frtype=QUO&totype=" target="mainFrame">
				<cfoutput>#menutitle[70]#</cfoutput>
			</a>
		</li>
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/updatedbill_form.cfm?frtype=PO&totype=RC" target="mainFrame">
				<cfoutput>#menutitle[196]#</cfoutput>
			</a>
		</li>
         <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/updatedbill_form.cfm?frtype=DO&totype=INV" target="mainFrame">
				<cfoutput>#menutitle[197]#</cfoutput>
			</a>
		</li>
        
        
    </span>
    </cfif>

    
    
	<cfif getpin2.h3100 eq "T">
    	<li onClick="SwitchMenu('sub9')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[83]#</cfoutput></a></li>
<span id="sub9" style="display:none;" class="submenu">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/item_enquires.cfm" target="mainFrame">
				<cfoutput>#menutitle[198]#</cfoutput>
			</a>
		</li>
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/relitembalance.cfm" target="mainFrame">
				<cfoutput>#menutitle[199]#</cfoutput>
			</a>
		</li>
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/locationitem_enquires.cfm" target="mainFrame">
				<cfoutput>#menutitle[200]#</cfoutput>
			</a>
		</li>
    </span>
	</cfif>
    
    
	<cfif husergrpid eq "admin" or husergrpid eq "super">
		<li onClick="SwitchMenu('sub10')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[84]#</cfoutput></a></li>
<span id="sub10" style="display:none;" class="submenu">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/traceitem_costvalue_form.cfm?type=FIFO" target="mainFrame">
				<cfoutput>#menutitle[201]#</cfoutput>
			</a>
		</li>
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/stockcosting.cfm" target="mainFrame">
				<cfoutput>#menutitle[202]#</cfoutput>
			</a>
		</li>
        
    </span>
	</cfif>
    <cfif getpin2.h3100 eq "T">
    	<li onClick="SwitchMenu('sub11')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[86]#</cfoutput></a></li>
<span id="sub11" style="display:none;" class="submenu">
    
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/report-exception/nolocationreport.cfm" target="mainFrame">
			<cfoutput>#menutitle[203]#</cfoutput>
            </a>
		</li>
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/report-exception/noagentreport.cfm" target="mainFrame">
			<cfoutput>#menutitle[204]#</cfoutput>
            </a>
		</li>
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/report-exception/nobatchcodereport.cfm" target="mainFrame">
			<cfoutput>#menutitle[205]#</cfoutput>
            </a>
		</li>
        
	</span>
    </cfif>
    
     <cfif getpin2.h3100 eq "T">
		<li onClick="SwitchMenu('sub12')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[87]#</cfoutput></a></li>
<span id="sub12" style="display:none;" class="submenu">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/noacceptreport1.cfm" target="mainFrame">
				<cfoutput>#menutitle[206]#</cfoutput>
            </a>
		</li>
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/noacceptreport2.cfm" target="mainFrame">
				<cfoutput>#menutitle[207]#</cfoutput>
            </a>
		</li>
	</span>
    </cfif>
    <cfif husergrpid eq "admin" or husergrpid eq "super">
    <li onClick="SwitchMenu('sub13')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[175]#</cfoutput></a></li>
<span id="sub13" style="display:none;" class="submenu">
    <cfif husergrpid eq "admin" or husergrpid eq "super">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/refno2check.cfm" target="mainFrame">
				<cfoutput>#menutitle[85]#</cfoutput>
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
