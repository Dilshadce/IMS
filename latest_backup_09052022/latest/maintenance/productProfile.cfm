<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "116,120,121,65,122,123,10,11,117,118,119,3,299">
<cfinclude template="/latest/words.cfm">
<cfinclude template="/latest/pageTitle/pageTitle.cfm">
<cfset targetTitle="Product">
<cfset targetTable="icitem">
<cfset pageTitle="#words[116]#">
<cfset displayEditDelete=getUserPin2.H10103_3b>

<cfquery name="getdisplaysetup" datasource="#dts#">
    select * 
    from displaysetup;
</cfquery>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/dataTables/dataTables_bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/bootstrap-multiselect/bootstrap-multiselect.css" />
    <link rel="stylesheet" type="text/css" href="/latest/css/maintenance/profile.css" />
    <!--[if lt IE 9]>
        <script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
        <script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
    <![endif]-->
 
    <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/latest/js/dataTables/dataTables_bootstrap.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap-multiselect/bootstrap-multiselect.js"></script>
    <script type="text/javascript" src="/latest/js/bootstrap-multiselect/bootstrap-multiselect-collapsible-groups.js"></script>

    <cfoutput>
    <script type="text/javascript">
        var dts='#dts#';
		var hitemgroup='#hitemgroup#';
        var targetTitle='#targetTitle#';
        var targetTable='#targetTable#';
		var display='#displayEditDelete#';
		var menuID='#url.menuID#';
		
		var itemno='#words[120]#';
		var productcode='#words[121]#';
		var description='#words[65]#';
		var comment="comment";
		var brand='#words[122]#'
		var model="model";
		var category='#words[123]#';
		var group="group";
		var material="material";
		var rating="rating"
		var size="size";
		var cost="cost";
		var price="price";
		var unit="unit";
		var qtyBF="Qty B/F";
		var unitSP2="Unit Selling Price";
		var supplier="Supplier";
		var showOnHand="Show On Hand Qty";
		var discontinueItem="Discontinue Item";
		var itemPacking="Item Packing";
		var foreignCurrency="Foreign Currency";
		var foreignUnitPrice="Foreign Unit Price";
		var foreignSellPrice="Foreign Sell Price";
		<cfif lcase(husergrpid) eq "admin" or lcase(husergrpid) eq "super">
			var displaymultiselect="T"
		<cfelse>
			var displaymultiselect=""
		</cfif>
		
		var vis1 = "getdisplaysetup.item_itemno";
		
		var action='#words[10]#';
		var SEARCH='#words[11]#';
		
		<cfif IsDefined('url.message')>
			window.setTimeout(function() {
				$(".alert").fadeTo(500, 0).slideUp(500, function(){
					$(this).remove(); 
				});
			}, 3000);
		</cfif>
    </script>
    </cfoutput>
    <script type="text/javascript" src="/latest/js/maintenance/productProfile.js"></script>

</head>

<body>
<cfoutput>
<div class="container">
	<div class="page-header">
		<h2>
			#pageTitle#
			<span class="glyphicon glyphicon-question-sign btn-link"></span>
			<span class="glyphicon glyphicon-facetime-video btn-link"></span>
            
			<div class="pull-right">
            	<cfif getUserPin2.H10103_3a EQ 'T'>
                    <button type="button" class="btn btn-default" onclick="window.open('/latest/maintenance/product.cfm?action=create&menuID=#url.menuID#','_self');">
                        <span class="glyphicon glyphicon-plus"></span> #words[117]#
                    </button>
                </cfif>
                <button type="button" class="btn btn-default" onclick="window.open('/../../../default/maintenance/icitem_setting.cfm','_self');">
                	#words[118]#
                </button>
                <!---  
                <div class="btn-group">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                     <span class="glyphicon glyphicon-wrench"></span> 
                      More Settings
						<span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">
						<li><a href="customerItemProfile.cfm" id="customerItem" style="cursor:pointer;">Customer/Item Price</a></li>
                        <li><a href="supplierItemProfile.cfm" id="supplierItem" style="cursor:pointer;">Supplier/Item Price</a></li>
                        <li><a href="itemCustomerProfile.cfm" id="itemCustomer" style="cursor:pointer;">Item/Customer Price</a></li>
                    	<li><a href="itemSupplierProfile.cfm" id="itemSupplier" style="cursor:pointer;">Item/Supplier Price</a></li>
                    </ul>
				</div> 
				---> 
                <cfif getUserPin2.H10103_3d EQ 'T'>    
                    <button type="button" class="btn btn-default" onclick="window.open('../../../../default/maintenance/printbarcode_filter.cfm','_self');">
                        <span class="glyphicon glyphicon-print"></span> #words[119]#
                    </button>
                </cfif>
                <cfif getUserPin2.H10103_3c EQ 'T'>    
                    <button type="button" class="btn btn-default" onclick="window.open('../../../../default/maintenance/p_icitem.cfm','_blank');">
                        <span class="glyphicon glyphicon-print"></span> #words[3]#
                    </button>
				</cfif>
                
                <select id="example-multiple-selected" multiple="multiple" <cfif lcase(husergrpid) eq "admin" or lcase(husergrpid) eq "super"><cfelse> style="display:none"</cfif>>
                	<option id="0" name="0" value="0" <cfif getdisplaysetup.item_itemno eq 'Y'>selected</cfif>>Item No</option>
                	<option id="1" name="1" value="1" <cfif getdisplaysetup.item_aitemno eq 'Y'>selected</cfif>>Product Code</option>
                    <option id="2" name="2" value="2" <cfif getdisplaysetup.item_desp eq 'Y'>selected</cfif>>Description</option>
                	<option id="3" name="3" value="3" <cfif getdisplaysetup.item_comment eq 'Y'>selected</cfif>>Comment</option>
                    <option id="4" name="4" value="4" <cfif getdisplaysetup.item_brand eq 'Y'>selected</cfif>>Brand</option>
                    <option id="5" name="5" value="5" <cfif getdisplaysetup.item_model eq 'Y'>selected</cfif>>Model</option>
                    <option id="6" name="6" value="6" <cfif getdisplaysetup.item_category eq 'Y'>selected</cfif>>Category</option>
                    <option id="7" name="7" value="7" <cfif getdisplaysetup.item_group eq 'Y'>selected</cfif>>Group</option>
                    <option id="8" name="8" value="8" <cfif getdisplaysetup.item_material eq 'Y'>selected</cfif>>Material</option>
                    <option id="9" name="9" value="9"  <cfif getdisplaysetup.item_rating eq 'Y'>selected</cfif>>Rating</option>
                	<option id="10" name="10" value="10" <cfif getdisplaysetup.item_sizeid eq 'Y'>selected</cfif>>Size</option>
                    <cfif getpin2.h1360 eq "T">
                    <option id="11" name="11" value="11" <cfif getdisplaysetup.item_cost eq 'Y'>selected</cfif>>Cost</option>
                	<cfelse>
                    <option id="11" name="11" value="11">Cost</option>
                	
                    </cfif>
                    <cfif getpin2.h1360 eq "T">
                    <option id="12" name="12" value="12" <cfif getdisplaysetup.item_price eq 'Y'>selected</cfif>>Price</option>
                    <cfelse>
                    <option id="12" name="12" value="12">Price</option>
                    </cfif>
                    <option id="13" name="13" value="13" <cfif getdisplaysetup.item_unit eq 'Y'>selected</cfif>>Unit</option>
                    <option id="14" name="14" value="14" <cfif getdisplaysetup.item_qtybf eq 'Y'>selected</cfif>>Qty B/F</option>
                    <cfif getpin2.h1361 eq "T">
                    <option id="15" name="15" value="15" <cfif getdisplaysetup.item_price2 eq 'Y'>selected</cfif>>Unit Selling Price 2</option>
                    <cfelse>
                    <option id="15" name="15" value="15">Unit Selling Price 2</option>
                    
                    </cfif>
                    <option id="16" name="16" value="16" <cfif getdisplaysetup.item_supp eq 'Y'>selected</cfif>>Supplier</option>
                    <!--- <option value="17" selected>Show On Hand Qty</option> --->
                	<option id="17" name="17" value="17" <cfif getdisplaysetup.dis_item eq 'Y'>selected</cfif>>Discontinue Item</option>
                    <option id="18" name="18" value="18" <cfif getdisplaysetup.item_packing eq 'Y'>selected</cfif>>Item Packing</option>
                    <option id="19" name="19" value="19" <cfif getdisplaysetup.foreign_currency eq 'Y'>selected</cfif>>Foreign Currency</option>
                    <cfif getpin2.h1360 eq "T">
                    <option id="20" name="20" value="20" <cfif getdisplaysetup.foreign_unit eq 'Y'>selected</cfif>>Foreign Unit Price</option>
                    <cfelse>
                    <option id="20" name="20" value="20">Foreign Unit Price</option>
                    </cfif>
                    <cfif getpin2.h1361 eq "T">
                    <option id="21" name="21" value="21" <cfif getdisplaysetup.foreign_selling eq 'Y'>selected</cfif>>Foreign Selling Price</option>
    				<cfelse>
                    <option id="21" name="21" value="21">Foreign Selling Price</option>
    				</cfif>
                    <option id="22" name="22" value="22"  <cfif getdisplaysetup.item_showonhand eq 'Y'>selected</cfif>>On Hand</option>
                </select>   
                
			</div>
		</h2>
	</div>
	<div class="container">
    	<cfif IsDefined('url.message')>
        	<div class="alert alert-danger alert-dismissable">
              <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
              <strong>#url.itemno# #words[299]#</strong> 
            </div>
    	</cfif>
		<table class="table table-bordered table-hover" id="resultTable" style="table-layout:fixed">
			<thead>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>
</cfoutput>
</body>
</html>