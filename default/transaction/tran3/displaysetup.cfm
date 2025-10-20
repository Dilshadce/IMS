<html>
<head>
<title>Dealer Menu</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/collapse_expand_single_item.js"></script>
</head>

<body>

<script type="text/javascript">
	
	function default1()
	{
		document.getElementById('bill_refno').checked=true;
		document.getElementById('bill_refno2').checked=true;
		document.getElementById('bill_toinv').checked=false;
		document.getElementById('bill_custno').checked=true;
		document.getElementById('bill_name').checked=true;
		document.getElementById('bill_date').checked=true;
		document.getElementById('bill_period').checked=true;
		document.getElementById('bill_PO').checked=false;
		document.getElementById('bill_project').checked=false;
		document.getElementById('bill_job').checked=false;
		document.getElementById('bill_agent').checked=true;
		document.getElementById('bill_driver').checked=false;
		document.getElementById('bill_created').checked=false;
		document.getElementById('bill_user').checked=true;
		document.getElementById('bill_currcode').checked=true;
		document.getElementById('bill_term').checked=true;
		document.getElementById('bill_grand').checked=false;
		document.getElementById('bill_rem5').checked=false;
		document.getElementById('bill_rem6').checked=false;
		document.getElementById('bill_rem7').checked=false;
		document.getElementById('bill_rem8').checked=false;
		document.getElementById('bill_rem9').checked=false;
		document.getElementById('bill_rem10').checked=false;
		document.getElementById('bill_rem11').checked=false;
		document.getElementById('bill_b_attn').checked=false;
		document.getElementById('bill_d_attn').checked=false;
		
		document.getElementById('billbody_itemno').checked=true;
		document.getElementById('billbody_aitemno').checked=false;
		document.getElementById('billbody_desp').checked=true;
		document.getElementById('billbody_location').checked=false;
		document.getElementById('billbody_project').checked=false;
		document.getElementById('billbody_job').checked=false;
		document.getElementById('billbody_qty').checked=true;
		document.getElementById('billbody_unit').checked=false;
		document.getElementById('billbody_batch').checked=false;
		document.getElementById('billbody_price').checked=true;
		document.getElementById('billbody_currcode').checked=true;
		document.getElementById('billbody_taxamt').checked=true;
		document.getElementById('billbody_amt').checked=true;
		document.getElementById('billbody_taxcode').checked=true;
		document.getElementById('billbody_brem1').checked=false;
		document.getElementById('billbody_brem2').checked=false;
		document.getElementById('billbody_brem3').checked=false;
		document.getElementById('billbody_brem4').checked=false;
		
		document.getElementById('item_itemno').checked=true;
		document.getElementById('item_aitemno').checked=true;
		document.getElementById('item_desp').checked=true;
		document.getElementById('item_brand').checked=true;
		document.getElementById('item_model').checked=true;
		document.getElementById('item_category').checked=true;
		document.getElementById('item_group').checked=true;
		document.getElementById('item_material').checked=true;
		document.getElementById('item_rating').checked=true;
		document.getElementById('item_sizeid').checked=true;
		document.getElementById('item_cost').checked=true;
		document.getElementById('item_price').checked=true;
		document.getElementById('item_unit').checked=true;
		document.getElementById('item_qtybf').checked=true;
		document.getElementById('item_price2').checked=true;
		document.getElementById('item_supp').checked=true;
		document.getElementById('item_showonhand').checked=true;
		
		document.getElementById('cust_custno').checked=true;
		document.getElementById('cust_name').checked=true;
		document.getElementById('cust_add').checked=true;
		document.getElementById('cust_tel').checked=true;
		document.getElementById('cust_contact').checked=true;
		document.getElementById('cust_agent').checked=true;
		document.getElementById('cust_driver').checked=true;
		document.getElementById('cust_currcode').checked=true;
		document.getElementById('cust_attn').checked=false;
		document.getElementById('cust_fax').checked=false;
		document.getElementById('cust_term').checked=false;
		document.getElementById('cust_area').checked=false;
		document.getElementById('cust_business').checked=false;
		document.getElementById('cust_createdate').checked=false;
		
		document.getElementById('itemsearch_itemno').checked=true;
		document.getElementById('itemsearch_aitemno').checked=true;
		document.getElementById('itemsearch_desp').checked=true;
		document.getElementById('itemsearch_ucost').checked=true;
		document.getElementById('itemsearch_price').checked=true;
		document.getElementById('itemsearch_qty').checked=true;
		document.getElementById('report_aitemno').checked=false;
		
		document.getElementById('simple_itemno').checked=true;
		document.getElementById('simple_desp').checked=true;
		document.getElementById('simple_location').checked=true;
		document.getElementById('simple_qty').checked=true;
		document.getElementById('simple_freeqty').checked=true;
		document.getElementById('simple_packing').checked=true;
		document.getElementById('simple_price').checked=true;
		document.getElementById('simple_disc').checked=true;
		document.getElementById('simple_amt').checked=true;
		document.getElementById('update_location').checked=false;
		document.getElementById('update_unit').checked=false;
		document.getElementById('update_bodyremark1').checked=false;
		document.getElementById('update_bodyremark2').checked=false;
		document.getElementById('update_bodyremark3').checked=false;
		document.getElementById('update_bodyremark4').checked=false;
		
				
	}
</script>

<cfif isdefined('url.done')>

<cfquery datasource="#dts#" name="getdisplaysetuprecord">
		select * from displaysetup
</cfquery>

<cfif getdisplaysetuprecord.recordcount eq 0>
<cfquery datasource="#dts#" name="insertdisplaysetup">
	insert into displaysetup (companyid) values ('IMS')
    </cfquery>
</cfif>

<cfquery datasource="#dts#" name="SaveGeneralInfo">
		update displaysetup set companyid='IMS'
        
        <cfif isdefined("form.bill_refno")>
        	,bill_refno = 'Y'
        <cfelse>
         	,bill_refno = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_refno2")>
        	,bill_refno2 = 'Y'
        <cfelse>
         	,bill_refno2 = 'N'
		</cfif>
        <cfif isdefined("form.bill_toinv")>
        	,bill_toinv = 'Y'
        <cfelse>
         	,bill_toinv = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_custno")>
        	,bill_custno = 'Y'
        <cfelse>
         	,bill_custno = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_name")>
        	,bill_name = 'Y'
        <cfelse>
         	,bill_name = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_date")>
        	,bill_date = 'Y'
        <cfelse>
         	,bill_date = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_period")>
        	,bill_period = 'Y'
        <cfelse>
         	,bill_period = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_PO")>
        	,bill_PO = 'Y'
        <cfelse>
         	,bill_PO = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_project")>
        	,bill_project = 'Y'
        <cfelse>
         	,bill_project = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_job")>
        	,bill_job = 'Y'
        <cfelse>
         	,bill_job = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_agent")>
        	,bill_agent = 'Y'
        <cfelse>
         	,bill_agent = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_driver")>
        	,bill_driver = 'Y'
        <cfelse>
         	,bill_driver = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_created")>
        	,bill_created = 'Y'
        <cfelse>
         	,bill_created = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_user")>
        	,bill_user = 'Y'
        <cfelse>
         	,bill_user = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_currcode")>
        	,bill_currcode = 'Y'
        <cfelse>
         	,bill_currcode = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_term")>
        	,bill_term = 'Y'
        <cfelse>
         	,bill_term = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_grand")>
        	,bill_grand = 'Y'
        <cfelse>
         	,bill_grand = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_rem5")>
        	,bill_rem5 = 'Y'
        <cfelse>
         	,bill_rem5 = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_rem6")>
        	,bill_rem6 = 'Y'
        <cfelse>
         	,bill_rem6 = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_rem7")>
        	,bill_rem7 = 'Y'
        <cfelse>
         	,bill_rem7 = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_rem8")>
        	,bill_rem8 = 'Y'
        <cfelse>
         	,bill_rem8 = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_rem9")>
        	,bill_rem9 = 'Y'
        <cfelse>
         	,bill_rem9 = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_rem10")>
        	,bill_rem10 = 'Y'
        <cfelse>
         	,bill_rem10 = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_rem11")>
        	,bill_rem11 = 'Y'
        <cfelse>
         	,bill_rem11 = 'N'
		</cfif>
        
        <cfif isdefined("form.bill_b_attn")>
        	,bill_b_attn = 'Y'
        <cfelse>
         	,bill_b_attn = 'N'
		</cfif>
        <cfif isdefined("form.bill_d_attn")>
        	,bill_d_attn = 'Y'
        <cfelse>
         	,bill_d_attn = 'N'
		</cfif>
        
        <cfif isdefined("form.billbody_itemno")>
        	,billbody_itemno = 'Y'
        <cfelse>
         	,billbody_itemno = 'N'
		</cfif>
        
        <cfif isdefined("form.billbody_aitemno")>
        	,billbody_aitemno = 'Y'
        <cfelse>
         	,billbody_aitemno = 'N'
		</cfif>
        
        <cfif isdefined("form.billbody_desp")>
        	,billbody_desp = 'Y'
        <cfelse>
         	,billbody_desp = 'N'
		</cfif>
        
        <cfif isdefined("form.billbody_location")>
        	,billbody_location = 'Y'
        <cfelse>
         	,billbody_location = 'N'
		</cfif>
        
        <cfif isdefined("form.billbody_project")>
        	,billbody_project = 'Y'
        <cfelse>
         	,billbody_project = 'N'
		</cfif>
        <cfif isdefined("form.billbody_job")>
        	,billbody_job = 'Y'
        <cfelse>
         	,billbody_job = 'N'
		</cfif>
        
        <cfif isdefined("form.billbody_qty")>
        	,billbody_qty = 'Y'
        <cfelse>
         	,billbody_qty = 'N'
		</cfif>
        <cfif isdefined("form.billbody_unit")>
        	,billbody_unit = 'Y'
        <cfelse>
         	,billbody_unit = 'N'
		</cfif>
        <cfif isdefined("form.billbody_batch")>
        	,billbody_batch = 'Y'
        <cfelse>
         	,billbody_batch = 'N'
		</cfif>
        
        <cfif isdefined("form.billbody_price")>
        	,billbody_price = 'Y'
        <cfelse>
         	,billbody_price = 'N'
		</cfif>
        
        <cfif isdefined("form.billbody_currcode")>
        	,billbody_currcode = 'Y'
        <cfelse>
         	,billbody_currcode = 'N'
		</cfif>
        
        <cfif isdefined("form.billbody_taxamt")>
        	,billbody_taxamt = 'Y'
        <cfelse>
         	,billbody_taxamt = 'N'
		</cfif>
        
        <cfif isdefined("form.billbody_amt")>
        	,billbody_amt = 'Y'
        <cfelse>
         	,billbody_amt = 'N'
		</cfif>
        
        <cfif isdefined("form.billbody_taxcode")>
        	,billbody_taxcode = 'Y'
        <cfelse>
         	,billbody_taxcode = 'N'
		</cfif>
        
        <cfif isdefined("form.billbody_brem1")>
        	,billbody_brem1 = 'Y'
        <cfelse>
         	,billbody_brem1 = 'N'
		</cfif>
        
        <cfif isdefined("form.billbody_brem2")>
        	,billbody_brem2 = 'Y'
        <cfelse>
         	,billbody_brem2 = 'N'
		</cfif>
        
        <cfif isdefined("form.billbody_brem3")>
        	,billbody_brem3 = 'Y'
        <cfelse>
         	,billbody_brem3 = 'N'
		</cfif>
        
        <cfif isdefined("form.billbody_brem4")>
        	,billbody_brem4 = 'Y'
        <cfelse>
         	,billbody_brem4 = 'N'
		</cfif>
        
        <cfif isdefined("form.item_itemno")>
        	,item_itemno = 'Y'
        <cfelse>
         	,item_itemno = 'N'
		</cfif>
        
        
        
        <cfif isdefined("form.item_aitemno")>
        	,item_aitemno = 'Y'
        <cfelse>
         	,item_aitemno = 'N'
		</cfif>
        
        <cfif isdefined("form.item_desp")>
        	,item_desp = 'Y'
        <cfelse>
         	,item_desp = 'N'
		</cfif>
        
      
        
        <cfif isdefined("form.item_brand")>
        	,item_brand = 'Y'
        <cfelse>
         	,item_brand = 'N'
		</cfif>
        
      
        
        <cfif isdefined("form.item_model")>
        	,item_model = 'Y'
        <cfelse>
         	,item_model = 'N'
		</cfif>
        
      
        
        <cfif isdefined("form.item_category")>
        	,item_category = 'Y'
        <cfelse>
         	,item_category = 'N'
		</cfif>
        
       
        
        <cfif isdefined("form.item_group")>
        	,item_group = 'Y'
        <cfelse>
         	,item_group = 'N'
		</cfif>
        
       
        
        <cfif isdefined("form.item_material")>
        	,item_material = 'Y'
        <cfelse>
         	,item_material = 'N'
		</cfif>
        
      
        <cfif isdefined("form.item_rating")>
        	,item_rating = 'Y'
        <cfelse>
         	,item_rating = 'N'
		</cfif>
        
       
        <cfif isdefined("form.item_sizeid")>
        	,item_sizeid = 'Y'
        <cfelse>
         	,item_sizeid = 'N'
		</cfif>
        
       
        
        <cfif isdefined("form.item_cost")>
        	,item_cost = 'Y'
        <cfelse>
         	,item_cost = 'N'
		</cfif>
        
        <cfif isdefined("form.item_price")>
        	,item_price = 'Y'
        <cfelse>
         	,item_price = 'N'
		</cfif>
        
        <cfif isdefined("form.item_unit")>
        	,item_unit = 'Y'
        <cfelse>
         	,item_unit = 'N'
		</cfif>
        <cfif isdefined("form.item_qtybf")>
        	,item_qtybf = 'Y'
        <cfelse>
         	,item_qtybf = 'N'
		</cfif>
        <cfif isdefined("form.item_price2")>
        	,item_price2 = 'Y'
        <cfelse>
         	,item_price2 = 'N'
		</cfif>
        <cfif isdefined("form.item_supp")>
        	,item_supp = 'Y'
        <cfelse>
         	,item_supp = 'N'
		</cfif>
        <cfif isdefined("form.item_showonhand")>
        	,item_showonhand = 'Y'
        <cfelse>
         	,item_showonhand = 'N'
		</cfif>
        
        <cfif isdefined("form.cust_custno")>
        	,cust_custno = 'Y'
        <cfelse>
         	,cust_custno = 'N'
		</cfif>
        
        <cfif isdefined("form.cust_name")>
        	,cust_name = 'Y'
        <cfelse>
         	,cust_name = 'N'
		</cfif>
       
        
        <cfif isdefined("form.cust_add")>
        	,cust_add = 'Y'
        <cfelse>
         	,cust_add = 'N'
		</cfif>
        
       
        
        <cfif isdefined("form.cust_tel")>
        	,cust_tel = 'Y'
        <cfelse>
         	,cust_tel = 'N'
		</cfif>
        
        <cfif isdefined("form.cust_contact")>
        	,cust_contact = 'Y'
        <cfelse>
         	,cust_contact = 'N'
		</cfif>
        
        <cfif isdefined("form.cust_agent")>
        	,cust_agent = 'Y'
        <cfelse>
         	,cust_agent = 'N'
		</cfif>
        
        <cfif isdefined("form.cust_driver")>
        	,cust_driver = 'Y'
        <cfelse>
         	,cust_driver = 'N'
		</cfif>
        
        <cfif isdefined("form.cust_currcode")>
        	,cust_currcode = 'Y'
        <cfelse>
         	,cust_currcode = 'N'
		</cfif>
        
        <cfif isdefined("form.cust_attn")>
        	,cust_attn = 'Y'
        <cfelse>
         	,cust_attn = 'N'
		</cfif>
        
        <cfif isdefined("form.cust_fax")>
        	,cust_fax = 'Y'
        <cfelse>
         	,cust_fax = 'N'
		</cfif>
        
        <cfif isdefined("form.cust_term")>
        	,cust_term = 'Y'
        <cfelse>
         	,cust_term = 'N'
		</cfif>
        
        <cfif isdefined("form.cust_area")>
        	,cust_area = 'Y'
        <cfelse>
         	,cust_area = 'N'
		</cfif>
        
        <cfif isdefined("form.cust_business")>
        	,cust_business = 'Y'
        <cfelse>
         	,cust_business = 'N'
		</cfif>
        
        <cfif isdefined("form.cust_createdate")>
        	,cust_createdate = 'Y'
        <cfelse>
         	,cust_createdate = 'N'
		</cfif>
        
        
        <cfif isdefined("form.itemsearch_itemno")>
        	,itemsearch_itemno = 'Y'
        <cfelse>
         	,itemsearch_itemno = 'N'
		</cfif>
        
        <cfif isdefined("form.itemsearch_aitemno")>
        	,itemsearch_aitemno = 'Y'
        <cfelse>
         	,itemsearch_aitemno = 'N'
		</cfif>
        <cfif isdefined("form.itemsearch_desp")>
        	,itemsearch_desp = 'Y'
        <cfelse>
         	,itemsearch_desp = 'N'
		</cfif>
        <cfif isdefined("form.itemsearch_ucost")>
        	,itemsearch_ucost = 'Y'
        <cfelse>
         	,itemsearch_ucost = 'N'
		</cfif>
        <cfif isdefined("form.itemsearch_price")>
        	,itemsearch_price = 'Y'
        <cfelse>
         	,itemsearch_price = 'N'
		</cfif>
        <cfif isdefined("form.itemsearch_qty")>
        	,itemsearch_qty = 'Y'
        <cfelse>
         	,itemsearch_qty = 'N'
		</cfif>
        <cfif isdefined("form.report_aitemno")>
        	,report_aitemno = 'Y'
        <cfelse>
         	,report_aitemno = 'N'
		</cfif>
        <cfif isdefined("form.simple_itemno")>
        	,simple_itemno = 'Y'
        <cfelse>
         	,simple_itemno = 'N'
		</cfif>
        <cfif isdefined("form.simple_desp")>
        	,simple_desp = 'Y'
        <cfelse>
         	,simple_desp = 'N'
		</cfif>
        <cfif isdefined("form.simple_location")>
        	,simple_location = 'Y'
        <cfelse>
         	,simple_location = 'N'
		</cfif>
        <cfif isdefined("form.simple_qty")>
        	,simple_qty = 'Y'
        <cfelse>
         	,simple_qty = 'N'
		</cfif>
        <cfif isdefined("form.simple_freeqty")>
        	,simple_freeqty = 'Y'
        <cfelse>
         	,simple_freeqty = 'N'
		</cfif>
        <cfif isdefined("form.simple_packing")>
        	,simple_packing = 'Y'
        <cfelse>
         	,simple_packing = 'N'
		</cfif>
        <cfif isdefined("form.simple_price")>
        	,simple_price = 'Y'
        <cfelse>
         	,simple_price = 'N'
		</cfif>
        <cfif isdefined("form.simple_disc")>
        	,simple_disc = 'Y'
        <cfelse>
         	,simple_disc = 'N'
		</cfif>
        <cfif isdefined("form.simple_amt")>
        	,simple_amt = 'Y'
        <cfelse>
         	,simple_amt = 'N'
		</cfif>
        <cfif isdefined("form.update_location")>
        	,update_location = 'Y'
        <cfelse>
         	,update_location = 'N'
		</cfif>        
        <cfif isdefined("form.update_unit")>
        	,update_unit = 'Y'
        <cfelse>
         	,update_unit = 'N'
		</cfif>        
        <cfif isdefined("form.update_bodyremark1")>
        	,update_bodyremark1 = 'Y'
        <cfelse>
         	,update_bodyremark1 = 'N'
		</cfif>        
        <cfif isdefined("form.update_bodyremark2")>
        	,update_bodyremark2 = 'Y'
        <cfelse>
         	,update_bodyremark2 = 'N'
		</cfif>        
        <cfif isdefined("form.update_bodyremark3")>
        	,update_bodyremark3 = 'Y'
        <cfelse>
         	,update_bodyremark3 = 'N'
		</cfif>        
        <cfif isdefined("form.update_bodyremark4")>
        	,update_bodyremark4 = 'Y'
        <cfelse>
         	,update_bodyremark4 = 'N'
		</cfif>  
        
               
        
</cfquery>
</cfif>
<h4>
	<cfif getpin2.h5110 eq "T"><a href="comprofile.cfm">Company Profile</a> </cfif>
    <cfif getpin2.h5120 eq "T">|| <a href="lastusedno.cfm">Last Used No</a> </cfif>
    <cfif getpin2.h5130 eq "T">|| <a href="transaction.cfm">Transaction Setup</a> </cfif>
    <cfif getpin2.h5140 eq "T">|| <a href="Accountno.cfm">UBS Accounting Default Setup</a> </cfif> 
    <cfif getpin2.h5150 eq "T">|| <a href="userdefine.cfm">User Defined</a> </cfif>
    <cfif getpin2.h5160 eq "T">||<a href="dealer_menu/dealer_menu.cfm">Dealer Menu</a> </cfif> 
    <cfif getpin2.h5170 eq "T">||<a href="transaction_menu/transaction_menu.cfm">Transaction Menu</a> </cfif> 
    <cfif getpin2.h5180 eq "T">||<a href="userdefineformula.cfm">User Define - Formula</a></cfif>
    <cfif getpin2.h5130 eq "T">||Display Setup</cfif>
    <cfif getpin2.h5130 eq "T">||<a href="displaysetup2.cfm">Display Setup 2</a></cfif>
</h4>

<h1 align="center">General Setup - Display Setup</h1>

<cfquery name="getgsetup" datasource="#dts#">
	select 
	* 
	from gsetup;
</cfquery>

<cfquery name="getdisplaysetup" datasource="#dts#">
	select 
	* 
	from displaysetup;
</cfquery>

<!--- Modification On 11-01-2010, Remove Those Unuse Fields From This Form --->

<cfform name="displaysetup" action="displaysetup.cfm?done=1" method="post">

	<cfoutput>
	<table align="center" class="data" width="50%">
    <tr><th colspan="2"><div align="center">Bill Header</div></th></tr>
		<tr>
            <th>Ref No</th>
            <td><input name="bill_refno" type="checkbox" value="Y" <cfif getdisplaysetup.bill_refno eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Ref No 2</th>
            <td><input name="bill_refno2" type="checkbox" value="Y" <cfif getdisplaysetup.bill_refno2 eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>To Inv</th>
            <td><input name="bill_toinv" type="checkbox" value="Y" <cfif getdisplaysetup.bill_toinv eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Cust No</th>
            <td><input name="bill_custno" type="checkbox" value="Y" <cfif getdisplaysetup.bill_custno eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Description</th>
            <td><input name="bill_name" type="checkbox" value="Y" <cfif getdisplaysetup.bill_name eq 'Y'>checked</cfif>></td>
          </tr>
           <tr>
            <th>Date</th>
            <td><input name="bill_date" type="checkbox" value="Y" <cfif getdisplaysetup.bill_date eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Period</th>
            <td><input name="bill_period" type="checkbox" value="Y" <cfif getdisplaysetup.bill_period eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>PO</th>
            <td><input name="bill_PO" type="checkbox" value="Y" <cfif getdisplaysetup.bill_PO eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>#getgsetup.lproject#</th>
            <td><input name="bill_project" type="checkbox" value="Y" <cfif getdisplaysetup.bill_project eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>#getgsetup.ljob#</th>
            <td><input name="bill_job" type="checkbox" value="Y" <cfif getdisplaysetup.bill_job eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>#getgsetup.lagent#</th>
            <td><input name="bill_agent" type="checkbox" value="Y" <cfif getdisplaysetup.bill_agent eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>#getgsetup.ldriver#</th>
            <td><input name="bill_driver" type="checkbox" value="Y" <cfif getdisplaysetup.bill_driver eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Created By</th>
            <td><input name="bill_created" type="checkbox" value="Y" <cfif getdisplaysetup.bill_created eq 'Y'>checked</cfif>></td>
          </tr>
           <tr>
            <th>User</th>
            <td><input name="bill_user" type="checkbox" value="Y" <cfif getdisplaysetup.bill_user eq 'Y'>checked</cfif>></td>
          </tr>
           <tr>
            <th>Currency</th>
            <td><input name="bill_currcode" type="checkbox" value="Y" <cfif getdisplaysetup.bill_currcode eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Terms</th>
            <td><input name="bill_term" type="checkbox" value="Y" <cfif getdisplaysetup.bill_term eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Grand Amount</th>
            <td><input name="bill_grand" type="checkbox" value="Y" <cfif getdisplaysetup.bill_grand eq 'Y'>checked</cfif>></td>
          </tr>
           <tr>
            <th>Remark 5</th>
            <td><input name="bill_rem5" type="checkbox" value="Y" <cfif getdisplaysetup.bill_rem5 eq 'Y'>checked</cfif>></td>
          </tr>
           <tr>
            <th>Remark 6</th>
            <td><input name="bill_rem6" type="checkbox" value="Y" <cfif getdisplaysetup.bill_rem6 eq 'Y'>checked</cfif>></td>
          </tr>
           <tr>
            <th>Remark 7</th>
            <td><input name="bill_rem7" type="checkbox" value="Y" <cfif getdisplaysetup.bill_rem7 eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Remark 8</th>
            <td><input name="bill_rem8" type="checkbox" value="Y" <cfif getdisplaysetup.bill_rem8 eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Remark 9</th>
            <td><input name="bill_rem9" type="checkbox" value="Y" <cfif getdisplaysetup.bill_rem9 eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Remark 10</th>
            <td><input name="bill_rem10" type="checkbox" value="Y" <cfif getdisplaysetup.bill_rem10 eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Remark 11</th>
            <td><input name="bill_rem11" type="checkbox" value="Y" <cfif getdisplaysetup.bill_rem11 eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>B_Attn</th>
            <td><input name="bill_b_attn" type="checkbox" value="Y" <cfif getdisplaysetup.bill_b_attn eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>D_Attn</th>
            <td><input name="bill_D_attn" type="checkbox" value="Y" <cfif getdisplaysetup.bill_D_attn eq 'Y'>checked</cfif>></td>
          </tr>
		<tr><th colspan="2"><div align="center">Bill Body</div></th></tr>
		<tr>
            <th>Item No</th>
            <td><input name="billbody_itemno" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_itemno eq 'Y'>checked</cfif>></td>
          </tr>
        <tr>
            <th>Product Code</th>
            <td><input name="billbody_aitemno" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_aitemno eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Description</th>
            <td><input name="billbody_desp" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_desp eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Location</th>
            <td><input name="billbody_location" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_location eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Project</th>
            <td><input name="billbody_project" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_project eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Job</th>
            <td><input name="billbody_job" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_job eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Qty</th>
            <td><input name="billbody_qty" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_qty eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Unit</th>
            <td><input name="billbody_unit" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_unit eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Batch Code</th>
            <td><input name="billbody_batch" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_batch eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Price</th>
            <td><input name="billbody_price" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_price eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Curr Code</th>
            <td><input name="billbody_currcode" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_currcode eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Tax Amount</th>
            <td><input name="billbody_taxamt" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_taxamt eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Amount</th>
            <td><input name="billbody_amt" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_amt eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Tax Code</th>
            <td><input name="billbody_taxcode" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_taxcode eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Body Remark 1</th>
            <td><input name="billbody_brem1" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_brem1 eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Body Remark 2</th>
            <td><input name="billbody_brem2" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_brem2 eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Body Remark 3</th>
            <td><input name="billbody_brem3" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_brem3 eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Body Remark 4</th>
            <td><input name="billbody_brem4" type="checkbox" value="Y" <cfif getdisplaysetup.billbody_brem4 eq 'Y'>checked</cfif>></td>
          </tr>
          <tr><th colspan="2"><div align="center">Item Profile</div></th></tr>
		<tr>
            <th>Item No</th>
            <td><input name="item_itemno" type="checkbox" value="Y" <cfif getdisplaysetup.item_itemno eq 'Y'>checked</cfif>>
            </td>
            
          </tr>
          <tr>
            <th>Product Code</th>
            <td><input name="item_aitemno" type="checkbox" value="Y" <cfif getdisplaysetup.item_aitemno eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Description</th>
            <td><input name="item_desp" type="checkbox" value="Y" <cfif getdisplaysetup.item_desp eq 'Y'>checked</cfif>>
            </td>
          </tr>
          <tr>
            <th>Brand</th>
            <td><input name="item_brand" type="checkbox" value="Y" <cfif getdisplaysetup.item_brand eq 'Y'>checked</cfif>>
            </td>
          </tr>
          <tr>
            <th>#getgsetup.lmodel#</th>
            <td><input name="item_model" type="checkbox" value="Y" <cfif getdisplaysetup.item_model eq 'Y'>checked</cfif>>
            </td>
          </tr>
          <tr>
            <th>#getgsetup.lcategory#</th>
            <td><input name="item_category" type="checkbox" value="Y" <cfif getdisplaysetup.item_category eq 'Y'>checked</cfif>>
            </td>
          </tr>
          <tr>
            <th>#getgsetup.lgroup#</th>
            <td><input name="item_group" type="checkbox" value="Y" <cfif getdisplaysetup.item_group eq 'Y'>checked</cfif>>
            </td>
          </tr>
           
          <tr>
            <th>#getgsetup.lmaterial#</th>
            <td><input name="item_material" type="checkbox" value="Y" <cfif getdisplaysetup.item_material eq 'Y'>checked</cfif>>
            </td>
          </tr>
          <tr>
            <th>#getgsetup.lrating#</th>
            <td><input name="item_rating" type="checkbox" value="Y" <cfif getdisplaysetup.item_rating eq 'Y'>checked</cfif>>
            </td>
          </tr>
          <tr>
            <th>#getgsetup.lsize#</th>
            <td><input name="item_group" type="checkbox" value="Y" <cfif getdisplaysetup.item_sizeid eq 'Y'>checked</cfif>>
            </td>
          </tr>
          <tr>
            <th>Cost</th>
            <td><input name="item_cost" type="checkbox" value="Y" <cfif getdisplaysetup.item_cost eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Price</th>
            <td><input name="item_price" type="checkbox" value="Y" <cfif getdisplaysetup.item_price eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Unit</th>
            <td><input name="item_unit" type="checkbox" value="Y" <cfif getdisplaysetup.item_unit eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Qty B/F</th>
            <td><input name="item_qtybf" type="checkbox" value="Y" <cfif getdisplaysetup.item_qtybf eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Unit Selling Price 2</th>
            <td><input name="item_price2" type="checkbox" value="Y" <cfif getdisplaysetup.item_price2 eq 'Y'>checked</cfif>></td>
          </tr>
           <tr>
            <th>Supplier</th>
            <td><input name="item_supp" type="checkbox" value="Y" <cfif getdisplaysetup.item_supp eq 'Y'>checked</cfif>></td>
          </tr>
           <tr>
            <th>Show On Hand Qty</th>
            <td><input name="item_showonhand" type="checkbox" value="Y" <cfif getdisplaysetup.item_showonhand eq 'Y'>checked</cfif>></td>
          </tr>
           <tr><th colspan="2"><div align="center">Customer/Supplier Profile</div></th></tr>
		<tr>
            <th>Customer No</th>
            <td><input name="cust_custno" type="checkbox" value="Y" <cfif getdisplaysetup.cust_custno eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Customer Name</th>
            <td><input name="cust_name" type="checkbox" value="Y" <cfif getdisplaysetup.cust_name eq 'Y'>checked</cfif>>
            </td>
          </tr>
          <tr>
            <th>Address</th>
            <td><input name="cust_add" type="checkbox" value="Y" <cfif getdisplaysetup.cust_add eq 'Y'>checked</cfif>>
            </td>
          </tr>
          <tr>
            <th>Telephone</th>
            <td><input name="cust_tel" type="checkbox" value="Y" <cfif getdisplaysetup.cust_tel eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Contact</th>
            <td><input name="cust_contact" type="checkbox" value="Y" <cfif getdisplaysetup.cust_contact eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>#getgsetup.lagent#</th>
            <td><input name="cust_agent" type="checkbox" value="Y" <cfif getdisplaysetup.cust_agent eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>#getgsetup.ldriver#</th>
            <td><input name="cust_driver" type="checkbox" value="Y" <cfif getdisplaysetup.cust_driver eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Curr Code</th>
            <td><input name="cust_currcode" type="checkbox" value="Y" <cfif getdisplaysetup.cust_currcode eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Attention</th>
            <td><input name="cust_attn" type="checkbox" value="Y" <cfif getdisplaysetup.cust_attn eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Fax</th>
            <td><input name="cust_fax" type="checkbox" value="Y" <cfif getdisplaysetup.cust_fax eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Term</th>
            <td><input name="cust_term" type="checkbox" value="Y" <cfif getdisplaysetup.cust_term eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Area</th>
            <td><input name="cust_area" type="checkbox" value="Y" <cfif getdisplaysetup.cust_area eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Business</th>
            <td><input name="cust_business" type="checkbox" value="Y" <cfif getdisplaysetup.cust_business eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Created Date</th>
            <td><input name="cust_createdate" type="checkbox" value="Y" <cfif getdisplaysetup.cust_createdate eq 'Y'>checked</cfif>></td>
          </tr>
          
          
          
          
          <tr><th colspan="2"><div align="center">Item Search Profile</div></th></tr>
		<tr>
            <th>Item No</th>
            <td><input name="itemsearch_itemno" type="checkbox" value="Y" <cfif getdisplaysetup.itemsearch_itemno eq 'Y'>checked</cfif>></td>
          </tr>
         <tr>
            <th>Product Code</th>
            <td><input name="itemsearch_aitemno" type="checkbox" value="Y" <cfif getdisplaysetup.itemsearch_aitemno eq 'Y'>checked</cfif>></td>
          </tr>
         <tr>
            <th>Name</th>
            <td><input name="itemsearch_desp" type="checkbox" value="Y" <cfif getdisplaysetup.itemsearch_desp eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>UCOST</th>
            <td><input name="itemsearch_ucost" type="checkbox" value="Y" <cfif getdisplaysetup.itemsearch_ucost eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Price</th>
            <td><input name="itemsearch_price" type="checkbox" value="Y" <cfif getdisplaysetup.itemsearch_price eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Qty on Hand</th>
            <td><input name="itemsearch_qty" type="checkbox" value="Y" <cfif getdisplaysetup.itemsearch_qty eq 'Y'>checked</cfif>></td>
          </tr>
		 <tr><th colspan="2"><div align="center">Report Display</div></th></tr>
         <tr>
            <th>Product Code</th>
            <td><input name="report_aitemno" type="checkbox" value="Y" <cfif getdisplaysetup.report_aitemno eq 'Y'>checked</cfif>></td>
          </tr>
          <tr><th colspan="2"><div align="center">Simple Transaction Display</div></th></tr>
         <tr>
            <th>Item Code</th>
            <td><input name="simple_itemno" type="checkbox" value="Y" <cfif getdisplaysetup.simple_itemno eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Description</th>
            <td><input name="simple_desp" type="checkbox" value="Y" <cfif getdisplaysetup.simple_desp eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Location</th>
            <td><input name="simple_location" type="checkbox" value="Y" <cfif getdisplaysetup.simple_location eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Quantity</th>
            <td><input name="simple_qty" type="checkbox" value="Y" <cfif getdisplaysetup.simple_qty eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Free Quantity</th>
            <td><input name="simple_freeqty" type="checkbox" value="Y" <cfif getdisplaysetup.simple_freeqty eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Packing</th>
            <td><input name="simple_packing" type="checkbox" value="Y" <cfif getdisplaysetup.simple_packing eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Price</th>
            <td><input name="simple_price" type="checkbox" value="Y" <cfif getdisplaysetup.simple_price eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Discount</th>
            <td><input name="simple_disc" type="checkbox" value="Y" <cfif getdisplaysetup.simple_disc eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Amount</th>
            <td><input name="simple_amt" type="checkbox" value="Y" <cfif getdisplaysetup.simple_amt eq 'Y'>checked</cfif>></td>
          </tr>
		<tr>
        <tr><th colspan="2"><div align="center">Update View</div></th></tr>
		<tr>
            <th>Location</th>
            <td><input name="update_location" type="checkbox" value="Y" <cfif getdisplaysetup.update_location eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Unit</th>
            <td><input name="update_unit" type="checkbox" value="Y" <cfif getdisplaysetup.update_unit eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Body Remark 1</th>
            <td><input name="update_bodyremark1" type="checkbox" value="Y" <cfif getdisplaysetup.update_bodyremark1 eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Body Remark 2</th>
            <td><input name="update_bodyremark2" type="checkbox" value="Y" <cfif getdisplaysetup.update_bodyremark2 eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Body Remark 3</th>
            <td><input name="update_bodyremark3" type="checkbox" value="Y" <cfif getdisplaysetup.update_bodyremark3 eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
            <th>Body Remark 4</th>
            <td><input name="update_bodyremark4" type="checkbox" value="Y" <cfif getdisplaysetup.update_bodyremark4 eq 'Y'>checked</cfif>></td>
          </tr>
          <tr>
          
	</table>
	<table align="center" class="data" width="50%">
		<tr>
			<td align="center">
				<input name="Save" type="submit" value="Save">
				<input name="Reset" type="reset" value="Reset">
                <input name="Default" type="button" value="Default" onClick="default1();">
			</td>
		</tr>
	</table>
	</cfoutput>
</cfform>

</body>
</html>