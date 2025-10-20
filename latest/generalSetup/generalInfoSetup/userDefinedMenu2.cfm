<cfset pageTitle="Update Menu">
<cfset pageAction="Update">
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!---<meta name="viewport" content="width=device-width, initial-scale=1.0">--->

    <title>#pageTitle#</title>
	<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-datepicker/datepicker3.css">
	<link rel="stylesheet" type="text/css" href="/latest/css/maintenance/target.css">
    <!--[if lt IE 9]>
        <script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
        <script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
</head>

<body class="container">
<cfoutput>
	<form class="form-horizontal" role="form" id="userDefinedMenuForm" name="userDefinedMenuForm" action="userDefinedMenuProcess.cfm" method="post";>
        <div class="page-header">
            <h3>#pageTitle#</h3>
        </div>
        	<input type="hidden" id="companyID" name="companyID" value="#companyID#" />
            <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading" data-toggle="collapse" href="##mainInfoCollapse">
                            <h4 class="panel-title accordion-toggle">Main Information</h4>
                        </div>
                        <div id="mainInfoCollapse" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-6">							
                                        <div class="form-group">
                                            <label for="compro" class="col-sm-4 control-label">Company Name</label>
                                            <div class="col-sm-8">			
                                                <input type="text" class="form-control input-sm" id="compro" name="compro" value="#compro#" placeholder="Company Name" required maxlength="80"/>										
                                            </div>
                                        </div>	
                                        <div class="form-group">
                                            <label for="compro2" class="col-sm-4 control-label">Address</label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="compro2" name="compro2" value="#compro2#" placeholder="Street Address" maxlength="80">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="compro3" class="col-sm-4 control-label"></label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="compro3" name="compro3" value="#compro3#" placeholder="Apt, Suite, Bldg." maxlength="80">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="compro4" class="col-sm-4 control-label"></label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="compro4" name="compro4" value="#compro4#" placeholder="Additional Address Information" maxlength="80">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="compro5" class="col-sm-4 control-label"></label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="compro5" name="compro5" value="#compro5#" placeholder="Town/City" maxlength="80">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"></label>
                                            <div class="col-sm-4">
                                                <input type="text" class="form-control input-sm" id="compro6" name="compro6" value="#compro6#" placeholder="Country" maxlength="80">											
                                            </div>
                                            <div class="col-sm-4">
                                                <input type="text" class="form-control input-sm" id="compro7" name="compro7" value="#compro7#" placeholder="Postal Code" maxlength="10">
                                            </div>
                                        </div>  
                                        <div class="form-group">
                                            <label for="comUEN" class="col-sm-4 control-label">Company UEN</label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="comUEN" name="comUEN" value="#comUEN#" placeholder="Company UEN Number" maxlength="80">
                                            </div>
                                        </div>	
                                        
                                         <div class="form-group">
                                            <label for="language" class="col-sm-4 control-label">Language</label>
                                            <div class="col-sm-8">
                                            	<select class="form-control input-sm" id="language" name="language">
                                                	<option value="malay" <cfif getGsetup.dflanguage EQ "malay">selected</cfif>>Bahasa Malaysia</option>
                                                    <option value="indo" <cfif getGsetup.dflanguage EQ "indo">selected</cfif>>Bahasa Indonesia</option>
                                                	<option value="english" <cfif getGsetup.dflanguage EQ "english">selected</cfif>>English</option>
                                                    
                                                    <option value="sim_ch" <cfif getGsetup.dflanguage EQ "sim_ch">selected</cfif>>Simplified Chinese</option>
                                                    <option value="tra_ch" <cfif getGsetup.dflanguage EQ "tra_ch">selected</cfif>>Traditional Chinese</option>
                                                    <option value="vietnam" <cfif getGsetup.dflanguage EQ "vietnam">selected</cfif>>Vietnamese</option>
                                                    <option value="thai" <cfif getGsetup.dflanguage EQ "thai">selected</cfif>>Thai</option>
                                                </select>
                                            </div>
                                        </div>                                                                   						
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                      
                      
                      
                      
                     
                     
                     
                     
                     
                      
                      
                      
                      <cfoutput>
                       <div class="panel panel-default">
                        <div class="panel-heading" data-toggle="collapse" href="##billing">
                            <h4 class="panel-title accordion-toggle">Billing Information&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h4>
                        </div>
                         <div style=" margin-top:-30px; width:180px; margin-left:160px;">&nbsp;<cfinclude template="subscribeNow.cfm"></div>
                         
                         
                         
                         
                             <div id="billing" class="panel-collapse collapse in">
                         <div style=" margin-top:10px; border:1px ##CCCCCC solid; position:absolute; width:380px; margin-left:560px;">
                         
                             <cfquery name="getdatabase" datasource="main">
	SELECT usercount,companyid FROM useraccountlimit where companyid='#dts#' order by companyid
	</cfquery>
    
<cfquery name="getdatabaseAMS" datasource="mainams">
	SELECT usercount,companyid FROM useraccountlimit where companyid='#replacenocase(dts,'_i','_a')#' order by companyid
	</cfquery>    
    
    
     <cfquery datasource='main' name="getallusercount">
			select * 
			from users 
			where userbranch='#dts#' and usergrpid <> 'super' 
			order by usergrpid,userid;
		</cfquery>
         <cfquery datasource='mainams' name="getallusercountAMS">
			select * 
			from users 
			where userbranch='#replacenocase(dts,'_i','_a')#' and usergrpid <> 'super' 
			order by usergrpid,userid;
		</cfquery>    

        
        <table class="data">
        <tr>
     
    <div align="center"><font size="+1" >   <th>Total IMS Users:</th><td> <cfoutput>#val(getdatabase.usercount)#</cfoutput></td>
</font></div>
</tr>
<cfif getdatabaseAMS.recordcount neq 0>
 <div align="center"><font size="+1" ><th>Total AMS Users: </th></th><td><cfoutput>#val(getdatabaseAMS.usercount)#</cfoutput>
</td>
</font></div>
</tr>
</cfif>
  <tr>
     
<div align="center"><font size="+1" ><th>Current IMS Users:</th><td> <cfoutput>#val(getallusercount.recordcount)#</cfoutput>
</td>
</font></div>
</tr>
<cfif getallusercountAMS.recordcount neq 0>  <tr>
     
 <div align="center"><font size="+1" ><th>Current AMS Users:</th><td> <cfoutput>#val(getallusercountAMS.recordcount)#</cfoutput>
</td>
</font></div>
</tr>
</cfif>





<cfif getdatabaseAMS.recordcount neq 0>
  <tr>
     
<div align="center"><font size="+1" ><th style="border-top:1px grey solid">Balance Users:</th><td style="border-top:1px grey solid; color:red"> <cfoutput>#val(getdatabase.usercount)+val(getdatabaseAMS.usercount)-val(getallusercountAMS.recordcount)-val(getallusercount.recordcount)#</cfoutput>
</td>
</font></div>
</tr>


<cfelse>  <tr>
     
<div align="center"><font size="+1" ><th style="border-top:1px grey solid">Balance Users:</th><td style="border-top:1px grey solid; color:red">  <cfoutput>#val(getdatabase.usercount-getallusercount.recordcount)#</cfoutput>
</td>
</font></div>
</tr>
</cfif>
</table>             
                         </div>
                         
                        
                    
                     
                      <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-6">    
                                    
                        <cfquery name="getPackage" datasource="#dts#">
select * from net_c.usersystemaccount u left join netiquette_c.getpayment g
 on u.paymentId = g.id where 
 
 u.companyId  = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replacenocase(replacenocase(replacenocase(replacenocase(dts,'_c','','all'),'_i','','all'),'_a','','all'),'_p','','all')#">
 and system = 'IMS'
 
 </cfquery>


<cfquery name="getTran" datasource="netiquette2_i">
select * from artran a left join ictran i on a.refno = i.refno where A.refno2 = '#getpackage.paymentid#' 
</cfquery>

                              
                                        <div class="form-group">
                                            <label for="GSTno" class="col-sm-4 control-label">Plan</label>
                                            <div class="col-sm-8">
                                               <cfif getpackage.paymentid eq ''>Trial Account<cfelse>#listfirst(getTran.itemno,'&')#</cfif>
                                            </div>
                                        </div>
                                        
                                    <div class="form-group">
                                            <label for="GSTno" class="col-sm-4 control-label">Extra Function</label>
                                            <div class="col-sm-8">
                                              <cfif getpackage.paymentid eq ''>-<cfelse>#replacenocase(valuelist(getTran.itemno),listfirst(valuelist(getTran.itemno))&',','')#</cfif>
                                            </div>
                                        </div>
                                        
                                           <div class="form-group">
                                            <label for="GSTno" class="col-sm-4 control-label">Number of Client</label>
                                            <div class="col-sm-8">
                                            <cfquery name="getCustno" datasource="#dts#">
select * from #target_arcust#
</cfquery>
#getcustno.recordcount#
                                            </div>
                                        </div>       
                                     
   <div class="form-group">
                                            <label for="GSTno" class="col-sm-4 control-label">Payment Details</label>
                                            <div class="col-sm-8">
<a target="_blank" href="/paypal/preprintedformat.cfm?tran=INV&nexttranno=#getTran.refno#&billname=NET_iCBIL_TaxInv2&doption=0">#getTran.refno#</a>
                                            </div>
                                        </div>

<cfquery name="getSubs" datasource="netiquette_c">
select * from paymentdetails where SUBSCR_ID = '#getpackage.SUBSCR_ID#' and amount3 <>''
</cfquery>

   <div class="form-group">
                                            <label for="GSTno" class="col-sm-4 control-label">Email</label>
                                            <div class="col-sm-8">
#getsubs.payer_email#
                                            </div>
                                        </div>



   <div class="form-group">
                                            <label for="GSTno" class="col-sm-4 control-label">Name</label>
                                            <div class="col-sm-8">
#getsubs.first_name# #getsubs.last_name#
                                            </div>
                                        </div>



<cfquery name="getBal" datasource="netiquette_c">
select * from trackipn where SBCR_ID = '#getpackage.SUBSCR_ID# - #getPackage.trialid#' and status = 'Verified' <!---  group by txn_id --->
</cfquery>

   <div class="form-group">
                                            <label for="GSTno" class="col-sm-4 control-label">Recurring</label>
                                            <div class="col-sm-8">
<cfif getpackage.paymentid neq ''>#getsubs.RECUR_TIMES# times, each #getsubs.recurring# month</cfif>
                                            </div>
                                        </div>
   <div class="form-group">
                                            <label for="GSTno" class="col-sm-4 control-label">Recurring Received</label>
                                            <div class="col-sm-8">
<cfif getpackage.paymentid eq ''>-<cfelse><a <!--- href="detail.cfm?subscr_id=#getpackage.SUBSCR_ID#&trialid=#getPackage.trialid#" --->>#val(getBal.recordcount)-1# months</a></cfif>
<cfquery name="get" datasource="#dts#">
select created_on,refno,subscr_id from (select subscr_id,id from netiquette_c.getpayment) g left join (select created_on,refno,refno2 from netiquette2_i.artran) a 
on g.id = a.refno2 where subscr_id = '#getpackage.SUBSCR_ID#' 
</cfquery>

<div style="  padding:5px 5px 5px 5px; "><cfloop query="get">#currentrow#.&nbsp;&nbsp;<a target="_blank" href="/paypal/preprintedformat.cfm?tran=INV&nexttranno=#refno#&billname=NET_iCBIL_TaxInv2&doption=0">#refno#-#dateformat(created_on,'dd/mm/yyyy')#</a><br></cfloop></div>
                                            </div>
                                        </div>   
                                        
                                         <div class="form-group">                                     
                               <label for="GSTno" class="col-sm-4 control-label">Subscription End Date </label>
                                            <div class="col-sm-8" style="font-weight:bolder; padding:3px 3px 3px 3px;">
				#dateformat(getpackage.subscriptionEndDate,'dd/mm/yyyy')#          
                                        </div>
                                        </div> 
                                     
                                     
                                     
                                     
                                     
                                     
                                        
                                        
                                        </div>
                                        </div>
                                        </div>
                      
                      
                      
                      
                      
                      </div>
                      </div>
                      
                      
                      </cfoutput>
                      
                      
                      
                      
                      
                      
                      
                      
                        
                    <div class="panel panel-default">
                        <div class="panel-heading" data-toggle="collapse" href="##financialInfoCollapse">
                            <h4 class="panel-title accordion-toggle">Financial Information</h4>
                        </div>
                        <div id="financialInfoCollapse" class="panel-collapse collapse in">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-6">                      
                                        <div class="form-group">
                                            <label for="GSTno" class="col-sm-4 control-label">Company #gstWord#</label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="GSTno" name="GSTno" value="#GSTno#" placeholder="#gstPlaceholder#" maxlength="30">
                                            </div>
                                        </div>	
                                        <div class="form-group">
										<label for="date" class="col-sm-4 control-label">Last A/C Year Closing Date</label>
										<div class="col-sm-8">
											<div class="input-group date">
												<input type="text" class="form-control input-sm" id="date" name="date" placeholder="Account Created Date" value="#DateFormat(lastYearClosing,'dd/mm/yyyy')#">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
											</div>
										</div>
                                        
                                        
                                        
									</div> 
                                        <div class="form-group">
                                            <label for="thisYearClosing" class="col-sm-4 control-label">This A/C Year Closing Period</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="thisYearClosing" name="thisYearClosing">
                                                    <cfloop index="i" from="1" to="18">
                                                        <option value="#numberformat(i,"00")#" <cfif val(#thisYearClosing#) EQ i>selected</cfif>>#i#</option>
                                                    </cfloop>
                                                </select>
                                            </div>
                                        </div> 	
                                        <div class="form-group">
                                            <label for="currencyCode" class="col-sm-4 control-label">Code & Symbol</label>
                                            <div class="col-sm-4">
                                                <select class="form-control input-sm" id="currencyCode" name="currencyCode">
                                                    <option value="">Choose a Currency</option>
                                                    <cfloop query="listCurrency">
                                                        <option value="#listCurrency.currcode#" data-symbol="#listCurrency.currency#" data-description="#listCurrency.currency1#" <cfif listCurrency.currcode EQ xcurrency>selected</cfif>>#listCurrency.currcode#</option>
                                                    </cfloop>
                                                </select>
                                            </div>
                                        </div>    
                                        <div class="form-group">
                                            <label for="debtorFrom" class="col-sm-4 control-label">Debtor From</label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="debtorFrom" name="debtorFrom" value="#debtorFrom#" placeholder="Debtor From" maxlength="4">
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="debtorTo" class="col-sm-4 control-label">Debtor To</label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="debtorTo" name="debtorTo" value="#debtorTo#" placeholder="Debtor To" maxlength="4">
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="creditorFrom" class="col-sm-4 control-label">Creditor From</label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="creditorFrom" name="creditorFrom" value="#creditorFrom#" placeholder="Creditor From" maxlength="4">
                                            </div>
                                        </div> 
                                        <div class="form-group">
                                            <label for="creditorTo" class="col-sm-4 control-label">Creditor To</label>
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="creditorTo" name="creditorTo" value="#creditorTo#" placeholder="Creditor To" maxlength="4">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="periodAllowed" class="col-sm-4 control-label">Period Allowed From</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" id="periodAllowed" name="periodAllowed">
                                                    <cfloop index="i" from="1" to="18">
                                                        <option value="#numberformat(i,"00")#" <cfif val(#periodAllowed#) EQ i>selected</cfif>>#i#</option>
                                                    </cfloop>
                                                </select>
                                            </div>
                                        </div> 	                 						
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
    </form>    
               
	<!--- <form name="upload_picture" action="/latest/uploadImage/company_image.cfm" method="post" enctype="multipart/form-data" target="_blank">
        <div class="panel panel-default">
            <div class="panel-heading" data-toggle="collapse" href="##thirdPanel">
                <h4 class="panel-title accordion-toggle">Upload Company's Logo</h4>
            </div>
            <div id="thirdPanel" class="panel-collapse collapse in">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-6">                               
                            <div class="form-group">
                                <label class="col-sm-4 control-label"></label>
                                <div class="col-sm-8">			
                               		<input type="file" name="formatlogo" id="formatlogo" size="50" accept="image/gif,image/jpeg,image/tiff,image/x-ms-bmp,image/x-photo-cd,image/x-png,image/x-portable-greymap,image/x-portable-pixmap,image/x-portablebitmap">	
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label"></label>
                                <div class="col-sm-8">			
                                    <input type="text" name="picture_name" id="picture_name" size="50" value="">&nbsp;
        <input type="submit" name="Upload" value="Upload" onClick="javascript:return add_option(document.getElementById('picture_name').value);">	
                                </div>
                            </div>	                             						
                        </div>
                    </div>
                </div>
            </div>
        </div>
	</form>  --->
			</div>
            
            <div class="pull-right">
				<input type="button" value="#pageAction#" class="btn btn-primary" onclick="document.getElementById('companyProfileForm').submit();"/>
				<input type="button" value="Cancel" onclick="window.location='/latest/body/bodymenu.cfm?id=60100'" class="btn btn-default" />
			</div>
</cfoutput>
</body>
</html>

