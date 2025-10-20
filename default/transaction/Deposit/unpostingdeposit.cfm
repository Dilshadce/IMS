<html>
<head>
<title>Search Deposit</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

	<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
	
	<script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
	<script src="/SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
	<script src="/SpryAssets/SpryValidationSelect.js" type="text/javascript"></script>

</head>

<body>
<h1>Deposit Selection Page</h1>

<cfoutput>
	<h4>
	<cfif getpin2.h1F10 eq 'T'><a href="Deposittable2.cfm?type=Create">Creating A New Deposit</a> </cfif>
	<cfif getpin2.h1F20 eq 'T'>|| <a href="Deposittable.cfm">List All Deposit</a> </cfif>
	<cfif getpin2.h1F30 eq 'T'>|| <a href="s_Deposittable.cfm?type=Deposit">Search For Deposit</a></cfif>
    
    
    <cfif getpin2.h1630 eq 'T'>|| <a href="p_Deposit.cfm">Deposit Listing</a></cfif>

    || <a href="postingdeposit.cfm">Deposit Posting</a>
    || <a href="unpostingdeposit.cfm">Unposting Deposit</a>
	|| <a href="depositimport_to_ams.cfm">Import Posting</a>
	</h4>
    
    <cfif isdefined("url.process")>
		<h1>#form.status#</h1><hr>
  	</cfif>
</cfoutput>
<cfform name="postdepositform" id="postdeposit" action="unpostingdepositprocess.cfm" method="post">
Type : 
    <select name="Sort" id="sort" onChange="ajaxFunction(document.getElementById('ajaxField'),'unpostingdepositfilterajax.cfm?sort='+document.getElementById('sort').value);">
		<option value="-">-</option>
      	<option value="wos_date">Date</option>
      	<option value="fperiod">Period</option>
        <option value="sono">Reference No</option>
        <option value="depositno">Deposit No</option>
    </select>
	
    
    <div id="ajaxField" name="ajaxField">
	
    </div>
    
	<div id="ajaxField2" name="ajaxField2">
	
    </div>
</cfform>
</body>
</html>