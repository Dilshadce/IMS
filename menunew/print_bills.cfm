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
<cfif getpin2.h6000 eq "T">
        <cfif getpin2.h6700 eq "T" or getpin2.h6600 eq "T" or getpin2.h6500 eq "T" or getpin2.h6400 eq "T" or getpin2.h6300 eq "T" or getpin2.h6200 eq "T" or getpin2.h6100 eq "T">
        <li onClick="SwitchMenu('sub18')"><a class="oe_secondary_menu_item" style="cursor:pointer">
        <cfoutput>#menutitle[148]#</cfoutput></a></li>
<span id="sub18" style="display:none;" class="submenu">
			<cfif getpin2.h6100 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=INV&name=Invoice&BilType=" target="mainFrame">
                        <cfoutput>#menutitle[60]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.h6200 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=CS&name=Cash Bills&BilType=" target="mainFrame">
                        <cfoutput>#menutitle[61]#</cfoutput>
                    </a>
                </li>
                </cfif>
                
                <cfif getpin2.h6300 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=CN&name=Credit Note&BilType=" target="mainFrame">
                        <cfoutput>#menutitle[62]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.h6400 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=DN&name=Debit Note&BilType=" target="mainFrame">
                        <cfoutput>#menutitle[63]#</cfoutput>
                    </a>
                </li>
                </cfif>
                
                <cfif getpin2.h6500 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=RC&name=Receive&BilType=" target="mainFrame">
                        <cfoutput>#menutitle[64]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.h6600 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=PR&name=Purchase Return&BilType=" target="mainFrame">
                        <cfoutput>#menutitle[65]#</cfoutput>
                    </a>
                </li>
                </cfif>
                
                <cfif getpin2.h6700 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=DO&name=Delivery Order&BilType=DO" target="mainFrame">
                        <cfoutput>#menutitle[66]#</cfoutput>
                    </a>
                </li>
                </cfif>
    </span>
    </cfif>
    
    <cfif getpin2.h6C00 eq "T" or getpin2.h6D00 eq "T" or getpin2.h6E00 eq "T">
    <li onClick="SwitchMenu('sub2')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[49]#</cfoutput></a></li>
                <span id="sub2" style="display:none;" class="submenu">
    
    <cfif getpin2.h6C00 eq "T">
	<li>
		<a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=ISS&name=Issue&BilType=" target="mainFrame">
			<cfoutput>#menutitle[71]#</cfoutput>
		</a>
	</li>
    </cfif>
    <cfif getpin2.h6D00 eq "T">
	<li>
		<a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=OAI&name=Adjustment Increase&BilType=" target="mainFrame">
			<cfoutput>#menutitle[72]#</cfoutput>
		</a>
	</li>
    </cfif>
    <cfif getpin2.h6E00 eq "T">
	<li>
		<a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=OAR&name=Adjustment Reduce&BilType=" target="mainFrame">
			<cfoutput>#menutitle[73]#</cfoutput>
		</a>
	</li>
    </cfif>
    </span>
    </cfif>
    
    
    
    <cfif getpin2.h6900 eq "T" or getpin2.h6A00 eq "T" or getpin2.h6B00 eq "T">
    <li onClick="SwitchMenu('sub3')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[155]#</cfoutput></a></li>
                <span id="sub3" style="display:none;" class="submenu">
    

    <cfif getpin2.h6900 eq "T">
	<li>
		<a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=PO&name=Purchase Order&BilType=" target="mainFrame">
			<cfoutput>#menutitle[68]#</cfoutput>
		</a>
	</li>
    </cfif>
    <cfif getpin2.h6A00 eq "T">
	<li>
		<a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=SO&name=Sales Order&BilType=" target="mainFrame">
			<cfoutput>#menutitle[69]#</cfoutput>
		</a>
	</li>
    </cfif>
    <cfif getpin2.h6B00 eq "T">
	<li>
		<a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=QUO&name=Quotation&BilType=" target="mainFrame">
			<cfoutput>#menutitle[70]#</cfoutput>
		</a>
	</li>
    </cfif>
    
    </span>
    </cfif>
    
    
    <cfif getpin2.h6F00 eq "T" or getpin2.h6G00 eq "T" or getpin2.h6H00 eq "T" or getpin2.h6I00 eq "T">
     <li onClick="SwitchMenu('sub4')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[163]#</cfoutput></a></li>
    <span id="sub4" style="display:none;" class="submenu">
    <cfif getpin2.h6F00 eq "T">
	<li>
		<a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=TR&name=Transfer Note&BilType=" target="mainFrame">
			<cfoutput>#menutitle[74]#</cfoutput>
		</a>
	</li>
    </cfif>
    <cfif getpin2.h6G00 eq "T">
	<li>
		<a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=TR&name=Transfer Note 2&BilType=" target="mainFrame">
			<cfoutput>#menutitle[75]#</cfoutput>
		</a>
	</li>
    </cfif>
    <cfif getpin2.h6H00 eq "T">
	<li>
		<a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=TR&name=Consignment Note&BilType=" target="mainFrame">
			<cfoutput>#menutitle[76]#</cfoutput>
		</a>
	</li>
    </cfif>
    <cfif getpin2.h6I00 eq "T">
	<li>
		<a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=TR&name=Consignment Return&BilType=" target="mainFrame">
			<cfoutput>#menutitle[77]#</cfoutput>
		</a>
	</li>
    </cfif>
    
    </span>
    </cfif>
    
        <cfif getpin2.h6800 eq "T">
        <li onClick="SwitchMenu('sub11')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[175]#</cfoutput></a></li>
       <span id="sub11" style="display:none;" class="submenu">
			<cfif getpin2.h6800 eq "T">
            <li>
                <a class="oe_secondary_submenu_item" href="/#HDir#/print_bills/generate_print_bills.cfm?type=DO&name=Packing List&BilType=" target="mainFrame">
                    <cfoutput>#menutitle[67]#</cfoutput>
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
