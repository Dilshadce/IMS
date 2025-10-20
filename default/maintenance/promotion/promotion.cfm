<cfquery name="getpromoid" datasource="#dts#">
SELECT * FROM PROMOTION where promoid = "#url.promoid#"
</cfquery>

<cfquery name="getcust" datasource="#dts#">
select custno,name from #target_arcust# order by custno
</cfquery>


<cfif getpromoid.recordcount eq 0>

<cfform action="promotionadd.cfm" method="post" name="form1">
<table width="100%">
<tr>
<th width="200">
Promotion Type
</th>
<td>
<select name="promoType" id="promoType" onChange="ajaxFunction(document.getElementById('ajaxField'),'/default/maintenance/promotion/promotionBody.cfm?type='+this.value);">
<option value="priceFixeddis">All items Discount</option>
<option value="priceVarprice">All items set Special price</option>
<option value="pricefixedprice">All items set Common price</option>
<option value="buyamtdis">Buy $ Give Discount</option>
<option value="buyamttotalprice">Buy $ Set Total Price</option>
<option value="buyamtsingleprice">Buy $ Set Single Price</option>
<option value="buyqtydis">Buy # Give Discount</option>
<option value="buyqtytotalprice">Buy # Set Total Price</option>
<option value="buyqtysingleprice">Buy # Set Single Price</option>
<option value="percent">Fix Discount Percent</option>
<option value="free">Buy # Free #</option>
</select>
</td>
</tr>
<tr>
<th>Description</th>
<td><input type="text" name="promodesp" id="promodesp" value="" maxlength="100" /></td>
</tr>
<tr>
  <th>Promotion Period From:</th>
  <td><cfinput type="text" name="proFrom" id="proFrom" value="DD/MM/YYYY" required="yes" message="Period from is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proFrom);"></td>
  <th>Promotion Period To:</th>
  <td><cfinput type="text" name="proTo" id="proTo" value="DD/MM/YYYY" required="yes" message="Period to is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proTo);"></td>
</tr>
<tr>
<th>Customer</th>
  <td colspan="3"><cfoutput><select name="custno">
  <option value="">Choose a customer if the promotion is for a specific customer</option>
  <cfloop query="getcust">
  <option value="#getcust.custno#">#getcust.custno# - #getcust.name#</option>
  </cfloop>
  </select>
  </cfoutput>
</td>
</tr>

<tr>
<th>Member Only</th>
  	<td colspan="3">
  	<input type="checkbox" name="memberonly" id="memberonly" value="Y" />
	</td>
</tr>


</table>
<hr />

<div id="ajaxField">
<table width="100%">
<input type="hidden" name="pricedistype" id="pricedistype" value="Fixeddis" >&nbsp;&nbsp;
<tr>
  <th>Amount</th>
  <td><cfinput type="text" name="priceamt" id="price amt" message="Price / Amount / Percentage is required" /></td>
</tr>




<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>
</div>
</cfform>

<cfelse>


<cfset type = getpromoid.type>
<cfform name="updatepromo" action="promotionupdate.cfm" method="post" >
<cfoutput>
<b>Type : #type#</b>
<br />
<cfif isdefined('url.success')>
Update Success!
</cfif>
<br />
<input type="hidden" name="promoid" id="promoid" value="#getpromoid.promoid#" />
<cfset protype = type>
<cfset buydistype = getpromoid.buydistype>
<cfset pricedistype = getpromoid.pricedistype>
<cfset description = getpromoid.description>
<cfset periodfrom = dateformat(getpromoid.periodfrom,'dd/mm/yyyy')>
<cfset periodto = dateformat(getpromoid.periodto,'dd/mm/yyyy')>
<cfset priceamt = getpromoid.priceamt>
<cfset memberonly = getpromoid.memberonly>

<cfif protype eq "price" and pricedistype eq "Fixeddis">
<table width="100%">
<tr>
<th>Description</th>
<td><input type="text" name="promodesp" id="promodesp" value="#description#" maxlength="100" /></td>
</tr>

<tr>
  <th>Promotion Period From:</th>
  <td><cfinput type="text" name="proFrom" id="proFrom" value="#periodfrom#" required="yes" message="Period from is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proFrom);"></td>
  <th>Promotion Period To:</th>
  <td><cfinput type="text" name="proTo" id="proTo" value="#periodto#" required="yes" message="Period to is invalid" validate="eurodate" validateat="onsubmit"/><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proTo);"></td>
</tr>
<tr>
<th>Customer</th>
  <td><cfoutput><select name="custno">
  <option value="">Choose a customer if the promotion is for a specific customer</option>
  <cfloop query="getcust">
  <option value="#getcust.custno#" <cfif getpromoid.customer eq getcust.custno>selected="selected" </cfif>>#getcust.custno# - #getcust.name#</option>
  </cfloop>
  </select>
  </cfoutput>
  </td>
</tr>
<tr>
<th>Member Only</th>
  	<td colspan="3">
  	<input type="checkbox" name="memberonly" id="memberonly" <cfif memberonly eq "Y">checked</cfif> value="Y" />
	</td>
</tr>
<input type="hidden" name="pricedistype" id="pricedistype" value="Fixeddis" >
<tr>
  <th>Price</th>
  <td><cfinput type="text" name="priceamt" id="priceamt" value="#priceamt#" required="yes" message="Price / Amount / Percentage is required" /></td>
</tr>

<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>

<cfelseif protype eq "price" and pricedistype eq "fixedprice">
<table width="100%">
<tr>
<th>Description</th>
<td><input type="text" name="promodesp" id="promodesp" value="#description#" maxlength="100" /></td>
</tr>

<tr>
  <th>Promotion Period From:</th>
  <td><cfinput type="text" name="proFrom" id="proFrom" value="#periodfrom#" required="yes" message="Period from is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proFrom);"></td>
  <th>Promotion Period To:</th>
  <td><cfinput type="text" name="proTo" id="proTo" value="#periodto#" required="yes" message="Period to is invalid" validate="eurodate" validateat="onsubmit"/><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proTo);"></td>
</tr>
<tr>
<th>Customer</th>
  <td><cfoutput><select name="custno">
  <option value="">Choose a customer if the promotion is for a specific customer</option>
  <cfloop query="getcust">
  <option value="#getcust.custno#" <cfif getpromoid.customer eq getcust.custno>selected="selected" </cfif>>#getcust.custno# - #getcust.name#</option>
  </cfloop>
  </select>
  </cfoutput>
  </td>
</tr>
<tr>
<th>Member Only</th>
  	<td colspan="3">
  	<input type="checkbox" name="memberonly" id="memberonly" <cfif memberonly eq "Y">checked</cfif> value="Y" />
	</td>
</tr>
<input type="hidden" name="pricedistype" id="pricedistype" value="fixedprice" >
<tr>
  <th>Price</th>
  <td><cfinput type="text" name="priceamt" id="priceamt" value="#priceamt#" required="yes" message="Price / Amount / Percentage is required" /></td>
</tr>

<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>

<cfelseif protype eq "price" and pricedistype eq "Varprice">
<table width="100%">
<tr>
<th>Description</th>
<td><input type="text" name="promodesp" id="promodesp" value="#description#" maxlength="100" /></td>
</tr>

<tr>
  <th>Promotion Period From:</th>
  <td><cfinput type="text" name="proFrom" id="proFrom" value="#periodfrom#" required="yes" message="Period from is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proFrom);"></td>
  <th>Promotion Period To:</th>
  <td><cfinput type="text" name="proTo" id="proTo" value="#periodto#" required="yes" message="Period to is invalid" validate="eurodate" validateat="onsubmit"/><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proTo);"></td>
</tr>
<tr>
<th>Customer</th>
  <td><cfoutput><select name="custno">
  <option value="">Choose a customer if the promotion is for a specific customer</option>
  <cfloop query="getcust">
  <option value="#getcust.custno#" <cfif getpromoid.customer eq getcust.custno>selected="selected" </cfif>>#getcust.custno# - #getcust.name#</option>
  </cfloop>
  </select>
  </cfoutput>
  </td>
</tr>
<tr>
<th>Member Only</th>
  	<td colspan="3">
  	<input type="checkbox" name="memberonly" id="memberonly" <cfif memberonly eq "Y">checked</cfif> value="Y" />
	</td>
</tr>
<input type="hidden" name="pricedistype" id="pricedistype" value="Varprice" >
<tr>
  <th></th>
  <td><cfinput type="hidden" name="priceamt" id="priceamt" value="#priceamt#" required="yes" message="Price / Amount / Percentage is required" /></td>
</tr>

<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>

<cfelseif protype eq "buy" and buydistype eq "totalamt" and pricedistype eq "Fixeddis">
<table width="100%">
<tr>
<th>Description</th>
<td><input type="text" name="promodesp" id="promodesp" value="#description#" maxlength="100" /></td>
</tr>
<tr>
  <th>Promotion Period From:</th>
  <td><cfinput type="text" name="proFrom" id="proFrom" value="#periodfrom#" required="yes" message="Period from is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proFrom);"></td>
  <th>Promotion Period To:</th>
  <td><cfinput type="text" name="proTo" id="proTo" value="#periodto#" required="yes" message="Period to is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proTo);"></td>
</tr>
<tr>
  <th>Customer</th>
  <td><cfoutput><select name="custno">
  <option value="">Choose a customer if the promotion is for a specific customer</option>
  <cfloop query="getcust">
  <option value="#getcust.custno#" <cfif getpromoid.customer eq getcust.custno>selected="selected" </cfif>>#getcust.custno# - #getcust.name#</option>
  </cfloop>
  </select>
  </cfoutput>
  </td>
</tr>
<tr>
<th>Member Only</th>
  	<td colspan="3">
  	<input type="checkbox" name="memberonly" id="memberonly" <cfif memberonly eq "Y">checked</cfif> value="Y" />
	</td>
</tr>

<input type="hidden" name="buydistype" id="buydistype" value="totalamt" >
<input type="hidden" name="pricedistype" id="pricedistype" value="Fixeddis">

<tr>
  <th>When Item Total Above:</th>
  <td><input type="text" name="rangefrom" id="rangefrom" value="#getpromoid.rangefrom#" /></td>
  <input type="hidden" name="rangeto" id="rangeto" value="9999999" /></tr>

<tr>
  <th>Discount By</th>
  <td>
  <select name="discby" id="discby">
  <option value="price" <cfif getpromoid.discby eq "price">selected="selected" </cfif>>Price</option>
  <option value="percent" <cfif getpromoid.discby eq "percent">selected="selected" </cfif>>Percent</option>
  </select></td>
  
</tr>

<tr>
  <th>Price / Percent</th>
  <td>
  <cfinput type="text" name="priceamt" id="price amt" value="#priceamt#"  />
  </td>
  <td colspan="2">(eg: Put 1.00 for S$ 1.00 or 10 for 10% )</td>
</tr>

<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>

<cfelseif protype eq "buy" and buydistype eq "totalqty" and pricedistype eq "Fixeddis">
<table width="100%">
<tr>
<th>Description</th>
<td><input type="text" name="promodesp" id="promodesp" value="#description#" maxlength="100" /></td>
</tr>
<tr>
  <th>Promotion Period From:</th>
  <td><cfinput type="text" name="proFrom" id="proFrom" value="#periodfrom#" required="yes" message="Period from is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proFrom);"></td>
  <th>Promotion Period To:</th>
  <td><cfinput type="text" name="proTo" id="proTo" value="#periodto#" required="yes" message="Period to is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proTo);"></td>
</tr>
<tr>
  <th>Customer</th>
  <td><cfoutput><select name="custno">
  <option value="">Choose a customer if the promotion is for a specific customer</option>
  <cfloop query="getcust">
  <option value="#getcust.custno#" <cfif getpromoid.customer eq getcust.custno>selected="selected" </cfif>>#getcust.custno# - #getcust.name#</option>
  </cfloop>
  </select>
  </cfoutput>
  </td>
</tr>
<tr>
<th>Member Only</th>
  	<td colspan="3">
  	<input type="checkbox" name="memberonly" id="memberonly" <cfif memberonly eq "Y">checked</cfif> value="Y" />
	</td>
</tr>

<input type="hidden" name="buydistype" id="buydistype" value="totalqty" >
<input type="hidden" name="pricedistype" id="pricedistype" value="Fixeddis">

<tr>
  <th>When Item Total Above:</th>
  <td><input type="text" name="rangefrom" id="rangefrom" value="#getpromoid.rangefrom#" /></td>
  <input type="hidden" name="rangeto" id="rangeto" value="9999999" /></tr>

<tr>
  <th>Discount By</th>
  <td>
  <select name="discby" id="discby">
  <option value="price" <cfif getpromoid.discby eq "price">selected="selected" </cfif>>Price</option>
  <option value="percent" <cfif getpromoid.discby eq "percent">selected="selected" </cfif>>Percent</option>
  </select></td>
  
</tr>

<tr>
  <th>Price / Percent</th>
  <td>
  <cfinput type="text" name="priceamt" id="price amt" value="#priceamt#"  />
  </td>
  <td colspan="2">(eg: Put 1.00 for S$ 1.00 or 10 for 10% )</td>
</tr>

<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>

<cfelseif protype eq "buy" and buydistype eq "totalamt" and pricedistype eq "Varprice">
<table width="100%">
<tr>
<th>Description</th>
<td><input type="text" name="promodesp" id="promodesp" value="#description#" maxlength="100" /></td>
</tr>
<tr>
  <th>Promotion Period From:</th>
  <td><cfinput type="text" name="proFrom" id="proFrom" value="#periodfrom#" required="yes" message="Period from is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proFrom);"></td>
  <th>Promotion Period To:</th>
  <td><cfinput type="text" name="proTo" id="proTo" value="#periodto#" required="yes" message="Period to is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proTo);"></td>
</tr>
<tr>
  <th>Customer</th>
  <td><cfoutput><select name="custno">
  <option value="">Choose a customer if the promotion is for a specific customer</option>
  <cfloop query="getcust">
  <option value="#getcust.custno#" <cfif getpromoid.customer eq getcust.custno>selected="selected" </cfif>>#getcust.custno# - #getcust.name#</option>
  </cfloop>
  </select>
  </cfoutput>
  </td>
</tr>
<tr>
<th>Member Only</th>
  	<td colspan="3">
  	<input type="checkbox" name="memberonly" id="memberonly" <cfif memberonly eq "Y">checked</cfif> value="Y" />
	</td>
</tr>

<input type="hidden" name="buydistype" id="buydistype" value="totalamt" >
<input type="hidden" name="pricedistype" id="pricedistype" value="Varprice">
<input type="hidden" name="discby" id="discby" value="">

<tr>
  <th>When Item Total Above:</th>
  <td><input type="text" name="rangefrom" id="rangefrom" value="#getpromoid.rangefrom#" /></td>
  <input type="hidden" name="rangeto" id="rangeto" value="9999999" /></tr>

<tr>
  <th>Price / Percent</th>
  <td>
  <cfinput type="text" name="priceamt" id="price amt" value="#priceamt#"  />
  </td>
  <td colspan="2">(eg: Put 1.00 for S$ 1.00 or 10 for 10% )</td>
</tr>

<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>


<cfelseif protype eq "buy" and buydistype eq "totalqty" and pricedistype eq "Varprice">
<table width="100%">
<tr>
<th>Description</th>
<td><input type="text" name="promodesp" id="promodesp" value="#description#" maxlength="100" /></td>
</tr>
<tr>
  <th>Promotion Period From:</th>
  <td><cfinput type="text" name="proFrom" id="proFrom" value="#periodfrom#" required="yes" message="Period from is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proFrom);"></td>
  <th>Promotion Period To:</th>
  <td><cfinput type="text" name="proTo" id="proTo" value="#periodto#" required="yes" message="Period to is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proTo);"></td>
</tr>
<tr>
  <th>Customer</th>
  <td><cfoutput><select name="custno">
  <option value="">Choose a customer if the promotion is for a specific customer</option>
  <cfloop query="getcust">
  <option value="#getcust.custno#" <cfif getpromoid.customer eq getcust.custno>selected="selected" </cfif>>#getcust.custno# - #getcust.name#</option>
  </cfloop>
  </select>
  </cfoutput>
  </td>
</tr>
<tr>
<th>Member Only</th>
  	<td colspan="3">
  	<input type="checkbox" name="memberonly" id="memberonly" <cfif memberonly eq "Y">checked</cfif> value="Y" />
	</td>
</tr>

<input type="hidden" name="buydistype" id="buydistype" value="totalqty" >
<input type="hidden" name="pricedistype" id="pricedistype" value="Varprice">
<input type="hidden" name="discby" id="discby" value="">

<tr>
  <th>When Item Total Above:</th>
  <td><input type="text" name="rangefrom" id="rangefrom" value="#getpromoid.rangefrom#" /></td>
  <input type="hidden" name="rangeto" id="rangeto" value="9999999" /></tr>

<tr>
  <th>Price / Percent</th>
  <td>
  <cfinput type="text" name="priceamt" id="price amt" value="#priceamt#"  />
  </td>
  <td colspan="2">(eg: Put 1.00 for S$ 1.00 or 10 for 10% )</td>
</tr>

<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>

<cfelseif protype eq "buy" and buydistype eq "totalamt" and pricedistype eq "fixedprice">
<table width="100%">
<tr>
<th>Description</th>
<td><input type="text" name="promodesp" id="promodesp" value="#description#" maxlength="100" /></td>
</tr>
<tr>
  <th>Promotion Period From:</th>
  <td><cfinput type="text" name="proFrom" id="proFrom" value="#periodfrom#" required="yes" message="Period from is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proFrom);"></td>
  <th>Promotion Period To:</th>
  <td><cfinput type="text" name="proTo" id="proTo" value="#periodto#" required="yes" message="Period to is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proTo);"></td>
</tr>
<tr>
  <th>Customer</th>
  <td><cfoutput><select name="custno">
  <option value="">Choose a customer if the promotion is for a specific customer</option>
  <cfloop query="getcust">
  <option value="#getcust.custno#" <cfif getpromoid.customer eq getcust.custno>selected="selected" </cfif>>#getcust.custno# - #getcust.name#</option>
  </cfloop>
  </select>
  </cfoutput>
  </td>
</tr>
<tr>
<th>Member Only</th>
  	<td colspan="3">
  	<input type="checkbox" name="memberonly" id="memberonly" <cfif memberonly eq "Y">checked</cfif> value="Y" />
	</td>
</tr>

<input type="hidden" name="buydistype" id="buydistype" value="totalamt" >
<input type="hidden" name="pricedistype" id="pricedistype" value="fixedprice">
<input type="hidden" name="discby" id="discby" value="">

<tr>
  <th>When Item Total Above:</th>
  <td><input type="text" name="rangefrom" id="rangefrom" value="#getpromoid.rangefrom#" /></td>
  <input type="hidden" name="rangeto" id="rangeto" value="9999999" /></tr>

<tr>
  <th>Price / Percent</th>
  <td>
  <cfinput type="text" name="priceamt" id="price amt" value="#priceamt#"  />
  </td>
  <td colspan="2">(eg: Put 1.00 for S$ 1.00 or 10 for 10% )</td>
</tr>

<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>

<cfelseif protype eq "buy" and buydistype eq "totalqty" and pricedistype eq "fixedprice">
<table width="100%">
<tr>
<th>Description</th>
<td><input type="text" name="promodesp" id="promodesp" value="#description#" maxlength="100" /></td>
</tr>
<tr>
  <th>Promotion Period From:</th>
  <td><cfinput type="text" name="proFrom" id="proFrom" value="#periodfrom#" required="yes" message="Period from is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proFrom);"></td>
  <th>Promotion Period To:</th>
  <td><cfinput type="text" name="proTo" id="proTo" value="#periodto#" required="yes" message="Period to is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proTo);"></td>
</tr>
<tr>
  <th>Customer</th>
  <td><cfoutput><select name="custno">
  <option value="">Choose a customer if the promotion is for a specific customer</option>
  <cfloop query="getcust">
  <option value="#getcust.custno#" <cfif getpromoid.customer eq getcust.custno>selected="selected" </cfif>>#getcust.custno# - #getcust.name#</option>
  </cfloop>
  </select>
  </cfoutput>
  </td>
</tr>
<tr>
<th>Member Only</th>
  	<td colspan="3">
  	<input type="checkbox" name="memberonly" id="memberonly" <cfif memberonly eq "Y">checked</cfif> value="Y" />
	</td>
</tr>

<input type="hidden" name="buydistype" id="buydistype" value="totalqty" >
<input type="hidden" name="pricedistype" id="pricedistype" value="fixedprice">
<input type="hidden" name="discby" id="discby" value="">

<tr>
  <th>When Item Total Above:</th>
  <td><input type="text" name="rangefrom" id="rangefrom" value="#getpromoid.rangefrom#" /></td>
  <input type="hidden" name="rangeto" id="rangeto" value="9999999" /></tr>

<tr>
  <th>Price / Percent</th>
  <td>
  <cfinput type="text" name="priceamt" id="price amt" value="#priceamt#"  />
  </td>
  <td colspan="2">(eg: Put 1.00 for S$ 1.00 or 10 for 10% )</td>
</tr>

<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>



<cfelseif protype eq "percent">



<table width="100%">
<tr>
<th>Description</th>
<td><input type="text" name="promodesp" id="promodesp" value="#description#" maxlength="100" /></td>
</tr>
<tr>
  <th>Promotion Period From:</th>
  <td><cfinput type="text" name="proFrom" id="proFrom" value="#periodfrom#" required="yes" message="Period from is invalid" validate="eurodate" validateat="onsubmit"/><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proFrom);"></td>
  <th>Promotion Period To:</th>
  <td><cfinput type="text" name="proTo" id="proTo" value="#periodto#" required="yes" message="Period to is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proTo);"></td>
</tr>
<tr>
  <th>Customer</th>
  <td><cfoutput><select name="custno">
  <option value="">Choose a customer if the promotion is for a specific customer</option>
  <cfloop query="getcust">
  <option value="#getcust.custno#" <cfif getpromoid.customer eq getcust.custno>selected="selected" </cfif>>#getcust.custno# - #getcust.name#</option>
  </cfloop>
  </select>
  </cfoutput>
  </td>
</tr>
<tr>
<th>Discount Percentage</th>
<td>
<cfinput type="text" name="priceamt" id="priceamt" value="#priceamt#" required="yes" message="Price / Amount / Percentage is required" >
</td>

</tr>


<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>

<cfelseif protype eq "free">
<table>
<tr>
<th>Free item</th>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<th>Description</th>
<td><input type="text" name="promodesp" id="promodesp" value="#description#" maxlength="100" /></td>
</tr>
<tr>
  <th>Promotion Period From:</th>
  <td><cfinput type="text" name="proFrom" id="proFrom" value="#periodfrom#" required="yes" message="Period from is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proFrom);"></td>
  <th>Promotion Period To:</th>
  <td><cfinput type="text" name="proTo" id="proTo" value="#periodto#" required="yes" message="Period to is invalid" validate="eurodate" validateat="onsubmit" /><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(proTo);"></td>
</tr>
<tr>
<th>Customer</th>
  <td colspan="3"><cfoutput><select name="custno">
  <option value="">Choose a customer if the promotion is for a specific customer</option>
  <cfloop query="getcust">
  <option value="#getcust.custno#" <cfif getpromoid.customer eq getcust.custno>selected="selected" </cfif>>#getcust.custno# - #getcust.name#</option>
  </cfloop>
  </select>
  </cfoutput>
  </td>
</tr>
<tr>
<th>Member Only</th>
  	<td colspan="3">
  	<input type="checkbox" name="memberonly" id="memberonly" <cfif memberonly eq "Y">checked</cfif> value="Y" />
	</td>
</tr>

<tr>
  <th>Buy Over Quantity</th>
    <td><cfinput type="text" name="priceamt" id="priceamt" value="#priceamt#" required="yes" message="Price / Amount / Percentage / Quantity is required" /></td>
  <th>Free Quantity</th>
  <td><input type="text" name="rangefrom" id="rangefrom" value="#getpromoid.rangefrom#" /></td>
</tr>
<tr>
  <td colspan="100%" align="center"><input type="submit" name="submit" value="Save" /></td>
</tr>
</table>

</cfif>

</cfoutput>
</cfform>
</cfif>