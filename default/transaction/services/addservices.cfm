<html>
<body onUnload="javascript:location.reload(true)">
<cfquery name='getservice' datasource='#dts#'>
	select servi, desp from icservi order by servi
</cfquery>

<cfset tran = url.tran>
<cfset custno = url.custno>
<cfset tranno = url.tranno>
<cfquery datasource='#dts#' name="getitem">
	select * from artran where refno='#tranno#' and type = "#tran#"
</cfquery>
<cfoutput>
<form action="" method="post" name="submit3" id="submit3">
<input type="hidden" name="tran" value="#url.tran#" >
</form>

<table>
<tr>
<th>Choose a Service</th>
<td><select name='expressservicelist' id="expressservicelist" onChange="document.getElementById('desp').value = this.options[this.selectedIndex].id">
        	<option value=''>Choose an Service</option>
          	<cfloop query='getservice'>
				<cfif getservice.servi eq ""><option value='Unnamed'>Unnamed - #desp#</option>
				<cfelse><option value='#URLEncodedFormat(servi)#' id="#desp#">#servi# - #desp#</option>
				</cfif>
          	</cfloop>
		</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" align="right" value="CLOSE" onClick="releaseDirtyFlag();submitinvoice();">
</td>

</tr>
<tr>
<th>Description</th>
<td><input type="text" name="desp" id="desp" size="60" ></td>
</tr>
<tr>
<th>Amount</th>
<td><input type="text" name="expressamt" id="expressamt" size="10" value="0.00" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="button" value="Add" onClick="addItem('Services');clearform('Services');"></td>
</tr>
</table>
</cfoutput>
<div id="ajaxFieldSer" name="ajaxFieldSer">
<cfquery name="selectservices" datasource="#dts#">
SELECT itemno, desp, amt FROM ictran where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#" and linecode = "SV"
</cfquery>
<cfoutput>
<table width="550">
<tr>
<th width="150">Item Code</th><th width="300">Description</th><th width="100" align="right">Amount</th>
</tr>
<cfloop query="selectservices">
<tr>
<td>#selectservices.itemno#</td>
<td>#selectservices.desp#</td>
<td align="right">#numberformat(selectservices.amt,'.__')#</td>
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
	