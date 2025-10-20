<html>
<head>
<title>Transaction Setup</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/collapse_expand_single_item.js"></script>
</head>
<cftry>
  <cfquery name="SELECTBILL" datasource="#dts#">
	SELECT * from customized_format
	</cfquery>
  <cfset selectbill1="1">
  <cfcatch type="any">
    <cfset selectbill1="0">
  </cfcatch>
</cftry>
<cfif isdefined('url.type')>
  <cfquery datasource="#dts#" name="SaveGeneralInfo">
		update gsetup set 
		<!--- <cfif isdefined ("form.delinvoice")>delinvoice = '1',<cfelse>delinvoice = '0',</cfif> --->
		<!--- <cfif isdefined ("form.invsecure")>invsecure = '1',<cfelse>invsecure = '0',</cfif> --->
		<cfif isdefined ("form.cost")>
			cost=upper('#form.cost#'),
		<cfelse>
			cost='',
		</cfif>
		<cfif isdefined ("form.gpricemin")>
			gpricemin='1',
		<cfelse>
			gpricemin='0',
		</cfif>
        <cfif isdefined ("form.recompriceup")>
			recompriceup='Y',
		<cfelse>
			recompriceup='N',
		</cfif>
        recompriceup1='#form.recompriceup1#',
		<cfif isdefined ("form.priceminctrl")>
			priceminctrl='1',
		<cfelse>
			priceminctrl='0',
		</cfif>
		<cfif isdefined ("form.printoption")>
			printoption='1',
		<cfelse>
			printoption='0',
		</cfif>
		<cfif isdefined ("form.negstk")>
			negstk = '1',
		<cfelse>
			negstk='0',
		</cfif>
        <cfif isdefined ("form.proavailqty")>
			proavailqty = '1',
		<cfelse>
			proavailqty='0',
		</cfif>
        <cfif isdefined ("form.prozero")>
			prozero = '1',
		<cfelse>
			prozero='0',
		</cfif>
		<cfif isdefined ("form.invoneset")>
			invoneset='1',
		<cfelse>
			invoneset='0',
		</cfif>
		<cfif isdefined ("form.postvalue")>
			postvalue='#form.postvalue#',
		<cfelse>
			postvalue='',
		</cfif>
		<cfif isdefined ("form.shipvia")>
			shipvia='1',
		<cfelse>
			shipvia='0',
		</cfif>
		<cfif isdefined ("form.filteritem")>
			filteritem='1',
		<cfelse>
			filteritem='0',
		</cfif>
        <cfif isdefined ("form.filteritemreport")>
			filteritemreport='1',
		<cfelse>
			filteritemreport='0',
		</cfif>
        <cfif isdefined ("form.CNbaseonprice")>
			CNbaseonprice='1',
		<cfelse>
			CNbaseonprice='0',
		</cfif>
        <cfif isdefined ("form.includemisc")>
			includemisc='1',
		<cfelse>
			includemisc='0',
		</cfif>
        <cfif isdefined ("form.reportagentfromcust")>
			reportagentfromcust='Y',
		<cfelse>
			reportagentfromcust='N',
		</cfif>
        <cfif isdefined ("form.oldcustsupp")>
			oldcustsupp='Y',
		<cfelse>
			oldcustsupp='N',
		</cfif>
        <cfif isdefined ("form.defaultNONGSTcustomer")>
			defaultNONGSTcustomer='Y',
		<cfelse>
			defaultNONGSTcustomer='N',
		</cfif>
        fifocal = "#form.fifocal#",
        <cfif isdefined ("form.filteritemAJAX")>
			filteritemAJAX='1',
		<cfelse>
			filteritemAJAX='0',
		</cfif>
		<cfif isdefined ("form.texteditor")>
			texteditor='1',
		<cfelse>
			texteditor='0',
		</cfif>
		<cfif isdefined ("form.rc_oneset")>
			rc_oneset='1',
		<cfelse>
			rc_oneset='0',
		</cfif>
		<cfif isdefined ("form.pr_oneset")>
			pr_oneset='1',
		<cfelse>
			pr_oneset='0',
		</cfif>
		<cfif isdefined ("form.do_oneset")>
			do_oneset='1',
		<cfelse>
			do_oneset='0',
		</cfif>
		<cfif isdefined ("form.cs_oneset")>
			cs_oneset='1',
		<cfelse>
			cs_oneset='0',
		</cfif>
		<cfif isdefined ("form.cn_oneset")>
			cn_oneset='1',
		<cfelse>
			cn_oneset='0',
		</cfif>
		<cfif isdefined ("form.dn_oneset")>
			dn_oneset='1',
		<cfelse>
			dn_oneset='0',
		</cfif>
		<cfif isdefined ("form.iss_oneset")>
			iss_oneset='1',
		<cfelse>
			iss_oneset='0',
		</cfif>
		<cfif isdefined ("form.po_oneset")>
			po_oneset='1',
		<cfelse>
			po_oneset='0',
		</cfif>
		<cfif isdefined ("form.so_oneset")>
			so_oneset='1',
		<cfelse>
			so_oneset='0',
		</cfif>
		<cfif isdefined ("form.quo_oneset")>
			quo_oneset='1',
		<cfelse>
			quo_oneset='0',
		</cfif>
		<cfif isdefined ("form.assm_oneset")>
			assm_oneset='1',
		<cfelse>
			assm_oneset='0',
		</cfif>
        <cfif isdefined ("form.rq_oneset")>
			rq_oneset='1',
		<cfelse>
			rq_oneset='0',
		</cfif>
		<cfif isdefined ("form.tr_oneset")>
			tr_oneset='1',
		<cfelse>
			tr_oneset='0',
		</cfif>
		<cfif isdefined ("form.oai_oneset")>
			oai_oneset='1',
		<cfelse>
			oai_oneset='0',
		</cfif>
		<cfif isdefined ("form.oar_oneset")>
			oar_oneset='1',
		<cfelse>
			oar_oneset='0',
		</cfif>
		<cfif isdefined ("form.sam_oneset")>
			sam_oneset='1',
		<cfelse>
			sam_oneset='0',
		</cfif>
		<cfif lcase(HcomID) eq "eocean_i">
			<cfif isdefined ("form.ct_oneset")>
				ct_oneset='1',
			<cfelse>
				ct_oneset='0',
			</cfif>
		</cfif>
		<cfif isdefined ("form.filterall")>
			filterall='1',
		<cfelse>
			filterall='0',
		</cfif>
        
        <cfif isdefined ("form.costingCN")>
			costingCN='Y',
		<cfelse>
			costingCN='N',
		</cfif>
        
        <cfif isdefined ("form.costingOAI")>
			costingOAI='Y',
		<cfelse>
			costingOAI='N',
		</cfif>
        
        <cfif isdefined ("form.refno2inv")>
			refno2inv='1',
		<cfelse>
			refno2inv='0',
		</cfif>
        <cfif isdefined ("form.refno2SO")>
			refno2SO='1',
		<cfelse>
			refno2SO='0',
		</cfif>
        <cfif isdefined ("form.refno2PR")>
			refno2PR='1',
		<cfelse>
			refno2PR='0',
		</cfif>
        <cfif isdefined ("form.refno2RC")>
			refno2RC='1',
		<cfelse>
			refno2RC='0',
		</cfif>
        <cfif isdefined ("form.refno2DO")>
			refno2DO='1',
		<cfelse>
			refno2DO='0',
		</cfif>
        <cfif isdefined ("form.refno2CS")>
			refno2CS='1',
		<cfelse>
			refno2CS='0',
		</cfif>
        <cfif isdefined ("form.refno2CN")>
			refno2CN='1',
		<cfelse>
			refno2CN='0',
		</cfif>
        <cfif isdefined ("form.refno2DN")>
			refno2DN='1',
		<cfelse>
			refno2DN='0',
		</cfif>
        <cfif isdefined ("form.refno2PO")>
			refno2PO='1',
		<cfelse>
			refno2PO='0',
		</cfif>
        <cfif isdefined ("form.refno2QUO")>
			refno2QUO='1',
		<cfelse>
			refno2QUO='0',
		</cfif>
		<cfif isdefined ("form.multilocation")>
			multilocation='#form.multilocation#',
		<cfelse>
			multilocation='',
		</cfif>	
		<cfif isdefined ("form.suppcustdropdown")>
			suppcustdropdown='#form.suppcustdropdown#',
		<cfelse>
			suppcustdropdown='',
		</cfif>
        <cfif isdefined ("form.wpitemtax")>
			wpitemtax='#form.wpitemtax#',
		<cfelse>
			wpitemtax='',
		</cfif>	
        wpitemtax1=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.wpitemtax1#">,	
        <cfif isdefined ("form.ngstcustdisabletax")>
			ngstcustdisabletax='#form.ngstcustdisabletax#',
		<cfelse>
			ngstcustdisabletax='',
		</cfif>
        <cfif isdefined ("form.ngstcustautotax")>
			ngstcustautotax='#form.ngstcustautotax#',
		<cfelse>
			ngstcustautotax='',
		</cfif>	
		<cfif isdefined ("form.editamount")>
			editamount='#form.editamount#',
		<cfelse>
			editamount='',
		</cfif>	
		gst='#val(form.gst)#',
        df_qty='#val(form.df_qty)#',
        disclimit='#val(form.disclimit)#',
        dfcustcode='#form.dfcustcode#',
        dfsuppcode='#form.dfsuppcode#',
        dfpos='#form.dfpos#',
        df_mem_price='#form.df_mem_price#',
        itempriceprior='#form.itempriceprior#',
		<cfif isdefined ("form.df_salestax")>	
			df_salestax='#form.df_salestax#',
		<cfelse>
			df_salestax='',
		</cfif>
        <cfif isdefined ("form.df_salestaxzero")>	
			df_salestaxzero='#form.df_salestaxzero#',
		<cfelse>
			df_salestaxzero='',
		</cfif>
		<cfif isdefined ("form.df_purchasetax")>	
			df_purchasetax='#form.df_purchasetax#'
		<cfelse>
			df_purchasetax=''
		</cfif>
        <cfif isdefined ("form.df_purchasetaxzero")>	
			,df_purchasetaxzero='#form.df_purchasetaxzero#'
		<cfelse>
			,df_purchasetaxzero=''
		</cfif>
		<cfif (lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i")>
			,driver='#form.driver#'
		</cfif>
        <cfif isdefined("form.defaultEndUser")>
        	,defaultenduser = '1'
        <cfelse>
         	,defaultenduser = ''
		</cfif>
        <cfif isdefined("form.quoChooseItem")>
        	,quoChooseItem = '1'
        <cfelse>
         	,quoChooseItem = ''
		</cfif>
        <cfif isdefined("form.chooselocation")>
        	,chooselocation = 'Y'
        <cfelse>
         	,chooselocation = ''
		</cfif>
         <cfif isdefined("form.locarap")>
        	,locarap = 'Y'
        <cfelse>
         	,locarap = ''
		</cfif>
        <cfif isdefined("form.auom")>
        	,auom = '1'
        <cfelse>
         	,auom = ''
		</cfif>
        <cfif isdefined("form.PACAA")>
        	,PACAA = 'Y'
        <cfelse>
         	,PACAA = 'N'
		</cfif>
        <cfif isdefined("form.PPTS")>
        	,PPTS = 'Y'
        <cfelse>
         	,PPTS = 'N'
		</cfif>
        <cfif isdefined("form.APCWP")>
        	,APCWP = 'Y'
        <cfelse>
         	,APCWP = 'N'
		</cfif>
        <cfif isdefined("form.PPWKOF")>
        	,PPWKOF = 'Y'
        <cfelse>
         	,PPWKOF = 'N'
		</cfif>
        <cfif isdefined("form.PNOPROJECT")>
        	,PNOPROJECT = 'Y'
        <cfelse>
         	,PNOPROJECT = 'N'
		</cfif>
        <cfif isdefined("form.ECAOTA")>
        	,ECAOTA = 'Y'
        <cfelse>
         	,ECAOTA = 'N'
		</cfif>
        <cfif isdefined("form.AECE")>
        	,AECE = 'Y'
        <cfelse>
         	,AECE = 'N'
		</cfif>
        <cfif isdefined("form.quobatch")>
        	,quobatch = 'Y'
        <cfelse>
         	,quobatch = 'N'
		</cfif>
        <cfif isdefined("form.projectcompany")>
        	,projectcompany = 'Y'
        <cfelse>
         	,projectcompany = 'N'
		</cfif>
        <cfif isdefined("form.ECAMTOTA")>
        	,ECAMTOTA = 'Y'
        <cfelse>
         	,ECAMTOTA = 'N'
		</cfif>
        <cfif isdefined("form.PCBLTC")>
        	,PCBLTC = 'Y'
        <cfelse>
         	,PCBLTC = 'N'
		</cfif>
        <cfif isdefined("form.expressdisc")>
        	,expressdisc = '#form.expressdisc#'
		</cfif>
        <cfif isdefined("form.ASACTP")>
        	,ASACTP = 'Y'
        <cfelse>
         	,ASACTP = 'N'
		</cfif>
        <cfif isdefined("form.ASDA")>
        	,ASDA = 'Y'
        <cfelse>
         	,ASDA = 'N'
		</cfif>
        <cfif isdefined("form.projectbybill")>
        	,projectbybill = '1'
        <cfelse>
         	,projectbybill = ''
		</cfif>	
        <cfif isdefined("form.jobbyitem")>
        	,jobbyitem = 'Y'
        <cfelse>
         	,jobbyitem = 'N'
		</cfif>	
        <cfif isdefined("form.keepDeletedBills")>
        	,keepDeletedBills = '1'
        <cfelse>
         	,keepDeletedBills = ''
		</cfif>
        <cfif isdefined("form.RPED")>
        	,EDControl = 'Y'
        <cfelse>
         	,EDControl = 'N'
		</cfif>
        <cfif isdefined("form.appDisSupCus")>
        	,appDisSupCus = 'Y'
        <cfelse>
         	,appDisSupCus = 'N'
		</cfif>
        <cfif isdefined("form.appDisSupCusitem")>
        	,appDisSupCusitem = 'Y'
        <cfelse>
         	,appDisSupCusitem = 'N'
		</cfif>
        <cfif isdefined("form.voucher")>
        	,voucher = 'Y'
        <cfelse>
         	,voucher = 'N'
		</cfif>
        <cfif isdefined("form.asvoucher")>
        	,asvoucher = 'Y'
        <cfelse>
         	,asvoucher = 'N'
		</cfif>
        <cfif isdefined("form.voucherbal")>
        	,voucherbal = 'Y'
        <cfelse>
         	,voucherbal = 'N'
		</cfif>
        <cfif isdefined("form.voucherb4disc")>
        	,voucherb4disc = 'Y'
        <cfelse>
         	,voucherb4disc = 'N'
		</cfif>
        <cfif isdefined("form.voucherasdisc")>
        	,voucherasdisc = 'Y'
        <cfelse>
         	,voucherasdisc = 'N'
		</cfif>
        ,ddlcust ='#form.ddlcust#' 
        ,ddlsupp ='#form.ddlsupp#' 
        ,ddltran ='#form.ddltran#' 
        ,ddlbilltype ='#form.ddlbilltype#' 
        ,df_cs_cust ='#form.df_cs_cust#' 
        ,ddlitem ='#form.ddlitem#' 
        ,ddllocation ='#form.ddllocation#' 
        ,ddlagent ='#form.ddlagent#' 
        ,ddlterm ='#form.ddlterm#' 
        ,df_trprice ='#form.df_trprice#' 
          <cfif isdefined("form.countryddl")>
        	,countryddl = 'Y'
        <cfelse>
         	,countryddl = 'N'
		</cfif>
        <cfif isdefined("form.fcurrency")>
        	,fcurrency = 'Y'
        <cfelse>
         	,fcurrency = 'N'
		</cfif>
        <cfif isdefined("form.addonremark")>
        	,addonremark = 'Y'
        <cfelse>
         	,addonremark = 'N'
		</cfif>
        <cfif isdefined("form.collectaddress")>
        	,collectaddress = 'Y'
        <cfelse>
         	,collectaddress = 'N'
		</cfif>
        <cfif isdefined("form.multiagent")>
        	,multiagent = 'Y'
        <cfelse>
         	,multiagent = 'N'
		</cfif>
        <cfif isdefined("form.prodisprice")>
        	,prodisprice = 'Y'
        <cfelse>
         	,prodisprice = 'N'
		</cfif>
        <cfif isdefined("form.taxincluded")>
        	,taxincluded = 'Y'
        <cfelse>
         	,taxincluded = 'N'
		</cfif>
        <cfif isdefined("form.agentuserid")>
        	,agentuserid = 'Y'
        <cfelse>
         	,agentuserid = 'N'
		</cfif>
        <cfif isdefined("form.agentlistuserid")>
        	,agentlistuserid = 'Y'
        <cfelse>
         	,agentlistuserid = 'N'
		</cfif>
        <cfif isdefined("form.enableedit")>
        	,enableedit = 'Y'
        <cfelse>
         	,enableedit = 'N'
		</cfif>
        <cfif isdefined("form.commenttext")>
        	,commenttext = 'Y'
        <cfelse>
         	,commenttext = 'N'
		</cfif>
        ,commentlimit = '#form.commentlimit#'
        ,termlimit = '#form.termlimit#'
        ,desplimit = '#form.desplimit#'
        ,disp1limit = '#val(form.disp1limit)#'
        <cfif isdefined("form.custnamelength")>
        	,custnamelength = 'Y'
        <cfelse>
         	,custnamelength = 'N'
		</cfif>
        <cfif isdefined("form.capall")>
        	,capall = 'Y'
        <cfelse>
         	,capall = 'N'
		</cfif>
        
        <cfif isdefined("form.autolocbf")>
        	,autolocbf = 'Y'
        <cfelse>
         	,autolocbf = 'N'
		</cfif>
        <cfif isdefined("form.grpinitem")>
        	,grpinitem = 'Y'
        <cfelse>
         	,grpinitem = 'N'
		</cfif>
        
        <cfif isdefined("form.custissue")>
        	,custissue = 'Y'
        <cfelse>
         	,custissue = 'N'
		</cfif>
         <cfif isdefined("form.deductso")>
        	,deductso = 'Y'
        <cfelse>
         	,deductso = 'N'
		</cfif>
        ,costformula1='#form.costformula1#'
        ,costformula2='#form.costformula2#'
        ,costformula3='#form.costformula3#'
         <cfif isdefined("form.advancebom")>
        	,advancebom = 'Y'
        <cfelse>
         	,advancebom = 'N'
		</cfif>
         <cfif isdefined("form.displaycostcode")>
        	,displaycostcode = 'Y'
        <cfelse>
         	,displaycostcode = 'N'
		</cfif>
         <cfif isdefined("form.prefixbycustquo")>
        	,prefixbycustquo = 'Y'
        <cfelse>
         	,prefixbycustquo = 'N'
		</cfif>
         <cfif isdefined("form.prefixbycustso")>
        	,prefixbycustso = 'Y'
        <cfelse>
         	,prefixbycustso = 'N'
		</cfif>
         <cfif isdefined("form.prefixbycustinv")>
        	,prefixbycustinv = 'Y'
        <cfelse>
         	,prefixbycustinv = 'N'
		</cfif>
        <cfif isdefined("form.updatetopo")>
        	,updatetopo = 'Y'
        <cfelse>
         	,updatetopo = 'N'
		</cfif>
        <cfif isdefined("form.autobom")>
        	,autobom = 'Y'
        <cfelse>
         	,autobom = 'N'
		</cfif>
        <cfif isdefined("form.singlelocation")>
        	,singlelocation = 'Y'
        <cfelse>
         	,singlelocation = 'N'
		</cfif>
        <cfif isdefined("form.allowedityearend")>
        	,allowedityearend = 'Y'
        <cfelse>
         	,allowedityearend = 'N'
		</cfif>
        <cfif isdefined("form.printapprove")>
        	,printapprove = 'Y'
        <cfelse>
         	,printapprove = 'N'
		</cfif>
        <cfif isdefined("form.printapprovelevel1")>
        	,printapprovelevel1 = '#form.printapprovelevel1#'
        </cfif>
        <cfif isdefined("form.printapprovelevel2")>
        	,printapprovelevel2 = '#form.printapprovelevel2#'
        </cfif>
        
        <cfif isdefined("form.printapproveamt")>
        	,printapproveamt = '#form.printapproveamt#'
            </cfif>
         <cfif isdefined("form.simpleinvtype")>
        	,simpleinvtype = '#form.simpleinvtype#'
            </cfif>
        <cfif isdefined("form.autonextdate")>
        	,autonextdate = '#form.autonextdate#'
           </cfif>
        <cfif isdefined("form.attnddl")>
        	,attnddl = 'Y'
        <cfelse>
         	,attnddl = 'N'
		</cfif>
        <cfif isdefined("form.agentbycust")>
        	,agentbycust = 'Y'
        <cfelse>
         	,agentbycust = 'N'
		</cfif>
        <cfif isdefined("form.alloweditposted")>
        	,alloweditposted = 'Y'
        <cfelse>
         	,alloweditposted = 'N'
		</cfif>
        <cfif isdefined("form.postcsdebtor")>
        	,postcsdebtor = 'Y'
        <cfelse>
         	,postcsdebtor = 'N'
		</cfif>
        <cfif isdefined("form.postdepdebtor")>
        	,postdepdebtor = 'Y'
        <cfelse>
         	,postdepdebtor = 'N'
		</cfif>
        <cfif isdefined("form.postingRCRefno")>
        	,postingRCRefno = 'Y'
        <cfelse>
         	,postingRCRefno = 'N'
		</cfif>
        <cfif isdefined("form.periodficposting")>
        	,periodficposting = 'Y'
        <cfelse>
         	,periodficposting = 'N'
		</cfif>
        <cfif isdefined("form.serialnorun")>
        	,serialnorun = 'Y'
        <cfelse>
         	,serialnorun = 'N'
		</cfif>
        <cfif isdefined("form.expressmultiitem")>
        	,expressmultiitem = 'Y'
        <cfelse>
         	,expressmultiitem = 'N'
		</cfif>
         <cfif isdefined("form.transactiondate")>
        	,transactiondate = 'Y'
        <cfelse>
         	,transactiondate = 'N'
		</cfif>
        <cfif isdefined("form.tranuserid")>
        	,tranuserid = 'Y'
        <cfelse>
         	,tranuserid = 'N'
		</cfif>
        <cfif isdefined("form.taxfollowitemprofile")>
        	,taxfollowitemprofile = 'Y'
        <cfelse>
         	,taxfollowitemprofile = 'N'
		</cfif>
         <cfif isdefined("form.po_to_rc_currrate")>
        	,po_to_rc_currrate = 'Y'
        <cfelse>
         	,po_to_rc_currrate = 'N'
		</cfif>
        <cfif isdefined("form.enabledetectrem1")>
        	,enabledetectrem1 = 'Y'
        <cfelse>
         	,enabledetectrem1 = 'N'
		</cfif>
        <cfif isdefined("form.remainloc")>
        	,remainloc = 'Y'
        <cfelse>
         	,remainloc = 'N'
		</cfif>
        <cfif isdefined("form.showservicepart")>
        	,showservicepart = 'Y'
        <cfelse>
         	,showservicepart = 'N'
		</cfif>
        <cfif isdefined("form.poapproval")>
        	,poapproval = 'Y'
        <cfelse>
         	,poapproval = 'N'
		</cfif>
        <cfif isdefined("form.histpriceinv")>
        	,histpriceinv = 'Y'
        <cfelse>
         	,histpriceinv = 'N'
		</cfif>
        <cfif isdefined("form.soautocreaproj")>
        	,soautocreaproj = 'Y'
        <cfelse>
         	,soautocreaproj = 'N'
		</cfif>
        <cfif isdefined("form.followlocation")>
        	,followlocation = 'Y'
        <cfelse>
         	,followlocation = 'N'
		</cfif>
        <cfif isdefined("form.crcdtype")>
        	,crcdtype = 'Y'
        <cfelse>
         	,crcdtype = 'N'
		</cfif>
        <cfif isdefined("form.termscondition")>
        	,termscondition = 'Y'
        <cfelse>
         	,termscondition = 'N'
		</cfif>
        
        <cfif isdefined("form.locationwithqty")>
        	,locationwithqty = 'Y'
        <cfelse>
         	,locationwithqty = 'N'
		</cfif>
        <cfif isdefined("form.autooutstandingreport")>
        	,autooutstandingreport = 'Y'
        <cfelse>
         	,autooutstandingreport = 'N'
		</cfif>
        <cfif isdefined("form.lightloc")>
        	,lightloc = 'Y'
        <cfelse>
         	,lightloc = 'N'
		</cfif>
        <cfif isdefined("form.disablefoc")>
        	,disablefoc = 'Y'
        <cfelse>
         	,disablefoc = 'N'
		</cfif>
        <cfif isdefined("form.footerexchange")>
        	,footerexchange = 'Y'
        <cfelse>
         	,footerexchange = 'N'
		</cfif>
        <cfif isdefined("form.quotationlead")>
        	,quotationlead = 'Y'
        <cfelse>
         	,quotationlead = 'N'
		</cfif>
        <cfif isdefined("form.quotationchangeitem")>
        	,quotationchangeitem = 'Y'
        <cfelse>
         	,quotationchangeitem = 'N'
		</cfif>
        ,dummycust = "#form.dummycust#"
        <cfif isdefined("form.mitemdiscountbyitem")>
        	,mitemdiscountbyitem = 'Y'
        <cfelse>
         	,mitemdiscountbyitem = 'N'
		</cfif>
        ,itemdiscmethod = "#form.itemdiscmethod#"
        <cfif isdefined("form.disablevoid")>
        	,disablevoid = 'Y'
        <cfelse>
         	,disablevoid = 'N'
		</cfif>
        
		<cfif isdefined("form.homepagemenu")>
        ,homepagemenu = "#form.homepagemenu#"
        <cfelse>
        ,homepagemenu = ''
        </cfif>
        ,mailserver = '#form.mailserver#'
        ,mailport = '#form.mailport#'
        ,mailuser = '#form.mailuser#'
        ,mailpassword = '#form.mailpassword#'
        ,dfemail = '#form.dfemail#'
			<cfif isdefined("form.generateQuoRevision")>
	        	,generateQuoRevision = '1'
	        <cfelse>
	         	,generateQuoRevision = ''
			</cfif>	
            <cfif isdefined("form.editbillpassword")>
	        	,editbillpassword = '1'
	        <cfelse>
	         	,editbillpassword = ''
			</cfif>	
			,revStyle=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.revStyle#">
			,generateQuoRevision1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.generateQuoRevision1#">
           

        ,custSuppNo = "#form.custSuppNo#"
        ,SuppNo = "#form.SuppNo#"
        ,iaft = "#form.iaft#"
		,custsupp_limit_display = "#val(form.custsupp_limit_display)#"
        ,EAPT = "#form.EAPT#"
        ,PRF = "#form.PRF#"
        <cfif form.refnoNACC gt 50>
        ,refnoNACC = "50"
		<cfelse>
        ,refnoNACC = "#form.refnoNACC#"
		</cfif>
        
        <cfif form.refnoNACC gt 50>
         ,refnoACC = "50"
        <cfelse>
        ,refnoACC = "#form.refnoACC#"
        </cfif>
        
		where companyid='IMS';
	</cfquery>
    
    <cfif hlinkams eq "Y">
    	<cfset target_gsetup = replacenocase(dts,"_i","_a","all")&".gsetup">
    	<cfquery name="updategsetupAMS" datasource="#dts#">
        	UPDATE #target_gsetup# SET
            custno="#form.custsuppno#",suppno="#form.suppno#"
        </cfquery>
    </cfif>
    
  	<cfquery name="updategsetup2" datasource="#dts#">
    UPDATE gsetup2 SET
    DECL_DISCOUNT = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.totaldecpoint#">,
    DECL_UPRICE = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.pricedecpoint#">,
    DECL_TOTALAMT = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.totalamtdecpoint#">,
    <cfif isdefined('form.RCPCOST')>
    UPDATE_UNIT_COST = "T"
    <cfelse>
    UPDATE_UNIT_COST = "F"
	</cfif>
    </cfquery>
    
    <cfquery name="updategsetuppos" datasource="#dts#">
    update gsetuppos set memberpointamt="val(form.memberpointamt)"
    </cfquery>
    
    
</cfif>
<cfquery datasource="#dts#" name="getGeneralInfo">
	select * 
	from gsetup;
</cfquery>
<cfquery datasource="#dts#" name="getGeneralInfo2">
	select * 
	from gsetup2;
</cfquery>

<cfquery datasource="#dts#" name="getGeneralInfoPOS">
	select * 
	from gsetuppos;
</cfquery>

<!--- <cfset delinvoice = '#getGeneralInfo.delinvoice#'>
<cfset invsecure = '#getGeneralInfo.invsecure#'> --->
<cfset cost = getGeneralInfo.cost>
<cfset gpricemin = getGeneralInfo.gpricemin>
<cfset recompriceup = getGeneralInfo.recompriceup>
<cfset recompriceup1 = getGeneralInfo.recompriceup1>
<cfset priceminctrl = getGeneralInfo.priceminctrl>
<cfset priceminpass = getGeneralInfo.priceminpass>
<cfset printoption = getGeneralInfo.printoption>
<cfset negstk = getGeneralInfo.negstk>
<cfset proavailqty = getGeneralInfo.proavailqty>
<cfset prozero = getGeneralInfo.prozero>
<cfset invoneset = getGeneralInfo.invoneset>
<cfset postvalue = getGeneralInfo.postvalue>
<cfset shipvia = getGeneralInfo.shipvia>
<cfset gst = getGeneralInfo.gst>
<cfset df_qty = getGeneralInfo.df_qty>
<cfset disclimit = getGeneralInfo.disclimit>
<cfset dfcustcode = getGeneralInfo.dfcustcode>
<cfset dfsuppcode = getGeneralInfo.dfsuppcode>
<cfset dfpos = getGeneralInfo.dfpos>
<cfset df_mem_price = getGeneralInfo.df_mem_price>
<cfset filteritem = getGeneralInfo.filteritem>
<cfset filteritemreport = getGeneralInfo.filteritemreport>
<cfset CNbaseonprice = getGeneralInfo.CNbaseonprice>
<cfset includemisc = getGeneralInfo.includemisc>
<cfset reportagentfromcust = getGeneralInfo.reportagentfromcust>
<cfset oldcustsupp = getGeneralInfo.oldcustsupp>
<cfset defaultNONGSTcustomer = getGeneralInfo.defaultNONGSTcustomer>
<cfset fifocal = getGeneralInfo.fifocal>
<cfset filteritemAJAX = getGeneralInfo.filteritemAJAX>
<cfset texteditor = getGeneralInfo.texteditor>
<!--- ADD ON 19-06-2008 --->
<cfset rc_oneset = getGeneralInfo.rc_oneset>
<cfset pr_oneset = getGeneralInfo.pr_oneset>
<cfset do_oneset = getGeneralInfo.do_oneset>
<cfset cs_oneset = getGeneralInfo.cs_oneset>
<cfset cn_oneset = getGeneralInfo.cn_oneset>
<cfset dn_oneset = getGeneralInfo.dn_oneset>
<cfset rq_oneset = getGeneralInfo.rq_oneset>
<cfset iss_oneset = getGeneralInfo.iss_oneset>
<cfset po_oneset = getGeneralInfo.po_oneset>
<cfset so_oneset = getGeneralInfo.so_oneset>
<cfset quo_oneset = getGeneralInfo.quo_oneset>
<cfset assm_oneset = getGeneralInfo.assm_oneset>
<cfset tr_oneset = getGeneralInfo.tr_oneset>
<cfset oai_oneset = getGeneralInfo.oai_oneset>
<cfset oar_oneset = getGeneralInfo.oar_oneset>
<cfset sam_oneset = getGeneralInfo.sam_oneset>
<!--- ADD ON 11-09-2008 --->
<cfset filterall = getGeneralInfo.filterall>
<cfset costingCN = getGeneralInfo.costingCN>
<cfset costingOAI = getGeneralInfo.costingOAI>
<!--- ADD ON 18-11-2008 --->
<cfset xmultilocation = getGeneralInfo.multilocation>
<!--- ADD ON 16-06-2009 --->
<cfset suppcustdropdown=getGeneralInfo.suppcustdropdown>
<!--- ADD ON 30-07-2009 --->
<cfset wpitemtax=getGeneralInfo.wpitemtax>
<cfset wpitemtax1=getGeneralInfo.wpitemtax1>
<cfset ngstcustdisabletax=getGeneralInfo.ngstcustdisabletax>
<cfset ngstcustautotax=getGeneralInfo.ngstcustautotax>
<!--- ADD ON 07-10-2009 --->
<cfset editamount=getGeneralInfo.editamount>
<cfif (lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i")>
  <cfset driver=getGeneralInfo.driver>
</cfif>
<!--- ADD ON 26-10-2009 --->
<cfset df_salestax=getGeneralInfo.df_salestax>
<cfset df_salestaxzero=getGeneralInfo.df_salestaxzero>
<cfset df_purchasetax=getGeneralInfo.df_purchasetax>
<cfset df_purchasetaxzero=getGeneralInfo.df_purchasetaxzero>

<!--- ADD ON 30-10-2009 --->
<cfset defaultEndUser = getGeneralInfo.defaultenduser>

<!--- ADD ON 03-11-2009 --->
<cfset quoChooseItem = getGeneralInfo.quoChooseItem>
<cfset chooselocation = getGeneralInfo.chooselocation>
<cfset locarap = getGeneralInfo.locarap>
<!---ADD ON 04-11-2009 --->
<cfset custSuppNo = getGeneralInfo.custSuppNo >
<cfset SuppNo = getGeneralInfo.SuppNo >
<!---ADD ON 24-11-2009 --->
<cfset auom = getGeneralInfo.auom>
<!---ADD ON 09-12-2009 --->
<cfset projectbybill = getGeneralInfo.projectbybill>
<cfset jobbyitem = getGeneralInfo.jobbyitem>
<!---ADD ON 22-12-2009 --->
<cfset keepDeletedBills = getGeneralInfo.keepDeletedBills>
<cfset RPED = getGeneralInfo.EDControl>
<cfset appDisSupCus = getGeneralInfo.appDisSupCus>
<cfset appDisSupCusitem = getGeneralInfo.appDisSupCusitem>
<cfset voucher = getGeneralInfo.voucher>
<cfset asvoucher = getGeneralInfo.asvoucher>
<cfset voucherbal = getGeneralInfo.voucherbal>
<cfset voucherb4disc = getGeneralInfo.voucherb4disc>
<cfset voucherasdisc = getGeneralInfo.voucherasdisc>
<cfset countryddl = getGeneralInfo.countryddl>
<cfset fcurrency = getGeneralInfo.fcurrency>
<cfset addonremark = getGeneralInfo.addonremark>
<cfset collectaddress = getGeneralInfo.collectaddress>
<cfset multiagent = getGeneralInfo.multiagent>
<cfset prodisprice = getGeneralInfo.prodisprice>
<cfset taxincluded = getGeneralInfo.taxincluded>
<cfset agentuserid = getGeneralInfo.agentuserid>
<cfset agentlistuserid = getGeneralInfo.agentlistuserid>
<cfset enableedit = getGeneralInfo.enableedit>
<cfset commenttext = getGeneralInfo.commenttext>
<cfset commentlimit = getGeneralInfo.commentlimit>
<cfset termlimit = getGeneralInfo.termlimit>
<cfset desplimit = getGeneralInfo.desplimit>
<cfset disp1limit = getGeneralInfo.disp1limit>
<cfset custnamelength = getGeneralInfo.custnamelength>
<cfset capall = getGeneralInfo.capall>
<cfset autolocbf = getGeneralInfo.autolocbf>
<cfset grpinitem = getGeneralInfo.grpinitem>
<cfset custissue = getGeneralInfo.custissue>
<cfset deductso = getGeneralInfo.deductso>
<cfset advancebom = getGeneralInfo.advancebom>
<cfset df_trprice = getGeneralInfo.df_trprice>
<cfset displaycostcode = getGeneralInfo.displaycostcode>
<cfset prefixbycustquo = getGeneralInfo.prefixbycustquo>
<cfset prefixbycustso = getGeneralInfo.prefixbycustso>
<cfset prefixbycustinv = getGeneralInfo.prefixbycustinv>
<cfset updatetopo = getGeneralInfo.updatetopo>
<cfset autobom = getGeneralInfo.autobom>
<cfset singlelocation = getGeneralInfo.singlelocation>
<cfset allowedityearend = getGeneralInfo.allowedityearend>
<cfset printapprove = getGeneralInfo.printapprove>
<cfset printapprovelevel1 =getGeneralInfo.printapprovelevel1>
<cfset printapprovelevel2 =getGeneralInfo.printapprovelevel2>

<cfset printapproveamt = getGeneralInfo.printapproveamt>
<cfset simpleinvtype = getGeneralInfo.simpleinvtype>
<cfset autonextdate = getGeneralInfo.autonextdate>
<cfset attnddl = getGeneralInfo.attnddl>
<cfset agentbycust = getGeneralInfo.agentbycust>
<cfset alloweditposted = getGeneralInfo.alloweditposted>
<cfset postcsdebtor = getGeneralInfo.postcsdebtor>
<cfset postdepdebtor = getGeneralInfo.postdepdebtor>
<cfset postingRCRefno = getGeneralInfo.postingRCRefno>
<cfset periodficposting = getGeneralInfo.periodficposting>
<cfset serialnorun = getGeneralInfo.serialnorun>
<cfset expressmultiitem = getGeneralInfo.expressmultiitem>
<cfset transactiondate = getGeneralInfo.transactiondate>
<cfset tranuserid = getGeneralInfo.tranuserid>
<cfset taxfollowitemprofile = getGeneralInfo.taxfollowitemprofile>
<cfset po_to_rc_currrate = getGeneralInfo.po_to_rc_currrate>
<cfset enabledetectrem1 = getGeneralInfo.enabledetectrem1>
<cfset remainloc = getGeneralInfo.remainloc>
<cfset showservicepart = getGeneralInfo.showservicepart>
<cfset poapproval = getGeneralInfo.poapproval>
<cfset histpriceinv = getGeneralInfo.histpriceinv>
<cfset soautocreaproj = getGeneralInfo.soautocreaproj>
<cfset followlocation = getGeneralInfo.followlocation>
<cfset crcdtype = getGeneralInfo.crcdtype>
<cfset termscondition = getGeneralInfo.termscondition>
<cfset locationwithqty = getGeneralInfo.locationwithqty>
<cfset autooutstandingreport = getGeneralInfo.autooutstandingreport>
<cfset lightloc = getGeneralInfo.lightloc>
<cfset disablefoc = getGeneralInfo.disablefoc>
<cfset footerexchange = getGeneralInfo.footerexchange>
<cfset dummycust = getGeneralInfo.dummycust>
<cfset quotationlead = getGeneralInfo.quotationlead>
<cfset quotationchangeitem = getGeneralInfo.quotationchangeitem>
<cfset mitemdiscountbyitem = getGeneralInfo.mitemdiscountbyitem>
<cfset itemdiscmethod = getGeneralInfo.itemdiscmethod>
<cfset disablevoid = getGeneralInfo.disablevoid>
<cfset costformula1 = getGeneralInfo.costformula1>
<cfset costformula2 = getGeneralInfo.costformula2>
<cfset costformula3 = getGeneralInfo.costformula3>
<!---ADD ON 7-1-2010 --->
<cfset iaft = getGeneralInfo.iaft>
<cfset EAPT = getGeneralInfo.EAPT>
<cfset PRF = getGeneralInfo.PRF>
<cfset PACAA = getGeneralInfo.PACAA>
<cfset PPTS = getGeneralInfo.PPTS>
<cfset APCWP = getGeneralInfo.APCWP>
<cfset PPWKOF = getGeneralInfo.PPWKOF>
<cfset PNOPROJECT = getGeneralInfo.PNOPROJECT>
<cfset AECE = getGeneralInfo.AECE>
<cfset QUOBATCH = getGeneralInfo.QUOBATCH>
<cfset projectcompany = getGeneralInfo.projectcompany>
<cfset ECAOTA = getGeneralInfo.ECAOTA>
<cfset ECAMTOTA = getGeneralInfo.ECAMTOTA>
<cfset PCBLTC = getGeneralInfo.PCBLTC>
<cfset expressdisc = getGeneralInfo.expressdisc>
<cfset ASACTP = getGeneralInfo.ASACTP>
<cfset ASDA = getGeneralInfo.ASDA>
<cfset itempriceprior = getGeneralInfo.itempriceprior>
<cfset RCPCOST = getGeneralInfo2.UPDATE_UNIT_COST>
<cfset pricedecpoint = val(getGeneralInfo2.DECL_UPRICE)>
<cfset totaldecpoint = val(getGeneralInfo2.DECL_DISCOUNT)>
<cfset totalamtdecpoint = val(getGeneralInfo2.DECL_TOTALAMT)>
<cfset homepagemenu= getGeneralInfo.homepagemenu>
<cfset mailserver= getGeneralInfo.mailserver>
<cfset mailport= getGeneralInfo.mailport>
<cfset mailuser= getGeneralInfo.mailuser>
<cfset mailpassword= getGeneralInfo.mailpassword>
<cfset dfemail= getGeneralInfo.dfemail>
<cfset generateQuoRevision=getGeneralInfo.generateQuoRevision>
<cfset editbillpassword=getGeneralInfo.editbillpassword>
<cfset revStyle=getGeneralInfo.revStyle>
<cfset generateQuoRevision1=getGeneralInfo.generateQuoRevision1>
<cfset editbillpassword1=getGeneralInfo.editbillpassword1>

<!---ADD ON 08-02-2010 --->
<cfif isdefined("getGeneralInfo.ct_oneset")>
  <cfset ct_oneset=getGeneralInfo.ct_oneset>
</cfif>
<!---ADD ON 01-03-2010 --->
<cfset custsupp_limit_display=getGeneralInfo.custsupp_limit_display>

<!---ADD ON 10-06-2010 --->
<cfset refnoNACC = getGeneralInfo.refnoNACC>
<cfset refnoACC = getGeneralInfo.refnoACC>

<!---ADD ON 22-06-2010 --->
<cfset refno2INV = getGeneralInfo.refno2INV>
<cfset refno2SO = getGeneralInfo.refno2SO>
<cfset refno2PR = getGeneralInfo.refno2PR>
<cfset refno2RC = getGeneralInfo.refno2RC>
<cfset refno2DO = getGeneralInfo.refno2DO>
<cfset refno2CS = getGeneralInfo.refno2CS>
<cfset refno2CN = getGeneralInfo.refno2CN>
<cfset refno2DN = getGeneralInfo.refno2DN>
<cfset refno2PO = getGeneralInfo.refno2PO>
<cfset refno2QUO = getGeneralInfo.refno2QUO>

<cfset memberpointamt = getGeneralInfoPOS.memberpointamt>

<body>
<h4>
  <cfif getpin2.h5110 eq "T">
    <a href="comprofile.cfm">Company Profile</a>
  </cfif>
  <cfif getpin2.h5120 eq "T">
    || <a href="lastusedno.cfm">Last Used No</a>
  </cfif>
  <cfif getpin2.h5130 eq "T">
    || Transaction Setup
  </cfif>
  <cfif getpin2.h5140 eq "T">
    || <a href="Accountno.cfm">AMS Accounting Default Setup</a>
  </cfif>
  <cfif getpin2.h5150 eq "T">
    || <a href="userdefine.cfm">User Defined</a>
  </cfif>
  <cfif getpin2.h5160 eq "T">
    ||<a href="dealer_menu/dealer_menu.cfm">Dealer Menu</a>
  </cfif>
  <cfif getpin2.h5170 eq "T">
    ||<a href="transaction_menu/transaction_menu.cfm">Transaction Menu</a>
  </cfif>
  <cfif getpin2.h5180 eq "T">
    ||<a href="userdefineformula.cfm">User Define - Formula</a>
  </cfif>
  <cfif husergrpid eq "super">
    ||<a href="modulecontrol.cfm">Module Control</a>
  </cfif>
  <cfif getpin2.h5130 eq "T">
    ||<a href="displaysetup.cfm">Listing Setup</a>
  </cfif>
  <cfif getpin2.h5130 eq "T">
    ||<a href="displaysetup2.cfm">Display Detail</a>
  </cfif>
</h4>
<h1>General Setup - Transaction Setup</h1>
<cfform name="transaction_menu"  action="transaction.cfm?type=save" method="post">
  <table align="center"  width="70%">
    <tr>
      <td style="background-color:#00abcc; color:#FFF;  border:3px ridge #CCC; font-size:16px" onClick="javascript:shoh('transaction_menu_page1');shoh('transaction_menu_page2');"><strong>Page 1</strong><img src="/images/d.gif" name="imgtransaction_menu_page1" align="center"></td>
      <td style="background-color:#00abcc; color:#FFF;  border:3px ridge #CCC; font-size:16px" onClick="javascript:shoh('transaction_menu_page2');shoh('transaction_menu_page1');"><strong>Page 2</strong><img src="/images/u.gif" name="imgtransaction_menu_page2" align="center"></td>
    </tr>
  </table>
  <cfoutput>
    <table id="transaction_menu_page1" align="center" style="border: 3px ridge ##CCC;
	border-spacing: 0;
    border-radius: 7px;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	-khtml-border-radius-: 7px;
	text-shadow:##FFF;
	background-color:##F5F5F5;" width="70%">
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Transaction Setup</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Text Editor For Comment</div></th>
        <td><input name="texteditor" type="checkbox" value="1" <cfif texteditor eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Allow Edit Amount</div></th>
        <td><input name="editamount" type="checkbox" value="1" <cfif editamount eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Keep Deleted Bills</div></th>
        <td><input name="keepDeletedBills" type="checkbox" value="1" <cfif keepDeletedBills eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Generate Revision for
            <input name="generateQuoRevision1" type="text" value="#generateQuoRevision1#" maxlength="100" size="20">
            (For example: QUO)</div></th>
        <td><input name="generateQuoRevision" type="checkbox" value="1" <cfif generateQuoRevision eq '1'>checked</cfif>>
          <input name="revStyle" type="text" value="#revStyle#" maxlength="5" size="5"></td>
      </tr>
      <!---<tr>
            <th><div align="left">Edit Bill Password control for 
              <input name="editbillpassword1" type="text" value="#editbillpassword1#" maxlength="100" size="20">
              (For example: QUO,INV)</div></th>
            <td><input name="editbillpassword" type="checkbox" value="1" <cfif editbillpassword eq '1'>checked</cfif>>
            </td>
          </tr>--->
      
      <tr>
        <th><div align="left">Disable bill to be void after generate revision</div></th>
        <td><input name="disablevoid" id="disablevoid" type="checkbox" value="1" <cfif disablevoid eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Enable voucher for invoice</div></th>
        <td><input name="voucher" type="checkbox" value="1" <cfif voucher eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Enable item as voucher</div></th>
        <td><input name="asvoucher" type="checkbox" value="1" <cfif asvoucher eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Enable voucher have usage balance</div></th>
        <td><input name="voucherbal" type="checkbox" value="1" <cfif voucherbal eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Apply Voucher Before Discount</div></th>
        <td><input name="voucherb4disc" type="checkbox" value="1" <cfif voucherb4disc eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Apply Voucher As Discount</div></th>
        <td><input name="voucherasdisc" type="checkbox" value="1" <cfif voucherasdisc eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Enable Foreign currency</div></th>
        <td><input name="fcurrency" type="checkbox" value="1" <cfif fcurrency eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Change Comment field to textbox</div></th>
        <td><input name="commenttext" type="checkbox" value="1" <cfif commenttext eq 'Y'>checked</cfif>></td>
      </tr>
       <tr>
        <th><div align="left">Set limit for Term &amp; Cond text box</div></th>
        <td><cfinput name="termlimit" type="text" value="#termlimit#" validate="integer" message="Term & Cond limit field is Invalid (Number Only)"/></td>
      </tr>
      <tr>
        <th><div align="left">Set limit for comment text box</div></th>
        <td><cfinput name="commentlimit" type="text" value="#commentlimit#" validate="integer" message="Please Enter Numbers Only"/></td>
      </tr>
      <tr>
        <th><div align="left">Set limit for description text box max 100 ( for Product Profile )</div></th>
        <td><cfinput name="desplimit" type="text" value="#desplimit#" validate="integer" message="Please Enter Numbers Only" range="1,100"/></td>
      </tr>
      <tr>
        <th><div align="left">Set Limit For First Discount %</div></th>
        <td><cfinput name="disp1limit" type="text" value="#disp1limit#" validate="integer" maxlength="2" message="Please Enter Numbers Only" range="0,99"/></td>
      </tr>
      <tr>
        <th><div align="left">Enable Choose Customer At Issue</div></th>
        <td><input name="custissue" id="custissue" type="checkbox" value="Y" <cfif custissue eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Allow Bill Create and Edit in Year End Period</div></th>
        <td><input name="allowedityearend" id="allowedityearend" type="checkbox" value="Y" <cfif allowedityearend eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Enable Transaction Date in all Transaction</div></th>
        <td><input name="transactiondate" id="transactiondate" type="checkbox" value="Y" <cfif transactiondate eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Update User ID in Transaction</div></th>
        <td><input name="tranuserid" id="tranuserid" type="checkbox" value="Y" <cfif tranuserid eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Enable Terms & Condition Function</div></th>
        <td><input name="termscondition" id="termscondition" type="checkbox" value="Y" <cfif termscondition eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Enable Choose Credit Card Type</div></th>
        <td><input name="crcdtype" id="crcdtype" type="checkbox" value="Y" <cfif crcdtype eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Disable FOC popup at transaction</div></th>
        <td><input name="disablefoc" id="disablefoc" type="checkbox" value="Y" <cfif disablefoc eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Exchange Rate at Bill Footer</div></th>
        <td><input name="footerexchange" id="footerexchange" type="checkbox" value="Y" <cfif footerexchange eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Enable select Lead at Quotation</div></th>
        <td><input name="quotationlead" id="quotationlead" type="checkbox" value="Y" <cfif quotationlead eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Enable Quotation Change Item No</div></th>
        <td><input name="quotationchangeitem" id="quotationchangeitem" type="checkbox" value="Y" <cfif quotationchangeitem eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Express bill date will be the following day's date when passes</div></th>
        <td><cfinput name="autonextdate" id="autonextdate" type="text" value="#autonextdate#" range="1,24" message="Please Enter 1 to 24 for express bill date">
          (24 hour format) </td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Update Bill</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Update from PO to RC Follow PO Currency Rate</div></th>
        <td><input name="po_to_rc_currrate" id="po_to_rc_currrate" type="checkbox" value="Y" <cfif po_to_rc_currrate eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Enable QUO/SO update to PO when status is Y</div></th>
        <td><input name="updatetopo" id="updatetopo" type="checkbox" value="Y" <cfif updatetopo eq 'Y'>checked</cfif>></td>
      </tr>
      <!---<tr>
          <th><div align="left">Enable QUO/SO update to PO when status is Y</div></th>
          <td><input name="updatetopo" id="updatetopo" type="checkbox" value="Y" <cfif updatetopo eq 'Y'>checked</cfif>>
          </td>
        </tr>--->
      <tr>
        <th><div align="left">Enable Edit Of Transaction After Update</div></th>
        <td><input name="enableedit" type="checkbox" value="1" <cfif enableedit eq 'Y'>checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Stock Value</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Display Cost Code During Transaction</div></th>
        <td><input name="displaycostcode" id="displaycostcode" type="checkbox" value="Y" <cfif displaycostcode eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Cost Code Formula</div></th>
        <td><input name="costformula1" id="costformula1" type="text" value="#costformula1#" size="10" maxlength="10">
          &nbsp;&nbsp;
          <input name="costformula2" id="costformula2" type="text" value="#costformula2#" size="1" maxlength="1">
          &nbsp;&nbsp;
          <input name="costformula3" id="costformula3" type="text" value="#costformula3#" size="10" maxlength="10"></td>
      </tr>
      <tr>
        <th><div align="left">Enable Negative Stock</div></th>
        </th>
        <td><input name="negstk" type="checkbox" value="1" <cfif negstk eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Prompt Negative Available Qty</div></th>
        <td><input name="proavailqty" type="checkbox" value="1" <cfif proavailqty eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Prompt zero or min stock</div></th>
        <td><input name="prozero" id="prozero" type="checkbox" value="1" <cfif prozero eq '1'>checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Email And Approved</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">PO update to RC Require Approval of Admins</div></th>
        <td><input name="poapproval" id="poapproval" type="checkbox" value="Y" <cfif poapproval eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Required Password for Print & Delete</div></th>
        <td><input name="RPED" type="checkbox" value="1" <cfif RPED eq 'Y'>checked</cfif>></td>
      </tr>
      
      <tr>
        <th><div align="left">Printing of PO are only allowed after 2 level approval</div></th>
        <td><input name="printapprove" id="printapprove" type="checkbox" value="Y" <cfif printapprove eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
      <th colspan="2"><div align="left">1st Level Approval User Group <input name="printapprovelevel1" type="text" value="#printapprovelevel1#" maxlength="100" size="20"></div></th>
      </tr>
      <tr>
      <th colspan="2"><div align="left">2nd Level Approval User Group<input name="printapprovelevel2" type="text" value="#printapprovelevel2#" maxlength="100" size="20"></div></th>
      </tr>
      <tr>
        <th><div align="left">Transaction below this amount only need 1 level of approval</div></th>
        <td><cfinput name="printapproveamt" id="printapproveamt" type="text" value="#numberformat(printapproveamt,'_.__')#" validate="float" message="Please Enter a correct amount" maxlength="17"></td>
      </tr>
      
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Location</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Only Show Location Wtih Qty</div></th>
        <td><input name="locationwithqty" id="locationwithqty" type="checkbox" value="Y" <cfif locationwithqty eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Follow First Item Location</div></th>
        <td><input name="followlocation" id="followlocation" type="checkbox" value="Y" <cfif followlocation eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Light Transaction Location</div></th>
        <td><input name="lightloc" id="lightloc" type="checkbox" value="Y" <cfif lightloc eq 'Y'>checked</cfif>></td>
      </tr>
      
      <tr>
        <th><div align="left">Transaction Printing Option</div></th>
        <td><input name="printoption" type="checkbox" value="1" <cfif printoption eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Choose Location When Update Bill</div></th>
        <td><input name="chooselocation" type="checkbox" value="Y" <cfif chooselocation eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Location Bond With Customer/Supplier</div></th>
        <td><input name="locarap" type="checkbox" value="Y" <cfif locarap eq 'Y'>checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Project</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Automatic Create Project When SO is Created</div></th>
        <td><input name="soautocreaproj" id="soautocreaproj" type="checkbox" value="Y" <cfif soautocreaproj eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Remain Same Project With Previous Entry</div></th>
        <td><input name="remainloc" id="remainloc" type="checkbox" value="Y" <cfif remainloc eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Project & Job By Bill</div></th>
        <td><input name="projectbybill" type="checkbox" value="1" <cfif projectbybill eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Project By Bill, Job By Item</div></th>
        <td><input name="jobbyitem" type="checkbox" value="1" <cfif jobbyitem eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Project Account Code Auto Assign</div></th>
        <td><input name="PACAA" type="checkbox" value="1" <cfif PACAA eq 'Y'>checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Tax</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">With per Item Tax</div></th>
        <td><input name="wpitemtax" type="checkbox" value="1" <cfif wpitemtax eq '1'>checked</cfif>>
          <!---<input name="wpitemtax1" type="text" value="#wpitemtax1#">---></td>
      </tr>
      <tr>
        <th><div align="left">Disable Tax for Non Gst Customer/Supplier</div></th>
        <td><input name="ngstcustdisabletax" type="checkbox" value="1" <cfif ngstcustdisabletax eq '1'>checked</cfif>></td>
      </tr>
      <!--- <tr>
          <th><div align="left">Tax Auto Included for Non Gst Customer/Supplier</div></th>
          <td><input name="ngstcustautotax" type="checkbox" value="1" <cfif ngstcustautotax eq '1'>checked</cfif>>
          </td>
        </tr>--->
      <tr>
        <th><div align="left">Enable Tax Included as default</div></th>
        <td><input name="taxincluded" type="checkbox" value="1" <cfif taxincluded eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Enable Item Tax Follow According To Item Profile</div></th>
        <td><input name="taxfollowitemprofile" id="taxfollowitemprofile" type="checkbox" value="Y" <cfif taxfollowitemprofile eq 'Y'>checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Search</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Select Item Code By Filter</div></th>
        <td><input name="filteritem" type="checkbox" value="1" <cfif filteritem eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Select Item Code By Ajax List</div></th>
        <td><input name="filteritemAJAX" id="filteritemAJAX" type="checkbox" value="1" <cfif filteritemAJAX eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Select Product,Category,Group,Supplier/Customer By Filter</div></th>
        <td><input name="filterall" type="checkbox" value="1" <cfif filterall eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Show Supplier/Customer in Drop Down Selection List</div></th>
        <td><input name="suppcustdropdown" type="checkbox" value="1" <cfif suppcustdropdown eq '1'>checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Discount</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Apply Discount From Supplier or Customer profile</div></th>
        <td><input name="appDisSupCus" type="checkbox" value="1" <cfif appDisSupCus eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Apply Discount From Supplier or Customer profile <strong>To Item</strong></div></th>
        <td><input name="appDisSupCusitem" type="checkbox" value="1" <cfif appDisSupCusitem eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Apply Promotion Discount Toward Price</div></th>
        <td><input name="prodisprice" type="checkbox" value="1" <cfif prodisprice eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Transaction Discount Method</div></th>
        <td><select name="itemdiscmethod">
            <option value="byamt" <cfif itemdiscmethod eq 'byamt'>selected</cfif>>Item Discount By Amount</option>
            <option value="byprice" <cfif itemdiscmethod eq 'byprice'>selected</cfif>>Item Discount By Price</option>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Discount Type</div></th>
        <td><select name="expressdisc" id="expressdisc">
            <option value="1" <cfif expressdisc eq "1">Selected</cfif>>Discount Percent</option>
            <option value="2" <cfif expressdisc eq "2">Selected</cfif>>Discount Quantity</option>
          </select></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>BOM</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Enable Advance BOM</div></th>
        <td><input name="advancebom" id="advancebom" type="checkbox" value="Y" <cfif advancebom eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Auto Generate BOM if quantity reach 0</div></th>
        <td><input name="autobom" id="autobom" type="checkbox" value="Y" <cfif autobom eq 'Y'>checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Serial No</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Serial No autorun</div></th>
        <td><input name="serialnorun" id="serialnorun" type="checkbox" value="Y" <cfif serialnorun eq 'Y'>checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Barcode</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Enable Barcode Detect Remark 2 Field in Express Transaction</div></th>
        <td><input name="enabledetectrem1" id="enabledetectrem1" type="checkbox" value="Y" <cfif enabledetectrem1 eq 'Y'>checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Posting</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Post Tax Seperately Based On A/C Code</div></th>
        <td><input name="PPTS" type="checkbox" value="1" <cfif PPTS eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Automatic Posting Check When Post</div></th>
        <td><input name="APCWP" type="checkbox" value="1" <cfif APCWP eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Post Payment With Knockoff Features</div></th>
        <td><input name="PPWKOF" type="checkbox" value="1" <cfif PPWKOF eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Post Without Divide Project & Job</div></th>
        <td><input name="PNOPROJECT" type="checkbox" value="1" <cfif PNOPROJECT eq 'Y'>checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Others</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Use only 1 set of Invoice no</div></th>
        <td><input name="invoneset" type="checkbox" value="1" <cfif invoneset eq '1'>checked</cfif>></td>
      </tr>
      <!--- BEGIN: ADD ON 190608 --->
      <cfif HcomID eq "pnp_i">
        <input name="rc_oneset" type="hidden" value="#rc_oneset#">
        <input name="rq_oneset" type="hidden" value="#rq_oneset#">
        <input name="pr_oneset" type="hidden" value="#pr_oneset#">
        <input name="do_oneset" type="hidden" value="#do_oneset#">
        <input name="cs_oneset" type="hidden" value="#cs_oneset#">
        <input name="cn_oneset" type="hidden" value="#cn_oneset#">
        <input name="dn_oneset" type="hidden" value="#dn_oneset#">
        <input name="iss_oneset" type="hidden" value="#iss_oneset#">
        <input name="po_oneset" type="hidden" value="#po_oneset#">
        <input name="so_oneset" type="hidden" value="#so_oneset#">
        <input name="quo_oneset" type="hidden" value="#quo_oneset#">
        <input name="assm_oneset" type="hidden" value="#assm_oneset#">
        <input name="tr_oneset" type="hidden" value="#tr_oneset#">
        <input name="oai_oneset" type="hidden" value="#oai_oneset#">
        <input name="oar_oneset" type="hidden" value="#oar_oneset#">
        <input name="sam_oneset" type="hidden" value="#sam_oneset#">
        <cfelse>
        <tr>
          <th><div align="left">Use only 1 set of Purchase Receive no</div></th>
          <td><input name="rc_oneset" type="checkbox" value="1" <cfif rc_oneset eq '1'>checked</cfif>></td>
        </tr>
        <tr>
          <th><div align="left">Use only 1 set of Purchase Return no</div></th>
          <td><input name="pr_oneset" type="checkbox" value="1" <cfif pr_oneset eq '1'>checked</cfif>></td>
        </tr>
        <tr>
          <th><div align="left">Use only 1 set of Delivery Order no</div></th>
          <td><input name="do_oneset" type="checkbox" value="1" <cfif do_oneset eq '1'>checked</cfif>></td>
        </tr>
        <tr>
          <th><div align="left">Use only 1 set of Cash Sales no</div></th>
          <td><input name="cs_oneset" type="checkbox" value="1" <cfif cs_oneset eq '1'>checked</cfif>></td>
        </tr>
        <tr>
          <th><div align="left">Use only 1 set of Credit Note no</div></th>
          <td><input name="cn_oneset" type="checkbox" value="1" <cfif cn_oneset eq '1'>checked</cfif>></td>
        </tr>
        <tr>
          <th><div align="left">Use only 1 set of Debit Note no</div></th>
          <td><input name="dn_oneset" type="checkbox" value="1" <cfif dn_oneset eq '1'>checked</cfif>></td>
        </tr>
        <tr>
          <th><div align="left">Use only 1 set of Purchase Requisition no</div></th>
          <td><input name="rq_oneset" type="checkbox" value="1" <cfif rq_oneset eq '1'>checked</cfif>></td>
        </tr>
        <tr>
          <th><div align="left">Use only 1 set of Issue no</div></th>
          <td><input name="iss_oneset" type="checkbox" value="1" <cfif iss_oneset eq '1'>checked</cfif>></td>
        </tr>
        <tr>
          <th><div align="left">Use only 1 set of Purchase Order no</div></th>
          <td><input name="po_oneset" type="checkbox" value="1" <cfif po_oneset eq '1'>checked</cfif>></td>
        </tr>
        <tr>
          <th><div align="left">Use only 1 set of Sales Order no</div></th>
          <td><input name="so_oneset" type="checkbox" value="1" <cfif so_oneset eq '1'>checked</cfif>></td>
        </tr>
        <tr>
          <th><div align="left">Use only 1 set of Quotation no</div></th>
          <td><input name="quo_oneset" type="checkbox" value="1" <cfif quo_oneset eq '1'>checked</cfif>></td>
        </tr>
        <tr>
          <th><div align="left">Use only 1 set of Assembly no</div></th>
          <td><input name="assm_oneset" type="checkbox" value="1" <cfif assm_oneset eq '1'>checked</cfif>></td>
        </tr>
        <tr>
          <th><div align="left">Use only 1 set of Transfer no</div></th>
          <td><input name="tr_oneset" type="checkbox" value="1" <cfif tr_oneset eq '1'>checked</cfif>></td>
        </tr>
        <tr>
          <th><div align="left">Use only 1 set of Adjustment Increase no</div></th>
          <td><input name="oai_oneset" type="checkbox" value="1" <cfif oai_oneset eq '1'>checked</cfif>></td>
        </tr>
        <tr>
          <th><div align="left">Use only 1 set of Adjustment Reduce no</div></th>
          <td><input name="oar_oneset" type="checkbox" value="1" <cfif oar_oneset eq '1'>checked</cfif>></td>
        </tr>
        <tr>
          <th><div align="left">Use only 1 set of Sample no</div></th>
          <td><input name="sam_oneset" type="checkbox" value="1" <cfif sam_oneset eq '1'>checked</cfif>></td>
        </tr>
        <cfif isdefined("ct_oneset")>
          <tr>
            <th><div align="left">Use only 1 set of Consignment Note no</div></th>
            <td><input name="ct_oneset" type="checkbox" value="1" <cfif ct_oneset eq '1'>checked</cfif>></td>
          </tr>
        </cfif>
      </cfif>
      <tr>
        <th><div align="left">Enable Auto Refno 2 for</div></th>
        <td><table>
            <tr>
              <td><input name="refno2inv" type="checkbox" value="1" <cfif refno2inv eq '1'>checked</cfif>>
                INV </td>
              <td><input name="refno2SO" type="checkbox" value="1" <cfif refno2SO eq '1'>checked</cfif>>
                SO&nbsp; </td>
              <td><input name="refno2PR" type="checkbox" value="1" <cfif refno2PR eq '1'>checked</cfif>>
                PR </td>
            </tr>
            <tr>
              <td><input name="refno2RC" type="checkbox" value="1" <cfif refno2RC eq '1'>checked</cfif>>
                RC </td>
              <td><input name="refno2DO" type="checkbox" value="1" <cfif refno2DO eq '1'>checked</cfif>>
                DO </td>
              <td><input name="refno2CS" type="checkbox" value="1" <cfif refno2CS eq '1'>checked</cfif>>
                CS </td>
            </tr>
            <tr>
              <td><input name="refno2CN" type="checkbox" value="1" <cfif refno2CN eq '1'>checked</cfif>>
                CN </td>
              <td><input name="refno2DN" type="checkbox" value="1" <cfif refno2DN eq '1'>checked</cfif>>
                DN </td>
              <td><input name="refno2PO" type="checkbox" value="1" <cfif refno2PO eq '1'>checked</cfif>>
                PO </td>
            </tr>
            <tr>
              <td><input name="refno2QUO" type="checkbox" value="1" <cfif refno2QUO eq '1'>checked</cfif>>
                QUO </td>
            </tr>
          </table></td>
      </tr>
    
      <tr>
        <th><div align="left">Auto Set Recommended Price</div>
          <div align="left">
            <input name="recompriceup1" type="text" value="#recompriceup1#" maxlength="100" size="20">
          </div></th>
        <td><input name="recompriceup" id="recompriceup" type="checkbox" value="1" <cfif recompriceup eq 'Y'>checked</cfif>></td>
      </tr>
      <cfif lcase(hcomid) eq "msd_i">
        <tr>
          <th><div align="left">Ship Via Selection</div></th>
          <td><input name="shipvia" type="checkbox" value="1" <cfif shipvia eq '1'>checked</cfif>></td>
        </tr>
        <cfelse>
        <input name="shipvia" type="hidden" value="1">
      </cfif>
      <cfif (lcase(hcomid) eq "glenndemo_i" or lcase(hcomid) eq "glenn_i")>
        <cfquery name="getdriver" datasource="#dts#">
				select driverno,name from driver order by driverno
			</cfquery>
        <tr>
          <th>Default #getGeneralInfo.lDRIVER#</th>
          <td><select name="driver">
              <option value="">Please select one...</option>
              <cfloop query="getdriver">
                <option value="#getdriver.driverno#" <cfif getdriver.driverno eq driver>selected</cfif>>#getdriver.driverno# - #getdriver.name#</option>
              </cfloop>
            </select></td>
        </tr>
      </cfif>
      <tr>
        <th><div align="left">Enable Add on Remark</div></th>
        <td><input name="addonremark" type="checkbox" value="1" <cfif addonremark eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Collection Address</div></th>
        <td><input name="collectaddress" type="checkbox" value="1" <cfif collectaddress eq 'Y'>checked</cfif>></td>
      </tr>
      
      <!--- <tr>
          <th><div align="left">Set limit for comment text box</div></th>
          <td><cfinput name="commentlimit" type="text" value="#commentlimit#" validate="integer" message="Please Enter Numbers Only"/>
          </td>
        </tr>
        <tr>
          <th><div align="left">Set limit for description text box max 60 ( for Product Profile )</div></th>
          <td><cfinput name="desplimit" type="text" value="#desplimit#" validate="integer" message="Please Enter Numbers Only" range="1,60"/>
          </td>
        </tr>---> 
      
      <!--- <tr>
          <th><div align="left">Enable Choose Customer At Issue</div></th>
          <td><input name="custissue" id="custissue" type="checkbox" value="Y" <cfif custissue eq 'Y'>checked</cfif>>
          </td>
        </tr>--->
      <tr>
        <th><div align="left">Deduct SO for Balance On Hand</div></th>
        <td><input name="deductso" id="deductso" type="checkbox" value="Y" <cfif deductso eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Enable Quotation Prefix by Customer</div></th>
        <td><input name="prefixbycustquo" id="prefixbycustquo" type="checkbox" value="Y" <cfif prefixbycustquo eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Enable Sales Order Prefix by Customer</div></th>
        <td><input name="prefixbycustso" id="prefixbycustso" type="checkbox" value="Y" <cfif prefixbycustso eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Enable Invoice Prefix by Customer</div></th>
        <td><input name="prefixbycustinv" id="prefixbycustinv" type="checkbox" value="Y" <cfif prefixbycustinv eq 'Y'>checked</cfif>></td>
      </tr>
      <!---<tr>
          <th><div align="left">Allow Bill Create and Edit in Year End Period</div></th>
          <td><input name="allowedityearend" id="allowedityearend" type="checkbox" value="Y" <cfif allowedityearend eq 'Y'>checked</cfif>>
          </td>
        </tr>--->
      <tr>
        <th><div align="left">Change Attention to drop down list in transaction</div></th>
        <td><input name="attnddl" id="attnddl" type="checkbox" value="Y" <cfif attnddl eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Simple Transaction Include Multi Add Item Function</div></th>
        <td><input name="expressmultiitem" id="expressmultiitem" type="checkbox" value="Y" <cfif expressmultiitem eq 'Y'>checked</cfif>></td>
      </tr>
      
      <!---<tr>
          <th><div align="left">Enable Transaction Date in all Transaction</div></th>
          <td><input name="transactiondate" id="transactiondate" type="checkbox" value="Y" <cfif transactiondate eq 'Y'>checked</cfif>>
          </td>
        </tr>---> 
      
      <!---<tr>
          <th><div align="left">Update from PO to RC Follow PO Currency Rate</div></th>
          <td><input name="po_to_rc_currrate" id="po_to_rc_currrate" type="checkbox" value="Y" <cfif po_to_rc_currrate eq 'Y'>checked</cfif>>
          </td>
        </tr>--->
      
      <tr>
        <th><div align="left">Show Service part & Cost</div></th>
        <td><input name="showservicepart" id="showservicepart" type="checkbox" value="Y" <cfif showservicepart eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">History Price in Transaction Base on Invoice/PO base on RC</div></th>
        <td><input name="histpriceinv" id="histpriceinv" type="checkbox" value="Y" <cfif histpriceinv eq 'Y'>checked</cfif>></td>
      </tr>
      <!---<tr>
          <th><div align="left">Automatic Create Project When SO is Created</div></th>
          <td><input name="soautocreaproj" id="soautocreaproj" type="checkbox" value="Y" <cfif soautocreaproj eq 'Y'>checked</cfif>>
          </td>
        </tr>---> 
      
      <!---<tr>
          <th><div align="left">Enable Choose Credit Card Type</div></th>
          <td><input name="crcdtype" id="crcdtype" type="checkbox" value="Y" <cfif crcdtype eq 'Y'>checked</cfif>>
          </td>
        </tr>---> 
      
      <!---<tr>
          <th><div align="left">Enable Terms & Condition Function</div></th>
          <td><input name="termscondition" id="termscondition" type="checkbox" value="Y" <cfif termscondition eq 'Y'>checked</cfif>>
          </td>
        </tr>--->
      
      <tr>
        <th><div align="left">Auto Pop out Oustanding So report when login</div></th>
        <td><input name="autooutstandingreport" id="autooutstandingreport" type="checkbox" value="Y" <cfif autooutstandingreport eq 'Y'>checked</cfif>></td>
      </tr>
      
      <!--- <tr>
          <th><div align="left">Disable FOC popup at transaction</div></th>
          <td><input name="disablefoc" id="disablefoc" type="checkbox" value="Y" <cfif disablefoc eq 'Y'>checked</cfif>>
          </td>
        </tr>
        <tr>
          <th><div align="left">Exchange Rate at Bill Footer</div></th>
          <td><input name="footerexchange" id="footerexchange" type="checkbox" value="Y" <cfif footerexchange eq 'Y'>checked</cfif>>
          </td>
        </tr>
        
        <tr>
          <th><div align="left">Enable select Lead at Quotation</div></th>
          <td><input name="quotationlead" id="quotationlead" type="checkbox" value="Y" <cfif quotationlead eq 'Y'>checked</cfif>>
          </td>
        </tr>--->
      
      <tr>
        <th><div align="left">Dummy Customer</div></th>
        <cfquery name="getdummycustomer" datasource="#dts#">
          select * from #target_arcust#
          </cfquery>
        <td><select name="dummycust">
            <option value="" <cfif dummycust eq ''>selected</cfif>>Select a Customer No</option>
            <cfloop query="getdummycustomer">
              <option value="#getdummycustomer.custno#" <cfif dummycust eq '#getdummycustomer.custno#'>selected</cfif>>#getdummycustomer.custno# - #getdummycustomer.name#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Matrix Express Setup</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Apply Discount From Supplier or Customer profile (By Item)</div></th>
        <td><input name="mitemdiscountbyitem" id="mitemdiscountbyitem" type="checkbox" value="Y" <cfif mitemdiscountbyitem eq 'Y'>checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Simple INV Setup</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Simple Invoice Type</div></th>
        <td><select name="simpleinvtype">
            <option value="1" <cfif simpleinvtype eq '1'>selected</cfif>>Member</option>
            <option value="2" <cfif simpleinvtype eq '2'>selected</cfif>>Customer</option>
          </select></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>POS Setup</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Required amount to get 1 Member Point</div></th>
        <td><input type="text" name="memberpointamt" id="memberpointamt" value="#memberpointamt#"></td>
      </tr>
      
      <!--- <tr>
          <td colspan="2"><div align="center"><strong>Printing Setup</strong></div></td>
        </tr>--->
      
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Maintenance Setup</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Enable Dropdownlist for country</div></th>
        <td><input name="countryddl" type="checkbox" value="1" <cfif countryddl eq 'Y'>checked</cfif>></td>
      </tr>

      <tr>
        <th><div align="left">Enable more fields for customer name</div></th>
        <td><input name="custnamelength" type="checkbox" value="1" <cfif custnamelength eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Set all info key to capital letters</div></th>
        <td><input name="capall" type="checkbox" value="1" <cfif capall eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Automatic Create Location B/F When Create New Item</div></th>
        <td><input name="autolocbf" id="autolocbf" type="checkbox" value="1" <cfif autolocbf eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Include Group In Item</div></th>
        <td><input name="grpinitem" id="grpinitem" type="checkbox" value="1" <cfif grpinitem eq 'Y'>checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Report Setup</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Only allow single location in location report</div></th>
        <td><input name="singlelocation" id="singlelocation" type="checkbox" value="Y" <cfif singlelocation eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Select Item Code By Filter(Report)</div></th>
        <td><input name="filteritemreport" type="checkbox" value="1" <cfif filteritemreport eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Item Status and Value Fifo Calculation Way</div></th>
        <td><select name="fifocal" id="fifocal">
            <option value="1" <cfif fifocal eq "1">selected </cfif>>Qty x Currrate x Price</option>
            <option value="2" <cfif fifocal eq "2">selected </cfif>>Amt / TotalQty x Qty</option>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Sales Report - Agent from customer profile</div></th>
        <td><input name="reportagentfromcust" type="checkbox" value="1" <cfif reportagentfromcust eq '1'>checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Default Value Setup</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Bill Type Default</div></th>
        <td><select name="ddlbilltype">
            <cfloop list ="INV,QUO,SO,CS,PO,DO,RC,PR,CN,DN" index="i">
              <option value="#i#"  <cfif #i# eq #getGeneralInfo.ddlbilltype#>selected</cfif>>#i#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Cash Sales Default Customer</div></th>
        <cfquery name="getcustno" datasource="#dts#">
			select custno,name from #target_arcust# order by custno
      	  </cfquery>
        <td><select name="df_cs_cust">
            <option value="">Please select a location to set as default</option>
            <cfloop query ="getcustno">
              <option value="#custno#" <cfif #custno# eq #getGeneralInfo.df_cs_cust#>selected</cfif>>#custno# - #name#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Search Customer Default</div></th>
        <td><select name="ddlcust">
            <cfloop list ="Customer ID,Customer Name,Agent,Customer Tel,Left Name,Company UEN" index="i">
              <option value="#i#"  <cfif #i# eq #getGeneralInfo.ddlcust#>selected</cfif>>#i#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Search Supplier Default</div></th>
        <td><select name="ddlsupp">
            <cfloop list ="Supplier ID,Supplier Name,Agent,Supplier Tel,Left Name,Company UEN" index="i">
              <option value="#i#"  <cfif #i# eq #getGeneralInfo.ddlsupp#>selected</cfif>>#i#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Search Transaction Default</div></th>
        <td><select name="ddltran">
            <cfloop list ="Refno,Refno2,Supplier/Customer ID,Supplier/Customer Name,Agent,Period,Phone,Date,Left Name,created_by" index="i">
              <option value="#i#"  <cfif #i# eq #getGeneralInfo.ddltran#>selected</cfif>>#i#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Search Item Default</div></th>
        <td><select name="ddlitem">
            <cfloop list="Item No,Product Code,Brand,Description,Category,Size,Rating,Material,Group,Model,All" index="i">
              <option value="#i#" <cfif #i# eq #getGeneralInfo.ddlitem#>selected</cfif>>#i#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Location Default</div></th>
        <cfquery name="getlocation" datasource="#dts#">
	select location,desp from iclocation order by location;
      </cfquery>
        <td><select name="ddllocation">
            <option value="">Please select a location to set as default</option>
            <cfloop query ="getlocation">
              <option value="#location#" <cfif #location# eq #getGeneralInfo.ddllocation#>selected</cfif>>#location# - #desp#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Agent Default</div></th>
        <cfquery name="getagent" datasource="#dts#">
	select agent,desp from icagent order by agent;
      </cfquery>
        <td><select name="ddlagent">
            <option value="">Please select a agent to set as default</option>
            <cfloop query ="getagent">
              <option value="#agent#" <cfif #agent# eq #getGeneralInfo.ddlagent#>selected</cfif>>#agent# - #desp#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Term Default</div></th>
        <cfquery name="getterm" datasource="#dts#">
	select term,desp from #target_icterm# order by term;
      </cfquery>
        <td><select name="ddlterm">
            <option value="">Please select a term to set as default</option>
            <cfloop query ="getterm">
              <option value="#term#" <cfif #term# eq #getGeneralInfo.ddlterm#>selected</cfif>>#term# - #desp#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Transfer Default</div></th>
        <td><select name="df_trprice">
            <option value="cost">Cost</option>
            <option value="Price" <cfif #df_trprice# eq 'price'>selected</cfif>>Price</option>
            <option value="Price2" <cfif #df_trprice# eq 'price2'>selected</cfif>>Price 2</option>
            <option value="Price3" <cfif #df_trprice# eq 'price3'>selected</cfif>>Price 3</option>
            <option value="Price4" <cfif #df_trprice# eq 'price4'>selected</cfif>>Price 4</option>
            <option value="Price5" <cfif #df_trprice# eq 'price5'>selected</cfif>>Price 5</option>
            <option value="Price6" <cfif #df_trprice# eq 'price6'>selected</cfif>>Price 6</option>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Default Gst (%)</div></th>
        <td><cfinput type="text" name="gst" value="#gst#" size="3" maxlength="2" validate="float" message="Please Enter Correct TAX Value !"></td>
      </tr>
      <tr>
        <th><div align="left">Default Qty</div></th>
        <td><cfinput type="text" name="df_qty" value="#df_qty#" size="3" maxlength="2" validate="float" message="Please Enter Correct Qty Value !"></td>
      </tr>
      <tr>
        <th><div align="left">Discount Limit</div></th>
        <td><cfinput type="text" name="disclimit" value="#disclimit#" size="3" maxlength="3" range="0,100" validate="float" message="Please Enter Correct Discount Limit Value !"></td>
      </tr>
      <cfquery name="gettaxcode" datasource="#dts#">
			select * from #target_taxtable#
		</cfquery>
      <tr>
        <th><div align="left">Default Sales Tax Code</div></th>
        <td><select name="df_salestax">
            <cfloop query="gettaxcode">
              <option value="#gettaxcode.code#" <cfif gettaxcode.code eq df_salestax>selected</cfif>>#gettaxcode.code#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Default Sales Tax Code When Tax = 0</div></th>
        <td><select name="df_salestaxzero">
            <cfloop query="gettaxcode">
              <option value="#gettaxcode.code#" <cfif gettaxcode.code eq df_salestaxzero>selected</cfif>>#gettaxcode.code#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Default Purchase Tax Code</div></th>
        <td><select name="df_purchasetax">
            <cfloop query="gettaxcode">
              <option value="#gettaxcode.code#" <cfif gettaxcode.code eq df_purchasetax>selected</cfif>>#gettaxcode.code#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Default Purchase Tax Code When Tax = 0</div></th>
        <td><select name="df_purchasetaxzero">
            <cfloop query="gettaxcode">
              <option value="#gettaxcode.code#" <cfif gettaxcode.code eq df_purchasetaxzero>selected</cfif>>#gettaxcode.code#</option>
            </cfloop>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Default Customer Code</div></th>
        <td><cfinput type="text" name="dfcustcode" value="#dfcustcode#"></td>
      </tr>
      <tr>
        <th><div align="left">Default Supplier Code</div></th>
        <td><cfinput type="text" name="dfsuppcode" value="#dfsuppcode#"></td>
      </tr>
      <tr>
        <th><div align="left">POS Smallest Unit</div></th>
        <td><select name="dfpos" id="dfpos">
            <option value="0.10" <cfif dfpos eq "0.10">Selected</cfif>>10 Cents</option>
            <option value="0.05" <cfif dfpos eq "0.05">Selected</cfif>>5 Cents</option>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Old Customer / Supplier Profile</div></th>
        <td><input name="oldcustsupp" type="checkbox" value="1" <cfif oldcustsupp eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Default NON-GST Customer</div></th>
        <td><input name="defaultNONGSTcustomer" type="checkbox" value="1" <cfif defaultNONGSTcustomer eq 'Y'>checked</cfif>></td>
      </tr>
      
      <tr>
          <th><div align="left">Default Member Price Level</div></th>
          <td><select name="df_mem_price" id="df_mem_price">
          <option value="">Choose a price level</option>
          <option value="1" <cfif df_mem_price eq 1>selected</cfif>>1</option>
          <option value="2" <cfif df_mem_price eq 2>selected</cfif>>2</option>
          <option value="3" <cfif df_mem_price eq 3>selected</cfif>>3</option>
          <option value="4" <cfif df_mem_price eq 4>selected</cfif>>4</option>
          </select>
          </td>
        </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Agent Setup</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Enable Multi Agent</div></th>
        <td><input name="multiagent" type="checkbox" value="1" <cfif multiagent eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Agent in transaction follow customer profile</div></th>
        <td><input name="agentbycust" id="agentbycust" type="checkbox" value="Y" <cfif agentbycust eq 'Y'>checked</cfif>></td>
      </tr>
            <tr>
        <th><div align="left">Assign User ID to Agent</div></th>
        <td><input name="agentuserid" type="checkbox" value="1" <cfif agentuserid eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Assign Multiple User ID to Agent</div></th>
        <td><input name="agentlistuserid" type="checkbox" value="1" <cfif agentlistuserid eq 'Y'>checked</cfif>></td>
      </tr>
      
      </tr>
      
    </table>
    <table id="transaction_menu_page2" style="display:none" align="center" class="data" width="70%">
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Costing Method</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Fixed Cost</div></th>
        <td><input type="radio" name="cost" value="fixed"<cfif cost eq "FIXED">checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Month Average</div>
        </th>
        <td><input type="radio" name="cost" value="month"<cfif cost eq "MONTH">checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Moving Average</div>
        </th>
        <td><input type="radio" name="cost" value="moving"<cfif cost eq "MOVING">checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Weighted Average</div>
        </th>
        <td><input type="radio" name="cost" value="weight"<cfif cost eq "WEIGHT">checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">First In First Out (FIFO)</div></th>
        <td><input type="radio" name="cost" value="fifo"<cfif cost eq "FIFO">checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Last In First Out (LIFO)</div></th>
        <td><input type="radio" name="cost" value="lifo"<cfif cost eq "LIFO">checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">CN price for cost (untick initial cost)</div></th>
        <td><input name="CNbaseonprice" type="checkbox" value="1" <cfif CNbaseonprice eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Include Misc Cost In Costing</div></th>
        <td><input name="includemisc" type="checkbox" value="1" <cfif includemisc eq '1'>checked</cfif>></td>
      </tr>
      
      <!--- --->
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Type of contribute to costing</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">CN</div></th>
        <td><input type="checkbox" name="costingCN" value="Y"<cfif costingCN eq "Y">checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">OAI</div></th>
        <td><input type="checkbox" name="costingOAI" value="Y"<cfif costingOAI eq "Y">checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Posting</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Description</div></th>
        <td><input type="radio" name="postvalue" value="desp"<cfif postvalue eq 'desp'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">PONO</div></th>
        <td><input type="radio" name="postvalue" value="pono"<cfif postvalue eq 'pono'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Allow Edit Posted Bills</div></th>
        <td><input name="alloweditposted" id="alloweditposted" type="checkbox" value="Y" <cfif alloweditposted eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Post Cash Sales into debtor account</div></th>
        <td><input name="postcsdebtor" id="postcsdebtor" type="checkbox" value="Y" <cfif postcsdebtor eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Post Deposit into same debtor account</div></th>
        <td><input name="postdepdebtor" id="postdepdebtor" type="checkbox" value="Y" <cfif postdepdebtor eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Post RC 2nd Refno to Refno</div></th>
        <td><input name="postingRCRefno" id="postingRCRefno" type="checkbox" value="Y" <cfif postingRCRefno eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Periodic Posting</div></th>
        <td><input name="periodficposting" id="periodficposting" type="checkbox" value="Y" <cfif periodficposting eq 'Y'>checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Others</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Default Assign End User In Transaction</div></th>
        <td><input name="defaultEndUser" type="checkbox" value="1" <cfif defaultEndUser eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Choose Item For Quotation When Update Into Others</div></th>
        <td><input name="quoChooseItem" type="checkbox" value="1" <cfif quoChooseItem eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Additional Unit of Measurement</div></th>
        <td><input name="auom" type="checkbox" value="1" <cfif auom eq '1'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Cust/Supp Limit To Be Displayed</div></th>
        <td><input name="custsupp_limit_display" type="text" value="#custsupp_limit_display#" size="2"></td>
      </tr>
      <tr>
        <th><div align="left">Automatic Set Address Code to Profile</div></th>
        <td><input name="ASACTP" type="checkbox" value="1" <cfif ASACTP eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Automatic Set Delivery Address</div></th>
        <td><input name="ASDA" type="checkbox" value="1" <cfif ASDA eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Insert Batch Code for Quotation,PO and SO</div></th>
        <td><input name="quobatch" id="quobatch" type="checkbox" value="Y" <cfif quobatch eq "Y">checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">SO Material</div></th>
        <td><input name="projectcompany" id="projectcompany" type="checkbox" value="Y" <cfif projectcompany eq "Y">checked</cfif>></td>
      </tr>
      <tr>
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Customer Number Style</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">xxxx/xxx</div></th>
        <td><input name="custSuppNo" type="radio" value="1" <cfif custSuppNo eq "1">checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">xxxxxxx</div></th>
        <td><input name="custSuppNo" type="radio" value="2" <cfif custSuppNo eq "2">checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Supplier Number Style</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">xxxx/xxx</div></th>
        <td><input name="SuppNo" type="radio" value="1" <cfif SuppNo eq "1">checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">xxxxxxx</div></th>
        <td><input name="SuppNo" type="radio" value="2" <cfif SuppNo eq "2">checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Bill No Length</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Non Accounting Bill No Length (Maximum 50)</div></th>
        <td><input name="refnoNACC" type="text" value="#refnoNACC#" size="3"></td>
      </tr>
      <tr>
        <th><div align="left">Accounting Bill No Length (Maximum 50)</div></th>
        <td><input name="refnoACC" type="text" value="#refnoACC#" size="3"></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>eInvoice</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Invoice Attach File Type</div></th>
        <td><cfif selectbill1 eq "1">
            <select name="iaft" id="iaft">
              <option value="Default" <cfif iaft eq "#selectbill.file_name#"> selected </cfif>>Default Format</option>
              <cfloop query="selectbill">
                <option value="#selectbill.file_name#"<cfif iaft eq "#selectbill.file_name#"> selected </cfif>>#selectbill.display_name#</option>
              </cfloop>
            </select>
            <cfelse>
            <input type="text" name="iaft" id="iaft" value="#iaft#">
          </cfif></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Express Transaction</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Express Add Product Type</div></th>
        <td><select name="EAPT" id="EAPT">
            <option value="1"  <cfif EAPT eq "1">selected</cfif>>1</option>
            <option value="2" <cfif EAPT eq "2">selected</cfif>>2</option>
          </select></td>
      </tr>
      <tr>
        <th><div align="left">Purchase Receive From</div></th>
        <td><select name="PRF" id="PRF">
            <option value="creditor"  <cfif PRF eq "creditor">selected</cfif>>CREDITORS</option>
            <option value="debtor" <cfif PRF eq "debtor">selected</cfif>>DEBTORS</option>
          </select></td>
      </tr>
      <tr>
        <td colspan="2"><div align="center"><strong>Express Bill</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">After Except Continue Entry</div></th>
        <td><input name="AECE" type="checkbox" value="1" <cfif AECE eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Enable Change Address Others Than Admin</div></th>
        <td><input name="ECAOTA" type="checkbox" value="1" <cfif ECAOTA eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Enable Change Amount Others Than Admin</div></th>
        <td><input name="ECAMTOTA" type="checkbox" value="1" <cfif ECAMTOTA eq 'Y'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Price cannot be lower than cost</div></th>
        <td><input name="PCBLTC" type="checkbox" value="1" <cfif PCBLTC eq 'Y'>checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Transaction Control</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">RC Price Update To Item Cost</div>
        </th>
        <td><input name="RCPCOST" id="RCPCOST" type="checkbox" value="1" <cfif RCPCOST eq 'T'>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Price Decimal Point</div>
        </th>
        <td><input name="pricedecpoint" id="pricedecpoint" type="text" size="5" value="#pricedecpoint#"></td>
      </tr>
      <tr>
        <th><div align="left">Total Decimal Point</div>
        </th>
        <td><input name="totaldecpoint" id="totaldecpoint" type="text" size="5" value="#totaldecpoint#"></td>
      </tr>
      <tr>
        <th><div align="left">Total Amount Calculation Decimal Point </div></th>
        <td><input name="totalamtdecpoint" id="totalamtdecpoint" type="text" size="5" value="#totalamtdecpoint#"></td>
      </tr>
      <tr>
        <th><div align="left">Item Price Priority</div></th>
        <td><select name="itempriceprior" id="itempriceprior">
            <option value="1" <cfif itempriceprior eq "1">Selected</cfif>>1.Promotion - 2.Recommended - 3.Business - 4.Item Profile</option>
            <option value="2" <cfif itempriceprior eq "2">Selected</cfif>>1.Promotion - 2.Business - 3.Recommended - 4.Item Profile</option>
          </select></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Multi Location</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">Invoice</div></th>
        <td><input name="multilocation" type="checkbox" value="INV" <cfif ListFindNoCase(xmultilocation, "INV", ",") neq 0>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Purchase Receive</div></th>
        <td><input name="multilocation" type="checkbox" value="RC" <cfif ListFindNoCase(xmultilocation, "RC", ",") neq 0>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Purchase Return</div></th>
        <td><input name="multilocation" type="checkbox" value="PR" <cfif ListFindNoCase(xmultilocation, "PR", ",") neq 0>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Delivery Order</div></th>
        <td><input name="multilocation" type="checkbox" value="DO" <cfif ListFindNoCase(xmultilocation, "DO", ",") neq 0>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Cash Sales</div></th>
        <td><input name="multilocation" type="checkbox" value="CS" <cfif ListFindNoCase(xmultilocation, "CS", ",") neq 0>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Credit Note</div></th>
        <td><input name="multilocation" type="checkbox" value="CN" <cfif ListFindNoCase(xmultilocation, "CN", ",") neq 0>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Debit Note</div></th>
        <td><input name="multilocation" type="checkbox" value="DN" <cfif ListFindNoCase(xmultilocation, "DN", ",") neq 0>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Issue</div></th>
        <td><input name="multilocation" type="checkbox" value="ISS" <cfif ListFindNoCase(xmultilocation, "ISS", ",") neq 0>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Purchase Order</div></th>
        <td><input name="multilocation" type="checkbox" value="PO" <cfif ListFindNoCase(xmultilocation, "PO", ",") neq 0>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Sales Order</div></th>
        <td><input name="multilocation" type="checkbox" value="SO" <cfif ListFindNoCase(xmultilocation, "SO", ",") neq 0>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Quotation</div></th>
        <td><input name="multilocation" type="checkbox" value="QUO" <cfif ListFindNoCase(xmultilocation, "QUO", ",") neq 0>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Adjustment Increase</div></th>
        <td><input name="multilocation" type="checkbox" value="OAI" <cfif ListFindNoCase(xmultilocation, "OAI", ",") neq 0>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Adjustment Reduce</div></th>
        <td><input name="multilocation" type="checkbox" value="OAR" <cfif ListFindNoCase(xmultilocation, "OAR", ",") neq 0>checked</cfif>></td>
      </tr>
      <tr>
        <th><div align="left">Sample</div></th>
        <td><input name="multilocation" type="checkbox" value="SAM" <cfif ListFindNoCase(xmultilocation, "SAM", ",") neq 0>checked</cfif>></td>
      </tr>
      <tr height="20">
        <td colspan="2" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center"><strong>Homepage Menu</strong></div></td>
      </tr>
      <tr>
        <th><div align="left">HomePage Menu Default</div></th>
        <td><select name="homepagemenu">
            <cfif getGeneralInfo.interface eq "old">
              <option value="inforboard" <cfif homepagemenu eq 'inforboard'>selected</cfif>>Information Board</option>
              <option value="myfav" <cfif homepagemenu eq 'myfav'>selected</cfif>>My Favorites</option>
              <option value="dashboard" <cfif homepagemenu eq 'dashboard'>selected</cfif>>DashBoard</option>
              <option value="home" <cfif homepagemenu eq 'home'>selected</cfif>>Home</option>
              <option value="new" <cfif homepagemenu eq 'new'>selected</cfif>>New</option>
              <cfelse>
              <option value="dashboard" <cfif homepagemenu eq 'dashboard'>selected</cfif>>DashBoard</option>
              <option value="inforboard" <cfif homepagemenu eq 'inforboard'>selected</cfif>>Information Board</option>
              <option value="myfav" <cfif homepagemenu eq 'myfav'>selected</cfif>>Favorites</option>
              <option value="Navigation" <cfif homepagemenu eq 'Navigation'>selected</cfif>>Navigation</option>
              <option value="new" <cfif homepagemenu eq 'new'>selected</cfif>>New</option>
            </cfif>
          </select></td>
      </tr>
      <tr height="20">
        <td colspan="100%" style="background-color:##00abcc; color:##FFF;  border:3px ridge ##CCC; font-size:16px"><div align="center">Mail Server Setup</div></td>
      </tr>
      <tr>
        <th><div align="left">Mail Server</div></th>
        <td><cfinput type="text" name="mailserver" id="mailserver" maxlength="450" size="80"  value="#mailserver#" /></td>
      </tr>
      <tr>
        <th><div align="left">Mail Port</div></th>
        <td><cfinput type="text" name="mailport" id="mailport" maxlength="450" size="80"  value="#mailport#" /></td>
      </tr>
      <tr>
        <th><div align="left">Mail User</div></th>
        <td><cfinput type="text" name="mailuser" id="mailuser" maxlength="450" size="80"  value="#mailuser#" /></td>
      </tr>
      <tr>
        <th><div align="left">Mail Pass</div></th>
        <td><cfinput type="password" name="mailpassword" id="mailpassword" maxlength="450" size="80"  value="#mailpassword#" /></td>
      </tr>
      <tr>
        <th><div align="left">Default Receiver Email Address</div></th>
        <td><cfif left(dts,4) eq "beps"><cfinput type="text" name="dfemail" id="dfemail" maxlength="450" size="80"  value="#dfemail#"/><cfelse><cfinput type="text" name="dfemail" id="dfemail" maxlength="450" size="80"  value="#dfemail#" validate="email"/></cfif></td>
      </tr>
    </table>
    <table align="center" class="data" width="70%">
      <tr>
        <td colspan="2" align="center"><input name="submit" type="submit" value="Save">
          <input name="reset" type="reset" value="Reset"></td>
      </tr>
    </table>
  </cfoutput>
</cfform>
</body>
</html>