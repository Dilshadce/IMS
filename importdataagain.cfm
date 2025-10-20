<cfset dts1 = "bakersoven11_a">
<cfquery name="get_posted_transaction" datasource="#dts1#">
				select acc_code,reference from glpost
				group by acc_code,reference
			</cfquery>
            
<cfloop query="get_posted_transaction">
				<cfquery name="update" datasource="#dts#">
		    		update artran set IRAS_POSTED='P' WHERE refno='#get_posted_transaction.reference#' and type='#get_posted_transaction.acc_code#'
		    	</cfquery>
		    	
		    	<cfquery name="delete" datasource="#dts1#">
		        	delete from artran WHERE refno='#get_posted_transaction.reference#' and type='#get_posted_transaction.acc_code#'
		        </cfquery>
	            <cfquery name="delete2" datasource="#dts1#">
		        	delete from ictran WHERE refno='#get_posted_transaction.reference#' and type='#get_posted_transaction.acc_code#'
		        </cfquery>
		        
		        <cfquery name="select" datasource="#dts#">
		 			select TYPE,REFNO,REFNO2,TRANCODE,CUSTNO,FPERIOD,WOS_DATE,DESP,DESPA,AGENNO,AREA,SOURCE,JOB,
		 			CURRRATE,GROSS_BIL,DISC1_BIL,DISC2_BIL,DISC3_BIL,DISC_BIL,NET_BIL,TAX1_BIL,TAX2_BIL,TAX3_BIL,TAX_BIL,
		 			GRAND_BIL,DEBIT_BIL,CREDIT_BIL,INVGROSS,DISP1,DISP2,DISP3,DISCOUNT1,DISCOUNT2,DISCOUNT3,DISCOUNT,NET,
		 			TAX1,TAX2,TAX3,TAX,TAXP1,TAXP2,TAXP3,GRAND,DEBITAMT,CREDITAMT,MC1_BIL,MC2_BIL,M_CHARGE1,M_CHARGE2,
		 			CS_PM_CASH,CS_PM_CHEQ,CS_PM_CRCD,CS_PM_CRC2,CS_PM_DBCD,CS_PM_VOUC,DEPOSIT,CS_PM_DEBT,CS_PM_WHT,CHECKNO,
		 			IMPSTAGE,BILLCOST,BILLSALE,PAIDDATE,PAIDAMT,REFNO3,AGE,NOTE,TERM,ISCASH,VAN,DEL_BY,PLA_DODATE,ACT_DODATE,URGENCY,
		 			CURRRATE2,STAXACC,SUPP1,SUPP2,PONO,DONO,REM0,REM1,REM2,REM3,REM4,REM5,REM6,REM7,REM8,REM9,REM10,REM11,REM12,
		 			FREM0,FREM1,FREM2,FREM3,FREM4,FREM5,FREM6,FREM7,FREM8,FREM9,COMM1,COMM2,COMM3,COMM4,ID,GENERATED,TOINV,ORDER_CL,
		 			EXPORTED,EXPORTED1,EXPORTED2,EXPORTED3,LAST_YEAR,POSTED,PRINTED,LOKSTATUS,VOID,NAME,PONO2,DONO2,CSGTRANS,
		 			TAXINCL,TABLENO,CASHIER,MEMBER,COUNTER,TOURGROUP,TRDATETIME,TIME,XTRCOST,XTRCOST2,POINT,USERID,BPERIOD,VPERIOD,
		 			BDATE,CURRCODE,COMM0,REM13,REM14,MC3_BIL,MC4_BIL,MC5_BIL,MC6_BIL,MC7_BIL,M_CHARGE3,M_CHARGE4,M_CHARGE5,M_CHARGE6,M_CHARGE7,
		 			SPECIAL_ACCOUNT_CODE,CREATED_BY,UPDATED_BY,CREATED_ON,UPDATED_ON,IRAS_POSTED 
		 			from artran 
		 			WHERE refno='#get_posted_transaction.reference#' and type='#get_posted_transaction.acc_code#'
				</cfquery>
				
				<cfquery name="select_ictran" datasource="#dts#">
		 			select TYPE,REFNO,REFNO2,TRANCODE,CUSTNO,FPERIOD,WOS_DATE,CURRRATE,ITEMCOUNT,LINECODE,ITEMNO,DESP,DESPA,AGENNO,LOCATION,SOURCE,JOB,SIGN,QTY_BIL,PRICE_BIL,UNIT_BIL,AMT1_BIL,DISPEC1,DISPEC2,DISPEC3,DISAMT_BIL,AMT_BIL,TAXPEC1,TAXPEC2,TAXPEC3,TAXAMT_BIL,IMPSTAGE,QTY,PRICE,UNIT,AMT1,DISAMT,AMT,TAXAMT,FACTOR1,FACTOR2,DONO,DODATE,SODATE,BREM1,BREM2,BREM3,BREM4,PACKING,NOTE1,NOTE2,GLTRADAC,UPDCOST,GST_ITEM,TOTALUP,WITHSN,NODISPLAY,GRADE,PUR_PRICE,QTY1,QTY2,QTY3,QTY4,QTY5,QTY6,QTY7,QTY_RET,TEMPFIGI,SERCOST,M_CHARGE1,M_CHARGE2,ADTCOST1,ADTCOST2,IT_COS,AV_COST,BATCHCODE,EXPDATE,POINT,INV_DISC,INV_TAX,SUPP,EDI_COU1,WRITEOFF,TOSHIP,SHIPPED,NAME,DEL_BY,VAN,GENERATED,UD_QTY,TOINV,EXPORTED,EXPORTED1,EXPORTED2,EXPORTED3,BRK_TO,SV_PART,LAST_YEAR,VOID,SONO,MC1_BIL,MC2_BIL,USERID,DAMT,OLDBILL,WOS_GROUP,CATEGORY,AREA,SHELF,TEMP,TEMP1,BODY,TOTALGROUP,MARK,TYPE_SEQ,PROMOTER,TABLENO,MEMBER,TOURGROUP,TRDATETIME,TIME,BOMNO,DEFECTIVE,M_CHARGE3,M_CHARGE4,M_CHARGE5,M_CHARGE6,M_CHARGE7,MC3_BIL,MC4_BIL,MC5_BIL,MC6_BIL,MC7_BIL,TITLE_ID,TITLE_DESP,NOTE_A
	            	from ictran
	               	WHERE refno='#get_posted_transaction.reference#' and type='#get_posted_transaction.acc_code#'
				</cfquery>
				
		   		<cfif select.recordcount neq 0>
	            	<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#select.PAIDDATE#" returnvariable="select.PAIDDATE"/>  
	                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#select.WOS_DATE#" returnvariable="select.WOS_DATE"/>  
	                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#select.PLA_DODATE#" returnvariable="select.PLA_DODATE"/>  
	                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#select.ACT_DODATE#" returnvariable="select.ACT_DODATE"/>  
	                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#select.EXPORTED1#" returnvariable="select.EXPORTED1"/>  
	                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#select.EXPORTED3#" returnvariable="select.EXPORTED3"/>  
	                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#select.BDATE#" returnvariable="select.BDATE"/>
	                <cfinvoke component="cfc.date" method="getFormatedDateTime" inputDate="#select.CREATED_ON#" returnvariable="select.CREATED_ON"/>
	                <cfinvoke component="cfc.date" method="getFormatedDateTime" inputDate="#select.UPDATED_ON#" returnvariable="select.UPDATED_ON"/>    
	                
		   			<cfquery name="insertData" datasource="#dts1#">
		    			INSERT INTO artran 
		    			(TYPE,REFNO,REFNO2,TRANCODE,CUSTNO,FPERIOD,WOS_DATE,DESP,DESPA,AGENNO,AREA,SOURCE,JOB,
		    			CURRRATE,GROSS_BIL,DISC1_BIL,DISC2_BIL,DISC3_BIL,DISC_BIL,NET_BIL,TAX1_BIL,TAX2_BIL,TAX3_BIL,TAX_BIL,
		    			GRAND_BIL,DEBIT_BIL,CREDIT_BIL,INVGROSS,DISP1,DISP2,DISP3,DISCOUNT1,DISCOUNT2,DISCOUNT3,DISCOUNT,NET,
		    			TAX1,TAX2,TAX3,TAX,TAXP1,TAXP2,TAXP3,GRAND,DEBITAMT,CREDITAMT,MC1_BIL,MC2_BIL,M_CHARGE1,M_CHARGE2,
		    			CS_PM_CASH,CS_PM_CHEQ,CS_PM_CRCD,CS_PM_CRC2,CS_PM_DBCD,CS_PM_VOUC,DEPOSIT,CS_PM_DEBT,CS_PM_WHT,CHECKNO,
		    			IMPSTAGE,BILLCOST,BILLSALE,PAIDDATE,PAIDAMT,REFNO3,AGE,NOTE,TERM,ISCASH,VAN,DEL_BY,PLA_DODATE,ACT_DODATE,URGENCY,
		    			CURRRATE2,STAXACC,SUPP1,SUPP2,PONO,DONO,REM0,REM1,REM2,REM3,REM4,REM5,REM6,REM7,REM8,REM9,REM10,REM11,REM12,
		    			FREM0,FREM1,FREM2,FREM3,FREM4,FREM5,FREM6,FREM7,FREM8,FREM9,COMM1,COMM2,COMM3,COMM4,ID,GENERATED,TOINV,ORDER_CL,
		    			EXPORTED,EXPORTED1,EXPORTED2,EXPORTED3,LAST_YEAR,POSTED,PRINTED,LOKSTATUS,VOID,NAME,PONO2,DONO2,CSGTRANS,
		    			TAXINCL,TABLENO,CASHIER,MEMBER,COUNTER,TOURGROUP,TRDATETIME,TIME,XTRCOST,XTRCOST2,POINT,USERID,BPERIOD,VPERIOD,
		    			BDATE,CURRCODE,COMM0,REM13,REM14,MC3_BIL,MC4_BIL,MC5_BIL,MC6_BIL,MC7_BIL,M_CHARGE3,M_CHARGE4,M_CHARGE5,M_CHARGE6,M_CHARGE7,
		    			SPECIAL_ACCOUNT_CODE,CREATED_BY,UPDATED_BY,CREATED_ON,UPDATED_ON,IRAS_POSTED) 
		    			values 
		    			('#select.TYPE#','#select.REFNO#','#select.REFNO2#','#select.TRANCODE#','#select.CUSTNO#','#select.FPERIOD#','#select.WOS_DATE#',
		    			'#select.DESP#','#select.DESPA#','#select.AGENNO#','#select.AREA#','#select.SOURCE#','#select.JOB#','#val(select.CURRRATE)#',
		    			'#val(select.GROSS_BIL)#','#val(select.DISC1_BIL)#','#val(select.DISC2_BIL)#','#val(select.DISC3_BIL)#','#val(select.DISC_BIL)#',
		    			'#val(select.NET_BIL)#','#val(select.TAX1_BIL)#','#val(select.TAX2_BIL)#','#val(select.TAX3_BIL)#','#val(select.TAX_BIL)#',
		    			'#val(select.GRAND_BIL)#','#val(select.DEBIT_BIL)#','#val(select.CREDIT_BIL)#','#val(select.INVGROSS)#','#val(select.DISP1)#',
		    			'#val(select.DISP2)#','#val(select.DISP3)#','#val(select.DISCOUNT1)#','#val(select.DISCOUNT2)#','#val(select.DISCOUNT3)#','#val(select.DISCOUNT)#',
		    			'#val(select.NET)#','#val(select.TAX1)#','#val(select.TAX2)#','#val(select.TAX3)#','#val(select.TAX)#','#val(select.TAXP1)#','#val(select.TAXP2)#',
		    			'#val(select.TAXP3)#','#val(select.GRAND)#','#val(select.DEBITAMT)#','#val(select.CREDITAMT)#','#val(select.MC1_BIL)#','#val(select.MC2_BIL)#',
		    			'#val(select.M_CHARGE1)#','#val(select.M_CHARGE2)#','#val(select.CS_PM_CASH)#','#val(select.CS_PM_CHEQ)#','#val(select.CS_PM_CRCD)#',
		    			'#val(select.CS_PM_CRC2)#','#val(select.CS_PM_DBCD)#','#val(select.CS_PM_VOUC)#','#val(select.DEPOSIT)#','#val(select.CS_PM_DEBT)#',
		    			'#val(select.CS_PM_WHT)#','#val(select.CHECKNO)#','#select.IMPSTAGE#','#val(select.BILLCOST)#','#val(select.BILLSALE)#','#select.PAIDDATE#',
		    			'#val(select.PAIDAMT)#','#select.REFNO3#','#select.AGE#','#select.NOTE#','#select.TERM#','#select.ISCASH#','#select.VAN#','#select.DEL_BY#',
		    			'#select.PLA_DODATE#','#select.ACT_DODATE#','#select.URGENCY#','#val(select.CURRRATE2)#',
		    			'#select.STAXACC#','#select.SUPP1#','#select.SUPP2#','#select.PONO#','#select.DONO#','#select.REM0#','#select.REM1#','#select.REM2#',
		    			'#select.REM3#','#select.REM4#','#select.REM5#','#select.REM6#','#select.REM7#','#select.REM8#','#select.REM9#','#select.REM10#','#select.REM11#',
		    			'#select.REM12#','#select.FREM0#','#select.FREM1#','#select.FREM2#','#select.FREM3#','#select.FREM4#','#select.FREM5#','#select.FREM6#','#select.FREM7#',
		    			'#select.FREM8#','#select.FREM9#','#select.COMM1#','#select.COMM2#','#select.COMM3#','#select.COMM4#','#select.ID#','#select.GENERATED#','#select.TOINV#',
		    			'#select.ORDER_CL#','#select.EXPORTED#','#select.EXPORTED1#','#select.EXPORTED2#','#select.EXPORTED3#','#select.LAST_YEAR#','#select.POSTED#',
		    			'#select.PRINTED#','#select.LOKSTATUS#','#select.VOID#','#select.NAME#','#select.PONO2#','#select.DONO2#','#select.CSGTRANS#','#select.TAXINCL#',
		    			'#select.TABLENO#','#select.CASHIER#','#select.MEMBER#','#select.COUNTER#','#select.TOURGROUP#','0000-00-00 00:00:00',
		    			'#select.TIME#','#val(select.XTRCOST)#','#val(select.XTRCOST2)#','#val(select.POINT)#','#select.USERID#','#select.BPERIOD#',
		    			'#select.VPERIOD#','#select.BDATE#','#select.CURRCODE#','#select.COMM0#','#select.REM13#','#select.REM14#','#val(select.MC3_BIL)#',
		    			'#val(select.MC4_BIL)#','#val(select.MC5_BIL)#','#val(select.MC6_BIL)#','#val(select.MC7_BIL)#','#val(select.M_CHARGE3)#','#val(select.M_CHARGE4)#',
		    			'#val(select.M_CHARGE5)#','#val(select.M_CHARGE6)#','#val(select.M_CHARGE7)#','#select.SPECIAL_ACCOUNT_CODE#','#select.CREATED_BY#','#select.UPDATED_BY#',
		    			'#select.CREATED_ON#','#select.UPDATED_ON#','#select.IRAS_POSTED#')	
					</cfquery> 
		   		</cfif>
            
	            <cfif select_ictran.recordcount neq 0>
					<cfloop query="select_ictran">
	               		<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#select_ictran.WOS_DATE#" returnvariable="select_ictran.WOS_DATE"/>  
	                	<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#select_ictran.DODATE#" returnvariable="select_ictran.DODATE"/>  
		                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#select_ictran.SODATE#" returnvariable="select_ictran.SODATE"/> 
		                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#select_ictran.EXPDATE#" returnvariable="select_ictran.EXPDATE"/>  
		                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#select_ictran.EXPORTED1#" returnvariable="select_ictran.EXPORTED1"/>  
		                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#select_ictran.EXPORTED3#" returnvariable="select_ictran.EXPORTED3"/>  
		                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#select_ictran.TRDATETIME#" returnvariable="select_ictran.TRDATETIME"/>
		
		                <cfquery name="insertData" datasource="#dts1#">
		                	INSERT INTO `ictran` (`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,`PACKING`,`NOTE1`,`NOTE2`,`GLTRADAC`,`UPDCOST`,`GST_ITEM`,`TOTALUP`,`WITHSN`,`NODISPLAY`,`GRADE`,`PUR_PRICE`,`QTY1`,`QTY2`,`QTY3`,`QTY4`,`QTY5`,`QTY6`,`QTY7`,`QTY_RET`,`TEMPFIGI`,`SERCOST`,`M_CHARGE1`,`M_CHARGE2`,`ADTCOST1`,`ADTCOST2`,`IT_COS`,`AV_COST`,`BATCHCODE`,`EXPDATE`,`POINT`,`INV_DISC`,`INV_TAX`,`SUPP`,`EDI_COU1`,`WRITEOFF`,`TOSHIP`,`SHIPPED`,`NAME`,`DEL_BY`,`VAN`,`GENERATED`,`UD_QTY`,`TOINV`,`EXPORTED`,`EXPORTED1`,`EXPORTED2`,`EXPORTED3`,`BRK_TO`,`SV_PART`,`LAST_YEAR`,`VOID`,`SONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`TEMP`,`TEMP1`,`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,`TABLENO`,`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,`DEFECTIVE`,`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,`MC6_BIL`,`MC7_BIL`,`TITLE_ID`,`TITLE_DESP`,`NOTE_A`) VALUES 
		                    ('#select_ictran.TYPE#','#select_ictran.REFNO#','#select_ictran.REFNO2#','#select_ictran.TRANCODE#','#select_ictran.CUSTNO#','#select_ictran.FPERIOD#','#select_ictran.WOS_DATE#','#select_ictran.CURRRATE#','#select_ictran.ITEMCOUNT#','#select_ictran.LINECODE#','#select_ictran.ITEMNO#','#select_ictran.DESP#','#select_ictran.DESPA#','#select_ictran.AGENNO#','#select_ictran.LOCATION#','#select_ictran.SOURCE#','#select_ictran.JOB#','#select_ictran.SIGN#','#select_ictran.QTY_BIL#','#select_ictran.PRICE_BIL#','#select_ictran.UNIT_BIL#','#select_ictran.AMT1_BIL#','#val(select_ictran.DISPEC1)#','#val(select_ictran.DISPEC2)#','#val(select_ictran.DISPEC3)#','#val(select_ictran.DISAMT_BIL)#','#select_ictran.AMT_BIL#','#select_ictran.TAXPEC1#','#select_ictran.TAXPEC2#','#select_ictran.TAXPEC3#','#select_ictran.TAXAMT_BIL#','#select_ictran.IMPSTAGE#','#select_ictran.QTY#','#select_ictran.PRICE#','#select_ictran.UNIT#','#select_ictran.AMT1#','#select_ictran.DISAMT#','#select_ictran.AMT#','#select_ictran.TAXAMT#','#select_ictran.FACTOR1#','#select_ictran.FACTOR2#','#select_ictran.DONO#','#select_ictran.DODATE#','#select_ictran.SODATE#','#select_ictran.BREM1#','#select_ictran.BREM2#','#select_ictran.BREM3#','#select_ictran.BREM4#','#select_ictran.PACKING#','#select_ictran.NOTE1#','#select_ictran.NOTE2#','#select_ictran.GLTRADAC#','#select_ictran.UPDCOST#',
							'#select_ictran.GST_ITEM#','#select_ictran.TOTALUP#','#select_ictran.WITHSN#','#select_ictran.NODISPLAY#','#select_ictran.GRADE#','#select_ictran.PUR_PRICE#','#select_ictran.QTY1#','#select_ictran.QTY2#','#select_ictran.QTY3#','#select_ictran.QTY4#','#select_ictran.QTY5#','#select_ictran.QTY6#','#select_ictran.QTY7#','#select_ictran.QTY_RET#','#select_ictran.TEMPFIGI#','#select_ictran.SERCOST#','#select_ictran.M_CHARGE1#','#select_ictran.M_CHARGE2#','#select_ictran.ADTCOST1#','#select_ictran.ADTCOST2#','#select_ictran.IT_COS#','#select_ictran.AV_COST#','#select_ictran.BATCHCODE#','#select_ictran.EXPDATE#','#select_ictran.POINT#','#select_ictran.INV_DISC#','#select_ictran.INV_TAX#','#select_ictran.SUPP#','#select_ictran.EDI_COU1#','#select_ictran.WRITEOFF#','#select_ictran.TOSHIP#','#select_ictran.SHIPPED#','#select_ictran.NAME#','#select_ictran.DEL_BY#','#select_ictran.VAN#','#select_ictran.GENERATED#','#select_ictran.UD_QTY#','#select_ictran.TOINV#','#select_ictran.EXPORTED#','#select_ictran.EXPORTED1#','#select_ictran.EXPORTED2#','#select_ictran.EXPORTED3#','#select_ictran.BRK_TO#','#select_ictran.SV_PART#','#select_ictran.LAST_YEAR#','#select_ictran.VOID#','#select_ictran.SONO#','#select_ictran.MC1_BIL#','#select_ictran.MC2_BIL#','#select_ictran.USERID#','#select_ictran.DAMT#','#select_ictran.OLDBILL#','#select_ictran.WOS_GROUP#',
							'#select_ictran.CATEGORY#','#select_ictran.AREA#','#select_ictran.SHELF#','#select_ictran.TEMP#','#select_ictran.TEMP1#','#select_ictran.BODY#','#select_ictran.TOTALGROUP#','#select_ictran.MARK#','#select_ictran.TYPE_SEQ#','#select_ictran.PROMOTER#','#select_ictran.TABLENO#','#select_ictran.MEMBER#','#select_ictran.TOURGROUP#','#select_ictran.TRDATETIME#','#select_ictran.TIME#','#select_ictran.BOMNO#','#select_ictran.DEFECTIVE#','#select_ictran.M_CHARGE3#','#select_ictran.M_CHARGE4#','#select_ictran.M_CHARGE5#','#select_ictran.M_CHARGE6#','#select_ictran.M_CHARGE7#','#select_ictran.MC3_BIL#','#select_ictran.MC4_BIL#','#select_ictran.MC5_BIL#','#select_ictran.MC6_BIL#','#select_ictran.MC7_BIL#','#select_ictran.TITLE_ID#','#select_ictran.TITLE_DESP#','#select_ictran.NOTE_A#')
		               	</cfquery>
					</cfloop>
	            </cfif>
			</cfloop>