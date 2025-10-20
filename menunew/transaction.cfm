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
<cfif getpin2.h2000 eq "T">
	<cfif lcase(HcomID) eq "beps_i">
    	<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/assignmentslip/s_assignmentsliptable.cfm" target="mainFrame">
				<cfoutput>#menutitle[147]#</cfoutput>
			</a>
		</li>
    </cfif>
	<cfif lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i">	<!--- Modified on 29-12-2009 --->
    <cfif  getpin2.h2860 eq 'T' or getpin2.h2100 eq "T" or getpin2.h2870 eq "T" or getpin2.h2880 eq "T" or getpin2.h2300 eq "T" or getpin2.h2400 eq "T" or getpin2.h2500 eq "T" or getpin2.h2800 eq "T" or getpin2.h2900 eq "T" or getpin2.h2A00 eq "T">
    <li onClick="SwitchMenu('sub1')"><a class="oe_secondary_menu_item" style="cursor:pointer">
    <cfoutput>#menutitle[148]#</cfoutput></a></li>
<span id="sub1" style="display:none;" class="submenu">
		<cfif getpin2.h2860 eq 'T'>
			<li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=po" target="mainFrame">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lPO#
                    <cfelse>
                    <cfoutput>#menutitle[68]#</cfoutput>
                    </cfif>
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2100 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=rc" target="mainFrame">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lRC#
                    <cfelse>
                    <cfoutput>#menutitle[42]#</cfoutput>
                    </cfif>
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2870 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=quo" target="mainFrame">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lQUO#
                    <cfelse>
                    <cfoutput>#menutitle[70]#</cfoutput>
                    </cfif>
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2880 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=so" target="mainFrame">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lSO#
                    <cfelse>
                    <cfoutput>#menutitle[69]#</cfoutput>
                    </cfif>
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2300 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=do" target="mainFrame">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lDO#
                    <cfelse>
                    <cfoutput>#menutitle[44]#</cfoutput>
                    </cfif>
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2400 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=inv" target="mainFrame">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lINV#
                    <cfelse>
                    <cfoutput>#menutitle[45]#</cfoutput>
                    </cfif>
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2500 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=cs" target="mainFrame">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lCS#
                    <cfelse>
                    <cfoutput>#menutitle[46]#</cfoutput>
                    </cfif>
				</a>
			</li>
		</cfif>
            </span>
    </cfif>
		<cfif getpin2.h2800 eq "T">
                <li onClick="SwitchMenu('sub2')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[49]#</cfoutput></a></li>
                <span id="sub2" style="display:none;" class="submenu">
                <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/assm1.cfm" target="mainFrame">
						<cfoutput>#menutitle[149]#</cfoutput>
				</a>
				</li>
                
                <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=ISS" target="mainFrame">
						<cfoutput>#menutitle[150]#</cfoutput>
				</a>
				</li>
                
                <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=OAI" target="mainFrame">
						<cfoutput>#menutitle[151]#</cfoutput>
				</a>
				</li>
                
                <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=OAR" target="mainFrame">
						<cfoutput>#menutitle[152]#</cfoutput>
				</a>
				</li>
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/historicalrecords/historicalmenu.cfm" target="mainFrame">
						<cfoutput>#menutitle[153]#</cfoutput>
				</a>
				</li>
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/expressadjustmenttran/index.cfm" target="mainFrame">
						<cfoutput>#menutitle[154]#</cfoutput>
				</a>
				</li>
                
                
                </span>
            </cfif>
            
            <cfif getpin2.h2800 eq "T">
                <li onClick="SwitchMenu('sub3')"><a class="oe_secondary_menu_item" style="cursor:pointer">
                <cfoutput>#menutitle[155]#</cfoutput></a></li>
                <span id="sub3" style="display:none;" class="submenu">
                <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=po" target="mainFrame">
						<cfoutput>#menutitle[68]#</cfoutput>
				</a>
				</li>
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=quo" target="mainFrame">
						<cfoutput>#menutitle[70]#</cfoutput>
				</a>
				</li>
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=so" target="mainFrame">
						<cfoutput>#menutitle[156]#</cfoutput>
				</a>
				</li>
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=sam" target="mainFrame">
						<cfoutput>#menutitle[157]#</cfoutput>
				</a>
				</li>
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=rq" target="mainFrame">
						<cfoutput>#menutitle[158]#</cfoutput>
				</a>
				</li>
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/writeoff.cfm?tran=po" target="mainFrame">
						<cfoutput>#menutitle[159]#</cfoutput>
				</a>
				</li>
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/writeoff.cfm?tran=so" target="mainFrame">
						<cfoutput>#menutitle[160]#</cfoutput>
				</a>
				</li>
                
                <li onClick="SwitchMenu2('sub1')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[161]#</cfoutput></a></li>
                <span id="sub1" style="display:none;" class="submenu2">
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/HistoricalRecords/historicalrecords.cfm?historical=ListHistoricalBillsOrder" target="mainFrame">
						<cfoutput>#menutitle[162]#</cfoutput>
				</a>
				</li>
                
                <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/HistoricalRecords/historicalrecords.cfm?historical=ListHistoricalItemsOrder" target="mainFrame">
						<cfoutput>#menutitle[172]#</cfoutput>
				</a>
				</li>
                </span>
                
            </span>
            </cfif>
        
        <cfif getpin2.h2800 eq "T">
                <li onClick="SwitchMenu('sub4')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[163]#</cfoutput></a></li>
                <span id="sub4" style="display:none;" class="submenu">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/copy.cfm" target="mainFrame">
                        <cfoutput>#menutitle[164]#</cfoutput>
                    </a>
				</li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=TR" target="mainFrame">
                        <cfoutput>#menutitle[165]#</cfoutput>
                    </a>
				</li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=TR&consignment=out" target="mainFrame">
                        <cfoutput>#menutitle[166]#</cfoutput>
                    </a>
				</li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=TR&consignment=return" target="mainFrame">
                        <cfoutput>#menutitle[167]#</cfoutput>
                    </a>
				</li>
                
                </span>
                </cfif>
            
            
	  	<cfif getpin2.h2900 eq "T">
        <li onClick="SwitchMenu('sub5')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[50]#</cfoutput></a></li>
                <span id="sub5" style="display:none;" class="submenu">
                    <li>
                        <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/generateupdate/distribute_miscellaneous_charges_into_cost.cfm" target="mainFrame">
                            <cfoutput>#menutitle[168]#</cfoutput>
                        </a>
                    </li>
                    <li>
                        <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/generateupdate/generate_full_payment_date.cfm" target="mainFrame">
                            <cfoutput>#menutitle[169]#</cfoutput>
                        </a>
                    </li>
        			<li>
                        <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/generateupdate/generate_customer_outstanding_balance.cfm" target="mainFrame">
                           <cfoutput>#menutitle[170]#</cfoutput>
                        </a>
                    </li>
                                
            </span>
		</cfif>
        <cfif getpin2.h2A00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/eInvoicing/eInvoicemenu.cfm" target="mainFrame">
				<cfoutput>#menutitle[171]#</cfoutput>
			</a>
		</li>
	</cfif>

	<cfelse>
    <cfif  getpin2.h2100 eq "T" or getpin2.h2200 eq "T" or getpin2.h2300 eq "T" or getpin2.h2400 eq "T" or getpin2.h2500 eq "T" or getpin2.h2600 eq "T" or getpin2.h2700 eq "T"  >
    <li onClick="SwitchMenu('sub2')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[148]#</cfoutput></a></li>
<span id="sub2" style="display:none;" class="submenu">
    
    
		<cfif getpin2.h2100 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=rc" target="mainFrame">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lRC#
                    <cfelse>
                    <cfoutput>#menutitle[64]#</cfoutput>
                    </cfif>
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2200 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=pr" target="mainFrame">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lPR#
                    <cfelse>
                    <cfoutput>#menutitle[65]#</cfoutput>
                    </cfif>
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2300 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=do" target="mainFrame">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lDO#
                    <cfelse>
                    <cfoutput>#menutitle[66]#</cfoutput>
                    </cfif>
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2400 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=inv" target="mainFrame">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lINV#
                    <cfelse>
                    <cfoutput>#menutitle[60]#</cfoutput>
                    </cfif>
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2500 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=cs" target="mainFrame">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lCS#
                    <cfelse>
                    <cfoutput>#menutitle[46]#</cfoutput>
                    </cfif>
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2600 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=cn" target="mainFrame">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lCN#
                    <cfelse>
                    <cfoutput>#menutitle[47]#</cfoutput>
                    </cfif>
				</a>
			</li>
		</cfif>	
		<cfif getpin2.h2700 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=dn" target="mainFrame">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lDN#
                    <cfelse>
                    <cfoutput>#menutitle[48]#</cfoutput>
                    </cfif>
				</a>
			</li>
		</cfif>
        </span>
        </cfif>
		<cfif getpin2.h2800 eq "T">
                <li onClick="SwitchMenu('sub6')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[49]#</cfoutput></a></li>
                <span id="sub6" style="display:none;" class="submenu">
                <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/assm1.cfm" target="mainFrame">
						<cfoutput>#menutitle[149]#</cfoutput>
				</a>
				</li>
                
                <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=ISS" target="mainFrame">
						<cfoutput>#menutitle[150]#</cfoutput>
				</a>
				</li>
                
                <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=OAI" target="mainFrame">
						<cfoutput>#menutitle[151]#</cfoutput>
				</a>
				</li>
                
                <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=OAR" target="mainFrame">
						<cfoutput>#menutitle[152]#</cfoutput>
				</a>
				</li>
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/expressadjustmenttran/index.cfm" target="mainFrame">
						<cfoutput>#menutitle[154]#</cfoutput>
				</a>
				</li>
                
                
             <li onClick="SwitchMenu2('sub13')"><a class="oe_secondary_menu_item" style="cursor:pointer">
			<cfoutput>#menutitle[153]#</cfoutput></a></li>
                <span id="sub13" style="display:none;" class="submenu2">   
                <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/historicalrecords/historicalform.cfm?historical=ViewBatchSummary" target="mainFrame">
						<cfoutput>#menutitle[408]#</cfoutput>
				</a>
				</li>
                <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/historicalrecords/historicalform.cfm?historical=ListHistoricalBills" target="mainFrame">
						<cfoutput>#menutitle[409]#</cfoutput>
				</a>
				</li>
                <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/historicalrecords/historicalform.cfm?historical=ListHistoricalPrice" target="mainFrame">
						<cfoutput>#menutitle[410]#</cfoutput>
				</a>
				</li>
                
                </span>
            </span>
            </cfif>
            
            <cfif getpin2.h2800 eq "T">
                <li onClick="SwitchMenu('sub7')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[155]#</cfoutput></a></li>
                <span id="sub7" style="display:none;" class="submenu">
                <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=po" target="mainFrame">
						<cfoutput>#menutitle[68]#</cfoutput>
				</a>
				</li>
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=quo" target="mainFrame">
						<cfoutput>#menutitle[70]#</cfoutput>
				</a>
				</li>
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=so" target="mainFrame">
						<cfoutput>#menutitle[156]#</cfoutput>
				</a>
				</li>
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=sam" target="mainFrame">
						<cfoutput>#menutitle[157]#</cfoutput>
				</a>
				</li>
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=rq" target="mainFrame">
						<cfoutput>#menutitle[158]#</cfoutput>
				</a>
				</li>
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/writeoff.cfm?tran=po" target="mainFrame">
						<cfoutput>#menutitle[159]#</cfoutput>
				</a>
				</li>
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/writeoff.cfm?tran=so" target="mainFrame">
						<cfoutput>#menutitle[160]#</cfoutput>
				</a>
				</li>
                
                <li onClick="SwitchMenu2('sub9')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[161]#</cfoutput></a></li>
                <span id="sub9" style="display:none;" class="submenu2">
                 <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/HistoricalRecords/historicalrecords.cfm?historical=ListHistoricalBillsOrder" target="mainFrame">
						<cfoutput>#menutitle[162]#</cfoutput>
				</a>
				</li>
                
                <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/HistoricalRecords/historicalrecords.cfm?historical=ListHistoricalItemsOrder" target="mainFrame">
						<cfoutput>#menutitle[172]#</cfoutput>
				</a>
				</li>
                </span>
                
            </span>
            </cfif>
        
        <cfif getpin2.h2800 eq "T">
                <li onClick="SwitchMenu('sub8')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[163]#</cfoutput></a></li>
                <span id="sub8" style="display:none;" class="submenu">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/copy.cfm" target="mainFrame">
                        <cfoutput>#menutitle[164]#</cfoutput>
                    </a>
				</li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=TR" target="mainFrame">
                        <cfoutput>#menutitle[165]#</cfoutput>
                    </a>
				</li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=TR&consignment=out" target="mainFrame">
                        <cfoutput>#menutitle[166]#</cfoutput>
                    </a>
				</li>
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=TR&consignment=return" target="mainFrame">
                        <cfoutput>#menutitle[167]#</cfoutput>
                    </a>
				</li>
                
                </span>
                </cfif>
	  	<cfif getpin2.h2900 eq "T">
			<li onClick="SwitchMenu('sub12')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[50]#</cfoutput></a></li>
                <span id="sub12" style="display:none;" class="submenu">
                    <li>
                        <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/generateupdate/distribute_miscellaneous_charges_into_cost.cfm" target="mainFrame">
                            <cfoutput>#menutitle[168]#</cfoutput>
                        </a>
                    </li>
                    <li>
                        <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/generateupdate/generate_full_payment_date.cfm" target="mainFrame">
                            <cfoutput>#menutitle[169]#</cfoutput>
                        </a>
                    </li>
        			<li>
                        <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/generateupdate/generate_customer_outstanding_balance.cfm" target="mainFrame">
                            <cfoutput>#menutitle[170]#</cfoutput>
                        </a>
                    </li>
                                
            </span>
		</cfif>
        <cfif getpin2.h2A00 eq "T">
            
            <li onClick="SwitchMenu('sub10')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[171]#</cfoutput></a></li>
                    <span id="sub10" style="display:none;" class="submenu">
                        <li>
                            <a class="oe_secondary_submenu_item" href="/#HDir#/eInvoicing/eInvoice.cfm" target="mainFrame">
                                 <cfoutput>#menutitle[173]#</cfoutput>
                            </a>
                        </li>
                        
                        <li>
                            <a class="oe_secondary_submenu_item" href="/#HDir#/eInvoicing/eInvoicelog.cfm" target="mainFrame">
                                 <cfoutput>#menutitle[174]#</cfoutput>
                            </a>
                        </li>
    
                    </span>
        </cfif>
    <cfif getpin2.h2B00 eq "T" or getpin2.h2C00 eq "T" or getpin2.h2H00 eq "T" or lcase(HcomID) eq "demo_i" or lcase(HcomID) eq "ovas_i" or lcase(HcomID) eq "verjas_i" or  lcase(HcomID) eq "augment_i" or lcase(HcomID) eq "supervalu_i" or getmodule.postran eq '1'>
    <li onClick="SwitchMenu('sub11')"><a class="oe_secondary_menu_item" style="cursor:pointer"><cfoutput>#menutitle[175]#</cfoutput></a></li>
                    <span id="sub11" style="display:none;" class="submenu">
    <cfif getpin2.h2B00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/packinglist/listPackingMain.cfm" target="mainFrame">
				<cfoutput>#menutitle[51]#</cfoutput>
			</a>
		</li>
	</cfif>
    <cfif getpin2.h2C00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/newbody.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/recurringtran/')">
				<cfoutput>#menutitle[52]#</cfoutput>
			</a>
		</li>
        </cfif>
      <cfif getpin2.h2H00 eq "T">
         <li>
			<a class="oe_secondary_submenu_item" href="/newbody.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/expressbill/')">
				<cfoutput>#menutitle[53]#</cfoutput>
			</a>
		</li>
        <cfif lcase(HcomID) eq "demo_i">
          <li>
			<a class="oe_secondary_submenu_item" href="/newbody.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/expressbill2/')">
				<cfoutput>#menutitle[54]#</cfoutput>
			</a>
		</li>
        </cfif>
         <cfif lcase(HcomID) eq "ovas_i">
          <li>
			<a class="oe_secondary_submenu_item" href="/newbody.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/ovasexpressbill/')">
				<cfoutput>#menutitle[175]#</cfoutput>
			</a>
		</li>
        </cfif>
        
        <cfif lcase(HcomID) eq "verjas_i" or lcase(HcomID) eq "augment_i">
          <li>
			<a class="oe_secondary_submenu_item" href="/newbody.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/verjasexpressbill/')">
				<cfif lcase(HcomID) eq "augment_i"><cfoutput>#menutitle[176]#</cfoutput>
                <cfelse><cfoutput>#menutitle[177]#</cfoutput></cfif>
			</a>
		</li>
        </cfif>
        <cfif lcase(HcomID) eq "supervalu_i">
          <li>
			<a class="oe_secondary_submenu_item" href="/newbody.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/verjasexpressbill/')">
				<cfoutput>#menutitle[178]#</cfoutput>
			</a>
		</li>
        </cfif>
        <cfif getmodule.postran eq '1'>
          <li>
			<a class="oe_secondary_submenu_item" href="/newbody.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/POS/index.cfm?first=true')">
				<cfoutput>#menutitle[55]#</cfoutput>
			</a>            
		</li>

        <li>
        <a class="oe_secondary_submenu_item" href="/default/admin/possync" target="mainFrame" >
        <cfoutput>#menutitle[179]#</cfoutput></a>
        </li>
        </cfif>
        
	
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/itemcombine" target="mainFrame">
				<cfoutput>#menutitle[56]#</cfoutput>
			</a>
		</li>
        <li>
			<a class="oe_secondary_submenu_item" href="/default/POS/listpos.cfm" target="mainFrame">
				<cfoutput>#menutitle[57]#</cfoutput>
			</a>
		</li>
        <cfif lcase(hcomid) eq "demo_i">
         <li>
			<a class="oe_secondary_submenu_item" href="/sixcapital" target="mainFrame">
				<cfoutput>#menutitle[58]#</cfoutput>
			</a>
		</li>
        </cfif>
</cfif>
</span>
</cfif>
</cfif>
</cfif>
</div>
</div>
</div>
</cfoutput>
</body>
</html>