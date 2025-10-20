<cfquery name="updateDisplaySetup" datasource="#dts#">
	UPDATE displaysetup
    SET 
    <cfif form.type EQ "custSuppProfile">
    	<cfif form.optionVal EQ "0">
    		cust_custno	
    	<cfelseif form.optionVal EQ "1">
        	cust_name
        <cfelseif form.optionVal EQ "2">
        	cust_add
        <cfelseif form.optionVal EQ "3">
        	cust_tel
        <cfelseif form.optionVal EQ "4">
        	cust_contact
        <cfelseif form.optionVal EQ "5">
        	cust_agent
        <cfelseif form.optionVal EQ "6">
        	cust_driver
        <cfelseif form.optionVal EQ "7">
        	cust_currcode
        <cfelseif form.optionVal EQ "8">
        	cust_attn
        <cfelseif form.optionVal EQ "9">
        	cust_fax
        <cfelseif form.optionVal EQ "10">
        	cust_term
        <cfelseif form.optionVal EQ "11">
        	cust_area
        <cfelseif form.optionVal EQ "12">
        	cust_business
        <cfelseif form.optionVal EQ "13">
        	cust_createdate
        </cfif>
    <cfelseif form.type EQ "productProfile">
   		<cfif form.optionVal EQ "0">
    		item_itemno	
    	<cfelseif form.optionVal EQ "1">
        	item_aitemno
        <cfelseif form.optionVal EQ "2">
        	item_desp
        <cfelseif form.optionVal EQ "3">
        	item_comment
        <cfelseif form.optionVal EQ "4">
        	item_brand
        <cfelseif form.optionVal EQ "5">
        	item_model
        <cfelseif form.optionVal EQ "6">
        	item_category
        <cfelseif form.optionVal EQ "7">
        	item_group
        <cfelseif form.optionVal EQ "8">
        	item_material
        <cfelseif form.optionVal EQ "9">
        	item_rating
        <cfelseif form.optionVal EQ "10">
        	item_sizeid
        <cfelseif form.optionVal EQ "11">
        	item_cost
        <cfelseif form.optionVal EQ "12">
        	item_price
        <cfelseif form.optionVal EQ "13">
        	item_unit
        <cfelseif form.optionVal EQ "14">
        	item_qtybf
        <cfelseif form.optionVal EQ "15">
        	item_price2
        <cfelseif form.optionVal EQ "16">
        	item_supp
        <cfelseif form.optionVal EQ "17">
        	dis_item
        <cfelseif form.optionVal EQ "18">
        	item_packing
        <cfelseif form.optionVal EQ "19">
        	foreign_currency
        <cfelseif form.optionVal EQ "20">
        	foreign_unit
        <cfelseif form.optionVal EQ "21">
        	foreign_selling
        <cfelseif form.optionVal EQ "22">
        	item_showonhand
        </cfif>
        
        
    </cfif>
        
	<cfif checked EQ TRUE>
        = "Y"
    <cfelse>
        = "N"
    </cfif>
</cfquery>