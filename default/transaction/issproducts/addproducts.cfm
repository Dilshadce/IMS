<html>
<body>
<cfquery name='getproduct' datasource='#dts#'>
	select itemno, desp from icitem where (nonstkitem<>'T' or nonstkitem is null) 
		order by <cfif lcase(hcomid) eq "glenn_i">desp<cfelse>itemno</cfif>
</cfquery>
<cfset tran = url.tran>
<cfset custno = url.custno>
<cfset tranno = url.tranno>

<cfoutput>
<form action="" method="post" name="submit3" id="submit3">
<input type="hidden" name="tran" value="#url.tran#" >
</form>
<cfform name="pricetake" id="pricetake" action="" method="post">
<table>
<tr>
<th>Choose a Product</th>
<td colspan="3"><select name='expressservicelist' id="expressservicelist" onChange="document.getElementById('desp').value = this.options[this.selectedIndex].id;ajaxFunction(window.document.getElementById('itemDetail'),'/default/transaction/Products/addItemAjax.cfm?itemno='+this.value+'&custno=#url.custno#&tran=#url.tran#');">
        	<option value=''>Choose a Product</option>
          	<cfloop query='getproduct'>
				<cfif getproduct.desp eq ""><option value='Unnamed'>Unnamed - #desp#</option>
				<cfelse><option value='#URLEncodedFormat(itemno)#' id="#desp#">#itemno# - #desp#</option>
				</cfif>
          	</cfloop>
		</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" align="right" value="CLOSE" onClick="ColdFusion.Window.hide('expressproduct');submitinvoice();"></td>
        <td rowspan="4"><div id="itemDetail"></div></td>
</tr>
<tr>
<th>Description</th>
<td colspan="3"><input type="text" name="desp" id="desp" size="60" ></td>
</tr>
<tr>
<th>Quantity</th>
<td><input type="text" name="expqty" id="expqty" size="10" maxlength="10" value="0" onKeyUp="calamt()"></td>
<th>Price</th>
<cfif tran eq "INV" or tran eq "CS" or tran eq "SO" or tran eq "CN" or tran eq "DO" or tran eq "QUO" or tran eq "SAM">
<cfset targettbl = target_arcust>
<cfelse>
<cfset targettbl = target_apvend>
</cfif>
<td><cfinput type="text" name="expprice" id="expprice" size="15" maxlength="15" value="0.00" onKeyUp="calamt()" bind="cfc:itemprice.itemprice({expressservicelist},'#dts#','#custno#','#targettbl#','#tran#')"></td>
</tr>
<tr>
<th>Amount</th>
<td><input type="text" name="expressamt" id="expressamt" size="10" value="0.00" readonly >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</td>
<th>
Location
</th>
<td>
<cfquery name="getlocation" datasource="#dts#">
SELECT "" as location, "Choose A Location" as desp
UNION ALL
SELECT location,concat(location," - ",desp) as desp FROM iclocation
</cfquery>
<select name="location" id="location">
<cfloop query="getlocation">
<option value="#getlocation.location#">#getlocation.desp#</option>
</cfloop>
</select>
  <input type="button" value="Add" onClick="addItem('Products');"></td>
</tr>
</table>
</cfform>
</cfoutput>
<div id="ajaxFieldPro" name="ajaxFieldPro">
<cfquery name="selectproducts" datasource="#dts#">
SELECT itemno, desp, amt_bil,qty_bil,price_bil FROM ictran where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#" and (linecode <> "SV" or linecode is null)
</cfquery>
<cfoutput>
<table width="700">
<tr>
<th width="100">Item Code</th><th width="200">Description</th><th width="50">Quantity</th><th width="100">Price</th><th width="100" align="right">Amount</th>
</tr>
<cfloop query="selectproducts">
<tr>
<td>#selectproducts.itemno#</td>
<td>#selectproducts.desp#</td>
<td>#numberformat(selectproducts.qty_bil,'.__')#</td>
<td>#numberformat(selectproducts.price_bil,'.__')#</td>
<td align="right">#numberformat(selectproducts.amt_bil,'.__')#</td>
</tr>
</cfloop>
</table>
</cfoutput>
</div>
<div style="width:1px; height:1px; overflow:scroll">
<cfset url.tran = #tran#>
<cfset url.ttype = "Edit">
<cfset url.refno = #tranno#>
<cfset url.custno = #custno#>
<cfset url.first = 0>
<cfset url.jsoff = "true">
<cfinclude template="/default/transaction/iss2.cfm">
</div>
</body>
</html>