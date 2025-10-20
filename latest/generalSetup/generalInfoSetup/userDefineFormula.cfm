<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1765, 1766, 157,1767, 1768, 1770, 1771, 1772, 1773, 1774, 1775, 1776, 1777, 1769">
<cfinclude template="/latest/words.cfm">

<cfset pageTitle="#words[1765]#">
<cfquery name="getGsetup" datasource='#dts#'>
	SELECT * 
	FROM gsetup 
	WHERE companyid = 'IMS';
</cfquery>

	<cfset quantityFormula = getGsetup.qtyformula>
    <cfset priceFormula = getGsetup.priceformula>
    <cfset Define1 = getGsetup.xqty1>
    <cfset Define2 = getGsetup.xqty2>
    <cfset Define3 = getGsetup.xqty3>
    <cfset Define4 = getGsetup.xqty4>
    <cfset Define5 = getGsetup.xqty5>
    <cfset Define6 = getGsetup.xqty6>
    <cfset Define7 = getGsetup.xqty7>

    <cfset value1 = replace(getGsetup.qtyformula,'xqty1','Define1','all')>
    <cfset value2 = replace(value1,'xqty2','Define2','all')>
    <cfset value3 = replace(value2,'xqty3','Define3','all')>
    <cfset value4 = replace(value3,'xqty4','Define4','all')>
    <cfset value5 = replace(value4,'xqty5','Define5','all')>
    <cfset value6 = replace(value5,'xqty6','Define6','all')>
    <cfset value7 = replace(value6,'xqty7','Define7','all')>
    
    <cfset value11 = replace(getGsetup.priceformula,'xqty1','Define1','all')>
    <cfset value12 = replace(value11,'xqty2','Define2','all')>
    <cfset value13 = replace(value12,'xqty3','Define3','all')>
    <cfset value14 = replace(value13,'xqty4','Define4','all')>
    <cfset value15 = replace(value14,'xqty5','Define5','all')>
    <cfset value16 = replace(value15,'xqty6','Define6','all')>
    <cfset value17 = replace(value16,'xqty7','Define7','all')>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <link rel="stylesheet" href="/latest/css/form.css" />
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]>
        <script type="text/javascript" src="/latest/js/selectivizr/selectivizr-min.js"></script>
        <noscript><link rel="stylesheet" href="" /></noscript>
    <![endif]-->
    
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/target.css">
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.css">
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <script type="text/javascript">
		
		function verify(fieldname,s){
			
			var word_list = s.split(/\W/);
				
			for(i=0;i<word_list.length;i++){
				if(word_list[i].search(/\D/)!='-1'){
					if(word_list[i]!='Define1' && word_list[i] !='Define2' && word_list[i] !='Define3' && word_list[i] !='Define4' && word_list[i] !='Define5' && word_list[i] !='Define6' && word_list[i] !='Define7' && word_list[i] !='xfactor1' && word_list[i] !='xfactor2' && word_list[i] !='round' && word_list[i] !='int' && word_list[i] !='iif'){
						alert('Variable '+word_list[i]+' is not found!');
						document.getElementById(fieldname).focus();
						break;
					}
				}			
			}
		}
	
	</script>
</head>

<body class="container">
<cfoutput>
<form class="form-horizontal" role="form" action="/latest/generalSetup/generalInfoSetup/userDefineFormulaProcess.cfm" method="post">
	<div class="page-header">
		<h3>#pageTitle#</h3>
	</div>
		<div class="panel-group">
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##firstCollapse">
						<h4 class="panel-title accordion-toggle">#words[1766]#</h4>
					</div>
					<div id="firstCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">							
									<div class="form-group">
										<label for="quantityFormula" class="col-sm-4 control-label">#words[157]#</label>
                                        <div class="col-sm-8">
                                       		<input type="text" class="form-control input-sm" id="quantityFormula" name="quantityFormula" value="#value7#" placeholder="#words[1767]#" onBlur="verify('qtyformula',this.value);" />
										</div>	
									</div>	
                                    
                                    <div class="form-group">
										<label for="priceFormula" class="col-sm-4 control-label">#words[1768]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="priceFormula" name="priceFormula" value="#value17#" placeholder="#words[1769]#" onBlur="verify('qtyformula',this.value);" />									
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
                	
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##secondCollapse">
						<h4 class="panel-title accordion-toggle">#words[1770]#</h4>
					</div>
					<div id="secondCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">                      
                                 <div class="form-group">
										<label for="Define1" class="col-sm-4 control-label">#words[1771]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="Define1" name="Define1" value="#Define1#" placeholder="#words[1771]#">									
										</div>
									</div>
                                    
                                    <div class="form-group">
										<label for="#words[1772]#" class="col-sm-4 control-label">#words[1772]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="Define2" name="Define2" value="#Define2#" placeholder="#words[1772]#">									
										</div>
									</div>
                                    
                                    <div class="form-group">
                                    <label for="Define3" class="col-sm-4 control-label">#words[1773]#</label>
                                      <div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="Define3" name="Define3" value="#Define3#" placeholder="#words[1773]#">									
									  </div>
								  </div>
                                    
                                    <div class="form-group">
										<label for="Define4" class="col-sm-4 control-label">#words[1774]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="Define4" name="Define4" value="#Define4#" placeholder="#words[1774]#">									
										</div>
									</div>
                                    
                                    <div class="form-group">
										<label for="Define5" class="col-sm-4 control-label">#words[1775]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="Define5" name="Define5" value="#Define5#" placeholder="#words[1775]#">									
										</div>
									</div>
                                    
                                    <div class="form-group">
										<label for="Define6" class="col-sm-4 control-label">#words[1776]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="Define6" name="Define6" value="#Define6#" placeholder="#words[1776]#">									
										</div>
									</div>
                                    
                                    <div class="form-group">
										<label for="Define7" class="col-sm-4 control-label">#words[1777]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="Define7" name="Define7" value="#Define7#" placeholder="#words[1777]#">									
										</div>
									</div>

							  </div>
							</div>
						</div>
					</div>
				</div>
                
               
            
            <div class="pull-right">
				<input type="submit" value="Save" class="btn btn-primary"/>
				<input type="reset" value="Reset" class="btn btn-primary"/>
			</div>
</form>
</cfoutput>
</body>
</html>

