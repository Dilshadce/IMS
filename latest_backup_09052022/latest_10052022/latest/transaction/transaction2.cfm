<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">

<cfquery name="getGsetup" datasource="#dts#">
	SELECT *,refno2#tran# as refno2valid
	FROM gsetup;
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
    select * from modulecontrol
</cfquery>

<cfquery datasource="#dts#" name="getdisplaysetup2">
	Select * from displaysetup2
</cfquery>
<cfquery name="getuserdefault" datasource="#dts#">
    select * from userdefault
</cfquery>

<cfquery name="listCurrency" datasource="#dts#">
	SELECT currcode,currency,currency1 
	FROM #target_currency#
	ORDER BY currcode;
</cfquery>

<cfquery name="listAttention" datasource="#dts#">
	SELECT attentionno,name 
	FROM attention;
</cfquery>

<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,transactionSortBy,tran_edit_name from dealer_menu limit 1
</cfquery>

<cfquery name="showall" datasource="#dts#">
	select 
	* 
	from #target_currency#;
</cfquery>


<cfif getGsetup.EDControl eq "Y" and url.ttype eq "Delete">
<cfajaximport tags="cfform">
<cfwindow center="true" width="350" height="300" name="exampass" refreshOnShow="true" closable="false" modal="true" title="Enter Password" initshow="true"
        source="/default/transaction/exampass/exampass.cfm?type=delete" />
</cfif>
<cfset session.hcredit_limit_exceed = "">
<cfset session.bcredit_limit_exceed = "">
<cfset session.customercode = "">
<cfset session.tran_refno = "">

<cfparam name="xrelated" default="0">
<cfparam name="alcreate" default="0">
<cfparam name="alsimple" default="0">
<cfparam name="Submit" default="">
<cfparam name="ChgBillToAddr" default="">
<cfparam name="ChgDeliveryAddr" default="">
<cfparam name="ChgCollectFromAddr" default="">
<cfparam name="Scust" default="">

<!--- --->
<cfloop list="RC,PR,DO,INV,CS,CN,DN,PO,RQ,QUO,SO,SAM" index="i">

<cfif tran eq i>
  	<cfset tran = i>
  	<cfset tranname = evaluate('getGsetup.l#i#')>
  	<cfset trancode = i&"no">
  	<cfset tranarun = i&"arun">
</cfif>
</cfloop>

<cfif tran eq "RC" or tran eq "PR" or tran eq "PO" or tran eq "RQ">
  	<cfquery name="getcustomer" datasource="#dts#">
		select custno,name,name2,currcode,END_USER,arrem1 from #target_apvend# where custno ='#form.custno#'
  	</cfquery>

	<cfset ptype = "Supplier">
<cfelse>
  	<cfquery name="getcustomer" datasource="#dts#">
		select custno,name,name2,currcode,END_USER,arrem1 from #target_arcust# where custno ='#form.custno#'
  	</cfquery>

	<cfset ptype = "Customer">
</cfif>


<cfquery name="currency" datasource="#dts#">
  	select * 
	from #target_currency# 
	where currcode='#getcustomer.currcode#'
</cfquery>


<cfif form.mode eq "Create">
  	<cfset lastaccyear = dateformat(getGsetup.lastaccyear, "dd/mm/yyyy")>
	<cfset period = getGsetup.period>
	<cfset currentdate = dateformat(invoicedate,"dd/mm/yyyy")>
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
	
    
    <cfloop from='1' to="18" index="i">
    
    <cfif readperiod eq numberformat(i,'00')>
    
    <cfquery name="getdaycurrency" datasource="#dts#">
  	select * 
	from #target_currencymonth# 
	where currcode='#getcustomer.currcode#' and fperiod='#numberformat(i,'00')#'
	</cfquery>
    <cfif getdaycurrency.recordcount neq 0>
    	<cfset rates2 = evaluate('getdaycurrency.CurrD#day(currentdate)#')>
    <cfelse>
		<cfset rates2 = evaluate('currency.CurrP#i#')>
    </cfif>
	</cfif>
    
    </cfloop>
    
    <cfif readperiod eq '99' and getgsetup.allowedityearend eq "Y" >
    	<cfset rates2 = currency.CurrP1>
	</cfif>

	<cfif readperiod eq '00'>
		<h3>Error, your Last A/C Year Closing Date is wrong. Please correct it.</h3>
		<cfabort>
	</cfif>
    
    <cfif readperiod eq '99' and getgsetup.allowedityearend eq "N">
        <h3>Error, the bill date is over period 18. Please contact system administrator.</h3>
        <cfabort>
    <cfelseif readperiod eq '99' and getgsetup.allowedityearend eq "Y" and tran neq "SO" and tran neq "PO" and tran neq "QUO" and tran neq "SAM">
    	<h3>Error, the bill date is over period 18. Please contact system administrator.</h3>
        <cfabort>
    </cfif>
    
    <cfquery datasource="#dts#" name="getGeneralInfo">
		select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse 
        from refnoset
		where type = '#tran#'
		and counter = <cfif isdefined("form.invset")>'#form.invset#'<cfelse>1</cfif>
	</cfquery>
    

    <cfif getGeneralInfo.arun eq "1">
		<cfset refnocnt = len(getGeneralInfo.tranno)>
		<cfset cnt = 0>
		<cfset yes = 0>

		<cfloop condition = "cnt lte refnocnt and yes eq 0">
			<cfset cnt = cnt + 1>
			<cfif isnumeric(mid(getGeneralInfo.tranno,cnt,1))>
				<cfset yes = 1>
			</cfif>
		</cfloop>

		<cfset nolen = refnocnt - cnt + 1>
		<!--- <cfset nextno = right(getGeneralInfo.tranno,nolen) + 1> --->
		<cftry>
			<cfset nextno = right(getGeneralInfo.tranno,nolen) + 1>
			<cfcatch type="any">
				<cftry>
					<cfset c = len(listlast(getGeneralInfo.tranno,"/"))>
					<cfset v = "0">
					<cfloop from="2" to="#c#" index="a">
						<cfset v = v&"0">
					</cfloop>
					<cfset a = numberformat(right(getGeneralInfo.tranno,4) + 1,v)>
					<cfset nextno = listfirst(getGeneralInfo.tranno,"/")&"/"&a>
				<cfcatch type="any">
					<cfset nextno=0>
				</cfcatch>
				</cftry>
			</cfcatch>
		</cftry>

		<cfset nocnt = 1>
		<cfset zero = "">

		<cfloop condition = "nocnt lte nolen">
			<cfset zero = zero & "0">
			<cfset nocnt = nocnt + 1>
		</cfloop>

		<cfif tran eq 'SO' or tran eq 'PO' or tran eq 'QUO' or tran eq 'RQ'>
			<cfset limit = 24>
		<cfelse>
			<cfset limit = 20>
		</cfif>
		
		<cftry>
			<cfif cnt gt 1>
				<cfset nexttranno = left(getGeneralInfo.tranno,cnt-1)&numberformat(nextno,zero)>
				<cfif len(nexttranno) gt limit>
					<cfset nexttranno = '99999999'>
				</cfif>
			<cfelse>
				<cftry>
					<cfset nexttranno = numberformat(nextno,zero)>
					<cfcatch type="any">
					<cfset nexttranno = nextno>
					</cfcatch>
				</cftry>
	
				<cfif len(nexttranno) gt limit>
					<cfset nexttranno = '99999999'>
				</cfif>
			</cfif>
		<cfcatch type="any">
			<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
			<cfset nexttranno = newnextNum>	
		</cfcatch>
		</cftry>
		
		
		<!--- <cfif lcase(HcomID) eq "mhsl_i" and tran eq "INV"> --->
		<cfif (lcase(HcomID) eq "mhsl_i" and tran eq "INV") or (lcase(HcomID) eq "ideal_i")>
			<cfset actual_nexttranno = nexttranno>
			<cfif getGeneralInfo.refnocode2 neq "">
				<cfset nexttranno = actual_nexttranno&"/"&getGeneralInfo.refnocode2>
			</cfif>
		<cfelseif lcase(HcomID) eq "zeadine_i" or lcase(HcomID) eq "zeadine09_i">
			<cfset actual_nexttranno = nexttranno>
			<cfif getGeneralInfo.refnocode2 neq "">
				<cfset nexttranno = actual_nexttranno&"-"&getGeneralInfo.refnocode2>
			</cfif>
		<cfelseif lcase(HcomID) eq "topsteel_i" or lcase(HcomID) eq "topsteelhol_i" or lcase(HcomID) eq "chemline_i" or lcase(HcomID) eq "kingston_i" or lcase(HcomID) eq "probulk_i">
			<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
			<cfset nexttranno = newnextNum>	
        <cfelse>
        	<cfinvoke component="cfc.refno" method="processNum" oldNum="#getGeneralInfo.tranno#" returnvariable="newnextNum" />
        	<cfset actual_nexttranno = newnextNum>
            <cfif (getGeneralInfo.refnocode2 neq "" or getGeneralInfo.refnocode neq "") and getGeneralInfo.presuffixuse eq "1">
				<cfset nexttranno = getGeneralInfo.refnocode&actual_nexttranno&getGeneralInfo.refnocode2>
            <cfelse>
            	<cfset nexttranno = actual_nexttranno>
			</cfif>		
		</cfif>
	
	  	<cfset tranarun_1 = getGeneralInfo.arun>
   	<cfelse>
      	<cfquery name="getChkDuplicate" datasource='#dts#'>
        	Select * from artran where type = '#type#' and refno = '#form.nexttranno#'
      	</cfquery>

      	<cfoutput query ="getChkDuplicate">
        	<cfif getChkDuplicate.recordcount GT 0 >
            	<h3><font color="##FF0000">Your #tranname# Number's (#form.nexttranno#) has been created already.<br>Press back to edit it.</font></h3>
          		<cfabort>
  	    	</cfif>
      	</cfoutput>

	  	<cfset nexttranno = "">
	  	<cfset tranarun_1 = "0">
	</cfif>
</cfif>
<!--- --->

<cfif form.mode eq "Delete">
    	<cfquery datasource='#dts#' name="getitem">
	  		select * from artran where refno='#form.currefno#' and type = "#tran#"
    	</cfquery>
		
			<cfquery datasource='#dts#' name="getartran_comment">
				select * from artran_remark where refno='#form.currefno#' and type = "#tran#"
			</cfquery>
		  <cfif getartran_comment.recordcount neq 0>
				<cfset xremark1 = tostring(getartran_comment.remark1)>
				<cfset xremark2 = tostring(getartran_comment.remark2)>
				<cfset xremark3 = tostring(getartran_comment.remark3)>
				<cfset xremark4 = tostring(getartran_comment.remark4)>
				<cfset xremark5 = tostring(getartran_comment.remark5)>
				<cfset xremark6 = tostring(getartran_comment.remark6)>
				<cfset xremark7 = tostring(getartran_comment.remark7)>
				<cfset xremark8 = tostring(getartran_comment.remark8)>
				<cfset xremark9 = tostring(getartran_comment.remark9)>
				<cfset xremark10 = tostring(getartran_comment.remark10)>
			<cfif lcase(HcomID) eq "winbells_i">
					<cfset xremark11 = tostring(getartran_comment.remark11)>
					<cfset xremark12 = tostring(getartran_comment.remark12)>
					<cfset xremark13 = tostring(getartran_comment.remark13)>
					<cfset xremark14 = tostring(getartran_comment.remark14)>
					<cfset xremark15 = tostring(getartran_comment.remark15)>
					<cfset xremark16 = tostring(getartran_comment.remark16)>
					<cfset xremark17 = tostring(getartran_comment.remark17)>
			</cfif>
			<cfelse>
				<cfset xremark1 = "">
				<cfset xremark2 = "">
				<cfset xremark3 = "">
				<cfset xremark4 = "">
				<cfset xremark5 = "">
				<cfset xremark6 = "">
				<cfset xremark7 = "">
				<cfset xremark8 = "">
				<cfset xremark9 = "">
				<cfset xremark10 = "">
			<cfif lcase(HcomID) eq "winbells_i">
					<cfset xremark11 = "">
					<cfset xremark12 = "">
					<cfset xremark13 = "">
					<cfset xremark14 = "">
					<cfset xremark15 = "">
					<cfset xremark16 = "">
					<cfset xremark17 = "">
			</cfif>
		  </cfif>		
		
		<cfif tran eq 'SAM'>
        <cfquery datasource="#dts#" name="getcustomere">
	    		Select name, name2,currcode,agent from #target_apvend# where custno = "#getitem.custno#"
                union all
                Select name, name2,currcode,agent from #target_arcust# where custno = "#getitem.custno#"
      		</cfquery>
		<cfelseif tran eq "RC" or tran eq "PR" or tran eq "PO" or tran eq "RQ">
	  		<cfquery datasource="#dts#" name="getcustomere">
	    		Select name, name2,currcode,agent from #target_apvend# where custno = "#getitem.custno#"
      		</cfquery>
    	<cfelse>
	  		<cfquery datasource="#dts#" name="getcustomere">
	    		Select name, name2,currcode,agent from #target_arcust# where custno = "#getitem.custno#"
	  		</cfquery>
    	</cfif>
		
		<cfset currperiod = "CurrP"&"#val(getitem.fperiod)#">

	  <cfif getitem.currcode neq "">
			<cfset xcurrcode = getitem.currcode>
		<cfelse>
			<cfset xcurrcode = getcustomere.currcode>
	  </cfif>

		<cfset currrate = getitem.currrate>
    	<cfset wos_type = getitem.type>
    	<cfset refno2 = getitem.refno2>
    	<cfset Bil_Custno = getitem.custno>
    	<cfset custno = getitem.custno>
    	<cfset name = getcustomere.name>
    	<cfset name2 = getcustomere.name2>
    	<cfset readpreiod = getitem.fperiod>
    	<cfset nDateCreate = getitem.wos_date>
    	<cfset desp = getitem.desp>
    	<cfset despa = getitem.despa>
    	<cfset xterm = getitem.term>
    	<cfset xsource = getitem.source>
    	<cfset xjob = getitem.job>
    	<cfset xagenno = getitem.agenno>
		<cfset xdriverno = getitem.van>
    	<cfset pono = getitem.pono>
		<cfset dono = getitem.dono>
        <cfset sono = getitem.sono>
        <cfset quono = getitem.quono>
		<cfset remark0 = form.BCode>
    	<cfset remark2 = form.B_Attn>
    	<cfset remark4 = form.B_Phone>
		<cfset remark5 = getitem.rem5>
    	<cfset remark6 = getitem.rem6>
    	<cfset remark7 = getitem.rem7>
    	<cfset remark8 = getitem.rem8>
    	<cfset remark9 = getitem.rem9>
    	<cfset remark10 = getitem.rem10>
    	<cfset remark11 = getitem.rem11>
        <cfset permitno = getitem.permitno>
		<cfset frem0 = form.B_name>
		<cfset frem1 = form.B_name2>
		<cfset frem2 = form.B_add1>
		<cfset frem3 = form.B_add2>
		<cfset frem4 = form.B_add3>
		<cfset frem5 = form.B_add4>
		<cfset remark13 = ''>
		<cfset frem6 = form.B_fax>
		<cfset phonea = form.b_phone2>
        <cfset e_mail = form.b_email>
        <cfset postalcode = form.postalcode>
        <cfset d_postalcode = form.d_postalcode>
		<cfset remark1 = form.DCode>
        <cfset remark3 = form.D_Attn>
        <cfset remark12 = form.D_Phone>
        <cfset frem7 = form.D_name>
        <cfset frem8 = form.D_name2>
        <cfset frem9 = ''>
        <cfset comm0 = form.D_add1>
        <cfset comm1 = form.D_add2>
        <cfset comm2 = form.D_add3>
        <cfset comm3 = form.D_add4>
        <cfset remark14 = ''>
        <cfset comm4 = form.D_fax>
        <cfset d_phone2 = form.d_phone2>
        <cfset d_email = form.d_email>
        <cfif getGsetup.collectaddress eq 'Y'>
			<cfset remark15 = form.CCode>
            <cfset remark16 = form.C_name>
            <cfset remark17 = form.C_name2>
            <cfset remark18 = form.C_add1>
            <cfset remark19 = form.C_add2>
            <cfset remark20 = form.C_add3>
            <cfset remark21 = form.C_add4>
            <cfset remark22 = form.C_add5>
            <cfset remark23 = form.C_attn>
            <cfset remark24 = form.C_phone>
            <cfset remark25 = form.C_fax>
		</cfif>
        <cfif lcase(hcomid) eq 'ugateway_i'>
            <cfset via = form.via>
		</cfif>
        
    	<cfset userid = getitem.userid>
		<cfset nexttranno = form.currefno>
		<cfset mode = "Delete">
		<cfset title = "Mode  =  Delete">
		<cfset button = "Delete">
  	</cfif>

  	<cfif form.mode eq "Create">
   		<cfset wos_type = "">
		
        <cfif tran eq 'SAM'>
        <cfquery datasource="#dts#" name="getcustomere">
	    		Select name, name2,currcode,agent,term from #target_apvend# where custno = "#form.custno#"
                union all
                Select name, name2,currcode,agent,term from #target_arcust# where custno = "#form.custno#"
      		</cfquery>
		<cfelseif tran eq "rc" or tran eq "pr" or tran eq "po" or tran eq "rq">
	  		<cfquery datasource="#dts#" name="getcustomere">
				Select name, name2,currcode,agent,term from #target_apvend# where custno = "#form.custno#"
	  		</cfquery>
		<cfelse>
	  		<cfquery datasource="#dts#" name="getcustomere">
				Select name, name2,currcode,agent,term from #target_arcust# where custno = "#form.custno#"
	  		</cfquery>
        </cfif>

		<cfset Bil_Custno = "">
		<cfset xcurrcode = getcustomere.currcode>

	  <cfif rates2 eq "">
			<cfset currrate = 1>
		<cfelse>
			<cfset currrate = rates2>
	  </cfif>
		
	  <cfset readpreiod = "">
      <cfif isdefined('form.refno2set')>
        <cfset refno2 = form.refno2set>
	  <cfelse>
		<cfset refno2 = "">
      </cfif>
		<cfset nDateCreate = "">
	    <cfif tran eq "INV">
			<cfset desp = getuserdefault.inv_desp>
		<cfelseif tran eq "RC">
			<cfset desp = getuserdefault.rc_desp>
		<cfelseif tran eq "PR">
			<cfset desp = getuserdefault.pr_desp>
		<cfelseif tran eq "DO">
			<cfset desp = getuserdefault.do_desp>
		<cfelseif tran eq "CS">
			<cfset desp = getuserdefault.cs_desp>
		<cfelseif tran eq "CN">
       
			<cfset desp = getuserdefault.cn_desp>
		<cfelseif tran eq "DN">
			<cfset desp = getuserdefault.dn_desp>
		<cfelse>
			<cfset desp = "">
	    </cfif>
		<cfset despa = "">
        <cfif getcustomere.term eq ''>
        <cfset xterm = getgsetup.ddlterm>
        <cfelse>
		<cfset xterm = getcustomere.term>
        </cfif>
    	<cfset xsource = Huserproject>
    	<cfset xjob = Huserjob>
		<cfset xagenno = getcustomere.agent>
        <cfif getcustomere.agent eq ''>
		<cfquery name="getagentfromuser" datasource="#dts#">
  select agent from #target_icagent# where 0=0 and (discontinueagent='' or discontinueagent is null) and agent = '#huserid#' or agentid = '#huserid#' order by agent
		</cfquery>
        <cfif getagentfromuser.agent neq ''>
		<cfset xagenno = getagentfromuser.agent>
        <cfelse>
        <cfset xagenno = ''>
        </cfif>
		</cfif>
        
    	<cfset xdriverno = getcustomer.END_USER>
      	<cfif isdefined('form.issueno')>
            <cfset pono='#form.issueno#'>
        <cfelse>
            <cfset pono = "">
      	</cfif>
		
		<cfset dono = "">
		<cfset remark0 = form.BCode>
    	<cfset remark2 = form.B_Attn>
    	<cfset remark4 = form.B_Phone>
        <cfif tran eq "RQ" and isdefined('form.remark5')>
        <cfset remark5 = form.remark5>
        <cfelse>
		<cfset remark5 = "">
        </cfif>
        <cfif lcase(hcomid) eq "imperial1_i">
		<cfset remark6 = "12">
        <cfelseif lcase(hcomid) eq "safetrans_i">
		<cfset remark6 = getcustomer.arrem1>
        <cfelse>
        <cfset remark6 = "">
        </cfif>
		<cfset remark7 = "">
        <cfif lcase(hcomid) eq "ascend_i">
        <cfset remark8 = "Terms of Payment :">
        <cfelse>
		<cfset remark8 = "">
        </cfif>
		<cfset remark9 = "">
		<cfset remark10 = "">
		<cfset remark11 = "">
        <cfif tran eq 'QUO' and getgsetup.quotationlead eq 'Y' and isdefined("form.leadno")>
        <cfset permitno = form.leadno>
        <cfelse>
        <cfset permitno = "">
        </cfif>
		<cfset frem0 = form.B_name>
		<cfset frem1 = form.B_name2>
		<cfset frem2 = form.B_add1>
		<cfset frem3 = form.B_add2>
		<cfset frem4 = form.B_add3>
		<cfset frem5 = form.B_add4>
		<!---<cfset remark13 = form.B_add5>--->
        <cfset remark13 = ''>
		<cfset frem6 = form.B_fax>
		<cfset phonea = form.b_phone2>
        <cfset e_mail = form.b_email>
        <cfset postalcode = form.postalcode>
        <cfset d_postalcode = form.d_postalcode>
        <cfset sono = "">
		<cfset quono = "">
		
		<!---For avent /top steel--->	
			<cfset xremark1 = "">
			<cfset xremark2 = "">
			<cfset xremark3 = "">
			<cfset xremark4 = "">
			<cfset xremark5 = "">
			<cfset xremark6 = "">
			<cfset xremark7 = "">
			<cfset xremark8 = "">
			<cfset xremark9 = "">
			<cfset xremark10 = "">
			<cfset xremark11 = "">
            <cfset xremark12 = "">
            <cfset xremark13 = "">
            <cfset xremark14 = "">
            <cfset xremark15 = "">
            <cfset xremark16 = "">
            <cfset xremark17 = "">
			<cfset remark1 = form.DCode>
			<cfset remark3 = form.D_Attn>
			<cfset remark12 = form.D_Phone>
			<cfset frem7 = form.D_name>
			<cfset frem8 = form.D_name2>
			<cfset frem9 = ''>
			<cfset comm0 = form.D_add1>
			<cfset comm1 = form.D_add2>
			<cfset comm2 = form.D_add3>
			<cfset comm3 = form.D_add4>
			<cfset remark14 = ''>
			<cfset comm4 = form.D_fax>
            <cfset d_phone2 = form.d_phone2>
            <cfset d_email = form.d_email>
        <cfif getGsetup.collectaddress eq 'Y'>
				<cfset remark15 = form.CCode>
				<cfset remark16 = form.C_name>
				<cfset remark17 = form.C_name2>
				<cfset remark18 = form.C_add1>
				<cfset remark19 = form.C_add2>
				<cfset remark20 = form.C_add3>
				<cfset remark21 = form.C_add4>
				<cfset remark22 = form.C_add5>
				<cfset remark23 = form.C_attn>
				<cfset remark24 = form.C_phone>
				<cfset remark25 = form.C_fax>
		</cfif>
        <cfif lcase(hcomid) eq 'ugateway_i'>
            	<cfset via = form.via >
		</cfif>
		<cfset userid = "">

		<!--- Same as Javascript - function ChgDueDate() --->
    	<!--- <cfif lcase(HcomID) neq "mhca_i" and lcase(HcomID) neq "thaipore_i" and lcase(hcomid) neq "jaynbtrading_i" and lcase(HcomID) neq "demo_i" and lcase(HcomID) neq "winbells_i"> --->
		<cfif lcase(HcomID) eq "tmt_i" or lcase(HcomID) eq "taff_i">
			<cfif xterm neq ''>
		  		<cfloop query = "getTerm">
	 				<cfif xterm eq getTerm.term>
	          			<cfif sign eq "P">
	        				<cfquery datasource="#dts#" name="getDays">
				  				Select days from #target_icterm# where term = '#xterm#'
	  						</cfquery>
	
							<cfset Days = getDays.days>
							<cfset xDate = '#dateformat(invoicedate, 'dd/mm/yyyy')#'>
							<cfset yDate = DateAdd("y",Days,xDate)>
	  						<cfset remark6 = '#dateformat(yDate, 'dd/mm/yyyy')#'>
	   		  			<cfelse>
			    			<!---     //Not available for minus date yet. --->
	  		  			</cfif>
					</cfif>
	 	  		</cfloop>
	    	<cfelse>
	      		<cfset remark6 = ''>
			</cfif>
        <cfelseif lcase(hcomid) eq "imperial1_i">
		<cfset remark6 = "12">
		<cfelse>
			<cfset remark6 = ''>
		</cfif>
		

		<cfset mode = "Create">
		<cfset title = "Mode=Create">
		<cfset button = "Create">
	</cfif>

	<cfif form.mode eq "Edit">
		<cfquery datasource='#dts#' name="getitem">
	  		select * from artran where refno='#form.currefno#' and type = "#tran#"
		</cfquery>

		<cfset Bil_Custno=getitem.custno>
		<cfset custno=form.custno>
		
        <cfif tran eq 'SAM'>
        <cfquery datasource="#dts#" name="getcustomere">
	    		Select name, name2,currcode,agent from #target_apvend# where custno = "#form.custno#"
                union all
                Select name, name2,currcode,agent from #target_arcust# where custno = "#form.custno#"
      		</cfquery>
		<cfelseif tran eq "rc" or tran eq "pr" or tran eq "po" or tran eq "rq">
	  		<cfquery datasource="#dts#" name="getcustomere">
				Select name, name2,currcode,agent from #target_apvend# where custno = "#form.custno#"
	  		</cfquery>
		<cfelse>
	  		<cfquery datasource="#dts#" name="getcustomere">
				Select name, name2,currcode,agent from #target_arcust# where custno = "#form.custno#"
	  		</cfquery>
    	</cfif>

		<cfset name = getcustomere.name>
    	<cfset name2 = getcustomere.name2>

   	  <cfif getitem.currcode neq "">
			<cfset xcurrcode = getitem.currcode>
		<cfelse>
			<cfset xcurrcode = getcustomere.currcode>
	  </cfif>

		<cfset currrate = getitem.currrate>
    	<cfset wos_type = getitem.type>
    	<cfset readpreiod = getitem.fperiod>
    	<cfset nDateCreate = getitem.wos_date>
    	<cfset refno2 = getitem.refno2>
    	<cfset desp = getitem.desp>
    	<cfset despa = getitem.despa>
    	<cfset xterm = getitem.term>
    	<cfset xsource = getitem.source>
    	<cfset xjob = getitem.job>
    	<cfset xagenno = getitem.agenno>
		<cfset xdriverno = getitem.van>
    	<cfset pono = getitem.pono>
		<cfset dono = getitem.dono>
		<cfset sono = getitem.sono>
        <cfset quono = getitem.quono>
		<cfset remark0 = form.BCode>
        <cfset remark2 = form.B_Attn>
        <cfset remark4 = form.B_Phone>
        <cfset remark5 = getitem.rem5>
        <cfset remark6 = getitem.rem6>
        <cfset remark7 = getitem.rem7>
        <cfset remark8 = getitem.rem8>
        <cfset remark9 = getitem.rem9>
        <cfset remark10 = getitem.rem10>
        <cfset remark11 = getitem.rem11>
        <cfset permitno = getitem.permitno>
        <cfset frem0 = form.B_name>
        <cfset frem1 = form.B_name2>
        <cfset frem2 = form.B_add1>
        <cfset frem3 = form.B_add2>
        <cfset frem4 = form.B_add3>
        <cfset frem5 = form.B_add4>
        <cfset remark13 = ''>
        <cfset frem6 = form.B_fax>
        <cfset phonea = form.b_phone2>
        <cfset e_mail = form.b_email>
        <cfset postalcode = form.postalcode>
        <cfset d_postalcode = form.d_postalcode>
		<cfset remark1 = form.DCode>
        <cfset remark3 = form.D_Attn>
        <cfset remark12 = form.D_Phone>
        <cfset frem7 = form.D_name>
        <cfset frem8 = form.D_name2>
        <cfset frem9 = ''>
        <cfset comm0 = form.D_add1>
        <cfset comm1 = form.D_add2>
        <cfset comm2 = form.D_add3>
        <cfset comm3 = form.D_add4>
        <cfset remark14 = ''>
        <cfset comm4 = form.D_fax>
        <cfset d_phone2 = form.d_phone2>
        <cfset d_email = form.d_email>
        <cfif getGsetup.collectaddress eq 'Y'>
			<cfset remark15 = form.CCode>
            <cfset remark16 = form.C_name>
            <cfset remark17 = form.C_name2>
            <cfset remark18 = form.C_add1>
            <cfset remark19 = form.C_add2>
            <cfset remark20 = form.C_add3>
            <cfset remark21 = form.C_add4>
            <cfset remark22 = form.C_add5>
            <cfset remark23 = form.C_attn>
            <cfset remark24 = form.C_phone>
            <cfset remark25 = form.C_fax>
		</cfif>
        <cfif lcase(hcomid) eq 'ugateway_i'>
            	<cfset via = form.via>
		</cfif>
		<cfset userid = getitem.userid>
    	<cfset nexttranno = form.currefno>
		<cfset mode = "Edit">
    	<cfset title = "Mode = Edit ">
    	<cfset button = "Edit">
  	</cfif>



<!--- --->

<cfset buttonStatus = "btn btn-primary active" >
<cfset buttonStatus2 = "btn btn-default" >

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!---<meta name="viewport" content="width=device-width, initial-scale=1.0">--->
<title><cfoutput>#mode# #tranname#</cfoutput></title>
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">

<!--[if lt IE 9]>
	<script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
	<script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
<![endif]-->
<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>

<script>
	var dts='#dts#';
	var target='#url.target#';
	var action='#mode#';
</script>


	<script type="text/javascript" src="/latest/js/maintenance/target.js"></script>
    <!---Filter Template--->
    <cfinclude template="/latest/transaction/filter/filterAgent.cfm">
    <cfinclude template="/latest/transaction/filter/filterDriver.cfm">
    <cfinclude template="/latest/transaction/filter/filterJob.cfm">
    <cfinclude template="/latest/transaction/filter/filterProject.cfm">
    <cfinclude template="/latest/transaction/filter/filterTerm.cfm">
    <!--- --->
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>

   <!--- --->
   <script language="JavaScript">
	function validate(){
	<cfif getdisplaysetup2.project_compulsory eq "Y">
	if(document.getElementById("Source").value == ""){
		alert('Please Choose a Project!');
		return false;
	}
	</cfif>
	
	}
	
	
	function validatetime(fieldid)
	{
		re = /^(\d{1,2})\/(\d{1,2})\/(\d{4}) (\d{1,2}):(\d{2})$/;
		
		
	<!---if(document.getElementById(fieldid).value != '' && !document.getElementById(fieldid).value.match(re)) {
      alert("Invalid datetime format: " + document.getElementById(fieldid).value);
      document.getElementById(fieldid).focus();
    }---->
	
	if(document.getElementById(fieldid).value != '') {
      if(regs = document.getElementById(fieldid).value.match(re)) {
        // day value between 1 and 31
        if(regs[1] < 1 || regs[1] > 31) {
          alert("Invalid value for day: " + regs[1]);
          document.getElementById(fieldid).focus();
        }
        // month value between 1 and 12
        if(regs[2] < 1 || regs[2] > 12) {
          alert("Invalid value for month: " + regs[2]);
          document.getElementById(fieldid).focus();
        }
        // year value between 1902 and 2012
        if(regs[3] < 1902 || regs[3] > (new Date()).getFullYear()) {
          alert("Invalid value for year: " + regs[3] + " - must be between 1902 and " + (new Date()).getFullYear());
          document.getElementById(fieldid).focus();
        }
		if(regs[4] > 23) {
            alert("Invalid value for hours: " + regs[4]);
            document.getElementById(fieldid).focus();
          }
		  if(regs[5] > 59) {
          alert("Invalid value for minutes: " + regs[5]);
          document.getElementById(fieldid).focus();
        }
      } else {
        alert("Invalid date format: " + document.getElementById(fieldid).value);
        document.getElementById(fieldid).focus();
      }
	}
	}
		function updateDriver(drno,drname){
			myoption = document.createElement("OPTION");
			myoption.text = drno + " - " + drname;
			myoption.value = drno;
			document.invoicesheet.driver.options.add(myoption);
			var indexvalue = document.getElementById("driver").length-1;
			document.getElementById("driver").selectedIndex=indexvalue;
		}
			function updatejob(jobno){
			myoption = document.createElement("OPTION");
			myoption.text = jobno;
			myoption.value = jobno;
			document.invoicesheet.Job.options.add(myoption);
			var indexvalue = document.getElementById("job").length-1;
			document.getElementById("job").selectedIndex=indexvalue;
		}
		function updateProject(Projectno){
			myoption = document.createElement("OPTION");
			myoption.text = Projectno;
			myoption.value = Projectno;
			document.invoicesheet.Source.options.add(myoption);
			var indexvalue = document.getElementById("Source").length-1;
			document.getElementById("Source").selectedIndex=indexvalue;
		}
		function selectlist(varval,varattb){		
		for (var idx=0;idx<document.getElementById(varattb).options.length;idx++) 
		{
			if (varval==document.getElementById(varattb).options[idx].value) 
			{
				document.getElementById(varattb).options[idx].selected=true;
				
			}
		}
		}

		function updateremark6(){
		selectlist(document.getElementById('remark61').value,'remark6');
		selectlist(document.getElementById('remark71').value,'remark7');
		selectlist(document.getElementById('remark81').value,'remark8');
		selectlist(document.getElementById('remark131').value,'remark13');
		}
		
		function updateascendremark6(){
		setTimeout("document.getElementById('remark6').value=document.getElementById('ascendremark61').value+' To '+document.getElementById('ascendremark62').value;",1500);
		}
		
		function updateshipvia2()
		{
		setTimeout("document.getElementById('remark10').value=document.getElementById('hidshipvia').value",500);

		}
	</script>
   <!--- --->

</head>
<body>
<cfoutput>
       
        
        
		<form class="form-horizontal" role="form" action="transaction3.cfm" method="post"><!--- onsubmit="document.getElementById('custno').disabled=false";--->
		<cfset newuuid = rereplace(createUUID(),'-','','all')>
		<cfset formname = "transpage"&newuuid>
        <cfset session[#formName#]="transpage">
        	<input type="hidden" name="newuuid" id="newuuid" value="#newuuid#"> 
            <input type="text" name="mode" value="#mode#">
            <input type="text" name="type" id="type" value="#listfirst(mode)#">
			<input type="hidden" name="tran" id="tran" value="#listfirst(tran)#">
            <input type="hidden" name="custno" value="#listfirst(form.custno)#">
            <input type="hidden" name="name" value="#convertquote(getcustomere.name)#">
            <input type="hidden" name="name2" value="#getcustomere.name2#">
            <input type="hidden" name="frem0" value="#convertquote(frem0)#">
            <input type="hidden" name="frem1" value="#convertquote(frem1)#">
            <input type="hidden" name="invoicedate" value="#listfirst(form.invoicedate)#">		
            <input type="hidden" name="frem2" value="#frem2#">
            <input type="hidden" name="frem3" value="#frem3#">
            <input type="hidden" name="frem4" value="#frem4#">
            <input type="hidden" name="frem5" value="#frem5#">
            <input type="hidden" name="frem6" value="#frem6#">
            <input type="hidden" name="frem7" value="#convertquote(frem7)#">
            <input type="hidden" name="frem8" value="#convertquote(frem8)#">
            <input type="hidden" name="frem9" value="#frem9#">
            <input type="hidden" name="comm0" value="#convertquote(comm0)#">
            <input type="hidden" name="comm1" value="#convertquote(comm1)#">
            <input type="hidden" name="comm2" value="#convertquote(comm2)#">
            <input type="hidden" name="comm3" value="#convertquote(comm3)#">
            <input type="hidden" name="comm4" value="#convertquote(comm4)#">
            <input type="hidden" name="d_phone2" value="#convertquote(d_phone2)#">
            <input type="hidden" name="d_email" value="#convertquote(d_email)#">
            <input type="hidden" name="remark12" value="#remark12#">
            
            <input type="hidden" name="remark0" value="#form.BCode#">
            <input type="hidden" name="remark1" value="#form.DCode#">
            <input type="hidden" name="remark2" value="#remark2#">
            <input type="hidden" name="remark3" value="#remark3#">
            <input type="hidden" name="remark4" value="#remark4#">
            
            
            <cfif lcase(hcomid) eq 'amtaircon_i' and tran eq "PO">
            <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i")>
            <input type="hidden" name="remark14" value="#remark14#">
            <cfelse>
            <input type="hidden" name="remark13" value="#remark13#">
            <input type="hidden" name="remark14" value="#remark14#">
            </cfif>
            <input type="hidden" name="phonea" value="#phonea#">
            <input type="hidden" name="e_mail" value="#e_mail#">
            <input type="hidden" name="postalcode" value="#postalcode#">
            <input type="hidden" name="d_postalcode" value="#d_postalcode#">
            <cfif getGsetup.collectaddress eq 'Y'>
                <input type="hidden" name="remark15" value="#remark15#">
                <input type="hidden" name="remark16" value="#remark16#">
                <input type="hidden" name="remark17" value="#remark17#">
                <input type="hidden" name="remark18" value="#remark18#">
                <input type="hidden" name="remark19" value="#remark19#">
                <input type="hidden" name="remark20" value="#remark20#">
                <input type="hidden" name="remark21" value="#remark21#">
                <input type="hidden" name="remark22" value="#remark22#">
                <input type="hidden" name="remark23" value="#remark23#">
                <input type="hidden" name="remark24" value="#remark24#">
                <input type="hidden" name="remark25" value="#remark25#">
            </cfif>
            <cfif lcase(hcomid) eq 'ugateway_i'>
                <input type="hidden" name="via" value="#via#">
            </cfif>
            <cfif form.mode eq "Delete" or form.mode eq "Edit">
                <input type="hidden" name="readperiod" value="#getitem.fperiod#">
            <cfelse>
                <input type="hidden" name="readperiod" value="#listfirst(readperiod)#">
            </cfif>

            <cfif isdefined("form.invset")>
                <input type="hidden" name="invset" id="invset" value="#listfirst(invset)#">
                <input type="hidden" name="tranarun" id="tranarun" value="#listfirst(tranarun)#">
            </cfif>
            
            <cfif isdefined("form.recover") and form.mode eq "Delete">
			<input type="hidden" name="recover" value="#listfirst(form.recover)#">
            </cfif>
             <!---  chonghow --->
			<cfif isdefined("form.recoverCoC") and form.mode eq "Delete">
                <input name="recoverCoC" id="recoverCoC" type="hidden" value="1">
            </cfif>
            <!---  chonghow --->
            
            <cfif isdefined("form.keepDeleted") and form.mode eq "Delete">	<!--- ADD ON 22-12-2009 --->
                <input name="keepDeleted" type="hidden" value="#listfirst(form.keepDeleted)#">
            </cfif>
            
            <table width="100%">
            <tr>
            <td colspan="100%">
            <img src="/images/transaction page header-02.png" width="100%" >
            </td>
            </tr>
            <tr>
            <td rowspan="4" width="30%">
            <table style="margin:5% 5% 5% 5%" border="1" width="80%" height="80">
            <tr>
            <td width="50%" height="100%" style=" background-color:##999; font-size:14px" align="center">Last Sales Order<br><font size="+1">1111</font></td>
			<td width="50%" height="100%" style=" font-size:14px" align="center">New Sales Order<br><font size="+1">
            <cfif tranarun_1 eq "1">
			<input name="nexttranno" type="hidden" value="#nexttranno#">
            #nexttranno#
            <cfelse>
            <input name="nexttranno" id="nexttranno" type="text" value="#nexttranno#" onvalidate="javascript:NextTransNo()" size="10" onKeyUp="this.value=trim(this.value)" <cfif lcase(HcomID) eq "leatat_i">maxlength="30"<cfelse><cfif tran eq 'SO' or tran eq 'PO' or tran eq 'QUO'>maxlength="24"<cfelse><cfif lcase(HcomID) eq "meisei_i" and tran eq "RC">maxlength = "10"<cfelse>maxlength="20"</cfif></cfif></cfif>>
            </cfif>
            </font></td>
            </tr>
            </table>

            
            </td>
            <th>#getGsetup.refno2#</th>
            <th colspan="2">#getGsetup.lDRIVER#</th>
            
            </tr>
            <tr>
 			<td width="30%" nowrap>
            <input type="text" name="refno2" value="#refno2#">
            </td>
            <td width="40%" colspan="2">
            <cfif xdriverno neq ''>
				<cfset driverdisplayValue = xdriverno>   
            <cfelse>
                <cfset driverdisplayValue = "Choose an #getGsetup.lDRIVER#">
            </cfif>
            <input type="hidden" id="driver" name="driver" class="driverFilter"  placeholder="#driverdisplayValue#" />
            <cfif getpin2.h1C10 eq 'T'><br /><a href="driver.cfm?type=Create" target="_blank">Create New End User</a></cfif>
            </td>
            </tr>
            <tr>
            <th>#getGsetup.lAGENT#</th>
            <th colspan="2">Currency</th>
            </tr>
            <tr>
            <td>
            <cfif xagenno neq ''>
				<cfset agentdisplayValue = xagenno>   
            <cfelse>
                <cfset agentdisplayValue = "Choose an #getGsetup.lagent#">
            </cfif>
            <input type="hidden" id="agenno" name="agenno" class="agentFilter"  placeholder="#agentdisplayValue#" />
            </td>
            <td colspan="2">
            <cfif form.mode eq "Create" or form.custno neq Bil_Custno>
          		<input type="text" name="refno3" value="#listfirst(xcurrcode)#" size="4" readonly>
            <cfelse>
                <input name="refno3" type="text" size="10" value="#listfirst(xcurrcode)#" readonly>
            </cfif>
            
       

            <input name="currrate" id="currrate" type="text" size="10" value="<cfif val(listfirst(currrate)) neq 0>#Numberformat(listfirst(currrate), "._____")#<cfelse>1.000</cfif>">
            <input type="Button" name="UpdCurrRate" value="Update" onClick="displayrate(),displayname()">
            <input type="checkbox" name="itemrate" value="1">Item Rate
            </td>
            </tr>
            <tr>
            <th>Sales Order Date</th>
            <th>Term</th>
            <th width="15%">Project</th>
            <th>Job</th>
            </tr>
            
            <tr>
            <td>#dateformat(nDateCreate,'dd/mm/yyyy')#</td>
            <td>
            <cfif xterm neq ''>
				<cfset termdisplayValue = xterm>   
            <cfelse>
                <cfset termdisplayValue = "Choose a Terms">
            </cfif>
            <input type="hidden" id="terms" name="terms" class="termFilter"  placeholder="#termdisplayValue#" />
            </td>
            <td>
            <cfif xSource neq ''>
				<cfset projectdisplayValue = xSource>   
            <cfelse>
                <cfset projectdisplayValue = "Choose a #getGsetup.lproject#">
            </cfif>
            <input type="hidden" id="Source" name="Source" class="projectFilter"  placeholder="#projectdisplayValue#" />
            </td>
            <td>
            <cfif xjob neq ''>
				<cfset jobdisplayValue = xjob>   
            <cfelse>
                <cfset jobdisplayValue = "Choose a #getGsetup.ljob#">
            </cfif>
            <input type="hidden" id="Job" name="Job" class="jobFilter"  placeholder="#jobdisplayValue#" />
            </td>
            
            </tr>
            <tr>
            <th>Customer</th>
            <th colspan="3">Description</th>
            </tr>
            <tr>
            <td>#custno# - #name#</td>
            <td><input name="desp" type="text" size="40" maxlength="40" value="#desp#">
            <input name="despa" type="text" size="40" maxlength="40" value="#despa#">
            </td>
            </tr>
            
            
            </table>
            
            <!---End Header--->
            
            <table width="100%">
            <tr>
            <td width="50%">Quo No
            </td>
            <td width="50%"><cfif lcase(hcomid) eq "fdipx_i">Invoice No.<cfelseif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">Factory<cfelseif lcase(hcomid) eq "sdc_i" or lcase(hcomid) eq "sdab_i">Validity<cfelseif (lcase(hcomid) eq "weikeninv_i" or lcase(hcomid) eq "weikenint_i" or lcase(hcomid) eq "weikenid_i" or lcase(hcomid) eq "futurehome_i" or lcase(hcomid) eq "weikenbuilder_i" or lcase(hcomid) eq "weikendecor_i")>Status<cfelseif lcase(hcomid) eq "apnt_i">Inv No<cfelseif lcase(hcomid) eq "atc2005_i">Tag<cfelseif lcase(hcomid) eq "draco_i">Job Type (Others)<cfelse>Permit No</cfif>
            </td>
            </tr>
            <tr>
            <td><input type="text" name="quono" value="#quono#" size="40" maxlength="35"></td>
            <td>
            <cfif lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "gorgeous_i">
            <select name="permitno">
            <option value="BLK 20" <cfif permitno eq 'BLK 20'>selected</cfif>>BLK 20</option>
            <option value="BLK 22" <cfif permitno eq 'BLK 22'>selected</cfif>>BLK 22</option>
            </select>
            <cfelseif (lcase(hcomid) eq "weikeninv_i" or lcase(hcomid) eq "weikenint_i" or lcase(hcomid) eq "weikenid_i" or lcase(hcomid) eq "futurehome_i" or lcase(hcomid) eq "weikenbuilder_i" or lcase(hcomid) eq "weikendecor_i")>
            <cfif lcase(husergrpid) eq "admin" or lcase(husergrpid) eq "super">
            <select name="permitno">
            <option value="" <cfif permitno eq ''>selected</cfif>></option>
            <option value="locked" <cfif permitno eq 'locked'>selected</cfif>>Locked</option>
            </select>
            <cfelse>
            <input type="text" name="permitno" id="permitno" value="#permitno#" readonly>
            </cfif>
            <cfelseif lcase(hcomid) eq "atc2005_i">
            <cfquery datasource="#dts#" name="getshelf">
            select * from icshelf order by shelf
            </cfquery>
            <select name="permitno">
            <option value="">Choose a tag</option>
            <cfloop query="getshelf">
            <option value="#getshelf.shelf#" <cfif permitno eq getshelf.shelf>selected</cfif>>#getshelf.shelf# - #getshelf.desp#</option>
            </cfloop>
            
            </select>
            <cfelse>
            <input type="text" name="permitno" value="#permitno#" size="40" maxlength="100" <cfif tran eq 'QUO' and getgsetup.quotationlead eq 'Y' and isdefined("form.leadno")>readonly</cfif>>
            </cfif>
            </td>
            </tr>
            
            <tr>
            <td width="50%">#getgsetup.bodyso#
            </td>
            <td width="50%">#getgsetup.rem5#
            </td>
            </tr>
            <tr>
            <td><input type="text" name="sono" value="#sono#" size="40" maxlength="35"></td>
            <td>
            <cfif lcase(hcomid) eq "tmt_i" or lcase(HcomID) eq "taff_i" or lcase(HcomID) eq "aqua_i">
				<cfquery datasource="#dts#" name="getcust">
					Select custno,name from #target_arcust# order by name
				</cfquery>
				<select name="remark5">
					<option value="">Please choose</option>
					<cfloop query="getcust">
						<option value="#getcust.custno#"<cfif remark5 eq getcust.custno>Selected</cfif>>#getcust.custno# - #getcust.name#</option>
					</cfloop>
				</select>
            <cfelseif tran eq 'RQ'>
				<cfquery datasource="#dts#" name="getcust">
					Select custno,name from #target_arcust#
                    where 0=0
                    <cfif getpin2.h1t00 eq 'T'>
					<cfif getgsetup.agentlistuserid eq "Y">and ucase(agent) in (SELECT agent FROM #target_icagent# WHERE agentlist like "%#ucase(huserid)#%")
					<cfelse>
           			and (ucase(created_by)='#ucase(huserid)#' or ucase(agent)='#ucase(huserid)#')  
					</cfif>
					<cfelse>
                    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i">
                   
                    <cfelse>
					<cfif Huserloc neq "All_loc">
					and (created_by in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
					</cfif>
                    </cfif>
                    </cfif>
                     order by custno
				</cfquery>
				<select name="remark5">
					<option value="">Please choose</option>
					<cfloop query="getcust">
						<option value="#getcust.custno#"<cfif remark5 eq getcust.custno>Selected</cfif>>#getcust.custno# - #getcust.name#</option>
					</cfloop>
				</select>
			
			<cfelseif lcase(hcomid) eq "kingston_i" and tran eq "PO">
            
            <input type="text" name="remark5" value="Tay Si Lin" size="40" maxlength="35">
			      <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
            <cfquery name="getveh" datasource="#dts#">
            SELECT * from vehicles where custcode = "#custno#"
            </cfquery>
            <select name="remark5" id="remark5" onChange="setTimeout('updateremark6()',1000);">
            <option value="">Select a vehicles</option>
            <cfloop query="getveh">
                <option value="#getveh.carno#" <cfif remark5 eq getveh.carno>Selected</cfif>>#getveh.carno#</option>
            </cfloop>
            </select>
             <cfelseif lcase(HcomID) eq "kimlee_i" and tran eq "CN" or lcase(HcomID) eq "bakersoven_i" and tran eq "CN">
			 <script type="text/javascript">
             function selectlist(custno){	
			for (var idx=0;idx<document.getElementById('remark5').options.length;idx++) {
					if (custno==document.getElementById('remark5').options[idx].value) {
						document.getElementById('remark5').options[idx].selected=true;
					}
				} 
				}
	</script>
               <cfquery name="getkiminv" datasource="#dts#">
        SELECT refno,custno,name from artran where type = "INV" group by refno
        </cfquery>
        <select name="remark5" id="remark5">
        <option value="">Select an invoice number</option>
        <cfloop query="getkiminv">
        	<option value="#getkiminv.refno#" <cfif remark5 eq getkiminv.refno>Selected</cfif>>#getkiminv.refno#-#getkiminv.custno# #getkiminv.name#</option>
        </cfloop>
        </select><img src="/images/find.jpg" width="20" height="14.5" onClick="javascript:ColdFusion.Window.show('findInvoice');" />
        
            
                 <cfelseif lcase(hcomid) eq "taftc_i">
         <cfinput type="text" name="remark5" id="remark5"  bind="cfc:tran2cfc.getdate1('#dts#',{Job})" />
        
		<cfelseif lcase(HcomID) eq "unichem_i" and tran eq "INV">
        <cfquery name="getservicecode" datasource="#dts#">
        SELECT "" as servicecode, "Please Select a Service Agreement" as desp
        union all
        SELECT servicecode,concat(servicecode,' - ',desp) as desp from serviceagree
        </cfquery>  
        <cfselect name="remark5" id="remark5" query="getservicecode" value="servicecode" display="desp" selected="#remark5#" />
		
        
         <cfelseif  lcase(HcomID) eq "stjohns_i">
			<input type="text" name="remark5" value="#remark5#" size="40" maxlength="120">
            <cfelseif  lcase(HcomID) eq "mastercare_i" or lcase(HcomID) eq "gorgeous_i">
            <input type="checkbox" name="remcheck" id="remcheck" value="Yes" <cfif remark5 eq "YES"> checked</cfif> onClick="if(this.checked == true){document.getElementById('remark5').value='YES';} else {document.getElementById('remark5').value='NO';}">
            <input type="hidden" name="remark5" id="remark5" value="#remark5#" size="40" maxlength="80">
            <cfelseif lcase(HcomID) eq "vtop_i">
			
            <input type="text" name="remark5" value="#remark5#" size="40" maxlength="200">
            <cfelseif lcase(hcomid) eq "sdc_i" or lcase(hcomid) eq "sdab_i">
            <select name="remark5">
            <option value="">Choose a delivery terms</option>
            <option value="FCA Glimakra, Sweden Incoterms 2010" <cfif remark5 eq 'FCA Glimakra, Sweden Incoterms 2010'>selected</cfif>>FCA Glimakra, Sweden Incoterms 2010</option>
            <option value="FCA Fristad, Sweden Incoterms 2010" <cfif remark5 eq 'FCA Fristad, Sweden Incoterms 2010'>selected</cfif>>FCA Fristad, Sweden Incoterms 2010</option>
            <option value="FCA Brondby, Denmark Incoterms 2010" <cfif remark5 eq 'FCA Brondby, Denmark Incoterms 2010'>selected</cfif>>FCA Brondby, Denmark Incoterms 2010</option>
            <option value="FOB Gothenburg, Sweden Incoterms 2010" <cfif remark5 eq 'FOB Gothenburg, Sweden Incoterms 2010'>selected</cfif>>FOB Gothenburg, Sweden Incoterms 2010</option>
            <option value="CIF Hong Kong port by sea freight Incoterms 2010" <cfif remark5 eq 'CIF Hong Kong port by sea freight Incoterms 2010'>selected</cfif>>CIF Hong Kong port by sea freight Incoterms 2010</option>
            <option value="CIF Singapore port by sea freight Incoterms 2010" <cfif remark5 eq 'CIF Singapore port by sea freight Incoterms 2010'>selected</cfif>>CIF Singapore port by sea freight Incoterms 2010</option>
            <option value="CIF Manila port by sea freight Incoterms 2010" <cfif remark5 eq 'CIF Manila port by sea freight Incoterms 2010'>selected</cfif>>CIF Manila port by sea freight Incoterms 2010</option>
            <option value="FOB Copenhagen port, Incoterms 2010" <cfif remark5 eq 'FOB Copenhagen port, Incoterms 2010'>selected</cfif>>FOB Copenhagen port, Incoterms 2010</option>
            <option value="Excluding local handling fee and/or duties and taxes" <cfif remark5 eq 'Excluding local handling fee and/or duties and taxes'>selected</cfif>>Excluding local handling fee and/or duties and taxes</option>
            <option value="Ex works Hong Kong stock." <cfif remark5 eq 'Ex works Hong Kong stock'>selected</cfif>>Ex works Hong Kong stock. </option>
            <option value="FCA Suzhou, PRC Incoterms 2010" <cfif remark5 eq 'FCA Suzhou, PRC Incoterms 2010'>selected</cfif>>FCA Suzhou, PRC Incoterms 2010</option>
            
            </select>
            <cfelseif lcase(hcomid) eq "ascend_i">
            <cfif tran eq "PO">
            <input type="text" name="remark5" value="AV/IT Rental" size="40" maxlength="80">
            <cfelse>
            <select name="remark5">
            <option value="">Choose a title</option>
           <option value="AV/ IT RENTAL" <cfif remark5 eq "AV/ IT RENTAL">selected</cfif>>AV/ IT RENTAL</option>
                <option value="PURCHASE AND INSTALL" <cfif remark5 eq "PURCHASE AND INSTALL">selected</cfif>>PURCHASE AND INSTALL</option>
            <option value="PROVISION OF INTERNET SERVICES" <cfif remark5 eq "PROVISION OF INTERNET SERVICES">selected</cfif>>PROVISION OF INTERNET SERVICES</option>
            </select>
            </cfif>
            <cfelseif getmodule.auto eq "1">
            <cfquery name="getveh" datasource="#dts#">
            SELECT * from vehicles <cfif lcase(hcomid) eq "coolnlite_i" or lcase(hcomid) eq "imperial1_i">where custcode = "#custno#"</cfif>
            </cfquery>
            <select name="remark5" id="remark5" onChange="setTimeout('updateremark6()',1000);">
            <cfif lcase(hcomid) eq "coolnlite_i" or lcase(hcomid) eq "imperial1_i">
            <cfif getveh.recordcount eq 0>
            <option value="">Select a vehicles</option>
            <cfelse>
            
            </cfif>
            <cfelse><option value="">Select a vehicles</option></cfif>
            <cfloop query="getveh">
                <option value="#getveh.entryno#" <cfif remark5 eq getveh.entryno>Selected</cfif>>#getveh.entryno#</option>
            </cfloop>
            </select>
            <input type="button" name="Svehi1" value="Search" onClick="javascript:ColdFusion.Window.show('findvehicle');" >
			<cfelse>
            
            
        <cfif hcomid eq 'mylustre_i'>
         
         <cfquery name="general" datasource="#replace(dts,'_i','_c','all')#">
select * from generalSetup
</cfquery>
            <cfquery name="getDeliveryTiming" datasource="#dts#">
select * from deliveryTiming where id = '#general.DeliveryTiming#'
</cfquery>


            <select name="remark5" id="remark5">
            <option value="">Choose a Delivery Timing</option>
           <cfloop from='1' to='4' index='a'>
           <cfif isnumeric(evaluate('getDeliveryTiming.day#a#'))>
           
           <option  <cfif "#evaluate('getDeliveryTiming.day#a#')#-#timeformat(evaluate('getDeliveryTiming.time#a#'),'hh:mm tt')##timeformat(evaluate('getDeliveryTiming.totime#a#'),'hh:mm tt')#" eq remark5>selected</cfif>   value="#evaluate('getDeliveryTiming.day#a#')#-#timeformat(evaluate('getDeliveryTiming.time#a#'),'hh:mm tt')##timeformat(evaluate('getDeliveryTiming.totime#a#'),'hh:mm tt')#"><!--- #DayOfWeekAsString(evaluate('getDeliveryTiming.day#a#'))# ---><cfif #evaluate('getDeliveryTiming.day#a#')# eq 1>AM
           <cfelseif #evaluate('getDeliveryTiming.day#a#')# eq 2>
           PM
           <cfelseif #evaluate('getDeliveryTiming.day#a#')# eq 3>
           Night
           <cfelse>
           Saturday
           </cfif> - #timeformat(evaluate('getDeliveryTiming.time#a#'),'hh:mm tt')# to #timeformat(evaluate('getDeliveryTiming.totime#a#'),'hh:mm tt')#</option>
           </cfif>
           
         </cfloop>
         </select>
        
        <cfelse>  
            
			<cfif trim(getGsetup.remark5list) eq ''>
            <input type="text" name="remark5" value="#remark5#" size="40" maxlength="80">
            <cfelse>
            <select name="remark5" id="remark5">
            <option value="">Please choose</option>
            <cfloop list="#getGsetup.remark5list#" index="i">
            <option value="#i#" <cfif remark5 eq i>selected</cfif>>#i#</option>
            </cfloop>
            </select>
            </cfif>
			</cfif></cfif>
            </td>
            </tr>
            
            <!--- --->
            
            <tr>
            <td width="50%">#getgsetup.bodypo#
            </td>
            <td width="50%">#getgsetup.rem6#
            </td>
            </tr>
            <tr>
            <td><input type="text" name="pono" value="#pono#" size="40" maxlength="35"></td>
            <td>
            <cfif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
        <select name="remark6" id="remark6" >
        <cfloop list="0%,10%,15%,20%,30%,40%,50%" index="i">
        <option value="#i#" <cfif remark6 eq #i#>selected</cfif>>#i#</option>
        </cfloop></select>
		<cfinput type="hidden" id="remark61" name="remark61" bind="cfc:accordtran2.getremark6('#dts#',{remark5})" >
        <cfelseif lcase(hcomid) eq "aimpest_i" or lcase(hcomid) eq "safetrans_i">
        <cfquery name="getarrem1" datasource="#dts#">
            SELECT arrem1 from #target_arcust# where custno = "#trim(custno)#"
            </cfquery>
        <input type="text" name="remark6" value="#getarrem1.arrem1#" size="40" maxlength="80">
        <cfelseif lcase(hcomid) eq "taftc_i">
         <cfinput type="text" name="remark6" id="remark6"  bind="cfc:tran2cfc.getdate2('#dts#',{Job})" />

		<cfelseif lcase(hcomid) eq "visionlaw_i">
        <textarea name="remark6" id="remark6" cols='40' rows='3' onKeyDown="limitText(this.form.remark6,200);" onKeyUp="limitText(this.form.remark6,200);">#remark6#</textarea>
        <cfelseif lcase(hcomid) eq "sdc_i" or lcase(hcomid) eq "sdab_i">
        <select name="remark6">
        <option value="">Choose a Payment Terms</option>
        <option value="30% down payment due with purchase order." <cfif remark6 eq '30% down payment due with purchase order.'>selected</cfif>>30% down payment due with purchase order.</option>
        <option value="40% down payment due with purchase order." <cfif remark6 eq '40% down payment due with purchase order.'>selected</cfif>>40% down payment due with purchase order.</option>
        <option value="50% down payment due with purchase order." <cfif remark6 eq '50% down payment due with purchase order.'>selected</cfif>>50% down payment due with purchase order.</option>
        <option value="60% against B/L" <cfif remark6 eq '60% against B/L'>selected</cfif>>60% against B/L</option>
        <option value="70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark6 eq '70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark6 eq '60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark6 eq '70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark6 eq '60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="Balance 10 days from invoice date" <cfif remark6 eq 'Balance 10 days from invoice date'>selected</cfif>>Balance 10 days from invoice date</option>
        <option value="Balance 14 days from invoice date" <cfif remark6 eq 'Balance 14 days from invoice date'>selected</cfif>>Balance 14 days from invoice date</option>
        <option value="Goods remain the property of Sveba-Dahlen Group until full payment is made" <cfif remark6 eq 'Goods remain the property of Sveba-Dahlen Group until full payment is made'>selected</cfif>>Goods remain the property of Sveba-Dahlen Group until full payment is made</option>
        <option value="The quotation is subject to our general terms and conditions available in our price list" <cfif remark6 eq 'The quotation is subject to our general terms and conditions available in our price list'>selected</cfif>>The quotation is subject to our general terms and conditions available in our price list</option>
        </select>
       <cfelseif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
        <select name="remark6">
        <option value="4-6 weeks ARO" <cfif remark6 eq '4-6 weeks ARO'>selected</cfif>>4-6 weeks ARO</option>
        <option value="Ex-Stock Prior to Sales" <cfif remark6 eq 'Ex-Stock Prior to Sales'>selected</cfif>>Ex-Stock Prior to Sales</option>
        <option value="1-2 Weeks  ARO" <cfif remark6 eq '1-2 Weeks  ARO'>selected</cfif>>1-2 Weeks  ARO</option>
        <option value="2- 4 week s ARO" <cfif remark6 eq '2- 4 week s ARO'>selected</cfif>>2- 4 week s ARO</option>
        <option value="6-8 weeks AR0" <cfif remark6 eq '6-8 weeks AR0'>selected</cfif>>6-8 weeks AR0</option>
        <option value="See Remarks***" <cfif remark6 eq 'See Remarks***'>selected</cfif>>See Remarks***</option>
        <option value="As per Tender Documents***" <cfif remark6 eq 'As per Tender Documents***'>selected</cfif>>As per Tender Documents***</option>
        <option value="Immediately" <cfif remark6 eq 'Immediately'>selected</cfif>>Immediately</option>
        <option value="" <cfif remark6 eq ''>selected</cfif>></option>
        </select>
         <cfelseif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i">
            <input type="text" name="remark6" value="#remark6#" size="40" maxlength="80" >
         <cfelseif lcase(hcomid) eq "ascend_i">
            <input type="hidden" name="ascendremark61" value="" size="40" maxlength="80" >
            <input type="hidden" name="ascendremark62" value="" size="40" maxlength="80" >
            <input type="text" name="remark6" value="#remark6#" size="40" maxlength="80" >
            From <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(ascendremark61);updateascendremark6();"> To
            <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(ascendremark62);updateascendremark6();">
            <cfelseif getmodule.auto eq "1" and lcase(hcomid) neq "imperial1_i">
            <input type="text" name="remark6" value="#remark6#" size="40" maxlength="80"  onblur="validatetime('remark6')">
            <input type="button" name="generatedatetime" id="generatedatetime" onClick="document.getElementById('remark6').value='#dateformat(now(),'DD/MM/YYYY')#'+' #timeformat(now(),'HH:MM')#'" value="Start Time" />
  		<cfelseif lcase(hcomid) eq "dgalleria_i">
        <cfinput type="text" name="remark6" value="#remark6#" size="40" maxlength="10" validate="eurodate" message="Kindly key in date format">
        <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark6);">(DD/MM/YYYY)
                <cfelse>
            <cfif trim(getGsetup.remark6list) eq ''>
            <input type="text" name="remark6" value="#remark6#" size="40" maxlength="80">
            <cfelse>
            <select name="remark6" id="remark6">
            <option value="">Please choose</option>
            <cfloop list="#getGsetup.remark6list#" index="i">
            <option value="#i#" <cfif remark6 eq i>selected</cfif>>#i#</option>
            </cfloop>
            </select>
            </cfif>
            </cfif>
            </td>
            </tr>
            
            <tr>
            <td width="50%">#getgsetup.bodydo#
            </td>
            <td width="50%">#getgsetup.rem7#
            </td>
            </tr>
            <tr>
            <td><input type="text" name="dono" value="#listfirst(dono)#" size="40" maxlength="35"></td>
            <td>
            <!--- MODIFIED ON 23-02-2009,PURPOSE: NET_I NEW PO FORMAT --->
				<cfif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i") and tran eq "PO">
					<select name="remark7">
						<option value="">Please Select the Client</option>
						<cfloop query="getarcust">
							<option value="#custno#" <cfif custno eq remark7>selected</cfif>>#custno# - #name#</option>
						</cfloop>
					</select>
                <cfelseif lcase(hcomid) eq "kingston_i" and tran eq "PO">
				<select name="remark7" id="remark7">
                <option value="Kindly send to our office" selected>Kindly send to our office</option>
                <option value="Kindly send to our site">Kindly send to our site</option>
                <option value="Self-Collection">Self-Collection</option>
                </select>
                
                          <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
                        
                <select name="remark7" id="remark7">
  <cfloop list="OPC,NORMAL" index="i">
  <option value="#i#" <cfif remark7 eq #i#>selected</cfif>>#i#</option>
</cfloop></select><cfinput type="hidden" id="remark71" name="remark71" bind="cfc:accordtran2.getremark7('#dts#',{remark5})">
 				<cfelseif lcase(hcomid) eq "mcjim_i">
                <input type="text" name="remark7" value="#remark7#" size="40" maxlength="50">
                <cfelseif lcase(hcomid) eq "powernas_i">
                <input type="text" name="remark7" value="#remark7#" size="40" maxlength="200">
                <cfelseif lcase(hcomid) eq "visionlaw_i">
        <textarea name="remark7" id="remark7" cols='40' rows='3' onKeyDown="limitText(this.form.remark7,300);" onKeyUp="limitText(this.form.remark7,300);">#remark7#</textarea>	
        		<cfelseif lcase(hcomid) eq "gorgeous_i" or lcase(hcomid) eq "mastercare_i" or lcase(hcomid) eq "litelab_i" or lcase(hcomid) eq "dgalleria_i">
                <cfif isdate(remark7)>
            <cfset remark7=dateformat(remark7,'DD/MM/YYYY')>
            </cfif>
            <input type="text" name="remark7" value="#remark7#" size="40" maxlength="80" readonly>
            <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark7);">(DD/MM/YYYY)	
            <cfelseif lcase(hcomid) eq "sdc_i" or lcase(hcomid) eq "sdab_i">
        <select name="remark7">
        <option value="">Choose a Payment Terms</option>
        <option value="30% down payment due with purchase order." <cfif remark7 eq '30% down payment due with purchase order.'>selected</cfif>>30% down payment due with purchase order.</option>
        <option value="40% down payment due with purchase order." <cfif remark7 eq '40% down payment due with purchase order.'>selected</cfif>>40% down payment due with purchase order.</option>
        <option value="50% down payment due with purchase order." <cfif remark7 eq '50% down payment due with purchase order.'>selected</cfif>>50% down payment due with purchase order.</option>
        <option value="60% against B/L" <cfif remark7 eq '60% against B/L'>selected</cfif>>60% against B/L</option>
        <option value="70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark7 eq '70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark7 eq '60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark7 eq '70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark7 eq '60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="Balance 10 days from invoice date" <cfif remark7 eq 'Balance 10 days from invoice date'>selected</cfif>>Balance 10 days from invoice date</option>
        <option value="Balance 14 days from invoice date" <cfif remark7 eq 'Balance 14 days from invoice date'>selected</cfif>>Balance 14 days from invoice date</option>
        <option value="Goods remain the property of Sveba-Dahlen Group until full payment is made" <cfif remark7 eq 'Goods remain the property of Sveba-Dahlen Group until full payment is made'>selected</cfif>>Goods remain the property of Sveba-Dahlen Group until full payment is made</option>
        <option value="The quotation is subject to our general terms and conditions available in our price list" <cfif remark7 eq 'The quotation is subject to our general terms and conditions available in our price list'>selected</cfif>>The quotation is subject to our general terms and conditions available in our price list</option>
        </select>
       <cfelseif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
        <select name="remark7">
        <option value="14 days" <cfif remark7 eq '14 days'>selected</cfif>>14 days</option>
        <option value="7  days" <cfif remark7 eq '7  days'>selected</cfif>>7  days</option>
        <option value="30 days" <cfif remark7 eq '30 days'>selected</cfif>>30 days</option>
        <option value="45 days" <cfif remark7 eq '45 days'>selected</cfif>>45 days</option>
        <option value="" <cfif remark7 eq ''>selected</cfif>></option>
        </select>
        <cfelseif getmodule.auto eq "1" and lcase(hcomid) neq "imperial1_i">
                
					<input type="text" name="remark7" value="#remark7#" size="40" maxlength="80"  onblur="validatetime('remark7')">
                    <input type="button" name="generatedatetime2" id="generatedatetime2" onClick="document.getElementById('remark7').value='#dateformat(now(),'DD/MM/YYYY')#'+' #timeformat(now(),'HH:MM')#'" value="Complete Time" />
				<cfelse>
                
                <cfif trim(getGsetup.remark7list) eq ''>
            	<input type="text" name="remark7" value="#remark7#" size="40" maxlength="80">
            	<cfelse>
            	<select name="remark7" id="remark7">
            	<option value="">Please choose</option>
            	<cfloop list="#getGsetup.remark7list#" index="i">
            	<option value="#i#" <cfif remark7 eq i>selected</cfif>>#i#</option>
            	</cfloop>
            	</select>
            	</cfif>
					
				</cfif>			
            </td>
            </tr>
            
            <tr>
            <td width="50%"></td>
            <td width="50%">#getgsetup.rem8#
            </td>
            </tr>
            <tr>
            <td></td>
            <td>
            <cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
				<select name="remark8">
				<option value="">Please select</option>
				<cfloop query="getlocation">
				<option value="#location#" <cfif remark8 eq location>selected</cfif>>#desp#</option>
				</cfloop>
				</select>
            <cfelseif lcase(hcomid) eq "net_i">
            <input type="text" name="remark8" value="<cfif remark8 neq "" and remark8 neq "0000-00-00"> #dateformat(remark8,"dd/mm/yyyy")#</cfif>" size="10" maxlength="10">
			<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark8);">(DD/MM/YYYY)
			<cfelseif lcase(hcomid) eq "tmt_i" or lcase(HcomID) eq "taff_i">
				<select name="remark8">
				<option value="">Please Select</option>
				<option value="directReferral" <cfif remark8 eq "directReferral">selected</cfif>>Direct Referral</option>
				<option value="onspot" <cfif remark8 eq "onspot">selected</cfif>>On Spot</option>
				<option value="telesales" <cfif remark8 eq "telesales">selected</cfif>>Tele-Sales</option>
				</select>
                <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
                        
                <select name="remark8" id="remark8">
<option value="" <cfif remark8 eq "">Selected</cfif>>Please select a coverage type</option>
<option value="Comprehensive" <cfif remark8 eq "Comprehensive">Selected</cfif>>Comprehensive</option>
<option value="Third party, fire and theft" <cfif remark8 eq "Third party, fire and theft">Selected</cfif>>Third party, fire and theft</option>
<option value="Third party only" <cfif remark8 eq "Third party only">Selected</cfif>>Third party only</option>
</select><cfinput type="hidden" id="remark81" name="remark81" bind="cfc:accordtran2.getremark8('#dts#',{remark5})">

<cfelseif lcase(hcomid) eq "redhorn_i" and tran eq "PO">
                        
                <select name="remark8" id="remark8">
<option value="" <cfif remark8 eq "">Selected</cfif>>Please select a Delivery type</option>
<option value="Self Collect" <cfif remark8 eq "Self Collect">Selected</cfif>>Self Collect</option>
<option value="Deliver By Supplier" <cfif remark8 eq "Deliver By Supplier">Selected</cfif>>Deliver By Supplier</option>
</select>

<cfelseif lcase(hcomid) eq "taftc_i">
         <cfinput type="text" name="remark8" id="remark8"  bind="cfc:tran2cfc.getdate3('#dts#',{Job})" />
         
         <cfelseif lcase(hcomid) eq "sdc_i" or lcase(hcomid) eq "sdab_i">
        <select name="remark8">
        <option value="">Choose a Payment Terms</option>
        <option value="30% down payment due with purchase order." <cfif remark8 eq '30% down payment due with purchase order.'>selected</cfif>>30% down payment due with purchase order.</option>
        <option value="40% down payment due with purchase order." <cfif remark8 eq '40% down payment due with purchase order.'>selected</cfif>>40% down payment due with purchase order.</option>
        <option value="50% down payment due with purchase order." <cfif remark8 eq '50% down payment due with purchase order.'>selected</cfif>>50% down payment due with purchase order.</option>
        <option value="60% against B/L" <cfif remark8 eq '60% against B/L'>selected</cfif>>60% against B/L</option>
        <option value="70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark8 eq '70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>70% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark8 eq '60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>60% against irrevocable L/C, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark8 eq '70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>70% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order." <cfif remark8 eq '60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.'>selected</cfif>>60% against irrevocable L/C at 60 days sight, opened to and confirmed by Nordea Bank Sweden. Details will be provided with order.</option>
        <option value="Balance 10 days from invoice date" <cfif remark8 eq 'Balance 10 days from invoice date'>selected</cfif>>Balance 10 days from invoice date</option>
        <option value="Balance 14 days from invoice date" <cfif remark8 eq 'Balance 14 days from invoice date'>selected</cfif>>Balance 14 days from invoice date</option>
        <option value="Goods remain the property of Sveba-Dahlen Group until full payment is made" <cfif remark8 eq 'Goods remain the property of Sveba-Dahlen Group until full payment is made'>selected</cfif>>Goods remain the property of Sveba-Dahlen Group until full payment is made</option>
        <option value="The quotation is subject to our general terms and conditions available in our price list" <cfif remark8 eq 'The quotation is subject to our general terms and conditions available in our price list'>selected</cfif>>The quotation is subject to our general terms and conditions available in our price list</option>
        </select>
        <cfelseif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
        <select name="remark8">
        <option value="Ex-Works" <cfif remark8 eq 'Ex-Works'>selected</cfif>>Ex-Works</option>
        <option value="FOB Singapore" <cfif remark8 eq 'FOB Singapore'>selected</cfif>>FOB Singapore</option>
        <option value="CIF " <cfif remark8 eq 'CIF'>selected</cfif>>CIF </option>
        <option value="CIP" <cfif remark8 eq 'CIP'>selected</cfif>>CIP</option>
        <option value="-" <cfif remark8 eq '-'>selected</cfif>>-</option>
        <option value=""></option>
        <option value="FCA" <cfif remark8 eq 'FCA'>selected</cfif>>FCA</option>
        <option value="CPT" <cfif remark8 eq 'CPT'>selected</cfif>>CPT</option>
        <option value="DAT" <cfif remark8 eq 'DAT'>selected</cfif>>DAT</option>
        <option value="DAP" <cfif remark8 eq 'DAP'>selected</cfif>>DAP</option>
        <option value="DDP" <cfif remark8 eq 'DDP'>selected</cfif>>DDP</option>
        <option value="FAS" <cfif remark8 eq 'FAS'>selected</cfif>>FAS</option>
        <option value="CFR" <cfif remark8 eq 'CFR'>selected</cfif>>CFR</option>
        </select>
        <cfelseif getmodule.auto eq "1" and lcase(hcomid) neq "imperial1_i">
            <cfif isdate(remark8)>
            <cfset remark8=dateformat(remark8,'DD/MM/YYYY')>
            </cfif>
            <input type="text" name="remark8" value="#remark8#" size="40" maxlength="80" readonly>
            <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark8);">(DD/MM/YYYY)
			<cfelse>
            
            <cfif trim(getGsetup.remark8list) eq ''>
            	<input type="text" name="remark8" value="#remark8#" size="40" maxlength="80">
            	<cfelse>
            	<select name="remark8" id="remark8">
            	<option value="">Please choose</option>
            	<cfloop list="#getGsetup.remark8list#" index="i">
            	<option value="#i#" <cfif remark8 eq i>selected</cfif>>#i#</option>
            	</cfloop>
            	</select>
            	</cfif>
            
				
			</cfif>
            </td>
            </tr>
            
            <tr>
            <td width="50%"></td>
            <td width="50%">#getgsetup.rem9#
            </td>
            </tr>
            <tr>
            <td></td>
            <td>
            <cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "net_i" or ((lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i") and tran eq "PO")>
				<input type="text" name="remark9" value="#dateformat(remark9,"dd/mm/yyyy")#" size="10" maxlength="10">
				<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark9);">(DD/MM/YYYY)
                
                                      <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
                        
 <cfinput type="text" id="remark9" name="remark9" bind="cfc:accordtran2.getremark9('#dts#',{remark5})">
<cfelseif lcase(hcomid) eq "taftc_i">
         <cfinput type="text" name="remark9" id="remark9"  bind="cfc:tran2cfc.getdate4('#dts#',{Job})" />
         
         <cfelseif (lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "mfssmy_i") and tran eq "SO">
         <cfinput type="text" name="remark9" value="#remark9#" size="40" maxlength="35" required="yes" message="Kindly Fill in Doctor Name">
         <cfelseif lcase(hcomid) eq "mastercare_i" or lcase(HcomID) eq "gorgeous_i">
         <input type="checkbox" name="rem9check" id="rem9check" value="Yes" <cfif remark9 eq "YES"> checked</cfif> onClick="if(this.checked == true){document.getElementById('remark9').value='YES';} else {document.getElementById('remark9').value='NO';}">
         <input type="hidden" name="remark9" id="remark9" value="#remark9#" size="40" maxlength="35">
         <cfelseif lcase(hcomid) eq "sdc_i" or lcase(hcomid) eq "sdab_i">
         <select name="remark9">
         <option value="">Choose a warranty</option>
         <option value="Glimek: 12 month warrenty from date of commissioning or 15 month from date of shipment whichever is sooner according to Glimek warrenty terms 2011-02-01" <cfif remark9 eq 'Glimek: 12 month warrenty from date of commissioning or 15 month from date of shipment whichever is sooner according to Glimek warrenty terms 2011-02-01'>selected</cfif>>Glimek: 12 month warrenty from date of commissioning or 15 month from date of shipment whichever is sooner according to Glimek warrenty terms 2011-02-01</option>
         <option value="Sveba-Dahlen AB: 12 month warrenty or 2700 working hours from date of installation, or 18 month from shipment date, whichever comes sooner according to Sveba-Dahlen warrenty conditions" <cfif remark9 eq 'Sveba-Dahlen AB: 12 month warrenty or 2700 working hours from date of installation, or 18 month from shipment date, whichever comes sooner according to Sveba-Dahlen warrenty conditions'>selected</cfif>>Sveba-Dahlen AB: 12 month warrenty or 2700 working hours from date of installation, or 18 month from shipment date, whichever comes sooner according to Sveba-Dahlen warrenty conditions</option>
         <option value="BEAR: 24 month warrenty from invoice or delivery date to our distributor, however maximum 30 month from dispatch from our factory according to BEAR warrenty conditions" <cfif remark9 eq 'BEAR: 24 month warrenty from invoice or delivery date to our distributor, however maximum 30 month from dispatch from our factory according to BEAR warrenty conditions'>selected</cfif>>BEAR: 24 month warrenty from invoice or delivery date to our distributor, however maximum 30 month from dispatch from our factory according to BEAR warrenty conditions</option>
         <option value="Refer to www.bearvarimixer.dk/legal" <cfif remark9 eq 'Refer to www.bearvarimixer.dk/legal'>selected</cfif>>Refer to www.bearvarimixer.dk/legal</option>
         <option value="Refer to www.sveba-dahlen.com/legal" <cfif remark9 eq 'Refer to www.sveba-dahlen.com/legal'>selected</cfif>>Refer to www.sveba-dahlen.com/legal</option>
         <option value="Refer to www.glimek.com/legal" <cfif remark9 eq 'Refer to www.glimek.com/legal'>selected</cfif>>Refer to www.glimek.com/legal</option>
         </select>
         <cfelseif lcase(hcomid) eq "vsolutionspteltd_i" or lcase(hcomid) eq "vsyspteltd_i">
        <cfquery name="getvsolutionsremark" datasource="#dts#">
        SELECT arrem1 from #target_arcust# where custno = '#custno#'
        </cfquery>
         <cfinput type="text" id="remark9" name="remark9" value="#getvsolutionsremark.arrem1#" maxlength="80" size="40">
         <cfelseif lcase(hcomid) eq "tranz_i">
         <input type="checkbox" name="cbremark9" id="cbremark9" value="1" <cfif remark9 neq ''>checked</cfif> onClick="if(this.checked == true){document.getElementById('remark9').value='Sign'}else{document.getElementById('remark9').value=''}">
         <input type="hidden" name="remark9" value="#remark9#" size="40" maxlength="80">
         <cfelseif lcase(hcomid) eq "ascend_i">
         
         
         <cfinput type="text" id="remark9" name="remark9" value="#remark9#" maxlength="80" size="40">
         <img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark9);">(DD/MM/YYYY)
			<cfelse>
             <div>
             <cfif trim(getGsetup.remark9list) eq ''>
            	<input type="text" name="remark9" value="#remark9#" size="40" maxlength="80">
            	<cfelse>
            	<select name="remark9" id="remark9">
            	<option value="">Please choose</option>
            	<cfloop list="#getGsetup.remark9list#" index="i">
            	<option value="#i#" <cfif remark9 eq i>selected</cfif>>#i#</option>
            	</cfloop>
            	</select>
            	</cfif>
             
				
                </div>
			</cfif>
            </td>
            </tr>
            
            
            <tr>
            <td width="50%"></td>
            <td width="50%">#getgsetup.rem10#
            </td>
            </tr>
            <tr>
            <td></td>
            <td>
            <cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
				<select name="remark10">
					<option value="">Please Select</option>
					<option value="-" <cfif remark10 eq "-">selected</cfif>>To</option>
					<option value="&" <cfif remark10 eq "&">selected</cfif>>And</option>
				</select>
			<cfelseif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i") and tran eq "INV">
				<input type="text" name="remark10" value="#remark10#" size="10" maxlength="10">
				<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark10);">(DD/MM/YYYY)
			<cfelseif lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i" or lcase(hcomid) eq "decor_i" or lcase(hcomid) eq "derotech_i" or lcase(hcomid) eq "pteat_i" or lcase(hcomid) eq "penth_i">
				<textarea name="remark10" id="remark10" cols='40' rows='3' onKeyDown="limitText(this.form.remark10,200);" onKeyUp="limitText(this.form.remark10,200);">#remark10#</textarea>
                <cfelseif lcase(hcomid) eq "bestform_i" or lcase(hcomid) eq "alsale_i" or lcase(hcomid) eq "gbi_i" or getmodule.auto eq "1" or lcase(hcomid) eq "litelab_i" or lcase(hcomid) eq "d72ipl_i">
				<textarea name="remark10" id="remark10" cols='40' rows='3' onKeyDown="limitText(this.form.remark10,500);" onKeyUp="limitText(this.form.remark10,500);">#remark10#</textarea>
            <cfelseif lcase(hcomid) eq "mcjim_i" or lcase(hcomid) eq "visionlaw_i" or lcase(hcomid) eq "bspl_i" or lcase(hcomid) eq "polypet_i">
        <input type="text" name="remark10" value="#remark10#" maxlength="100" size="40"></td>
        <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
                <cfoutput>
<cfinput type="text" name="remark10" id="remark10" value="#remark10#" bind="cfc:accordtran2.getremark10('#dts#',{remark5})"></cfoutput>
        <cfelseif lcase(hcomid) eq "mingsia_i" or lcase(hcomid) eq "knm_i" or lcase(hcomid) eq "letrain_i" or lcase(hcomid) eq "btgroup_i">
        <input type="text" name="remark10" value="#remark10#" maxlength="150" size="40">
        <cfelseif (lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "mfssmy_i") and tran eq "SO">
        <cfinput type="text" name="remark10" value="#remark10#" maxlength="35" size="40" required="yes" message="Kindly Fill in Patient Name">
	<cfelseif lcase(hcomid) eq "aepl_i">
				<textarea name="remark10" id="remark10" cols='100' rows='3' onKeyDown="limitText(this.form.remark10,200);" onKeyUp="limitText(this.form.remark10,500);">#remark10#</textarea>
            <cfelseif (lcase(hcomid) eq "bnbm_i" or lcase(HcomID) eq "bnbp_i") and tran eq 'QUO'>
            <select name="remark10" id="remark10" onChange="bnbpupdatedetail();">
            	<option value="" <cfif remark10 eq "">selected</cfif>>Please Choose a Remark</option>
            	<option value="" <cfif remark10 eq "1">selected</cfif>>Remark 1</option>
                <option value="2" <cfif remark10 eq "2">selected</cfif>>Remark 2</option>
                <option value="3" <cfif remark10 eq "3">selected</cfif>>Remark 3</option>
                <option value="4" <cfif remark10 eq "4">selected</cfif>>Remark 4</option>
                <option value="5" <cfif remark10 eq "5">selected</cfif>>Remark 5</option>
            	</select>
            <cfelseif lcase(hcomid) eq "asaiki_i">
        <input type="text" name="remark10" value="#remark10#" size="40" maxlength="80">
        <input type="button" name="updateshipvia" id="updateshipvia" value="Update" onClick="ajaxFunction(document.getElementById('updateshipviaajax'),'/default/transaction/tran2asaikiajax.cfm?custno='+escape(document.getElementById('custno').value));updateshipvia2();"><div id="updateshipviaajax"></div>
			<cfelseif lcase(hcomid) eq "atc2005_i">
            <input type="text" name="remark10" value="#remark10#" maxlength="200" size="40">
			<cfelse>
            	<cfif trim(getGsetup.remark10list) eq ''>
            	<input type="text" name="remark10" value="#remark10#" maxlength="35" size="40">
            	<cfelse>
            	<select name="remark10" id="remark10">
            	<option value="">Please choose</option>
            	<cfloop list="#getGsetup.remark10list#" index="i">
            	<option value="#i#" <cfif remark10 eq i>selected</cfif>>#i#</option>
            	</cfloop>
            	</select>
            	</cfif>
            
			</cfif>
            </td>
            </tr>
            
            <tr>
            <td width="50%"></td>
            <td width="50%">#getgsetup.rem11#</td>
            </tr>
            <tr>
            <td></td>
            <td>
            <cfif lcase(hcomid) eq "glenn_i" or lcase(hcomid) eq "glenndemo_i">
				<input type="text" name="remark11" value="#dateformat(remark11,"dd/mm/yyyy")#" size="10" maxlength="10">
				<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark11);">(DD/MM/YYYY)
			<cfelseif (lcase(HcomID) eq "net_i" or lcase(hcomid) eq "netm_i") and tran eq "INV">
					<input type="text" name="remark11" value="#remark11#" size="10" maxlength="10">
					<img src="../../images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(remark11);">(DD/MM/YYYY)
                   <cfelseif (lcase(hcomid) eq "accord_i" or lcase(hcomid) eq "demoinsurance_i") and (tran eq "INV" or tran eq "CS")>
				<cfinput type="text" name="remark11" id="remark11" value="#remark11#" bind="cfc:accordtran2.getremark11('#dts#',{remark5})">
              <cfelseif lcase(hcomid) eq "fdipx_i">
				<textarea name="remark11" id="remark11" cols="40" rows="3" >#remark11#</textarea>
                <cfelseif lcase(hcomid) eq "powernas_i" or lcase(hcomid) eq "acerich_i" or lcase(hcomid) eq "demoinsurance_i">
                <cfquery name="getsupplist" datasource="#dts#">
                select custno,name from #target_apvend#
                </cfquery>
                <select  name="remark11">
                <option value="">Please Choose a supplier</option>
                <cfloop query="getsupplist">
                <option value="#getsupplist.custno#"<cfif remark11 eq getsupplist.custno>selected</cfif>>#getsupplist.custno# - #getsupplist.name#</option>
                </cfloop>
                </select>
            <cfelseif lcase(hcomid) eq "mastercare_i" or lcase(HcomID) eq "gorgeous_i">
         <input type="checkbox" name="rem11check" id="rem11check" value="Yes" <cfif remark11 eq "YES"> checked</cfif> onClick="if(this.checked == true){document.getElementById('remark11').value='YES';} else {document.getElementById('remark11').value='NO';}">
         <input type="hidden" name="remark11" value="#remark11#" size="40" maxlength="35">
			<cfelse>
				<textarea name="remark11" id="remark11" cols='40' rows='3' onKeyDown="limitText(this.form.remark11,300);" onKeyUp="limitText(this.form.remark11,300);"></textarea>
			</cfif>
            </td>
            </tr>
            </table>
            <cfif getgsetup.addonremark eq 'Y'>
          	<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##remarksInfoCollapse">
						<h4 class="panel-title accordion-toggle">Extra Remark</h4>
					</div>
					<div id="remarksInfoCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<cfinclude template="tran2addon.cfm">
						</div>
					</div>
				</div>  
			</div>
            </cfif>
            <cfif getgsetup.multiagent eq 'Y'>
            <div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##agentInfoCollapse">
						<h4 class="panel-title accordion-toggle">eXTRA rEMARK</h4>
					</div>
					<div id="agentInfoCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<cfinclude template="tranmultiagent.cfm">
						</div>
					</div>
				</div>  
			</div>
            </cfif>
          
          
          
			
			<div align="center">
				<button type="submit" class="btn btn-primary" id="submit">Next</button>
				<button type="button" class="btn btn-default" onclick="window.history(-1)" >Back</button>
			</div>
		</form>		
	</div>
</cfoutput>
</body>
</html>