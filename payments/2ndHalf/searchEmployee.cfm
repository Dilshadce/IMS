<script language="javascript" type="text/javascript" src="/javascripts/ajax.js"></script>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
<table>
<tr>
<td>Empno / Keyword</td>
<td><input type="text" name="search" id="search"/></td>
</tr>
<tr>
<td></td>
<td><input type="submit" name="GO" value="GO" onclick="ajaxFunction(document.getElementById('ajaxField'),'searchEmployeeAjax.cfm?keyword='+document.getElementById('search').value );"/></td>
</tr>
</table>

<div id="ajaxField" name="ajaxField">
<cfquery name="searchKey" datasource="#dts#">
SELECT * FROM pmast as a left join (select empno as empno1,payyes from paytran) as b on a.empno = b.empno1 WHERE a.paystatus = "A"  and a.confid >= #hpin# and b.payyes = "Y" 
</cfquery>

<cfoutput>
<table>
<cfloop query="searchKey">
<tr>
<td>#searchKey.empno#</td>
<td>#searchKey.name#</td>
<td><a href="viewPaySlipForm.cfm?empno=#searchKey.empno#">SELECT</a></td>
</tr>
</cfloop>
</table>
</cfoutput>
</div>