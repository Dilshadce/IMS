<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "142,125,578,606,608,65,126,127,141,122,104,123,143,146,147,133,154,155,148,149,150,151,190,191,192,193,195,196,
199,200,201,685,230,231,232,233,234,235,236,237,238,239,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,
341,244,91,92,93,94,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,686,609,
610,611,612,613,614,615,61,617,618,619,620,621,622,623,624,625,626,627,628,687,401,402,403,404,405,406,407,408,409,410,411,412,413,
414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,688,629,630,631,96,616,156,135">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.mItemNo')>
	<cfset URLmItemNo = trim(urldecode(url.mItemNo))>
</cfif>

<cfquery name="getCategory" datasource='#dts#'>
    SELECT * 
    FROM iccate;
</cfquery>

<cfquery name="getGroup" datasource='#dts#'>
    SELECT * 
    FROM icgroup
    where 1=1
    <cfif hitemgroup neq ''>
        AND wos_group='#hitemgroup#'
    </cfif>
</cfquery>

<cfquery name="getgsetup" datasource='#dts#'>
    SELECT * 
    FROM gsetup;
</cfquery>

<cfquery name="getSize" datasource='#dts#'>
    SELECT * 
    FROM icsizeid;
</cfquery>

<cfquery name="getMaterial" datasource='#dts#'>
    SELECT * 
    FROM iccolorid;
</cfquery>

<cfquery name="getBrand" datasource='#dts#'>
    SELECT * 
    FROM brand;
</cfquery>

<cfquery name="getSupp" datasource='#dts#'>
   	SELECT custno,name,currcode FROM #target_apvend# WHERE (status<>'B' or status is null) ORDER BY custno
</cfquery>

<cfquery name="getModel" datasource='#dts#'>
    SELECT * 
    FROM vehimodel;
</cfquery>

<cfquery name="getCurrency" datasource='#dts#'>
    SELECT * 
    FROM currency;
</cfquery>

<cfquery name="getUnitOfMeasurement" datasource='#dts#'>
    SELECT * 
    FROM unit;
</cfquery>

<!--- Control The Decimal Point --->
<cfquery name='getgsetup2' datasource='#dts#'>
    SELECT * FROM gsetup2
</cfquery>
<cfset iDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_UPrice = '.'>
<cfloop index='LoopCount' from='1' to='#iDecl_UPrice#'>
  <cfset stDecl_UPrice = stDecl_UPrice & '_'>
</cfloop>

<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset pageTitle="Create Matrix Profile">
		<cfset pageAction="Create">
        
        <cfset colorNo = "">
        
        <cfif getgsetup.grpinitem eq "Y" and trim(lcase(Hitemgroup)) neq "">
        <cfset matrixItemNo = Hitemgroup&"/">
        <cfelse>
        <cfset matrixItemNo = "">
        </cfif>
        
        <cfset alternateItemNo= "">
        <cfset desp = "">
        <cfset despa = "">
        <cfset comment = "">
        
        <cfset brand = "">
        <cfset supplier = "">
        <cfset category = "">
        <cfset group = Hitemgroup>
        <cfset photo = "">  
        <cfset size = "">
        <cfset material = "">
        <cfset model = "">
        
        
        <cfset unitOfMeasurement = "">
        <cfset unitCostPrice = "">
        <cfset unitSellingPrice1 = "">
        <cfset unitSellingPrice2 = "">
        <cfset unitSellingPrice3 = "">
        <cfset unitSellingPrice4 = ""> 
        <cfset muRatio = "">
        
        <cfset foreignCurrency = "">
        <cfset foreignUnitCost = "">
        <cfset foreignSellingPrice = "">
        
        <cfloop index="i" from="2" to="10">
        	<cfset 'foreignCurrency#i#' = "">
            <cfset 'foreignUnitCost#i#' = "">
            <cfset 'foreignSellingPrice#i#' = "">
        </cfloop>
        
        <cfloop index="i" from="1" to="30">
        	<cfset 'remark#i#' = "">
        </cfloop>
        
        <cfset foreignSellingPrice = "">       
         
        <cfloop index="i" from="1" to="20">
        	<cfset 'color#i#' = "">
            <cfset 'size#i#' = "">
        </cfloop>
        
        <cfset sizeColor = "SC">
         
	<cfelseif url.action EQ "update">
		<cfset pageTitle="Update Matrix Profile">
		<cfset pageAction="Update">
        
		<cfquery name="getMatrix" datasource='#dts#'>
            SELECT * 
            FROM icmitem 
            WHERE mitemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLmItemNo#">;
		</cfquery>
        
        <cfset colorNo = getMatrix.colorno>
        <cfset matrixItemNo = getMatrix.mitemno>
        <cfset alternateItemNo= getMatrix.aitemno>
        <cfset desp = getMatrix.desp>
        <cfset despa = getMatrix.despa>
        <cfset comment = getMatrix.comment>
        
        <cfset brand = getMatrix.brand>
        <cfset supplier = getMatrix.supp>
        <cfset category = getMatrix.category>
        <cfset group = getMatrix.wos_group>
        <cfset photo = getMatrix.photo>  
        <cfset size = getMatrix.sizeid>
        <cfset material = getMatrix.colorid>
        <cfset model = getMatrix.shelf>
        
        
        <cfset unitOfMeasurement = getMatrix.unit>
        <cfset unitCostPrice = getMatrix.ucost>
        <cfset unitSellingPrice1 = getMatrix.price>
        <cfset unitSellingPrice2 = getMatrix.price2>
        <cfset unitSellingPrice3 = getMatrix.price3>
        <cfset unitSellingPrice4 = getMatrix.price4>
        <cfset muRatio = getMatrix.muratio>
        
        <cfset foreignCurrency = getMatrix.fcurrcode>
        <cfset foreignUnitCost = getMatrix.fucost>
        <cfset foreignSellingPrice = getMatrix.fprice>
        
        <cfloop index="i" from="2" to="10">
        	<cfset 'foreignCurrency#i#' = evaluate('getMatrix.fcurrcode#i#')>
            <cfset 'foreignUnitCost#i#' = evaluate('getMatrix.fucost#i#')>
            <cfset 'foreignSellingPrice#i#' = evaluate('getMatrix.fprice#i#')>
        </cfloop>      
        
        <cfloop index="i" from="1" to="30">
        	<cfset 'remark#i#' = evaluate('getMatrix.remark#i#')>
        </cfloop>       
         
        <cfloop index="i" from="1" to="20">
        	<cfset 'color#i#' = evaluate('getMatrix.color#i#')>
            <cfset 'size#i#' = evaluate('getMatrix.size#i#')>
        </cfloop>
                 
        <cfset sizeColor = getMatrix.sizecolor>
                 
    <cfelseif url.action EQ "delete">
    	<cfset pageTitle="Delete Matrix Profile">
		<cfset pageAction="Delete"> 
        
		<cfquery name="getMatrix" datasource='#dts#'>
            SELECT * 
            FROM icmitem 
            WHERE mitemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLmItemNo#">;
		</cfquery>
        
        <cfset colorNo = getMatrix.colorno>
        <cfset matrixItemNo = getMatrix.mitemno>
        <cfset alternateItemNo= getMatrix.aitemno>
        <cfset desp = getMatrix.desp>
        <cfset despa = getMatrix.despa>
        <cfset comment = getMatrix.comment>
        
        <cfset brand = getMatrix.brand>
        <cfset supplier = getMatrix.supp>
        <cfset category = getMatrix.category>
        <cfset group = getMatrix.wos_group>
        <cfset photo = getMatrix.photo>  
        <cfset size = getMatrix.sizeid>
        <cfset material = getMatrix.colorid>
        <cfset model = getMatrix.shelf>
        
        
        <cfset unitOfMeasurement = getMatrix.unit>
        <cfset unitCostPrice = getMatrix.ucost>
        <cfset unitSellingPrice1 = getMatrix.price>
        <cfset unitSellingPrice2 = getMatrix.price2>
        <cfset unitSellingPrice3 = getMatrix.price3>
        <cfset unitSellingPrice4 = getMatrix.price4>
        <cfset muRatio = getMatrix.muratio>
        
        <cfset foreignCurrency = getMatrix.fcurrcode>
        <cfset foreignUnitCost = getMatrix.fucost>
        <cfset foreignSellingPrice = getMatrix.fprice>
        
        <cfloop index="i" from="2" to="10">
        	<cfset 'foreignCurrency#i#' = evaluate('getMatrix.fcurrcode#i#')>
            <cfset 'foreignUnitCost#i#' = evaluate('getMatrix.fucost#i#')>
            <cfset 'foreignSellingPrice#i#' = evaluate('getMatrix.fprice#i#')>
        </cfloop>      
        
        <cfloop index="i" from="1" to="30">
        	<cfset 'remark#i#' = evaluate('getMatrix.remark#i#')>
        </cfloop>       
         
        <cfloop index="i" from="1" to="20">
        	<cfset 'color#i#' = evaluate('getMatrix.color#i#')>
            <cfset 'size#i#' = evaluate('getMatrix.size#i#')>
        </cfloop>          
		
        <cfset sizeColor = getMatrix.sizecolor>
        
	</cfif> 
</cfif>

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
    <script type="text/javascript" src="/scripts/prototypenew.js" ></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>

    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <script>
	
		function add_option(pic_name)
		{
			var agree = confirm("Are You Sure ?");
			
			var optn = document.createElement("OPTION");
			optn.text = pic_name;
			optn.value = pic_name;
			document.getElementById("picture_available").options.add(optn);
			
			
			if (agree==true)
			{
				var detection=0;
				var totaloption=document.getElementById("picture_available").length-1;
	
				for(var i=0;i<=totaloption;++i)
				{
					if(document.getElementById("picture_available").options[i].value==pic_name)
					{
						detection=1;
						break;
					}
				}
				
				if(detection!=1)
				{
					var a=new Option(pic_name,pic_name);
					document.getElementById("picture_available").options[document.getElementById("picture_available").length]=a;
				}
				document.getElementById("picture_available").value=pic_name;
				return true;
			}
			else
			{
				return false;
			}
		}
		
		function change_picture(picture)
	{
		var encode_picture = encodeURI(picture);
		show_picture.location="/latest/uploadImage/icitem_image.cfm?pic3="+encode_picture;
	}
		
		function delete_picture(picture)
		{
		var answer =confirm("Are you sure want to delete picture "+picture);
		if (answer)
		{
			var encode_picture = encodeURI(picture);
			show_picture.location="/latest/uploadImage/icitem_image.cfm?delete=true&picture="+encode_picture;
			var elSel = document.getElementById('picture_available');
			  var i;
			  for (i = elSel.length - 1; i>=0; i--) {
				if (elSel.options[i].selected) {
				  elSel.remove(i);
				}
			  }
		}
		
		}
		
		function showpic(picname)
			{
			return hs.expand(picname)
			}
			
		function uploading_picture(pic_name)
		{
			var new_pic_name1 = new String(pic_name);
			var new_pic_name2 = new_pic_name1.split(/[-,/,\\]/g);
			document.getElementById("picture_name").value=new_pic_name2[new_pic_name2.length-1];
		}

		function calculateMUratio(fixnum){
			
			if(isNaN(document.getElementById('muRatio').value)){
				alert("Your input is not a number! Please try again!");
			}
			else{
				if( document.getElementById('unitCostPrice').value == ''){
					var costprice = 0;
				}
				else{
					var costprice =  document.getElementById('unitCostPrice').value;
				}
				var price3 = document.getElementById('muRatio').value  * document.getElementById('unitCostPrice').value;
				price3 = price3.toFixed(fixnum);
				document.getElementById('unitSellingPrice3').value = price3;
			}
	}
	
	function getsizefunc(sizeid){
		<cfif lcase(hcomid) eq "didachi_i" OR lcase(hcomid) eq "newapparel_i">
		ajaxFunction(document.getElementById('sizeajaxfield'),'matrixsizeajax.cfm?sizeid='+sizeid);
		setTimeout('setsize();',500)
		</cfif>
	}
	
	function setsize(){
	for(i=1; i<=20; i++){
	document.getElementById('size'+i).value=document.getElementById('hidsize'+i).value	
	}
	}
	</script>
</head>

<body class="container">
<cfoutput>
<form id="form" name="form" class="form-horizontal" role="form" action="/latest/maintenance/matrixProcess.cfm?action=#url.action#" method="post" onsubmit="document.getElementById('matrixItemNo').disabled=false";>
	<div class="page-header">
		<h3>#pageTitle#</h3>
	</div>
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
										<label for="colorNo" class="col-sm-4 control-label">#words[578]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="colorNo" name="colorNo" value="#colorNo#" placeholder="#words[578]#" maxlength="10">									
										</div>
									</div>					
									<div class="form-group">
										<label for="matrixItemNo" class="col-sm-4 control-label">#words[606]#</label>
										<div class="col-sm-8">			
											<input type="text" class="form-control input-sm" id="matrixItemNo" name="matrixItemNo" placeholder="#words[606]#" required="yes" maxlength="20" value="#matrixItemNo#"  <cfif IsDefined('url.action') AND url.action NEQ 'create'> disabled="true"</cfif>
                                            <cfif getgsetup.grpinitem eq "Y" and trim(lcase(Hitemgroup)) neq "">onKeyup="if(this.value.length < document.getElementById('itemgrpcode').value.length+1){this.value=document.getElementById('itemgrpcode').value+'/';}"</cfif> />										
											<cfif getgsetup.grpinitem eq "Y" and trim(lcase(Hitemgroup)) neq "">
                                            <input type="hidden" name="itemgrpcode" id="itemgrpcode" value="#Hitemgroup#" />
                                            </cfif>
                                        </div>
									</div>	
                                    <div class="form-group">
										<label for="alternateItemNo" class="col-sm-4 control-label">#words[608]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="alternateItemNo" name="alternateItemNo" value="#alternateItemNo#" placeholder="#words[608]#">									
										</div>
									</div>	
                                    <div class="form-group">
										<label for="desp" class="col-sm-4 control-label">#words[65]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="desp" name="desp" value="#desp#" placeholder="#words[65]#">									
                                            <input type="text" class="form-control input-sm" id="despa" name="despa" value="#despa#" placeholder="#words[126]#">									
										</div>
									</div>	  
                                    <div class="form-group">
										<label for="comment" class="col-sm-4 control-label">#words[127]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="comment" name="comment" value="#comment#" placeholder="#words[127]#">									
										</div>
									</div>                                                                  						
								</div>
							</div>
						</div>
					</div>
				</div>
                	
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##generalInfoCollapse">
						<h4 class="panel-title accordion-toggle">#words[141]#</h4>
					</div>
					<div id="generalInfoCollapse" class="panel-collapse collapse">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">      
                                 	<div class="form-group">
										<label for="brand" class="col-sm-4 control-label">#words[122]#</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" name="brand">
                                                <option value="">#words[142]#</option>
                                                <cfloop query="getBrand">
                                                	<option value="#getBrand.brand#">#getBrand.brand#</option>
                                                </cfloop>
                                            </select>									
										</div>
									</div>                
                                    <div class="form-group">
										<label for="supplier" class="col-sm-4 control-label">#words[104]#</label>
										<div class="col-sm-8">			
										<select class="form-control input-sm" name="supplier" id="supplier">
                                                <option value="">#words[156]#</option>
                                                <cfloop query="getSupp">
                                                	<option value="#getSupp.custno#" <cfif supplier eq getSupp.custno>selected</cfif>>#getSupp.custno# - #getSupp.name#</option>
                                                </cfloop>
                                            </select>	
                                        
                                        
                                        </div>
									</div>	
                                    
                                    <div class="form-group">
										<label for="category" class="col-sm-4 control-label">#words[123]#</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" name="category">
                                                <option value="">#words[143]#</option>
                                                <cfloop query="getCategory">
                                                	<option value="#getCategory.cate#">#getCategory.cate#</option>
                                                </cfloop>
                                            </select>	
										</div>
									</div>	
                                   	<div class="form-group">
										<label for="group" class="col-sm-4 control-label">#words[146]#</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" name="group">
                                                <cfif hitemgroup eq '' or getGroup.recordcount eq 0>
                                                <option value="">#words[147]#</option>
                                                </cfif>
                                                <cfloop query="getGroup">
                                                	<option value="#getGroup.wos_group#" #IIF(wos_group eq wos_group,DE('selected'),DE(''))#>#getGroup.wos_group#</option>
                                                </cfloop>
                                            </select>	
										</div>
									</div> 
                                    <div class="form-group">
										<label for="photo" class="col-sm-4 control-label">#words[133]#</label>
										<div class="col-sm-8">
											<cfdirectory action="list" directory="#HRootPath#\images\#hcomid#\" name="picture_list">
                                           <select name="picture_available" id="picture_available" onChange="javascript:change_picture(this.value);" class="form-control input-sm">
                                                <option value="">-</option>
                                                <cfloop query="picture_list">
                                                    <cfif picture_list.name neq "Thumbs.db">
                                                        <option value="#picture_list.name#" #iif((photo eq picture_list.name),DE("selected"),DE(""))#>#picture_list.name#</option>
                                                    </cfif>
                                                </cfloop>
                                            </select> 
                                            
                                            <div style="margin-top:5px; margin-left: 200px;">
                                            <button type="button" class="btn btn-default" onclick="window.open('/latest/uploadImage/uploadItemImage.cfm','Upload Item Image','height=200,width=500');">
                                                <span class="glyphicon glyphicon-plus"></span>#words[135]#
                                            </button>
                                        </div>
                                     
                                            <div style="float:right; margin:25px;">	
                                            	<iframe id="show_picture" name="show_picture" frameborder="0" marginheight="0" marginwidth="0" align="middle" height="150" width="150" scrolling="no" src="/latest/uploadImage/icitem_image.cfm?pic3=#urlencodedformat(photo)#"></iframe>		
                                            </div>		
										</div>
									</div>	
								</div>
                                <div class="col-sm-6">                                   
                                  	<div class="form-group">
										<label for="size" class="col-sm-4 control-label">#words[154]#</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" name="size" id="size" onchange="getsizefunc(this.value);">
                                                <option value="">#words[155]#</option>
                                                <cfloop query="getSize">
                                                	<option value="#getSize.sizeID#" #IIF(sizeID eq size,DE('selected'),DE(''))#>#getSize.sizeID#</option>
                                                </cfloop>
                                            </select>	
										</div>
									</div>  
                                    <div class="form-group">
										<label for="material" class="col-sm-4 control-label">#words[148]#</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" name="material">
                                                <option value="">#words[149]#</option>
                                                <cfloop query="getMaterial">
                                                	<option value="#getMaterial.colorid#" #IIF(colorid eq material,DE('selected'),DE(''))#>#getMaterial.colorid#</option>
                                                </cfloop>
                                            </select>	
										</div>
									</div> 
                                    <div class="form-group">
										<label for="model" class="col-sm-4 control-label">#words[150]#</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" name="model">
                                                <option value="">#words[151]#</option>
                                                <cfloop query="getModel">
                                                	<option value="#getModel.model#" #IIF(model eq model,DE('selected'),DE(''))#>#getModel.model#</option>
                                                </cfloop>
                                            </select>	
										</div>
									</div>                  						
								</div>	
							</div>
						</div>
					</div>
				</div>
                
                <div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##productInfoCollapse">
						<h4 class="panel-title accordion-toggle">#words[190]#</h4>
					</div>                    
					<div id="productInfoCollapse" class="panel-collapse collapse">
						<div class="panel-body">
							<div class="row">
                            	<div class="col-sm-6">    
                                	<div class="form-group">
										<label for="unitSellingPrice1" class="col-sm-4 control-label">#words[191]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="unitSellingPrice1" name="unitSellingPrice1" value="#unitSellingPrice1#" placeholder="#words[191]#">	
										</div>
									</div>	
                                    <div class="form-group">
										<label for="unitSellingPrice2" class="col-sm-4 control-label">#words[192]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="unitSellingPrice2" name="unitSellingPrice2" value="#unitSellingPrice2#" placeholder="#words[192]#">	
										</div>
									</div>
                                    <div class="form-group">
										<label for="muRatio" class="col-sm-4 control-label">#words[193]#</label>
                                        <div class="col-sm-2">
											<input type="text" class="form-control input-sm" id="muRatio" name="muRatio" value="#muRatio#" placeholder="#words[193]#" onkeyup="calculateMUratio(#iDecl_UPrice#)">	
										</div>
										<div class="col-sm-6">
											<input type="text" class="form-control input-sm" id="unitSellingPrice3" name="unitSellingPrice3" value="#NumberFormat(unitSellingPrice3, stDecl_UPrice)#" placeholder="#words[195]#">	
										</div>
									</div>
                                    <div class="form-group">
										<label for="unitSellingPrice4" class="col-sm-4 control-label">#words[196]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="unitSellingPrice4" name="unitSellingPrice4" value="#unitSellingPrice4#" placeholder="#words[196]#">	
										</div>
									</div>	                        						
								</div>
								<div class="col-sm-6">                      
                                	<div class="form-group">
										<label for="unitOfMeasurement" class="col-sm-4 control-label">#words[199]#</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" name="unitOfMeasurement">
                                                <option value="">#words[200]#</option>
                                                <cfloop query="getUnitOfMeasurement">
                                                	<option value="#getUnitOfMeasurement.unit#" #IIF(unit eq unitOfMeasurement,DE('selected'),DE(''))#>#getUnitOfMeasurement.unit#</option>
                                                </cfloop>
                                            </select>	
										</div>
									</div>
                                    <div class="form-group">
										<label for="unitCostPrice" class="col-sm-4 control-label">#words[201]#</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="unitCostPrice" name="unitCostPrice" value="#unitCostPrice#" placeholder="#words[201]#">	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
                
                <div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##foreignInfoCollapse">
						<h4 class="panel-title accordion-toggle">#words[685]#</h4>
					</div>                    
					<div id="foreignInfoCollapse" class="panel-collapse collapse">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">                      	
                                    <div class="form-group">
									                                    
                                    	<cfloop index="i" from="1" to="10">
                                            <label for="foreignCurrency#i#" class="col-sm-4 control-label">#words[i+229]#</label>
                                            <div class="col-sm-8">
                                            	<select class="form-control input-sm" id="foreignCurrency#i#" name="foreignCurrency#i#" >
                                                	<cfloop query="getCurrency">
														<cfif i EQ 1>
                                                            <cfset foreignCurrencyValue = #foreignCurrency#>
                                                        <cfelse>
                                                            <cfset foreignCurrencyValue = evaluate('foreignCurrency#i#')>
                                                        </cfif>
                                                        <option value ="#foreignCurrencyValue#">#foreignCurrencyValue#</option>
                                                    </cfloop>
                                                </select> 
                                            </div>
                                        </cfloop>     
									</div>
								</div>
                                
                                <div class="col-sm-3">                      	
                                    <div class="form-group">                               
                                    	<cfloop index="i" from="1" to="10">
                                            <div class="col-sm-8">
                                            	<cfif i EQ 1>
                                                	<cfset foreignUnitCostValue = #foreignUnitCost#>
                                                <cfelse>
                                                	<cfset foreignUnitCostValue = evaluate('foreignUnitCost#i#')>
                                                </cfif>	
                                                <input type="text" class="form-control input-sm" id="foreignUnitCostValue#i#" name="foreignUnitCostValue#i#" value="#foreignUnitCostValue#" placeholder="#words[i+321]#">	
                                            </div>
                                        </cfloop>     
									</div>
								</div>
                                
                                <div class="col-sm-3">                      	
                                    <div class="form-group">                               
                                    	<cfloop index="i" from="1" to="10">
                                            <div class="col-sm-8">
                                            	<cfif i EQ 1>
                                                	<cfset foreignSellingPriceValue = #foreignSellingPrice#>
                                                <cfelse>
                                                	<cfset foreignSellingPriceValue = evaluate('foreignSellingPrice#i#')>
                                                </cfif>	
                                                <input type="text" class="form-control input-sm" id="foreignSellingPriceValue#i#" name="foreignSellingPriceValue#i#" value="#foreignSellingPriceValue#" placeholder="#words[i+331]#">	
                                            </div>
                                        </cfloop>     
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
                
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##remarksInfoCollapse">
						<h4 class="panel-title accordion-toggle">#words[244]#</h4>
					</div>
					<div id="remarksInfoCollapse" class="panel-collapse collapse">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">      
                                 	<div class="form-group">                               
                                    	<cfloop index="i" from="1" to="15">
                                            <label for="remark#i#" class="col-sm-4 control-label"><cfif i lt 5>#words[i+90]#<cfelse>#words[i+240]#</cfif></label>
                                            <div class="col-sm-8">	
                                            	<cfset remarkValue = evaluate('remark#i#')>	
                                                <input type="text" class="form-control input-sm" id="remark#i#" name="remark#i#" value="#remarkValue#" placeholder="<cfif i lt 5>#words[i+90]#<cfelse>#words[i+240]#</cfif>" maxlength="25">										
                                            </div>
                                        </cfloop>     
									</div>                      
								</div>
                                <div class="col-sm-6">      
                                 	<div class="form-group">                               
                                    	<cfloop index="i" from="16" to="30">
                                            <label for="remark#i#" class="col-sm-4 control-label">#words[i+240]#</label>
                                            <div class="col-sm-8">	
                                            	<cfset remarkValue = evaluate('remark#i#')>	
                                                <input type="text" class="form-control input-sm" id="remark#i#" name="remark#i#" value="#remarkValue#" placeholder="#words[i+240]#" maxlength="25">										
                                            </div>
                                        </cfloop>     
									</div>                      
								</div>	
							</div>
						</div>
					</div>
				</div>
                
                <div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##colorInfoCollapse">
						<h4 class="panel-title accordion-toggle">#words[686]#</h4>
					</div>
					<div id="colorInfoCollapse" class="panel-collapse collapse">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">      
                                 	<div class="form-group">                               
                                    	<cfloop index="i" from="1" to="10">
                                            <label for="color#i#" class="col-sm-4 control-label">#words[i+608]#</label>
                                            <div class="col-sm-8">	
                                            	<cfset colorValue = evaluate('color#i#')>	
                                                <input type="text" class="form-control input-sm" id="color#i#" name="color#i#" value="#colorValue#" placeholder="#words[i+608]#" maxlength="10">										
                                            </div>
                                        </cfloop>     
									</div>                       
								</div>
                                <div class="col-sm-6">      
                                 	<div class="form-group">                               
                                    	<cfloop index="i" from="11" to="20">
                                            <label for="color#i#" class="col-sm-4 control-label">#words[i+608]#</label>
                                            <div class="col-sm-8">	
                                            	<cfset colorValue = evaluate('color#i#')>	
                                                <input type="text" class="form-control input-sm" id="color#i#" name="color#i#" value="#colorValue#" placeholder="#words[i+608]#" maxlength="10">										
                                            </div>
                                        </cfloop>     
									</div>                       
								</div>	
							</div>
						</div>
					</div>
				</div>
                
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##sizeInfoCollapse">
						<h4 class="panel-title accordion-toggle">#words[687]#</h4>
					</div>
					<div id="sizeInfoCollapse" class="panel-collapse collapse">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">      
                                 	<div class="form-group">                               
                                    	<cfloop index="i" from="1" to="10">
                                            <label for="size#i#" class="col-sm-4 control-label">#words[i+400]#</label>
                                            <div class="col-sm-8">	
                                            	<cfset sizeValue = evaluate('size#i#')>	
                                                <input type="text" class="form-control input-sm" id="size#i#" name="size#i#" value="#sizeValue#" placeholder="#words[i+400]#" maxlength="10">										
                                            </div>
                                        </cfloop>     
									</div>                       
								</div>
                                <div class="col-sm-6">      
                                 	<div class="form-group">                               
                                    	<cfloop index="i" from="11" to="20">
                                            <label for="size#i#" class="col-sm-4 control-label">#words[i+400]#</label>
                                            <div class="col-sm-8">	
                                            	<cfset sizeValue = evaluate('size#i#')>	
                                                <input type="text" class="form-control input-sm" id="size#i#" name="size#i#" value="#sizeValue#" placeholder="#words[i+400]#" maxlength="10">										
                                            </div>
                                        </cfloop>     
									</div>                       
								</div>	
							</div>
						</div>
					</div>
				</div>
                <div id="sizeajaxfield"></div>
                
                <div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##otherInfoCollapse">
						<h4 class="panel-title accordion-toggle">#words[688]#</h4>
					</div>
					<div id="otherInfoCollapse" class="panel-collapse collapse">
						<div class="panel-body">
							<div class="row">                          
                                <div class="col-sm-6">      
                                 	<div class="form-group">                               
                                    	<label for="sizeAndColor" class="col-sm-4 control-label">#words[629]#</label>
										<div class="col-sm-8">
											<div class="row">
												<div class="col-sm-7">
													<div class="radio">	
														<input type="radio" id="sizeColor" name="sizeColor" value="SC" <cfif sizeColor eq "SC">checked</cfif>>
													</div>													
												</div>
											</div>											
										</div>
                                        <label for="sizeOnly" class="col-sm-4 control-label">#words[630]#</label>
										<div class="col-sm-8">
											<div class="row">
												<div class="col-sm-7">
													<div class="radio">	
														<input type="radio" id="sizeColor" name="sizeColor" value="S" <cfif sizeColor eq "S">checked</cfif>>
													</div>													
												</div>
											</div>											
										</div>
                                        <label for="colorOnly" class="col-sm-4 control-label">#words[631]#</label>
										<div class="col-sm-8">
											<div class="row">
												<div class="col-sm-7">
													<div class="radio">	
														<input type="radio" id="sizeColor" name="sizeColor" value="C" <cfif sizeColor eq "C">checked</cfif>>
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
                
			</div>
            
            <div class="pull-right">
				<input type="submit" value="#pageAction#" class="btn btn-primary"/>
				<input type="button" value="#words[96]#" onclick="window.location='/latest/maintenance/matrixProfile.cfm'" class="btn btn-default" />
			</div>
</form>
</cfoutput>
</body>
</html>

