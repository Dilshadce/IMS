<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Write Off <cfoutput>#url.type#</cfoutput></title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function checkqty(refno,trancode,currow,writeoff){
	var thisitem = 'thisitem_'+ currow;
	var itemno = document.getElementById(thisitem).value;
	var balqty = document.getElementById('balqty_'+refno+'_'+itemno+'_'+trancode).value;
	if(parseFloat(writeoff) > parseFloat(balqty)){
		alert('Write Off Qty Cannot More than Balance Qty!');
		document.getElementById('writeoff_'+refno+'_'+itemno+'_'+trancode).value = document.getElementById('oldwriteoff_'+refno+'_'+itemno+'_'+trancode).value;
		document.getElementById('writeoff_'+refno+'_'+itemno+'_'+trancode).focus();
	}
}

function onlyNumbers(evt)
{
	var e = event || evt; // for trans-browser compatibility
	var charCode = e.which || e.keyCode;

	if (charCode > 31 && (charCode < 48 || charCode > 57) && (event.keyCode != 46))
		return false;

	return true;

}
</script>
</head>

<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfif form.datefrom neq "" and form.dateto neq "">
		<cfset ndatefrom = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
		<cfset ndateto = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
	</cfif>
</cfif>

<cfquery name="gettranname" datasource="#dts#">
	select lPO,lSO from gsetup
</cfquery>

<cfswitch expression="#url.type#">
	<cfcase value="so">
		<cfset trantype = gettranname.lSO>
		<cfset trancode = "SO">
	</cfcase>
	<cfcase value="po">
		<cfset trantype = gettranname.lPO>
		<cfset trancode = "PO">
	</cfcase>
</cfswitch>
<cfquery name="getinfo" datasource="#dts#">
	select b.desp,a.refno,a.type,a.custno,a.name,a.wos_date,b.itemno,b.qty,b.writeoff,b.shipped,b.trancode 
	from artran a,ictran b 
	where a.refno = b.refno and a.type = b.type and a.type = '#url.type#' 
	and b.shipped < b.qty
	<cfif refnofrom neq "" and refnoto neq "">
		and a.refno >= '#refnofrom#' and a.refno <= '#refnoto#'
	</cfif>
	<cfif datefrom neq "" and dateto neq ""> 
		and a.wos_date >= #ndatefrom# and a.wos_date <= #ndateto#
	</cfif>		
	<cfif trim(productfrom) neq "" and trim(productto) neq ""> 
		and b.itemno >= '#productfrom#' and b.itemno <= '#productto#'
	</cfif>	
	<cfif trim(custfrom) neq "" and trim(custto) neq ""> 
		and a.custno >= '#custfrom#' and a.custno <= '#custto#'
	</cfif>	
	<cfif periodfrom neq "" and periodto neq "">
		and a.fperiod between '#periodfrom#' and '#periodto#'
	</cfif>
	and (b.void='' or b.void is null)
	<cfif isdefined('form.nowriteoff')>
	and b.writeoff < b.qty-b.shipped
	</cfif>
	order by a.refno,b.itemno
</cfquery>
<body>
<cfoutput>
<h1>Write Off #trantype#</h1>
<form name="form" action="writeoffprocess.cfm?type=#url.type#" method="post">
<cfif getinfo.recordcount eq 0>
	<h3>No Record Found.</h3>
</cfif>

<table border="0" align="center" width="65%" class="data">
	<tr>
		<th>Type</th>
		<th>Cust No.</th>
        <th>Cust Name.</th>
		<th>Ref No.</th>
		<th>Date</th>
		<th><cfif hcomid eq 'kjcpl_i' or hcomid eq 'mlpl_i' or lcase(hcomid) eq "kjctrial_i">Item Description<cfelse>Item No.</cfif></th>
		<th><div align="center">Qty</div></th>
		<th><div align="center"><cfif url.type eq "SO">Delivered<cfelse>Receive</cfif></div></th>
		<th><div align="center">Write Off Qty</div></th>
	</tr>
	
	<cfloop query="getinfo">
		<input type="hidden" id="thisitem_#getinfo.currentrow#" value="#convertquote(getinfo.itemno)#">
		<input type="hidden" name="idlist" value=";#getinfo.refno#;#convertquote(getinfo.itemno)#;#getinfo.trancode#">
		<cfset balqty = val(getinfo.qty) - val(getinfo.shipped)>
		<input type="hidden" name="balqty_#getinfo.refno#_#convertquote(getinfo.itemno)#_#getinfo.trancode#" id="balqty_#getinfo.refno#_#convertquote(getinfo.itemno)#_#getinfo.trancode#" value="#balqty#">
		<input type="hidden" name="oldwriteoff_#getinfo.refno#_#convertquote(getinfo.itemno)#_#getinfo.trancode#" id="oldwriteoff_#getinfo.refno#_#convertquote(getinfo.itemno)#_#getinfo.trancode#" value="#getinfo.writeoff#">
	<tr>
		<td>#getinfo.type#</td>
		<td>#getinfo.custno#</td>
        <td>#getinfo.name#</td>
		<td>#getinfo.refno#</td>
		<td>#dateformat(getinfo.wos_date,"dd/mm/yyyy")#</td>
		<td><cfif hcomid eq 'kjcpl_i' or hcomid eq 'mlpl_i' or lcase(hcomid) eq "kjctrial_i">#getinfo.desp#<cfelse>#getinfo.itemno#</cfif></td>
		<td><div align="center">#getinfo.qty#</div></td>
		<td><div align="center">#getinfo.shipped#</div></td>
		<td><div align="center">
			<input type="text" name="writeoff_#getinfo.refno#_#getinfo.trancode#" id="writeoff_#getinfo.refno#_#convertquote(getinfo.itemno)#_#getinfo.trancode#"
					value="#getinfo.writeoff#" size="10" onBlur="checkqty('#getinfo.refno#','#getinfo.trancode#',#getinfo.currentrow#,this.value);"  onkeypress="return onlyNumbers();">
		</div></td>
	</tr>
	</cfloop>
	<tr><td colspan="100%"><hr></td></tr>
	<tr>
		<td colspan="100%" align="center">
			<cfif getinfo.recordcount neq 0>
				<input type="submit" value="Save">
			</cfif>
			<input type="button" value="Exit" onClick="javascript:history.back();">
		</td>
	</tr>
</table>
</form>
</cfoutput>
</body>
</html>