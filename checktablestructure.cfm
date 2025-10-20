<cftry>
<cfquery name="getlinktable" datasource="#dts#">
select * from (
SELECT
count(schema_name) as ac,schema_name
FROM information_schema.SCHEMATA where (right(schema_name,2) = "_a" or right(schema_name,2) = "_i")
group by left(schema_name,length(schema_name)-2)) as a where a.ac = 2
</cfquery>
<cfloop query="getlinktable">
<cfset databasename = left(getlinktable.schema_name,len(getlinktable.schema_name)-2)&"_i">
<cfset databasename1 = left(getlinktable.schema_name,len(getlinktable.schema_name)-2)&"_a">
<cfoutput>
<cfquery name="getimstable" datasource="#dts#">
show columns from #databasename#.artran where field in ('TYPE','TRANCODE','CUSTNO','FPERIOD','WOS_DATE','DESP','DESPA','AREA','SOURCE','JOB','
		    			CURRRATE','GROSS_BIL','DISC1_BIL','DISC2_BIL','DISC3_BIL','DISC_BIL','NET_BIL','TAX1_BIL','TAX2_BIL','TAX3_BIL','TAX_BIL','
		    			GRAND_BIL','DEBIT_BIL','CREDIT_BIL','INVGROSS','DISP1','DISP2','DISP3','DISCOUNT1','DISCOUNT2','DISCOUNT3','DISCOUNT','NET','
		    			TAX1','TAX2','TAX3','TAX','TAXP1','TAXP2','TAXP3','GRAND','DEBITAMT','CREDITAMT','MC1_BIL','MC2_BIL','M_CHARGE1','M_CHARGE2','
		    			CS_PM_CASH','CS_PM_CHEQ','CS_PM_CRCD','CS_PM_CRC2','CS_PM_DBCD','CS_PM_VOUC','DEPOSIT','CS_PM_DEBT','CS_PM_WHT','CHECKNO','
		    			IMPSTAGE','BILLCOST','BILLSALE','PAIDDATE','PAIDAMT','REFNO3','AGE','NOTE','TERM','ISCASH','VAN','DEL_BY','PLA_DODATE','ACT_DODATE','URGENCY','
		    			CURRRATE2','STAXACC','SUPP1','SUPP2','PONO','DONO','REM0','REM1','REM2','REM3','REM4','REM5','REM6','REM7','REM8','REM9','REM10','REM11','REM12','
		    			FREM0','FREM1','FREM2','FREM3','FREM4','FREM5','FREM6','FREM7','FREM8','FREM9','COMM1','COMM2','COMM3','COMM4','ID','GENERATED','TOINV','ORDER_CL','
		    			EXPORTED','EXPORTED1','EXPORTED2','EXPORTED3','LAST_YEAR','POSTED','PRINTED','LOKSTATUS','VOID','NAME','PONO2','DONO2','CSGTRANS','
		    			TAXINCL','TABLENO','CASHIER','MEMBER','COUNTER','TOURGROUP','TRDATETIME','TIME','XTRCOST','XTRCOST2','POINT','USERID','BPERIOD','VPERIOD','
		    			BDATE','CURRCODE','COMM0','REM13','REM14','MC3_BIL','MC4_BIL','MC5_BIL','MC6_BIL','MC7_BIL','M_CHARGE3','M_CHARGE4','M_CHARGE5','M_CHARGE6','M_CHARGE7',
		    			'SPECIAL_ACCOUNT_CODE','CREATED_BY','UPDATED_BY','CREATED_ON','UPDATED_ON','IRAS_POSTED')
</cfquery>

<cfloop query="getimstable">
<cfquery name="checkams" datasource="#dts#">
show columns from #databasename1#.artran where field = "#getimstable.field#" and type = "#getimstable.type#"
</cfquery>
<cfif checkams.recordcount eq 0>
#databasename1#--ARTRAN--#getimstable.field#<br/>
</cfif>
</cfloop>

<cfquery name="getimstable" datasource="#dts#">
show columns from #databasename#.ictran where field in ('TYPE','TRANCODE','CUSTNO','FPERIOD','WOS_DATE','CURRRATE','ITEMCOUNT','LINECODE','ITEMNO','DESP','DESPA','LOCATION','SOURCE','JOB','SIGN','QTY_BIL','PRICE_BIL','UNIT_BIL','AMT1_BIL','DISPEC1','DISPEC2','DISPEC3','DISAMT_BIL','AMT_BIL','TAXPEC1','TAXPEC2','TAXPEC3','TAXAMT_BIL','IMPSTAGE','QTY','PRICE','UNIT','AMT1','DISAMT','AMT','TAXAMT','FACTOR1','FACTOR2','DONO','DODATE','SODATE','BREM1','BREM2','BREM3','BREM4','PACKING','NOTE1','NOTE2','GLTRADAC','UPDCOST','GST_ITEM','TOTALUP','WITHSN','NODISPLAY','GRADE','PUR_PRICE','QTY1','QTY2','QTY3','QTY4','QTY5','QTY6','QTY7','QTY_RET','TEMPFIGI','SERCOST','M_CHARGE1','M_CHARGE2','ADTCOST1','ADTCOST2','IT_COS','AV_COST','BATCHCODE','EXPDATE','POINT','INV_DISC','INV_TAX','SUPP','EDI_COU1','WRITEOFF','TOSHIP','SHIPPED','NAME','DEL_BY','VAN','GENERATED','UD_QTY','TOINV','EXPORTED','EXPORTED1','EXPORTED2','EXPORTED3','BRK_TO','SV_PART','LAST_YEAR','VOID','SONO','MC1_BIL','MC2_BIL','USERID','DAMT','OLDBILL','WOS_GROUP','CATEGORY','AREA','SHELF','TEMP','TEMP1','BODY','TOTALGROUP','MARK','TYPE_SEQ','PROMOTER','TABLENO','MEMBER','TOURGROUP','TRDATETIME','TIME','BOMNO','DEFECTIVE','M_CHARGE3','M_CHARGE4','M_CHARGE5','M_CHARGE6','M_CHARGE7','MC3_BIL','MC4_BIL','MC5_BIL','MC6_BIL','MC7_BIL','TITLE_ID','TITLE_DESP','NOTE_A')
</cfquery>

<cfloop query="getimstable">
<cfquery name="checkams" datasource="#dts#">
show columns from #databasename1#.ictran where field = "#getimstable.field#" and type = "#getimstable.type#"
</cfquery>
<cfif checkams.recordcount eq 0>
#databasename1#--ICTRAN--#getimstable.field#<br/>
</cfif>
</cfloop>

</cfoutput>
</cfloop>
<cfcatch type="any">
<cfoutput>
#cfcatch.Detail#
</cfoutput>
</cfcatch>

</cftry>
