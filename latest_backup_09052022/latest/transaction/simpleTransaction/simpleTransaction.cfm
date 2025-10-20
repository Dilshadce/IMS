<cfsetting showdebugoutput="no">
<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "689,5,185,666,667,674,668,665,673,690,272,188,961,104,95,98,1779,957,954,1375,1847,702,9,530,65,959,795,777,752,793,506,475,29,1358,55,274,482,227,1096,592,1099,787,2167,786,1294,1099,1320,4003,96">
<cfinclude template="/latest/words.cfm">

<cfquery name="getGsetup" datasource="#dts#">
	SELECT  df_salestax,df_purchasetax,wpitemtax,bCurr,
    		rem5,rem6,rem7,rem8,rem9,rem10,rem11
    FROM gsetup;
</cfquery>

<cfif IsDefined("url.type")>
	<cfset type=url.type>
	<cfif type EQ "CN">
		<cfset title="#words[689]#">
		<cfset target="#words[5]#">
		<cfset targetTable="arcust">
		<cfset taxException="ST">
		<cfset itemPriceType="price">
        <cfset defaultTaxCode=getGsetup.df_salestax>
	<cfelseif type EQ "CS">
		<cfset title="#words[185]#">
		<cfset target="#words[5]#">
		<cfset targetTable="arcust">
		<cfset taxException="ST">
		<cfset itemPriceType="price">
        <cfset defaultTaxCode=getGsetup.df_salestax>
	<cfelseif type EQ "DN">
		<cfset title="#words[667]#">
		<cfset target="#words[5]#">
		<cfset targetTable="arcust">
		<cfset taxException="ST">
		<cfset itemPriceType="price">
        <cfset defaultTaxCode=getGsetup.df_salestax>
	<cfelseif type EQ "INV">
		<cfset title="#words[666]#">
		<cfset target="#words[5]#">
		<cfset targetTable="arcust">
		<cfset taxException="ST">
		<cfset itemPriceType="price">
        <cfset defaultTaxCode=getGsetup.df_salestax>
	<cfelseif type EQ "SAM">
		<cfset title="#words[674]#">
		<cfset target="#words[5]#">
		<cfset targetTable="arcust">
		<cfset taxException="ST">
		<cfset itemPriceType="price">
        <cfset defaultTaxCode=getGsetup.df_salestax>
    <cfelseif type EQ "QUO">
		<cfset title="#words[668]#">
		<cfset target="#words[5]#">
		<cfset targetTable="arcust">
		<cfset taxException="ST">
		<cfset itemPriceType="price">
        <cfset defaultTaxCode=getGsetup.df_salestax> 
    <cfelseif type EQ "DO">
		<cfset title="#words[665]#">
		<cfset target="#words[5]#">
		<cfset targetTable="arcust">
		<cfset taxException="ST">
		<cfset itemPriceType="price">
        <cfset defaultTaxCode=getGsetup.df_salestax>     
    <cfelseif type EQ "SO">
		<cfset title="#words[673]#">
		<cfset target="#words[5]#">
		<cfset targetTable="arcust">
		<cfset taxException="ST">
		<cfset itemPriceType="price">
        <cfset defaultTaxCode=getGsetup.df_salestax>        
	<cfelseif type EQ "PO">
		<cfset title="#words[690]#">
		<cfset target="#words[104]#">
		<cfset targetTable="apvend">
		<cfset taxException="PT">
		<cfset itemPriceType="ucost">
        <cfset defaultTaxCode=getGsetup.df_purchasetax>
	<cfelseif type EQ "RC">
		<cfset title="#words[272]#">
		<cfset target="#words[104]#">
		<cfset targetTable="apvend">
		<cfset taxException="PT">
		<cfset itemPriceType="ucost">
        <cfset defaultTaxCode=getGsetup.df_purchasetax>
    <cfelseif type EQ "PR">
		<cfset title="#words[188]#">
		<cfset target="#words[104]#">
		<cfset targetTable="apvend">
		<cfset taxException="PT">
		<cfset itemPriceType="ucost">
        <cfset defaultTaxCode=getGsetup.df_purchasetax>    
     <cfelseif type EQ "RQ">
		<cfset title="#words[961]#">
		<cfset target="#words[104]#">
		<cfset targetTable="apvend">
		<cfset taxException="PT">
		<cfset itemPriceType="ucost">
        <cfset defaultTaxCode=getGsetup.df_purchasetax>        
	</cfif>
</cfif>

<cfset action = url.action>
<cfset transactionTable="artran">

<cfquery name="getGsetup2" datasource="#dts#">
	SELECT decl_uprice,decl_discount,decl_totalAmt
    FROM gsetup2;
</cfquery>
<cfquery name="getLastRefNo" datasource="#dts#">
	SELECT lastUsedNo,counter,refnoused
	FROM refnoset
	WHERE type="#type#";
</cfquery>
<cfquery name="getTax" datasource="#dts#">
	SELECT code,rate1
	FROM #target_taxtable#
	WHERE tax_type IN ('#taxException#','T');
</cfquery>
<cfquery name="getDefaultTaxRate" datasource="#dts#">
	SELECT rate1
	FROM #target_taxtable#
	WHERE code = '#defaultTaxCode#';
</cfquery>
<cfquery name="getCurrency" datasource="#dts#">
	SELECT currcode,currency1
	FROM #target_currency#;
</cfquery>
<cfquery name="getTerm" datasource="#dts#">
	SELECT term,desp
	FROM #target_icterm#;
</cfquery>
<cfquery name="getProject" datasource="#dts#">
	SELECT source,project
	FROM #target_project#
    WHERE porj = 'P';
</cfquery>
<cfquery name="getJob" datasource="#dts#">
	SELECT source,project
	FROM #target_project#
    WHERE porj = 'J';
</cfquery>
<cfquery name="getAgent" datasource="#dts#">
	SELECT agent
	FROM #target_icagent#;
</cfquery>
<cfquery name="getDriver" datasource="#dts#">
	SELECT driverno,name
	FROM driver;
</cfquery>
<cfquery name="getUnitOfMeasurement" datasource="#dts#">
	SELECT unit
	FROM unit;
</cfquery>
<cfquery name="getLocation" datasource="#dts#">
	SELECT location
	FROM iclocation;
</cfquery>
<cfquery name="getTermsCondition" datasource="#dts#">
	SELECT l#type# AS termsCondition
	FROM ictermandcondition;
</cfquery>
<cfquery name="getUserDefault" datasource="#dts#">
	SELECT #type#_desp AS desp 
	FROM userdefault;
</cfquery>

<cfset uuid = CreateUUID()>

<cfif action EQ 'Create'>
	<cfset transactionItemTable = "ictrantemp">
	<cfset trancode = 1>
    <cfset custno = ''> 
	<cfset refno = ''>
	<cfset dateValue = DateFormat(Now(),"dd/mm/yyyy")>
    <cfset currcodeValue = getGsetup.bCurr>
    <cfset currencyRateValue = ''>
    <cfset termValue = ''>
    <cfset refno2Value = ''>
    <cfset ponoValue = ''>
    <cfset quonoValue = ''>
    <cfset sonoValue = ''>
    <cfset donoValue = ''>
    <cfset despValue = getUserDefault.desp>
    <cfset projectValue = ''>
    <cfset jobValue = ''>
    <cfset agentValue = ''>
    <cfset driverValue = ''>
    <cfloop index="i" from="5" to="11"> 
    	<cfif evaluate('getGsetup.rem#i#') NEQ 'Header Remark #i#'>
   			<cfset 'headerRemark#i#' = evaluate('getGsetup.rem#i#')>
        <cfelse>
        	<cfset 'headerRemark#i#' = "Remark #i#">
        </cfif>
	</cfloop>
    <cfloop index="i" from="5" to="11">
    	<cfset 'rem#i#' = ''>
    </cfloop>
    <cfset disp1Value = ''>
    <cfset disp2Value = ''>
    <cfset disp3Value = ''>
    <cfset disc_bilValue = ''>
    <cfset net_bilValue = ''>
    <cfset noteValue = defaultTaxCode>
    <cfset taxp1Value = ''>
    <cfset tax_bilValue = ''>
    <cfset roundingAdjustmentValue = "">
    <cfset grand_bilValue = ''>
    <cfset termsConditionValue = getTermsCondition.termsCondition>
    <cfset discountMethod = '%'>
    
<cfelseif action EQ 'Update'>
    <cfquery name="getArtran" datasource="#dts#">
        SELECT	custno,name,
                frem0,frem1,frem2,frem3,frem4,frem5,country,postalcode,rem2,rem4,phonea,frem6,e_mail,
                frem7,frem8,comm0,comm1,comm2,comm3,d_country,d_postalcode,rem3,rem12,d_phone2,comm4,d_email,
                refno,wos_date,currcode,currrate,term,
                refno2,pono,quono,sono,dono,desp,
                source,job,agenno,van,
                <cfloop index="i" from="5" to="11">rem#i#,</cfloop>termsCondition,
                disp1,disp2,disp3,disc_bil,
                invgross,gross_bil,net,net_bil,
                taxincl,note,taxp1,tax,tax_bil,
                roundadj,grand,grand_bil
        FROM artran
        WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
        AND refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">;
    </cfquery>
    
	<cfset transactionItemTable = "ictran">
    <cfset trancode = 0>
    <cfset custno = getArtran.custno>
	<cfset refnoValue = trim(url.refno)>
    <cfset dateValue = DateFormat(getArtran.wos_date,"DD/MM/YYYY")>
    <cfset currcodeValue = getArtran.currcode>
    <cfset currencyRateValue =  getArtran.currrate>
    <cfset termValue = getArtran.term>
    <cfset refno2Value = getArtran.refno2>
    <cfset ponoValue = getArtran.pono>
    <cfset quonoValue = getArtran.quono>
    <cfset sonoValue = getArtran.sono>
    <cfset donoValue = getArtran.dono>
    <cfset despValue = getArtran.desp>
    <cfset projectValue = getArtran.source>
    <cfset jobValue = getArtran.job>
    <cfset agentValue = getArtran.agenno>
    <cfset driverValue = getArtran.van>
    <cfloop index="i" from="5" to="11"> 
    	<cfif evaluate('getGsetup.rem#i#') NEQ 'Header Remark #i#'>
   			<cfset 'headerRemark#i#' = evaluate('getGsetup.rem#i#')>
        <cfelse>
        	<cfset 'headerRemark#i#' = "Remark #i#">
        </cfif>
	</cfloop>
    <cfloop index="i" from="5" to="11">
    	<cfset 'rem#i#' = evaluate('getArtran.rem#i#')>
    </cfloop>
    <cfset disp1Value = getArtran.disp1>
    <cfset disp2Value = getArtran.disp2>
    <cfset disp3Value = getArtran.disp3>
    <cfset disc_bilValue = getArtran.disc_bil>
    <cfset net_bilValue = getArtran.net_bil>
    <cfset noteValue = getArtran.note>
    <cfset taxp1Value = getArtran.taxp1>
    <cfset tax_bilValue = getArtran.tax_bil>
    <cfset roundingAdjustmentValue = getArtran.roundadj>
    <cfset grand_bilValue = getArtran.grand_bil>
    <cfset termsConditionValue = getArtran.termsCondition>
    <cfset discountMethod = '%'>
    
    <!--- Preparing ictranTemp data --->
	<cfquery name="insertIctran" datasource="#dts#">
        INSERT IGNORE INTO ictrantemp(	uuid,type,refno,trancode,itemcount,linecode,itemno,desp,despa,comment,brem1,brem2,brem3,brem4,
                                        location,qty,qty_bil,unit,unit_bil,factor1,factor2,price,price_bil,                                   
                                        dispec1,disamt,disamt_bil,
                                        taxpec1,taxamt_bil,
                                     	amt,amt_bil,amt1,amt1_bil,timeStamp
                                     )     
        SELECT '#uuid#' AS uuid,type,refno,trancode,itemcount,linecode,itemno,desp,despa,comment,brem1,brem2,brem3,brem4,
               location,qty,qty_bil,unit,unit_bil,factor1,factor2,price,price_bil,                                   
               dispec1,disamt,disamt_bil,
               taxpec1,taxamt_bil,
               amt,amt_bil,amt1,amt1_bil,NOW()
        FROM ictran
        WHERE type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
        AND refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">;                                       
    </cfquery>
</cfif>

<cfset priceDecimalPoint=getGsetup2.decl_uprice>
<cfset discountDecimalPoint=getGsetup2.decl_discount>
<cfset totalDecimalPoint=getGsetup2.decl_totalAmt>
<cfset itemTax=getGsetup.wpitemtax>
<cfset locationList = ValueList(getLocation.location,",")>
<cfset unitOfMeasurementList = ValueList(getUnitOfMeasurement.unit,",")>
<cfset taxCodeList = ValueList(getTax.code,",")>
<cfset locationRecordCount = getLocation.recordCount>
<cfset defaultTaxRate = getDefaultTaxRate.rate1>

<cfset projectRecordCount = getProject.recordCount>
<cfset jobRecordCount = getJob.recordCount>
<cfset agentRecordCount = getAgent.recordCount>
<cfset driverRecordCount = getDriver.recordCount>
<cfset sectionCount = 4>
<cfset tab1 = 'tab1'>
<cfset tab2 = 'tab2'>
<cfset tab3 = 'tab3'>
<cfset tab4 = 'tab4'>

<cfif projectRecordCount EQ 0 AND jobRecordCount EQ 0 AND agentRecordCount EQ 0 AND driverRecordCount EQ 0>
	<cfset sectionCount = sectionCount-1> 
    <cfset tab1 = 'tab1'>
	<cfset tab2 = 'tab2'>
    <cfset tab3 = ''>
    <cfset tab4 = 'tab3'>   
</cfif>

<cfoutput>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <!--- <meta name="viewport" content="width=device-width, initial-scale=1.0">	--->
    <meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="-1">
	<meta http-equiv="pragma" content="no-cache">
    <title>Simple Transaction</title>    
	<link rel="stylesheet" type="text/css" href="simpleTransaction.css"/>
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <link rel="stylesheet" href="bootstrap-tour-standalone.min.css" >
	<script type="text/javascript">
		var HlinkAMS='#HlinkAMS#';
		var dts='#dts#';
		var Hitemgroup='#Hitemgroup#';
		var action='#action#';
		var target='#target#';
		var targetTable='#targetTable#';
		var type='#type#';
		var refno='#refno#';
		var uuid='#uuid#';
		var priceDecimalPoint='#priceDecimalPoint#';
		var discountDecimalPoint='#discountDecimalPoint#';
		var totalDecimalPoint='#totalDecimalPoint#';
		var itemPriceType='#itemPriceType#';
		var itemTax='#itemTax#';
		var defaultTaxCode='#defaultTaxCode#';
		var defaultTaxRate='#defaultTaxRate#';
		var viewownagent='#getpin2.h1t00#';
		var huserid='#huserid#';
		var target_icagent='#target_icagent#';
	</script>
    <!--[if lt IE 9]>
        <script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
        <script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
    <![endif]-->
	<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/transaction/simpleTransaction/js/select2.min.js"></script>
    <script type="text/javascript" src="bootstrap-tour-standalone.min.js"></script> 
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="simpleTransaction.js"></script>
    <script type="text/javascript" src="/latest/js/autoNumeric/autoNumeric.js"></script>
    <script type="text/javascript" src="webTour.js"></script>   <!--- Webtour --->
</head>
<body>  
	<div id="hidden_div">
        <input type="text" id="locationList" name="locationList" value="#locationList#" />
        <input type="text" id="unitOfMeasurementList" name="unitOfMeasurementList" value="#unitOfMeasurementList#" />
        <input type="text" id="taxCodeList" name="taxCodeList" value="#taxCodeList#" />
	</div>  
    <div id="createdTransactionMessage" class="alert alert-success flyover flyover-centered">
		<div class="alertReferenceNoLabel"></div> 
    </div>
    <div id="header">
        <div class="col-row" id="h3">
            <h4 class="title-uppercase" ><cfif action eq "create">#words[95]#<cfelse>#words[98]#</cfif> #title#</h4>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <label for="custnoLabel" class="sr-only">#target#</label>
                <div class="col-sm-8" id="Step1">
                    <input type="hidden" id="custno" name="custno" class="custno" value="#custno#"/>
                </div>
            </div>
            <div class="col-sm-6">
                <ul class="nav nav-tabs uppercase">
                    <cfloop index="i" from="1" to="#sectionCount#">
                        <li <cfif i EQ 1>class="active"</cfif>>
                            <a href="##tab#i#" data-toggle="tab">#words[1779]# #i#</a>
                        </li>
                    </cfloop>
                    <!---START: Kastam Diraja Malaysia Required Fields --->
                    <cfif getGsetup.bCurr EQ 'MYR' AND (type EQ 'CN' OR type EQ 'DN')>
                        <li>
                            <a href="##tab5" data-toggle="tab">** RMCD</a>
                        </li>
                    </cfif>
                    <!---END: Kastam Diraja Malaysia Required Fields --->
                    <button id="takeTour" name="takeTour">Take a Tour</button>
                </ul>
            </div>
		</div>
    </div>
    <div class="row" id="top_section">
    	<div class="col-sm-6 ">  
            <div class="address_section min-padding">
                <div class="col-sm-6 addressHeight">
                    <div id="showLabel1">
                        <label for="billToLabel" class="col-sm-4 control-label" data-toggle="modal" data-target="##myModalBillingAddress">
                            <abbr title="Click to change">#words[957]#</abbr>
                        </label>
                    </div>    
                    <div class="col-sm-8 custinfo" id="custinfo"></div>                             
                </div>
                <div class="col-sm-6 addressHeight">
                    <div id="showLabel2">
                        <label for="deliveryToLabel" class="col-sm-4 control-label" data-toggle="modal" data-target="##myModalDeliveryAddress">
                            <abbr title="Click to change">#words[954]#</abbr>
                        </label>
                    </div>
                    <div class="col-sm-8" id="custinfo2"></div>
                </div>  
        	</div>               
        </div>
        <div class="col-sm-6">
			<div class="tabbable">
				<div class="tab-content">
            		<div class="tab-pane active" id="#tab1#">
                        <form class="form-horizontal formTabSection min-padding" role="form">
                            <div class="form-group" >
                                <label for="refnoLabel" class="col-sm-6 control-label">#words[1375]#</label>
                                <div class="col-sm-6">
                                    <div class="row no-pad">
                                        <div class="col-sm-6" id="Step2">
										<cfif url.action eq "Create">
                                            <input class="form-control input-sm" type="text" id="refno" name="refno" value="#refno#" <cfif getLastRefNo.refnoused eq "1">disabled="true"</cfif>/>
                                        <cfelse>
											 <input class="form-control input-sm" type="text" id="refno" name="refno" value="#refno#" disabled="true"/>
										</cfif>
										</div>
                                        <cfif action EQ 'Create'>
                                            <div class="col-sm-6" id="Step3">
                                                <select class="form-control input-sm" id="RefNoSet" name="RefNoSet">
                                                    <option value="">#words[1847]#</option>
                                                    <cfloop query="getLastRefNo">
                                                        <option value="#getLastRefNo.counter#">#getLastRefNo.counter# - #getLastRefNo.lastUsedNo#</option>
                                                    </cfloop>
                                                </select>
                                            </div>    
                                        </cfif>
                                   </div>
                                </div>        
                            </div>
                            <div class="form-group">
                                <label for="dateLabel" class="col-sm-6 control-label">#words[702]#</label>
                                <div class="col-sm-6">
                                    <div class="input-group date">
                                        <input class="form-control input-sm" type="text" id="wos_date" name="wos_date" value="#dateValue#" />
                                        <span class="input-group-addon min-padding calender-addon">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="currcodeLabel" class="col-sm-6 control-label">#words[9]#</label>
                                <div class="col-sm-6">
                                    <div class="row no-pad">
                                    	<div class="col-sm-4" id="Step5">
                                            <input class="form-control input-sm" type="text" id="currencyRate" name="currencyRate" value="#currencyRateValue#"/>
                                        </div>
                                        <div class="col-sm-8" id="Step4">
                                            <select class="form-control input-sm" id="currcode" name="currcode">
                                                <option value="">Choose a Currency</option>
                                                <cfloop query="getCurrency">
                                                    <option value="#getCurrency.currcode#" <cfif getCurrency.currcode EQ currcodeValue>selected</cfif>>#getCurrency.currency1# [#getCurrency.currcode#]</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                   </div>
                                </div>   
                            </div>    
                            <div class="form-group">
                                <label for="termLabel" class="col-sm-6 control-label">#words[530]#</label>
                                <div class="col-sm-6">
                                    <select class="form-control input-sm" id="term" name="term" >
                                        <option value="">Choose a Term</option>
                                        <cfloop query="getTerm">
                                            <option value="#getTerm.term#" <cfif getTerm.term EQ termValue>selected</cfif>>#getTerm.term#</option>
                                        </cfloop>
                                    </select>
                                </div>
                            </div>
                        </form>
            		</div>
            		<div class="tab-pane" id="#tab2#">
                    	<form class="form-horizontal formTabSection min-padding" role="form">
                        	<div class="form-group">
                                <label class="col-sm-2 control-label">#words[65]#</label>
                                <div class="col-sm-10">
                                    <input class="form-control input-sm" type="text" id="desp" name="desp" value="#despValue#"/>
                                </div>
                            </div> 
                            <div class="form-group">
                                <label for="refno2Label" class="col-sm-2 control-label">#words[959]#</label>
                                <div class="col-sm-10">
                                    <input class="form-control input-sm" type="text" id="refno2" name="refno2" value="#refno2Value#"/>
                                </div>
                            </div>
                            <div class="form-group">
                            	<cfif type NEQ 'PO'>
                                    <label for="poNoLabel" class="col-sm-2 control-label">#words[795]#</label>
                                    <div class="col-sm-4">
                                        <input class="form-control input-sm" type="text" id="pono" name="pono" value="#ponoValue#"/> 
                                    </div>
                                <cfelse>
                                	<input class="form-control input-sm" type="hidden" id="pono" name="pono" value=""/> 	    
                                </cfif>
                        		<cfif type NEQ 'QUO'>
                                    <label for="quoNoLabel" class="col-sm-2 control-label">#words[777]#</label>
                                    <div class="col-sm-4">
                                        <input class="form-control input-sm" type="text" id="quono" name="quono" value="#quonoValue#"/>
                                    </div>
                                <cfelse>
                                	<input class="form-control input-sm" type="hidden" id="quono" name="quono" value=""/>	    
                            	</cfif>        
                            </div> 
                            <div class="form-group">
                            	<cfif type NEQ 'SO'>
                                    <label for="soNoLabel" class="col-sm-2 control-label">#words[752]#</label>
                                    <div class="col-sm-4">
                                        <input class="form-control input-sm" type="text" id="sono" name="sono"  value="#sonoValue#"/>  
                                    </div>
                                <cfelse>
                                	<input class="form-control input-sm" type="hidden" id="sono" name="sono"  value=""/>  	    
                                </cfif>
                        		<cfif type NEQ 'DO'>
                                    <label for="doNoLabel" class="col-sm-2 control-label">#words[793]#</label>
                                    <div class="col-sm-4">
                                        <input class="form-control input-sm" type="text" id="dono" name="dono" value="#donoValue#"/>
                                    </div>
                                <cfelse>  
                                	<input class="form-control input-sm" type="hidden" id="dono" name="dono" value=""/>  
                            	</cfif>        
                            </div>  
                    	</form> 
            		</div>
                    <div class="tab-pane" id="#tab3#">
                    	<form class="form-horizontal formTabSection min-padding" role="form">
							<cfif getProject.recordCount GT 0>
                                <div class="form-group">
                                    <label for="projectLabel" class="col-sm-6 control-label">#words[506]#</label>
                                    <div class="col-sm-6">
                                        <select class="form-control input-sm" id="project" name="project">
                                            <option value="">Choose a Project</option>
                                            <cfloop query="getProject">
                                                <option value="#getProject.source#" <cfif getProject.source EQ projectValue>selected</cfif>>#getProject.source# - #getProject.project#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            <cfelse>
                            	<input class="form-control input-sm" type="hidden" id="project" name="project" value=""/> 	    
                            </cfif>   
                            <cfif getJob.recordCount GT 0> 
                                <div class="form-group">
                                    <label for="jobLabel" class="col-sm-6 control-label">#words[475]#</label>
                                    <div class="col-sm-6">
                                        <select class="form-control input-sm" id="job" name="job">
                                            <option value="">Choose a Job</option>
                                            <cfloop query="getJob">
                                                <option value="#getJob.source#" <cfif getJob.source EQ jobValue>selected</cfif>>#getJob.source# - #getJob.project#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            <cfelse>
                            	<input class="form-control input-sm" type="hidden" id="job" name="job" value=""/> 	    
                            </cfif>   
                            <cfif getAgent.recordCount GT 0>
                                <div class="form-group">
                                    <label for="agentLabel" class="col-sm-6 control-label">#words[29]#</label>
                                    <div class="col-sm-6">
                                        <select class="form-control input-sm" id="agent" name="agent">
                                            <option value="">Choose an Agent</option>
                                            <cfloop query="getAgent">
                                                <option value="#getAgent.agent#" <cfif getAgent.agent EQ agentValue>selected</cfif>>#getAgent.agent#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                            <cfelse>
                            	<input class="form-control input-sm" type="hidden" id="agent" name="agent" value=""/> 	    
                            </cfif>
                            <cfif getDriver.recordCount GT 0>
                                <div class="form-group">
                                    <label for="driverLabel" class="col-sm-6 control-label">#words[1358]#</label>
                                    <div class="col-sm-6">
                                        <select class="form-control input-sm" id="driver" name="driver">
                                            <option value="">Choose a Customer Service</option>
                                            <cfloop query="getDriver">
                                                <option value="#getDriver.driverno#" <cfif getDriver.driverno EQ driverValue>selected</cfif>>#getDriver.driverno# - #getDriver.name#</option>
                                            </cfloop>
                                        </select>
                                   </div>
                               </div>
                           <cfelse>
                            	<input class="form-control input-sm" type="hidden" id="driver" name="driver" value=""/> 	    
                            </cfif>
						</form>       
            		</div>
					<div class="tab-pane" id="#tab4#">
                    	<form class="form-horizontal formTabSection min-padding" role="form">
                            <cfloop from="5" to="7" index="i">
                                <div class="form-group">
                                    <label for="remark#i#" class="col-sm-2 control-label">#evaluate('headerRemark#i#')#</label>
                                    <div class="col-sm-4">
                                        <input class="form-control input-sm" type="text" id="remark#i#" value="#evaluate('rem#i#')#"/>
                                    </div>
                                    <label for="remark#3+i#" class="col-sm-2 control-label">#evaluate('headerRemark#i+3#')#</label>
                                    <div class="col-sm-4">
                                        <input class="form-control input-sm" type="text" id="remark#i+3#" value="#evaluate('rem#i+3#')#"/>
                                    </div>
                                </div>
                            </cfloop>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">#headerRemark11#</label>
                                <div class="col-sm-10">
                                    <input class="form-control input-sm" type="text" id="remark11" name="remark11" value="#rem11#"/>
                                </div>
                            </div>
                    	</form> 	       
            		</div>
                    <div class="tab-pane" id="tab5" <cfif getGsetup.bCurr NEQ 'MYR' AND (type NEQ 'CN' AND type NEQ 'DN')>style="visibility:hidden"</cfif>>
                        <form class="form-horizontal formTabSection min-padding" role="form">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Tax Invoice No</label>
                                <div class="col-sm-10">
                                    <input type="hidden" id="INVno" name="INVno" class="INVno" value=""/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Tax Invoice Date</label>
                                <div class="col-sm-10">
                                    <input class="form-control input-sm" type="text" id="taxINVdate" name="taxINVdate" value="" disabled="true"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Reason</label>
                                <div class="col-sm-10">
                                    <textarea id="reason" name="reason" class="form-control" rows="2" cols="2" placeholder="Reason"></textarea>
                                </div>
                            </div>
                        </form> 	       
                    </div>     
          		</div>
        	</div>
        </div>
    </div> 
    
    <form>
        <div class="row" id="body_section">  
            <table class="itemTable">
                <thead>
                    <tr class="itemTableTR">
                        <th class="th_one itemTableTH">#words[55]#</th>
                        <th class="th_two itemTableTH">#words[274]#</th>
                        <th class="th_three itemTableTH">#words[65]#</th>
                        <th class="th_four itemTableTH">#words[482]#</th>
                        <th class="th_five itemTableTH">#words[227]#</th>
                        <th class="th_six itemTableTH">#words[1096]# <label for="currencyCodeLabel" id="currencyCode" class="currencyCode"></label></th>
                        <th class="th_seven itemTableTH">#words[592]#</th>
                        <th class="th_eight itemTableTH">#words[1099]#</th>
                        <th class="th_nine itemTableTH">#words[787]# <label for="currencyCodeLabel" id="currencyCode" class="currencyCode"></label></th>
                        <th class="th_ten itemTableTH"></th>
                    </tr>
                </thead>
                <tbody id="item_table_body">
                	<cfif action EQ 'Create'>
                        <tr id="#trancode#" class="edit_tr last_edit_tr">
                            <td class="td_one">
                                <label for="recordCountLabel" id="recordCount_#trancode#" class="recordCount">
                                	<abbr title="" class="reshuffleTitle">#trancode#</abbr>
                                </label>
                            </td>
                            <td class="select2_Item">
                            	<input type="text" id="itemno_label_#trancode#" name="itemno_label_#trancode#" class="form-control input-sm itemno_label" disabled="true"/>
                                <input type="hidden" id="itemno_input_#trancode#" name="itemno_input_#trancode#" class="editbox itemno_input addline" data-placeholder="Choose an item" />
                                <input type="hidden" id="lineCode_label_#trancode#" name="lineCode_label_#trancode#" class="form-control input-sm"/>
                            </td>
                            <td>
                                <div class="input-group">
                                    <input type="text" id="desp_input_#trancode#" name="desp_input_#trancode#" class="form-control input-sm desp_input"/>
                                    <span class="input-group-addon glyphiconA glyphicon-plus editItemDescription" id="editItemDescription_#trancode#" data-toggle="modal" data-target="##myItemDescription">
                                    </span>
                                </div>
                            </td>
                            <td class="td_four">
                                <select id="location_input_#trancode#" name="location_input_#trancode#" class="form-control input-sm location_input">
                                    <option value="">Location</option>
                                    <cfloop query="getLocation">
                                        <option value="#getLocation.location#">#getLocation.location#</option>
                                    </cfloop>
                                </select>
                            </td>
                            <td>
                                <div class="row no-pad">
                                    <div class="col-sm-4">
                                        <input type="text" id="qty_input_#trancode#" name="qty_input_#trancode#" class="form-control input-sm qty_input textAlignRight" />
                                    </div>
                                    <div class="col-sm-8">
                                        <select id="unitOfMeasurement_input_#trancode#" name="unitOfMeasurement_input_#trancode#" class="form-control input-sm unitOfMeasurement_input">
                                            <option value="">U.O.M</option>	
                                            <cfloop query="getUnitOfMeasurement">
                                                <option value="#getUnitOfMeasurement.unit#">#getUnitOfMeasurement.unit#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>
                                <div class="row no-pad">
                                    <div class="col-sm-6">
                                        <input type="text" id="factor1_#trancode#" name="factor1_#trancode#" class="form-control input-sm collapse factor1 textAlignRight"/>
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="text" id="factor2_#trancode#" name="factor2_#trancode#" class="form-control input-sm collapse factor2 textAlignRight"/>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <input type="text" id="price_input_#trancode#" name="price_input_#trancode#" class="form-control input-sm price_input textAlignRight priceHistory" />
                            </td>
                            <td>
                                <div class="input-group">
                                    <input type="text" id="dispec1_input_#trancode#" name="dispec1_input_#trancode#" class="form-control input-sm dispec1_input textAlignRight" />
                                    <span class="input-group-addon" id="discount">%</span>
                                </div>
                            </td>
                            <td class="itemTaxTD">
                            	<div class="row no-pad">
                                    <div class="col-sm-2">
                            	<input type="checkbox" id="itemTaxIncluded_input_#trancode#" name="itemTaxIncluded_input_#trancode#" value="T" class="form-control input-sm itemTaxIncluded">
                                	</div>
                                	<div class="col-sm-10">
                                <select id="itemTaxCode_input_#trancode#" name="itemTaxCode_input_#trancode#" class="form-control input-sm itemTaxCode">
                                    <cfloop query="getTax">
                                        <option value="#getTax.code#" <cfif getTax.code EQ defaultTaxCode>selected</cfif>>#getTax.code#</option>
                                    </cfloop>
                                </select>
                                <input type="hidden" id="taxpec1_input_#trancode#" name="taxpec1_input_#trancode#" class="form-control input-sm taxpec1_input textAlignRight" disabled="true"/>
                                <input type="hidden" id="taxAmtBil_input_#trancode#" name="taxAmtBil_input_#trancode#" class="form-control input-sm taxAmtBil_input textAlignRight" disabled="true"/>
                            		</div>
                                </div>
                            </td>
                            <td>
                                <input type="text" id="amt_input_#trancode#" name="amt_input_#trancode#" class="form-control input-sm amt_input textAlignRight" disabled="true"/>
                            </td>
                            <td class="td_ten">
                                <span class="glyphicon glyphicon-trash delete_item" id="#trancode#"></span> 
                            </td>
                        </tr> 
                	</cfif>           
                </tbody>
            </table>
        </div>
	</form> 
    
    <div class="row" id="footer_section">
    	<div class="col-sm-6" id="footer_left_section">
        	<div class="form-group" id="Step7">
                <label for="termConditionLabel" class="sr-only">#words[2167]#</label>
                <div class="col-sm-12">
                	<textarea id="termCondition" name="termCondition" class="form-control" rows="7" cols="5" placeholder="Terms and Conditions">#termsConditionValue#</textarea>
                </div>
            </div>
        </div>
        <div class="col-sm-6" id="footer_right_section">
       		<form class="form-horizontal" role="form">
            	<div class="form-group">
                   <label for="totalQtyLabel" class="col-sm-6 control-label">#words[786]#</label>
                    <div class="col-sm-6">
                        <input type="text" id="totalQty_bil" name="totalQty_bil" class="form-control input-sm textAlignRight" disabled="true"/>
                    </div>
                </div>
               	<input type="hidden" id="gross_bil" name="gross_bil" class="form-control input-sm textAlignRight"/>
                <div class="form-group">
                	<label for="discountLabel" class="col-sm-6 control-label">#words[592]#</label>
                    <div class="col-sm-6">
                        <div class="row no-pad" id="Step6">
                            <div class="col-sm-3">
                                <div class="input-group">
                                    <input type="text" id="disp1_bil" name="disp1_bil" class="form-control input-sm disp1_bil textAlignRight" value="#disp1Value#" />
                                    <span class="input-group-addon" id="discount">%</span>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="input-group">	
                                    <input type="text" id="disp2_bil" name="disp2_bil" class="form-control input-sm disp2_bil textAlignRight" value="#disp2Value#" disabled="true"/>
                                    <span class="input-group-addon" id="discount">%</span>
                                </div>    
                            </div>
                            <div class="col-sm-3">
                                <div class="input-group">
                                    <input type="text" id="disp3_bil" name="disp3_bil" class="form-control input-sm disp3_bil textAlignRight" value="#disp3Value#" disabled="true"/>
                                    <span class="input-group-addon" id="discount">%</span>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="input-group">
                                    <input type="text" id="discount_bil" name="discount_bil" class="form-control input-sm discount_bil textAlignRight" value="#disc_bilValue#" />
                                </div>
                            </div>
                        </div>   
                    </div>     
                </div>
                <div class="form-group">
                    <label for="netLabel" class="col-sm-6 control-label">#words[1294]#</label>
                    <div class="col-sm-6">
                    	<input type="text" id="net_bil" name="net_bil" class="form-control input-sm net_bil textAlignRight" disabled="true" value="#net_bilValue#"/>   
                    </div>
                </div>   
                <div class="form-group">
                    <label for="taxLabel" id="taxLabel" class="col-sm-6 control-label">(Plus) #words[1099]#</label>
                    <div class="col-sm-6">
                        <input type="text" id="itemTax_bil" name="itemTax_bil" class="form-control input-sm itemTax_bil textAlignRight" disabled="true"/>
                        <div class="row no-pad">
                            <div class="col-sm-4">
                            	<div class="input-group">
                                	<span class="input-group-addon billTaxIncluded min-padding">
                                        <input type="checkbox" id="billTaxIncluded" name="billTaxIncluded" value="">
                                    </span>
                                    <select id="taxCode" name="taxCode" class="form-control input-sm taxCode">
                                        <cfloop query="getTax">
                                            <option value="#getTax.code#" <cfif getTax.code EQ noteValue>selected</cfif>>#getTax.code#</option>
                                        </cfloop>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="input-group">
                                    <input type="text" id="taxp1_bil" name="taxp1_bil" class="form-control input-sm taxp1_bil textAlignRight" value="#taxp1Value#" disabled="true"/>
                                    <span class="input-group-addon discountSymbol_bil" id="discount">%</span>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <input type="text" id="tax_bil" name="tax_bil" class="form-control input-sm tax_bil textAlignRight" value="#tax_bilValue#" disabled="true"/>
                            </div>
                        </div>
                	</div>                    
                </div>
                <div class="form-group">
                	<cfif type EQ "CS">
						<label for="roundingAdjustmentLabel" class="col-sm-6 control-label">#words[4003]#</label>
                        <div class="col-sm-6">
                            <input type="text" id="roundingAdjustment" name="roundingAdjustment" class="form-control input-sm textAlignRight" value="#roundingAdjustmentValue#" disabled="true"/>
                        </div>	
                    <cfelse>
                    	<input type="hidden" id="roundingAdjustment" name="roundingAdjustment" class="form-control input-sm textAlignRight" value="#roundingAdjustmentValue#" disabled="true"/>	
                    </cfif>     
                </div>
                <div class="form-group">
                    <label for="grandTotalLabel" class="col-sm-6 control-label">#words[1320]#</label>
                    <div class="col-sm-6">
                    	<input type="text" id="grand_bil" name="grand_bil" class="form-control input-sm grand_bil textAlignRight" value="#grand_bilValue#" disabled="true"/>
                    </div>
                </div>
        	</form>         	
        </div>	  
        <div class="row col-xs-offset-4" id="footer_sticky_section">
            <div class="btn-group dropup" id="finalStep">
                <button type="button" class="btn btn-primary saveTransaction createButton" id="create" data-loading-text="Saving..."><cfif action eq "create">#words[95]#<cfelse>#words[98]#</cfif></button>
                <button type="button" class="btn btn-primary dropdown-toggle createButton" data-toggle="dropdown" aria-expanded="false">
                    <span class="caret"></span>
                    <span class="sr-only">Toggle Dropdown</span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <cfif HuserID EQ 'ultraprinesh'>
                        <li><a class="" data-toggle="modal" data-target="##myEmailBill"><cfif action eq "create">#words[95]#<cfelse>#words[98]#</cfif> and Email</a></li>
                    </cfif>
                    <li><a class="" id="createAndNew"><cfif action eq "create">#words[95]#<cfelse>#words[98]#</cfif> and New</a></li>
                </ul>
            </div>  
            <button type="button" class="btn btn-default cancelButton" id="cancel" data-loading-text="Cancelling...">#words[96]#</button>
        </div>
    </div>       
</body>
</html>
</cfoutput>
 
<cfoutput>               
    <cfinclude template="/latest/modal/itemDescription.cfm">
    <cfinclude template="/latest/modal/changeDeliveryAddress.cfm">
    <cfinclude template="/latest/modal/changeBillingAddress.cfm">
    <cfinclude template="/latest/modal/createCustomerSupplier.cfm">
    <cfinclude template="/latest/modal/emailBill.cfm">
</cfoutput>

<img src="ajaxLoading.gif" id="loading_indicator" style="display:none" />
