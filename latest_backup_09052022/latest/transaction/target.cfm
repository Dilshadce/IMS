<cfif IsDefined('url.custno')>
	<cfset URLcustno = trim(urldecode(url.custno))>
</cfif>

<cfquery name="getGsetup" datasource="#dts#">
	SELECT *
	FROM gsetup;
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

<cfquery name="listCustomerRemark" datasource="#dts#">
	SELECT * 
	FROM extraremark;
</cfquery>

<cfquery name="listAttention" datasource="#dts#">
	SELECT attentionno,name 
	FROM attention;
</cfquery>

<cfquery name="listTaxCode" datasource="#dts#">
	SELECT *
	FROM #target_taxtable#
    WHERE tax_type IN ('T','ST')
    AND rate1 = '0';
</cfquery>

<cfquery name="listDriver" datasource="#dts#">
	SELECT *
	FROM driver
    ORDER BY driverno;
</cfquery>

<cfif url.target EQ "Customer">
	<cfset targetTitle="Customer">
	<cfset targetTable=target_arcust>
	<cfset codefr=getGsetup.debtorfr>
	<cfset formAction="/latest/maintenance/customerProcess.cfm">
<cfelseif url.target EQ "Supplier">
	<cfset targetTitle="Supplier">
	<cfset targetTable=target_apvend>
	<cfset codefr=getGsetup.creditorfr>
	<cfset formAction="/latest/maintenance/supplierProcess.cfm">
</cfif>

<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset action="Create">
		<cfset mode="create">
             
        <cfset custno = "">
        <cfset name= "">
        <cfset name2= "">
        <cfset comuen= "">
        <cfset agent= "">
        <cfset groupTo= "">
        <cfset status= "">
        <cfset autopay= "">
        
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
        <cfset d_email= "">
		
        <cfset GSTstatus = 'T'>

        <cfset gstno= "">
        <cfset taxCode= "">
        <cfset salec= "">
        <cfset salecnc= "">
        <cfset currencyCode= "">
        <cfset currencySymbol= "">
        <cfset currencyDesp= "">
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
        
        <cfset business= "">
        <cfset areaSelected= "">
        <cfset driver= "">  
        <cfset createdDate= "">  
        <cfset remark1= "">           
        <cfset remark2= "">
        <cfset remark3= "">
        <cfset remark4= ""> 
        
	<cfelseif url.action EQ "update">
		<cfset action="Update">
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
        
        <cfset custno = getCustomer.custno>
        <cfset name= getCustomer.name>
        <cfset name2= getCustomer.name2>
        <cfset comuen= getCustomer.comuen>
        <cfset agent= getCustomer.agent>
        <cfset groupTo= getCustomer.groupto>
        <cfset status= getCustomer.status>
        <cfset autopay= getCustomer.autopay>
        
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
        <cfset d_email= getCustomer.web_site>
		
        <cfset GSTstatus = getCustomer.ngst_cust>
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
        
        <cfset business= getCustomer.business>
        <cfset areaSelected= getCustomer.area>
        <cfset driver= getCustomer.end_user> 
        <cfset createdDate= getCustomer.date>    
        <cfset remark1= getCustomer.arrem1>           
        <cfset remark2= getCustomer.arrem2>
        <cfset remark3= getCustomer.arrem3>
        <cfset remark4= getCustomer.arrem4>       
	                        
    <cfelseif url.action EQ "delete">
    	<cfset action="Delete">
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
        
        <cfset custno = getCustomer.custno>
        <cfset name= getCustomer.name>
        <cfset name2= getCustomer.name2>
        <cfset comuen= getCustomer.comuen>
        <cfset agent= getCustomer.agent>
        <cfset groupTo= getCustomer.groupto>
        <cfset status= getCustomer.status>
        <cfset autopay= getCustomer.autopay>
        
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
        <cfset d_email= getCustomer.web_site>

		<cfset GSTstatus = getCustomer.ngst_cust>
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
        
        <cfset business= getCustomer.business>
        <cfset areaSelected= getCustomer.area>
        <cfset driver= getCustomer.end_user> 
        <cfset createdDate= getCustomer.date>    
        <cfset remark1= getCustomer.arrem1>           
        <cfset remark2= getCustomer.arrem2>
        <cfset remark3= getCustomer.arrem3>
        <cfset remark4= getCustomer.arrem4> 
           
	</cfif>
    
</cfif>

<cfset buttonStatus = "btn btn-primary active" >
<cfset buttonStatus2 = "btn btn-default" >

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!---<meta name="viewport" content="width=device-width, initial-scale=1.0">--->
<title><cfoutput>#action# #targetTitle#</cfoutput></title>
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
	var dts='#dts#';
	var target='#url.target#';
	var targetTitle='#targetTitle#';
	var targetTable='#targetTable#';
	<cfif url.target EQ "Customer">
		var codefr='#getGsetup.debtorfr#';
		var codeto='#getGsetup.debtorto#'
	<cfelseif url.target EQ "Supplier">
		var codefr='#getGsetup.creditorfr#';
		var codeto='#getGsetup.creditorto#';
	</cfif>
	var action='#action#';
</script>

</cfoutput>
	<script type="text/javascript" src="/latest/js/maintenance/target.js"></script>
    <cfinclude template="/latest/maintenance/filter/filterAgent.cfm">
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <script type="text/javascript">
        function GST_buttonStatus(){
    
            if(document.getElementById('nonGSTPart').style.display== 'none'){
                document.getElementById('nonGSTPart').style.display = 'block';
                document.getElementById('GSTpart').style.display = 'none';
				document.getElementById('GST_button').value = "N";	
            }
            
            else{
                document.getElementById('nonGSTPart').style.display = 'none';
                document.getElementById('GSTpart').style.display = 'block';
				document.getElementById('GST_button').value = "Y";
            }
    	}
	</script>
</head>
<body>
<cfoutput>
	<div class="container">
		<div class="page-header">
			<h3>#action# #targetTitle#</h3>
		</div>
		<form class="form-horizontal" role="form" action="#formAction#?action=#url.action#" method="post" onsubmit="document.getElementById('custno').disabled=false";>
			<input type="hidden" name="mode" value="#mode#">
			<div class="panel-group">
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##basicCollapse">
						<h4 class="panel-title accordion-toggle">Basic Information</h4>
					</div>
					<div id="basicCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">								
									<div class="form-group">
										<label for="custno" class="col-sm-4 control-label">#targetTitle# No.</label>
										<div class="col-sm-8">
											<div class="row">
												<div class="col-sm-5">
													<input type="text" class="form-control input-sm" id="custno" name="custno" placeholder="XXXX/XXX" maxlength="8" <cfif IsDefined("url.action") AND url.action NEQ "create"> value="#custno#" disabled="true"</cfif>>
												</div>
												<div class="col-sm-7">
													<div class="checkbox">
														<label>
															<input type="checkbox" value="0" id="autopay" name="autopay" <cfif autopay EQ 'Y'>checked</cfif>>
															Open Item #targetTitle#
														</label>
													</div>													
												</div>
											</div>
											<span class="help-block" style="display:none;"></span>											
										</div>
									</div>
									<div class="form-group">
										<label for="name" class="col-sm-4 control-label">Name</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="name" name="name" value="#name#" placeholder="#targetTitle# Name Line 1" maxlength="40">
										</div>
									</div>
									<div class="form-group">
										<label for="name2" class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="name2" name="name2" value="#name2#" placeholder="#targetTitle# Name Line 2" maxlength="40">
											<span class="help-block" style="display:none;"></span>
										</div>
									</div>
									<div class="form-group">
										<label for="comuen" class="col-sm-4 control-label">Company UEN</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="comuen" name="comuen" value="#comuen#" placeholder="Company UEN Numbers" maxlength="16">
										</div>
									</div>	
									<div class="form-group">
										<label for="agent" class="col-sm-4 control-label">Agent</label>
										<div class="col-sm-8">
											<cfif agent neq ''>
                                                <cfset displayValue = agent>   
                                            <cfelse>
                                                <cfset displayValue = "Choose an Agent">
                                            </cfif>
											<input type="hidden" id="agent" name="agent" class="agentFilter" data-placeholder="#displayValue#" />
										</div>
									</div>  
									<div class="form-group">
										<label for="groupTo" class="col-sm-4 control-label">Group To</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="groupTo" name="groupTo" value="#groupTo#" placeholder="Group To" maxlength="8">
										</div>
									</div> 
                                    <div class="form-group">
										<label for="status" class="col-sm-4 control-label">Bad Status</label>
										<div class="col-sm-8">
											<div class="row">
												<div class="col-sm-7">
													<div class="checkbox">	
														<input type="checkbox" value="0" id="status" name="status" <cfif status EQ 'Y'>checked</cfif>>
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
						<h4 class="panel-title accordion-toggle">Contact Information</h4>
					</div>
					<div id="contactCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
                            	<div class="col-sm-6">
									<div class="form-group">
										<label for="add1" class="col-sm-4 control-label">Address</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="add1" name="add1" value="#add1#" placeholder="Street Address" maxlength="35">
										</div>
									</div>
									<div class="form-group">
										<label for="add2" class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="add2" name="add2" value="#add2#" placeholder="Apt, Suite, Bldg." maxlength="35">
										</div>
									</div>
									<div class="form-group">
										<label for="add3" class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="add3" name="add3" value="#add3#" placeholder="Additional Address Information" maxlength="35">
										</div>
									</div>
									<div class="form-group">
										<label for="add4" class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="add4" name="add4" value="#add4#" placeholder="Town/City" maxlength="35">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-4 control-label"></label>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="country" name="country" value="#country#" placeholder="Country" maxlength="25">											
										</div>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="postalcode" name="postalcode" value="#postalcode#" placeholder="Postal Code" maxlength="25">
										</div>
									</div>
                                    <div class="form-group">
										<label for="attn" class="col-sm-4 control-label">Attention</label>
										<div class="col-sm-8">
                                            <select class="form-control input-sm" id="attn" name="attn">
                                                <option value="">Choose an Attention</option>
                                                <cfloop query="listAttention">
                                                    <option value="#listAttention.attentionno#" <cfif listAttention.attentionno EQ attn>selected</cfif>>#listAttention.name#</option>
                                                </cfloop>
											</select>
										</div>
									</div>	
                                    <div class="form-group">
										<label for="phone" class="col-sm-4 control-label">Phone</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="phone" name="phone" value="#phone#" placeholder="Primary Phone Number" maxlength="25">
										</div>
									</div>
                                    <div class="form-group">
										<label for="hp" class="col-sm-4 control-label">HP</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="hp" name="hp" value="#hp#" placeholder="Mobile Number" maxlength="25">
										</div>
									</div>
									<div class="form-group">
										<label for="fax" class="col-sm-4 control-label">Fax</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="fax" name="fax" value="#fax#" placeholder="Fax Number" maxlength="25">
										</div>
									</div>								
									<div class="form-group">
										<label for="email" class="col-sm-4 control-label">Email</label>
										<div class="col-sm-8">
											<input type="email" class="form-control input-sm" id="email" name="email" value="#email#" placeholder="Email Address" maxlength="100">
										</div>
									</div>
                                </div>
                                <div class="col-sm-6">
									<div class="form-group">
										<label for="d_add1" class="col-sm-4 control-label">Delivery Address</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="d_add1" name="d_add1" value="#d_add1#" placeholder="Street Address" maxlength="35">
										</div>
									</div>
									<div class="form-group">
										<label for="d_add2" class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="d_add2" name="d_add2" value="#d_add2#" placeholder="Apt, Suite, Bldg." maxlength="35">
										</div>
									</div>
									<div class="form-group">
										<label for="d_add3" class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="d_add3" name="d_add3" value="#d_add3#" placeholder="Additional Address Information" maxlength="35">
										</div>
									</div>
									<div class="form-group">
										<label for="d_add4" class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="d_add4" name="d_add4" value="#d_add4#" placeholder="Town/City" maxlength="35">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-4 control-label"></label>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="d_country" name="d_country" value="#d_country#" placeholder="Country" maxlength="25">											
										</div>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="d_postalcode" name="d_postalcode" value="#d_postalcode#" placeholder="Postal Code" maxlength="25">
										</div>
									</div>
                                    <div class="form-group">
										<label for="d_attn" class="col-sm-4 control-label">Delivery Attention</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" id="d_attn" name="d_attn">
                                                <option value="">Choose a Delivery Attention</option>
                                                <cfloop query="listAttention">
                                                    <option value="#listAttention.attentionno#" <cfif listAttention.attentionno EQ d_attn>selected</cfif>>#listAttention.name#</option>
                                                </cfloop>
											</select>
										</div>
									</div>	
                                    <div class="form-group">
										<label for="d_phone" class="col-sm-4 control-label">Delivery Phone</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="d_phone" name="d_phone" value="#d_phone#" placeholder="Primary Phone Number" maxlength="25">
										</div>
									</div>
                                    <div class="form-group">
										<label for="d_hp" class="col-sm-4 control-label">Delivery HP</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="d_hp" name="d_hp" value="#d_hp#" placeholder="Mobile Number" maxlength="25">
										</div>
									</div>
									<div class="form-group">
										<label for="d_fax" class="col-sm-4 control-label">Delivery Fax</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="d_fax" name="d_fax" value="#d_fax#" placeholder="Fax Number" maxlength="25">
										</div>
									</div>								
									<div class="form-group">
										<label for="d_email" class="col-sm-4 control-label">Delivery Email</label>
										<div class="col-sm-8">
											<input type="email" class="form-control input-sm" id="d_email" name="d_email" value="#d_email#" placeholder="Email Address" maxlength="100">
										</div>
									</div>                                    
								</div>
							</div>
						</div>
                	</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##currencyCollapse">
						<h4 class="panel-title accordion-toggle">Financial Information</h4>
					</div>
					<div id="currencyCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">                            
								<div class="col-sm-6">
                                	<div class="form-group">
										<label class="col-sm-4 control-label">GST #targetTitle#</label>
										<div class="col-sm-8">
											<div class="btn-group btn-toggle ngst">
                                            	<cfif GSTstatus EQ 'F'>
                                                	<cfset buttonStatus = "btn btn-primary active" >
                                                    <cfset buttonStatus2 = "btn btn-default" >
                                                <cfelseif GSTstatus EQ 'T' >
                                                	<cfset buttonStatus = "btn btn-default" >
                                                    <cfset buttonStatus2 = "btn btn-primary active" >
                                                </cfif>
												<button type="button" name ="buttonYES" id="buttonYES" 
                                               		onClick="GST_buttonStatus()" class="#buttonStatus#">Yes</button>
                                                    
												<button type="button" name ="buttonNO" id="buttonNO" 
                                                	onClick="GST_buttonStatus()" class="#buttonStatus2#">No</button>
                                                    
												<cfif GSTstatus EQ 'T'>
                                                    <input type="hidden" name="GST_button" id="GST_button" value="T">
                                                <cfelse>
                                                    <input type="hidden" name="GST_button" id="GST_button" value="F">    
                                                </cfif>
											</div>
										</div>
									</div>
                                    <div id="GSTpart" <cfif GSTstatus EQ 'T'>style="display:none"</cfif>>
                                        <div class="form-group">
                                            <label for="gstno" class="col-sm-4 control-label">GST No.</label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="gstno" name="gstno" value="#gstno#" placeholder="Goods and Services Tax Numbers" maxlength="16">
                                            </div>
                                        </div>	   
                                    </div>
                                    <div id="nonGSTPart" <cfif GSTstatus EQ 'F'>style="display:none"</cfif>>    
                                        <div class="form-group">
                                        <label for="taxCode" class="col-sm-4 control-label">Tax Code</label>
                                            <div class="col-sm-4">
                                                <select class="form-control input-sm" id="taxCode" name="taxCode">
                                                    <option value="">Choose a Tax Code</option>
                                                    <cfloop query="listTaxCode">
                                                        <option value="#listTaxCode.code#" data-symbol="#listTaxCode.code#" data-description="#listTaxCode.code#" <cfif listTaxCode.code EQ taxCode>selected</cfif>>#listTaxCode.code#</option>
                                                    </cfloop>
                                                </select>
                                            </div>
                                        </div>
                                    </div>	
                                    <cfif url.target EQ "Customer">
                                    	<cfset displayTitle1 = "Credit Sales Code">
                                        <cfset displayTitle2 = "Sales Return Code">   
                                    <cfelse>
                                    	<cfset displayTitle1 = "Purchase Code">
                                        <cfset displayTitle2 = "Purchase Return Code">                                     
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
								</div>     
								<div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="currcode" class="col-sm-4 control-label">Code & Symbol</label>
                                        <div class="col-sm-4">
                                            <select class="form-control input-sm" id="currcode" name="currcode">
                                                <option value="">Choose a Currency</option>
                                                <cfloop query="listCurrency">
                                                    <option value="#listCurrency.currcode#" data-symbol="#listCurrency.currency#" data-description="#listCurrency.currency1#" <cfif listCurrency.currcode EQ currencyCode>selected</cfif>>#listCurrency.currcode#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                        <div class="col-sm-4">
                                            <input type="text" class="form-control input-sm" id="currency" name="currency" value="#currencySymbol#" placeholder="Currency Symbol">
                                        </div>
                                    </div>	
                                    <div class="form-group">
                                        <label for="currency1" class="col-sm-4 control-label">Description</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control input-sm" id="currency1" name="currency1" value="#currencySymbol#" placeholder="Currency Description">
                                        </div>
                                    </div>	
                                   
                                    
                                    <!---
                                    
                                    <div class="form-group">
									<label for="currencyCode" class="col-sm-4 control-label">Code & Symbol</label>
										<div class="col-sm-4">
											<select class="form-control input-sm" id="currencyCode" name="currencyCode">
												<option value="">Choose a Currency</option>
												<cfloop query="listCurrency">
													<option value="#listCurrency.currcode#" data-symbol="#listCurrency.currency#" data-description="#listCurrency.currency1#" <cfif listCurrency.currcode EQ currencyCode>selected</cfif>>#listCurrency.currcode#</option>
												</cfloop>
											</select>
										</div>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="currencySymbol" name="currencySymbol" <!---value="#currencySymbol#" ---> data-placeholder="Currency Symbol">
										</div>
									</div>
									<div class="form-group">
										<label for="currencyDesp" class="col-sm-4 control-label">Description</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="currencyDesp" name="currencyDesp" <!--- value="#currencyDesp#" ---> data-placeholder="Currency Description">
										</div>
									</div>
                                    
                                    --->
                                    
                                    
                                    <div class="form-group">
										<label for="terms" class="col-sm-4 control-label">Terms</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" id="term" name="term">
												<option value="">Choose a Terms</option>
												<cfloop query="listTerm">
													<option value="#listTerm.term#" <cfif listTerm.term EQ terms>selected</cfif>>#listTerm.term#</option>
												</cfloop>
											</select>
										</div>
									</div>
                                    <div class="form-group">
										<label for="creditLimit" class="col-sm-4 control-label">Credit Limit</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="creditLimit" name="creditLimit" value="#creditLimit#" placeholder="Credit Limit" value="0.00" />
										</div>
									</div>
									<div class="form-group">
										<label for="invoiceLimit" class="col-sm-4 control-label">Invoice Limit</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="invoiceLimit" name="invoiceLimit" value="#invoiceLimit#" placeholder="Invoice Limit" value="0.00" />
										</div>
									</div>
								</div>  
							</div>
						</div>
					</div>
				</div> 
                <div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##discountCollapse">
						<h4 class="panel-title accordion-toggle">Discount Information</h4>
					</div>
					<div id="discountCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">
									<div class="form-group">
										<label for="discPercentageCategory" class="col-sm-4 control-label">Discount Percentage Category</label>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="discPercentageCategory" name="discPercentageCategory" value="#discPercentageCategory#" placeholder="Discount Percentage Category" maxlength="40">
										</div>
									</div>	
                                    <div class="form-group">
										<label for="discPercentageLvl_1" class="col-sm-4 control-label">Discount Percentage Level 1</label>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="discPercentageLvl_1" name="discPercentageLvl_1" value="#discPercentageLvl_1#" placeholder="Discount Percentage Level 1" maxlength="40">
										</div>
									</div>
                                    <div class="form-group">
										<label for="discPercentageLvl_2" class="col-sm-4 control-label">Discount Percentage Level 2</label>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="discPercentageLvl_2" name="discPercentageLvl_2" value="#discPercentageLvl_2#" placeholder="Discount Percentage Level 2" maxlength="40">
										</div>
									</div>		
                                    <div class="form-group">
										<label for="discPercentageLvl_3" class="col-sm-4 control-label">Discount Percentage Level 3</label>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="discPercentageLvl_3" name="discPercentageLvl_3" value="#discPercentageLvl_3#" placeholder="Discount Percentage Level 3" maxlength="40">
										</div>
									</div>
								</div>
                                
                                <cfif url.target EQ "Customer">
                                <div class="col-sm-6">
									<div class="form-group">
										<label for="normalRate" class="col-sm-4 control-label">Normal Rate</label>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="normalRate" name="normalRate" value="#normalRate#" placeholder="Normal Rate" maxlength="10">
										</div>
									</div>	
                                    <div class="form-group">
										<label for="offerRate" class="col-sm-4 control-label">Offer Rate</label>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="offerRate" name="offerRate" value="#offerRate#" placeholder="Offer Rate" maxlength="10">
										</div>
									</div>
                                    <div class="form-group">
										<label for="otherRate" class="col-sm-4 control-label">Other Rate</label>
										<div class="col-sm-4">
											<input type="text" class="form-control input-sm" id="otherRate" name="otherRate" value="#otherRate#" placeholder="Other Rate" maxlength="10">
										</div>
									</div>		
								</div>
                                </cfif>
                                
							</div>
						</div>
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##businessCollapse">
						<h4 class="panel-title accordion-toggle">Other Information</h4>
					</div>
					<div id="businessCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">
									<div class="form-group">
										<label for="business" class="col-sm-4 control-label">Business Nature</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" id="business" name="business">
												<option value="">Choose a Business Nature</option>
												<cfloop query="listBusiness">
													<option value="#listBusiness.business#" <cfif listBusiness.business EQ business>selected</cfif>>#listBusiness.desp#</option>
												</cfloop>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label for="area" class="col-sm-4 control-label">Area</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" id="area" name="area">
												<option value="">Choose an Area</option>
												<cfloop query="listArea">
													<option value="#listArea.area#" <cfif listArea.area EQ areaSelected>selected</cfif>>#listArea.area# - #listArea.desp#</option>
												</cfloop>
											</select>
										</div>
									</div>		
                                    <div class="form-group">
										<label for="driver" class="col-sm-4 control-label">#getGsetup.ldriver#</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" id="driver" name="driver">
												<option value="">Choose a #getGsetup.ldriver#</option>
												<cfloop query="listDriver">
													<option value="#listDriver.driverno#" <cfif listDriver.driverno EQ driver>selected</cfif>>#listDriver.driverno#--#listDriver.name#</option>
												</cfloop>
											</select>
										</div>
									</div>
                                    <div class="form-group">
										<label for="createdDate" class="col-sm-4 control-label">Created Date</label>
										<div class="col-sm-8">
											<div class="input-group date">
                                    			<cfif IsDefined("url.action") AND url.action EQ "create">
                                                	<cfset dateValue = NOW()>
                                                <cfelse> 
                                                	<cfset dateValue = createdDate>
												</cfif>        
												<input type="text" class="form-control input-sm" id="createdDate" name="createdDate" placeholder="Account Created Date" value="#DateFormat(dateValue,'dd/mm/yyyy')#" <cfif IsDefined("url.action") AND url.action NEQ "create"> disabled="true"</cfif>>
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
											</div>
										</div>
									</div>    		
								</div>
								<div class="col-sm-6">
									<div class="form-group">
										<label for="remark1" class="col-sm-4 control-label">Remark 1</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="remark1" name="remark1" value="#remark1#" placeholder="Remark 1" maxlength="40">
										</div>
									</div>
									<div class="form-group">
										<label for="remark2" class="col-sm-4 control-label">Remark 2</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="remark2" name="remark2" value="#remark2#" placeholder="Remark 2" maxlength="40">
										</div>
									</div>
                                    <div class="form-group">
										<label for="remark3" class="col-sm-4 control-label">Remark 3</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="remark3" name="remark3" value="#remark3#" placeholder="Remark 3" maxlength="40">
										</div>
									</div>
                                    <div class="form-group">
										<label for="remark4" class="col-sm-4 control-label">Remark 4</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="remark4" name="remark4" value="#remark4#" placeholder="Remark 4" maxlength="40">
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
            
			<hr>
			<div class="pull-right">
				<button type="submit" class="btn btn-primary" id="submit">#action#</button>
				<button type="button" class="btn btn-default" onclick="window.location='/latest/maintenance/custSuppProfile.cfm?type=#url.target#'" >Cancel</button>
			</div>
		</form>		
	</div>
</cfoutput>
</body>
</html>