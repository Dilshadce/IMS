<!--- START: Kastam Diraja Malaysia Required Fields --->
<cfquery name="getGSTsummary" datasource="#dts#">
	SELECT note_a,taxpec1,
       ROUND(SUM(if(taxincl = 'T',amt-taxamt,amt)),2) AS sumAmt,
       ROUND(SUM(taxamt),2) AS taxAmt
    FROM ictran 
    WHERE type = '#trim(getHeaderInfo.type)#'
    AND	refno = '#trim(getHeaderInfo.refno)#'
    GROUP BY note_a;
</cfquery>

<cfif getCustAdd.GSTno EQ '' >
	<cfquery name="getCustSuppGSTinfo" datasource="#dts#">
		SELECT gstno 
		FROM #ptype#
		WHERE custno = "#getheaderinfo.custno#";
	</cfquery>    
	<cfif getCustAdd.GSTno EQ ''>
		<cfset getCustAdd.GSTno = getCustSuppGSTinfo.gstno>
	</cfif> 
</cfif>

<cfif  getDeliveryAdd.GSTno EQ ''>
	<cfquery name="getCustSuppGSTinfo" datasource="#dts#">
		SELECT gstno 
		FROM #ptype#
		WHERE custno = "#getheaderinfo.custno#";
	</cfquery>    
	<cfif getDeliveryAdd.GSTno EQ ''>
		<cfset getDeliveryAdd.GSTno = ''>
	</cfif>   
	  
</cfif>

 


<!--- END: Kastam Diraja Malaysia Required Fields --->

<!---START: For tax included bills--->
<cfquery name="getIctranTax" datasource="#dts#">
    SELECT taxincl
    FROM ictran
    WHERE type = <cfif getheaderinfo.type eq "TR">'TROU'<cfelse>'#getHeaderInfo.type#'</cfif>
    AND	refno = '#getHeaderInfo.refno#'
    AND taxincl = "T";
</cfquery>

<cfif getHeaderInfo.taxincl EQ "T" OR getIctranTax.recordCount NEQ 0>
    <cfset getHeaderInfo.gross_bil = getHeaderInfo.disc_bil + getHeaderInfo.net_bil>
    <cfset getHeaderInfo.invgross = getHeaderInfo.discount + getHeaderInfo.net>
</cfif>
<!---END: For tax included bills--->

<cfquery name="InsertICBil_M" datasource="#dts#">
	INSERT INTO r_icbil_m ( B_Name, B_Name2, B_Add1, B_Add2, B_Add3, B_Add4, B_Country, B_PostalCode, B_Attn, B_Tel, B_HP, B_Fax, B_Email, B_GSTno,
							D_Name, D_Name2, D_Add1, D_Add2, D_Add3, D_Add4, D_Country, D_PostalCode, D_Attn, D_Tel, D_HP, D_Fax, D_Email, D_GSTno,
							CustNo, RefNo, RefNo2, PONO, DONO, QUONO, SONO, Terms, TermDesp, Date,
							Agent, AgentDesp, AgentHP, Project, Job, 
							Rem0, Rem1, Rem2, Rem3, Rem4, Rem5, Rem6, Rem7, Rem8, Rem9, Rem10, Rem11, Rem12,
							Disp1, Disp2, Disp3, Discount, Disamt_Bil, Taxp1, Tax, Taxamt_Bil,
							Deposit, InvGross, Gross_Bil, Net, Net_Bil, Total, Total_Bil, RoundingAdj,
							CurrCode, CurrSymbol, CurrRate,
							UserName, EndUser, TermsCondition,
							GSTcode, GSTtaxPercentage, GSTamt, GSTtaxAmt)
	VALUES (
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustAdd.name#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustAdd.name2#">,
				<cfloop index='i' from='1' to='4'>
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('getCustAdd.add#i#')#">,
				</cfloop>
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustAdd.country#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustAdd.postalcode#">,                    
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustAdd.attn#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustAdd.phone#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustAdd.phonea#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustAdd.fax#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustAdd.e_mail#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustAdd.GSTno#">,
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDeliveryAdd.name#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDeliveryAdd.name2#">,
				<cfloop index='i' from='1' to='4'>
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('getDeliveryAdd.add#i#')#">,
				</cfloop>
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDeliveryAdd.country#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDeliveryAdd.postalcode#">,      
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDeliveryAdd.attn#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDeliveryAdd.phone#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDeliveryAdd.phonea#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDeliveryAdd.fax#">,   
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDeliveryAdd.d_email#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDeliveryAdd.GSTno#">,
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.custno#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.refno#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.refno2#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.pono#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.dono#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.quono#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.sono#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.term#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.termDesp#">,
				<cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(getHeaderInfo.wos_date,'YYYY-MM-DD')#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.agentNo#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.agentDesp#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.agentHP#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.project#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.job#">,  
								  
				<cfloop index='i' from='0' to='12'>
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('getHeaderInfo.rem#i#')#">,
				</cfloop>
				
				<cfloop index='i' from='1' to='3'>
					<cfqueryparam cfsqltype="cf_sql_double" value="#val(evaluate('getHeaderInfo.disp#i#'))#">,
				</cfloop>
				<cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.discount)#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.disc_bil)#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.taxp1)#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.tax)#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.tax_bil)#">,
				
				<cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.deposit)#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.invgross)#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.gross_bil)#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.net)#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.net_bil)#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.grand)#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.grand_bil)#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.roundadj)#">,
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.currencyCode#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.currencySymbol#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.currrate)#">,
				
				<cfif getHeaderInfo.username NEQ ''>
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.username#">,
				<cfelse>
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getUserName.username#">,
				</cfif>
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.driverName#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#toString(getHeaderInfo.termsCondition)#">,	
				
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#ValueList(getGSTsummary.note_a)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#ValueList(getGSTsummary.taxpec1)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#ValueList(getGSTsummary.sumAmt)#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#ValueList(getGSTsummary.taxAmt)#">
			)
</cfquery>