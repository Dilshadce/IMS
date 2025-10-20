<html>
<head>
<title>Edit Item Opening Quantity/Cost</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getitem" datasource="#dts#">
	select itemno,desp,unit,qtybf,ucost,avcost,avcost2 
	from icitem 
	order by itemno;
</cfquery>
<cfquery name='getgsetup' datasource='#dts#'>
  Select * from gsetup
</cfquery>

<body>
<h4>
	<cfif getpin2.h1310 eq 'T'>
		<cfif lcase(hcomid) eq 'tcds_i'>
    	<a href="tcdsicitem2.cfm?type=Create">Creating a New Item</a> 
    <cfelse>
		<a href="icitem2.cfm?type=Create">Creating a New Item</a> 
    </cfif>
	</cfif>
	<cfif getpin2.h1320 eq 'T'>
		|| <a href="icitem.cfm?type=icitem">List all Item</a> 
	</cfif>
	<cfif getpin2.h1330 eq 'T'>
		|| <a href="s_icitem.cfm?type=icitem">Search For Item</a> 
	</cfif>
	<cfif getpin2.h1340 eq 'T'>
		|| <a href="p_icitem.cfm">Item Listing</a> 
	</cfif>
	|| <a href="icitem_setting.cfm">More Setting</a>
	<cfif getpin2.h1350 eq 'T'>|| <a href="printbarcode_filter.cfm">Print Barcode</a></cfif>
    <cfif getpin2.h1311 eq 'T' and getpin2.h13D0 eq 'T'>
		||<a href="edititemexpress.cfm">Edit Item Express</a> 
	</cfif>
    <cfif getpin2.h1311 eq 'T'>
    <cfquery name="checkitemnum" datasource="#dts#">
    select itemno from icitem
    </cfquery>
    <cfif checkitemnum.recordcount lt 400>
    ||<a href="edititemexpress2.cfm">Edit Item Express 2</a> 
    </cfif>
    </cfif>
</h4>
<h1 align="center">Express Edit Item</h1>
<!----- replace with CFGRID by edwin
<table width="75%" border="0" cellspacing="0" cellpadding="2" class="data" align="center">
	<tr>
    	<th>Item No.</th>
    	<th>Unit</th>
    	<th>Qty B/f</th>
    	<th>Fixed Cost</th>
    	<th>Mth.Ave.Cost</th>
    	<th>Mov.Ave.Cost</th>
    	<th>Action</th>
  	</tr>
  	<cfoutput query="getitem">
  		<tr>
    		<td>#itemno# - #desp#</td>
    		<td><div align="center">#unit#</div></td>
    		<td><div align="right">#qtybf#</div></td>
    		<td><div align="right">#numberformat(ucost,",_.____")#</div></td>
    		<td><div align="right">#numberformat(avcost,",_.____")#</div></td>
    		<td><div align="right">#numberformat(avcost2,",_.____")#</div></td>
    		<td align="center"><a href="fifoopq1.cfm?itemno=#urlencodedformat(itemno)#">Edit</a></td>
  		</tr>
  	</cfoutput>
	
</table>
------->
<table align="center">
<tr>
<th>Filter By</th>
<td>
<select name="filtercolumn" id="filtercolumn">
<cfif lcase(hcomid) eq 'tcds_i'>
<option value="sizeid"><cfoutput>#getgsetup.lsize#</cfoutput></option>
<option value="desp">Description</option>
<option value="itemno"><cfoutput>#getgsetup.litemno#</cfoutput></option>
<option value="aitemno">Product Code</option>
<option value="barcode">Barcode</option>
<option value="price2">Promotional</option>
<option value="supp">Supplier</option>
<option value="colorid">Label</option>
<option value="costcode">Promotion</option>

<cfelse>
<option value="itemno"><cfoutput>#getgsetup.litemno#</cfoutput></option>
<option value="desp">Description</option>
<option value="ucost">Cost</option>
</cfif>
</select>
</td>
<th>Filter Text</th>
<td>
<input type="text" name="filter" id="filter" value="" />
	<input type="button" name="filterbutton" value="Go" id="filterbutton"
							onclick="ColdFusion.Grid.refresh('usersgrid',false)">
</td>
<td width="50%"></td>
</tr>
<tr>
<td colspan="5">
<cfset group1="">
<cfset cate1="">
<cfset brand1="">
<cfset sizeid1="">
<cfset colorid1="">
<cfset supp1="">
<cfset rating1="">

<cfquery name="getgroup" datasource="#dts#">
select wos_group from icgroup
</cfquery>

<cfquery name="getcate" datasource="#dts#">
select cate from iccate
</cfquery>

<cfquery name="getbrand" datasource="#dts#">
select brand from brand
</cfquery>

<cfquery name="getsizeid" datasource="#dts#">
select sizeid from icsizeid
</cfquery>

<cfquery name="getcolorid" datasource="#dts#">
select colorid from iccolorid
</cfquery>

<cfquery name="getsupp" datasource="#dts#">
select custno,name from #target_apvend#
</cfquery>

<cfquery name="getrating" datasource="#dts#">
Select * from iccostcode order by costcode
</cfquery>

<cfloop query="getgroup">
<cfif group1 neq ''>
<cfset group1=group1&','&getgroup.wos_group>
<cfelse>
<cfset group1=getgroup.wos_group>
</cfif>
</cfloop>

<cfloop query="getcate">
<cfif cate1 neq ''>
<cfset cate1=cate1&','&getcate.cate>
<cfelse>
<cfset cate1=getcate.cate>
</cfif>
</cfloop>

<cfloop query="getbrand">
<cfif brand1 neq ''>
<cfset brand1=brand1&','&getbrand.brand>
<cfelse>
<cfset brand1=getbrand.brand>
</cfif>
</cfloop>

<cfloop query="getsizeid">
<cfif sizeid1 neq ''>
<cfset sizeid1=sizeid1&','&getsizeid.sizeid>
<cfelse>
<cfset sizeid1=getsizeid.sizeid>
</cfif>
</cfloop>

<cfloop query="getcolorid">
<cfif colorid1 neq ''>
<cfset colorid1=colorid1&','&getcolorid.colorid>
<cfelse>
<cfset colorid1=getcolorid.colorid>
</cfif>
</cfloop>

<cfloop query="getsupp">
<cfif supp1 neq ''>
<cfset supp1=supp1&','&getsupp.custno&'-'&getsupp.name>
<cfelse>
<cfset supp1=getsupp.custno&'-'&getsupp.name>
</cfif>
</cfloop>

<cfloop query="getrating">
<cfif rating1 neq ''>
<cfset rating1=rating1&','&getrating.costcode>
<cfelse>
<cfset rating1=getrating.costcode>
</cfif>
</cfloop>

	<cfform name="display" format="html" width="1000" height="800">
    
    <cfif lcase(hcomid) eq 'tcds_i'>
    	<cfgrid name="usersgrid" align="middle" format="html" 
			bind="cfc:edititemexpress.getitem({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{filtercolumn},{filter},'#dts#')"
			onchange="cfc:edititemexpress.editItemOP({cfgridaction}, {cfgridrow}, {cfgridchanged},'#dts#','#HUserID#')"
			selectonload="false" selectmode="edit" maxrows="20">
	        
			<cfgridcolumn name="itemno" header="#getgsetup.litemno#" width="80"  select="no">
            <cfgridcolumn name="aitemno" header="ProductCode" width="80">
            <cfgridcolumn name="barcode" header="Barcode" width="80">
            <cfoutput>
            <cfgridcolumn name="sizeid" header="Artist" width="100" values="#sizeid1#">
            </cfoutput>
		      <cfgridcolumn name="desp" header="Description" width="250">
            <!---<cfgridcolumn name="lastcost" header="Last Cost" width="100" select="no">--->
            <cfgridcolumn name="ucost" header="Average Cost" width="100">  
			<cfgridcolumn name="price" header="Selling Price" width="100">
		    <cfgridcolumn name="price2" header="Lowest Selling Price" width="100">
            <cfoutput>
            <cfgridcolumn name="costcode" header="Promotion" width="100" values="#rating1#">
			<cfgridcolumn name="supp" header="Supplier" width="300" values="#supp1#">
            <cfgridcolumn name="colorid" header="Label" width="100" values="#colorid1#">
            <cfgridcolumn name="category" header="Cateogory" width="100" values="#cate1#">
            <cfgridcolumn name="wos_group" header="Sub Category" width="100" values="#group1#">
            </cfoutput>
		
		</cfgrid>
    
    
    <cfelse>
		<cfgrid name="usersgrid" align="middle" format="html" 
			bind="cfc:edititemexpress.getitem({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{filtercolumn},{filter},'#dts#')"
			onchange="cfc:edititemexpress.editItemOP({cfgridaction}, {cfgridrow}, {cfgridchanged},'#dts#','#HUserID#')"
			selectonload="false" selectmode="edit" maxrows="20">
	        
			<cfgridcolumn name="itemno" header="#getgsetup.litemno#" width="80"  select="no">
		      <cfgridcolumn name="desp" header="Description" width="250">
              <cfif getpin2.h1360 eq 'T'>
			<cfgridcolumn name="ucost" header="COST" width="100">
            </cfif>
			<cfgridcolumn name="price" header="PRICE" width="100">
		      <cfgridcolumn name="price2" header="PRICE2" width="100">
			<cfgridcolumn name="price3" header="PRICE3" width="100">
            <cfgridcolumn name="price4" header="PRICE4" width="100">
            <cfoutput>
			<cfgridcolumn name="category" header="CATEGORY" width="100" values="#cate1#">
            <cfgridcolumn name="wos_group" header="GROUP" width="100" values="#group1#">
            <cfgridcolumn name="brand" header="Brand" width="100" values="#brand1#">
            </cfoutput>
            <cfgridcolumn name="custprice_rate" header="RATE" width="100" values="normal,offer,others">
            <cfgridcolumn name="remark1" header="Remark 1" width="100">
            <cfgridcolumn name="remark2" header="Remark 2" width="100">
            <cfgridcolumn name="remark3" header="Remark 3" width="100">
            <cfgridcolumn name="remark4" header="Remark 4" width="100">
		
		</cfgrid>
    </cfif>
	</cfform>
</td>
</tr>
</table>

</body>
</html>