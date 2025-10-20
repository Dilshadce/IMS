<cfajaximport tags="cfform">
<cfsetting showdebugoutput="no">
<cfquery name="getgsetup" datasource="#dts#">
SELECT filterall,ECAOTA,ECAMTOTA,negstk,PCBLTC,ddlbilltype,expressdisc,displaycostcode,ldriver,autonextdate,ddllocation,lastaccyear FROM gsetup
</cfquery>
<html>
<head>
<script src="/SpryAssets/SpryCollapsiblePanel.js" type="text/javascript"></script>
<link href="/SpryAssets/SpryCollapsiblePanel.css" rel="stylesheet" type="text/css" />
	<title>Express Name</title>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
    <script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script type="text/javascript">
	<cfset uuid = createuuid()>
	
	
	
	function addItemAdvance()
	{
	<cfoutput>
	var desp = encodeURI(document.getElementById('desp2').value);
	
	var qtyonhand = document.getElementById('qtyonhand').value;
	
	var qtyactual = document.getElementById('qtyactual').value;
	var qtydiff = document.getElementById('qtydiff').value;
	var refno = document.getElementById('refno').value;
	var unit1 = document.getElementById('unit').value;
	var ucost = document.getElementById('ucost').value;
	var period = document.getElementById('period').value;
	var location = encodeURI(document.getElementById('location').value);
	var date = encodeURI(document.getElementById('wos_date').value);
	
	var expressservice=encodeURI(document.getElementById('expressservicelist').value);

	
	
	var ajaxurl = '/default/report-location/locationexpressadjustment/addproductsAjax.cfm?itemno='+escape(expressservice)+'&desp='+escape(desp)+'&qtyonhand='+escape(qtyonhand)+'&qtyactual='+escape(qtyactual)+'&qtydiff='+escape(qtydiff)+'&refno='+escape(refno)+'&unit1='+escape(unit1)+'&ucost='+escape(ucost)+'&loc='+escape(location)+'&date='+escape(date)+'&period='+escape(period)+'&uuid=#URLEncodedFormat(uuid)#';
	ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
	clearformadvance();
	setTimeout('refreshlist();',750);
	</cfoutput>
	}
	<cfoutput>
	function clearformadvance()
	{
	document.getElementById('expressservicelist').value = '';
	document.getElementById('desp2').value = '';
	document.getElementById('qtyactual').value = '';
	document.getElementById('qtyonhand').value = '';
	document.getElementById('qtydiff').value = '';
	document.getElementById('unit').value = '';
	document.getElementById('ucost').value = '0.00';

	}
	
	function refreshlist()
	{
	ColdFusion.Grid.refresh('itemlist',false);
	}
	
	function addnewitem2()
	{
	addItemControl();
	
	}
	function addItemControl()
	{
	var itemno = document.getElementById('expressservicelist').value;
	
	if (itemno == "")
	{
	alert("Please select item");
	}
	else
	{
	addItemAdvance();
	}
	}
	
	</cfoutput>
	
	
	function updateVal()
	{
	var validdesp = unescape(document.getElementById('desphid').value);

	if (validdesp == "itemisnoexisted")
	{
	document.getElementById('btn_add').value = "Item No Existed";
	document.getElementById('btn_add').disabled = true; 
	}
	else
	{
	
	document.getElementById('desp2').value = unescape(decodeURI(document.getElementById('desphid').value));
	document.getElementById('unit').selectedIndex =document.getElementById('unithid').value;
	document.getElementById('ucost').value = document.getElementById('ucostid').value;
	document.getElementById('qtyonhand').value = document.getElementById('qtyonhandid').value;
	document.getElementById('btn_add').value = "Add";
	document.getElementById('btn_add').disabled = false; 
	}
	}
	
    </script>
    
    
</head>
<body>
<cfquery name="getlastrefno" datasource="#dts#">
select refno as refno from locadj order by created_on desc
</cfquery>

<cfif getlastrefno.refno eq ''>
<cfset refno=1>
<cfelse>
<cfset refno=getlastrefno.refno+1>
</cfif>

<cfoutput>
<h1>Express Location Quantity Adjustment</h1>
<h2>*Note - Kindly choose period and date before choosing item</h2>
<cfform name="form" id="form" action="process.cfm" method="post">

<input type="hidden" name="uuid" id="uuid" value="#uuid#">
<input type="hidden" name="refno" id="refno" value="#refno#">
<input type="hidden" name="pagesize" id="pagesize" value="10" />
<table width="100%" border="0">
<tr>
<th>Period</th>
      	<td colspan="2">
			<select name="period" id="period" onChange="document.getElementById('wos_date').value = this.options[this.selectedIndex].id;">
				<cfoutput>
                <cfset nowdate = dateformat(now(),"dd/mm/yyyy")>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("00"),DE("01")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="01" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("00"),DE("01")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))# >Period 01 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("00"),DE("01")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("01"),DE("02")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="02" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("01"),DE("02")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 02 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("01"),DE("02")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("02"),DE("03")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="03" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("02"),DE("03")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 03 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("02"),DE("03")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("03"),DE("04")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="04" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("03"),DE("04")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 04 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("03"),DE("04")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("04"),DE("05")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="05" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("04"),DE("05")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 05 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("04"),DE("05")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("05"),DE("06")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="06" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("05"),DE("06")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 06 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("05"),DE("06")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("06"),DE("07")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="07" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("06"),DE("07")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 07 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("06"),DE("07")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("07"),DE("08")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="08" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("07"),DE("08")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 08 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("07"),DE("08")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("08"),DE("09")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="09" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("08"),DE("09")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 09 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("08"),DE("09")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("09"),DE("10")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="10" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("09"),DE("10")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 10 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("09"),DE("10")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("10"),DE("11")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="11" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("10"),DE("11")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 11 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("10"),DE("11")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("11"),DE("12")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="12" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("11"),DE("12")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 12 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("11"),DE("12")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("12"),DE("13")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="13" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("12"),DE("13")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 13 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("12"),DE("13")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("13"),DE("14")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="14" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("13"),DE("14")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 14 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("13"),DE("14")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("14"),DE("15")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="15" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("14"),DE("15")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 15 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("14"),DE("15")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("15"),DE("16")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="16" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("15"),DE("16")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 16 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("15"),DE("16")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("16"),DE("17")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="17" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("16"),DE("17")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 17 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("16"),DE("17")),getgsetup.lastaccyear),'mmm yyyy')#</option>
                <cfset lasdate =#dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("17"),DE("18")),getgsetup.lastaccyear),'dd/mm/yyyy')#>
				<option value="18" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("17"),DE("18")),getgsetup.lastaccyear),'mmm yyyy')),DE('selected id="#nowdate#"'),DE('id="#lasdate#"'))#>Period 18 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgsetup.lastaccyear)) eq year(getgsetup.lastaccyear) and month(dateadd("d",1,getgsetup.lastaccyear)) eq month(getgsetup.lastaccyear),DE("17"),DE("18")),getgsetup.lastaccyear),'mmm yyyy')#</option>
				</cfoutput>
			</select>
		</td>
</tr>
<tr>
<th>Date Of Adjustment</th>
<td colspan="3"><cfinput type="text" name="wos_date" id="wos_date" value="#dateformat(now(),'DD/MM/YYYY')#"/><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(wos_date);">&nbsp;(DD/MM/YYYY)<font color="FF0000"><br>Please Check Your Date With Your Selected Period !</font></td>
</tr>
<td colspan="100%">
<hr></td>
</tr>
<tr>
<th width="10%">Choose a product</th>
<td  colspan="3"><cfinput type="text" name="expressservicelist" id="expressservicelist" size="26" onBlur="this.value = this.value.split('___', 1);ajaxFunction(window.document.getElementById('itemDetail'),'/default/report-location/locationexpressadjustment/addItemAjax.cfm?itemno='+encodeURI(this.value)+'&location='+document.getElementById('location').value+'&date='+document.getElementById('wos_date').value);setTimeout('updateVal();',750);" autosuggest="cfc:itemno.findItem({cfautosuggestvalue},'#dts#')" autosuggestminlength="1" /><input type="button" onClick="ColdFusion.Window.show('searchitem');" value="Search" align="right" />
<input type="hidden" name="desp2" id="desp2" value="">
<input type="hidden" name="unit" id="unit" value="">
<input type="hidden" name="ucost" id="ucost" value="0.00">
</td>
<th>Location</th>
<cfquery name="getlocation" datasource="#dts#">
select location,desp from iclocation
</cfquery>
<td><select name="location" onChange="this.value = this.value.split('___', 1);ajaxFunction(window.document.getElementById('itemDetail'),'/default/report-location/locationexpressadjustment/addItemAjax.cfm?itemno='+encodeURI(document.getElementById('expressservicelist').value)+'&location='+document.getElementById('location').value+'&date='+document.getElementById('wos_date').value);setTimeout('updateVal();',750);">
<cfloop query="getlocation">
<option value="#location#">#location# - #desp#</option>
</cfloop>
</select>
</td>
</tr>
<tr>
 <th><div id="itemDetail"></div>Qty On Hand</th>
  <td><input type="text"  name="qtyonhand" id="qtyonhand" maxlength="10" value="" readonly></td>
  
  <th>Actual Qty</th>
  <td><input type="text"  name="qtyactual" id="qtyactual" maxlength="10" value="" onKeyUp="document.getElementById('qtydiff').value=document.getElementById('qtyonhand').value-document.getElementById('qtyactual').value;"></td>
  
  <th>Qty Difference</th>
  <td><input type="text"  name="qtydiff" id="qtydiff" maxlength="10" value="" readonly></td>
</tr>

<tr>
<td colspan="9" align="center">
<input name="btn_add" style="font: medium bolder" id="btn_add" type="button" value="Add" onClick="addnewitem2();document.getElementById('period').disabled = true;document.getElementById('wos_date').disabled = true;document.getElementById('imagedate').disabled = true;"><div id="ajaxFieldPro" name="ajaxFieldPro"></div>
</td>
</tr>
<tr>
<td colspan="8" height="200">
<cfgrid name="itemlist" pagesize="7" format="html" width="95%" height="100%"
bind="cfc:itemlist.getictran({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},'#dts#','#uuid#',{pagesize})"
                                onchange="cfc:itemlist.editictran({cfgridaction},
                                            {cfgridrow},
                                            {cfgridchanged},'#dts#','#HUserID#')" selectmode="edit" textcolor="##000000" delete="yes" deletebutton="Delete" selectonload="false">
                                
                    <cfgridcolumn name="itemno" header="Item Code" dataalign="left" select="no" width="100">
                    <cfgridcolumn name="desp" header="Description" dataalign="left" select="no" width="300">
                    <cfgridcolumn name="qtyonhand" header="Quantity On Hand" dataalign="center" select="no" width="100">
                    <cfgridcolumn name="qtyactual" header="Quantity Actual" dataalign="right" select="no" width="150">
                    <cfgridcolumn name="qtydiff" header="Quantity Difference" dataalign="right" select="no" width="150">
                    <cfgridcolumn name="location" header="Location" dataalign="right" select="no" width="150">
                    <cfgridcolumn name="uuid" header="uuid" dataalign="right" display="no">       
							</cfgrid></td>
</tr>
<tr>

  <td colspan="100%" align="center"><cfinput type="submit" style="font: medium bolder" name="Submit" id="Submit" value="Accept"/> &nbsp;&nbsp;&nbsp;<cfinput type="button" style="font: medium bolder" name="Close" id="Close" value="Close" onClick="window.close();"/></td>

</tr>
</table>

</cfform>
</cfoutput>
<cfwindow center="true" width="600" height="400" name="searchitem" refreshOnShow="true" closable="true" modal="false" title="Search Item" initshow="false"
        source="/default/report-location/locationexpressadjustment/searchitem.cfm" /></body></html>