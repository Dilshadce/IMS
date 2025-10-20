<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfinclude template="/object/dateobject.cfm">
<cfquery datasource='#dts#' name="getgeneral">
	Select lsize as layer from gsetup
</cfquery>
<cfparam name="status" default="">
<cfif #form.mode# eq "Create">
	<cfquery datasource='#dts#' name="checkitemExist">
 	 	Select * from icsizeid where sizeid = '#form.sizeid#' 
 	 </cfquery>
  	<cfif checkitemExist.recordcount GT 0 >
		<cfoutput>
      		<h3><font color="##FF0000">Error, This #getgeneral.layer# ("#form.sizeid#") has been created already.</font></h3>
	    </cfoutput> 
    	<cfabort>
	</cfif>
	
<!--- 	<cfinsert datasource='#dts#' tablename="icsizeid" formfields="sizeid,desp,size1,size2,size3,size4,size5,size6,size7,size8,size9,size10,size11,size12,size13,size14,size15,size16,size17,size18,size19,size20,size21,size22,size23,size24,size25,size26,size27,size28,size29,size30"> --->

<cfquery name="insert" datasource="#dts#">
INSERT INTO
icsizeid
(
sizeid
,desp
<cfloop from="1" to="7" index="i">
,daytype#i#
,starttime#i#
,endtime#i#
,breakh#i#
,workh#i#
</cfloop>
<cfset typelist = "WD,OD,RD,PH">
<cfloop list="#typelist#" index="i">
<cfloop from="1" to="8" index="a">
,#i#OT#a#
</cfloop>
</cfloop>
<cfloop from="1" to="30" index="i">
,phdate#i#
,phdesp#i#
</cfloop>
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sizeid#">
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">
<cfloop from="1" to="7" index="i">
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.daytype#i#')#">
<cfset starttime = evaluate('form.starthr#i#')&":"&evaluate('form.startmin#i#')>
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#starttime#">
<cfset endtime = evaluate('form.endhr#i#')&":"&evaluate('form.endmin#i#')>
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#endtime#">
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.breakh#i#')#">
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.workh#i#')#">
</cfloop>
<cfset typelist = "WD,OD,RD,PH">
<cfloop list="#typelist#" index="i">
<cfloop from="1" to="8" index="a">
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.#i#OT#a#')#">
</cfloop>
</cfloop>
<cfloop from="1" to="30" index="i">
<cfif evaluate('form.phdate#i#') neq "">
<cfset phdate = dateformatnew(evaluate('form.phdate#i#'),'YYYY-MM-DD')>
<cfelse>
<cfset phdate = '0000-00-00'>
</cfif>
,"#phdate#"
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.phdesp#i#')#">
</cfloop>
)
</cfquery>
	
	<cfset status="The #getgeneral.layer#, #form.sizeid# had been successfully created. ">

<cfelse>

		<cfquery datasource='#dts#' name="checkitemExist">
			Select * from icsizeid where sizeid='#form.sizeid#'
		</cfquery>
		
		<cfif checkitemExist.recordcount GT 0 >
		
				<cfif #form.mode# eq "Delete">
						<cfquery datasource='#dts#' name="deleteitem">
								Delete from icsizeid where sizeid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sizeid#">
						</cfquery>
						<cfset status="The #getgeneral.layer#, #form.sizeid# had been successfully deleted. ">	
								
				</cfif>
				<cfif #form.mode# eq "Edit">
                
                <cfquery name="update" datasource="#dts#">
                UPDATE icsizeid
                SET
               desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">
                <cfloop from="1" to="7" index="i">
                ,daytype#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.daytype#i#')#">
                <cfset starttime = evaluate('form.starthr#i#')&":"&evaluate('form.startmin#i#')>
                ,starttime#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#starttime#">
                <cfset endtime = evaluate('form.endhr#i#')&":"&evaluate('form.endmin#i#')>
                ,endtime#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#endtime#">
                ,breakh#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.breakh#i#')#">
                ,workh#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.workh#i#')#">
                </cfloop>
                <cfset typelist = "WD,OD,RD,PH">
                <cfloop list="#typelist#" index="i">
                <cfloop from="1" to="8" index="a">
                ,#i#OT#a# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.#i#OT#a#')#">
                </cfloop>
                </cfloop>
                <cfloop from="1" to="30" index="i">
                <cfif evaluate('form.phdate#i#') neq "">
                <cfset phdate = dateformatnew(evaluate('form.phdate#i#'),'YYYY-MM-DD')>
                <cfelse>
                <cfset phdate = '0000-00-00'>
                </cfif>
                ,phdate#i# = "#phdate#"
                ,phdesp#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.phdesp#i#')#">

                
                </cfloop>
WHERE
 sizeid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sizeid#">
                </cfquery>
					<!--- <cfupdate datasource='#dts#' tablename="icsizeid" formfields="sizeid,desp,size1,size2,size3,size4,size5,size6,size7,size8,size9,size10,size11,size12,size13,size14,size15,size16,size17,size18,size19,size20,size21,size22,size23,size24,size25,size26,size27,size28,size29,size30"> --->
					
					<!--- EDI_ID, ITEMNO,	AITEMNO, MITEMNO, SHORTCODE, DESP, DESPA, BRAND, CATEGORY, WOS_GROUP, SHELF, SUPP, PACKING,
WEIGHT,	COSTCODE, UNIT,	UCOST, PRICE, PRICE2, PRICE3, PRICE_MIN, MINIMUM, MAXIMUM, REORDER, UNIT2,COLORID,
SIZEID,	FACTOR1, FACTOR2, PRICEU2, UNIT3, FACTORU3_A, FACTORU3_B, PRICEU3, UNIT4, FACTORU4_A, FACTORU4_B,
PRICEU4, UNIT5,	FACTORU5_A, FACTORU5_B, PRICEU5, UNIT6,	FACTORU6_A, FACTORU6_B,	PRICEU6, DISPEC_A1,DISPEC_A2,
DISPEC_A3, DISPEC_B1, DISPEC_B2, DISPEC_B3, DISPEC_C1, DISPEC_C2, DISPEC_C3, PRICE_CATA, PRICE_CATB,PRICE_CATC,
COST_CATA, COST_CATB, COST_CATC, QTY2, QTY3, QTY4, QTY5, QTY6, WQFORMULA, WPFORMULA, GRADED, MURATIO,QTYBF,
QTYNET,	QTYACTUAL, AVCOST, AVCOST2, BOM_COST, TQ_OBAL, TQ_IN, TQ_OUT, TQ_CBAL, T_UCOST, T_STKV, TQ_INV, TQ_CS,
TQ_CN, TQ_DN, TQ_RC, TQ_PR, TQ_ISS, TQ_OAI, TQ_OAR, TA_INV, TA_CS, TA_CN, TA_DN, TA_RC, TA_PR, TA_ISS, TQ_OAI,
TQ_OAR,	QIN11, QIN12, QIN13, QIN14, QIN15, QIN16, QIN17, QIN18, QIN19, QIN20, QIN21, QIN22, QIN23, QIN24,QIN25,
QIN26, QIN27, QIN28, QOUT11, QOUT12, QOUT13, QOUT14, QOUT15, QOUT16, QOUT17, QOUT18, QOUT19, QOUT20, QOUT21,
QOUT22, QOUT23, QOUT24, QOUT25, QOUT26,	QOUT27, QOUT28, SALEC, SALECSC, SALECNC, PURC, PURPREC, TEMPFIG, 
TEMPFIG1, CT_RATING, POINT, QCPOINT, AWARD1, AWARD2, AWARD3, AWARD4, AWARD5, AWARD6, AWARD7, AWARD8, REMARK1,
REMARK2, REMARK3, REMARK4, REMARK5, REMARK6, REMARK7, REMARK8, REMARK9, REMARK10, REMARK11, REMARK12, REMARK13,
REMARK14, REMARK15, REMARK16, REMARK17, REMARK18, REMARK19, REMARK20, REMARK21, REMARK22, REMARK23, REMARK24,
REMARK25, REMARK26, REMARK27, REMARK28, REMARK29, REMARK30, COMMRATE1, COMMRATE2, COMMRATE3, COMMRATE4,
WOS_DATE, QTYDEC, TEMP_QTY, QTY, PHOTO, COMPEC_A, COMPEC_B, COMPEC_C, WOS_TIME, EXPIRED, WSERIALNO, PROMOTOR,
TAXABLE, TAXPERC1, TAXPERC2, NONSTKITEM, GRAPHIC, PRODCODE, BRK_TO, COLOR, SIZE --->						

						<cfset status="The #getgeneral.layer#, #form.sizeid# had been successfully edited. ">
				</cfif>
				
		<cfelse>		
			<cfset status="Sorry, the #getgeneral.layer#, #form.sizeid# was ALREADY removed from the system. Process unsuccessful.">
		</cfif>
</cfif>
<!---Get the messaged to be passed into the view user page. (vUser.cfm) --->

<cfoutput>
	<form name="done" action="s_sizeidtable.cfm?type=icsizeid&process=done" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>
	done.submit();
</script>