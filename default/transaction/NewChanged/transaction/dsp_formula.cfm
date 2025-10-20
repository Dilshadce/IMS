<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<cfquery name='getgsetup2' datasource='#dts#'>
  	select concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,Decl_Uprice as Decl_Uprice1, concat('.',repeat('_',DECL_DISCOUNT)) as DECL_DISCOUNT1, DECL_DISCOUNT from gsetup2
</cfquery>
<cfquery name="getartran" datasource="#dts#">
	select * from artran 
	where type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
	and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
</cfquery>

<cfquery name="getictran" datasource="#dts#">
	select * from ictran 
	where type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.type#">
	and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.refno#">
	and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.itemno#">
	and itemcount=<cfqueryparam cfsqltype="cf_sql_integer" value="#url.itemcount#">
</cfquery>

<cfquery datasource="#dts#" name="getGsetup">
	select xqty1,xqty2,xqty3,xqty4,xqty5,xqty6,xqty7,qtyformula,priceformula from gsetup
</cfquery>

<cfif url.formulatype eq "priceFormula">
	<cfset formula=lcase(getGsetup.priceformula)>
<cfelse>
	<cfset formula=lcase(getGsetup.qtyformula)>
</cfif>

<cfif getictran.recordcount neq 0>
	<cfset qty1=getictran.qty1>
	<cfset qty2=getictran.qty2>
	<cfset qty3=getictran.qty3>
	<cfset qty4=getictran.qty4>
	<cfset qty5=getictran.qty5>
	<cfset qty6=getictran.qty6>
	<cfset qty7=getictran.qty7>
<cfelse>
	<cfset qty1=0>
	<cfset qty2=0>
	<cfset qty3=0>
	<cfset qty4=0>
	<cfset qty5=0>
	<cfset qty6=0>
	<cfset qty7=0>
</cfif>

<cfif url.qty1 neq 0>
	<cfset qty1=url.qty1>
</cfif>

<cfif url.qty2 neq 0>
	<cfset qty2=url.qty2>
</cfif>

<cfif url.qty3 neq 0>
	<cfset qty3=url.qty3>
</cfif>

<cfif url.qty4 neq 0>
	<cfset qty4=url.qty4>
</cfif>

<cfif url.qty5 neq 0>
	<cfset qty5=url.qty5>
</cfif>

<cfif url.qty6 neq 0>
	<cfset qty6=url.qty6>
</cfif>

<cfif url.qty7 neq 0>
	<cfset qty7=url.qty7>
</cfif>

<html>
<head>
	<title>FORMULA</title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		<cfoutput>
			var fixnum=#getgsetup2.Decl_UPrice1#;
		</cfoutput>
		
		function UpdateFormula(){			
			var formula=document.getElementById("formula").value;
			var qty1=document.getElementById("qty1").value;
			var qty2=document.getElementById("qty2").value;
			var qty3=document.getElementById("qty3").value;
			var qty4=document.getElementById("qty4").value;
			var qty5=document.getElementById("qty5").value;
			var qty6=document.getElementById("qty6").value;
			var qty7=document.getElementById("qty7").value;
			formula=formula.replace(/xqty1/g,qty1);
			formula=formula.replace(/xqty2/g,qty2);
			formula=formula.replace(/xqty3/g,qty3);
			formula=formula.replace(/xqty4/g,qty4);
			formula=formula.replace(/xqty5/g,qty5);
			formula=formula.replace(/xqty6/g,qty6);
			formula=formula.replace(/xqty7/g,qty7);
			formula=formula.replace(/round/g,'Math.round');
			if(document.getElementById("formulatype").value=='priceFormula'){
				qty=document.getElementById("qty").value;
				price=eval(formula);
				opener.document.form1.price.value = price;
			}
			else if(document.getElementById("formulatype").value=='qtyFormula'){
				qty=eval(formula);
				price=document.getElementById("price").value;
				opener.document.form1.qty.value = qty;
			}
			opener.document.form1.amt.value = (qty * price).toFixed(fixnum);
			opener.document.form1.qty1.value = qty1;
			opener.document.form1.qty2.value = qty2;
			opener.document.form1.qty3.value = qty3;
			opener.document.form1.qty4.value = qty4;
			opener.document.form1.qty5.value = qty5;
			opener.document.form1.qty6.value = qty6;
			opener.document.form1.qty7.value = qty7;
			
			window.close();
		}
	</script>
</head>

<body> 
<h1 align="center">Determine <cfoutput><cfif url.formulatype eq "priceFormula">Unit Price<cfelseif url.formulatype eq "qtyFormula">Quantity</cfif></cfoutput></h1>
<cfoutput>
<form name="itemform" id="itemform" action="" method="post">
<input type="hidden" id="itemno" name="itemno" value="#convertquote(itemno)#">
<input type="hidden" id="price" name="price" value="#val(url.price)#">
<input type="hidden" id="qty" name="qty" value="#val(url.qty)#">
<input type="hidden" id="formula" name="formula" value="#formula#">
<input type="hidden" id="formulatype" name="formulatype" value="#url.formulatype#">

<table border="0" align="center" width="400px" cellpadding="0" cellspacing="2">
	<cfif FindNoCase('xqty1',formula) neq 0>
		<tr>
			<th>#getGsetup.xqty1#</th>
			<td><input type="text" name="qty1" id="qty1" value="#qty1#"></td>
		</tr>
	<cfelse>
		<input type="hidden" name="qty1" id="qty1" value="#qty1#">
	</cfif>
	<cfif FindNoCase('xqty2',formula) neq 0>
		<tr>
			<th>#getGsetup.xqty2#</th>
			<td><input type="text" name="qty2" id="qty2" value="#qty2#"></td>
		</tr>
	<cfelse>
		<input type="hidden" name="qty2" id="qty2" value="#qty2#">
	</cfif>
	<cfif FindNoCase('xqty3',formula) neq 0>
		<tr>
			<th>#getGsetup.xqty3#</th>
			<td><input type="text" name="qty3" id="qty3" value="#qty3#"></td>
		</tr>
	<cfelse>
		<input type="hidden" name="qty3" id="qty3" value="#qty3#">
	</cfif>
	<cfif FindNoCase('xqty4',formula) neq 0>
		<tr>
			<th>#getGsetup.xqty4#</th>
			<td><input type="text" name="qty4" id="qty4" value="#qty4#"></td>
		</tr>
	<cfelse>
		<input type="hidden" name="qty4" id="qty4" value="#qty4#">
	</cfif>
	<cfif FindNoCase('xqty5',formula) neq 0>
		<tr>
			<th>#getGsetup.xqty5#</th>
			<td><input type="text" name="qty5" id="qty5" value="#qty5#"></td>
		</tr>
	<cfelse>
		<input type="hidden" name="qty5" id="qty5" value="#qty5#">
	</cfif>
	<cfif FindNoCase('xqty6',formula) neq 0>
		<tr>
			<th>#getGsetup.xqty6#</th>
			<td><input type="text" name="qty6" id="qty6" value="#qty6#"></td>
		</tr>
	<cfelse>
		<input type="hidden" name="qty6" id="qty6" value="#qty6#">
	</cfif>
	<cfif FindNoCase('xqty7',formula) neq 0>
		<tr>
			<th>#getGsetup.xqty7#</th>
			<td><input type="text" name="qty7" id="qty7" value="#qty7#"></td>
		</tr>
	<cfelse>
		<input type="hidden" name="qty7" id="qty7" value="#qty7#">
	</cfif>
	<tr><td colspan="100%" align="center" height="10"></td></tr>
	<tr>
		<td colspan="100%" align="center">
			<input type="button" value="Ok" onClick="UpdateFormula();">&nbsp;&nbsp;<input type="button" value="Cancel" onClick="window.close();">
		</td>
	</tr>
</table>
</form>
</cfoutput>
</body>
</html>