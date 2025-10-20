<html>
<head>
<title>Service Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>

<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>

<cfquery name="getdealer_menu" datasource="#dts#">
	select * from dealer_menu
</cfquery>
</head>

<script language="JavaScript">
<!--- 	document.form.Tick.value = toString(val(document.form.Tick.value)+1); --->

function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			
									}

function TickCate()	{
  if(document.form.cbCate.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbCate.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickSizeID()	{
  if(document.form.cbSizeID.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbSizeID.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickCostCode()	{
  if(document.form.cbCostCode.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbCostCode.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickColorID()	{
  if(document.form.cbColorID.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbColorID.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickGroup()	{
  if(document.form.cbGroup.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbGroup.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickShelf()	{
  if(document.form.cbShelf.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbShelf.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickMItemNo()	{
  if(document.form.cbMItemNo.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbMItemNo.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickQtyBF()	{
  if(document.form.cbQtyBF.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbQtyBF.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickQty2()	{
  if(document.form.cbQty2.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbQty2.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickBrand()	{
  if(document.form.cbBrand.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbBrand.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickUnit()	{
  if(document.form.cbUnit.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbUnit.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickQty3()	{
  if(document.form.cbQty3.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbQty3.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickSupp()	{
  if(document.form.cbSupp.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbSupp.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickCost()	{
  if(document.form.cbCost.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbCost.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickQty4()	{
  if(document.form.cbQty4.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbQty4.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickPacking()	{
  if(document.form.cbPacking.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbPacking.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickPrice()	{
  if(document.form.cbPrice.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbPrice.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickQty5()	{
  if(document.form.cbQty5.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbQty5.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickMinimum()	{
  if(document.form.cbMinimum.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbMinimum.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickPrice2()	{
  if(document.form.cbPrice2.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbPrice2.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickQty6()	{
  if(document.form.cbQty6.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbQty6.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickMaximum()	{
  if(document.form.cbMaximum.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbMaximum.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickPrice3()	{
  if(document.form.cbPrice3.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbPrice3.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickQOH()	{
  if(document.form.cbQOH.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbQOH.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickReorder()	{
  if(document.form.cbReorder.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbReorder.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickfcurrcode()	{
  if(document.form.cbfcurrcode.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbfcurrcode.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickfucost()	{
  if(document.form.cbfucost.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbfucost.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickfprice()	{
  if(document.form.cbfprice.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbfprice.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickPrice_Min()	{
  if(document.form.cbPrice_Min.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbPrice_Min.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function TickCostformula()	{
  if(document.form.cbcostformula.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbcostformula.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickcreatedate()	{
  if(document.form.cbcredate.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbcredate.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem1()	{
  if(document.form.cbrem1.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem1.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem2()	{
  if(document.form.cbrem2.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem2.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem3()	{
  if(document.form.cbrem3.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem3.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem4()	{
  if(document.form.cbrem4.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem4.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem5()	{
  if(document.form.cbrem5.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem5.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem6()	{
  if(document.form.cbrem6.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem6.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem7()	{
  if(document.form.cbrem7.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem7.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem8()	{
  if(document.form.cbrem8.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem8.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem9()	{
  if(document.form.cbrem9.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem9.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem10()	{
  if(document.form.cbrem10.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem10.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem11()	{
  if(document.form.cbrem11.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem11.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem12()	{
  if(document.form.cbrem12.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem12.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem13()	{
  if(document.form.cbrem13.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem13.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem14()	{
  if(document.form.cbrem14.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem14.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem15()	{
  if(document.form.cbrem15.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem15.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem16()	{
  if(document.form.cbrem16.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem16.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem17()	{
  if(document.form.cbrem17.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem17.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem18()	{
  if(document.form.cbrem18.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem18.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem19()	{
  if(document.form.cbrem19.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem19.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickrem20()	{
  if(document.form.cbrem20.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbrem20.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickbarcode()	{
  if(document.form.cbbarcode.checked) {
    if(eval(document.form.Tick.value)<=4){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 5 Fields.");
	  document.form.cbbarcode.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function ClearAll()	{
  document.form.Tick.value = "0";
  document.form.cbCate.checked = false;
  document.form.cbSizeID.checked = false;
  document.form.cbCostCode.checked = false;
  document.form.cbColorID.checked = false;
  document.form.cbGroup.checked = false;
  document.form.cbShelf.checked = false;
  document.form.cbMItemNo.checked = false;
  document.form.cbQtyBF.checked = false;
  document.form.cbQty2.checked = false;
  document.form.cbBrand.checked = false;
  document.form.cbUnit.checked = false;
  document.form.cbQty3.checked = false;
  document.form.cbSupp.checked = false;
  document.form.cbCost.checked = false;
  document.form.cbQty4.checked = false;
  document.form.cbPacking.checked = false;
  document.form.cbPrice.checked = false;
  document.form.cbQty5.checked = false;
  document.form.cbMinimum.checked = false;
  document.form.cbPrice2.checked = false;
  document.form.cbQty6.checked = false;
  document.form.cbMaximum.checked = false;
  document.form.cbPrice3.checked = false;
  document.form.cbReorder.checked = false;
  document.form.cbfcurrcode.checked = false;
  document.form.cbfucost.checked = false;
  document.form.cbfprice.checked = false;
  document.form.cbPrice_Min.checked = false;
    document.form.cbQOH.checked = false;
	document.form.cbcostformula.checked = false;
	document.form.cbcredate.checked = false;
	document.form.cbrem1.checked = false;
	document.form.cbrem2.checked = false;
	document.form.cbrem3.checked = false;
	document.form.cbrem4.checked = false;
	document.form.cbrem5.checked = false;
	document.form.cbrem6.checked = false;
	document.form.cbrem7.checked = false;
	document.form.cbrem8.checked = false;
	document.form.cbrem9.checked = false;
	document.form.cbrem10.checked = false;
	document.form.cbrem11.checked = false;
	document.form.cbrem12.checked = false;
	document.form.cbrem13.checked = false;
	document.form.cbrem14.checked = false;
	document.form.cbrem15.checked = false;
	document.form.cbrem16.checked = false;
	document.form.cbrem17.checked = false;
	document.form.cbrem18.checked = false;
	document.form.cbrem19.checked = false;
	document.form.cbrem20.checked = false;
	document.form.cbbarcode.checked = false;
	
  return true;
}

// begin: product search
function getProduct(type){
	if(type == 'productto'){
		var inputtext = document.form.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.form.searchitemfr.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult2);
	}
}

function getProductResult(itemArray){
	DWRUtil.removeAllOptions("productto");
	DWRUtil.addOptions("productto", itemArray,"KEY", "VALUE");
}

function getProductResult2(itemArray){
	DWRUtil.removeAllOptions("productfrom");
	DWRUtil.addOptions("productfrom", itemArray,"KEY", "VALUE");
}
// end: product search

</script>

<cfquery name="getservi" datasource="#dts#">
  select servi, desp from icservi order by servi
</cfquery>
<cfquery name="getcate" datasource="#dts#">
  select * from iccate order by cate
</cfquery>
<cfquery name="getsizeid" datasource="#dts#">
  select sizeid, desp from icsizeid order by sizeid
</cfquery>
<cfquery name="getcostcode" datasource="#dts#">
  select costcode, desp from iccostcode order by costcode
</cfquery>
<cfquery name="getcolorid" datasource="#dts#">
  select colorid, desp from iccolorid order by colorid
</cfquery>
<cfquery name="getshelf" datasource="#dts#">
  select shelf, desp from icshelf order by shelf
</cfquery>
<cfquery name="getgroup" datasource="#dts#">
  select wos_group, desp from icgroup order by wos_group
</cfquery>
<cfquery name="getgsetup" datasource='#dts#'>
  Select * from gsetup
</cfquery>

<body>
<h1 align="center">Service Listing</h1>
<cfoutput>
	<h4>
	<cfif getpin2.h1G10 eq 'T'>
		<a href="servicetable2.cfm?type=Create">Creating a Service</a> 
	</cfif>
	<cfif getpin2.h1G20 eq 'T'>
		|| <a href="servicetable.cfm?">List All Service</a> 
	</cfif>
	<cfif getpin2.h1G30 eq 'T'>
		|| <a href="s_servicetable.cfm?type=icservi">Search For Service</a>
	</cfif>
   
   || <a href="s_servicetable.cfm?type=icservi">Service Listing</a> 
</h4>
</cfoutput>

<cfform action="l_icservi.cfm" name="form" method="post" target="_blank">
<input type="hidden" name="fromto" id="fromto" value="" />
  <input type="hidden" name="Tick" value="0">
  <table border="0" align="center" width="90%" class="data">
    <tr>
      <th>Report Format</th>
      <td colspan="3"><input type="radio" name="result" value="HTML" checked>
        HTML<br/>
        <input type="radio" name="result" value="EXCELDEFAULT">
        EXCEL DEFAULT </td>
    </tr>
      <tr>
      <th width="20%"><cfoutput>Service</cfoutput></th>
      <td width="5%"><div align="center">From</div></td>
      <td colspan="6"><select name="productfrom">
          <option value="">Choose a <cfoutput>service</cfoutput></option>
          <cfoutput query="getservi">
            <option value="#servi#">#servi# 
              - #desp#</option>
          </cfoutput>
        </select>
          <cfif getgsetup.filterall eq "1">
            <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />
            &nbsp;
            <input type="text" name="searchservifr" onKeyUp="getProduct('productfrom');">
          </cfif>
      </td>
    </tr>
    <tr>
      <th><cfoutput>Service</cfoutput></th>
      <td><div align="center">To</div></td>
      <td colspan="6" nowrap><select name="productto">
          <option value="">Choose a <cfoutput>service</cfoutput></option>
          <cfoutput query="getservi">
            <option value="service">#servi# 
              - #desp#</option>
          </cfoutput>
        </select>
          <cfif getgsetup.filterall eq "1">
            <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finditem');" />
            &nbsp;
            <input type="text" name="searchservito" onKeyUp="getProduct('productto');">
          </cfif>
      </td>
    </tr>
    <tr>
      <td colspan="8">&nbsp;</td>
    </tr>
     <tr>
    
      <td width="5%"><div align="right">
      <input type="Submit" name="Submit" value="Submit">
    </div></td>
  </tr>
  </table>
  <table border="0" align="center" width="90%" class="data"><tr><cfif getgsetup.gpricemin eq 1>
  </cfif>
  </tr>
  </table>
</cfform>
</body>
</html>

<cfif getdealer_menu.itemformat eq '2'>
<cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem2.cfm?type=Product&fromto={fromto}" />
<cfelse>
<cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem.cfm?type=Product&fromto={fromto}" />
        </cfif>