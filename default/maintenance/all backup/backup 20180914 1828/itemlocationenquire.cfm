<html>
<head>
<title>Product Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script type='text/javascript' src='/ajax/core/shortcut.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
<!--- 	document.form.Tick.value = toString(val(document.form.Tick.value)+1); --->

function selectlist(custno,fieldtype){

            document.getElementById(fieldtype).value=custno;
			
			ajaxFunction(document.getElementById('itemajax'),'/default/maintenance/itemlocationenquireajax.cfm?itemno='+escape(document.getElementById('productfrom').value));
			
			}
</script>

</head>

<cfquery name="getGsetup" datasource="#dts#">
  Select lLOCATION from GSetup
</cfquery>

<body>
<h1 align="center"><cfoutput>#getGsetup.lLOCATION# Listing</cfoutput></h1>
  <cfoutput>
    <h4>
    <cfif getpin2.h1D10 eq 'T'><a href="locationtable2.cfm?type=Create">Creating a New #getGsetup.lLOCATION#</a> </cfif>
	<cfif getpin2.h1D20 eq 'T'>|| <a href="locationtable.cfm">List All #getGsetup.lLOCATION#</a> </cfif>
	<cfif getpin2.h1D30 eq 'T'>|| <a href="s_locationtable.cfm?type=Icitem">Search For #getGsetup.lLOCATION#</a></cfif>
    
     <cfif getpin2.h1630 eq 'T'>|| <a href="p_location.cfm"> #getGsetup.lLOCATION# Listing</a></cfif>
     <cfif getpin2.h1630 eq 'T'>|| <a href="itemlocationenquire.cfm">Item #getGsetup.lLOCATION# Balance Listing</a></cfif>
  </h4>
  </cfoutput>

  <table border="0" align="center" width="90%" class="data">
  <tr>
  <th>Item No</th>
  <td><input type="text" name="productfrom" id="productfrom" value="" onKeyUp="ajaxFunction(document.getElementById('itemajax'),'/default/maintenance/itemlocationenquireajax.cfm?itemno='+document.getElementById('productfrom').value);"><input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('searchitem');" /></td>
  </tr>  
  </table>
  <div id="itemajax">
  <table border="0" align="center" width="90%" class="data">
  <tr>
  <th width="30">Location</th>
  <td>
  </td>
  </tr>
  <tr>
  <th>Qty</th>
  <td></td>
  
  </tr>
  </table>
  </div>
</body>
</html>

<cfwindow center="true" width="1000" height="600" name="searchitem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="tcdssearchitem.cfm?type=Product&fromto=from&itemno={productfrom}" />
