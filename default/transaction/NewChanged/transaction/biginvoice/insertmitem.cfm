<cfif isdefined('url.uuid')>
<cfoutput>
<cfquery name="inserttempcreatebiitem" datasource="#dts#">
            insert into tempcreatebiitem
            (
                type,
                refno,
                itemno,
                desp,
                desp2,
                qty,
                price,
                amount,
                uuid,
                orderno
                )
                values
                (
                'INV',
                '#listfirst(URLDECODE(url.invlist))#',
                'Salary', 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.desp)#">, 
                '', 
                '#val(url.qty)#',
                #Numberformat(val(url.price),'.__')#, 
                 #Numberformat(val(url.amount),'.__')#,
               '#url.uuid#',
               1
                )
</cfquery>
<cfquery name="getgross" datasource="#dts#">
SELECT  sum(round(coalesce(custtotalgross,0)+0.00001,2)) as totalamt FROM assignmentslip WHERE refno in (<cfqueryparam cfsqltype="cf_sql_varchar"  value="#URLDECODE(url.invlist)#" list="yes" separator=",">) and combine <> "Y" ORDER BY REFNO
</cfquery>

<cfquery name="getlist" datasource="#dts#">
SELECT * FROM tempcreatebiitem WHERE uuid = "#url.uuid#" ORDER BY id
</cfquery>
      
<table align="center" width="1000px">
<tr>
<th colspan="100%"><div align="left">Inserted Row</div></th>
</tr>
<tr>
<th><div align="left">Item Description</div></th>
<th><div align="left">Quantity</div></th>
<th><div align="right">Price</div></th>
<th><div align="right">Amount</div></th>
</tr>
<cfset totalamount = numberformat(val(getgross.totalamt),'.__') >
<cfloop query="getlist">
<tr>
<td>#getlist.desp#</td>
<td>#val(getlist.qty)#</td>
<td>#numberformat(val(getlist.price),'.__')#</td>
<td>#numberformat(val(getlist.amount),'.__')#</td>
</tr>
<cfset totalamount = totalamount - numberformat(val(getlist.amount),'.__')>
</cfloop>
<tr>
<th colspan="3">Balance</th>
<th><input type="text" name="balance" id="balance" value="#numberformat(totalamount,'.__')#" size="20" readonly="readonly" /></th>
</tr>
<tr>
<th><div align="left">Item Description</div></th>
<th><div align="left">Quantity</div></th>
<th><div align="right">Price</div></th>
<th><div align="right">Amount</div></th>
</tr>
<tr>
<td><input type="text" name="desp" id="desp" value="" size="70" maxlength="400"  /></td>
<td><input type="text" name="qty" id="qty" value="1" size="10" onkeyup="calamt()" /></td>
<td><input type="text" name="price" id="price" value="0.00" size="20" onkeyup="calamt()" /></td>
<td><input type="text" name="amount" id="amount" value="0.00" size="20" readonly="readonly" /></td>
</tr>
<tr>
<td colspan="100%"><div align="center"><cfif numberformat(totalamount,'.__') neq 0><input type="button" name="groupitem" id="groupitem" value="Insert Item" onClick="groupitemfunc();"><cfelse><input type="submit" name="sub_btn" id="sub_btn" value="Create Big Invoice"></cfif></div></td>
</tr>
</table>
</cfoutput>
</cfif>
