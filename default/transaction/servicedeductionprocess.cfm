<cfset taxcharge = 0 >
<cfset totaltaxcharge = 0 >

<html>
<head>
<title>Create Service Deduction</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getusername" datasource="main">
    select username from users where userid='#huserid#' and userbranch='#dts#'
</cfquery>

<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM,lRQ

	from GSetup
</cfquery>

<!--- Calculate the period --->
<cfparam name="gross" default="0">
<cfparam name="gross_bil" default="0">
<cfparam name="lastpono" default="">
<cfparam name="updatepono" default="">

<cfset nDateNow=dateformat(now(),"YYYY-MM-DD")>

<cfquery datasource="#dts#" name="getGsetup">
  	Select * from GSetup
</cfquery>

<cfset lastaccyear = dateformat(getGsetup.lastaccyear, "YYYY-MM-DD")>
<cfset period = '#getGsetup.period#'>
<cfset currentdate = dateformat(now(),"YYYY-MM-DD")>
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
		
<cfif isdefined("form.f_cdate") and form.f_cdate neq "">
	<!--- <cfset ndatenow = lsdateformat(form.f_cdate, 'yyyy-mm-dd')> --->
	<cfinvoke component="cfc.Date" method="getDbDate" inputDate="#form.f_cdate#" returnvariable="nDateNow"/>
    <cfset ndate = createdate(right(form.f_cdate,4),mid(form.f_cdate,4,2),left(form.f_cdate,2))>
	<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndate,'yyyy-mm-dd')#" returnvariable="readperiod"/>
</cfif>

<cfif readperiod eq "99">
	<h3>Period 99 Not Allowed. Please Check Your Date.</h3><cfabort>
</cfif>

<cfset currperiod = "CurrP" & val(readperiod)>

	<cfset tranarun = "samarun">

	<cfset ptype = target_arcust>

<cfquery datasource="#dts#" name="getGeneralInfo">
	select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse from refnoset
	where type = 'SAM'
	and counter = '1'
</cfquery>

<cfif getGeneralInfo.arun eq "1">
	<cfset refnocnt = len(getGeneralInfo.tranno)>
	<cfset cnt = 0>
	<cfset yes = 0>

		<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
		<cfset nexttranno = newnextNum>
	
        <cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum1" />
        <cfset actual_nexttranno = newnextNum1>
        <cfif (getGeneralInfo.refnocode2 neq "" or getGeneralInfo.refnocode neq "") and getGeneralInfo.presuffixuse eq "1">
            <cfset nexttranno = getGeneralInfo.refnocode&actual_nexttranno&getGeneralInfo.refnocode2>
        <cfelse>
            <cfset nexttranno = actual_nexttranno>
        </cfif>	

	<cftry>
		<cfquery name="checkexist" datasource="#dts#">
			select refno from artran where type = 'SAM' and refno = <cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
		</cfquery>
	<cfcatch type="any">
		<cfoutput>#cfcatch.Message#::#cfcatch.Detail#</cfoutput><cfabort>
	</cfcatch>
	</cftry>
	
	<cfif checkexist.recordcount gt 0>
		<h3>Error. This reference no. have been created. Please change the Last Used No.</h3>
		<cfabort>
	</cfif>
<cfelse>
	<cfif form.nextrefno neq ''>
		<cfquery name="checkexist" datasource="#dts#">
			select refno from artran where type = 'SAM' and refno = '#nextrefno#'
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

		<cfset type = gettranname.lSAM>
        
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = 'SAM'
			and counter =  '1'
		</cfquery>

		<cfset j = 1>
		
        <cfquery datasource="#dts#" name="getbody">
        		select a.* from ictran as a
left join(select sum(qty) as updatedqty,trancode,frrefno,frtype from servicededuct where type='SAM' and frtype='INV' and frrefno='#form.refno#' group by itemno)as b on a.trancode=b.trancode and a.type=b.frtype and a.refno=b.frrefno
where a.refno='#form.refno#' and a.type='INV' and a.qty-ifnull(b.updatedqty,0) > 0 and a.deductableitem = 'Y'
		</cfquery>

			<cfloop query="getbody">
            
            <cfset fulfillqty=evaluate('form.fulfillqty_#getbody.trancode#')>
        
        	<cfif fulfillqty gt 0>
            
			  	<cfquery datasource="#dts#" name="getheader">
					Select currcode,custno from artran where refno = '#form.refno#' and type = 'SAM'
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

				<!--- Add On 061008, 2nd Unit Function --->
				<cfif val(getbody.factor1) neq 0>
					<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
				<cfelse>
					<cfset getbody.price_bil = 0>
				</cfif>
				
				<cfset newamt1_bil = fulfillqty * getbody.price_bil>
				
				<!--- <cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil> --->
				<cfset newdamt_bil1 = (val(getbody.dispec1) / 100) * newamt1_bil>
				<cfset netamt = newamt1_bil - newdamt_bil1>
				<cfset newdamt_bil2 = (val(getbody.dispec2) / 100) * netamt>
				<cfset netamt = netamt - newdamt_bil2>
				<cfset newdamt_bil3 = (val(getbody.dispec3) / 100) * netamt>
				<cfset netamt = netamt - newdamt_bil3>
				<cfset newdamt_bil = newdamt_bil1 + newdamt_bil2 + newdamt_bil3>
				    <cfif getbody.taxincl neq "T">
				<cfset newtaxamt_bil = (val(getbody.taxpec1) / 100) * (val(newamt1_bil) - val(newdamt_bil))>
                <cfelse>
                <cfset newtaxamt_bil = ((val(newamt1_bil) - val(newdamt_bil)) * val(getbody.taxpec1))/(100+val(getbody.taxpec1)) >
				</cfif>
                
                <cfif getbody.taxincl neq "T">
                <cfset taxcharge = taxcharge + newtaxamt_bil>
				</cfif>
                <cfset totaltaxcharge = totaltaxcharge + newtaxamt_bil>
				<!--- <cfset newamt_bil = newamt1_bil - newdamt_bil + newtaxamt_bil> --->
                <cfset newamt_bil = newamt1_bil - newdamt_bil>
				<cfset newamt_bil = numberformat(newamt_bil,".__")>
				<cfset newprice = getbody.price_bil * newcurrate>
				<cfset newamt1 = newamt1_bil * newcurrate>
				<cfset newdamt = newdamt_bil * newcurrate>
				<cfset newtaxamt = newtaxamt_bil * newcurrate>
				<cfset newamt = newamt_bil * newcurrate>
				<cfset newamt = numberformat(newamt,".__")>
				<cfset gross_bil = gross_bil + newamt_bil>
				<cfset gross = gross_bil * newcurrate>
                
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.dodate#" returnvariable="getbody.dodate"/>
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
                
				<!--- SO TO INV --->
				<cfquery datasource="#dts#" name="insertictran">
					Insert into ictran 
					(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
					`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
					`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
					`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,
					`PACKING`,`NOTE1`,
					`NOTE2`,`GLTRADAC`,`UPDCOST`,`GST_ITEM`,`TOTALUP`,`WITHSN`,`GRADE`,`PUR_PRICE`,
					`QTY_RET`,`TEMPFIGI`,`SERCOST`,`M_CHARGE1`,`M_CHARGE2`,`ADTCOST1`,`ADTCOST2`,`IT_COS`,`AV_COST`,
					`BATCHCODE`,`EXPDATE`,`POINT`,`INV_DISC`,`INV_TAX`,`SUPP`,`EDI_COU1`,`WRITEOFF`,`TOSHIP`,`SHIPPED`,`NAME`,`DEL_BY`,
					`VAN`,`GENERATED`,`UD_QTY`,`TOINV`,`EXPORTED`,`EXPORTED1`,`EXPORTED2`,`EXPORTED3`,`BRK_TO`,`SV_PART`,`LAST_YEAR`,
					`VOID`,`SONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`TEMP`,`TEMP1`,
					`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,`TABLENO`,`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,
					`NODISPLAY`,`TITLE_ID`,`TITLE_DESP`,
					`COMMENT`,`DEFECTIVE`,`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,
					`MC6_BIL`,`MC7_BIL`,`taxincl`,`note_a`)
					values ('SAM', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
					'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">, 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,
					'#getbody.agenno#',	
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">,
                     '#getbody.source#', '#getbody.job#', '', 
					'#val(fulfillqty)#',
					'#getbody.price_bil#', '#getbody.unit#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
					'#newdamt_bil#', '#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#', '#newtaxamt_bil#', '',
					'#val(fulfillqty)#', 
					'#newprice#', '#getbody.unit#','#newamt1#', '#newdamt#',
					'#newamt#', '#newtaxamt#', '1', '1', 	'#form.refno#','#getbody.dodate#','#dateformat(wos_date,"yyyy-mm-dd")#',
					'#brem1#', '#brem2#', '#brem3#', '#brem4#', 
					'', '', '', '#gltradac#', '', 'N', 'N', '', '#grade#', '0.00',
					'0.00', '0', '#getbody.sercost#', '#getbody.m_charge1#', '#getbody.m_charge2#', #getbody.adtcost1#, #getbody.adtcost2#, '0', '0','#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '',
					'', '0', '0', '0','#getbody.name#', '0', '#getbody.van#', 'Y', '', '', '', '0000-00-00', '', '0000-00-00', '', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.sv_part#">, '', '',
					'#form.refno#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#', '#getbody.category#', '#area#',
					'#Shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#', '0',
					'#member#', '', #Now()#, 'Time', '#bomno#',
					'#getbody.nodisplay#','#getbody.title_id#','#getbody.title_desp#',

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
					  	"#tostring(getbody.comment)#",'#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#','#getbody.taxincl#','#getbody.note_a#')
					<cfelseif SingleQ eq '' and DoubleQ eq 'Y'>
					  	<!--- Found " in the comment --->
					  	'#tostring(getbody.comment)#','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#','#getbody.taxincl#','#getbody.note_a#')
					<cfelseif SingleQ eq '' and DoubleQ eq ''>
					  	'#tostring(getbody.comment)#','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#','#getbody.taxincl#','#getbody.note_a#')
					<cfelse>
					  	'','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#','#getbody.taxincl#','#getbody.note_a#')
					</cfif>
				</cfquery>

				<cfquery name="inserticlink" datasource="#dts#">
					insert into servicededuct values ('SAM','#nexttranno#','#j#',
					'#ndatenow#','INV','#form.refno#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#val(fulfillqty)#')
				</cfquery>

			<cfset j = j + 1>
		</cfif>
		</cfloop>
        
        
		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#form.refno#' and type = "INV"
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
		<cfset net = net_bil * newcurrate>        <cfif getheader.taxincl neq "T">
        
        <cfif totaltaxcharge eq 0 and taxcharge eq 0>
		<cfset tax1_bil = net_bil * xtaxp1/100> 
        <cfelse>
                <cfif getGsetup.wpitemtax eq "">
        <cfset taxdis1 = totaltaxcharge * xdisp1/100 >
        <cfset tax1_bil = totaltaxcharge - taxdis1>
        <cfset taxdis2 = tax1_bil * xdisp2/100 >
        <cfset tax1_bil = tax1_bil - taxdis2>
        <cfset taxdis3 = tax1_bil * xdisp3/100 >
        <cfset tax1_bil = tax1_bil - taxdis3>
        <cfif val(taxdis1) eq 0 and val(taxdis2) eq 0  and val(taxdis3) eq 0 and val(disc_bil) neq 0 >
        <cftry>
        <cfset tax1_bil = totaltaxcharge * ((val(gross_bil) - val(disc_bil))/val(gross_bil))>
		<cfcatch type="any">
        </cfcatch>
        </cftry>
		</cfif>
        <cfset totaltaxcharge = tax1_bil>
        
        <cfset taxdisc1 = taxcharge * xdisp1/100 >
        <cfset tax1_bils = taxcharge - taxdisc1>
        <cfset taxdisc2 = tax1_bils * xdisp2/100 >
        <cfset tax1_bils = tax1_bils - taxdisc2>
        <cfset taxdisc3 = tax1_bils * xdisp3/100 >
        <cfset tax1_bils = tax1_bils - taxdisc3>
        <cfif val(taxdisc1) eq 0 and val(taxdisc2) eq 0  and val(taxdisc3) eq 0 and val(disc_bil) neq 0 >
        <cftry>
        <cfset tax1_bils = taxcharge * ((val(gross_bil) - val(disc_bil))/val(gross_bil))>
		<cfcatch type="any">
        </cfcatch>
        </cftry>
		</cfif>
        <cfset taxcharge = tax1_bils>
        <cfelse>
        <cfset tax1_bil = totaltaxcharge >
		</cfif>
		</cfif>
        
        <cfelse>   
        <cfset tax1_bil = (net_bil * xtaxp1)/(100+xtaxp1)>
		</cfif>
        
		<cfset tax1 = tax1_bil * newcurrate>
		<cfset tax_bil = tax1_bil>
		<cfset tax = tax1>
        <cfif getheader.taxincl neq "T">
        
        <cfif totaltaxcharge eq 0 and taxcharge eq 0>
		<cfset grand_bil = net_bil + tax_bil>
        <cfelseif taxcharge neq 0>
        <cfset grand_bil = net_bil + taxcharge>
		</cfif>
       
        <cfelse>
        <cfset grand_bil = net_bil>
        </cfif>
		<cfset grand_bil = numberformat(grand_bil,".__")>
		<cfset grand = grand_bil * newcurrate>
		<cfset grand = numberformat(grand,".__")>
		
		<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,
			currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,
			tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax2,
			tax3,tax,taxp1,taxp2,taxp3,grand,note,term,van,pono,dono,sono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
			rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
			trdatetime,userid,username,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49,taxincl)

			values('SAM','#nexttranno#','#getheader.refno2#','#getheader.custno#','#readperiod#','#ndatenow#',
			<cfif getheader.desp eq "">'SALES'<cfelse>'#getheader.desp#'</cfif>,'#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#','#getheader.term#','#getheader.van#',
			<cfif lcase(HcomID) eq "mphcranes_i"><cfif getheader.pono neq ''>'#getheader.pono#'<cfelse>''</cfif><cfelseif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">'#getheader.pono#'<cfelse><cfif getheader.pono neq ''>'#getheader.pono#'<cfelse>''</cfif></cfif>,'#getheader.dono#',<cfif lcase(HcomID) eq "vsolutionspteltd_i">'#getheader.pono#'<cfelse>'#updatepono#'</cfif>,'#getheader.rem0#','#getheader.rem1#', '#getheader.rem2#','#getheader.rem3#',
			'#getheader.rem4#','#getheader.rem5#',
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			'#getheader.rem11#', '#getheader.rem12#','#getheader.frem0#', '#getheader.frem1#', '#getheader.frem2#', '#getheader.frem3#', '#getheader.frem4#',
			'#getheader.frem5#', '#getheader.frem6#', '#getheader.frem7#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getheader.comm0#', '#getheader.comm1#', '#getheader.comm2#', '#getheader.comm3#', '#getheader.comm4#',
			'#getheader.name#','#getheader.phonea#',
			#Now()#, <cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserID#">,'#getusername.username#','#getheader.currcode#',
			'#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#',
			'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#','#getheader.special_account_code#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserID#">,#now()#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserID#">,#now()#,'#getheader.rem30#', '#getheader.rem31#', '#getheader.rem32#', '#getheader.rem33#', '#getheader.rem34#', '#getheader.rem35#', '#getheader.rem36#', '#getheader.rem37#', '#getheader.rem38#', '#getheader.rem39#', '#getheader.rem40#', '#getheader.rem41#', '#getheader.rem42#', '#getheader.rem43#', '#getheader.rem44#', '#getheader.rem45#', '#getheader.rem46#', '#getheader.rem47#', '#getheader.rem48#', '#getheader.rem49#'
			,'#getheader.taxincl#')
		</cfquery>
        
        <script>
		<cfoutput>
		window.location.href="transaction3c.cfm?tran=SAM&nexttranno=#nexttranno#";
		</cfoutput>
		</script>
</html>