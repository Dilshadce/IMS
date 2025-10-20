<cfset taxcharge = 0 >
<cfset totaltaxcharge = 0 >
<cfif IsDefined("session.formName") and session.formname eq "updatepage">
<cftry>
<cfset StructDelete(Session, "formName")>
<cfcatch type="any">
</cfcatch>
</cftry>
<html>
<head>
<title>Update Main Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getusername" datasource="main">
    select username from users where userid='#huserid#' and userbranch='#dts#'
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
    select * from modulecontrol
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

<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM,lRQ

	from GSetup
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

<cfif url.t2 eq "INV">
	<cfif trancode eq "invno">
		<cfset tranarun = "invarun">
	<cfelseif trancode eq "invno_2">
		<cfset tranarun = "invarun_2">
	<cfelseif trancode eq "invno_3">
		<cfset tranarun = "invarun_3">
	<cfelseif trancode eq "invno_4">
		<cfset tranarun = "invarun_4">
	<cfelseif trancode eq "invno_5">
		<cfset tranarun = "invarun_5">
	<cfelseif trancode eq "invno_6">
		<cfset tranarun = "invarun_6">
	</cfif>
<cfelseif url.t2 eq "DO">
	<cfset tranarun = "doarun">
<cfelseif url.t2 eq "RC">
	<cfset tranarun = "rcarun">
<cfelseif url.t2 eq "PO">
	<cfset tranarun = "poarun">
<cfelseif url.t2 eq "SO">
	<cfset tranarun = "soarun">
<cfelseif url.t2 eq "CS">
	<cfset tranarun = "csarun">
<cfelseif url.t2 eq "QUO">
	<cfset tranarun = "quoarun">
</cfif>

<cfif t1 eq 'PO' or t1 eq 'PR' or t1 eq 'RC'>
	<cfset ptype = target_apvend>
<cfelse>
	<cfset ptype = target_arcust>
</cfif>

<cfset uuid = createuuid()>

<cfquery datasource="#dts#" name="getGeneralInfo">
	select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse from refnoset
	where type = '#t2#'
	and counter = '#invset#'
</cfquery>

<cfif getGeneralInfo.arun eq "1">
	<cfset refnocnt = len(getGeneralInfo.tranno)>
	<cfset cnt = 0>
	<cfset yes = 0>
	<!--- ADD ON 12-01-2009 --->
	<!--- REMARK ON 06-10-2009 --->
	<!--- <cfif lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "avent_i" or lcase(HcomID) eq "chemline_i"> --->
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
		<cfset nexttranno = newnextNum>
	
	<!--- <cfelse>
		<cfloop condition = "cnt lte refnocnt and yes eq 0">
			<cfset cnt = cnt + 1>
			<cfif isnumeric(mid(getGeneralInfo.tranno,cnt,1))>
				<cfset yes = 1>
			</cfif>
		</cfloop>
	
		<cfset nolen = refnocnt - cnt + 1>
		<cfset nextno = right(getGeneralInfo.tranno,nolen) + 1>
		<cfset nocnt = 1>
		<cfset zero = "">
	
		<cfloop condition = "nocnt lte nolen">
			<cfset zero = zero & "0">
			<cfset nocnt = nocnt + 1>
		</cfloop>
	
		<cfif t2 eq 'SO' or t2 eq 'PO' or t2 eq 'QUO'>
			<cfset limit = 24>
		<cfelse>
			<cfset limit = 20>
		</cfif>
	
		<cfif cnt gt 1>
			<cfset nexttranno = left(getGeneralInfo.tranno,cnt-1)&numberformat(nextno,zero)>
			<cfif len(nexttranno) gt limit>
				<cfset nexttranno = '99999999'>
			</cfif>
		<cfelse>
			<cfset nexttranno = numberformat(nextno,zero)>
			<cfif len(nexttranno) gt limit>
				<cfset nexttranno = '99999999'>
			</cfif>
		</cfif>
	</cfif> --->
	<cfif lcase(HcomID) eq "zeadine_i" or lcase(HcomID) eq "zeadine09_i">
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="actual_nexttranno" />
		<cfif getGeneralInfo.refnocode2 neq "">
			<cfset nexttranno = actual_nexttranno&"-"&getGeneralInfo.refnocode2>
		</cfif>	
    <cfelse>
        <cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum1" />
        <cfset actual_nexttranno = newnextNum1>
        <cfif (getGeneralInfo.refnocode2 neq "" or getGeneralInfo.refnocode neq "") and getGeneralInfo.presuffixuse eq "1">
            <cfset nexttranno = getGeneralInfo.refnocode&actual_nexttranno&getGeneralInfo.refnocode2>
        <cfelse>
            <cfset nexttranno = actual_nexttranno>
        </cfif>	
        
         <cfif lcase(HcomID) eq "3ree_i" and url.t2 eq "INV">
				<cfset actual_nexttranno = nexttranno>
                <cfset mylist= listchangedelims(checkbox,"",",")>
                <cfquery datasource="#dts#" name="get3reedetail">
					Select custno from artran where refno = '#listgetat(mylist,1,";")#' 
			  	</cfquery>
                <cfquery name="get3reeremark" datasource="#dts#">
                select arrem1 from #target_arcust# where custno='#get3reedetail.custno#'
                </cfquery>
                <cfif trim(get3reeremark.arrem1) neq ''>
                <cfset nexttranno = actual_nexttranno&listgetat(form.f_cdate,2,'/')&right(listgetat(form.f_cdate,3,'/'),2)&get3reeremark.arrem1>
                <cfelse>
				<cfset nexttranno = actual_nexttranno&listgetat(form.f_cdate,2,'/')&right(listgetat(form.f_cdate,3,'/'),2)&right(get3reedetail.custno,3)>
          </cfif>
          </cfif>
          
          <cfif lcase(HcomID) eq "asaiki_i">
				<cfset actual_nexttranno = nexttranno>
                <cfset mylist= listchangedelims(checkbox,"",",")>
                <cfquery datasource="#dts#" name="get3reedetail">
					Select custno from artran where refno = '#listgetat(mylist,1,";")#' 
			  	</cfquery>
				<cfset nexttranno = actual_nexttranno&listgetat(form.f_cdate,2,'/')&right(listgetat(form.f_cdate,3,'/'),2)>
          </cfif>
        
	</cfif>
	<!--- <cfloop condition = "cnt lte refnocnt and yes eq 0">
		<cfset cnt = cnt + 1>
		<cfif isnumeric(mid(getGeneralInfo.tranno,cnt,1))>
			<cfset yes = 1>
		</cfif>
	</cfloop>

	<cfset nolen = refnocnt - cnt + 1>
	<cfset nextno = right(getGeneralInfo.tranno,nolen) + 1>
	<cfset nocnt = 1>
	<cfset zero = "">

	<cfloop condition = "nocnt lte nolen">
		<cfset zero = zero & "0">
		<cfset nocnt = nocnt + 1>
	</cfloop>

	<cfif t2 eq 'SO' or t2 eq 'PO' or t2 eq 'QUO'>
		<cfset limit = 24>
	<cfelse>
		<cfset limit = 10>
	</cfif>

	<cfif cnt gt 1>
		<cfset nexttranno = left(getGeneralInfo.tranno,cnt-1)&numberformat(nextno,zero)>
		<cfif len(nexttranno) gt limit>
			<cfset nexttranno = '99999999'>
		</cfif>
	<cfelse>
		<cfset nexttranno = numberformat(nextno,zero)>
		<cfif len(nexttranno) gt limit>
			<cfset nexttranno = '99999999'>
		</cfif>
	</cfif> --->
	
	<!--- ADD ON 090109 --->
	<!--- <cfif lcase(HcomID) eq "topsteel_i">
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
		<cfset nexttranno = newnextNum>
	</cfif> --->
	
	<!--- ADD ON 230608 --->
    
    <cfif lcase(hcomid) neq "atc2005_i">
	<cftry>
		<cfquery name="checkexist" datasource="#dts#">
			select refno from artran where type = '#t2#' and refno = <cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
		</cfquery>
	<cfcatch type="any">
		<cfoutput>#cfcatch.Message#::#cfcatch.Detail#</cfoutput><cfabort>
	</cfcatch>
	</cftry>
	
	<cfif checkexist.recordcount gt 0>
		<h3>Error. This reference no. have been created. Please change the Last Used No.</h3>
		<cfabort>
	</cfif>
    </cfif>
<cfelse>
	<cfif lcase(hcomid) neq "atc2005_i">
	<cfif form.nextrefno neq ''>
		<cfquery name="checkexist" datasource="#dts#">
			select refno from artran where type = '#t2#' and refno = '#nextrefno#'
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
</cfif>


<body>

<!--- t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO --->
<cfif url.t2 eq "DO">
	<h1>Update to <cfoutput>#gettranname.lDO#</cfoutput></h1>
     <cfif url.t1 eq "SAM">
		<cfset type = gettranname.lSAM>
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>

		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>
		<cfset j = 1>
		
		
        <cfset stepcount = "+4" >

		<cfloop from="1" to="#cnt#" index="i" step="#stepcount#">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

			  <cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>SAM No. : #listgetat(mylist,i,";")# <br></cfoutput>
			
			<!--- Start of Update body --->
            
				<cfset xParam1 = listgetat(mylist,i,";")>

				<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			  		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  		<cfset xParam2 = ''>
				<cfelse>
			  		<cfset xParam2 = listgetat(mylist,i+1,";")>
				</cfif>

				<cfset xParam3 = listgetat(mylist,i+2,";")>
                
                <cfset xParam4 = listgetat(mylist,i+3,";")>
                
                <cfquery name="insertintotempiclink" datasource="#dts#">
                insert into iclinktemp (uuid,refno,itemno,trancode,serialno) values ('#uuid#','#xParam1#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam3#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam4#">)
                </cfquery>
                
		</cfloop>
        
        
        		<cfquery datasource="#dts#" name="getictrantemp">
					Select count(serialno) as fulfill,refno,trancode,itemno from iclinktemp where uuid = '#uuid#' group by refno,trancode
				</cfquery>
        		<cfloop query="getictrantemp">
                
				<cfquery datasource="#dts#" name="getbody">
					Select * from ictran where refno = '#getictrantemp.refno#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictrantemp.itemno#"> and trancode = '#getictrantemp.trancode#' and shipped < qty and type = 'SAM'
				</cfquery>

				<cfloop query="getbody">
				  	<cfquery datasource="#dts#" name="getheader">
						Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SAM'
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
					
					<cfset newamt1_bil = getictrantemp.fulfill * getbody.price_bil>
					
					<cfset newdamt_bil1 = (getbody.dispec1 / 100) * newamt1_bil>
					<cfset netamt = newamt1_bil - newdamt_bil1>
					<cfset newdamt_bil2 = (getbody.dispec2 / 100) * netamt>
					<cfset netamt = netamt - newdamt_bil2>
					<cfset newdamt_bil3 = (getbody.dispec3 / 100) * netamt>
					<cfset netamt = netamt - newdamt_bil3>
					
					<cfset newdamt_bil = newdamt_bil1 + newdamt_bil2 + newdamt_bil3>
					<cfif val(newdamt_bil) eq 0 and val(getbody.DISAMT_BIL) neq 0 and val(getbody.qty_bil) neq 0>
						<cfset newdamt_bil = val(getbody.DISAMT_BIL) * val(getictrantemp.fulfill) / val(getbody.qty_bil)>
						<cfset netamt = netamt - val(getbody.DISAMT_BIL)>
					</cfif>
					
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
	                
	                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.sodate#" returnvariable="getbody.sodate"/>
	                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
	                
                    <!---update serial---->
                    <cfquery datasource="#dts#" name="getictempserial">
                        Select * from iclinktemp where refno='#getbody.refno#' and trancode='#getbody.trancode#' and itemno='#getbody.itemno#' and uuid='#uuid#'
                    </cfquery>
                    
                    <cfloop query="getictempserial">
                    <cfquery datasource="#dts#" name="getupdateserial">
                        Select * from iserial where type='SAM' and refno='#getictempserial.refno#' and serialno='#getictempserial.serialno#' and trancode='#getictempserial.trancode#'
                    </cfquery>
                    
                    <cfquery datasource="#dts#" name="updateserial">
                        update iserial set generated='#nexttranno#' where type='SAM' and refno='#getictempserial.refno#' and serialno='#getictempserial.serialno#' and trancode='#getictempserial.trancode#'
                    </cfquery>
                    
                    <cfquery datasource="#dts#" name="insertserial">
                        insert into iserial (type,refno,trancode,custno,fperiod,wos_date,itemno,serialno,agenno,location,currrate,sign,price) 
                            values ('DO','#nexttranno#','#j#','#getupdateserial.custno#','#readperiod#',
                            #ndatenow#,'#getupdateserial.itemno#','#getupdateserial.serialno#','#getupdateserial.agenno#','#getupdateserial.location#', 
                            '#getupdateserial.currrate#','#getupdateserial.sign#','#getupdateserial.price#')
                    </cfquery>
                    
                    </cfloop>
                    <!--- --->
                    
                    
					<!--- SAM TO DO --->
					<cfquery datasource="#dts#" name="insertictran">
						Insert into ictran 
						(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
						`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
						`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
						`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,
						<cfif lcase(hcomid) eq "avent_i">
							`BREM5`,`BREM6`,
						<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
							`BREM5`,`BREM7`,`BREM8`,`BREM9`,`BREM10`,
						</cfif>
						`PACKING`,`NOTE1`,
						`NOTE2`,`GLTRADAC`,`UPDCOST`,`GST_ITEM`,`TOTALUP`,`WITHSN`,`GRADE`,`PUR_PRICE`,
						`QTY_RET`,`TEMPFIGI`,`SERCOST`,`M_CHARGE1`,`M_CHARGE2`,`ADTCOST1`,`ADTCOST2`,`IT_COS`,`AV_COST`,
						`BATCHCODE`,`EXPDATE`,`POINT`,`INV_DISC`,`INV_TAX`,`SUPP`,`EDI_COU1`,`WRITEOFF`,`TOSHIP`,`SHIPPED`,`NAME`,`DEL_BY`,
						`VAN`,`GENERATED`,`UD_QTY`,`TOINV`,`EXPORTED`,`EXPORTED1`,`EXPORTED2`,`EXPORTED3`,`BRK_TO`,`SV_PART`,`LAST_YEAR`,
						`VOID`,`SONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`TEMP`,`TEMP1`,
						`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,`TABLENO`,`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,
						`NODISPLAY`,`TITLE_ID`,`TITLE_DESP`,<cfif lcase(hcomid) eq "topsteel_i">`TITLE_DESPA`,</cfif>
						`COMMENT`,`DEFECTIVE`,`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,
						`MC6_BIL`,`MC7_BIL`<cfif lcase(hcomid) eq "fdipx_i">,`JobOrderNo`</cfif>,`taxincl`,`note_a`)
						values ('DO', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
						'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
	                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,
						'#agenno#',	<cfif isdefined('form.location')>
                    <cfif listgetat(form.location,j) eq "emptylocation">
						<cfset locationvalue = "">
                        <cfelse>
                        <cfset locationvalue = listgetat(form.location,j)>
                        </cfif>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#locationvalue#">,
                    <cfelse>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">,
					</cfif> '#getbody.source#', '#getbody.job#', '', '#val(getictrantemp.fulfill)#',
						'#getbody.price_bil#','#getbody.unit_bil#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
						'#newdamt_bil#', '#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#', '#newtaxamt_bil#',
						'', '#val(getictrantemp.fulfill)#', '#newprice#','#getbody.unit#', '#newamt1#', '#newdamt#', '#newamt#',
						'#newtaxamt#', '1', '1', '#getictrantemp.refno#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#getbody.sodate#', '#brem1#', '#brem2#', '#brem3#', '#brem4#',
						<cfif lcase(hcomid) eq "avent_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
						<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
						</cfif>
						'#getbody.packing#', '#getbody.note1#', '#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N', '', '#getbody.grade#', '0.00',
						'0.00', '0', '0', '#getbody.m_charge1#', '#getbody.m_charge2#', '#getbody.adtcost1#', '#getbody.adtcost2#', '0', '0', '#getbody.batchcode#', '#getbody.expdate#', '0', '0', '0',
						'', '',	'0', '0', '0',	'#getbody.name#', '0', '0', 'Y', '', '', '', '0000-00-00', '', '0000-00-00', '', '', '', '',
						'#getictrantemp.refno#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#', '#getbody.category#', '#Area#',
						'#Shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#', '0', '#member#', '', #Now()#, 'Time',
						'#BOMNO#',
						'#getbody.nodisplay#','#getbody.title_id#','#getbody.title_desp#',
	            		<cfif lcase(hcomid) eq "topsteel_i"><cfqueryparam cfsqltype="cf_sql_longvarchar" value="#getbody.title_despa#">,</cfif>
	
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
						  	"#tostring(getbody.comment)#",'#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						<cfelseif SingleQ eq '' and DoubleQ eq 'Y'>
						  	<!--- Found " in the comment --->
						  	'#tostring(getbody.comment)#','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						<cfelseif SingleQ eq '' and DoubleQ eq ''>
						  	'#tostring(getbody.comment)#','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						<cfelse>
						  	'','#getbody.defective#',,'#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						</cfif>
					</cfquery>
	
					<cfif getbody.batchcode neq "">
						<cfif getbody.location neq "">
							<cfquery name="updateobbatch" datasource="#dts#">
								update lobthob set bth_qut=(bth_qut+'#val(getictrantemp.fulfill)#')
								where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+'#val(getictrantemp.fulfill)#')
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						<cfelse>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+'#val(getictrantemp.fulfill)#')
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						</cfif>
					</cfif>
	
					<cfset qname='QOUT'&(readperiod+10)>
	
					<cfquery name="UpdateIcitem" datasource="#dts#">
						update icitem set #qname#=(#qname#+#val(getictrantemp.fulfill)#) where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
					</cfquery>
	
					<cfquery name="inserticlink" datasource="#dts#">
						insert into iclink values ('DO','#nexttranno#','#j#',
						'#ndatenow#','SAM','#getictrantemp.refno#','#getbody.trancode#',
						#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#val(getictrantemp.fulfill)#')
					</cfquery>
	
					<cfset newship = getbody.shipped + val(getictrantemp.fulfill)>
	
					<cfquery datasource="#dts#" name="updateictran">
						Update ictran set shipped = '#newship#'
						where refno = '#getictrantemp.refno#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getictrantemp.itemno#"> and trancode = '#getictrantemp.trancode#'
						and toinv = '' and type = 'SAM'
					</cfquery>
					
				</cfloop>
	
				<cfif val(getictrantemp.fulfill) gte (getbody.qty-getbody.shipped-getbody.writeoff)>
					<cfquery datasource="#dts#" name="updateartran">
						Update ictran set toinv = '#nexttranno#', generated = 'Y'
						where refno = '#getictrantemp.refno#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getictrantemp.itemno#">
						and toinv = '' and type = 'SAM' and trancode = '#getictrantemp.trancode#'
					</cfquery>
					
				</cfif>
					<cfset j = j + 1>


			<cfset j = j + 1>
			
			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#getictrantemp.refno#' and shipped < qty and type = 'SAM'
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set toinv = '#nexttranno#', order_cl = 'Y', generated = 'Y'
					where refno = '#getictrantemp.refno#' and type = 'SAM'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lSAM# no: #getictrantemp.refno# is successfully updated to #gettranname.lDO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
		</cfloop>

<!---header--->


		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SAM'
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
		
		<cfif lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i">
			<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getheader.rem9#" returnvariable="getheader.rem9"/>
			<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getheader.rem11#" returnvariable="getheader.rem11"/>
		</cfif>
		
		<!--- Create a new transaction --->
		<!--- SAM TO DO --->
		<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,
			currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,
			tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax2,
			tax3,tax,taxp1,taxp2,taxp3,grand,note,term,van,pono,dono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
			rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
			trdatetime,userid,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49
			<cfif lcase(hcomid) eq 'iel_i'>
				,rem15,rem16,rem17,rem18,rem19,rem20,rem21,rem22,rem23,rem24,rem25
			</cfif>,taxincl,e_mail)

			values('DO','#nexttranno#','#getheader.refno2#','#getheader.custno#','#readperiod#','#ndatenow#',
			'#getheader.desp#','#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#',	'#getheader.term#','#getheader.van#',
			'#getheader.pono#',<cfif getheader.dono neq ''>'#getheader.dono#'<cfelse>'#updatepono#'</cfif>,'#getheader.quono#','#getheader.rem0#','#getheader.rem1#','#getheader.rem2#','#getheader.rem3#',
			'#getheader.rem4#','#getheader.rem5#','#getheader.rem6#',
			'#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#','#getheader.rem11#',
			'#getheader.rem12#','#getheader.frem0#', '#getheader.frem1#', '#getheader.frem2#', '#getheader.frem3#', '#getheader.frem4#',
			'#getheader.frem5#', '#getheader.frem6#', '#getheader.frem7#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getheader.comm0#', '#getheader.comm1#', '#getheader.comm2#', '#getheader.comm3#', '#getheader.comm4#',
			'#getheader.name#','#getheader.phonea#',
			#Now()#, '#HUserID#','#getheader.currcode#',
			'#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#',
			'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#','#getheader.special_account_code#',
			'#HUserID#',#now()#,'#HUserID#',#now()#,'#getheader.rem30#', '#getheader.rem31#', '#getheader.rem32#', '#getheader.rem33#', '#getheader.rem34#', '#getheader.rem35#', '#getheader.rem36#', '#getheader.rem37#', '#getheader.rem38#', '#getheader.rem39#', '#getheader.rem40#', '#getheader.rem41#', '#getheader.rem42#', '#getheader.rem43#', '#getheader.rem44#', '#getheader.rem45#', '#getheader.rem46#', '#getheader.rem47#', '#getheader.rem48#', '#getheader.rem49#'
			<cfif lcase(hcomid) eq 'iel_i'>
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem15#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem16#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem17#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem18#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem19#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem20#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem21#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem22#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem23#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem24#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem25#">
			</cfif>,'#getheader.taxincl#','#getheader.e_mail#')
		</cfquery>
		
        
</cfif></cfif>

<cfif getGsetup.MULTIAGENT eq 'Y'>
<cfquery datasource="#dts#" name="updatemultiagent">
update artran set multiagent1='#getheader.multiagent1#' ,multiagent2='#getheader.multiagent2#' ,multiagent3='#getheader.multiagent3#' ,multiagent4='#getheader.multiagent4#' ,multiagent5='#getheader.multiagent5#' ,multiagent6='#getheader.multiagent6#' ,multiagent7='#getheader.multiagent7#' ,multiagent8='#getheader.multiagent8#' where refno='#nexttranno#' and type='#url.t2#'
</cfquery>
</cfif>
<cftry>
<cfif getGsetup.wpitemtax neq '1' and val(getheader.net) neq 0>
<cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictran 
        set note_a='#getheader.note#',
        TAXPEC1='#getheader.taxp1#',
        TAXAMT_BIL=round((AMT_BIL/#val(getheader.net_bil)#)*#val(getheader.tax_bil)#,3),
        TAXAMT=round((AMT/#val(getheader.net)#)*#val(getheader.tax)#,3)
        where type='#url.t2#' and refno='#nexttranno#';
    </cfquery>
</cfif>
<cfcatch type="any">
</cfcatch>
</cftry>

<cfoutput>
	<cfif url.t2 eq "DO" and url.t1 eq "PO">
		<h2><a href="updateA.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#">Click Here to update more #t1#</a></h2>
	<cfelse>
		<h2><a href="update.cfm?t1=#URLEncodedFormat(t1)#&t2=#URLEncodedFormat(t2)#">Click Here to update more #t1#</a></h2>
	</cfif>
</cfoutput>
</body>
</html>
<cfelse>
	This form has either already been submitted or is being called from the wrong page.
</cfif>
        
        
        