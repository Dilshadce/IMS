<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "5,16,17,24,25,104,106,107,112,113,95,59,98,22,18,26,19,20,21,315,317,109,
314,110,111,112,316,318,15,23,27,28,29,31,32,33,8,6,34,35,36,37,38,39,40,41,42,43,300,44,45,46,47,
48,49,50,43,51,52,301,53,54,55,58,56,57,60,61,302,303,304,305,306,308,62,63,64,65,66,67,68,69,70,309,
310,311,312,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,90,313,91,92,93,94,14,97,105,115,30,1838,1358">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.custno')>
	<cfset URLcustno = trim(urldecode(url.custno))>
</cfif>

<cfquery name="getGsetup" datasource="#dts#">
	SELECT  a.debtorfr,a.creditorfr,a.ctycode,a.debtorfr,a.debtorto,a.custSuppNo,a.creditorfr,a.creditorto,a.suppno,
    		b.currcode,b.currency,b.currency1
	FROM gsetup AS a
    LEFT JOIN (SELECT currcode,currency,currency1 FROM #target_currency#) AS b ON a.ctycode=b.currcode;
</cfquery>

<cfquery name="getmodulecontrol" datasource="#dts#">
	SELECT malaysiaGST
	FROM modulecontrol;
</cfquery>

<cfquery name="listCurrency" datasource="#dts#">
	SELECT currcode,currency,currency1 
	FROM #target_currency#
	ORDER BY currcode;
</cfquery>

<cfquery name="listBusiness" datasource="#dts#">
	SELECT business,desp 
	FROM business 
	ORDER BY business;
</cfquery>

<cfquery name="listArea" datasource="#dts#">
	SELECT area,desp 
	FROM #target_icarea#
	ORDER BY area;
</cfquery>

<cfquery name="listAgent" datasource="#dts#">
	SELECT agent,desp 
	FROM #target_icagent#
	ORDER BY agent;
</cfquery>

<cfquery name="listTerm" datasource="#dts#">
	SELECT term 
	FROM #target_icterm#
	ORDER BY term;
</cfquery>

<cfquery name="listTaxCode" datasource="#dts#">
	SELECT *
	FROM #target_taxtable#
    <cfif url.target EQ "Customer">
    	WHERE tax_type IN ('T','ST')
    <cfelse>
    	WHERE tax_type IN ('T','PT')
    </cfif>
    AND rate1 = '0';
</cfquery>

<cfquery name="listDriver" datasource="#dts#">
	SELECT driverno,name
	FROM driver
    ORDER BY driverno;
</cfquery>

<cfif url.target EQ "Customer">
	<cfset targetTable=target_arcust>
	<cfset codefr=getGsetup.debtorfr>
	<cfset formAction="/latest/maintenance/customerProcess.cfm?action=#url.action#&menuID=#url.menuID#">
	<cfset targetTitle="#words[5]#">
    <cfset targetNo="#words[16]#">
    <cfset openItem="#words[17]#">
    <cfset targetNameLine1="#words[24]#">
    <cfset targetNameLine2="#words[25]#">
    
    <cfif getGsetup.custSuppNo EQ "1">
    	<cfset targetFormat = "XXXX/XXX">
    <cfelse>
    	<cfset targetFormat = "XXXXXXX">
    </cfif>
<cfelseif url.target EQ "Supplier">
	<cfset targetTable=target_apvend>
	<cfset codefr=getGsetup.creditorfr>
	<cfset formAction="/latest/maintenance/supplierProcess.cfm?action=#url.action#&menuID=#url.menuID#">
	<cfset targetTitle="#words[104]#">
    <cfset targetNo="#words[106]#">
    <cfset openItem="#words[107]#">
    <cfset targetNameLine1="#words[112]#">
    <cfset targetNameLine2="#words[113]#">
    
    <cfif getGsetup.suppNo EQ "1">
    	<cfset targetFormat = "XXXX/XXX">
    <cfelse>
    	<cfset targetFormat = "XXXXXXX">
    </cfif>
</cfif>

<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset action="Create">
		<cfset actionWords="#words[95]#">
		<cfset mode="create">
   
        <cfset custno = "">
        <cfset name= "">
        <cfset name2= "">
        <cfset comuen= "">
        <cfset agent= "">
        <cfset groupTo= "">
        <cfset status= "">
      
        <cfset add1= "">
        <cfset add2= "">
        <cfset add3= "">
        <cfset add4= "">
        <cfset country = "">
        <cfset postalCode= "">
        <cfset attn= "">
        <cfset phone= "">
        <cfset hp= "">
        <cfset fax= "">
        <cfset email= "">
        
        <cfset d_add1= "">
        <cfset d_add2= "">
        <cfset d_add3= "">
        <cfset d_add4= "">
        <cfset d_country= "">
        <cfset d_postalCode= "">
        <cfset d_attn= "">
        <cfset d_phone= "">
        <cfset d_hp= "">
        <cfset d_fax= "">
        <cfset web_site= "">
		
        <cfset taxIncluded= "">
        <cfset GSTstatus = 'T'>
        <cfif getGsetup.ctycode EQ "IDR">         
        	<cfset gstWord = "NPWP">
            <cfset gstPlaceHolder = "Nomor pokok Wajib Pajak">
        <cfelse>
            <cfset gstWord = "GST">
            <cfset gstPlaceHolder = "#words[59]#"> 
        </cfif>   
        <cfset gstno= "">
        <cfset taxCode= "">
        <cfset salec= "">
        <cfset salecnc= "">
        <cfset currencyCode= getGsetup.ctycode>
        <cfset currencySymbol= getGsetup.currency>
        <cfset currencyDesp= getGsetup.currency1>
        <cfset terms= "">
        <cfset creditLimit= "">
        <cfset invoiceLimit= "">
        
        <cfset discPercentageCategory= "">
        <cfset discPercentageLvl_1= "">
        <cfset discPercentageLvl_2= "">
        <cfset discPercentageLvl_3= "">
        
        <cfif url.target EQ "Customer">
			<cfset normalRate= "">
            <cfset offerRate= "">
            <cfset otherRate= "">
        </cfif>
        
        <cfset businessValue= "">
        <cfset areaSelected= "">
        <cfset driver= "">  
        <cfset createdDate= "">  
        <cfset remark1= "">           
        <cfset remark2= "">
        <cfset remark3= "">
        <cfset remark4= ""> 
        <cfset remark5= "">
        <cfset remark6= "">
        <cfset remark7= "">
        <cfset remark8= "">
        <cfset remark9= "">
        <cfset remark10= "">
        
        <cfset gst_act_date= ""> 
        <cfset gst_valid_period= ""> 
        <cfset gstappno= ""> 
        <cfset gst_app_datefrom= ""> 
        <cfset gst_app_dateto= ""> 
        
	<cfelseif url.action EQ "update">
		<cfset action="Update">
		<cfset actionWords="#words[98]#">
		<cfset mode="edit">
        
        <cfif url.target EQ "Customer">
            <cfquery name="getCustomer" datasource='#dts#'>
                SELECT * 
                FROM #target_arcust# 
                WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLcustno#">;
            </cfquery>
        <cfelseif url.target EQ "Supplier">
        	<cfquery name="getCustomer" datasource='#dts#'>
                SELECT * 
                FROM #target_apvend# 
                WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLcustno#">;
            </cfquery>
        </cfif>    
        
        <cfset custno= getCustomer.custno>
        <cfset name= getCustomer.name>
        <cfset name2= getCustomer.name2>
        <cfset comuen= getCustomer.comuen>
        <cfset agent= getCustomer.agent>
        <cfset groupTo= getCustomer.groupto>
        <cfset status= getCustomer.status>
 
        <cfset add1= getCustomer.add1>
        <cfset add2= getCustomer.add2>
        <cfset add3= getCustomer.add3>
        <cfset add4= getCustomer.add4>
        <cfset country = getCustomer.country>
        <cfset postalCode= getCustomer.postalcode>
        <cfset attn= getCustomer.attn>
        <cfset phone= getCustomer.phone>
        <cfset hp= getCustomer.phonea>
        <cfset fax= getCustomer.fax>
        <cfset email= getCustomer.e_mail>
        
        <cfset d_add1= getCustomer.daddr1>
        <cfset d_add2= getCustomer.daddr2>
        <cfset d_add3= getCustomer.daddr3>
        <cfset d_add4= getCustomer.daddr4>
        <cfset d_country= getCustomer.d_country>
        <cfset d_postalCode= getCustomer.d_postalcode>
        <cfset d_attn= getCustomer.dattn>
        <cfset d_phone= getCustomer.dphone>
        <cfset d_hp= getCustomer.contact>
        <cfset d_fax= getCustomer.dfax>
        <cfset web_site= getCustomer.web_site>
		
        <cfset taxIncluded = getCustomer.taxincl_cust>
        <cfif getCustomer.ngst_cust EQ ''>
        	<cfset GSTstatus = 'T'>
        <cfelse>	
        	<cfset GSTstatus = getCustomer.ngst_cust>	
        </cfif>
        <cfif getGsetup.ctycode EQ "IDR">        
        	<cfset gstWord = "NPWP">
            <cfset gstPlaceHolder = "Nomor pokok Wajib Pajak">
        <cfelse>
            <cfset gstWord = "GST">
            <cfset gstPlaceHolder = "#words[59]#"> 
        </cfif>
        <cfset gstno= getCustomer.gstno>
        <cfset taxCode= getCustomer.taxcode>
        <cfset salec= getCustomer.salec>
        <cfset salecnc= getCustomer.salecnc>
        <cfset currencyCode= getCustomer.currcode>
        <cfset currencySymbol= getCustomer.currency>
        <cfset currencyDesp= getCustomer.currency1>
        <cfset terms= getCustomer.term>
        <cfset creditLimit= getCustomer.crlimit>
        <cfset invoiceLimit= getCustomer.invlimit>
        
        <cfset discPercentageCategory= getCustomer.dispec_cat>
        <cfset discPercentageLvl_1= getCustomer.dispec1>
        <cfset discPercentageLvl_2= getCustomer.dispec2>
        <cfset discPercentageLvl_3= getCustomer.dispec3>
        <cfif url.target EQ "Customer">
			<cfset normalRate= getCustomer.normal_rate>
            <cfset offerRate= getCustomer.offer_rate>
            <cfset otherRate= getCustomer.others_rate>
        </cfif>
        
        <cfset businessValue= getCustomer.business>
        <cfset areaSelected= getCustomer.area>
        <cfset driver= getCustomer.end_user> 
        <cfset createdDate= getCustomer.created_on>    
        <cfset remark1= getCustomer.arrem1>           
        <cfset remark2= getCustomer.arrem2>
        <cfset remark3= getCustomer.arrem3>
        <cfset remark4= getCustomer.arrem4>  
        <cfset remark5= getCustomer.arrem5> 
        <cfset remark6= getCustomer.arrem6> 
        <cfset remark7= getCustomer.arrem7> 
        <cfset remark8= getCustomer.arrem8> 
        <cfset remark9= getCustomer.arrem9> 
        <cfset remark10= getCustomer.arrem10>     
        <cfset gstappno= getCustomer.gstappno> 
        <cfset gst_act_date= DateFormat(getCustomer.gst_act_date,"dd/mm/yyyy")> 
        <cfset gst_valid_period= getCustomer.gst_valid_period> 
        <cfset gst_app_datefrom= DateFormat(getCustomer.gst_app_datefrom,"dd/mm/yyyy")> 
        <cfset gst_app_dateto= DateFormat(getCustomer.gst_app_dateto,"dd/mm/yyyy")> 
	                        
    <cfelseif url.action EQ "delete">
    	<cfset action="Delete">
        <cfset actionWords="Delete">
		<cfset mode="delete">  
        
        <cfif url.target EQ "Customer">
            <cfquery name="getCustomer" datasource='#dts#'>
                SELECT * 
                FROM #target_arcust# 
                WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLcustno#">;
            </cfquery>
        <cfelseif url.target EQ "Supplier">
        	<cfquery name="getCustomer" datasource='#dts#'>
                SELECT * 
                FROM #target_apvend# 
                WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLcustno#">;
            </cfquery>
        </cfif> 
        
        <cfset custno= getCustomer.custno>
        <cfset name= getCustomer.name>
        <cfset name2= getCustomer.name2>
        <cfset comuen= getCustomer.comuen>
        <cfset agent= getCustomer.agent>
        <cfset groupTo= getCustomer.groupto>
        <cfset status= getCustomer.status>
    
        <cfset add1= getCustomer.add1>
        <cfset add2= getCustomer.add2>
        <cfset add3= getCustomer.add3>
        <cfset add4= getCustomer.add4>
        <cfset country = getCustomer.country>
        <cfset postalCode= getCustomer.postalcode>
        <cfset attn= getCustomer.attn>
        <cfset phone= getCustomer.phone>
        <cfset hp= getCustomer.phonea>
        <cfset fax= getCustomer.fax>
        <cfset email= getCustomer.e_mail>
        
        <cfset d_add1= getCustomer.daddr1>
        <cfset d_add2= getCustomer.daddr2>
        <cfset d_add3= getCustomer.daddr3>
        <cfset d_add4= getCustomer.daddr4>
        <cfset d_country= getCustomer.d_country>
        <cfset d_postalCode= getCustomer.d_postalcode>
        <cfset d_attn= getCustomer.dattn>
        <cfset d_phone= getCustomer.dphone>
        <cfset d_hp= getCustomer.contact>
        <cfset d_fax= getCustomer.dfax>
        <cfset web_site= getCustomer.web_site>

		<cfset taxIncluded = getCustomer.taxincl_cust>
		<cfset GSTstatus = getCustomer.ngst_cust>
        <cfif getGsetup.ctycode EQ "IDR">          
        	<cfset gstWord = "NPWP">
            <cfset gstPlaceHolder = "Nomor pokok Wajib Pajak">  Goods and Services Tax
        <cfelse>
            <cfset gstWord = "GST">
            <cfset gstPlaceHolder = "#words[59]#"> 
        </cfif>
        <cfset gstno= getCustomer.gstno>
        <cfset taxCode= getCustomer.taxcode>
        <cfset salec= getCustomer.salec>
        <cfset salecnc= getCustomer.salecnc>
        <cfset currencyCode= getCustomer.currcode>
        <cfset currencySymbol= getCustomer.currency>
        <cfset currencyDesp= getCustomer.currency1>
        <cfset terms= getCustomer.term>
        <cfset creditLimit= getCustomer.crlimit>
        <cfset invoiceLimit= getCustomer.invlimit>
        
        <cfset discPercentageCategory= getCustomer.dispec_cat>
        <cfset discPercentageLvl_1= getCustomer.dispec1>
        <cfset discPercentageLvl_2= getCustomer.dispec2>
        <cfset discPercentageLvl_3= getCustomer.dispec3>
        <cfif url.target EQ "Customer">
			<cfset normalRate= getCustomer.normal_rate>
            <cfset offerRate= getCustomer.offer_rate>
            <cfset otherRate= getCustomer.others_rate>
        </cfif>    
        
        <cfset businessValue= getCustomer.business>
        <cfset areaSelected= getCustomer.area>
        <cfset driver= getCustomer.end_user> 
        <cfset createdDate= getCustomer.created_on>    
        <cfset remark1= getCustomer.arrem1>           
        <cfset remark2= getCustomer.arrem2>
        <cfset remark3= getCustomer.arrem3>
        <cfset remark4= getCustomer.arrem4> 
        <cfset remark5= getCustomer.arrem5> 
        <cfset remark6= getCustomer.arrem6> 
        <cfset remark7= getCustomer.arrem7> 
        <cfset remark8= getCustomer.arrem8> 
        <cfset remark9= getCustomer.arrem9> 
        <cfset remark10= getCustomer.arrem10>  
        <cfset gstappno= getCustomer.gstappno> 
        <cfset gst_valid_period= getCustomer.gst_valid_period> 
        <cfset gst_act_date= DateFormat(getCustomer.gst_act_date,"dd/mm/yyyy")> 
        <cfset gst_app_datefrom= DateFormat(getCustomer.gst_app_datefrom,"dd/mm/yyyy")> 
        <cfset gst_app_dateto= DateFormat(getCustomer.gst_app_dateto,"dd/mm/yyyy")>      
	</cfif>    
</cfif>

<cfset pageTitle="">

<cfif url.target EQ "Customer" AND url.action EQ "create">
	<cfset pageTitle="#words[14]#">
<cfelseif url.target EQ "Customer" AND url.action EQ "update">
	<cfset pageTitle="#words[97]#">
<cfelseif url.target EQ "Supplier" AND url.action EQ "create">
	<cfset pageTitle="#words[105]#">
<cfelseif url.target EQ "Supplier" AND url.action EQ "update">
	<cfset pageTitle="#words[115]#">
</cfif>

<cfset buttonStatus = "btn btn-primary active" >
<!---
<cfset buttonStatus2 = "btn btn-default" >--->

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!---<meta name="viewport" content="width=device-width, initial-scale=1.0">--->
<title><cfoutput>#pageTitle#</cfoutput></title>
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">
<link rel="stylesheet" type="text/css" href="/latest/css/maintenance/target.css">
<!--[if lt IE 9]>
	<script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
	<script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
<![endif]-->
<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>
<cfoutput>

<script>
	var Hlinkams='#Hlinkams#'
	var dts='#dts#';
	var target='#url.target#';
	var targetTitle='#targetTitle#';
	var targetTable='#targetTable#';
	var targetRangeTo='#words[22]#';
	<cfif url.target EQ "Customer">
		var codefr='#getGsetup.debtorfr#';
		var codeto='#getGsetup.debtorto#';
		var targetNumberRequired='#words[18]#';
		var targetNameRequired='#words[26]#';
		var targetFormat='#words[19]#';
		var targetSurfix='#words[20]#';
		var targetRange='#words[21]#';
		var targetDuplicateNumber='#words[315]#';
		var targetDuplicateName='#words[317]#';
		var custSuppNoStyle='#getGsetup.custSuppNo#';
	<cfelseif url.target EQ "Supplier">
		var codefr='#getGsetup.creditorfr#';
		var codeto='#getGsetup.creditorto#';
		var targetNumberRequired='#words[109]#';
		var targetNameRequired='#words[314]#';
		var targetFormat='#words[110]#';
		var targetSurfix='#words[111]#';
		var targetRange='#words[112]#';
		var targetDuplicateNumber='#words[316]#';
		var targetDuplicateName='#words[318]#';
		var custSuppNoStyle='#getGsetup.suppno#';
	</cfif>
	var action='#action#';
</script>

</cfoutput>
	<cfinclude template="/latest/filter/filterAgent.cfm">
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
	<script type="text/javascript" src="/latest/js/maintenance/target.js"></script>
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <script type="text/javascript">
        function GST_buttonStatus(){
    
            if(document.getElementById('nonGSTPart').style.display== 'none'){
                document.getElementById('nonGSTPart').style.display = 'block';
                document.getElementById('GSTpart').style.display = 'none';
				document.getElementById('GST_button').value = "T";	
            }
            
            else{
                document.getElementById('nonGSTPart').style.display = 'none';
                document.getElementById('GSTpart').style.display = 'block';
				document.getElementById('GST_button').value = "F";
            }
    	}
	</script>
</head>
<body>
<cfoutput>
	<div class="container">
		<div class="page-header">
			<h3>#pageTitle#</h3>
		</div>
		<form class="form-horizontal" role="form" action="#formAction#" method="post" onSubmit="document.getElementById('custno').disabled=false";>
			<input type="hidden" name="mode" value="#mode#">
			<div class="panel-group">
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##basicCollapse">
						<h4 class="panel-title accordion-toggle">#words[15]#</h4>
					</div>
					<div id="basicCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">								
									<div class="form-group">
										<label for="custno" class="col-sm-4 control-label">#targetNo#</label>
										<div class="col-sm-8">
											<div class="row">
												<div class="col-sm-12">
													<input type="text" class="form-control input-sm" id="custno" name="custno" autocomplete="off" placeholder="#targetFormat#" maxlength="8" <cfif IsDefined("url.action") AND url.action NEQ "create"> value="#custno#" disabled="true"</cfif>>
												</div>
											</div>
											<span class="help-block" style="display:none;"></span>											
										</div>
									</div>
									<div class="form-group">
										<label for="name" class="col-sm-4 control-label">#words[23]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="name" name="name" value="#name#" placeholder="#targetNameLine1#" maxlength="40">
										</div>
									</div>
									<div class="form-group">
										<label for="name2" class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="name2" name="name2" value="#name2#" placeholder="#targetNameLine2#" maxlength="40">
											<span class="help-block" style="display:none;"></span>
										</div>
									</div>
									<div class="form-group">
										<label for="comuen" class="col-sm-4 control-label">#words[27]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="comuen" name="comuen" value="#comuen#" placeholder="#words[28]#" maxlength="16">
										</div>
									</div>	
									<div class="form-group">
										<label for="agent" class="col-sm-4 control-label">#words[29]#</label>
										<div class="col-sm-8">
											<input type="hidden" id="agent" name="agent" class="agentFilter" value="#agent#" placeholder="#words[30]#" />
										</div>
									</div>  
									<div class="form-group">
										<label for="groupTo" class="col-sm-4 control-label">#words[31]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="groupTo" name="groupTo" value="#groupTo#" placeholder="#words[31]#" maxlength="8">
										</div>
									</div> 
                                    <div class="form-group">
										<label for="status" class="col-sm-4 control-label">#words[32]#</label>
										<div class="col-sm-8">
											<div class="row">
												<div class="col-sm-7">
													<div class="checkbox">	
														<input type="checkbox" value="0" id="status" name="status" <cfif status EQ 'B'>checked</cfif>>
													</div>													
												</div>
											</div>											
										</div>
									</div>                                                                  						
								</div>  
							</div>
						</div>
					</div>
				</div>
                
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##contactCollapse">
						<h4 class="panel-title accordion-toggle">#words[33]#</h4>
					</div>
					<div id="contactCollapse" class="panel-collapse collapse">
						<div class="panel-body">
							<div class="row">
                            	<div class="col-sm-6">
                                	<div class="form-group">
										<label for="attn" class="col-sm-4 control-label">#words[8]#</label>
										<div class="col-sm-8">
                                        	<input type="text" class="form-control input-sm" id="attn" name="attn" value="#attn#">
										</div>
									</div>
									<div class="form-group">
										<label for="add1" class="col-sm-4 control-label">#words[6]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="add1" name="add1" value="#add1#" placeholder="#words[34]#" maxlength="35">
										</div>
									</div>
									<div class="form-group">
										<label for="add2" class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="add2" name="add2" value="#add2#" placeholder="#words[35]#" maxlength="35">
										</div>
									</div>
									<div class="form-group">
										<label for="add3" class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="add3" name="add3" value="#add3#" placeholder="#words[36]#" maxlength="35">
										</div>
									</div>
									<div class="form-group">
										<label for="add4" class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="add4" name="add4" value="#add4#" placeholder="#words[37]#" maxlength="35">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-4 control-label"></label>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="country" name="country" value="#country#" placeholder="#words[38]#" maxlength="25">											
										</div>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="postalcode" name="postalcode" value="#postalcode#" placeholder="#words[39]#" maxlength="25">
										</div>
									</div>	
                                    <div class="form-group">
										<label for="phone" class="col-sm-4 control-label">#words[40]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="phone" name="phone" value="#phone#" placeholder="#words[41]#" maxlength="25">
										</div>
									</div>
                                    <div class="form-group">
										<label for="hp" class="col-sm-4 control-label">#words[42]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="hp" name="hp" value="#hp#" placeholder="#words[43]#" maxlength="25">
										</div>
									</div>
									<div class="form-group">
										<label for="fax" class="col-sm-4 control-label">#words[300]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="fax" name="fax" value="#fax#" placeholder="#words[44]#" maxlength="25">
										</div>
									</div>								
									<div class="form-group">
										<label for="email" class="col-sm-4 control-label">#words[45]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="email" name="email" value="#email#" placeholder="#words[46]#" maxlength="100">
										</div>
									</div>
                                </div>
                                <div class="col-sm-6">
                                	<div class="form-group">
										<label for="d_attn" class="col-sm-4 control-label">#words[47]#</label>
										<div class="col-sm-8">
                                        <input type="text" class="form-control input-sm" id="d_attn" name="d_attn" value="#d_attn#">
										</div>
									</div>
									<div class="form-group">
										<label for="d_add1" class="col-sm-4 control-label">#words[48]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="d_add1" name="d_add1" value="#d_add1#" placeholder="#words[34]#" maxlength="35">
										</div>
									</div>
									<div class="form-group">
										<label for="d_add2" class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="d_add2" name="d_add2" value="#d_add2#" placeholder="#words[35]#" maxlength="35">
										</div>
									</div>
									<div class="form-group">
										<label for="d_add3" class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="d_add3" name="d_add3" value="#d_add3#" placeholder="#words[36]#" maxlength="35">
										</div>
									</div>
									<div class="form-group">
										<label for="d_add4" class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="d_add4" name="d_add4" value="#d_add4#" placeholder="#words[37]#" maxlength="35">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-4 control-label"></label>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="d_country" name="d_country" value="#d_country#" placeholder="#words[38]#" maxlength="25">											
										</div>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="d_postalcode" name="d_postalcode" value="#d_postalcode#" placeholder="#words[39]#" maxlength="25">
										</div>
									</div>	
                                    <div class="form-group">
										<label for="d_phone" class="col-sm-4 control-label">#words[49]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="d_phone" name="d_phone" value="#d_phone#" placeholder="#words[41]#" maxlength="25">
										</div>
									</div>
                                    <div class="form-group">
										<label for="d_hp" class="col-sm-4 control-label">#words[50]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="d_hp" name="d_hp" value="#d_hp#" placeholder="#words[43]#" maxlength="25">
										</div>
									</div>
									<div class="form-group">
										<label for="d_fax" class="col-sm-4 control-label">#words[51]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="d_fax" name="d_fax" value="#d_fax#" placeholder="#words[44]#" maxlength="25">
										</div>
									</div>								
									<div class="form-group">
										<label for="web_site" class="col-sm-4 control-label">#words[52]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="web_site" name="web_site" value="#web_site#" placeholder="#words[46]#" maxlength="100">
										</div>
									</div>                                    
								</div>
							</div>
                            <div class="row">
                            	<div class="col-sm-5"></div> 
                                <div class="col-sm-6">
                                	<button type="button" class="btn btn-default copyBillingAddress">
                                        <i class="glyphicon glyphicon-transfer"></i>
                                        Copy Billing Address to Delivery Address
                                    </button>
                                </div>  
                                <div class="col-sm-1"></div>     
                            </div>
						</div>
                	</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##currencyCollapse">
						<h4 class="panel-title accordion-toggle">#words[301]#</h4>
					</div>
					<div id="currencyCollapse" class="panel-collapse collapse">
						<div class="panel-body">
							<div class="row">                            
								<div class="col-sm-6">
                                	<div class="form-group">
										<label for="taxIncluded" class="col-sm-4 control-label">#words[53]#</label>
										<div class="col-sm-8">
											<div class="row">
												<div class="col-sm-7">
													<div class="checkbox">	
														<input type="checkbox" value="T" id="taxIncluded" name="taxIncluded" <cfif taxIncluded EQ 'T'>checked</cfif>>
													</div>													
												</div>
											</div>											
										</div>
									</div>
                                	<div class="form-group">
										<label class="col-sm-4 control-label">#gstWord# #targetTitle#</label>
										<div class="col-sm-8">
											<div class="btn-group btn-toggle ngst">
                                            	<cfif GSTstatus EQ 'F'>
                                                	<cfset buttonStatus = "btn btn-primary active" >
                                                    <cfset buttonStatus2 = "btn btn-default" >
                                                <cfelseif GSTstatus EQ 'T' OR GSTstatus EQ ''>
                                                	<cfset buttonStatus = "btn btn-default" >
                                                    <cfset buttonStatus2 = "btn btn-primary active" >
                                                </cfif>
												<button type="button" name ="buttonYES" id="buttonYES" 
                                               		onClick="GST_buttonStatus()" class="#buttonStatus#">#words[54]#</button>
                                                    
												<button type="button" name ="buttonNO" id="buttonNO" 
                                                	onClick="GST_buttonStatus()" class="#buttonStatus2#">#words[55]#</button>  

                                                 <input type="hidden" name="GST_button" id="GST_button" value="#GSTstatus#">
											</div>
										</div>
									</div>
                                    <div id="GSTpart" <cfif GSTstatus EQ 'T'>style="display:none"</cfif>>
                                        <div class="form-group">
                                            <label for="gstno" class="col-sm-4 control-label">#gstWord# #words[58]#</label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="gstno" name="gstno" value="#gstno#" placeholder="#gstPlaceholder#" maxlength="16">
                                            </div>
                                        </div>	   
                                    </div>
                                    <div id="nonGSTPart" <cfif GSTstatus EQ 'F'>style="display:none"</cfif>>    
                                        <div class="form-group">
                                        <label for="taxCode" class="col-sm-4 control-label">#words[56]#</label>
                                            <div class="col-sm-4">
                                                <select class="form-control input-sm" id="taxCode" name="taxCode">
                                                    <option value="">#words[57]#</option>
                                                    <cfloop query="listTaxCode">
                                                        <option value="#listTaxCode.code#" data-symbol="#listTaxCode.code#" data-description="#listTaxCode.code#" <cfif listTaxCode.code EQ taxCode>selected</cfif>>#listTaxCode.code#</option>
                                                    </cfloop>
                                                </select>
                                            </div>
                                        </div>
                                    </div>	
                                    <cfif url.target EQ "Customer">
                                    	<cfset displayTitle1 = "#words[60]#">
                                        <cfset displayTitle2 = "#words[61]#">   
                                    <cfelse>
                                    	<cfset displayTitle1 = "#words[302]#">
                                        <cfset displayTitle2 = "#words[303]#">                                     
                                    </cfif>
                                    
                                    <div class="form-group">
										<label for="salec" class="col-sm-4 control-label">#displayTitle1#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="salec" name="salec" value="#salec#" placeholder="#displayTitle1#" maxlength="8">
										</div>
									</div>
									<div class="form-group">
										<label for="salecnc" class="col-sm-4 control-label">#displayTitle2#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="salecnc" name="salecnc" value="#salecnc#" placeholder="#displayTitle2#" maxlength="8">
										</div>
									</div>		
                                    
                                    <div class="form-group">
										<label for="salecnc" class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											
										</div>
									</div>		
                                    
                                    <cfif getmodulecontrol.malaysiagst EQ '1'>
                                        <div class="form-group">
                                            <label for="gst_act_date" class="col-sm-4 control-label">#words[304]#</label>
                                            <div class="col-sm-8">
                                                <div class="input-group date">
                                                    <input type="text" class="form-control input-sm" id="gst_act_date" name="gst_act_date" value="#gst_act_date#" placeholder="#words[304]#" maxlength="10">
                                                    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                                </div>
                                            </div>
                                        </div>	
                                         <div class="form-group">
                                            <label for="gst_valid_period" class="col-sm-4 control-label">#words[305]#</label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="gst_valid_period" name="gst_valid_period" value="#gst_valid_period#" placeholder="#words[306]#" maxlength="10">
                                            </div>
                                        </div>	
                                        <div class="form-group">
                                            <label for="gst_app_datefrom" class="col-sm-4 control-label">Self Billed GST Approval Date From</label>
                                            <div class="col-sm-8">
                                            <div class="input-group date">
                                                <input type="text" class="form-control input-sm" id="gst_app_datefrom" name="gst_app_datefrom" value="#gst_app_datefrom#" placeholder="#words[308]#" maxlength="10">
                                            	<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                            </div>
                                            </div>
                                        </div>
                                    <cfelse>
                                    	<input type="hidden" name="gst_act_date" id="gst_act_date" value="#gst_act_date#">
                                        <input type="hidden" name="gst_valid_period" id="gst_valid_period" value="#gst_valid_period#">
                                        <input type="hidden" name="gst_app_datefrom" id="gst_app_datefrom" value="#gst_app_datefrom#">
                                    </cfif>  					
								</div>     
								<div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="currcode" class="col-sm-4 control-label">#words[62]#</label>
                                        <div class="col-sm-4">
                                            <select class="form-control input-sm" id="currcode" name="currcode">
                                                <option value="">#words[63]#</option>
                                                <cfloop query="listCurrency">
                                                    <option value="#listCurrency.currcode#" data-symbol="#listCurrency.currency#" data-description="#listCurrency.currency1#" <cfif listCurrency.currcode EQ currencyCode>selected</cfif>>#listCurrency.currcode#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control input-sm" id="currency" name="currency" value="#currencySymbol#" placeholder="#words[64]#">
                                        </div>
                                    </div>	
                                    <div class="form-group">
                                        <label for="currency1" class="col-sm-4 control-label">#words[65]#</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control input-sm" id="currency1" name="currency1" value="#currencyDesp#" placeholder="#words[66]#">
                                        </div>
                                    </div>	
                                    <div class="form-group">
										<label for="terms" class="col-sm-4 control-label">#words[67]#</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" id="term" name="term">
												<option value="">#words[68]#</option>
												<cfloop query="listTerm">
													<option value="#listTerm.term#" <cfif listTerm.term EQ terms>selected</cfif>>#listTerm.term#</option>
												</cfloop>
											</select>
										</div>
									</div>
                                    <div class="form-group">
										<label for="creditLimit" class="col-sm-4 control-label">#words[69]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="creditLimit" name="creditLimit" value="#creditLimit#" placeholder="#words[69]#" value="0.00" />
										</div>
									</div>
									<div class="form-group">
										<label for="invoiceLimit" class="col-sm-4 control-label">#words[70]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="invoiceLimit" name="invoiceLimit" value="#invoiceLimit#" placeholder="#words[70]#" value="0.00" />
										</div>
									</div>
                                    
                                    <cfif getmodulecontrol.malaysiagst eq '1'>
                                    	<div class="form-group">
										<label for="gstappno" class="col-sm-4 control-label">#words[309]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="gstappno" name="gstappno" value="#gstappno#" placeholder="#words[310]#" value="" />
										</div>
										</div>
                                        <div class="form-group">
										<label for="gst_app_dateto" class="col-sm-4 control-label">#words[311]#</label>
										<div class="col-sm-8">
										<div class="input-group date">
                                        	<input type="text" class="form-control input-sm" id="gst_app_dateto" name="gst_app_dateto" value="#gst_app_dateto#" placeholder="#words[312]#" maxlength="10" />
											<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                        </div>
										</div>
                                    <cfelse>
                                    	<input type="hidden" name="gstappno" id="gstappno" value="#gstappno#">
                                        <input type="hidden" name="gst_app_dateto" id="gst_app_dateto" value="#gst_app_dateto#">
                                    </cfif>
                                    
								</div>  
							</div>
						</div>
					</div>
				</div> 
                <div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##discountCollapse">
						<h4 class="panel-title accordion-toggle">#words[71]#</h4>
					</div>
					<div id="discountCollapse" class="panel-collapse collapse">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">
									<div class="form-group">
										<label for="discPercentageCategory" class="col-sm-4 control-label">#words[72]#</label>
										<div class="col-sm-6">
                                       		<div class="input-group">
												<input type="text" class="form-control input-sm" id="discPercentageCategory" name="discPercentageCategory" value="#discPercentageCategory#" placeholder="#words[73]#" maxlength="40">
                                             	<span class="input-group-addon">%</span>
                                             </div>
										</div>
									</div>	
                                    <div class="form-group">
										<label for="discPercentageLvl_1" class="col-sm-4 control-label">#words[74]#</label>
										<div class="col-sm-6">
                                        	<div class="input-group">
												<input type="text" class="form-control input-sm" id="discPercentageLvl_1" name="discPercentageLvl_1" value="#discPercentageLvl_1#" placeholder="#words[75]#" maxlength="40">
                                            	<span class="input-group-addon">%</span>
                                            </div>
										</div>
									</div>
                                    <div class="form-group">
										<label for="discPercentageLvl_2" class="col-sm-4 control-label">#words[76]#</label>
										<div class="col-sm-6">
                                        	<div class="input-group">
												<input type="text" class="form-control input-sm" id="discPercentageLvl_2" name="discPercentageLvl_2" value="#discPercentageLvl_2#" placeholder="#words[77]#" maxlength="40">
                                            	<span class="input-group-addon">%</span>
                                            </div>    
										</div>
									</div>		
                                    <div class="form-group">
										<label for="discPercentageLvl_3" class="col-sm-4 control-label">#words[78]#</label>
										<div class="col-sm-6">
                                        	<div class="input-group">
												<input type="text" class="form-control input-sm" id="discPercentageLvl_3" name="discPercentageLvl_3" value="#discPercentageLvl_3#" placeholder="#words[79]#" maxlength="40">
                                            	<span class="input-group-addon">%</span>
                                            </div>    
										</div>
									</div>
								</div>
                                
                                <cfif url.target EQ "Customer">
                                <div class="col-sm-6">
									<div class="form-group">
										<label for="normalRate" class="col-sm-4 control-label">#words[80]#</label>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="normalRate" name="normalRate" value="#normalRate#" placeholder="#words[80]#" maxlength="10">
										</div>
									</div>	
                                    <div class="form-group">
										<label for="offerRate" class="col-sm-4 control-label">#words[81]#</label>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="offerRate" name="offerRate" value="#offerRate#" placeholder="#words[81]#" maxlength="10">
										</div>
									</div>
                                    <div class="form-group">
										<label for="otherRate" class="col-sm-4 control-label">#words[82]#</label>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="otherRate" name="otherRate" value="#otherRate#" placeholder="#words[82]#" maxlength="10">
										</div>
									</div>		
								</div>
                                </cfif>
                                
							</div>
						</div>
					</div>
				</div>
                
                <div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##remarkCollapse">
						<h4 class="panel-title accordion-toggle">Remark Information</h4>
					</div>
					<div id="remarkCollapse" class="panel-collapse collapse">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="remark1" class="col-sm-4 control-label">#words[91]#</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control input-sm" id="remark1" name="remark1" value="#remark1#" placeholder="#words[91]#">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="remark2" class="col-sm-4 control-label">#words[92]#</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control input-sm" id="remark2" name="remark2" value="#remark2#" placeholder="#words[92]#">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="remark3" class="col-sm-4 control-label">#words[93]#</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control input-sm" id="remark3" name="remark3" value="#remark3#" placeholder="#words[93]#">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="remark4" class="col-sm-4 control-label">#words[94]#</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control input-sm" id="remark4" name="remark4" value="#remark4#" placeholder="#words[94]#">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="remark5Label" class="col-sm-4 control-label">Remark 5</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control input-sm" id="remark5" name="remark5" value="#remark5#" placeholder="Remark 5">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="remark6Label" class="col-sm-4 control-label">Remark 6</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control input-sm" id="remark6" name="remark6" value="#remark6#" placeholder="Remark 6">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="remark7Label" class="col-sm-4 control-label">Remark 7</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control input-sm" id="remark7" name="remark7" value="#remark7#" placeholder="Remark 7">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="remark8Label" class="col-sm-4 control-label">Remark 8</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control input-sm" id="remark8" name="remark8" value="#remark8#" placeholder="Remark 8">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="remark9Label" class="col-sm-4 control-label">Remark 9</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control input-sm" id="remark9" name="remark9" value="#remark9#" placeholder="Remark 9">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="remark10Label" class="col-sm-4 control-label">Remark 10</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control input-sm" id="remark10" name="remark10" value="#remark10#" placeholder="Remark 10">
                                        </div>
                                    </div>
                                </div>
							</div>
						</div>
					</div>
				</div>

				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##businessCollapse">
						<h4 class="panel-title accordion-toggle">#words[83]#</h4>
					</div>
					<div id="businessCollapse" class="panel-collapse collapse">
						<div class="panel-body">
							<div class="row">
                            	<div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="business" class="col-sm-4 control-label">#words[84]#</label>
                                        <div class="col-sm-8">
                                            <select class="form-control input-sm" id="business" name="business">
                                                <option value="">#words[85]#</option>
                                                <cfloop query="listBusiness">
                                                    <option value="#listBusiness.business#" <cfif listBusiness.business EQ businessValue>selected</cfif>>#listBusiness.desp#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="area" class="col-sm-4 control-label">#words[86]#</label>
                                        <div class="col-sm-8">
                                            <select class="form-control input-sm" id="area" name="area">
                                                <option value="">#words[87]#</option>
                                                <cfloop query="listArea">
                                                    <option value="#listArea.area#" <cfif listArea.area EQ areaSelected>selected</cfif>>#listArea.area# - #listArea.desp#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>		
                                    <div class="form-group">
                                        <label for="driver" class="col-sm-4 control-label">#words[1358]#</label>
                                        <div class="col-sm-8">
                                            <select class="form-control input-sm" id="driver" name="driver">
                                                <option value="">#words[1838]#</option>
                                                <cfloop query="listDriver">
                                                    <option value="#listDriver.driverno#" <cfif listDriver.driverno EQ driver>selected</cfif>>#listDriver.driverno#--#listDriver.name#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="createdDateLabel" class="col-sm-4 control-label">#words[90]#</label>
                                        <div class="col-sm-8">
                                            <div class="input-group date">
                                                <cfif IsDefined("url.action") AND url.action EQ "create">
                                                    <cfset dateValue = NOW()>
                                                <cfelse> 
                                                    <cfset dateValue = createdDate>
                                                </cfif>        
                                                <input type="text" class="form-control input-sm" id="createdDate" name="createdDate" placeholder="#words[313]#" value="#DateFormat(dateValue,'dd/mm/yyyy')#" <cfif IsDefined("url.action") AND url.action NEQ "create"> disabled="true"</cfif>>
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div> 
                            	</div>           		
							</div>
						</div>
					</div>
				</div>
            
			<hr>
			<div class="pull-right">
				<button type="submit" class="btn btn-primary" id="submit">#actionWords#</button>
				<button type="button" class="btn btn-default" onClick="window.location='/latest/maintenance/custSuppProfile.cfm?target=#url.target#&menuID=#url.menuID#'">Cancel</button>
			</div>
		</form>		
	</div>
</cfoutput>
</body>
</html>