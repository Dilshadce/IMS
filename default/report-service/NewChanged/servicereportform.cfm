<cfquery name="getgeneral" datasource="#dts#">
	select filterall,lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lPROJECT,lJOB from gsetup
</cfquery>
<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<html>
<head>
<title><cfoutput>Service</cfoutput>Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../scripts/date_format.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>
<script type="text/javascript">

function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			
									}

// begin: customer search
function getcustomer(type){
	if(type == 'customerto'){
		var inputtext = document.form.searchcustomerto.value;
		DWREngine._execute(_reportflocation, null, 'customerlookup', inputtext, getcustomerResult);
		
	}else{
		var inputtext = document.form.searchcustomerfr.value;
		DWREngine._execute(_reportflocation, null, 'customerlookup', inputtext, getcustomerResult2);
	}
}

function getcustomerResult(customerArray){
	DWRUtil.removeAllOptions("customerto");
	DWRUtil.addOptions("customerto", customerArray,"KEY", "VALUE");
}

function getcustomerResult2(customerArray){
	DWRUtil.removeAllOptions("customerfrom");
	DWRUtil.addOptions("customerfrom", customerArray,"KEY", "VALUE");
}
// end: customer search

// begin: Agent search
function getAgent(type){
	if(type == 'agentfrom'){
		var inputtext = document.form.searchagentfr.value;
		DWREngine._execute(_reportflocation, null, 'agentlookup', inputtext, getagentResult);
	}else{
		var inputtext = document.form.searchagentto.value;
		DWREngine._execute(_reportflocation, null, 'agentlookup', inputtext, getagentResult2);
	}
}

function getagentResult(agentArray){
	DWRUtil.removeAllOptions("agentfrom");
	DWRUtil.addOptions("agentfrom", agentArray,"KEY", "VALUE");
}

function getagentResult2(agentArray){
	DWRUtil.removeAllOptions("agentto");
	DWRUtil.addOptions("agentto", agentArray,"KEY", "VALUE");
}
// end: Agent search

</script>
</head>
<cfquery name="getservice" datasource="#dts#">
	select desp,servi from icservi
	order by servi
</cfquery>
<cfquery name="getitem" datasource="#dts#">
	select desp,itemno from icitem where itemtype='SV'
	order by itemno
</cfquery>
<cfoutput>
  <cfquery name="getcust" datasource="#dts#">
	select * 
	from #target_arcust# 

	order by custno
</cfquery>
</cfoutput>
<cfquery name="getagent" datasource="#dts#">
	select *
	from #target_icagent# 
	order by agent
</cfquery>
<cfoutput></cfoutput>

<body>
<h3> <a href="servicereportmenu.cfm"><cfoutput>Service</cfoutput> Report</a> >> <a><font size="2"><cfoutput>Service Listing Report</cfoutput></font></a> </h3>
<cfset trantype = getgeneral.lPROJECT&" Transaction Listing Report">
<cfform name="form" action="servicereportresult.cfm?type=#url.type#" method="post" target="_blank">
  <table width="65%" border="0" cellspacing="0" cellpadding="3" class="data" align="center">
    <cfoutput>
      <input type="hidden" name="tran" id="tran" value="#target_arcust#" />
      <input type="hidden" name="fromto" id="fromto" value="" />
    </cfoutput>
    <cfif url.type eq "listprojitem">
      <tr>
        <th width="25%">Mark Type to Send</th>
        <td width="75%"><h3><font size="1"><b>* System will consider all the type below if you unclick all of them !</b></font></h3></td>
      </tr>
      <tr>
        <th>Report Format</th>
      </tr>
      <tr>
        <td nowrap colspan="3"><input type="radio" name="result" value="HTML" checked>
          HTML</td>
      </tr>
      <tr>
        <td nowrap colspan="3"><input type="radio" name="result" value="EXCELDEFAULT">
          EXCEL DEFAULT</td>
      </tr>
      <tr>
        <td><input type="checkbox" name="marktype" value="rc">
          'RC' Receive</td>
        <td><input type="checkbox" name="marktype" value="pr">
          'PR' Purchase Return</td>
      </tr>
      <tr>
        <td><input type="checkbox" name="marktype" value="inv" checked>
          'INV' Invoice</td>
        <td><input type="checkbox" name="marktype" value="do">
          'DO' Delivery Order</td>
      </tr>
      <tr>
        <td><input type="checkbox" name="marktype" value="cs">
          'CS' Cash Sale</td>
        <td><input type="checkbox" name="marktype" value="cn">
          'CN' Credit Note</td>
      </tr>
      <tr>
        <td><input type="checkbox" name="marktype" value="dn">
          'DN' Debit Note</td>
        <td><input type="checkbox" name="marktype" value="iss">
          'ISS' Issue</td>
      </tr>
      <tr>
        <td><input type="checkbox" name="marktype" value="oai">
          'OAI' Adjustment Increace</td>
        <td><input type="checkbox" name="marktype" value="oar">
          'OAR' Adjustment Reduce</td>
      </tr>
      <tr>
        <td><input type="checkbox" name="marktype" value="trin,trou">
          'TR' Transfer</td>
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
    </cfif>
    <cfif url.type neq "itemprojiss">
      <tr>
        <th width="25%"><cfoutput>Service Item</cfoutput> From</th>
        <td width="75%"><select name="itemfrom">
            <option value="">Choose a Service Item <cfoutput></cfoutput></option>
            <cfoutput query="getitem">
              <option value="#itemno#">#itemno# - #desp#</option>
            </cfoutput>
          </select></td>
      </tr>
      <tr>
        <th><cfoutput>Service Item</cfoutput> To</th>
        <td><select name="itemto">
            <option value="">Choose a Service Item <cfoutput></cfoutput></option>
            <cfoutput query="getitem">
              <option value="#itemno#">#itemno# - #desp#</option>
            </cfoutput>
          </select></td>
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
      <tr>
        <th width="25%"><cfoutput>Service</cfoutput> From</th>
        <td width="75%"><select name="Servicefrom">
            <option value="">Choose a <cfoutput>Service</cfoutput></option>
            <cfoutput query="getservice">
              <option value="#servi#">#desp# - #servi#</option>
            </cfoutput>
          </select></td>
      </tr>
      <tr>
        <th><cfoutput>service</cfoutput> To</th>
        <td><select name="serviceto">
            <option value="">Choose a <cfoutput>service</cfoutput></option>
            <cfoutput query="getservice">
              <option value="#servi#">#desp# - #servi#</option>
            </cfoutput>
          </select></td>
      </tr>
      <tr>
        <td colspan="100%"><hr></td>
      </tr>
    </cfif>
    <tr>
      <th width="25%">Cust/Supp No From</th>
      <td width="75%"><select name="customerfrom">
          <option value="">Choose a customer</option>
          <cfoutput query="getcust">
            <option value="#convertquote(custno)#">#custno# - #name#</option>
          </cfoutput>
        </select>
        <cfif getgeneral.filterall eq "1">
          <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />
          &nbsp;
          <input type="text" name="searchcustomerfr" onKeyUp="getcustomer('customerfrom');">
        </cfif></td>
    </tr>
    <tr>
      <th>Cust/Supp No To</th>
      <td><select name="customerto">
          <option value="">Choose a customer</option>
          <cfoutput query="getcust">
            <option value="#convertquote(custno)#">#custno# - #name#</option>
          </cfoutput>
        </select>
        <cfif getgeneral.filterall eq "1">
          <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />
          &nbsp;
          <input type="text" name="searchcustomerto" onKeyUp="getcustomer('customerto');">
        </cfif></td>
    </tr>
    <tr>
      <td colspan="100%"><hr></td>
    </tr>
    <tr>
      <th>Agent From</th>
      <td><select name="agentfrom">
          <option value="">Choose a <cfoutput>Agent</cfoutput></option>
          <cfoutput query="getagent">
            <option value="#agent#">#agent# - #desp#</option>
          </cfoutput>
        </select>
        <cfif getgeneral.filterall eq "1">
          <input type="text" name="searchagentfr" onKeyUp="getagent('agentfrom');">
        </cfif></td>
    </tr>
    <tr>
      <th><cfoutput>Agent</cfoutput> To</th>
      <td><select name="agentto">
          <option value="">Choose a <cfoutput>Agent</cfoutput></option>
          <cfoutput query="getagent">
            <option value="#agent#">#agent# - #desp#</option>
          </cfoutput>
        </select>
        <cfif getgeneral.filterall eq "1">
          <input type="text" name="searchagentto" onKeyUp="getagent('agentto');">
        </cfif></td>
    </tr>
    <tr>
      <td colspan="100%"><hr></td>
    </tr>
    <cfoutput>
      <tr>
        <th>Period From</th>
        <td><select name="periodfrom">
            <option value="01" selected>Period 01 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="02">Period 02 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="03">Period 03 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="04">Period 04 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="05">Period 05 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="06">Period 06 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="07">Period 07 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="08">Period 08 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="09">Period 09 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="10">Period 10 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="11">Period 11 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="12">Period 12 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="13">Period 13 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="14">Period 14 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="15">Period 15 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="16">Period 16 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="17">Period 17 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="18">Period 18 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')#</option>
          </select></td>
      </tr>
      <tr>
        <th>Period To</th>
        <td><select name="periodto">
            <option value="01" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 01 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("00"),DE("01")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="02" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 02 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("01"),DE("02")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="03" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 03 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("02"),DE("03")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="04" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 04 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("03"),DE("04")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="05" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 05 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("04"),DE("05")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="06" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 06 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("05"),DE("06")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="07" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 07 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("06"),DE("07")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="08" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 08 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("07"),DE("08")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="09" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 09 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("08"),DE("09")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="10" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 10 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("09"),DE("10")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="11" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 11 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("10"),DE("11")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="12" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 12 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("11"),DE("12")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="13" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 13 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("12"),DE("13")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="14" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 14 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("13"),DE("14")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="15" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 15 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("14"),DE("15")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="16" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 16 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("15"),DE("16")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="17" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 17 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("16"),DE("17")),getgeneral.lastaccyear),'mmm yyyy')#</option>
            <option value="18" #iif((dateformat(now(),'mmm yyyy') eq dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')),DE('selected'),DE(''))#>Period 18 - #dateformat(dateadd('m',iif(year(dateadd("d",1,getgeneral.lastaccyear)) eq year(getgeneral.lastaccyear) and month(dateadd("d",1,getgeneral.lastaccyear)) eq month(getgeneral.lastaccyear),DE("17"),DE("18")),getgeneral.lastaccyear),'mmm yyyy')#</option>
          </select></td>
      </tr>
    </cfoutput>
    <tr>
      <td colspan="100%"><hr></td>
    </tr>
    <tr>
      <th>Date From</th>
      <td><cfinput name="datefrom" type="text" value="" size="11" validate="eurodate" message="Wrong Date format!">
        (DD/MM/YYYY) </td>
    </tr>
    <tr>
      <th>Date To</th>
      <td><cfinput name="dateto" type="text" value="" size="11" validate="eurodate" message="Wrong Date format!">
        (DD/MM/YYYY) </td>
    </tr>
    <tr>
      <td colspan="100%"><hr></td>
    </tr>
    <tr>
      <td colspan="100%"><hr></td>
    </tr>
    <tr>
      <td colspan="100%" align="right"><input type="Submit" name="Submit" value="Submit"></td>
    </tr>
  </table>
</cfform>
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?type={tran}&fromto={fromto}" />
</body>
</html>