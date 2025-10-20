<cfset protype = url.type>

<cfquery name="getcust" datasource="#dts#">
select custno,name from #target_arcust# order by custno
</cfquery>

<cfif protype eq "priceFixeddis">
<table width="100%">
<input type="hidden" name="pricedistype" id="pricedistype" value="Fixeddis" >&nbsp;&nbsp;
<tr>
  <th width="200">Discount Amount</th>
  <td><input type="text" name="priceamt" id="priceamt" /></td>
</tr>

<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>
<cfelseif protype eq "pricefixedprice">
<table width="100%">
<input type="hidden" name="pricedistype" id="pricedistype" value="fixedprice" >&nbsp;&nbsp;
<tr>
  <th width="200">Price</th>
  <td><input type="text" name="priceamt" id="priceamt" /></td>
</tr>

<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>
<cfelseif protype eq "priceVarprice">
<table width="100%">
<input type="hidden" name="pricedistype" id="pricedistype" value="Varprice" >&nbsp;&nbsp;

<input type="hidden" name="priceamt" id="priceamt" value="0" />

<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>



<cfelseif protype eq "buyamtdis">

<table width="100%">
<input type="hidden" name="buydistype" id="buydistype" value="totalamt" >
<input type="hidden" name="pricedistype" id="pricedistype" value="Fixeddis">
<tr>
  <th width="200">When Item Total Above:</th>
  <td><input type="text" name="rangefrom" id="rangefrom" /></td>
	<input type="hidden" name="rangeto" id="rangeto" value="9999999" />
</tr>
<tr>
  <th>Discount By</th>
  <td>
  <select name="discby" id="discby">
  <option value="price">Price</option>
  <option value="percent">Percent</option>
  </select></td>
</tr>
<tr>
  <th>Price / Percent</th>
  <td>
  <input type="text" name="priceamt" id="price amt" />(eg: Put 1.00 for S$ 1.00 or 10 for 10% )
  </td>
</tr>
<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>

<cfelseif protype eq "buyamttotalprice">

<table width="100%">
<input type="hidden" name="buydistype" id="buydistype" value="totalamt" >
<input type="hidden" name="pricedistype" id="pricedistype" value="fixedprice">
<input type="hidden" name="discby" id="discby" value="">

<tr>
  <th width="200">When Item Total Above:</th>
  <td><input type="text" name="rangefrom" id="rangefrom" /></td>
  <input type="hidden" name="rangeto" id="rangeto" value="9999999" />
</tr>
<tr>
  <th>Total Price</th>
  <td>
  <input type="text" name="priceamt" id="price amt" />
  </td>
  <td colspan="2"></td>
</tr>
<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>

<cfelseif protype eq "buyamtsingleprice">

<table width="100%">
<input type="hidden" name="buydistype" id="buydistype" value="totalamt" >
<input type="hidden" name="pricedistype" id="pricedistype" value="Varprice">
<input type="hidden" name="discby" id="discby" value="">

<tr>
  <th width="200">When Item Total Above:</th>
  <td><input type="text" name="rangefrom" id="rangefrom" /></td>
  <input type="hidden" name="rangeto" id="rangeto" value="9999999" />
</tr>
<tr>
  <th>Unit Price</th>
  <td>
  <input type="text" name="priceamt" id="price amt" />
  </td>
  <td colspan="2"></td>
</tr>
<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>

<cfelseif protype eq "buyqtydis">

<table width="100%">
<input type="hidden" name="buydistype" id="buydistype" value="totalqty" >
<input type="hidden" name="pricedistype" id="pricedistype" value="Fixeddis">

<tr>
  <th width="200">When Item Total Above:</th>
  <td><input type="text" name="rangefrom" id="rangefrom" /></td>
  <input type="hidden" name="rangeto" id="rangeto" value="9999999" />
</tr>
<tr>
  <th>Discount By</th>
  <td>
  <select name="discby" id="discby">
  <option value="amt">Amount</option>
  <option value="price">Price</option>
  <option value="percent">Percent</option>
  </select></td>
</tr>
<tr>
  <th>Price / Percent</th>
  <td>
  <input type="text" name="priceamt" id="price amt" />
  </td>
  <td colspan="2"></td>
</tr>
<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>

<cfelseif protype eq "buyqtytotalprice">

<table width="100%">
<input type="hidden" name="buydistype" id="buydistype" value="totalqty" >
<input type="hidden" name="pricedistype" id="pricedistype" value="fixedprice">
<input type="hidden" name="discby" id="discby" value="price">

<tr>
  <th width="200">When Item Total Above:</th>
  <td><input type="text" name="rangefrom" id="rangefrom" /></td>
  <input type="hidden" name="rangeto" id="rangeto" value="9999999" />
</tr>
<tr>
  <th>Total Price</th>
  <td>
  <input type="text" name="priceamt" id="price amt" />
  </td>
  <td colspan="2"></td>
</tr>
<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>
<cfelseif protype eq "buyqtysingleprice">

<table width="100%">
<input type="hidden" name="buydistype" id="buydistype" value="totalqty" >
<input type="hidden" name="pricedistype" id="pricedistype" value="Varprice">
<input type="hidden" name="discby" id="discby" value="price">

<tr>
  <th width="200">When Item Total Above:</th>
  <td><input type="text" name="rangefrom" id="rangefrom" /></td>
  <input type="hidden" name="rangeto" id="rangeto" value="9999999" />
</tr>
<tr>
  <th>Unit Price</th>
  <td>
  <input type="text" name="priceamt" id="price amt" />
  </td>
  <td colspan="2"></td>
</tr>
<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>

<cfelseif protype eq "percent">
<table width="100%">
<tr>
<th width="200">Discount Percentage</th>
<td>
<input type="text" name="priceamt" id="priceamt" value="" >
</td>
</tr>
<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>
<cfelseif protype eq "free">
<table width="100%">
<tr>
  <th width="200">Buy Over Quantity</th>
    <td><input type="text" name="priceamt" id="priceamt" value="" required="yes" message="Price / Amount / Percentage / Quantity is required" /></td>
  <th>Free Quantity</th>
  <td><input type="text" name="rangefrom" id="rangefrom" value="" /></td>
</tr>

<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>

</cfif>