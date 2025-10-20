<cfform name="createcomm" action="commprocess.cfm" method="post">
<table>
<tr>
<th colspan="3">
Create New Commission
</th>
</tr>
<tr>
<th>
Commision Name
</th>
<td>:</td>
<td>
<cfinput type="text" name="commname" id="commname" required="yes" message="Commission Name is Required">
</td>
</tr>
<tr>
<th>
Commision Description
</th>
<td>:</td>
<td>
<cfinput type="text" name="commdesp" id="commdesp">
</td>
</tr>
<cfquery name="getgroup" datasource="#dts#">
SELECT "" as wos_group, "Please Choose a Group" as groupdesp
union all
SELECT wos_group,concat(wos_group," - ",desp) as groupdesp FROM icgroup
</cfquery>
<tr>
<th>
Commission group
</th>
<td>:</td>
<td>
<cfselect name="group" id="group" query="getgroup" display="groupdesp" value="wos_group" />
</td>
</tr>
<cfquery name="getCate" datasource="#dts#">
SELECT "" as cate, "Please Choose a Category" as catedesp
union all
SELECT cate,concat(cate," - ",desp) as catedesp FROM iccate
</cfquery>
<tr>
<th>
Commission categories
</th>
<td>:</td>
<td>
<cfselect name="cate" id="cate" query="getCate" display="catedesp" value="cate" />
</td>
</tr>
<cfquery name="getBrand" datasource="#dts#">
SELECT "" as brand, "Please Choose a Brand" as branddesp
union all
SELECT brand,concat(brand," - ",desp) as branddesp FROM brand
</cfquery>
<tr>
<th>
Commission brand
</th>
<td>:</td>
<td>
<cfselect name="brand" id="brand" query="getBrand" display="branddesp" value="brand" />
</td>
</tr>
<tr>
<th>Range From</th>
<td>:</td>
<td><cfinput type="text" name="rangeFrom" id="rangeFrom" required="yes" validate="float" validateat="onsubmit" message="Range From is Required or is Invalid" /></td>
</tr>
<tr>
<th>Range To</th>
<td>:</td>
<td><cfinput type="text" name="rangeTo" id="rangeTo" required="yes" validate="float" validateat="onsubmit" message="Range to is Required or is Invalid" /></td>
</tr>
<tr>
<th>Commission Rate (%)</th>
<td>:</td>
<td><cfinput type="text" name="rate" id="rate" range="0,100" validate="float" validateat="onsubmit" message="Commission Rate is Required or is Invalid" required="yes" /></td>
</tr>
<tr>
<td colspan="3" align="center"><input type="submit" name="createcomm" id="createcomm" value="Create" /></td>
</tr>
</table>
</cfform>