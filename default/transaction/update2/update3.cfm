<html>
<head>
<title>Update Main Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<!--- Calculate the period --->
<cfparam name="gross" default="0">
<cfparam name="gross_bil" default="0">
<cfparam name="lastpono" default="">
<cfparam name="updatepono" default="">
<cfparam name="counter" default="">
<cfparam name="fr_type" default="">
<cfparam name="ft_type" default="">
<cfparam name="fr_refno" default="">
<cfparam name="nextrefno" default="">
<cfparam name="f_cdate" default="">
<cfparam name="updatetype" default="1">
<cfparam name="bylocation" default="">
<cfparam name="updateqin" default="N">
<cfparam name="updateqout" default="N">

<!--- fr_type: From Type; ft_type: To Type --->
<!--- FROM DO --->
<cfif fr_type eq "DO">
	<cfset updateFromType="Delivery Order">
	<!--- TO INV --->
	<cfif ft_type eq "INV">
		<cfset updateToType="Invoice">
	    <cfset tt_type="INV">
	    <cfset msg1="and (shipped+writeoff) < qty">
	    <cfset dsign="-1">
	</cfif>
<!--- FROM SO --->
<cfelseif fr_type eq "SO">
	<cfset updateFromType="Sales Order">
	<!--- TO INV --->
	<cfif ft_type eq "INV">
		<cfset updateToType="Invoice">
	    <cfset tt_type="INV,DO">
	    <cfset msg1="and (shipped+writeoff) < qty">
	    <cfset updateqout="Y">
	    <cfset dsign="-1">
	<!--- TO DO --->
	<cfelseif ft_type eq "DO">
		<cfset updateToType="Delivery Order">
	    <cfset tt_type="INV,DO">
	    <cfset msg1="and (shipped+writeoff) < qty">
	    <cfset updateqout="Y">
	    <cfset dsign="-1">
	<!--- TO PO --->
	<cfelseif ft_type eq "PO">
		<cfset updateToType="Purchase Order">
	    <cfset tt_type="PO">
	    <cfset msg1="and exported = '' and toinv = ''">
	    <cfset dsign="1">
	</cfif>
<!--- FROM PO --->
<cfelseif fr_type eq "PO">
	<cfset updateFromType="Purchase Order">
	<!--- TO RC --->
	<cfif ft_type eq "RC">
		<cfset updateToType="Purchase Receive">
	    <cfset tt_type="RC">
	    <cfset msg1="and (shipped+writeoff) < qty">
	    <cfset updateqin="Y">
	    <cfset dsign="1">
	</cfif>
<!--- FROM QUO --->
<cfelseif fr_type eq "QUO">
	<cfset updateFromType="Quotation">
	<!--- TO INV --->
	<cfif ft_type eq "INV">
		<cfset updateToType="Invoice">
	    <cfset tt_type="INV,SO">
	    <cfset msg1="and shipped < qty">
	    <cfset updateqout="Y">
	    <cfset dsign="-1">
	<cfelseif ft_type eq "SO">
		<cfset updateToType="Sales Order">
	    <cfset tt_type="INV,SO">
	    <cfset msg1="and shipped < qty">
	    <cfset dsign="-1">
	</cfif>
</cfif>

<cfif ft_type eq 'PO' or ft_type eq 'PR' or ft_type eq 'RC'>
	<cfset ptype = target_apvend>
<cfelse>
	<cfset ptype = target_arcust>
</cfif>

<cfquery datasource="#dts#" name="getGsetup">
  	Select * from GSetup
</cfquery>

<cfset lastaccyear = dateformat(getGsetup.lastaccyear, "dd/mm/yyyy")>
<cfset period = '#getGsetup.period#'>
<cftry>
	<cfset currentdate = createDate(ListGetAt(f_cdate,3,"/"),ListGetAt(f_cdate,2,"/"),ListGetAt(f_cdate,1,"/"))>
<cfcatch type="any">
	<cfset currentdate = now()>
</cfcatch>
</cftry>

<cfset tmpYear = year(currentdate)>
<cfset clsyear = year(lastaccyear)>
<cfset tmpmonth = month(currentdate)>
<cfset clsmonth = month(lastaccyear)>
<cfset intperiod = (tmpyear - clsyear) * 12 + tmpmonth - clsmonth>

<cfif intperiod gt 18 or intperiod lte 0>
  	<cfset readperiod = 99>
<cfelse>
  	<cfset readperiod = numberformat(intperiod,"00")>
</cfif>

<cfset currperiod = "CurrP" & val(readperiod)>

<cfquery datasource="#dts#" name="getGeneralInfo">
	select lastUsedNo as tranno, refnoused as arun from refnoset
	where type = '#ft_type#'
	and counter = '#counter#'
</cfquery>

<cfquery name="checkexist" datasource="#dts#">
	select refno from artran where type = '#ft_type#' and refno = '#nextrefno#'
</cfquery>
	
<cfif checkexist.recordcount gt 0>
	<cfif getGeneralInfo.arun eq "1">
		<h3>Error. This reference no. have been created. Please change the Last Used No.</h3>
	<cfelse>
		<h3>Error. This reference no. have been created. Please click back and re-enter another reference no.</h3>
	</cfif>
	<cfabort>
</cfif>

<cfoutput><h1>Update to #updateToType#</h1></cfoutput>
<cfquery name="updategsetup" datasource="#dts#">
	update refnoset set 
	lastUsedNo=UPPER('#nextrefno#')
	where type = '#ft_type#'
	and counter =  '#counter#'
</cfquery>
<!--- UPDATETYPE:1 @ UPDATE BY ITEM BY SELECTED QUANTITY --->
<cfif updatetype eq "1">
	<cfif isdefined("form.fulfill")>
		<cfset xlist= form.fulfill>
		<cfset cnt=listlen(xlist)>
		
		<cfloop from="1" to="#cnt#" index="i">
			<cfif listgetat(form.fulfill,i) gt listgetat(form.qtytoful,i)>
				<h3>Error. The qty to fulfill is greater than the outstanding qty.</h3>
				<cfabort>
			</cfif>
		</cfloop>
	</cfif>
	<cfset mylist= listchangedelims(checkbox,"",",")>
	<cfset cnt=listlen(mylist,";")>

	Transaction Update Summary<br><br>
	
	<cfset j = 1>
	<cfloop from="1" to="#cnt#" index="i" step="+2">
		<!--- xParam1: itemno; xParam2: trancode --->
		<cfif trim(listgetat(mylist,i,";")) eq 'YHFTOKCF'>
			<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			<cfset xParam1 = ''>
		<cfelse>
			<cfset xParam1 = listgetat(mylist,i,";")>
		</cfif>

		<cfset xParam2 = listgetat(mylist,i+1,";")>

		<cfquery datasource="#dts#" name="getbody">
			Select * from ictran 
			where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_refno#"> 
			and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_type#"> 
			and itemno = '#xParam1#' and trancode = '#xParam2#'
			#msg1#
		</cfquery>
		
		<cfquery datasource="#dts#" name="getheader">
			Select currcode,custno 
			from artran 
			where refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_refno#"> 
			and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_type#">
		</cfquery>
		
		<cfif getheader.currcode eq ''>
			<cfquery name="getcurrcode" datasource="#dts#">
				select currcode from #ptype# where custno = '#getheader.custno#'
			</cfquery>

			<cfset xCurrCode = getcurrcode.currcode>
		<cfelse>
			<cfset xCurrCode = getheader.currcode>
		</cfif>

		<cfquery name="currency" datasource="#dts#">
			select #currperiod# as rate 
			from #target_currency# 
			where currcode = '#xCurrCode#'
		</cfquery>

		<cfif currency.rate neq "">
			<cfset newcurrate = currency.rate>
		<cfelse>
			<cfset newcurrate = 1>
		</cfif>
		
		<!--- BODY START --->
		<cfloop query="getbody">
			<cfif val(getbody.factor1) neq 0>
				<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
			<cfelse>
				<cfset getbody.price_bil = 0>
			</cfif>
			<cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil>
			<cfset newdamt_bil1 = (val(getbody.dispec1) / 100) * newamt1_bil>
			<cfset netamt = newamt1_bil - newdamt_bil1>
			<cfset newdamt_bil2 = (val(getbody.dispec2) / 100) * netamt>
			<cfset netamt = netamt - newdamt_bil2>
			<cfset newdamt_bil3 = (val(getbody.dispec3) / 100) * netamt>
			<cfset netamt = netamt - newdamt_bil3>
			<cfset newdamt_bil = newdamt_bil1 + newdamt_bil2 + newdamt_bil3>
			<cfset newtaxamt_bil = (val(getbody.taxpec1) / 100) * (newamt1_bil - newdamt_bil)>
			<cfset newamt_bil = newamt1_bil - newdamt_bil + newtaxamt_bil>
			<cfset newamt_bil = numberformat(newamt_bil,".__")>
			<cfset newprice = getbody.price_bil * newcurrate>
			<cfset newamt1 = newamt1_bil * newcurrate>
			<cfset newdamt = newdamt_bil * newcurrate>
			<cfset newtaxamt = newtaxamt_bil * newcurrate>
			<cfset newamt = newamt_bil * newcurrate>
			<cfset newamt = numberformat(newamt,".__")>
			<cfset gross_bil = gross_bil + newamt_bil>
			<cfset gross = gross_bil * newcurrate>
			
			<cfif fr_type eq "DO">
				<cfset dDono=fr_refno>
				<cfset dDodate=dateformat(getbody.wos_date,"yyyy-mm-dd")>
			<cfelse>
				<cfset dDono="">
				<cfset dDodate="0000-00-00">
			</cfif>	
			
			<cfif fr_type eq "SO">
				<cfset dSOno=fr_refno>
				<cfset dSOdate=dateformat(getbody.wos_date,"yyyy-mm-dd")>
			<cfelse>
				<cfset dSOno="">
				<cfset dSOdate="0000-00-00">
			</cfif>
			
			<cfquery datasource="#dts#" name="insertictran">
				Insert into ictran 
				(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,
				`ITEMNO`,`DESP`,`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,
				`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,
				`DISPEC1`,`DISPEC2`,`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,
				`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,
				`QTY`,`PRICE`,`UNIT`,`AMT1`,`DISAMT`,`AMT`,`TAXAMT`,
				`FACTOR1`,`FACTOR2`,`DONO`,`DODATE`,`SODATE`,
				`BREM1`,`BREM2`,`BREM3`,`BREM4`,
				<cfif lcase(hcomid) eq "avent_i">
					`BREM5`,`BREM6`,
				<cfelseif lcase(hcomid) eq "thaipore_i">
					`BREM5`,`BREM7`,`BREM8`,`BREM9`,`BREM10`,
				</cfif>
				`PACKING`,`NOTE1`,`NOTE2`,`GLTRADAC`,
				`UPDCOST`,`GST_ITEM`,`TOTALUP`,`WITHSN`,`NODISPLAY`,`GRADE`,`PUR_PRICE`,
				`QTY1`,`QTY2`,`QTY3`,`QTY4`,`QTY5`,`QTY6`,`QTY7`,
				`QTY_RET`,`TEMPFIGI`,`SERCOST`,`M_CHARGE1`,`M_CHARGE2`,`ADTCOST1`,`ADTCOST2`,`IT_COS`,`AV_COST`,
				`BATCHCODE`,`EXPDATE`,`POINT`,`INV_DISC`,`INV_TAX`,`SUPP`,
				`EDI_COU1`,`WRITEOFF`,`TOSHIP`,`SHIPPED`,`NAME`,`DEL_BY`,`VAN`,
				`GENERATED`,`UD_QTY`,`TOINV`,`EXPORTED`,`EXPORTED1`,`EXPORTED2`,`EXPORTED3`,`BRK_TO`,`SV_PART`,`LAST_YEAR`,`VOID`,
				`SONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`TEMP`,`TEMP1`,
				`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,`TABLENO`,`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,
				`COMMENT`,`DEFECTIVE`,`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,
				`MC6_BIL`,`MC7_BIL`)
				values 
				('#ft_type#','#nextrefno#','#getbody.refno2#','#j#','#getbody.custno#','#readperiod#',#currentdate#,'#newcurrate#','#j#','',
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.agenno#">,	 
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.source#">, 
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.job#">,'', 
				'#val(listgetat(form.fulfill,j))#','#getbody.price_bil#','#getbody.unit_bil#','#newamt1_bil#',
				'#val(getbody.dispec1)#','#val(getbody.dispec2)#','#val(getbody.dispec3)#','#newdamt_bil#','#newamt_bil#',
				'#val(getbody.taxpec1)#','#val(getbody.taxpec2)#','#val(getbody.taxpec3)#','#newtaxamt_bil#','',
				'#val(listgetat(form.fulfill,j))#','#newprice#','#getbody.unit#','#newamt1#','#newdamt#','#newamt#','#newtaxamt#', 
				'1','1',<cfqueryparam cfsqltype="cf_sql_varchar" value="#dDono#">,'#dDodate#','#dSOdate#',
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#brem1#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#brem2#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#brem3#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#brem4#">,
				<cfif lcase(hcomid) eq "avent_i">
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
				<cfelseif lcase(hcomid) eq "thaipore_i">
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
				</cfif>
				'','','','#gltradac#','','N','N','','#nodisplay#','#grade#','0.00',
				'#getbody.qty1#','#getbody.qty2#','#getbody.qty3#','#getbody.qty4#','#getbody.qty5#','#getbody.qty6#','#getbody.qty7#',
				'0.00','','0','#getbody.m_charge1#','#getbody.m_charge2#',#getbody.adtcost1#,#getbody.adtcost2#,'0','0',
				'#getbody.batchcode#','#dateformat(getbody.expdate,"yyyy-mm-dd")#','0','0','0','#getbody.supp#',
				'','0','0','0','#getbody.name#','#getbody.del_by#','#getbody.van#', 
				'','','','','0000-00-00','','0000-00-00','','','','',
				'#dSOno#','#getbody.mc1_bil#','#getbody.mc2_bil#','#huserid#','0','','#getbody.wos_group#','#getbody.category#','#area#','#Shelf#','#Temp#','#Temp1#',
				'','0.00','0','0','#Promoter#','0','#member#','',#Now()#, '#timeformat(Now(),"hh:mm:ss")#', '#bomno#',
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getbody.comment)#">,
				'#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#',
				'#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#')	
			</cfquery>

			<cfif getbody.batchcode neq "">
				<cfif getbody.location neq "">
					<cfquery name="updateobbatch" datasource="#dts#">
						update lobthob set bth_qut=(bth_qut+#val(listgetat(form.fulfill,j))#)
						where location='#getbody.location#' and itemno = '#getbody.itemno#' and batchcode = '#getbody.batchcode#'
					</cfquery>
					<cfquery name="updateobbatch" datasource="#dts#">
						update obbatch set bth_qut=(bth_qut+#val(listgetat(form.fulfill,j))#)
						where itemno = '#getbody.itemno#' and batchcode = '#getbody.batchcode#'
					</cfquery>
				<cfelse>
					<cfquery name="updateobbatch" datasource="#dts#">
						update obbatch set bth_qut=(bth_qut+#val(listgetat(form.fulfill,j))#)
						where itemno = '#getbody.itemno#' and batchcode = '#getbody.batchcode#'
					</cfquery>
				</cfif>
			</cfif>

			<cfif updateqin eq "Y">
				<cfset qname='QIN'&(readperiod+10)>
			</cfif>
			
			<cfif updateqout eq "Y">
				<cfset qname='QOUT'&(readperiod+10)>
			</cfif>
			
			<cfif updateqin eq "Y" or updateqout eq "Y">
				<cfquery name="UpdateIcitem" datasource="#dts#">
					update icitem set #qname#=(#qname#+#val(listgetat(form.fulfill,j))#) where itemno = '#getbody.itemno#'
				</cfquery>
			</cfif>

			<cfquery name="inserticlink" datasource="#dts#">
				insert into iclink 
				values 
				('#ft_type#','#nextrefno#','#j#',
				#currentdate#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_type#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_refno#"> ,'#getbody.trancode#',
				#currentdate#,'#getbody.itemno#','#val(listgetat(form.fulfill,j))#')
			</cfquery>
			
			<cfset newship = getbody.shipped+val(listgetat(form.fulfill,j))>
			
			<cfquery datasource="#dts#" name="updateictran">
				Update ictran set shipped = '#newship#'
				where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_refno#"> 
				and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_type#">
				and itemno = '#getbody.itemno#' and trancode = '#getbody.trancode#'
			</cfquery>
				
			<!--- Step 1:--->
			<cfif form["grdcolumnlist_#fr_type#_#fr_refno#_#xParam2#"] neq "">
				<cfset grdcolumnlist = form["grdcolumnlist_#fr_type#_#fr_refno#_#xParam2#"]>
				<cfset bgrdcolumnlist = form["bgrdcolumnlist_#fr_type#_#fr_refno#_#xParam2#"]>
				<cfset grdvaluelist = form["grdvaluelist_#fr_type#_#fr_refno#_#xParam2#"]>
				<cfset totalrecord = form["totalrecord_#fr_type#_#fr_refno#_#xParam2#"]>
				<cfset myArray = ListToArray(grdcolumnlist,",")>
				<cfset myArray2 = ListToArray(grdvaluelist,",")>
				<cfset myArray3 = ListToArray(bgrdcolumnlist,",")>
					
				<cfquery name="insertigrade" datasource="#dts#">
					insert into igrade
					(type,refno,trancode,itemno,wos_date,fperiod,sign,del_by,location,void,generated,custno,exported,factor1,factor2,
					<cfloop from="1" to="#totalrecord#" index="k">
						<cfif k neq totalrecord>
							#myArray[k]#,
						<cfelse>
							#myArray[k]#
						</cfif>
					</cfloop>
					)
					values
					('#ft_type#','#nextrefno#','#j#','#getbody.itemno#',#currentdate#,'#readperiod#','#dsign#','','#getbody.location#','','',
					'#getbody.custno#','','1', '1',
					<cfloop from="1" to="#totalrecord#" index="k">
						<cfif k neq totalrecord>
							#myArray2[k]#,
						<cfelse>
							#myArray2[k]#
						</cfif>
					</cfloop>)
				</cfquery>
				
				<cfquery name="updateitemgrd" datasource="#dts#">
					update itemgrd
					set
					<cfloop from="1" to="#totalrecord#" index="k">
						<cfif k neq totalrecord>
							#myArray3[k]# = #myArray3[k]#-#myArray2[k]#,
						<cfelse>
							#myArray3[k]# = #myArray3[k]#-#myArray2[k]#
						</cfif>
					</cfloop>
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
				</cfquery>
					
				<cfquery name="updatelogrdob" datasource="#dts#">
					update logrdob
					set
					<cfloop from="1" to="#totalrecord#" index="k">
						<cfif k neq totalrecord>
							#myArray3[k]# = #myArray3[k]#-#myArray2[k]#,
						<cfelse>
							#myArray3[k]# = #myArray3[k]#-#myArray2[k]#	
						</cfif>
					</cfloop>
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
					and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
				</cfquery>
			</cfif><!--- End: Add on 031008, graded item --->	
		</cfloop><!--- BODY END --->
		
		<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
			<cfquery datasource="#dts#" name="updateartran">
				Update ictran set toinv = '#nextrefno#', generated = 'Y'
				where refno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_refno#">
				and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_type#">   
				and itemno = '#xparam1#' and trancode = '#xparam2#'
				and toinv = ''
			</cfquery>
						
			<!--- Step 2:--->
			<cfquery datasource="#dts#" name="updateigrade">
				Update igrade i, ictran ic 
				set i.generated = 'Y'
				where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
				and i.refno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_refno#"> 
				and i.type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_type#">   
				and i.itemno = '#xparam1#' and i.trancode = '#xparam2#'
				and ic.toinv = ''
			</cfquery>
		</cfif>
		
		<cfset j = j + 1>
		
		<cfquery name="getictran" datasource="#dts#">
			select refno from ictran where refno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_refno#">
			and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_type#">
			#msg1#
		</cfquery>

		<cfif getictran.recordcount eq 0>
			<cfquery name="updateartan" datasource="#dts#">
				update artran set toinv = '#nextrefno#', order_cl = 'Y', generated = 'Y' 
				where refno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_refno#">
				and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_type#">   
			</cfquery>
		</cfif>

		<cfoutput><h2>SO no: #fr_refno#,#xparam1# is successfully updated to Invoice No: #nextrefno#</h2></cfoutput>
	</cfloop>

	<cfquery datasource="#dts#" name="getheader">
		Select * from artran 
		where refno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_refno#">
		and type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr_type#">
	</cfquery>

	<cfif getheader.currcode eq ''>
		<cfquery name="getcurrcode" datasource="#dts#">
			select currcode from #ptype# where custno = '#getheader.custno#'
		</cfquery>

		<cfset xCurrCode = getcurrcode.currcode>
	<cfelse>
		<cfset xCurrCode = getheader.currcode>
	</cfif>

	<cfquery name="currency" datasource="#dts#">
		select #currperiod# as rate 
		from #target_currency# 
		where currcode = '#xCurrCode#'
	</cfquery>

	<cfif currency.rate neq "">
		<cfset newcurrate = currency.rate>
	<cfelse>
		<cfset newcurrate = 1>
	</cfif>

	<cfif getheader.disp1 neq 0 and getheader.disp1 neq "">
		<cfset xdisp1 = getheader.disp1>
	<cfelse>
		<cfset xdisp1 = 0>
	</cfif>

	<cfif getheader.disp2 neq 0 and getheader.disp2 neq "">
		<cfset xdisp2 = getheader.disp2>
	<cfelse>
		<cfset xdisp2 = 0>
	</cfif>

	<cfif getheader.disp3 neq 0 and getheader.disp3 neq "">
		<cfset xdisp3 = getheader.disp3>
	<cfelse>
		<cfset xdisp3 = 0>
	</cfif>

	<cfif getheader.taxp1 neq 0 and getheader.taxp1 neq "">
		<cfset xtaxp1 = getheader.taxp1>
	<cfelse>
		<cfset xtaxp1 = 0>
	</cfif>

	<cfset disc1_bil = gross_bil * xdisp1/100>
	<cfset net1_bil = gross_bil - disc1_bil>
	<cfset disc2_bil = net1_bil * xdisp2/100>
	<cfset net1_bil = net1_bil - disc2_bil>
	<cfset disc3_bil = net1_bil * xdisp3/100>

	<cfif val(disc1_bil) eq 0 and val(disc2_bil) eq 0 and val(disc3_bil) eq 0 and val(getheader.disc_bil) neq 0>
		<cfset disc_bil = getheader.disc_bil>
	<cfelse>
		<cfset disc_bil = disc1_bil + disc2_bil + disc3_bil>
	</cfif>

	<cfset discount1 = val(disc1_bil) * newcurrate>
	<cfset discount2 = val(disc2_bil) * newcurrate>
	<cfset discount3 = val(disc3_bil) * newcurrate>
	<cfset discount = val(disc_bil) * newcurrate>
	<cfset net_bil = gross_bil - val(disc_bil)>
	<cfset net = net_bil * newcurrate>
	<cfset tax1_bil = net_bil * xtaxp1/100>
	<cfset tax1 = tax1_bil * newcurrate>
	<cfset tax_bil = tax1_bil>
	<cfset tax = tax1>
	<cfset grand_bil = net_bil + tax_bil>
	<cfset grand_bil = numberformat(grand_bil,".__")>
	<cfset grand = grand_bil * newcurrate>
	<cfset grand = numberformat(grand,".__")>
	
	<cfif lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i">
		<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getheader.rem9#" returnvariable="getheader.rem9"/>
		<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getheader.rem11#" returnvariable="getheader.rem11"/>
    </cfif>
		
	<!--- Create a new transaction --->
	<cfquery datasource="#dts#" name="insertartran">
		Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,
		currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,
		tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax2,
		tax3,tax,taxp1,taxp2,taxp3,grand,note,term,van,pono,dono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
		rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
		trdatetime,userid,currcode,
		m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
		created_by,created_on,updated_by,updated_on
		<cfif lcase(hcomid) eq 'iel_i'>
			,rem15,rem16,rem17,rem18,rem19,rem20,rem21,rem22,rem23,rem24,rem25
		</cfif>)

		values
			
		('#ft_type#','#nextrefno#','#getheader.refno2#','#getheader.custno#','#readperiod#',#currentdate#,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.desp#">,'#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#',
		'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#tax1_bil#',
		'#getheader.tax2_bil#','#getheader.tax3_bil#','#tax_bil#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
		'#discount1#','#discount2#','#discount3#','#discount#',
		'#net#','#tax1#','#getheader.tax2#','#getheader.tax3#','#tax#','#xtaxp1#','#getheader.taxp2#',
		'#getheader.taxp3#','#grand#','#getheader.note#','#getheader.term#','#getheader.van#',
		<cfif getheader.pono neq '' and getheader.pono neq 'NIL'>'#getheader.pono#'<cfelse>'#fr_refno#'</cfif>,'#getheader.dono#','#getheader.rem0#','#getheader.rem1#', '#getheader.rem2#','#getheader.rem3#',
		'#getheader.rem4#','#getheader.rem5#',
		'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
		'#getheader.rem11#', '#getheader.rem12#','#getheader.frem0#', '#getheader.frem1#', '#getheader.frem2#', '#getheader.frem3#', '#getheader.frem4#',
		'#getheader.frem5#', '#getheader.frem6#', '#getheader.frem7#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
		'#getheader.comm0#', '#getheader.comm1#', '#getheader.comm2#', '#getheader.comm3#', '#getheader.comm4#',
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.name#">,'#getheader.phonea#',
		#Now()#, '#HUserID#','#getheader.currcode#',
		'#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#',
		'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#','#getheader.special_account_code#',
		'#HUserID#',#now()#,'#HUserID#',#now()#
		<cfif lcase(hcomid) eq 'iel_i'>
			,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem15#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem16#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem17#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem18#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem19#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem20#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem21#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem22#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem23#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem24#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem25#">
		</cfif>)
	</cfquery>
<!--- UPDATETYPE:2 @ UPDATE BY ITEM BY ALL QUANTITY --->
<cfelseif updatetype eq "2">

<!--- UPDATETYPE:3 @ UPDATE BY BILL --->
<cfelseif updatetype eq "3">

</cfif>
</body>
</html>