<html>
<head>
<title>Edit Item Price</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfinclude template="../../CFC/convert_single_double_quote_script.cfm">
</head>

<body>
<cfquery name='getgsetup2' datasource='#dts#'>
  Select * from gsetup2
</cfquery>
<cfquery name='getgsetup' datasource='#dts#'>
  Select * from gsetup
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_Uprice>
<cfset stDecl_UPrice = '.'>

<cfloop index='LoopCount' from='1' to='#iDecl_UPrice#'>
  <cfset stDecl_UPrice = stDecl_UPrice & '_'>
</cfloop>

<h4>
	<cfif getpin2.h1310 eq 'T'>
		<a href="icitem2.cfm?type=Create">Creating a New Item</a> 
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
<h1 align="center">Express Edit Item 2</h1>
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
<cfform name="edititemexpress2" action="edititemexpress2process.cfm" method="post">
<table align="center" class="data" width="100%" border="0" cellspacing="0">
<tr>
		<th><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfoutput>#getgsetup.litemno#</cfoutput></font></div></th>
		<th><div align="left"><font size="2" face="Times New Roman,Times,serif">ITEM DESCRIPTION</font></div></th>
		<th><div align="right"><font size="2" face="Times New Roman,Times,serif">Unit Cost</font></div></th>
		<th><div align="right"><font size="2" face="Times New Roman,Times,serif"><cfif lcase(hcomid) eq "hairo_i" or hcomid eq "freshways_i">Fixed<cfelse>Price</cfif></font></div></th>
		<th><div align="right"><font size="2" face="Times New Roman,Times,serif"><cfif lcase(hcomid) eq "hairo_i" or hcomid eq "freshways_i">Best<cfelse>Price 2</cfif></font></div></th>
		<th><div align="right"><font size="2" face="Times New Roman,Times,serif"><cfif lcase(hcomid) eq "hairo_i" or hcomid eq "freshways_i">Good<cfelse>Price 3</cfif></font></div></th>
        <th><div align="right"><font size="2" face="Times New Roman,Times,serif"><cfif lcase(hcomid) eq "hairo_i" or hcomid eq "freshways_i">Promo<cfelse>Price 4</cfif></font></div></th>
	</tr>
    <cfquery name="getiteminfo" datasource="#dts#">
			select itemno,desp,ucost,price,price2,price3,price4,category,wos_group 
			from icitem 
</cfquery>
<cfoutput>
<input type="hidden" name="totalitem" value="#getiteminfo.recordcount#">
<cfloop query="getiteminfo">
<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td nowrap>
					<input type="hidden" id="itemno#getiteminfo.currentrow#" name="itemno#getiteminfo.currentrow#" value="#convertquote(getiteminfo.itemno)#">
					<div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.itemno#</font></div>
				</td>
                <td>
                <div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.desp#</font></div>
                </td>
                <td nowrap>
					<div align="right"><cfinput type="text" id="ucost#getiteminfo.currentrow#" name="ucost#getiteminfo.currentrow#" value="#NumberFormat(getiteminfo.ucost,stDecl_UPrice)#" size="10" message="Please Enter A Correct Unit Cost !" required="no" validate="float"></div>
				</td>
                <td nowrap>
					<div align="right"><cfinput type="text" id="price#getiteminfo.currentrow#" name="price#getiteminfo.currentrow#" value="#NumberFormat(getiteminfo.price,stDecl_UPrice)#" size="10" message="Please Enter A Correct Price 1 !" required="no" validate="float"></div>
				</td>
                <td nowrap>
					<div align="right"><cfinput type="text" id="pricea#getiteminfo.currentrow#" name="pricea#getiteminfo.currentrow#" value="#NumberFormat(getiteminfo.price2,stDecl_UPrice)#" size="10" message="Please Enter A Correct Price 2 !" required="no" validate="float"></div>
				</td>
                <td nowrap>
					<div align="right"><cfinput type="text" id="priceb#getiteminfo.currentrow#" name="priceb#getiteminfo.currentrow#" value="#NumberFormat(getiteminfo.price3,stDecl_UPrice)#" size="10" message="Please Enter A Correct Price 3 !" required="no" validate="float"></div>
				</td>
                <td nowrap>
					<div align="right"><cfinput type="text" id="pricec#getiteminfo.currentrow#" name="pricec#getiteminfo.currentrow#" value="#NumberFormat(getiteminfo.price4,stDecl_UPrice)#" size="10" message="Please Enter A Correct Price 4 !" required="no" validate="float"></div>
				</td>
</tr>
</cfloop>
<tr align="center">
			<td colspan="7">
				<input type="submit" name="Submit" value="Submit">
                <cfif lcase(HcomID) eq "hairo_i" or hcomid eq "freshways_i">
                <cfelse>
				<input type="reset" name="Reset" value="Reset">
                </cfif>
			</td>
		</tr>
</cfoutput>
</table>

	</cfform>
<script type="text/javascript">
document.getElementById('ucost1').focus();
</script>
</body>
</html>