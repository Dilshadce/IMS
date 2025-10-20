<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Testing</title>
<link rel="stylesheet" type="text/css" href="/newinterface2/css1.css" />
<script language="javascript" type="text/javascript" src="/scripts/change_left_menunew.js"></script>
</head>
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

<body class="netiquette" onload="SwitchMenu('sub6')">
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
        <cfif getpin2.h2000 eq "T">
          <cfif lcase(HcomID) eq "beps_i">
            <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/assignmentslip/s_assignmentsliptable.cfm" target="mainFrame" title="<cfoutput>#menutitle[147]#</cfoutput>"> <cfoutput>#menutitle[147]#</cfoutput> </a> </li>
          </cfif>
          <cfif lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i">
            <!--- Modified on 29-12-2009 --->
            <cfif  getpin2.h2860 eq 'T' or getpin2.h2100 eq "T" or getpin2.h2870 eq "T" or getpin2.h2880 eq "T" or getpin2.h2300 eq "T" or getpin2.h2400 eq "T" or getpin2.h2500 eq "T" or getpin2.h2800 eq "T" or getpin2.h2900 eq "T" or getpin2.h2A00 eq "T">
              <li onClick="SwitchMenu('sub1')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[148]#</cfoutput>"> <cfoutput>#menutitle[148]#</cfoutput></a></li>
              <span id="sub1" style="display:none;" class="submenu">
              <cfif getpin2.h2860 eq 'T'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=po" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lPO#
                    <cfelse>
                    <cfoutput>#menutitle[68]#</cfoutput>
                    </cfif>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lPO#
                    <cfelse>
                    <cfoutput>#menutitle[68]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              <cfif getpin2.h2100 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=rc" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lRC#
                    <cfelse>
                    <cfoutput>#menutitle[42]#</cfoutput>
                    </cfif>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lRC#
                    <cfelse>
                    <cfoutput>#menutitle[42]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              <cfif lcase(hcomid) neq "excelsnm_i">
                <cfif getpin2.h2870 eq "T">
                  <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=quo" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lQUO#
                    <cfelse>
                    <cfoutput>#menutitle[70]#</cfoutput>
                    </cfif>">
                    <cfif getGeneralInfo.dflanguage eq 'english'>
                      #getGeneralInfo.lQUO#
                      <cfelse>
                      <cfoutput>#menutitle[70]#</cfoutput>
                    </cfif>
                    </a> </li>
                </cfif>
              </cfif>
              <cfif getpin2.h2880 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=so" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lSO#
                    <cfelse>
                    <cfoutput>#menutitle[69]#</cfoutput>
                    </cfif>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lSO#
                    <cfelse>
                    <cfoutput>#menutitle[69]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              <cfif getpin2.h2300 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=do" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lDO#
                    <cfelse>
                    <cfoutput>#menutitle[44]#</cfoutput>
                    </cfif>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lDO#
                    <cfelse>
                    <cfoutput>#menutitle[44]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              <cfif getpin2.h2400 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=inv" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lINV#
                    <cfelse>
                    <cfoutput>#menutitle[45]#</cfoutput>
                    </cfif>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lINV#
                    <cfelse>
                    <cfoutput>#menutitle[45]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              <cfif getpin2.h2500 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=cs" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lCS#
                    <cfelse>
                    <cfoutput>#menutitle[46]#</cfoutput>
                    </cfif>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lCS#
                    <cfelse>
                    <cfoutput>#menutitle[46]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              </span>
            </cfif>
            <cfif getpin2.h2800 eq "T">
              <li onClick="SwitchMenu('sub2')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[49]#</cfoutput>"><cfoutput>#menutitle[49]#</cfoutput></a></li>
              <span id="sub2" style="display:none;" class="submenu">
              <cfif getpin2.h2810 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/assm1.cfm" target="mainFrame" title="<cfoutput>#menutitle[149]#</cfoutput>"> <cfoutput>#menutitle[149]#</cfoutput> </a> </li>
              </cfif>
              <cfif getpin2.h2820 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=ISS" target="mainFrame" title="<cfoutput>#menutitle[150]#</cfoutput>"> <cfoutput>#menutitle[150]#</cfoutput> </a> </li>
              </cfif>
              <cfif getpin2.h2830 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=OAI" target="mainFrame" title="<cfoutput>#menutitle[151]#</cfoutput>"> <cfoutput>#menutitle[151]#</cfoutput> </a> </li>
              </cfif>
              <cfif getpin2.h2840 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=OAR" target="mainFrame" title="<cfoutput>#menutitle[152]#</cfoutput>"> <cfoutput>#menutitle[152]#</cfoutput> </a> </li>
              </cfif>
              <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/historicalrecords/historicalmenu.cfm" target="mainFrame" title="<cfoutput>#menutitle[153]#</cfoutput>"> <cfoutput>#menutitle[153]#</cfoutput> </a> </li>
              <cfif getpin2.h2L00 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/expressadjustmenttran/index.cfm" target="mainFrame" title="<cfoutput>#menutitle[154]#</cfoutput>"> <cfoutput>#menutitle[154]#</cfoutput> </a> </li>
              </cfif>
              </span>
            </cfif>
            <cfif getpin2.h2800 eq "T">
              <li onClick="SwitchMenu('sub3')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[155]#</cfoutput>"> <cfoutput>#menutitle[155]#</cfoutput></a></li>
              <span id="sub3" style="display:none;" class="submenu">
              <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=po" target="mainFrame" title="<cfoutput>#menutitle[68]#</cfoutput>"> <cfoutput>#menutitle[68]#</cfoutput> </a> </li>
              <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=quo" target="mainFrame" title="<cfoutput>#menutitle[70]#</cfoutput>"> <cfoutput>#menutitle[70]#</cfoutput> </a> </li>
              <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=so" target="mainFrame" title="<cfoutput>#menutitle[156]#</cfoutput>"> <cfoutput>#menutitle[156]#</cfoutput> </a> </li>
              <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=sam" target="mainFrame" title="<cfoutput>#menutitle[157]#</cfoutput>">
                <cfif getGeneralInfo.dflanguage eq 'english'>
                  #getGeneralInfo.lSAM#
                  <cfelse>
                  <cfoutput>#menutitle[157]#</cfoutput>
                </cfif>
                </a> </li>
              <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=rq" target="mainFrame" title="<cfoutput>#menutitle[158]#</cfoutput>"> <cfoutput>#menutitle[158]#</cfoutput> </a> </li>
              <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/writeoff.cfm?tran=po" target="mainFrame" title="<cfoutput>#menutitle[159]#</cfoutput>"> <cfoutput>#menutitle[159]#</cfoutput> </a> </li>
              <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/writeoff.cfm?tran=so" target="mainFrame" title="<cfoutput>#menutitle[160]#</cfoutput>"> <cfoutput>#menutitle[160]#</cfoutput> </a> </li>
              <li onClick="SwitchMenu2('sub1')"><a class="oe_secondary_menu_item2" style="cursor:pointer" title="<cfoutput>#menutitle[161]#</cfoutput>"><cfoutput>#menutitle[161]#</cfoutput></a></li>
              <span id="sub1" style="display:none;" class="submenu2">
              <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/HistoricalRecords/historicalrecords.cfm?historical=ListHistoricalBillsOrder" target="mainFrame" title="<cfoutput>#menutitle[162]#</cfoutput>"> <cfoutput>#menutitle[162]#</cfoutput> </a> </li>
              <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/HistoricalRecords/historicalrecords.cfm?historical=ListHistoricalItemsOrder" target="mainFrame" title="<cfoutput>#menutitle[172]#</cfoutput>"> <cfoutput>#menutitle[172]#</cfoutput> </a> </li>
              </span> </span>
            </cfif>
            <cfif getpin2.h2800 eq "T">
              <li onClick="SwitchMenu('sub4')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[163]#</cfoutput>"><cfoutput>#menutitle[163]#</cfoutput></a></li>
              <span id="sub4" style="display:none;" class="submenu">
              <cfif lcase(hcomid) neq "excelsnm_i">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/copy.cfm" target="mainFrame" title="<cfoutput>#menutitle[164]#</cfoutput>"> <cfoutput>#menutitle[164]#</cfoutput> </a> </li>
              </cfif>
              <cfif getpin2.h28A0 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=TR" target="mainFrame" title="<cfoutput>#menutitle[165]#</cfoutput>"> <cfoutput>#menutitle[165]#</cfoutput> </a> </li>
              </cfif>
              <cfif getpin2.h28E0 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=TR&consignment=out" target="mainFrame" title="<cfoutput>#menutitle[166]#</cfoutput>"> <cfoutput>#menutitle[166]#</cfoutput> </a> </li>
              </cfif>
              <cfif getpin2.h28F0 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=TR&consignment=return" target="mainFrame" title="<cfoutput>#menutitle[167]#</cfoutput>"> <cfoutput>#menutitle[167]#</cfoutput> </a> </li>
              </cfif>
              </span>
            </cfif>
            <cfif getpin2.h2900 eq "T">
              <li onClick="SwitchMenu('sub5')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[50]#</cfoutput>"><cfoutput>#menutitle[50]#</cfoutput></a></li>
              <span id="sub5" style="display:none;" class="submenu">
              <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/generateupdate/distribute_miscellaneous_charges_into_cost.cfm" target="mainFrame" title="<cfoutput>#menutitle[168]#</cfoutput>"> <cfoutput>#menutitle[168]#</cfoutput> </a> </li>
              <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/generateupdate/generate_full_payment_date.cfm" target="mainFrame" title="<cfoutput>#menutitle[169]#</cfoutput>"> <cfoutput>#menutitle[169]#</cfoutput> </a> </li>
              <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/generateupdate/generate_customer_outstanding_balance.cfm" target="mainFrame" title="<cfoutput>#menutitle[170]#</cfoutput>"> <cfoutput>#menutitle[170]#</cfoutput> </a> </li>
              </span>
            </cfif>
            <cfif getpin2.h2A00 eq "T">
              <li> <a class="oe_secondary_submenu_item" href="/#HDir#/eInvoicing/eInvoicemenu.cfm" target="mainFrame" title="<cfoutput>#menutitle[171]#</cfoutput>"> <cfoutput>#menutitle[171]#</cfoutput> </a> </li>
            </cfif>
            <cfelse>
            <cfif  getpin2.h28C0 eq "T" or getpin2.h2100 eq "T" or getpin2.h2200 eq "T" or getpin2.h2860 eq "T" or getpin2.h2700 eq "T">
              <li onClick="SwitchMenu('sub2')">
                <cfif husergrpid eq 'super'>
                  <a href="/purchasediagrammenu.cfm" target="mainFrame" class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[148]#</cfoutput>"><cfoutput>#menutitle[148]#</cfoutput></a>
                  <cfelse>
                  <a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[148]#</cfoutput>"><cfoutput>#menutitle[148]#</cfoutput></a>
                </cfif>
              </li>
              <span id="sub2" style="display:none;" class="submenu">
              <cfif getpin2.h2860 eq 'T'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=po" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lPO#
                    <cfelse>
                    <cfoutput>#menutitle[68]#</cfoutput>
                </cfif>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lPO#
                    <cfelse>
                    <cfoutput>#menutitle[68]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              <cfif getpin2.h2100 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=rc" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lRC#
                    <cfelse>
                    <cfoutput>#menutitle[64]#</cfoutput>
                    </cfif>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lRC#
                    <cfelse>
                    <cfoutput>#menutitle[64]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              <cfif getpin2.h2200 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=pr" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lPR#
                    <cfelse>
                    <cfoutput>#menutitle[65]#</cfoutput>
                    </cfif>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lPR#
                    <cfelse>
                    <cfoutput>#menutitle[65]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              <cfif getpin2.h28C0 eq 'T'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=rq" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lRQ#
                    <cfelse>
                    <cfoutput>#menutitle[158]#</cfoutput>
                    </cfif>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lRQ#
                    <cfelse>
                    <cfoutput>#menutitle[158]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              </span>
            </cfif>
            <cfif getpin2.h2300 eq "T" or getpin2.h2400 eq "T" or getpin2.h2500 eq "T" or getpin2.h2600 eq "T" or getpin2.h2870 eq "T" or getpin2.h2880 eq "T">
              <li onClick="SwitchMenu('sub6')">
                <cfif husergrpid eq 'super'>
                  <a href="/salesdiagrammenu.cfm" target="mainFrame" class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[155]#</cfoutput>"><cfoutput>#menutitle[155]#</cfoutput></a>
                  <cfelse>
                  <a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[155]#</cfoutput>"><cfoutput>#menutitle[155]#</cfoutput></a>
                </cfif>
              </li>
              <span id="sub6" style="display:none;" class="submenu">
              <cfif lcase(HcomID) eq "simplysiti_i">
                <cfif getpin2.h2500 eq "T">
                  <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/simplysitiimportexcel/import_excel.cfm" target="mainFrame" title="Import Sales From Outlet"> Import Sales From Outlet </a> </li>
                  <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/simplysitiimportexcel/simplysitigeneratetransfer.cfm" target="mainFrame" title="Generate Transfer"> Generate Transfer </a> </li>
                </cfif>
              </cfif>
              <cfif lcase(hcomid) neq "excelsnm_i">
                <cfif getpin2.h2870 eq "T">
                  <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=quo" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lQUO#
                    <cfelse>
                    <cfoutput>#menutitle[70]#</cfoutput>
                    </cfif>">
                    <cfif getGeneralInfo.dflanguage eq 'english'>
                      #getGeneralInfo.lQUO#
                      <cfelse>
                      <cfoutput>#menutitle[70]#</cfoutput>
                    </cfif>
                    </a> </li>
                </cfif>
              </cfif>
              <cfif lcase(HcomID) eq "hodaka_i">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/expresshodaka/index.cfm?type=SO" target="mainFrame" title="<cfoutput>Order Form</cfoutput>"> <cfoutput>Order Form</cfoutput> </a> </li>
              </cfif>
              <cfif getpin2.h2880 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=SO" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lSO#
                    <cfelse>
                    <cfoutput>#menutitle[156]#</cfoutput>
                    </cfif>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lSO#
                    <cfelse>
                    <cfoutput>#menutitle[156]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              <cfif getpin2.h2300 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=do" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lDO#
                    <cfelse>
                    <cfoutput>#menutitle[66]#</cfoutput>
                    </cfif>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lDO#
                    <cfelse>
                    <cfoutput>#menutitle[66]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              <cfif getpin2.h2400 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=inv" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lINV#
                    <cfelse>
                    <cfoutput>#menutitle[45]#</cfoutput>
                    </cfif>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lINV#
                    <cfelse>
                    <cfoutput>#menutitle[45]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              <cfif getpin2.h2500 eq 'T'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=cs" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lCS#
                    <cfelse>
                    <cfoutput>#menutitle[46]#</cfoutput>
                </cfif>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lCS#
                    <cfelse>
                    <cfoutput>#menutitle[46]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              <cfif getpin2.h2600 eq 'T'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=cn" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lCN#
                    <cfelse>
                    <cfoutput>#menutitle[47]#</cfoutput>
                </cfif>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lCN#
                    <cfelse>
                    <cfoutput>#menutitle[47]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              <cfif getpin2.h2700 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=dn" target="mainFrame" title="<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lDN#
                    <cfelse>
                    <cfoutput>#menutitle[48]#</cfoutput>
                    </cfif>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lDN#
                    <cfelse>
                    <cfoutput>#menutitle[48]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              <cfif getpin2.h2K00 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/deposit/s_deposittable.cfm" target="mainFrame"> Deposit Profile </a> </li>
              </cfif>
              <cfif lcase(hcomid) eq "imperial1_i">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/jobsheet/viewjob.cfm" target="mainFrame"> Job Sheet </a> </li>
              </cfif>
              </span>
            </cfif>
            <cfif getpin2.h2810 eq 'T' or getpin2.h2820 eq 'T' or getpin2.h2830 eq 'T' or getpin2.h28A0 eq 'T' or getpin2.h28E0 eq 'T' or getpin2.h28F0 eq 'T'>
              <li onClick="SwitchMenu('sub8')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[163]#</cfoutput>"><cfoutput>#menutitle[163]#</cfoutput></a></li>
              <span id="sub8" style="display:none;" class="submenu">
              <cfif getpin2.h2810 eq 'T'>
                <cfquery datasource="#dts#" name="getGeneralInfo">
				Select *
				from GSetup
				</cfquery>
                <cfif getGeneralInfo.assm_oneset neq '1'>
                  <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/assm0.cfm" target="mainFrame" title="<cfoutput>#menutitle[149]#</cfoutput>"> <cfoutput>#menutitle[149]#</cfoutput> </a> </li>
                  <cfelse>
                  <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/assm1.cfm" target="mainFrame" title="<cfoutput>#menutitle[149]#</cfoutput>"> <cfoutput>#menutitle[149]#</cfoutput> </a> </li>
                </cfif>
              </cfif>
              <cfif getpin2.h2820 eq 'T'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=ISS" target="mainFrame" title="<cfoutput>#menutitle[150]#</cfoutput>"> <cfoutput>#menutitle[150]#</cfoutput> </a> </li>
              </cfif>
              <cfif getpin2.h2830 eq 'T'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=OAI" target="mainFrame" title="<cfoutput>#menutitle[151]#</cfoutput>"> <cfoutput>#menutitle[151]#</cfoutput> </a> </li>
              </cfif>
              <cfif lcase(hcomid) eq 'glrsg_i' or lcase(hcomid) eq 'demo_i'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/importOAI.cfm" target="mainFrame" title="<cfoutput>Import Adjustment</cfoutput>"> <cfoutput>Import Adjustment</cfoutput> </a> </li>
              </cfif>
              <cfif getmodule.manufacturing eq "1" >
                <cfif getpin2.h2810 eq 'T'>
                  <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/dissemble/index.cfm" target="mainFrame" title="<cfoutput>Assemble / Dissemble</cfoutput>"> <cfoutput>#getGeneralInfo.ass#</cfoutput> </a> </li>
                </cfif>
              </cfif>
              <cfif getpin2.h2840 eq 'T'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=OAR" target="mainFrame" title="<cfoutput>#menutitle[152]#</cfoutput>"> <cfoutput>#menutitle[152]#</cfoutput> </a> </li>
              </cfif>
              <cfif getpin2.h2830 eq 'T'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/expressadjustmenttran/index.cfm" target="mainFrame" title="<cfoutput>#menutitle[154]#</cfoutput>"> <cfoutput>#menutitle[154]#</cfoutput> </a> </li>
              </cfif>
              <cfif lcase(hcomid) neq "excelsnm_i">
                <cfif getpin2.h28A0 eq 'T'>
                  <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=TR" target="mainFrame" title="<cfoutput>#menutitle[165]#</cfoutput>"> <cfoutput>#menutitle[165]#</cfoutput> </a> </li>
                </cfif>
              </cfif>
              <cfif lcase(hcomid) neq "excelsnm_i">
                <cfif getpin2.h28E0 eq 'T'>
                  <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=TR&consignment=out" target="mainFrame" title="<cfoutput>#menutitle[166]#</cfoutput>"> <cfoutput>#menutitle[166]#</cfoutput> </a> </li>
                </cfif>
              </cfif>
              <cfif lcase(hcomid) neq "excelsnm_i">
                <cfif getpin2.h28F0 eq 'T'>
                  <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/siss.cfm?tran=TR&consignment=return" target="mainFrame" title="<cfoutput>#menutitle[167]#</cfoutput>"> <cfoutput>#menutitle[167]#</cfoutput> </a> </li>
                </cfif>
              </cfif>
              </span>
            </cfif>
            <cfif getpin2.h2850 eq 'T' or getpin2.h2890 eq 'T' or getpin2.h28C0 eq 'T' or getpin2.h28D0 eq 'T' or getpin2.h28B0 eq 'T'>
              <li onClick="SwitchMenu('sub7')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[49]#</cfoutput>"><cfoutput>#menutitle[49]#</cfoutput></a></li>
              <span id="sub7" style="display:none;" class="submenu">
              <cfif getpin2.h2850 eq 'T'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=sam" target="mainFrame" title="<cfoutput>#menutitle[157]#</cfoutput>">
                  <cfif getGeneralInfo.dflanguage eq 'english'>
                    #getGeneralInfo.lSAM#
                    <cfelse>
                    <cfoutput>#menutitle[157]#</cfoutput>
                  </cfif>
                  </a> </li>
              </cfif>
              <cfif getmodule.repairtran eq '1'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/repairservice/s_repairservicetable.cfm" target="mainFrame" title="<cfoutput>Repair Service</cfoutput>"> <cfoutput>Repair Service</cfoutput> </a> </li>
              </cfif>
              <cfif lcase(hcomid) neq "excelsnm_i">
                <cfif getpin2.h2890 eq 'T'>
                  <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/copy.cfm" target="mainFrame" title="<cfoutput>#menutitle[164]#</cfoutput>"> <cfoutput>#menutitle[164]#</cfoutput> </a> </li>
                </cfif>
              </cfif>
              <cfif getpin2.h28C0 eq 'T'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/writeoff.cfm?tran=po" target="mainFrame" title="<cfoutput>#menutitle[159]#</cfoutput>"> <cfoutput>#menutitle[159]#</cfoutput> </a> </li>
              </cfif>
              <cfif getpin2.h28D0 eq 'T'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/writeoff.cfm?tran=so" target="mainFrame" title="<cfoutput>#menutitle[160]#</cfoutput>"> <cfoutput>#menutitle[160]#</cfoutput> </a> </li>
              </cfif>
              <cfif getpin2.h28B0 eq 'T'>
                <li onClick="SwitchMenu2('sub9')"><a class="oe_secondary_menu_item2" style="cursor:pointer" title="<cfoutput>#menutitle[161]#</cfoutput>"><cfoutput>#menutitle[161]#</cfoutput></a></li>
                <span id="sub9" style="display:none;" class="submenu2">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/historicalrecords/historicalform.cfm?historical=ViewBatchSummary" target="mainFrame" title="<cfoutput>#menutitle[408]#</cfoutput>"> <cfoutput>#menutitle[408]#</cfoutput> </a> </li>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/historicalrecords/historicalform.cfm?historical=ListHistoricalBills" target="mainFrame" title="<cfoutput>#menutitle[409]#</cfoutput>"> <cfoutput>#menutitle[409]#</cfoutput> </a> </li>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/historicalrecords/historicalform.cfm?historical=ListHistoricalPrice" target="mainFrame" title="<cfoutput>#menutitle[410]#</cfoutput>"> <cfoutput>#menutitle[410]#</cfoutput> </a> </li>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/HistoricalRecords/historicalrecords.cfm?historical=ListHistoricalBillsOrder" target="mainFrame" title="<cfoutput>#menutitle[162]#</cfoutput>"> <cfoutput>#menutitle[162]#</cfoutput> </a> </li>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/HistoricalRecords/historicalrecords.cfm?historical=ListHistoricalItemsOrder" target="mainFrame" title="<cfoutput>#menutitle[172]#</cfoutput>"> <cfoutput>#menutitle[172]#</cfoutput> </a> </li>
                </span>
              </cfif>
              </span>
            </cfif>
            <cfif getpin2.h2900 eq "T">
              <li onClick="SwitchMenu('sub12')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[50]#</cfoutput>"><cfoutput>#menutitle[50]#</cfoutput></a></li>
              <span id="sub12" style="display:none;" class="submenu">
              <cfif getpin2.h2901 eq 'T'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/generateupdate/distribute_miscellaneous_charges_into_cost.cfm" target="mainFrame" title="<cfoutput>#menutitle[168]#</cfoutput>"> <cfoutput>#menutitle[168]#</cfoutput> </a> </li>
              </cfif>
              <cfif getpin2.h2902 eq 'T'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/generateupdate/generate_full_payment_date.cfm" target="mainFrame" title="<cfoutput>#menutitle[169]#</cfoutput>"> <cfoutput>#menutitle[169]#</cfoutput> </a> </li>
              </cfif>
              <cfif getpin2.h2903 eq 'T'>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/generateupdate/generate_customer_outstanding_balance.cfm" target="mainFrame" title="<cfoutput>#menutitle[170]#</cfoutput>"> <cfoutput>#menutitle[170]#</cfoutput> </a> </li>
              </cfif>
              </span>
            </cfif>
            <cfif getpin2.h2A00 eq "T">
              <li onClick="SwitchMenu('sub10')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[171]#</cfoutput>"><cfoutput>#menutitle[171]#</cfoutput></a></li>
              <span id="sub10" style="display:none;" class="submenu">
              <li> <a class="oe_secondary_submenu_item" href="/#HDir#/eInvoicing/eInvoice.cfm" target="mainFrame" title="<cfoutput>#menutitle[173]#</cfoutput>"> <cfoutput>#menutitle[173]#</cfoutput> </a> </li>
              <li> <a class="oe_secondary_submenu_item" href="/#HDir#/eInvoicing/eInvoicelog.cfm" target="mainFrame" title="<cfoutput>#menutitle[174]#</cfoutput>"> <cfoutput>#menutitle[174]#</cfoutput> </a> </li>
              </span>
            </cfif>
            <cfif lcase(hcomid) eq "ubs_i" or lcase(hcomid) eq "net_i" or lcase(hcomid) eq "imk_i" or lcase(hcomid) eq "netm_i" or lcase(hcomid) eq "netsm_i">
              <cfif husergrpid eq 'super' or husergrpid eq 'admin' or husergrpid eq 'general' or husergrpid eq 'support' or husergrpid eq 'gusers'>
                <li onClick="SwitchMenu('sub13')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="CRM">CRM</a></li>
                <span id="sub13" style="display:none;" class="submenu">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/crm/createjob.cfm" target="mainFrame" title="Create Jobsheet"> Create Jobsheet </a> </li>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/crm/viewjob.cfm" target="mainFrame" title="View Jobsheet"> View Jobsheet </a> </li>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/crm/customerhistory.cfm" target="mainFrame" title="View Customer History"> View Customer History </a> </li>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/crm/viewschedule.cfm" target="mainFrame" title="View Schedule"> View Schedule </a> </li>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/crm/rptexpire.cfm" target="mainFrame" title="View Expire Contract"> View Expire Contract </a> </li>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/crm/chkcntct.cfm" target="mainFrame" title="Check Contract"> Check Contract </a> </li>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/crm/cust_maintenance/index.cfm" target="mainFrame" title="Customer Account"> Customer Account </a> </li>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/crm/updatecntct.cfm" target="mainFrame" title=""> Update Contract </a> </li>
                </span>
              </cfif>
            </cfif>
            <cfif getpin2.h2B00 eq 'T' or getpin2.h2C00 eq 'T' or getpin2.h2H00 eq 'T'>
              <li onClick="SwitchMenu('sub11')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[411]#</cfoutput>"><cfoutput>#menutitle[411]#</cfoutput></a></li>
              <span id="sub11" style="display:none;" class="submenu">
              <cfif getpin2.h2B00 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/packinglist/listPackingMain.cfm" target="mainFrame" title="<cfoutput>#menutitle[51]#</cfoutput>"> <cfoutput>#menutitle[51]#</cfoutput> </a> </li>
              </cfif>
              <cfif getpin2.h2C00 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/newbody2.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/recurringtran/')" title="<cfoutput>#menutitle[52]#</cfoutput>"> <cfoutput>#menutitle[52]#</cfoutput> </a> </li>
              </cfif>
              <cfif getpin2.h2H00 eq "T">
                <li> <a class="oe_secondary_submenu_item" href="/newbody2.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/expressbill/')" title="<cfoutput>#menutitle[53]#</cfoutput>"> <cfoutput>#menutitle[53]#</cfoutput> </a> </li>
                <cfif lcase(HcomID) eq "demo_i">
                  <li> <a class="oe_secondary_submenu_item" href="/newbody2.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/expressbill2/')" title="<cfoutput>#menutitle[54]#</cfoutput>"> <cfoutput>#menutitle[54]#</cfoutput> </a> </li>
                </cfif>
                <cfif lcase(HcomID) eq "ovas_i">
                  <li> <a class="oe_secondary_submenu_item" href="/newbody2.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/ovasexpressbill/')" title="<cfoutput>#menutitle[175]#</cfoutput>"> <cfoutput>#menutitle[175]#</cfoutput> </a> </li>
                </cfif>
                <cfif lcase(HcomID) eq "verjas_i" or lcase(HcomID) eq "augment_i">
                  <li> <a class="oe_secondary_submenu_item" href="/newbody2.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/verjasexpressbill/')" title="<cfif lcase(HcomID) eq "augment_i"><cfoutput>#menutitle[176]#</cfoutput>
                <cfelse><cfoutput>#menutitle[177]#</cfoutput></cfif>">
                    <cfif lcase(HcomID) eq "augment_i">
                      <cfoutput>#menutitle[176]#</cfoutput>
                      <cfelse>
                      <cfoutput>#menutitle[177]#</cfoutput>
                    </cfif>
                    </a> </li>
                </cfif>
                <cfif lcase(HcomID) eq "supervalu_i">
                  <li> <a class="oe_secondary_submenu_item" href="/newbody2.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/verjasexpressbill/')" title="<cfoutput>#menutitle[178]#</cfoutput>"> <cfoutput>#menutitle[178]#</cfoutput> </a> </li>
                </cfif>
                <cfif getmodule.postran eq '1'>
                  <li> <a class="oe_secondary_submenu_item" href="/newbody2.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/POS/index.cfm?first=true')" title="<cfoutput>#menutitle[55]#</cfoutput>"> <cfoutput>#menutitle[55]#</cfoutput> </a> </li>
                  <li> <a class="oe_secondary_submenu_item" href="/default/admin/possync" target="mainFrame" title="<cfoutput>#menutitle[179]#</cfoutput>" > <cfoutput>#menutitle[179]#</cfoutput></a> </li>
                </cfif>
                <li> <a class="oe_secondary_submenu_item" href="/#HDir#/transaction/itemcombine" target="mainFrame" title="<cfoutput>#menutitle[56]#</cfoutput>"> <cfoutput>#menutitle[56]#</cfoutput> </a> </li>
                <li> <a class="oe_secondary_submenu_item" href="/default/POS/listpos.cfm" target="mainFrame" title="<cfoutput>#menutitle[57]#</cfoutput>"> <cfoutput>#menutitle[57]#</cfoutput> </a> </li>
                <cfif lcase(hcomid) eq "demo_i">
                  <li> <a class="oe_secondary_submenu_item" href="/sixcapital" target="mainFrame" title="<cfoutput>#menutitle[58]#</cfoutput>"> <cfoutput>#menutitle[58]#</cfoutput> </a> </li>
                </cfif>
               
                <cfif huserid eq "ultralung">
                  <li> <a class="oe_secondary_submenu_item" href="/default/transaction/polypetPOS/" target="mainFrame" title="<cfoutput>Polypet POS</cfoutput>"> <cfoutput>Polypet POS</cfoutput> </a> </li>
                </cfif>
              </cfif>
               <cfif lcase(hcomid) eq "skopl_i" or lcase(hcomid) eq "demo_i" or  ucase(hcomid) eq "APNT_I" or  ucase(hcomid) eq "IDEAKONZEPTE_I"  or  ucase(hcomid) eq "LHXK_I"  or  ucase(hcomid) eq "EOCEAN_I"  or  ucase(hcomid) eq "NETSOURCE_I"  or  lcase(hcomid) eq "snnpl_i">
                  <li> <a class="oe_secondary_submenu_item" href="/tradeXchange/tradeXchange.cfm" target="mainFrame" title="<cfoutput>TradeXchange</cfoutput>"> <cfoutput>TradeXchange DOCX</cfoutput> </a> </li>
                </cfif>
              </span>
            </cfif>
          </cfif>
        </cfif>
        
        <cfinclude template="/menunew2/chat.cfm">
        <a class="oe_secondary_submenu_item" href="https://www.teamviewer.com/link/?url=505374&id=625664214" style="text-decoration:none; text-align:left"> <img src="https://www.teamviewer.com/link/?url=979936&id=625664214" alt="TeamViewer for Remote Support" title="TeamViewer for Remote Support" border="0" width="130" height="50"> </a> <a class="oe_secondary_submenu_item" href="https://showmypc.com/ShowMyPC3150.exe" style="text-decoration:none; text-align:left"> <img src="https://showmypc.com/images/home/remote-support-logo2521.jpg" alt="ShowMyPc for Remote Support" title="Show My Pc for Remote Support" border="0" width="130" height="50"></a> </div>
    </div>
  </div>
</cfoutput>
</body>
</html>