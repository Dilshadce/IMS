<cfif IsDefined("url.debug")>
	<cfabort>
</cfif>

<noscript>
	WARNING! Javascript has been disabled or is not supported in this browser.
    <br>Please enable Javascript in your browser.
</noscript>

<cfquery name='getGsetup' datasource='#dts#'>
	SELECT wpitemtax
	FROM gsetup;
</cfquery>

<cfif getGsetup.wpitemtax NEQ 1>
	<cftry>
        <cfquery name="getGsetup2" datasource="#dts#">
        	SELECT Decl_Uprice,Decl_Discount,Decl_totalamt 
            FROM gsetup2;
        </cfquery>
        
        <cfquery name="updateAmtBil_ictran" datasource="#dts#">
        	UPDATE ictran 
            SET
            	amt_bil = round(price_bil * qty_bil,#getGsetup2.Decl_totalamt#)-disamt_bil 
            WHERE type = '#tran#' 
           	AND <cfif IsDefined('url.nexttranno')> 
            		refno='#url.nexttranno#'; 
            	<cfelse> 
                	refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">);
                </cfif>
        </cfquery>

        <cfquery name="updateAmt_ictran" datasource="#dts#">
        	UPDATE ictran 
            SET 
            	amt = amt_bil * currrate 
            WHERE type = '#tran#' 
            AND <cfif IsDefined('url.nexttranno')> 
            		refno='#url.nexttranno#'; 
                <cfelse> 
                	refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">);
                </cfif>
        </cfquery>

        <cfquery name="getSum_ictran" datasource="#dts#">
        	SELECT refno,type,sum(amt_bil) AS sumAmt 
            FROM ictran 
            WHERE type = '#tran#' 
            AND <cfif IsDefined('url.nexttranno')> 
            		refno='#url.nexttranno#' 
                <cfelse> 
                	refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">)
                </cfif> 
            GROUP BY refno;
        </cfquery>

        <cfquery name="updateSum_artran" datasource="#dts#">
        	UPDATE artran 
            SET 
            	gross_bil = "#val(getSum_ictran.sumAmt)#" 
            WHERE type = '#tran#' 
            AND refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getSum_ictran.refno#">;
        </cfquery>


        <cfquery name="updateGrand_artran" datasource="#dts#">
        	UPDATE artran 
            SET 
            	net_bil = gross_bil - disc_bil 
            WHERE type = '#tran#' 
            AND <cfif IsDefined('url.nexttranno')> 
            		refno='#url.nexttranno#'; 
                <cfelse> 
                	refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">);
                </cfif>
        </cfquery>

        <cfquery name="updateGrand2_artran" datasource="#dts#">
        	UPDATE artran 
            SET 
        		grand_bil = if(taxincl = "T",net_bil,round(net_bil + (net_bil * taxp1/100),#getGsetup2.Decl_totalamt#)),
        		tax1_bil = if(taxincl = "T",round(net_bil * taxp1/(100+taxp1),#getGsetup2.Decl_totalamt#), round(net_bil * taxp1/100,#getGsetup2.Decl_Uprice#)),
       			tax_bil = if(taxincl = "T",round(net_bil * taxp1/(100+taxp1),#getGsetup2.Decl_totalamt#), round(net_bil * taxp1/100,#getGsetup2.Decl_totalamt#)) 
        	WHERE type = '#tran#' 
            AND <cfif IsDefined('url.nexttranno')> 
            		refno='#url.nexttranno#'; 
                <cfelse> 
                	refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">);
                </cfif>
        </cfquery>

        <cfquery name="updaterate" datasource="#dts#">
        	UPDATE artran 
            SET 
            	grand = grand_bil * currrate , 
                net = net_bil * currrate, 
                invgross = gross_bil * currrate, 
                tax = tax_bil * currrate, 
                tax1 = tax1_bil 
            WHERE type = '#tran#' 
            AND <cfif IsDefined('url.nexttranno')> 
            		refno='#url.nexttranno#'; 
                <cfelse> 
                	refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">);
                </cfif>
        </cfquery>

        <cfquery name="checkartran" datasource='#dts#'>
        	SELECT *,m_charge1+m_charge2+m_charge3+m_charge4+m_charge5+m_charge6+m_charge7 AS totalmisc 
            FROM artran 
            WHERE type = '#tran#' 
            AND refno='#url.nexttranno#';
        </cfquery>

		<cfif checkartran.currrate NEQ 1>
        
            <cfif getGsetup.wpitemtax NEQ "1" AND checkartran.taxincl NEQ "T" AND val(checkartran.totalmisc) EQ 0>
            
                <cfquery name="updaterate" datasource="#dts#">
                    UPDATE artran 
                    SET  
                    	tax=round(grand,#getGsetup2.Decl_totalamt#)-round(net,#getGsetup2.Decl_totalamt#) 
                    WHERE type = '#tran#' 
                    AND <cfif IsDefined('url.nexttranno')> 
                    		refno='#url.nexttranno#'; 
                        <cfelse> 
                        	refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">);
                        </cfif>
                </cfquery>
            
            <cfelseif getGsetup.wpitemtax neq "1" and val(checkartran.totalmisc) eq 0>
            
                <cfquery name="updaterate" datasource="#dts#">
                    UPDATE artran 
                    SET  
                    	tax=round(grand,#getGsetup2.Decl_totalamt#)-round(net,#getGsetup2.Decl_totalamt#)-round(discount,#getGsetup2.Decl_totalamt#) 
                    WHERE type = '#tran#' 
                    AND <cfif IsDefined('url.nexttranno')> 
                    		refno='#url.nexttranno#'; 
                        <cfelse> 
                        	refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">);
                        </cfif>
                </cfquery>
            </cfif>
        </cfif>
        
        <cfquery name="getartran" datasource='#dts#'>
        	SELECT * 
            FROM artran 
            WHERE type = '#tran#' 
            AND refno='#url.nexttranno#';
        </cfquery>

		<cfif getGsetup.wpitemtax neq "Y" and val(getartran.invgross) NEQ 0>

    		<cfif getartran.taxincl eq "T">

                <cfquery name="updatesum2" datasource="#dts#">
            		UPDATE artran 
                    SET 
                    	gross_bil = grand_bil-tax_bil+disc_bil-mc1_bil-mc2_bil-mc3_bil-mc4_bil-mc5_bil-mc6_bil-mc6_bil 
                    WHERE type = '#tran#' 
                    AND refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getSum_ictran.refno#">;
                </cfquery>

                <cfquery name="updaterate2" datasource="#dts#">
					UPDATE artran 
                    SET 
                    	invgross = gross_bil * currrate 
                    WHERE type = '#tran#' 
                    AND refno='#url.nexttranno#'; 
                </cfquery>

                <cfquery name="updateictrantax" datasource="#dts#">
                    UPDATE ictran 
                    SET 
                    	note_a='#getartran.note#',
                    	TAXPEC1='#getartran.taxp1#',
                    	TAXAMT_BIL=round((AMT_BIL/#val(getartran.net_bil)+val(getartran.disc_bil)#)*#val(getartran.tax1_bil)#,5),
                    	TAXAMT=round((AMT/#val(getartran.net)+val(getartran.discount)#)*#val(getartran.tax)#,5)
                    WHERE type = '#tran#' and refno='#url.nexttranno#'
                </cfquery>
    		<cfelse>
                <cfquery name="updateictrantax" datasource="#dts#">
                    UPDATE ictran 
                    SET note_a='#getartran.note#',
                    	TAXPEC1='#getartran.taxp1#',
                    	TAXAMT_BIL=round((AMT_BIL/#val(getartran.gross_bil)#)*#val(getartran.tax1_bil)#,5),
                    	TAXAMT=round((AMT/#val(getartran.invgross)#)*#val(getartran.tax)#,5)
                    WHERE type = '#tran#' and refno='#url.nexttranno#'
                </cfquery>
    		</cfif>
		</cfif>
    <cfcatch type="any">
    </cfcatch>
	</cftry>
</cfif><!---CLOSING TAG FOR: getGsetup.wpitemtax NEQ 1 --->

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
    FROM gsetup; 
</cfquery>

<cfquery name="getGsetup2" datasource='#dts#'>
  	SELECT CONCAT('.',REPEAT('_',Decl_Uprice)) AS Decl_Uprice,CONCAT('.',REPEAT('_',Decl_Discount)) AS Decl_Discount 
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

<cfquery name="getHeaderInfo" datasource='#dts#' >
	SELECT 	a.type,a.custno,a.refno,a.refno2,a.wos_date,a.desp,a.despa,a.term,a.pono,a.dono,a.sono,
            a.cs_pm_cash,a.cs_pm_cheq,a.cs_pm_crcd,a.cs_pm_crc2,a.cs_pm_tt,a.cs_pm_dbcd,a.cs_pm_vouc,a.cs_pm_cash,a.deposit,a.cs_pm_debt,
            a.taxincl,a.termscondition,
            a.rem0,a.rem1,a.rem2,a.rem3,a.rem4,a.rem5,a.rem6,a.rem7,a.rem8,a.rem9,a.rem10,a.rem11,a.rem12,a.rem13,a.rem14,
            a.rem30,a.rem31,a.rem32,a.rem33,a.rem34,a.rem35,a.rem36,a.rem37,a.rem38,a.rem39,
			a.rem40,a.rem41,a.rem42,a.rem43,a.rem44,a.rem45,a.rem46,a.rem47,a.rem48,a.rem49,
            a.frem0,a.frem1,a.frem2,a.frem3,a.frem4,a.frem5,a.frem6,a.country,a.postalcode,
            a.frem7,a.frem8,a.comm0,a.comm1,a.comm2,a.comm3,a.comm4,a.d_country,a.d_postalcode,
            a.mc1_bil,a.mc2_bil,a.mc3_bil,a.mc4_bil,a.mc5_bil,a.mc6_bil,a.mc7_bil,
            a.disp1,a.disp2,a.disp3,a.disc_bil,a.disc1_bil,a.disc2_bil,a.disc3_bil, 
            a.taxp1,a.tax_bil,a.tax1_bil,a.tax2_bil,a.tax3_bil,a.discount,a.gross_bil,a.net_bil,a.grand_bil,a.currrate,
            a.phonea,a.d_phone2,a.e_mail,a.d_email,   
            a.name,a.userid,a.username,a.created_by,
                    
            ag.agent AS agentNo, ag.desp AS agentDesp, ag.hp AS agentHP, ag.photo AS agentSignature,
            curr.currency AS currencySymbol,curr.currcode AS currencyCode, 
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
        AND type =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#" >
    </cfquery>
</cfif>
<cfset j = 1>
<cfset k = 0>

<cfloop query="getHeaderInfo">
	<cfif getHeaderInfo.rem0 NEQ "">
		<cfif getHeaderInfo.rem0 EQ "Profile">
			<cfif tran EQ 'PR' OR tran EQ 'PO' OR tran EQ 'RC'>
				<cfquery name="getCustAdd" datasource='#dts#'>
					SELECT 	name,name2,add1,add2,add3,add4,country,postalcode, 
                    		attn,phone,phonea,fax,e_mail
                    FROM #target_apvend# 
                    WHERE custno = '#getHeaderInfo.custno#'; 
				</cfquery>
			<cfelse>
				<cfquery name="getCustAdd" datasource='#dts#'>
					SELECT 	name,name2,add1,add2,add3,add4,country,postalcode,
                    		attn,phone,phonea,fax,e_mail 
                    FROM #target_arcust# 
                    WHERE custno = '#getHeaderInfo.custno#'; 
				</cfquery>
			</cfif>
		<cfelse>
			<cfquery name="getCustAdd" datasource='#dts#'>
				SELECT 	a.name,'' AS name2,a.add1,a.add2,a.add3,a.add4,a.country,a.postalcode,
                		a.attn,a.phone,a.phonea,a.fax,b.e_mail
				FROM address a, #ptype# b 
                WHERE a.code = '#getHeaderInfo.rem0#' 
                AND a.custno = b.custno;
			</cfquery>
		</cfif>
	<cfelse>
		<cfset getCustAdd.name = getHeaderInfo.frem0>
		<cfset getCustAdd.name2 = getHeaderInfo.frem1>
		<cfset getCustAdd.add1 = getHeaderInfo.frem2>
		<cfset getCustAdd.add2 = getHeaderInfo.frem3>
		<cfset getCustAdd.add3 = getHeaderInfo.frem4>
		<cfset getCustAdd.add4 = getHeaderInfo.frem5>
        <cfset getCustAdd.country = getHeaderInfo.country>
        <cfset getCustAdd.postalcode = getHeaderInfo.postalcode>
        <cfset getCustAdd.add4 = getHeaderInfo.frem5>
		<cfset getCustAdd.attn = getHeaderInfo.rem2>
		<cfset getCustAdd.phone = getHeaderInfo.rem4>
        <cfset getCustAdd.phonea = getHeaderInfo.phonea>
		<cfset getCustAdd.fax = getHeaderInfo.frem6>
		<cfset getCustAdd.e_mail = getHeaderInfo.e_mail>
	</cfif>
	
	<cfif getHeaderInfo.rem1 NEQ "">
		<cfif getHeaderInfo.rem1 eq "Profile">
			<cfif tran EQ 'PR' OR tran EQ 'PO' OR tran EQ 'RC'>
				<cfquery name="getDeliveryAdd" datasource='#dts#'>
					SELECT  name,name2,daddr1 AS add1,daddr2 AS add2,daddr3 AS add3,daddr4 AS add4,d_country AS country,d_postalcode AS postalcode,
                    		dattn AS attn,dphone AS phone,contact AS phonea,dfax AS fax,d_email
                    FROM #target_apvend# 
                    WHERE custno = '#getHeaderInfo.custno#';
				</cfquery>
			<cfelse>
				<cfquery name="getDeliveryAdd" datasource='#dts#'>
					SELECT  name,name2,daddr1 AS add1,daddr2 AS add2,daddr3 AS add3,daddr4 AS add4,d_country AS country,d_postalcode AS postalcode,
                    		dattn AS attn,dphone AS phone,contact AS phonea,dfax AS fax,d_email
                    FROM #target_arcust# 
                    WHERE custno = '#getHeaderInfo.custno#'; 
				</cfquery>
			</cfif>
		<cfelse>
			<cfquery name="getDeliveryAdd" datasource='#dts#'>
				SELECT 	a.name,'' as name2,a.add1,a.add2,a.add3,a.add4,a.country,a.postalcode,
                		a.attn,a.phone,b.contact AS phonea,a.fax,b.d_email
				FROM address a			
				LEFT JOIN #ptype# AS b ON a.custno = b.custno
				WHERE a.code = '#getHeaderInfo.rem1#';
			</cfquery>
		</cfif>
	<cfelse>
		<cfset getDeliveryAdd.name = getHeaderInfo.frem7>
		<cfset getDeliveryAdd.name2 = getHeaderInfo.frem8>
		<cfset getDeliveryAdd.add1 = getHeaderInfo.comm0>
		<cfset getDeliveryAdd.add2 = getHeaderInfo.comm1>
		<cfset getDeliveryAdd.add3 = getHeaderInfo.comm2>
		<cfset getDeliveryAdd.add4 = getHeaderInfo.comm3>
        <cfset getDeliveryAdd.country = getHeaderInfo.d_country>
        <cfset getDeliveryAdd.postalcode = getHeaderInfo.d_postalcode>
		<cfset getDeliveryAdd.attn = getHeaderInfo.rem3>
		<cfset getDeliveryAdd.phone = getHeaderInfo.rem12>
        <cfset getDeliveryAdd.phonea = getHeaderInfo.d_phone2>
		<cfset getDeliveryAdd.fax = getHeaderInfo.comm4>
		<cfset getDeliveryAdd.d_email = getHeaderInfo.d_email>
	</cfif>
	
	<cfif k neq 0>
		<cfquery name="update" datasource="#dts#">
			UPDATE r_icbil_s
			SET 
            	counter_2 = #k#
			WHERE No = #j-1#;
		</cfquery>
	</cfif>
	<cfset k = k+1>
    
	<cfquery name="InsertICBil_M" datasource="#dts#">
	  	INSERT INTO r_icbil_m ( B_Name, B_Name2, B_Add1, B_Add2, B_Add3, B_Add4, B_Country, B_PostalCode, B_Attn, B_Tel, B_HP, B_Fax, B_Email,
        						D_Name, D_Name2, D_Add1, D_Add2, D_Add3, D_Add4, D_Country, D_PostalCode, D_Attn, D_Tel, D_HP, D_Fax, D_Email,
                                CustNo, RefNo, RefNo2, PONO, DONO, Terms, TermDesp, Prefix, Date,
                                Agent, AgentDesp, AgentHP, Project, Job, 
                                Rem0, Rem1, Rem2, Rem3, Rem4, Rem5, Rem6, Rem7, Rem8, Rem9, Rem10, Rem11, Rem12,
                                Disp1, Disp2, Disp3, Disamt_Bil, Taxp1, Taxamt_Bil,
                                Deposit, Gross_Bil, Net_Bil, Total,  
                                CurrCode, CurrSymbol, CurrRate,
                                UserName, EndUser)
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
                    
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.custno#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.refno#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.refno2#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.pono#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.dono#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.term#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.termDesp#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#tranPrefix#">,
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
                    <cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.disc_bil)#">,
                    <cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.taxp1)#">,
                    <cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.tax_bil)#">,
                    <cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.deposit)#">,
                    <cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.gross_bil)#">,
                    <cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.net_bil)#">,
                    <cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.grand_bil)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.currencyCode#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.currencySymbol#">,
                    <cfqueryparam cfsqltype="cf_sql_double" value="#val(getHeaderInfo.currrate)#">,
	  				<cfif getHeaderInfo.username NEQ ''>
                    	<cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.username#">,
        			<cfelse>
                    	<cfqueryparam cfsqltype="cf_sql_varchar" value="#getUserName.username#">,
        			</cfif>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getHeaderInfo.driverName#">
                )
	</cfquery><!---CLOSING TAG: InsertICBil_M  --->
	
	<cfquery name="getBodyInfo" datasource="#dts#">
		SELECT  a.refno,a.itemno,a.desp,a.despa,a.comment,
        		a.unit_bil,a.qty_bil,a.price_bil,a.amt_bil,a.dispec1,a.dispec2,a.dispec3,a.disamt_bil,a.taxpec1,a.taxpec2,a.taxpec3,a.taxamt_bil,
                a.price,a.amt,
                a.brem1,a.brem2,a.brem3,a.brem4,a.itemcount,
                a.qty1,a.qty2,a.qty3,a.qty4,a.qty5,a.qty6,a.qty7,
                a.title_desp,a.location,
                a.photo,a.type,a.trancode,
                
                b.aitemno
                
		FROM ictran AS a
        LEFT JOIN icitem AS b ON a.itemno = b.itemno 
		WHERE type = <cfif getheaderinfo.type eq "TR">'TROU'<cfelse>'#getHeaderInfo.type#'</cfif>
		AND	refno = '#getHeaderInfo.refno#'
		ORDER BY trancode;
	</cfquery>
	
	<cfloop query="getBodyInfo">
		
		<cfquery name="getserial" datasource="#dts#">
	    	SELECT * 
            FROM iserial 
            WHERE refno = '#getBodyInfo.refno#' 
            AND type = '#getHeaderInfo.type#' 
	    	AND itemno = '#getBodyInfo.itemno#' 
            AND trancode = '#getBodyInfo.itemcount#';
	  	</cfquery>
	  	
	  	<cfif getserial.recordcount GT 0>
        	<cfloop query="getserial">
	    	<cfif getserial.currentrow eq 1>
			<cfset mylist1 = getserial.serialno>
            <cfelse>
            <cfset mylist1 = mylist1&", "&getserial.serialno>
            </cfif>
            
            </cfloop>
            
            
	  	<cfelse>
	    	<cfset mylist1 = ''>
	  	</cfif>
	  	
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
		
		<cfquery name="InsertICBil_S" datasource='#dts#'>
			INSERT IGNORE INTO r_icbil_s (	no, sRefNo, itemNo, aitemno, desp, despa, sn_no, comment, 
                                            unit, qty, price, amt, dispec1, dispec2, dispec3, itemdis_bil, taxpec1, taxpec2, taxpec3, taxamt,
                                            sgd_price, sgd_amt,   
                                            brem1, brem2, brem3, brem4,
                                            qty1, qty2, qty3, qty4, qty5, qty6, qty7,
                                            titledesp, location, 
                                            counter_1, counter_2, counter_3, counter_4,photo)
                                    
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
                        <cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.price)#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.amt)#">,  
                        <cfloop index='i' from='1' to='4'>
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('getBodyInfo.brem#i#')#">,
                        </cfloop>  
                        <cfloop index='i' from='1' to='7'>
                        	<cfqueryparam cfsqltype="cf_sql_double" value="#val(evaluate('getBodyInfo.qty#i#'))#">,
                        </cfloop>
                        <cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.title_desp)#">, 
                        <cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.location)#">,
                        <cfqueryparam cfsqltype="cf_sql_decimal" value="#getBodyInfo.currentrow#">,
                        '',
                        '',
                        '',
                        '#getBodyInfo.photo#'
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
	</cfloop><!---CLOSING TAG: getBodyInfo--->
</cfloop><!---CLOSING TAG: getHeaderInfo--->

<cfquery name="update" datasource="#dts#">
	UPDATE r_icbil_s
	SET 
    	counter_2 = #k#
	WHERE no = #j-1#
</cfquery>

<cfquery name="MyQuery" datasource="#dts#">
  	SELECT r_icbil_m.*, r_icbil_s.*, CAST(r_icbil_s.comment AS BINARY) AS Cmd
  	FROm r_icbil_m, r_icbil_s 
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

<!---Set: Filename --->

<cfquery name="getTemplate" datasource="#dts#">
  	SELECT billFormatTemplate
  	FROM gsetup2;
</cfquery>

<cfset templateID = getTemplate.billFormatTemplate>
<cfset templateLocation = "Template_"&templateID&"/"&tran&".cfr">


<cfif IsDefined('url.format')>
	<cfif url.format EQ 'faktorPajak'>
        <cfset fname="faktorPajak.cfr">
    <cfelseif url.format EQ 'faktorPajakUSD'>
        <cfset fname="faktorPajakUSD.cfr"> 
    </cfif>
<cfelseif IsDefined('url.tax')>
	<cfif trim(url.tax) EQ 'Mas'>
    	<cfset fname="Template_3 (Malaysia Non GST)/"&tran&".cfr">
    <cfelseif trim(url.tax) EQ '2'>
		<cfset fname = "Template_"&templateID&"/Template_ItemTax/"&tran&".cfr">
    <cfelse>
    	<cfset fname = "Template_"&templateID&"/Template_BillTax/"&tran&".cfr">  	    
    </cfif>  
</cfif>

<cfreport template="#fname#" format="PDF" query="MyQuery">    	
    <cfreportparam name="amsLink" value="#IIF(Hlinkams eq 'Y',DE('yes'),DE('no'))#">
    <cfreportparam name="dts" value="#dts#">
    <cfreportparam name="custSupp" value="#ptype#">
    <cfreportparam name="decimalPlace_general" value="#getGsetup2.Decl_Uprice#">
    <cfreportparam name="decimalPlace_discount" value="#getGsetup2.Decl_Discount#">
    <cfreportparam name="compro" value="#getGsetup.compro#">
    <cfloop index="i" from="2" to="10">
    	<cfreportparam name="compro#i#" value="#evaluate('getGsetup.compro#i#')#">
	</cfloop>
    <cfreportparam name="companyCurrency" value="#getGsetup.bcurr#">
    <cfreportparam name="GSTno" value="#getGsetup.gstno#">
    <cfreportparam name="companyUEN" value="#getGsetup.comuen#">
    <cfreportparam name="taxInclude" value="#getHeaderInfo.taxincl#">
    <cfreportparam name="cash" value="#getHeaderInfo.cs_pm_cash#">
    <cfreportparam name="cheque" value="#getHeaderInfo.cs_pm_cheq#">
    <cfreportparam name="creditCard1" value="#getHeaderInfo.cs_pm_crcd#">
    <cfreportparam name="creditCard2" value="#getHeaderInfo.cs_pm_crc2#">
    <cfreportparam name="voucher" value="#getHeaderInfo.cs_pm_vouc#">
    <cfreportparam name="debitCard" value="#getHeaderInfo.cs_pm_dbcd#">
    <cfreportparam name="debt" value="#getHeaderInfo.cs_pm_debt#">
    <cfreportparam name="miscellaneousCharges" value="#getHeaderInfo.mc1_bil#">
    <cfreportparam name="termsCondition" value="#getHeaderInfo.termscondition#">
    <cfloop index="i" from="30" to="49">
    	<cfreportparam name="remark#i#" value="#evaluate('getHeaderInfo.rem#i#')#">
	</cfloop>
    <cfreportparam name="agentSignature" value="#getHeaderInfo.agentSignature#">
    <cfreportparam name="termCode" value="#getHeaderInfo.termCode#">
    <cfreportparam name="termDesp" value="#getHeaderInfo.termDesp#">
    <cfreportparam name="soNo" value="#getHeaderInfo.sono#">
    <cfreportparam name="projectDesp" value="#getHeaderInfo.projectDesp#">
    <cfreportparam name="jobDesp" value="#getHeaderInfo.jobDesp#">
    <cfreportparam name="driverNo" value="#getHeaderInfo.driverno#">
    <cfreportparam name="driverName" value="#getHeaderInfo.name#">
    <cfif getHeaderInfo.username NEQ ''>
        <cfreportparam name="username" value="#getHeaderInfo.username#">
    <cfelse>
        <cfreportparam name="username" value="#getUserName.username#">
    </cfif> 
    <cfreportparam name="createdBy" value="#getHeaderInfo.created_by#"> 
    <cfreportparam name="companyLogo" value="#companyLogo#"> 
    
    <cfreportparam name="custno" value="#getHeaderInfo.custno#"> 
    <cfreportparam name="name" value="#getHeaderInfo.name#"> 
    <cfreportparam name="rem1" value="#getHeaderInfo.rem1#"> 
    <cfreportparam name="rem2" value="#getHeaderInfo.rem2#"> 
    
    <!---<cfreportparam name="B_Country" value="#getCustAdd.country#">  
    <cfreportparam name="B_PostalCode" value="#getCustAdd.postalcode#"> 
    <cfreportparam name="B_Email" value="#getCustAdd.e_mail#">
    <cfreportparam name="D_Country" value="#getDeliveryAdd.country#"> 
    <cfreportparam name="D_PostalCode" value="#getDeliveryAdd.postalcode#"> 
    <cfreportparam name="D_Email" value="#getDeliveryAdd.d_email#">--->

</cfreport>

