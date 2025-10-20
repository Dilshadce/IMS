<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title>Calculate Cost Menu</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>
<script type="text/javascript" src="/scripts/prototypenew.js" ></script>
<script type="text/javascript">
function trim(strval)
	{
	return strval.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	}
	
function getItemNew(divid,itemno,filterby,filteron)
{
	if(trim(document.getElementById(filterby).value) !='')
	{
	var ajaxurl = '/object/act_getitem.cfm?new=1&itemno='+itemno+'&searchtype='+document.getElementById(filteron).value+ '&text=' + escape(encodeURI(document.getElementById(filterby).value));
		 new Ajax.Request(ajaxurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById(divid).innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Found!'); },		
		onComplete: function(transport){
			try{
			showImage(document.getElementById(itemno).value);
			}
			catch(err)
			{
			}
        }
      })	  
	}
}


// begin: product search
function getProduct(type){
	if(type == 'itemto'){
		var inputtext = document.form.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.form.searchitemfr.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult2);
	}
}

function getProductResult(itemArray){
	DWRUtil.removeAllOptions("itemto");
	DWRUtil.addOptions("itemto", itemArray,"KEY", "VALUE");
}

function getProductResult2(itemArray){
	DWRUtil.removeAllOptions("itemfrom");
	DWRUtil.addOptions("itemfrom", itemArray,"KEY", "VALUE");
}
// end: product search

</script>

</head>

<body>
<cfoutput>
<cfif isdefined("url.type") and url.type eq "fixed">
	<cfset costtype = "Fixed Cost Method">
<cfelseif isdefined("url.type") and url.type eq "month">
	<cfset costtype = "Month Average Method">
<cfelseif isdefined("url.type") and url.type eq "moving">
	<cfset costtype = "Moving Average Method">
<cfelseif isdefined("url.type") and url.type eq "fifo">
	<cfset costtype = "First In First Out Method">
<cfelseif isdefined("url.type") and url.type eq "lifo">
	<cfset costtype = "Last In First Out Method">
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select filterall,filteritemreport,ddlitem from gsetup
</cfquery>
<!--- Add On 15-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy from dealer_menu limit 1
</cfquery>

<!--- <cfquery name="getitem" datasource="#dts#">
	select itemno, desp from icitem order by itemno
</cfquery> --->
<cfquery name="getitem" datasource="#dts#">
	select itemno, desp from icitem order by <cfif getdealer_menu.productSortBy neq "">#getdealer_menu.productSortBy#<cfelse>itemno</cfif>
</cfquery>

<!--- <h2 align="center">Calculate Cost of #costtype# </h2> --->
<h3>
	<a href="salesmenu.cfm">Sales Report Menu</a> >> 
	<a><font size="2">Calculate Cost of #costtype#</font></a>
</h3>
<br><br>* Please Select Some Items

<form name="form" action="calculatecost.cfm?type=#url.type#" method="post" target="_blank">
<table width="75%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
<tr>
		<th>Report Format<input type="hidden" name="tran" id="tran" value="#target_arcust#" /><input type="hidden" name="fromto" id="fromto" value="" /></th>
          <td><input type="radio" name="result" value="HTML" checked>HTML<br/>
        <input type="radio" name="result" value="EXCELDEFAULT">EXCEL DEFAULT</td>
	</tr>
	<tr> 
    	<th>Item No From</th>
        <td>
        <cfif getgeneral.filteritemreport eq "1">
        <div id="getitemnew" style="display:inline">
				<select id="itemfrom" name='itemfrom'>
					<option value='-1'>Please Filter The Item</option>
				</select></div> Filter by:
				<input id="letter" name="letter" type="text" size="8" onKeyup="getItemNew('getitemnew','itemfrom','letter','searchtype');"> in:
             
				<select id="searchtype" name="searchtype" onChange="getItemNew('getitemnew','itemfrom','letter','searchtype');">
                    <cfloop list="itemno,aitemno,desp,despa,category,wos_group,brand" index="i">
                <cfif #i# eq "itemno">
                <cfset sitemdesp ="Item No">
                <cfelseif #i# eq "aitemno">
                <cfset sitemdesp ="Product Code">
                <cfelseif #i# eq "desp">
                <cfset sitemdesp ="Description">
                <cfelseif i eq "despa">
                <cfset sitemdesp ="Description 2">
                <cfelseif #i# eq "category">
                <cfset sitemdesp ="Category">
                <cfelseif #i# eq "wos_group">
                <cfset sitemdesp ="Group">
                <cfelseif #i# eq "brand">
                <cfset sitemdesp ="Brand">
                </cfif>
                <option value="#i#" <cfif #sitemdesp# eq #getgeneral.ddlitem#>selected</cfif>>#sitemdesp#</option>
                </cfloop>
				</select>
        <cfelse>       
        <select name="itemfrom" id="itemfrom">
			<option value="">Choose an Item</option>
			<cfloop query="getitem">
			<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
			</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchitemfr" id="searchitemfr" onKeyUp="getProduct('itemfrom');">
			</cfif>
			</cfif>
		</td>
	</tr>
	<tr><td><br></td></tr>
    <tr> 
        <th>Item No To</th>
        <td>
           <cfif getgeneral.filteritemreport eq "1">
        <div id="getitemnew2" style="display:inline">
				<select id="itemto" name='itemto'>
					<option value='-1'>Please Filter The Item</option>
				</select></div> Filter by:
				<input id="letter2" name="letter2" type="text" size="8" onKeyup="getItemNew('getitemnew2','itemto','letter2','searchtype2');"> in:
             
				<select id="searchtype2" name="searchtype2" onChange="getItemNew('getitemnew2','itemto','letter2','searchtype2');">
                    <cfloop list="itemno,aitemno,desp,despa,category,wos_group,brand" index="i">
                <cfif #i# eq "itemno">
                <cfset sitemdesp ="Item No">
                <cfelseif #i# eq "aitemno">
                <cfset sitemdesp ="Product Code">
                <cfelseif #i# eq "desp">
                <cfset sitemdesp ="Description">
                <cfelseif i eq "despa">
                <cfset sitemdesp ="Description 2">
                <cfelseif #i# eq "category">
                <cfset sitemdesp ="Category">
                <cfelseif #i# eq "wos_group">
                <cfset sitemdesp ="Group">
                <cfelseif #i# eq "brand">
                <cfset sitemdesp ="Brand">
                </cfif>
                <option value="#i#" <cfif #sitemdesp# eq #getgeneral.ddlitem#>selected</cfif>>#sitemdesp#</option>
                </cfloop>
				</select>
        <cfelse>
        <select name="itemto" id="itemto">
				<option value="">Choose an Item</option>
				<cfloop query="getitem">
					<option value="#convertquote(itemno)#">#itemno# - #desp#</option>
				</cfloop>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchitemto" id="searchitemto" onKeyUp="getProduct('itemto');">
			</cfif>
            </cfif>
		</td>
     </tr>
     <cfif isdefined("url.type") and url.type eq "fifo">
     <tr>
     <td>&nbsp;</td>
     </tr>
     <tr>
     <td></td>
     <td>Tick to include Misc Charges<input type="checkbox" name="cbincludecharge" id="cbincludecharge" value="1"></td>
     </tr>
     </cfif>
	 <tr> 
        <td colspan="2" align="right"><input type="submit" name="Submit" value="Submit"></td>
     </tr>
    </table>
</form>
</cfoutput>
</body>
</html>