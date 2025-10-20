<cfquery name='getgsetup2' datasource='#dts#'>
  	select concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,Decl_Uprice as Decl_Uprice1, concat('.',repeat('_',DECL_DISCOUNT)) as DECL_DISCOUNT1, DECL_DISCOUNT from gsetup2
</cfquery>

<cfset stDecl_UPrice=getgsetup2.Decl_Uprice>
<cfset stDecl_Disc=getgsetup2.DECL_DISCOUNT1>

<cfquery name="deleteictran" datasource="#dts#">
	delete from ictranmat
	where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#" and trancode="#url.trancode#"
</cfquery>

<cfquery name="selectproducts" datasource="#dts#">
SELECT * FROM ictranmat where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#" and (linecode <> "SV" or linecode is null)
</cfquery>
<cfoutput>
<table width="700">
<tr>
<th width="100">Item Code</th><th width="200">Description</th><th width="50">Quantity</th><th width="100">Price</th><th width="100" align="right">Amount</th><th width="100" align="right">Action</th>
</tr>
<cfloop query="selectproducts">
<tr>
<td>#selectproducts.itemno#</td>
<td>#selectproducts.desp#</td>
<td><cfif lcase(hcomid) eq "pengwang_i" or lcase(hcomid) eq "pingwang_i" or lcase(hcomid) eq "huanhong_i" or lcase(hcomid) eq "ptpw_i">#numberformat(selectproducts.qty_bil,'.____')#<cfelse>#selectproducts.qty_bil#</cfif></td>
<td>#numberformat(selectproducts.price_bil,stDecl_UPrice)#</td>
<td align="right"><cfif lcase(hcomid) eq "pengwang_i" or lcase(hcomid) eq "pingwang_i" or lcase(hcomid) eq "huanhong_i" or lcase(hcomid) eq "ptpw_i">#numberformat(selectproducts.amt_bil,'.____')#<cfelse>#numberformat(selectproducts.amt_bil,'.__')#</cfif></td>
<td align="right"><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="ajaxFunction(document.getElementById('ajaxFieldPro'),'/default/transaction/material/deleteproductsAjax.cfm?trancode=#selectproducts.trancode#&tran=#tran#&tranno=#tranno#&custno=#custno#');">Delete</a></td>
</tr>
</cfloop>
</table>
</cfoutput>
