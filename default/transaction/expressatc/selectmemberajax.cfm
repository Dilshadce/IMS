<cfoutput>
<cfset custno=URLDECODE(url.custno)>
<cfquery name="getlist" datasource="#dts#">
SELECT * FROM #target_arcust#
WHERE 
custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.custno)#">
order by custno
</cfquery>


<cfform name="customerform" height="100%" width="100%" action="" target="new"  method="post">
<table width="60%" style=" font-size:10px">
<tr>
<th colspan="100%">Customer Information</th>

</tr>
<tr>
<th>Customer Name</th>
<td>:</td>
<td><input type="text" style="font-size:10px" name="b_name" id="b_name" value="#getlist.name#" maxlength="35" size="40"/></td>
<th>Recipient Name</th><td>:</td><td><input type="text" style="font-size:10px" name="d_name" id="d_name" value="#getlist.arrem4#" maxlength="35" size="40"></td>
</tr>
<tr>
<th></th>
<td></td>
<td><input type="text" name="b_name2" style="font-size:10px" id="b_name2" value="#getlist.name2#" maxlength="35" size="40"/></td>
<th></th><td></td><td><input type="text" name="d_name2" style="font-size:10px" id="d_name2" value="" maxlength="35" size="40"></td>
</tr>

<tr>
<th>Gender</th>
<td>:</td>
<td>#getlist.arrem1#</td>
<th>Phone 2</th>
<td>:</td>
<td>#getlist.phonea#</td>
</tr>
<!---
<tr>
<th>Contact</th>
<td>:</td>
<td>#getlist.contact#</td>
<th>Attention</th>
<td>:</td>
<td>#getlist.attn#</td>
</tr>--->

<tr>
<th>Fax</th>
<td>:</td>
<td>#getlist.fax#</td>
<th>Email</th>
<td>:</td>
<td>#getlist.e_mail#</td>
</tr>

<tr>
<th>Address 1</th>
<td>:</td>
<td>
<input type="text" name="b_add1" id="b_add1" style="font-size:10px" value="#getlist.add1#" maxlength="35" size="40"></td>
<th>Address 1</th><td>:</td><td><input type="text" style="font-size:10px" name="d_add1" id="d_add1" value="#getlist.daddr1#" maxlength="35" size="40"></td>
</tr>
<tr>
<th>Address 2 </th>
<td>:</td>
<td>
<input type="text" name="b_add2" style="font-size:10px" id="b_add2" value="#getlist.add2#" maxlength="35" size="40"></td>
<th>Address 2 </th><td>:</td><td><input type="text" style="font-size:10px" name="d_add2" id="d_add2" value="#getlist.daddr2#" maxlength="35" size="40"></td>
</tr>
<tr>
<th>Address 3</th>
<td>:</td>
<td>
<input type="text" style="font-size:10px" name="b_add3" id="b_add3" value="#getlist.add3#" maxlength="35" size="40"></td>
<th>Address 3</th><td>:</td><td><input type="text" style="font-size:10px" name="d_add3" id="d_add3" value="#getlist.daddr3#" maxlength="35" size="40"></td>
</tr>
<tr>
<th>Address 4</th>
<td>:</td>
<td>
<input type="text" style="font-size:10px" name="b_add4" id="b_add4" value="#getlist.add4#" maxlength="35" size="40"></td>
<th>Address 4</th><td>:</td><td><input type="text" style="font-size:10px" name="d_add4" id="d_add4" value="#getlist.daddr4#" maxlength="35" size="40"></td>
</tr>

<tr>
<th>Address 5</th>
<td>:</td>
<td>
<input type="text" style="font-size:10px" name="b_add5" id="b_add5" value="#getlist.add5#" maxlength="35" size="40"></td>
<th>Address 5</th><td>:</td><td><input type="text" style="font-size:10px" name="d_add5" id="d_add5" value="#getlist.daddr5#" maxlength="35" size="40"></td>
</tr>

<tr>
<th>Postal Code</th>
<td>:</td>
<td>
<input type="text" style="font-size:10px" name="b_postalcode" id="b_postalcode" value="#getlist.postalcode#" maxlength="35" size="40"></td>
<th>Postal Code</th><td>:</td><td><input type="text" style="font-size:10px" name="d_postalcode" id="d_postalcode" value="#getlist.d_postalcode#" maxlength="35" size="40"></td>
</tr>
<tr>
<th>Tel</th>
<td>:</td>
<td>
<input type="text" style="font-size:10px" name="b_phone" id="b_phone" value="#getlist.phone#" maxlength="35" size="40"></td>
<th>Tel</th><td>:</td><td><input type="text" style="font-size:10px" name="d_phone" id="d_phone" value="#getlist.dphone#" maxlength="35" size="40"><input type="hidden" name="d_fax" id="d_fax" value=""></td>
</tr>

<tr>
<th>Hp</th>
<td>:</td>
<td>
<input type="text" style="font-size:10px" name="b_phone2" id="b_phone2" value="#getlist.phonea#" maxlength="35" size="40"></td>
<th>Hp</th><td>:</td><td><input type="text" style="font-size:10px" name="d_phone2" id="d_phone2" value="#getlist.contact#" maxlength="35" size="40"></td>
</tr>

<tr>
<th>Attention</th>
<td>:</td>
<td>
<input type="text" style="font-size:10px" name="b_attn" id="b_attn" value="#getlist.attn#" maxlength="35" size="40"></td>
<th>Attention</th><td>:</td><td><input type="text" style="font-size:10px" name="d_attn" id="d_attn" value="#getlist.dattn#" maxlength="35" size="40"></td>
</tr>
<tr>

<td colspan="6"><input type="button" name="createsobtn" id="createsobtn" value="Create Job Order"  onClick="createjob('#URLEncodedFormat(custno)#');window.location.href='/default/transaction/expressatc/searchmember.cfm'"/>
&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" name="createsobtn" id="createsobtn" value="Create Job Order New"  onClick="createjob2('#URLEncodedFormat(custno)#');window.location.href='/default/transaction/expressatc/searchmember.cfm'"/>
</td>

</tr>

</table>
</cfform>
<br />

<h2>Customer Purchase History</h2>
<cfquery name="gettran" datasource="#dts#">
SELECT * FROM ictran
WHERE 
custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.custno)#"> and type='SO'
order by custno limit 10  
</cfquery>

<table width="100%">
<tr>
<td>Date</td>
<td>Invoice No</td>
<td>Item No</td>
<td>Description</td>
<td>Delivery Date</td>
<td></td>
<td>Qty</td>
<td align="right">Price</td>
<td align="right">Discount</td>
<td align="right">Amount</td>
</tr>

<cfloop query="gettran">
<tr>
<td>#dateformat(gettran.wos_date,'DD/MM/YYYY')#</td>
<td>#gettran.refno#</td>
<td>#gettran.itemno#</td>
<td>#gettran.desp#</td>
<td>#gettran.deliverydate#</td>
<td><a href="/default/transaction/tran_edit2.cfm?tran=#type#&ttype=Edit&refno=#refno#&custno=#URLEncodedFormat(custno)#&first=0"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a></td>
<td>#gettran.qty#</td>
<td align="right">#numberformat(gettran.price,',_.__')#</td>
<td align="right">#numberformat(gettran.disamt,',_.__')#</td>
<td align="right">#numberformat(gettran.amt,',_.__')#</td>
</tr>
</cfloop>


</table>

</cfoutput>