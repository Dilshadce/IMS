<cfsetting showdebugoutput="no">
<link rel="stylesheet" type="text/css" href="creditnote.css"/>
<cfset custno = URLDecode(url.custno)>
<cfset invno = URLDecode(url.invno)>
<cfset refno = URLDecode(url.refno)>
<cfset uuid = URLDecode(url.uuid)>

<cfquery name="checkitemExist" datasource="#dts#">
    select 
    refno
    from ictrantempcn 
    WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">
	and refno2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invno#">
</cfquery>

<cfif checkitemExist.recordcount eq 0>
<cfquery name="insertictran" datasource="#dts#">
	insert into ictrantempcn
	(TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, brem8, brem9, brem10, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, totalupdisplay, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY8, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, QUONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl, LOC_CURRRATE, LOC_CURRCODE, TITLE_ID, TITLE_DESP, consignment, FOC, voucherno, asvoucher, BOMCOSTMETHOD, MANUDATE, milcert, importpermit, PHOTO, PONO, countryoforigin, pallet, requiredate, replydate, deliverydate, invlinklist, invcnitem, cnqty, cnamt, deductableitem, stkcost, originalqty, custom_taxpec, custom_taxamt, custom_taxamt_bil,UUID)
	SELECT 'INV', '#refno#' as REFNO, REFNO, TRANCODE, CUSTNO, FPERIOD, WOS_DATE, CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA, AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL, UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3, DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3, TAXAMT_BIL, NOTE_A, IMPSTAGE, QTY, PRICE, UNIT, AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE, SODATE, BREM1, BREM2, BREM3, BREM4, brem8, brem9, brem10, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST, GST_ITEM, TOTALUP, WITHSN, NODISPLAY, totalupdisplay, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6, QTY7, QTY8, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1, ADTCOST2, IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1, WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED, EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, QUONO, MC1_BIL, MC2_BIL, USERID, DAMT, OLDBILL, WOS_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1, BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME, TIME, BOMNO, COMMENT, DEFECTIVE, M_CHARGE3, M_CHARGE4, M_CHARGE5, M_CHARGE6, M_CHARGE7, MC3_BIL, MC4_BIL, MC5_BIL, MC6_BIL, MC7_BIL, taxincl, LOC_CURRRATE, LOC_CURRCODE, TITLE_ID, TITLE_DESP, consignment, FOC, voucherno, asvoucher, BOMCOSTMETHOD, MANUDATE, milcert, importpermit, PHOTO, PONO, countryoforigin, pallet, requiredate, replydate, deliverydate, invlinklist, invcnitem, cnqty, cnamt, deductableitem, stkcost, originalqty, custom_taxpec, custom_taxamt, custom_taxamt_bil,'#uuid#' 
	FROM ictran
	WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#invno#">
</cfquery>

</cfif>

<cfquery name="getsum" datasource="#dts#">
SELECT SUM(amt1_bil) as sumsubtotal,count(itemno) as countitemno,sum(taxamt_bil) as sumtaxtotal FROM ictrantempcn where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#" />
</cfquery>

<cfoutput>
<input type="hidden" name="hidsubtotal" id="hidsubtotal" value="#numberformat(getsum.sumsubtotal,'.__')#" />
<input type="hidden" name="hidtaxtotal" id="hidtaxtotal" value="#numberformat(getsum.sumtaxtotal,'.__')#" />
<input type="hidden" name="hiditemcount" id="hiditemcount" value="#getsum.countitemno#" />


<cfquery name="getictrantemp" datasource="#dts#">
SELECT * FROM ictrantempcn WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> order by trancode
</cfquery>

							<div class="row" id="body_section">  
								<table class="itemTable">
									<thead>
										<tr class="itemTableTR">
											<th class="th_one itemTableTH">Invoice Number</th>
											<th class="th_two itemTableTH">Item Number</th>
											<th class="th_three itemTableTH">Description</th>
											<th class="th_four itemTableTH">Quantity</th>
											<th class="th_five itemTableTH">Price</th>
											<th class="th_six itemTableTH">Amount</th>
										</tr>
									</thead>
									<tbody id="item_table_body">
										<cfloop query="getictrantemp">
											<tr id="#trancode#" class="edit_tr last_edit_tr">
												<td class="td_one">
													#refno2#
												</td>
												<td class="td_two">
													#itemno#
												</td>
												<td class="td_three">
													#desp#
												</td>
												<td class="td_four">
													#qty_bil#
												</td>
												<td class="td_five">
													#price_bil#
												</td>
												<td class="td_fix">
													#amt_bil#
												</td>
											</tr>     
										</cfloop>
									</tbody>
								</table>
							</div>

</cfoutput>

