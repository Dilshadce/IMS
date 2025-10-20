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
<table>
<tr>
<th>Choose a Product</th>
<td colspan="3"><select name='expressservicelist' id="expressservicelist" onChange="document.getElementById('desp').value = this.options[this.selectedIndex].id">
        	<option value=''>Choose a Product</option>
          	<cfloop query='getproduct'>
				<cfif getproduct.desp eq ""><option value='Unnamed'>Unnamed - #desp#</option>
				<cfelse><option value='#URLEncodedFormat(itemno)#' id="#desp#">#itemno# - #desp#</option>
				</cfif>
          	</cfloop>
		</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" align="right" value="CLOSE" onClick="submitinvoice();">
</td>
</tr>
<tr>
<th>Description</th>
<td colspan="3"><input type="text" name="desp" id="desp" size="60" ></td>
</tr>
<tr>
<th>Quantity</th>
<td><input type="text" name="expqty" id="expqty" size="10" maxlength="10" value="0" onKeyUp="calamt()"></td>
<th>Price</th>
<td><input type="text" name="expprice" id="expprice" size="15" maxlength="15" value="0.00" onKeyUp="calamt()"></td>
</tr>
<tr>
<th>Amount</th>
<td colspan="3"><input type="text" name="expressamt" id="expressamt" size="10" value="0.00" readonly >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="button" value="Add" onClick="addItem('Products');"></td>
</tr>
</table>
</cfoutput>
<div id="ajaxField" name="ajaxField">
<cfquery name="selectproducts" datasource="#dts#">
SELECT itemno, desp, amt,qty,price FROM ictran where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#" and (linecode <> "SV" or linecode is null)
</cfquery>
<cfoutput>
<table width="550">
<tr>
<th width="100">Item Code</th><th width="200">Description</th><th width="50">Quantity</th><th width="100">Price</th><th width="100" align="right">Amount</th>
</tr>
<cfloop query="selectproducts">
<tr>
<td>#selectproducts.itemno#</td>
<td>#selectproducts.desp#</td>
<td>#numberformat(selectproducts.qty,'.__')#</td>
<td>#numberformat(selectproducts.price,'.__')#</td>
<td align="right">#numberformat(selectproducts.amt,'.__')#</td>
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
<cfinclude template="/default/transaction/tran_edit2.cfm">
</div>
</body>
</html>
	