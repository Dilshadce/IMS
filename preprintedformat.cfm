
<cfif isdefined("url.debug")><cfabort></cfif><cffunction name="findCurrentSetInv" output="true">
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
</cffunction><noscript>
	Javascript has been disabled or not supported in this browser.<br>Please enable Javascript supported before continue.
</noscript>

<cfset trancode="#lcase(tran)#no">
<cfset prefix="#lcase(tran)#code">
<cfset suffix="#lcase(tran)#no2">

<cfquery name="getGSetup" datasource="#dts#">
  	select invoneset,#prefix# as prefix,#trancode#,#suffix# as suffix,
	<cfif tran eq "INV"><cfloop from="2" to="6" index="i">#prefix#_#i#,#trancode#_#i#,#suffix#_#i#,</cfloop></cfif>
	compro,compro2,compro3,compro4,compro5,compro6,compro7,gstno,comuen from gsetup 
</cfquery>

<cfquery name="getGSetup2" datasource='#dts#'>
  	Select concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,concat('.',repeat('_',Decl_Discount)) as Decl_Discount from gsetup2
</cfquery>

<cfset tran_prefix=getGSetup.prefix>
<cfset tran_suffix=getGSetup.suffix>
<cfset fname=BillName&".cfr">

<cfswitch expression="#tran#">
	<cfcase value="RC"><cfset ptype=target_apvend></cfcase>
	<cfcase value="PR"><cfset ptype=target_apvend></cfcase>
	<cfcase value="INV">
		<cfif getGSetup.invoneset eq 0>
			<cfinvoke method="findCurrentSetInv" input="#getGSetup#" refno="#url.nexttranno#" returnvariable="invSetNum"/>
			<cfif invSetNum neq 1>
				<cfset tran_prefix=evaluate("getGSetup.#prefix#_#invSetNum#")>
				<cfset tran_suffix=evaluate("getGSetup.#suffix#_#invSetNum#")>
			</cfif>
		</cfif>
		<cfset ptype=target_arcust>
	</cfcase>
	<cfcase value="DO">
		<cfset ptype=target_arcust>
	</cfcase>
	<cfcase value="CS"><cfset ptype=target_arcust></cfcase>
	<cfcase value="CN"><cfset ptype=target_arcust></cfcase>
	<cfcase value="DN"><cfset ptype=target_arcust></cfcase>
	<cfcase value="QUO"><cfset ptype=target_arcust></cfcase>
	<cfcase value="PO"><cfset ptype=target_apvend></cfcase>
	<cfcase value="SO"><cfset ptype=target_arcust></cfcase>
</cfswitch>


<cfquery name="ClearICBil_M" datasource="#dts#">
  	truncate r_IcBil_M
</cfquery>

<cfquery name="ClearICBil_S" datasource="#dts#">
  	truncate r_IcBil_S
</cfquery>
<cfquery datasource='#dts#' name="getHeaderInfo">
	select a.type,a.refno,a.desp,a.despa,a.refno2,a.term,
	a.source,a.job,a.pono,a.dono,a.currcode,a.note,	
	a.deposit,a.cs_pm_debt,  
	
	a.rem0,a.rem1,a.rem2,a.rem3,a.rem4,a.rem5,a.rem6,a.rem7,a.rem8,a.rem9,a.rem10,a.rem11,a.rem12,a.rem13,a.rem14,
	a.frem0,a.frem1,a.frem2,a.frem3,a.frem4,a.frem5,a.frem6,a.frem7,a.frem8,a.frem9,
	a.comm0,a.comm1,a.comm2,a.comm3,a.comm4,
	a.mc1_bil,a.mc2_bil,a.mc3_bil,a.mc4_bil,a.mc5_bil,a.mc6_bil,a.mc7_bil,
	
	a.fperiod,a.custno as custno,a.wos_date,a.currrate,
	a.agenno,a.name,a.van,
	
	a.gross_bil, 
	a.disp1, a.disp2, a.disp3, a.disc1_bil, a.disc2_bil, a.disc3_bil, a.disc_bil, 
	a.taxp1,a.tax_bil,a.tax1_bil,a.tax2_bil,a.tax3_bil, a.net_bil, a.grand_bil,

	ag.desp as agen_desp,ag.HP as agentHP,ag.commsion1 as agent_email,curr.currency,dr.name as drivername,it.desp as termdesp
	
	from artran a 
	left join icagent ag on a.agenno=ag.agent
	left join driver dr on a.van=dr.driverno
	left join #target_currency# curr on a.currcode = curr.currcode
	left join #target_icterm# it on a.term=it.term
		
	where a.type = '#tran#' and a.refno='#url.nexttranno#'
</cfquery>

<cfset j = 1>
<cfset k = 0>
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
		<cfset getCustAdd.END_USER=getHeaderInfo.van>
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
			set counter_2 = #k#
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
	
	<cftry>
		<cfquery name="InsertICBil_M" datasource="#dts#">
			Insert into r_icbil_m (B_Name, B_Name2, B_Add1, B_Add2, B_Add3, B_Add4, B_Attn, B_Tel, B_Fax,
			D_Name, D_Add1, D_Add2, D_Add3, D_Add4, D_Attn, D_Tel, D_Fax,
			Custno, Refno,PONO,DONO, 
			Date, Terms, Agent, Rem1, Rem2, Rem3, Rem4, 
			Rem5, Rem6, Rem7, Rem8, Rem9, Rem10, Rem11, Rem12, Total, Disp1, Disp2, Disp3, Disamt_bil, 
			Net_bil, Taxp1, Taxamt_bil, CurrCode, CurrRate, Gross_bil, Deposit,REFNO2,TERMDESP)
					
			values 
			(<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustAdd.name#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustAdd.name2#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustAdd.add1#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustAdd.add2#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustAdd.add3#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getCustAdd.add4#">,
			<cfqueryparam cfsqltype="cf_sql_char" value="#getCustAdd.attn#">,
			'#jsstringformat(getCustAdd.phone)#', '#jsstringformat(getCustAdd.fax)#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDeliveryAdd.name#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDeliveryAdd.add1#">, 
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDeliveryAdd.add2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDeliveryAdd.add3#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDeliveryAdd.add4#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getDeliveryAdd.attn#">,
			'#jsstringformat(getDeliveryAdd.phone)#','#jsstringformat(getDeliveryAdd.fax)#',
			'#jsstringformat(getheaderinfo.Custno)#','#jsstringformat(getheaderinfo.refno)#','#jsstringformat(getheaderinfo.pono)#','#jsstringformat(getheaderinfo.dono)#','#jsstringformat(dateformat(getheaderinfo.wos_date,"yyyy-mm-dd"))#',
			'#jsstringformat(getheaderinfo.term)#','#jsstringformat(getheaderinfo.agenno)#',
			'#jsstringformat(getheaderinfo.rem1)#','#jsstringformat(getheaderinfo.rem2)#',
			'#jsstringformat(getheaderinfo.currency)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.rem4#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.rem5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.rem6#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.rem7#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.rem8#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.rem9#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.rem10#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.rem11#">,'#jsstringformat(getheaderinfo.cs_pm_debt)#','#jsstringformat(getheaderinfo.grand_bil)#','#jsstringformat(getheaderinfo.disp1)#', 
			'#jsstringformat(getheaderinfo.disp2)#','#jsstringformat(getheaderinfo.disp3)#','#jsstringformat(thisdisamt_bil)#',
			'#jsstringformat(getheaderinfo.net_bil)#','#jsstringformat(xtaxp1)#','#jsstringformat(getheaderinfo.tax_bil)#','#jsstringformat(getheaderinfo.currcode)#', 
			'#jsstringformat(getheaderinfo.currrate)#','#jsstringformat(getheaderinfo.gross_bil)#','#val(getheaderinfo.deposit)#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.refno2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.termdesp#">)
		</cfquery>
	<cfcatch type="any">
		<cfoutput>#cfcatch.Message#:::#cfcatch.Detail#</cfoutput><cfabort>
	</cfcatch>
	</cftry>
	
	<cfquery name="getbodyinfo" datasource="#dts#">
		select
		a.type,a.refno,a.itemno,a.desp,a.despa,a.comment,a.unit_bil,a.location,
		a.brem1,a.brem2,a.brem3,a.brem4,a.gltradac,a.wos_group,a.category,
		a.packing,a.trancode,
		
		a.price_bil,a.qty_bil,a.amt1_bil,
		a.dispec1,a.dispec2,a.dispec3,a.disamt_bil,
		a.taxpec1,a.taxamt_bil,a.amt_bil
		
		from ictran a
		where type = '#getHeaderInfo.type#'
		and	refno = '#getHeaderInfo.refno#'
		order by trancode
	</cfquery>

	
	<cfloop query="getbodyinfo">
		<cfquery name="getserial" datasource="#dts#">
	    	select * from iserial where refno = '#getbodyinfo.refno#' and type = '#getbodyinfo.type#' 
	    	and itemno = '#getbodyinfo.itemno#' and trancode = '#getbodyinfo.trancode#'
	  	</cfquery>
	  	
	  	<cfif getserial.recordcount gt 0>
	    	<cfset mylist1 = valuelist(getserial.SERIALNO)>
	  	<cfelse>
	    	<cfset mylist1 = ''>
	  	</cfif>
		
		<cfif getserial.recordcount gt 0>
	    	<cfset mylist1 = valuelist(getserial.SERIALNO)>
	  	<cfelse>
	    	<cfset mylist1 = ''>
	  	</cfif>
		
	  	<cfset iteminfo = arraynew(1)>
		<cfset iteminfo[1] = getbodyinfo.desp>
		<cfset iteminfo[2] = getbodyinfo.despa>
		<cfset iteminfo[3] = replace(tostring(getbodyinfo.comment),chr(10)," ","all")>
		<cfset info=''>
		
		<cfif doption eq "0">
			<cfloop index="a" from="1" to="3">
				<cfif iteminfo[a] neq "" and iteminfo[a] neq "XCOST">
					<cfif a neq 3>
						<cfset info = info&iteminfo[a]&chr(10)>
					<cfelse>
						<cfset info = info&iteminfo[a]>
					</cfif>
				</cfif>
			</cfloop>
		<cfelse>
			<cfset charinline=val(doption)>
			<cfloop index="a" from="1" to="3">
				<cfif iteminfo[a] neq "" and iteminfo[a] neq "XCOST">
					<cfif info eq "">
						<cfset info = trim(wrap(iteminfo[a],charinline))>
					<cfelse>
						<cfset info = info&chr(10)&trim(wrap(iteminfo[a],charinline))>
					</cfif>
				</cfif>
			</cfloop>
		</cfif>
		 <cfif info neq "">
		<cfset str = ListGetAt(info,1,chr(13)&chr(10))>
         <cfelse>
                <cfset str = "">
                </cfif>
		<cfset recordcnt = ListLen(info,chr(13)&chr(10))>
		<cfquery name="InsertICBil_S" datasource='#dts#'>
	 		Insert into r_icbil_s (SRefno, No, ItemNo, Desp, SN_No, Unit, Qty, Price, Amt,dispec1, counter_1)
			values ('#jsstringformat(getbodyinfo.refno)#','#j#','#jsstringformat(getbodyinfo.itemno)#',
			<!---<cfqueryparam cfsqltype="cf_sql_varchar" value="#str#">--->'#jsstringformat(str)#','#mylist1#',
			'#jsstringformat(getbodyinfo.unit_bil)#','#val(getbodyinfo.qty_bil)#','#val(getbodyinfo.price_bil)#','#val(getbodyinfo.amt_bil)#',
			'#val(getbodyinfo.dispec1)#','#val(getbodyinfo.currentrow)#')
	  	</cfquery>
	
	
		<cfset j = j + 1>
		
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
				
				<cfquery name="InsertICBil_S" datasource='#dts#'>
	 				Insert into r_icbil_s (SRefno, No, Desp)
					values ('#jsstringformat(getbodyinfo.refno)#','#j#',<!---<cfqueryparam cfsqltype="cf_sql_varchar" value="#str#">--->'#jsstringformat(str)#')
	  			</cfquery>
				<cfset j = j + 1>
			</cfloop>
		</cfif>
        		<cfif getbodyinfo.recordcount neq getbodyinfo.currentrow>
			<cfquery name="InsertICBil_S" datasource='#dts#'>
			 	Insert into r_icbil_s (SRefno, No)
				values ('#jsstringformat(getbodyinfo.refno)#','#j#')
			</cfquery>
			<cfset j = j + 1>
		</cfif>
	</cfloop>
</cfloop>
<cfquery name="update" datasource="#dts#">
	update r_icbil_s
	set counter_2 = #k#
	where No = #j-1#
</cfquery>

<cfquery name="MyQuery" datasource="#dts#">
  	select    r_icbil_m.*, r_icbil_s.*, CAST(r_icbil_s.comment AS BINARY) AS Cmd
  	from      r_icbil_m, r_icbil_s 
  	where     r_icbil_m.Refno = r_icbil_s.SRefno 
	order by r_icbil_s.no
</cfquery>
<cfquery name="getcurrate" datasource="#dts#">
select currrate from currency where currcode='#getHeaderInfo.currcode#' 
</cfquery>
<cfreport template="#fname#" format="PDF" query="MyQuery"><!--- or "FlashPaper" or "Excel" or "RTF" --->
	<cfreportparam name="decimalPlace_general" value="#getGSetup2.Decl_Uprice#">
	<cfreportparam name="decimalPlace_discount" value="#getGSetup2.Decl_Discount#">
	<cfreportparam name="custSupp" value="#ptype#">
	<cfreportparam name="prefix" value="#tran_prefix#">
	<cfreportparam name="suffix" value="#tran_suffix#">
	<cfreportparam name="dts" value="#dts#">
	<cfreportparam name="amsLink" value="#IIF(Hlinkams eq 'Y',DE('yes'),DE('no'))#">
	<cfreportparam name="compro" value="#getGSetup.compro#">
	<cfreportparam name="compro2" value="#getGSetup.compro2#">
	<cfreportparam name="compro3" value="#getGSetup.compro3#">
	<cfreportparam name="compro4" value="#getGSetup.compro4#">
	<cfreportparam name="compro5" value="#getGSetup.compro5#">
	<cfreportparam name="compro6" value="#getGSetup.compro6#">
	<cfreportparam name="compro7" value="#getGSetup.compro7#">
	<cfreportparam name="gstno" value="#getGSetup.gstno#">
    <cfreportparam name="comuen" value="#getGSetup.comuen#">
    <cfreportparam name="currrate" value="#getcurrate.currrate#">
    <cfreportparam name="totalqty" value="#getbodyinfo.qty_bil#">
</cfreport>