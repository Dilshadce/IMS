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

<!--- REMARK ON 230608 AND REPLACE WITH THE BELOW ONE --->
<!---cfquery datasource="#dts#" name="getGeneralInfo">
	Select #trancode# as tranno, #tranarun# as arun from GSetup
</cfquery--->
<!--- <cfquery datasource="main" name="getGeneralInfo">
	select lastUsedNo as tranno, refnoused as arun from refnoset
	where userDept = '#dts#'
	and type = '#t2#'
	and counter = '#invset#'
</cfquery> --->

<!---checklocationrefno--->

<cfset followlocationrefno=0><!---Follow location Profile Running No--->



<cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">
<cfset mylist= listchangedelims(checkbox,"",",")>
<cfquery name="getmikadefaultuser" datasource="#dts#">
	Select userid from artran where refno = '#listgetat(mylist,1,";")#' and type = '#t1#' 
</cfquery>
<cfquery name="getmikauserloc" datasource="main">
	SELECT location from users where userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getmikadefaultuser.userid#"> and userbranch=<cfqueryparam cfsqltype="cf_sql_varchar" value="#dts#">
</cfquery>
</cfif>

<cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">
<!---mika only --->

<cfif getmikauserloc.location neq "">
<cfquery datasource="#dts#" name="getlocationrefno">
			select lastUsedNo
            from refnoset_location
			where type = '#t2#'
			and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            and activate="T"
</cfquery>
<cfif getlocationrefno.recordcount neq 0>
<cfset followlocationrefno=1>
</cfif>
</cfif>

<cfelse>
<cfif  lcase(huserloc) neq "all_loc">
<cfquery datasource="#dts#" name="getlocationrefno">
			select lastUsedNo
            from refnoset_location
			where type = '#t2#'
			and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            and activate="T"
</cfquery>
<cfif getlocationrefno.recordcount neq 0>
<cfset followlocationrefno=1>
</cfif>
</cfif>

</cfif>


<!---end checklocationrefno--->



<cfif followlocationrefno eq 1>
    <cfquery datasource="#dts#" name="getGeneralInfo">
        select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse from refnoset_location
        where type = '#t2#'
        and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
        and activate="T"
    </cfquery>
<cfelse>
    <cfquery datasource="#dts#" name="getGeneralInfo">
        select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse from refnoset
        where type = '#t2#'
        and counter = '#invset#'
    </cfquery>
</cfif>

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
                <cfif invset neq 4>
				<cfset nexttranno = actual_nexttranno&listgetat(form.f_cdate,2,'/')&right(listgetat(form.f_cdate,3,'/'),2)>
                <cfelse>
                <cfset nexttranno = actual_nexttranno>
                </cfif>
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
    
    <cfif lcase(hcomid) eq "atc2005_i" and t2 eq 'INV' and t1 eq 'SO'>
    <cfelse>
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
	<cfif lcase(hcomid) eq "atc2005_i" and t2 eq 'INV' and t1 eq 'SO'>
    <cfelse>
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

<cfif isdefined("form.fulfill")>
	<cfset xlist= form.fulfill>
	<cfset cnt=listlen(xlist)>

	<cfloop from="1" to="#cnt#" index="i">
    <cfif lcase(hcomid) eq "hunting_i">
    <cfif listgetat(form.fulfill,i) gt (listgetat(form.qtytoful,i)*1.05)>
			<h3>Error. The qty to fulfill is greater than the outstanding qty.</h3>
			<cfabort>
		</cfif>
    <cfelse>
    	<cfif isdefined('form.balanceqty') and getGsetup.negstk neq '1'>
        <cfif listgetat(form.balanceqty,i) neq 'SV'>
        <cfif (listgetat(form.fulfill,i) gt listgetat(form.qtytoful,i)) or listgetat(form.fulfill,i) gt listgetat(form.balanceqty,i)>
			<h3>Error. The qty to fulfill is greater than the balance qty.</h3>
			<cfabort>
		</cfif>
        </cfif>
        <cfelse>
		<cfif listgetat(form.fulfill,i) gt listgetat(form.qtytoful,i)>
			<h3>Error. The qty to fulfill is greater than the outstanding qty.</h3>
			<cfabort>
		</cfif>
        </cfif>
        <cfif listgetat(form.fulfill,i) eq 0>
        <h3>Error. The qty to fulfill cannot be 0.</h3>
        <cfabort>
        </cfif>
    </cfif>    
	</cfloop>
</cfif>

<body>
<!--- Update to Invoice --->
<!--- t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV t2 = INV --->
<cfif url.t2 eq "INV">
	<h1>Update to <cfoutput>#gettranname.lINV#</cfoutput></h1>
	<!--- t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO t1 = DO --->
	<cfif url.t1 eq "DO">
		<cfset type = gettranname.lDO>
		
		<!--- REMARK ON 230608 AND REPLACE WITH THE BELOW ONE --->
		<!---cfquery datasource="#dts#" name="updategsetup">
			Update Gsetup set #trancode# = UPPER("#nexttranno#")
		</cfquery--->
		
		<!--- <cfquery name="updategsetup" datasource="main">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where userDept = '#dts#'
			and type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
		
		<!--- <cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
            <cfquery name="updategsetup" datasource="#dts#">
                update refnoset set 
                lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and counter =  '#invset#'
            </cfquery>
        </cfif>

		<cfoutput><h2>#gettranname.lDO# no: #listfirst(form.checkbox,";")# is successfully updated to #gettranname.lINV# No: <a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></h2></cfoutput>

		<cfset mylist= listchangedelims(checkbox,"",",")>

		<cfset cnt=listlen(mylist,";")>
		<cfset j = 1>
		
		Transaction Update Summary<br><br>

		<cfloop from="1" to="#cnt#" index="i">
			<cfif LastPONO neq listgetat(mylist,i,";")>
				<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>
			  	<cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>Do No. : #listgetat(mylist,i,";")# <br></cfoutput>

			<!--- Start of update header --->
			<cfquery datasource="#dts#" name="updateartran">
				Update artran set toinv = '#nexttranno#', generated = 'Y' where refno = '#listgetat(mylist,i,";")#' and type = 'DO'
			</cfquery>
			<!--- End of Update header --->
			<!--- Start of Update body --->
			<cfquery datasource="#dts#" name="updateictran">
				Update ictran set shipped = qty, toinv = '#nexttranno#', generated = 'Y' where refno = '#listgetat(mylist,i,";")#' and type = 'DO'
			</cfquery>
			<!--- End of Update body --->
			<!--- Add on 031008 --->
			<!--- Start of Update igrade --->
			<cfquery datasource="#dts#" name="updateictran">
				Update igrade set generated = 'Y' where refno = '#listgetat(mylist,i,";")#' and type = 'DO'
			</cfquery>
			<!--- Transaction Details<br>--->
			<cfquery datasource="#dts#" name="getbody">
				Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = 'DO' order by trancode
			</cfquery>

			<cfloop query="getbody">
			  	<!--- GET LATEST CURRRATE --->
			  	<cfquery datasource="#dts#" name="getheader">
					Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'DO'
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
                
				<cfif lcase(hcomid) eq "leatat_i">
                <cfset currency.rate= getheader.currrate>
				</cfif>
				<cfif currency.rate neq "">
					<cfset newcurrate = val(currency.rate)>
				<cfelse>
					<cfset newcurrate = 1><!--- default --->
				</cfif>
                
                <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>

				<cfset newamt1_bil = val(getbody.qty_bil) * val(getbody.price_bil)>
                
                
                <cfif val(getbody.dispec1) eq 0 and val(getbody.dispec1) eq 0 and val(getbody.dispec1) eq 0>
                
                <cfset netamt = val(newamt1_bil) - val(getbody.disamt_bil)>
                <cfset newdamt_bil = val(getbody.disamt_bil)>
                
                <cfelse>
                
				<cfset newdamt_bil1 = (val(getbody.dispec1) / 100) * val(newamt1_bil)>
				<cfset netamt = val(newamt1_bil) - val(newdamt_bil1)>
				<cfset newdamt_bil2 = (val(getbody.dispec2) / 100) * val(netamt)>
				<cfset netamt = val(netamt) - val(newdamt_bil2)>
				<cfset newdamt_bil3 = (val(getbody.dispec3) / 100) * val(netamt)>
                <cfset netamt = val(netamt) - val(newdamt_bil3)>
                <cfset newdamt_bil = val(newdamt_bil1) + val(newdamt_bil2) + val(newdamt_bil3)>
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
                
				<!--- <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil) + val(newtaxamt_bil)> --->
                <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil)>
				<cfset newamt_bil = numberformat(val(newamt_bil),".__")>
				<cfset newprice = val(getbody.price_bil) * val(newcurrate)>

				<cfset newamt1 = val(newamt1_bil) * val(newcurrate)>
				<cfset newdamt = val(newdamt_bil) * val(newcurrate)>
				<cfset newtaxamt = val(newtaxamt_bil) * val(newcurrate)>
				<cfset newamt = val(newamt_bil) * val(newcurrate)>
				<cfset newamt = numberformat(val(newamt),".__")>

				<cfset gross_bil = val(gross_bil) + val(newamt_bil)>
				<cfset gross = val(gross_bil) * val(newcurrate)>
                
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
					
				<!--- DO TO INV --->
                <cfif lcase(hcomid) eq 'bsssb_i' or lcase(hcomid) eq 'hnm_i' or lcase(hcomid) eq 'rvsb_i' or lcase(hcomid) eq 'puss_i'>
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
					`VOID`,`SONO`,`QUONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`TEMP`,`TEMP1`,
					`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,`TABLENO`,`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,
					`NODISPLAY`,`TITLE_ID`,`TITLE_DESP`,<cfif lcase(hcomid) eq "topsteel_i">`TITLE_DESPA`,</cfif>
					`COMMENT`,`DEFECTIVE`,`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,
					`MC6_BIL`,`MC7_BIL`<cfif lcase(hcomid) eq "fdipx_i">,`JobOrderNo`</cfif>,`taxincl`,`note_a`) 
					values ('INV', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
					'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,	
					'#getbody.agenno#',	 <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">, '#getbody.source#', '#getbody.job#', '',
					'#getbody.qty_bil#', '#getbody.price_bil#',	'#getbody.unit_bil#', '#getbody.amt1_bil#', '#val(getbody.dispec1)#',
					'#val(getbody.dispec2)#', '#val(getbody.dispec3)#', '#getbody.amt_bil#', '#getbody.amt_bil#', '#val(getbody.taxpec1)#',
					'#val(getbody.taxpec2)#', '#val(getbody.taxpec3)#', '#getbody.taxamt_bil#', '', '#getbody.qty#', '#newprice#',
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.unit#">, '#getbody.amt1#', '#getbody.amt#',	'#getbody.amt#', '#getbody.taxamt#', '#getbody.factor1#', '#getbody.factor2#',
					'#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#dateformat(getbody.wos_date,"yyyy-mm-dd")#', '#getbody.brem1#', '#getbody.brem2#', '#getbody.brem3#',
					'#getbody.brem4#', 
					<cfif lcase(hcomid) eq "avent_i">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
					<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
					</cfif>
					'#getbody.packing#', '#getbody.note1#', '#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N',
					'', '#getbody.grade#', '0.00','0.00','0',
					'0', '#getbody.m_charge1#', '#getbody.m_charge2#', '#getbody.adtcost1#', '#getbody.adtcost2#', '0', '0', '#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '', '0', '0', '0','#getbody.name#', '', '#getbody.van#', 'Y',
					'', '',	'', '0000-00-00', '', '0000-00-00', '', '', '', '', '#getbody.sono#', '#getbody.quono#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#',
					'#getbody.category#', '#getbody.area#', '#getbody.shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#',
					'0', '#member#', '', #Now()#, 'Time', '#getbody.bomno#',
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
					  '','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					</cfif>
				</cfquery>
                
                <cfelse>
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
					`VOID`,`SONO`,`QUONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`TEMP`,`TEMP1`,
					`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,`TABLENO`,`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,
					`NODISPLAY`,`TITLE_ID`,`TITLE_DESP`,<cfif lcase(hcomid) eq "topsteel_i">`TITLE_DESPA`,</cfif>
					`COMMENT`,`DEFECTIVE`,`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,
					`MC6_BIL`,`MC7_BIL`<cfif lcase(hcomid) eq "fdipx_i">,`JobOrderNo`</cfif>,`taxincl`,`note_a`) 
					values ('INV', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
					'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,	
					'#getbody.agenno#',	 <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">, '#getbody.source#', '#getbody.job#', '',
					'#getbody.qty_bil#', '#getbody.price_bil#',	'#getbody.unit_bil#', '#newamt1_bil#', '#val(getbody.dispec1)#',
					'#val(getbody.dispec2)#', '#val(getbody.dispec3)#', '#newdamt_bil#', '#newamt_bil#', '#val(getbody.taxpec1)#',
					'#val(getbody.taxpec2)#', '#val(getbody.taxpec3)#', '#newtaxamt_bil#', '', '#getbody.qty#', '#newprice#',
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.unit#">, '#newamt1#', '#newdamt#',	'#newamt#', '#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#',
					'#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#dateformat(getbody.wos_date,"yyyy-mm-dd")#', '#getbody.brem1#', '#getbody.brem2#', '#getbody.brem3#',
					'#getbody.brem4#', 
					<cfif lcase(hcomid) eq "avent_i">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
					<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
					</cfif>
					'#getbody.packing#', '#getbody.note1#', '#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N',
					'', '#getbody.grade#', '0.00','0.00','0',
					'0', '#getbody.m_charge1#', '#getbody.m_charge2#', '#getbody.adtcost1#', '#getbody.adtcost2#', '0', '0', '#getbody.batchcode#',<cfif getbody.expdate eq "" or getbody.expdate eq "0000-00-00">'0000-00-00'<cfelse>#getbody.expdate#</cfif>, '0', '0', '0', '', '', '0', '0', '0','#getbody.name#', '', '#getbody.van#', 'Y',
					'', '',	'', '0000-00-00', '', '0000-00-00', '', '', '', '', '#getbody.sono#', '#getbody.quono#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getbody.userid#'<cfelse>'#huserid#'</cfif>, '0', '', '#getbody.wos_group#',
					'#getbody.category#', '#getbody.area#', '#getbody.shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#',
					'0', '#member#', '', #Now()#, 'Time', '#getbody.bomno#',
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
					  '','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					</cfif>
				</cfquery>
				</cfif>
				<cfquery name="inserticlink" datasource="#dts#">
					insert into iclink values ('INV','#nexttranno#','#j#',
					'#ndatenow#','DO','#listgetat(mylist,i,";")#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#getbody.qty_bil#')
				</cfquery>
				
				<!--- Add on 031008 --->
        		<cfquery datasource="#dts#" name="getigrade">
					Select * from igrade where refno = '#listgetat(mylist,i,";")#' and type = 'DO' 
                    and TRANCODE = '#getbody.trancode#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
				</cfquery>
				
				<cfif getigrade.recordcount neq 0>
            		<cfquery name="insertigrade" datasource="#dts#">
                		insert into igrade
						(type,refno,trancode,itemno,wos_date,fperiod,sign,del_by,location,void,generated,custno,exported,factor1,factor2,
						<cfloop from="11" to="160" index="k">
							<cfif k neq 160>
								GRD#k#,
							<cfelse>
								GRD#k#
							</cfif>
						</cfloop>)
						values
						('INV','#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.itemno#">,'#ndatenow#','#readperiod#',
						'-1','',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.location#">,'','',
						'#getigrade.custno#','','#getigrade.factor1#','#getigrade.factor2#',
						<cfloop from="11" to="160" index="k">
							<cfif k neq 160>
								#Evaluate("getigrade.GRD#k#")#,
							<cfelse>
								#Evaluate("getigrade.GRD#k#")#
							</cfif>
						</cfloop>)
                	</cfquery>
				</cfif>
				
				<cfset j = j + 1>
			</cfloop>
		</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'DO'
		</cfquery>
        
        <cfquery datasource="#dts#" name="updateartran">
				Update artran set toinv = '#nexttranno#', generated = 'Y' where refno = '#listgetat(mylist,1,";")#' and type = 'DO'
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

		<cfif lcase(hcomid) eq "leatat_i">
                <cfset currency.rate= getheader.currrate>
		</cfif>
		<cfif currency.rate neq "">
			<cfset newcurrate = currency.rate>
		<cfelse>
			<cfset newcurrate = 1>
		</cfif>
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
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
		<cfset net = net_bil * newcurrate>
        
        <cfif getheader.taxincl neq "T">
        
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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
        <cfoutput>
        #getheader.taxincl#
        </cfoutput>
        <cfif getheader.taxincl neq "T">
			<cfif totaltaxcharge eq 0 and taxcharge eq 0>
				<cfset grand_bil = net_bil + tax_bil>
            <cfelseif taxcharge neq 0>
				<cfset grand_bil = net_bil + taxcharge>
            <cfelse>
            	<cfset grand_bil = net_bil>
            </cfif>
        <cfelse>
			<cfset grand_bil = net_bil>
        </cfif>
		<cfset xdebt=grand_bil-val(getheader.deposit)-val(getheader.cs_pm_cash)-val(getheader.cs_pm_cheq)-val(getheader.cs_pm_crcd)-val(getheader.cs_pm_crc2)-val(getheader.cs_pm_vouc)-val(getheader.cs_pm_dbcd)>
		<cfset grand_bil = numberformat(grand_bil,".__")>
		<cfset grand = grand_bil * newcurrate>
		<cfset grand = numberformat(grand,".__")>
		
		<cfif lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i">
			<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getheader.rem9#" returnvariable="getheader.rem9"/>
			<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getheader.rem11#" returnvariable="getheader.rem11"/>
	    </cfif>
        <cfif getheader.desp eq "" or getheader.desp eq "DELIVERY">
        <cfset getheader.desp  = "SALES">
		</cfif>
        
        <cfquery name="gettermscondition" datasource="#dts#">
        	select linv from ictermandcondition
        </cfquery>
		
		<!--- DO TO INV --->
        <cfif lcase(hcomid) eq 'bsssb_i' or lcase(hcomid) eq 'hnm_i' or lcase(hcomid) eq 'rvsb_i' or lcase(hcomid) eq 'puss_i'>
        <cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,currrate,
			gross_bil,disc1_bil,disc2_bil,disc3_bil,
			disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,
			discount3,discount,net,tax1,tax2,tax3,tax,taxp1,taxp2,taxp3,grand,note,
			term,van,pono,dono,sono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,rem12,frem0,frem1,frem2,
			frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
			trdatetime,userid,username,currcode,m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,
			mc5_bil,mc6_bil,mc7_bil,creditcardtype1,creditcardtype2,deposit,cs_pm_cash,cs_pm_cheq,cs_pm_crcd,cs_pm_crc2,cs_pm_vouc,cs_pm_debt,cs_pm_dbcd,
            special_account_code,created_by,created_on,updated_by,updated_on,
            rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49
			<cfif lcase(hcomid) eq 'iel_i'>
				,rem15,rem16,rem17,rem18,rem19,rem20,rem21,rem22,rem23,rem24,rem25
			</cfif>,taxincl,e_mail,d_phone2,postalcode,d_postalcode,B_GSTno,D_GSTno)

			values('INV','#nexttranno#','#getheader.refno2#','#getheader.custno#','#readperiod#','#ndatenow#','#getheader.desp#',
			'#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#','#getheader.job#',
			'#newcurrate#','#getheader.gross_bil#','#getheader.disc1_bil#','#getheader.disc2_bil#','#getheader.disc3_bil#',
			'#getheader.disc_bil#','#getheader.net_bil#','#numberformat(getheader.tax1_bil,".__")#','#getheader.tax2_bil#','#getheader.tax3_bil#',
			'#numberformat(getheader.tax_bil,".__")#','#getheader.grand_bil#','#getheader.invgross#',
			'#getheader.disp1#','#getheader.disp2#','#getheader.disp3#','#getheader.discount1#','#getheader.discount2#',
			'#getheader.discount3#','#getheader.discount#','#getheader.net#',
			'#numberformat(getheader.tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(getheader.tax,".__")#','#getheader.taxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#getheader.grand#','#getheader.note#','#getheader.term#','#getheader.van#',
			'#getheader.pono#','#updatepono#','#getheader.sono#','#getheader.quono#','#getheader.rem0#','#getheader.rem1#', '#getheader.rem2#',
			'#getheader.rem3#', '#getheader.rem4#','#getheader.rem5#','#getheader.rem6#', <cfif lcase(hcomid) eq 'fdipx_i'>'#getheader.dono#'<cfelse>'#getheader.rem7#'</cfif>,
			'#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#','#getheader.rem11#', '#getheader.rem12#',
			'#getheader.frem0#', '#getheader.frem1#', '#getheader.frem2#', '#getheader.frem3#', '#getheader.frem4#',
			'#getheader.frem5#', '#getheader.frem6#', '#getheader.frem7#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getheader.comm0#', '#getheader.comm1#', '#getheader.comm2#', '#getheader.comm3#', '#getheader.comm4#',
			'#getheader.name#','#getheader.phonea#',
			#Now()#, '#HUserID#','#getusername.username#','#getheader.currcode#','#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#',
			'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#','#getheader.creditcardtype1#','#getheader.creditcardtype2#',
			'#val(getheader.deposit)#','#val(getheader.cs_pm_cash)#','#val(getheader.cs_pm_cheq)#','#val(getheader.cs_pm_crcd)#','#val(getheader.cs_pm_crc2)#',
			'#val(getheader.cs_pm_vouc)#','#val(xdebt)#','#val(getheader.cs_pm_dbcd)#',
			'#getheader.special_account_code#','#HUserID#',#now()#,'#HUserID#',#now()#,'#getheader.rem30#', '#getheader.rem31#', '#getheader.rem32#', '#getheader.rem33#', '#getheader.rem34#', '#getheader.rem35#', '#getheader.rem36#', '#getheader.rem37#', '#getheader.rem38#', '#getheader.rem39#', '#getheader.rem40#', '#getheader.rem41#', '#getheader.rem42#', '#getheader.rem43#', '#getheader.rem44#', '#getheader.rem45#', '#getheader.rem46#', '#getheader.rem47#', '#getheader.rem48#', '#getheader.rem49#'
			<cfif lcase(hcomid) eq 'iel_i'>
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem15#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem16#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem17#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem18#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem19#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem20#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem21#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem22#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem23#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem24#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem25#">
			</cfif>,'#getheader.taxincl#','#getheader.e_mail#','#getheader.d_phone2#','#getheader.postalcode#','#getheader.d_postalcode#',
            '#getheader.B_GSTno#','#getheader.D_GSTno#')
		</cfquery>
        <cfelse>
		<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,currrate,
			gross_bil,disc1_bil,disc2_bil,disc3_bil,
			disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,
			discount3,discount,net,tax1,tax2,tax3,tax,taxp1,taxp2,taxp3,grand,note,
			term,van,pono,dono,sono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,rem12,frem0,frem1,frem2,
			frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
			trdatetime,userid,username,currcode,m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,
			mc5_bil,mc6_bil,mc7_bil,creditcardtype1,creditcardtype2,deposit,cs_pm_cash,cs_pm_cheq,cs_pm_crcd,cs_pm_crc2,cs_pm_vouc,cs_pm_debt,cs_pm_dbcd,
			special_account_code,created_by,created_on,updated_by,updated_on,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49,termscondition
			<cfif lcase(hcomid) eq 'iel_i'>
				,rem15,rem16,rem17,rem18,rem19,rem20,rem21,rem22,rem23,rem24,rem25
			</cfif>,taxincl,e_mail,depositno,postalcode,d_postalcode,B_GSTno,D_GSTno,country,d_country)

			values('INV','#nexttranno#','#getheader.refno2#','#getheader.custno#','#readperiod#','#ndatenow#','#getheader.desp#',
			'#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#','#getheader.job#',
			'#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#',
			'#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#','#getheader.tax2_bil#','#getheader.tax3_bil#',
			'#numberformat(tax_bil,".__")#','#grand_bil#','#gross#',
			'#xdisp1#','#xdisp2#','#xdisp3#','#discount1#','#discount2#',
			'#discount3#','#discount#','#net#',
			'#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#','#getheader.term#','#getheader.van#',
			'#getheader.pono#','#updatepono#','#getheader.sono#','#getheader.quono#','#getheader.rem0#','#getheader.rem1#', '#getheader.rem2#',
			'#getheader.rem3#', '#getheader.rem4#','#getheader.rem5#','#getheader.rem6#', <cfif lcase(hcomid) eq 'fdipx_i'>'#getheader.dono#'<cfelse>'#getheader.rem7#'</cfif>,
			'#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#','#getheader.rem11#', '#getheader.rem12#',
			'#getheader.frem0#', '#getheader.frem1#', '#getheader.frem2#', '#getheader.frem3#', '#getheader.frem4#',
			'#getheader.frem5#', '#getheader.frem6#', '#getheader.frem7#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getheader.comm0#', '#getheader.comm1#', '#getheader.comm2#', '#getheader.comm3#', '#getheader.comm4#',
			'#getheader.name#','#getheader.phonea#',
			#Now()#, <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getheader.userid#'<cfelse>'#HUserID#'</cfif>,'#getusername.username#','#getheader.currcode#','#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#',
			'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#','#getheader.creditcardtype1#','#getheader.creditcardtype2#',
			'#val(getheader.deposit)#','#val(getheader.cs_pm_cash)#','#val(getheader.cs_pm_cheq)#','#val(getheader.cs_pm_crcd)#','#val(getheader.cs_pm_crc2)#',
			'#val(getheader.cs_pm_vouc)#','#val(xdebt)#','#val(getheader.cs_pm_dbcd)#',
			'#getheader.special_account_code#','#HUserID#',#now()#,'#HUserID#',#now()#,'#getheader.rem30#', '#getheader.rem31#', '#getheader.rem32#', '#getheader.rem33#', '#getheader.rem34#', '#getheader.rem35#', '#getheader.rem36#', '#getheader.rem37#', '#getheader.rem38#', '#getheader.rem39#', '#getheader.rem40#', '#getheader.rem41#', '#getheader.rem42#', '#getheader.rem43#', '#getheader.rem44#', '#getheader.rem45#', '#getheader.rem46#', '#getheader.rem47#', '#getheader.rem48#', '#getheader.rem49#',<cfif gettermscondition.linv neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#gettermscondition.linv#"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.termscondition#"></cfif>
			<cfif lcase(hcomid) eq 'iel_i'>
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem15#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem16#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem17#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem18#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem19#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem20#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem21#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem22#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem23#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem24#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem25#">
			</cfif>,'#getheader.taxincl#','#getheader.e_mail#','#getheader.depositno#','#getheader.postalcode#','#getheader.d_postalcode#','#getheader.B_GSTno#','#getheader.D_GSTno#','#getheader.country#','#getheader.d_country#')
		</cfquery>
        </cfif>
		
		<cftry>
			<cfquery name="getheader_remark" datasource="#dts#">
				select 
				type,
				refno,
				cast(remark1 as binary) as remark1,
				cast(remark2 as binary) as remark2,
				cast(remark3 as binary) as remark3,
				cast(remark4 as binary) as remark4,
				cast(remark5 as binary) as remark5,
				cast(remark6 as binary) as remark6,
				cast(remark7 as binary) as remark7,
				cast(remark8 as binary) as remark8,
				cast(remark9 as binary) as remark9,
				cast(remark10 as binary) as remark10
				from artran_remark where refno = '#listgetat(mylist,1,";")#' and type = 'DO'
			</cfquery>
			<cfif getheader_remark.recordcount neq 0>
				<cfquery name="insert_remark" datasource="#dts#">
					insert into artran_remark
					(type,refno,
					<cfloop from="1" to="10" index="z">
						remark#z#,
					</cfloop>USERID,LASTUSERID)
					values
					('INV','#nexttranno#',
					<cfloop from="1" to="10" index="z">
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#getheader_remark["remark#z#"][1]#">,
					</cfloop>'#HUserID#','#HUserID#')
				</cfquery>
			</cfif>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
		<!--- End of Update to Invoice from Delivery Order --->
	<!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
	<cfelseif url.t1 eq "SO">
    <cfif getmodule.auto eq "1">
    <!---shell so to inv--->
    <cfset type = gettranname.lSO>
		
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
            <cfquery name="updategsetup" datasource="#dts#">
                update refnoset set 
                lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and counter =  '#invset#'
            </cfquery>
		</cfif>
        
		<cfoutput><h2>#gettranname.lSO# no: #listfirst(form.checkbox,";")# is successfully updated to #gettranname.lINV# No: <a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></h2></cfoutput>

		<cfset mylist= listchangedelims(checkbox,"",",")>

		<cfset cnt=listlen(mylist,";")>
		<cfset j = 1>
		
		Transaction Update Summary<br><br>

		<cfloop from="1" to="#cnt#" index="i">
			<cfif LastPONO neq listgetat(mylist,i,";")>
				<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>
			  	<cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>So No. : #listgetat(mylist,i,";")# <br></cfoutput>

			<!--- Start of update header --->
			<cfquery datasource="#dts#" name="updateartran">
				Update artran set toinv = '#nexttranno#', generated = 'Y', order_cl = 'Y' where refno = '#listgetat(mylist,i,";")#' and type = 'SO'
			</cfquery>
			<!--- End of Update header --->
			<!--- Start of Update body --->
			<cfquery datasource="#dts#" name="updateictran">
				Update ictran set shipped = qty, toinv = '#nexttranno#', generated = 'Y' where refno = '#listgetat(mylist,i,";")#' and type = 'SO'
			</cfquery>
			<!--- End of Update body --->
			<!--- Add on 031008 --->
			<!--- Start of Update igrade --->
			<cfquery datasource="#dts#" name="updateictran">
				Update igrade set generated = 'Y' where refno = '#listgetat(mylist,i,";")#' and type = 'SO'
			</cfquery>
			<!--- Transaction Details<br>--->
			<cfquery datasource="#dts#" name="getbody">
				Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = 'SO' order by trancode
			</cfquery>

			<cfloop query="getbody">
			  	<!--- GET LATEST CURRRATE --->
			  	<cfquery datasource="#dts#" name="getheader">
					Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SO'
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
                
				<cfif lcase(hcomid) eq "leatat_i">
                <cfset currency.rate= getheader.currrate>
				</cfif>
				<cfif currency.rate neq "">
					<cfset newcurrate = val(currency.rate)>
				<cfelse>
					<cfset newcurrate = 1><!--- default --->
				</cfif>
                
                <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>

				<cfset newamt1_bil = val(getbody.qty_bil) * val(getbody.price_bil)>
				<cfset newdamt_bil1 = (val(getbody.dispec1) / 100) * val(newamt1_bil)>
				<cfset netamt = val(newamt1_bil) - val(newdamt_bil1)>
				<cfset newdamt_bil2 = (val(getbody.dispec2) / 100) * val(netamt)>
				<cfset netamt = val(netamt) - val(newdamt_bil2)>
				<cfset newdamt_bil3 = (val(getbody.dispec3) / 100) * val(netamt)>
				<cfset netamt = val(netamt) - val(newdamt_bil3)>

				<cfset newdamt_bil = val(getbody.disamt_bil)>
                <cfif getbody.taxincl neq "T">
				<cfset newtaxamt_bil = (val(getbody.taxpec1) / 100) * (val(newamt1_bil) - val(newdamt_bil))>
                <cfelse>
                <cfset newtaxamt_bil = ((val(newamt1_bil) - val(newdamt_bil)) * val(getbody.taxpec1))/(100+val(getbody.taxpec1)) >
				</cfif>
                
                <cfif getbody.taxincl neq "T">
                <cfset taxcharge = taxcharge + newtaxamt_bil>
				</cfif>
                <cfset totaltaxcharge = totaltaxcharge + newtaxamt_bil>
                
				<!--- <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil) + val(newtaxamt_bil)> --->
                <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil)>
				<cfset newamt_bil = numberformat(val(newamt_bil),".__")>
				<cfset newprice = val(getbody.price_bil) * val(newcurrate)>

				<cfset newamt1 = val(newamt1_bil) * val(newcurrate)>
				<cfset newdamt = val(newdamt_bil) * val(newcurrate)>
				<cfset newtaxamt = val(newtaxamt_bil) * val(newcurrate)>
				<cfset newamt = val(newamt_bil) * val(newcurrate)>
				<cfset newamt = numberformat(val(newamt),".__")>

				<cfset gross_bil = val(gross_bil) + val(newamt_bil)>
				<cfset gross = val(gross_bil) * val(newcurrate)>
                
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.dodate#" returnvariable="getbody.dodate"/>
					
				<!---SHELL SO TO INV --->
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
					`VOID`,`SONO`,`QUONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`TEMP`,`TEMP1`,
					`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,`TABLENO`,`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,
					`NODISPLAY`,`TITLE_ID`,`TITLE_DESP`,<cfif lcase(hcomid) eq "topsteel_i">`TITLE_DESPA`,</cfif>
					`COMMENT`,`DEFECTIVE`,`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,
					`MC6_BIL`,`MC7_BIL`<cfif lcase(hcomid) eq "fdipx_i">,`JobOrderNo`</cfif>,`taxincl`,`note_a`) 
					values ('INV', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
					'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,	
					'#getbody.agenno#',	 <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">, '#getbody.source#', '#getbody.job#', '',
					'#getbody.qty_bil#', '#getbody.price_bil#',	'#getbody.unit_bil#', '#newamt1_bil#', '#val(getbody.dispec1)#',
					'#val(getbody.dispec2)#', '#val(getbody.dispec3)#', '#newdamt_bil#', '#newamt_bil#', '#val(getbody.taxpec1)#',
					'#val(getbody.taxpec2)#', '#val(getbody.taxpec3)#', '#newtaxamt_bil#', '', '#getbody.qty#', '#newprice#',
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.unit#">, '#newamt1#', '#newdamt#',	'#newamt#', '#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#',
					'#listgetat(mylist,i,";")#', <cfif getbody.wos_date eq '' or getbody.wos_date eq '0000-00-00'>'0000-00-00'<cfelse>'#dateformat(getbody.wos_date,"yyyy-mm-dd")#'</cfif>,<cfif getbody.wos_date eq '' or getbody.wos_date eq '0000-00-00'>'0000-00-00'<cfelse>'#dateformat(getbody.wos_date,"yyyy-mm-dd")#'</cfif>, '#getbody.brem1#', '#getbody.brem2#', '#getbody.brem3#',
					'#getbody.brem4#', 
					<cfif lcase(hcomid) eq "avent_i">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
					<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
					</cfif>
					'#getbody.packing#', '#getbody.note1#', '#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N',
					'', '#getbody.grade#', '0.00','0.00','0',
					'0', '#getbody.m_charge1#', '#getbody.m_charge2#', '#getbody.adtcost1#', '#getbody.adtcost2#', '0', '0', '#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '', '0', '0', '0','#getbody.name#', '', '#getbody.van#', 'Y',
					'', '',	'', '0000-00-00', '', '0000-00-00', '', '', '', '', '#getbody.sono#', '#getbody.quono#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#',
					'#getbody.category#', '#getbody.area#', '#getbody.shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#',
					'0', '#member#', '', #Now()#, 'Time', '#getbody.bomno#',
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
					  '','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					</cfif>
				</cfquery>

				<cfquery name="inserticlink" datasource="#dts#">
					insert into iclink values ('INV','#nexttranno#','#j#',
					'#ndatenow#','SO','#listgetat(mylist,i,";")#','#getbody.trancode#',
					<cfif getbody.wos_date eq '' or getbody.wos_date eq '0000-00-00'>'0000-00-00'<cfelse>#getbody.wos_date#</cfif>,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#getbody.qty_bil#')
				</cfquery>
				
				<!--- Add on 031008 --->
        		<cfquery datasource="#dts#" name="getigrade">
					Select * from igrade where refno = '#listgetat(mylist,i,";")#' and type = 'SO' 
                    and TRANCODE = '#getbody.trancode#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
				</cfquery>
				
				<cfif getigrade.recordcount neq 0>
            		<cfquery name="insertigrade" datasource="#dts#">
                		insert into igrade
						(type,refno,trancode,itemno,wos_date,fperiod,sign,del_by,location,void,generated,custno,exported,factor1,factor2,
						<cfloop from="11" to="160" index="k">
							<cfif k neq 160>
								GRD#k#,
							<cfelse>
								GRD#k#
							</cfif>
						</cfloop>)
						values
						('INV','#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.itemno#">,'#ndatenow#','#readperiod#',
						'-1','',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.location#">,'','',
						'#getigrade.custno#','','#getigrade.factor1#','#getigrade.factor2#',
						<cfloop from="11" to="160" index="k">
							<cfif k neq 160>
								#Evaluate("getigrade.GRD#k#")#,
							<cfelse>
								#Evaluate("getigrade.GRD#k#")#
							</cfif>
						</cfloop>)
                	</cfquery>
				</cfif>
				
				<cfset j = j + 1>
			</cfloop>
		</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SO'
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

		<cfif lcase(hcomid) eq "leatat_i">
                <cfset currency.rate= getheader.currrate>
		</cfif>
		<cfif currency.rate neq "">
			<cfset newcurrate = currency.rate>
		<cfelse>
			<cfset newcurrate = 1>
		</cfif>
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
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
		<cfset net = net_bil * newcurrate>
        
        <cfif getheader.taxincl neq "T">
        
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
        <cfoutput>
        #getheader.taxincl#
        </cfoutput>
        <cfif getheader.taxincl neq "T">
			<cfif totaltaxcharge eq 0 and taxcharge eq 0>
				<cfset grand_bil = net_bil + tax_bil>
            <cfelseif taxcharge neq 0>
				<cfset grand_bil = net_bil + taxcharge>
            <cfelse>
            	<cfset grand_bil = net_bil>
            </cfif>
        <cfelse>
			<cfset grand_bil = net_bil>
        </cfif>
		<cfset xdebt=grand_bil-val(getheader.deposit)-val(getheader.cs_pm_cash)-val(getheader.cs_pm_cheq)-val(getheader.cs_pm_crcd)-val(getheader.cs_pm_crc2)-val(getheader.cs_pm_vouc)>
		<cfset grand_bil = numberformat(grand_bil,".__")>
		<cfset grand = grand_bil * newcurrate>
		<cfset grand = numberformat(grand,".__")>
		
		<cfif lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i">
			<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getheader.rem9#" returnvariable="getheader.rem9"/>
			<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getheader.rem11#" returnvariable="getheader.rem11"/>
	    </cfif>
        <cfif getheader.desp eq "" or getheader.desp eq "DELIVERY">
        <cfset getheader.desp  = "SALES">
		</cfif>
		
		<!---SHELL SO TO INV --->
		<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,currrate,
			gross_bil,disc1_bil,disc2_bil,disc3_bil,
			disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,
			discount3,discount,net,tax1,tax2,tax3,tax,taxp1,taxp2,taxp3,grand,note,
			term,van,pono,dono,sono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,rem12,frem0,frem1,frem2,
			frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
			trdatetime,userid,username,currcode,m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,
			mc5_bil,mc6_bil,mc7_bil,deposit,cs_pm_cash,cs_pm_cheq,cs_pm_crcd,cs_pm_crc2,cs_pm_vouc,cs_pm_debt,
			special_account_code,created_by,created_on,updated_by,updated_on,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49
			<cfif lcase(hcomid) eq 'iel_i'>
				,rem15,rem16,rem17,rem18,rem19,rem20,rem21,rem22,rem23,rem24,rem25
			</cfif>,taxincl,e_mail)

			values('INV','#nexttranno#','#getheader.refno2#','#getheader.custno#','#readperiod#','#ndatenow#','#getheader.desp#',
			'#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#','#getheader.job#',
			'#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#',
			'#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#','#getheader.tax2_bil#','#getheader.tax3_bil#',
			'#numberformat(tax_bil,".__")#','#grand_bil#','#gross#',
			'#xdisp1#','#xdisp2#','#xdisp3#','#discount1#','#discount2#',
			'#discount3#','#discount#','#net#',
			'#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#','#getheader.term#','#getheader.van#',
			'#getheader.pono#','#updatepono#','#getheader.sono#','#getheader.quono#','#getheader.rem0#','#getheader.rem1#', '#getheader.rem2#',
			'#getheader.rem3#', '#getheader.rem4#','#getheader.rem5#','#getheader.rem6#', <cfif lcase(hcomid) eq 'fdipx_i'>'#getheader.dono#'<cfelse>'#getheader.rem7#'</cfif>,
			'#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#','#getheader.rem11#', '#getheader.rem12#',
			'#getheader.frem0#', '#getheader.frem1#', '#getheader.frem2#', '#getheader.frem3#', '#getheader.frem4#',
			'#getheader.frem5#', '#getheader.frem6#', '#getheader.frem7#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getheader.comm0#', '#getheader.comm1#', '#getheader.comm2#', '#getheader.comm3#', '#getheader.comm4#',
			'#getheader.name#','#getheader.phonea#',
			#Now()#, '#HUserID#','#getusername.username#','#getheader.currcode#','#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#',
			'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#',
			'#val(getheader.deposit)#','#val(getheader.cs_pm_cash)#','#val(getheader.cs_pm_cheq)#','#val(getheader.cs_pm_crcd)#','#val(getheader.cs_pm_crc2)#',
			'#val(getheader.cs_pm_vouc)#','#val(xdebt)#',
			'#getheader.special_account_code#','#HUserID#',#now()#,'#HUserID#',#now()#,'#getheader.rem30#', '#getheader.rem31#', '#getheader.rem32#', '#getheader.rem33#', '#getheader.rem34#', '#getheader.rem35#', '#getheader.rem36#', '#getheader.rem37#', '#getheader.rem38#', '#getheader.rem39#', '#getheader.rem40#', '#getheader.rem41#', '#getheader.rem42#', '#getheader.rem43#', '#getheader.rem44#', '#getheader.rem45#', '#getheader.rem46#', '#getheader.rem47#', '#getheader.rem48#', '#getheader.rem49#'
			<cfif lcase(hcomid) eq 'iel_i'>
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem15#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem16#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem17#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem18#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem19#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem20#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem21#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem22#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem23#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem24#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem25#">
			</cfif>,'#getheader.taxincl#','#getheader.e_mail#')
		</cfquery>
		
		<cftry>
			<cfquery name="getheader_remark" datasource="#dts#">
				select 
				type,
				refno,
				cast(remark1 as binary) as remark1,
				cast(remark2 as binary) as remark2,
				cast(remark3 as binary) as remark3,
				cast(remark4 as binary) as remark4,
				cast(remark5 as binary) as remark5,
				cast(remark6 as binary) as remark6,
				cast(remark7 as binary) as remark7,
				cast(remark8 as binary) as remark8,
				cast(remark9 as binary) as remark9,
				cast(remark10 as binary) as remark10
				from artran_remark where refno = '#listgetat(mylist,1,";")#' and type = 'SO'
			</cfquery>
			<cfif getheader_remark.recordcount neq 0>
				<cfquery name="insert_remark" datasource="#dts#">
					insert into artran_remark
					(type,refno,
					<cfloop from="1" to="10" index="z">
						remark#z#,
					</cfloop>USERID,LASTUSERID)
					values
					('INV','#nexttranno#',
					<cfloop from="1" to="10" index="z">
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#getheader_remark["remark#z#"][1]#">,
					</cfloop>'#HUserID#','#HUserID#')
				</cfquery>
			</cfif>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
    <!---End shell so to inv--->
    
    <cfelseif lcase(hcomid) eq "atc2005_i">
    <!---atc2005 so to inv--->
    <cfset type = gettranname.lSO>    
    Transaction Update Summary<br><br>
    
    <cfset mylist= listchangedelims(checkbox,"",",")>

	<cfset cnt=listlen(mylist,";")>
	<cfset j = 1>

	<cfloop from="1" to="#cnt#" index="i">
    <cfset gross_bil=0>
    <cfset gross=0>
    <!---
    <cfquery name="get_running_no" datasource="#dts#">
			select lastusedno as tranno,refnoused as arun,refnocode,refnocode2,presuffixuse from refnoset where counter = "#invset#" and type = "#t2#"   
	</cfquery>
		
		
       	<cfset refnocheck = 0>
		<cfset refno1 = get_running_no.tranno>
        <cfloop condition="refnocheck eq 0">
        <cftry>
        <cfinvoke component="cfc.incrementValue" method="getIncreament" returnvariable="nexttranno">
			<cfinvokeargument name="input" value="#refno1#">
		</cfinvoke>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#get_running_no.tranno#" returnvariable="nexttranno" />	
		</cfcatch>
        </cftry>
        <cfquery name="checkexistence" datasource="#dts#">
        SELECT refno FROM artran WHERE 
        refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno#"> and type = '#t2#'
        </cfquery>
        <cfif checkexistence.recordcount eq 0>
        <cfset refnocheck = 1>
        <cfelse>
        <cfset refno1 = nexttranno>
		</cfif>
        </cfloop>
		--->
        
        <cfset nexttranno=listgetat(mylist,i,";")>
        
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=UPPER('#nexttranno#')
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
        
            <cfquery name="updategsetup" datasource="#dts#">
                update refnoset set 
                lastUsedNo=UPPER('#nexttranno#')
                where type = '#url.t2#'
                and counter =  '#invset#'
            </cfquery>
        </cfif>
        
		    <cfoutput><h2>#gettranname.lSO# no: #listfirst(form.checkbox,";")# is successfully updated to #gettranname.lINV# No: <a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></h2></cfoutput>

		
			<cfif LastPONO neq listgetat(mylist,i,";")>
				<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>
			  	<cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>So No. : #listgetat(mylist,i,";")# <br></cfoutput>

			<!--- Start of update header --->
			<cfquery datasource="#dts#" name="updateartran">
				Update artran set toinv = '#nexttranno#', generated = 'Y', order_cl = 'Y' where refno = '#listgetat(mylist,i,";")#' and type = 'SO'
			</cfquery>
			<!--- End of Update header --->
			<!--- Start of Update body --->
			<cfquery datasource="#dts#" name="updateictran">
				Update ictran set shipped = qty, toinv = '#nexttranno#', generated = 'Y' where refno = '#listgetat(mylist,i,";")#' and type = 'SO'
			</cfquery>
			<!--- End of Update body --->
			<!--- Add on 031008 --->
			<!--- Start of Update igrade --->
			<cfquery datasource="#dts#" name="updateictran">
				Update igrade set generated = 'Y' where refno = '#listgetat(mylist,i,";")#' and type = 'SO'
			</cfquery>
			<!--- Transaction Details<br>--->
			<cfquery datasource="#dts#" name="getbody">
				Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = 'SO' order by trancode
			</cfquery>

			<cfloop query="getbody">
			  	<!--- GET LATEST CURRRATE --->
			  	<cfquery datasource="#dts#" name="getheader">
					Select * from artran where refno = '#listgetat(mylist,i,";")#' and type = 'SO'
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
                
				<cfif lcase(hcomid) eq "leatat_i">
                <cfset currency.rate= getheader.currrate>
				</cfif>
				<cfif currency.rate neq "">
					<cfset newcurrate = val(currency.rate)>
				<cfelse>
					<cfset newcurrate = 1><!--- default --->
				</cfif>
                
                <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>

				<cfset newamt1_bil = val(getbody.qty_bil) * val(getbody.price_bil)>
				<cfset newdamt_bil1 = (val(getbody.dispec1) / 100) * val(newamt1_bil)>
				<cfset netamt = val(newamt1_bil) - val(newdamt_bil1)>
				<cfset newdamt_bil2 = (val(getbody.dispec2) / 100) * val(netamt)>
				<cfset netamt = val(netamt) - val(newdamt_bil2)>
				<cfset newdamt_bil3 = (val(getbody.dispec3) / 100) * val(netamt)>
				<cfset netamt = val(netamt) - val(newdamt_bil3)>

				<cfset newdamt_bil = val(getbody.disamt_bil)>
                <cfif getbody.taxincl neq "T">
				<cfset newtaxamt_bil = (val(getbody.taxpec1) / 100) * (val(newamt1_bil) - val(newdamt_bil))>
                <cfelse>
                <cfset newtaxamt_bil = ((val(newamt1_bil) - val(newdamt_bil)) * val(getbody.taxpec1))/(100+val(getbody.taxpec1)) >
				</cfif>
                
                <cfif getbody.taxincl neq "T">
                <cfset taxcharge = taxcharge + newtaxamt_bil>
				</cfif>
                <cfset totaltaxcharge = totaltaxcharge + newtaxamt_bil>
                
				<!--- <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil) + val(newtaxamt_bil)> --->
                <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil)>
				<cfset newamt_bil = numberformat(val(newamt_bil),".__")>
				<cfset newprice = val(getbody.price_bil) * val(newcurrate)>

				<cfset newamt1 = val(newamt1_bil) * val(newcurrate)>
				<cfset newdamt = val(newdamt_bil) * val(newcurrate)>
				<cfset newtaxamt = val(newtaxamt_bil) * val(newcurrate)>
				<cfset newamt = val(newamt_bil) * val(newcurrate)>
				<cfset newamt = numberformat(val(newamt),".__")>

				<cfset gross_bil = val(gross_bil) + val(newamt_bil)>
				<cfset gross = val(gross_bil) * val(newcurrate)>
                
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
					
				<!---atc2005 SO TO INV --->
                <cftry>
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
					`VOID`,`SONO`,`QUONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`TEMP`,`TEMP1`,
					`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,`TABLENO`,`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,
					`NODISPLAY`,`TITLE_ID`,`TITLE_DESP`,<cfif lcase(hcomid) eq "topsteel_i">`TITLE_DESPA`,</cfif>
					`COMMENT`,`DEFECTIVE`,`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,
					`MC6_BIL`,`MC7_BIL`<cfif lcase(hcomid) eq "fdipx_i">,`JobOrderNo`</cfif>,`taxincl`,`note_a`) 
					values ('INV', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
					'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,	
					'#getbody.agenno#',	 <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">, '#getbody.source#', '#getbody.job#', '',
					'#getbody.qty_bil#', '#getbody.price_bil#',	'#getbody.unit_bil#', '#newamt1_bil#', '#val(getbody.dispec1)#',
					'#val(getbody.dispec2)#', '#val(getbody.dispec3)#', '#newdamt_bil#', '#newamt_bil#', '#val(getbody.taxpec1)#',
					'#val(getbody.taxpec2)#', '#val(getbody.taxpec3)#', '#newtaxamt_bil#', '', '#getbody.qty#', '#newprice#',
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.unit#">, '#newamt1#', '#newdamt#',	'#newamt#', '#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#',
					'#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#dateformat(getbody.wos_date,"yyyy-mm-dd")#', '#getbody.brem1#', '#getbody.brem2#', '#getbody.brem3#',
					'#getbody.brem4#', 
					<cfif lcase(hcomid) eq "avent_i">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
					<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
					</cfif>
					'#getbody.packing#', '#getbody.note1#', '#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N',
					'', '#getbody.grade#', '0.00','0.00','0',
					'0', '#getbody.m_charge1#', '#getbody.m_charge2#', '#getbody.adtcost1#', '#getbody.adtcost2#', '0', '0', '#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '', '0', '0', '0','#getbody.name#', '', '#getbody.van#', 'Y',
					'', '',	'', '0000-00-00', '', '0000-00-00', '', '', '', '', '#getbody.sono#', '#getbody.quono#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#',
					'#getbody.category#', '#getbody.area#', '#getbody.shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#',
					'0', '#member#', '', #Now()#, 'Time', '#getbody.bomno#',
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
					  '','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					</cfif>
				</cfquery>

				<cfquery name="inserticlink" datasource="#dts#">
					insert into iclink values ('INV','#nexttranno#','#j#',
					'#ndatenow#','SO','#listgetat(mylist,i,";")#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#getbody.qty_bil#')
				</cfquery>
				
				<!--- Add on 031008 --->
        		<cfquery datasource="#dts#" name="getigrade">
					Select * from igrade where refno = '#listgetat(mylist,i,";")#' and type = 'SO' 
                    and TRANCODE = '#getbody.trancode#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
				</cfquery>
				
				<cfif getigrade.recordcount neq 0>
            		<cfquery name="insertigrade" datasource="#dts#">
                		insert into igrade
						(type,refno,trancode,itemno,wos_date,fperiod,sign,del_by,location,void,generated,custno,exported,factor1,factor2,
						<cfloop from="11" to="160" index="k">
							<cfif k neq 160>
								GRD#k#,
							<cfelse>
								GRD#k#
							</cfif>
						</cfloop>)
						values
						('INV','#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.itemno#">,'#ndatenow#','#readperiod#',
						'-1','',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.location#">,'','',
						'#getigrade.custno#','','#getigrade.factor1#','#getigrade.factor2#',
						<cfloop from="11" to="160" index="k">
							<cfif k neq 160>
								#Evaluate("getigrade.GRD#k#")#,
							<cfelse>
								#Evaluate("getigrade.GRD#k#")#
							</cfif>
						</cfloop>)
                	</cfquery>
				</cfif>
				
				<cfset j = j + 1>
                <cfcatch>
                </cfcatch>
                </cftry>
			</cfloop>
            
            
            <cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,i,";")#' and type = 'SO'
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

		<cfif lcase(hcomid) eq "leatat_i">
                <cfset currency.rate= getheader.currrate>
		</cfif>
		<cfif currency.rate neq "">
			<cfset newcurrate = currency.rate>
		<cfelse>
			<cfset newcurrate = 1>
		</cfif>
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
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
		<cfset net = net_bil * newcurrate>
        
        <cfif getheader.taxincl neq "T">
        
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
        <cfoutput>
        #getheader.taxincl#
        </cfoutput>
        <cfif getheader.taxincl neq "T">
			<cfif totaltaxcharge eq 0 and taxcharge eq 0>
				<cfset grand_bil = net_bil + tax_bil>
            <cfelseif taxcharge neq 0>
				<cfset grand_bil = net_bil + taxcharge>
            <cfelse>
            	<cfset grand_bil = net_bil>
            </cfif>
        <cfelse>
			<cfset grand_bil = net_bil>
        </cfif>
		<cfset xdebt=grand_bil-val(getheader.deposit)-val(getheader.cs_pm_cash)-val(getheader.cs_pm_cheq)-val(getheader.cs_pm_crcd)-val(getheader.cs_pm_crc2)-val(getheader.cs_pm_vouc)>
		<cfset grand_bil = numberformat(grand_bil,".__")>
		<cfset grand = grand_bil * newcurrate>
		<cfset grand = numberformat(grand,".__")>
		
		<cfif lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i">
			<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getheader.rem9#" returnvariable="getheader.rem9"/>
			<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getheader.rem11#" returnvariable="getheader.rem11"/>
	    </cfif>
        <cfif getheader.desp eq "" or getheader.desp eq "DELIVERY">
        <cfset getheader.desp  = "SALES">
		</cfif>
		
		<!---atc2005 SO TO INV --->
		<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,currrate,
			gross_bil,disc1_bil,disc2_bil,disc3_bil,
			disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,
			discount3,discount,net,tax1,tax2,tax3,tax,taxp1,taxp2,taxp3,grand,note,
			term,van,pono,dono,sono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,rem12,rem13,rem14,d_phone2,d_email,postalcode,d_postalcode,frem0,frem1,frem2,
			frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
			trdatetime,userid,username,currcode,m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,
			mc5_bil,mc6_bil,mc7_bil,deposit,cs_pm_cash,cs_pm_cheq,cs_pm_crcd,cs_pm_dbcd,cs_pm_crc2,cs_pm_vouc,cs_pm_debt,
			special_account_code,created_by,created_on,updated_by,updated_on,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49
			<cfif lcase(hcomid) eq 'iel_i'>
				,rem15,rem16,rem17,rem18,rem19,rem20,rem21,rem22,rem23,rem24,rem25
			</cfif>,taxincl,e_mail)

			values('INV','#nexttranno#','#getheader.refno2#','#getheader.custno#','#readperiod#','#ndatenow#','#getheader.desp#',
			'#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#','#getheader.job#',
			'#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#',
			'#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#','#getheader.tax2_bil#','#getheader.tax3_bil#',
			'#numberformat(tax_bil,".__")#','#grand_bil#','#gross#',
			'#xdisp1#','#xdisp2#','#xdisp3#','#discount1#','#discount2#',
			'#discount3#','#discount#','#net#',
			'#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#','#getheader.term#','#getheader.van#',
			'#getheader.pono#','#listgetat(mylist,i,";")#','#getheader.sono#','#getheader.quono#','#getheader.rem0#','#getheader.rem1#', '#getheader.rem2#',
			'#getheader.rem3#', '#getheader.rem4#','#getheader.rem5#','#getheader.rem6#', <cfif lcase(hcomid) eq 'fdipx_i'>'#getheader.dono#'<cfelse>'#getheader.rem7#'</cfif>,
			'#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#','#getheader.rem11#', '#getheader.rem12#','#getheader.rem13#','#getheader.rem14#','#getheader.d_phone2#','#getheader.d_email#','#getheader.postalcode#','#getheader.d_postalcode#',
			'#getheader.frem0#', '#getheader.frem1#', '#getheader.frem2#', '#getheader.frem3#', '#getheader.frem4#',
			'#getheader.frem5#', '#getheader.frem6#', '#getheader.frem7#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getheader.comm0#', '#getheader.comm1#', '#getheader.comm2#', '#getheader.comm3#', '#getheader.comm4#',
			'#getheader.name#','#getheader.phonea#',
			#Now()#, '#HUserID#','#getusername.username#','#getheader.currcode#','#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#',
			'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#',
			'#val(getheader.deposit)#','#val(getheader.cs_pm_cash)#','#val(getheader.cs_pm_cheq)#','#val(getheader.cs_pm_crcd)#','#val(getheader.cs_pm_dbcd)#','#val(getheader.cs_pm_crc2)#',
			'#val(getheader.cs_pm_vouc)#','#val(xdebt)#',
			'#getheader.special_account_code#','#HUserID#',#now()#,'#HUserID#',#now()#,'#getheader.rem30#', '#getheader.rem31#', '#getheader.rem32#', '#getheader.rem33#', '#getheader.rem34#', '#getheader.rem35#', '#getheader.rem36#', '#getheader.rem37#', '#getheader.rem38#', '#getheader.rem39#', '#getheader.rem40#', '#getheader.rem41#', '#getheader.rem42#', '#getheader.rem43#', '#getheader.rem44#', '#getheader.rem45#', '#getheader.rem46#', '#getheader.rem47#', '#getheader.rem48#', '#getheader.rem49#'
			<cfif lcase(hcomid) eq 'iel_i'>
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem15#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem16#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem17#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem18#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem19#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem20#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem21#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem22#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem23#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem24#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem25#">
			</cfif>,'#getheader.taxincl#','#getheader.e_mail#')
		</cfquery>
		
		<cftry>
			<cfquery name="getheader_remark" datasource="#dts#">
				select 
				type,
				refno,
				cast(remark1 as binary) as remark1,
				cast(remark2 as binary) as remark2,
				cast(remark3 as binary) as remark3,
				cast(remark4 as binary) as remark4,
				cast(remark5 as binary) as remark5,
				cast(remark6 as binary) as remark6,
				cast(remark7 as binary) as remark7,
				cast(remark8 as binary) as remark8,
				cast(remark9 as binary) as remark9,
				cast(remark10 as binary) as remark10
				from artran_remark where refno = '#listgetat(mylist,i,";")#' and type = 'SO'
			</cfquery>
			<cfif getheader_remark.recordcount neq 0>
				<cfquery name="insert_remark" datasource="#dts#">
					insert into artran_remark
					(type,refno,
					<cfloop from="1" to="10" index="z">
						remark#z#,
					</cfloop>USERID,LASTUSERID)
					values
					('INV','#nexttranno#',
					<cfloop from="1" to="10" index="z">
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#getheader_remark["remark#z#"][1]#">,
					</cfloop>'#HUserID#','#HUserID#')
				</cfquery>
			</cfif>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
            
            
            <!---end loop so--->
		</cfloop>

		
    <!---End atc2005 so to inv--->
    <cfelse>
    
		<cfset type = gettranname.lSO>
		<!---cfquery datasource="#dts#" name="updategsetup">
			Update Gsetup set #trancode# = UPPER("#nexttranno#")
		</cfquery--->
		
		<!--- <cfquery name="updategsetup" datasource="main">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where userDept = '#dts#'
			and type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
		
		<!--- <cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
        
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
        
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
		</cfif>
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>

		<cfset j = 1>

		<cfloop from="1" to="#cnt#" index="i" step="+3">
			<cfoutput>SO No. : #listgetat(mylist,i,";")# <br></cfoutput>

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
			  	<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  	<cfset xParam2 = ''>
			<cfelse>
			  	<cfset xParam2 = listgetat(mylist,i+1,";")>
			</cfif>

			<cfset xParam3 = listgetat(mylist,i+2,";")>

			<cfquery datasource="#dts#" name="getbody">
				Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and shipped < qty and type = 'SO'
			</cfquery>
		
			<cfloop query="getbody">
			  	<cfquery datasource="#dts#" name="getheader">
					Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SO'
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
                
                <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>

				<!--- Add On 061008, 2nd Unit Function --->
				<!---<cfif val(getbody.factor1) neq 0>
					<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
				<cfelse>
					<cfset getbody.price_bil = 0>
				</cfif>--->
                <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
				
				<cfif lcase(hcomid) eq "nikbra_i">
					<cfset fulfill = qty - shipped+writeoff>
					<cfset newamt1_bil = fulfill * getbody.price_bil>
				<cfelse>
					<cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil>
				</cfif>
				
				<!--- <cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil> --->
                
                <cfif val(getbody.dispec1) eq 0 and val(getbody.dispec2) eq 0 and val(getbody.dispec3) eq 0>
				
                <cfset netamt = newamt1_bil - val(getbody.disamt_bil)>
                <cfset newdamt_bil = val(getbody.disamt_bil)>
                
				<cfelse>
                
				<cfset newdamt_bil1 = (val(getbody.dispec1) / 100) * newamt1_bil>
				<cfset netamt = newamt1_bil - newdamt_bil1>
				<cfset newdamt_bil2 = (val(getbody.dispec2) / 100) * netamt>
				<cfset netamt = netamt - newdamt_bil2>
				<cfset newdamt_bil3 = (val(getbody.dispec3) / 100) * netamt>
				<cfset netamt = netamt - newdamt_bil3>
				<cfset newdamt_bil = newdamt_bil1 + newdamt_bil2 + newdamt_bil3>
                
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
                
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.dodate#" returnvariable="getbody.dodate"/>
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
                
				<!--- SO TO INV --->
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
					`PACKING`,`NOTE1`<cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">,`ictranfilename`</cfif>,
					`NOTE2`,`GLTRADAC`,`UPDCOST`,`GST_ITEM`,`TOTALUP`,`WITHSN`,`GRADE`,`PUR_PRICE`,
					`QTY_RET`,`TEMPFIGI`,`SERCOST`,`M_CHARGE1`,`M_CHARGE2`,`ADTCOST1`,`ADTCOST2`,`IT_COS`,`AV_COST`,
					`BATCHCODE`,`EXPDATE`,`POINT`,`INV_DISC`,`INV_TAX`,`SUPP`,`EDI_COU1`,`WRITEOFF`,`TOSHIP`,`SHIPPED`,`NAME`,`DEL_BY`,
					`VAN`,`GENERATED`,`UD_QTY`,`TOINV`,`EXPORTED`,`EXPORTED1`,`EXPORTED2`,`EXPORTED3`,`BRK_TO`,`SV_PART`,`LAST_YEAR`,
					`VOID`,`SONO`,`QUONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`TEMP`,`TEMP1`,
					`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,`TABLENO`,`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,
					`NODISPLAY`,`TITLE_ID`,`TITLE_DESP`,<cfif lcase(hcomid) eq "topsteel_i">`TITLE_DESPA`,</cfif>
					`COMMENT`,`DEFECTIVE`,`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,
					`MC6_BIL`,`MC7_BIL`<cfif lcase(hcomid) eq "fdipx_i">,`JobOrderNo`</cfif>,`taxincl`,`note_a`)
					values ('INV', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
					'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">, 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,
					'#getbody.agenno#',	
                    <cfif isdefined('form.location')>
                    <cfif listgetat(form.location,j) eq "emptylocation">
						<cfset locationvalue = "">
                        <cfelse>
                        <cfset locationvalue = listgetat(form.location,j)>
                        </cfif>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#locationvalue#">,
                    <cfelse>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">,
					</cfif>
                     '#getbody.source#', '#getbody.job#', '', 
					<cfif lcase(hcomid) eq "nikbra_i">'#val(fulfill)#'<cfelse>'#val(listgetat(form.fulfill,j))#'</cfif>,
					'#getbody.price_bil#', '#getbody.unit#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
					'#newdamt_bil#', '#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#', '#newtaxamt_bil#', '',
					<cfif lcase(hcomid) eq "nikbra_i">'#val(fulfill)#'<cfelse>'#fulfillactual#'</cfif>, 
					'#getbody.price#', '#getbody.unit_bil#','#newamt1#', '#newdamt#',
					'#newamt#', '#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#', 	'#xparam1#',<cfif getbody.dodate eq '' or getbody.dodate eq '0000-00-00'>'0000-00-00'<cfelse>'#dateformat(getbody.dodate,"yyyy-mm-dd")#'</cfif>,'#dateformat(wos_date,"yyyy-mm-dd")#',
					'#brem1#', '#brem2#', '#brem3#', '#brem4#', 
					<cfif lcase(hcomid) eq "avent_i">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
					<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
					</cfif>
					'', ''<cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">,'#getbody.ictranfilename#'</cfif>, '', '#gltradac#', '', 'N', 'N', '', '#grade#', '0.00',
					'0.00', '0', '#getbody.sercost#', '#getbody.m_charge1#', '#getbody.m_charge2#', #getbody.adtcost1#, #getbody.adtcost2#, '0', '0','#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '',
					'', '0', '0', '0','#getbody.name#', '0', '#getbody.van#', 'Y', '', '', '', '0000-00-00', '', '0000-00-00', '', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.sv_part#">, '', '',
					'#xparam1#', '#getbody.quono#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getbody.userid#'<cfelse>'#huserid#'</cfif>, '0', '', '#getbody.wos_group#', '#getbody.category#', '#area#',
					'#Shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#', '0',
					'#member#', '', #Now()#, 'Time', '#bomno#',
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
					  	'','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					</cfif>
				</cfquery>

				<cfif getbody.batchcode neq "">
					<cfif getbody.location neq "">
						<cfquery name="updateobbatch" datasource="#dts#">
							update lobthob set bth_qut=(bth_qut+<cfif lcase(hcomid) eq "nikbra_i">#val(fulfill)#<cfelse>#val(fulfillactual)#</cfif>)
							where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
						<cfquery name="updateobbatch" datasource="#dts#">
							update obbatch set bth_qut=(bth_qut+<cfif lcase(hcomid) eq "nikbra_i">#val(fulfill)#<cfelse>#val(fulfillactual)#</cfif>)
							where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
					<cfelse>
						<cfquery name="updateobbatch" datasource="#dts#">
							update obbatch set bth_qut=(bth_qut+<cfif lcase(hcomid) eq "nikbra_i">#val(fulfill)#<cfelse>#val(fulfillactual)#</cfif>)
							where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
					</cfif>
				</cfif>

				<cfset qname='QOUT'&(readperiod+10)>

				<cfquery name="UpdateIcitem" datasource="#dts#">
					update icitem set #qname#=(#qname#+<cfif lcase(hcomid) eq "nikbra_i">#val(fulfill)#<cfelse>#val(fulfillactual)#</cfif>) where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
				</cfquery>

				<cfquery name="inserticlink" datasource="#dts#">
					insert into iclink values ('INV','#nexttranno#','#j#',
					'#ndatenow#','SO','#listgetat(mylist,i,";")#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,<cfif lcase(hcomid) eq "nikbra_i">'#val(fulfill)#'<cfelse>'#val(listgetat(form.fulfill,j))#'</cfif>)
				</cfquery>

				<!--- <cfset newship = getbody.shipped + listgetat(form.fulfill,j)> --->
				<cfif lcase(hcomid) eq "nikbra_i">
					<cfset newship = getbody.shipped+val(fulfill)>
				<cfelse>
                <cfif getbody.shipped lte 0>
                <cfset newship = val(listgetat(form.fulfill,j))>
                <cfelse>
					<cfset newship = getbody.shipped+val(listgetat(form.fulfill,j))>
                </cfif>
				</cfif>

				<cfquery datasource="#dts#" name="updateictran">
					Update ictran set shipped = '#newship#'
					where refno = '#xparam1#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and trancode = '#xparam3#'
					and type = 'SO'
				</cfquery>
				
				<!--- Step 1:--->
				<cfif lcase(hcomid) neq "nikbra_i">
					<!--- Start: Add on 031008, graded item --->
					<!--- <cfif Evaluate("form.grdcolumnlist_SO_#xparam1#_#xParam3#") neq ""> --->
					<cfif form["grdcolumnlist_SO_#xparam1#_#xParam3#"] neq "">
						<!--- <cfset grdcolumnlist = Evaluate("form.grdcolumnlist_SO_#xparam1#_#xParam3#")>
						<cfset bgrdcolumnlist = Evaluate("form.bgrdcolumnlist_SO_#xparam1#_#xParam3#")>
						<cfset grdvaluelist = Evaluate("form.grdvaluelist_SO_#xparam1#_#xParam3#")>
						<cfset totalrecord = Evaluate("form.totalrecord_SO_#xparam1#_#xParam3#")> --->
						<cfset grdcolumnlist = form["grdcolumnlist_SO_#xparam1#_#xParam3#"]>
						<cfset bgrdcolumnlist = form["bgrdcolumnlist_SO_#xparam1#_#xParam3#"]>
						<cfset grdvaluelist = form["grdvaluelist_SO_#xparam1#_#xParam3#"]>
						<cfset totalrecord = form["totalrecord_SO_#xparam1#_#xParam3#"]>
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
							('INV', '#nexttranno#','#j#','#xParam2#','#ndatenow#','#readperiod#','-1','','#getbody.location#','','',
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
							and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
						</cfquery>
					</cfif>
					<!--- End: Add on 031008, graded item --->
				</cfif>
			</cfloop>

			<cfif lcase(hcomid) eq "nikbra_i">
				<cfquery datasource="#dts#" name="updateartran">
					Update ictran set toinv = '#nexttranno#', generated = 'Y'
					where refno = '#xparam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#"> and trancode = '#xparam3#' 
					and toinv = '' and type = 'SO'
				</cfquery>
			<cfelse>
				<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
					<cfquery datasource="#dts#" name="updateartran">
						Update ictran set toinv = '#nexttranno#', generated = 'Y'
						where refno = '#xparam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#"> and trancode = '#xparam3#'
						and toinv = '' and type = 'SO'
					</cfquery>
					
					<!--- Step 2:--->
					<!--- Add on 031008, For Graded Item --->
					<cfquery datasource="#dts#" name="updateigrade">
						Update igrade i, ictran ic 
						set i.generated = 'Y'
						where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
						and i.refno = '#xparam1#' and i.itemno =<cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#"> and i.trancode = '#xparam3#'
						and ic.toinv = '' and i.type = 'SO'
					</cfquery>
				</cfif>
			</cfif>
			
			<!--- <cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
				<cfquery datasource="#dts#" name="updateartran">
					Update ictran set toinv = '#nexttranno#', generated = 'Y'
					where refno = '#xparam1#' and itemno = '#xparam2#' and trancode = '#xparam3#'
					and toinv = '' and type = 'SO'
				</cfquery>
				
				<!--- Step 2:--->
				<!--- Add on 031008, For Graded Item --->
				<cfquery datasource="#dts#" name="updateigrade">
					Update igrade i, ictran ic 
					set i.generated = 'Y'
					where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
					and i.refno = '#xparam1#' and i.itemno = '#xparam2#' and i.trancode = '#xparam3#'
					and ic.toinv = '' and i.type = 'SO'
				</cfquery>
			</cfif> --->
			
			<cfset j = j + 1>

			<!--- <cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#xparam1#' and shipped < qty and type = 'SO'
			</cfquery> --->
			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#xparam1#' and (shipped+writeoff) < qty and type = 'SO'
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set toinv = '#nexttranno#', order_cl = 'Y', generated = 'Y' <cfif lcase(hcomid) eq "ltm_i">,rem45=''</cfif> where refno = '#xparam1#' and type = 'SO'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lSO# no: #xparam1#,#xparam2# is successfully updated to #gettranname.lINV# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
		</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = "SO"
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
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
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

		<cfquery name="checkexistiniclink" datasource="#dts#">
            	select refno from iclink where frtype="SO" and frrefno="#getheader.refno#" and refno<>"#nexttranno#" and type="INV"
        </cfquery>

		<cfif val(disc1_bil) eq 0 and val(disc2_bil) eq 0 and val(disc3_bil) eq 0 and val(getheader.disc_bil) neq 0>
			
			<cfif checkexistiniclink.recordcount neq 0>
            <cfset disc_bil = 0>
            <cfelse>
			<cfset disc_bil = getheader.disc_bil>
            </cfif>
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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
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
		
		<!--- SO TO INV --->
		<!--- Create a new transaction --->
		<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,
			currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,
			tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax2,
			tax3,tax,taxp1,taxp2,taxp3,grand,note,term,van,pono,dono,sono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
			rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
			trdatetime,userid,username,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49
			<cfif lcase(hcomid) eq 'iel_i'>
				,rem15,rem16,rem17,rem18,rem19,rem20,rem21,rem22,rem23,rem24,rem25
			</cfif>,taxincl<cfif lcase(hcomid) eq 'mastercare_i' or lcase(hcomid) eq 'gorgeous_i'>,deposit</cfif>,d_phone2,postalcode,d_postalcode,depositno<cfif checkexistiniclink.recordcount eq 0>,creditcardtype1,creditcardtype2,deposit,cs_pm_cash,cs_pm_cheq,cs_pm_crcd,cs_pm_crc2,cs_pm_dbcd,cs_pm_vouc,cs_pm_debt</cfif>,B_GSTno,D_GSTno)

			values('INV','#nexttranno#','#getheader.refno2#','#getheader.custno#','#readperiod#','#ndatenow#',
			<cfif getheader.desp eq "">'SALES'<cfelse>'#getheader.desp#'</cfif>,'#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#','#getheader.term#','#getheader.van#',
			<cfif lcase(HcomID) eq "mphcranes_i"><cfif getheader.pono neq ''>'#getheader.pono#'<cfelse>''</cfif><cfelseif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">'#getheader.pono#'<cfelse><cfif getheader.pono neq ''>'#getheader.pono#'<cfelse>''</cfif></cfif>,'#getheader.dono#',<cfif lcase(HcomID) eq "vsolutionspteltd_i">'#getheader.pono#'<cfelse>'#updatepono#'</cfif>,'#getheader.quono#','#getheader.rem0#','#getheader.rem1#', '#getheader.rem2#','#getheader.rem3#',
			'#getheader.rem4#','#getheader.rem5#',
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			'#getheader.rem11#', '#getheader.rem12#','#getheader.frem0#', '#getheader.frem1#', '#getheader.frem2#', '#getheader.frem3#', '#getheader.frem4#',
			'#getheader.frem5#', '#getheader.frem6#', '#getheader.frem7#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getheader.comm0#', '#getheader.comm1#', '#getheader.comm2#', '#getheader.comm3#', '#getheader.comm4#',
			'#getheader.name#','#getheader.phonea#',
			#Now()#, <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getheader.userid#'<cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserID#"></cfif>,'#getusername.username#','#getheader.currcode#',
			'#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#',
			'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#','#getheader.special_account_code#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserID#">,#now()#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#HUserID#">,#now()#,'#getheader.rem30#', '#getheader.rem31#', '#getheader.rem32#', '#getheader.rem33#', '#getheader.rem34#', '#getheader.rem35#', '#getheader.rem36#', '#getheader.rem37#', '#getheader.rem38#', '#getheader.rem39#', '#getheader.rem40#', '#getheader.rem41#', '#getheader.rem42#', '#getheader.rem43#', '#getheader.rem44#', '#getheader.rem45#', '#getheader.rem46#', '#getheader.rem47#', '#getheader.rem48#', '#getheader.rem49#'
			<cfif lcase(hcomid) eq 'iel_i'>
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem15#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem16#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem17#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem18#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem19#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem20#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem21#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem22#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem23#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem24#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem25#">
			</cfif>,'#getheader.taxincl#'<cfif lcase(hcomid) eq 'mastercare_i' or lcase(hcomid) eq 'gorgeous_i'>,'#getheader.deposit#'</cfif>,'#getheader.d_phone2#','#getheader.postalcode#','#getheader.d_postalcode#','#getheader.depositno#'<cfif checkexistiniclink.recordcount eq 0>,'#getheader.creditcardtype1#','#getheader.creditcardtype2#',
			'#val(getheader.deposit)#','#val(getheader.cs_pm_cash)#','#val(getheader.cs_pm_cheq)#','#val(getheader.cs_pm_crcd)#','#val(getheader.cs_pm_crc2)#','#val(getheader.cs_pm_dbcd)#',
			'#val(getheader.cs_pm_vouc)#','#val(getheader.cs_pm_debt)#'</cfif>,'#getheader.B_GSTno#','#getheader.D_GSTno#')
		</cfquery>
		<cftry>
			<cfquery name="getheader_remark" datasource="#dts#">
				select 
				type,
				refno,
				cast(remark1 as binary) as remark1,
				cast(remark2 as binary) as remark2,
				cast(remark3 as binary) as remark3,
				cast(remark4 as binary) as remark4,
				cast(remark5 as binary) as remark5,
				cast(remark6 as binary) as remark6,
				cast(remark7 as binary) as remark7,
				cast(remark8 as binary) as remark8,
				cast(remark9 as binary) as remark9,
				cast(remark10 as binary) as remark10
				from artran_remark where refno = '#listgetat(mylist,1,";")#' and type = "SO"
			</cfquery>
			<cfif getheader_remark.recordcount neq 0>
				<cfquery name="insert_remark" datasource="#dts#">
					insert into artran_remark
					(type,refno,
					<cfloop from="1" to="10" index="z">
						remark#z#,
					</cfloop>USERID,LASTUSERID)
					values
					('INV','#nexttranno#',
					<cfloop from="1" to="10" index="z">
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#getheader_remark["remark#z#"][1]#">,
					</cfloop>'#HUserID#','#HUserID#')
				</cfquery>
			</cfif>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
        </cfif>
	<!--- t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO --->
	<cfelseif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
		<!---cfquery datasource="#dts#" name="updategsetup">
			Update Gsetup set #trancode# = UPPER("#nexttranno#")
		</cfquery--->
		
		<!--- <cfquery name="updategsetup" datasource="main">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where userDept = '#dts#'
			and type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
		
		<!--- <cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
        
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
        </cfif>

		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>
		<cfset j = 1>

		<cfloop from="1" to="#cnt#" index="i" step="+3">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

			  <cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>QUO No. : #listgetat(mylist,i,";")# <br></cfoutput>
			<cfset xParam1 = listgetat(mylist,i,";")>

			<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			  <!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  	<cfset xParam2 = ''>
			<cfelse>
			  	<cfset xParam2 = listgetat(mylist,i+1,";")>
			</cfif>

			<cfset xParam3 = listgetat(mylist,i+2,";")>

			<cfquery datasource="#dts#" name="getbody">
				Select * from ictran where refno = '#xParam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#"> and trancode = '#xParam3#' and shipped < qty and type = 'QUO'
			</cfquery>

			<cfloop query="getbody">
			  	<cfquery datasource="#dts#" name="getheader">
					Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
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
                
                <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>
				
				<!--- Add On 061008, 2nd Unit Function --->
				<!---<cfif val(getbody.factor1) neq 0>
					<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
				<cfelse>
					<cfset getbody.price_bil = 0>
				</cfif>--->
                
                <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
                
				
				<cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil>
				
				<cfset newdamt_bil1 = (getbody.dispec1 / 100) * newamt1_bil>
				<cfset netamt = newamt1_bil - newdamt_bil1>
				<cfset newdamt_bil2 = (getbody.dispec2 / 100) * netamt>
				<cfset netamt = netamt - newdamt_bil2>
				<cfset newdamt_bil3 = (getbody.dispec3 / 100) * netamt>
				<cfset netamt = netamt - newdamt_bil3>
				
				<cfset newdamt_bil = newdamt_bil1 + newdamt_bil2 + newdamt_bil3>
				<cfif val(newdamt_bil) eq 0 and val(getbody.DISAMT_BIL) neq 0 and val(getbody.qty_bil) neq 0>
					<cfset newdamt_bil = val(getbody.DISAMT_BIL) * val(listgetat(fulfill,j)) / val(getbody.qty_bil)>
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
                
				<!--- QUO TO INV --->
				<cfquery datasource="#dts#" name="insertictran">
					Insert into ictran 
					(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
					`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
					`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
					`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`QUONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,
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
					values ('INV', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
					'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,
					'#agenno#',	
					<cfif isdefined('form.location')>
                    <cfif listgetat(form.location,j) eq "emptylocation">
						<cfset locationvalue = "">
                        <cfelse>
                        <cfset locationvalue = listgetat(form.location,j)>
                        </cfif>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#locationvalue#">,
                    <cfelse>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">,
					</cfif> '#getbody.source#', '#getbody.job#', '', '#listgetat(form.fulfill,j)#',
					'#getbody.price_bil#','#getbody.unit_bil#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
					'#newdamt_bil#', '#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#', '#newtaxamt_bil#',
					'', '#fulfillactual#', '#getbody.price#','#getbody.unit#', '#newamt1#', '#newdamt#', '#newamt#',
					'#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#', '#listgetat(mylist,i,";")#', '#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#getbody.sodate#', '#brem1#', '#brem2#', '#brem3#', '#brem4#',
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
					'#listgetat(mylist,i,";")#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#', '#getbody.category#', '#Area#',
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
							update lobthob set bth_qut=(bth_qut+'#fulfillactual#')
							where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
						<cfquery name="updateobbatch" datasource="#dts#">
							update obbatch set bth_qut=(bth_qut+'#fulfillactual#')
							where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
					<cfelse>
						<cfquery name="updateobbatch" datasource="#dts#">
							update obbatch set bth_qut=(bth_qut+'#fulfillactual#')
							where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
					</cfif>
				</cfif>

				<cfset qname='QOUT'&(readperiod+10)>

				<cfquery name="UpdateIcitem" datasource="#dts#">
					update icitem set #qname#=(#qname#+#fulfillactual#) where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
				</cfquery>

				<cfquery name="inserticlink" datasource="#dts#">
					insert into iclink values ('INV','#nexttranno#','#j#',
					'#ndatenow#','QUO','#listgetat(mylist,i,";")#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#val(listgetat(form.fulfill,j))#')
				</cfquery>

				<cfset newship = getbody.shipped + val(listgetat(form.fulfill,j))>

				<cfquery datasource="#dts#" name="updateictran">
					Update ictran set shipped = '#newship#'
					where refno = '#xparam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and trancode = '#xparam3#'
					and toinv = '' and type = 'QUO'
				</cfquery>
				
				<!--- Start: Add on 031008, graded item --->
				<!--- <cfif Evaluate("form.grdcolumnlist_QUO_#xparam1#_#xParam3#") neq ""> --->
				<cfif form["grdcolumnlist_QUO_#xparam1#_#xParam3#"] neq "">
					<!--- <cfset grdcolumnlist = Evaluate("form.grdcolumnlist_QUO_#xparam1#_#xParam3#")>
					<cfset bgrdcolumnlist = Evaluate("form.bgrdcolumnlist_QUO_#xparam1#_#xParam3#")>
					<cfset grdvaluelist = Evaluate("form.grdvaluelist_QUO_#xparam1#_#xParam3#")>
					<cfset totalrecord = Evaluate("form.totalrecord_QUO_#xparam1#_#xParam3#")> --->
					<cfset grdcolumnlist = form["grdcolumnlist_QUO_#xparam1#_#xParam3#"]>
					<cfset bgrdcolumnlist = form["bgrdcolumnlist_QUO_#xparam1#_#xParam3#"]>
					<cfset grdvaluelist = form["grdvaluelist_QUO_#xparam1#_#xParam3#"]>
					<cfset totalrecord = form["totalrecord_QUO_#xparam1#_#xParam3#"]>
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
						('INV', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">, '#ndatenow#','#readperiod#','-1','','#getbody.location#','','',
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
						where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
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
						where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
						and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
					</cfquery>
				</cfif>
				<!--- End: Add on 031008, graded item --->
			</cfloop>

			<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
				<cfquery datasource="#dts#" name="updateartran">
					Update ictran set toinv = '#nexttranno#', generated = 'Y'
					where refno = '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#">
					and toinv = '' and type = 'QUO' and trancode = '#xparam3#'
				</cfquery>
				
				<!--- Step 2:--->
				<!--- Add on 031008, For Graded Item --->
				<cfquery datasource="#dts#" name="updateigrade">
					Update igrade i, ictran ic 
					set i.generated = 'Y'
					where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
					and i.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#"> and i.trancode = '#xparam3#'
					and i.refno = '#xparam1#' and i.type = 'QUO'
					and ic.toinv = ''
				</cfquery>
			</cfif>

			<cfset j = j + 1>

			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#' and (shipped+writeoff) < qty and type = 'QUO'
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set toinv = '#nexttranno#', order_cl = 'Y', generated = 'Y'
					where refno = '#listgetat(mylist,i,";")#' and type = 'QUO'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lQUO# no: #listgetat(form.checkbox,i,";")#,#listgetat(form.checkbox,i+1,";")# is successfully updated to #gettranname.lINV# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
		</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
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
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
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
		<cfset net = net_bil * newcurrate>        
		<cfif getheader.taxincl neq "T">
        
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
        
         <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
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
        
        <cfquery name="gettermscondition" datasource="#dts#">
        	select linv from ictermandcondition
        </cfquery>
		
		<!--- Create a new transaction --->
		<!--- QUO TO INV --->
		<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,
			currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,
			tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax2,
			tax3,tax,taxp1,taxp2,taxp3,grand,cs_pm_debt,note,term,van,pono,dono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
			rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
			trdatetime,userid,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49
			<cfif lcase(hcomid) eq 'iel_i'>
				,rem15,rem16,rem17,rem18,rem19,rem20,rem21,rem22,rem23,rem24,rem25
			</cfif>,taxincl,e_mail,depositno,B_GSTno,D_GSTno,termscondition,country,d_country,postalcode,d_postalcode)

			values('INV','#nexttranno#','#getheader.refno2#','#getheader.custno#','#readperiod#','#ndatenow#',
			<cfif getheader.desp eq "">'SALES'<cfelse>'#getheader.desp#'</cfif>,'#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#grand#','#getheader.note#',	'#getheader.term#','#getheader.van#',
			'#getheader.pono#',<cfif getheader.dono neq ''>'#getheader.dono#'<cfelse>''</cfif>,'#updatepono#','#getheader.rem0#','#getheader.rem1#','#getheader.rem2#','#getheader.rem3#',
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
			</cfif>,'#getheader.taxincl#','#getheader.e_mail#','#getheader.depositno#','#getheader.B_GSTno#','#getheader.D_GSTno#',<cfif gettermscondition.linv neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#gettermscondition.linv#"><cfelse>'#getheader.termscondition#'</cfif>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.country#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.d_country#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.postalcode#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.d_postalcode#">
            )
		</cfquery>
		
		<cftry>
			<cfquery name="getheader_remark" datasource="#dts#">
				select 
				type,
				refno,
				cast(remark1 as binary) as remark1,
				cast(remark2 as binary) as remark2,
				cast(remark3 as binary) as remark3,
				cast(remark4 as binary) as remark4,
				cast(remark5 as binary) as remark5,
				cast(remark6 as binary) as remark6,
				cast(remark7 as binary) as remark7,
				cast(remark8 as binary) as remark8,
				cast(remark9 as binary) as remark9,
				cast(remark10 as binary) as remark10
				from artran_remark where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
			</cfquery>
			<cfif getheader_remark.recordcount neq 0>
				<cfquery name="insert_remark" datasource="#dts#">
					insert into artran_remark
					(type,refno,
					<cfloop from="1" to="10" index="z">
						remark#z#,
					</cfloop>USERID,LASTUSERID)
					values
					('INV','#nexttranno#',
					<cfloop from="1" to="10" index="z">
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#getheader_remark["remark#z#"][1]#">,
					</cfloop>'#HUserID#','#HUserID#')
				</cfquery>
			</cfif>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
		
	<cfelseif url.t1 eq "PO">
		<cfset type = gettranname.lPO>
		
		<!--- <cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
        
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
        
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
        </cfif>
		
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>
		
		Transaction Update Summary<br><br>
		
		<cfset j = 1>
		
		<cfloop from="1" to="#cnt#" index="i" step="+3">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

			  	<cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>
			
			<cfoutput>PO No. : #listgetat(mylist,i,";")# <br></cfoutput>
		
			<cfset xParam1 = listgetat(mylist,i,";")>		<!--- REFNO --->
			
			<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			  	<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  	<cfset xParam2 = ''>
			<cfelse>
			  	<cfset xParam2 = listgetat(mylist,i+1,";")>	<!--- ITEMNO --->
			</cfif>
	
			<cfset xParam3 = listgetat(mylist,i+2,";")>		<!--- TRANCODE --->
			
			<cfquery datasource="#dts#" name="getbody">
			  	Select a.*,b.price as xprice 
			  	from ictran a,icitem b 
			  	where a.itemno=b.itemno 
			  	and a.refno = '#xParam1#' and a.type = '#url.t1#' 
			  	and a.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#"> and a.trancode = '#xParam3#' 
			  	and a.exported = '' and a.toinv = ''
			</cfquery>
			
			<cfquery name="getcustomer" datasource="#dts#">
				select a.custno,a.name,a.name2,a.add1,a.add2,a.add3,a.add4,a.fax,a.term,a.currcode,a.agent,a.area,a.attn,a.phone,a.phonea,(select #currperiod# from #target_currency# where currcode=a.currcode) as rate 
				from #target_arcust# as a 
				where a.custno='#form.customer#'
			</cfquery>
				
			<cfset newcurrate = val(getcustomer.rate)>
			
			<cfloop query="getbody">
				<cfset xqty=listgetat(form.fulfill,j)>
				<cfset xprice=getbody.xprice>
				<cfset xamt=xqty*xprice>
				<cfset gross=gross+xamt>
		  		
				<cfif newcurrate neq 0>
					<cfset xprice_bil=xprice/newcurrate>
					<cfset xamt_bil=xqty*xprice_bil>
					<cfset gross_bil=gross/newcurrate>					
				<cfelse>
					<cfset xprice_bil=0>
					<cfset xamt_bil=0>
					<cfset gross_bil=0>
				</cfif>
                
				<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
                
				<!--- PO TO INV --->
		  		<cfquery datasource="#dts#" name="insertictran">
					Insert into ictran 
					(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,
					`ITEMNO`,`DESP`,`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,
					`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,`DISPEC3`,
					`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
					`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`DODATE`,`SODATE`,
					`BREM1`,`BREM2`,`BREM3`,`BREM4`,`PACKING`,`NOTE1`,`NOTE2`,
					`GLTRADAC`,`UPDCOST`,`GST_ITEM`,`TOTALUP`,`WITHSN`,`GRADE`,`PUR_PRICE`,
					`QTY_RET`,`TEMPFIGI`,`SERCOST`,`M_CHARGE1`,`M_CHARGE2`,`ADTCOST1`,`ADTCOST2`,`IT_COS`,`AV_COST`,
					`BATCHCODE`,`EXPDATE`,`POINT`,`INV_DISC`,`INV_TAX`,`SUPP`,`EDI_COU1`,`WRITEOFF`,`TOSHIP`,`SHIPPED`,`NAME`,`DEL_BY`,`VAN`,
					`GENERATED`,`UD_QTY`,`TOINV`,`EXPORTED`,`EXPORTED1`,`EXPORTED2`,`EXPORTED3`,`BRK_TO`,`SV_PART`,`LAST_YEAR`,
					`VOID`,`SONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,
					`AREA`,`SHELF`,`TEMP`,`TEMP1`,`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,`TABLENO`,
					`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,
					`NODISPLAY`,`TITLE_ID`,`TITLE_DESP`,<cfif lcase(hcomid) eq "topsteel_i">`TITLE_DESPA`,</cfif>
					`COMMENT`,`DEFECTIVE`,
					`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,
					`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,`MC6_BIL`,`MC7_BIL`<cfif lcase(hcomid) eq "fdipx_i">,`JobOrderNo`</cfif>,`taxincl`,`note_a`)					
					values 
					('INV','#nexttranno#','#getbody.refno2#','#j#','#getcustomer.custno#','#readperiod#','#ndatenow#','#newcurrate#','#j#','#getbody.linecode#',
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,'#getcustomer.agent#',
                    <cfif isdefined('form.location')>
                    <cfif listgetat(form.location,j) eq "emptylocation">
						<cfset locationvalue = "">
                        <cfelse>
                        <cfset locationvalue = listgetat(form.location,j)>
                        </cfif>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#locationvalue#">,
                    <cfelse>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">,
					</cfif>'#getbody.source#',
					'#getbody.job#','-1','#xqty#','#xprice_bil#','#unit#','#xamt_bil#','0','0','0',
					'0','#xamt_bil#','0','0','0','0','','#xqty#','#xprice#','#unit#','#xamt#',
					'0','#xamt#','0','1','1','#getbody.dono#',<cfif getbody.dodate neq "">#dateformat(getbody.dodate,"yyyy-mm-dd")#<cfelse>'0000-00-00'</cfif>,<cfif getbody.sodate neq "">#getbody.sodate#<cfelse>'0000-00-00'</cfif>,
					'#getbody.brem1#','#getbody.brem2#','#getbody.brem3#','#getbody.brem4#','#getbody.packing#','#getbody.note1#','#getbody.note2#',
					'#getbody.gltradac#','','N','N','','#getbody.grade#','0.00',
					'0.00','0','0','#getbody.m_charge1#','#getbody.m_charge2#','#getbody.adtcost1#','#getbody.adtcost2#','0','0',
					'#getbody.batchcode#','#getbody.expdate#','0','0','0','','','0','0','0','#getcustomer.name#','','',
					'','','','','0000-00-00','','0000-00-00','','','',
					'','#listgetat(mylist,i,";")#','#getbody.mc1_bil#','#getbody.mc2_bil#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">,'0','','#getbody.wos_group#','#getbody.category#',
					'#getcustomer.area#','#getbody.shelf#','#getbody.temp#','#getbody.temp1#','','0','0','0','#getbody.promoter#','0',
					'','',#Now()#,'#TIMEFORMAT(now(),"hh:mm tt")#','#getbody.BOMNO#',
					'#getbody.nodisplay#','#getbody.title_id#','#getbody.title_desp#',
            		<cfif lcase(hcomid) eq "topsteel_i"><cfqueryparam cfsqltype="cf_sql_longvarchar" value="#getbody.title_despa#">,</cfif>
					<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getbody.comment)#">,'#getbody.defective#',
					'#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#',
					'#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
				</cfquery>
				
				<cfquery name="inserticlink" datasource="#dts#">
					insert into iclink 
					values 
					('INV','#nexttranno#','#j#',
					'#ndatenow#','PO','#listgetat(mylist,i,";")#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#listgetat(form.fulfill,j)#')
				</cfquery>
				
				<cfif form["grdcolumnlist_PO_#xparam1#_#xParam3#"] neq "">
					<cfset grdcolumnlist = form["grdcolumnlist_PO_#xparam1#_#xParam3#"]>
					<cfset bgrdcolumnlist = form["bgrdcolumnlist_PO_#xparam1#_#xParam3#"]>
					<cfset grdvaluelist = form["grdvaluelist_PO_#xparam1#_#xParam3#"]>
					<cfset totalrecord = form["totalrecord_PO_#xparam1#_#xParam3#"]>
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
						('INV','#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">, '#ndatenow#','#readperiod#','-1','','#getbody.location#','','',
						'#getcustomer.custno#','','1', '1',
						<cfloop from="1" to="#totalrecord#" index="k">
							<cfif k neq totalrecord>
								#myArray2[k]#,
							<cfelse>
								#myArray2[k]#
							</cfif>
						</cfloop>)
					</cfquery>
				</cfif>
				
			</cfloop>	<!--- getbody END--->
			
			<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
				<cfquery datasource="#dts#" name="updateartran">
					Update ictran set exported = '#nexttranno#', exported1 = '#ndatenow#'
					where refno	= '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#">
					and exported = '' and type = 'PO' and trancode = '#xparam3#'
				</cfquery>
				
				<!--- Step 2:--->
				<!--- Add on 051008, For Graded Item --->
				<cfquery datasource="#dts#" name="updateigrade">
					Update igrade i, ictran ic 
					set i.exported = '#nexttranno#'
					where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
					and i.refno = '#xparam1#' and i.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and i.trancode = '#xparam3#'
					and ic.exported = '' and i.type = 'PO'
				</cfquery>
			</cfif>
			<cfset j = j + 1>
			
			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#'
				and exported = '' and type = 'PO'
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set exported = '#nexttranno#', exported1 = '#ndatenow#' 
					where refno = '#listgetat(mylist,i,";")#'
					and type = 'PO'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lPO# no: ,#listgetat(mylist,i,";")#,#listgetat(mylist,i+1,";")# is successfully updated to #gettranname.lINV# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
		</cfloop>	<!--- END from="1" to="#cnt#" index="i" step="+3" END --->
		
		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'PO'
		</cfquery>
        
        <cfset xnet=gross>       
        <cfset xtaxp1=getGsetup.gst>
        <cfset xnote = 'STAX'>
        <cfset xtax=xtaxp1*xnet/100>
        <cfset grand=xnet+xtax>
		  		
		<cfif newcurrate neq 0>
			<cfset xnet_bil=xnet/newcurrate>
            <cfset xtax_bil=xtax/newcurrate>
            <cfset grand_bil=grand/newcurrate>					
        <cfelse>
            <cfset xnet_bil=0>
            <cfset xtax_bil=0>
            <cfset grand_bil=0>
        </cfif>
		
		<cfquery datasource="#dts#" name="insertartran">
			Insert into artran 
			(type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,
		  	currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,
		  	tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax2,tax3,
		  	tax,taxp1,taxp2,taxp3,grand,debitamt,cs_pm_debt,note,term,van,pono,dono,quono,
            rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
		  	rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
		  	trdatetime,userid,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on,taxincl,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49,depositno)

		  	values('INV','#nexttranno#','#getheader.refno2#','#getcustomer.custno#','#readperiod#','#ndatenow#',
			<cfif getheader.desp eq "">'SALES'<cfelse>'#getheader.desp#'</cfif>,'#getheader.despa#','#getcustomer.agent#','#getcustomer.area#','#getheader.source#','#getheader.job#',
			'#newcurrate#','#gross_bil#','0','0','0','0','#xnet_bil#','#xtax_bil#','0','0',
			'#xtax_bil#','#grand_bil#','#gross#','0','0','0','0','0','0','0','#xnet#','0','0','0',			
			'#xtax#','#xtaxp1#','0','0','#grand#','#grand#','#grand#','#xnote#','#getcustomer.term#','#getheader.van#','#updatepono#','#getheader.dono#','#getheader.quono#',			
			'Profile','Profile', '#getcustomer.attn#','#getcustomer.attn#','#getcustomer.phone#','#getheader.rem5#',			
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			'#getheader.rem11#', '#getcustomer.phone#','#getcustomer.name#', '#getcustomer.name2#', '#getcustomer.add1#', '#getcustomer.add2#', '#getcustomer.add3#',
			'#getcustomer.add4#', '#getcustomer.fax#', '#getcustomer.name#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getcustomer.add1#', '#getcustomer.add2#', '#getcustomer.add3#', '#getcustomer.add4#', '#getcustomer.fax#',
			'#getcustomer.name#','#getcustomer.phonea#',
			#Now()#, '#HUserID#','#getcustomer.currcode#',
			'#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#',
			'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#','#getheader.special_account_code#',
			'#HUserID#',#now()#,'#HUserID#',#now()#,'#getheader.taxincl#','#getheader.rem30#', '#getheader.rem31#', '#getheader.rem32#', '#getheader.rem33#', '#getheader.rem34#', '#getheader.rem35#', '#getheader.rem36#', '#getheader.rem37#', '#getheader.rem38#', '#getheader.rem39#', '#getheader.rem40#', '#getheader.rem41#', '#getheader.rem42#', '#getheader.rem43#', '#getheader.rem44#', '#getheader.rem45#', '#getheader.rem46#', '#getheader.rem47#', '#getheader.rem48#', '#getheader.rem49#','#getheader.depositno#')
	  	</cfquery>
		
	</cfif>		<!--- END t2=INV END  --->
<!--- t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO t2 = DO --->
<cfelseif url.t2 eq "DO">
	<h1>Update to <cfoutput>#gettranname.lDO#</cfoutput></h1>
	
	<cfif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
		<!---cfquery datasource="#dts#" name="updategsetup">
			Update Gsetup set dono = UPPER("#nexttranno#")
		</cfquery--->
		
		<!--- <cfquery name="updategsetup" datasource="main">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where userDept = '#dts#'
			and type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
		
		<!--- <cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
        
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
		</cfif>
        
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>

		<cfset j = 1>

		<cfloop from="1" to="#cnt#" index="i" step="+3">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

				<cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>SO No. : #listgetat(mylist,i,";")# <br></cfoutput>
			<cfset xParam1 = listgetat(mylist,i,";")>

			<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			  	<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  	<cfset xParam2 = ''>
			<cfelse>
			  	<cfset xParam2 = listgetat(mylist,i+1,";")>
			</cfif>

			<cfset xParam3 = listgetat(mylist,i+2,";")>

			<cfquery datasource="#dts#" name="getbody">
				Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and shipped < qty and type = 'SO'
			</cfquery>

			<cfquery datasource="#dts#" name="getcust">
				Select * from #target_arcust# where custno = '#getbody.custno#'
			</cfquery>

			<cfloop query="getbody">
			  	<cfquery datasource="#dts#" name="getheader">
					Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SO'
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
                
                <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>

				<!--- Add On 061008, 2nd Unit Function --->
				<!---<cfif val(getbody.factor1) neq 0>
					<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
				<cfelse>
					<cfset getbody.price_bil = 0>
				</cfif>--->
                <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
                
                
                
				<cfif lcase(hcomid) eq "nikbra_i">
					<cfset fulfill = qty - shipped+writeoff >
					<cfset newamt1_bil = fulfill * getbody.price_bil>
				<cfelse>
					<cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil>
				</cfif>
				<!--- <cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil> --->
                
                
                <cfif val(getbody.dispec1) eq 0 and val(getbody.dispec2) eq 0 and val(getbody.dispec3) eq 0>
				
                <cfset netamt = newamt1_bil - val(getbody.disamt_bil)>
                <cfset newdamt_bil = val(getbody.disamt_bil)>
                
				<cfelse>
				<cfset newdamt_bil1 = (val(getbody.dispec1) / 100) * newamt1_bil>
				<cfset netamt = newamt1_bil - newdamt_bil1>
				<cfset newdamt_bil2 = (val(getbody.dispec2) / 100) * netamt>
				<cfset netamt = netamt - newdamt_bil2>
				<cfset newdamt_bil3 = (val(getbody.dispec3) / 100) * netamt>
				<cfset netamt = netamt - newdamt_bil3>
				<cfset newdamt_bil = newdamt_bil1 + newdamt_bil2 + newdamt_bil3>
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
				<!--- SO TO DO --->
				<!--- <cfif lcase(HcomID) eq "steel_i">
					<cfquery name="getItemBody" datasource="#dts#">
						select itemno,desp,despa from icitem where itemno='#listgetat(newitemno,j)#'
					</cfquery>
				</cfif> --->
                
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
                
				<cfquery datasource="#dts#" name="insertictran">
					Insert into ictran 
					(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
					`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
					`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
					`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,`countryoforigin`,
					<cfif lcase(hcomid) eq "avent_i">
						`BREM5`,`BREM6`,
					<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
						`BREM5`,`BREM7`,`BREM8`,`BREM9`,`BREM10`,
					</cfif>
					`PACKING`,`NOTE1`<cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">,`ictranfilename`</cfif>,
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
					</cfif> '#getbody.source#', '#getbody.job#', '',
					<cfif lcase(hcomid) eq "nikbra_i">'#val(fulfill)#'<cfelse>'#val(listgetat(form.fulfill,j))#'</cfif>,
					'#getbody.price_bil#','#unit_bil#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
					'#newdamt_bil#','#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#', '#newtaxamt_bil#', '',
					<cfif lcase(hcomid) eq "nikbra_i">'#val(fulfill)#'<cfelse>'#val(fulfillactual)#'</cfif>, '#getbody.price#',
					'#unit#', '#newamt1#', '#newdamt#', '#newamt#', '#newtaxamt#', '#val(getbody.factor1)#', '#val(getbody.factor2)#', '#listgetat(mylist,i,";")#',
					'#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#dateformat(getbody.wos_date,"yyyy-mm-dd")#',
					<cfif lcase(HcomID) eq "floprints_i">'','','',''<cfelse>'#brem1#','#brem2#','#brem3#','#brem4#','#getbody.countryoforigin#'</cfif>,
					<cfif lcase(hcomid) eq "avent_i">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
					<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
					</cfif>
					'#getbody.packing#', '#getbody.note1#'<cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">,'#getbody.ictranfilename#'</cfif>,
					'#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N', '', '#getbody.grade#', '0.00',
					'0.00', '0', '0', '#getbody.m_charge1#', '#getbody.m_charge2#', '#getbody.adtcost1#', '#getbody.adtcost2#', '0', '0',	'#getbody.batchcode#',<cfif getbody.expdate eq "" or getbody.expdate eq "0000-00-00">'0000-00-00'<cfelse>'#dateformat(getbody.expdate,'yyyy-mm-dd')#'</cfif>, '0', '0', '0', '', '',
					'0', '0', '0', '#name#', '0', '0', 'Y', '', '', '', '0000-00-00', '', '0000-00-00', '', '', '', '',
					'#listgetat(mylist,i,";")#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getbody.userid#'<cfelse>'#huserid#'</cfif>, '0', '', '#getbody.wos_group#', '#getbody.category#',
					'#Area#', '#Shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#', '0',
					'#member#', '', #Now()#, 'Time', '#BOMNO#',
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
					  	'','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					</cfif>
				</cfquery>

				<cfif getbody.batchcode neq "">
					<cfif getbody.location neq "">
						<cfquery name="updateobbatch" datasource="#dts#">
							update lobthob set bth_qut=(bth_qut+<cfif lcase(hcomid) eq "nikbra_i">#val(fulfill)#<cfelse>#val(fulfillactual)#</cfif>)
							where location='#getbody.location#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
						<cfquery name="updateobbatch" datasource="#dts#">
							update obbatch set bth_qut=(bth_qut+<cfif lcase(hcomid) eq "nikbra_i">#val(fulfill)#<cfelse>#val(fulfillactual)#</cfif>)
							where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
					<cfelse>
						<cfquery name="updateobbatch" datasource="#dts#">
							update obbatch set bth_qut=(bth_qut+<cfif lcase(hcomid) eq "nikbra_i">#val(fulfill)#<cfelse>#val(fulfillactual)#</cfif>)
							where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
					</cfif>
				</cfif>

				<cfset qname='QOUT'&(readperiod+10)>

				<!--- <cfquery name="UpdateIcitem" datasource="#dts#">
					update icitem set #qname#=(#qname#+#listgetat(form.fulfill,j)#) where itemno = '#getbody.itemno#'
				</cfquery> --->
				<cfquery name="UpdateIcitem" datasource="#dts#">
					update icitem set #qname#=(#qname#+<cfif lcase(hcomid) eq "nikbra_i">#val(fulfill)#<cfelse>#val(fulfillactual)#</cfif>) where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
				</cfquery>

				<cfquery name="inserticlink" datasource="#dts#">
					insert into iclink values ('DO','#nexttranno#','#j#',
					'#ndatenow#','SO','#listgetat(mylist,i,";")#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,
					<cfif lcase(hcomid) eq "nikbra_i">'#val(fulfill)#'<cfelse>'#val(listgetat(form.fulfill,j))#'</cfif>)
				</cfquery>

				<!--- <cfset newship = getbody.shipped + listgetat(form.fulfill,j)> --->
				<cfif lcase(hcomid) eq "nikbra_i">
					<cfset newship = getbody.shipped+val(fulfill)>
				<cfelse>
					<cfset newship=getbody.shipped+val(listgetat(form.fulfill,j))>
				</cfif>

				<cfquery datasource="#dts#" name="updateictran">
					Update ictran set shipped = '#newship#'
					where refno = '#xparam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and trancode = '#xparam3#'
					and type = 'SO'
				</cfquery>
				
				<cfif lcase(hcomid) neq "nikbra_i">
					<!--- Start: Add on 031008, graded item --->
					<!--- <cfif Evaluate("form.grdcolumnlist_SO_#xparam1#_#xParam3#") neq ""> --->
					<cfif form["grdcolumnlist_SO_#xparam1#_#xParam3#"] neq "">
						<!--- <cfset grdcolumnlist = Evaluate("form.grdcolumnlist_SO_#xparam1#_#xParam3#")>
						<cfset bgrdcolumnlist = Evaluate("form.bgrdcolumnlist_SO_#xparam1#_#xParam3#")>
						<cfset grdvaluelist = Evaluate("form.grdvaluelist_SO_#xparam1#_#xParam3#")>
						<cfset totalrecord = Evaluate("form.totalrecord_SO_#xparam1#_#xParam3#")> --->
						<cfset grdcolumnlist = form["grdcolumnlist_SO_#xparam1#_#xParam3#"]>
						<cfset bgrdcolumnlist = form["bgrdcolumnlist_SO_#xparam1#_#xParam3#"]>
						<cfset grdvaluelist = form["grdvaluelist_SO_#xparam1#_#xParam3#"]>
						<cfset totalrecord = form["totalrecord_SO_#xparam1#_#xParam3#"]>
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
							('DO', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">, '#ndatenow#','#readperiod#','-1','','#getbody.location#','','',
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
							and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
						</cfquery>
					</cfif>
					<!--- End: Add on 031008, graded item --->	
				</cfif>
			</cfloop>

			<cfif lcase(hcomid) eq "nikbra_i">
				<cfquery datasource="#dts#" name="updateartran">
					Update ictran set toinv = '#nexttranno#', generated = 'Y'
					where refno = '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#">
					and toinv = '' and type = 'SO' and trancode = '#xparam3#'
				</cfquery>
			<cfelse>
				<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
					<cfquery datasource="#dts#" name="updateartran">
						Update ictran set toinv = '#nexttranno#', generated = 'Y'
						where refno = '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#">
						and toinv = '' and type = 'SO' and trancode = '#xparam3#'
					</cfquery>
					
					<!--- Step 2:--->
					<!--- Add on 031008, For Graded Item --->
					<cfquery datasource="#dts#" name="updateigrade">
						Update igrade i, ictran ic 
						set i.generated = 'Y'
						where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
						and i.refno = '#xparam1#' and i.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#"> and i.trancode = '#xparam3#'
						and ic.toinv = '' and i.type = 'SO'
					</cfquery>
				</cfif>
			</cfif>
			<!--- <cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
				<cfquery datasource="#dts#" name="updateartran">
					Update ictran set toinv = '#nexttranno#', generated = 'Y'
					where refno = '#listgetat(mylist,i,";")#' and itemno = '#listgetat(mylist,i+1,";")#'
					and toinv = '' and type = 'SO' and trancode = '#xparam3#'
				</cfquery>
				
				<!--- Step 2:--->
				<!--- Add on 031008, For Graded Item --->
				<cfquery datasource="#dts#" name="updateigrade">
					Update igrade i, ictran ic 
					set i.generated = 'Y'
					where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
					and i.refno = '#xparam1#' and i.itemno = '#xparam2#' and i.trancode = '#xparam3#'
					and ic.toinv = '' and i.type = 'SO'
				</cfquery>
			</cfif> --->

			<cfset j = j + 1>

			<!--- <cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#' and shipped < qty and type = 'SO'
			</cfquery> --->
			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#' and (shipped+writeoff) < qty and type = 'SO'
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartran" datasource="#dts#">
					update artran set toinv = '#nexttranno#', order_cl = 'Y', generated = 'Y' where refno = '#listgetat(mylist,i,";")#' and type = 'SO'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lSO# no: #listgetat(mylist,i,";")#,#listgetat(mylist,i+1,";")# is successfully updated to #gettranname.lDO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
		</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SO'
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
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
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
        
        <cfquery name="checkupdatelist" datasource="#dts#">
        	select * from iclink where frrefno='#listgetat(mylist,1,";")#' and frtype='SO' and refno<>"#nexttranno#" and type='DO'
        </cfquery>
        
        <cfif checkupdatelist.recordcount eq 0>
			<cfset disc_bil = getheader.disc_bil>
        <cfelse>
        	<cfset disc_bil = 0>
        </cfif>
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
         <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        <cfif getheader.taxincl neq "T">
        <cfset grand_bil = net_bil + tax_bil>
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
        
        <cfset xdebt=grand_bil-val(getheader.deposit)-val(getheader.cs_pm_cash)-val(getheader.cs_pm_cheq)-val(getheader.cs_pm_crcd)-val(getheader.cs_pm_crc2)-val(getheader.cs_pm_dbcd)-val(getheader.cs_pm_vouc)>
		<cfset grand_bil = numberformat(grand_bil,".__")>
		<cfset grand = grand_bil * newcurrate>
		<cfset grand = numberformat(grand,".__")>
		
		<cfif lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i">
			<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getheader.rem9#" returnvariable="getheader.rem9"/>
			<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getheader.rem11#" returnvariable="getheader.rem11"/>
		</cfif>
		
        <cfquery name="getponofromiclink" datasource="#dts#">
        select refno from iclink where frrefno="#getheader.refno#" and type="PO"
        </cfquery>
        <cfif getponofromiclink.recordcount neq 0>
        <cfset getheader.pono=getponofromiclink.refno>
        </cfif>
        
		<!--- Create a new transaction --->
		<!--- SO TO DO --->
        
        <cfif dts EQ "mika_i">
        	<cfquery name="getLDO" datasource="#dts#">
            	SELECT LDO FROM ictermandcondition
            </cfquery>
        </cfif>
        
		<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,
			currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,
			tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax2,
			tax3,tax,taxp1,taxp2,taxp3,grand,note,term,van,pono,dono,sono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
			rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
			trdatetime,userid,username,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,creditcardtype1,creditcardtype2,deposit,cs_pm_cash,cs_pm_cheq,cs_pm_crcd,cs_pm_crc2,cs_pm_dbcd,cs_pm_vouc,cs_pm_debt,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49,termscondition

			<cfif lcase(hcomid) eq 'iel_i'>
				,rem15,rem16,rem17,rem18,rem19,rem20,rem21,rem22,rem23,rem24,rem25
			</cfif>,taxincl,e_mail<cfif lcase(HcomID) eq "dental_i" or lcase(HcomID) eq "dental10_i" or lcase(HcomID) eq "mfss_i" or lcase(HcomID) eq "hcss_i" or lcase(hcomid) eq "mfssmy_i">,voucher</cfif>,d_phone2,postalcode,d_postalcode,depositno,B_GSTno,D_GSTno)

			values('DO','#nexttranno#','#getheader.refno2#','#getheader.custno#','#readperiod#','#ndatenow#',
			'#getheader.desp#','#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#','#getheader.term#','#getheader.van#',
			<cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">'#getheader.pono#'<cfelseif lcase(hcomid) eq "vsolutionspteltd_i"><cfif getheader.pono neq ''>'#getheader.pono#'<cfelse>'#getheader.dono#'</cfif><cfelseif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">'#getheader.pono#'<cfelse><cfif getheader.pono neq ''>'#getheader.pono#'<cfelse>''</cfif></cfif>,'#getheader.dono#','#updatepono#','#getheader.quono#','#getheader.rem0#','#getheader.rem1#', '#getheader.rem2#','#getheader.rem3#',
			'#getheader.rem4#',<!--- <cfif lcase(hcomid) eq "kjcpl_i">'#getheader.refno#'<cfelse> --->'#getheader.rem5#'<!--- </cfif> --->,
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			'#getheader.rem11#', '#getheader.rem12#','#getheader.frem0#', '#getheader.frem1#', '#getheader.frem2#', '#getheader.frem3#', '#getheader.frem4#',
			'#getheader.frem5#', '#getheader.frem6#', '#getheader.frem7#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getheader.comm0#', '#getheader.comm1#', '#getheader.comm2#', '#getheader.comm3#', '#getheader.comm4#',
			'#getheader.name#','#getheader.phonea#',
			#Now()#, <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getheader.userid#'<cfelse>'#HUserID#'</cfif>,'#getusername.username#','#getheader.currcode#',
			'#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#','#getheader.creditcardtype1#','#getheader.creditcardtype2#',
			'#val(getheader.deposit)#','#val(getheader.cs_pm_cash)#','#val(getheader.cs_pm_cheq)#','#val(getheader.cs_pm_crcd)#','#val(getheader.cs_pm_crc2)#','#val(getheader.cs_pm_dbcd)#',
			'#val(getheader.cs_pm_vouc)#','#val(xdebt)#',
			'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#','#getheader.special_account_code#',
			'#HUserID#',#now()#,'#HUserID#',#now()#,'#getheader.rem30#', '#getheader.rem31#', '#getheader.rem32#', '#getheader.rem33#', '#getheader.rem34#', '#getheader.rem35#', '#getheader.rem36#', '#getheader.rem37#', '#getheader.rem38#', '#getheader.rem39#', '#getheader.rem40#', '#getheader.rem41#', '#getheader.rem42#', '#getheader.rem43#', '#getheader.rem44#', '#getheader.rem45#', '#getheader.rem46#', '#getheader.rem47#', '#getheader.rem48#', '#getheader.rem49#', <cfif dts EQ "mika_i">'#getLDO.LDO#'<cfelse>'#getheader.termscondition#'</cfif>
			<cfif lcase(hcomid) eq 'iel_i'>
				,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem15#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem16#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem17#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem18#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem19#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem20#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem21#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem22#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem23#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem24#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.rem25#">
			</cfif>,'#getheader.taxincl#','#getheader.e_mail#'<cfif lcase(HcomID) eq "dental_i" or lcase(HcomID) eq "dental10_i" or lcase(HcomID) eq "mfss_i" or lcase(HcomID) eq "hcss_i" or lcase(hcomid) eq "mfssmy_i">,'#getheader.voucher#'</cfif>,'#getheader.d_phone2#','#getheader.postalcode#','#getheader.d_postalcode#','#getheader.depositno#','#getheader.B_GSTno#','#getheader.D_GSTno#')
		</cfquery>
		
        <cfif lcase(HcomID) eq "dental_i" or lcase(HcomID) eq "dental10_i" or lcase(HcomID) eq "mfss_i" or lcase(HcomID) eq "hcss_i" or lcase(hcomid) eq "mfssmy_i">
        
        <cfloop list="#updatepono#" delimiters="," index="i">
        <cfquery name="selectsovoucher" datasource="#dts#">
        select * from vouchertran where type='SO' and refno='#i#'
        </cfquery>
        <cfquery name="insertvouchertran" datasource="#dts#">
        INSERT INTO vouchertran (voucherno,usagevalue,wos_date,refno,type,created_by,created_on)
        VALUES
        (
		"#selectsovoucher.voucherno#","#selectsovoucher.usagevalue#",
        "#dateformat(now(),'YYYY-MM-DD')#","#nexttranno#","DO",
        '#huserid#',
        now()
        )
        </cfquery>
        
        <cfquery name="removesovouchertran" datasource="#dts#">
        update vouchertran set usagevalue='0'
        where type='SO' and refno='#i#'
        </cfquery>
        </cfloop>
        </cfif>
        
		<cftry>
			<cfquery name="getheader_remark" datasource="#dts#">
				select 
				type,
				refno,
				cast(remark1 as binary) as remark1,
				cast(remark2 as binary) as remark2,
				cast(remark3 as binary) as remark3,
				cast(remark4 as binary) as remark4,
				cast(remark5 as binary) as remark5,
				cast(remark6 as binary) as remark6,
				cast(remark7 as binary) as remark7,
				cast(remark8 as binary) as remark8,
				cast(remark9 as binary) as remark9,
				cast(remark10 as binary) as remark10
				from artran_remark where refno = '#listgetat(mylist,1,";")#' and type = 'SO'
			</cfquery>
			<cfif getheader_remark.recordcount neq 0>
				<cfquery name="insert_remark" datasource="#dts#">
					insert into artran_remark
					(type,refno,
					<cfloop from="1" to="10" index="z">
						remark#z#,
					</cfloop>USERID,LASTUSERID)
					values
					('DO','#nexttranno#',
					<cfloop from="1" to="10" index="z">
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#getheader_remark["remark#z#"][1]#">,
					</cfloop>'#HUserID#','#HUserID#')
				</cfquery>
			</cfif>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
      <!--- SAMPLE   --->
     <cfelseif url.t1 eq "SAM">
		<cfset type = gettranname.lSAM>
        
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
		</cfif>
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>
		<cfset j = 1>
		
		<cfif getGsetup.quochooseitem eq 1>
        	<cfset stepcount = "+3" >
		<cfelse>
        	<cfset stepcount = "+1" >
        </cfif>

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
            <cfif getGsetup.quochooseitem eq 1>
				<cfset xParam1 = listgetat(mylist,i,";")>

				<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			  		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  		<cfset xParam2 = ''>
				<cfelse>
			  		<cfset xParam2 = listgetat(mylist,i+1,";")>
				</cfif>

				<cfset xParam3 = listgetat(mylist,i+2,";")>
			
				<cfquery datasource="#dts#" name="getbody">
					Select * from ictran where refno = '#xParam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#"> and trancode = '#xParam3#' and shipped < qty and type = 'SAM'
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
                    
                    <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>
					
					<!--- Add On 061008, 2nd Unit Function --->
					<!---<cfif val(getbody.factor1) neq 0>
						<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
					<cfelse>
						<cfset getbody.price_bil = 0>
					</cfif>--->
                    <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
					
					<cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil>
					
					<cfset newdamt_bil1 = (getbody.dispec1 / 100) * newamt1_bil>
					<cfset netamt = newamt1_bil - newdamt_bil1>
					<cfset newdamt_bil2 = (getbody.dispec2 / 100) * netamt>
					<cfset netamt = netamt - newdamt_bil2>
					<cfset newdamt_bil3 = (getbody.dispec3 / 100) * netamt>
					<cfset netamt = netamt - newdamt_bil3>
					
					<cfset newdamt_bil = newdamt_bil1 + newdamt_bil2 + newdamt_bil3>
					<cfif val(newdamt_bil) eq 0 and val(getbody.DISAMT_BIL) neq 0 and val(getbody.qty_bil) neq 0>
						<cfset newdamt_bil = val(getbody.DISAMT_BIL) * val(listgetat(fulfill,j)) / val(getbody.qty_bil)>
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
					</cfif> '#getbody.source#', '#getbody.job#', '', '#listgetat(form.fulfill,j)#',
						'#getbody.price_bil#','#getbody.unit_bil#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
						'#newdamt_bil#', '#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#', '#newtaxamt_bil#',
						'', '#fulfillactual#', '#getbody.price#','#getbody.unit#', '#newamt1#', '#newdamt#', '#newamt#',
						'#newtaxamt#', '#val(getbody.factor1)#', '#val(getbody.factor2)#', '#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#getbody.sodate#', '#brem1#', '#brem2#', '#brem3#', '#brem4#',
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
						'#listgetat(mylist,i,";")#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#', '#getbody.category#', '#Area#',
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
								update lobthob set bth_qut=(bth_qut+'#fulfillactual#')
								where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+'#fulfillactual#')
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						<cfelse>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+'#fulfillactual#')
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						</cfif>
					</cfif>
	
					<cfset qname='QOUT'&(readperiod+10)>
	
					<cfquery name="UpdateIcitem" datasource="#dts#">
						update icitem set #qname#=(#qname#+#fulfillactual#) where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
					</cfquery>
	
					<cfquery name="inserticlink" datasource="#dts#">
						insert into iclink values ('DO','#nexttranno#','#j#',
						'#ndatenow#','SAM','#listgetat(mylist,i,";")#','#getbody.trancode#',
						#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#val(listgetat(form.fulfill,j))#')
					</cfquery>
	
					<cfset newship = getbody.shipped + val(listgetat(form.fulfill,j))>
	
					<cfquery datasource="#dts#" name="updateictran">
						Update ictran set shipped = '#newship#'
						where refno = '#xparam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and trancode = '#xparam3#'
						and toinv = '' and type = 'SAM'
					</cfquery>
					
					<cfif form["grdcolumnlist_SAM_#xparam1#_#xParam3#"] neq "">
						<cfset grdcolumnlist = form["grdcolumnlist_SAM_#xparam1#_#xParam3#"]>
						<cfset bgrdcolumnlist = form["bgrdcolumnlist_SAM_#xparam1#_#xParam3#"]>
						<cfset grdvaluelist = form["grdvaluelist_SAM_#xparam1#_#xParam3#"]>
						<cfset totalrecord = form["totalrecord_SAM_#xparam1#_#xParam3#"]>
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
							('DO', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">, '#ndatenow#','#readperiod#','-1','','#getbody.location#','','',
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
							and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
						</cfquery>
					</cfif>
				</cfloop>
	
				<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
					<cfquery datasource="#dts#" name="updateartran">
						Update ictran set toinv = '#nexttranno#', generated = 'Y'
						where refno = '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#">
						and toinv = '' and type = 'SAM' and trancode = '#xparam3#'
					</cfquery>
					
					<!--- Step 2:--->
					<!--- Add on 031008, For Graded Item --->
					<cfquery datasource="#dts#" name="updateigrade">
						Update igrade i, ictran ic 
						set i.generated = 'Y'
						where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
						and i.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#"> and i.trancode = '#xparam3#'
						and i.refno = '#xparam1#' and i.type = 'SAM'
						and ic.toinv = ''
					</cfquery>
				</cfif>
            <cfelse>
            	<cfquery datasource="#dts#" name="getbody">
					Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = 'SAM' order by itemcount
				</cfquery>
				<cfloop query="getbody">
				  	<!--- GET LATEST CURRRATE --->
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
						<cfset newcurrate = val(currency.rate)>
					<cfelse>
						<cfset newcurrate = 1><!--- default --->
					</cfif>
                    
                    <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>
	
					<cfset newamt1_bil = val(getbody.qty_bil) * val(getbody.price_bil)>
					<cfset newdamt_bil1 = (val(getbody.dispec1) / 100) * val(newamt1_bil)>
					<cfset netamt = val(newamt1_bil) - val(newdamt_bil1)>
					<cfset newdamt_bil2 = (val(getbody.dispec2) / 100) * val(netamt)>
					<cfset netamt = val(netamt) - val(newdamt_bil2)>
					<cfset newdamt_bil3 = (val(getbody.dispec3) / 100) * val(netamt)>
					<cfset netamt = val(netamt) - val(newdamt_bil3)>
	
					<cfset newdamt_bil = val(newdamt_bil1) + val(newdamt_bil2) + val(newdamt_bil3)>
					<cfset newtaxamt_bil = (val(getbody.taxpec1) / 100) * (val(newamt1_bil) - val(newdamt_bil))>
					<!--- <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil) + val(newtaxamt_bil)> --->
	                <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil)>
					<cfset newamt_bil = numberformat(val(newamt_bil),".__")>
					<cfset newprice = val(getbody.price_bil) * val(newcurrate)>
	
					<cfset newamt1 = val(newamt1_bil) * val(newcurrate)>
					<cfset newdamt = val(newdamt_bil) * val(newcurrate)>
					<cfset newtaxamt = val(newtaxamt_bil) * val(newcurrate)>
					<cfset newamt = val(newamt_bil) * val(newcurrate)>
					<cfset newamt = numberformat(val(newamt),".__")>
	
					<cfset gross_bil = val(gross_bil) + val(newamt_bil)>
					<cfset gross = val(gross_bil) * val(newcurrate)>
	                
	                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
						
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
	                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,	
						'#getbody.agenno#',	 <cfif isdefined('form.location')>
                    <cfif listgetat(form.location,j) eq "emptylocation">
						<cfset locationvalue = "">
                        <cfelse>
                        <cfset locationvalue = listgetat(form.location,j)>
                        </cfif>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#locationvalue#">,
                    <cfelse>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">,
					</cfif> '#getbody.source#', '#getbody.job#', '',
						'#getbody.qty_bil#', '#getbody.price_bil#',	'#getbody.unit_bil#', '#newamt1_bil#', '#val(getbody.dispec1)#',
						'#val(getbody.dispec2)#', '#val(getbody.dispec3)#', '#newdamt_bil#', '#newamt_bil#', '#val(getbody.taxpec1)#',
						'#val(getbody.taxpec2)#', '#val(getbody.taxpec3)#', '#newtaxamt_bil#', '', '#getbody.qty#', '#newprice#',
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.unit#">, '#newamt1#', '#newdamt#',	'#newamt#', '#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#',
						'#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#dateformat(getbody.wos_date,"yyyy-mm-dd")#', '#getbody.brem1#', '#getbody.brem2#', '#getbody.brem3#',
						'#getbody.brem4#', 
						<cfif lcase(hcomid) eq "avent_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
						<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
						</cfif>
						'#getbody.packing#', '#getbody.note1#', '#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N',
						'', '#getbody.grade#', '0.00','0.00','0',
						'0', '#getbody.m_charge1#', '#getbody.m_charge2#', '#getbody.adtcost1#', '#getbody.adtcost2#', '0', '0', '#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '', '0', '0', '0','#getbody.name#', '', '#getbody.van#', 'Y',
						'', '',	'', '0000-00-00', '', '0000-00-00', '', '', '', '', '#getbody.sono#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#',
						'#getbody.category#', '#getbody.area#', '#getbody.shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#',
						'0', '#member#', '', #Now()#, 'Time', '#getbody.bomno#',
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
						  '','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						</cfif>
					</cfquery>
					
					
					<cfif getbody.batchcode neq "">
						<cfif getbody.location neq "">
							<cfquery name="updateobbatch" datasource="#dts#">
								update lobthob set bth_qut=(bth_qut+#getbody.qty#)
								where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+#getbody.qty#)
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						<cfelse>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+#getbody.qty#)
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						</cfif>
					</cfif>
	
					<cfset qname='QOUT'&(readperiod+10)>
	
					<cfquery name="UpdateIcitem" datasource="#dts#">
						update icitem set #qname#=(#qname#+#getbody.qty#) where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
					</cfquery>
	
					<cfquery name="inserticlink" datasource="#dts#">
						insert into iclink values ('DO','#nexttranno#','#j#',
						'#ndatenow#','SAM','#listgetat(mylist,i,";")#','#getbody.trancode#',
						#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#getbody.qty_bil#')
					</cfquery>
					
					<!--- Add on 031008 --->
	        		<cfquery datasource="#dts#" name="getigrade">
						Select * from igrade where refno = '#listgetat(mylist,i,";")#' and type = 'SAM' 
	                    and TRANCODE = '#getbody.trancode#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
					</cfquery>
					
					<cfif getigrade.recordcount neq 0>
	            		<cfquery name="insertigrade" datasource="#dts#">
	                		insert into igrade
							(type,refno,trancode,itemno,wos_date,fperiod,sign,del_by,location,void,generated,custno,exported,factor1,factor2,
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									GRD#k#,
								<cfelse>
									GRD#k#
								</cfif>
							</cfloop>)
							values
							('DO','#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.itemno#">,'#ndatenow#','#readperiod#',
							'-1','',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.location#">,'','',
							'#getigrade.custno#','','#getigrade.factor1#','#getigrade.factor2#',
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>)
	                	</cfquery>
	                	<cfquery name="updateitemgrd" datasource="#dts#">
							update itemgrd
							set
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
						</cfquery>
					
						<cfquery name="updatelogrdob" datasource="#dts#">
							update logrdob
							set
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
							and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
						</cfquery>
					</cfif>
					
					<cfset j = j + 1>
				</cfloop>
            </cfif>

			<cfset j = j + 1>
			<cfif getGsetup.quochooseitem neq 1>
				<cfquery datasource="#dts#" name="updateictran">
					Update ictran 
					set shipped = qty,
					toinv='#nexttranno#'
					where refno =  '#listgetat(mylist,i,";")#'
					and toinv = '' and type = 'SAM'
				</cfquery>
			</cfif>
			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#' and (shipped+writeoff) < qty and type = 'SAM'
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set toinv = '#nexttranno#', order_cl = 'Y', generated = 'Y'
					where refno = '#listgetat(mylist,i,";")#' and type = 'SAM'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lSAM# no: #listgetat(form.checkbox,i,";")#<cfif getGsetup.quochooseitem eq 1>,#listgetat(form.checkbox,i+1,";")# </cfif>is successfully updated to #gettranname.lDO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
		</cfloop>

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
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
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
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
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
		
		<cftry>
			<cfquery name="getheader_remark" datasource="#dts#">
				select 
				type,
				refno,
				cast(remark1 as binary) as remark1,
				cast(remark2 as binary) as remark2,
				cast(remark3 as binary) as remark3,
				cast(remark4 as binary) as remark4,
				cast(remark5 as binary) as remark5,
				cast(remark6 as binary) as remark6,
				cast(remark7 as binary) as remark7,
				cast(remark8 as binary) as remark8,
				cast(remark9 as binary) as remark9,
				cast(remark10 as binary) as remark10
				from artran_remark where refno = '#listgetat(mylist,1,";")#' and type = 'SAM'
			</cfquery>
			<cfif getheader_remark.recordcount neq 0>
				<cfquery name="insert_remark" datasource="#dts#">
					insert into artran_remark
					(type,refno,
					<cfloop from="1" to="10" index="z">
						remark#z#,
					</cfloop>USERID,LASTUSERID)
					values
					('DO','#nexttranno#',
					<cfloop from="1" to="10" index="z">
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#getheader_remark["remark#z#"][1]#">,
					</cfloop>'#HUserID#','#HUserID#')
				</cfquery>
			</cfif>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
	<!--- t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO --->
	<cfelseif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
		</cfif>
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>
		<cfset j = 1>
		
		<cfif getGsetup.quochooseitem eq 1>
        	<cfset stepcount = "+3" >
		<cfelse>
        	<cfset stepcount = "+1" >
        </cfif>

		<cfloop from="1" to="#cnt#" index="i" step="#stepcount#">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

			  <cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>QUO No. : #listgetat(mylist,i,";")# <br></cfoutput>
			
			<!--- Start of Update body --->
            <cfif getGsetup.quochooseitem eq 1>
				<cfset xParam1 = listgetat(mylist,i,";")>

				<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			  		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  		<cfset xParam2 = ''>
				<cfelse>
			  		<cfset xParam2 = listgetat(mylist,i+1,";")>
				</cfif>

				<cfset xParam3 = listgetat(mylist,i+2,";")>
			
				<cfquery datasource="#dts#" name="getbody">
					Select * from ictran where refno = '#xParam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#"> and trancode = '#xParam3#' and shipped < qty and type = 'QUO'
				</cfquery>

				<cfloop query="getbody">
				  	<cfquery datasource="#dts#" name="getheader">
						Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
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
                    
                    <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>
					
					<!--- Add On 061008, 2nd Unit Function --->
					<!---<cfif val(getbody.factor1) neq 0>
						<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
					<cfelse>
						<cfset getbody.price_bil = 0>
					</cfif>--->
                    <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
					
					<cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil>
					
					<cfset newdamt_bil1 = (getbody.dispec1 / 100) * newamt1_bil>
					<cfset netamt = newamt1_bil - newdamt_bil1>
					<cfset newdamt_bil2 = (getbody.dispec2 / 100) * netamt>
					<cfset netamt = netamt - newdamt_bil2>
					<cfset newdamt_bil3 = (getbody.dispec3 / 100) * netamt>
					<cfset netamt = netamt - newdamt_bil3>
					
					<cfset newdamt_bil = newdamt_bil1 + newdamt_bil2 + newdamt_bil3>
					<cfif val(newdamt_bil) eq 0 and val(getbody.DISAMT_BIL) neq 0 and val(getbody.qty_bil) neq 0>
						<cfset newdamt_bil = val(getbody.DISAMT_BIL) * val(listgetat(fulfill,j)) / val(getbody.qty_bil)>
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
	                
					<!--- QUO TO DO --->
					<cfquery datasource="#dts#" name="insertictran">
						Insert into ictran 
						(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
						`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
						`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
						`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`QUONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,
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
					</cfif> '#getbody.source#', '#getbody.job#', '', '#listgetat(form.fulfill,j)#',
						'#getbody.price_bil#','#getbody.unit_bil#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
						'#newdamt_bil#', '#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#', '#newtaxamt_bil#',
						'', '#fulfillactual#', '#getbody.price#','#getbody.unit#', '#newamt1#', '#newdamt#', '#newamt#',
						'#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#', '#listgetat(mylist,i,";")#', '#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#getbody.sodate#', '#brem1#', '#brem2#', '#brem3#', '#brem4#',
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
						'#listgetat(mylist,i,";")#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#', '#getbody.category#', '#Area#',
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
								update lobthob set bth_qut=(bth_qut+'#fulfillactual#')
								where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+'#fulfillactual#')
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						<cfelse>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+'#fulfillactual#')
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						</cfif>
					</cfif>
	
					<cfset qname='QOUT'&(readperiod+10)>
	
					<cfquery name="UpdateIcitem" datasource="#dts#">
						update icitem set #qname#=(#qname#+#fulfillactual#) where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
					</cfquery>
	
					<cfquery name="inserticlink" datasource="#dts#">
						insert into iclink values ('DO','#nexttranno#','#j#',
						'#ndatenow#','QUO','#listgetat(mylist,i,";")#','#getbody.trancode#',
						#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#val(listgetat(form.fulfill,j))#')
					</cfquery>
	
					<cfset newship = getbody.shipped + val(listgetat(form.fulfill,j))>
	
					<cfquery datasource="#dts#" name="updateictran">
						Update ictran set shipped = '#newship#'
						where refno = '#xparam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and trancode = '#xparam3#'
						and toinv = '' and type = 'QUO'
					</cfquery>
					
					<cfif form["grdcolumnlist_QUO_#xparam1#_#xParam3#"] neq "">
						<cfset grdcolumnlist = form["grdcolumnlist_QUO_#xparam1#_#xParam3#"]>
						<cfset bgrdcolumnlist = form["bgrdcolumnlist_QUO_#xparam1#_#xParam3#"]>
						<cfset grdvaluelist = form["grdvaluelist_QUO_#xparam1#_#xParam3#"]>
						<cfset totalrecord = form["totalrecord_QUO_#xparam1#_#xParam3#"]>
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
							('DO', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">, '#ndatenow#','#readperiod#','-1','','#getbody.location#','','',
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
							and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
						</cfquery>
					</cfif>
				</cfloop>
	
				<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
					<cfquery datasource="#dts#" name="updateartran">
						Update ictran set toinv = '#nexttranno#', generated = 'Y'
						where refno = '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#">
						and toinv = '' and type = 'QUO' and trancode = '#xparam3#'
					</cfquery>
					
					<!--- Step 2:--->
					<!--- Add on 031008, For Graded Item --->
					<cfquery datasource="#dts#" name="updateigrade">
						Update igrade i, ictran ic 
						set i.generated = 'Y'
						where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
						and i.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#"> and i.trancode = '#xparam3#'
						and i.refno = '#xparam1#' and i.type = 'QUO'
						and ic.toinv = ''
					</cfquery>
				</cfif>
            <cfelse>
            	<cfquery datasource="#dts#" name="getbody">
					Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = 'QUO' order by itemcount
				</cfquery>
				<cfloop query="getbody">
				  	<!--- GET LATEST CURRRATE --->
				  	<cfquery datasource="#dts#" name="getheader">
						Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
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
						<cfset newcurrate = val(currency.rate)>
					<cfelse>
						<cfset newcurrate = 1><!--- default --->
					</cfif>
                    
                    <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>
	
					<cfset newamt1_bil = val(getbody.qty_bil) * val(getbody.price_bil)>
					<cfset newdamt_bil1 = (val(getbody.dispec1) / 100) * val(newamt1_bil)>
					<cfset netamt = val(newamt1_bil) - val(newdamt_bil1)>
					<cfset newdamt_bil2 = (val(getbody.dispec2) / 100) * val(netamt)>
					<cfset netamt = val(netamt) - val(newdamt_bil2)>
					<cfset newdamt_bil3 = (val(getbody.dispec3) / 100) * val(netamt)>
					<cfset netamt = val(netamt) - val(newdamt_bil3)>
	
					<cfset newdamt_bil = val(newdamt_bil1) + val(newdamt_bil2) + val(newdamt_bil3)>
					<cfset newtaxamt_bil = (val(getbody.taxpec1) / 100) * (val(newamt1_bil) - val(newdamt_bil))>
					<!--- <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil) + val(newtaxamt_bil)> --->
	                <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil)>
					<cfset newamt_bil = numberformat(val(newamt_bil),".__")>
					<cfset newprice = val(getbody.price_bil) * val(newcurrate)>
	
					<cfset newamt1 = val(newamt1_bil) * val(newcurrate)>
					<cfset newdamt = val(newdamt_bil) * val(newcurrate)>
					<cfset newtaxamt = val(newtaxamt_bil) * val(newcurrate)>
					<cfset newamt = val(newamt_bil) * val(newcurrate)>
					<cfset newamt = numberformat(val(newamt),".__")>
	
					<cfset gross_bil = val(gross_bil) + val(newamt_bil)>
					<cfset gross = val(gross_bil) * val(newcurrate)>
	                
	                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
						
					<!--- QUO TO DO --->
					<cfquery datasource="#dts#" name="insertictran">
						Insert into ictran 
						(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
						`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
						`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
						`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`QUONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,
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
	                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,	
						'#getbody.agenno#',	 <cfif isdefined('form.location')>
                    <cfif listgetat(form.location,j) eq "emptylocation">
						<cfset locationvalue = "">
                        <cfelse>
                        <cfset locationvalue = listgetat(form.location,j)>
                        </cfif>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#locationvalue#">,
                    <cfelse>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">,
					</cfif> '#getbody.source#', '#getbody.job#', '',
						'#getbody.qty_bil#', '#getbody.price_bil#',	'#getbody.unit_bil#', '#newamt1_bil#', '#val(getbody.dispec1)#',
						'#val(getbody.dispec2)#', '#val(getbody.dispec3)#', '#newdamt_bil#', '#newamt_bil#', '#val(getbody.taxpec1)#',
						'#val(getbody.taxpec2)#', '#val(getbody.taxpec3)#', '#newtaxamt_bil#', '', '#getbody.qty#', '#newprice#',
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.unit_bil#">, '#newamt1#', '#newdamt#',	'#newamt#', '#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#',
						'#listgetat(mylist,i,";")#','#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#dateformat(getbody.wos_date,"yyyy-mm-dd")#', '#getbody.brem1#', '#getbody.brem2#', '#getbody.brem3#',
						'#getbody.brem4#', 
						<cfif lcase(hcomid) eq "avent_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
						<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
						</cfif>
						'#getbody.packing#', '#getbody.note1#', '#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N',
						'', '#getbody.grade#', '0.00','0.00','0',
						'0', '#getbody.m_charge1#', '#getbody.m_charge2#', '#getbody.adtcost1#', '#getbody.adtcost2#', '0', '0', '#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '', '0', '0', '0','#getbody.name#', '', '#getbody.van#', 'Y',
						'', '',	'', '0000-00-00', '', '0000-00-00', '', '', '', '', '#getbody.sono#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#',
						'#getbody.category#', '#getbody.area#', '#getbody.shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#',
						'0', '#member#', '', #Now()#, 'Time', '#getbody.bomno#',
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
						  '','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						</cfif>
					</cfquery>
					
					
					<cfif getbody.batchcode neq "">
						<cfif getbody.location neq "">
							<cfquery name="updateobbatch" datasource="#dts#">
								update lobthob set bth_qut=(bth_qut+#getbody.qty#)
								where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+#getbody.qty#)
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						<cfelse>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+#getbody.qty#)
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						</cfif>
					</cfif>
	
					<cfset qname='QOUT'&(readperiod+10)>
	
					<cfquery name="UpdateIcitem" datasource="#dts#">
						update icitem set #qname#=(#qname#+#getbody.qty#) where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
					</cfquery>
	
					<cfquery name="inserticlink" datasource="#dts#">
						insert into iclink values ('DO','#nexttranno#','#j#',
						'#ndatenow#','QUO','#listgetat(mylist,i,";")#','#getbody.trancode#',
						#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#getbody.qty_bil#')
					</cfquery>
					
					<!--- Add on 031008 --->
	        		<cfquery datasource="#dts#" name="getigrade">
						Select * from igrade where refno = '#listgetat(mylist,i,";")#' and type = 'QUO' 
	                    and TRANCODE = '#getbody.trancode#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
					</cfquery>
					
					<cfif getigrade.recordcount neq 0>
	            		<cfquery name="insertigrade" datasource="#dts#">
	                		insert into igrade
							(type,refno,trancode,itemno,wos_date,fperiod,sign,del_by,location,void,generated,custno,exported,factor1,factor2,
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									GRD#k#,
								<cfelse>
									GRD#k#
								</cfif>
							</cfloop>)
							values
							('DO','#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.itemno#">,'#ndatenow#','#readperiod#',
							'-1','',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.location#">,'','',
							'#getigrade.custno#','','#getigrade.factor1#','#getigrade.factor2#',
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>)
	                	</cfquery>
	                	<cfquery name="updateitemgrd" datasource="#dts#">
							update itemgrd
							set
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
						</cfquery>
					
						<cfquery name="updatelogrdob" datasource="#dts#">
							update logrdob
							set
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
							and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
						</cfquery>
					</cfif>
					
					<cfset j = j + 1>
				</cfloop>
            </cfif>

			<cfset j = j + 1>
			<cfif getGsetup.quochooseitem neq 1>
				<cfquery datasource="#dts#" name="updateictran">
					Update ictran 
					set shipped = qty,
					toinv='#nexttranno#'
					where refno =  '#listgetat(mylist,i,";")#'
					and toinv = '' and type = 'QUO'
				</cfquery>
			</cfif>
			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#' and (shipped+writeoff) < qty and type = 'QUO'
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set toinv = '#nexttranno#', order_cl = 'Y', generated = 'Y'
					where refno = '#listgetat(mylist,i,";")#' and type = 'QUO'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lQUO# no: #listgetat(form.checkbox,i,";")#<cfif getGsetup.quochooseitem eq 1>,#listgetat(form.checkbox,i+1,";")# </cfif>is successfully updated to #gettranname.lDO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
		</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
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
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
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
		<!--- QUO TO DO --->
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
			</cfif>,taxincl,e_mail,country,d_country,postalcode,d_postalcode)

			values('DO','#nexttranno#','#getheader.refno2#','#getheader.custno#','#readperiod#','#ndatenow#',
			'#getheader.desp#','#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#',	'#getheader.term#','#getheader.van#',
			'#getheader.pono#',<cfif getheader.dono neq ''>'#getheader.dono#'<cfelse>'#updatepono#'</cfif>,'#updatepono#','#getheader.rem0#','#getheader.rem1#','#getheader.rem2#','#getheader.rem3#',
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
			</cfif>,'#getheader.taxincl#','#getheader.e_mail#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.country#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.d_country#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.postalcode#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.d_postalcode#">
            )
		</cfquery>
		
		<cftry>
			<cfquery name="getheader_remark" datasource="#dts#">
				select 
				type,
				refno,
				cast(remark1 as binary) as remark1,
				cast(remark2 as binary) as remark2,
				cast(remark3 as binary) as remark3,
				cast(remark4 as binary) as remark4,
				cast(remark5 as binary) as remark5,
				cast(remark6 as binary) as remark6,
				cast(remark7 as binary) as remark7,
				cast(remark8 as binary) as remark8,
				cast(remark9 as binary) as remark9,
				cast(remark10 as binary) as remark10
				from artran_remark where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
			</cfquery>
			<cfif getheader_remark.recordcount neq 0>
				<cfquery name="insert_remark" datasource="#dts#">
					insert into artran_remark
					(type,refno,
					<cfloop from="1" to="10" index="z">
						remark#z#,
					</cfloop>USERID,LASTUSERID)
					values
					('DO','#nexttranno#',
					<cfloop from="1" to="10" index="z">
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#getheader_remark["remark#z#"][1]#">,
					</cfloop>'#HUserID#','#HUserID#')
				</cfquery>
			</cfif>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
	<cfelseif url.t1 eq "PO">
		<cfset type = gettranname.lPO>
		<!---cfquery datasource="#dts#" name="updategsetup">
			Update Gsetup set dono = UPPER("#nexttranno#")
		</cfquery--->
		
		<!--- <cfquery name="updategsetup" datasource="main">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where userDept = '#dts#'
			and type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
		
		<!--- <cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
		</cfif>
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>
		<cfset j = 1>
		<cfloop from="1" to="#cnt#" index="i" step="+3">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

				<cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>PO No. : #listgetat(mylist,i,";")# <br></cfoutput>
			<cfset xParam1 = listgetat(mylist,i,";")>

			<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			  	<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  	<cfset xParam2 = ''>
			<cfelse>
			  	<cfset xParam2 = listgetat(mylist,i+1,";")>
			</cfif>

			<cfset xParam3 = listgetat(mylist,i+2,";")>

			<cfquery datasource="#dts#" name="getbody">
				Select * from ictran where refno = '#xParam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#"> and trancode = '#xParam3#' and type = 'PO'
			</cfquery>

			<cfquery name="getcust" datasource="#dts#">
				select a.custno,a.name,a.term,a.currcode,a.agent,a.area,(select #currperiod# from #target_currency# where currcode=a.currcode) as rate 
				from #target_arcust# as a 
				where a.custno='#form.customer#'
			</cfquery>
			
			<cfset newcurrate = val(getcust.rate)>
			
			<cfloop query="getbody">
			  	
				<cfset newamt1_bil = 0>
				<cfset newdamt_bil1 = 0>
				<cfset netamt = newamt1_bil - newdamt_bil1>
				<cfset newdamt_bil2 = 0>
				<cfset netamt = netamt - newdamt_bil2>
				<cfset newdamt_bil3 = 0>
				<cfset netamt = netamt - newdamt_bil3>
				<cfset newdamt_bil = newdamt_bil1 + newdamt_bil2 + newdamt_bil3>
				<cfset newtaxamt_bil = 0>
				<!--- <cfset newamt_bil = newamt1_bil - newdamt_bil + newtaxamt_bil> --->
                <cfset newamt_bil = newamt1_bil - newdamt_bil>
				<cfset newamt_bil = numberformat(newamt_bil,".__")>
				<cfset newprice = 0>
				<cfset newamt1 = newamt1_bil * newcurrate>
				<cfset newdamt = newdamt_bil * newcurrate>
				<cfset newtaxamt = newtaxamt_bil * newcurrate>
				<cfset newamt = newamt_bil * newcurrate>
				<cfset newamt = numberformat(newamt,".__")>
				<cfset gross_bil = gross_bil + newamt_bil>
				<cfset gross = gross_bil * newcurrate>
				
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
                
				<cfquery datasource="#dts#" name="insertictran">
					Insert into ictran 
					(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
					`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
					`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
					`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,`PACKING`,`NOTE1`,
					`NOTE2`,`GLTRADAC`,`UPDCOST`,`GST_ITEM`,`TOTALUP`,`WITHSN`,`GRADE`,`PUR_PRICE`,
					`QTY_RET`,`TEMPFIGI`,`SERCOST`,`M_CHARGE1`,`M_CHARGE2`,`ADTCOST1`,`ADTCOST2`,`IT_COS`,`AV_COST`,
					`BATCHCODE`,`EXPDATE`,`POINT`,`INV_DISC`,`INV_TAX`,`SUPP`,`EDI_COU1`,`WRITEOFF`,`TOSHIP`,`SHIPPED`,`NAME`,`DEL_BY`,
					`VAN`,`GENERATED`,`UD_QTY`,`TOINV`,`EXPORTED`,`EXPORTED1`,`EXPORTED2`,`EXPORTED3`,`BRK_TO`,`SV_PART`,`LAST_YEAR`,
					`VOID`,`SONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`TEMP`,`TEMP1`,
					`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,`TABLENO`,`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,
					`NODISPLAY`,`TITLE_ID`,`TITLE_DESP`,<cfif lcase(hcomid) eq "topsteel_i">`TITLE_DESPA`,</cfif>
					`COMMENT`,`DEFECTIVE`,`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,
					`MC6_BIL`,`MC7_BIL`<cfif lcase(hcomid) eq "fdipx_i">,`JobOrderNo`</cfif>,`taxincl`,`note_a`)
					values ('DO', '#nexttranno#', '#getbody.refno2#', '#j#', '#getcust.custno#', '#readperiod#',
					'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">, 
					'#agenno#',	<cfif isdefined('form.location')>
                    <cfif listgetat(form.location,j) eq "emptylocation">
						<cfset locationvalue = "">
                        <cfelse>
                        <cfset locationvalue = listgetat(form.location,j)>
                        </cfif>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#locationvalue#">,
                    <cfelse>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">,
					</cfif> '#getbody.source#', '#getbody.job#', '', '#listgetat(form.fulfill,j)#',
					'0', '#unit#', '#newamt1_bil#', '0', '0', '0',
					'#newdamt_bil#','#newamt_bil#', '0','0', '0', '#newtaxamt_bil#', '',
					'#listgetat(form.fulfill,j)#', '#newprice#',
					'#unit#', '#newamt1#', '#newdamt#', '#newamt#', '#newtaxamt#', '1', '1', '#listgetat(mylist,i,";")#',
					'#dateformat(Now(),"yyyy-mm-dd")#','#dateformat(getbody.wos_date,"yyyy-mm-dd")#',
					<cfif lcase(HcomID) eq "floprints_i">'','','',''<cfelse>'#brem1#','#brem2#','#brem3#','#brem4#'</cfif>,
					'#getbody.packing#', '#getbody.note1#',
					'#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N', '', '#getbody.grade#', '0.00',
					'0.00', '0', '0', '0', '0', '0', '0', '0', '0','#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '',
					'0', '0', '0','#getcust.name#', '0', '0', 'Y', '', '', '', '0000-00-00', '', '0000-00-00', '', '', '', '',
					'#listgetat(mylist,i,";")#', '0', '0', '#huserid#', '0', '', '#getbody.wos_group#', '#getbody.category#',
					'#Area#', '#Shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#', '0',
					'#member#', '', #Now()#, 'Time', '#BOMNO#',
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
					  	'','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					</cfif>
				</cfquery>

				<cfif getbody.batchcode neq "">
					<cfif getbody.location neq "">
						<cfquery name="updateobbatch" datasource="#dts#">
							update lobthob set bth_qut=(bth_qut+'#listgetat(form.fulfill,j)#')
							where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
						<cfquery name="updateobbatch" datasource="#dts#">
							update obbatch set bth_qut=(bth_qut+'#listgetat(form.fulfill,j)#')
							where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
					<cfelse>
						<cfquery name="updateobbatch" datasource="#dts#">
							update obbatch set bth_qut=(bth_qut+'#listgetat(form.fulfill,j)#')
							where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
					</cfif>
				</cfif>

				<cfset qname='QOUT'&(readperiod+10)>

				<cfquery name="UpdateIcitem" datasource="#dts#">
					update icitem set #qname#=(#qname#+#listgetat(form.fulfill,j)#) where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
				</cfquery>

				<cfquery name="inserticlink" datasource="#dts#">
					insert into iclink values ('DO','#nexttranno#','#j#',
					'#ndatenow#','PO','#listgetat(mylist,i,";")#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#listgetat(form.fulfill,j)#')
				</cfquery>
				
				<cfset newship = getbody.shipped + listgetat(form.fulfill,j)>

				<cfquery datasource="#dts#" name="updateictran">
					Update ictran set shipped = '#newship#'
					where refno = '#xparam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and trancode = '#xparam3#'
					and type = 'PO'
				</cfquery>
				
				<!--- Start: Add on 051008, graded item --->
				<!--- <cfif Evaluate("form.grdcolumnlist_PO_#xparam1#_#xParam3#") neq ""> --->
				<cfif form["grdcolumnlist_PO_#xparam1#_#xParam3#"] neq "">
					<!--- <cfset grdcolumnlist = Evaluate("form.grdcolumnlist_PO_#xparam1#_#xParam3#")>
					<cfset bgrdcolumnlist = Evaluate("form.bgrdcolumnlist_PO_#xparam1#_#xParam3#")>
					<cfset grdvaluelist = Evaluate("form.grdvaluelist_PO_#xparam1#_#xParam3#")>
					<cfset totalrecord = Evaluate("form.totalrecord_PO_#xparam1#_#xParam3#")> --->
					<cfset grdcolumnlist = form["grdcolumnlist_PO_#xparam1#_#xParam3#"]>
					<cfset bgrdcolumnlist = form["bgrdcolumnlist_PO_#xparam1#_#xParam3#"]>
					<cfset grdvaluelist = form["grdvaluelist_PO_#xparam1#_#xParam3#"]>
					<cfset totalrecord = form["totalrecord_PO_#xparam1#_#xParam3#"]>
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
						('DO', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">, '#ndatenow#','#readperiod#','-1','','#getbody.location#','','',
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
						where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
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
						where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
						and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
					</cfquery>
				</cfif>
				<!--- End: Add on 051008, graded item --->
			</cfloop>

			<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
				<cfquery datasource="#dts#" name="updateartran">
					Update ictran set toinv = '#nexttranno#', generated = 'Y'
					where refno = '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#"><!--- '#listgetat(mylist,i+1,";")#' --->
					and toinv = '' and type = 'PO' and trancode = '#xparam3#'
				</cfquery>
			</cfif>

			<cfset j = j + 1>

			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#' and (shipped+writeoff) < qty and type = 'PO'
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set toinv = '#nexttranno#', order_cl = 'Y', generated = 'Y' 
					where refno = '#listgetat(mylist,i,";")#'
					and type = 'PO'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lPO# no: #listgetat(mylist,i,";")#,#listgetat(mylist,i+1,";")# is successfully updated to #gettranname.lDO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
		</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'PO'
		</cfquery>

		<cfset xdisp1 = 0>
		<cfset xdisp2 = 0>
		<cfset xdisp3 = 0>
		<cfset xtaxp1 = 0>
		

		<cfset disc1_bil = gross_bil * xdisp1/100>
		<cfset net1_bil = gross_bil - disc1_bil>
		<cfset disc2_bil = net1_bil * xdisp2/100>
		<cfset net1_bil = net1_bil - disc2_bil>
		<cfset disc3_bil = net1_bil * xdisp3/100>

		<cfset disc_bil = disc1_bil + disc2_bil + disc3_bil>
		
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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
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
		<!--- PO TO DO --->
		<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,
			currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,
			tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax2,
			tax3,tax,taxp1,taxp2,taxp3,grand,note,term,van,pono,dono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
			rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,trdatetime,userid,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on,taxincl,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49)

			values('DO','#nexttranno#','#getheader.refno2#','#getcust.custno#','#readperiod#','#ndatenow#',
			'#getheader.desp#','#getheader.despa#','#getcust.agent#','#getcust.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'0','0','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','0','0','#numberformat(tax,".__")#','#xtaxp1#','0',
			'0','#grand#','#getheader.note#','#getcust.term#','',
			<cfif getheader.pono neq ''>'#getheader.pono#'<cfelse>'#updatepono#'</cfif>,'#getheader.dono#','#getheader.quono#','#getheader.rem0#','#getheader.rem1#', '#getheader.rem2#','#getheader.rem3#',
			'#getheader.rem4#','#getheader.rem5#',
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			'#getheader.rem11#', '#getheader.rem12#','#getheader.frem0#', '#getheader.frem1#', '#getheader.frem2#', '#getheader.frem3#', '#getheader.frem4#',
			'#getheader.frem5#', '#getheader.frem6#', '#getheader.frem7#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getheader.comm0#', '#getheader.comm1#', '#getheader.comm2#', '#getheader.comm3#', '#getheader.comm4#',
			'#getcust.name#',#Now()#, '#HUserID#','#getcust.currcode#',
			'#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#',
			'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#','#getheader.special_account_code#',
			'#HUserID#',#now()#,'#HUserID#',#now()#,'#getheader.taxincl#','#getheader.rem30#', '#getheader.rem31#', '#getheader.rem32#', '#getheader.rem33#', '#getheader.rem34#', '#getheader.rem35#', '#getheader.rem36#', '#getheader.rem37#', '#getheader.rem38#', '#getheader.rem39#', '#getheader.rem40#', '#getheader.rem41#', '#getheader.rem42#', '#getheader.rem43#', '#getheader.rem44#', '#getheader.rem45#', '#getheader.rem46#', '#getheader.rem47#', '#getheader.rem48#', '#getheader.rem49#')
		</cfquery>
	</cfif>
<!--- t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC t2 = RC --->
<cfelseif url.t2 eq "RC">
	<h1>Update to <cfoutput>#gettranname.lRC#</cfoutput></h1>
	<!--- t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO t1 = PO --->
	<cfif url.t1 eq "PO">
		<cfset type = gettranname.lPO>
	
		<!---cfquery datasource="#dts#" name="updategsetup">
			Update Gsetup set rcno = UPPER("#nexttranno#")
		</cfquery--->
		
		<!--- <cfquery name="updategsetup" datasource="main">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where userDept = '#dts#'
			and type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
		
		<!--- <cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
		<cftry>
        	<cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        	<cfelse>
			<cfquery name="updategsetup" datasource="#dts#">
				update refnoset set 
				lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
				where type = '#url.t2#'
				and counter =  '#invset#'
			</cfquery>
            </cfif>
		<cfcatch type="any">
			<cfoutput>#cfcatch.Message#::#cfcatch.Detail#</cfoutput><cfabort>
		</cfcatch>
		</cftry>

		<cfset mylist= listchangedelims(checkbox,"",",")>

		<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>

		<cfset j = 1>

		<cfloop from="1" to="#cnt#" index="i" step="+3">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

				<cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>
			<cfoutput>PO No. : #listgetat(mylist,i,";")# <br></cfoutput>
			<cfset xParam1 = listgetat(mylist,i,";")>

			<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			  	<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  	<cfset xParam2 = ''>
			<cfelse>
			  	<cfset xParam2 = listgetat(mylist,i+1,";")>
			</cfif>

			<cfset xParam3 = listgetat(mylist,i+2,";")>

			<cfquery datasource="#dts#" name="getbody">
				Select * from ictran where refno = '#xParam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#"> and trancode = '#xParam3#'
				and shipped < qty and type = 'PO'
			</cfquery>

			<cfloop query="getbody">
			  	<cfquery datasource="#dts#" name="getheader">
					Select currcode,custno,currrate from artran where refno = '#listgetat(mylist,1,";")#' and type = 'PO'
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
                <cfif getGsetup.po_to_rc_currrate eq 'Y'>
                <cfset newcurrate = getheader.currrate>
                <cfelse>
					<cfset newcurrate = currency.rate>
                    </cfif>
				<cfelse>
					<cfset newcurrate = 1>
				</cfif>
                
                <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>
                
         

				<!--- Add On 061008, 2nd Unit Function --->
				<!---<cfif val(getbody.factor1) neq 0>
                	<cfif getbody.price_bil neq '#listgetat(pricebil,j)#'>
                    <cfset getbody.price_bil = '#listgetat(pricebil,j)#'>
					</cfif>
					<cfset getbody.price_bil = numberformat(getbody.price_bil,'.000000') * val(getbody.factor2) / val(getbody.factor1)>
				<cfelse>
					<cfset getbody.price_bil = 0>
				</cfif>--->
                <cfif getbody.price_bil neq '#listgetat(pricebil,j)#'>
                    <cfset getbody.price_bil = '#listgetat(pricebil,j)#'>
					</cfif>
                <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
                
                
                
                
				<cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil>
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
                <cfset taxcharge = taxcharge + numberformat(newtaxamt_bil,".__")>
				</cfif>
                <cfset totaltaxcharge = totaltaxcharge + numberformat(newtaxamt_bil,".__")>
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
                
                
                
				<!--- PO TO RC --->
				<!---<cftry>--->
					<cfquery datasource="#dts#" name="insertictran">
						Insert into ictran (TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, wos_DATE,
						CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA,
						AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL,
						UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3,
						DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3,
						TAXAMT_BIL, IMPSTAGE, QTY, PRICE, UNIT,
						AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE,
						SODATE, BREM1, BREM2, BREM3, BREM4, 
						<cfif lcase(hcomid) eq "avent_i">
							BREM5,BREM6,
						<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
							BREM5,BREM7,BREM8,BREM9,BREM10,
						</cfif>
						PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST,
						GST_ITEM, TOTALUP, WITHSN, GRADE, PUR_PRICE,
						QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1,ADTCOST2,
						IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1,
						WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED,
						EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL,
						MC2_BIL, USERID, DAMT, OLDBILL, wos_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1,
						BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME,
						TIME, BOMNO,
						`NODISPLAY`,`TITLE_ID`,`TITLE_DESP`,<cfif lcase(hcomid) eq "topsteel_i">`TITLE_DESPA`,</cfif> 
						DEFECTIVE,comment,M_CHARGE3,M_CHARGE4,M_CHARGE5,M_CHARGE6,M_CHARGE7,MC3_BIL,MC4_BIL,MC5_BIL,MC6_BIL,MC7_BIL<cfif lcase(hcomid) eq "fdipx_i">,JobOrderNo</cfif>,`taxincl`,`note_a`)
	
						values ('RC', '#nexttranno#', <cfif isdefined('form.refno2')><cfif form.refno2 neq ''>'#form.refno2#'<cfelse>'#getbody.refno2#'</cfif><cfelse>'#getbody.refno2#'</cfif>, '#j#', '#getbody.custno#', '#readperiod#', '#ndatenow#',
						'#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
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
					</cfif> '#getbody.source#', '#getbody.job#', '', '#listgetat(form.fulfill,j)#', '#getbody.price_bil#',
						'#getbody.unit_bil#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
						'#newdamt_bil#', '#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#',
						'#newtaxamt_bil#', '', '#fulfillactual#', '#getbody.price#', '#unit#',
						'#newamt1#', '#newdamt#', '#newamt#', '#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#',
						'#listgetat(mylist,i,";")#',<cfif getbody.dodate EQ '' or getbody.dodate EQ '0000-00-00'>'0000-00-00'<cfelse>'#DateFormat(getbody.dodate,"yyyy-mm-dd")#'</cfif>,'#dateformat(getbody.wos_date,"yyyy-mm-dd")#', '#brem1#', '#brem2#', '#brem3#', '#brem4#',
						<cfif lcase(hcomid) eq "avent_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
						<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
						</cfif>
						'#packing#', '#note1#', '#note2#',
						'#gltradac#', '', 'N', 'N', '', '#grade#', '0.00','0.00', '0', '0', '#getbody.m_charge1#', '#getbody.m_charge2#',
						'#getbody.adtcost1#', '#getbody.adtcost2#', '0', '0', '#getbody.batchcode#',<cfif getbody.expdate eq "" or getbody.expdate eq "0000-00-00">'0000-00-00'<cfelse>#getbody.expdate#</cfif>, '0', '0', '0', '', '', '0', '0', '0',
						'#name#', '0', '#van#', 'Y', '', '', '', '0000-00-00', '', '0000-00-00', '', '', '', '','#listgetat(mylist,i,";")#',
						'#getbody.mc1_bil#', '#getbody.mc2_bil#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">, '0', '', '#getbody.wos_group#', '#getbody.category#', '#Area#', '#Shelf#', '#Temp#', '#Temp1#',
						'', '0', '0', '0', '#Promoter#', '0',
						'#member#', '', #Now()#, 'Time', '#BOMNO#',
						'#getbody.nodisplay#','#getbody.title_id#','#getbody.title_desp#',
            			<cfif lcase(hcomid) eq "topsteel_i"><cfqueryparam cfsqltype="cf_sql_longvarchar" value="#getbody.title_despa#">,</cfif> 
						'#getbody.defective#',
	
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
						  	"#tostring(getbody.comment)#",'#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						<cfelseif SingleQ eq '' and DoubleQ eq 'Y'>
						  	<!--- Found " in the comment --->
						  	'#tostring(getbody.comment)#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						<cfelseif SingleQ eq '' and DoubleQ eq ''>
						  	'#tostring(getbody.comment)#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						<cfelse>
						  	'','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						</cfif>
					</cfquery>
				<!---<cfcatch type="any">
					<cfoutput>#cfcatch.Message#::#cfcatch.Detail#</cfoutput><cfabort>
				</cfcatch>
				</cftry>--->
				
				<!--- UPDATE UNIT COST --->
				<cfinclude template = "update_unit_cost_process.cfm">
				<!--- UPDATE UNIT COST --->
				
				<cfif getbody.batchcode neq "">
					<cfif getbody.location neq "">
						<cfquery name="updateobbatch" datasource="#dts#">
							update lobthob set bth_qin=(bth_qin+'#fulfillactual#'),rc_type = 'RC', rc_refno = '#nexttranno#', rc_expdate = '#getbody.expdate#'
							where location='#getbody.location#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
						<cfquery name="updateobbatch" datasource="#dts#">
							update obbatch set bth_qin=(bth_qin+'#fulfillactual#'),rc_type = 'RC', rc_refno = '#nexttranno#', rc_expdate = '#getbody.expdate#'
							where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
					<cfelse>
						<cftry>
						<cfquery name="updateobbatch" datasource="#dts#">
							update obbatch set bth_qin=(bth_qin+'#fulfillactual#'),rc_type = 'RC', rc_refno = '#nexttranno#', rc_expdate = '#getbody.expdate#'
							where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
						<cfcatch type="database"></cfcatch>
						</cftry>
					</cfif>
				</cfif>

				<cfquery name="inserticlink" datasource="#dts#">
					insert into iclink values ('RC','#nexttranno#','#j#',
					'#ndatenow#','PO','#listgetat(mylist,i,";")#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#val(listgetat(form.fulfill,j))#')
				</cfquery>

				<cfset newship = getbody.shipped + val(listgetat(form.fulfill,j))>

				<cfquery datasource="#dts#" name="updateictran">
					Update ictran set shipped = '#newship#'
					where refno = '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and trancode = '#getbody.trancode#'
					and toinv = '' and type = 'PO'
				</cfquery>

				<cfset qname='QIN'&(readperiod+10)><cfoutput>#qname#--#getbody.qty#</cfoutput>

				<cfquery name="UpdateIcitem" datasource="#dts#">
					update icitem set #qname#=(#qname#+#fulfillactual#) where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
				</cfquery>
				
				<!--- Start: Add on 051008, graded item --->
				<!--- <cfif Evaluate("form.grdcolumnlist_PO_#xparam1#_#xParam3#") neq ""> --->
				<cfif form["grdcolumnlist_PO_#xparam1#_#xParam3#"] neq "">
					<!--- <cfset grdcolumnlist = Evaluate("form.grdcolumnlist_PO_#xparam1#_#xParam3#")>
					<cfset bgrdcolumnlist = Evaluate("form.bgrdcolumnlist_PO_#xparam1#_#xParam3#")>
					<cfset grdvaluelist = Evaluate("form.grdvaluelist_PO_#xparam1#_#xParam3#")>
					<cfset totalrecord = Evaluate("form.totalrecord_PO_#xparam1#_#xParam3#")> --->
					<cfset grdcolumnlist = form["grdcolumnlist_PO_#xparam1#_#xParam3#"]>
					<cfset bgrdcolumnlist = form["bgrdcolumnlist_PO_#xparam1#_#xParam3#"]>
					<cfset grdvaluelist = form["grdvaluelist_PO_#xparam1#_#xParam3#"]>
					<cfset totalrecord = form["totalrecord_PO_#xparam1#_#xParam3#"]>
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
						('RC', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">, '#ndatenow#','#readperiod#','1','','#getbody.location#','','',
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
								#myArray3[k]# = #myArray3[k]#+#myArray2[k]#,
							<cfelse>
								#myArray3[k]# = #myArray3[k]#+#myArray2[k]#
							</cfif>
						</cfloop>
						where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
					</cfquery>
				
					<cfquery name="updatelogrdob" datasource="#dts#">
						update logrdob
						set
						<cfloop from="1" to="#totalrecord#" index="k">
							<cfif k neq totalrecord>
								#myArray3[k]# = #myArray3[k]#+#myArray2[k]#,
							<cfelse>
								#myArray3[k]# = #myArray3[k]#+#myArray2[k]#
							</cfif>
						</cfloop>
						where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
						and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
					</cfquery>
				</cfif>
				<!--- End: Add on 051008, graded item --->
			</cfloop>

			<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
				<cfquery datasource="#dts#" name="updateartran">
					Update ictran set toinv = '#nexttranno#', generated = 'Y'
					where refno = '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">
					and toinv = '' and type = 'PO' and trancode = '#xparam3#'
				</cfquery>
				
				<!--- Step 2:--->
				<!--- Add on 051008, For Graded Item --->
				<cfquery datasource="#dts#" name="updateigrade">
					Update igrade i, ictran ic 
					set i.generated = 'Y'
					where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
					and i.refno = '#xparam1#' and i.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and i.trancode = '#xparam3#'
					and ic.toinv = '' and i.type = 'PO'
				</cfquery>
			</cfif>

			<cfset j = j + 1>

			<!--- <cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#' and shipped < qty and type = 'PO'
			</cfquery> --->
			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#' and <!---(shipped+writeoff) < qty--->(toinv="" or toinv is null) and type = 'PO'
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set toinv = '#nexttranno#', order_cl = 'Y', generated = 'Y'<cfif isdefined('form.refno2')><cfif form.refno2 neq ''>,refno2='#form.refno2#'</cfif></cfif> where refno = '#listgetat(mylist,i,";")#' and type = 'PO'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lPO# no: #listgetat(form.checkbox,i,";")#,#xParam2# is successfully updated to #gettranname.lRC# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
		</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'PO'
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
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>

		<cfif getheader.disp1 neq 0 and  getheader.disp1 neq "">
			<cfset xdisp1 = val(getheader.disp1)>
		<cfelse>
			<cfset xdisp1 = 0>
		</cfif>

		<cfif getheader.disp2 neq 0 and  getheader.disp2 neq "">
			<cfset xdisp2 = val(getheader.disp2)>
		<cfelse>
			<cfset xdisp2 = 0>
		</cfif>

		<cfif getheader.disp3 neq 0 and  getheader.disp3 neq "">
			<cfset xdisp3 = val(getheader.disp3)>
		<cfelse>
			<cfset xdisp3 = 0>
		</cfif>

		<cfif getheader.taxp1 neq 0 and  getheader.taxp1 neq "">
			<cfset xtaxp1 = val(getheader.taxp1)>
		<cfelse>
			<cfset xtaxp1 = 0>
		</cfif>

		<cfset disc1_bil = gross_bil * xdisp1/100>
		<cfset net1_bil = gross_bil - disc1_bil>
		<cfset disc2_bil = net1_bil * xdisp2/100>
		<cfset net1_bil = net1_bil - disc2_bil>
		<cfset disc3_bil = net1_bil * xdisp3/100>

		<cfif disc1_bil eq 0 and disc2_bil eq 0 and disc3_bil eq 0 and getheader.disc_bil neq 0>
			<cfset disc_bil = val(getheader.disc_bil)>
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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
        <cfif getheader.taxincl neq "T">
        
        <cfif totaltaxcharge eq 0 and taxcharge eq 0>
		<cfset grand_bil = net_bil + tax_bil>
        <cfelseif taxcharge neq 0>
        <cfset grand_bil = net_bil + taxcharge>
        <cfelse>
        <cfset grand_bil = net_bil>
		</cfif>
       
        <cfelse>
        <cfset grand_bil = net_bil>
        </cfif>
		<cfset grand_bil = numberformat(grand_bil+val(getheader.mc1_bil)+val(getheader.mc2_bil)+val(getheader.mc3_bil)+val(getheader.mc4_bil)+val(getheader.mc5_bil)+val(getheader.mc6_bil)+val(getheader.mc7_bil),".__")>
		<cfset grand = grand_bil * newcurrate>
		<cfset grand = numberformat(grand,".__")>
		
		<cfif lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i">
			<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getheader.rem9#" returnvariable="getheader.rem9"/>
			<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getheader.rem11#" returnvariable="getheader.rem11"/>
		</cfif>
		 <cfif getheader.desp eq "">
        <cfset getheader.desp  = "PURCHASES">
		</cfif>
		<!--- PO TO RC --->
		<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,
			currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,
			tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax2,
			tax3,tax,taxp1,taxp2,taxp3,grand,note,term,van,pono,dono,quono,sono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
			rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
			trdatetime,userid,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49
			<cfif lcase(hcomid) eq 'iel_i'>
				,rem15,rem16,rem17,rem18,rem19,rem20,rem21,rem22,rem23,rem24,rem25
			</cfif>,taxincl)

			values('RC','#nexttranno#',<cfif isdefined('form.refno2')><cfif form.refno2 neq ''>'#form.refno2#'<cfelse>'#getheader.refno2#'</cfif><cfelse>'#getheader.refno2#'</cfif>,'#getheader.custno#','#readperiod#','#ndatenow#',
			'#getheader.desp#','#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#val(net)#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#','#getheader.term#','#getheader.van#',
			<cfif getheader.pono neq ''>'#getheader.pono#'<cfelse>'#updatepono#'</cfif>,'#getheader.dono#','#getheader.quono#','#getheader.sono#','#getheader.rem0#','#getheader.rem1#', '#getheader.rem2#','#getheader.rem3#',
			'#getheader.rem4#','#getheader.rem5#',
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			'#getheader.rem11#', '#getheader.rem12#','#getheader.frem0#', '#getheader.frem1#', '#getheader.frem2#', '#getheader.frem3#', '#getheader.frem4#',
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
			</cfif>,'#getheader.taxincl#')
		</cfquery>
        
       
        
        <!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
		<cfelseif url.t1 eq "SO">
	  	<cfset type = gettranname.lSO>
		
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
        
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
		</cfif>
		<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>

		<cfset j = 1>

		<cfloop from="1" to="#cnt#" index="i" step="+3">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

			  	<cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>SO No. : #listgetat(mylist,i,";")# <br></cfoutput>
			<cfset xParam1 = listgetat(mylist,i,";")>

			<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
		  		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
		  		<cfset xParam2 = ''>
			<cfelse>
		  		<cfset xParam2 = listgetat(mylist,i+1,";")>
			</cfif>

			<cfset xParam3 = listgetat(mylist,i+2,";")>
			<cfif getgsetup.projectcompany eq 'Y' and isdefined('form.updatemat')>
            
            <cfquery datasource="#dts#" name="getbody">
		  		Select * from ictranmat where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and exported = "" <cfif getgsetup.updatetopo neq 'Y'>and toinv = ""</cfif> and type = 'SO'
			</cfquery>
            <cfelse>
			<cfquery datasource="#dts#" name="getbody">
		  		Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and exported = "" <cfif getgsetup.updatetopo neq 'Y'>and toinv = ""</cfif> and type = 'SO'
			</cfquery>
            </cfif>
			
			<cfquery name="getsupplier" datasource="#dts#">
				select a.custno,a.name,a.name2,a.add1,a.add2,a.add3,a.add4,a.fax,a.term,a.currcode,a.agent,a.area,a.attn,a.phone,a.phonea,(select #currperiod# from #target_currency# where currcode=a.currcode) as rate 
				from #target_apvend# as a 
				where a.custno='#form.supplier#';
			</cfquery>
			
			<cfset newcurrate = val(getsupplier.rate)>
			
			<cfloop query="getbody">
			  	<cfquery datasource="#dts#" name="getheader">
					Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SO'
			  	</cfquery>

				<!--- <cfif getheader.currcode eq ''>
					<cfquery name="getcurrcode" datasource="#dts#">
						select currcode from #ptype# where customerno = '#getheader.custno#'
					</cfquery>
					<cfset xCurrCode = getcurrcode.currcode>
			  	<cfelse>
					<cfset xCurrCode = getheader.currcode>
			  	</cfif>

		  		<cfquery name="currency" datasource="#dts#">
		 			select #currperiod# as rate from currencyrate where currcode = '#xCurrCode#'
		  		</cfquery>

				<cfif currency.rate neq "">
					<cfset newcurrate = currency.rate>
				<cfelse>
					<cfset newcurrate = 1>
		  		</cfif> --->

				<cfquery name="getItemcostDetails" datasource="#dts#">
				SELECT ucost,fcurrcode,fprice,fucost<cfloop from="2" to="10" index="zz">,fcurrcode#zz#,fprice#zz#,fucost#zz#</cfloop> from icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getbody.itemno)#">
				</cfquery>
                
                <cfset getbody.price_bil = val(getItemcostDetails.ucost)>
                
                	<cfif trim(getsupplier.currcode) neq "">
					<cfif getsupplier.currcode eq getItemcostDetails.fcurrcode>
                    <cfset getbody.price_bil=getItemcostDetails.fucost>
                    </cfif>
                    
                    <cfloop from="2" to="10" index="zz">
                    <cfif getsupplier.currcode eq evaluate('getItemcostDetails.fcurrcode#zz#')>
                    <cfset getbody.price_bil= evaluate('getItemcostDetails.fucost#zz#')>
                    </cfif>
                    </cfloop>
                	</cfif>

				<!--- Add On 061008, 2nd Unit Function --->
                <cfif hcomid eq "asiasoft_i">
                <cfset getbody.brem4 = val(getbody.price_bil)>
                <cfset getbody.price_bil = val(getbody.brem2)>
                <cfset getbody.dispec1 = 0>
                <cfset getbody.dispec2 = 0>
                <cfset getbody.dispec3 = 0>
				</cfif>
                <!---
				<cfif val(getbody.factor1) neq 0>
					<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
				<cfelse>
					<cfset getbody.price_bil = 0>
				</cfif>--->
                <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
                
                
				<cfset newamt1_bil = listgetat(form.fulfill,j) * getbody.price_bil>
		  		<cfset newdamt_bil1 = (getbody.dispec1 / 100) * newamt1_bil>
		  		<cfset netamt = newamt1_bil - newdamt_bil1>
	      		<cfset newdamt_bil2 = (getbody.dispec2 / 100) * netamt>
		  		<cfset netamt = netamt - newdamt_bil2>
		  		<cfset newdamt_bil3 = (getbody.dispec3 / 100) * netamt>
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
                
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>

		  		<!--- SO TO RC --->
		  		<cfquery datasource="#dts#" name="insertictran">
					Insert into ictran 
					(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
					`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
					`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
					`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,`PACKING`,`NOTE1`,
					`NOTE2`,`GLTRADAC`,`UPDCOST`,`GST_ITEM`,`TOTALUP`,`WITHSN`,`GRADE`,`PUR_PRICE`,
					`QTY_RET`,`TEMPFIGI`,`SERCOST`,`M_CHARGE1`,`M_CHARGE2`,`ADTCOST1`,`ADTCOST2`,`IT_COS`,`AV_COST`,
					`BATCHCODE`,`EXPDATE`,`POINT`,`INV_DISC`,`INV_TAX`,`SUPP`,`EDI_COU1`,`WRITEOFF`,`TOSHIP`,`SHIPPED`,`NAME`,`DEL_BY`,
					`VAN`,`GENERATED`,`UD_QTY`,`TOINV`,`EXPORTED`,`EXPORTED1`,`EXPORTED2`,`EXPORTED3`,`BRK_TO`,`SV_PART`,`LAST_YEAR`,
					`VOID`,`SONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`TEMP`,`TEMP1`,
					`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,`TABLENO`,`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,
					`NODISPLAY`,`TITLE_ID`,`TITLE_DESP`,<cfif lcase(hcomid) eq "topsteel_i">`TITLE_DESPA`,</cfif>
					`COMMENT`,`DEFECTIVE`,`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,
					`MC6_BIL`,`MC7_BIL`<cfif lcase(hcomid) eq "fdipx_i">,`JobOrderNo`</cfif>,`taxincl`,`note_a`)
					values ('RC', '#nexttranno#', '#getbody.refno2#', '#j#', '#getsupplier.custno#', '#readperiod#',
					'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,
					'#getsupplier.agent#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">, '#getbody.source#', '#getbody.job#', '', '#listgetat(form.fulfill,j)#',
                    <cfif hcomid eq "asiasoft_i">
                    '#getbody.price_bil#', '#unit#', '#newamt1_bil#', '0', '0', '0',
					'0','#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#', '#newtaxamt_bil#', '',
					'#listgetat(form.fulfill,j)#', '#newprice#',
					'#unit#', '#newamt1#', '0', '#newamt#', '#newtaxamt#', '1', '1', '#listgetat(mylist,i,";")#',
					#getbody.wos_date#,
                    <cfelse>
					'0', '#unit_bil#', '0', '0', '0', '0',
					'0','0', '0','0', '0', '0', '',
					'#fulfillactual#', '0',
					'#unit#', '0', '0', '0', '0', '1', '1', '#listgetat(mylist,i,";")#',
					#getbody.wos_date#,</cfif>	'0000-00-00', '#brem1#', '#brem2#', '#brem3#', '#brem4#', '#getbody.packing#', '#getbody.note1#',
					'#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N', '', '#getbody.grade#', '0.00',
					'0.00', '0', '0','#getbody.m_charge1#','#getbody.m_charge2#','#getbody.adtcost1#','#getbody.adtcost2#','0','0','#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '',
					'0', '0', '0',	'#name#', '0', '0', 'Y', '', '', '', '0000-00-00', '', '0000-00-00', '', '', '', '',
					'#listgetat(mylist,i,";")#','#getbody.mc1_bil#','#getbody.mc2_bil#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">, '0', '', '#getbody.wos_group#', '#getbody.category#',
					'#getsupplier.area#', '#Shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#', '0',
					'#member#', '', #Now()#, 'Time', '#BOMNO#',
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
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getbody.comment)#">,'#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					<cfelseif SingleQ eq '' and DoubleQ eq 'Y'>
						<!--- Found " in the comment --->
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getbody.comment)#">,'#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					<cfelseif SingleQ eq '' and DoubleQ eq ''>
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getbody.comment)#">,'#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					<cfelse>
						'','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					</cfif>
		  		</cfquery>
				
                <!--- UPDATE UNIT COST --->
				<cfinclude template = "update_unit_cost_process.cfm">
				<!--- UPDATE UNIT COST --->
				
				<cfif getbody.batchcode neq "">
					<cfif getbody.location neq "">
						<cfquery name="updateobbatch" datasource="#dts#">
							update lobthob set bth_qin=(bth_qin+'#fulfillactual#'),rc_type = 'RC', rc_refno = '#nexttranno#', rc_expdate = #getbody.expdate#
							where location='#getbody.location#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
						<cfquery name="updateobbatch" datasource="#dts#">
							update obbatch set bth_qin=(bth_qin+'#fulfillactual#'),rc_type = 'RC', rc_refno = '#nexttranno#', rc_expdate = #getbody.expdate#
							where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
					<cfelse>
						<cftry>
						<cfquery name="updateobbatch" datasource="#dts#">
							update obbatch set bth_qin=(bth_qin+'#fulfillactual#'),rc_type = 'RC', rc_refno = '#nexttranno#', rc_expdate = #getbody.expdate#
							where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
						<cfcatch type="database"></cfcatch>
						</cftry>
					</cfif>
				</cfif>
                
				<cfquery name="inserticlink" datasource="#dts#">
					insert into iclink values ('RC','#nexttranno#','#j#',
					'#ndatenow#','SO','#listgetat(mylist,i,";")#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#val(listgetat(form.fulfill,j))#')
				</cfquery>
                
                <cfset qname='QIN'&(readperiod+10)><cfoutput>#qname#--#getbody.qty#</cfoutput>

				<cfquery name="UpdateIcitem" datasource="#dts#">
					update icitem set #qname#=(#qname#+#fulfillactual#) where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
				</cfquery>
				
				<!--- Start: Add on 051008, graded item --->
				<!--- <cfif Evaluate("form.grdcolumnlist_SO_#xparam1#_#xParam3#") neq ""> --->
				<cfif form["grdcolumnlist_SO_#xparam1#_#xParam3#"] neq "">
					<!--- <cfset grdcolumnlist = Evaluate("form.grdcolumnlist_SO_#xparam1#_#xParam3#")>
					<cfset bgrdcolumnlist = Evaluate("form.bgrdcolumnlist_SO_#xparam1#_#xParam3#")>
					<cfset grdvaluelist = Evaluate("form.grdvaluelist_SO_#xparam1#_#xParam3#")>
					<cfset totalrecord = Evaluate("form.totalrecord_SO_#xparam1#_#xParam3#")> --->
					<cfset grdcolumnlist = form["grdcolumnlist_SO_#xparam1#_#xParam3#"]>
					<cfset bgrdcolumnlist = form["bgrdcolumnlist_SO_#xparam1#_#xParam3#"]>
					<cfset grdvaluelist = form["grdvaluelist_SO_#xparam1#_#xParam3#"]>
					<cfset totalrecord = form["totalrecord_SO_#xparam1#_#xParam3#"]>
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
						('RC', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">,'#ndatenow#','#readperiod#','1','','#getbody.location#','','',
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
								#myArray3[k]# = #myArray3[k]#+#myArray2[k]#,
							<cfelse>
								#myArray3[k]# = #myArray3[k]#+#myArray2[k]#
							</cfif>
						</cfloop>
						where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
					</cfquery>
				
					<cfquery name="updatelogrdob" datasource="#dts#">
						update logrdob
						set
						<cfloop from="1" to="#totalrecord#" index="k">
							<cfif k neq totalrecord>
								#myArray3[k]# = #myArray3[k]#+#myArray2[k]#,
							<cfelse>
								#myArray3[k]# = #myArray3[k]#+#myArray2[k]#
							</cfif>
						</cfloop>
						where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
						and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
					</cfquery>
			
				</cfif>
				<!--- End: Add on 051008, graded item --->
				
			</cfloop>

			<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
            <cfif getgsetup.projectcompany eq 'Y' and isdefined('form.updatemat')>
            <cfquery datasource="#dts#" name="updateartran">
					Update ictranmat set exported = '#nexttranno#', exported1 = '#ndatenow#'
					where refno	= '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#">
					and exported = '' and type = 'SO' and trancode = '#xparam3#'
				</cfquery>
            <cfelse>
				<cfquery datasource="#dts#" name="updateartran">
					Update ictran set exported = '#nexttranno#', exported1 = '#ndatenow#'
					where refno	= '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#">
					and exported = '' and type = 'SO' and trancode = '#xparam3#'
				</cfquery>
				</cfif>
				<!--- Step 2:--->
				<!--- Add on 051008, For Graded Item --->
				<cfquery datasource="#dts#" name="updateigrade">
					Update igrade i, ictran ic 
					set i.exported = '#nexttranno#'
					where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
					and i.refno = '#xparam1#' and i.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and i.trancode = '#xparam3#'
					and ic.exported = '' and i.type = 'SO'
				</cfquery>
			</cfif>

			<cfset j = j + 1>
			<cfif getgsetup.projectcompany eq 'Y' and isdefined('form.updatemat')>
            <cfquery name="getictran" datasource="#dts#">
				select refno from ictranmat where refno = '#listgetat(mylist,i,";")#'
				and exported = '' and type = 'SO'
			</cfquery>
            <cfelse>
			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#'
				and exported = '' and type = 'SO'
			</cfquery>
			</cfif>
			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set exported = '#nexttranno#' where refno = '#listgetat(mylist,i,";")#'
					and type = 'SO'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lSO# no: ,#listgetat(mylist,i,";")#,#listgetat(mylist,i+1,";")# is successfully updated to #gettranname.lPO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
	 	</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SO'
		</cfquery>

		<!--- <cfif getheader.currcode eq ''>
			<cfquery name="getcurrcode" datasource="#dts#">
				select currcode from #ptype# where customerno = '#getheader.custno#'
			</cfquery>
			<cfset xCurrCode = getcurrcode.currcode>
		<cfelse>
			<cfset xCurrCode = getheader.currcode>
		</cfif>

	  	<cfquery name="currency" datasource="#dts#">
	 		select #currperiod# as rate from currencyrate where currcode = '#xCurrCode#'
	  	</cfquery>

		<cfif currency.rate neq "">
			<cfset newcurrate = currency.rate>
		<cfelse>
			<cfset newcurrate = 1>
	  	</cfif> --->

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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
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
		
	  	<!--- Create a new transaction --->
		<!--- SO TO RC --->
	  	<!--- REMARK ON 04-05-2009 & REPLACE WITH THE BELOW ONE --->
	  	<!--- <cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,
		  	currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,
		  	tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax2,
		  	tax3,tax,taxp1,taxp2,taxp3,grand,note,term,van,pono,dono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
		  	rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,trdatetime,userid,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on)

		  	values('PO','#nexttranno#','#getheader.refno2#','#getsupplier.custno#','#readperiod#','#ndatenow#',
			'#getheader.desp#','#getheader.despa#','#getsupplier.agent#','#getsupplier.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#','#getsupplier.term#','#getheader.van#',
			'#updatepono#','#getheader.dono#','Profile','Profile', '#getsupplier.attn#','#getsupplier.attn#',
			'#getsupplier.phone#','#getheader.rem5#',
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			'#getheader.rem11#', '#getsupplier.phone#','#getsupplier.name#', '#getsupplier.name2#', '#getsupplier.add1#', '#getsupplier.add2#', '#getsupplier.add3#',
			'#getsupplier.add4#', '#getsupplier.fax#', '#getsupplier.name#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getheader.comm0#', '#getheader.comm1#', '#getheader.comm2#', '#getheader.comm3#', '#getheader.comm4#',
			'#getsupplier.name#',#Now()#, '#HUserID#','#getsupplier.currcode#',
			'#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#',
			'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#','#getheader.special_account_code#',
			'#HUserID#',#now()#,'#HUserID#',#now()#)
	  	</cfquery> --->
	  	<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,
		  	currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,
		  	tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax2,
		  	tax3,tax,taxp1,taxp2,taxp3,grand,note,term,van,pono,dono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
		  	rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
		  	trdatetime,userid,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on,taxincl,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49)

		  	values('RC','#nexttranno#','#getheader.refno2#','#getsupplier.custno#','#readperiod#','#ndatenow#',
			'#getheader.desp#','#getheader.despa#','#getsupplier.agent#','#getsupplier.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#','#getsupplier.term#','#getheader.van#',
			'#updatepono#','#getheader.dono#','#getheader.quono#','Profile','Profile', '#getsupplier.attn#','#getsupplier.attn#',
			'#getsupplier.phone#','#getheader.rem5#',
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			'#getheader.rem11#', '#getsupplier.phone#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getsupplier.name#">, '#getsupplier.name2#', '#getsupplier.add1#', '#getsupplier.add2#', '#getsupplier.add3#',
			'#getsupplier.add4#', '#getsupplier.fax#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getsupplier.name#">, '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getsupplier.add1#', '#getsupplier.add2#', '#getsupplier.add3#', '#getsupplier.add4#', '#getsupplier.fax#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getsupplier.name#">,'#getsupplier.phonea#',
			#Now()#, '#HUserID#','#getsupplier.currcode#',
			'#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#',
			'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#','#getheader.special_account_code#',
			'#HUserID#',#now()#,'#HUserID#',#now()#,'#getheader.taxincl#'<cfif lcase(HcomID) eq "ascend_i">,'', '', '',''<cfelse>,'#getheader.rem30#', '#getheader.rem31#', '#getheader.rem32#', '#getheader.rem33#'</cfif>, '#getheader.rem34#', '#getheader.rem35#', '#getheader.rem36#', '#getheader.rem37#', '#getheader.rem38#', '#getheader.rem39#', '#getheader.rem40#', '#getheader.rem41#', '#getheader.rem42#', '#getheader.rem43#', '#getheader.rem44#', '#getheader.rem45#', '#getheader.rem46#', '#getheader.rem47#', '#getheader.rem48#', '#getheader.rem49#')
	  	</cfquery>

	</cfif>
<!--- t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ t2 = RQ --->
<cfelseif url.t2 eq "RQ">
	<h1>Update to <cfoutput>#gettranname.lRQ#</cfoutput></h1>
    <!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
	<cfif url.t1 eq "SO">
	  	<cfset type = gettranname.lSO>

	  	<!---cfquery datasource="#dts#" name="updategsetup">
	  		Update Gsetup set pono = UPPER("#nexttranno#")
	  	</cfquery--->
	  	<!--- <cfquery name="updategsetup" datasource="main">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where userDept = '#dts#'
			and type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
		
		<!--- <cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
        
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
		</cfif>
		<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>

		<cfset j = 1>

		<cfloop from="1" to="#cnt#" index="i" step="+3">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

			  	<cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>SO No. : #listgetat(mylist,i,";")# <br></cfoutput>
			<cfset xParam1 = listgetat(mylist,i,";")>

			<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
		  		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
		  		<cfset xParam2 = ''>
			<cfelse>
		  		<cfset xParam2 = listgetat(mylist,i+1,";")>
			</cfif>

			<cfset xParam3 = listgetat(mylist,i+2,";")>
			<cfif getgsetup.projectcompany eq 'Y' and isdefined('form.updatemat')>
            
            <cfquery datasource="#dts#" name="getbody">
		  		Select * from ictranmat where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and exported = "" <cfif getgsetup.updatetopo neq 'Y'>and toinv = ""</cfif> and type = 'SO'
			</cfquery>
            <cfelse>
			<cfquery datasource="#dts#" name="getbody">
		  		Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and exported = "" <cfif getgsetup.updatetopo neq 'Y'>and toinv = ""</cfif> and type = 'SO'
			</cfquery>
            </cfif>
			
			<cfquery name="getsupplier" datasource="#dts#">
				select a.custno,a.name,a.name2,a.add1,a.add2,a.add3,a.add4,a.fax,a.term,a.currcode,a.agent,a.area,a.attn,a.phone,a.phonea,(select #currperiod# from #target_currency# where currcode=a.currcode) as rate 
				from #target_apvend# as a 
				where a.custno='#form.supplier#';
			</cfquery>
            
			
			<cfset newcurrate = val(getsupplier.rate)>
			
			<cfloop query="getbody">
			  	<cfquery datasource="#dts#" name="getheader">
					Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SO'
			  	</cfquery>

				<!--- <cfif getheader.currcode eq ''>
					<cfquery name="getcurrcode" datasource="#dts#">
						select currcode from #ptype# where customerno = '#getheader.custno#'
					</cfquery>
					<cfset xCurrCode = getcurrcode.currcode>
			  	<cfelse>
					<cfset xCurrCode = getheader.currcode>
			  	</cfif>

		  		<cfquery name="currency" datasource="#dts#">
		 			select #currperiod# as rate from currencyrate where currcode = '#xCurrCode#'
		  		</cfquery>

				<cfif currency.rate neq "">
					<cfset newcurrate = currency.rate>
				<cfelse>
					<cfset newcurrate = 1>
		  		</cfif> --->

				<!--- Add On 061008, 2nd Unit Function --->
                <cfif hcomid eq "asiasoft_i">
                <cfset getbody.brem4 = val(getbody.price_bil)>
                <cfset getbody.price_bil = val(getbody.brem2)>
                <cfset getbody.dispec1 = 0>
                <cfset getbody.dispec2 = 0>
                <cfset getbody.dispec3 = 0>
				</cfif>
                
                <cfif hcomid eq "bnbm_i" or hcomid eq "bnbp_i">
                <cfset getbody.brem1 = val(getbody.price_bil)>
                </cfif>
                
                <!---<cfif hcomid eq "asiasoft_i">
				<cfif val(getbody.factor1) neq 0>
					<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
				<cfelse>
					<cfset getbody.price_bil = 0>
				</cfif>
                </cfif>--->
                <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
                
                <cfif lcase(hcomid) eq "unistat_i">
                <cfquery name="getItemcostDetails" datasource="#dts#">
				SELECT ucost,fcurrcode,fprice,fucost<cfloop from="2" to="10" index="zz">,fcurrcode#zz#,fprice#zz#,fucost#zz#</cfloop> from icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getbody.itemno)#">
				</cfquery>
                
                <cfset getbody.price_bil = val(getItemcostDetails.ucost)>
                
                	<cfif trim(getsupplier.currcode) neq "">
					<cfif getsupplier.currcode eq getItemcostDetails.fcurrcode>
                    <cfset getbody.price_bil=getItemcostDetails.fucost>
                    </cfif>
                    
                    <cfloop from="2" to="10" index="zz">
                    <cfif getsupplier.currcode eq evaluate('getItemcostDetails.fcurrcode#zz#')>
                    <cfset getbody.price_bil= evaluate('getItemcostDetails.fucost#zz#')>
                    </cfif>
                    </cfloop>
                	</cfif>
                
                <cfelse>
                <cfset getbody.price_bil = val(listgetat(form.itemcost,j))>
                </cfif>
                
                
				<cfset newamt1_bil = listgetat(form.fulfill,j) * getbody.price_bil>
		  		<cfset newdamt_bil1 = (getbody.dispec1 / 100) * newamt1_bil>
		  		<cfset netamt = newamt1_bil - newdamt_bil1>
	      		<cfset newdamt_bil2 = (getbody.dispec2 / 100) * netamt>
		  		<cfset netamt = netamt - newdamt_bil2>
		  		<cfset newdamt_bil3 = (getbody.dispec3 / 100) * netamt>
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
                
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>

		  		<!--- SO TO RQ --->
		  		<cfquery datasource="#dts#" name="insertictran">
					Insert into ictran 
					(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
					`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
					`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
					`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,`PACKING`,`NOTE1`,
					`NOTE2`,`GLTRADAC`,`UPDCOST`,`GST_ITEM`,`TOTALUP`,`WITHSN`,`GRADE`,`PUR_PRICE`,
					`QTY_RET`,`TEMPFIGI`,`SERCOST`,`M_CHARGE1`,`M_CHARGE2`,`ADTCOST1`,`ADTCOST2`,`IT_COS`,`AV_COST`,
					`BATCHCODE`,`EXPDATE`,`POINT`,`INV_DISC`,`INV_TAX`,`SUPP`,`EDI_COU1`,`WRITEOFF`,`TOSHIP`,`SHIPPED`,`NAME`,`DEL_BY`,
					`VAN`,`GENERATED`,`UD_QTY`,`TOINV`,`EXPORTED`,`EXPORTED1`,`EXPORTED2`,`EXPORTED3`,`BRK_TO`,`SV_PART`,`LAST_YEAR`,
					`VOID`,`SONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`TEMP`,`TEMP1`,
					`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,`TABLENO`,`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,
					`NODISPLAY`,`TITLE_ID`,`TITLE_DESP`,<cfif lcase(hcomid) eq "topsteel_i">`TITLE_DESPA`,</cfif>
					`COMMENT`,`DEFECTIVE`,`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,
					`MC6_BIL`,`MC7_BIL`<cfif lcase(hcomid) eq "fdipx_i">,`JobOrderNo`</cfif>,`taxincl`,`note_a`)
					values ('RQ', '#nexttranno#', '#getbody.refno2#', '#j#', '#getsupplier.custno#', '#readperiod#',
					'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,
					'#getsupplier.agent#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">, '#getbody.source#', '#getbody.job#', '', '#listgetat(form.fulfill,j)#',
                    <!---<cfif hcomid eq "asiasoft_i" or hcomid eq "bnbm_i" or hcomid eq "bnbp_i">--->
                    '#getbody.price_bil#', '#unit#', '#newamt1_bil#', '0', '0', '0',
					'0','#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#', '#newtaxamt_bil#', '',
					'#listgetat(form.fulfill,j)#', '#newprice#',
					'#unit#', '#newamt1#', '0', '#newamt#', '#newtaxamt#', '1', '1', '#listgetat(mylist,i,";")#',
					#getbody.wos_date#,
                    <!---<cfelse>
					'0', '#unit_bil#', '0', '0', '0', '0',
					'0','0', '0','0', '0', '0', '',
					'#fulfillactual#', '0',
					'#unit#', '0', '0', '0', '0', '#getbody.factor1#', '#getbody.factor2#', '#listgetat(mylist,i,";")#',
					#getbody.wos_date#,</cfif>--->	'0000-00-00', '#brem1#', '#brem2#', '#brem3#', '#brem4#', '#getbody.packing#', '#getbody.note1#',
					'#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N', '', '#getbody.grade#', '0.00',
					'0.00', '0', '0','#getbody.m_charge1#','#getbody.m_charge2#','#getbody.adtcost1#','#getbody.adtcost2#','0','0','#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '',
					'0', '0', '0',	'#name#', '0', '0', 'Y', '', '', '', '0000-00-00', '', '0000-00-00', '', '', '', '',
					'#listgetat(mylist,i,";")#','#getbody.mc1_bil#','#getbody.mc2_bil#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">, '0', '', '#getbody.wos_group#', '#getbody.category#',
					'#getsupplier.area#', '#Shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#', '0',
					'#member#', '', #Now()#, 'Time', '#BOMNO#',
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
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getbody.comment)#">,'#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					<cfelseif SingleQ eq '' and DoubleQ eq 'Y'>
						<!--- Found " in the comment --->
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getbody.comment)#">,'#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					<cfelseif SingleQ eq '' and DoubleQ eq ''>
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getbody.comment)#">,'#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					<cfelse>
						'','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					</cfif>
		  		</cfquery>

				<cfquery name="inserticlink" datasource="#dts#">
					insert into iclink values ('RQ','#nexttranno#','#j#',
					'#ndatenow#','SO','#listgetat(mylist,i,";")#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#val(listgetat(form.fulfill,j))#')
				</cfquery>
				
				<!--- Start: Add on 051008, graded item --->
				<!--- <cfif Evaluate("form.grdcolumnlist_SO_#xparam1#_#xParam3#") neq ""> --->
				<cfif form["grdcolumnlist_SO_#xparam1#_#xParam3#"] neq "">
					<!--- <cfset grdcolumnlist = Evaluate("form.grdcolumnlist_SO_#xparam1#_#xParam3#")>
					<cfset bgrdcolumnlist = Evaluate("form.bgrdcolumnlist_SO_#xparam1#_#xParam3#")>
					<cfset grdvaluelist = Evaluate("form.grdvaluelist_SO_#xparam1#_#xParam3#")>
					<cfset totalrecord = Evaluate("form.totalrecord_SO_#xparam1#_#xParam3#")> --->
					<cfset grdcolumnlist = form["grdcolumnlist_SO_#xparam1#_#xParam3#"]>
					<cfset bgrdcolumnlist = form["bgrdcolumnlist_SO_#xparam1#_#xParam3#"]>
					<cfset grdvaluelist = form["grdvaluelist_SO_#xparam1#_#xParam3#"]>
					<cfset totalrecord = form["totalrecord_SO_#xparam1#_#xParam3#"]>
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
						('RQ', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">,'#ndatenow#','#readperiod#','1','','#getbody.location#','','',
						'#getbody.custno#','','1', '1',
						<cfloop from="1" to="#totalrecord#" index="k">
							<cfif k neq totalrecord>
								#myArray2[k]#,
							<cfelse>
								#myArray2[k]#
							</cfif>
						</cfloop>)
					</cfquery>
			
				</cfif>
				<!--- End: Add on 051008, graded item --->
				
			</cfloop>

			<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
            <cfif getgsetup.projectcompany eq 'Y' and isdefined('form.updatemat')>
            <cfquery datasource="#dts#" name="updateartran">
					Update ictranmat set exported = '#nexttranno#', exported1 = '#ndatenow#'
					where refno	= '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#">
					and exported = '' and type = 'SO' and trancode = '#xparam3#'
				</cfquery>
            <cfelse>
				<cfquery datasource="#dts#" name="updateartran">
					Update ictran set exported = '#nexttranno#', exported1 = '#ndatenow#'
					where refno	= '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#">
					and exported = '' and type = 'SO' and trancode = '#xparam3#'
				</cfquery>
				</cfif>
				<!--- Step 2:--->
				<!--- Add on 051008, For Graded Item --->
				<cfquery datasource="#dts#" name="updateigrade">
					Update igrade i, ictran ic 
					set i.exported = '#nexttranno#'
					where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
					and i.refno = '#xparam1#' and i.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and i.trancode = '#xparam3#'
					and ic.exported = '' and i.type = 'SO'
				</cfquery>
			</cfif>

			<cfset j = j + 1>
			<cfif getgsetup.projectcompany eq 'Y' and isdefined('form.updatemat')>
            <cfquery name="getictran" datasource="#dts#">
				select refno from ictranmat where refno = '#listgetat(mylist,i,";")#'
				and exported = '' and type = 'SO'
			</cfquery>
            <cfelse>
			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#'
				and exported = '' and type = 'SO'
			</cfquery>
			</cfif>
			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set exported = '#nexttranno#' where refno = '#listgetat(mylist,i,";")#'
					and type = 'SO'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lSO# no: ,#listgetat(mylist,i,";")#,#listgetat(mylist,i+1,";")# is successfully updated to #gettranname.lRQ# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
	 	</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SO'
		</cfquery>
        
        <cfquery name="getcustomer" datasource="#dts#">
				select a.custno,a.name,a.name2,a.add1,a.add2,a.add3,a.add4,a.fax,a.term,a.currcode,a.agent,a.area,a.attn,a.phone,a.phonea,(select #currperiod# from #target_currency# where currcode=a.currcode) as rate 
				from #target_arcust# as a 
				where a.custno='#getheader.custno#';
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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
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
		  	tax3,tax,taxp1,taxp2,taxp3,grand,note,RQnote,RQtaxp1,term,van,pono,dono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
		  	rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
		  	trdatetime,userid,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on,taxincl,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49)

		  	values('RQ','#nexttranno#','#getheader.refno2#','#getsupplier.custno#','#readperiod#','#ndatenow#',
			'#getheader.desp#','#getheader.despa#','#getsupplier.agent#','#getsupplier.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','TX7','#getheader.note#','#numberformat(getheader.taxp1,".__")#','#getsupplier.term#','#getheader.van#',
			'#updatepono#','#getheader.dono#','#getheader.quono#','Profile','', '#getsupplier.attn#','#getsupplier.attn#',
			'#getsupplier.phone#','#getheader.custno#',
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			'#getheader.rem11#', '#getsupplier.phone#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getsupplier.name#">, '#getsupplier.name2#', '#getsupplier.add1#', '#getsupplier.add2#', '#getsupplier.add3#',
			'#getsupplier.add4#', '#getsupplier.fax#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustomer.name#">, '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getcustomer.add1#', '#getcustomer.add2#', '#getcustomer.add3#', '#getcustomer.add4#', '#getcustomer.fax#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getsupplier.name#">,'#getcustomer.phonea#',
			#Now()#, '#HUserID#','#getsupplier.currcode#',
			'#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#',
			'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#','#getheader.special_account_code#',
			'#HUserID#',#now()#,'#HUserID#',#now()#,'#getheader.taxincl#'<cfif lcase(HcomID) eq "ascend_i">,'', '', '',''<cfelse>,'#getheader.rem30#', '#getheader.rem31#', '#getheader.rem32#', '#getheader.rem33#'</cfif>, '#getheader.rem34#', '#getheader.rem35#', '#getheader.rem36#', '#getheader.rem37#', '#getheader.rem38#', '#getheader.rem39#', '#getheader.rem40#', '#getheader.rem41#', '#getheader.rem42#', '#getheader.rem43#', '#getheader.rem44#', '#getheader.rem45#', '#getheader.rem46#', '#getheader.rem47#', '#getheader.rem48#', '#getheader.rem49#')
	  	</cfquery>
        
       </cfif>
    
    
<!--- t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO t2 = PO --->
<cfelseif url.t2 eq "PO">
	<h1>Update to <cfoutput>#gettranname.lPO#</cfoutput></h1>
	<!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
	<cfif url.t1 eq "SO">
	  	<cfset type = gettranname.lSO>

	  	<!---cfquery datasource="#dts#" name="updategsetup">
	  		Update Gsetup set pono = UPPER("#nexttranno#")
	  	</cfquery--->
	  	<!--- <cfquery name="updategsetup" datasource="main">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where userDept = '#dts#'
			and type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
		
		<!--- <cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
		</cfif>
		<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>

		<cfset j = 1>

		<cfloop from="1" to="#cnt#" index="i" step="+3">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

			  	<cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>SO No. : #listgetat(mylist,i,";")# <br></cfoutput>
			<cfset xParam1 = listgetat(mylist,i,";")>

			<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
		  		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
		  		<cfset xParam2 = ''>
			<cfelse>
		  		<cfset xParam2 = listgetat(mylist,i+1,";")>
			</cfif>

			<cfset xParam3 = listgetat(mylist,i+2,";")>
			<cfif getgsetup.projectcompany eq 'Y' and isdefined('form.updatemat')>
            
            <cfquery datasource="#dts#" name="getbody">
		  		Select * from ictranmat where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and exported = "" <cfif getgsetup.updatetopo neq 'Y'>and toinv = ""</cfif> and type = 'SO'
			</cfquery>
            <cfelse>
			<cfquery datasource="#dts#" name="getbody">
		  		Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and exported = "" <cfif getgsetup.updatetopo neq 'Y'>and toinv = ""</cfif> and type = 'SO'
			</cfquery>
            </cfif>
			
			<cfquery name="getsupplier" datasource="#dts#">
				select a.ngst_cust,a.taxcode,a.custno,a.name,a.name2,a.add1,a.add2,a.add3,a.add4,a.fax,a.term,a.currcode,a.agent,a.area,a.attn,a.phone,a.phonea,(select #currperiod# from #target_currency# where currcode=a.currcode) as rate 
				from #target_apvend# as a 
				where a.custno='#form.supplier#';
			</cfquery>
			
			<cfset newcurrate = val(getsupplier.rate)>
			
            <cfloop from='1' to="18" index="m">
    
			<cfif readperiod eq numberformat(m,'00')>
            
            <cfquery name="getdaycurrency" datasource="#dts#">
            select * 
            from #target_currencymonth# 
            where currcode='#getsupplier.currcode#' and fperiod='#numberformat(m,'00')#'
            </cfquery>
            <cfif getdaycurrency.recordcount neq 0>
                <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
            <cfelse>
            </cfif>
            </cfif>
            
            </cfloop>
            
			<cfloop query="getbody">
			  	<cfquery datasource="#dts#" name="getheader">
					Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SO'
			  	</cfquery>

				<!--- <cfif getheader.currcode eq ''>
					<cfquery name="getcurrcode" datasource="#dts#">
						select currcode from #ptype# where customerno = '#getheader.custno#'
					</cfquery>
					<cfset xCurrCode = getcurrcode.currcode>
			  	<cfelse>
					<cfset xCurrCode = getheader.currcode>
			  	</cfif>

		  		<cfquery name="currency" datasource="#dts#">
		 			select #currperiod# as rate from currencyrate where currcode = '#xCurrCode#'
		  		</cfquery>

				<cfif currency.rate neq "">
					<cfset newcurrate = currency.rate>
				<cfelse>
					<cfset newcurrate = 1>
		  		</cfif> --->

				<!--- Add On 061008, 2nd Unit Function --->
                
                <cfquery name="getItemcostDetails" datasource="#dts#">
				SELECT ucost,fcurrcode,fprice,fucost<cfloop from="2" to="10" index="zz">,fcurrcode#zz#,fprice#zz#,fucost#zz#</cfloop> from icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getbody.itemno)#">
				</cfquery>
                
                <cfset unitcost_bil = val(getItemcostDetails.ucost)>
                
                	<cfif trim(getsupplier.currcode) neq "">
					<cfif getsupplier.currcode eq getItemcostDetails.fcurrcode>
                    <cfset unitcost_bil=getItemcostDetails.fucost>
                    </cfif>
                    
                    <cfloop from="2" to="10" index="zz">
                    <cfif getsupplier.currcode eq evaluate('getItemcostDetails.fcurrcode#zz#')>
                    <cfset unitcost_bil= evaluate('getItemcostDetails.fucost#zz#')>
                    </cfif>
                    </cfloop>
                	</cfif>
                
                
                <cfif getgsetup.itempriceprior eq "2">
                <cfquery name="getcustomerprice" datasource="#dts#">
                select * from icl3p where itemno='#getbody.itemno#' and custno='#getsupplier.custno#'
                </cfquery>
                <cfif getcustomerprice.recordcount neq 0>
                <cfset unitcost_bil = val(getcustomerprice.price)>
                </cfif>
                </cfif>
                
                <cfset getbody.dispec1 = 0>
                <cfset getbody.dispec2 = 0>
                <cfset getbody.dispec3 = 0>
                <cfset getbody.taxpec1 = 0>
                <cfset getbody.note_a = trim(getgsetup.df_purchasetax)>
                <cfif getgsetup.wpitemtax eq 1>
                <cfif getsupplier.ngst_cust eq 'T'>
                <cfset getbody.taxpec1 = 0>
                <cfif trim(getsupplier.taxcode) neq ''>
                <cfset getbody.note_a = trim(getsupplier.taxcode)>
                <cfelse>
                <cfset getbody.note_a = trim(getgsetup.df_purchasetaxzero)>
                </cfif>
                <cfelse>
				<cfset getbody.taxpec1 = val(getgsetup.gst)>
                <cfset getbody.note_a = trim(getgsetup.df_purchasetax)>
                </cfif>
                </cfif>
                
                <cfset getbody.taxpec2 = 0>
                <cfset getbody.taxpec3 = 0>
                
                
                <cfif hcomid eq "asiasoft_i">
                <cfset getbody.brem4 = val(getbody.price_bil)>
                <cfset getbody.price_bil = val(getbody.brem2)>
                <cfset getbody.dispec1 = 0>
                <cfset getbody.dispec2 = 0>
                <cfset getbody.dispec3 = 0>
				</cfif>
                
                <cfif hcomid eq "ltm_i" or hcomid eq "demo_i">
                <cfset unitcost_bil = val(getbody.brem1)>
				</cfif>
                
				<!---<cfif val(getbody.factor1) neq 0>
					<cfset unitcost_bil = val(unitcost_bil) * val(getbody.factor2) / val(getbody.factor1)>
				<cfelse>
					<cfset unitcost_bil = 0>
				</cfif>--->
                <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
                
                
                
				<cfset newamt1_bil = listgetat(form.fulfill,j) * unitcost_bil>
		  		<cfset newdamt_bil1 = (getbody.dispec1 / 100) * newamt1_bil>
		  		<cfset netamt = newamt1_bil - newdamt_bil1>
	      		<cfset newdamt_bil2 = (getbody.dispec2 / 100) * netamt>
		  		<cfset netamt = netamt - newdamt_bil2>
		  		<cfset newdamt_bil3 = (getbody.dispec3 / 100) * netamt>
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
				<cfset newprice = unitcost_bil * newcurrate>
		  		<cfset newamt1 = newamt1_bil * newcurrate>
		  		<cfset newdamt = newdamt_bil * newcurrate>
		  		<cfset newtaxamt = newtaxamt_bil * newcurrate>
		  		<cfset newamt = newamt_bil * newcurrate>
		  		<cfset newamt = numberformat(newamt,".__")>
		  		<cfset gross_bil = gross_bil + newamt_bil>
		  		<cfset gross = gross_bil * newcurrate>
                
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>

		  		<!--- SO TO PO --->
		  		<cfquery datasource="#dts#" name="insertictran">
					Insert into ictran 
					(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
					`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
					`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
					`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,`PACKING`,`NOTE1`,
					`NOTE2`,`GLTRADAC`,`UPDCOST`,`GST_ITEM`,`TOTALUP`,`WITHSN`,`GRADE`,`PUR_PRICE`,
					`QTY_RET`,`TEMPFIGI`,`SERCOST`,`M_CHARGE1`,`M_CHARGE2`,`ADTCOST1`,`ADTCOST2`,`IT_COS`,`AV_COST`,
					`BATCHCODE`,`EXPDATE`,`POINT`,`INV_DISC`,`INV_TAX`,`SUPP`,`EDI_COU1`,`WRITEOFF`,`TOSHIP`,`SHIPPED`,`NAME`,`DEL_BY`,
					`VAN`,`GENERATED`,`UD_QTY`,`TOINV`,`EXPORTED`,`EXPORTED1`,`EXPORTED2`,`EXPORTED3`,`BRK_TO`,`SV_PART`,`LAST_YEAR`,
					`VOID`,`SONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`TEMP`,`TEMP1`,
					`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,`TABLENO`,`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,
					`NODISPLAY`,`TITLE_ID`,`TITLE_DESP`,<cfif lcase(hcomid) eq "topsteel_i">`TITLE_DESPA`,</cfif>
					`COMMENT`,`DEFECTIVE`,`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,
					`MC6_BIL`,`MC7_BIL`<cfif lcase(hcomid) eq "fdipx_i">,`JobOrderNo`</cfif>,`taxincl`,`note_a`)
					values ('PO', '#nexttranno#', '#getbody.refno2#', '#j#', '#getsupplier.custno#', '#readperiod#',
					'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,
					<cfif lcase(hcomid) eq "ltm_i" or lcase(hcomid) eq "matercare_i" or lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "netsource_i" or lcase(hcomid) eq "kjctrial_i">'#getbody.agenno#'<cfelse>'#getsupplier.agent#'</cfif>, <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">, '#getbody.source#', '#getbody.job#', '', '#listgetat(form.fulfill,j)#',
                    <!---<cfif hcomid eq "asiasoft_i" or hcomid eq "ltm_i" or hcomid eq "demo_i">--->
                    '#unitcost_bil#', '#getbody.unit_bil#', '#newamt1_bil#', '0', '0', '0',
					'0','#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#', '#newtaxamt_bil#', '',
					'#fulfillactual#', '#newprice#',
					'#unit#', '#newamt1#', '0', '#newamt#', '#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#', '#listgetat(mylist,i,";")#',
					#getbody.wos_date#,
                    <!---<cfelse>
					'0', '#unit#', '0', '0', '0', '0',
					'0','0', '0','0', '0', '0', '',
					'#listgetat(form.fulfill,j)#', '0',
					'#unit#', '0', '0', '0', '0', '1', '1', '#listgetat(mylist,i,";")#',
					#getbody.wos_date#,</cfif>
                    --->
                    '0000-00-00', '#brem1#', '#brem2#', '#brem3#', '#brem4#', '#getbody.packing#', '#getbody.note1#',
					'#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N', '', '#getbody.grade#', '0.00',
					'0.00', '0', '0','#getbody.m_charge1#','#getbody.m_charge2#','#getbody.adtcost1#','#getbody.adtcost2#','0','0','#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '',
					'0', '0', '0',	'#name#', '0', '0', 'Y', '', '', '', '0000-00-00', '', '0000-00-00', '', '', '', '',
					'#listgetat(mylist,i,";")#','#getbody.mc1_bil#','#getbody.mc2_bil#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">, '0', '', '#getbody.wos_group#', '#getbody.category#',
					'#getsupplier.area#', '#Shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#', '0',
					'#member#', '', #Now()#, 'Time', '#BOMNO#',
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
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getbody.comment)#">,'#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					<cfelseif SingleQ eq '' and DoubleQ eq 'Y'>
						<!--- Found " in the comment --->
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getbody.comment)#">,'#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					<cfelseif SingleQ eq '' and DoubleQ eq ''>
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getbody.comment)#">,'#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					<cfelse>
						'','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					</cfif>
		  		</cfquery>

				<cfquery name="inserticlink" datasource="#dts#">
					insert into iclink values ('PO','#nexttranno#','#j#',
					'#ndatenow#','SO','#listgetat(mylist,i,";")#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#val(listgetat(form.fulfill,j))#')
				</cfquery>
				
				<!--- Start: Add on 051008, graded item --->
				<!--- <cfif Evaluate("form.grdcolumnlist_SO_#xparam1#_#xParam3#") neq ""> --->
				<cfif form["grdcolumnlist_SO_#xparam1#_#xParam3#"] neq "">
					<!--- <cfset grdcolumnlist = Evaluate("form.grdcolumnlist_SO_#xparam1#_#xParam3#")>
					<cfset bgrdcolumnlist = Evaluate("form.bgrdcolumnlist_SO_#xparam1#_#xParam3#")>
					<cfset grdvaluelist = Evaluate("form.grdvaluelist_SO_#xparam1#_#xParam3#")>
					<cfset totalrecord = Evaluate("form.totalrecord_SO_#xparam1#_#xParam3#")> --->
					<cfset grdcolumnlist = form["grdcolumnlist_SO_#xparam1#_#xParam3#"]>
					<cfset bgrdcolumnlist = form["bgrdcolumnlist_SO_#xparam1#_#xParam3#"]>
					<cfset grdvaluelist = form["grdvaluelist_SO_#xparam1#_#xParam3#"]>
					<cfset totalrecord = form["totalrecord_SO_#xparam1#_#xParam3#"]>
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
						('PO', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">,'#ndatenow#','#readperiod#','1','','#getbody.location#','','',
						'#getbody.custno#','','1', '1',
						<cfloop from="1" to="#totalrecord#" index="k">
							<cfif k neq totalrecord>
								#myArray2[k]#,
							<cfelse>
								#myArray2[k]#
							</cfif>
						</cfloop>)
					</cfquery>
			
				</cfif>
				<!--- End: Add on 051008, graded item --->
				
			</cfloop>

			<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
            <cfif getgsetup.projectcompany eq 'Y' and isdefined('form.updatemat')>
            <cfquery datasource="#dts#" name="updateartran">
					Update ictranmat set exported = '#nexttranno#', exported1 = '#ndatenow#'
					where refno	= '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#">
					and exported = '' and type = 'SO' and trancode = '#xparam3#'
				</cfquery>
            <cfelse>
				<cfquery datasource="#dts#" name="updateartran">
					Update ictran set exported = '#nexttranno#', exported1 = '#ndatenow#'
					where refno	= '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#">
					and exported = '' and type = 'SO' and trancode = '#xparam3#'
				</cfquery>
				</cfif>
				<!--- Step 2:--->
				<!--- Add on 051008, For Graded Item --->
				<cfquery datasource="#dts#" name="updateigrade">
					Update igrade i, ictran ic 
					set i.exported = '#nexttranno#'
					where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
					and i.refno = '#xparam1#' and i.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and i.trancode = '#xparam3#'
					and ic.exported = '' and i.type = 'SO'
				</cfquery>
			</cfif>

			<cfset j = j + 1>
			<cfif getgsetup.projectcompany eq 'Y' and isdefined('form.updatemat')>
            <cfquery name="getictran" datasource="#dts#">
				select refno from ictranmat where refno = '#listgetat(mylist,i,";")#'
				and exported = '' and type = 'SO'
			</cfquery>
            <cfelse>
			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#'
				and exported = '' and type = 'SO'
			</cfquery>
			</cfif>
			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set exported = '#nexttranno#' where refno = '#listgetat(mylist,i,";")#'
					and type = 'SO'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lSO# no: ,#listgetat(mylist,i,";")#,#listgetat(mylist,i+1,";")# is successfully updated to #gettranname.lPO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
	 	</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SO'
		</cfquery>

        
        <cfset xdisp1 = 0>
        <cfset xdisp2 = 0>
        <cfset xdisp3 = 0>
        <cfset xtaxp1 = 0>
        
        <cfset getheader.note = trim(getgsetup.df_purchasetax)>
		<cfif getgsetup.wpitemtax eq "">
        <cfif getsupplier.ngst_cust eq 'T'>
        <cfset xtaxp1 = 0>
        <cfif trim(getsupplier.taxcode) neq ''>
        <cfset getheader.note = trim(getsupplier.taxcode)>
        <cfelse>
        <cfset getheader.note = trim(getgsetup.df_purchasetaxzero)>
        </cfif>
        <cfelse>
        <cfset xtaxp1 = val(getgsetup.gst)>
        <cfset getheader.note = trim(getgsetup.df_purchasetax)>
        </cfif>
        </cfif>
        
        

		<cfset disc1_bil = gross_bil * xdisp1/100>
		<cfset net1_bil = gross_bil - disc1_bil>
		<cfset disc2_bil = net1_bil * xdisp2/100>
		<cfset net1_bil = net1_bil - disc2_bil>
		<cfset disc3_bil = net1_bil * xdisp3/100>

		<cfif disc1_bil eq 0 and disc2_bil eq 0 and disc3_bil eq 0 and getheader.disc_bil neq 0>
			<cfset disc_bil = 0>
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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
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
		  	tax3,tax,taxp1,taxp2,taxp3,grand,note,term,van,<cfif lcase(hcomid) eq "asaiki_i">pono<cfelse>sono</cfif>,dono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
		  	rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
		  	trdatetime,userid,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on,taxincl,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49)

		  	values('PO','#nexttranno#','#getheader.refno2#','#getsupplier.custno#','#readperiod#','#ndatenow#',
			'#getheader.desp#','#getheader.despa#',<cfif lcase(hcomid) eq "ltm_i" or lcase(hcomid) eq "matercare_i" or lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "netsource_i" or lcase(hcomid) eq "kjctrial_i">'#getheader.agenno#'<cfelse>'#getsupplier.agent#'</cfif>,'#getsupplier.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'0','0','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','0','0','#numberformat(tax,".__")#','#xtaxp1#','0',
			'0','#grand#','#getheader.note#','#getsupplier.term#','#getheader.van#',
			'#updatepono#','#getheader.dono#','#getheader.quono#','Profile','Profile', '#getsupplier.attn#','#getsupplier.attn#',
			'#getsupplier.phone#','#getheader.rem5#',
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			'#getheader.rem11#', '#getsupplier.phone#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getsupplier.name#">, '#getsupplier.name2#', '#getsupplier.add1#', '#getsupplier.add2#', '#getsupplier.add3#',
			'#getsupplier.add4#', '#getsupplier.fax#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getsupplier.name#">, '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getsupplier.add1#', '#getsupplier.add2#', '#getsupplier.add3#', '#getsupplier.add4#', '#getsupplier.fax#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getsupplier.name#">,'#getsupplier.phonea#',
			#Now()#, '#HUserID#','#getsupplier.currcode#',
			'0','0','0','0','0','0','0',
			'0','0','0','0','0','0','0','#getheader.special_account_code#',
			'#HUserID#',#now()#,'#HUserID#',#now()#,'#getheader.taxincl#'<cfif lcase(HcomID) eq "ascend_i">,'', '', '',''<cfelse>,'#getheader.rem30#', '#getheader.rem31#', '#getheader.rem32#', '#getheader.rem33#'</cfif>, '#getheader.rem34#', '#getheader.rem35#', '#getheader.rem36#', '#getheader.rem37#', '#getheader.rem38#', '#getheader.rem39#', '#getheader.rem40#', '#getheader.rem41#', '#getheader.rem42#', '#getheader.rem43#', '#getheader.rem44#', '#getheader.rem45#', '#getheader.rem46#', '#getheader.rem47#', '#getheader.rem48#', '#getheader.rem49#')
	  	</cfquery>
        
        <cfif hcomid eq "asiasoft_i">
		<cfif getheader.rem31 eq "">
        <cfajaximport tags="cfform">
<cfajaximport tags="cfwindow,cflayout-tab"> 
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
        <cfwindow x="10" y="10" modal="true"  width="1100" height="600" name="createCustomer" refreshOnShow="true"
        title="Add New Customer" initshow="true"
        source="/default/maintenance/createCustomerAjax.cfm?id=#getheader.rem30#" />
		</cfif>
		</cfif>
	<!--- t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO --->
	<cfelseif url.t1 eq "QUO">
	  	<cfset type = gettranname.lQUO>
	  	
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
		</cfif>
        
		<cfset mylist= listchangedelims(checkbox,"",",")>
	  	<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>

		<cfset j = 1>

		<cfloop from="1" to="#cnt#" index="i" step="+3">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

			  	<cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>QUO No. : #listgetat(mylist,i,";")# <br></cfoutput>
			<cfset xParam1 = listgetat(mylist,i,";")>

			<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
		  		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
		  		<cfset xParam2 = ''>
			<cfelse>
		  		<cfset xParam2 = listgetat(mylist,i+1,";")>
			</cfif>

			<cfset xParam3 = listgetat(mylist,i+2,";")>

			<cfquery datasource="#dts#" name="getbody">
		  		Select * from ictran 
		  		where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and exported = "" <cfif getgsetup.updatetopo neq 'Y'>and toinv = ""</cfif> and type = 'QUO'
			</cfquery>
			
			<cfquery name="getsupplier" datasource="#dts#">
				select a.custno,a.name,a.name2,a.add1,a.add2,a.add3,a.add4,a.fax,a.term,a.currcode,a.agent,a.area,a.attn,a.phone,a.phonea,(select #currperiod# from #target_currency# where currcode=a.currcode) as rate 
				from #target_apvend# as a 
				where a.custno='#form.supplier#';
			</cfquery>
			
			<cfset newcurrate = val(getsupplier.rate)>
			
			<cfloop query="getbody">
			  	<cfquery datasource="#dts#" name="getheader">
					Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
			  	</cfquery>
			  	
				<!---<cfif val(getbody.factor1) neq 0>
					<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
				<cfelse>
					<cfset getbody.price_bil = 0>
				</cfif>--->
                
                <cfquery name="getItemcostDetails" datasource="#dts#">
				SELECT ucost,fcurrcode,fprice,fucost<cfloop from="2" to="10" index="zz">,fcurrcode#zz#,fprice#zz#,fucost#zz#</cfloop> from icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getbody.itemno)#">
				</cfquery>
                
                <cfset getbody.price_bil = val(getItemcostDetails.ucost)>
                
                	<cfif trim(getsupplier.currcode) neq "">
					<cfif getsupplier.currcode eq getItemcostDetails.fcurrcode>
                    <cfset getbody.price_bil=getItemcostDetails.fucost>
                    </cfif>
                    
                    <cfloop from="2" to="10" index="zz">
                    <cfif getsupplier.currcode eq evaluate('getItemcostDetails.fcurrcode#zz#')>
                    <cfset getbody.price_bil= evaluate('getItemcostDetails.fucost#zz#')>
                    </cfif>
                    </cfloop>
                	</cfif>
                
                <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
                
                
				<cfset newamt1_bil = listgetat(form.fulfill,j) * getbody.price_bil>
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
                
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>

		  		<!--- QUO TO PO --->
		  		<cfquery datasource="#dts#" name="insertictran">
					Insert into ictran 
					(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
					`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
					`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
					`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`QUONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,`PACKING`,`NOTE1`,
					`NOTE2`,`GLTRADAC`,`UPDCOST`,`GST_ITEM`,`TOTALUP`,`WITHSN`,`GRADE`,`PUR_PRICE`,
					`QTY_RET`,`TEMPFIGI`,`SERCOST`,`M_CHARGE1`,`M_CHARGE2`,`ADTCOST1`,`ADTCOST2`,`IT_COS`,`AV_COST`,
					`BATCHCODE`,`EXPDATE`,`POINT`,`INV_DISC`,`INV_TAX`,`SUPP`,`EDI_COU1`,`WRITEOFF`,`TOSHIP`,`SHIPPED`,`NAME`,`DEL_BY`,
					`VAN`,`GENERATED`,`UD_QTY`,`TOINV`,`EXPORTED`,`EXPORTED1`,`EXPORTED2`,`EXPORTED3`,`BRK_TO`,`SV_PART`,`LAST_YEAR`,
					`VOID`,`SONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`TEMP`,`TEMP1`,
					`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,`TABLENO`,`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,
					`NODISPLAY`,`TITLE_ID`,`TITLE_DESP`,<cfif lcase(hcomid) eq "topsteel_i">`TITLE_DESPA`,</cfif>
					`COMMENT`,`DEFECTIVE`,`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,
					`MC6_BIL`,`MC7_BIL`<cfif lcase(hcomid) eq "fdipx_i">,`JobOrderNo`</cfif>,`taxincl`,`note_a`)
					values ('PO', '#nexttranno#', '#getbody.refno2#', '#j#', '#getsupplier.custno#', '#readperiod#',
					'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,
					'#getsupplier.agent#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">, '#getbody.source#', '#getbody.job#', '', '#listgetat(form.fulfill,j)#',
					'#getbody.price_bil#', '#getbody.unit_bil#', '#newamt1_bil#', '0', '0', '0',
					'0','#newamt_bil#', '#getbody.taxpec1#','0', '0', '#newtaxamt_bil#', '',
					'#fulfillactual#', '#newprice#',
					'#unit#', '#newamt1#', '0', '#newamt#', '#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#', '#listgetat(mylist,i,";")#', '#listgetat(mylist,i,";")#',
					#getbody.wos_date#,	'0000-00-00', '#brem1#', '#brem2#', '#brem3#', '#brem4#', '#getbody.packing#', '#getbody.note1#',
					'#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N', '', '#getbody.grade#', '0.00',
					'0.00', '0', '0','#getbody.m_charge1#','#getbody.m_charge2#','#getbody.adtcost1#','#getbody.adtcost2#','0','0','#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '',
					'0', '0', '0',	'#name#', '0', '0', 'Y', '', '', '', '0000-00-00', '', '0000-00-00', '', '', '', '',
					'#listgetat(mylist,i,";")#','#getbody.mc1_bil#','#getbody.mc2_bil#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">, '0', '', '#getbody.wos_group#', '#getbody.category#',
					'#getsupplier.area#', '#Shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#', '0',
					'#member#', '', #Now()#, 'Time', '#BOMNO#',
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
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getbody.comment)#">,'#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					<cfelseif SingleQ eq '' and DoubleQ eq 'Y'>
						<!--- Found " in the comment --->
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getbody.comment)#">,'#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					<cfelseif SingleQ eq '' and DoubleQ eq ''>
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getbody.comment)#">,'#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					<cfelse>
						'','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					</cfif>
		  		</cfquery>

				<cfquery name="inserticlink" datasource="#dts#">
					insert into iclink values ('PO','#nexttranno#','#j#',
					'#ndatenow#','QUO','#listgetat(mylist,i,";")#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#val(listgetat(form.fulfill,j))#')
				</cfquery>
				
				<cfif form["grdcolumnlist_QUO_#xparam1#_#xParam3#"] neq "">
					<cfset grdcolumnlist = form["grdcolumnlist_QUO_#xparam1#_#xParam3#"]>
					<cfset bgrdcolumnlist = form["bgrdcolumnlist_QUO_#xparam1#_#xParam3#"]>
					<cfset grdvaluelist = form["grdvaluelist_QUO_#xparam1#_#xParam3#"]>
					<cfset totalrecord = form["totalrecord_QUO_#xparam1#_#xParam3#"]>
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
						('PO', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">,'#ndatenow#','#readperiod#','1','','#getbody.location#','','',
						'#getbody.custno#','','1', '1',
						<cfloop from="1" to="#totalrecord#" index="k">
							<cfif k neq totalrecord>
								#myArray2[k]#,
							<cfelse>
								#myArray2[k]#
							</cfif>
						</cfloop>)
					</cfquery>
			
				</cfif>
			</cfloop>

			<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
				<cfquery datasource="#dts#" name="updateartran">
					Update ictran set exported = '#nexttranno#', exported1 = '#ndatenow#'
					where refno	= '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#">
					and exported = '' and type = 'QUO' and trancode = '#xparam3#'
				</cfquery>
				
				<cfquery datasource="#dts#" name="updateigrade">
					Update igrade i, ictran ic 
					set i.exported = '#nexttranno#'
					where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
					and i.refno = '#xparam1#' and i.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and i.trancode = '#xparam3#'
					and ic.exported = '' and i.type = 'QUO'
				</cfquery>
			</cfif>

			<cfset j = j + 1>

			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran 
				where refno = '#listgetat(mylist,i,";")#' and type = 'QUO'
				and exported = ''
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set exported = '#nexttranno#' 
					where refno = '#listgetat(mylist,i,";")#' and type = 'QUO'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lQUO# no: ,#listgetat(mylist,i,";")#,#listgetat(mylist,i+1,";")# is successfully updated to #gettranname.lPO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
	 	</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
		</cfquery>

	 	<cfif getheader.disp1 neq 0 and  getheader.disp1 neq "">
			<cfset xdisp1 = val(getheader.disp1)>
	 	<cfelse>
			<cfset xdisp1 = 0>
	 	</cfif>

		<cfif getheader.disp2 neq 0 and  getheader.disp2 neq "">
			<cfset xdisp2 = val(getheader.disp2)>
		<cfelse>
			<cfset xdisp2 = 0>
		</cfif>

		<cfif getheader.disp3 neq 0 and  getheader.disp3 neq "">
			<cfset xdisp3 = val(getheader.disp3)>
		<cfelse>
			<cfset xdisp3 = 0>
		</cfif>

		<cfif getheader.taxp1 neq 0 and  getheader.taxp1 neq "">
			<cfset xtaxp1 = val(getheader.taxp1)>
		<cfelse>
			<cfset xtaxp1 = 0>
		</cfif>

		<cfset disc1_bil = gross_bil * xdisp1/100>
		<cfset net1_bil = gross_bil - disc1_bil>
		<cfset disc2_bil = net1_bil * xdisp2/100>
		<cfset net1_bil = net1_bil - disc2_bil>
		<cfset disc3_bil = net1_bil * xdisp3/100>

		<cfif disc1_bil eq 0 and disc2_bil eq 0 and disc3_bil eq 0 and getheader.disc_bil neq 0>
			<cfset disc_bil = val(getheader.disc_bil)>
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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
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
		
	  	<!--- Create a new transaction --->
		<!--- QUO TO PO --->
	  	<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,
		  	currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,
		  	tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax2,
		  	tax3,tax,taxp1,taxp2,taxp3,grand,note,term,van,pono,dono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
		  	rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
		  	trdatetime,userid,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on,taxincl,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49)

		  	values('PO','#nexttranno#','#getheader.refno2#','#getsupplier.custno#','#readperiod#','#ndatenow#',
			'#getheader.desp#','#getheader.despa#','#getsupplier.agent#','#getsupplier.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#','#getsupplier.term#','#getheader.van#',
			'#updatepono#','#getheader.dono#','#updatepono#','Profile','Profile', '#getsupplier.attn#','#getsupplier.attn#',
			'#getsupplier.phone#','#getheader.rem5#',
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			'#getheader.rem11#', '#getsupplier.phone#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getsupplier.name#">, '#getsupplier.name2#', '#getsupplier.add1#', '#getsupplier.add2#', '#getsupplier.add3#',
			'#getsupplier.add4#', '#getsupplier.fax#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getsupplier.name#">, '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getsupplier.add1#', '#getsupplier.add2#', '#getsupplier.add3#', '#getsupplier.add4#', '#getsupplier.fax#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getsupplier.name#">,'#getsupplier.phonea#',
			#Now()#, '#HUserID#','#getsupplier.currcode#',
			'#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#',
			'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#','#getheader.special_account_code#',
			'#HUserID#',#now()#,'#HUserID#',#now()#,'#getheader.taxincl#','#getheader.rem30#', '#getheader.rem31#', '#getheader.rem32#', '#getheader.rem33#', '#getheader.rem34#', '#getheader.rem35#', '#getheader.rem36#', '#getheader.rem37#', '#getheader.rem38#', '#getheader.rem39#', '#getheader.rem40#', '#getheader.rem41#', '#getheader.rem42#', '#getheader.rem43#', '#getheader.rem44#', '#getheader.rem45#', '#getheader.rem46#', '#getheader.rem47#', '#getheader.rem48#', '#getheader.rem49#')
	  	</cfquery>
	</cfif>
    
    <!--- t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ t1 = RQ --->
	<cfif url.t1 eq "RQ">
		<cfset type = gettranname.lRQ>
		<cftry>
        	<cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        	<cfelse>
			<cfquery name="updategsetup" datasource="#dts#">
				update refnoset set 
				lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
				where type = '#url.t2#'
				and counter =  '#invset#'
			</cfquery>
            </cfif>
		<cfcatch type="any">
			<cfoutput>#cfcatch.Message#::#cfcatch.Detail#</cfoutput><cfabort>
		</cfcatch>
		</cftry>

		<cfset mylist= listchangedelims(checkbox,"",",")>

		<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>

		<cfset j = 1>

		<cfloop from="1" to="#cnt#" index="i" step="+3">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

				<cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>
			<cfoutput>PO No. : #listgetat(mylist,i,";")# <br></cfoutput>
			<cfset xParam1 = listgetat(mylist,i,";")>

			<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			  	<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  	<cfset xParam2 = ''>
			<cfelse>
			  	<cfset xParam2 = listgetat(mylist,i+1,";")>
			</cfif>

			<cfset xParam3 = listgetat(mylist,i+2,";")>

			<cfquery datasource="#dts#" name="getbody">
				Select * from ictran where refno = '#xParam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#"> and trancode = '#xParam3#'
				and shipped < qty and type = 'RQ'
			</cfquery>
			<cfquery name="getsupplier" datasource="#dts#">
				select a.custno,a.name,a.name2,a.add1,a.add2,a.add3,a.add4,a.fax,a.term,a.currcode,a.agent,a.area,a.attn,a.phone,a.phonea,a.daddr1,a.daddr2,a.daddr3,a.daddr4,a.dfax,(select #currperiod# from #target_currency# where currcode=a.currcode) as rate 
				from #target_apvend# as a 
				where a.custno='#form.supplier#';
			</cfquery>
			<cfloop query="getbody">
			  	<cfquery datasource="#dts#" name="getheader">
					Select currcode,custno,currrate from artran where refno = '#listgetat(mylist,1,";")#' and type = 'RQ'
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
                <cfif getGsetup.po_to_rc_currrate eq 'Y'>
                <cfset newcurrate = getheader.currrate>
                <cfelse>
					<cfset newcurrate = currency.rate>
                    </cfif>
				<cfelse>
					<cfset newcurrate = 1>
				</cfif>
                
                <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(currentdate)#')>
                </cfif>
         

				<!--- Add On 061008, 2nd Unit Function --->
				<!---<cfif val(getbody.factor1) neq 0>
                	<cfif getbody.price_bil neq '#listgetat(pricebil,j)#'>
                    <cfset getbody.price_bil = '#listgetat(pricebil,j)#'>
					</cfif>
					<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
				<cfelse>
					<cfset getbody.price_bil = 0>
				</cfif>--->
                <cfif getbody.price_bil neq '#listgetat(pricebil,j)#'>
                    <cfset getbody.price_bil = '#listgetat(pricebil,j)#'>
					</cfif>
                <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
                
                
				<cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil>
				<cfset newdamt_bil1 = (getbody.dispec1 / 100) * newamt1_bil>
				<cfset netamt = newamt1_bil - newdamt_bil1>
				<cfset newdamt_bil2 = (getbody.dispec2 / 100) * netamt>
				<cfset netamt = netamt - newdamt_bil2>
				<cfset newdamt_bil3 = (getbody.dispec3 / 100) * netamt>
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
                
				<!--- RQ TO PO --->
				<cftry>
					<cfquery datasource="#dts#" name="insertictran">
						Insert into ictran (TYPE, REFNO, REFNO2, TRANCODE, CUSTNO, FPERIOD, wos_DATE,
						CURRRATE, ITEMCOUNT, LINECODE, ITEMNO, DESP, DESPA,
						AGENNO, LOCATION, SOURCE, JOB, SIGN, QTY_BIL, PRICE_BIL,
						UNIT_BIL, AMT1_BIL, DISPEC1, DISPEC2, DISPEC3,
						DISAMT_BIL, AMT_BIL, TAXPEC1, TAXPEC2, TAXPEC3,
						TAXAMT_BIL, IMPSTAGE, QTY, PRICE, UNIT,
						AMT1, DISAMT, AMT, TAXAMT, FACTOR1, FACTOR2, DONO, DODATE,
						SODATE, BREM1, BREM2, BREM3, BREM4, 
						<cfif lcase(hcomid) eq "avent_i">
							BREM5,BREM6,
						<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
							BREM5,BREM7,BREM8,BREM9,BREM10,
						</cfif>
						PACKING, NOTE1, NOTE2, GLTRADAC, UPDCOST,
						GST_ITEM, TOTALUP, WITHSN, GRADE, PUR_PRICE,
						QTY_RET, TEMPFIGI, SERCOST, M_CHARGE1, M_CHARGE2, ADTCOST1,ADTCOST2,
						IT_COS, AV_COST, BATCHCODE, EXPDATE, POINT, INV_DISC, INV_TAX, SUPP, EDI_COU1,
						WRITEOFF, TOSHIP, SHIPPED, NAME, DEL_BY, VAN, GENERATED, UD_QTY, TOINV, EXPORTED,
						EXPORTED1, EXPORTED2, EXPORTED3, BRK_TO, SV_PART, LAST_YEAR, VOID, SONO, MC1_BIL,
						MC2_BIL, USERID, DAMT, OLDBILL, wos_GROUP, CATEGORY, AREA, SHELF, TEMP, TEMP1,
						BODY, TOTALGROUP, MARK, TYPE_SEQ, PROMOTER, TABLENO, MEMBER, TOURGROUP, TRDATETIME,
						TIME, BOMNO,
						`NODISPLAY`,`TITLE_ID`,`TITLE_DESP`,<cfif lcase(hcomid) eq "topsteel_i">`TITLE_DESPA`,</cfif> 
						DEFECTIVE,comment,M_CHARGE3,M_CHARGE4,M_CHARGE5,M_CHARGE6,M_CHARGE7,MC3_BIL,MC4_BIL,MC5_BIL,MC6_BIL,MC7_BIL<cfif lcase(hcomid) eq "fdipx_i">,JobOrderNo</cfif>,`taxincl`,`note_a`)
	
						values ('PO', '#nexttranno#', '#getbody.refno2#', '#j#', '#getsupplier.custno#', '#readperiod#', '#ndatenow#',
						'#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
	                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,
						'#getbody.agenno#',	<cfif isdefined('form.location')>
                        <cfif listgetat(form.location,j) eq "emptylocation">
						<cfset locationvalue = "">
                        <cfelse>
                        <cfset locationvalue = listgetat(form.location,j)>
                        </cfif>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#locationvalue#">,

                    <cfelse>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">,
					</cfif> '#getbody.source#', '#getbody.job#', '', '#listgetat(form.fulfill,j)#', '#getbody.price_bil#',
						'#getbody.unit_bil#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
						'#newdamt_bil#', '#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#',
						'#newtaxamt_bil#', '', '#listgetat(form.fulfill,j)#', '#getbody.price#', '#unit#',
						'#newamt1#', '#newdamt#', '#newamt#', '#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#',
						'#listgetat(mylist,i,";")#',
                        <cfif getbody.dodate eq '' or getbody.dodate eq '0000-00-00'>'0000-00-00'<cfelse>'#dateformat(getbody.dodate,"yyyy-mm-dd")#'</cfif>,
                        <cfif getbody.wos_date eq '' or getbody.wos_date eq '0000-00-00'>'0000-00-00'<cfelse>'#dateformat(getbody.wos_date,"yyyy-mm-dd")#'</cfif>,
                        <!---'#dateformat(getbody.dodate,"yyyy-mm-dd")#',--->
                        <!---'#dateformat(getbody.wos_date,"yyyy-mm-dd")#', --->
                        '#brem1#', '#brem2#', '#brem3#', '#brem4#',
						<cfif lcase(hcomid) eq "avent_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
						<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
						</cfif>
						'#packing#', '#note1#', '#note2#',
						'#gltradac#', '', 'N', 'N', '', '#grade#', '0.00','0.00', '0', '0', '#getbody.m_charge1#', '#getbody.m_charge2#',
						'#getbody.adtcost1#', '#getbody.adtcost2#', '0', '0', '#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '', '0', '0', '0',
						'#getsupplier.name#', '0', '#van#', 'Y', '', '', '', '0000-00-00', '', '0000-00-00', '', '', '', '','#listgetat(mylist,i,";")#',
						'#getbody.mc1_bil#', '#getbody.mc2_bil#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">, '0', '', 
                        '#getbody.wos_group#', '#getbody.category#', '#Area#', '#Shelf#', '#Temp#', '#Temp1#',
						'', '0', '0', '0', '#Promoter#', '0',
						'#member#', '', #Now()#, 'Time', '#BOMNO#',
						'#getbody.nodisplay#','#getbody.title_id#','#getbody.title_desp#',
            			<cfif lcase(hcomid) eq "topsteel_i"><cfqueryparam cfsqltype="cf_sql_longvarchar" value="#getbody.title_despa#">,</cfif> 
						'#getbody.defective#',

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
						  	"#tostring(getbody.comment)#",'#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						<cfelseif SingleQ eq '' and DoubleQ eq 'Y'>
						  	<!--- Found " in the comment --->
						  	'#tostring(getbody.comment)#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						<cfelseif SingleQ eq '' and DoubleQ eq ''>
						  	'#tostring(getbody.comment)#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						<cfelse>
						  	'','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						</cfif>
					</cfquery>
				<cfcatch type="any">
					<cfoutput>#cfcatch.Message#::#cfcatch.Detail#</cfoutput><cfabort>
				</cfcatch>
				</cftry>
				

				<cfquery name="inserticlink" datasource="#dts#">
					insert into iclink values ('PO','#nexttranno#','#j#',
					'#ndatenow#','RQ','#listgetat(mylist,i,";")#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#listgetat(form.fulfill,j)#')
				</cfquery>

				<cfset newship = getbody.shipped + listgetat(form.fulfill,j)>
				<!---
				<cfquery datasource="#dts#" name="updateictran">
					Update ictran set shipped = '#newship#'
					where refno = '#xparam1#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and trancode = '#xparam3#'
					and toinv = '' and type = 'RQ'
				</cfquery>--->

				<cfset qname='QIN'&(readperiod+10)><cfoutput>#qname#--#getbody.qty#</cfoutput>
				
				<!--- Start: Add on 051008, graded item --->
				<!--- <cfif Evaluate("form.grdcolumnlist_PO_#xparam1#_#xParam3#") neq ""> --->
                <cfif form["grdcolumnlist_RQ_#xparam1#_#xParam3#"] neq "">
					<cfset grdcolumnlist = form["grdcolumnlist_RQ_#xparam1#_#xParam3#"]>
					<cfset bgrdcolumnlist = form["bgrdcolumnlist_RQ_#xparam1#_#xParam3#"]>
					<cfset grdvaluelist = form["grdvaluelist_RQ_#xparam1#_#xParam3#"]>
					<cfset totalrecord = form["totalrecord_RQ_#xparam1#_#xParam3#"]>
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
						('PO', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">, '#ndatenow#','#readperiod#','1','','#getbody.location#','','',
						'#getbody.custno#','','1', '1',
						<cfloop from="1" to="#totalrecord#" index="k">
							<cfif k neq totalrecord>
								#myArray2[k]#,
							<cfelse>
								#myArray2[k]#
							</cfif>
						</cfloop>)
					</cfquery>

				</cfif>
                
				
				<!--- End: Add on 051008, graded item --->
			</cfloop>

			<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
				<cfquery datasource="#dts#" name="updateartran">
					Update ictran set toinv = '#nexttranno#', generated = 'Y'
					where refno = '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">
					and toinv = '' and type = 'RQ' and trancode = '#xparam3#'
				</cfquery>
				
				<!--- Step 2:--->
				<!--- Add on 051008, For Graded Item --->
				<cfquery datasource="#dts#" name="updateigrade">
					Update igrade i, ictran ic 
					set i.generated = 'Y'
					where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
					and i.refno = '#xparam1#' and i.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and i.trancode = '#xparam3#'
					and ic.toinv = '' and i.type = 'RQ'
				</cfquery>
			</cfif>

			<cfset j = j + 1>

			<!--- <cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#' and shipped < qty and type = 'PO'
			</cfquery> --->
			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#' and toinv = '' and type = 'RQ'
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set toinv = '#nexttranno#', order_cl = 'Y', generated = 'Y' where refno = '#listgetat(mylist,i,";")#' and type = 'RQ'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lRQ# no: #listgetat(form.checkbox,i,";")#,#xParam2# is successfully updated to #gettranname.lPO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
		</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'RQ'
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
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(currentdate)#')>
                </cfif>

		<cfif getheader.disp1 neq 0 and  getheader.disp1 neq "">
			<cfset xdisp1 = val(getheader.disp1)>
		<cfelse>
			<cfset xdisp1 = 0>
		</cfif>

		<cfif getheader.disp2 neq 0 and  getheader.disp2 neq "">
			<cfset xdisp2 = val(getheader.disp2)>
		<cfelse>
			<cfset xdisp2 = 0>
		</cfif>

		<cfif getheader.disp3 neq 0 and  getheader.disp3 neq "">
			<cfset xdisp3 = val(getheader.disp3)>
		<cfelse>
			<cfset xdisp3 = 0>
		</cfif>

		<cfif getheader.taxp1 neq 0 and  getheader.taxp1 neq "">
			<cfset xtaxp1 = val(getheader.taxp1)>
		<cfelse>
			<cfset xtaxp1 = 0>
		</cfif>

		<cfset disc1_bil = gross_bil * xdisp1/100>
		<cfset net1_bil = gross_bil - disc1_bil>
		<cfset disc2_bil = net1_bil * xdisp2/100>
		<cfset net1_bil = net1_bil - disc2_bil>
		<cfset disc3_bil = net1_bil * xdisp3/100>

		<cfif disc1_bil eq 0 and disc2_bil eq 0 and disc3_bil eq 0 and getheader.disc_bil neq 0>
			<cfset disc_bil = val(getheader.disc_bil)>
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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
        <cfif getheader.taxincl neq "T">
        
        <cfif totaltaxcharge eq 0 and taxcharge eq 0>
		<cfset grand_bil = net_bil + tax_bil>
        <cfelseif taxcharge neq 0>
        <cfset grand_bil = net_bil + taxcharge>
        <cfelse>
        <cfset grand_bil = net_bil>
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
		 <cfif getheader.desp eq "">
        <cfset getheader.desp  = "PURCHASES">
		</cfif>
		<!--- RQ TO PO --->
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
			</cfif>,taxincl)

			values('PO','#nexttranno#','#getheader.refno2#','#getsupplier.custno#','#readperiod#','#ndatenow#',
			'#getheader.desp#','#getheader.despa#','#getheader.agenno#','#getsupplier.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#val(net)#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#','#getheader.term#','#getheader.van#',
			<cfif getheader.pono neq ''>'#getheader.pono#'<cfelse>'#updatepono#'</cfif>,'#getheader.dono#','#getheader.quono#','#getheader.rem0#','#getheader.rem1#', '#getsupplier.attn#','#getsupplier.attn#',
			'#getsupplier.phone#','#getheader.rem5#',
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			'#getheader.rem11#', '#left(getGsetup.compro5,20)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getsupplier.name#">, '#getsupplier.name2#', '#getsupplier.add1#', '#getsupplier.add2#', '#getsupplier.add3#',
			'#getsupplier.add4#', '#getsupplier.fax#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getGsetup.compro#">, '#getsupplier.name2#', '#getheader.frem9#',
			'#getGsetup.compro2#', '#getGsetup.compro3#', '#getGsetup.compro4#', '#getsupplier.daddr4#', '#right(getGsetup.compro5,20)#',
			'#getsupplier.name#','#getsupplier.phonea#',
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
			</cfif>,'#getheader.taxincl#')
		</cfquery>
        
         <cfif lcase(hcomid) eq "haikhim_i">
        
        <cfquery name="gethaikhimuseremail" datasource="main">
        select useremail from users where userid="#getheader.created_by#" and userbranch="#hcomid#"
        </cfquery>
    
        <cfif gethaikhimuseremail.useremail neq "">
        <cfmail from="noreply@mynetiquette.com" to="#gethaikhimuseremail.useremail#" 
                subject="#getheader.type#-#getheader.refno# PO Has Been Created"
            >
    
        The Bill No #getheader.refno# For Project #getheader.source# Has Been Updated To PO No : #nexttranno#
        
        </cfmail>
        </cfif>

        
        </cfif>
        
	</cfif>
    
<!--- t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO t2 = SO --->
<cfelseif url.t2 eq "SO">
	<h1>Update to <cfoutput>#gettranname.lSO#</cfoutput></h1>
	<!--- t1 = QUO --->
	<cfif url.t1 eq "QUO" and (lcase(HcomID) neq "steel_i" and lcase(HcomID) neq "tranz_i")>
		<cfset type = gettranname.lQUO>

		<!---cfquery datasource="#dts#" name="updategsetup">
			Update Gsetup set sono =UPPER("#nexttranno#")
		</cfquery--->
		<!--- <cfquery name="updategsetup" datasource="main">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where userDept = '#dts#'
			and type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
		
		<!--- <cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
		</cfif>
		<cfoutput><h2>#gettranname.lQUO# no: #listfirst(form.checkbox,";")# is successfully updated to #gettranname.lSO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>

		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset j = 1>
		<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>
        
        <cfif getGsetup.quochooseitem eq 1>
        <cfset stepcount = "+3" >
		<cfelse>
        <cfset stepcount = "+1" >
        </cfif>

		<cfloop from="1" to="#cnt#" index="i" step="#stepcount#">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

				<cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>QUO No. : #listgetat(mylist,i,";")# <br></cfoutput>

			
			<!--- Start of Update body --->
            
			<cfif getGsetup.quochooseitem eq 1>
				<cfset xParam1 = listgetat(mylist,i,";")>

				<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			  		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  		<cfset xParam2 = ''>
				<cfelse>
			  		<cfset xParam2 = listgetat(mylist,i+1,";")>
				</cfif>

				<cfset xParam3 = listgetat(mylist,i+2,";")>
			
				<cfquery datasource="#dts#" name="getbody">
					Select * from ictran where refno = '#xParam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#"> and trancode = '#xParam3#' and shipped < qty and type = 'QUO'
				</cfquery>

				<cfloop query="getbody">
				  	<cfquery datasource="#dts#" name="getheader">
						Select currcode,custno,permitno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
				  	</cfquery>
					<cfif lcase(hcomid) eq "bnbm_i" or lcase(HcomID) eq "bnbp_i">
                    <cfquery datasource="#dts#" name="getleadaccountno">
						select accountno from #replace(dts,'_i','_c','all')#.lead where id='#getheader.permitno#'
				  	</cfquery>
                    <cfquery datasource="#dts#" name="getleadcustdetail">
						select * from #target_arcust# where custno='#getleadaccountno.accountno#'
				  	</cfquery>
                    </cfif>
                    
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
                    
                    <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>
					
					<!--- Add On 061008, 2nd Unit Function --->
					<!---<cfif val(getbody.factor1) neq 0>
						<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
					<cfelse>
						<cfset getbody.price_bil = 0>
					</cfif>--->
                    <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
					
					<cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil>
					
					<cfset newdamt_bil1 = (getbody.dispec1 / 100) * newamt1_bil>
					<cfset netamt = newamt1_bil - newdamt_bil1>
					<cfset newdamt_bil2 = (getbody.dispec2 / 100) * netamt>
					<cfset netamt = netamt - newdamt_bil2>
					<cfset newdamt_bil3 = (getbody.dispec3 / 100) * netamt>
					<cfset netamt = netamt - newdamt_bil3>
					
					<cfset newdamt_bil = newdamt_bil1 + newdamt_bil2 + newdamt_bil3>
					<cfif val(newdamt_bil) eq 0 and val(getbody.DISAMT_BIL) neq 0 and val(getbody.qty_bil) neq 0>
						<cfset newdamt_bil = val(getbody.DISAMT_BIL) * val(listgetat(fulfill,j)) / val(getbody.qty_bil)>
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
	                
					<!--- QUO TO SO --->
					<cfquery datasource="#dts#" name="insertictran">
						Insert into ictran 
						(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
						`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
						`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
						`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`QUONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,
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
						`MC6_BIL`,`MC7_BIL`<cfif lcase(hcomid) eq "fdipx_i">,`JobOrderNo`</cfif>,`taxincl`,`note_a`
                        <cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">,`ictranfilename`</cfif>)
						values ('SO', '#nexttranno#', '#getbody.refno2#', '#j#', <cfif lcase(hcomid) eq "bnbm_i" or lcase(HcomID) eq "bnbp_i"><cfif getleadcustdetail.recordcount neq 0>'#getleadcustdetail.custno#'<cfelse>'#getbody.custno#'</cfif><cfelse>'#getbody.custno#'</cfif>, '#readperiod#',
						'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
	                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,
						'#agenno#',	<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">,<cfif getgsetup.soautocreaproj eq 'Y'>'#nexttranno#'<cfelse>'#getbody.source#'</cfif>, '#getbody.job#', '', '#listgetat(form.fulfill,j)#',
						'#getbody.price_bil#','#getbody.unit_bil#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
						'#newdamt_bil#', '#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#', '#newtaxamt_bil#',
						'', '#fulfillactual#', '#getbody.price#','#getbody.unit#', '#newamt1#', '#newdamt#', '#newamt#',
						'#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#', '#listgetat(mylist,i,";")#', '#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#getbody.sodate#', '#brem1#', '#brem2#', '#brem3#', '#brem4#',
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
						'#listgetat(mylist,i,";")#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#', '#getbody.category#', '#Area#',
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
						  	'','#getbody.defective#',,'#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#'<cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">,'#getbody.ictranfilename#'</cfif>)
						</cfif>
					</cfquery>
					
                    <cfif getgsetup.soautocreaproj eq 'Y'>
                    <cfquery datasource='#dts#' name='insertnewproject'>
                    insert ignore into #target_project# (source,project,porj) values ('#nexttranno#','#nexttranno#','P')
                    </cfquery>
                    </cfif>
                    
					<!---QUO TO SO NO NEED <cfif getbody.batchcode neq "">
						<cfif getbody.location neq "">
							<cfquery name="updateobbatch" datasource="#dts#">
								update lobthob set bth_qut=(bth_qut+'#listgetat(form.fulfill,j)#')
								where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+'#listgetat(form.fulfill,j)#')
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						<cfelse>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+'#listgetat(form.fulfill,j)#')
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						</cfif>
					</cfif>
	
					<cfset qname='QOUT'&(readperiod+10)>
	
					<cfquery name="UpdateIcitem" datasource="#dts#">
						update icitem set #qname#=(#qname#+#listgetat(form.fulfill,j)#) where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
					</cfquery>--->
	
					<cfquery name="inserticlink" datasource="#dts#">
						insert into iclink values ('so','#nexttranno#','#j#',
						'#ndatenow#','QUO','#listgetat(mylist,i,";")#','#getbody.trancode#',
						#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#val(listgetat(form.fulfill,j))#')
					</cfquery>
	
					<cfset newship = getbody.shipped + val(listgetat(form.fulfill,j))>
	
					<cfquery datasource="#dts#" name="updateictran">
						Update ictran set shipped = '#newship#'
						where refno = '#xparam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and trancode = '#xparam3#'
						and toinv = '' and type = 'QUO'
					</cfquery>
					
					<cfif form["grdcolumnlist_QUO_#xparam1#_#xParam3#"] neq "">
						<cfset grdcolumnlist = form["grdcolumnlist_QUO_#xparam1#_#xParam3#"]>
						<cfset bgrdcolumnlist = form["bgrdcolumnlist_QUO_#xparam1#_#xParam3#"]>
						<cfset grdvaluelist = form["grdvaluelist_QUO_#xparam1#_#xParam3#"]>
						<cfset totalrecord = form["totalrecord_QUO_#xparam1#_#xParam3#"]>
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
							('SO', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">, '#ndatenow#','#readperiod#','-1','','#getbody.location#','','',
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
							and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
						</cfquery>
					</cfif>
				</cfloop>
	
				<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
					<cfquery datasource="#dts#" name="updateartran">
						Update ictran set toinv = '#nexttranno#', generated = 'Y'
						where refno = '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#">
						and type = 'QUO' and trancode = '#xparam3#'
					</cfquery>
					
					<!--- Step 2:--->
					<!--- Add on 031008, For Graded Item --->
					<cfquery datasource="#dts#" name="updateigrade">
						Update igrade i, ictran ic 
						set i.generated = 'Y'
						where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
						and i.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#"> and i.trancode = '#xparam3#'
						and i.refno = '#xparam1#' and i.type = 'QUO'
					</cfquery>
				</cfif>
            <cfelse>
            	<cfquery datasource="#dts#" name="getbody">
					Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = 'QUO' order by itemcount
				</cfquery>
				<cfloop query="getbody">
				  	<!--- GET LATEST CURRRATE --->
				  	<cfquery datasource="#dts#" name="getheader">
						Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
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
						<cfset newcurrate = val(currency.rate)>
					<cfelse>
						<cfset newcurrate = 1><!--- default --->
					</cfif>
                    
                    <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>
	
					<cfset newamt1_bil = val(getbody.qty_bil) * val(getbody.price_bil)>
					<cfset newdamt_bil1 = (val(getbody.dispec1) / 100) * val(newamt1_bil)>
					<cfset netamt = val(newamt1_bil) - val(newdamt_bil1)>
					<cfset newdamt_bil2 = (val(getbody.dispec2) / 100) * val(netamt)>
					<cfset netamt = val(netamt) - val(newdamt_bil2)>
					<cfset newdamt_bil3 = (val(getbody.dispec3) / 100) * val(netamt)>
					<cfset netamt = val(netamt) - val(newdamt_bil3)>
	
					<cfset newdamt_bil = val(newdamt_bil1) + val(newdamt_bil2) + val(newdamt_bil3)>
					<cfset newtaxamt_bil = (val(getbody.taxpec1) / 100) * (val(newamt1_bil) - val(newdamt_bil))>
					<!--- <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil) + val(newtaxamt_bil)> --->
	                <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil)>
					<cfset newamt_bil = numberformat(val(newamt_bil),".__")>
					<cfset newprice = val(getbody.price_bil) * val(newcurrate)>
	
					<cfset newamt1 = val(newamt1_bil) * val(newcurrate)>
					<cfset newdamt = val(newdamt_bil) * val(newcurrate)>
					<cfset newtaxamt = val(newtaxamt_bil) * val(newcurrate)>
					<cfset newamt = val(newamt_bil) * val(newcurrate)>
					<cfset newamt = numberformat(val(newamt),".__")>
	
					<cfset gross_bil = val(gross_bil) + val(newamt_bil)>
					<cfset gross = val(gross_bil) * val(newcurrate)>
	                
	                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
						
					<!--- QUO TO SO --->
					<cfquery datasource="#dts#" name="insertictran">
						Insert into ictran 
						(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
						`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
						`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
						`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`QUONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,
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
						`MC6_BIL`,`MC7_BIL`<cfif lcase(hcomid) eq "fdipx_i">,`JobOrderNo`</cfif>,`taxincl`,`note_a`<cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">,`ictranfilename`</cfif>) 
						values ('SO', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
						'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
	                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,	
						'#getbody.agenno#',	 <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">, <cfif getgsetup.soautocreaproj eq 'Y'>'#nexttranno#'<cfelse>'#getbody.source#'</cfif>, '#getbody.job#', '',
						'#getbody.qty_bil#', '#getbody.price_bil#',	'#getbody.unit_bil#', '#newamt1_bil#', '#val(getbody.dispec1)#',
						'#val(getbody.dispec2)#', '#val(getbody.dispec3)#', '#newdamt_bil#', '#newamt_bil#', '#val(getbody.taxpec1)#',
						'#val(getbody.taxpec2)#', '#val(getbody.taxpec3)#', '#newtaxamt_bil#', '', '#getbody.qty#', '#newprice#',
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.unit#">, '#newamt1#', '#newdamt#',	'#newamt#', '#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#',
						'#listgetat(mylist,i,";")#','#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#dateformat(getbody.wos_date,"yyyy-mm-dd")#', '#getbody.brem1#', '#getbody.brem2#', '#getbody.brem3#',
						'#getbody.brem4#', 
						<cfif lcase(hcomid) eq "avent_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
						<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
						</cfif>
						'#getbody.packing#', '#getbody.note1#', '#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N',
						'', '#getbody.grade#', '0.00','0.00','0',
						'0', '#getbody.m_charge1#', '#getbody.m_charge2#', '#getbody.adtcost1#', '#getbody.adtcost2#', '0', '0', '#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '', '0', '0', '0','#getbody.name#', '', '#getbody.van#', 'Y',
						'', '',	'', '0000-00-00', '', '0000-00-00', '', '', '', '', '#getbody.sono#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#',
						'#getbody.category#', '#getbody.area#', '#getbody.shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#',
						'0', '#member#', '', #Now()#, 'Time', '#getbody.bomno#',
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
						  "#tostring(getbody.comment)#",'#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#'<cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">,'#getbody.ictranfilename#'</cfif>)
						<cfelseif SingleQ eq '' and DoubleQ eq 'Y'>
						  <!--- Found " in the comment --->
						  '#tostring(getbody.comment)#','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#'<cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">,'#getbody.ictranfilename#'</cfif>)
						<cfelseif SingleQ eq '' and DoubleQ eq ''>
						  '#tostring(getbody.comment)#','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#'<cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">,'#getbody.ictranfilename#'</cfif>)
						<cfelse>
						  '','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#'<cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">,'#getbody.ictranfilename#'</cfif>)
						</cfif>
					</cfquery>
					
                    <cfif getgsetup.soautocreaproj eq 'Y'>
                    <cfquery datasource='#dts#' name='insertnewproject'>
                    insert ignore into #target_project# (source,project,porj) values ('#nexttranno#','#nexttranno#','P')
                    </cfquery>
                    </cfif>
					
					<cfif getbody.batchcode neq "">
						<cfif getbody.location neq "">
							<cfquery name="updateobbatch" datasource="#dts#">
								update lobthob set bth_qut=(bth_qut+#getbody.qty#)
								where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+#getbody.qty#)
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						<cfelse>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+#getbody.qty#)
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						</cfif>
					</cfif>
	
					<cfset qname='QOUT'&(readperiod+10)>
	
					<cfquery name="UpdateIcitem" datasource="#dts#">
						update icitem set #qname#=(#qname#+#getbody.qty#) where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
					</cfquery>
	
					<cfquery name="inserticlink" datasource="#dts#">
						insert into iclink values ('SO','#nexttranno#','#j#',
						'#ndatenow#','QUO','#listgetat(mylist,i,";")#','#getbody.trancode#',
						#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#getbody.qty_bil#')
					</cfquery>
					
					<!--- Add on 031008 --->
	        		<cfquery datasource="#dts#" name="getigrade">
						Select * from igrade where refno = '#listgetat(mylist,i,";")#' and type = 'QUO' 
	                    and TRANCODE = '#getbody.trancode#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
					</cfquery>
					
					<cfif getigrade.recordcount neq 0>
	            		<cfquery name="insertigrade" datasource="#dts#">
	                		insert into igrade
							(type,refno,trancode,itemno,wos_date,fperiod,sign,del_by,location,void,generated,custno,exported,factor1,factor2,
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									GRD#k#,
								<cfelse>
									GRD#k#
								</cfif>
							</cfloop>)
							values
							('SO','#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.itemno#">,'#ndatenow#','#readperiod#',
							'-1','',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.location#">,'','',
							'#getigrade.custno#','','#getigrade.factor1#','#getigrade.factor2#',
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>)
	                	</cfquery>
	                	<cfquery name="updateitemgrd" datasource="#dts#">
							update itemgrd
							set
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
						</cfquery>
					
						<cfquery name="updatelogrdob" datasource="#dts#">
							update logrdob
							set
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
							and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
						</cfquery>
					</cfif>
					
					<cfset j = j + 1>
				</cfloop>
            </cfif>
            <cfset j = j + 1>
			<cfif getGsetup.quochooseitem neq 1>
				<cfquery datasource="#dts#" name="updateictran">
					Update ictran 
					set shipped = qty,
					toinv='#nexttranno#'
					where refno =  '#listgetat(mylist,i,";")#'
					and toinv = '' and type = 'QUO'
				</cfquery>
			</cfif>
			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#' and (shipped+writeoff) < qty and type = 'QUO'
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set toinv = '#nexttranno#', order_cl = 'Y', generated = 'Y'
					where refno = '#listgetat(mylist,i,";")#' and type = 'QUO'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lQUO# no: #listgetat(form.checkbox,i,";")#<cfif getGsetup.quochooseitem eq 1>,#listgetat(form.checkbox,i+1,";")# </cfif>is successfully updated to #gettranname.lSO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
		</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
		</cfquery>
        
        <cfif lcase(hcomid) eq "bnbm_i" or lcase(HcomID) eq "bnbp_i">
                    <cfquery datasource="#dts#" name="getleadaccountno">
						select accountno from #replace(dts,'_i','_c','all')#.lead where id='#getheader.permitno#'
				  	</cfquery>
                    <cfquery datasource="#dts#" name="getleadcustdetail">
						select * from #target_arcust# where custno='#getleadaccountno.accountno#'
				  	</cfquery>
         </cfif>

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
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
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
		
		<!--- QUO TO SO --->
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
			</cfif>,taxincl,e_mail,termscondition,country,d_country,postalcode,d_postalcode)

			values('SO','#nexttranno#','#getheader.refno2#',<cfif lcase(hcomid) eq "bnbm_i" or lcase(HcomID) eq "bnbp_i"><cfif getleadcustdetail.recordcount neq 0>'#getleadcustdetail.custno#'<cfelse>'#getheader.custno#'</cfif><cfelse>'#getheader.custno#'</cfif>,'#readperiod#','#ndatenow#',
			'#getheader.desp#','#getheader.despa#','#getheader.agenno#','#getheader.area#',<cfif getgsetup.soautocreaproj eq 'Y'>'#nexttranno#'<cfelse>'#getheader.source#'</cfif>,
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#','#getheader.term#','#getheader.van#',
			'#getheader.pono#',<cfif getheader.dono neq ''>'#getheader.dono#'<cfelse>'#getheader.dono#'</cfif>,'#updatepono#','#getheader.rem0#','#getheader.rem1#', '#getheader.rem2#','#getheader.rem3#',
			'#getheader.rem4#','#getheader.rem5#',
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			<cfif isdefined('form.remarks')><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remarks#"><cfelse>'#getheader.rem11#'</cfif>, '#getheader.rem12#','#getheader.frem0#', '#getheader.frem1#', '#getheader.frem2#', '#getheader.frem3#', '#getheader.frem4#',
			'#getheader.frem5#', '#getheader.frem6#', '#getheader.frem7#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getheader.comm0#', '#getheader.comm1#', '#getheader.comm2#', '#getheader.comm3#', '#getheader.comm4#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.name#">,'#getheader.phonea#',
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
			</cfif>,'#getheader.taxincl#','#getheader.e_mail#','#getheader.termscondition#','#getheader.country#','#getheader.d_country#','#getheader.postalcode#','#getheader.d_postalcode#')
		</cfquery>

		<!---cfquery name="UpdateLastUsedNo" datasource="#dts#">
			update gsetup set sono='#nexttranno#'
		</cfquery--->
		
		<!--- <cfquery name="updategsetup" datasource="main">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where userDept = '#dts#'
			and type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
		<cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=UPPER('#nexttranno#')
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
        
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
        </cfif>
		
        <cfif hcomid eq "bnbm_i" or hcomid eq "bnbp_i">
		<cfquery name="getsoitemlist" datasource="#dts#">
        select itemno,desp,qty,price,location from ictran where refno='#nexttranno#' and type='SO'
        </cfquery>
        <table width="70%">
        <tr>
        <th><div align="left">Item No</div></th>
        <th><div align="left">Description</div></th>
        <th><div align="right">Qty On Hand</div></th>
        <th><div align="right">Order Qty</div></th>
        <th><div align="right">Price</div></th>
        </tr>
        <cfoutput>
        <cfloop query="getsoitemlist">
        <cfif getsoitemlist.location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance
                            
                            from icitem as a 
                            
                            left join 
                            (
                                select 
                                location,
                                itemno,
                                (select desp from iclocation where location=locqdbf.location) as locationdesp 
                                from locqdbf
                                where itemno=itemno 
                                and itemno='#itemno#' 
                                and location = '#getsoitemlist.location#'
                            ) as b on a.itemno=b.itemno 
                            
                            left join 
                            (
                                select 
                                a.location,
                                a.itemno,
                                (ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
                                
                                from locqdbf as a 
                                
                                left join
                                (
                                    select 
                                    location,
                                    itemno,
                                    sum(qty) as sum_in 
                                    
                                    from ictran
                                    
                                    where type in ('RC','CN','OAI','TRIN') 
                                    and fperiod<>'99'
                                    and itemno='#itemno#' 
                                    and location = '#getsoitemlist.location#'
                                    and (void = "" or void is null)
                                    and (linecode = "" or linecode is null)
                        
                                    group by location,itemno
                                    order by location,itemno
                                ) as b on a.location=b.location and a.itemno=b.itemno
                                
                                left join
                                (
                                    select 
                                    location,
                                    category,
                                    wos_group,
                                    itemno,
                                    sum(qty) as sum_out 
                                    
                                    from ictran 
                                    
                                    where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
                                    and (toinv='' or toinv is null) 
                                    and fperiod<>'99'
                                    and itemno='#itemno#' 
                                    and location = '#getsoitemlist.location#'
                                    and (void = "" or void is null)
                                    and (linecode = "" or linecode is null)
                                    group by location,itemno
                                    order by location,itemno
                                ) as c on a.location=c.location and a.itemno=c.itemno 
                                
                                where a.itemno=a.itemno
                                and a.itemno='#itemno#' 
                               and a.location = '#getsoitemlist.location#'
                                
                            ) as c on a.itemno=c.itemno and b.location=c.location 
                            
                            where a.itemno=a.itemno 
                            and b.location<>''
                        	and b.location = '#getsoitemlist.location#'
                            and a.itemno='#itemno#' 
                            order by a.itemno;
                            </cfquery>
                            <cfelse>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
                            from icitem as a
                            
                            left join 
                            (
                                select itemno,sum(qty) as sumtotalin 
                                from ictran 
                                where type in ('RC','CN','OAI','TRIN') 
                                and itemno='#itemno#' 
                                and fperiod<>'99'
                                and (void = '' or void is null)
                                group by itemno
                            ) as b on a.itemno=b.itemno
                            
                            left join 
                            (
                                select itemno,sum(qty) as sumtotalout 
                                from ictran 
                                where type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
                                and itemno='#itemno#' 
                                and fperiod<>'99'
                                and (void = '' or void is null)
                                and toinv='' 
                                group by itemno
                            ) as c on a.itemno=c.itemno
                            
                            where a.itemno='#itemno#' 
                            </cfquery>
                            </cfif>
                            <cfif getitemqtyonhand.recordcount eq 0>
                            <cfset getitemqtyonhand.balance=0>
                            </cfif>
        
        
        <tr>
        <td>#getsoitemlist.itemno#</td>
        <td>#getsoitemlist.desp#</td>
        <td align="right">#getitemqtyonhand.balance#</td>
        <td align="right">#getsoitemlist.qty#</td>
        <td align="right">#numberformat(getsoitemlist.price,',_.__')#</td>
        </tr>
        </cfloop>
        </cfoutput>
        </table>
        </cfif>
		<cftry>
			<cfquery name="getheader_remark" datasource="#dts#">
				select 
				type,
				refno,
				cast(remark1 as binary) as remark1,
				cast(remark2 as binary) as remark2,
				cast(remark3 as binary) as remark3,
				cast(remark4 as binary) as remark4,
				cast(remark5 as binary) as remark5,
				cast(remark6 as binary) as remark6,
				cast(remark7 as binary) as remark7,
				cast(remark8 as binary) as remark8,
				cast(remark9 as binary) as remark9,
				cast(remark10 as binary) as remark10
				from artran_remark where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
			</cfquery>
			<cfif getheader_remark.recordcount neq 0>
				<cfquery name="insert_remark" datasource="#dts#">
					insert into artran_remark
					(type,refno,
					<cfloop from="1" to="10" index="z">
						remark#z#,
					</cfloop>USERID,LASTUSERID)
					values
					('SO','#nexttranno#',
					<cfloop from="1" to="10" index="z">
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getheader_remark["remark#z#"][1])#">,
					</cfloop>'#HUserID#','#HUserID#')
				</cfquery>
			</cfif>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
		<!---- ---->
        
        <!--- t1 = QUO Multilocation --->
	<cfelseif url.t1 eq "QUO" and lcase(HcomID) eq "tranz_i">
		<cfset type = gettranname.lQUO>
        
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>

		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
		</cfif>
		<cfoutput><h2>#gettranname.lQUO# no: #listfirst(form.checkbox,";")# is successfully updated to #gettranname.lSO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>

		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset j = 1>
        <cfset z = 1>
		<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>
        
        <cfif getGsetup.quochooseitem eq 1>
        <cfset stepcount = "+3" >
		<cfelse>
        <cfset stepcount = "+1" >
        </cfif>

		<cfloop from="1" to="#cnt#" index="i" step="#stepcount#">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

				<cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>QUO No. : #listgetat(mylist,i,";")# <br></cfoutput>

			
			<!--- Start of Update body --->
				<cfset xParam1 = listgetat(mylist,i,";")>

				<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			  		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  		<cfset xParam2 = ''>
				<cfelse>
			  		<cfset xParam2 = listgetat(mylist,i+1,";")>
				</cfif>

				<cfset xParam3 = listgetat(mylist,i+2,";")>
			
				<cfquery datasource="#dts#" name="getbody">
					Select * from ictran where refno = '#xParam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#"> and trancode = '#xParam3#' and shipped < qty and type = 'QUO'
				</cfquery>

				<cfloop query="getbody">
                
                <cfquery name="getmultilocation" datasource="#dts#">
                select * from multilocupdatetemp where uuid='#listfirst(form.multilocuuid)#' and trancode='#getbody.trancode#' and type='#getbody.type#' and refno='#getbody.refno#' 
                </cfquery>
                <cfloop query="getmultilocation">
                
				  	<cfquery datasource="#dts#" name="getheader">
						Select currcode,custno,permitno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
				  	</cfquery>
					<cfif lcase(hcomid) eq "bnbm_i" or lcase(HcomID) eq "bnbp_i">
                    <cfquery datasource="#dts#" name="getleadaccountno">
						select accountno from #replace(dts,'_i','_c','all')#.lead where id='#getheader.permitno#'
				  	</cfquery>
                    <cfquery datasource="#dts#" name="getleadcustdetail">
						select * from #target_arcust# where custno='#getleadaccountno.accountno#'
				  	</cfquery>
                    </cfif>
                    
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
                    
                    <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>
					
					<!--- Add On 061008, 2nd Unit Function --->
					<!---<cfif val(getbody.factor1) neq 0>
						<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
					<cfelse>
						<cfset getbody.price_bil = 0>
					</cfif>--->
                    <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(getmultilocation.qty)* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(getmultilocation.qty)>
                </cfif>
					
					<cfset newamt1_bil = getmultilocation.qty * getbody.price_bil>
					
					<cfset newdamt_bil1 = (getbody.dispec1 / 100) * newamt1_bil>
					<cfset netamt = newamt1_bil - newdamt_bil1>
					<cfset newdamt_bil2 = (getbody.dispec2 / 100) * netamt>
					<cfset netamt = netamt - newdamt_bil2>
					<cfset newdamt_bil3 = (getbody.dispec3 / 100) * netamt>
					<cfset netamt = netamt - newdamt_bil3>
					
					<cfset newdamt_bil = newdamt_bil1 + newdamt_bil2 + newdamt_bil3>
					<cfif val(newdamt_bil) eq 0 and val(getbody.DISAMT_BIL) neq 0 and val(getbody.qty_bil) neq 0>
						<cfset newdamt_bil = val(getbody.DISAMT_BIL) * getmultilocation.qty / val(getbody.qty_bil)>
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
	                
	                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="" returnvariable="getbody.sodate"/>
	                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="" returnvariable="getbody.expdate"/>
	                
					<!--- QUO TO SO --->
					<cfquery datasource="#dts#" name="insertictran">
						Insert into ictran 
						(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
						`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
						`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
						`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`QUONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,
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
						`MC6_BIL`,`MC7_BIL`<cfif lcase(hcomid) eq "fdipx_i">,`JobOrderNo`</cfif>,`taxincl`,`note_a`
                        <cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">,`ictranfilename`</cfif>)
						values ('SO', '#nexttranno#', '#getbody.refno2#', '#j#', <cfif lcase(hcomid) eq "bnbm_i" or lcase(HcomID) eq "bnbp_i"><cfif getleadcustdetail.recordcount neq 0>'#getleadcustdetail.custno#'<cfelse>'#getbody.custno#'</cfif><cfelse>'#getbody.custno#'</cfif>, '#readperiod#',
						'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
	                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,
						'#getbody.agenno#',	<cfqueryparam cfsqltype="cf_sql_varchar" value="#getmultilocation.location#">,<cfif getgsetup.soautocreaproj eq 'Y'>'#nexttranno#'<cfelse>'#getbody.source#'</cfif>, '#getbody.job#', '', '#getmultilocation.qty#',
						'#getbody.price_bil#','#getbody.unit_bil#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
						'#newdamt_bil#', '#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#', '#newtaxamt_bil#',
						'', '#fulfillactual#', '#getbody.price#','#getbody.unit#', '#newamt1#', '#newdamt#', '#newamt#',
						'#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#', '#listgetat(mylist,i,";")#', '#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#getbody.sodate#', '#getmultilocation.brem1#', '#getbody.brem2#', '#getbody.brem3#', '#getbody.brem4#',
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
						'#listgetat(mylist,i,";")#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#', '#getbody.category#', '#getbody.Area#',
						'#getbody.Shelf#', '#getbody.Temp#', '#getbody.Temp1#', '', '0', '0', '0', '#getbody.Promoter#', '0', '#getbody.member#', '', #Now()#, 'Time',
						'#getbody.BOMNO#',
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
						  	'','#getbody.defective#',,'#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#'<cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">,'#getbody.ictranfilename#'</cfif>)
						</cfif>
					</cfquery>
					
                    <cfif getgsetup.soautocreaproj eq 'Y'>
                    <cfquery datasource='#dts#' name='insertnewproject'>
                    insert ignore into #target_project# (source,project,porj) values ('#nexttranno#','#nexttranno#','P')
                    </cfquery>
                    </cfif>
                    
					<!---<cfif getbody.batchcode neq "">
						<cfif getbody.location neq "">
							<cfquery name="updateobbatch" datasource="#dts#">
								update lobthob set bth_qut=(bth_qut+'#listgetat(form.fulfill,j)#')
								where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+'#listgetat(form.fulfill,j)#')
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						<cfelse>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+'#listgetat(form.fulfill,j)#')
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						</cfif>
					</cfif>--->
	
					<cfset qname='QOUT'&(readperiod+10)>
	
					<cfquery name="UpdateIcitem" datasource="#dts#">
						update icitem set #qname#=(#qname#+#getmultilocation.qty#) where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
					</cfquery>
	
					<cfquery name="inserticlink" datasource="#dts#">
						insert into iclink values ('so','#nexttranno#','#j#',
						'#ndatenow#','QUO','#listgetat(mylist,i,";")#','#getbody.trancode#',
						#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#getmultilocation.qty#')
					</cfquery>
	
					<cfset newship = getbody.shipped + listgetat(form.fulfill,z)>
	
					<cfquery datasource="#dts#" name="updateictran">
						Update ictran set shipped = '#newship#'
						where refno = '#xparam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and trancode = '#xparam3#'
						and toinv = '' and type = 'QUO'
					</cfquery>
					<!---
					<cfif form["grdcolumnlist_QUO_#xparam1#_#xParam3#"] neq "">
						<cfset grdcolumnlist = form["grdcolumnlist_QUO_#xparam1#_#xParam3#"]>
						<cfset bgrdcolumnlist = form["bgrdcolumnlist_QUO_#xparam1#_#xParam3#"]>
						<cfset grdvaluelist = form["grdvaluelist_QUO_#xparam1#_#xParam3#"]>
						<cfset totalrecord = form["totalrecord_QUO_#xparam1#_#xParam3#"]>
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
							('SO', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">, '#ndatenow#','#readperiod#','-1','','#getbody.location#','','',
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
							and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
						</cfquery>
					</cfif>--->
				 <cfset j = j + 1>
                </cfloop>
                </cfloop>
	
				<cfif listgetat(form.fulfill,z) gte listgetat(form.qtytoful,z)>
					<cfquery datasource="#dts#" name="updateartran">
						Update ictran set toinv = '#nexttranno#', generated = 'Y'
						where refno = '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#">
						and type = 'QUO' and trancode = '#xparam3#'
					</cfquery>
					
					<!--- Step 2:--->
					<!--- Add on 031008, For Graded Item --->
					<cfquery datasource="#dts#" name="updateigrade">
						Update igrade i, ictran ic 
						set i.generated = 'Y'
						where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
						and i.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#"> and i.trancode = '#xparam3#'
						and i.refno = '#xparam1#' and i.type = 'QUO'
					</cfquery>
				</cfif>

           <cfset z = z + 1>
            
			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#' and (shipped+writeoff) < qty and type = 'QUO'
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set toinv = '#nexttranno#', order_cl = 'Y', generated = 'Y'
					where refno = '#listgetat(mylist,i,";")#' and type = 'QUO'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lQUO# no: #listgetat(form.checkbox,i,";")#<cfif getGsetup.quochooseitem eq 1>,#listgetat(form.checkbox,i+1,";")# </cfif>is successfully updated to #gettranname.lSO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
		</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
		</cfquery>
        
        <cfif lcase(hcomid) eq "bnbm_i" or lcase(HcomID) eq "bnbp_i">
                    <cfquery datasource="#dts#" name="getleadaccountno">
						select accountno from #replace(dts,'_i','_c','all')#.lead where id='#getheader.permitno#'
				  	</cfquery>
                    <cfquery datasource="#dts#" name="getleadcustdetail">
						select * from #target_arcust# where custno='#getleadaccountno.accountno#'
				  	</cfquery>
         </cfif>

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
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
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
		
		<!--- QUO TO SO --->
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
			</cfif>,taxincl,e_mail,termscondition,country,d_country,postalcode,d_postalcode,B_GSTno,D_GSTno)

			values('SO','#nexttranno#','#getheader.refno2#',<cfif lcase(hcomid) eq "bnbm_i" or lcase(HcomID) eq "bnbp_i"><cfif getleadcustdetail.recordcount neq 0>'#getleadcustdetail.custno#'<cfelse>'#getheader.custno#'</cfif><cfelse>'#getheader.custno#'</cfif>,'#readperiod#','#ndatenow#',
			'#getheader.desp#','#getheader.despa#','#getheader.agenno#','#getheader.area#',<cfif getgsetup.soautocreaproj eq 'Y'>'#nexttranno#'<cfelse>'#getheader.source#'</cfif>,
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#','#getheader.term#','#getheader.van#',
			'#getheader.pono#',<cfif getheader.dono neq ''>'#getheader.dono#'<cfelse>'#updatepono#'</cfif>,'#updatepono#','#getheader.rem0#','#getheader.rem1#', '#getheader.rem2#','#getheader.rem3#',
			'#getheader.rem4#','#getheader.rem5#',
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			<cfif isdefined('form.remarks')><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.remarks#"><cfelse>'#getheader.rem11#'</cfif>, '#getheader.rem12#','#getheader.frem0#', '#getheader.frem1#', '#getheader.frem2#', '#getheader.frem3#', '#getheader.frem4#',
			'#getheader.frem5#', '#getheader.frem6#', '#getheader.frem7#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getheader.comm0#', '#getheader.comm1#', '#getheader.comm2#', '#getheader.comm3#', '#getheader.comm4#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.name#">,'#getheader.phonea#',
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
			</cfif>,'#getheader.taxincl#','#getheader.e_mail#','#getheader.termscondition#','#getheader.country#','#getheader.d_country#','#getheader.postalcode#','#getheader.d_postalcode#','#getheader.B_GSTno#','#getheader.D_GSTno#')
		</cfquery>

		<!---cfquery name="UpdateLastUsedNo" datasource="#dts#">
			update gsetup set sono='#nexttranno#'
		</cfquery--->
		
		<!--- <cfquery name="updategsetup" datasource="main">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where userDept = '#dts#'
			and type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
		
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=UPPER('#nexttranno#')
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
        
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
        
        </cfif>
		
        <cfif hcomid eq "bnbm_i" or hcomid eq "bnbp_i">
		<cfquery name="getsoitemlist" datasource="#dts#">
        select itemno,desp,qty,price,location from ictran where refno='#nexttranno#' and type='SO'
        </cfquery>
        <table width="70%">
        <tr>
        <th><div align="left">Item No</div></th>
        <th><div align="left">Description</div></th>
        <th><div align="right">Qty On Hand</div></th>
        <th><div align="right">Order Qty</div></th>
        <th><div align="right">Price</div></th>
        </tr>
        <cfoutput>
        <cfloop query="getsoitemlist">
        <cfif getsoitemlist.location neq ''>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(c.balance,0) as balance
                            
                            from icitem as a 
                            
                            left join 
                            (
                                select 
                                location,
                                itemno,
                                (select desp from iclocation where location=locqdbf.location) as locationdesp 
                                from locqdbf
                                where itemno=itemno 
                                and itemno='#itemno#' 
                                and location = '#getsoitemlist.location#'
                            ) as b on a.itemno=b.itemno 
                            
                            left join 
                            (
                                select 
                                a.location,
                                a.itemno,
                                (ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
                                
                                from locqdbf as a 
                                
                                left join
                                (
                                    select 
                                    location,
                                    itemno,
                                    sum(qty) as sum_in 
                                    
                                    from ictran
                                    
                                    where type in ('RC','CN','OAI','TRIN') 
                                    and fperiod<>'99'
                                    and itemno='#itemno#' 
                                    and location = '#getsoitemlist.location#'
                                    and (void = "" or void is null)
                                    and (linecode = "" or linecode is null)
                        
                                    group by location,itemno
                                    order by location,itemno
                                ) as b on a.location=b.location and a.itemno=b.itemno
                                
                                left join
                                (
                                    select 
                                    location,
                                    category,
                                    wos_group,
                                    itemno,
                                    sum(qty) as sum_out 
                                    
                                    from ictran 
                                    
                                    where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
                                    and (toinv='' or toinv is null) 
                                    and fperiod<>'99'
                                    and itemno='#itemno#' 
                                    and location = '#getsoitemlist.location#'
                                    and (void = "" or void is null)
                                    and (linecode = "" or linecode is null)
                                    group by location,itemno
                                    order by location,itemno
                                ) as c on a.location=c.location and a.itemno=c.itemno 
                                
                                where a.itemno=a.itemno
                                and a.itemno='#itemno#' 
                               and a.location = '#getsoitemlist.location#'
                                
                            ) as c on a.itemno=c.itemno and b.location=c.location 
                            
                            where a.itemno=a.itemno 
                            and b.location<>''
                        	and b.location = '#getsoitemlist.location#'
                            and a.itemno='#itemno#' 
                            order by a.itemno;
                            </cfquery>
                            <cfelse>
                            <cfquery name="getitemqtyonhand" datasource="#dts#">
                            select 
                            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
                            from icitem as a
                            
                            left join 
                            (
                                select itemno,sum(qty) as sumtotalin 
                                from ictran 
                                where type in ('RC','CN','OAI','TRIN') 
                                and itemno='#itemno#' 
                                and fperiod<>'99'
                                and (void = '' or void is null)
                                group by itemno
                            ) as b on a.itemno=b.itemno
                            
                            left join 
                            (
                                select itemno,sum(qty) as sumtotalout 
                                from ictran 
                                where type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
                                and itemno='#itemno#' 
                                and fperiod<>'99'
                                and (void = '' or void is null)
                                and toinv='' 
                                group by itemno
                            ) as c on a.itemno=c.itemno
                            
                            where a.itemno='#itemno#' 
                            </cfquery>
                            </cfif>
                            <cfif getitemqtyonhand.recordcount eq 0>
                            <cfset getitemqtyonhand.balance=0>
                            </cfif>
        
        
        <tr>
        <td>#getsoitemlist.itemno#</td>
        <td>#getsoitemlist.desp#</td>
        <td align="right">#getitemqtyonhand.balance#</td>
        <td align="right">#getsoitemlist.qty#</td>
        <td align="right">#numberformat(getsoitemlist.price,',_.__')#</td>
        </tr>
        </cfloop>
        </cfoutput>
        </table>
        </cfif>
		<cftry>
			<cfquery name="getheader_remark" datasource="#dts#">
				select 
				type,
				refno,
				cast(remark1 as binary) as remark1,
				cast(remark2 as binary) as remark2,
				cast(remark3 as binary) as remark3,
				cast(remark4 as binary) as remark4,
				cast(remark5 as binary) as remark5,
				cast(remark6 as binary) as remark6,
				cast(remark7 as binary) as remark7,
				cast(remark8 as binary) as remark8,
				cast(remark9 as binary) as remark9,
				cast(remark10 as binary) as remark10
				from artran_remark where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
			</cfquery>
			<cfif getheader_remark.recordcount neq 0>
				<cfquery name="insert_remark" datasource="#dts#">
					insert into artran_remark
					(type,refno,
					<cfloop from="1" to="10" index="z">
						remark#z#,
					</cfloop>USERID,LASTUSERID)
					values
					('SO','#nexttranno#',
					<cfloop from="1" to="10" index="z">
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getheader_remark["remark#z#"][1])#">,
					</cfloop>'#HUserID#','#HUserID#')
				</cfquery>
			</cfif>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
		<!----endmultilocation---->
        
        
        
        <cfelseif url.t1 eq "SAM">
		<cfset type = gettranname.lSAM>

		<cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>

		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>

		</cfif>

		<cfoutput><h2>#gettranname.lSAM# no: #listfirst(form.checkbox,";")# is successfully updated to #gettranname.lSO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>

		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset j = 1>
		<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>
        
        <cfif getGsetup.quochooseitem eq 1>
        <cfset stepcount = "+3" >
		<cfelse>
        <cfset stepcount = "+1" >
        </cfif>

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

			<cfquery datasource="#dts#" name="updateartran">
				Update artran set toinv = '#nexttranno#', order_cl ='Y', generated = 'Y' where refno = '#listgetat(mylist,i,";")#' and type = 'SAM'
			</cfquery>

			<cfquery datasource="#dts#" name="updateictran">
				Update ictran set toinv = '#nexttranno#', generated = 'Y' where refno = '#listgetat(mylist,i,";")#' and type = 'SAM'
			</cfquery>
			<!--- End of Update header --->
			
			<!--- Add on 031008 --->
            <!--- Start of Update igrade --->
			<cfquery datasource="#dts#" name="updateictran">
				Update igrade set generated = 'Y' where refno = '#listgetat(mylist,i,";")#' and type = 'SAM'
			</cfquery>
			<!--- End of Update igrade --->
			
			<!--- Start of Update body --->
            <cfif getGsetup.quochooseitem eq 1>
			<cfset xParam1 = listgetat(mylist,i,";")>

			<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
		  		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
		  		<cfset xParam2 = ''>
			<cfelse>
		  		<cfset xParam2 = listgetat(mylist,i+1,";")>
			</cfif>

			<cfset xParam3 = listgetat(mylist,i+2,";")>
			
			<cfquery datasource="#dts#" name="getbody">
		  		Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and shipped < qty and type = 'SAM'
			</cfquery>
            <cfelse>
            	<cfquery datasource="#dts#" name="getbody">
				Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = 'SAM' order by itemcount
			</cfquery>
            </cfif>
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
                
                <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>
                
                <!---- ---->
                <!---<cfif val(getbody.factor1) neq 0>
                	<cfif getbody.price_bil neq '#listgetat(pricebil,j)#'>
                    <cfset getbody.price_bil = '#listgetat(pricebil,j)#'>
					</cfif>
					<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
				<cfelse>
					<cfset getbody.price_bil = 0>
				</cfif>--->
                <cfif getbody.price_bil neq '#listgetat(pricebil,j)#'>
                    <cfset getbody.price_bil = '#listgetat(pricebil,j)#'>
					</cfif>
                <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
                
                
				<cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil>
				<cfset newdamt_bil1 = (getbody.dispec1 / 100) * newamt1_bil>
				<cfset netamt = newamt1_bil - newdamt_bil1>
				<cfset newdamt_bil2 = (getbody.dispec2 / 100) * netamt>
				<cfset netamt = netamt - newdamt_bil2>
				<cfset newdamt_bil3 = (getbody.dispec3 / 100) * netamt>
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
                
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.sodate#" returnvariable="getbody.sodate"/>
                
				<!--- SAM TO SO --->
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
					values ('SO', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
					'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,
					'#getbody.agenno#',	 '#getbody.location#', '#getbody.source#', '#getbody.job#', '', '#listgetat(form.fulfill,j)#', '#getbody.price_bil#',
						'#unit#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
						'#newdamt_bil#', '#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#',
						'#newtaxamt_bil#', '', '#fulfillactual#', '#getbody.price#', '#unit#',
						'#newamt1#', '#newdamt#', '#newamt#', '#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#',
						'#listgetat(mylist,i,";")#','#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#getbody.sodate#', '#brem1#', '#brem2#', '#brem3#', '#brem4#',
					<cfif lcase(hcomid) eq "avent_i">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
					<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
					</cfif>
					'#getbody.packing#', '#getbody.note1#', '#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N',
					'', '#getbody.grade#', '0.00','0.00',
					'0', '0', '#getbody.m_charge1#','#getbody.m_charge2#', '#getbody.adtcost1#', '#getbody.adtcost2#', '0', '0', '#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '', '0', '0', '0','#getbody.name#', '', '#getbody.van#', 'Y',
					'', '',	'', '0000-00-00', '', '0000-00-00', '', '', '', '', '#getbody.sono#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#',
					'#getbody.category#', '#getbody.area#', '#getbody.shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#',
					'0', '#member#', '', #Now()#, 'Time', '#getbody.bomno#',
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
					  	'','#getbody.defective#')
					</cfif>
				</cfquery>

				<cfset newship = getbody.qty - getbody.shipped>

				<cfquery name="inserticlink" datasource="#dts#">
					insert into iclink values ('SO','#nexttranno#','#j#',
					'#ndatenow#','SAM','#listgetat(mylist,i,";")#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#newship#')
				</cfquery>

				<cfquery datasource="#dts#" name="updateictran">
					Update ictran set shipped = '#newship#'
					where refno = '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and trancode = '#getbody.trancode#'
					and type = 'SAM'
				</cfquery>
				
				 <!--- Add on 031008 --->
        		<cfquery datasource="#dts#" name="getigrade">
					Select * from igrade where refno = '#listgetat(mylist,i,";")#' and type = 'SAM' 
                    and TRANCODE = '#getbody.trancode#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
				</cfquery>
        
        		<cfif getigrade.recordcount neq 0>
            		<cfquery name="insertigrade" datasource="#dts#">
                		insert into igrade
						(type,refno,trancode,itemno,wos_date,fperiod,sign,del_by,location,void,generated,custno,exported,factor1,factor2,
						<cfloop from="11" to="160" index="k">
							<cfif k neq 160>
								GRD#k#,
							<cfelse>
								GRD#k#
							</cfif>
						</cfloop>)
						values
						('SO','#nexttranno#','#j#', <cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.itemno#">,'#ndatenow#','#readperiod#',
						'-1','','#getigrade.location#','','',
						'#getigrade.custno#','','#getigrade.factor1#','#getigrade.factor2#',
						<cfloop from="11" to="160" index="k">
							<cfif k neq 160>
								#Evaluate("getigrade.GRD#k#")#,
							<cfelse>
								#Evaluate("getigrade.GRD#k#")#
							</cfif>
						</cfloop>)
                	</cfquery>
				</cfif>
				
				<cfset j = j +1>
			</cfloop>
		</cfloop>

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
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
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
		
		<!--- SAM TO SO --->
		<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,
			currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,
			tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax2,
			tax3,tax,taxp1,taxp2,taxp3,grand,note,term,van,pono,dono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
			rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
			trdatetime,userid,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49
			<cfif lcase(hcomid) eq 'iel_i'>
				,rem15,rem16,rem17,rem18,rem19,rem20,rem21,rem22,rem23,rem24,rem25
			</cfif>,taxincl)

			values('SO','#nexttranno#','#getheader.refno2#','#getheader.custno#','#readperiod#','#ndatenow#',
			'#getheader.desp#','#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#','#getheader.term#','#getheader.van#',
			'#getheader.pono#',<cfif getheader.dono neq ''>'#getheader.dono#'<cfelse>'#updatepono#'</cfif>,'#getheader.rem0#','#getheader.rem1#', '#getheader.rem2#','#getheader.rem3#',
			'#getheader.rem4#','#getheader.rem5#',
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			'#getheader.rem11#', '#getheader.rem12#','#getheader.frem0#', '#getheader.frem1#', '#getheader.frem2#', '#getheader.frem3#', '#getheader.frem4#',
			'#getheader.frem5#', '#getheader.frem6#', '#getheader.frem7#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getheader.comm0#', '#getheader.comm1#', '#getheader.comm2#', '#getheader.comm3#', '#getheader.comm4#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.name#">,'#getheader.phonea#',
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
			</cfif>,'#getheader.taxincl#')
		</cfquery>

		<!---cfquery name="UpdateLastUsedNo" datasource="#dts#">
			update gsetup set sono='#nexttranno#'
		</cfquery--->
		
		<!--- <cfquery name="updategsetup" datasource="main">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where userDept = '#dts#'
			and type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
        
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=UPPER('#nexttranno#')
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
		
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
        
        </cfif>
		
		<cftry>
			<cfquery name="getheader_remark" datasource="#dts#">
				select 
				type,
				refno,
				cast(remark1 as binary) as remark1,
				cast(remark2 as binary) as remark2,
				cast(remark3 as binary) as remark3,
				cast(remark4 as binary) as remark4,
				cast(remark5 as binary) as remark5,
				cast(remark6 as binary) as remark6,
				cast(remark7 as binary) as remark7,
				cast(remark8 as binary) as remark8,
				cast(remark9 as binary) as remark9,
				cast(remark10 as binary) as remark10
				from artran_remark where refno = '#listgetat(mylist,1,";")#' and type = 'SAM'
			</cfquery>
			<cfif getheader_remark.recordcount neq 0>
				<cfquery name="insert_remark" datasource="#dts#">
					insert into artran_remark
					(type,refno,
					<cfloop from="1" to="10" index="z">
						remark#z#,
					</cfloop>USERID,LASTUSERID)
					values
					('SO','#nexttranno#',
					<cfloop from="1" to="10" index="z">
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#tostring(getheader_remark["remark#z#"][1])#">,
					</cfloop>'#HUserID#','#HUserID#')
				</cfquery>
			</cfif>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
        
        
        
	<cfelseif url.t1 eq "QUO" and lcase(HcomID) eq "steel_i">
		<cfset type = gettranname.lQUO>

		<!---cfquery datasource="#dts#" name="updategsetup">
			Update Gsetup set sono =UPPER("#nexttranno#")
		</cfquery--->
		<!--- <cfquery name="updategsetup" datasource="main">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where userDept = '#dts#'
			and type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery> --->
		
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=UPPER('#nexttranno#')
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=UPPER('#nexttranno#')
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
		</cfif>
		<cfoutput><h2>#gettranname.lQUO# no: #listfirst(form.checkbox,";")# is successfully updated to #gettranname.lSO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>

		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset j = 1>
		<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>

		<cfloop from="1" to="#cnt#" index="i" step="+3">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

				<cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>
			
			<cfoutput>QUO No. : #listgetat(mylist,i,";")# <br></cfoutput>
			<cfset xParam1 = listgetat(mylist,i,";")>

			<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			  	<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  	<cfset xParam2 = ''>
			<cfelse>
			  	<cfset xParam2 = listgetat(mylist,i+1,";")>
			</cfif>

			<cfset xParam3 = listgetat(mylist,i+2,";")>

			<cfquery datasource="#dts#" name="getbody">
				Select * from ictran where refno = '#xParam1#' and itemno = '#xParam2#' and trancode = '#xParam3#' and shipped < qty and type = 'QUO'
			</cfquery>

			<cfquery datasource="#dts#" name="getcust">
				Select * from #target_arcust# where custno='#getbody.custno#'
			</cfquery>

			<cfloop query="getbody">
			  	<cfquery datasource="#dts#" name="getheader">
					Select currcode,custno from artran where refno='#listgetat(mylist,1,";")#' and type = 'QUO'
			  	</cfquery>

				<cfif getheader.currcode eq ''>
					<cfquery name="getcurrcode" datasource="#dts#">
						select currcode from #ptype# where custno='#getheader.custno#'
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
                
                <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>

				<!--- Add On 061008, 2nd Unit Function --->
				<!---<cfif val(getbody.factor1) neq 0>
					<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
				<cfelse>
					<cfset getbody.price_bil = 0>
				</cfif>--->
                <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
                
                
				<cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil>
				<cfset newdamt_bil1 = (getbody.dispec1 / 100) * newamt1_bil>
				<cfset netamt = newamt1_bil - newdamt_bil1>
				<cfset newdamt_bil2 = (getbody.dispec2 / 100) * netamt>
				<cfset netamt = netamt - newdamt_bil2>
				<cfset newdamt_bil3 = (getbody.dispec3 / 100) * netamt>
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
				<!--- QUO TO SO and lcase(HcomID) eq "steel_i" --->
                
                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
				
				<cfquery name="getItemBody" datasource="#dts#">
					select itemno,desp,despa from icitem where itemno='#listgetat(newitemno,j)#'
				</cfquery>

				<cfquery datasource="#dts#" name="insertictran">
					Insert into ictran 
					(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
					`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
					`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
					`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,`PACKING`,`NOTE1`,
					`NOTE2`,`GLTRADAC`,`UPDCOST`,`GST_ITEM`,`TOTALUP`,`WITHSN`,`GRADE`,`PUR_PRICE`,
					`QTY_RET`,`TEMPFIGI`,`SERCOST`,`M_CHARGE1`,`M_CHARGE2`,`ADTCOST1`,`ADTCOST2`,`IT_COS`,`AV_COST`,
					`BATCHCODE`,`EXPDATE`,`POINT`,`INV_DISC`,`INV_TAX`,`SUPP`,`EDI_COU1`,`WRITEOFF`,`TOSHIP`,`SHIPPED`,`NAME`,`DEL_BY`,
					`VAN`,`GENERATED`,`UD_QTY`,`TOINV`,`EXPORTED`,`EXPORTED1`,`EXPORTED2`,`EXPORTED3`,`BRK_TO`,`SV_PART`,`LAST_YEAR`,
					`VOID`,`SONO`,`MC1_BIL`,`MC2_BIL`,`USERID`,`DAMT`,`OLDBILL`,`WOS_GROUP`,`CATEGORY`,`AREA`,`SHELF`,`TEMP`,`TEMP1`,
					`BODY`,`TOTALGROUP`,`MARK`,`TYPE_SEQ`,`PROMOTER`,`TABLENO`,`MEMBER`,`TOURGROUP`,`TRDATETIME`,`TIME`,`BOMNO`,
					`NODISPLAY`,`TITLE_ID`,`TITLE_DESP`,<cfif lcase(hcomid) eq "topsteel_i">`TITLE_DESPA`,</cfif>
					`COMMENT`,`DEFECTIVE`,`M_CHARGE3`,`M_CHARGE4`,`M_CHARGE5`,`M_CHARGE6`,`M_CHARGE7`,`MC3_BIL`,`MC4_BIL`,`MC5_BIL`,
					`MC6_BIL`,`MC7_BIL`<cfif lcase(hcomid) eq "fdipx_i">,`JobOrderNo`</cfif>,`taxincl`,`note_a`)
					values ('SO', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
					'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfif listgetat(newitemno,j) neq "-1">'#getItemBody.itemno#', '#getItemBody.desp#', '#getItemBody.despa#'<cfelse>'#getbody.itemno#', '#getbody.desp#', '#getbody.despa#'</cfif>, 
					'#agenno#',	 '#getbody.location#', '#getbody.source#', '#getbody.job#', '', '#listgetat(form.fulfill,j)#',
					'#getbody.price_bil#', '#getbody.unit_bil#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
					'#newdamt_bil#','#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#', '#newtaxamt_bil#', '',
					'#fulfillactual#', '#getbody.price#',
					'#unit#', '#newamt1#', '#newdamt#', '#newamt#', '#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#', '',
					'#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#dateformat(getbody.wos_date,"yyyy-mm-dd")#',
					<cfif lcase(HcomID) eq "floprints_i">'','','',''<cfelse>'#brem1#','#brem2#','#brem3#','#brem4#'</cfif>,
					'#getbody.packing#', '#getbody.note1#',
					'#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N', '', '#getbody.grade#', '0.00',
					'0.00', '0', '0', '#getbody.m_charge1#', '#getbody.m_charge2#', '#getbody.adtcost1#', '#getbody.adtcost2#', '0', '0',	'#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '',
					'0', '0', '0',	'#name#', '0', '#van#', 'Y', '', '', '', '0000-00-00', '', '0000-00-00', '', '', '', '',
					'#listgetat(mylist,i,";")#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#', '#getbody.category#',
					'#Area#', '#Shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#', '0',
					'#member#', '', #Now()#, 'Time', '#BOMNO#',
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
					  	'','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
					</cfif>
				</cfquery>

				<!---SAM TO SO NO NEED
				<cfif getbody.batchcode neq "">
					<cfif getbody.location neq "">
						<cfquery name="updateobbatch" datasource="#dts#">
							update lobthob set bth_qut=(bth_qut+'#listgetat(form.fulfill,j)#')
							where location='#getbody.location#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
						</cfquery>
						<cfquery name="updateobbatch" datasource="#dts#">
							update obbatch set bth_qut=(bth_qut+'#listgetat(form.fulfill,j)#')
							where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode='#getbody.batchcode#'
						</cfquery>
					<cfelse>
						<cfquery name="updateobbatch" datasource="#dts#">
							update obbatch set bth_qut=(bth_qut+'#listgetat(form.fulfill,j)#')
							where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode='#getbody.batchcode#'
						</cfquery>
					</cfif>
				</cfif>--->

				<cfquery name="inserticlink" datasource="#dts#">
					insert into iclink values ('SO','#nexttranno#','#j#',
					'#ndatenow#','QUO','#listgetat(mylist,i,";")#','#getbody.trancode#',
					#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#val(listgetat(form.fulfill,j))#')
				</cfquery>

				<cfset newship = getbody.shipped + val(listgetat(form.fulfill,j))>

				<cfquery datasource="#dts#" name="updateictran">
					Update ictran set shipped = '#newship#'
					where refno = '#xparam1#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and trancode = '#xparam3#'
					and type='QUO'
				</cfquery>
				
				<!--- Start: Add on 051008, graded item --->
				<!--- <cfif Evaluate("form.grdcolumnlist_QUO_#xparam1#_#xParam3#") neq ""> --->
				<cfif form["grdcolumnlist_QUO_#xparam1#_#xParam3#"] neq "">
					<!--- <cfset grdcolumnlist = Evaluate("form.grdcolumnlist_QUO_#xparam1#_#xParam3#")>
					<cfset bgrdcolumnlist = Evaluate("form.bgrdcolumnlist_QUO_#xparam1#_#xParam3#")>
					<cfset grdvaluelist = Evaluate("form.grdvaluelist_QUO_#xparam1#_#xParam3#")>
					<cfset totalrecord = Evaluate("form.totalrecord_QUO_#xparam1#_#xParam3#")> --->
					<cfset grdcolumnlist = form["grdcolumnlist_QUO_#xparam1#_#xParam3#"]>
					<cfset bgrdcolumnlist = form["bgrdcolumnlist_QUO_#xparam1#_#xParam3#"]>
					<cfset grdvaluelist = form["grdvaluelist_QUO_#xparam1#_#xParam3#"]>
					<cfset totalrecord = form["totalrecord_QUO_#xparam1#_#xParam3#"]>
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
						('SO', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">, '#ndatenow#','#readperiod#','1','','#getbody.location#','','',
						'#getbody.custno#','','1', '1',
						<cfloop from="1" to="#totalrecord#" index="k">
							<cfif k neq totalrecord>
								#myArray2[k]#,
							<cfelse>
								#myArray2[k]#
							</cfif>
						</cfloop>)
					</cfquery>
			
				</cfif>
				<!--- End: Add on 051008, graded item --->
			</cfloop>

			<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
				<cfquery datasource="#dts#" name="updateartran">
					Update ictran set toinv = '#nexttranno#', generated = 'Y'
					where refno = '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#">
					and toinv='' and type='QUO' and trancode = '#xparam3#'
				</cfquery>
				
				<!--- Step 2:--->
				<!--- Add on 051008, For Graded Item --->
				<cfquery datasource="#dts#" name="updateigrade">
					Update igrade i, ictran ic 
					set i.generated = 'Y'
					where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
					and i.refno = '#xparam1#' and i.itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and i.trancode = '#xparam3#'
					and ic.toinv = '' and i.type = 'QUO'
				</cfquery>
			</cfif>

			<cfset j = j + 1>

			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#' and (shipped+writeoff) < qty and type = 'QUO'
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartran" datasource="#dts#">
					update artran set toinv = '#nexttranno#', order_cl = 'Y', generated = 'Y' where refno = '#listgetat(mylist,i,";")#' and type='QUO'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lQUO# no: #listgetat(mylist,i,";")#,#listgetat(mylist,i+1,";")# is successfully updated to #gettranname.lSO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
		</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
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
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
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
		<!--- Create a new transaction --->
		<!--- QUO TO SO --->
		<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,
			currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,
			tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax2,
			tax3,tax,taxp1,taxp2,taxp3,grand,note,term,van,pono,dono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
			rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
			trdatetime,userid,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on,taxincl,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49,termscondition,country,d_country,postalcode,d_postalcode,B_GSTno,D_GSTno
)

			values('SO','#nexttranno#','#getheader.refno2#','#getheader.custno#','#readperiod#','#ndatenow#',
			'#getheader.desp#','#getheader.despa#','#getheader.agenno#','#getheader.area#',<cfif getgsetup.soautocreaproj eq 'Y'>'#nexttranno#'<cfelse>'#getheader.source#'</cfif>,
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#','#getheader.term#','#getheader.van#',
			<cfif getheader.pono neq ''>'#getheader.pono#'<cfelse>'#updatepono#'</cfif>,'#getheader.dono#','#updatepono#','#getheader.rem0#','#getheader.rem1#', '#getheader.rem2#','#getheader.rem3#',
			'#getheader.rem4#','#getheader.rem5#',
			'#getheader.rem6#', '#getheader.rem7#', '#getheader.rem8#', '#getheader.rem9#', '#getheader.rem10#',
			'#getheader.rem11#', '#getheader.rem12#','#getheader.frem0#', '#getheader.frem1#', '#getheader.frem2#', '#getheader.frem3#', '#getheader.frem4#',
			'#getheader.frem5#', '#getheader.frem6#', '#getheader.frem7#', '<cfif lcase(HcomID) eq "hco_i">#tostring(getheader.frem8)#<cfelse>#getheader.frem8#</cfif>', '#getheader.frem9#',
			'#getheader.comm0#', '#getheader.comm1#', '#getheader.comm2#', '#getheader.comm3#', '#getheader.comm4#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheader.name#">,'#getheader.phonea#',
			#Now()#, '#HUserID#','#getheader.currcode#',
			'#getheader.m_charge1#','#getheader.m_charge2#','#getheader.m_charge3#','#getheader.m_charge4#','#getheader.m_charge5#','#getheader.m_charge6#','#getheader.m_charge7#',
			'#getheader.mc1_bil#','#getheader.mc2_bil#','#getheader.mc3_bil#','#getheader.mc4_bil#','#getheader.mc5_bil#','#getheader.mc6_bil#','#getheader.mc7_bil#','#getheader.special_account_code#',
			'#HUserID#',#now()#,'#HUserID#',#now()#,'#getheader.taxincl#'
,'#getheader.rem30#', '#getheader.rem31#', '#getheader.rem32#', '#getheader.rem33#', '#getheader.rem34#', '#getheader.rem35#', '#getheader.rem36#', '#getheader.rem37#', '#getheader.rem38#', '#getheader.rem39#', '#getheader.rem40#', '#getheader.rem41#', '#getheader.rem42#', '#getheader.rem43#', '#getheader.rem44#', '#getheader.rem45#', '#getheader.rem46#', '#getheader.rem47#', '#getheader.rem48#', '#getheader.rem49#','#getheader.termscondition#','#getheader.country#','#getheader.d_country#','#getheader.postalcode#','#getheader.d_postalcode#','#getheader.B_GSTno#','#getheader.D_GSTno#')
		</cfquery>
	</cfif>
<!--- t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS t2 = CS --->
<cfelseif url.t2 eq "CS">
	<h1>Update to <cfoutput>#gettranname.lCS#</cfoutput></h1>
	
	<!--- t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO t1 = QUO --->
	<cfif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
		</cfif>
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>
		<cfset j = 1>
		
		<cfif getGsetup.quochooseitem eq 1>
        	<cfset stepcount = "+3" >
		<cfelse>
        	<cfset stepcount = "+1" >
        </cfif>

		<cfloop from="1" to="#cnt#" index="i" step="#stepcount#">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

			  <cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>QUO No. : #listgetat(mylist,i,";")# <br></cfoutput>
			
			<!--- Start of Update body --->
            <cfif getGsetup.quochooseitem eq 1>
				<cfset xParam1 = listgetat(mylist,i,";")>

				<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			  		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  		<cfset xParam2 = ''>
				<cfelse>
			  		<cfset xParam2 = listgetat(mylist,i+1,";")>
				</cfif>

				<cfset xParam3 = listgetat(mylist,i+2,";")>
			
				<cfquery datasource="#dts#" name="getbody">
					Select * from ictran where refno = '#xParam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#"> and trancode = '#xParam3#' and shipped < qty and type = 'QUO'
				</cfquery>

				<cfloop query="getbody">
				  	<cfquery datasource="#dts#" name="getheader">
						Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
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
                    
                    <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>
					
					<!--- Add On 061008, 2nd Unit Function --->
					<!---<cfif val(getbody.factor1) neq 0>
						<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
					<cfelse>
						<cfset getbody.price_bil = 0>
					</cfif>--->
                    <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
					
					<cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil>
					
					<cfset newdamt_bil1 = (getbody.dispec1 / 100) * newamt1_bil>
					<cfset netamt = newamt1_bil - newdamt_bil1>
					<cfset newdamt_bil2 = (getbody.dispec2 / 100) * netamt>
					<cfset netamt = netamt - newdamt_bil2>
					<cfset newdamt_bil3 = (getbody.dispec3 / 100) * netamt>
					<cfset netamt = netamt - newdamt_bil3>
					
					<cfset newdamt_bil = newdamt_bil1 + newdamt_bil2 + newdamt_bil3>
					<cfif val(newdamt_bil) eq 0 and val(getbody.DISAMT_BIL) neq 0 and val(getbody.qty_bil) neq 0>
						<cfset newdamt_bil = val(getbody.DISAMT_BIL) * val(listgetat(fulfill,j)) / val(getbody.qty_bil)>
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
	                
					<!--- QUO TO CS --->
					<cfquery datasource="#dts#" name="insertictran">
						Insert into ictran 
						(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
						`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
						`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
						`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`QUONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,
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
						values ('CS', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
						'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
	                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,
						'#agenno#',	<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">, '#getbody.source#', '#getbody.job#', '', '#listgetat(form.fulfill,j)#',
						'#getbody.price_bil#','#getbody.unit_bil#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
						'#newdamt_bil#', '#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#', '#newtaxamt_bil#',
						'', '#fulfillactual#', '#getbody.price#','#getbody.unit#', '#newamt1#', '#newdamt#', '#newamt#',
						'#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#', '#listgetat(mylist,i,";")#', '#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#getbody.sodate#', '#brem1#', '#brem2#', '#brem3#', '#brem4#',
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
						'#listgetat(mylist,i,";")#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#', '#getbody.category#', '#Area#',
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
								update lobthob set bth_qut=(bth_qut+'#fulfillactual#')
								where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+'#fulfillactual#')
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						<cfelse>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+'#fulfillactual#')
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						</cfif>
					</cfif>
	
					<cfset qname='QOUT'&(readperiod+10)>
	
					<cfquery name="UpdateIcitem" datasource="#dts#">
						update icitem set #qname#=(#qname#+#fulfillactual#) where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
					</cfquery>
	
					<cfquery name="inserticlink" datasource="#dts#">
						insert into iclink values ('CS','#nexttranno#','#j#',
						'#ndatenow#','QUO','#listgetat(mylist,i,";")#','#getbody.trancode#',
						#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#val(listgetat(form.fulfill,j))#')
					</cfquery>
	
					<cfset newship = getbody.shipped + val(listgetat(form.fulfill,j))>
	
					<cfquery datasource="#dts#" name="updateictran">
						Update ictran set shipped = '#newship#'
						where refno = '#xparam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and trancode = '#xparam3#'
						and toinv = '' and type = 'QUO'
					</cfquery>
					
					<cfif form["grdcolumnlist_QUO_#xparam1#_#xParam3#"] neq "">
						<cfset grdcolumnlist = form["grdcolumnlist_QUO_#xparam1#_#xParam3#"]>
						<cfset bgrdcolumnlist = form["bgrdcolumnlist_QUO_#xparam1#_#xParam3#"]>
						<cfset grdvaluelist = form["grdvaluelist_QUO_#xparam1#_#xParam3#"]>
						<cfset totalrecord = form["totalrecord_QUO_#xparam1#_#xParam3#"]>
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
							('CS', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">, '#ndatenow#','#readperiod#','-1','','#getbody.location#','','',
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
							and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
						</cfquery>
					</cfif>
				</cfloop>
	
				<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
					<cfquery datasource="#dts#" name="updateartran">
						Update ictran set toinv = '#nexttranno#', generated = 'Y'
						where refno = '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#">
						and type = 'QUO' and trancode = '#xparam3#'
					</cfquery>
					
					<!--- Step 2:--->
					<!--- Add on 031008, For Graded Item --->
					<cfquery datasource="#dts#" name="updateigrade">
						Update igrade i, ictran ic 
						set i.generated = 'Y'
						where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
						and i.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#"> and i.trancode = '#xparam3#'
						and i.refno = '#xparam1#' and i.type = 'QUO'
					</cfquery>
				</cfif>
            <cfelse>
            	<cfquery datasource="#dts#" name="getbody">
					Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = 'QUO' order by itemcount
				</cfquery>
				<cfloop query="getbody">
				  	<!--- GET LATEST CURRRATE --->
				  	<cfquery datasource="#dts#" name="getheader">
						Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
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
						<cfset newcurrate = val(currency.rate)>
					<cfelse>
						<cfset newcurrate = 1><!--- default --->
					</cfif>
                    
                    <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>
	
					<cfset newamt1_bil = val(getbody.qty_bil) * val(getbody.price_bil)>
					<cfset newdamt_bil1 = (val(getbody.dispec1) / 100) * val(newamt1_bil)>
					<cfset netamt = val(newamt1_bil) - val(newdamt_bil1)>
					<cfset newdamt_bil2 = (val(getbody.dispec2) / 100) * val(netamt)>
					<cfset netamt = val(netamt) - val(newdamt_bil2)>
					<cfset newdamt_bil3 = (val(getbody.dispec3) / 100) * val(netamt)>
					<cfset netamt = val(netamt) - val(newdamt_bil3)>
	
					<cfset newdamt_bil = val(newdamt_bil1) + val(newdamt_bil2) + val(newdamt_bil3)>
					<cfset newtaxamt_bil = (val(getbody.taxpec1) / 100) * (val(newamt1_bil) - val(newdamt_bil))>
					<!--- <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil) + val(newtaxamt_bil)> --->
	                <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil)>
					<cfset newamt_bil = numberformat(val(newamt_bil),".__")>
					<cfset newprice = val(getbody.price_bil) * val(newcurrate)>
	
					<cfset newamt1 = val(newamt1_bil) * val(newcurrate)>
					<cfset newdamt = val(newdamt_bil) * val(newcurrate)>
					<cfset newtaxamt = val(newtaxamt_bil) * val(newcurrate)>
					<cfset newamt = val(newamt_bil) * val(newcurrate)>
					<cfset newamt = numberformat(val(newamt),".__")>
	
					<cfset gross_bil = val(gross_bil) + val(newamt_bil)>
					<cfset gross = val(gross_bil) * val(newcurrate)>
	                
	                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
						
					<!--- QUO TO CS --->
					<cfquery datasource="#dts#" name="insertictran">
						Insert into ictran 
						(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
						`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
						`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
						`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`QUONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,
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
						values ('CS', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
						'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
	                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,	
						'#getbody.agenno#',	 <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">, '#getbody.source#', '#getbody.job#', '',
						'#getbody.qty_bil#', '#getbody.price_bil#',	'#getbody.unit_bil#', '#newamt1_bil#', '#val(getbody.dispec1)#',
						'#val(getbody.dispec2)#', '#val(getbody.dispec3)#', '#newdamt_bil#', '#newamt_bil#', '#val(getbody.taxpec1)#',
						'#val(getbody.taxpec2)#', '#val(getbody.taxpec3)#', '#newtaxamt_bil#', '', '#getbody.qty#', '#newprice#',
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.unit#">, '#newamt1#', '#newdamt#',	'#newamt#', '#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#',
						'#listgetat(mylist,i,";")#','#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#dateformat(getbody.wos_date,"yyyy-mm-dd")#', '#getbody.brem1#', '#getbody.brem2#', '#getbody.brem3#',
						'#getbody.brem4#', 
						<cfif lcase(hcomid) eq "avent_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
						<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
						</cfif>
						'#getbody.packing#', '#getbody.note1#', '#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N',
						'', '#getbody.grade#', '0.00','0.00','0',
						'0', '#getbody.m_charge1#', '#getbody.m_charge2#', '#getbody.adtcost1#', '#getbody.adtcost2#', '0', '0', '#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '', '0', '0', '0','#getbody.name#', '', '#getbody.van#', 'Y',
						'', '',	'', '0000-00-00', '', '0000-00-00', '', '', '', '', '#getbody.sono#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#',
						'#getbody.category#', '#getbody.area#', '#getbody.shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#',
						'0', '#member#', '', #Now()#, 'Time', '#getbody.bomno#',
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
						  '','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						</cfif>
					</cfquery>
					
					
					<cfif getbody.batchcode neq "">
						<cfif getbody.location neq "">
							<cfquery name="updateobbatch" datasource="#dts#">
								update lobthob set bth_qut=(bth_qut+#getbody.qty#)
								where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+#getbody.qty#)
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						<cfelse>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+#getbody.qty#)
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						</cfif>
					</cfif>
	
					<cfset qname='QOUT'&(readperiod+10)>
	
					<cfquery name="UpdateIcitem" datasource="#dts#">
						update icitem set #qname#=(#qname#+#getbody.qty#) where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
					</cfquery>
	
					<cfquery name="inserticlink" datasource="#dts#">
						insert into iclink values ('CS','#nexttranno#','#j#',
						'#ndatenow#','QUO','#listgetat(mylist,i,";")#','#getbody.trancode#',
						#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#getbody.qty_bil#')
					</cfquery>
					
					<!--- Add on 031008 --->
	        		<cfquery datasource="#dts#" name="getigrade">
						Select * from igrade where refno = '#listgetat(mylist,i,";")#' and type = 'QUO' 
	                    and TRANCODE = '#getbody.trancode#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
					</cfquery>
					
					<cfif getigrade.recordcount neq 0>
	            		<cfquery name="insertigrade" datasource="#dts#">
	                		insert into igrade
							(type,refno,trancode,itemno,wos_date,fperiod,sign,del_by,location,void,generated,custno,exported,factor1,factor2,
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									GRD#k#,
								<cfelse>
									GRD#k#
								</cfif>
							</cfloop>)
							values
							('CS','#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.itemno#">,'#ndatenow#','#readperiod#',
							'-1','',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.location#">,'','',
							'#getigrade.custno#','','#getigrade.factor1#','#getigrade.factor2#',
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>)
	                	</cfquery>
	                	<cfquery name="updateitemgrd" datasource="#dts#">
							update itemgrd
							set
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
						</cfquery>
					
						<cfquery name="updatelogrdob" datasource="#dts#">
							update logrdob
							set
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
							and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
						</cfquery>
					</cfif>
					
					<cfset j = j + 1>
				</cfloop>
            </cfif>

			<cfset j = j + 1>
			<cfif getGsetup.quochooseitem neq 1>
				<cfquery datasource="#dts#" name="updateictran">
					Update ictran 
					set shipped = qty,
					toinv='#nexttranno#'
					where refno =  '#listgetat(mylist,i,";")#'
					and toinv = '' and type = 'QUO'
				</cfquery>
			</cfif>
			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#' and (shipped+writeoff) < qty and type = 'QUO'
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set toinv = '#nexttranno#', order_cl = 'Y', generated = 'Y'
					where refno = '#listgetat(mylist,i,";")#' and type = 'QUO'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lQUO# no: #listgetat(form.checkbox,i,";")#<cfif getGsetup.quochooseitem eq 1>,#listgetat(form.checkbox,i+1,";")# </cfif>is successfully updated to #gettranname.lCS# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
		</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
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
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
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
		<cfset net = net_bil * newcurrate>        
		
		<cfif getheader.taxincl neq "T">
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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
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
		<!--- QUO TO CS --->
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

			values('CS','#nexttranno#','#getheader.refno2#','#getheader.custno#','#readperiod#','#ndatenow#',
			'CASH SALES','#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#',	'#getheader.term#','#getheader.van#',
			'#getheader.pono#',<cfif getheader.dono neq ''>'#getheader.dono#'<cfelse>'#updatepono#'</cfif>,'#updatepono#','#getheader.rem0#','#getheader.rem1#','#getheader.rem2#','#getheader.rem3#',
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
		
		<cftry>
			<cfquery name="getheader_remark" datasource="#dts#">
				select 
				type,
				refno,
				cast(remark1 as binary) as remark1,
				cast(remark2 as binary) as remark2,
				cast(remark3 as binary) as remark3,
				cast(remark4 as binary) as remark4,
				cast(remark5 as binary) as remark5,
				cast(remark6 as binary) as remark6,
				cast(remark7 as binary) as remark7,
				cast(remark8 as binary) as remark8,
				cast(remark9 as binary) as remark9,
				cast(remark10 as binary) as remark10
				from artran_remark where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
			</cfquery>
			<cfif getheader_remark.recordcount neq 0>
				<cfquery name="insert_remark" datasource="#dts#">
					insert into artran_remark
					(type,refno,
					<cfloop from="1" to="10" index="z">
						remark#z#,
					</cfloop>USERID,LASTUSERID)
					values
					('CS','#nexttranno#',
					<cfloop from="1" to="10" index="z">
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#getheader_remark["remark#z#"][1]#">,
					</cfloop>'#HUserID#','#HUserID#')
				</cfquery>
			</cfif>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
        
        <!--- t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO t1 = SO --->
	<cfelseif url.t1 eq "SO">
		<cfset type = gettranname.lSO>
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
		</cfif>
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>
		<cfset j = 1>
		
		<cfif getGsetup.quochooseitem eq 1>
        	<cfset stepcount = "+3" >
		<cfelse>
        	<cfset stepcount = "+1" >
        </cfif>

		<cfloop from="1" to="#cnt#" index="i" step="#stepcount#">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

			  <cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>QUO No. : #listgetat(mylist,i,";")# <br></cfoutput>
			
			<!--- Start of Update body --->
            <cfif getGsetup.quochooseitem eq 1>
				<cfset xParam1 = listgetat(mylist,i,";")>

				<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			  		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  		<cfset xParam2 = ''>
				<cfelse>
			  		<cfset xParam2 = listgetat(mylist,i+1,";")>
				</cfif>

				<cfset xParam3 = listgetat(mylist,i+2,";")>
			
				<cfquery datasource="#dts#" name="getbody">
					Select * from ictran where refno = '#xParam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#"> and trancode = '#xParam3#' and shipped < qty and type = 'SO'
				</cfquery>

				<cfloop query="getbody">
				  	<cfquery datasource="#dts#" name="getheader">
						Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SO'
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
                    
                    <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>
					
					<!--- Add On 061008, 2nd Unit Function --->
					<!---<cfif val(getbody.factor1) neq 0>
						<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
					<cfelse>
						<cfset getbody.price_bil = 0>
					</cfif>--->
                    <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
					
					<cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil>
					
					<cfset newdamt_bil1 = (getbody.dispec1 / 100) * newamt1_bil>
					<cfset netamt = newamt1_bil - newdamt_bil1>
					<cfset newdamt_bil2 = (getbody.dispec2 / 100) * netamt>
					<cfset netamt = netamt - newdamt_bil2>
					<cfset newdamt_bil3 = (getbody.dispec3 / 100) * netamt>
					<cfset netamt = netamt - newdamt_bil3>
					
					<cfset newdamt_bil = newdamt_bil1 + newdamt_bil2 + newdamt_bil3>
					<cfif val(newdamt_bil) eq 0 and val(getbody.DISAMT_BIL) neq 0 and val(getbody.qty_bil) neq 0>
						<cfset newdamt_bil = val(getbody.DISAMT_BIL) * val(listgetat(fulfill,j)) / val(getbody.qty_bil)>
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
	                
					<!--- SO TO CS --->
					<cfquery datasource="#dts#" name="insertictran">
						Insert into ictran 
						(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
						`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
						`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
						`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`QUONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,
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
						values ('CS', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
						'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
	                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,
						'#agenno#',	<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">, '#getbody.source#', '#getbody.job#', '', '#listgetat(form.fulfill,j)#',
						'#getbody.price_bil#','#getbody.unit_bil#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
						'#newdamt_bil#', '#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#', '#newtaxamt_bil#',
						'', '#fulfillactual#', '#getbody.price#','#getbody.unit#', '#newamt1#', '#newdamt#', '#newamt#',
						'#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#', '#listgetat(mylist,i,";")#', '#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#getbody.sodate#', '#brem1#', '#brem2#', '#brem3#', '#brem4#',
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
						'#listgetat(mylist,i,";")#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#', '#getbody.category#', '#Area#',
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
								update lobthob set bth_qut=(bth_qut+'#fulfillactual#')
								where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+'#fulfillactual#')
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						<cfelse>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+'#fulfillactual#')
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						</cfif>
					</cfif>
	
					<cfset qname='QOUT'&(readperiod+10)>
	
					<cfquery name="UpdateIcitem" datasource="#dts#">
						update icitem set #qname#=(#qname#+#fulfillactual#) where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
					</cfquery>
	
					<cfquery name="inserticlink" datasource="#dts#">
						insert into iclink values ('CS','#nexttranno#','#j#',
						'#ndatenow#','SO','#listgetat(mylist,i,";")#','#getbody.trancode#',
						#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#val(listgetat(form.fulfill,j))#')
					</cfquery>
	
					<cfset newship = getbody.shipped + val(listgetat(form.fulfill,j))>
	
					<cfquery datasource="#dts#" name="updateictran">
						Update ictran set shipped = '#newship#'
						where refno = '#xparam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and trancode = '#xparam3#'
						and toinv = '' and type = 'SO'
					</cfquery>
                    
					
					<cfif form["grdcolumnlist_SO_#xparam1#_#xParam3#"] neq "">
						<cfset grdcolumnlist = form["grdcolumnlist_SO_#xparam1#_#xParam3#"]>
						<cfset bgrdcolumnlist = form["bgrdcolumnlist_SO_#xparam1#_#xParam3#"]>
						<cfset grdvaluelist = form["grdvaluelist_SO_#xparam1#_#xParam3#"]>
						<cfset totalrecord = form["totalrecord_SO_#xparam1#_#xParam3#"]>
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
							('CS', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">, '#ndatenow#','#readperiod#','-1','','#getbody.location#','','',
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
							and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
						</cfquery>
					</cfif>
				</cfloop>
	
				<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
					<cfquery datasource="#dts#" name="updateartran">
						Update ictran set toinv = '#nexttranno#'
						where refno = '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#">
						and type = 'SO' and trancode = '#xparam3#'
					</cfquery>
					
					<!--- Step 2:--->
					<!--- Add on 031008, For Graded Item --->
					<cfquery datasource="#dts#" name="updateigrade">
						Update igrade i, ictran ic 
						set i.generated = 'Y'
						where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
						and i.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#"> and i.trancode = '#xparam3#'
						and i.refno = '#xparam1#' and i.type = 'SO'
					</cfquery>
				</cfif>
                
                <cfquery name="getictran" datasource="#dts#">
                        select refno from ictran where refno = '#listgetat(mylist,i,";")#' and (shipped+writeoff) < qty and type = 'SO'
                    </cfquery>
        
				<cfif getictran.recordcount eq 0>
                    <cfquery name="updateartan" datasource="#dts#">
                        update artran set toinv = '#nexttranno#', order_cl = 'Y'
                        where refno = '#listgetat(mylist,i,";")#' and type = 'SO'
                    </cfquery>
                </cfif>
                
            <cfelse>
            	<cfquery datasource="#dts#" name="getbody">
					Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = 'SO' order by itemcount
				</cfquery>
				<cfloop query="getbody">
				  	<!--- GET LATEST CURRRATE --->
				  	<cfquery datasource="#dts#" name="getheader">
						Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SO'
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
						<cfset newcurrate = val(currency.rate)>
					<cfelse>
						<cfset newcurrate = 1><!--- default --->
					</cfif>
                    
                    <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>
	
					<cfset newamt1_bil = val(getbody.qty_bil) * val(getbody.price_bil)>
					<cfset newdamt_bil1 = (val(getbody.dispec1) / 100) * val(newamt1_bil)>
					<cfset netamt = val(newamt1_bil) - val(newdamt_bil1)>
					<cfset newdamt_bil2 = (val(getbody.dispec2) / 100) * val(netamt)>
					<cfset netamt = val(netamt) - val(newdamt_bil2)>
					<cfset newdamt_bil3 = (val(getbody.dispec3) / 100) * val(netamt)>
					<cfset netamt = val(netamt) - val(newdamt_bil3)>
	
					<cfset newdamt_bil = val(newdamt_bil1) + val(newdamt_bil2) + val(newdamt_bil3)>
					<cfset newtaxamt_bil = (val(getbody.taxpec1) / 100) * (val(newamt1_bil) - val(newdamt_bil))>
					<!--- <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil) + val(newtaxamt_bil)> --->
	                <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil)>
					<cfset newamt_bil = numberformat(val(newamt_bil),".__")>
					<cfset newprice = val(getbody.price_bil) * val(newcurrate)>
	
					<cfset newamt1 = val(newamt1_bil) * val(newcurrate)>
					<cfset newdamt = val(newdamt_bil) * val(newcurrate)>
					<cfset newtaxamt = val(newtaxamt_bil) * val(newcurrate)>
					<cfset newamt = val(newamt_bil) * val(newcurrate)>
					<cfset newamt = numberformat(val(newamt),".__")>
	
					<cfset gross_bil = val(gross_bil) + val(newamt_bil)>
					<cfset gross = val(gross_bil) * val(newcurrate)>
	                
	                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
						
					<!--- QUO TO CS --->
					<cfquery datasource="#dts#" name="insertictran">
						Insert into ictran 
						(`TYPE`,`REFNO`,`REFNO2`,`TRANCODE`,`CUSTNO`,`FPERIOD`,`WOS_DATE`,`CURRRATE`,`ITEMCOUNT`,`LINECODE`,`ITEMNO`,`DESP`,
						`DESPA`,`AGENNO`,`LOCATION`,`SOURCE`,`JOB`,`SIGN`,`QTY_BIL`,`PRICE_BIL`,`UNIT_BIL`,`AMT1_BIL`,`DISPEC1`,`DISPEC2`,
						`DISPEC3`,`DISAMT_BIL`,`AMT_BIL`,`TAXPEC1`,`TAXPEC2`,`TAXPEC3`,`TAXAMT_BIL`,`IMPSTAGE`,`QTY`,`PRICE`,`UNIT`,`AMT1`,
						`DISAMT`,`AMT`,`TAXAMT`,`FACTOR1`,`FACTOR2`,`DONO`,`QUONO`,`DODATE`,`SODATE`,`BREM1`,`BREM2`,`BREM3`,`BREM4`,
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
						values ('CS', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
						'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
	                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,	
						'#getbody.agenno#',	 <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">, '#getbody.source#', '#getbody.job#', '',
						'#getbody.qty_bil#', '#getbody.price_bil#',	'#getbody.unit_bil#', '#newamt1_bil#', '#val(getbody.dispec1)#',
						'#val(getbody.dispec2)#', '#val(getbody.dispec3)#', '#newdamt_bil#', '#newamt_bil#', '#val(getbody.taxpec1)#',
						'#val(getbody.taxpec2)#', '#val(getbody.taxpec3)#', '#newtaxamt_bil#', '', '#getbody.qty#', '#newprice#',
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.unit#">, '#newamt1#', '#newdamt#',	'#newamt#', '#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#',
						'#listgetat(mylist,i,";")#','#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#dateformat(getbody.wos_date,"yyyy-mm-dd")#', '#getbody.brem1#', '#getbody.brem2#', '#getbody.brem3#',
						'#getbody.brem4#', 
						<cfif lcase(hcomid) eq "avent_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
						<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
						</cfif>
						'#getbody.packing#', '#getbody.note1#', '#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N',
						'', '#getbody.grade#', '0.00','0.00','0',
						'0', '#getbody.m_charge1#', '#getbody.m_charge2#', '#getbody.adtcost1#', '#getbody.adtcost2#', '0', '0', '#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '', '0', '0', '0','#getbody.name#', '', '#getbody.van#', 'Y',
						'', '',	'', '0000-00-00', '', '0000-00-00', '', '', '', '', '#getbody.sono#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#',
						'#getbody.category#', '#getbody.area#', '#getbody.shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#',
						'0', '#member#', '', #Now()#, 'Time', '#getbody.bomno#',
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
						  '','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						</cfif>
					</cfquery>
					
					
					<cfif getbody.batchcode neq "">
						<cfif getbody.location neq "">
							<cfquery name="updateobbatch" datasource="#dts#">
								update lobthob set bth_qut=(bth_qut+#getbody.qty#)
								where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+#getbody.qty#)
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						<cfelse>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+#getbody.qty#)
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						</cfif>
					</cfif>
	
					<cfset qname='QOUT'&(readperiod+10)>
	
					<cfquery name="UpdateIcitem" datasource="#dts#">
						update icitem set #qname#=(#qname#+#getbody.qty#) where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
					</cfquery>
	
					<cfquery name="inserticlink" datasource="#dts#">
						insert into iclink values ('CS','#nexttranno#','#j#',
						'#ndatenow#','SO','#listgetat(mylist,i,";")#','#getbody.trancode#',
						#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#getbody.qty_bil#')
					</cfquery>
					
					<!--- Add on 031008 --->
	        		<cfquery datasource="#dts#" name="getigrade">
						Select * from igrade where refno = '#listgetat(mylist,i,";")#' and type = 'SO' 
	                    and TRANCODE = '#getbody.trancode#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
					</cfquery>
					
					<cfif getigrade.recordcount neq 0>
	            		<cfquery name="insertigrade" datasource="#dts#">
	                		insert into igrade
							(type,refno,trancode,itemno,wos_date,fperiod,sign,del_by,location,void,generated,custno,exported,factor1,factor2,
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									GRD#k#,
								<cfelse>
									GRD#k#
								</cfif>
							</cfloop>)
							values
							('CS','#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.itemno#">,'#ndatenow#','#readperiod#',
							'-1','',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.location#">,'','',
							'#getigrade.custno#','','#getigrade.factor1#','#getigrade.factor2#',
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>)
	                	</cfquery>
	                	<cfquery name="updateitemgrd" datasource="#dts#">
							update itemgrd
							set
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
						</cfquery>
					
						<cfquery name="updatelogrdob" datasource="#dts#">
							update logrdob
							set
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
							and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
						</cfquery>
					</cfif>
					
					<cfset j = j + 1>
				</cfloop>
            </cfif>

			<cfset j = j + 1>
			<cfif getGsetup.quochooseitem neq 1>
				<cfquery datasource="#dts#" name="updateictran">
					Update ictran 
					set shipped = qty,
					toinv='#nexttranno#'
					where refno =  '#listgetat(mylist,i,";")#'
					and toinv = '' and type = 'SO'
				</cfquery>
			</cfif>
			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#' and (shipped+writeoff) < qty and type = 'SO'
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set toinv = '#nexttranno#', order_cl = 'Y'
					where refno = '#listgetat(mylist,i,";")#' and type = 'SO'
				</cfquery>
			</cfif>

			<cfoutput><h2>#gettranname.lSO# no: #listgetat(form.checkbox,i,";")#<cfif getGsetup.quochooseitem eq 1>,#listgetat(form.checkbox,i+1,";")# </cfif>is successfully updated to #gettranname.lCS# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
		</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SO'
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
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
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
		<cfset net = net_bil * newcurrate>        
		
		<cfif getheader.taxincl neq "T">
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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
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
        <cfset xdebt=grand-val(getheader.deposit)-val(getheader.cs_pm_cash)-val(getheader.cs_pm_cheq)-val(getheader.cs_pm_crcd)-val(getheader.cs_pm_crc2)-val(getheader.cs_pm_vouc)-val(getheader.cs_pm_dbcd)>
		
		<cfif lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i">
			<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getheader.rem9#" returnvariable="getheader.rem9"/>
			<cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getheader.rem11#" returnvariable="getheader.rem11"/>
		</cfif>
		
		<!--- Create a new transaction --->
		<!--- SO TO CS --->
		<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,
			currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,
			tax_bil,grand_bil,deposit,cs_pm_debt,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax2,
			tax3,tax,taxp1,taxp2,taxp3,grand,note,term,van,pono,dono,quono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
			rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
			trdatetime,userid,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49
			<cfif lcase(hcomid) eq 'iel_i'>
				,rem15,rem16,rem17,rem18,rem19,rem20,rem21,rem22,rem23,rem24,rem25
			</cfif>,taxincl,e_mail,termscondition)

			values('CS','#nexttranno#','#getheader.refno2#','#getheader.custno#','#readperiod#','#ndatenow#',
			'CASH SALES','#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#getheader.deposit#','#xdebt#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#',	'#getheader.term#','#getheader.van#',
			'#getheader.pono#',<cfif getheader.dono neq ''>'#getheader.dono#'<cfelse>'#updatepono#'</cfif>,'#updatepono#','#getheader.rem0#','#getheader.rem1#','#getheader.rem2#','#getheader.rem3#',
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
			</cfif>,'#getheader.taxincl#','#getheader.e_mail#','#getheader.termscondition#')
		</cfquery>
		
		<cftry>
			<cfquery name="getheader_remark" datasource="#dts#">
				select 
				type,
				refno,
				cast(remark1 as binary) as remark1,
				cast(remark2 as binary) as remark2,
				cast(remark3 as binary) as remark3,
				cast(remark4 as binary) as remark4,
				cast(remark5 as binary) as remark5,
				cast(remark6 as binary) as remark6,
				cast(remark7 as binary) as remark7,
				cast(remark8 as binary) as remark8,
				cast(remark9 as binary) as remark9,
				cast(remark10 as binary) as remark10
				from artran_remark where refno = '#listgetat(mylist,1,";")#' and type = 'QUO'
			</cfquery>
			<cfif getheader_remark.recordcount neq 0>
				<cfquery name="insert_remark" datasource="#dts#">
					insert into artran_remark
					(type,refno,
					<cfloop from="1" to="10" index="z">
						remark#z#,
					</cfloop>USERID,LASTUSERID)
					values
					('CS','#nexttranno#',
					<cfloop from="1" to="10" index="z">
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#getheader_remark["remark#z#"][1]#">,
					</cfloop>'#HUserID#','#HUserID#')
				</cfquery>
			</cfif>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
        
        
	</cfif>
	<!--- End of Update to CS from SO --->
<cfelseif url.t2 eq "QUO">

<cfif url.t1 eq "SAMM">
		<cfset type = "Sales Order">
        <cfif followlocationrefno eq 1>
            <cfquery datasource="#dts#" name="updategsetup">
                update refnoset_location
                set lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
                where type = '#url.t2#'
                and location = <cfif lcase(hcomid) eq "mika_i" or lcase(hcomid) eq "nil_i">'#getmikauserloc.location#'<cfelse>'#huserloc#'</cfif>
            </cfquery>
        <cfelse>
		<cfquery name="updategsetup" datasource="#dts#">
			update refnoset set 
			lastUsedNo=<cfif isdefined("actual_nexttranno")>UPPER('#actual_nexttranno#')<cfelse>UPPER('#nexttranno#')</cfif>
			where type = '#url.t2#'
			and counter =  '#invset#'
		</cfquery>
		</cfif>
		<cfset mylist= listchangedelims(checkbox,"",",")>
		<cfset cnt=listlen(mylist,";")>

		Transaction Update Summary<br><br>
		<cfset j = 1>
		
		<cfif getGsetup.quochooseitem eq 1>
        	<cfset stepcount = "+3" >
		<cfelse>
        	<cfset stepcount = "+1" >
        </cfif>

		<cfloop from="1" to="#cnt#" index="i" step="#stepcount#">
			<cfif LastPONO neq listgetat(mylist,i,";")>
			  	<cfif updatepono eq ''>
					<cfset updatepono = listgetat(mylist,i,";")>
				<cfelse>
					<cfset updatepono = updatepono & ',' & listgetat(mylist,i,";")>
				</cfif>

			  <cfset LastPONO = listgetat(mylist,i,";")>
			</cfif>

			<cfoutput>Sales Order No. : #listgetat(mylist,i,";")# <br></cfoutput>
			
			<!--- Start of Update body --->
            <cfif getGsetup.quochooseitem eq 1>
				<cfset xParam1 = listgetat(mylist,i,";")>

				<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
			  		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
			  		<cfset xParam2 = ''>
				<cfelse>
			  		<cfset xParam2 = listgetat(mylist,i+1,";")>
				</cfif>

				<cfset xParam3 = listgetat(mylist,i+2,";")>
			
				<cfquery datasource="#dts#" name="getbody">
					Select * from ictran where refno = '#xParam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#"> and trancode = '#xParam3#' and shipped < qty and type = 'SAMM'
				</cfquery>

				<cfloop query="getbody">
				  	<cfquery datasource="#dts#" name="getheader">
						Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SAMM'
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
                    
                    <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>
					
					<!--- Add On 061008, 2nd Unit Function --->
					<!---<cfif val(getbody.factor1) neq 0>
						<cfset getbody.price_bil = val(getbody.price_bil) * val(getbody.factor2) / val(getbody.factor1)>
					<cfelse>
						<cfset getbody.price_bil = 0>
					</cfif>--->
                    <cfif getbody.factor1 neq 0 and getbody.factor2 neq 0>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))* getbody.factor1 / getbody.factor2>
                <cfelse>
                <cfset fulfillactual=val(listgetat(form.fulfill,j))>
                </cfif>
					
					<cfset newamt1_bil = listgetat(fulfill,j) * getbody.price_bil>
					
					<cfset newdamt_bil1 = (getbody.dispec1 / 100) * newamt1_bil>
					<cfset netamt = newamt1_bil - newdamt_bil1>
					<cfset newdamt_bil2 = (getbody.dispec2 / 100) * netamt>
					<cfset netamt = netamt - newdamt_bil2>
					<cfset newdamt_bil3 = (getbody.dispec3 / 100) * netamt>
					<cfset netamt = netamt - newdamt_bil3>
					
					<cfset newdamt_bil = newdamt_bil1 + newdamt_bil2 + newdamt_bil3>
					<cfif val(newdamt_bil) eq 0 and val(getbody.DISAMT_BIL) neq 0 and val(getbody.qty_bil) neq 0>
						<cfset newdamt_bil = val(getbody.DISAMT_BIL) * val(listgetat(fulfill,j)) / val(getbody.qty_bil)>
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
	                
					<!--- SAMM TO QUO --->
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
						values ('QUO', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
						'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
	                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,
						'#agenno#',	<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">, '#getbody.source#', '#getbody.job#', '', '#listgetat(form.fulfill,j)#',
						'#getbody.price_bil#','#getbody.unit_bil#', '#newamt1_bil#', '#getbody.dispec1#', '#getbody.dispec2#', '#getbody.dispec3#',
						'#newdamt_bil#', '#newamt_bil#', '#getbody.taxpec1#','#getbody.taxpec2#', '#getbody.taxpec3#', '#newtaxamt_bil#',
						'', '#fulfillactual#', '#getbody.price#','#getbody.unit#', '#newamt1#', '#newdamt#', '#newamt#',
						'#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#', '#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#getbody.sodate#', '#brem1#', '#brem2#', '#brem3#', '#brem4#',
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
						'#listgetat(mylist,i,";")#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#', '#getbody.category#', '#Area#',
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
								update lobthob set bth_qut=(bth_qut+'#listgetat(form.fulfill,j)#')
								where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+'#listgetat(form.fulfill,j)#')
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						<cfelse>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+'#listgetat(form.fulfill,j)#')
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						</cfif>
					</cfif>
	
					<cfset qname='QOUT'&(readperiod+10)>
	
					<cfquery name="UpdateIcitem" datasource="#dts#">
						update icitem set #qname#=(#qname#+#listgetat(form.fulfill,j)#) where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
					</cfquery>
	
					<cfquery name="inserticlink" datasource="#dts#">
						insert into iclink values ('QUO','#nexttranno#','#j#',
						'#ndatenow#','SAMM','#listgetat(mylist,i,";")#','#getbody.trancode#',
						#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#listgetat(form.fulfill,j)#')
					</cfquery>
	
					<cfset newship = getbody.shipped + listgetat(form.fulfill,j)>
	
					<cfquery datasource="#dts#" name="updateictran">
						Update ictran set shipped = '#newship#'
						where refno = '#xparam1#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xparam2#"> and trancode = '#xparam3#'
						and toinv = '' and type = 'SAMM'
					</cfquery>
					
					<cfif form["grdcolumnlist_SAMM_#xparam1#_#xParam3#"] neq "">
						<cfset grdcolumnlist = form["grdcolumnlist_SAMM_#xparam1#_#xParam3#"]>
						<cfset bgrdcolumnlist = form["bgrdcolumnlist_SAMM_#xparam1#_#xParam3#"]>
						<cfset grdvaluelist = form["grdvaluelist_SAMM_#xparam1#_#xParam3#"]>
						<cfset totalrecord = form["totalrecord_SAMM_#xparam1#_#xParam3#"]>
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
							('QUO', '#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#xParam2#">, '#ndatenow#','#readperiod#','-1','','#getbody.location#','','',
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
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
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xParam2#">
							and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
						</cfquery>
					</cfif>
				</cfloop>
	
				<cfif listgetat(form.fulfill,j) gte listgetat(form.qtytoful,j)>
					<cfquery datasource="#dts#" name="updateartran">
						Update ictran set toinv = '#nexttranno#', generated = 'Y'
						where refno = '#listgetat(mylist,i,";")#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#">
						and type = 'SAMM' and trancode = '#xparam3#'
					</cfquery>
					
					<!--- Step 2:--->
					<!--- Add on 031008, For Graded Item --->
					<cfquery datasource="#dts#" name="updateigrade">
						Update igrade i, ictran ic 
						set i.generated = 'Y'
						where i.type = ic.type and i.refno=ic.refno and i.itemno = ic.itemno and i.trancode = ic.trancode 
						and i.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#xparam2#"> and i.trancode = '#xparam3#'
						and i.refno = '#xparam1#' and i.type = 'SAMM'
					</cfquery>
				</cfif>
            <cfelse>
            	<cfquery datasource="#dts#" name="getbody">
					Select * from ictran where refno = '#listgetat(mylist,i,";")#' and type = 'SAMM' order by itemcount
				</cfquery>
				<cfloop query="getbody">
				  	<!--- GET LATEST CURRRATE --->
				  	<cfquery datasource="#dts#" name="getheader">
						Select currcode,custno from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SAMM'
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
						<cfset newcurrate = val(currency.rate)>
					<cfelse>
						<cfset newcurrate = 1><!--- default --->
					</cfif>
                    
                    <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
                </cfif>
	
					<cfset newamt1_bil = val(getbody.qty_bil) * val(getbody.price_bil)>
					<cfset newdamt_bil1 = (val(getbody.dispec1) / 100) * val(newamt1_bil)>
					<cfset netamt = val(newamt1_bil) - val(newdamt_bil1)>
					<cfset newdamt_bil2 = (val(getbody.dispec2) / 100) * val(netamt)>
					<cfset netamt = val(netamt) - val(newdamt_bil2)>
					<cfset newdamt_bil3 = (val(getbody.dispec3) / 100) * val(netamt)>
					<cfset netamt = val(netamt) - val(newdamt_bil3)>
	
					<cfset newdamt_bil = val(newdamt_bil1) + val(newdamt_bil2) + val(newdamt_bil3)>
					<cfset newtaxamt_bil = (val(getbody.taxpec1) / 100) * (val(newamt1_bil) - val(newdamt_bil))>
					<!--- <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil) + val(newtaxamt_bil)> --->
	                <cfset newamt_bil = val(newamt1_bil) - val(newdamt_bil)>
					<cfset newamt_bil = numberformat(val(newamt_bil),".__")>
					<cfset newprice = val(getbody.price_bil) * val(newcurrate)>
	
					<cfset newamt1 = val(newamt1_bil) * val(newcurrate)>
					<cfset newdamt = val(newdamt_bil) * val(newcurrate)>
					<cfset newtaxamt = val(newtaxamt_bil) * val(newcurrate)>
					<cfset newamt = val(newamt_bil) * val(newcurrate)>
					<cfset newamt = numberformat(val(newamt),".__")>
	
					<cfset gross_bil = val(gross_bil) + val(newamt_bil)>
					<cfset gross = val(gross_bil) * val(newcurrate)>
	                
	                <cfinvoke component="cfc.date" method="getFormatedDate" inputDate="#getbody.expdate#" returnvariable="getbody.expdate"/>
						
					<!--- SAMM TO QUO --->
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
						values ('QUO', '#nexttranno#', '#getbody.refno2#', '#j#', '#getbody.custno#', '#readperiod#',
						'#ndatenow#', '#newcurrate#', '#j#', '#getbody.linecode#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">, 
	                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.despa#">,	
						'#getbody.agenno#',	 <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.location#">, '#getbody.source#', '#getbody.job#', '',
						'#getbody.qty_bil#', '#getbody.price_bil#',	'#getbody.unit_bil#', '#newamt1_bil#', '#val(getbody.dispec1)#',
						'#val(getbody.dispec2)#', '#val(getbody.dispec3)#', '#newdamt_bil#', '#newamt_bil#', '#val(getbody.taxpec1)#',
						'#val(getbody.taxpec2)#', '#val(getbody.taxpec3)#', '#newtaxamt_bil#', '', '#getbody.qty#', '#newprice#',
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.unit#">, '#newamt1#', '#newdamt#',	'#newamt#', '#newtaxamt#', '#getbody.factor1#', '#getbody.factor2#',
						'#listgetat(mylist,i,";")#', '#dateformat(getbody.wos_date,"yyyy-mm-dd")#','#dateformat(getbody.wos_date,"yyyy-mm-dd")#', '#getbody.brem1#', '#getbody.brem2#', '#getbody.brem3#',
						'#getbody.brem4#', 
						<cfif lcase(hcomid) eq "avent_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem6#">,
						<cfelseif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "laihock_i">
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem7#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem8#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem9#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.brem10#">,
						</cfif>
						'#getbody.packing#', '#getbody.note1#', '#getbody.note2#', '#getbody.gltradac#', '', 'N', 'N',
						'', '#getbody.grade#', '0.00','0.00','0',
						'0', '#getbody.m_charge1#', '#getbody.m_charge2#', '#getbody.adtcost1#', '#getbody.adtcost2#', '0', '0', '#getbody.batchcode#','#getbody.expdate#', '0', '0', '0', '', '', '0', '0', '0','#getbody.name#', '', '#getbody.van#', 'Y',
						'', '',	'', '0000-00-00', '', '0000-00-00', '', '', '', '', '#getbody.sono#', '#getbody.mc1_bil#', '#getbody.mc2_bil#', '#huserid#', '0', '', '#getbody.wos_group#',
						'#getbody.category#', '#getbody.area#', '#getbody.shelf#', '#Temp#', '#Temp1#', '', '0', '0', '0', '#Promoter#',
						'0', '#member#', '', #Now()#, 'Time', '#getbody.bomno#',
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
						  '','#getbody.defective#','#getbody.m_charge3#','#getbody.m_charge4#','#getbody.m_charge5#','#getbody.m_charge6#','#getbody.m_charge7#','#getbody.mc3_bil#','#getbody.mc4_bil#','#getbody.mc5_bil#','#getbody.mc6_bil#','#getbody.mc7_bil#'<cfif lcase(hcomid) eq "fdipx_i">,'#getbody.JobOrderNo#'</cfif>,'#getbody.taxincl#','#getbody.note_a#')
						</cfif>
					</cfquery>
					
					
					<cfif getbody.batchcode neq "">
						<cfif getbody.location neq "">
							<cfquery name="updateobbatch" datasource="#dts#">
								update lobthob set bth_qut=(bth_qut+#getbody.qty#)
								where location='#getbody.location#' and itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+#getbody.qty#)
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						<cfelse>
							<cfquery name="updateobbatch" datasource="#dts#">
								update obbatch set bth_qut=(bth_qut+#getbody.qty#)
								where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#"> and batchcode = '#getbody.batchcode#'
							</cfquery>
						</cfif>
					</cfif>
	
					<cfset qname='QOUT'&(readperiod+10)>
	
					<cfquery name="UpdateIcitem" datasource="#dts#">
						update icitem set #qname#=(#qname#+#getbody.qty#) where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">
					</cfquery>
	
					<cfquery name="inserticlink" datasource="#dts#">
						insert into iclink values ('QUO','#nexttranno#','#j#',
						'#ndatenow#','SAMM','#listgetat(mylist,i,";")#','#getbody.trancode#',
						#getbody.wos_date#,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbody.itemno#">,'#getbody.qty_bil#')
					</cfquery>
					
					<!--- Add on 031008 --->
	        		<cfquery datasource="#dts#" name="getigrade">
						Select * from igrade where refno = '#listgetat(mylist,i,";")#' and type = 'SAMM' 
	                    and TRANCODE = '#getbody.trancode#' and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
					</cfquery>
					
					<cfif getigrade.recordcount neq 0>
	            		<cfquery name="insertigrade" datasource="#dts#">
	                		insert into igrade
							(type,refno,trancode,itemno,wos_date,fperiod,sign,del_by,location,void,generated,custno,exported,factor1,factor2,
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									GRD#k#,
								<cfelse>
									GRD#k#
								</cfif>
							</cfloop>)
							values
							('QUO','#nexttranno#','#j#',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.itemno#">,'#ndatenow#','#readperiod#',
							'-1','',<cfqueryparam cfsqltype="cf_sql_char" value="#getigrade.location#">,'','',
							'#getigrade.custno#','','#getigrade.factor1#','#getigrade.factor2#',
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>)
	                	</cfquery>
	                	<cfquery name="updateitemgrd" datasource="#dts#">
							update itemgrd
							set
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
						</cfquery>
					
						<cfquery name="updatelogrdob" datasource="#dts#">
							update logrdob
							set
							<cfloop from="11" to="160" index="k">
								<cfif k neq 160>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#,
								<cfelse>
									bgrd#k#=bgrd#k#-#Evaluate("getigrade.GRD#k#")#
								</cfif>
							</cfloop>
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.itemno#">
							and location = <cfqueryparam cfsqltype="cf_sql_char" value="#getbody.location#">
						</cfquery>
					</cfif>
					
					<cfset j = j + 1>
				</cfloop>
            </cfif>

			<cfset j = j + 1>
			<cfif getGsetup.quochooseitem neq 1>
				<cfquery datasource="#dts#" name="updateictran">
					Update ictran 
					set shipped = qty,
					toinv='#nexttranno#'
					where refno =  '#listgetat(mylist,i,";")#'
					and toinv = '' and type = 'SAMM'
				</cfquery>
			</cfif>
			<cfquery name="getictran" datasource="#dts#">
				select refno from ictran where refno = '#listgetat(mylist,i,";")#' and (shipped+writeoff) < qty and type = 'SAMM'
			</cfquery>

			<cfif getictran.recordcount eq 0>
				<cfquery name="updateartan" datasource="#dts#">
					update artran set toinv = '#nexttranno#', order_cl = 'Y', generated = 'Y'
					where refno = '#listgetat(mylist,i,";")#' and type = 'SAMM'
				</cfquery>
			</cfif>

			<cfoutput><h2>Sales Order no: #listgetat(form.checkbox,i,";")#<cfif getGsetup.quochooseitem eq 1>,#listgetat(form.checkbox,i+1,";")# </cfif>is successfully updated to #gettranname.lQUO# No: <u><a href="../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#" target="_blank">#nexttranno#</a> <input type="button" name="button" value="Preview" onClick="window.open('../transaction3c.cfm?tran=#t2#&nexttranno=#nexttranno#')"></u></h2></cfoutput>
		</cfloop>

		<cfquery datasource="#dts#" name="getheader">
			Select * from artran where refno = '#listgetat(mylist,1,";")#' and type = 'SAMM'
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
        
        <cfquery name="getdaycurrency" datasource="#dts#">
                select * 
                from #target_currencymonth# 
                where currcode='#xCurrCode#' and fperiod='#numberformat(val(readperiod),'00')#'
                </cfquery>
                <cfif getdaycurrency.recordcount neq 0>
                    <cfset newcurrate = evaluate('getdaycurrency.CurrD#day(ndate)#')>
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
		<cfset net = net_bil * newcurrate>        
		
		<cfif getheader.taxincl neq "T">
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
        
        <cfif getheader.taxincl eq "T">
        <cfset gross_bil = val(gross_bil) - val(tax_bil)>
		<cfset gross = val(gross) - val(tax)>
        </cfif>
        
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
		<!--- SAMM TO QUO --->
		<cfquery datasource="#dts#" name="insertartran">
			Insert into artran (type,refno,refno2,custno,fperiod,wos_date,desp,despa,agenno,area,source,job,
			currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax2_bil,tax3_bil,
			tax_bil,grand_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax2,
			tax3,tax,taxp1,taxp2,taxp3,grand,note,term,van,pono,dono,rem0,rem1,rem2,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,
			rem12,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,frem9,comm0,comm1,comm2,comm3,comm4,name,phonea,
			trdatetime,userid,currcode,
			m_charge1,m_charge2,m_charge3,m_charge4,m_charge5,m_charge6,m_charge7,mc1_bil,mc2_bil,mc3_bil,mc4_bil,mc5_bil,mc6_bil,mc7_bil,special_account_code,
			created_by,created_on,updated_by,updated_on,rem30,rem31,rem32,rem33,rem34,rem35,rem36,rem37,rem38,rem39,rem40,rem41,rem42,rem43,rem44,rem45,rem46,rem47,rem48,rem49
			<cfif lcase(hcomid) eq 'iel_i'>
				,rem15,rem16,rem17,rem18,rem19,rem20,rem21,rem22,rem23,rem24,rem25
			</cfif>,taxincl,e_mail)

			values('QUO','#nexttranno#','#getheader.refno2#','#getheader.custno#','#readperiod#','#ndatenow#',
			'CASH SALES','#getheader.despa#','#getheader.agenno#','#getheader.area#','#getheader.source#',
			'#getheader.job#','#newcurrate#','#gross_bil#','#disc1_bil#','#disc2_bil#','#disc3_bil#','#disc_bil#','#net_bil#','#numberformat(tax1_bil,".__")#',
			'#getheader.tax2_bil#','#getheader.tax3_bil#','#numberformat(tax_bil,".__")#','#grand_bil#','#gross#','#xdisp1#','#xdisp2#','#xdisp3#',
			'#discount1#','#discount2#','#discount3#','#discount#',
			'#net#','#numberformat(tax1,".__")#','#getheader.tax2#','#getheader.tax3#','#numberformat(tax,".__")#','#xtaxp1#','#getheader.taxp2#',
			'#getheader.taxp3#','#grand#','#getheader.note#',	'#getheader.term#','#getheader.van#',
			'#getheader.pono#',<cfif getheader.dono neq ''>'#getheader.dono#'<cfelse>'#updatepono#'</cfif>,'#getheader.rem0#','#getheader.rem1#','#getheader.rem2#','#getheader.rem3#',
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
		
		<cftry>
			<cfquery name="getheader_remark" datasource="#dts#">
				select 
				type,
				refno,
				cast(remark1 as binary) as remark1,
				cast(remark2 as binary) as remark2,
				cast(remark3 as binary) as remark3,
				cast(remark4 as binary) as remark4,
				cast(remark5 as binary) as remark5,
				cast(remark6 as binary) as remark6,
				cast(remark7 as binary) as remark7,
				cast(remark8 as binary) as remark8,
				cast(remark9 as binary) as remark9,
				cast(remark10 as binary) as remark10
				from artran_remark where refno = '#listgetat(mylist,1,";")#' and type = 'SAMM'
			</cfquery>
			<cfif getheader_remark.recordcount neq 0>
				<cfquery name="insert_remark" datasource="#dts#">
					insert into artran_remark
					(type,refno,
					<cfloop from="1" to="10" index="z">
						remark#z#,
					</cfloop>USERID,LASTUSERID)
					values
					('QUO','#nexttranno#',
					<cfloop from="1" to="10" index="z">
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#getheader_remark["remark#z#"][1]#">,
					</cfloop>'#HUserID#','#HUserID#')
				</cfquery>
			</cfif>
		<cfcatch type="any">
		</cfcatch>
		</cftry>
	</cfif>
    
</cfif>
<br><br>

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

<cfif url.t2 eq "DO" or url.t2 eq "INV" or url.t2 eq "RC" or url.t2 eq "CS">
<cfif url.t1 eq "DO" and url.t2 eq "INV">
<cfelse>
<cfquery name="getitemlist" datasource="#dts#">
SELECT itemno,qty,itemcount,location,custno,fperiod,trdatetime,agenno,currrate,price,batchcode FROM ictran WHERE refno = "#nexttranno#" and type = "#url.t2#"
</cfquery>
<cfloop query="getitemlist">
<cfquery name="checkserial" datasource="#dts#">
select wserialno,aitemno from icitem where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getitemlist.itemno#"> and wserialno = "T"
</cfquery>
<cfif checkserial.recordcount neq 0>
<div align="left">
<h1><cfif lcase(hcomid) eq 'vsolutionspteltd_i' or lcase(hcomid) eq 'vsyspteltd_i' or lcase(hcomid) eq 'demo_i'>Item No:<cfelse>Serial Item:</cfif> #getitemlist.itemno#</h1>
<cfif lcase(hcomid) eq 'vsolutionspteltd_i' or lcase(hcomid) eq 'vsyspteltd_i' or lcase(hcomid) eq 'demo_i'><br><h1>Product Code : #checkserial.aitemno#</h1></cfif>
<iframe src="/default/transaction/update/serial.cfm?type=Create&tran=#URLEncodedFormat(url.t2)#&nexttranno=#URLEncodedFormat(nexttranno)#&itemcount=#URLEncodedFormat(getitemlist.itemcount)#&qty=#URLEncodedFormat(getitemlist.qty)#&itemno=#URLEncodedFormat(getitemlist.itemno)#&custno=#URLEncodedFormat(getitemlist.custno)#&readperiod=#URLEncodedFormat(getitemlist.fperiod)#&nDateCreate=#URLEncodedFormat(dateformat(getitemlist.trdatetime,'YYYYMMDD'))#&agenno=#URLEncodedFormat(getitemlist.agenno)#&currrate=#URLEncodedFormat(getitemlist.currrate)#&price=#URLEncodedFormat(getitemlist.price)#&location=#URLEncodedFormat(getitemlist.location)#&batchcode=#URLEncodedFormat(getitemlist.batchcode)#" width="800" height="300" >
</iframe>
</div>
</cfif>
</cfloop>
</cfif>
</cfif>
</cfoutput>
</body>
</html>
  				<cfif getGsetup.autolocbf eq "Y">
                <cfinvoke component="cfc.countlocbal" method="countlocbal" dts="#dts#" refno="#nexttranno#" type="#url.t2#" returnvariable="done" />
                </cfif>

<cfelse>
	This form has either already been submitted or is being called from the wrong page.
</cfif>
