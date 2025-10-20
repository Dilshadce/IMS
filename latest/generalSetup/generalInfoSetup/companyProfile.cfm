<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "125, 1497, 6, 40, 300, 45, 27, 603, 34, 35, 36, 37, 39, 28, 598, 45, 23, 301, 9, 1266, 1267, 1078, 313, 63, 1603, 1604, 1605, 1612, 1613, 1614, 1606, 1607, 1608, 1609, 1610 ,1611, 1617, 1618, 1619, 1620, 1621, 1622, 1623, 1624, 1625, 1626, 1627, 1628, 1629, 1630, 1631, 1615, 1616, 59, 1632, 1801">
<cfinclude template="/latest/words.cfm">

<cfset pageTitle="#words[1603]#">
<cfset pageAction="Update">

<cfquery name="listCurrency" datasource="#dts#">
	SELECT currcode,currency,currency1 
	FROM #target_currency#
	ORDER BY currcode;
</cfquery>

<cftry>
<cfquery name="listCountry" datasource="mainams">
	SELECT *
	FROM dropListCountry;
</cfquery>
<cfcatch>
<cfquery name="listCountry" datasource="main">
	SELECT *
	FROM dropListCountry;
</cfquery>

</cfcatch>
</cftry>


<cfquery name="getGsetup" datasource="#dts#">
	SELECT compro6,ctycode
	FROM gsetup;
</cfquery>

<cfif getGsetup.ctycode EQ "IDR">        
	<cfset gstWord = "Company NPWP">  
    <cfset gstPlaceholder = "Nomor Pokok Wajib Pajak">  
<cfelse>
    <cfset gstWord = "#words[1604]#">
    <cfset gstPlaceholder = "#words[59]#">  
</cfif> 

<cfif Hlinkams eq "Y">
    <cfquery name="getGsetup" datasource="#replace(LCASE(dts),'_i','_a','all')#">
        SELECT * 
        FROM gsetup;
    </cfquery>
    
    <cfset companyID = getGsetup.companyid>
    <cfset compro = getGsetup.compro>
    <cfset compro2 = getGsetup.compro2>
    <cfset compro3 = getGsetup.compro3> 
    <cfset compro4 = getGsetup.compro4>
    <cfset compro5 = getGsetup.compro5>  
    <cfset compro6 = getGsetup.compro6>    
    <cfset compro7 = getGsetup.compro7> 
	<cfset compro8 = getGsetup.compro8> 
    <cfset compro9 = getGsetup.compro9> 
    <cfset compro10 = getGsetup.compro10>
    <cfset comUEN = getGsetup.comuen>  
      
    <cfset GSTno = getGsetup.gstno>
    
    <cfset xcurrency= getGsetup.ctycode>
    <cfset currencyCode= listCurrency.currcode>
    
    <cfset lastYearClosing = Dateformat(getGsetup.lastaccyear, "DD/MM/YYYY")>
    <cfset thisYearClosing = getGsetup.period>
    <cfset debtorFrom = getGsetup.debtorfr>
    <cfset debtorTo = getGsetup.debtorto>
    <cfset creditorFrom = getGsetup.creditorfr>
    <cfset creditorTo = getGsetup.creditorto>
</cfif>

<cfquery name="getGsetup" datasource="#dts#">
    SELECT * 
    FROM gsetup;
</cfquery>

<cfquery name="getGsetup2" datasource="#dts#">
    SELECT billFormatTemplate 
    FROM gsetup2;
</cfquery>

<cfset companyID = getGsetup.companyid>
<cfset compro = getGsetup.compro>
<cfset compro2 = getGsetup.compro2>
<cfset compro3 = getGsetup.compro3> 
<cfset compro4 = getGsetup.compro4>
<cfset compro5 = getGsetup.compro5>  
<cfset compro6 = getGsetup.compro6>    
<cfset compro7 = getGsetup.compro7>
<cfset compro8 = getGsetup.compro8> 
<cfset compro9 = getGsetup.compro9> 
<cfset compro10 = getGsetup.compro10> 
<cfset comUEN = getGsetup.comuen>  
  
<cfset GSTno = getGsetup.gstno>
<cfset xcurrency= getGsetup.bCurr>
<cfset currencyCode= listCurrency.currcode>

<cfset lastYearClosing = Dateformat(getGsetup.lastaccyear, "DD/MM/YYYY")>
<cfset thisYearClosing = getGsetup.period>
<cfset debtorFrom = getGsetup.debtorfr>
<cfset debtorTo = getGsetup.debtorto>
<cfset creditorFrom = getGsetup.creditorfr>
<cfset creditorTo = getGsetup.creditorto>
<cfset periodAllowed = getGsetup.periodalfr>
<cfset billFormatTemplate = getGsetup2.billFormatTemplate>

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
	<link rel="stylesheet" type="text/css" href="/latest/js/bootstrapformhelpers/css/bootstrap-formhelpers.css">
	<link rel="stylesheet" type="text/css" href="/latest/js/bootstrapformhelpers/css/bootstrap-formhelpers.min.css">
    <link rel="stylesheet" type="text/css" href="/latest/tooltip/tooltip.css">
    <!--[if lt IE 9]>
        <script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
        <script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/latest/tooltip/tooltip.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap-datepicker/bootstrap-datepicker.js"></script>
    <script type="text/javascript">
		$(document).ready(function(e) {	
			$('.input-group.date').datepicker({
				format: "dd/mm/yyyy",
				todayBtn: "linked",
				autoclose: true,
				todayHighlight: true,
			});
			
			/* This triggers after each slide change
			 * Must plus 1 as the index starts from 0
			 */
			$('.carousel').on('slid.bs.carousel', function () {
				var selectedTemplate = $('#myCarousel .active').index('#myCarousel .item')+1;
				$('#billFormatTemplate').val(selectedTemplate);
			});
		});
	</script>
    
    <style>
		.carousel-inner > .item > img,
	  	.carousel-inner > .item > a > img {
			width: 85%;
			height: 20%;
			margin: auto;
	  }
  	</style>
</head>

<body class="container">
<cfoutput>
	<form class="form-horizontal" role="form" id="companyProfileForm" name="companyProfileForm" action="companyProfileProcess.cfm" method="post";>
        <div class="page-header">
            <h3>#pageTitle#</h3>
        </div>
        <input type="hidden" id="companyID" name="companyID" value="#companyID#" />
        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading" data-toggle="collapse" href="##mainInfoCollapse">
                    <h4 class="panel-title accordion-toggle">#words[125]#</h4>
                </div>
                <div id="mainInfoCollapse" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-6">							
                                <div class="form-group">
                                    <label for="compro" class="col-sm-4 control-label">#words[1497]#</label>
                                    <div class="col-sm-7">			
                                        <input type="text" class="form-control input-sm" id="compro" name="compro" value="#compro#" placeholder="#words[1497]#" required maxlength="80"/>										
                                    </div>
                                </div>	
                                <div class="form-group">
                                    <label for="compro2" class="col-sm-4 control-label">#words[6]#</label>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control input-sm" id="compro2" name="compro2" value="#compro2#" placeholder="#words[34]#" maxlength="80">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="compro3" class="col-sm-4 control-label"></label>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control input-sm" id="compro3" name="compro3" value="#compro3#" placeholder="#words[35]#" maxlength="80">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="compro4" class="col-sm-4 control-label"></label>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control input-sm" id="compro4" name="compro4" value="#compro4#" placeholder="#words[36]#" maxlength="80">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="compro5" class="col-sm-4 control-label"></label>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control input-sm" id="compro5" name="compro5" value="#compro5#" placeholder="#words[37]#" maxlength="80">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"></label>
                                    <div class="col-sm-4">
                                        <select class="form-control input-sm" id="compro6" name="compro6">
                                            <option value="">#words[1605]#</option>
                                            <cfloop query="listCountry">
                                                <option value="#listCountry.country#" <cfif listCountry.country EQ compro6>selected</cfif>>#listCountry.country#</option>
                                            </cfloop>
                                        </select>										
                                    </div>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control input-sm" id="compro7" name="compro7" value="#compro7#" placeholder="#words[39]#" maxlength="10">
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="compro8" class="col-sm-4 control-label">#words[40]#</label>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control input-sm" id="compro8" name="compro8" value="#compro8#" placeholder="#words[1612]#" maxlength="100">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="compro9" class="col-sm-4 control-label">#words[300]#</label>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control input-sm" id="compro9" name="compro9" value="#compro9#" placeholder="#words[1613]#" maxlength="100">
                                    </div>
                                </div> 
                                <div class="form-group">
                                    <label for="compro10" class="col-sm-4 control-label">#words[45]#</label>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control input-sm" id="compro10" name="compro10" value="#compro10#" placeholder="#words[1614]#" maxlength="100">
                                    </div>
                                </div>	
                                <div class="form-group">
                                    <label for="comUEN" class="col-sm-4 control-label">#words[27]#</label>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control input-sm" id="comUEN" name="comUEN" value="#comUEN#" placeholder="#words[28]#" maxlength="80">
                                    </div>
                                </div>	                                                                						
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading" data-toggle="collapse" href="##financialInfoCollapse">
                    <h4 class="panel-title accordion-toggle">#words[301]#</h4>
                </div>
                <div id="financialInfoCollapse" class="panel-collapse collapse">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-6">                      
                                <div class="form-group">
                                    <label for="GSTno" class="col-sm-4 control-label">#gstWord#</label>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control input-sm" id="GSTno" name="GSTno" value="#GSTno#" placeholder="#gstPlaceholder#" maxlength="30">
                                    </div>
                                </div>	
                                <div class="form-group">
                                <label for="date" class="col-sm-4 control-label">#words[1631]#</label>
                                <div class="col-sm-7">
                                <cfif lcase(husergrpid) eq "super">
                                	 <div class="input-group date">
                                        <input type="text" class="form-control input-sm" id="date" name="date" placeholder="#words[313]#" value="#DateFormat(lastYearClosing,'dd/mm/yyyy')#">
                                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>	
                                     </div>
                                <cfelse>
                                    <div>
                                    	
                                        <input type="text" class="form-control input-sm" id="date" name="date" placeholder="#words[313]#" value="#DateFormat(lastYearClosing,'dd/mm/yyyy')#" readonly>
                                       
                                    </div>
                                </cfif>
                                </div>
                            </div> 
                                <div class="form-group">
                                    <label for="thisYearClosing" class="col-sm-4 control-label">#words[1632]#</label> 
                                    <div class="col-sm-7">
                                        <select class="form-control input-sm" id="thisYearClosing" name="thisYearClosing">
                                            <cfloop index="i" from="1" to="18">
                                                <option value="#numberformat(i,"00")#" <cfif val(#thisYearClosing#) EQ i>selected</cfif>>#i#</option>
                                            </cfloop>
                                        </select>
                                    <cfif lcase(husergrpid) eq "super">
                                    For Super User Changing this Will Not Change Accounting
                                    </cfif>
                                    </div>
                                    <span class="glyphicon glyphicon-question-sign mhover nopadding glypAlignment col-sm-1" id="60111_1"></span>
                                </div> 	
                                <div class="form-group">
                                    <label for="currencyCode" class="col-sm-4 control-label">#words[9]#</label>
                                    <div class="col-sm-7">
                                        <select class="form-control input-sm" id="currencyCode" name="currencyCode" required>
                                            <option value="">#words[63]#</option>
                                            <cfloop query="listCurrency">
                                                <option value="#listCurrency.currcode#" data-symbol="#listCurrency.currency#" data-description="#listCurrency.currency1#" <cfif listCurrency.currcode EQ xcurrency>selected</cfif>>#listCurrency.currcode#</option>
                                            </cfloop>
                                        </select>
                                    </div>
                                </div>    
                                <div class="form-group">
                                    <label for="debtorFrom" class="col-sm-4 control-label">#words[1266]#</label>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control input-sm" id="debtorFrom" name="debtorFrom" value="#debtorFrom#" placeholder="#words[1266]#" maxlength="4">
                                    </div>
                                    <span class="glyphicon glyphicon-question-sign mhover nopadding glypAlignment col-sm-1" id="60111_2"></span>
                                </div> 
                                <div class="form-group">
                                    <label for="debtorTo" class="col-sm-4 control-label">#words[1267]#</label>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control input-sm" id="debtorTo" name="debtorTo" value="#debtorTo#" placeholder="#words[1267]#" maxlength="4">
                                    </div>
                                    <span class="glyphicon glyphicon-question-sign mhover nopadding glypAlignment col-sm-1" id="60111_3"></span>
                                </div> 
                                <div class="form-group">
                                    <label for="creditorFrom" class="col-sm-4 control-label">#words[1615]#</label>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control input-sm" id="creditorFrom" name="creditorFrom" value="#creditorFrom#" placeholder="#words[1615]#" maxlength="4">
                                    </div>
                                    <span class="glyphicon glyphicon-question-sign mhover nopadding glypAlignment col-sm-1" id="60111_4"></span>
                                </div> 
                                <div class="form-group">
                                    <label for="creditorTo" class="col-sm-4 control-label">#words[1616]#</label>
                                    <div class="col-sm-7">
                                        <input type="text" class="form-control input-sm" id="creditorTo" name="creditorTo" value="#creditorTo#" placeholder="#words[1616]#" maxlength="4">
                                    </div>
                                    <span class="glyphicon glyphicon-question-sign nopadding glypAlignment mhover col-sm-1" id="60111_5"></span>
                                </div>
                                <div class="form-group">
                                    <label for="periodAllowed" class="col-sm-4 control-label">#words[1078]#</label>
                                    <div class="col-sm-7">
                                        <select class="form-control input-sm" id="periodAllowed" name="periodAllowed">
                                            <cfloop index="i" from="1" to="18">
                                                <option value="#numberformat(i,"00")#" <cfif val(#periodAllowed#) EQ i>selected</cfif>>#i#</option>
                                            </cfloop>
                                        </select>   
                                        
                                    </div>
                                    <span class="glyphicon glyphicon-question-sign mhover nopadding glypAlignment col-sm-1" id="60111_6"></span>
                                </div> 	                 						
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="panel panel-default">
                <div class="panel-heading" data-toggle="collapse" href="##billformatTemplateCollapse">
                    <h4 class="panel-title accordion-toggle">BillFormat Templates</h4>
                </div>
                <div id="billformatTemplateCollapse" class="panel-collapse collapse">
                    <div class="panel-body">
                        <div class="row">
							<div id="myCarousel" class="carousel slide" data-interval="false">
                                <!-- Indicators -->
                                <cfif getGsetup.compro6 EQ 'MALAYSIA'>
                                <ol class="carousel-indicators">
                                    <li data-target="##myCarousel" data-slide-to="0" class="active"></li>
                                    <li data-target="##myCarousel" data-slide-to="1"></li>
                                    <li data-target="##myCarousel" data-slide-to="2"></li>
                                    <li data-target="##myCarousel" data-slide-to="3"></li>
                                </ol>
                                <cfelse>
                                <ol class="carousel-indicators">
                                    <li data-target="##myCarousel" data-slide-to="0" class="active"></li>
                                    <li data-target="##myCarousel" data-slide-to="1"></li>
                                </ol>
                                </cfif>
                                <!-- Wrapper for slides -->
                                <div class="carousel-inner" role="listbox">
									<cfif getGsetup.compro6 EQ 'MALAYSIA'>
										<cfif getGsetup.wpitemtax EQ ''>
                                            <div class="item active">
                                              <img src="/billformat/default/newDefault/MYR/Template_1/Template_BillTax/Sample.jpg" alt="Sample One">
                                            </div>
                                            
                                            <div class="item">
                                              <img src="/billformat/default/newDefault/MYR/Template_2/Template_BillTax/Sample.jpg" alt="Sample Two">
                                            </div>
                                            
                                            <div class="item">
                                              <img src="/billformat/default/newDefault/MYR/Template_3/Template_BillTax/Sample.jpg" alt="Sample Three">
                                            </div>
                                            
                                            <div class="item">
                                              <img src="/billformat/default/newDefault/MYR/Template_4/Template_BillTax/Sample.jpg" alt="Sample Four">
                                            </div>
                                        <cfelse>
                                            <div class="item active">
                                              <img src="/billformat/default/newDefault/MYR/Template_1/Template_ItemTax/Sample.jpg" alt="Sample One">
                                            </div>
                                            
                                            <div class="item">
                                              <img src="/billformat/default/newDefault/MYR/Template_2/Template_ItemTax/Sample.jpg" alt="Sample Two">
                                            </div>
                                            
                                            <div class="item">
                                              <img src="/billformat/default/newDefault/MYR/Template_3/Template_ItemTax/Sample.jpg" alt="Sample Three">
                                            </div>
                                            
                                            <div class="item">
                                              <img src="/billformat/default/newDefault/MYR/Template_4/Template_ItemTax/Sample.jpg" alt="Sample Four">
                                            </div>
                                        </cfif>
                                    <cfelse>
                                        <cfif getGsetup.wpitemtax EQ ''>
                                            <div class="item active">
                                              <img src="/billformat/default/newDefault/Template_1/Template_BillTax/Sample.jpg" alt="Sample One">
                                            </div>
                                            
                                            <div class="item">
                                               <img src="/billformat/default/newDefault/Template_2/Template_BillTax/Sample.jpg" alt="Sample Two">
                                            </div>
                                        <cfelse>
                                            <div class="item active">
                                              <img src="/billformat/default/newDefault/Template_1/Template_ItemTax/Sample.jpg" alt="Sample One">
                                            </div>
                                            
                                            <div class="item">
                                               <img src="/billformat/default/newDefault/Template_2/Template_ItemTax/Sample.jpg" alt="Sample Two">
                                            </div>
                                        </cfif>

                                    </cfif>            
                                </div>
                                
                                <!-- Left and right controls -->
                                <a class="left carousel-control alertNow" href="##myCarousel" role="button" data-slide="prev">
                                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <a class="right carousel-control alertNow" href="##myCarousel" role="button" data-slide="next">
                                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                    <span class="sr-only">Next</span>
                                </a>
							</div>    
                        </div>
                    </div>
                    <input type="hidden" class="form-control input-sm" id="billFormatTemplate" name="billFormatTemplate" value="#billFormatTemplate#">
                </div>
            </div>
            
           
            
        </div>
    </form>  
      
    <div class="pull-right">
        <input type="button" value="#pageAction#" class="btn btn-primary" onClick="document.getElementById('companyProfileForm').submit();"/>
        <input type="button" value="Cancel" onClick="window.location='/latest/body/bodymenu.cfm?id=60100'" class="btn btn-default" />
    </div>    
    


 
</cfoutput>
</body>
</html>

