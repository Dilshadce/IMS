<cfif IsDefined('url.itemno')>
	<cfset URLitemNo = trim(urldecode(url.itemno))>
</cfif>

<cfquery name="getTax" datasource="#dts#">
	SELECT "" AS code,"Choose a Default Tax" AS code2 
	UNION ALL
	SELECT code,code as code2 
    FROM #target_taxtable# 
    WHERE (tax_type = "ST" OR tax_type = "T");
</cfquery>

<cfquery name="getCategory" datasource="#dts#">
    SELECT * 
    FROM iccate;
</cfquery>  

<cfquery name="getBrand" datasource="#dts#">
    SELECT * 
    FROM brand;
</cfquery> 

<cfquery name="getGroup" datasource="#dts#">
    SELECT * 
    FROM icgroup;
</cfquery> 

<cfquery name="getCommission" datasource="#dts#">
    SELECT commname 
    FROM commission;
</cfquery>       

<cfquery name="getMaterial" datasource='#dts#'>
    SELECT * 
    FROM iccolorid;
</cfquery>

<cfquery name="getRating" datasource='#dts#'>
    SELECT * 
    FROM iccostcode;
</cfquery>

<cfquery name="getSize" datasource='#dts#'>
    SELECT * 
    FROM icsizeid;
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
  SELECT * 
  FROM gsetup2;
</cfquery>
<cfset iDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_UPrice = '.'>
<cfloop index='LoopCount' from='1' to='#iDecl_UPrice#'>
  <cfset stDecl_UPrice = stDecl_UPrice & '_'>
</cfloop>

<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfset pageTitle="Create Product Profile">
		<cfset pageAction="Create">
        
        <!--- Panel 1--->
        <cfset itemNo = "">
        <cfset desp = "">
        <cfset despa= "">
        <cfset comment = "">
        <cfset productCode = "">
        <cfset barCode = "">
        <cfset defaultTax = "">
        <cfset itemType = "">
        <cfset photo = "">
        
        <!--- Panel 2--->
        <cfset brand = "">
        <cfset commission = "">
        <cfset category = "">
        <cfset group = "">
        <cfset material = "">
        <cfset model = "">
        <cfset rating = ""> 
        <cfset size = "">
        <cfset supplier = "">
        <cfset qtyFormula = "">  
        <cfset unitPriceFormula = "">   
        <cfset serialNo = "">
        <cfset relatedItem = ""> 
        <cfset packing = "">
        <cfset reorder = "">
        <cfset minimum = "">
        <cfset maximum = "">
        <cfset qtyBF = "">
        <cfset quantity2 = "">
        <cfset quantity3 = "">
        <cfset quantity4 = "">
        <cfset quantity5 = "">
        <cfset quantity6 = "">
        <cfset graded = "">
        <cfset nonGraded = "">
        
        <!--- Panel 3--->
        <cfset salec = "">
		<cfset salecsc = "">
        <cfset salecnc = "">
        <cfset purc = "">
        <cfset purprc = "">
		<cfset displayDefaultValue = "Choose a GL Account">
        
        <!--- Panel 4--->
        <cfloop index="i" from="1" to="6">
        	<cfset 'unitSellingPrice#i#' = "">
		</cfloop>
        <cfset muRatio = "">
        <cfset unitOfMeasurement = "">
        <cfset unitCostPrice = "">
        <cfset minSellingPrice = "">
        <cfset normal= "">
        <cfset offer = "">
        <cfset others = "">

        
        <!--- Panel 5--->
        <cfset unitOfMeasurement2 = "">
        <cfset firstUnit2 = "">
        <cfset secondUnit2 = "">
        <cfset sellingPrice2 = "">	
        <cfloop index="i" from="3" to="6">
        	<cfset 'unitOfMeasurement#i#' = "">
            <cfset 'firstUnit#i#' = "">
            <cfset 'secondUnit#i#' = "">
            <cfset 'sellingPrice#i#' = "">
        </cfloop>
          
        <cfloop index="i" from="1" to="10">
        	<cfset 'packingName#i#' = "">
            <cfset 'quantity#i#' = "">
            <cfset 'freeQty#i#' = "">>
        </cfloop>        
        
        <!--- Panel 7--->       
        <cfset foreignCurrency1 = "">
        <cfset foreignUnitCost1 = "">
        <cfset foreignSellingPrice1 = "">   
        <cfloop index="i" from="2" to="10">
        	<cfset 'foreignCurrency#i#' = "">
            <cfset 'foreignUnitCost#i#' = "">
            <cfset 'foreignSellingPrice#i#' = "">
        </cfloop>
        
        <!--- Panel 8--->
        <cfloop index="i" from="1" to="30">
        	<cfset 'remark#i#' = "">
        </cfloop>
         
	<cfelseif url.action EQ "update">
		<cfset pageTitle="Update Product Profile">
		<cfset pageAction="Update">
        
		<cfquery name="getProduct" datasource='#dts#'>
            SELECT * 
            FROM icitem 
            WHERE itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLitemNo#">;
		</cfquery>
        
        <!--- Panel 1--->
        <cfset itemNo = getProduct.itemno>
        <cfset desp = getProduct.desp>
        <cfset despa= getProduct.despa>
        <cfset comment = getProduct.comment>
        <cfset productCode = getProduct.aitemno>
        <cfset barCode = getProduct.barcode>
        <cfset defaultTax = getProduct.taxcode>
        <cfset itemType = getProduct.itemtype>
        <cfset photo = getProduct.photo>
        
        <!--- Panel 2--->
        <cfset brand = getProduct.brand>
        <cfset commission = getProduct.commlvl>
        <cfset category = getProduct.category>
        <cfset group = getProduct.wos_group>
        <cfset material = getProduct.colorid>
        <cfset model = getProduct.shelf>
        <cfset rating = getProduct.costcode> 
        <cfset size = getProduct.sizeid>
        <cfset supplier = getProduct.supp>
        <cfset qtyFormula = getProduct.wqformula>  
        <cfset unitPriceFormula = getProduct.wpformula>   
        <cfset serialNo = getProduct.wserialno>
        <cfset relatedItem = ""> 
        <cfset packing = getProduct.packing>
        <cfset reorder = getProduct.reorder>
        <cfset minimum = getProduct.minimum>
        <cfset maximum = getProduct.maximum>
        <cfset qtyBF = getProduct.qtybf>
        <cfset quantity1 = getProduct.qty>
        <cfloop index="i" from="2" to="6">
        	<cfset 'quantity#i#' = evaluate('getProduct.qty#i#')>
        </cfloop>
        
        <cfset grade = getProduct.graded>
        
        <!--- Panel 3--->
        <cfset salec = getProduct.salec>
		<cfset salecsc = getProduct.salecsc>
        <cfset salecnc = getProduct.salecnc>
        <cfset purc = getProduct.purc>
        <cfset purprc = getProduct.purprec>
		<cfset displayDefaultValue = "Choose a GL Account">
        
        <!--- Panel 4--->
        <cfloop index="i" from="1" to="6">
        	<cfif i EQ 1>
            	<cfset 'unitSellingPrice#i#' = getProduct.price>
            <cfelse>
        		<cfset 'unitSellingPrice#i#' = evaluate('getProduct.price#i#')>
            </cfif>
		</cfloop>
        <cfset muRatio = getProduct.muratio>
        <cfset unitOfMeasurement = getProduct.unit>
        <cfset unitCostPrice = getProduct.ucost>
        <cfset minSellingPrice = getProduct.price_min>
        <cfset normal= "">
        <cfset offer = "">
        <cfset others = "">

        
        <!--- Panel 5--->
        <cfset unitOfMeasurement2 = getProduct.unit2>
        <cfset firstUnit2 = getProduct.factor1>
        <cfset secondUnit2 = getProduct.factor2>
        <cfset sellingPrice2 = getProduct.priceu2>	
        <cfloop index="i" from="3" to="6">
        	<cfset 'unitOfMeasurement#i#' = evaluate('getProduct.unit#i#')>
            <cfset 'firstUnit#i#' = evaluate('getProduct.factoru#i#_a')>
            <cfset 'secondUnit#i#' = evaluate('getProduct.factoru#i#_b')>
            <cfset 'sellingPrice#i#' = evaluate('getProduct.priceu#i#')>
        </cfloop>
        
        
        <cfloop index="i" from="1" to="10">
        	<cfset 'packingName#i#' = evaluate('getProduct.packingdesp#i#')>
            <cfset 'quantity#i#' = evaluate('getProduct.packingqty#i#')>
            <cfset 'freeQty#i#' = evaluate('getProduct.packingfreeqty#i#')>>
        </cfloop>        
        
        <!--- Panel 7--->   
        <cfset foreignCurrency1 = getProduct.fucost>
        <cfset foreignUnitCost1 = getProduct.fprice>
        <cfset foreignSellingPrice1 = getProduct.fcurrcode>   
        <cfloop index="i" from="2" to="10">
        	<cfset 'foreignCurrency#i#' = evaluate('getProduct.fucost#i#')>
            <cfset 'foreignUnitCost#i#' = evaluate('getProduct.fprice#i#')>
            <cfset 'foreignSellingPrice#i#' = evaluate('getProduct.fcurrcode#i#')>
        </cfloop>
        
        <!--- Panel 8--->
        <cfloop index="i" from="1" to="30">
        	<cfset 'remark#i#' = evaluate('getProduct.remark#i#')>
        </cfloop>              
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
    
    <cfinclude template="/latest/maintenance/filter/filterBrand.cfm">
    <cfinclude template="/latest/maintenance/filter/filterCategory.cfm">
    <cfinclude template="/latest/maintenance/filter/filterGroup.cfm">
    <cfinclude template="/latest/maintenance/filter/filterSupplier.cfm">
    <cfinclude template="filterGL.cfm">
    
    <link rel="stylesheet" href="/latest/css/select2/select2.css" />
    <script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
    <script language="JavaScript">
	
		function add_option(pic_name)
		{
			var agree = confirm("Are You Sure ?");
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
	</script>
</head>

<body class="container">
<cfoutput>
<form id="form" name="form" class="form-horizontal" role="form" action="/latest/maintenance/productProcess.cfm?action=#url.action#" method="post" onsubmit="document.getElementById('itemNo').disabled=false";>
	<div class="page-header">
		<h3>#pageTitle#</h3>
	</div>
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
										<label for="itemNo" class="col-sm-4 control-label">Item No</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="itemNo" name="itemNo" value="#itemNo#" placeholder="Item No">									
										</div>
									</div>				  
                                    <div class="form-group">
										<label for="desp" class="col-sm-4 control-label">Description</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="desp" name="desp" value="#desp#" placeholder="Description">									
                                            <input type="text" class="form-control input-sm" id="despa" name="despa" value="#despa#" placeholder="Description 2">									
										</div>
									</div>	  
                                    <div class="form-group">
										<label for="comment" class="col-sm-4 control-label">Comment</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="comment" name="comment" value="#comment#" placeholder="Comment">									
										</div>
									</div> 
                                    <div class="form-group">
										<label for="productCode" class="col-sm-4 control-label">Product Code</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="productCode" name="productCode" value="#productCode#" placeholder="Product Code">									
										</div>
									</div>	
                                    <div class="form-group">
										<label for="barCode" class="col-sm-4 control-label">Bar Code</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="barCode" name="barCode" value="#barCode#" placeholder="Bar Code">									
										</div>
									</div>  
                                    <div class="form-group">
										<label for="defaultTax" class="col-sm-4 control-label">Default Tax</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" id="defaultTax" name="defaultTax">
                                            	<option value="">Choose a Default Tax</option>
                                                <cfloop query="getTax">
                                              		<option value="#code#" <cfif IsDefined('getProduct.taxcode') AND getTax.code eq defaultTax>selected</cfif>>#code#</option>
                                                </cfloop>    
                                            </select>								
										</div>
									</div> 
                                    <div class="form-group">
										<label for="itemType" class="col-sm-4 control-label">Item Type</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" id="itemType" name="itemType">
                                            	<option value="">Choose an Item Type</option>
                                              	<option value="S" <cfif itemType eq "S">selected </cfif>>Sales Only</option>
                                              	<option value="P" <cfif itemType eq "P">selected </cfif>>Purchases Only</option>
                                              	<option value="SV" <cfif itemType eq "SV">selected </cfif>>Service Only</option>
                                            </select>								
										</div>
									</div>
                                    <div class="form-group">
										<label for="photo" class="col-sm-4 control-label">Item's Image</label>
										<div class="col-sm-8">
											<cfdirectory action="list" directory="#HRootPath#\images\#hcomid#\" name="picture_list">
                                            <select name="picture_available" id="picture_available" onChange="javascript:change_picture(this.value);" class="form-control input-sm">
                                                <option value="">Choose an Image</option>
                                                <cfloop query="picture_list">
                                                    <cfif picture_list.name neq "Thumbs.db">
                                                        <option value="#picture_list.name#" #iif((photo eq picture_list.name),DE("selected"),DE(""))#>#picture_list.name#</option>
                                                    </cfif>
                                                </cfloop>
                                             </select> 
                                             <input type="button" name="uploadPhoto" id="uploadPhoto" value="Upload Item's Image" onClick="window.open('/latest/uploadImage/icitem_image.cfm','Upload Item's Image','height=300,width=200');">
                                            <div style="float:right; margin:25px;">	
                                            	<iframe id="show_picture" name="show_picture" frameborder="0" marginheight="0" marginwidth="0" align="middle" height="150" width="150" scrolling="no" src="/latest/uploadImage/icitem_image.cfm?pic3=#urlencodedformat(photo)#"></iframe>		
                                            </div>		
										</div>
									</div>                                                                  						
								</div>
							</div>
						</div>
					</div>
				</div>
                	
				<div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##generalInfoCollapse">
						<h4 class="panel-title accordion-toggle">Product Information</h4>
					</div>
					<div id="generalInfoCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">      
                                 	<div class="form-group">
										<label for="brand" class="col-sm-4 control-label">Brand</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" id="brand" name="brand">
                                                <option value="">Choose a Brand</option>
                                                <cfloop query="getBrand">
                                                    <option value="#getBrand.brand#" <cfif IsDefined('getBrand.brand') AND getBrand.brand eq brand>selected</cfif>>#getBrand.brand#</option>
                                                </cfloop>
                                            </select>										
										</div>
									</div>                
                                    <div class="form-group">
										<label for="category" class="col-sm-4 control-label">Category</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" id="category" name="category">
                                                <option value="">Choose a Category</option>
                                                <cfloop query="getCategory">
                                                    <option value="#getCategory.cate#" <cfif IsDefined('getCategory.cate') AND getCategory.cate eq category>selected</cfif>>#getCategory.cate#</option>
                                                </cfloop>
                                            </select>
										</div>
									</div>	
                                    <div class="form-group">
										<label for="commision" class="col-sm-4 control-label">Commision</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" id="commission" name="commission">
                                                <option value="">Choose a Commision</option>
                                                <cfloop query="getCommission">
                                                    <option value="#getCommission.commname#" <cfif IsDefined('getCommission.commname') AND getCommission.commname EQ commission>selected</cfif>>#getCommission.commname#</option>
                                                </cfloop>
                                            </select>
										</div>
									</div>
                                    <div class="form-group">
										<label for="group" class="col-sm-4 control-label">Group</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" id="group" name="group">
                                                <option value="">Choose a Group</option>
                                                <cfloop query="getGroup">
                                                    <option value="#getGroup.wos_group#" <cfif IsDefined('getGroup.wos_group') AND getGroup.wos_group EQ group>selected</cfif>>#getGroup.wos_group#</option>
                                                </cfloop>
                                            </select>	
										</div>
									</div>	
                                   	<div class="form-group">
										<label for="material" class="col-sm-4 control-label">Material</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" id="material" name="material">
                                                <option value="">Choose a Material</option>
                                                <cfloop query="getMaterial">
                                                    <option value="#getMaterial.commname#" <cfif IsDefined('getMaterial.colorid') AND getMaterial.colorid EQ material>selected</cfif>>#getMaterial.colorid#</option>
                                                </cfloop>
                                            </select>
										</div>
									</div> 
                                    <div class="form-group">
										<label for="rating" class="col-sm-4 control-label">Rating</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" id="rating" name="rating">
                                                <option value="">Choose a Rating</option>
                                                <cfloop query="getRating">
                                                    <option value="#getRating.costcode#" <cfif IsDefined('getRating.costcode') AND getRating.costcode EQ rating>selected</cfif>>#getRating.costcode#</option>
                                                </cfloop>
                                            </select>
										</div>
									</div> 
                                    <div class="form-group">
										<label for="size" class="col-sm-4 control-label">Size</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" id="size" name="size">
                                                <option value="">Choose a Size</option>
                                                <cfloop query="getSize">
                                                    <option value="#getSize.sizeid#" <cfif IsDefined('getSize.sizeid') AND getSize.sizeid EQ size>selected</cfif>>#getSize.sizeid#</option>
                                                </cfloop>
                                            </select>
										</div>
									</div> 
                                    <div class="form-group">
										<label for="supplier" class="col-sm-4 control-label">Supplier</label>
										<div class="col-sm-8">
											<input type="hidden" id="supplier" name="supplier" class="supplierFilter" value="#supplier#" data-placeholder="Choose a Supplier" />
										</div>
									</div>
                                    <div class="form-group">
										<label for="qtyFormula" class="col-sm-4 control-label">Quantity Formula</label>
										<div class="col-sm-8">
											<input type="checkbox" id="quantityFormula" name="quantityFormula" value="1"/>
										</div>
									</div>
                                    <div class="form-group">
										<label for="unitPriceFormula" class="col-sm-4 control-label">Unit Price Formula</label>
										<div class="col-sm-8">
											<input type="checkbox" id="unitPriceFormula" name="unitPriceFormula" value="1"/>
										</div>
									</div>
                                    <div class="form-group">
										<label for="serialNo" class="col-sm-4 control-label">Serial No</label>
										<div class="col-sm-8">
											<input type="checkbox" id="serialNo" name="serialNo" value="T"/>
										</div>
									</div>
                                    <!---
                                    <div class="form-group">
										<label for="relatedItem" class="col-sm-4 control-label">Related Item</label>
										<div class="col-sm-8">
											<input type="checkbox" id="relatedItem" name="relatedItem" value="1"/>
										</div>
									</div>
                                    --->
								</div>
                                <div class="col-sm-6">
                                	<div class="form-group">
										<label for="packing" class="col-sm-4 control-label">Packing</label>
										<div class="col-sm-8">
												<input type="text" class="form-control input-sm" id="packing" name="packing" value="#packing#" placeholder="Packing Info" maxlength="20">
										</div>
									</div>	
                                    <div class="form-group">
										<label for="reorder" class="col-sm-4 control-label">Reorder</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="reorder" name="reorder" value="#reorder#" placeholder="Reorder Info" maxlength="20">
										</div>
									</div>
                                    <div class="form-group">
										<label for="minimum" class="col-sm-4 control-label">Minimum</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="minimum" name="minimum" value="#minimum#" placeholder="Minimum Info" maxlength="20">
										</div>
									</div> 
                                    <div class="form-group">
										<label for="maximum" class="col-sm-4 control-label">Maximum</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="maximum" name="maximum" value="#maximum#" placeholder="Maximum Info" maxlength="20">
										</div>
									</div>
                                    <div class="form-group">
										<label for="qtyBF" class="col-sm-4 control-label">Quantity B/F</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="qtyBF" name="qtyBF" value="#qtyBF#" placeholder="Quantity Bring Forward" maxlength="20">
										</div>
									</div>
                                    <div class="form-group">
										<label for="quantity2" class="col-sm-4 control-label">Length</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="quantity2" name="quantity2" value="#quantity2#" placeholder="Length Info" maxlength="20">
										</div>
									</div>
                                    <div class="form-group">
										<label for="quantity3" class="col-sm-4 control-label">Width</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="quantity3" name="quantity3" value="#quantity3#" placeholder="Width Info" maxlength="20">
										</div>
									</div>
                                    <div class="form-group">
										<label for="quantity4" class="col-sm-4 control-label">Thickness</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="quantity4" name="quantity4" value="#quantity4#" placeholder="Thickness Info" maxlength="20">
										</div>
									</div> 
                                    <div class="form-group">
										<label for="quantity5" class="col-sm-4 control-label">Weight/Length</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="quantity5" name="quantity5" value="#quantity5#" placeholder="Weight/Length Info" maxlength="20">
										</div>
									</div> 
                                    <div class="form-group">
										<label for="quantity6" class="col-sm-4 control-label">Price/Weight</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="quantity6" name="quantity6" value="#quantity6#" placeholder="Price/Weight Info" maxlength="20">
										</div>
									</div>
                                    <div class="form-group">
										<label for="graded" class="col-sm-4 control-label">Graded</label>
										<div class="col-sm-8">
											<input type="radio" class="form-control radio-sm" id="grade" name="grade" value="Y" <cfif IsDefined('getProduct.graded') AND getProduct.graded eq "Y">checked</cfif>>
										</div>
									</div> 
                                    <div class="form-group">
										<label for="nonGraded" class="col-sm-4 control-label">Non-Graded</label>
										<div class="col-sm-8">
											<input type="radio" class="form-control radio-sm" id="grade" name="grade" value="N" <cfif IsDefined('getProduct.graded') AND getProduct.graded eq "N">checked</cfif>>
										</div>
									</div>
                                </div>
							</div>
						</div>
					</div>
				</div>

                <div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##generalLedgerInfoCollapse">
						<h4 class="panel-title accordion-toggle">General Ledger Information</h4>
					</div>
					<div id="generalLedgerInfoCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">      
                                	<div class="form-group">
										<label for="creditSales" class="col-sm-4 control-label">Credit Sales</label>
										<div class="col-sm-8">
											<cfif salec neq ''>
                                                <cfset displayValue = salec>   
                                            <cfelse>
                                                <cfset displayValue = displayDefaultValue>
                                            </cfif>
											<input type="hidden" id="creditSales" name="creditSales" class="accno1" data-placeholder="#displayValue#" />	
										</div>
									</div>
                                    <div class="form-group">
										<label for="cashSales" class="col-sm-4 control-label">Cash Sales</label>
										<div class="col-sm-8">  
											<cfif salecsc neq ''>
                                                <cfset displayValue = salecsc>   
                                            <cfelse>
                                                <cfset displayValue = displayDefaultValue>
                                            </cfif>                                    
											<input type="hidden" id="cashSales" name="cashSales" class="accno2" data-placeholder="#displayValue#" />	
										</div>
									</div>	
                                    <div class="form-group">
										<label for="salesReturn" class="col-sm-4 control-label">Sales Return</label>
										<div class="col-sm-8">
                                        	<cfif salecnc neq ''>
                                                <cfset displayValue = salecnc>   
                                            <cfelse>
                                                <cfset displayValue = displayDefaultValue>
                                            </cfif>
											<input type="hidden" id="salesReturn" name="salesReturn" class="accno3" data-placeholder="#displayValue#" />	
										</div>
									</div>	   
                                    <div class="form-group">
										<label for="purchase" class="col-sm-4 control-label">Purchase</label>
										<div class="col-sm-8">
                                        	<cfif purc neq ''>
                                                <cfset displayValue = purc>   
                                            <cfelse>
                                                <cfset displayValue = displayDefaultValue>
                                            </cfif>
											<input type="hidden" id="purchase" name="purchase" class="accno4" data-placeholder="#displayValue#" />	
										</div>
									</div>
                                    <div class="form-group">
										<label for="purchaseReturn" class="col-sm-4 control-label">Purchase Return</label>
										<div class="col-sm-8">
                                        	<cfif purprc neq ''>
                                                <cfset displayValue = purprc>   
                                            <cfelse>
                                                <cfset displayValue = displayDefaultValue>
                                            </cfif>
											<input type="hidden" id="purchaseReturn" name="purchaseReturn" class="accno5" data-placeholder="#displayValue#" />	
										</div>
									</div> 	                     
								</div>	
							</div>
						</div>
					</div>
				</div>
                
                <div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##productInfoCollapse">
						<h4 class="panel-title accordion-toggle">Unit Information</h4>
					</div>                    
					<div id="productInfoCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
                                <div class="col-sm-6">    
                                	<div class="form-group">
										<label for="unitSellingPrice1" class="col-sm-4 control-label">Unit Selling Price 1</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="unitSellingPrice1" name="unitSellingPrice1" value="#unitSellingPrice1#" placeholder="Unit Selling Price 1">	
										</div>
									</div>	
                                    <div class="form-group">
										<label for="unitSellingPrice2" class="col-sm-4 control-label">Unit Selling Price 2</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="unitSellingPrice2" name="unitSellingPrice2" value="#unitSellingPrice2#" placeholder="Unit Selling Price 2">	
										</div>
									</div>
                                    <div class="form-group">
										<label for="muRatio" class="col-sm-4 control-label">M.U Ratio</label>
                                        <div class="col-sm-2">
											<input type="text" class="form-control input-sm" id="muRatio" name="muRatio" value="#muRatio#" placeholder="M.U Ratio" onkeyup="calculateMUratio(#iDecl_UPrice#)">	
										</div>
										<div class="col-sm-6">
											<input type="text" class="form-control input-sm" id="unitSellingPrice3" name="unitSellingPrice3" value="#NumberFormat(unitSellingPrice3, stDecl_UPrice)#" placeholder="Unit Selling Price 3">	
										</div>
									</div>
                                    <div class="form-group">
										<label for="unitSellingPrice4" class="col-sm-4 control-label">Unit Selling Price 4</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="unitSellingPrice4" name="unitSellingPrice4" value="#unitSellingPrice4#" placeholder="Unit Selling Price 4">	
										</div>
									</div>	
                                    <div class="form-group">
										<label for="unitSellingPrice5" class="col-sm-4 control-label">Unit Selling Price 5</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="unitSellingPrice5" name="unitSellingPrice5" value="#unitSellingPrice5#" placeholder="Unit Selling Price 5">	
										</div>
									</div>	
                                    <div class="form-group">
										<label for="unitSellingPrice6" class="col-sm-4 control-label">Unit Selling Price 6</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="unitSellingPrice6" name="unitSellingPrice6" value="#unitSellingPrice6#" placeholder="Unit Selling Price 6">	
										</div>
									</div>                        						
								</div>
                                <div class="col-sm-6">                      
                                	<div class="form-group">
										<label for="unitOfMeasurement" class="col-sm-4 control-label">Unit of Measurement</label>
										<div class="col-sm-8">
											<select class="form-control input-sm" name="unitOfMeasurement">
                                                <option value="">Choose an Unit of Measurement</option>
                                                <cfloop query="getUnitOfMeasurement">
                                                	<option value="#getUnitOfMeasurement.unit#" #IIF(unit eq unitOfMeasurement,DE('selected'),DE(''))#>#getUnitOfMeasurement.unit#</option>
                                                </cfloop>
                                            </select>	
										</div>
									</div>
                                    <div class="form-group">
										<label for="unitCostPrice" class="col-sm-4 control-label">Unit Cost Price</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="unitCostPrice" name="unitCostPrice" value="#unitCostPrice#" placeholder="Unit Cost Price">	
										</div>
									</div>
                                    <div class="form-group">
										<label for="minSellingPrice" class="col-sm-4 control-label">Minimum Selling Price</label>
										<div class="col-sm-8">
											<input type="text" class="form-control input-sm" id="minSellingPrice" name="minSellingPrice" value="#minSellingPrice#" placeholder="Minimum Selling Price">	
										</div>
									</div>
                                    <div class="form-group">
										<label for="normal" class="col-sm-4 control-label">Normal</label>
										<div class="col-sm-8">
											<input type="radio" id="normal" name="normal" value="normal">	
										</div>
									</div>
                                    <div class="form-group">
										<label for="offer" class="col-sm-4 control-label">Offer</label>
										<div class="col-sm-8">
											<input type="radio" id="offer" name="offer" value="offer">
										</div>
									</div>
                                    <div class="form-group">
										<label for="others" class="col-sm-4 control-label">Others</label>
										<div class="col-sm-8">
											<input type="radio" id="others" name="others" value="others">	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
                
                <div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##panel5InfoCollapse">
						<h4 class="panel-title accordion-toggle">2nd Unit Information</h4>
					</div>
					<div id="panel5InfoCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-4">      
                                	<div class="form-group">
                                    	<cfloop index="i" from="2" to="6">
                                            <label for="unitOfMeasurement#i#" class="col-sm-4 control-label">U.O.M #i-1#</label>
                                            <div class="col-sm-8">
                                                <select class="form-control input-sm" name="unitOfMeasurement#i#">
                                                    <option value="">Choose an Unit of Measurement</option>
                                                    <cfloop query="getUnitOfMeasurement">
                                                        <option value="#getUnitOfMeasurement.unit#" #IIF(unit eq unitOfMeasurement,DE('selected'),DE(''))#>#getUnitOfMeasurement.unit#</option>
                                                    </cfloop>
                                                </select>	
                                            </div>
                                        </cfloop>
									</div> 	                    
								</div>
                                
                                <div class="col-sm-2">                      	
                                    <div class="form-group">                               
                                    	<cfloop index="i" from="2" to="6">
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="firstUnit#i#" name="firstUnit#i#" value="#evaluate('firstUnit#i#')#" placeholder="1st Unit">	
                                            </div>
                                        </cfloop>     
									</div>
								</div>
                                
                                <div class="col-sm-2">                      	
                                    <div class="form-group">                               
                                    	<cfloop index="i" from="2" to="6">
                                            <div class="col-sm-8">	
                                                <input type="text" class="form-control input-sm" id="secondUnit#i#" name="secondUnit#i#" value="#evaluate('secondUnit#i#')#" placeholder="2nd Unit">	
                                            </div>
                                        </cfloop>    
									</div>
								</div>
                                
                                <div class="col-sm-3">                      	
                                    <div class="form-group">                               
                                    	<cfloop index="i" from="2" to="6">
                                            <div class="col-sm-8">	
                                                <input type="text" class="form-control input-sm" id="sellingPrice#i#" name="sellingPrice#i#" value="#evaluate('sellingPrice#i#')#" placeholder="Selling Price">	
                                            </div>
                                        </cfloop>    
									</div>
								</div>
                                
							</div>
						</div>
					</div>
				</div>
                
                <div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##panel6InfoCollapse">
						<h4 class="panel-title accordion-toggle">Packing Information</h4>
					</div>
					<div id="panel6InfoCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">      
                                	<div class="form-group">
                                    	<cfloop index="i" from="1" to="10">
                                            <label for="packingName#i#" class="col-sm-4 control-label">Packing Name #i#</label>
                                            <div class="col-sm-8">
                                            	 <input type="text" class="form-control input-sm" id="packingName#i#" name="packingName#i#" value="#evaluate('packingName#i#')#" placeholder="Packing Name #i#">	   
                                            </div>
                                        </cfloop>
									</div> 	                    
								</div>
                                
                                <div class="col-sm-3">                      	
                                    <div class="form-group">                               
                                    	<cfloop index="i" from="1" to="10">
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="quantity#i#" name="quantity#i#" value="#evaluate('quantity#i#')#" placeholder="Quantity">	
                                            </div>
                                        </cfloop>     
									</div>
								</div>
                                
                                <div class="col-sm-3">                      	
                                    <div class="form-group">                               
                                    	<cfloop index="i" from="1" to="10">
                                            <div class="col-sm-8">
                                            	<input type="text" class="form-control input-sm" id="freeQty#i#" name="freeQty#i#" value="#evaluate('freeQty#i#')#" placeholder="Free Quantity">	
                                            </div>
                                        </cfloop>    
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>                

                <div class="panel panel-default">
					<div class="panel-heading" data-toggle="collapse" href="##foreignInfoCollapse">
						<h4 class="panel-title accordion-toggle">Foreign Currency, Unit Cost and Selling Price Information</h4>
					</div>                    
					<div id="foreignInfoCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">                      	
                                    <div class="form-group">                              
                                    	<cfloop index="i" from="1" to="10">
                                            <label for="foreignCurrency#i#" class="col-sm-4 control-label">Foreign Currency #i#</label>
                                            <div class="col-sm-8">
                                            	<select class="form-control input-sm" id="foreignCurrency#i#" name="foreignCurrency#i#" >
                                                	<option value="">Choose a Foreign Currency</option>
                                                	<cfloop query="getCurrency">
                                                        <option value ="#evaluate('foreignCurrency#i#')#">#evaluate('foreignCurrency#i#')#</option>
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
                                                <input type="text" class="form-control input-sm" id="foreignUnitCost#i#" name="foreignUnitCost#i#" value="#evaluate('foreignUnitCost#i#')#" placeholder="Foreign Unit Cost #i#">	
                                            </div>
                                        </cfloop>     
									</div>
								</div>
                                
                                <div class="col-sm-3">                      	
                                    <div class="form-group">                               
                                    	<cfloop index="i" from="1" to="10">
                                            <div class="col-sm-8">
                                                <input type="text" class="form-control input-sm" id="foreignSellingPrice#i#" name="foreignSellingPrice#i#" value="#evaluate('foreignSellingPrice#i#')#" placeholder="Foreign Selling Price #i#">	
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
						<h4 class="panel-title accordion-toggle">Remark Information</h4>
					</div>
					<div id="remarksInfoCollapse" class="panel-collapse collapse in">
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-6">      
                                 	<div class="form-group">                               
                                    	<cfloop index="i" from="1" to="15">
                                            <label for="remark#i#" class="col-sm-4 control-label">Remark #i#</label>
                                            <div class="col-sm-8">	
                                            	<cfset remarkValue = evaluate('remark#i#')>	
                                                <input type="text" class="form-control input-sm" id="remark#i#" name="remark#i#" value="#remarkValue#" placeholder="Remark #i#" maxlength="25">										
                                            </div>
                                        </cfloop>     
									</div>                      
								</div>
                                <div class="col-sm-6">      
                                 	<div class="form-group">                               
                                    	<cfloop index="i" from="16" to="30">
                                            <label for="remark#i#" class="col-sm-4 control-label">Remark #i#</label>
                                            <div class="col-sm-8">	
                                            	<cfset remarkValue = evaluate('remark#i#')>	
                                                <input type="text" class="form-control input-sm" id="remark#i#" name="remark#i#" value="#remarkValue#" placeholder="Remark #i#" maxlength="25">										
                                            </div>
                                        </cfloop>     
									</div>                      
								</div>	
							</div>
						</div>
					</div>
				</div>  
			</div>
            
            <div class="pull-right">
				<input type="submit" value="#pageAction#" class="btn btn-primary"/>
				<input type="button" value="Cancel" onclick="window.location='/latest/maintenance/productProfile.cfm'" class="btn btn-default" />
        
</form>

</cfoutput>
</body>
</html>

    



