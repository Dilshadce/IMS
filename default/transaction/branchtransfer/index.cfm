
<html>
<head><title>Inter Branck Stock Check / Transfer</title></head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<body>
<cfoutput>
<h3>Inter Branch Stock Check / Transfer</h3>
<table align="center">
<tr>
<th colspan="100%"><div align="center">Search Item</div></th>
</tr>
<tr>
<th>Category</th>
<td>
<cfquery name="getcate" datasource="#dts#">
SELECT * FROM iccate ORDER BY CATE
</cfquery>
<select name="cate" id="cate">
<option value="">Choose a Category</option>
<cfloop query="getcate">
<option value="#getcate.cate#">#getcate.cate# - #getcate.desp#</option>
</cfloop>
</select>
</td>
<td>
</td>
<th>
Gold Content
</th>
<td>
<cfquery name="getgold" datasource="#dts#">
SELECT sizeid,desp FROM icsizeid ORDER BY sizeid 
</cfquery>
<select name="goldcontent" id="goldcontent">
<option value="">Choose a Gold Content</option>
<cfloop query="getgold">
<option value="#getgold.sizeid#">#getgold.sizeid#</option>
</cfloop>
</select>
</td>
</tr>
<tr>
<th>Brand</th>
<td>
<cfquery name="getbrand" datasource="#dts#">
SELECT brand,desp FROM brand ORDER BY brand
</cfquery>
<select name="brand" id="brand">
<option value="">Choose a Brand</option>
<cfloop query="getbrand">
<option value="#getbrand.brand#">#getbrand.brand# - #getbrand.desp#</option>
</cfloop>
</select>
</td>
<td></td>
<th>Stone Desc</th>
<td>
<input type="text" name="stonedesc1" id="stonedesc1" value="">
</td>
</tr>
<tr>
<th>Group</th>
<td>
<cfquery name="getgroup" datasource="#dts#">
SELECT wos_group,desp FROM icgroup ORDER BY wos_group
</cfquery>
<select name="group" id="group">
<option value="">Choose a Group</option>
<cfloop query="getbrand">
<option value="#getgroup.wos_group#">#getgroup.wos_group# - #getgroup.desp#</option>
</cfloop>
</select>
</td>
<td></td>
<td></td>
<td><input type="text" name="stonedesc2" id="stonedesc2" value=""></td>
</tr>
<tr>
<th>Weight</th>
<td>
From <input type="text" name="weightfrom" id="weightfrom" value="" size="10" onBlur="if(this.value != '' && document.getElementById('weightto').value != ''){document.getElementById('weightto').value = this.value;}"> To <input type="text" name="weightto" id="weightto" value="" size="10">
</td><td></td>
<td></td>
<td><input type="text" name="stonedesc3" id="stonedesc3" value=""></td>
</tr>
<tr>
<th>Location</th>
<td>
<cfquery name="getlocation" datasource="#dts#">
SELECT location, desp FROM iclocation
</cfquery>
<select name="location" id="location">
<option value="">Choose a Location</option>
<cfloop query="getlocation">
<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
</cfloop>
</select>
</td>
<td></td>
<th>Size</th>
<td>
<input type="text" name="size" id="size" value="">
</td>
</tr>

<tr>
<th>Remarks</th>
<td colspan="4">
<input type="text" name="remark" id="remark" size="100">
</td>
</tr>
<tr>
<td colspan="100%" align="center"><input type="button" name="searchbtn" id="searchbtn" value="Search" onClick="searchitem()"></td>
</tr>
</table>
<script type="text/javascript" src="/scripts/prototypenew.js" ></script>
<script type="text/javascript">
function trim(strval)
	{
	return strval.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	}
	
function searchitem()
{
	ColdFusion.Window.show('processing');
	var categoryfield = escape(trim(document.getElementById('cate').value));
	var brandfield = escape(trim(document.getElementById('brand').value));
	var groupfield = escape(trim(document.getElementById('group').value));
	var weightfromfield = escape(trim(document.getElementById('weightfrom').value));
	var weighttofield = escape(trim(document.getElementById('weightto').value));
	var locationfield = escape(trim(document.getElementById('location').value));
	var goldcontentfield = escape(trim(document.getElementById('goldcontent').value));
	var stonedesc1field = escape(trim(document.getElementById('stonedesc1').value));
	var stonedesc2field = escape(trim(document.getElementById('stonedesc2').value));
	var stonedesc3field = escape(trim(document.getElementById('stonedesc3').value));
	var sizefield = escape(trim(document.getElementById('size').value));
	var remarkfield = escape(trim(document.getElementById('remark').value));
	
	var ajaxurl = '/default/transaction/branchtransfer/getlocstock.cfm?category='+categoryfield+'&brand='+brandfield+'&group='+groupfield+'&weightfrom='+weightfromfield+'&weightto='+weighttofield+'&location='+locationfield+'&goldcontent='+goldcontentfield+'&stonedesc1='+stonedesc1field+'&stonedesc2='+stonedesc2field+'&stonedesc3='+stonedesc3field+'&size='+sizefield+'&remark='+remarkfield;
		 new Ajax.Request(ajaxurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxfield').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Found!'); },		
		onComplete: function(transport){
		 ColdFusion.Window.hide('processing');
        }
      })	  
}

function validatesubmit()
{
	for(var i = 0;i<document.getElementById('itemrecords').value;i++)
	{
		if( document.getElementById('transfercode'+i).checked == true)
		{
			return true;
		}
	}
	alert('Please kindly select at least one item to transfer!');
	return false;
}


</script>

<cfform name="transfer" id="transfer" method="post" action="transferprocess.cfm" onsubmit="return validatesubmit();">

<div id="ajaxfield">

</div>

</cfform>
</cfoutput>
</body>
</html>
<cfwindow name="processing" width="300" height="300" initshow="false" center="true" closable="false" draggable="false" title="Importing....Please Wait" modal="true" resizable="false" >
<h1>Please Wait...</h1>
<img src="/images/loading.gif" align="middle" />
<div id="ajaxcontrol"></div>
</cfwindow>
