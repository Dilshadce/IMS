<html>
<head>
	<title>Transaction Setup</title>
 	<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/latest/js/bootstrap-toggle-master/bootstrap-toggle.min.css">
  	<link href="/latest/js/jQuery-Plugin-For-Beautifying-Checkboxes-Radio-Buttons-iCheck/skins/square/blue.css" type="text/css" rel="stylesheet">  
    <link href="/latest/CSS/generalSetup/generalInfoSetup/TransactionNew.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="/latest/tooltip/tooltip.css">
    <!--[if lt IE 9]>
        <script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
        <script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
	<script type="text/javascript" src="/latest/js/bootstrap-toggle-master/bootstrap-toggle.min.js"></script>
    <script type="text/javascript" src="/latest/js/tabToggle/tabToggle.js"></script>
    <script type="text/javascript" src="/latest/js/jQuery-Plugin-For-Beautifying-Checkboxes-Radio-Buttons-iCheck/icheck.min.js"></script>
	<script type="text/javascript" src="/latest/js/generalSetup/generalInfoSetup/TransactionNew.js"></script>
    <script type="text/javascript" src="/latest/js/autoNumeric/autoNumeric.js"></script>
    <script type="text/javascript" src="/latest/tooltip/tooltip.js"></script>
</head>

<cfquery name="getGeneralSetup" datasource="#dts#">
	SELECT * 
	FROM gsetup;
</cfquery>

<cfquery name="getGeneralSetup2" datasource="#dts#">
	SELECT decl_discount,decl_uprice,update_unit_cost,decl_totalamt
    FROM gsetup2;
</cfquery>

<cfquery name="getGeneralSetupPOS" datasource="#dts#" >
	SELECT memberpointamt 
	FROM gsetuppos;
</cfquery>

<cfquery name="getSalesTaxCode" datasource="#dts#">
	SELECT code,desp 
	FROM #target_taxtable#
    WHERE tax_type = 'ST'
</cfquery>

<cfquery name="getPurchaseTaxCode" datasource="#dts#">
	SELECT code,desp  
	FROM #target_taxtable#
    WHERE tax_type = 'PT'
</cfquery>

<cfquery name="getAgent" datasource="#dts#">
	SELECT agent,desp  
	FROM #target_icagent#;
</cfquery>

<cfquery name="getTerm" datasource="#dts#">
	SELECT term,desp 
	FROM #target_icterm# 
	ORDER BY term;
</cfquery>

<cfquery name="getUserLevel" datasource="#dts#">
    SELECT level 
    FROM userpin2 
    WHERE level != 'Super'
    ORDER BY level;
</cfquery>  

<cfquery name="getLocation" datasource="#dts#">
	SELECT location,desp 
	FROM iclocation 
	ORDER BY location;
</cfquery>

<!---
<cfquery name="getGeneralInfo" datasource="#dts#">
	SELECT * 
	FROM gsetup;
</cfquery>

<cfquery name="getGeneralInfo2" datasource="#dts#">
	SELECT decl_discount,decl_uprice,update_unit_cost,decl_totalamt
    FROM gsetup2;
</cfquery>--->

<!--- Panel 1: Sub 1 --->
<cfset wpitemtax = getGeneralSetup.wpitemtax>
<cfset taxincluded = getGeneralSetup.taxincluded>
<cfset taxfollowitemprofile = getGeneralSetup.taxfollowitemprofile>
<cfset df_salestax = getGeneralSetup.df_salestax>
<cfset df_salestaxzero = getGeneralSetup.df_salestaxzero>
<cfset df_purchasetax = getGeneralSetup.df_purchasetax>
<cfset df_purchasetaxzero = getGeneralSetup.df_purchasetaxzero>
<cfset appDisSupCus = getGeneralSetup.appDisSupCus>
<cfset appDisSupCusitem = getGeneralSetup.appDisSupCusitem>
<cfset expressdisc = getGeneralSetup.expressdisc>
<cfset itemdiscmethod = getGeneralSetup.itemdiscmethod>
<cfset gst = getGeneralSetup.gst>
<!--- Panel 1: Sub 2 --->
<cfset disablevoid = getGeneralSetup.disablevoid>
<cfset generateQuoRevision=getGeneralSetup.generateQuoRevision>
<cfset keepDeletedBills = getGeneralSetup.keepDeletedBills>
<cfset tranuserid = getGeneralSetup.tranuserid>
<cfset allowedityearend = getGeneralSetup.allowedityearend>
<cfset custissue = getGeneralSetup.custissue>
<cfset quotationlead = getGeneralSetup.quotationlead>
<cfset RCPCOST = getGeneralSetup2.UPDATE_UNIT_COST>
<cfset serialnorun = getGeneralSetup.serialnorun>
<cfset voucher = getGeneralSetup.voucher>
<cfset asvoucher = getGeneralSetup.asvoucher>
<cfset voucherbal = getGeneralSetup.voucherbal>
<cfset voucherb4disc = getGeneralSetup.voucherb4disc>
<cfset voucherasdisc = getGeneralSetup.voucherasdisc>
<!--- Panel 1: Sub 3 --->
<cfset pricedecpoint = val(getGeneralSetup2.DECL_UPRICE)>
<cfset totaldecpoint = val(getGeneralSetup2.DECL_DISCOUNT)>
<cfset totalamtdecpoint = val(getGeneralSetup2.DECL_TOTALAMT)>
<cfset commentlimit = getGeneralSetup.commentlimit>
<cfset termlimit = getGeneralSetup.termlimit>
<cfset desplimit = getGeneralSetup.desplimit>
<cfset disclimit = getGeneralSetup.disclimit>
<cfset disp1limit = getGeneralSetup.disp1limit>
<cfset dfpos = getGeneralSetup.dfpos>
<!--- Panel 1: Sub 4 --->
<cfset updatetopo = getGeneralSetup.updatetopo>
<cfset enableedit = getGeneralSetup.enableedit>
<cfset po_to_rc_currrate = getGeneralSetup.po_to_rc_currrate>
<!--- Panel 1: Sub 5 --->
<cfset poapproval = getGeneralSetup.poapproval>
<cfset RPED = getGeneralSetup.EDControl>
<cfset printapprove = getGeneralSetup.printapprove>
<cfset printapprovelevel1 = getGeneralSetup.printapprovelevel1>
<cfset printapprovelevel2 = getGeneralSetup.printapprovelevel2>
<cfset printapproveamt = getGeneralSetup.printapproveamt>
<cfset mailserver = getGeneralSetup.mailserver>
<cfset mailport = getGeneralSetup.mailport>
<cfset mailuser = getGeneralSetup.mailuser>
<cfset mailpassword = getGeneralSetup.mailpassword>
<cfset dfemail = getGeneralSetup.dfemail>
<!--- Panel 1: Sub 6 --->
<cfset negstk = getGeneralSetup.negstk>
<cfset proavailqty = getGeneralSetup.proavailqty>
<cfset prozero = getGeneralSetup.prozero>
<cfset costformula1 = getGeneralSetup.costformula1>
<cfset costformula2 = getGeneralSetup.costformula2>
<cfset costformula3 = getGeneralSetup.costformula3>
<cfset displaycostcode = getGeneralSetup.displaycostcode>
<!--- Panel 1: Sub 7 --->
<cfset soautocreaproj = getGeneralSetup.soautocreaproj>
<cfset remainloc = getGeneralSetup.remainloc>
<cfset projectbybill = getGeneralSetup.projectbybill>
<cfset jobbyitem = getGeneralSetup.jobbyitem>
<cfset PACAA = getGeneralSetup.PACAA>
<!--- Panel 1: Sub 8 --->
<cfset multiagent = getGeneralSetup.multiagent>
<cfset agentbycust = getGeneralSetup.agentbycust>
<cfset agentuserid = getGeneralSetup.agentuserid>
<cfset agentlistuserid = getGeneralSetup.agentlistuserid>
<cfset ddlagent = getGeneralSetup.ddlagent>
<!--- Panel 1: Sub 9 --->
<cfset xmultilocation = getGeneralSetup.multilocation>
<cfset locationwithqty = getGeneralSetup.locationwithqty>
<cfset followlocation = getGeneralSetup.followlocation>
<cfset locarap = getGeneralSetup.locarap>
<cfset ddllocation = getGeneralSetup.ddllocation>
<!--- Panel 1: Sub 10 --->
<cfset advancebom = getGeneralSetup.advancebom>
<cfset autobom = getGeneralSetup.autobom>
<!--- Panel 1: Sub 11 --->
<cfset df_trprice = getGeneralSetup.df_trprice>
<cfset defaultNONGSTcustomer = getGeneralSetup.defaultNONGSTcustomer>
<cfset defaultEndUser = getGeneralSetup.defaultenduser>
<cfset quoChooseItem = getGeneralSetup.quoChooseItem>
<cfset ASACTP = getGeneralSetup.ASACTP>
<cfset ASDA = getGeneralSetup.ASDA>
<cfset QUOBATCH = getGeneralSetup.QUOBATCH>
<cfset projectcompany = getGeneralSetup.projectcompany>
<cfset deductso = getGeneralSetup.deductso>
<cfset recompriceup = getGeneralSetup.recompriceup>
<cfset addonremark = getGeneralSetup.addonremark>
<cfset collectaddress = getGeneralSetup.collectaddress>
<cfset prefixbycustquo = getGeneralSetup.prefixbycustquo>
<cfset prefixbycustso = getGeneralSetup.prefixbycustso>
<cfset prefixbycustinv = getGeneralSetup.prefixbycustinv>
<cfset expressmultiitem = getGeneralSetup.expressmultiitem>
<cfset histpriceinv = getGeneralSetup.histpriceinv>
<cfset filteritemreport = getGeneralSetup.filteritemreport>
<cfset filteritem = getGeneralSetup.filteritem>
<cfset filteritemAJAX = getGeneralSetup.filteritemAJAX>
<cfset filterall = getGeneralSetup.filterall>
<cfset suppcustdropdown = getGeneralSetup.suppcustdropdown>
<cfset ddlterm = getGeneralSetup.ddlterm>
<cfset showservicepart = getGeneralSetup.showservicepart>
<cfset ddlbilltype = getGeneralSetup.ddlbilltype>

<cfset ddlitem = getGeneralSetup.ddlitem>
<cfset ddlsupp = getGeneralSetup.ddlsupp>
<cfset ddltran = getGeneralSetup.ddltran>
<cfset ddlcust = getGeneralSetup.ddlcust>

<!--- Panel 2--->
<cfset PPTS = getGeneralSetup.PPTS>
<cfset APCWP = getGeneralSetup.APCWP>
<cfset PPWKOF = getGeneralSetup.PPWKOF>
<cfset PNOPROJECT = getGeneralSetup.PNOPROJECT>
<cfset alloweditposted = getGeneralSetup.alloweditposted>
<cfset postcsdebtor = getGeneralSetup.postcsdebtor>
<cfset postdepdebtor = getGeneralSetup.postdepdebtor>
<cfset postingRCRefno = getGeneralSetup.postingRCRefno>
<cfset periodficposting = getGeneralSetup.periodficposting>
<cfset postvalue = getGeneralSetup.postvalue>
<!--- Panel 3--->
<cfset cost = getGeneralSetup.cost>
<cfset CNbaseonprice = getGeneralSetup.CNbaseonprice>
<cfset includemisc = getGeneralSetup.includemisc>
<cfset costingCN = getGeneralSetup.costingCN>
<cfset costingOAI = getGeneralSetup.costingOAI>
<!--- Panel 4: Sub 1 --->
<cfset custSuppNo = getGeneralSetup.custSuppNo >
<cfset SuppNo = getGeneralSetup.SuppNo >
<!--- Panel 4: Sub 2 --->
<cfset invoneset = getGeneralSetup.invoneset>
<cfset rc_oneset = getGeneralSetup.rc_oneset>
<cfset pr_oneset = getGeneralSetup.pr_oneset>
<cfset do_oneset = getGeneralSetup.do_oneset>
<cfset cs_oneset = getGeneralSetup.cs_oneset>
<cfset cn_oneset = getGeneralSetup.cn_oneset>
<cfset dn_oneset = getGeneralSetup.dn_oneset>
<cfset rq_oneset = getGeneralSetup.rq_oneset>
<cfset iss_oneset = getGeneralSetup.iss_oneset>
<cfset po_oneset = getGeneralSetup.po_oneset>
<cfset so_oneset = getGeneralSetup.so_oneset>
<cfset quo_oneset = getGeneralSetup.quo_oneset>
<cfset assm_oneset = getGeneralSetup.assm_oneset>
<cfset tr_oneset = getGeneralSetup.tr_oneset>
<cfset oai_oneset = getGeneralSetup.oai_oneset>
<cfset oar_oneset = getGeneralSetup.oar_oneset>
<cfset sam_oneset = getGeneralSetup.sam_oneset>
<cfset refno2INV = getGeneralSetup.refno2INV>
<cfset refno2SO = getGeneralSetup.refno2SO>
<cfset refno2PR = getGeneralSetup.refno2PR>
<cfset refno2RC = getGeneralSetup.refno2RC>
<cfset refno2DO = getGeneralSetup.refno2DO>
<cfset refno2CS = getGeneralSetup.refno2CS>
<cfset refno2CN = getGeneralSetup.refno2CN>
<cfset refno2DN = getGeneralSetup.refno2DN>
<cfset refno2PO = getGeneralSetup.refno2PO>
<cfset refno2QUO = getGeneralSetup.refno2QUO>
<!--- Panel 5 --->
<cfset singlelocation = getGeneralSetup.singlelocation>
<cfset fifocal = getGeneralSetup.fifocal>
<cfset reportagentfromcust = getGeneralSetup.reportagentfromcust>
<cfset autooutstandingreport = getGeneralSetup.autooutstandingreport>
<!--- Panel 6 --->
<cfset memberpointamt = getGeneralSetupPOS.memberpointamt>
<cfset df_mem_price = getGeneralSetup.df_mem_price>



<!---
<cfset gpricemin = getGeneralInfo.gpricemin>
<cfset recompriceup1 = getGeneralInfo.recompriceup1>
<cfset priceminctrl = getGeneralInfo.priceminctrl>
<cfset priceminpass = getGeneralInfo.priceminpass>
<cfset printoption = getGeneralInfo.printoption>
<cfset postvalue = getGeneralInfo.postvalue>
<cfset shipvia = getGeneralInfo.shipvia>
<cfset gst = getGeneralInfo.gst>
<cfset df_qty = getGeneralInfo.df_qty>
<cfset dfcustcode = getGeneralInfo.dfcustcode>
<cfset dfsuppcode = getGeneralInfo.dfsuppcode>
<cfset CNbaseonprice = getGeneralInfo.CNbaseonprice>
<cfset includemisc = getGeneralInfo.includemisc>
<cfset oldcustsupp = getGeneralInfo.oldcustsupp>
<cfset fifocal = getGeneralInfo.fifocal>
<cfset texteditor = getGeneralInfo.texteditor>
<cfset wpitemtax1=getGeneralInfo.wpitemtax1>
<cfset ngstcustdisabletax=getGeneralInfo.ngstcustdisabletax>
<cfset ngstcustautotax=getGeneralInfo.ngstcustautotax>
<cfset editamount=getGeneralInfo.editamount>
<cfset chooselocation = getGeneralInfo.chooselocation>
<cfset auom = getGeneralInfo.auom>
<cfset countryddl = getGeneralInfo.countryddl>
<cfset fcurrency = getGeneralInfo.fcurrency>
<cfset prodisprice = getGeneralInfo.prodisprice>
<cfset commenttext = getGeneralInfo.commenttext>
<cfset custnamelength = getGeneralInfo.custnamelength>
<cfset capall = getGeneralInfo.capall>
<cfset autolocbf = getGeneralInfo.autolocbf>
<cfset df_trprice = getGeneralInfo.df_trprice>
<cfset simpleinvtype = getGeneralInfo.simpleinvtype>
<cfset autonextdate = getGeneralInfo.autonextdate>
<cfset attnddl = getGeneralInfo.attnddl>
<cfset transactiondate = getGeneralInfo.transactiondate>
<cfset enabledetectrem1 = getGeneralInfo.enabledetectrem1>
>
<cfset histpriceinv = getGeneralInfo.histpriceinv>
<cfset crcdtype = getGeneralInfo.crcdtype>
<cfset termscondition = getGeneralInfo.termscondition>
<cfset lightloc = getGeneralInfo.lightloc>
<cfset disablefoc = getGeneralInfo.disablefoc>
<cfset footerexchange = getGeneralInfo.footerexchange>
<cfset dummycust = getGeneralInfo.dummycust>
<cfset quotationchangeitem = getGeneralInfo.quotationchangeitem>
<cfset mitemdiscountbyitem = getGeneralInfo.mitemdiscountbyitem>
<cfset iaft = getGeneralInfo.iaft>
<cfset EAPT = getGeneralInfo.EAPT>
<cfset PRF = getGeneralInfo.PRF>
<cfset PACAA = getGeneralInfo.PACAA>
<cfset ECAOTA = getGeneralInfo.ECAOTA>
<cfset ECAMTOTA = getGeneralInfo.ECAMTOTA>
<cfset PCBLTC = getGeneralInfo.PCBLTC>
<cfset itempriceprior = getGeneralInfo.itempriceprior>
<cfset homepagemenu= getGeneralInfo.homepagemenu>
<cfset editbillpassword=getGeneralInfo.editbillpassword>
<cfset revStyle=getGeneralInfo.revStyle>
<cfset generateQuoRevision1=getGeneralInfo.generateQuoRevision1>
<cfset editbillpassword1=getGeneralInfo.editbillpassword1>
<cfif isdefined("getGeneralInfo.ct_oneset")>
  <cfset ct_oneset=getGeneralInfo.ct_oneset>
</cfif>
<cfset custsupp_limit_display=getGeneralInfo.custsupp_limit_display>
<cfset refnoNACC = getGeneralInfo.refnoNACC>
<cfset refnoACC = getGeneralInfo.refnoACC>--->


<body class="container">
<cfform id="generalSetupform" name="generalSetupform" action="TransactionNewProcess.cfm?type=save" method="post">

<cfoutput>
   		<div id="header" class="row">
            <div class="col-sm-6"> General Setup - Transaction Setup</div>
            <div class="col-sm-6"></div>  
	 	</div> 
		<!---START: 1st Layer Tabs --->          
        <ul class="nav nav-tabs" id="interest_tabs">
            <li><a href="##transaction" data-toggle="tab" id="transactionMain">Transaction</a></li>
            <cfif HlinkAMS EQ 'Y'>
            	<li><a href="##posting" data-toggle="tab" id="postinglist">Posting</a></li>
            </cfif>
            <li><a href="##method" data-toggle="tab" id="Costinglist">Costing Method</a></li>
            <li><a href="##referenceNumber" data-toggle="tab" id="referenceMain">Reference Number</a></li>
            <li><a href="##report" data-toggle="tab" id="reportlist">Report</a></li>
            <li><a href="##pos" data-toggle="tab" id="poslist">POS</a></li>
        </ul>
        <!---END: 1st Layer Tabs --->
        
        <!---START: 2nd Layer Tabs --->
		<div class="tab-content layer" style="margin-top:0">
            <div id="transaction" class="tab-pane fade">
                <ul class="nav nav-tabs" id="transaction_tabs">
                	<li ><a href="##tax" data-toggle="tab">Tax / Discount</a></li>
                    <li><a href="##bill" data-toggle="tab">Bill / Voucher</a></li>
                    <li><a href="##limit" data-toggle="tab">Limit</a></li>
                    <li><a href="##update" data-toggle="tab">Update</a></li>
                    <li><a href="##mailSetup" data-toggle="tab">Approval / Mail</a></li> 
                    <li><a href="##costing" data-toggle="tab">Stock Value</a></li>
                    <!--- <cfif getpin2.H10319c EQ 'T'>   --->
                    	<li><a href="##project" data-toggle="tab">Project</a></li>
                    <!--- </cfif>
                    <cfif getpin2.H10314 EQ 'T'>  --->
                    	<li><a href="##agent" data-toggle="tab">Agent</a></li>
                    <!--- </cfif>
                    <cfif getpin2.H10319b EQ 'T'> --->
                    	<li><a href="##multiLoc" data-toggle="tab">Location</a></li>
                    <!--- </cfif>
                    <cfif getpin2.H10317 EQ 'T'> --->
                    	<li><a href="##BOM" data-toggle="tab">B.O.M</a></li>
                   <!---  </cfif> --->
                    <li><a href="##more" data-toggle="tab">More</a></li>
                </ul>
            </div>    
            <div id="referenceNumber" class="tab-pane fade">
                <ul class="nav nav-tabs" id="item_tabs">
                    <li><a href="##numberStyle" data-toggle="tab">Customer No</a></li>
                    <li><a href="##other" data-toggle="tab">Reference Number Set</a></li>
                </ul>
            </div>        
		 </div>
         <!---END: 2nd Layer Tabs --->
        
         
       <div class="tab-content">
        	<!--- Tax & Discount --->
            <div id="tax" class="tab-pane fade active">		
                <h4><u> Tax </u></h4>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Tax On</div>
                                <div class="col-sm-8">   	
                                    <input name="wpitemtax" id="wpitemtax" type="checkbox" value="1" data-toggle="toggle"  data-style="ios" data-onstyle="success" data-offstyle="info"  data-on="ITEM" data-off="BILL" data-width="60"  data-size="small"<cfif wpitemtax eq '1'>checked</cfif>>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Default Tax Included</div>
                                <div class="col-sm-8">        								 
                                    <input name="taxincluded" id="taxincluded" type="checkbox" value="1" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60"  data-size="small"<cfif taxincluded eq 'Y'>checked</cfif>>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                    	<div id="itemTaxOnly">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Item Tax From Item Profile</div>
                                    <input name="taxfollowitemprofile" id="taxfollowitemprofile" type="checkbox" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60"  data-size="small"<cfif taxfollowitemprofile eq 'Y'>checked</cfif>> 
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                 <div class="col-sm-4">Default Tax</div>
                                 <div class="col-sm-5 col-xs-offset-1 input-group">
                                    <input type="text" class="form-control" name="gst" id="gst" value="#gst#" size="3" maxlength="2" validate="float">																
                                    <span class="input-group-addon">%</span>
                                 </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                 <div class="col-sm-4">Default Sales Tax Code</div>
                                 <div class="col-sm-5 col-xs-offset-1 input-group">
                                    <select class="form-control" style="width:220" name="df_salestax" id="df_salestax">
                                    	<cfloop query="getSalesTaxCode">
                                        	<option value="#getSalesTaxCode.code#" <cfif getSalesTaxCode.code eq df_salestax>selected</cfif>>#getSalesTaxCode.code# - #getSalesTaxCode.desp#</option>
                                    	</cfloop>
                                    </select>
                                 </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                 <div class="col-sm-4">Default Sales Tax Code When Tax = 0</div>
                                 <div class="col-sm-5 col-xs-offset-1 input-group">
                                 	<select class="form-control"  name="df_salestaxzero" id="df_salestaxzero">
                                   		<cfloop query="getSalesTaxCode">
                                     		<option value="#getSalesTaxCode.code#" <cfif getSalesTaxCode.code eq df_salestaxzero>selected</cfif>>#getSalesTaxCode.code# - #getSalesTaxCode.desp#</option>
                                     	</cfloop>
                                 	</select>
                                 </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                 <div class="col-sm-4">Default Purchase Tax Code</div>
                                 <div class="col-sm-5 col-xs-offset-1 input-group">
                                 	<select class="form-control" name="df_purchasetax" id="df_purchasetax">
                                   		<cfloop query="getPurchaseTaxCode">
                                        	<option value="#getPurchaseTaxCode.code#" <cfif getPurchaseTaxCode.code eq df_purchasetax>selected</cfif>>#getPurchaseTaxCode.code# - #getPurchaseTaxCode.desp#</option>
                                    	</cfloop>
									</select>
                                 </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
								<div class="col-sm-4">Default Purchase Tax Code When Tax = 0</div>
                                <div class="col-sm-5 col-xs-offset-1 input-group">
									<select class="form-control" name="df_purchasetaxzero" id="df_purchasetaxzero">
                                   		<cfloop query="getPurchaseTaxCode">
                                     		<option value="#getPurchaseTaxCode.code#" <cfif getPurchaseTaxCode.code eq df_purchasetaxzero>selected</cfif>>#getPurchaseTaxCode.code# - #getPurchaseTaxCode.desp#</option>
                                     	</cfloop>
                                 	</select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <hr>
                <h4><u> Discount </u></h4>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4"><strong>Bill</strong> Discount From Supplier/Customer profile</div>
                                <div class="col-sm-8">   
                                    <input name="appDisSupCus" id="appDisSupCus" type="checkbox" value="1" data-toggle="toggle" data-on="Enable" data-off="Disable" data-width="60" data-size="small" <cfif appDisSupCus eq 'Y'>checked</cfif>>       
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4"><strong>Item</strong> Discount From Supplier/Customer profile</div>
                                <div class="col-sm-8">
                                    <input name="appDisSupCusitem" id="appDisSupCusitem" type="checkbox" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small" value="1" <cfif appDisSupCusitem eq 'Y'>checked</cfif>>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Discount Type</div>
                                <div class="col-sm-5 col-xs-offset-1 input-group">
                                    <select name="expressdisc" id="expressdisc" class="form-control" style="width:210" id="expressdisc">
                                        <option value="1" <cfif expressdisc eq "1">Selected</cfif>>Discount Percent</option>
                                        <option value="2" <cfif expressdisc eq "2">Selected</cfif>>Discount Quantity</option>
                                    </select>
                                </div>
                            </div>	
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Transaction Discount Method</div>
                                <div class="col-sm-5 col-xs-offset-1 input-group">
                                    <select name="itemdiscmethod" id="itemdiscmethod" style="width:210" class="form-control">
                                        <option value="byamt" <cfif itemdiscmethod eq 'byamt'>selected</cfif>>Item Discount By Amount</option>
                                        <option value="byprice" <cfif itemdiscmethod eq 'byprice'>selected</cfif>>Item Discount By Price</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> 
            <!--- BILL --->
            <div id="bill" class="tab-pane fade">
                <h4><u> Bill </u></h4>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Generate Revision</div> 
                                <div class="col-sm-8">	
                                    <input name="generateQuoRevision" type="checkbox" id="GenerateRevision" name="GenerateRevision" value="1" data-toggle="toggle" data-on="Enable" data-off="Disable" data-size="small"<cfif generateQuoRevision eq '1'>checked</cfif>>
                                </div>
                                <div id="showList1" class="showList1 col-sm-6"<cfif generateQuoRevision NEQ '1'>style="display:none"</cfif>>
                                	<input name="generateRevision_PO" id="generateRevision_PO" type="checkbox" value="Y" data-toggle="toggle" data-width="60" data-style="ios"  data-on="<i class='glyphicon glyphicon-ok-circle'></i> PO" data-off="<i class='glyphicon glyphicon-ban-circle'></i> PO" data-size="mini">	
                                    <input name="generateRevision_SO" id="generateRevision_SO" type="checkbox" value="Y" data-toggle="toggle" data-width="60" data-style="ios" data-on="<i class='glyphicon glyphicon-ok-circle'></i> SO" data-off="<i class='glyphicon glyphicon-ban-circle'></i> SO" data-size="mini">	
                                    <input name="generateRevision_QUO" id="generateRevision_QUO" type="checkbox" value="Y" data-toggle="toggle" data-width="60" data-style="ios" data-on="<i class='glyphicon glyphicon-ok-circle'></i> QUO" data-off="<i class='glyphicon glyphicon-ban-circle'></i> QUO" data-size="mini">	
                                    <input name="generateRevision_SAM" id="generateRevision_SAM" type="checkbox" value="Y" data-toggle="toggle" data-width="60" data-style="ios" data-on="<i class='glyphicon glyphicon-ok-circle'></i> SAM" data-off="<i class='glyphicon glyphicon-ban-circle'></i> SAM" data-size="mini">	  
                                </div>  
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Void Revised Bill</div>
                                <div class="col-sm-2 col-xs-offset-1">
                                <input name="disablevoid"  class="col-sm-8" id="disablevoid" type="checkbox" data-width="60" value="1" data-toggle="toggle"   data-on="Enable" data-off="Disable"   data-size="small"<cfif disablevoid eq 'Y'>checked</cfif>>   
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Keep Deleted Bills</div>  
                                <input name="keepDeletedBills" id="keepDeletedBills" type="checkbox" value="1" data-toggle="toggle" data-width="60" data-on="Enable" data-off="Disable"   data-size="small"<cfif keepDeletedBills eq '1'>checked</cfif>>
                            </div>	
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Update User ID in Transaction</div>
                                <div class="col-sm-2 col-xs-offset-1">
                                <input name="tranuserid" id="tranuserid" type="checkbox" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable"  data-size="small"<cfif tranuserid eq 'Y'>checked</cfif>> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">	
                                <div class="col-sm-4">Edit Period 99 Bill</div>
                                <input name="allowedityearend" id="allowedityearend" class="col-sm-8"  data-width="60" type="checkbox" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable"   data-size="small"<cfif allowedityearend eq 'Y'>checked</cfif>>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Choose Customer At Issue</div>
                                <div class="col-sm-2 col-xs-offset-1">
                                    <input name="custissue" id="custissue" type="checkbox" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable"   data-size="small"<cfif custissue eq 'Y'>checked</cfif>>	
                                </div>
                            </div> 	                      	
                        </div>
                    </div>
                </div>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">                       	
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Serial No autorun</div>
                                <div class="col-sm-8">
                                    <input name="serialnorun" id="serialnorun" type="checkbox" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif serialnorun eq 'Y'>checked</cfif>>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">RC Price Update To Item Cost</div>
                                <div class="col-sm-2 col-xs-offset-1">
                                    <input name="RCPCOST" id="RCPCOST" type="checkbox" value="1" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif RCPCOST eq 'T'>checked</cfif>>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" align="center">
					<div class="col-sm-12 checkbox">                       	
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Choose Lead at Quotation</div>
                                <input name="quotationlead" id="quotationlead" class="col-sm-8" id="quotationlead" type="checkbox" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-size="small"<cfif quotationlead eq 'Y'>checked</cfif>>
                            </div>	  
                        </div>
                    </div>
                </div>
                <hr>
                <h4><u> Voucher </u></h4>
                <!--- Voucher --->
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">                            
                            <div class="col-sm-4">Voucher for Invoice</div>
                                <input name="voucher" id="voucher" class="col-sm-8" type="checkbox" value="1" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable" data-size="small"<cfif voucher eq 'Y'>checked</cfif>>
                            </div>             
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Item as voucher</div>
                                <div class="col-sm-2 col-xs-offset-1">
                                    <input name="asvoucher" id="asvoucher"  type="checkbox" value="1" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif asvoucher eq 'Y'>checked</cfif>>	
                                </div> 
                            </div> 
                        </div>
                    </div>
                </div>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                            <div class="col-sm-4">Voucher have usage balance</div>
                                <input name="voucherbal" id="voucherbal" type="checkbox"  class="col-sm-8" value="1" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif voucherbal eq 'Y'>checked</cfif>>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Apply Voucher Before Discount</div> 
                                <div class="col-sm-2 col-xs-offset-1"> 
                                    <input name="voucherb4disc" id="voucherb4disc" type="checkbox" value="1" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable" data-size="small"<cfif voucherb4disc eq 'Y'>checked</cfif>>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                            <div class="col-sm-4">Apply Voucher As Discount</div>
                                <input name="voucherasdisc" id="voucherasdisc" type="checkbox" class="col-sm-6" value="1" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"   data-size="small"<cfif voucherasdisc eq 'Y'>checked</cfif>>
                            </div>				
                        </div>
                    </div>
                </div>
            </div> 
            <div id="limit" class="tab-pane fade">
				<!--- Limitation --->
                <h4><u> Limit </u></h4>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                    	<div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Price Decimal Point</div>
                                <div class="col-sm-5 col-xs-offset-1 input-group">
                                    <input name="pricedecpoint" id="pricedecpoint" class="form-control" type="text" size="5" value="#pricedecpoint#" maxlength="2">					
                                    <span class="input-group-addon" id="decimalControl">.</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                  <div class="col-sm-4">Description Limit</div>
                                  <div class="col-sm-5 col-xs-offset-1 input-group">
                                  <input name="desplimit" id="desplimit" type="text" class="form-control" value="#desplimit#" validate="integer" message="Please Enter Numbers Only" range="1,100"/>
                                  </div>
                            </div>    
                        </div>
                    </div>
                </div>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
						<div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Discount Decimal Point</div>
                                <div class="col-sm-5 col-xs-offset-1 input-group">
                                    <input name="totaldecpoint" id="totaldecpoint"  class="form-control" type="text" size="5" value="#totaldecpoint#" maxlength="2">
                                    <span class="input-group-addon" id="decimalTotal">.</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                 <div class="col-sm-4">Comment Limit</div>
                                 <div class="col-sm-5 col-xs-offset-1 input-group">
                                 <input name="commentlimit" id="commentlimit" type="text" class="form-control" value="#commentlimit#" validate="integer" message="Please Enter Numbers Only"/>
                                 </div>
                            </div>  
                        </div>
                    </div>
               	</div>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Total Decimal Point</div>
                                <div class="col-sm-5 col-xs-offset-1 input-group">
                                    <input name="totalamtdecpoint" id="totalamtdecpoint"  class="form-control" type="text" size="5" maxlength="2" value="#totalamtdecpoint#"> 
                                    <span class="input-group-addon" id="decimalDiscount">.</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Terms &amp; Conditions Limit</div>
                                <div class="col-sm-5 col-xs-offset-1 input-group">
                                <input name="termlimit" id="termlimit" type="text"  class="form-control" value="#termlimit#" validate="integer" message="Term & Cond limit field is Invalid (Number Only)"/>					
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                 <div class="col-sm-4">Discount Limit %</div>
                                 <div class="col-sm-5 col-xs-offset-1 input-group">
                                    <input class="form-control" type="text" name="disclimit" id="disclimit" value="#disclimit#" size="3" maxlength="3">
                                    <span class="input-group-addon">%</span>
                                 </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                 <div class="col-sm-4">Cash Transaction Rounding</div>
                                 <div class="col-sm-5 col-xs-offset-1 input-group">  
                                    <select class="form-control" name="dfpos" id="dfpos">
                                        <option value="0.10" <cfif dfpos eq "0.10">Selected</cfif>>10 Cents</option>
                                        <option value="0.05" <cfif dfpos eq "0.05">Selected</cfif>>5 Cents</option>
                                    </select>
                                 </div>
                            </div>
                        </div>
                    </div>
                </div>  
            </div>	
            <div id="update" class="tab-pane fade">
                <h4 ><u> Update </u></h4>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                 <div class="col-sm-4">QUO/SO Update to PO When Status is Y</div>
                                 <div class="col-sm-8">
                                 <input name="updatetopo" id="updatetopo" type="checkbox" value="Y" data-toggle="toggle" data-width="60"   data-on="Enable" data-off="Disable"   data-size="small"<cfif updatetopo eq 'Y'>checked</cfif>>
                                 </div>
                            </div>  
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                  <div class="col-sm-4">Edit Of Transaction After Update</div>
                                  <div class="col-sm-2 col-xs-offset-1">
                                        <input name="enableedit" id="enableedit" type="checkbox" value="1" data-toggle="toggle" data-width="60"   data-on="Enable" data-off="Disable"   data-size="small" <cfif enableedit eq 'Y'>checked</cfif>>
                                  </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                 <div class="col-sm-4">PO to RC Use PO Currency Rate</div>
                                 <div class="col-sm-8">
                                 <input name="po_to_rc_currrate" id="po_to_rc_currrate" type="checkbox" data-width="60" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-size="small"<cfif po_to_rc_currrate eq 'Y'>checked</cfif>>
                                 </div>
                            </div>  
                        </div>
                    </div>
                </div>			
            </div>
            <!--- Mail Setup --->
            <div id="mailSetup" class="tab-pane fade">
                <h4><u>Approval</u></h4>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">PO update to RC Require Approval of Admins</div>
                                <div class="col-sm-8">
                                    <input name="poapproval" id="poapproval" type="checkbox" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60"   data-size="small"<cfif poapproval eq 'Y'>checked</cfif>>                                     
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Required Password for Print & Delete</div>
                                <div class="col-sm-8">
                                    <input name="RPED" id="RPED" type="checkbox" value="1" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif RPED eq 'Y'>checked</cfif>>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Printing of PO are only allowed after 2 level approval</div>
                                <div class="col-sm-8">
                                    <input name="printapprove" id="printapprove" type="checkbox" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60"  data-size="small"<cfif printapprove eq 'Y'>checked</cfif>>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">1st Level Approval</div>
                                <div class="col-sm-5 col-xs-offset-1 input-group">                                    
                                    	<select name="printapprovelevel1" id="printapprovelevel1" class="form-control">
                                            <cfloop query="getUserLevel">
                                                <option value="#getUserLevel.level#" <cfif getUserLevel.level eq printapprovelevel1>selected</cfif>>#getUserLevel.level#</option>
                                            </cfloop>
                                        </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>  
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Transaction below this amount only need 1 level of approval</div>
                                <div class="col-sm-5 col-xs-offset-1 input-group">   
                                    <input name="printapproveamt" id="printapproveamt" class="form-control"  type="text" value="#numberformat(printapproveamt,'_.__')#" validate="float" message="Please Enter a correct amount" maxlength="17">
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">2nd Level Approval</div>
                                <div class="col-sm-5 col-xs-offset-1 input-group">
                                	<select name="printapprovelevel2" id="printapprovelevel2" class="form-control">
                                        <cfloop query="getUserLevel">
                                            <option value="#getUserLevel.level#" <cfif getUserLevel.level eq printapprovelevel1>selected</cfif>>#getUserLevel.level#</option>
                                        </cfloop>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <hr>
                <h4><u> Mail Server Setup</u></h4>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Mail Server</div>
                                <div class="col-sm-5 col-xs-offset-1 input-group">   	
                                    <input type="text" name="mailserver" id="mailserver" class="form-control"  maxlength="200" size="50"  value="#mailserver#" /> 
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Mail Port</div>
                                <div class="col-sm-5 col-xs-offset-1 input-group">                               
                                    <input type="text" name="mailport" id="mailport" class="col-md-6 form-control"  maxlength="200" size="50"  value="#mailport#" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Mail User</div>
                                <div class="col-sm-5 col-xs-offset-1 input-group">   
                                    <input type="text" name="mailuser" d="mailuser" class="form-control" i maxlength="200" size="50"  value="#mailuser#" />
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Mail Pass</div>
                                <div class="col-sm-5 col-xs-offset-1 input-group">	  
                                    <input type="password" name="mailpassword" id="mailpassword" class="col-md-6 form-control" maxlength="200" size="50"  value="#mailpassword#" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>  
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Default Receiver Email Address</div>
                                <div class="col-sm-5 col-xs-offset-1 input-group">   
                                    <input type="text" name="dfemail" id="dfemail" class="form-control" maxlength="200" size="50"  value="#dfemail#" validate="email"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>        
            </div>              
            <div id="costing" class="tab-pane fade">
				<!--- Stock Value --->
                <h4 ><u> Stock Value </u></h4>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Prompt Zero or Minimum Stock</div>
                                    <div class="col-sm-8">                      
                                        <input name="prozero" id="prozero" type="checkbox" value="1" data-toggle="toggle" data-on="Enable" data-off="Disable" data-width="60"  data-size="small"<cfif prozero eq '1'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Negative Stock</div>
                                    <div class="col-sm-8">
                                        <input name="negstk" id="negstk" type="checkbox" value="1" data-toggle="toggle" data-width="60" data-on="Enable" data-off="Disable" data-size="small"<cfif negstk eq '1'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Display Cost Code During Transaction</div>
                                    <div class="col-sm-8">
                                        <input name="displaycostcode" id="displaycostcode" type="checkbox" data-width="60" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable"  data-size="small"<cfif displaycostcode eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Prompt Negative Available Qty</div>
                                    <div class="col-sm-8">
                                        <input name="proavailqty" id="proavailqty" type="checkbox" value="1" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60"  data-size="small"<cfif proavailqty eq '1'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Cost Code Formula</div>
                                    <div class="col-sm-5 col-xs-offset-1 input-group">
                                        <input name="costformula1" id="costformula1" class="col-sm-6 form-control "  placeholder="replace of 0-9" id="costformula1" type="text" value="#costformula1#" size="10" maxlength="10">
                                        <input name="costformula2" id="costformula2" class="col-sm-6 form-control" id="costformula2" type="text" value="#costformula2#" size="1" maxlength="1">
                                        <input name="costformula3" id="costformula3" class="col-sm-6 form-control" placeholder="replace of 0-9" id="costformula3" type="text" value="#costformula3#" size="10" maxlength="10">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>             
                </div> 
                <!--- Project and Location --->
                <div id="project" class="tab-pane fade">
                        <h4><u> Project </u></h4>
                   	<div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Automatic Create Project When SO is Created</div>
                                    <div class="col-sm-8">
                                        <input name="soautocreaproj" id="soautocreaproj" type="checkbox" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif soautocreaproj eq 'Y'>checked</cfif>>  
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4"> Remain Same Project With Previous Entry</div>
                                    <div class="col-sm-8">
                                        <input name="remainloc" id="remainloc" type="checkbox" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif remainloc eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                        </div>
                   	</div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Project & Job By Bill</div>
                                    <div class="col-sm-8">
                                        <input name="projectbybill" id="projectbybill" type="checkbox" value="1" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif projectbybill eq '1'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Project By Bill, Job By Item</div>
                                    <div class="col-sm-8">
                                        <input name="jobbyitem" id="jobbyitem" type="checkbox" value="1" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif jobbyitem eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Project Account Code Auto Assign</div>
                                    <div class="col-sm-8">
                                        <input name="PACAA" id="PACAA" type="checkbox" value="1" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif PACAA eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--- Agent Tab --->
                <div id="agent" class="tab-pane fade">
                    <h4><u> Agent </u></h4>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Multi Agent</div>
                                    <div class="col-sm-8">
                                        <input name="multiagent" id="multiagent" type="checkbox" value="1" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif multiagent eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Agent in transaction follow customer profile</div>
                                    <div class="col-sm-8">
                                        <input name="agentbycust" id="agentbycust" type="checkbox" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif agentbycust eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Assign User ID to Agent</div>
                                    <div class="col-sm-8">                                  
                                        <input name="agentuserid" id="agentuserid" type="checkbox" value="1" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif agentuserid eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Assign Multiple User ID to Agent</div>
                                    <div class="col-sm-8">
                                        <input name="agentlistuserid" id="agentlistuserid" type="checkbox" value="1" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif agentlistuserid eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Default Agent</div>
                                    <div class="col-sm-8">
										<select class="form-control" style="width:210" name="ddlagent" id="ddlagent">
											<option value="">Default Agent</option>
                                            <cfloop query ="getAgent">
												<option value="#agent#" <cfif #agent# eq #ddlagent#>selected</cfif>>#agent# - #desp#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div id="multiLoc" class="tab-pane fade">
                    <h4><u>Multi Location</u></h4>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="form-group">
                                <div class="col-sm-12">
                                <input name="multilocation" id="multilocation" type="checkbox" value="PO" data-toggle="toggle"   
                                                data-on="<i class='glyphicon glyphicon-ok-circle'></i> Purchase Order" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Purchase Order" data-width="150" data-size="small"<cfif ListFindNoCase(xmultilocation, "PO", ",") neq 0>checked</cfif>>
                                                             
                                    <input name="multilocation" id="multilocation" type="checkbox" value="RC" data-toggle="toggle"   
                                                data-on="<i class='glyphicon glyphicon-ok-circle'></i> Purchase Receive" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Purchase Receive" data-width="150" data-size="small"<cfif ListFindNoCase(xmultilocation, "RC", ",") neq 0>checked</cfif>>
                                                                                   
                                    <input name="multilocation" id="multilocation" type="checkbox" value="PR" data-toggle="toggle"   
                                                data-on="<i class='glyphicon glyphicon-ok-circle'></i> Purchase Return" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Purchase Return" data-width="150" data-size="small"<cfif ListFindNoCase(xmultilocation, "PR", ",") neq 0>checked</cfif>>
                                                       
                                     <input name="multilocation" id="multilocation" type="checkbox" value="QUO" data-toggle="toggle"   
                                                data-on="<i class='glyphicon glyphicon-ok-circle'></i> Quotation" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Quotation" data-width="150" data-size="small"<cfif ListFindNoCase(xmultilocation, "QUO", ",") neq 0>checked</cfif>>
                                                
                                     <input name="multilocation" id="multilocation" type="checkbox" value="SO" data-toggle="toggle"   
                                                data-on="<i class='glyphicon glyphicon-ok-circle'></i> Sales Order" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Sales Order" data-width="150" data-size="small"<cfif ListFindNoCase(xmultilocation, "SO", ",") neq 0>checked</cfif>>
                                                
                                     <input name="multilocation" id="multilocation" type="checkbox" value="DO" data-toggle="toggle"   
                                                data-on="<i class='glyphicon glyphicon-ok-circle'></i> Delivery Order" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Delivery Order" data-width="150" data-size="small"<cfif ListFindNoCase(xmultilocation, "DO", ",") neq 0>checked</cfif>>
                                     
                                     <input name="multilocation" id="multilocation" type="checkbox" value="INV" data-toggle="toggle"   
                                                data-on="<i class='glyphicon glyphicon-ok-circle'></i> Invoice" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Invoice" data-width="150" data-size="small"<cfif ListFindNoCase(xmultilocation, "INV", ",") neq 0>checked</cfif>>
                                                                                              
                                     <input name="multilocation" id="multilocation" type="checkbox" value="CS" data-toggle="toggle"   
                                                data-on="<i class='glyphicon glyphicon-ok-circle'></i> Cash Sales" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Cash Sales" data-width="150" data-size="small"<cfif ListFindNoCase(xmultilocation, "CS", ",") neq 0>checked</cfif>>
                                     
                                     <input name="multilocation" id="multilocation" type="checkbox" value="CN" data-toggle="toggle"   
                                                data-on="<i class='glyphicon glyphicon-ok-circle'></i> Credit Note" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Credit Note" data-width="150" data-size="small"<cfif ListFindNoCase(xmultilocation, "CN", ",") neq 0>checked</cfif>>
                                                
                                     <input name="multilocation" id="multilocation" type="checkbox" value="DN" data-toggle="toggle"   
                                                data-on="<i class='glyphicon glyphicon-ok-circle'></i> Debit Note" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Debit Note" data-width="150" data-size="small"<cfif ListFindNoCase(xmultilocation, "DN", ",") neq 0>checked</cfif>>
                                                
                                     <input name="multilocation" id="multilocation" type="checkbox" value="ISS" data-toggle="toggle"   
                                                data-on="<i class='glyphicon glyphicon-ok-circle'></i> Issue" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Issue" data-width="150" data-size="small"<cfif ListFindNoCase(xmultilocation, "ISS", ",") neq 0>checked</cfif>>
                                                
                                     <input name="multilocation" id="multilocation" type="checkbox" value="OAI" data-toggle="toggle"   
                                                data-on="<i class='glyphicon glyphicon-ok-circle'></i> Adjustment Increase" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Adjustment Increase" data-width="150" data-size="small"<cfif ListFindNoCase(xmultilocation, "OAI", ",") neq 0>checked</cfif>>
                                                							
                                     <input name="multilocation" id="multilocation" type="checkbox" value="OAR" data-toggle="toggle"   
                                                data-on="<i class='glyphicon glyphicon-ok-circle'></i> Adjustment Reduce" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Adjustment Reduce" data-width="150" data-size="small"<cfif ListFindNoCase(xmultilocation, "OAR", ",") neq 0>checked</cfif>>
                                                
                                     <input name="multilocation" id="multilocation" type="checkbox" value="SAM" data-toggle="toggle"   
                                                data-on="<i class='glyphicon glyphicon-ok-circle'></i> Sample" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Sample" data-width="150" data-size="small"<cfif ListFindNoCase(xmultilocation, "SAM", ",") neq 0>checked</cfif>>
                                </div>
                            </div>
                        </div>
                    </div>
	                <h4 ><u> Location </u></h4>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Only Show Location Wtih Qty</div>
                                    <div class="col-sm-8">
                                        <input name="locationwithqty" id="locationwithqty" type="checkbox" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small" <cfif locationwithqty eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Follow First Item Location</div>
                                    <div class="col-sm-8">
                                        <input name="followlocation" id="followlocation" type="checkbox" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif followlocation eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>
                        <div class="row" align="center">
                            <div class="col-sm-12 checkbox">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <div class="col-sm-4">Location Bond With Customer/Supplier</div>
                                        <div class="col-sm-8">
                                            <input name="locarap" id="locarap" type="checkbox" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif locarap eq 'Y'>checked</cfif>>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>
                
                <div id="BOM" class="tab-pane fade">
                    <hr>
                    <h4><u> BOM </u></h4>                
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Advance BOM</div>
                                    <div class="col-sm-8">
                                        <input name="advancebom" id="advancebom" type="checkbox" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif advancebom eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Auto Generate BOM if quantity reach 0</div>
                                    <div class="col-sm-8">
                                        <input name="autobom" id="autobom" type="checkbox" value="Y" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif autobom eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>                         
                </div>

				<div id="more" class="tab-pane fade">
                    <h4><u>More</u></h4>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Default Term</div>
                                    <div class="col-sm-5 col-xs-offset-1 input-group">
                                        <select class="form-control" style="width:210" name="ddlterm" id="ddlterm">
                                            <option value="">Default Term</option>
                                            <cfloop query ="getTerm">
                                            	<option value="#term#" <cfif #term# eq #ddlterm#>selected</cfif>>#term# - #desp#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                     <div class="col-sm-4">Transfer Value</div>
                                     <div class="col-sm-5 col-xs-offset-1 input-group">
                                        <select class="form-control" style="width:210" name="df_trprice" id="df_trprice">
                                            <option value="cost">Cost</option>
                                            <option value="Price" <cfif #df_trprice# eq 'price'>selected</cfif>>Price</option>
                                          </select>
                                     </div>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                     <div class="col-sm-4">Default NON-GST Customer</div>
                                     <div class="col-sm-8">
                                        <input name="defaultNONGSTcustomer" id="defaultNONGSTcustomer" type="checkbox" value="1"data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif defaultNONGSTcustomer eq 'Y'>checked</cfif>>     
                                     </div>
                                </div>
                            </div>
                        </div>
					</div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                     <div class="col-sm-4">Default Assign End User In Transaction</div>
                                     <div class="col-sm-8">
                                        <input name="defaultEndUser" id="defaultEndUser" type="checkbox" value="1" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif defaultEndUser eq '1'>checked</cfif>> 
                                     </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                     <div class="col-sm-4">Choose Item For Quotation When Update Into Others</div>
                                     <div class="col-sm-8">
                                        <input name="quoChooseItem" id="quoChooseItem" type="checkbox" value="1" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif quoChooseItem eq '1'>checked</cfif>>
                                     </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                     <div class="col-sm-4">Automatic Set Address Code to Profile</div>
                                     <div class="col-sm-8">
                                        <input name="ASACTP" id="ASACTP" type="checkbox" value="1" data-toggle="toggle" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif ASACTP eq 'Y'>checked</cfif>>
                                     </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                     <div class="col-sm-4">Automatic Set Delivery Address</div>
                                     <div class="col-sm-8">
                                        <input name="ASDA" id="ASDA" type="checkbox" value="1" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif ASDA eq 'Y'>checked</cfif>>
                                     </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                     <div class="col-sm-4">Insert Batch Code for Quotation,PO and SO</div>
                                     <div class="col-sm-8">
                                        <input name="quobatch" id="quobatch" type="checkbox" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif quobatch eq "Y">checked</cfif>>
                                     </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                     <div class="col-sm-4">SO Material</div>
                                     <div class="col-sm-8">
                                        <input name="projectcompany" id="projectcompany" type="checkbox" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif projectcompany eq "Y">checked</cfif>>
                                     </div>
                                </div>
                            </div>
                        </div>
                    </div> 
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Deduct SO for Balance On Hand</div>
                                    <div class="col-sm-8">
                                        <input name="deductso" id="deductso" type="checkbox" value="Y"  data-toggle="toggle"   data-on="Enable" data-width="60" data-off="Disable"  data-size="small"<cfif deductso eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Auto Set Recommended Price</div>
                                    <div class="col-sm-8">
                                        <input name="recompriceup" id="recompriceup" type="checkbox" value="1" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif recompriceup eq 'Y'>checked</cfif>>
                                    </div>
                                    <div id="showList2" class="showList2 col-sm-6"<cfif recompriceup NEQ '1'>style="display:none"</cfif>>
                                        <input name="recomQUO" id="recomQUO" type="checkbox" value="Y" data-toggle="toggle" data-width="60"  data-style="ios"  data-on="<i class='glyphicon glyphicon-ok-circle'></i> QUO" data-off="<i class='glyphicon glyphicon-ban-circle'></i> QUO"   data-size="mini">	
                                        <input name="recomSO" id="recomSO" type="checkbox" value="Y" data-toggle="toggle" data-width="60" data-style="ios"  data-on="<i class='glyphicon glyphicon-ok-circle'></i> SO" data-off="<i class='glyphicon glyphicon-ban-circle'></i> SO"   data-size="mini">	
                                        <input name="recomDO" id="recomDO" type="checkbox" value="Y" data-toggle="toggle" data-width="60" data-style="ios"   data-on="<i class='glyphicon glyphicon-ok-circle'></i> DO" data-off="<i class='glyphicon glyphicon-ban-circle'></i> DO"   data-size="mini">	
                                        <input name="recomINV" id="recomINV" type="checkbox" value="Y" data-toggle="toggle" data-width="60" data-style="ios"  data-on="<i class='glyphicon glyphicon-ok-circle'></i> INV" data-off="<i class='glyphicon glyphicon-ban-circle'></i> INV"   data-size="mini">	
                                        <input name="recomCS" id="recomCS" type="checkbox" value="Y" data-toggle="toggle" data-width="60" data-style="ios"  data-on="<i class='glyphicon glyphicon-ok-circle'></i> CS" data-off="<i class='glyphicon glyphicon-ban-circle'></i> CS"   data-size="mini">	
                                        <input name="recomCN" id="recomCN" type="checkbox" value="Y" data-toggle="toggle" data-width="60" data-style="ios"  data-on="<i class='glyphicon glyphicon-ok-circle'></i> CN" data-off="<i class='glyphicon glyphicon-ban-circle'></i> CN"   data-size="mini">
                                        <input name="recomDN" id="recomDN" type="checkbox" value="Y" data-toggle="toggle" data-width="60" data-style="ios"  data-on="<i class='glyphicon glyphicon-ok-circle'></i> DN" data-off="<i class='glyphicon glyphicon-ban-circle'></i> DN"   data-size="mini">
                                        <input name="recomDP" id="recomDP" type="checkbox" value="Y" data-toggle="toggle" data-width="60" data-style="ios"   data-on="<i class='glyphicon glyphicon-ok-circle'></i> DP" data-off="<i class='glyphicon glyphicon-ban-circle'></i> DP"   data-size="mini">	
                                    </div>  
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Add on Remark</div>
                                    <div class="col-sm-8">
                                        <input name="addonremark" id="addonremark" type="checkbox" value="1" data-toggle="toggle"   data-on="Enable" data-width="60" data-off="Disable"  data-size="small"<cfif addonremark eq 'Y'>checked</cfif>>
                
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Collection Address</div>
                                    <div class="col-sm-8"> 	
                                        <input name="collectaddress" id="collectaddress" type="checkbox" value="1" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif collectaddress eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Quotation Prefix by Customer</div>

                                    <div class="col-sm-8">
                                        <input name="prefixbycustquo" id="prefixbycustquo" type="checkbox" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif prefixbycustquo eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Sales Order Prefix by Customer</div>
                                    <div class="col-sm-8">
                                        <input name="prefixbycustso" id="prefixbycustso" type="checkbox" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif prefixbycustso eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Invoice Prefix by Customer</div>
                                    <div class="col-sm-8">
                                        <input name="prefixbycustinv" id="prefixbycustinv" type="checkbox" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif prefixbycustinv eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Simple Transaction Include Multi Add Item Function</div>
                                    <div class="col-sm-8">
                                        <input name="expressmultiitem" id="expressmultiitem" type="checkbox" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif expressmultiitem eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">Show Service part & Cost</div>
                                    <div class="col-sm-8">
                                        <input name="showservicepart" id="showservicepart" type="checkbox" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif showservicepart eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <div class="col-sm-4">History Price in Transaction Base on Invoice/PO base on RC</div>
                                    <div class="col-sm-8">
                                        <input name="histpriceinv" id="histpriceinv" type="checkbox" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif histpriceinv eq 'Y'>checked</cfif>>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                    <h4 ><u> Search </u></h4>
                	<div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                     <div class="col-sm-4">Select Item Code By Filter</div>
                                     <div class="col-sm-8">
        								<input name="filteritem" id="filteritem" type="checkbox" value="1" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif filteritem eq '1'>checked</cfif>>
                                     </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                     <div class="col-sm-4">Select Item Code By Ajax List</div>

                                     <div class="col-sm-8">
        								<input name="filteritemAJAX" id="filteritemAJAX" type="checkbox" value="1" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif filteritemAJAX eq '1'>checked</cfif>>
                                     </div>
                                </div>
                            </div>
                        </div>             
                    </div>
                    <div class="row" align="center">
                        <div class="col-sm-12 checkbox">
                            <div class="col-sm-6">
                                <div class="form-group">
                                     <div class="col-sm-4">Select Product, Category, Group,Supplier/Customer By Filter</div>
                                     <div class="col-sm-8">
        								<input name="filterall" id="filterall" type="checkbox" value="1" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif filterall eq '1'>checked</cfif>>
                                     </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                     <div class="col-sm-4">Show Supplier/Customer in Drop Down Selection List</div>

                                     <div class="col-sm-8">
        								<input name="suppcustdropdown" id="suppcustdropdown" type="checkbox" value="1" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif suppcustdropdown eq '1'>checked</cfif>>
                                     </div>
                                </div>
                            </div>
                        </div>             
                    </div>
                </div>
                                
                
                
                <!--- ** Below is yet to be sorted ** --->
              
			<div id="posting" class="tab-pane fade">
              	<h4 ><u> Posting </u></h4>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Post Tax Seperately Based On A/C Code</div>
                                <div class="col-sm-8">
                                    <input name="PPTS" id="PPTS" type="checkbox" value="1" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif PPTS eq 'Y'>checked</cfif>>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Automatic Posting Check When Post</div>
                                <div class="col-sm-8">     	
                                    <input name="APCWP" id="APCWP" type="checkbox" value="1" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif APCWP eq 'Y'>checked</cfif>>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" align="center">
                    <div class="col-sm-12 checkbox">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Post Payment With Knockoff Features</div>
                                <div class="col-sm-8">
                                    <input name="PPWKOF" id="PPWKOF" type="checkbox" value="1" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif PPWKOF eq 'Y'>checked</cfif>>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <div class="col-sm-4">Post Without Divide Project & Job</div>
                                <div class="col-sm-8">                                     	 
                                    <input name="PNOPROJECT" id="PNOPROJECT" type="checkbox" value="1" data-toggle="toggle"   data-on="Enable" data-off="Disable" data-width="60" data-size="small"<cfif PNOPROJECT eq 'Y'>checked</cfif>>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                    <div class="row" align="center">
                    	<div class="col-sm-12 checkbox">
                        	<div class="col-sm-6">
                            	<div class="form-group">
                                	<div class="col-sm-12" style="margin:5">
                                             <div class="col-sm-4">Description</div>
                                             <div class="col-sm-8">
                                                <input type="radio" name="postvalue" id="postvalue" class="form-control" value="desp"<cfif postvalue eq 'desp'>checked</cfif>>
                                             </div>
                                     </div>
                                     <div class="col-sm-12" style="margin:5">
                                     		<div class="col-sm-4">PONO</div>
                                            <div class="col-sm-8">
                                            	<input type="radio" name="postvalue" id="postvalue" class="form-control" value="pono"<cfif postvalue eq 'pono'>checked</cfif>>
                                            </div>
                                     </div>
                            	</div>
                            </div>
                            <div class="col-sm-6">
                            	<div class="form-group">
                                     <div class="col-sm-4">Edit Posted Bills</div>
                                     <div class="col-sm-8">      
        									<input name="alloweditposted" id="alloweditposted" type="checkbox" value="Y"data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif alloweditposted eq 'Y'>checked</cfif>>
                                     </div>
     							</div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                    	<div class="col-sm-12 checkbox">
                        	<div class="col-sm-6">
                            	<div class="form-group">
                                	 <div class="col-sm-4">Periodic Posting</div>
                                     <div class="col-sm-8">  
        									<input name="periodficposting" id="periodficposting" type="checkbox" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif periodficposting eq 'Y'>checked</cfif>>
                                     </div>
                            	</div>
                            </div>
                            <div class="col-sm-6">
                            	<div class="form-group">
                                     <div class="col-sm-4">Post Cash Sales into debtor account</div>
                                     <div class="col-sm-8">
        									<input name="postcsdebtor" id="postcsdebtor" type="checkbox" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif postcsdebtor eq 'Y'>checked</cfif>>
                                     </div>
     							</div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                    	<div class="col-sm-12 checkbox">
                        	<div class="col-sm-6">
                            	<div class="form-group">
                                     <div class="col-sm-4">Post Deposit into same debtor account</div>
                                     <div class="col-sm-8">
       										<input name="postdepdebtor" id="postdepdebtor" type="checkbox" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif postdepdebtor eq 'Y'>checked</cfif>>
                                     </div>
                            	</div>
                            </div>
                            <div class="col-sm-6">
                            	<div class="form-group">
                                     <div class="col-sm-4">Post RC 2nd Refno to Refno</div>

                                     <div class="col-sm-8">
        									<input name="postingRCRefno" id="postingRCRefno" type="checkbox" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif postingRCRefno eq 'Y'>checked</cfif>>
                                     </div>
     							</div>
                            </div>
                        </div>
                    </div>
              	</div> 
              	<div id="agent" class="tab-pane fade">
                    <h4 ><u> Default Value </u></h4>
                    <div class="row" align="center">
                    	<div class="col-sm-12 checkbox">
                        	<div class="col-sm-6">
                            	<div class="form-group">
                                     <div class="col-sm-4">Bill Type Default</div>
                                     <div class="col-sm-8">
                                        <select class="form-control" style="width:210" name="ddlbilltype" id="ddlbilltype">
                                            <cfloop list ="INV,QUO,SO,CS,PO,DO,RC,PR,CN,DN" index="i">
                                              <option value="#i#"  <cfif #i# eq #ddlbilltype#>selected</cfif>>#i#</option>
                                            </cfloop>
                                        </select>
                                     </div>
                            	</div>
                            </div>
                            <!---<div class="col-sm-6">
                            	<div class="form-group">
                                     <div class="col-sm-4">Cash Sales Default Customer</div>
                                     <div class="col-sm-2 col-xs-offset-1">
                                        <cfquery name="getcustno" datasource="#dts#">
                                            SELECT custno,name 
                                            FROM #target_arcust# 
                                            ORDER BY custno
                                        </cfquery>
                                        <select class="form-control" style="width:210" name="df_cs_cust">
                                            	<option value="">Please select a location to set as default</option>
                                            <cfloop query ="getcustno">
                                              	<option value="#custno#" <cfif #custno# eq #getGeneralInfo.df_cs_cust#>selected</cfif>>#custno# - #name#</option>
                                            </cfloop>
                                        </select>
                                     </div>
     							</div>
                            </div>--->
                        </div>
                    </div>
                    <div class="row" align="center">
                    	<div class="col-sm-12 checkbox">
                        	<div class="col-sm-6">
                            	<div class="form-group">
                                     <div class="col-sm-4">Search Customer Default</div>
                                     <div class="col-sm-8">
                                        <select class="form-control" style="width:210" name="ddlcust">
                                            <cfloop list ="Customer ID,Customer Name,Agent,Customer Tel,Left Name,Company UEN" index="i">
                                            	<option value="#i#"  <cfif #i# eq #ddlcust#>selected</cfif>>#i#</option>
                                            </cfloop>
                                        </select>
                                     </div>
                            	</div>
                            </div>
                            <div class="col-sm-6">
                            	<div class="form-group">
                                     <div class="col-sm-4">Search Supplier Default</div>
                                     <div class="col-sm-2 col-xs-offset-1">
                                        <select class="form-control" style="width:210" name="ddlsupp">
                                            <cfloop list ="Supplier ID,Supplier Name,Agent,Supplier Tel,Left Name,Company UEN" index="i">
                                              <option value="#i#"  <cfif #i# eq #ddlsupp#>selected</cfif>>#i#</option>
                                            </cfloop>
                                        </select>
                                     </div>
     							</div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                    	<div class="col-sm-12 checkbox">
                        	<div class="col-sm-6">
                            	<div class="form-group">
                                     <div class="col-sm-4">Search Transaction Default</div>
                                     <div class="col-sm-8">
                                        <select class="form-control" style="width:210" name="ddltran">
                                            <cfloop list ="Refno,Refno2,Supplier/Customer ID,Supplier/Customer Name,Agent,Period,Phone,Date,Left Name,created_by" index="i">
                                            	<option value="#i#" <cfif #i# eq #ddltran#>selected</cfif>>#i#</option>
                                            </cfloop>
                                        </select>
                                     </div>
                            	</div>
                            </div>
                            <div class="col-sm-6">
                            	<div class="form-group">
                                     <div class="col-sm-4">Search Item Default</div>
                                     <div class="col-sm-2 col-xs-offset-1">
                                        <select class="form-control" style="width:210" name="ddlitem">
                                            <cfloop list="Item No,Product Code,Brand,Description,Category,Size,Rating,Material,Group,Model,All" index="i">
                                            	<option value="#i#" <cfif #i# eq #ddlitem#>selected</cfif>>#i#</option>
                                            </cfloop>
                                        </select>
                                     </div>
     							</div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                    	<div class="col-sm-12 checkbox">
                        	<div class="col-sm-6">
                            	<div class="form-group">
                                     <div class="col-sm-4">Location Default</div>
                                     <div class="col-sm-8">
                                        <select class="form-control" style="width:210" name="ddllocation">
                                            <option value="">Default Location</option>
                                            <cfloop query ="getLocation">
                                                <option value="#location#" <cfif #location# eq #ddllocation#>selected</cfif>>#location# - #desp#</option>
                                            </cfloop>
                                        </select>
                                     </div>
                            	</div>
                            </div>
                        </div>
                    </div>
              	</div>
              	<div id="method" class="tab-pane fade">
              	<h4 ><u> Costing Method </u></h4>
                	<div class="row" align="center">
                    	<div class="col-sm-12 checkbox">
                        	<div class="col-sm-6">
                            	<div class="form-group">
                                	<div class="col-sm-12" style="margin:5">
                                         <div class="col-sm-4">Fixed Cost</div>
                                         <div class="col-sm-8">
                                            <input type="radio" name="cost" id="cost" class="form-control" value="fixed"<cfif cost eq "FIXED">checked</cfif>>
                                         </div>
                                     </div>
                                     <div class="col-sm-12" style="margin:5">
                                         <div class="col-sm-4">Month Average</div>
                                         <div class="col-sm-8">
                                            <input type="radio" name="cost" id="cost" class="form-control" value="month"<cfif cost eq "MONTH">checked</cfif>>
                                         </div>
                                     </div>
                                     <div class="col-sm-12" style="margin:5">
                                         <div class="col-sm-4">Moving Average</div>
                                     	 <div class="col-sm-8">
       										 <input type="radio" name="cost" id="cost" class="form-control" value="moving"<cfif cost eq "MOVING">checked</cfif>>
                                     	 </div>
                                     </div>
                                     <div class="col-sm-12" style="margin:5">                                    	
                                         <div class="col-sm-4">Weighted Average</div>
                                         <div class="col-sm-8">
                                         <input type="radio" name="cost" id="cost" class="form-control" value="weight"<cfif cost eq "WEIGHT">checked</cfif>>
                                         </div>
                                     </div>
                                     <div class="col-sm-12" style="margin:5">                               
                                         <div class="col-sm-4">First In First Out (FIFO)</div>
                                         <div class="col-sm-8">
                                            <input type="radio" name="cost" id="cost" class="form-control" value="fifo"<cfif cost eq "FIFO">checked</cfif>>
                                         </div>
                                     </div>
                                     <div class="col-sm-12" style="margin:5">
                                         <div class="col-sm-4">Last In First Out (LIFO)</div>
                                     	 <div class="col-sm-8">
       										<input type="radio" name="cost" id="cost" class="form-control" value="lifo"<cfif cost eq "LIFO">checked</cfif>>
                                     	 </div>
                                     </div>   
                            	</div>
                            </div>
                            <div class="col-sm-6">
                                 <div class="form-group">
                                     <div class="col-sm-12">
                                         <div class="col-sm-4">Miscellaneous Cost In Costing</div>
                                         <div class="col-sm-8"> 
                                                <input name="includemisc" id="includemisc" type="checkbox" value="1" data-toggle="toggle" data-width="60"  data-on="Include" data-off="Exclude"  data-size="small"<cfif includemisc eq '1'>checked</cfif>>
                                         </div>
                                     </div>
     							</div>
                                <div id="fifoCalculation">
                                    <div class="form-group">
                                    	<div class="col-sm-12 padding-top">
                                            <div class="col-sm-4">Item Status and Value FIFO Calculation</div>
                                            <div class="col-sm-5 col-xs-offset-1 input-group">
                                                <select class="form-control" style="width:210" name="fifocal" id="fifocal">
                                                    <option value="1" <cfif fifocal eq "1">selected </cfif>>Qty x Currrate x Price</option>
                                                    <option value="2" <cfif fifocal eq "2">selected </cfif>>Amt / TotalQty x Qty</option>
                                                </select>
                                            </div>
                                       	</div>
                                    </div>       
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" align="center">
                    	<div class="col-sm-12 checkbox">
                        	<div class="col-sm-6">
                            	<div class="form-group">
                                     
                            	</div>
                            </div>
                            <div class="col-sm-6">
                            	<div class="form-group">
                                     <div class="col-sm-4"></div>
                                     <div class="col-sm-2 col-xs-offset-1">                                  	
        								
                                     </div>
     							</div>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <h4 ><u> Costing contributed Type </u></h4>
                    <div class="row" align="center">
                    	<div class="col-sm-12 checkbox">
                        	<div class="col-sm-6">
                            	<div class="form-group">
                                     <div class="col-sm-4">CN</div>
                                     <div class="col-sm-8">
        								<input type="checkbox" name="costingCN" id="costingCN" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif costingCN eq "Y">checked</cfif>>                                     
                                     </div>
                            	</div>
                                <div class="form-group">
                                    <div class="col-sm-4">CN Item Value</div>
                                    <div class="col-sm-8"> 
                                    	<input name="CNbaseonprice" id="CNbaseonprice" type="checkbox" value="1" data-style="ios" data-onstyle="success" data-offstyle="info" data-toggle="toggle" data-width="60"  data-on="Price" data-off="Cost" data-size="small"<cfif CNbaseonprice eq '1'>checked</cfif>>
                                    </div>
                                    
								</div>
                            </div>
                            <div class="col-sm-6">
                            	<div class="form-group">
                                     <div class="col-sm-4">OAI</div>
                                     <div class="col-sm-8">
        								<input type="checkbox" name="costingOAI" id="costingOAI" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif costingOAI eq "Y">checked</cfif>>

                                     </div>
     							</div>
                            </div>
                        </div>
                    </div>
                  </div>
                  <div id="numberStyle" class="tab-pane fade">
                    <!---<h4 ><u> Number Style</u></h4>--->
                    <div class="row" align="center">
                    	<div class="col-sm-12 checkbox">
                        	<div class="col-sm-6">
                            	<div class="form-group">
                                     <div class="col-sm-4">Customer Number Style</div>
                                     <div class="col-sm-8">
                                     	<div class="col-sm-12" style="margin:5">
                                     		<div class="col-sm-2 col-xs-offset-1">xxxx/xxx</div>
        									<input name="custSuppNo" id="custSuppNo" type="radio" value="1" <cfif custSuppNo eq "1">checked</cfif>>
     									</div>
                                        <div class="col-sm-12" style="margin:5">
                                        	<div class="col-sm-2 col-xs-offset-1">xxxxxxx</div>
                                        	<input name="custSuppNo" id="custSuppNo" type="radio" value="2" <cfif custSuppNo eq "2">checked</cfif>>
                                     	</div>
                                     </div>
                            	</div>
                            </div>
                            <div class="col-sm-6">
                            	<div class="form-group">
                                     <div class="col-sm-4">Supplier Number Style</div>
                                     <div class="col-sm-8">
                                     	<div class="col-sm-12" style="margin:5">
                                     		<div class="col-sm-2 col-xs-offset-1">xxxx/xxx</div>
        									<input name="SuppNo" id="SuppNo" type="radio" value="1" <cfif SuppNo eq "1">checked</cfif>>
     									</div>
                                        <div class="col-sm-12" style="margin:5">
                                        	<div class="col-sm-2 col-xs-offset-1">xxxxxxx</div>
                                        	<input name="SuppNo" id="SuppNo" type="radio" value="2" <cfif SuppNo eq "2">checked</cfif>>      
                                     	</div>
                                     </div>
     							</div>
                            </div>
                        </div>
                  	</div>
             	</div>
             	<div id="other" class="tab-pane fade">
              	<!---<h4><u></u></h4>---> 
                	<div class="row" align="center">
                    	<div class="col-sm-12 checkbox">
                        	<div class="input-group">
                        		<div class="form-group">
                                    <div class="col-sm-2 ">Only one set of Reference Number</div>  
                                    	<div class="col-sm-10">
                                    		<div class="input-group">
                                            <input name="po_oneset" id="po_oneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Purchase Order" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Purchase Order" data-width="150" data-size="small"<cfif po_oneset eq '1'>checked</cfif>>
                                                    
                                            <input name="rc_oneset" id="rc_oneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Purchase Receive" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Purchase Receive" data-width="150" data-size="small"<cfif rc_oneset eq '1'>checked</cfif>>
                                            
                                            <input name="pr_oneset" id="pr_oneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Purchase Return" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Purchase Return" data-width="150" data-size="small"<cfif pr_oneset eq '1'>checked</cfif>>
                                                    
                                            <input name="rq_oneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Purchase Requisition" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Purchase Requisition" data-width="150" data-size="small"<cfif rq_oneset eq '1'>checked</cfif>>
                                            
                                         	<input name="quo_oneset" id="quo_oneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Quotation" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Quotation" data-width="150" data-size="small"<cfif quo_oneset eq '1'>checked</cfif>>
                                                    
                                            <input name="so_oneset" id="so_oneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Sales Order" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Sales Order" data-width="150" data-size="small"<cfif so_oneset eq '1'>checked</cfif>>
                                                    
                                            <input name="do_oneset" id="do_oneset" type="checkbox" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Delivery Order" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Delivery Order" data-width="150" data-size="small"<cfif do_oneset eq '1'>checked</cfif>>
                                                  
                                            <input name="invoneset" id="invoneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Invoice" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Invoice" data-width="150" data-size="small"<cfif invoneset eq '1'>checked</cfif>>
                                                                                             
          									<input name="cs_oneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Cash Sales" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Cash Sales" data-width="150" data-size="small"<cfif cs_oneset eq '1'>checked</cfif>>
        											
          									<input name="cn_oneset" id="cn_oneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Credit Note" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Credit Note" data-width="150" data-size="small"<cfif cn_oneset eq '1'>checked</cfif>>
                       								
          									<input name="dn_oneset" id="dn_oneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Debit Note" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Debit Note" data-width="150" data-size="small"<cfif dn_oneset eq '1'>checked</cfif>>
        											                                      
          								    <input name="iss_oneset" id="iss_oneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Issue" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Issue" data-width="150" data-size="small"<cfif iss_oneset eq '1'>checked</cfif>>
                                                    
                                            
                  							<input name="oai_oneset" id="oai_oneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Adjustment Increase" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Adjustment Increase" data-width="150" data-size="small"<cfif oai_oneset eq '1'>checked</cfif>>
                									 
                  							<input name="oar_oneset" id="oar_oneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Adjustment Reduce" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Adjustment Reduce" data-width="150" data-size="small"<cfif oar_oneset eq '1'>checked</cfif>>
        												
                 							<input name="assm_oneset" id="assm_oneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                     data-on="<i class='glyphicon glyphicon-ok-circle'></i> Assembly" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Assembly" data-width="150" data-size="small"<cfif assm_oneset eq '1'>checked</cfif>>
              										
                  							<input name="tr_oneset" id="tr_oneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Transfer" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Transfer" data-width="150" data-size="small"<cfif tr_oneset eq '1'>checked</cfif>>
               										      
          									<input name="sam_oneset" id="sam_oneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Sample" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Sample" data-width="150" data-size="small"<cfif sam_oneset eq '1'>checked</cfif>>
        											
        <cfif isdefined("ct_oneset")>
         
            										<input name="ct_oneset" id="ct_oneset" type="checkbox" class="spacing-toggle" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Consignment Note" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Consignment Note" data-width="150" data-size="small"<cfif ct_oneset eq '1'>checked</cfif>>
          											
        </cfif>							
      									</div>
                                    </div>
                           		</div>
                            </div>
                        </div>
                	</div>
                	<hr> 
                	<div class="row" align="center">
                    	<div class="col-sm-12 checkbox">
                        	<div class="input-group">
                                <div class="col-sm-2 ">Only one set of Reference Number 2</div>
                                <div class="col-sm-10">
                                	<input name="refno2PO" id="refno2PO" type="checkbox" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Purchase Order " data-off="<i class='glyphicon glyphicon-ban-circle'></i> Purchase Order" data-width="150" data-size="small"<cfif refno2PO eq '1'>checked</cfif>>
                                    
                                    <input name="refno2RC" id="refno2RC" type="checkbox" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Purchase Receive" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Purchase Receive" data-width="150" data-size="small"<cfif refno2RC eq '1'>checked</cfif>>
                                                    
                                    <input name="refno2PR" id="refno2PR" type="checkbox" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Purchase Return" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Purchase Return" data-width="150" data-size="small"<cfif refno2PR eq '1'>checked</cfif>>
                                                                   						
              						<input name="refno2QUO" id="refno2QUO" type="checkbox" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Quotation" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Quotation" data-width="150" data-size="small"<cfif refno2QUO eq '1'>checked</cfif>>
                                                                 
              						<input name="refno2SO" id="refno2SO" type="checkbox" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Sales Order" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Sales Order" data-width="150" data-size="small"<cfif refno2SO eq '1'>checked</cfif>>
                       
             						<input name="refno2DO" id="refno2DO" type="checkbox" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Delivery Order" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Delivery Order" data-width="150" data-size="small"<cfif refno2DO eq '1'>checked</cfif>>
                
                					<input name="refno2inv" id="refno2inv" type="checkbox" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Invoice" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Invoice" data-width="150" data-size="small"<cfif refno2inv eq '1'>checked</cfif>>
                                    
              						<input name="refno2CS" id="refno2CS" type="checkbox" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Cash Sales" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Cash Sales" data-width="150" data-size="small"<cfif refno2CS eq '1'>checked</cfif>>
                
          
              						<input name="refno2CN" id="refno2CN" type="checkbox" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Credit Note" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Credit Note" data-width="150" data-size="small"<cfif refno2CN eq '1'>checked</cfif>>
               
              						<input name="refno2DN" id="refno2DN" type="checkbox" value="1" data-toggle="toggle"   
                                                    data-on="<i class='glyphicon glyphicon-ok-circle'></i> Debit Note" data-off="<i class='glyphicon glyphicon-ban-circle'></i> Debit Note" data-width="150" data-size="small"<cfif refno2DN eq '1'>checked</cfif>>
                 
                 				</div>
                			</div>
                        </div>
                	</div>
             	</div>
            <!--- Report tab --->             
            	<div id="report" class="tab-pane fade">
                	<div class="row" align="center">
                    	<div class="col-sm-12 checkbox">
                        	<div class="col-sm-6">
                            	<div class="form-group">
                                	 <div class="col-sm-4">Only allow single location in location report</div>
                                 	<div class="col-sm-8">
                                        <input name="singlelocation" id="singlelocation" type="checkbox" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif singlelocation eq 'Y'>checked</cfif>>                                     
                                 	</div>
                            	</div>
                        	</div>
                        	<div class="col-sm-6">
                            	<div class="form-group">
                                 	<div class="col-sm-4">Select Item Code By Filter</div>
                                 	<div class="col-sm-8">
                                    	<input name="filteritemreport" id="filteritemreport" type="checkbox" value="1" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif filteritemreport eq '1'>checked</cfif>>
                                 	</div>
                            	</div>
                        	</div>
                    	</div>
                	</div>
                	<div class="row" align="center">
                    	<div class="col-sm-12 checkbox">
                        	<div class="col-sm-6">
                            	<div class="form-group">
                                 	<div class="col-sm-4">Sales Report - Agent from customer profile</div>
                                 	<div class="col-sm-8">
                                    	<input name="reportagentfromcust" id="reportagentfromcust" type="checkbox" value="1" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif reportagentfromcust eq '1'>checked</cfif>>
                                 	</div>
                            	</div>
                        	</div>
                            <div class="col-sm-6">
                        		<div class="form-group">
                            		<div class="col-sm-4">Auto Pop out Oustanding So report when login</div>
                                	<div class="col-sm-8">
                            		<input name="autooutstandingreport" id="autooutstandingreport" type="checkbox" value="Y" data-toggle="toggle" data-width="60"  data-on="Enable" data-off="Disable"  data-size="small"<cfif autooutstandingreport eq 'Y'>checked</cfif>>
                            		</div>
                        		</div>
                    		</div>
                    	</div>
                	</div>
                </div>
            	<!--- POS tab --->
            	<div id="pos" class="tab-pane fade">
                	<div class="row" align="center">
                    	<div class="col-sm-12 checkbox">
                        	<div class="col-sm-6">
                           		<div class="form-group">
                               		<div class="col-sm-4">Required amount to get 1 Member Point</div>
                               		<div class="col-sm-5 col-xs-offset-1 input-group">
                                       	<input type="text" name="memberpointamt" id="memberpointamt" class="col-sm-6 col-sm-offset-2 form-control" value="#memberpointamt#">
                                 	</div>
                            	</div>
                        	</div>
                        	<div class="col-sm-6">
                           		<div class="form-group">
                               		<div class="col-sm-4">Default Member Price Level</div>
                               		<div class="col-sm-5 col-xs-offset-1 input-group">
                                     	<select class="form-control" name="df_mem_price" id="df_mem_price" style="width:210">
                                          	<option value="">Choose a price level</option>
                                          	<option value="1" <cfif df_mem_price eq 1>selected</cfif>>1</option>
                                          	<option value="2" <cfif df_mem_price eq 2>selected</cfif>>2</option>
                                          	<option value="3" <cfif df_mem_price eq 3>selected</cfif>>3</option>
                                          	<option value="4" <cfif df_mem_price eq 4>selected</cfif>>4</option>
                                      	</select>      
                               		</div>
                           		</div>
                       		</div>
                   		</div>
               		</div>
           		</div>   
        	</div> 
            	

			<div class="row col-xs-offset-3" id="footer_sticky_section">
                <input id="tempSubmit" class="btn-primary" name="tempSubmit" type="button" value="Save">
                <input id="tempReset" class="btn-default" name="tempReset" type="button" value="Cancel">
            </div>
			<input id="submitBtn" name="submitBtn" type="submit" value="Save" hidden="true">
            
			<!--- Extra Hidden Field --->
                <!---<input type="hidden" name="recompriceup1" value="#recompriceup1#" >--->
                <!---<input type="hidden" name="wpitemtax1" value="#wpitemtax1#" >--->
                <!---<input type="hidden" name="df_qty" value="#df_qty#" >--->
                <!---<input type="hidden" name="dfcustcode" value="#dfcustcode#" >
                <input type="hidden" name="dfsuppcode" value="#dfsuppcode#" >--->
                <!---<input type="hidden" name="itempriceprior" value="#itempriceprior#" >
                <input type="hidden" name="disp1limit" value="#disp1limit#" >
                <input type="hidden" name="revStyle" value="#revStyle#" >
                <input type="hidden" name="generateQuoRevision1" value="#generateQuoRevision1#" >
                <input type="hidden" name="iaft" value="#iaft#" >
                <input type="hidden" name="custsupp_limit_display" value="#custsupp_limit_display#" >
                <input type="hidden" name="EAPT" value="#EAPT#" >
                <input type="hidden" name="PRF" value="#PRF#" >
                <input type="hidden" name="refnoNACC" value="#refnoNACC#" >
                <input type="hidden" name="refnoACC" value="#refnoACC#" >--->
            <!--- Extra Hidden Field END --->           
</cfoutput>
</cfform>

    <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">
        	<!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <div class="modal-title" style="text-align:center">Warning!!</div>
                </div>
                <div class="modal-body">
                    <p style="text-align:center">Changing this may result in incorrect tax amount for your transactions. Consultant our support team :)</p>
                </div>
                <div class="modal-footer">
                    <div class="col-sm-12">            	
                        <button type="button" class="btn btn-default col-sm-4 col-xs-offset-4 modalYes" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
	</div>
	
</body>
</html>