<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Testing</title>
<link rel="stylesheet" type="text/css" href="/newinterface2/css1.css" />
<script language="javascript" type="text/javascript" src="/scripts/change_left_menunew.js"></script>

</head>

<body class="netiquette">
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
<cfelseif getGeneralInfo.dflanguage eq 'Indonesian'>
<cfset menutitle['#getlanguage.no#']=getlanguage.Indonesian>
</cfif>
</cfloop>


<cfoutput>
<div style="overflow:hidden;">
<div class="secondary_menu">
<div id="masterdiv">


<cfif getpin2.h3000 eq "T">
	
   
    
    
    
	<cfif getpin2.h3500 eq "T" or getpin2.h351A eq "T" or getpin2.h351B eq "T" or getpin2.h352A eq "T" or getpin2.h352B eq "T" or getpin2.h352C eq "T" or  getpin2.h353A eq "T" or getpin2.h353B eq "T" >
    <li onClick="SwitchMenu('sub2')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[80]#</cfoutput>"><cfoutput>#menutitle[80]#</cfoutput></a></li>
<span id="sub2" style="display:none;" class="submenu">

		

		<cfif getpin2.h351A eq "T" or  getpin2.h351B eq "T">
        <li onClick="SwitchMenu2('sub3')"><a class="oe_secondary_menu_item2" style="cursor:pointer" title="<cfoutput>#menutitle[180]#</cfoutput>"><cfoutput>#menutitle[180]#</cfoutput></a></li>
                <span id="sub3" style="display:none;" class="submenu2">
        <cfif getpin2.h351A eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/historypriceenquiry/historypriceform.cfm?history=customeritemlastprice" target="mainFrame" title="<cfoutput>#menutitle[181]#</cfoutput>">
				<cfoutput>#menutitle[181]#</cfoutput>
			</a>
		</li>
        </cfif>
        <cfif getpin2.h351B eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/historypriceenquiry/historypriceform.cfm?history=customeritemtransactedprice" target="mainFrame" title="<cfoutput>#menutitle[182]#</cfoutput>">
				<cfoutput>#menutitle[182]#</cfoutput>
			</a>
		</li>
        </cfif>
        </span>
        </cfif>
        <cfif getpin2.h352A eq "T" or getpin2.h352B eq "T" or getpin2.h352C eq "T">
        <li onClick="SwitchMenu2('sub4')"><a class="oe_secondary_menu_item2" style="cursor:pointer" title="<cfoutput>#menutitle[183]#</cfoutput>"><cfoutput>#menutitle[183]#</cfoutput></a></li>
                <span id="sub4" style="display:none;" class="submenu2">
        <cfif getpin2.h352A eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/historypriceenquiry/historypriceform.cfm?history=itemcustomertransactedprice" target="mainFrame" title="<cfoutput>#menutitle[184]#</cfoutput>">
				<cfoutput>#menutitle[184]#</cfoutput>
			</a>
		</li>
        </cfif>
        <cfif getpin2.h352B eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/historypriceenquiry/historypriceform.cfm?history=itemsupplierlastprice" target="mainFrame" title="<cfoutput>#menutitle[185]#</cfoutput>">
				<cfoutput>#menutitle[185]#</cfoutput>
			</a>
		</li>
        </cfif>
        <cfif getpin2.h352C eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/historypriceenquiry/historypriceform.cfm?history=itemsuppliertransactedprice" target="mainFrame" title="<cfoutput>#menutitle[186]#</cfoutput>">
				<cfoutput>#menutitle[186]#</cfoutput>
			</a>
		</li>
        </cfif>
        </span>
        </cfif>
         <cfif getpin2.h353A eq "T">
        <li onClick="SwitchMenu2('sub5')"><a class="oe_secondary_menu_item2" style="cursor:pointer" title="<cfoutput>#menutitle[187]#</cfoutput>"><cfoutput>#menutitle[187]#</cfoutput></a></li>
                <span id="sub5" style="display:none;" class="submenu2">
                <cfif getpin2.h353A eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/enquires/historypriceenquiry/historypriceform.cfm?history=supplieritemtransactedprice" target="mainFrame" title="<cfoutput>#menutitle[182]#</cfoutput>">
                        <cfoutput>#menutitle[182]#</cfoutput>
                    </a>
                </li>
                </cfif>
                </span>
                </cfif>
        <cfif getpin2.h353B eq "T">
        <li onClick="SwitchMenu2('sub6')"><a class="oe_secondary_menu_item2" style="cursor:pointer" title="<cfoutput>#menutitle[411]#</cfoutput>"><cfoutput>#menutitle[411]#</cfoutput></a></li>
        <span id="sub6" style="display:none;" class="submenu2">
        <cfif getpin2.h353B eq "T">
        <li>
            <a class="oe_secondary_submenu_item" href="/#HDir#/enquires/historypriceenquiry/historypriceform.cfm?history=adjustedtransactioncost" target="mainFrame" title="<cfoutput>#menutitle[188]#</cfoutput>">
                <cfoutput>#menutitle[188]#</cfoutput>
            </a>
        </li>
        </cfif>
        </span>
        </cfif>
        
        
    </span>
	</cfif>
	
	<cfif getpin2.h3200 eq "T" or getpin2.h3210 eq "T" or  getpin2.h3220 eq "T" or getpin2.h3230 eq "T" or  getpin2.h3240 eq "T" or  getpin2.h3250 eq "T" or getpin2.h3260 eq "T" or  getpin2.h3270 eq "T" or  getpin2.h32E0 eq "T" or getpin2.h3920 eq "T">
        <li onClick="SwitchMenu('sub7')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[189]#</cfoutput>"><cfoutput>#menutitle[189]#</cfoutput></a></li>
    <span id="sub7" style="display:none;" class="submenu">
    
    	<cfif getpin2.h3920 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/inforecast.cfm?type=Inventory" target="mainFrame" title="<cfoutput>#menutitle[81]#</cfoutput>">
				<cfoutput>#menutitle[81]#</cfoutput>
			</a>
		</li>
	</cfif>
    	<cfif getpin2.h3210 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/outreport.cfm?type=DO" target="mainFrame" title="<cfoutput>#menutitle[66]#</cfoutput>">
				<cfoutput>#menutitle[66]#</cfoutput>
			</a>
		</li>
        </cfif>
        <cfif lcase(hcomid) neq "excelsnm_i">
        <cfif getpin2.h3220 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/outreport.cfm?type=QUO" target="mainFrame" title="<cfoutput>#menutitle[70]#</cfoutput>">
				<cfoutput>#menutitle[70]#</cfoutput>
			</a>
		</li>
        </cfif>
        </cfif>
        <cfif getpin2.h3230 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/outreport.cfm?type=3" target="mainFrame" title="<cfoutput>#menutitle[68]#</cfoutput>">
				<cfoutput>#menutitle[68]#</cfoutput>
			</a>
		</li>
        </cfif>
        <cfif getpin2.h3240 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/outreport.cfm?type=4" target="mainFrame" title="<cfoutput>#menutitle[427]#</cfoutput>Details">
				<cfoutput>#menutitle[427]#</cfoutput>
			</a>
		</li>
        </cfif>
        <cfif getpin2.h3250 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/outreport.cfm?type=5" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lSO#
                    <cfelse>
                    <cfoutput>#menutitle[156]#</cfoutput>
                    </cfif>">
            <cfif getgeneralinfo.dflanguage eq 'english'>
            #getGeneralInfo.lSO#
            <cfelse>
				<cfoutput>#menutitle[156]#</cfoutput>
                </cfif>
			</a>
		</li>
        </cfif>
        <cfif getpin2.h3260 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/outreport.cfm?type=6" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lSO#
                    <cfelse>
                    <cfoutput>#menutitle[190]#</cfoutput>
                    </cfif>">
            <cfif getgeneralinfo.dflanguage eq 'english'>
            #getGeneralInfo.lSO# Detail
            <cfelse>
				<cfoutput>#menutitle[190]#</cfoutput>
                </cfif>
			</a>
		</li>
        </cfif>
        <cfif getpin2.h3270 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/outreport.cfm?type=7" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lSO#
                    <cfelse>
                    <cfoutput>#menutitle[191]#</cfoutput>
                    </cfif>">
            <cfif getgeneralinfo.dflanguage eq 'english'>
           #getGeneralInfo.lSO# to Purchase Order
            <cfelse>
				<cfoutput>#menutitle[191]#</cfoutput>
                </cfif>
			</a>
		</li>
        </cfif>
        <cfif getpin2.h32E0 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/outreport.cfm?type=8" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lSO#
                    <cfelse>
                    <cfoutput>#menutitle[192]#</cfoutput>
                    </cfif>">
            <cfif getgeneralinfo.dflanguage eq 'english'>
            #getGeneralInfo.lSO# to Purchae Order Material
            <cfelse>
				<cfoutput>#menutitle[192]#</cfoutput>
                </cfif>
			</a>
		</li>
        </cfif>    
    </span>
	</cfif>

	<cfif getpin2.h3200 eq "T" or getpin2.h32E0 eq "T" or getpin2.h32A0 eq "T" or getpin2.h32B0 eq "T" or getpin2.h32C0 eq "T" or getpin2.h32D0 eq "T">
        <li onClick="SwitchMenu('sub8')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[193]#</cfoutput>"><cfoutput>#menutitle[193]#</cfoutput></a></li>
    <span id="sub8" style="display:none;" class="submenu">
    	<cfif getpin2.h3290 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/updatedbill_form.cfm?frtype=SO&totype=INV" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lSO#
                    <cfelse>
                    <cfoutput>#menutitle[194]#</cfoutput>
                    </cfif>">
				 <cfif getgeneralinfo.dflanguage eq 'english'>
            #getGeneralInfo.lSO# to Invoice
            <cfelse>
				<cfoutput>#menutitle[194]#</cfoutput>
                </cfif>
			</a>
		</li>
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/updatedbill_form.cfm?frtype=SO&totype=CS" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lSO#
                    <cfelse>
                    <cfoutput>#menutitle[194]#</cfoutput>
                    </cfif>">
				 <cfif getgeneralinfo.dflanguage eq 'english'>
            #getGeneralInfo.lSO# to Cash Sales
            <cfelse>
				<cfoutput>#menutitle[194]#</cfoutput>
                </cfif>
			</a>
		</li>
        </cfif>
        <cfif getpin2.h32A0 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/updatedbill_form.cfm?frtype=SO&totype=PO" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lSO#
                    <cfelse>
                    <cfoutput>#menutitle[194]#</cfoutput>
                    </cfif>">
				<cfif getgeneralinfo.dflanguage eq 'english'>
            #getGeneralInfo.lSO# to Purchase Order
            <cfelse>
				<cfoutput>#menutitle[194]#</cfoutput>
                </cfif>
			</a>
		</li>
        </cfif>
        <cfif lcase(hcomid) neq "excelsnm_i">
        <cfif getpin2.h32B0 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/updatedbill_form.cfm?frtype=QUO&totype=" target="mainFrame" title="<cfoutput>#menutitle[70]#</cfoutput>">
				<cfoutput>#menutitle[70]#</cfoutput>
			</a>
		</li>
        </cfif>
        </cfif>
        <cfif getpin2.h32C0 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/updatedbill_form.cfm?frtype=PO&totype=RC" target="mainFrame" title="<cfoutput>#menutitle[196]#</cfoutput>">
				<cfoutput>#menutitle[196]#</cfoutput>
			</a>
		</li>
        </cfif>
        <cfif getpin2.h32D0 eq "T">
         <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/updatedbill_form.cfm?frtype=DO&totype=INV" target="mainFrame" title="<cfoutput>#menutitle[197]#</cfoutput>">
				<cfoutput>#menutitle[197]#</cfoutput>
			</a>
		</li>
        </cfif>
        
        
    </span>
    </cfif>

    
    
	<cfif getpin2.h3100 eq "T" or getpin2.h3120 eq "T" or getpin2.h3130 eq "T">
    	<li onClick="SwitchMenu('sub9')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[83]#</cfoutput>"><cfoutput>#menutitle[83]#</cfoutput></a></li>
<span id="sub9" style="display:none;" class="submenu">
		<cfif husergrpid eq "admin" or husergrpid eq "super">
		<cfif getpin2.h3910 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/billsummary.cfm" target="mainFrame" title="<cfoutput>#menutitle[79]#</cfoutput>">
				<cfoutput>#menutitle[79]#</cfoutput>
			</a>
		</li>
        </cfif>
	</cfif>
		
		<cfif getpin2.h3110 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/item_enquires.cfm" target="mainFrame" title="<cfoutput>#menutitle[198]#</cfoutput>">
				<cfoutput>#menutitle[198]#</cfoutput>
			</a>
		</li>
        </cfif>
        <cfif getpin2.h3120 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/relitembalance.cfm" target="mainFrame" title="<cfoutput>#menutitle[199]#</cfoutput>">
				<cfoutput>#menutitle[199]#</cfoutput>
			</a>
		</li>
        </cfif>
        <cfif getpin2.h3130 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/locationitem_enquires.cfm" target="mainFrame" title="<cfoutput>#menutitle[200]#</cfoutput>">
				<cfoutput>#menutitle[200]#</cfoutput>
			</a>
		</li>
        </cfif>
    </span>
	</cfif>
    
    
    <cfif getpin2.h3600 eq "T" or getpin2.h3610 eq "T" or getpin2.h3620 eq "T">
		<li onClick="SwitchMenu('sub10')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[84]#</cfoutput>"><cfoutput>#menutitle[84]#</cfoutput></a></li>
<span id="sub10" style="display:none;" class="submenu">
        <cfif getpin2.h3610 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/traceitem_costvalue_form.cfm?type=FIFO" target="mainFrame" title="<cfoutput>#menutitle[201]#</cfoutput>">
				<cfoutput>#menutitle[201]#</cfoutput>
			</a>
		</li>
        </cfif>
        <cfif getpin2.h3620 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/stockcosting.cfm" target="mainFrame" title="<cfoutput>#menutitle[202]#</cfoutput>">
				<cfoutput>#menutitle[202]#</cfoutput>
			</a>
		</li>
        </cfif>
        
    </span>
    </cfif>
    <cfif getpin2.h3700 eq "T" or getpin2.h3710 eq "T" or getpin2.h3720 eq "T" or getpin2.h3730 eq "T">
    	<li onClick="SwitchMenu('sub11')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[86]#</cfoutput>"><cfoutput>#menutitle[86]#</cfoutput></a></li>
<span id="sub11" style="display:none;" class="submenu">
    
		<cfif getpin2.h3710 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/report-exception/nolocationreport.cfm" target="mainFrame" title="<cfoutput>#menutitle[203]#</cfoutput>">
			<cfoutput>#menutitle[203]#</cfoutput>
            </a>
		</li>
        </cfif>
        <cfif getpin2.h3720 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/report-exception/noagentreport.cfm" target="mainFrame" title="<cfoutput>#menutitle[204]#</cfoutput>">
			<cfoutput>#menutitle[204]#</cfoutput>
            </a>
		</li>
         <cfif getmodule.job eq '1'>
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/report-exception/nojobreport.cfm" target="mainFrame" title="<cfoutput>No Job Report</cfoutput>">
			<cfoutput>No Job Report</cfoutput>
            </a>
		</li>
        </cfif>
        <cfif getmodule.project eq '1'>
         <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/report-exception/noprojectreport.cfm" target="mainFrame" title="<cfoutput>No Project Report</cfoutput>">
			<cfoutput>No Project Report</cfoutput>
            </a>
		</li>
        </cfif>
        </cfif>
        <cfif getpin2.h3730 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/report-exception/nobatchcodereport.cfm" target="mainFrame" title="<cfoutput>#menutitle[205]#</cfoutput>">
			<cfoutput>#menutitle[205]#</cfoutput>
            </a>
		</li>
        </cfif>
         <cfif getpin2.h3740 eq "T">
         <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/report-exception/itemnosymbol.cfm" target="mainFrame" title="<cfoutput>Item No Symbol</cfoutput>">
			<cfoutput>Item No Symbol</cfoutput>
            </a>
		</li>
        
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/report-exception/imspostedbillcheck.cfm" target="_blank" title="<cfoutput>IMS Posted Bills</cfoutput>">
			<cfoutput>Posted IMS Bill Not in AMS</cfoutput>
            </a>
		</li>
        </cfif>
	</span>
    </cfif>
    
     <cfif getpin2.h3800 eq "T" or getpin2.h3810 eq "T" or getpin2.h3820 eq "T" or getpin2.h3830 eq "T" or getpin2.h3840 eq "T">
		<li onClick="SwitchMenu('sub12')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[87]#</cfoutput>"><cfoutput>#menutitle[87]#</cfoutput></a></li>
<span id="sub12" style="display:none;" class="submenu">
        <cfif getpin2.h3810 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/noacceptreport1.cfm" target="mainFrame" title="<cfoutput>#menutitle[206]#</cfoutput>">
				<cfoutput>#menutitle[206]#</cfoutput>
            </a>
		</li>
        </cfif>
        <cfif getpin2.h3820 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/norecoverbill1.cfm" target="mainFrame" title="<cfoutput>#menutitle[414]#</cfoutput>">
				<cfoutput>#menutitle[414]#</cfoutput>
            </a>
		</li>
        </cfif>
        <cfif getpin2.h3830 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/norecoverbill2.cfm" target="mainFrame" title="<cfoutput>#menutitle[415]#</cfoutput>">
				<cfoutput>#menutitle[415]#</cfoutput>
            </a>
		</li>
        </cfif>
        <cfif getpin2.h3840 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/norecoverbill3.cfm" target="mainFrame" title="<cfoutput>#menutitle[416]#</cfoutput>">
				<cfoutput>#menutitle[416]#</cfoutput>
            </a>
		</li>
        </cfif>
        
	</span>
    </cfif>

	<cfif husergrpid eq "admin" or husergrpid eq "super">
    <cfif getpin2.h3A00 eq "T">
    <li onClick="SwitchMenu('sub13')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[411]#</cfoutput>"><cfoutput>#menutitle[411]#</cfoutput></a></li>
<span id="sub13" style="display:none;" class="submenu">
    <cfif husergrpid eq "admin" or husergrpid eq "super">
		    <cfif getpin2.h3A10 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/enquires/refno2check.cfm" target="mainFrame" title="<cfoutput>#menutitle[85]#</cfoutput>">
				<cfoutput>#menutitle[85]#</cfoutput>
			</a>
		</li>
        </cfif>
	</cfif>
    </span>
    </cfif>
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
