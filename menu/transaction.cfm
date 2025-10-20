<cfif getpin2.h2000 eq "T">
	<div class="menutitle" onClick="SwitchMenu('sub2')">Transaction</div>
</cfif>

<cfquery name="getGeneralInfo" datasource="#dts#">
	select * 
	from gsetup;
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
	select * 
	from modulecontrol;
</cfquery>

<span class="submenu" id="sub2">
<cfoutput>
<!--- 	<cfif left(lcase(HcomID),4) eq "beps">
    	<li>
			<a href="/#HDir#/transaction/assignmentslip/s_assignmentsliptable.cfm" target="mainFrame">
				Assignment Slip
			</a>
		</li>
    </cfif> --->
    <cfif left(lcase(HcomID),4) eq "beps">
    	<li>
			<a href="/#HDir#/transaction/assignmentslipnewnew/s_assignmentsliptable.cfm" target="mainFrame">
				Assignment Slip
			</a>
		</li>
    </cfif>
     <cfif left(lcase(HcomID),4) eq "beps">
    	<li>
			<a href="/#HDir#/transaction/biginvoice/index.cfm" target="mainFrame">
				Big Invoice
			</a>
		</li>
    </cfif>
<!---      <cfif hcomid eq "bepstest_i" or getauthuser() eq "ultracai">
    	<li>
			<a href="/#HDir#/transaction/assignmentslipnewnew/s_assignmentsliptable.cfm" target="mainFrame">
				Assignment Slip SUPER NEW
			</a>
		</li>
    </cfif> --->
    <cfif lcase(HcomID) eq "simplysiti_i">
    <cfif getpin2.h2500 eq "T">
    	<li>
			<a href="/#HDir#/transaction/simplysitiimportexcel/import_excel.cfm" target="mainFrame">
				Import Sales From Outlet
			</a>
		</li>
        <li>
			<a href="/#HDir#/transaction/simplysitiimportexcel/simplysitigeneratetransfer.cfm" target="mainFrame">
				Generate Transfer
			</a>
		</li>
    </cfif>
    </cfif>
	<cfif lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i">	<!--- Modified on 29-12-2009 --->
		<cfif getpin2.h2860 eq 'T'>
			<li>
				<a href="/#HDir#/transaction/transaction.cfm?tran=po" target="mainFrame">
					#getGeneralInfo.lPO#
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2100 eq "T">
			<li>
				<a href="/#HDir#/transaction/transaction.cfm?tran=rc" target="mainFrame">
					#getGeneralInfo.lRC#
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2870 eq "T">
			<li>
				<a href="/#HDir#/transaction/transaction.cfm?tran=quo" target="mainFrame">
					#getGeneralInfo.lQUO#
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2880 eq "T">
			<li>
				<a href="/#HDir#/transaction/transaction.cfm?tran=so" target="mainFrame">
					#getGeneralInfo.lSO#
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2300 eq "T">
			<li>
				<a href="/#HDir#/transaction/transaction.cfm?tran=do" target="mainFrame">
					#getGeneralInfo.lDO#
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2400 eq "T">
			<li>
				<a href="/#HDir#/transaction/transaction.cfm?tran=inv" target="mainFrame">
					#getGeneralInfo.lINV#
				</a>
			</li>
		</cfif>
		<cfif getpin2.h2500 eq "T">
			<li>
				<a href="/#HDir#/transaction/transaction.cfm?tran=cs" target="mainFrame">
					#getGeneralInfo.lCS#
				</a>
			</li>
		</cfif>

		<cfif getpin2.h2800 eq "T">
			<li>
				<a href="/#HDir#/transaction/otransaction.cfm" target="mainFrame">
					Other Transaction
				</a>
			</li>
		</cfif>
	  	<cfif getpin2.h2900 eq "T">
			<li>
				<a href="/#HDir#/transaction/generateupdate/generateupdatemenu.cfm" target="mainFrame">
					Generate/Update
				</a>
			</li>
		</cfif>
        <cfif getpin2.h2A00 eq "T">
		<li>
			<a href="/#HDir#/eInvoicing/eInvoicemenu.cfm" target="mainFrame">
				E-Invoicing
			</a>
		</li>
	</cfif>
	<cfelse>
		<cfif getpin2.h2100 eq "T">
			<li>
            <cfif lcase(HcomID) eq "supervalu_i">
				<a href="/#HDir#/transaction/stransaction.cfm?tran=rc" target="mainFrame">
					#getGeneralInfo.lRC#
				</a>
            <cfelse>
            	<a href="/#HDir#/transaction/transaction.cfm?tran=rc" target="mainFrame">
					#getGeneralInfo.lRC#
				</a>
            </cfif>
			</li>
		</cfif>
		<cfif getpin2.h2200 eq "T">
			<li>
            <cfif lcase(HcomID) eq "supervalu_i">
				<a href="/#HDir#/transaction/stransaction.cfm?tran=pr" target="mainFrame">
					#getGeneralInfo.lPR#
				</a>
            <cfelse>
				<a href="/#HDir#/transaction/transaction.cfm?tran=pr" target="mainFrame">
					#getGeneralInfo.lPR#
				</a>
            </cfif>
			</li>
		</cfif>
		<cfif getpin2.h2300 eq "T">
			<li>
            <cfif lcase(HcomID) eq "supervalu_i">
				<a href="/#HDir#/transaction/stransaction.cfm?tran=do" target="mainFrame">
					#getGeneralInfo.lDO#
				</a>
            <cfelse>
				<a href="/#HDir#/transaction/transaction.cfm?tran=do" target="mainFrame">
					#getGeneralInfo.lDO#
				</a>
            </cfif>
			</li>
		</cfif>
		<cfif getpin2.h2400 eq "T">
			<li>
            <cfif lcase(HcomID) eq "supervalu_i">
				<a href="/#HDir#/transaction/stransaction.cfm?tran=inv" target="mainFrame">
					#getGeneralInfo.lINV#
				</a>
            <cfelse>
				<a href="/#HDir#/transaction/transaction.cfm?tran=inv" target="mainFrame">
					#getGeneralInfo.lINV#
				</a>
                </cfif>
			</li>
            
		</cfif>
		<cfif getpin2.h2500 eq "T">
			<li>
            <cfif lcase(HcomID) eq "supervalu_i">
				<a href="/#HDir#/transaction/stransaction.cfm?tran=cs" target="mainFrame">
					#getGeneralInfo.lCS#
				</a>
            <cfelse>
				<a href="/#HDir#/transaction/transaction.cfm?tran=cs" target="mainFrame">
					#getGeneralInfo.lCS#
				</a>
            </cfif>
			</li>
		</cfif>
		<cfif getpin2.h2600 eq "T">
			<li>
            <cfif lcase(HcomID) eq "supervalu_i">
				<a href="/#HDir#/transaction/stransaction.cfm?tran=cn" target="mainFrame">
					#getGeneralInfo.lCN#
				</a>
            <cfelse>
				<a href="/#HDir#/transaction/transaction.cfm?tran=cn" target="mainFrame">
					#getGeneralInfo.lCN#
				</a>
            </cfif>
			</li>
		</cfif>	
		<cfif getpin2.h2700 eq "T">
			<li>
            <cfif lcase(HcomID) eq "supervalu_i">
				<a href="/#HDir#/transaction/stransaction.cfm?tran=dn" target="mainFrame">
					#getGeneralInfo.lDN#
				</a>
            <cfelse>
				<a href="/#HDir#/transaction/transaction.cfm?tran=dn" target="mainFrame">
					#getGeneralInfo.lDN#
				</a>
            </cfif>
			</li>
		</cfif>
        
		<cfif getpin2.h2800 eq "T">
			<li>
				<a href="/#HDir#/transaction/otransaction.cfm" target="mainFrame">
					Other Transaction
				</a>
			</li>
		</cfif>
        <cfif getmodule.auto eq "1">
        	<li>
				<a href="/#HDir#/transaction/deposit/deposittable.cfm" target="mainFrame">
					Deposit
				</a>
			</li>
        </cfif>
	  	<cfif getpin2.h2900 eq "T">
			<li>
				<a href="/#HDir#/transaction/generateupdate/generateupdatemenu.cfm" target="mainFrame">
					Generate/Update
				</a>
			</li>
		</cfif>
        <cfif getpin2.h2A00 eq "T">
		<li>
			<a href="/#HDir#/eInvoicing/eInvoicemenu.cfm" target="mainFrame">
				E-Invoicing
			</a>
		</li>
	</cfif>
    <cfif getpin2.h2B00 eq "T">
		<li>
			<a href="/#HDir#/transaction/packinglist/listPackingMain.cfm" target="mainFrame">
				Packing List
			</a>
		</li>
	</cfif>
    <cfif getpin2.h2C00 eq "T">
		<li>
			<a href="/newbody.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/recurringtran/')">
				Recurring Transaction
			</a>
		</li>
        </cfif>
      <cfif getpin2.h2H00 eq "T">
      	<cfif lcase(HcomID) eq "ovas_i">
          <li>
			<a href="/newbody.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/ovasexpressbill/')">
				Ovas Express Bill
			</a>
		</li>
        <cfelse>
         <li>
			<a href="/newbody.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/expressbill/')">
				Express Bill
			</a>
		</li>
        </cfif>
        <cfif lcase(HcomID) eq "demo_i">
          <li>
			<a href="/newbody.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/expressbill2/')">
				Express Bill 2
			</a>
		</li>
        </cfif>
         
        
        <cfif lcase(HcomID) eq "verjas_i" or lcase(HcomID) eq "augment_i">
          <li>
			<a href="/newbody.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/verjasexpressbill/')">
				<cfif lcase(HcomID) eq "augment_i">Matrix<cfelse>Verjas</cfif> Express Bill
			</a>
		</li>
        </cfif>
        <cfif lcase(HcomID) eq "supervalu_i">
          <li>
			<a href="/newbody.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/verjasexpressbill/')">
				Supervalu Express Bill
			</a>
		</li>
        </cfif>
        <cfif getmodule.postran eq '1'>
          <li>
			<a href="/newbody.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/POS/index.cfm?first=true')">
				POS Transaction
			</a>            
		</li>
		<!---
        <li>
        <a href="/default/admin/possync" target="mainFrame" >POS Sync</a>
        </li>--->
        </cfif>
        
<!---         <li>
			<a href="/newbody.cfm" target="mainFrame" onclick="popup('/#HDir#/transaction/expressbill/')">
				Express Bill
			</a>
		</li> --->
	
		<li>
			<a href="/#HDir#/transaction/itemcombine" target="mainFrame">
				Bill Item Combine
			</a>
		</li>
        <li>
			<a href="/default/POS/listpos.cfm" target="mainFrame">
				POS
			</a>
		</li>
        <cfif lcase(hcomid) eq "demo_i">
         <li>
			<a href="/sixcapital" target="mainFrame">
				Six Capital Demo
			</a>
		</li>
        </cfif>
        
	</cfif>
	</cfif>
    
    <cfif lcase(hcomid) eq "skopl_i" or lcase(hcomid) eq "demo_i" or  lcase(hcomid) eq "APNT_i" or  lcase(hcomid) eq "IDEAKONZEPTE_i"  or  lcase(hcomid) eq "demo_i"  or  lcase(hcomid) eq "demo_i"  or  lcase(hcomid) eq "demo_i">
         <li>
			<a class="oe_secondary_submenu_item" href="/tradeXchange/tradeXchange.cfm" target="mainFrame" title="<cfoutput>TradeXchange</cfoutput>">
				<cfoutput>TradeXchange DOCX</cfoutput>
			</a>
		</li>
        
        </cfif>
</cfoutput>

<!--- SPECIAL TRANSACTION FUNTION--->
<cfinclude template = "transaction_special.cfm">
<!--- SPECIAL TRANSACTION FUNTION--->
</span>