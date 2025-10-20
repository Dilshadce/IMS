<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "485,95,486,98,482,65,483,54,55,484,16,6,546,96,125">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.location')>
	<cfset URLlocation = trim(urldecode(url.location))>
</cfif>

<cfquery name="getfunctioncontrol" datasource="#dts#">
	SELECT * FROM functioncontrol
</cfquery>

<cfquery name="getproject" datasource="#dts#">
	SELECT * FROM #target_project#
	WHERE porj="P" and (completed="" or completed is null or completed="N" or completed="0")
</cfquery>

<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset pageTitle="#words[485]#">
		<cfset pageAction="#words[95]#">
		<cfset location = "">
        <cfset desp = "">
        <cfset consignmentOutlet = "">
        <cfset customerNo = "">
        <cfset add1 = "">
        <cfset add2 = "">
        <cfset add3 = "">
        <cfset add4 = ""> 
        <cfset xsource = ""> 
        
	<cfelseif url.action EQ "update">
		<cfset pageTitle="#words[486]#">
		<cfset pageAction="#words[98]#">
        <cfquery name="getLocation" datasource='#dts#'>
            SELECT * 
            FROM iclocation 
            WHERE location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLlocation#">;
		</cfquery>
		
		<cfset location = getLocation.location>
        <cfset desp = getLocation.desp>
        <cfset consignmentOutlet = getLocation.outlet>
        <cfset customerNo = getLocation.custno>
        <cfset add1 = getLocation.addr1>
        <cfset add2 = getLocation.addr2>
        <cfset add3 = getLocation.addr3>
        <cfset add4 = getLocation.addr4> 
	<cfset xsource = getLocation.source> 
                        
    <cfelseif url.action EQ "delete">
    	<cfset pageTitle="Delete Location Profile">
		<cfset pageAction="Delete">   
        
        <cfquery name="getLocation" datasource='#dts#'>
            SELECT * 
            FROM iclocation 
            WHERE location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLlocation#">;
		</cfquery>
		
		<cfset location = getLocation.location>
        <cfset desp = getLocation.desp>
        <cfset consignmentOutlet = getLocation.outlet>
        <cfset customerNo = getLocation.custno>
        <cfset add1 = getLocation.addr1>
        <cfset add2 = getLocation.addr2>
        <cfset add3 = getLocation.addr3>
        <cfset add4 = getLocation.addr4>   
	<cfset xsource = getLocation.source> 
	</cfif>
    
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#pageTitle#</cfoutput></title><!---
    <link rel="stylesheet" href="/latest/css/form.css" />--->
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/target.css">
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" type="text/javascript"></script>
    
	<cfinclude template="filterCustomer.cfm">
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
</head>

<body class="container">
<cfoutput>
<form class="formContainer form2Button" action="/latest/maintenance/locationProcess.cfm?action=#url.action#" method="post" onsubmit="document.getElementById('location').disabled=false";>
	<div class="page-header">
		<h3>#pageTitle#</h3>
	</div>
	<div class="panel-group">
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##panel1Collapse">
						<h4 class="panel-title accordion-toggle">#words[125]#</h4>
					</div>
                    <div id="panel1Collapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-8">      
                                 	<div class="form-group">
										<label for="location" class="col-sm-6 control-label">#words[482]#</label>
										<div class="col-sm-6">
											<input type="text" class="form-control input-sm" id="location" name="location" required="required" maxlength="20"
                    	<cfif IsDefined("url.action") AND url.action NEQ "create">  value="#URLlocation#"  disabled="true"</cfif>/>									
										</div>
									</div>
                                </div>
                             </div>
                             <div class="row">
								<div class="col-sm-8">
                                    <div class="form-group">
										<label for="desp" class="col-sm-6 control-label">#words[65]#</label>
										<div class="col-sm-6">
											<input type="text" class="form-control input-sm" id="desp" name="desp" value="#desp#" />                  							
										</div>
									</div>
                                </div>
                             </div>
                             <div class="row">
								<div class="col-sm-8">
                                    <div class="form-group">
										<label for="consignmentOutlet" class="col-sm-6 control-label">#words[483]#</label>
										<div class="col-sm-6">
											<select class="form-control input-sm" id="consignmentOutlet" name="consignmentOutlet">
                    	<option value="Y" <cfif consignmentOutlet EQ 'Y'>selected</cfif>>#words[54]#</option>
                      	<option value="N" <cfif consignmentOutlet EQ 'N'>selected</cfif>>#words[55]#</option>
                    						</select>  							
										</div>
									</div>
                                 </div>
                              </div>
                                    <cfif url.action EQ 'create'>
                              <div class="row">
								<div class="col-sm-8">
                                    <div class="form-group">
										<label for="" class="col-sm-6 control-label">#words[484]#</label>
										<div class="col-sm-6">
											<input type="checkbox" class="form-control input-sm" id="generateItem" checked name="generateItem" value="generate"/> 							
										</div>
									</div>
                                 </div>
                              </div>
            						</cfif>
                              <div class="row">
								<div class="col-sm-8">
                                    <div class="form-group">
										<label for="customerNo" class="col-sm-6 control-label">#words[16]#</label>
										<div class="col-sm-6">
											<input type="hidden" id="customerNo" name="customerNo" class="customerNo" data-placeholder="#customerNo#" />	 							
										</div>
									</div>
                                 </div>
                              </div>
                              <div class="row">
								<div class="col-sm-8">
                                    
                                    <div class="form-group">
										<label for="add1" class="col-sm-6 control-label">#words[6]#</label>
										<div class="col-sm-6">
											<input type="text" class="form-control input-sm" id="add1" name="add1" value="#add1#" maxlength="40" />     
										</div>
									</div>
                                 </div>
                              </div>
                              <div class="row">
								<div class="col-sm-8">      
                                    <div class="form-group">
										<label for="add2" class="col-sm-6 control-label"></label>
										<div class="col-sm-6">
											<input type="text" class="form-control input-sm" id="add2" name="add2" value="#add2#" maxlength="40" />         
										</div>
									</div>
                                 </div>
                              </div>
                              <div class="row">
								<div class="col-sm-8">
                                    <div class="form-group">
										<label for="add3" class="col-sm-6 control-label"></label>
										<div class="col-sm-6">
											<input type="text" class="form-control input-sm" id="add3" name="add3" value="#add3#" maxlength="40" />       
										</div>
									</div>
                                 </div>
                              </div>
                              
                              <div class="row">
								<div class="col-sm-8">      
                                    <div class="form-group">
										<label for="add4" class="col-sm-6 control-label"></label>
										<div class="col-sm-6">
											<input type="text" class="form-control input-sm" id="add4" name="add4" value="#add4#" maxlength="40" />        
										</div>
									</div>
                                 </div>
                              </div>
			      <div class="row">
								<div class="col-sm-8">      
                                    <div class="form-group">
										<label for="source" class="col-sm-6 control-label">Choose a Project</label>
										<div class="col-sm-6">
											<select id="source" name="source" class="form-control input-sm">
												<option value="">Choose a Project</option>
												<cfloop query="getproject">
													<option value="#getproject.source#" <cfif xsource eq getproject.source>selected</cfif>>#getproject.source# - #getproject.project#</option>
												</cfloop>
											</select>     
										</div>
									</div>
                                 </div>
                              </div>
                                    <cfif url.action NEQ 'create'>
                              <div class="row">
								<div class="col-sm-8">
                                    <div class="form-group">
										<label for="discontinueLocation" class="col-sm-6 control-label">#words[546]#</label>
										<div class="col-sm-6">
											<input type="checkbox" class="form-control input-sm" id="discontinueLocation" name="discontinueLocation" <cfif IsDefined("url.action") AND url.action NEQ "create"><cfif getLocation.noactivelocation eq 'T'>checked</cfif></cfif> />      
										</div>
									</div>
                                 </div>
                              </div>
                                    </cfif>
                    </div>
                </div>
		</div>
	</div>
    
    <cfif getfunctioncontrol.refnobylocation eq "Y" and url.action NEQ 'create'>
    <cfquery name="getlocationrefnoset" datasource="#dts#">
    	SELECT * FROM refnoset_location WHERE location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLlocation#">;
    </cfquery>
    
    <cfif getlocationrefnoset.recordcount eq 0>
    
    <cfset billlist='QUO,SO,DO,INV,CS,CN,DN,PO,PR,RC,RQ,SAM,DEP'>
    
    <cfloop list="#billlist#" index="i" delimiters=",">
    
    <cfquery name="insertlocationrefno" datasource="#dts#">
    	INSERT IGNORE INTO refnoset_location (location,type,lastusedno,refnoused) VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLlocation#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#i#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#left(location,1)##i#0000000">,'1')
    </cfquery>
    
    </cfloop>
    
    <cfquery name="getlocationrefnoset" datasource="#dts#">
    	SELECT * from refnoset_location where location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLlocation#">;
    </cfquery>
    
    </cfif>
    
    
    
    <!---Location Reference--->
    <div class="panel-group">
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##panel1Collapse">
						<h4 class="panel-title accordion-toggle">Reference No Set</h4>
					</div>
                    <div id="panel1Collapse" class="panel-collapse collapse in">
						<div class="panel-body">
                        	<cfloop query="getlocationrefnoset">
							<div class="row">
								<div class="col-sm-9">      
                                 	<div class="form-group">
										<label for="Invoice" class="col-sm-4 control-label">#type#</label>
										<div class="col-sm-6">
											<input type="text" class="form-control input-sm" id="refno_#type#" name="refno_#type#" required="required" maxlength="25" value="#lastusedno#" />									
										</div>
                                        <div class="col-sm-2">
											<input type="checkbox" class="form-control input-sm" id="activate_#type#" name="activate_#type#" <cfif getlocationrefnoset.activate eq 'T'>checked</cfif> />						
										</div>
                                        
                                        
									</div>
                                </div>
                             </div>
                             </cfloop>
                      </div>
                </div>
            </div>
        </div>
    
    
    <!---End Location Reference--->
    </cfif>
	<div>
		<input type="submit" value="#pageAction#" />
		<input type="button" value="#words[96]#" onclick="window.location='/latest/maintenance/locationProfile.cfm'" />
	</div>
</form>
</cfoutput>
</body>
</html>