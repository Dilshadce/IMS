<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfoutput>
<div align="center">
<br/>
<h2>PACKING LIST #url.packno#</h2>
<table>
<tr><td>
<h3><a href="/default/transaction/packinglist/packinglistprint.cfm?packid=#url.packno#" target="_blank"><img src="/images/printRpt.gif" width="20px" height="20px" /><br/>Print I</a></h3>
<td>
<td>
<h3><a href="/default/transaction/packinglist/packinglistprint2.cfm?packid=#url.packno#" target="_blank"><img src="/images/printRpt.gif" width="20px" height="20px" /><br/>Print II</a></h3>
</td>
<td>
<h3><a href="/default/transaction/packinglist/packinglistprint3.cfm?packid=#url.packno#" target="_blank"><img src="/images/printRpt.gif" width="20px" height="20px" /><br/>Print III</a></h3>
</td>
<cfif lcase(HcomID) eq "leatat_i">
<td>
<h3><a href="/default/transaction/packinglist/leatatpackinglistpdf.cfm?packid=#url.packno#" target="_blank"><img src="/images/printRpt.gif" width="20px" height="20px" /><br/>Print PDF</a></h3>
</td>
</cfif>
</div>

</cfoutput>