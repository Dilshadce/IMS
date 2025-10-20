<cfif isdefined('url.type')>
	<cftry>
        <cfquery name="updateGsetup" datasource="#dts#">
            UPDATE gsetup 
            SET 
                <cfif isdefined ("form.cost")>
                    cost=upper('#form.cost#'),
                <cfelse>
                    cost='',
                </cfif>
                <cfif isdefined ("form.recompriceup")>
                    recompriceup='Y',
                <cfelse>
                    recompriceup='N',
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
                <cfif isdefined ("form.defaultNONGSTcustomer")>
                    defaultNONGSTcustomer='Y',
                <cfelse>
                    defaultNONGSTcustomer='N',
                </cfif>
                <cfif isdefined ("form.filteritemAJAX")>
                    filteritemAJAX='1',
                <cfelse>
                    filteritemAJAX='0',
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
                	
                gst='#val(form.gst)#',
                disclimit='#val(form.disclimit)#',
                dfpos='#form.dfpos#',
                df_mem_price='#form.df_mem_price#',
                <cfif isdefined ("form.grpinitem")>	
                    grpinitem='Y',
                <cfelse>
                    grpinitem='N',
                </cfif>
                
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
              
                 <cfif isdefined("form.locarap")>
                    ,locarap = 'Y'
                <cfelse>
                    ,locarap = ''
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
                
                ,ddlitem ='#form.ddlitem#' 
                ,ddllocation ='#form.ddllocation#' 
                ,ddlagent ='#form.ddlagent#' 
                ,ddlterm ='#form.ddlterm#' 
                ,df_trprice ='#form.df_trprice#' 
                
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
                ,commentlimit = '#val(form.commentlimit)#'
                ,termlimit = '#val(form.termlimit)#'
                ,desplimit = '#val(form.desplimit)#'
                
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
                
                <cfif isdefined("form.locproject")>
                    ,locproject = 'Y'
                <cfelse>
                    ,locproject = 'N'
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
                <cfif isdefined("form.rqapproval")>
                    ,rqapproval = 'Y'
                <cfelse>
                    ,rqapproval = 'N'
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
                <cfif isdefined("form.quotationlead")>
                    ,quotationlead = 'Y'
                <cfelse>
                    ,quotationlead = 'N'
                </cfif>
                ,itemdiscmethod = "#form.itemdiscmethod#"
                <cfif isdefined("form.disablevoid")>
                    ,disablevoid = 'Y'
                <cfelse>
                    ,disablevoid = 'N'
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
                ,custSuppNo = "#form.custSuppNo#"
                ,SuppNo = "#form.SuppNo#"
                
			WHERE companyid='IMS';
        </cfquery>
        
        <cfquery name="updateGsetup2" datasource="#dts#">
            UPDATE gsetup2 
            SET
                DECL_DISCOUNT = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.totaldecpoint#">,
                DECL_UPRICE = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.pricedecpoint#">,
                DECL_TOTALAMT = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.totalamtdecpoint#">,
                <cfif isdefined('form.RCPCOST')>
                    UPDATE_UNIT_COST = "T"
                <cfelse>
                    UPDATE_UNIT_COST = "F"
                </cfif>
        </cfquery>
        
        <cfif hlinkams eq "Y">
            <cfset target_gsetup = replacenocase(dts,"_i","_a","all")&".gsetup">
            <cfquery name="updategsetupAMS" datasource="#dts#">
                UPDATE #target_gsetup# 
                SET
                    custno="#form.custsuppno#",
                    suppno="#form.suppno#";
            </cfquery>
        </cfif>
        
        <cfquery name="updategsetuppos" datasource="#dts#">
            UPDATE gsetuppos 
            SET memberpointamt="#val(form.memberpointamt)#";
        </cfquery>
        
    <cfcatch>
    </cfcatch>	    
	</cftry>  

    <script type="text/javascript">
		alert('Updated successfully!');
		window.open('/latest//body/bodymenu.cfm?id=60100&menuID=60100','_self');
	</script>
</cfif>