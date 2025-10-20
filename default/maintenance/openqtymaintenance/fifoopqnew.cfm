<html>
<head>
<title>Edit Item Opening Quantity/Cost</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type="text/javascript" src="/scripts/prototypenew.js" ></script>

<script type="text/javascript">

function changepagefilter(pagenumber){
	if(pagenumber == 0 || isNaN(pagenumber)){
		alert("Page number is not correct!");
	}
	else{
		<!---alert(document.getElementById('filtercolumn').value);
		alert(document.getElementById('filter').value);
		alert(pagenumber);
		--->
		ajaxFunction(document.getElementById('fifobodyajaxField'),"fifoopqbody.cfm?filtertype="+document.getElementById('filtercolumn').value+'&filtertext='+document.getElementById('filter').value+'&page='+pagenumber);
	}
}

function updatevalue(itemfield,itemno,updatevalue){
	if(isNaN(updatevalue)){
		alert("Please Key In number Only!");
	}
	else{
		ajaxFunction(document.getElementById('changevaluefieldAjax'),"fifoopqupdatevalue.cfm?itemfield="+itemfield+"&itemno="+escape(encodeURIComponent(itemno))+"&updatevalue="+updatevalue)
	}
}

</script>

<cfquery name="getitem" datasource="#dts#">
	select itemno,desp,unit,qtybf,ucost,avcost,avcost2 
	from icitem 
	order by itemno limit 10;
</cfquery>

<cfquery name="getpage" datasource="#dts#">
	select itemno
	from icitem 
	order by itemno;
</cfquery>

<cfset totalpagenumber=ceiling(getpage.recordcount/10)>

<body>
<cfoutput>
<h3>
	<a href="/default/maintenance/openqtymaintenance/openqtymenu.cfm">Opening Quantity Menu</a> >> 
	<a><font size="2">Item Opening Quantity</font></a>
</h3>
<h1 align="center">Item Opening Quantity</h1>
<table align="center">
<tr>
<th>Filter By</th>
<td>
<select name="filtercolumn" id="filtercolumn">
<option value="itemno">Itemno</option>
<option value="desp">Description</option>
<option value="ucost">Cost</option>
</select>
</td>
<th>Filter Text</th>
<td>
<input type="text" name="filter" id="filter" value="" />
	<input type="button" name="filterbutton" value="Go" id="filterbutton" onClick="changepagefilter('1')">
</td>
</tr>
</table>

<div id="fifobodyajaxField">

<table align="center" width="100%">
<tr>
<th width="25%"><div align="left">Item No</div></th>
<th width="40%"><div align="left">Description</div></th>
<th width="5%"><div align="left">Unit Of Measurement</div></th>
<th width="5%"><div align="left">Qty B/F</div></th>
<th width="5%"><div align="left">Fixed Cost</div></th>
<th width="5%"><div align="left">Mth. Av. Cost</div></th>
<th width="5%"><div align="left">Mov/Weg Av. Cost</div></th>
<th width="10%"><div align="center">Fifo Tab</div></th>
</tr>
<cfloop query="getitem">
<tr>
<td>#itemno#</td>
<td>#desp#</td>
<td>#unit#</td>
<td><input type="text" name="qtybf" id="qtybf" value="#qtybf#" size="4" onChange="updatevalue('qtybf','#getitem.itemno#',this.value)"></td>
<td><input type="text" name="ucost" id="ucost" value="#ucost#" size="4" onChange="updatevalue('ucost','#getitem.itemno#',this.value)"></td>
<td><input type="text" name="avcost" id="avcost" value="#avcost#" size="4" onChange="updatevalue('avcost','#getitem.itemno#',this.value)"></td>
<td><input type="text" name="avcost2" id="avcost2" value="#avcost2#" size="4" onChange="updatevalue('avcost2','#getitem.itemno#',this.value)"></td>
<td align="center"><input type="button" name="fifotab" id="fifotab" value="FIFO Tab" onClick="window.open('fifoopqnew1.cfm?itemno=#URLEncodedFormat(itemno)#','','','_blank')"></td>
</tr>
</cfloop>
<tr>
<td colspan="100%"><hr></td>
</tr>
<tr>
<td><input type="button" name="backbutton" id="backbutton" value="Back" id="filterbutton" onClick="document.getElementById('pagenumber').value=(document.getElementById('pagenumber').value*1)-1;changepagefilter(document.getElementById('pagenumber').value);"></td>
<td align="center" colspan="6">Page <input type="text" name="pagenumber" id="pagenumber" value="1" size="3" onBlur="changepagefilter(this.value);"> of #totalpagenumber# <input type="button" name="filterbutton" value="Go" id="filterbutton" onClick=""></td>
<td align="right"><input type="button" name="backbutton" id="backbutton" value="Next" id="filterbutton" onClick="document.getElementById('pagenumber').value=(document.getElementById('pagenumber').value*1)+1;changepagefilter(document.getElementById('pagenumber').value);"></td></tr>

</table>
</div>
<div id="changevaluefieldAjax"></div>
</cfoutput>
</body>
</html>