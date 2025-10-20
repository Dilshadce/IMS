<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>News</title>
<link href="/stylesheet/news.css" rel="stylesheet" type="text/css" />
</head>

<cfquery name="getmodule" datasource="#dts#">
    select * from modulecontrol
</cfquery>

<body>
 	<script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script type="text/javascript" src="/scripts/prototypenew.js" ></script>
    <script type="text/javascript">
	
	function changepage1()
	{
	ajaxFunction(document.getElementById('newajaxfield'),'newItemCreated.cfm');
	}
	function changepage2()
	{
	ajaxFunction(document.getElementById('newajaxfield'),'newCustCreated.cfm');
	}
	function changepage3()
	{
	ajaxFunction(document.getElementById('newajaxfield'),'newItemUpdated.cfm');
	}
	function changepage4()
	{
	ajaxFunction(document.getElementById('newajaxfield'),'newcar.cfm');
	}
	function changepage5()
	{
	ajaxFunction(document.getElementById('newajaxfield'),'todaysale.cfm');
	}
	function changepage6()
	{
	ajaxFunction(document.getElementById('newajaxfield'),'vehiserdate.cfm');
	}
	function changepage7()
	{
	ajaxFunction(document.getElementById('newajaxfield'),'todaysaledetail.cfm');
	}
	</script>
<cfoutput>
<table height="">
<tr><th class="thtitle" colspan="2" align="left" width="100%">News</th></tr>

<tr>
<th class="thsubtitle" onclick="changepage1();" onMouseOver="JavaScript:this.style.cursor='hand';" >New Item Created</th>
<td rowspan="100%" width="800">
<div class="divcontent" id="newajaxfield" >

</div>
</td>
</tr>
<tr>
<th class="thsubtitle" onclick="changepage2();" onMouseOver="JavaScript:this.style.cursor='hand';" >New Customer Created</th>
<td rowspan="100%" width="800">
<div class="divcontent" id="newajaxfield" >

</div>
</td>
</tr>


<tr>
<th class="thsubtitle" onclick="changepage3()" onMouseOver="JavaScript:this.style.cursor='hand';">NewNew Cost & Selling Price</th>

</tr>
<cfif getmodule.auto eq "1">
<tr>
<th class="thsubtitle" onclick="changepage4();" onMouseOver="JavaScript:this.style.cursor='hand';">New Car</th>

</tr>
</cfif>
<tr>
<th class="thsubtitle" onclick="changepage5();" onMouseOver="JavaScript:this.style.cursor='hand';">Today Sale</th>
</tr>
<tr>
<th class="thsubtitle" onclick="changepage7();" onMouseOver="JavaScript:this.style.cursor='hand';">Today Invoices</th>

</tr>
<cfif getmodule.auto eq "1">
<tr>
<th class="thsubtitle" onclick="changepage6();" onMouseOver="JavaScript:this.style.cursor='hand';">Car Service Near Date</th>

</tr>
</cfif>

</table>


</cfoutput>
</body>
</html>
