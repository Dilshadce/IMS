
<cfif isdefined("url.debug")><cfabort></cfif>

<cfquery name='getgeneralinfo' datasource='#dts#'>
	select wpitemtax
	from gsetup
</cfquery>
<cfif getgeneralinfo.wpitemtax neq 1>


<cftry>
<cfquery name="getdecimal" datasource="#dts#">
SELECT Decl_Uprice,Decl_Discount FROM gsetup2
</cfquery>

<cfquery name="recalculateictran" datasource="#dts#">
Update ictran set amt_bil = round(price_bil * qty_bil,#getdecimal.Decl_Uprice#)-disamt_bil WHERE
type = '#tran#' and <cfif isdefined('url.nexttranno')> refno='#url.nexttranno#' <cfelse> refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">)</cfif>
</cfquery>

<cfquery name="updateamt" datasource="#dts#">
UPDATE ictran SET amt = amt_bil * currrate WHERE
type = '#tran#' and <cfif isdefined('url.nexttranno')> refno='#url.nexttranno#' <cfelse> refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">)</cfif>
</cfquery>

<cfquery name="getsum" datasource="#dts#">
SELECT refno,type,sum(amt_bil) as sumamt FROM ictran WHERE type = '#tran#' and <cfif isdefined('url.nexttranno')> refno='#url.nexttranno#' <cfelse> refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">)</cfif> group by refno
</cfquery>

<cfquery name="updatesum" datasource="#dts#">
Update artran SET gross_bil = "#val(getsum.sumamt)#" WHERE type = '#tran#' and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getsum.refno#">
</cfquery>

<cfquery name="updatediscount" datasource="#dts#">
Update artran SET disc_bil = gross_bil*(disp1/100),disc1_bil = gross_bil*(disp1/100) WHERE type = '#tran#' and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getsum.refno#"> and disp1<>0
</cfquery>

<cfquery name="updategrand" datasource="#dts#">
UPDATE artran SET net_bil = round(gross_bil - disc_bil-rebatamt,2) WHERE
type = '#tran#' and <cfif isdefined('url.nexttranno')> refno='#url.nexttranno#' <cfelse> refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">)</cfif>
</cfquery>

<cfquery name="updategrand2" datasource="#dts#">
Update artran SET
grand_bil = if(taxincl = "T",net_bil,round((net_bil + (net_bil * taxp1/100))+0.000001,#getdecimal.Decl_Uprice#)),
tax1_bil = if(taxincl = "T",round((net_bil * taxp1/(100+taxp1))+0.000001,#getdecimal.Decl_Uprice#), round((net_bil * taxp1/100)+0.000001,#getdecimal.Decl_Uprice#)),
tax_bil = if(taxincl = "T",round((net_bil * taxp1/(100+taxp1))+0.000001,#getdecimal.Decl_Uprice#), round((net_bil * taxp1/100)+0.000001,#getdecimal.Decl_Uprice#))
WHERE
type = '#tran#' and <cfif isdefined('url.nexttranno')> refno='#url.nexttranno#' <cfelse> refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">)</cfif>
</cfquery>


<cfquery name="updaterate" datasource="#dts#">
Update artran SET grand = grand_bil * currrate , net = net_bil * currrate, invgross = gross_bil * currrate, tax=tax_bil * currrate, tax1 = tax1_bil WHERE
type = '#tran#' and <cfif isdefined('url.nexttranno')> refno='#url.nexttranno#' <cfelse> refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">)</cfif>
</cfquery>

<cfquery datasource='#dts#' name="getartran">
select * from artran where type = '#tran#' and refno='#url.nexttranno#'
</cfquery>

<cfquery name='getgeneralinfo' datasource='#dts#'>
	select wpitemtax
	from gsetup
</cfquery>

<cfif getgeneralinfo.wpitemtax neq "Y" and val(getartran.invgross) neq 0>

    <cfif getartran.taxincl eq "T">

    <cfquery name="updatesum2" datasource="#dts#">
Update artran SET gross_bil = grand_bil-tax_bil+disc_bil-mc1_bil-mc2_bil-mc3_bil-mc4_bil-mc5_bil-mc6_bil-mc6_bil WHERE type = '#tran#' and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getsum.refno#">
    </cfquery>


<cfquery name="updaterate2" datasource="#dts#">
Update artran SET invgross = gross_bil * currrate,discount = disc_bil * currrate,discount1 = disc1_bil * currrate WHERE
type = '#tran#' and refno='#url.nexttranno#'
</cfquery>

    <cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictran
        set note_a='#getartran.note#',
        TAXPEC1='#getartran.taxp1#',
        TAXAMT_BIL=round((AMT_BIL/#val(getartran.net_bil)+val(getartran.disc_bil)#)*#val(getartran.tax1_bil)#,5),
        TAXAMT=round((AMT/#val(getartran.net)+val(getartran.discount)#)*#val(getartran.tax)#,5)
        type = '#tran#' and refno='#url.nexttranno#'
    </cfquery>
    <cfelse>
	<cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictran
        set note_a='#getartran.note#',
        TAXPEC1='#getartran.taxp1#',
        TAXAMT_BIL=round((AMT_BIL/#val(getartran.gross_bil)#)*#val(getartran.tax1_bil)#,5),
        TAXAMT=round((AMT/#val(getartran.invgross)#)*#val(getartran.tax)#,5)
        type = '#tran#' and refno='#url.nexttranno#'
    </cfquery>
    </cfif>
</cfif>


<cfcatch type="any">
</cfcatch>
</cftry>
</cfif>
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
<noscript>
	Javascript has been disabled or not supported in this browser.<br>Please enable Javascript supported before continue.
</noscript>

<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM,lRQ

	from GSetup
</cfquery>
<cfset trancode="#lcase(tran)#no">
<cfset prefix="#lcase(tran)#code">
<cfset suffix="#lcase(tran)#no2">

<cfquery name="getGSetup" datasource="#dts#">
  	select invoneset,#prefix# as prefix,#trancode#,#suffix# as suffix,
	<cfif tran eq "INV"><cfloop from="2" to="6" index="i">#prefix#_#i#,#trancode#_#i#,#suffix#_#i#,</cfloop></cfif>
	compro,compro2,compro3,compro4,compro5,compro6,compro7,gstno,bcurr
    from gsetup
</cfquery>

<cfquery name="getGsetup2" datasource='#dts#'>
  	SELECT CONCAT(',.',REPEAT('_',Decl_Uprice)) AS Decl_Uprice,
    	   CONCAT(',.',REPEAT('_',Decl_Discount)) AS Decl_Discount,
           CONCAT(',.',REPEAT('_',Decl_TotalAmt)) AS Decl_TotalAmt
    FROM gsetup2;
</cfquery>

<cfset tran_prefix=getGSetup.prefix>
<cfset tran_suffix=getGSetup.suffix>
<cfset fname=tran&".cfr">
<cfif isdefined('url.format')>
<cfif url.format EQ 'faktorPajak'>
	<cfset fname="faktorPajak.cfr">
<cfelseif url.format EQ 'faktorPajakUSD'>
  	<cfset fname="faktorPajakUSD.cfr">
<cfelse>
	<cfset fname=tran&"2.cfr">
</cfif>
<cfelseif isdefined('url.tax')>
<cfset fname=tran&"5.cfr">
</cfif>

<cfswitch expression="#tran#">
	<cfcase value="RC"><cfset ptype=target_apvend></cfcase>
	<cfcase value="PR"><cfset ptype=target_apvend></cfcase>
	<cfcase value="INV"><cfset ptype=target_arcust></cfcase>
	<cfcase value="DO"><cfset ptype=target_arcust></cfcase>
	<cfcase value="CS"><cfset ptype=target_arcust></cfcase>
	<cfcase value="CN"><cfset ptype=target_arcust></cfcase>
	<cfcase value="DN"><cfset ptype=target_arcust></cfcase>
	<cfcase value="QUO"><cfset ptype=target_arcust></cfcase>
	<cfcase value="PO"><cfset ptype=target_apvend></cfcase>
	<cfcase value="SO"><cfset ptype=target_arcust></cfcase>
	<cfcase value="SAM"><cfset ptype=target_arcust></cfcase>
    <cfcase value="RQ"><cfset ptype=target_apvend></cfcase>
    <cfcase value="ISS"><cfset ptype=target_apvend></cfcase>
    <cfcase value="OAI"><cfset ptype=target_arcust></cfcase>
	<cfcase value="OAR"><cfset ptype=target_arcust></cfcase>
	<cfcase value="TR"><cfset ptype=target_arcust></cfcase>
</cfswitch>

<cfquery name="ClearICBil_M" datasource="#dts#">
  	truncate r_IcBil_M
</cfquery>

<cfquery name="ClearICBil_S" datasource="#dts#">
  	truncate r_IcBil_S
</cfquery>

<cfquery datasource='#dts#' name="getHeaderInfo">
	select a.type,a.refno,a.desp,a.despa,a.term,a.refno2,
	a.source,a.job,a.pono,a.dono,a.currcode,a.note,
	a.deposit,a.cs_pm_debt,

	a.rem0,a.rem1,a.rem2,a.rem3,a.rem4,a.rem5,a.rem6,a.rem7,a.rem8,a.rem9,a.rem10,a.rem11,a.rem12,a.rem13,a.rem14,
	a.frem0,a.frem1,a.frem2,a.frem3,a.frem4,a.frem5,a.frem6,a.frem7,a.frem8,a.frem9,
	a.comm0,a.comm1,a.comm2,a.comm3,a.comm4,
	a.mc1_bil,a.mc2_bil,a.mc3_bil,a.mc4_bil,a.mc5_bil,a.mc6_bil,a.mc7_bil,

	a.fperiod,a.custno,a.wos_date,a.currrate,a.consignment,
	a.agenno,a.name,a.van,

	a.gross_bil,
	a.disp1, a.disp2, a.disp3, a.disc1_bil, a.disc2_bil, a.disc3_bil, a.disc_bil,
	a.taxp1,a.tax_bil,a.tax1_bil,a.tax2_bil,a.tax3_bil, a.net_bil, a.grand_bil,a.rebateamt,

	ag.desp as agen_desp,curr.currency

	from artran a
	left join #target_icagent# ag on a.agenno=ag.agent
	left join #target_currency# curr on a.currcode = curr.currcode

	where a.type = '#tran#' and <cfif isdefined('url.nexttranno')> a.refno='#url.nexttranno#' <cfelse> a.refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">)</cfif>
</cfquery>
<cfif isdefined('url.nexttranno')>

<cfelse>
<cfquery name="updatePrinted" datasource="#dts#">
Update artran SET printed = "Y" where refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">) and type =<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.tran#" >
</cfquery>
</cfif>
<cfset j = 1>
<cfset k = 0>
<cfset l = 0>

<cfloop query="getHeaderInfo">
	<cfif getHeaderInfo.rem0 neq "">
		<cfif getHeaderInfo.rem0 eq "Profile">
			<cfif tran eq 'PR' or tran eq 'PO' or tran eq 'RC'>
				<cfquery datasource='#dts#' name="getCustAdd">
					select name,name2,add1,add2,add3,add4,attn,phone,fax,e_mail,web_site,contact,END_USER,COUNTRY,POSTALCODE from #target_apvend# where custno = '#getheaderInfo.custno#'
				</cfquery>
			<cfelse>
				<cfquery datasource='#dts#' name="getCustAdd">
					select name,name2,add1,add2,add3,add4,attn,phone,fax,e_mail,web_site,contact,END_USER,COUNTRY,POSTALCODE from #target_arcust# where custno = '#getheaderInfo.custno#'
				</cfquery>
			</cfif>
		<cfelse>
			<cfquery datasource='#dts#' name="getCustAdd">
				select a.name,'' as name2,a.add1,a.add2,a.add3,a.add4,a.attn,a.phone,a.fax,a.COUNTRY,a.POSTALCODE,b.e_mail,b.web_site,b.contact,b.END_USER
				from address a, #ptype# b where a.code = '#getheaderInfo.rem0#' and a.custno=b.custno
			</cfquery>
		</cfif>
		<cfif getCustAdd.country neq "" and getCustAdd.postalcode neq "">
			<cfset add5=getCustAdd.country&" "&getCustAdd.postalcode>
			<cfif getCustAdd.add1 eq "">
				<cfset getCustAdd.add1 = add5>
			<cfelseif getCustAdd.add2 eq "">
				<cfset getCustAdd.add2 = add5>
			<cfelseif getCustAdd.add3 eq "">
				<cfset getCustAdd.add3 = add5>
			<cfelseif getCustAdd.add4 eq "">
				<cfset getCustAdd.add4 = add5>
			<cfelse>
				<cfset getCustAdd.add5 = add5>
			</cfif>
		</cfif>
	<cfelse>
		<cfset getCustAdd.name=getHeaderInfo.frem0>
		<cfset getCustAdd.name2=getHeaderInfo.frem1>
		<cfset getCustAdd.add1=getHeaderInfo.frem2>
		<cfset getCustAdd.add2=getHeaderInfo.frem3>
		<cfset getCustAdd.add3=getHeaderInfo.frem4>
		<cfset getCustAdd.add4=getHeaderInfo.frem5>
		<cfset getCustAdd.attn=getHeaderInfo.rem2>
		<cfset getCustAdd.phone=getHeaderInfo.rem4>
		<cfset getCustAdd.fax=getHeaderInfo.frem6>
		<cfset getCustAdd.e_mail="">
		<cfset getCustAdd.web_site="">
		<cfset getCustAdd.contact="">
	</cfif>

	<cfif getHeaderInfo.rem1 neq "">
		<cfif getHeaderInfo.rem1 eq "Profile">
			<cfif tran eq 'PR' or tran eq 'PO' or tran eq 'RC'>
				<cfquery datasource='#dts#' name="getDeliveryAdd">
					select name,name2,daddr1 as add1,daddr2 as add2,daddr3 as add3,daddr4 as add4,dattn as attn,dphone as phone,dfax as fax,e_mail,contact,D_COUNTRY as COUNTRY,D_POSTALCODE as POSTALCODE from #target_apvend# where custno = '#getheaderInfo.custno#'
				</cfquery>
			<cfelse>
				<cfquery datasource='#dts#' name="getDeliveryAdd">
					select name,name2,daddr1 as add1,daddr2 as add2,daddr3 as add3,daddr4 as add4,dattn as attn,dphone as phone,dfax as fax,e_mail,contact,D_COUNTRY as COUNTRY,D_POSTALCODE as POSTALCODE from #target_arcust# where custno = '#getheaderInfo.custno#'
				</cfquery>
			</cfif>
		<cfelse>
			<cfquery datasource='#dts#' name="getDeliveryAdd">
				select a.name,'' as name2,a.add1,a.add2,a.add3,a.add4,a.attn,a.phone,a.fax,a.COUNTRY,a.POSTALCODE,b.e_mail,b.contact
				from address a
				left join #ptype# as b on a.custno=b.custno
				where a.code = '#getheaderInfo.rem1#'
			</cfquery>
		</cfif>
		<cfif getDeliveryAdd.country neq "" and getDeliveryAdd.postalcode neq "">
			<cfset add5=getDeliveryAdd.country&" "&getDeliveryAdd.postalcode>
			<cfif getDeliveryAdd.add1 eq "">
				<cfset getDeliveryAdd.add1 = add5>
			<cfelseif getDeliveryAdd.add2 eq "">
				<cfset getDeliveryAdd.add2 = add5>
			<cfelseif getDeliveryAdd.add3 eq "">
				<cfset getDeliveryAdd.add3 = add5>
			<cfelseif getDeliveryAdd.add4 eq "">
				<cfset getDeliveryAdd.add4 = add5>
			<cfelse>
				<cfset getDeliveryAdd.add5 = add5>
			</cfif>
		</cfif>
	<cfelse>
		<cfset getDeliveryAdd.name=getHeaderInfo.frem7>
		<cfset getDeliveryAdd.name2=getHeaderInfo.frem8>
		<cfset getDeliveryAdd.add1=getHeaderInfo.comm0>
		<cfset getDeliveryAdd.add2=getHeaderInfo.comm1>
		<cfset getDeliveryAdd.add3=getHeaderInfo.comm2>
		<cfset getDeliveryAdd.add4=getHeaderInfo.comm3>
		<cfset getDeliveryAdd.attn=getHeaderInfo.rem3>
		<cfset getDeliveryAdd.phone=getHeaderInfo.rem12>
		<cfset getDeliveryAdd.fax=getHeaderInfo.comm4>
		<cfset getDeliveryAdd.e_mail="">
		<cfset getDeliveryAdd.contact="">
	</cfif>

	<cfif k neq 0>
		<cfquery name="update" datasource="#dts#">
			update r_icbil_s
			set brem2 = #k#
			where No = #j-1#
		</cfquery>
	</cfif>
	<cfset k = k+1>
	<cfset xdisp1 = 0>
	<cfset xdisp2 = 0>
	<cfset xdisp3 = 0>
	<cfset xtaxp1 = 0>

	<cfif getheaderinfo.taxp1 neq "">
	  	<cfset xtaxp1 = getheaderinfo.taxp1>
	</cfif>

	<cfif getheaderinfo.disp1 neq "">
	  	<cfset xdisp1 = getheaderinfo.disp1>
	</cfif>

	<cfif getheaderinfo.disp2 neq "">
	  	<cfset xdisp2 = getheaderinfo.disp2>
	</cfif>

	<cfif getheaderinfo.disp3 neq "">
	  	<cfset xdisp3 = getheaderinfo.disp3>
	</cfif>

	<cfif getheaderinfo.disc1_bil neq 0>
	  	<cfset thisdisamt_bil = getheaderinfo.disc1_bil + getheaderinfo.disc2_bil + getheaderinfo.disc3_bil>
	<cfelse>
	  	<cfset thisdisamt_bil = getheaderinfo.disc_bil>
	</cfif>

	<cfset thistaxbil = getheaderinfo.tax1_bil + getheaderinfo.tax2_bil + getheaderinfo.tax3_bil>
	<!--- HEADER: REM12 => R_ICBIL_M: D_TEL; HEDAER: cs_pm_debt => R_ICBIL_M: REM12 --->
	<!--- HEADER: REM3 => R_ICBIL_M: D_ATTN; HEDAER: currency => R_ICBIL_M: REM3 --->
	<cfquery name="InsertICBil_M" datasource="#dts#">
	  	Insert into r_icbil_m (B_Name, B_Name2, B_Add1, B_Add2, B_Add3, B_Add4, B_Attn, B_Tel, B_Fax,
	  	D_Name, D_Add1, D_Add2, D_Add3, D_Add4, D_Attn, D_Tel, D_Fax, Custno, Refno,PONO,DONO,
	  	Date, Terms, Agent, Rem1, Rem2, Rem3, Rem4,
	  	Rem5, Rem6, Rem7, Rem8, Rem9, Rem10, Rem11, Rem12, Total, Disp1, Disp2, Disp3, Disamt_bil,
	  	Net_bil, Taxp1, Taxamt_bil, CurrCode, CurrRate, Gross_bil, Deposit,AGENTDESP)

	  	values
		(<cfqueryparam cfsqltype="cf_sql_char" value="#getCustAdd.name#">,<cfqueryparam cfsqltype="cf_sql_char" value="#getCustAdd.name2#">,
		<cfqueryparam cfsqltype="cf_sql_char" value="#getCustAdd.add1#">,<cfqueryparam cfsqltype="cf_sql_char" value="#getCustAdd.add2#">,
	  	<cfqueryparam cfsqltype="cf_sql_char" value="#getCustAdd.add3#">,<cfqueryparam cfsqltype="cf_sql_char" value="#getCustAdd.add4#">,
	  	<cfqueryparam cfsqltype="cf_sql_char" value="#getCustAdd.attn#">,<cfqueryparam cfsqltype="cf_sql_char" value="#getCustAdd.phone#">,
	  	<cfqueryparam cfsqltype="cf_sql_char" value="#getCustAdd.fax#">,<cfqueryparam cfsqltype="cf_sql_char" value="#getDeliveryAdd.name#">,
	  	<cfqueryparam cfsqltype="cf_sql_char" value="#getDeliveryAdd.add1#">,<cfqueryparam cfsqltype="cf_sql_char" value="#getDeliveryAdd.add2#">,
	  	<cfqueryparam cfsqltype="cf_sql_char" value="#getDeliveryAdd.add3#">,<cfqueryparam cfsqltype="cf_sql_char" value="#getDeliveryAdd.add4#">,
	  	<cfqueryparam cfsqltype="cf_sql_char" value="#getDeliveryAdd.attn#">,<cfqueryparam cfsqltype="cf_sql_char" value="#getDeliveryAdd.phone#">,
	  	<cfqueryparam cfsqltype="cf_sql_char" value="#getDeliveryAdd.fax#">,
	  	'#jsstringformat(getheaderinfo.custno)#','#jsstringformat(getheaderinfo.refno)#','#jsstringformat(getheaderinfo.pono)#','#jsstringformat(getheaderinfo.dono)#','#jsstringformat(dateformat(getheaderinfo.wos_date,"yyyy-mm-dd"))#',
		<cfqueryparam cfsqltype="cf_sql_char" value="#getheaderinfo.term#">,<cfqueryparam cfsqltype="cf_sql_char" value="#getheaderinfo.agenno#">,
	  	<cfqueryparam cfsqltype="cf_sql_char" value="#getheaderinfo.rem1#">,<cfqueryparam cfsqltype="cf_sql_char" value="#getheaderinfo.rem2#">,
	  	<cfqueryparam cfsqltype="cf_sql_char" value="#getheaderinfo.currency#">,<cfqueryparam cfsqltype="cf_sql_char" value="#getheaderinfo.rem4#">,
		<cfqueryparam cfsqltype="cf_sql_char" value="#getheaderinfo.rem5#">,<cfqueryparam cfsqltype="cf_sql_char" value="#getheaderinfo.rem6#">,
		<cfqueryparam cfsqltype="cf_sql_char" value="#getheaderinfo.rem7#">,<cfqueryparam cfsqltype="cf_sql_char" value="#getheaderinfo.rem8#">,
		<cfqueryparam cfsqltype="cf_sql_char" value="#getheaderinfo.rem9#">,<cfqueryparam cfsqltype="cf_sql_char" value="#getheaderinfo.rem10#">,
	  	<cfqueryparam cfsqltype="cf_sql_char" value="#getheaderinfo.rem11#">,'#val(getheaderinfo.cs_pm_debt)#','#val(getheaderinfo.grand_bil)#','#val(getheaderinfo.disp1)#',
	  	'#val(getheaderinfo.disp2)#','#val(getheaderinfo.disp3)#','#val(thisdisamt_bil)#',
		'#val(getheaderinfo.net_bil)#','#val(xtaxp1)#','#val(getheaderinfo.tax_bil)#','#jsstringformat(getheaderinfo.currcode)#',
	  	'#val(getheaderinfo.currrate)#','#val(getheaderinfo.gross_bil)#','#val(getheaderinfo.deposit)#',
	  	<cfqueryparam cfsqltype="cf_sql_char" value="#getheaderinfo.agen_desp#">)
	</cfquery>

	<cfquery name="getbodyinfo" datasource="#dts#">
		select
		type,refno,itemno,desp,despa,comment,unit_bil,location,
		brem1,brem2,brem3,brem4,gltradac,wos_group,category,itemcount,
		packing,trancode,

		price_bil,qty_bil,amt1_bil,
		dispec1,dispec2,dispec3,disamt_bil,
		taxpec1,taxamt_bil,amt_bil

		from ictran
		where type = <cfif getheaderinfo.type eq "TR">'TROU'<cfelse>'#getHeaderInfo.type#'</cfif>
		and	refno = '#getHeaderInfo.refno#'
		order by <cfif getheaderinfo.type eq "ISS">itemcount<cfelse>trancode</cfif>
	</cfquery>

	<cfloop query="getbodyinfo">

		<cfquery name="getserial" datasource="#dts#">
	    	select * from iserial where refno = '#getbodyinfo.refno#' and type = '#getHeaderInfo.type#'
	    	and itemno = '#getbodyinfo.itemno#' and trancode = '#getbodyinfo.itemcount#'
            group by serialno,itemno
	  	</cfquery>
	  	<cfset mylist1 = ''>
        <cfloop query="getserial">
        <cfif getserial.currentrow eq 1>
        <cfset mylist1 = mylist1&getserial.serialno>
        <cfelse>
        <cfset mylist1 = mylist1&" , "&getserial.serialno>
        </cfif>
        </cfloop>
        <!---
	  	<cfif getserial.recordcount gt 0>
	    	<cfset mylist1 = valuelist(getserial.SERIALNO)>
	  	<cfelse>
	    	<cfset mylist1 = ''>
	  	</cfif>--->

	  	<cfset iteminfo = arraynew(1)>
		<cfset iteminfo[1] = getbodyinfo.desp>
		<cfset iteminfo[2] = getbodyinfo.despa>
		<cfset iteminfo[3] = replace(tostring(getbodyinfo.comment),chr(10)," ","all")>
        <cfif mylist1 neq "">
        <cfset iteminfo[4] = "Serial No: "&mylist1>
        <cfelse>
        <cfset iteminfo[4] = "">
        </cfif>
		<cfset info=''>

			<cfloop index="a" from="1" to="4">
				<cfif iteminfo[a] neq "" and iteminfo[a] neq "XCOST">
					<cfif a neq 4>
						<cfset info = info&iteminfo[a]&chr(10)>
					<cfelse>
						<cfset info = info&iteminfo[a]>
					</cfif>
				</cfif>
			</cfloop>


		<cfif info neq "">
			<cfset str = ListGetAt(info,1,chr(13)&chr(10))>
		<cfelse>
			<cfset str ="">
		</cfif>
		<cfset recordcnt = ListLen(info,chr(13)&chr(10))>

        <cfquery name="InsertICBil_S" datasource='#dts#'>
			Insert into r_icbil_s (SRefno, No, ItemNo, Desp, SN_No, Unit, Qty, Price, Amt,dispec1,dispec2, counter_1,taxpec1)
			values ('#jsstringformat(getbodyinfo.refno)#','#j#','#jsstringformat(getbodyinfo.itemno)#','#jsstringformat(str)#','#mylist1#',
			'#jsstringformat(getbodyinfo.unit_bil)#','#jsstringformat(getbodyinfo.qty_bil)#','#jsstringformat(getbodyinfo.price_bil)#','#jsstringformat(getbodyinfo.amt_bil)#',
			'#jsstringformat(getbodyinfo.disamt_bil)#','#jsstringformat(getbodyinfo.taxamt_bil)#','#jsstringformat(currentrow)#','#jsstringformat(getbodyinfo.taxamt_bil)#')
		</cfquery>

		<cfset j = j + 1>

        <cfquery name="checkgrade" datasource='#dts#'>
        select * from igrade where type='#getbodyinfo.type#' and refno='#getbodyinfo.refno#' and trancode='#getbodyinfo.trancode#' and itemno='#getbodyinfo.itemno#'
        </cfquery>
        <cfif checkgrade.recordcount neq 0>

        <cfloop from="11" to="50" index="z">

        <cfif evaluate("checkgrade.grd#z#") neq 0>
        <cfset currentrow1=getbodyinfo.currentrow+l>
        <cfset l=l+1>

        <cfset currentrow1=getbodyinfo.currentrow+l>


        <cfquery name="getgroupgrade" datasource='#dts#'>
        select * from icgroup where wos_group='#getbodyinfo.wos_group#'
        </cfquery>

        <cfset itemgrade=evaluate("getgroupgrade.gradd#z#")>
        <cfset getbodyinfo.qty_bil=evaluate("checkgrade.grd#z#")>

        <cfquery name="InsertICBil_S" datasource='#dts#'>
			Insert into r_icbil_s (SRefno, No, Desp)
			values ('#jsstringformat(getbodyinfo.refno)#','#j#','#jsstringformat(itemgrade)# : #getbodyinfo.qty_bil#')
		</cfquery>

		<cfset j = j + 1>

		</cfif>
        </cfloop>
		</cfif>


		<cfif recordcnt gt 1>
			<cfloop from="2" to="#recordcnt#" index="i">
				<cfset str = ListGetAt(info,i,chr(13)&chr(10))>
	            <cfset str1 = Replace(Left(str,1)," ","")>

				<cfset count = Len(str) - 1>
				<cfif count lte 0>
					<cfset count = 1>
				</cfif>
				<cfset str2 = Right(str,count)>
				<cfset str = str1 & str2>

				<cfif trim(str) neq "">
					<cfquery name="InsertICBil_S" datasource='#dts#'>
		 				Insert into r_icbil_s (SRefno, No, Desp)
						values ('#jsstringformat(getbodyinfo.refno)#','#j#','#jsstringformat(str)#')
		  			</cfquery>
					<cfset j = j + 1>
				</cfif>
			</cfloop>
		</cfif>


	</cfloop>
</cfloop>
<cfquery name="update" datasource="#dts#">
	update r_icbil_s
	set brem2 = #k#
	where No = #j-1#
</cfquery>

<cfquery name="MyQuery" datasource="#dts#">
  	select    r_icbil_m.*, r_icbil_s.*, CAST(r_icbil_s.comment AS BINARY) AS Cmd
  	from      r_icbil_m, r_icbil_s
  	where     r_icbil_m.Refno = r_icbil_s.SRefno
	order by r_icbil_s.no
</cfquery>

<cfquery name="getGST" datasource="#dts#">

	SELECT gstno
    FROM
	<cfif tran eq 'PR' or tran eq 'PO' or tran eq 'RC'>
    	#target_apvend#
    <cfelse>
    	#target_arcust#
    </cfif>
    WHERE custno = '#getHeaderInfo.custno#';
</cfquery>

<cfif isDefined("newUUID")>
	<cfset newfname = "bill#newUUID#.pdf">
<cfelse>
	<cfset newfname = "bill.pdf">
</cfif>

<cfoutput>
    <cfreport template="#fname#" format="PDF" query="MyQuery" filename="temp/#newfname#" overwrite="yes"><!--- or "FlashPaper" or "Excel" or "RTF" --->
        <cfreportparam name="decimalPlace_general" value="#getGSetup2.Decl_Uprice#">
        <cfreportparam name="decimalPlace_discount" value="#getGSetup2.Decl_Discount#">
        <cfreportparam name="custSupp" value="#ptype#">
        <cfreportparam name="prefix" value="#tran_prefix#">
        <cfreportparam name="suffix" value="#tran_suffix#">
        <cfreportparam name="decimalPlace_unitPrice" value="#getGsetup2.Decl_Uprice#">
        <cfreportparam name="decimalPlace_discount" value="#getGsetup2.Decl_Discount#">
        <cfreportparam name="dts" value="#dts#">
        <cfreportparam name="amsLink" value="#IIF(Hlinkams eq 'Y',DE('yes'),DE('no'))#">
        <cfreportparam name="compro" value="#getGSetup.compro#">
        <cfreportparam name="compro2" value="#getGSetup.compro2#">
        <cfreportparam name="compro3" value="#getGSetup.compro3#">
        <cfreportparam name="compro4" value="#getGSetup.compro4#">
        <cfreportparam name="compro5" value="#getGSetup.compro5#">
        <cfreportparam name="compro6" value="#getGSetup.compro6#">
        <cfreportparam name="compro7" value="#getGSetup.compro7#">
        <cfreportparam name="companyGSTno" value="#getGSetup.gstno#">
        <cfreportparam name="lINV" value="#gettranname.lINV#">
        <cfreportparam name="lRC" value="#gettranname.lRC#">
        <cfreportparam name="lPR" value="#gettranname.lPR#">
        <cfreportparam name="lDO" value="#gettranname.lDO#">
        <cfreportparam name="lCS" value="#gettranname.lCS#">
        <cfreportparam name="lCN" value="#gettranname.lCN#">
        <cfreportparam name="lDN" value="#gettranname.lDN#">
        <cfreportparam name="lPO" value="#gettranname.lPO#">
        <cfreportparam name="lQUO" value="#gettranname.lQUO#">
        <cfreportparam name="lSO" value="#gettranname.lSO#">
        <cfreportparam name="lRQ" value="#gettranname.lRQ#">
        <cfreportparam name="lSAM" value="#gettranname.lSAM#">
        <cfreportparam name="custno" value="#getHeaderInfo.custno#">
        <cfreportparam name="name" value="#getHeaderInfo.name#">
        <cfreportparam name="refno2" value="#getHeaderInfo.refno2#">

        <cfreportparam name="rem1" value="#getHeaderInfo.rem1#">
        <cfreportparam name="rem2" value="#getHeaderInfo.rem2#">
        <cfreportparam name="rem3" value="#getHeaderInfo.rem3#">
        <cfreportparam name="rem4" value="#getHeaderInfo.rem4#">
        <cfreportparam name="rem5" value="#getHeaderInfo.rem5#">

        <cfreportparam name="GSTno" value="#getGST.gstno#">
        <cfreportparam name="depositBfrTax" value="#getHeaderInfo.rebateamt#">
        <cfreportparam name="bcurr" value="#getgsetup.bcurr#">
        <cfreportparam name="consignment" value="#getheaderinfo.consignment#">
    </cfreport>
</cfoutput>