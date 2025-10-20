<cfoutput>
<cfif getpin2.h5000 eq "T"><div class="menutitle" onClick="SwitchMenu('sub5')">General Setup</div></cfif>

<span class="submenu" id="sub5">
	<cfif getpin2.h5100 eq "T">
		<li>
			<a href="/#HDir#/admin/general.cfm" target="mainFrame">
				General Information Setup
			</a>
		</li>
	</cfif>
	<cfif getpin2.h5300 eq "T">
		<li>
			<a href="/#HDir#/admin/vuser.cfm" target="mainFrame">
				User Administration
			</a>
		</li>
	</cfif>
	<cfif getpin2.h5500 eq "T">
		<li>
			<!---a href="/#HDir#/admin/userdefinedmenu.cfm" target="mainFrame">
				User Defined Menu
			</a--->
			<a href="/#HDir#/admin/userdefinedmenu/usergroup.cfm" target="mainFrame">
				User Defined Menu
			</a>
		</li>
	</cfif>
    <cfif getpin2.h5300 eq "T">
		<li>
			<a href="/changepass/index.cfm" target="mainFrame">
				Change Password
			</a>
		</li>
	</cfif>
    <cfif getpin2.h5140 eq "T">
    	<li>
			<a href="/stockbatches/stockbatches.cfm" target="mainFrame">
				Stock Batches
			</a>
		</li>
    </cfif>
	<cfif getpin2.h5400 eq "T">
		<li>
			<a href="/#HDir#/currency/vcurrency.cfm" target="mainFrame">
				Currency Table
			</a>
		</li>
		<li>
			<a href="/#HDir#/admin/tax/tax.cfm" target="mainFrame">
				Tax Table
			</a>
		</li>
	</cfif>
	<cfif getpin2.h5600 eq "T">
		<li>
			<a href="/#HDir#/admin/posting2/postingacc.cfm?status=UNPOSTED" target="mainFrame">
				Posting To <cfif Hlinkams eq "Y">AMS<cfelse>UBS</cfif>
			</a>
		</li>
        <cfif hcomid eq "hairo_i" or hcomid eq "net_i" or hcomid eq "demo_i" or hcomid eq "freshways_i">
        <li>
			<a href="/#HDir#/admin/posting2/postingacc.cfm?status=UNPOSTED&ubs=yes" target="mainFrame">
				Export To UBS
			</a>
		</li>
        </cfif>
        <li>
			<a href="/#HDir#/admin/postingcontrol/armcancel.cfm" target="mainFrame">
				Posting Control
			</a>
		</li>	
	</cfif>	
	<cfif getpin2.h5200 eq "T" and (husergrpid eq "super" or hcomid eq 'aepl_i' or hcomid eq 'aeisb_i' or hcomid eq 'colorinc_i')>
		<li>
			<a href="/#HDir#/admin/yearend.cfm" target="mainFrame">
				Year-End Processing
			</a>
		</li>
        <li>
			<a href="/super_menu/fifo_costing_recalculate.cfm" target="mainFrame">
				FIFO Costing Calculation After Year-End
			</a>
		</li>
		<li>
			<a href="/super_menu/recalculatelocationqty.cfm" target="mainFrame">
				Location QtyBf Calculation After Year-End
			</a>
		</li>
       <li>
			<a href="/super_menu/calculate_gradeqty.cfm" target="mainFrame">
				Grade QtyBf Calculation After Year-End
			</a>
		</li>
        
        
	</cfif>
	<cfif getpin2.H5800 eq "T">
		<li>
			<a href="/#HDir#/admin/viewaudit_trail.cfm" target="mainFrame">
				View Audit Trail
			</a>
		</li>
        <li>
			<a href="/#HDir#/admin/lastusednoaudit_trail.cfm" target="mainFrame">
				View Last Used No Audit Trail
			</a>
		</li>
		<li>
			<a href="/#HDir#/admin/viewaudit_trail_custsuppitem.cfm" target="mainFrame">
				View Audit Trail II
			</a>
		</li>
        <li>
			<a href="/#HDir#/admin/viewaudit_bossmenu.cfm" target="mainFrame">
				View Boss Menu Audit Trail
			</a>
		</li>
	</cfif>
    <cfif husergrpid eq "admin" or husergrpid eq "super" >
    <li>
			<a href="/super_menu/addbillformat.cfm" target="mainFrame">
				Add .CFR Bills
			</a>
		</li>
    </cfif>
    <cfif husergrpid eq "super" or husergrpid eq "admin">
    <li>
			<a href="/#HDir#/admin/viewloginhistory.cfm" target="mainFrame">
				View Login History
			</a>
		</li>
    </cfif>
    <cfif getpin2.h5D00 eq "T" >
    	<li>
			<a href="/#HDir#/admin/importtable/import.cfm" target="mainFrame">
				Import CSV File to IMS
			</a>
		</li>
        </cfif>
        <cfif getpin2.h5E00 eq "T" >
		<li>
			<a href="/#HDir#/admin/importtable/import_excel.cfm" target="mainFrame">
				Import EXCEL File to IMS
			</a>
		</li>
        </cfif>
        <cfif getpin2.h5F00 eq "T" >
        <li>
       
			<a href="/#HDir#/admin/export_to_csv_list.cfm" target="mainFrame">
				Export To CSV File
			</a>
		</li>
        </cfif>
	<cfif husergrpid eq "super" or husergrpid eq "admin">
	
    	<li>
			<a href="/#HDir#/admin/logoutreport.cfm" target="mainFrame">
				Log in and out Report
			</a>
		</li>
        
	
    </cfif>
    <cfif husergrpid eq "super" or husergrpid eq "admin" or husergrpid eq "Accounts" or husergrpid eq "Accts Admin">
    <cfif lcase(HcomID) eq "kjcpl_i" or lcase(HcomID) eq "mlpl_i" or lcase(HcomID) eq "netivan_i"  or lcase(HcomID) eq "uniq_i">
        <li>
			<a href="/#HDir#/admin/export_to_csvtransfer_list.cfm" target="mainFrame">
				Export Transfer File to POS
			</a>
		</li>
	</cfif>
    </cfif>
	<cfif husergrpid eq "admin">
		<li>
			<a href="/super_menu/recalculateqty.cfm" target="mainFrame">
				Qin Qout Recalculate
			</a>
		</li>
    	<li>
			<a href="/super_menu/upload.cfm" target="mainFrame">
				Upload .CFR Bills
			</a>
		</li>
    </cfif>
    <cfif (lcase(HcomID) eq "thaipore_i" and findnocase("Priscillathaipore",HUserID)) or lcase(hcomid) eq "laihock_i">
		<li>
			<a href="/super_menu/changeitemno.cfm" target="mainFrame">
				Change Item No.
			</a>
		</li>
	</cfif>
<!--- 	<cfif Hlinkams eq "Y">
		<li>
			<a href="/#HDir#/admin/posting2/irasPosting.cfm" target="mainFrame">
				Iras Posting
			</a>
		</li>
	</cfif> --->
	<cfif getpin2.H5900 eq "T">
		<li>
			<a href="/#HDir#/admin/bossmenu/bossmenu.cfm" target="mainFrame">
				Boss Menu
			</a>
		</li>
    </cfif>
    <cfif getpin2.H5A00 eq "T">
        <li>
			<a href="/super_menu/updateproject.cfm" target="mainFrame">
				Update Transaction Project
			</a>
		</li>
    </cfif>
    <cfif getpin2.H5B00 eq "T">
        <li>
			<a href="/#HDir#/admin/sync/" target="mainFrame">
				Sync Agent, Area & Project
			</a>
		</li>
    </cfif>
    <cfif hcomid eq "aipl_i">
        <li>
			<a href="/#HDir#/admin/aiplsync/" target="mainFrame">
				AIPL Sync Item
			</a>
		</li>
        <li>
			<a href="/#HDir#/admin/aiplsync/syncgramas.cfm" target="mainFrame">
				AIPL Sync Item (Gramas)
			</a>
		</li>
        <li>
			<a href="/#HDir#/admin/aiplsync/syncbelco.cfm" target="mainFrame">
				AIPL Sync Item (Belco)
			</a>
		</li>
    </cfif>
    <cfif getpin2.H5C00 eq "T">
         <li>
			<a href="/#HDir#/admin/MonthlyBackup.cfm" target="mainFrame">
				Monthly Backup
			</a>
		</li>
	</cfif>
</span>
</cfoutput>