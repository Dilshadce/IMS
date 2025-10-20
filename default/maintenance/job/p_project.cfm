<cfquery datasource="#dts#" name="getgeneral">
	Select ljob as layer from gsetup
</cfquery>
<html>
<head>
<title><cfoutput>#getgeneral.layer#</cfoutput> Listing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>

</head>

<script language="JavaScript">
<!--- 	document.form.Tick.value = toString(val(document.form.Tick.value)+1); --->
		<cfset counter=2>
function Tickcreditsales()	{
  if(document.form.cbcreditsales.checked) {
    if(eval(document.form.Tick.value)<=(eval(document.form.counter.value)-1)){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 7 Fields.");
	  document.form.cbcreditsales.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickcashsales()	{
  if(document.form.cbcashsales.checked) {
    if(eval(document.form.Tick.value)<=(eval(document.form.counter.value)-1)){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 7 Fields.");
	  document.form.cbcashsales.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Ticksalesreturn()	{
  if(document.form.salesreturn.checked) {
    if(eval(document.form.Tick.value)<=(eval(document.form.counter.value)-1)){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 7 Fields.");
	  document.form.salesreturn.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function Tickpurchase()	{
  if(document.form.cbpurchase.checked) {
    if(eval(document.form.Tick.value)<=(eval(document.form.counter.value)-1)){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 7 Fields.");
	  document.form.cbpurchase.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}


function Tickpurchasereturn()	{
  if(document.form.cbpurchasereturn.checked) {
    if(eval(document.form.Tick.value)<=(eval(document.form.counter.value)-1)){
	  document.form.Tick.value = eval(document.form.Tick.value) + 1;
	}
	else{
	  alert("You Are Over 7 Fields.");
	  document.form.cbpurchasereturn.checked = false;
	}
  }
  else {
	document.form.Tick.value = eval(document.form.Tick.value) - 1;
  }
  return true;
}

function ClearAll()	{
  document.form.Tick.value = "-5";
  document.form.cbcreditsales.checked = false;
  document.form.cbcashsales.checked = false;
  document.form.cbsalesreturn.checked = false;
  document.form.cbpurchase.checked = false;
  document.form.cbpurchasereturn.checked = false;
  
  return true;
}


</script>

<body>
<cfquery name="getgroup" datasource="#dts#">
  select * FROM #target_project# where porj ="J" order by source
</cfquery>

  <h1 align="center"><cfoutput>Job Listing Report</cfoutput></h1>
<cfoutput>
    <h4 align = "center">
		<cfif getpin2.h1H10 eq 'T'><a href="Projecttable2.cfm?type=Create">Creating a #getgeneral.layer#</a> </cfif>
		<cfif getpin2.h1H20 eq 'T'>|| <a href="Projecttable.cfm?">List all #getgeneral.layer#</a> </cfif>
		<cfif getpin2.h1H30 eq 'T'>|| <a href="s_Projecttable.cfm?type=project">Search For #getgeneral.layer#</a></cfif>||<a href="p_project.cfm">#getgeneral.layer# Listing report</a>
  </h4>
  </cfoutput>

<cfform action="l_project.cfm" name="form" method="post" target="_blank">
  	<input type="hidden" name="Tick" value="0">

	<cfoutput><input type="hidden" name="counter" id="counter" value="#counter#"></cfoutput>
  <table border="0" align="center" width="90%" class="data">
    <tr> 
      <th width="15%"><cfoutput>#getgeneral.layer#</cfoutput></th>
      <td width="7%"> <div align="center">From</div></td>
      <td width="67%"><select name="groupfrom">
          <option value=""><cfoutput>Choose a #getgeneral.layer#</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#source#">#source# - #project# </option>
          </cfoutput> </select></td>
    </tr>
    <tr>
      <th height="24" width="15%"><cfoutput>#getgeneral.layer#</cfoutput></th>
      <td width="7%"><div align="center">To</div></td>
      <td width="67%" nowrap> <select name="groupto">
          <option value=""><cfoutput>Choose a #getgeneral.layer#</cfoutput></option>
          <cfoutput query="getgroup">
            <option value="#source#">#source# - #project#</option>
          </cfoutput> </select> </td>
	  <td width="11%"></td>
    </tr>

    <tr> 
      <td colspan="8">&nbsp;</td>
    </tr>


    <tr> 
      <td colspan="8">&nbsp;</td>
    </tr>
   
   
    <tr> 
<td></td>
<td></td>
      <td width="67%"><div align="right"> 
          <input type="Submit" name="Submit" value="Submit">
        </div></td>
    </tr>
  </table>
</cfform>
</body>
</html>
