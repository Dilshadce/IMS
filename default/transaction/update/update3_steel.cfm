<cfset tranarun = "rcarun">

<cfif isdefined("form.selectedrefno")>
	<cfparam name="gross" default="0">
	<cfparam name="gross_bil" default="0">
	<cfparam name="lastpono" default="">
	<cfparam name="updatepono" default="">

	<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" returnvariable="readperiod"/>
	
	<cfset selectedrefno=listgetat(form.selectedrefno,1,";")>
	<cfset custno=listgetat(form.selectedrefno,2,";")>
	<cfset nDateNow=dateformat(now(),"YYYY-MM-DD")>
	<cfset currperiod = "CurrP" & val(readperiod)>
	<cfset ptype = target_apvend>
	<cfset type = "Purchase Order">
	<cfset mylist= listchangedelims(checkbox,"",",")>
	<cfset cnt=listlen(mylist,";")>
	<cfset j = 1>
	<cfset k = 1>
	
	<cfquery datasource="#dts#" name="getGeneralInfo">
		Select #trancode# as tranno, #tranarun# as arun from GSetup
	</cfquery>
	
	<cfif getGeneralInfo.arun eq "1" and selectedrefno eq "new">
		<cfinvoke component="cfc.incrementValue" method="getIncreament" input="#getGeneralInfo.tranno#" returnvariable="nexttranno"/>
	<cfelseif getGeneralInfo.arun eq "1" and selectedrefno neq "new">
		<cfset nexttranno=selectedrefno>
	<cfelseif getGeneralInfo.arun neq "1" and selectedrefno neq "new">
		<cfset nexttranno=selectedrefno>
	<cfelse>
		<cfset nexttranno= form.nextrefno>
	</cfif>
	
	<cfif selectedrefno eq "new">
		<cfquery datasource="#dts#" name="updategsetup">
			Update Gsetup set rcno = UPPER("#nexttranno#")
		</cfquery>
		
		<cfquery datasource="#dts#" name="getCode">
			Select currcode from artran where refno='#listgetat(mylist,1,";")#' and type='PO'
		</cfquery>
	<cfelse>
		<cfquery datasource="#dts#" name="getCode">
			Select currcode from artran where refno='#nexttranno#' and type='PR'
		</cfquery>
		
		<cfquery datasource="#dts#" name="getMaxCnt">
			Select itemcount from ictran 
			where type='RC' and refno='#nexttranno#' and custno='#custno#'
			order by itemcount desc limit 1
		</cfquery>
		<cfif getMaxCnt.recordcount eq 1>
			<cfset j=getMaxCnt.itemcount+1>
		<cfelse>
			<cfset j=1>
		</cfif>
	</cfif>
	
	<cfif getCode.currcode eq ''>
		<cfquery name="getcurrcode" datasource="#dts#">
			select currcode from #ptype# where custno='#custno#'
		</cfquery>

		<cfset xCurrCode = getcurrcode.currcode>
	<cfelse>
		<cfset xCurrCode = getCode.currcode>
	</cfif>

	<cfquery name="getRate" datasource="#dts#">
		select #currperiod# as rate 
		from #target_currency# 
		where currcode='#xCurrCode#'
	</cfquery>

	<cfif getRate.rate neq "">
		<cfset newcurrate = getRate.rate>
	<cfelse>
		<cfset newcurrate = 1>
	</cfif>
			
	<cfloop from="1" to="#cnt#" index="i" step="+3">
		<cfif LastPONO neq listgetat(mylist,i,";")>
			<cfif updatepono eq ''>
				<cfset updatepono = listgetat(mylist,i,";")>
			<cfelse>
				<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
			</cfif>
			<cfset LastPONO = listgetat(mylist,i,";")>
		</cfif>
		
		<cfset xParam1 = listgetat(mylist,i,";")>

		<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			<cfset xParam2 = ''>
		<cfelse>
			<cfset xParam2 = listgetat(mylist,i+1,";")>
		</cfif>

		<cfset xParam3 = listgetat(mylist,i+2,";")>

		<cfquery datasource="#dts#" name="getbody">
			Select * 
			from ictran i where refno='#xParam1#' and itemno='#xParam2#' and trancode='#xParam3#'
			and shipped < qty and type='PO'
		</cfquery>
		
		<cfloop query="getbody">
			<cfset newamt1_bil = listgetat(fulfill,k) * getbody.price_bil>
			<cfset newdamt_bil1 = (val(getbody.dispec1)/100) * newamt1_bil>
			<cfset netamt = newamt1_bil - newdamt_bil1>
			<cfset newdamt_bil2 = (val(getbody.dispec2)/100) * netamt>
			<cfset netamt = netamt - newdamt_bil2>
			<cfset newdamt_bil3 = (val(getbody.dispec3)/100) * netamt>
			<cfset netamt = netamt - newdamt_bil3>
			<cfset newdamt_bil = newdamt_bil1 + newdamt_bil2 + newdamt_bil3>
			<cfset newtaxamt_bil = (val(getbody.taxpec1)/100) * (newamt1_bil - newdamt_bil)>
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
			<!--- PO TO RC --->
			<cfquery datasource="#dts#" name="insertictran">
				Insert into ictran (TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, wos_DATE,
				CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA,
				AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL,
				UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3,
				DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3,
				TAXAMT_BIL, IMPSTAGE, QTY, PRICE, UNIT,
				AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE,
				SODATE, BREM1, BREM2, BREM3, BREM4, PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST,
				GST_ITEM, TOTALUP, WITHSN, GRADE, PUR_PRICE, QTY1, QTY2, QTY3, QTY4, QTY5, QTY6,
				QTY7, QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1,ADTCOST2,
				IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1,
				WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED,
				EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL,
				MC2_BIL, USERID, DAMT, OLDBILL, wos_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1,
				BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME,
				TIME, BOMNO, DEFECTIVE,comment,M_CHARGE3,M_CHARGE4,M_CHARGE5,M_CHARGE6,M_CHARGE7,MC3_BIL,MC4_BIL,MC5_BIL,MC6_BIL,MC7_BIL)

				values ('RC', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#', '#ndatenow#',
				'#newcurrate#', '#j#', '', '#getbody.itemno#', '#getbody.desp#', '#getbody.despa#',
				'#agenno#',	 '#getbody.location#', '#getbody.source#', '#getbody.job#', '', '#listgetat(form.fulfill,k)#', '#getbody.price_bil#',
				'#unit_bil#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
				'#newdamt_bil#', '#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#',
				'#newtaxamt_bil#', '', '#listgetat(form.fulfill,k)#', '#newprice#', '#unit#',
				'#newamt1#', '#newdamt#', '#newamt#', '#newtaxamt#', '', '',
				'#listgetat(mylist,i,";")#','#dateformat(getbody.dodate,"yyyy-mm-dd")#','#dateformat(getbody.wos_date,"yyyy-mm-dd")#', '#brem1#', '#brem2#', '#brem3#', '#brem4#', '#packing#', '#note1#', '#note2#',
				'#gltradac#', '', 'N', 'N', '', '#grade#', '0.00', '1', '2', '3','4', '5', '6', '7', '0.00', '', '', '#getbody.m_charge1#', '#getbody.m_charge2#',
				'#getbody.adtcost1#', '#getbody.adtcost2#', '', '',	'#getbody.batchcode#','#dateformat(getbody.expdate,"yyyy-mm-dd")#', '', '', '', '', '', '', '', '',
				'#name#', '0', '#van#', 'Y', '', '', '', '', '', '', '', '', '', '','#listgetat(mylist,i,";")#',
				'#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '', '', '#getbody.wos_group#', '#getbody.category#', '#Area#', '#Shelf#', '#Temp#', '#Temp1#',
				'', '0.00', '0', '0', '#Promoter#', '0',
				'#member#', '', #Now()#, 'Time', '#BOMNO#', '#getbody.defective#',

				<cfset CommentLen = len(tostring(getbody.comment))>
				<cfset xComment = tostring(getbody.comment)>
				<cfset SingleQ = ''>
				<cfset DoubleQ = ''>

				<cfloop index = "Count" from = "1" to = "#CommentLen#">
					<cfif mid(xComment,Count,1) eq "'">
						<cfset SingleQ = 'Y'>
					<cfelseif mid(xComment,Count,1) eq '"'>
						<cfset DoubleQ = 'Y'>
					</cfif>
				</cfloop>

				<cfif SingleQ eq 'Y' and DoubleQ eq ''>
					<!--- Found ' in the comment --->
					"#tostring(getbody.comment)#",'#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#')
				<cfelseif SingleQ eq '' and DoubleQ eq 'Y'>
					<!--- Found " in the comment --->
					'#tostring(getbody.comment)#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#')
				<cfelseif SingleQ eq '' and DoubleQ eq ''>
					'#tostring(getbody.comment)#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#')
				<cfelse>
					'','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#')
				</cfif>
			</cfquery>

			<cfif getbody.batchcode neq "">
				<cfif getbody.location neq "">
					<cfquery name="updateobbatch" datasource="#dts#">
						update lobthob set bth_qin=(bth_qin+'#listgetat(form.fulfill,k)#'),rc_type = 'RC', rc_refno = '#nexttranno#', rc_expdate = #getbody.expdate#
						where location='#getbody.location#' and itemno = '#getbody.itemno#' and batchcode = '#getbody.batchcode#'
					</cfquery>
					<cfquery name="updateobbatch" datasource="#dts#">
						update obbatch set bth_qin=(bth_qin+'#listgetat(form.fulfill,k)#'),rc_type = 'RC', rc_refno = '#nexttranno#', rc_expdate = #getbody.expdate#
						where itemno = '#getbody.itemno#' and batchcode = '#getbody.batchcode#'
					</cfquery>
				<cfelse>
					<cftry>
					<cfquery name="updateobbatch" datasource="#dts#">
						update obbatch set bth_qin=(bth_qin+'#listgetat(form.fulfill,k)#'),rc_type = 'RC', rc_refno = '#nexttranno#', rc_expdate = #getbody.expdate#
						where itemno = '#getbody.itemno#' and batchcode = '#getbody.batchcode#'
					</cfquery>
					<cfcatch type="database"></cfcatch>
					</cftry>
				</cfif>
			</cfif>

			<cfquery name="inserticlink" datasource="#dts#">
				insert into iclink values ('RC','#nexttranno#','#j#',
				'#ndatenow#','PO','#listgetat(mylist,i,";")#','#getbody.trancode#',
				#getbody.wos_date#,'#getbody.itemno#','#listgetat(form.fulfill,k)#')
			</cfquery>

			<cfset newship = getbody.shipped + listgetat(form.fulfill,k)>

			<cfquery datasource="#dts#" name="updateictran">
				Update ictran set shipped = '#newship#'
				where refno = '#xparam1#' and itemno = '#xparam2#' and trancode = '#xparam3#'
				and toinv = '' and type = 'PO'
			</cfquery>

			<cfset qname='QIN'&(readperiod+10)><!--- <cfoutput>#qname#--#getbody.qty#</cfoutput> --->

			<cfquery name="UpdateIcitem" datasource="#dts#">
				update icitem set #qname#=(#qname#+#listgetat(form.fulfill,k)#) where itemno = '#getbody.itemno#'
			</cfquery>
		</cfloop>

		<cfif listgetat(form.fulfill,k) gte listgetat(form.qtytoful,k)>
			<cfquery datasource="#dts#" name="updateartran">
				Update ictran set toinv = '#nexttranno#', generated = 'Y'
				where refno = '#listgetat(mylist,i,";")#' and itemno = '#xParam2#'
				and toinv = '' and type = 'PO' and trancode = '#xparam3#'
			</cfquery>
		</cfif>

		<cfset j = j + 1>
		<cfset k = k + 1>
		
		<cfquery name="getictran" datasource="#dts#">
			select refno from ictran where refno = '#listgetat(mylist,i,";")#' and shipped < qty and type = 'PO'
		</cfquery>

		<cfif getictran.recordcount eq 0>
			<cfquery name="updateartan" datasource="#dts#">
				update artran set toinv = '#nexttranno#', order_cl = 'Y', generated = 'Y' where refno = '#listgetat(mylist,i,";")#' and type = 'PO'
			</cfquery>
		</cfif>
	</cfloop>
	
	<cfif listgetat(form.selectedrefno,1,";") eq "new">
		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'PO'
		</cfquery>
		
		<cfif getheader.disp1 neq 0 and  getheader.disp1 neq "">
			<cfset xdisp1 = getheader.disp1>
		<cfelse>
			<cfset xdisp1 = 0>
		</cfif>
	
		<cfif getheader.disp2 neq 0 and  getheader.disp2 neq "">
			<cfset xdisp2 = getheader.disp2>
		<cfelse>
			<cfset xdisp2 = 0>
		</cfif>
	
		<cfif getheader.disp3 neq 0 and  getheader.disp3 neq "">
			<cfset xdisp3 = getheader.disp3>
		<cfelse>
			<cfset xdisp3 = 0>
		</cfif>
	
		<cfif getheader.taxp1 neq 0 and  getheader.taxp1 neq "">
			<cfset xtaxp1 = getheader.taxp1>
		<cfelse>
			<cfset xtaxp1 = 0>
		</cfif>
	
		<cfset disc1_bil = gross_bil * xdisp1/100>
		<cfset net1_bil = gross_bil - disc1_bil>
		<cfset disc2_bil = net1_bil * xdisp2/100>
		<cfset net1_bil = net1_bil - disc2_bil>
		<cfset disc3_bil = net1_bil * xdisp3/100>
	
		<cfif disc1_bil eq 0 and disc2_bil eq 0 and disc3_bil eq 0 and getheader.disc_bil neq 0>
			<cfset disc_bil = getheader.disc_bil>
		<cfelse>
			<cfset disc_bil = disc1_bil + disc2_bil + disc3_bil>
		</cfif>
	
		<cfset discount1 = disc1_bil * newcurrate>
		<cfset discount2 = disc2_bil * newcurrate>
		<cfset discount3 = disc3_bil * newcurrate>
		<cfset discount = disc_bil * newcurrate>
		<cfset net_bil = gross_bil - disc_bil>
		<cfset net = net_bil * newcurrate>
		<cfset tax1_bil = net_bil * xtaxp1/100>
		<cfset tax1 = tax1_bil * newcurrate>
		<cfset tax_bil = tax1_bil>
		<cfset tax = tax1>
		<cfset grand_bil = net_bil + tax_bil>
		<cfset grand_bil = numberformat(grand_bil,".__")>
		<cfset grand = grand_bil * newcurrate>
		<cfset grand = numberformat(grand,".__")>
	
		<!--- PO TO RC --->
		<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,
			desp,despa,agenno,area,source,job,
			currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,
			tax3_bil,tax_bil,grand_bil,invgross,disp1,disp2,disp3,
			discount1,discount2,discount3,discount,net,tax1,tax2,tax3,tax,
			taxp1,taxp2,taxp3,grand,note,term,van,pono,dono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
			rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,trdatetime,userid,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code)
	
			values('RC','#nexttranno#','#getheader.refno2#','#getheader.custno#','#readperiod#','#ndatenow#',
			'#getheader.desp#','#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#','#getheader.job#',
			'#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#tax1_bil#','#getheader.tax2_bil#',
			'#getheader.tax3_bil#','#tax_bil#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#','#net#','#tax1#','#getheader.tax2#','#getheader.tax3#','#tax#',
			'#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#','#getheader.term#','#getheader.van#',
			<cfif getheader.pono neq ''>'#getheader.pono#'<cfelse>'#updatepono#'</cfif>,'#getheader.dono#','#getheader.rem0#','#getheader.rem1#', '#getheader.rem2#','#getheader.rem3#',
			'#getheader.rem4#','#getheader.rem5#',
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			'#getheader.rem11#', '#getheader.rem12#','#getheader.frem0#', '#getheader.frem1#', '#getheader.frem2#', '#getheader.frem3#', '#getheader.frem4#',
			'#getheader.frem5#', '#getheader.frem6#', '#getheader.frem7#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getheader.comm0#', '#getheader.comm1#', '#getheader.comm2#', '#getheader.comm3#', '#getheader.comm4#',
			'#getheader.name#',#Now()#, '#HUserID#','#getheader.currcode#',
			'#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#',
			'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#','#getheader.special_account_code#')
		</cfquery>
	<cfelse>
		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno='#nexttranno#' and type='#url.t2#'
		</cfquery>
	
		<cfif getheader.disp1 neq 0 and  getheader.disp1 neq "">
			<cfset xdisp1 = getheader.disp1>
		<cfelse>
			<cfset xdisp1 = 0>
		</cfif>
	
		<cfif getheader.disp2 neq 0 and  getheader.disp2 neq "">
			<cfset xdisp2 = getheader.disp2>
		<cfelse>
			<cfset xdisp2 = 0>
		</cfif>
	
		<cfif getheader.disp3 neq 0 and  getheader.disp3 neq "">
			<cfset xdisp3 = getheader.disp3>
		<cfelse>
			<cfset xdisp3 = 0>
		</cfif>
	
		<cfif getheader.taxp1 neq 0 and  getheader.taxp1 neq "">
			<cfset xtaxp1 = getheader.taxp1>
		<cfelse>
			<cfset xtaxp1 = 0>
		</cfif>
		
		<cfset disc1_bil = gross_bil*xdisp1/100>
		<cfset disc1_bildb = disc1_bil+val(getheader.disc1_bil)>
		<cfset net1_bil = gross_bil - disc1_bil>
		<cfset disc2_bil = net1_bil*xdisp2/100>
		<cfset disc2_bildb = disc2_bil+val(getheader.disc2_bil)>
		<cfset net1_bil = net1_bil - disc2_bil>
		<cfset disc3_bil = net1_bil*xdisp3/100>
		<cfset disc3_bildb = disc3_bil+val(getheader.disc3_bil)>
	
		<cfif disc1_bil eq 0 and disc2_bil eq 0 and disc3_bil eq 0 and getheader.disc_bil neq 0>
			<cfset disc_bil = getheader.disc_bil>
		<cfelse>
			<cfset disc_bil = getheader.disc_bil+disc1_bil+disc2_bil+disc3_bil>
		</cfif>
	
		<cfset discount1 = getheader.discount1+(disc1_bil*newcurrate)>
		<cfset discount2 = getheader.discount2+(disc2_bil*newcurrate)>
		<cfset discount3 = getheader.discount3+(disc3_bil*newcurrate)>
		<cfset discount = getheader.discount+(disc_bil*newcurrate)>
		<cfset net_bil = getheader.net_bil+(gross_bil-disc_bil)>
		<cfset net = net_bil * newcurrate>
		<cfset tax1_bil = net_bil * xtaxp1/100>
		<cfset tax1 = tax1_bil * newcurrate>
		<cfset tax_bil = tax1_bil>
		<cfset tax = tax1>
		<cfset grand_bil = numberformat((net_bil+tax_bil),".__")>
		<cfset grand = numberformat((grand_bil*newcurrate),".__")>
	
		<!--- PO TO RC --->
		<cfquery datasource="#dts#" name="updateArtran">
			update artran set 
			gross_bil='#(getheader.gross_bil+gross_bil)#',
			disc1_bil='#disc1_bildb#',
			disc2_bil='#disc2_bildb#',
			disc3_bil='#disc3_bildb#',
			disc_bil='#disc_bil#',
			net_bil='#net_bil#',
			tax1_bil='#tax1_bil#',
			tax_bil='#tax_bil#',
			grand_bil='#grand_bil#',
			invgross='#(getheader.invgross+gross)#',
			discount1='#discount1#',
			discount2='#discount2#',
			discount3='#discount3#',
			discount='#discount#',
			net='#net#',
			tax1='#tax1#',
			tax='#tax#',
			grand='#grand#',
			trdatetime=#Now()#, 
			userid='#HUserID#'
			<cfif getheader.pono eq ''>,pono='#updatepono#'</cfif>
			where type='RC' and refno='#nexttranno#' and custno='#custno#'
		</cfquery>
	</cfif>
<cfelse><!--- before click save --->
	<cfif checkbox neq "">
		<cfset mylist= listchangedelims(checkbox,"",",")>
		
		<cfquery datasource="#dts#" name="getGeneralInfo">
			Select #trancode# as tranno, #tranarun# as arun from GSetup
		</cfquery>
	
		<cfquery name="getSupplier" datasource="#dts#">
			select custno
			from artran 
			where refno='#listgetat(mylist,1,";")#' and type='PO' limit 1
		</cfquery>
		
		<cfquery name="getList" datasource="#dts#">
			select refno,agenno,wos_date,userid 
			from artran 
			where custno='#getSupplier.custno#' and type='RC'
			order by refno
		</cfquery>
		
		<!--- Validate Previous Data --->
		<cfif getGeneralInfo.arun neq "1">
			<cfif form.nextrefno neq ''>
				<cfquery name="checkexist" datasource="#dts#">
					select refno from artran where type='#t2#' and refno='#nextrefno#'
				</cfquery>
		
				<cfif checkexist.recordcount gt 0>
					<h3>Error. This reference no. have been created. Please click back and re-enter another reference no.</h3>
					<cfabort>
				</cfif>
				<cfset nexttranno= form.nextrefno>
			<cfelse>
				<h3>Error. Please click back to enter the Next Refno.</h3>
				<cfabort>
			</cfif>
		</cfif>
	
		<cfloop from="1" to="#listlen(form.fulfill)#" index="i">
			<cfif listgetat(form.fulfill,i) gt listgetat(form.qtytoful,i)>
				<h3>Error. The qty to fulfill is greater than the outstanding qty.</h3>
				<cfabort>
			</cfif>
		</cfloop>
	<cfelse>
		<h3>Error. Please select item.</h3>
		<cfabort>
	</cfif>
</cfif>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Update PO to RC</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link rel="stylesheet" href="../../../stylesheet/stylesheet.css"/>
</head>
<script language="javascript">
	function chckControl(id){
		var ttlrow=document.rcform.selectedrefno.length
		for(a=0;a<ttlrow;a++){
			document.rcform.selectedrefno[a].checked=false;
		}
		document.getElementById(id).checked=true;
	}	
</script>
<body>
	<cfif not isdefined("form.selectedrefno")>
		<cfoutput>
		<form name="rcform" action="update3_steel.cfm?t1=#t1#&t2=#t2#&trancode=#trancode#" method="post">
		<input type="hidden" name="checkbox" value="#checkbox#">
		<input type="hidden" name="fulfill" value="#fulfill#">
		<input type="hidden" name="qtytoful" value="#qtytoful#">
		<input type="hidden" name="batchcode" value="#batchcode#">
		<cfif getGeneralInfo.arun neq "1">
			<input type="hidden" name="nextrefno" value="#nextrefno#">
		</cfif>
		<table class="data" align="center">
		<tr>
			<th>Purchase Receive No</th>
			<th>Agent</th>
			<th>Date</th>
			<th>User</th>
			<th>To Bill</th>
		</tr>
		<tr>
			<td colspan="4">New Purchase Receive</td>
			<td><input id="0" type="checkbox" name="selectedrefno" value="new;#getSupplier.custno#" onClick="chckControl(this.id)" checked></td>
		</tr>
		<cfloop query="getList">
		<tr>
			<td>#getList.refno#</td>
			<td>#getList.agenno#</td>
			<td>#dateformat(getList.wos_date,"dd/mm/yyyy")#</td>
			<td>#userid#</td>
			<td><input id="#getList.currentrow#" type="checkbox" name="selectedrefno" value="#refno#;#getSupplier.custno#" onClick="chckControl(this.id)" onMouseOver="window.status='#refno#`#getSupplier.custno#'"></td>
		</tr>
		</cfloop>
		<tr>
			<td align="right" colspan="5">
				<input type="button" name="back" value="Back" onClick="window.history.back();">
				<input type="submit" name="submit" value="Save">
			</td>
		</tr>
		</table>
		</form>
		</cfoutput>
	<cfelse>
		Transaction Update Summary<br><br>
		<table border="0" class="data" align="center">
		<tr>
			<th>Purchase Order No (From)</th>
			<th width="30%">Itemno</th>
			<th>Purchase Receive No (To)</th>
			<th>Update Status</th>
		</tr>
		<cfoutput>
		<cfloop from="1" to="#cnt#" index="i" step="+3">
		<tr valign="middle">
			<td>#listgetat(mylist,i,";")#</td>
			<td>#listgetat(form.checkbox,i+1,";")#</td>
			<td>#nexttranno#</td>
			<td align="center"><font color="red">Successful</font></td>
		</tr>
		</cfloop>
		</table>
		<a href="update.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#">Click Here to update more #t1#</a>
		</cfoutput>
	</cfif>
	
</body>
</html>
