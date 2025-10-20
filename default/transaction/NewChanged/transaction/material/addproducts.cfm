<cfquery name='getgsetup2' datasource='#dts#'>
  	select concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,Decl_Uprice as Decl_Uprice1, concat('.',repeat('_',DECL_DISCOUNT)) as DECL_DISCOUNT1, DECL_DISCOUNT from gsetup2
</cfquery>

<cfset stDecl_UPrice=getgsetup2.Decl_Uprice>
<cfset stDecl_Disc=getgsetup2.DECL_DISCOUNT1>

<html>
<body>
<cfset tran = url.tran>
<cfset custno = url.custno>
<cfset tranno = url.tranno>
<cfquery name='getproduct' datasource='#dts#'>
	select itemno, desp,despa from icitem where (nonstkitem<>'T' or nonstkitem is null) 
    		<cfif Hitemgroup neq ''>
            and wos_group='#Hitemgroup#'
            </cfif>
            <cfif lcase(hcomid) eq "swisspost_i"  or lcase(hcomid) eq "swisspostdemo_i">
             and wos_group = (SELECT coalesce(agent,'') from <cfif tran eq 'rc' or tran eq 'pr' or tran eq 'po'>#target_apvend#<cfelse>#target_arcust#</cfif> WHERE custno = "#custno#")
					</cfif>
            
                    
		order by <cfif lcase(hcomid) eq "glenn_i">desp<cfelse>itemno</cfif>
</cfquery>


<cfoutput>
<form action="" method="post" name="submit3" id="submit3">
<input type="hidden" name="tran" value="#url.tran#" >
</form>
<cfform name="pricetake" id="pricetake" action="" method="post">
<table>
<tr>
<th>Choose a Product</th>
<td colspan="3"><select name='expressservicelist' id="expressservicelist" onChange="document.getElementById('desp').value = this.options[this.selectedIndex].id;ajaxFunction(window.document.getElementById('itemDetail'),'/default/transaction/material/addItemAjax.cfm?itemno='+this.value+'&custno=#url.custno#&tran=#url.tran#');setTimeout('calamt();',500);" onBlur="calamt();">
        	<option value=''>Choose a Product</option>
          	<cfloop query='getproduct'>
				<cfif getproduct.desp eq ""><option value='Unnamed'>Unnamed - #desp#</option>
				<cfelse><option value='#URLEncodedFormat(itemno)#' id="#desp#">#itemno# - #desp# #despa#</option>
				</cfif>
          	</cfloop>
		</select>&nbsp;&nbsp;<br><input type="text" name="searchitemnew" id="searchitemnew" size="10" onKeyUp="searchSel('expressservicelist','searchitemnew')" onBlur="ajaxFunction(window.document.getElementById('itemDetail'),'/default/transaction/material/addItemAjax.cfm?itemno='+document.getElementById('expressservicelist').value+'&custno=#url.custno#&tran=#url.tran#');setTimeout('setdespprice();',500);setTimeout('calamt();',500);" >&nbsp;&nbsp;
		<input type="button" align="right" value="CLOSE" onClick="releaseDirtyFlag();javascript:ColdFusion.Window.hide('matproduct');"></td>
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
<cfset targettbl2 = 'arcust'>
<cfelse>
<cfset targettbl = target_apvend>
<cfset targettbl2 = 'apvend'>
</cfif>
<td>
<cfif getpin2.h2F00 neq 'T'>
<cfinput type="text" name="expprice" id="expprice" size="15" maxlength="15" value="0.00" readonly onKeyUp="calamt()" bind="cfc:itemprice.itemprice({expressservicelist},'#dts#','#custno#','#targettbl#','#targettbl2#')">
<cfelse>
<cfinput type="text" name="expprice" id="expprice" size="15" maxlength="15" value="0.00" onKeyUp="calamt()" bind="cfc:itemprice.itemprice({expressservicelist},'#dts#','#custno#','#targettbl#','#targettbl2#')">
</cfif>
</td>
</tr>
<tr>
<th>Amount</th>
<td><input type="text" name="expressamt" id="expressamt" size="10" value="0.00" readonly >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</td>
<th>
Location
</th>
<td>
<cfif Huserloc neq "All_loc">


<cfquery name="getlocation" datasource="#dts#">
SELECT location,concat(location," - ",desp) as desp FROM iclocation
where 0=0
	and location='#Huserloc#'
</cfquery>

<cfelse>
<cfquery name="getlocation" datasource="#dts#">
SELECT "" as location, "Choose A Location" as desp
UNION ALL
SELECT location,concat(location," - ",desp) as desp FROM iclocation
</cfquery>
</cfif>
<select name="location" id="location">
<cfloop query="getlocation">
<option value="#getlocation.location#">#getlocation.desp#</option>
</cfloop>
</select>
  <input type="button" value="Add" onClick="addmat('Products');"></td>
</tr>
</table>
</cfform>
</cfoutput>
<div id="ajaxFieldPro" name="ajaxFieldPro">
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
</div>
</body>
</html>
	