<cfif IsDefined("url.debug")>
	<cfabort>
</cfif>

<noscript>
	WARNING! Javascript has been disabled or is not supported in this browser.
    <br>Please enable Javascript in your browser.
</noscript>

<cffunction name="findCurrentSetInv" output="true">
	<cfargument name="input" type="query" required="yes">
	<cfargument name="refno" type="string" required="yes">
	<cfset prefixRefno=left(arguments.refno,3)>
	<cfif left(input.invno,3) eq prefixRefno>
		<cfreturn 1>
	<cfelseif left(input.invno_2,3) eq prefixRefno>
		<cfreturn 2>
	<cfelseif left(input.invno_3,3) eq prefixRefno>
		<cfreturn 3>
	<cfelseif left(input.invno_4,3) eq prefixRefno>
		<cfreturn 4>
	<cfelseif left(input.invno_5,3) eq prefixRefno>
		<cfreturn 5>
	<cfelse>
		<cfreturn 6>
	</cfif> 
</cffunction>

<cfset trancode="#lcase(tran)#no">
<cfset prefix="#lcase(tran)#code">
<cfset suffix="#lcase(tran)#no2">

<cfquery name="getGsetup" datasource="#dts#">
  	SELECT  invoneset,#prefix# AS prefix,#trancode#,#suffix# AS suffix,
			<cfif tran eq "INV">
            	<cfloop from="2" to="6" index="i">#prefix#_#i#,#trancode#_#i#,#suffix#_#i#,</cfloop>
            </cfif>
            compro,compro2,compro3,compro4,compro5,compro6,compro7,compro8,compro9,compro10,
            gstno,comuen,bcurr
            <cfloop from="5" to="11" index="i">,rem#i#</cfloop> 
    FROM gsetup; 
</cfquery>

<cfquery name="getGsetup2" datasource='#dts#'>
  	SELECT CONCAT(',.',REPEAT('_',Decl_Uprice)) AS Decl_Uprice,
    	   CONCAT(',.',REPEAT('_',Decl_Discount)) AS Decl_Discount,
           CONCAT(',.',REPEAT('_',Decl_TotalAmt)) AS Decl_TotalAmt 
    FROM gsetup2;
</cfquery>

<cfset tranPrefix=getGsetup.prefix>
<cfset tran_suffix=getGsetup.suffix>

<cfif tran eq "RC" or tran eq "PR" or tran eq "RQ" or tran eq "PO">
	<cfset ptype=target_apvend>
<cfelse>
	<cfset ptype=target_arcust>
</cfif>

<cfquery name="ClearICBil_M" datasource="#dts#">
    TRUNCATE r_IcBil_M
</cfquery>

<cfquery name="ClearICBil_S" datasource="#dts#">
  	TRUNCATE r_IcBil_S
</cfquery>


<!---Function: SELECT artran --->
<cfquery name="getHeaderInfo" datasource='#dts#' >
	SELECT 	a.type,a.custno,a.refno,a.refno2,a.wos_date,a.desp,a.despa,a.term,a.pono,a.dono,a.sono,a.quono,a.depositno,
            a.cs_pm_cash,a.cs_pm_cheq,a.cs_pm_crcd,a.cs_pm_crc2,a.cs_pm_tt,a.cs_pm_dbcd,a.cs_pm_vouc,a.cs_pm_cash,a.deposit,a.cs_pm_debt,
            a.taxincl,a.termscondition,
            a.rem0,a.rem1,a.rem2,a.rem3,a.rem4,a.rem5,a.rem6,a.rem7,a.rem8,a.rem9,a.rem10,a.rem11,a.rem12,a.rem13,a.rem14,
            a.rem30,a.rem31,a.rem32,a.rem33,a.rem34,a.rem35,a.rem36,a.rem37,a.rem38,a.rem39,
			a.rem40,a.rem41,a.rem42,a.rem43,a.rem44,a.rem45,a.rem46,a.rem47,a.rem48,a.rem49,
            a.frem0,a.frem1,a.frem2,a.frem3,a.frem4,a.frem5,a.frem6,a.country,a.postalcode,a.b_gstno,
            a.frem7,a.frem8,a.comm0,a.comm1,a.comm2,a.comm3,a.comm4,a.d_country,a.d_postalcode,a.d_gstno,
            a.mc1_bil,a.mc2_bil,a.mc3_bil,a.mc4_bil,a.mc5_bil,a.mc6_bil,a.mc7_bil,
            a.disp1,a.disp2,a.disp3,a.disc_bil,a.disc1_bil,a.disc2_bil,a.disc3_bil, 
            a.note,a.taxp1,a.tax,a.tax_bil,a.tax1_bil,a.tax2_bil,a.tax3_bil,a.discount,
            a.invgross,a.gross_bil,a.net,a.net_bil,a.grand,a.grand_bil,a.roundadj,a.currrate,a.checkno,
            a.phonea,a.d_phone2,a.e_mail,a.d_email,   
            a.name,a.userid,a.username,a.created_by, a.returnbillno, a.returndate, a.returnreason,
                    
            ag.agent AS agentNo, ag.desp AS agentDesp, ag.hp AS agentHP, ag.photo AS agentSignature,
            curr.currency AS currencySymbol,a.currcode AS currencyCode, 
            tr.term AS termCode,tr.desp AS termDesp,
            proj.source AS project, proj.project AS projectDesp,
            job.source AS job, job.project AS jobDesp,
            dr.driverno AS driverNo,dr.name AS driverName
	
	FROM artran a 
	LEFT JOIN #target_icagent# ag ON a.agenno = ag.agent
	LEFT JOIN #target_currency# curr ON a.currcode = curr.currcode
	LEFT JOIN #target_icterm# tr ON a.term = tr.term
    LEFT JOIN #target_project# proj ON a.source = proj.source
    LEFT JOIN #target_project# job ON a.job = proj.source
    LEFT JOIN driver dr ON a.van = dr.driverno
	
	WHERE a.type = '#tran#' 
    <cfif IsDefined('url.printBill')> 	
    	<!---Function: Print Bill filters --->
		<cfinclude template="/billformat/default/newDefault/MYR/customized/printAllBillsFilter.cfm">	
    	ORDER BY a.refno ; 
	<cfelseif IsDefined('url.nexttranno')> 
        AND a.refno = '#url.nexttranno#' 
    <cfelse> 
        AND a.refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">)
    </cfif>
</cfquery>

<cfquery name="getUserName" datasource="main">
	SELECT username 
    FROM users 
    WHERE userid = '#getHeaderInfo.userid#' 
    AND userdept = '#dts#'
</cfquery>


<cfif IsDefined('url.printBill')>
<cfelseif IsDefined('url.nexttranno')> 
	<cfquery name="updatePrinted" datasource="#dts#">
    	UPDATE artran 
        SET 
        	printed = 'Y' 
        WHERE refno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.nexttranno#" >
        AND type =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#" >
    </cfquery>
<cfelse>
    <cfquery name="updatePrinted" datasource="#dts#">
    	UPDATE artran 
        SET 
        	printed = 'Y' 
        WHERE refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">) 
        AND type =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#">
    </cfquery>
</cfif>
<cfset j = 1>
<cfset k = 0>

<cfloop query="getHeaderInfo">
 
 	<!---Function: SELECT address --->
	<cfinclude template="/billformat/default/newDefault/MYR/customized/selectAddress.cfm">   
	
	<cfif k neq 0>
		<cfquery name="update" datasource="#dts#">
			UPDATE r_icbil_s
			SET 
            	counter_2 = #k#
			WHERE No = #j-1#;
		</cfquery>
	</cfif>
	<cfset k = k+1>
    
	<!---Function: INSERT artran --->
	<!--- START: Kastam Diraja Malaysia Required Fields --->
	<cfquery name="getGSTsummary" datasource="#dts#">
		SELECT note_a,taxpec1,
		   ROUND(SUM(if(taxincl = 'T',amt-taxamt,amt)),2) AS sumAmt,
		   ROUND(SUM(taxamt),2) AS taxAmt
		FROM ictran 
		WHERE type = '#trim(getHeaderInfo.type)#'
		AND	refno = '#trim(getHeaderInfo.refno)#'
        AND (void = '' OR void IS NULL)
		GROUP BY note_a;
	</cfquery>

	<cfif getCustAdd.GSTno EQ '' >
		<cfquery name="getCustSuppGSTinfo" datasource="#dts#">
			SELECT gstno,arrem6,dept1,business
			FROM #ptype#
			WHERE custno = "#getheaderinfo.custno#";
		</cfquery>    
		<cfif getCustAdd.GSTno EQ ''>
			<cfset getCustAdd.GSTno = getCustSuppGSTinfo.gstno>
		</cfif> 
	</cfif>

	<cfif  getDeliveryAdd.GSTno EQ ''>
		<cfquery name="getCustSuppGSTinfo" datasource="#dts#">
			SELECT gstno,arrem6,dept1,business
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
        AND (void = '' OR void IS NULL)
		AND taxincl = "T";
	</cfquery>

	<cfif getHeaderInfo.taxincl EQ "T" OR getIctranTax.recordCount NEQ 0>
		<cfset getHeaderInfo.gross_bil = getHeaderInfo.disc_bil + getHeaderInfo.net_bil>
		<cfset getHeaderInfo.invgross = getHeaderInfo.discount + getHeaderInfo.net>
	</cfif>
    
   <cfset billdate = #DateFormat(getHeaderInfo.wos_date,'DD-MM-YYYY')#>
   <cfset due = ReReplaceNoCase(getHeaderInfo.term,"[^0-9]","","ALL")>
   <cfif due neq ''>
		<cfset enddate = #dateadd("d",#due#,"#billdate#")#>
   <cfelse>
		<cfset enddate = #dateadd("d",#getCustSuppGSTinfo.arrem6#,"#billdate#")#>
   </cfif>
	<!---END: For tax included bills--->
	<cfif IsDefined('url.printBill')>
    	<cfquery name="getassignment" datasource="#dts#">
            SELECT placementno FROM assignmentslip
            WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderinfo.rem40#">
        </cfquery>
    <cfelse>
        <cfquery name="getassignment" datasource="#dts#">
            SELECT placementno FROM assignmentslip
            WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(getHeaderinfo.rem40)#">
        </cfquery>
	</cfif>
    
<cfquery name="getplacement" datasource="#dts#">
	SELECT location,po_no,jobpostype,supervisor FROM placement
	WHERE placementno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.placementno#">
</cfquery>

<cfquery name="getentity" datasource="#dts#">
	SELECT invnogroup FROM bo_jobtypeinv
	WHERE officecode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.location#">
    AND jobtype = "#getplacement.jobpostype#"
</cfquery>

<cfquery name="getaddress" datasource="#dts#">
	SELECT * FROM invaddress
	WHERE invnogroup=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getentity.invnogroup#">
</cfquery>

	<cfquery name="InsertICBil_M" datasource="#dts#">
		INSERT INTO r_icbil_m ( B_Name, B_Name2, B_Add1, B_Add2, B_Add3, B_Add4, B_Country, B_PostalCode, B_Attn, B_Tel, B_HP, B_Fax, B_Email, B_GSTno,
								D_Name, D_Name2, D_Add1, D_Add2, D_Add3, D_Add4, D_Country, D_PostalCode, D_Attn, D_Tel, D_HP, D_Fax, D_Email, D_GSTno,
								CustNo, RefNo, RefNo2, PONO, DONO, QUONO, SONO, Terms, TermDesp, Date, rem30,
								Agent, AgentDesp, AgentHP, Project, Job, 
								Rem0, Rem1, Rem2, Rem3, Rem4, Rem5, Rem6, Rem7, Rem8, Rem9, Rem10, Rem11, Rem12,
								Disp1, Disp2, Disp3, Discount, Disamt_Bil, Taxp1, Tax, Taxamt_Bil,
								Deposit, InvGross, Gross_Bil, Net, Net_Bil, Total, Total_Bil, RoundingAdj,
								CurrCode, CurrSymbol, CurrRate,
								UserName, EndUser, TermsCondition,
								GSTcode, GSTtaxPercentage, GSTamt, GSTtaxAmt,dept,location,compro,<cfloop index="a" from="2" to="10">compro#a#,<cfif a eq 10><cfbreak></cfif></cfloop>
								gstno,comuen,bankname,bankaccno,reportto)
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
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.po_no#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.dono#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.quono#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.sono#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="Nett #getCustSuppGSTinfo.arrem6# days">
                    ,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.termDesp#">,
					<cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(getHeaderInfo.wos_date,'YYYY-MM-DD')#">,
                    <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(enddate,'YYYY-MM-DD')#">,
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
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#ValueList(getGSTsummary.taxAmt)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustSuppGSTinfo.business#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.location#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaddress.name#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaddress.add1#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaddress.add2#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaddress.add3#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaddress.add4#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaddress.add5#">,
                    '',
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaddress.phone#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaddress.fax#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaddress.website#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaddress.gstno#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaddress.comuen#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getaddress.bankname#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getaddress.bankaccno#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.supervisor#">
				)
	</cfquery>
	
    
	<cfif getHeaderInfo.type eq "INV">
	
	<cfquery name="getinvoicetype" datasource="#dts#">
		SELECT invoiceformat as invoicegrouping FROM #target_arcust# where custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.custno#">
	</cfquery>
	
	<cfif getinvoicetype.invoicegrouping eq "3" or getinvoicetype.invoicegrouping eq "9">
    
    <cfquery name="findsimilar" datasource="#dts#">
    SELECT custno FROM arcust
    WHERE name like '%3M%'
    </cfquery>
        
    <cfif find(getHeaderInfo.custno, valuelist(findsimilar.custno))>
    <cfquery name="getBodyInfo" datasource="#dts#">
    SELECT  a.refno,a.itemno,if(a.itemno<>'adminfee','Outsource Fee','Staffing Services') as desp,'' as despa,'' as comment,
            a.unit_bil,'0' as qty_bil,'0' as price_bil,sum(a.amt_bil) as amt_bil,a.dispec1,a.dispec2,a.dispec3,a.disamt_bil,
            a.taxpec1,a.taxpec2,a.taxpec3,a.taxamt_bil,a.note_a,
            '0' as price,sum(a.amt) as amt,a.unit,
            a.brem1,a.brem2,a.brem3,a.brem4,a.itemcount,
            a.qty1,a.qty2,a.qty3,a.qty4,a.qty5,a.qty6,a.qty7,
            a.title_desp,a.location,
            b.photo,a.type,a.trancode,a.nodisplay
            
            ,b.aitemno
            
    FROM ictran AS a
    LEFT JOIN icitem AS b ON a.itemno = b.itemno
    WHERE type = <cfif getheaderinfo.type eq "TR">
    			 	'TROU'
                 <cfelse>
                 	'#getHeaderInfo.type#'
                 </cfif>
    AND	refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.refno#">
    AND a.itemno <> "name"
	AND (a.void = '' or a.void is null)
	group by refno,a.itemno="adminfee"
    ORDER BY trancode;
	</cfquery>
    <cfelse>
	<cfquery name="getBodyInfo" datasource="#dts#">
    SELECT  a.refno,a.itemno,'Outsource Fee' as desp,'' as despa,'' as comment,
            a.unit_bil,'0' as qty_bil,'0' as price_bil,sum(a.amt_bil) as amt_bil,a.dispec1,a.dispec2,a.dispec3,a.disamt_bil,
            a.taxpec1,a.taxpec2,a.taxpec3,a.taxamt_bil,a.note_a,
            '0' as price,sum(a.amt) as amt,a.unit,
            a.brem1,a.brem2,a.brem3,a.brem4,a.itemcount,
            a.qty1,a.qty2,a.qty3,a.qty4,a.qty5,a.qty6,a.qty7,
            a.title_desp,a.location,
            b.photo,a.type,a.trancode,a.nodisplay
            
            ,b.aitemno
            
    FROM ictran AS a
    LEFT JOIN icitem AS b ON a.itemno = b.itemno
    WHERE type = <cfif getheaderinfo.type eq "TR">
    			 	'TROU'
                 <cfelse>
                 	'#getHeaderInfo.type#'
                 </cfif>
    AND	refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.refno#">
    AND a.itemno <> "name"
	AND (a.void = '' or a.void is null)
	group by refno
    ORDER BY trancode;
	</cfquery>
    </cfif>
	
	<cfelseif  getinvoicetype.invoicegrouping eq "6" or getinvoicetype.invoicegrouping eq "11">
	<cfquery name="getBodyInfo" datasource="#dts#">
    SELECT  a.refno,a.itemno,a.desp,a.despa,a.comment,
            a.unit_bil,0 as qty_bil,0 as price_bil,sum(a.amt_bil) as amt_bil,a.dispec1,a.dispec2,a.dispec3,a.disamt_bil,
            a.taxpec1,a.taxpec2,a.taxpec3,a.taxamt_bil,a.note_a,
            0 as price,sum(a.amt) as amt,a.unit,
            a.brem1,a.brem2,a.brem3,a.brem4,a.itemcount,
            a.qty1,a.qty2,a.qty3,a.qty4,a.qty5,a.qty6,a.qty7,
            a.title_desp,a.location,
            b.photo,a.type,a.trancode,a.nodisplay
            
            ,b.aitemno
            
    FROM ictran AS a
    LEFT JOIN icitem AS b ON a.itemno = b.itemno
    WHERE type = <cfif getheaderinfo.type eq "TR">
    			 	'TROU'
                 <cfelse>
                 	'#getHeaderInfo.type#'
                 </cfif>
    AND	refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.refno#">
    and a.itemno <> "name"
	and (a.void = '' or a.void is null)
	group by itemno
    ORDER BY trancode;
	</cfquery>
	
	<cfelseif getinvoicetype.invoicegrouping eq "12">
	
	<cfquery name="getBodyInfo" datasource="#dts#">
    SELECT  a.refno,a.itemno,a.desp,a.despa,a.comment,
            a.unit_bil,0 as qty_bil,0 as price_bil,sum(a.amt_bil) as amt_bil,a.dispec1,a.dispec2,a.dispec3,a.disamt_bil,
            a.taxpec1,a.taxpec2,a.taxpec3,a.taxamt_bil,a.note_a,
            0 as price,sum(a.amt) as amt,a.unit,
            a.brem1,a.brem2,a.brem3,a.brem4,a.itemcount,
            a.qty1,a.qty2,a.qty3,a.qty4,a.qty5,a.qty6,a.qty7,
            a.title_desp,a.location,
            b.photo,a.type,a.trancode,a.nodisplay
            
            ,b.aitemno
            
    FROM ictran AS a
    LEFT JOIN icitem AS b ON a.itemno = b.itemno
    WHERE type = <cfif getheaderinfo.type eq "TR">
    			 	'TROU'
                 <cfelse>
                 	'#getHeaderInfo.type#'
                 </cfif>
    AND	refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.refno#">
    and a.itemno <> "name"
	and (a.void = '' or a.void is null)
	group by brem5
    ORDER BY trancode;
	</cfquery>
	
	<cfelseif getinvoicetype.invoicegrouping eq "4">
	
	<cfif getHeaderInfo.custno eq "300033090" 
	or getHeaderInfo.custno eq "300033578"
	or getHeaderInfo.custno eq "300033764"
	or getHeaderInfo.custno eq "300033784"
	or getHeaderInfo.custno eq "300033726"
	or getHeaderInfo.custno eq "300033349">
    	<cfquery name="getBodyInfo" datasource="#dts#">
        SELECT  a.refno,a.itemno,if(STRCMP(a.itemno,'adminfee'),a.desp,'Staffing Services') as desp,a.despa,a.comment,
                '' as unit_bil,'0' as qty_bil,'0' as price_bil,sum(a.amt_bil) as amt_bil,a.dispec1,a.dispec2,a.dispec3,a.disamt_bil,
                a.taxpec1,a.taxpec2,a.taxpec3,sum(a.taxamt_bil) as taxamt_bil,a.note_a,
                '0' as price,sum(a.amt) as amt,a.unit,
                a.brem1,a.brem2,a.brem3,a.brem4,a.itemcount,
                a.qty1,a.qty2,a.qty3,a.qty4,a.qty5,a.qty6,a.qty7,
                a.title_desp,a.location,
                b.photo,a.type,a.trancode,a.nodisplay
                
                ,b.aitemno
                
        FROM ictran AS a
        LEFT JOIN icitem AS b ON a.itemno = b.itemno
        WHERE type = <cfif getheaderinfo.type eq "TR">
                        'TROU'
                     <cfelse>
                        '#getHeaderInfo.type#'
                     </cfif>
        AND	refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.refno#">
        AND a.itemno <> "name"
        AND (a.void = '' or a.void is null)
		GROUP BY itemno
        ORDER BY trancode		
        </cfquery>
    <cfelse>
	
	<cfquery name="getBodyInfo" datasource="#dts#">
    SELECT  a.refno,a.itemno,'Staffing Services' as desp,'' as despa,'' as comment,
            '' as unit_bil,'0' as qty_bil,'0' as price_bil,sum(a.amt_bil) as amt_bil,a.dispec1,a.dispec2,a.dispec3,a.disamt_bil,
            a.taxpec1,a.taxpec2,a.taxpec3,a.taxamt_bil,a.note_a,
            '0' as price,sum(a.amt) as amt,a.unit,
            a.brem1,a.brem2,a.brem3,a.brem4,a.itemcount,
            a.qty1,a.qty2,a.qty3,a.qty4,a.qty5,a.qty6,a.qty7,
            a.title_desp,a.location,
            b.photo,a.type,a.trancode,a.nodisplay
            
            ,b.aitemno
            
    FROM ictran AS a
    LEFT JOIN icitem AS b ON a.itemno = b.itemno
    WHERE type = <cfif getheaderinfo.type eq "TR">
    			 	'TROU'
                 <cfelse>
                 	'#getHeaderInfo.type#'
                 </cfif>
    AND	refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.refno#">
    AND a.itemno <> "name"
	AND (a.void = '' or a.void is null)
	group by refno
    ORDER BY trancode;
	</cfquery>
	
	</cfif>
	<cfelse>
	
	<cfquery name="getBodyInfo" datasource="#dts#">
    SELECT  a.refno,a.itemno,a.desp,a.despa,a.comment,
            a.unit_bil,a.qty_bil,a.price_bil,a.amt_bil,a.dispec1,a.dispec2,a.dispec3,a.disamt_bil,
            a.taxpec1,a.taxpec2,a.taxpec3,a.taxamt_bil,a.note_a,
            a.price,a.amt,a.unit,
            a.brem1,a.brem2,a.brem3,a.brem4,a.itemcount,
            a.qty1,a.qty2,a.qty3,a.qty4,a.qty5,a.qty6,a.qty7,
            a.title_desp,a.location,
            b.photo,a.type,a.trancode,a.nodisplay
            
            ,b.aitemno
            
    FROM ictran AS a
    LEFT JOIN icitem AS b ON a.itemno = b.itemno
    WHERE type = <cfif getheaderinfo.type eq "TR">
    			 	'TROU'
                 <cfelse>
                 	'#getHeaderInfo.type#'
                 </cfif>
    AND	refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.refno#">
	and (a.void = '' or a.void is null)
    ORDER BY trancode;
	</cfquery>
	
	
	
	</cfif>
	
	<cfelse>
	
	<!---Function: SELECT ictran --->
	<cfquery name="getBodyInfo" datasource="#dts#">
    SELECT  a.refno,a.itemno,a.desp,a.despa,a.comment,
            a.unit_bil,a.qty_bil,a.price_bil,a.amt_bil,a.dispec1,a.dispec2,a.dispec3,a.disamt_bil,
            a.taxpec1,a.taxpec2,a.taxpec3,a.taxamt_bil,a.note_a,
            a.price,a.amt,a.unit,
            a.brem1,a.brem2,a.brem3,a.brem4,a.itemcount,
            a.qty1,a.qty2,a.qty3,a.qty4,a.qty5,a.qty6,a.qty7,
            a.title_desp,a.location,
            b.photo,a.type,a.trancode,a.nodisplay
            
            ,b.aitemno
            
    FROM ictran AS a
    LEFT JOIN icitem AS b ON a.itemno = b.itemno
    WHERE type = <cfif getheaderinfo.type eq "TR">
    			 	'TROU'
                 <cfelse>
                 	'#getHeaderInfo.type#'
                 </cfif>
    AND	refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.refno#">
	and (a.void = '' or a.void is null)
    ORDER BY trancode;
	</cfquery>
	
	</cfif>
	
    
    <cfif getBodyInfo.recordCount EQ 0>
		<cfquery name="InsertICBil_S" datasource='#dts#'>
            INSERT INTO r_icbil_s (SRefno, No, Desp, TaxCode)
            VALUES (	
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.refno#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#j#">,
                        " ",
                        " " 
                   )
        </cfquery>
        <cfset j = j + 1>
    <cfelse>
    	<cfset toRecalculateRunningNumber = 0>
        <cfloop query="getBodyInfo">
            <cfif getBodyInfo.nodisplay NEQ 'Y'>
                <cfquery name="getserial" datasource="#dts#">
                    SELECT * 
                    FROM iserial 
                    WHERE refno = '#getBodyInfo.refno#' 
                    AND type = '#getHeaderInfo.type#' 
                    AND itemno = '#getBodyInfo.itemno#' 
                    AND trancode = '#getBodyInfo.itemcount#';
                </cfquery>
                <cfset mylist1 = "">
                <cfloop query="getserial">
					<cfif mylist1 eq "">
                        <cfset mylist1 = getserial.serialno>
                    <cfelse>
                        <cfset mylist1 = mylist1&", "&getserial.serialno>
                    </cfif>
                </cfloop>
                
                <cfset iteminfo = arraynew(1)>
                <cfif getBodyInfo.desp EQ '' and getBodyInfo.despa EQ '' and replace(tostring(getBodyInfo.comment),chr(10)," ","all") EQ ''>
                    <cfset iteminfo[1] = ' '>
                <cfelse>
                    <cfset iteminfo[1] = getBodyInfo.desp>
                </cfif>
                
                <cfset iteminfo[2] = getBodyInfo.despa>
                <cfset iteminfo[3] = replace(tostring(getBodyInfo.comment),chr(10)," ","all")>
                <cfif mylist1 neq "">
                    <cfset iteminfo[4] = "Serial No: "&mylist1>
                <cfelse>
                    <cfset iteminfo[4] = "">
                </cfif>
                <cfset info=''>	        
                <cfloop index="a" from="1" to="4">
                    <cfif iteminfo[a] NEQ "" AND iteminfo[a] NEQ "XCOST">
                        <cfif a NEQ 4>
                            <cfset info = info&iteminfo[a]&chr(10)>
                        <cfelse>
                            <cfset info = info&iteminfo[a]>
                        </cfif>
                    </cfif>
                </cfloop>
                    
                <cfif info NEQ "">
                    <cfset str = ListGetAt(info,1,chr(13)&chr(10))>
                <cfelse>
                    <cfset str ="">
                </cfif>
                <cfset recordcnt = ListLen(info,chr(13)&chr(10))>
                
		<cfset toRecalculateRunningNumber = toRecalculateRunningNumber + 1>
                <cfif getbodyinfo.photo neq "">
		<cfset itemphoto='/images/#dts#/#getbodyinfo.photo#'>
		</cfif>
        
        <cfif #itemno# eq 'Name'>
        <cfset getBodyInfo.note_a = "">
        </cfif>
                <!---Function: INSERT ictran --->
		<cfquery name="InsertICBil_S" datasource='#dts#'>
			INSERT IGNORE INTO r_icbil_s (	no, sRefNo, itemNo, aitemno, desp, despa, sn_no, comment, 
											unit, qty, price, amt, dispec1, dispec2, dispec3, itemdis_bil, 
											taxpec1, taxpec2, taxpec3, taxamt, taxCode, 
											brem1, brem2, brem3, brem4,
											qty1, qty2, qty3, qty4, qty5, qty6, qty7,
											titledesp, location, 
											counter_1, counter_2, counter_3, counter_4, photo)
									
			VALUES ( 	<cfqueryparam cfsqltype="cf_sql_decimal" value="#j#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.refno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.itemno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.aitemno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#toString(str)#">, 	
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#toString(getBodyInfo.despa)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#toString(mylist1)#">,																					
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#toString(getBodyInfo.comment)#">,
							
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.unit_bil#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.qty_bil)#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.price_bil)#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.amt_bil)#">,
						<cfloop index='i' from='1' to='3'>
							<cfqueryparam cfsqltype="cf_sql_double" value="#val(evaluate('getBodyInfo.dispec#i#'))#">,
						</cfloop>
						<cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.disamt_bil)#">,
						
						<cfloop index='i' from='1' to='3'>
							<cfqueryparam cfsqltype="cf_sql_double" value="#val(evaluate('getBodyInfo.taxpec#i#'))#">,
						</cfloop>
						<cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.taxamt_bil)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.note_a#">,
						
						<cfloop index='i' from='1' to='4'>
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('getBodyInfo.brem#i#')#">,
						</cfloop>  
						
						<cfloop index='i' from='1' to='7'>
							<cfqueryparam cfsqltype="cf_sql_double" value="#val(evaluate('getBodyInfo.qty#i#'))#">,
						</cfloop>
						
						'', 
						<cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.location)#">,
						
						<cfqueryparam cfsqltype="cf_sql_decimal" value="#toRecalculateRunningNumber#">,
						'',
						'',
						'',
						<cfif IsDefined('itemphoto')>
							'#itemphoto#'
						<cfelseif getBodyInfo.photo NEQ ''>
							'/images/#dts#/#getBodyInfo.photo#'
						<cfelse>
							''    
						</cfif>
				   )
		</cfquery>
                <cfset j = j + 1>
                
                <cfif recordcnt GT 1>
                    <cfloop index="i" from="2" to="#recordcnt#" >
                        <cfset str = ListGetAt(info,i,chr(13)&chr(10))>
                        <cfset str1 = Replace(Left(str,1)," ","")>
                        <cfset count = Len(str) - 1>
                        <cfif count LTE 0>
                            <cfset count = 1>
                        </cfif>
                        <cfset str2 = Right(str,count)>
                        <cfset str = str1 & str2>
                        
                        <cfif str NEQ "">
                            <cfquery name="InsertICBil_S" datasource='#dts#'>
                                INSERT INTO r_icbil_s (SRefno, No, Desp)
                                VALUES (	
                                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.refno#">,
                                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#j#">,
                                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#str#"> 
                                       )
                            </cfquery>
                            <cfset j = j + 1>
                        </cfif>
                    </cfloop>
                </cfif><!---CLOSING TAG: recordcnt GT 1--->	
			</cfif><!---CLOSING TAG: No Display---> 
		</cfloop><!---CLOSING TAG: getBodyInfo--->        
	</cfif><!---CLOSING TAG: BLANK getBodyInfo--->
	<cfset fname=billname&".cfr">
    <cfquery name="checkFormatType" datasource="#dts#">
        SELECT format 
        FROM customized_format 
        WHERE file_name='#BillName#';
    </cfquery>
    
    <cfif checkFormatType.format NEQ ''>
        <cfset formatVariable = checkFormatType.format> 
    <cfelse>
        <cfset formatVariable = 'PDF'>
    </cfif> 
        
    <!---Function: INSERT ictran --->
    <cfquery name="getcninvdate" datasource="#dts#">
        SELECT wos_date 
        FROM artran
        WHERE refno = "#getheaderinfo.rem49#" and type="INV";
    </cfquery>

    <cfif fname eq "invoice.cfr">
	<cfif getaddress.invnogroup eq "1" or getaddress.invnogroup eq "2">
    <cfset fname="InvoiceMSS.cfr">
    <cfelseif getaddress.invnogroup eq "3" or getaddress.invnogroup eq "4">
    <cfset fname="InvoiceAPMR.cfr">
    <cfelseif getaddress.invnogroup eq "7" or getaddress.invnogroup eq "8">
    <cfset fname="InvoiceMBS.cfr">
    <cfelseif getaddress.invnogroup eq "5" or getaddress.invnogroup eq "6">
    <cfset fname="InvoiceMSS.cfr">
    <cfelse>
    <cfset fname="InvoiceAPMR.cfr">
    </cfif>
    </cfif>       
</cfloop><!---CLOSING TAG: getHeaderInfo--->

<cfquery name="update" datasource="#dts#">
	UPDATE r_icbil_s
	SET 
    counter_2 = #k#
	WHERE no = #j-1#
</cfquery>

<cfquery name="MyQuery" datasource="#dts#">
  	SELECT r_icbil_m.*, r_icbil_s.*, CAST(r_icbil_s.comment AS BINARY) AS Cmd
  	FROM r_icbil_m, r_icbil_s 
  	WHERE r_icbil_m.Refno = r_icbil_s.SRefno 
	ORDER BY r_icbil_s.no;
</cfquery>

<cfoutput>
	<cfset thisPath = ExpandPath("/billformat/#dts#/companyLogo.jpg")>
	<cfset thisDirectory = GetDirectoryFromPath(thisPath)>

	<cfif FileExists('#thisDirectory#companyLogo.jpg') EQ 'NO'>
		<cfset companyLogo=''>
	<cfelse>
		<cfset companyLogo='/billformat/#dts#/companyLogo.jpg'>
	</cfif>
</cfoutput>

<cfset fname=billname&".cfr">
<cfquery name="checkFormatType" datasource="#dts#">
	SELECT format 
    FROM customized_format 
    WHERE file_name='#BillName#';
</cfquery>

<cfif checkFormatType.format NEQ ''>
	<cfset formatVariable = checkFormatType.format> 
<cfelse>
	<cfset formatVariable = 'PDF'>
</cfif> 
    
<!---Function: INSERT ictran --->
<cfquery name="getcninvdate" datasource="#dts#">
	SELECT wos_date 
	FROM artran
	WHERE refno = "#getheaderinfo.rem49#" and type="INV";
</cfquery> 

<cfif getHeaderInfo.type eq "INV">
<cfquery name="getassignment" datasource="#dts#">
	SELECT placementno FROM assignmentslip
	WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#listfirst(getHeaderinfo.rem40)#">
</cfquery>

<cfquery name="getplacement" datasource="#dts#">
	SELECT location,po_no,jobpostype,supervisor FROM placement
	WHERE placementno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.placementno#">
</cfquery> 

<cfquery name="getentity" datasource="#dts#">
	SELECT invnogroup FROM bo_jobtypeinv
	WHERE officecode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacement.location#">
    AND jobtype = "#getplacement.jobpostype#"
</cfquery>

<cfquery name="getaddress" datasource="#dts#">
	SELECT * FROM invaddress
	WHERE invnogroup=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getentity.invnogroup#">
</cfquery> 

<cfset getGsetup.compro=getaddress.name>
<cfset getGsetup.compro2=getaddress.add1>
<cfset getGsetup.compro3=getaddress.add2>
<cfset getGsetup.compro4=getaddress.add3>
<cfset getGsetup.compro5=getaddress.add4>
<cfset getGsetup.compro6=getaddress.add5>
<cfset getGsetup.compro7="">
<cfset getGsetup.compro8=getaddress.phone>
<cfset getGsetup.compro9=getaddress.fax>
<cfset getGsetup.compro10=getaddress.website>

<cfset getGsetup.gstno=getaddress.gstno>
<cfset getGsetup.comuen=getaddress.comuen>

<cfif getaddress.logoname neq "">
<cfset companyLogo=getaddress.logoname>
</cfif> 

<cfif fname eq "invoice.cfr">
<cfif getaddress.invnogroup eq "1" or getaddress.invnogroup eq "2">
<cfset fname="InvoiceMSS.cfr">
<cfelseif getaddress.invnogroup eq "3" or getaddress.invnogroup eq "4">
<cfset fname="InvoiceAPMR.cfr">
<cfelseif getaddress.invnogroup eq "7" or getaddress.invnogroup eq "8">
<cfset fname="InvoiceMBS.cfr">
<cfelseif getaddress.invnogroup eq "5" or getaddress.invnogroup eq "6">
<cfset fname="InvoiceMSS.cfr">
<cfelse>
<cfset fname="InvoiceAPMR.cfr">
</cfif>
</cfif> 
</cfif>


<!---#due#
<cfabort>--->


<cfreport template="#fname#" format="PDF" query="MyQuery">    	
    <cfreportparam name="amsLink" value="#IIF(Hlinkams eq 'Y',DE('yes'),DE('no'))#">
    <cfreportparam name="dts" value="#dts#">
    <cfreportparam name="custSupp" value="#ptype#">
    <cfreportparam name="decimalPlace_unitPrice" value="#getGsetup2.Decl_Uprice#">
    <cfreportparam name="decimalPlace_discount" value="#getGsetup2.Decl_Discount#">
    <cfreportparam name="decimalPlace_totalAmt" value="#getGsetup2.Decl_TotalAmt#">
    <cfreportparam name="compro" value="#getGsetup.compro#">
    <cfloop index="i" from="2" to="10">
    	<cfreportparam name="compro#i#" value="#evaluate('getGsetup.compro#i#')#">
	</cfloop>
    <cfreportparam name="companyCurrency" value="#getGsetup.bcurr#">
    <cfreportparam name="GSTno" value="#getGsetup.gstno#">
    <cfreportparam name="gst" value="">
    <cfreportparam name="companyUEN" value="#getGsetup.comuen#">
    <cfloop index="i" from="5" to="11">
    	<cfreportparam name="headerRemark#i#" value="#evaluate('getGsetup.rem#i#')#">
	</cfloop>    
    <cfreportparam name="currencyCodeControl" value="#getHeaderInfo.currencyCode#">
    <cfreportparam name="taxInclude" value="#getHeaderInfo.taxincl#">
    <cfreportparam name="cash" value="#getHeaderInfo.cs_pm_cash#">
    <cfreportparam name="cheque" value="#getHeaderInfo.cs_pm_cheq#">
    <cfreportparam name="cheqno" value="#getHeaderInfo.checkno#">
    <cfreportparam name="creditCard1" value="#getHeaderInfo.cs_pm_crcd#">
    <cfreportparam name="creditCard2" value="#getHeaderInfo.cs_pm_crc2#">
    <cfreportparam name="voucher" value="#getHeaderInfo.cs_pm_vouc#">
    <cfreportparam name="debitCard" value="#getHeaderInfo.cs_pm_dbcd#">
    <cfreportparam name="debt" value="#getHeaderInfo.cs_pm_debt#">
    <cfreportparam name="miscellaneousCharges" value="#getHeaderInfo.mc1_bil#">
    <cfreportparam name="termsCondition" value="#getHeaderInfo.termscondition#">
    <cfloop index="i" from="30" to="47">
    	<cfreportparam name="rem#i#" value="#evaluate('getHeaderInfo.rem#i#')#">
	</cfloop>
    
    <cfif IsDefined("getheaderinfo.returnreason") AND  getheaderinfo.returnreason neq "">
    	<cfreportparam name="rem48" value="#getHeaderInfo.returnreason#">
    <cfelse>
    	<cfreportparam name="rem48" value="#getHeaderInfo.rem48#">
    </cfif>

    <cfif IsDefined("getheaderinfo.returnbillno") AND getheaderinfo.returnbillno neq "">
    	<cfreportparam name="rem49" value="#getHeaderInfo.returnbillno#">
    <cfelse>
    	<cfreportparam name="rem49" value="#getHeaderInfo.rem49#">
    </cfif>

    <cfif IsDefined("getheaderinfo.returndate") AND getheaderinfo.returndate neq "" and isdate(getheaderinfo.returndate)>
    	<cftry>
    		<cfset rem50date=createdate(right(getheaderinfo.returndate,4),mid(getheaderinfo.returndate,4,2),left(getheaderinfo.returndate,2))>
    	<cfcatch>
    		<cfif Len(getheaderinfo.returndate) GT 8>
	    		<cfset rem50date=createdate(right(getheaderinfo.returndate,4),listgetat(getheaderinfo.returndate,2,'/'),listgetat(getheaderinfo.returndate,1,'/'))>
       	 	<cfelse>
	    		<cfset rem50date=createdate(right(getheaderinfo.returndate,2),listgetat(getheaderinfo.returndate,2,'/'),listgetat(getheaderinfo.returndate,1,'/'))>
        	</cfif>
    	</cfcatch>
    	</cftry>
    
    	<cfreportparam name="rem50" value="#rem50date#">
    <cfelse>
    	<cfreportparam name="rem50" value="#getcninvdate.wos_date#">
    </cfif>
    
    <cfreportparam name="agentSignature" value="#getHeaderInfo.agentSignature#">
    <cfreportparam name="termCode" value="#getHeaderInfo.termCode#">
    <cfreportparam name="termDesp" value="#getHeaderInfo.termDesp#">
    <cfreportparam name="soNo" value="#getHeaderInfo.sono#">
    <cfreportparam name="quoNo" value="#getHeaderInfo.quono#">
    <cfreportparam name="projectDesp" value="#getHeaderInfo.projectDesp#">
    <cfreportparam name="jobDesp" value="#getHeaderInfo.jobDesp#">
    <cfreportparam name="driverNo" value="#getHeaderInfo.driverno#">
    <cfreportparam name="driverName" value="#getHeaderInfo.name#">
    <cfif getHeaderInfo.username NEQ ''>
        <cfreportparam name="username" value="#getHeaderInfo.username#">
    <cfelse>
        <cfreportparam name="username" value="#getUserName.username#">
    </cfif> 
	<cfreportparam name="reportto" value="#getplacement.supervisor#">  
    <cfreportparam name="createdBy" value="#getHeaderInfo.created_by#"> 
    <cfreportparam name="companyLogo" value="#companyLogo#">    
    <cfif isdefined('getplacement.location')>
    <cfreportparam name="placementloc" value="#getplacement.location#"> 
    <cfreportparam name="placementpo" value="#getplacement.po_no#"> 
     <cfelse>
    <cfreportparam name="placementloc" value=""> 
    <cfreportparam name="placementpo" value="">     
    <!---<cfreportparam name="dept" value="#getCustSuppGSTinfo.dept1#"> --->
    <!---<cfreportparam name="total" value="#totaltemp#">--->
    </cfif>
</cfreport>


