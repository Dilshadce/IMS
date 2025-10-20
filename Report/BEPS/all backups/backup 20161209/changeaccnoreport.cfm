<cfset dts2=replace(dts,'_i','','all')>
    <cfquery name="getmonth" datasource="payroll_main">
    SELECT myear,mmonth FROM gsetup WHERE comp_id = "#dts2#"
    </cfquery> 
    <cfif getmonth.mmonth eq "13">
    <cfset getmonth.mmonth = "12">
	</cfif>
    <cfset startdate =  dateformat(createdate(val(getmonth.myear),val(getmonth.mmonth),1),'DD/MM/YYYY')>
    <cfset completedate = dateformat(dateadd('m',1,createdate(val(getmonth.myear),val(getmonth.mmonth),daysinmonth(createdate(val(getmonth.myear),val(getmonth.mmonth),1)))),'DD/MM/YYYY')>
<html>
<head>
<title>View Assignment Slip Report</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>

<script type="text/javascript">

function searchSel(fieldid,textid) {
  var input=document.getElementById(textid).value.toLowerCase();
  var output=document.getElementById(fieldid).options;
  for(var i=0;i<output.length;i++) {
    if(output[i].text.toLowerCase().indexOf(input)>=0 && i != 0){
      output[i].selected=true;
	  break;
      }
    if(document.getElementById(textid).value==''){
      output[0].selected=true;
      }
  }
}

function selectlist(custno,fieldtype){

			for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) 
			{
        	if (custno==document.getElementById(fieldtype).options[idx].value) 
			{
            document.getElementById(fieldtype).options[idx].selected=true;
        	}
    		} 
			
									}
// begin: supplier search
function getSupp(type,option){
	if(type == 'getfrom'){
		var inputtext = document.form123.searchsuppfr.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult);
		
	}
	else{
		var inputtext = document.form123.searchsuppto.value;
		DWREngine._execute(_reportflocation, null, 'supplierlookup', inputtext, option, getSuppResult2);
	}
}

function getSuppResult(suppArray){
	DWRUtil.removeAllOptions("getfrom");
	DWRUtil.addOptions("getfrom", suppArray,"KEY", "VALUE");
}

function getSuppResult2(suppArray){
	DWRUtil.removeAllOptions("getto");
	DWRUtil.addOptions("getto", suppArray,"KEY", "VALUE");
}
// end: supplier search

// begin: group search
function getGroup(type){
	if(type == 'groupfrom'){
		var inputtext = document.form123.searchgroupfr.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult);
		
	}
	else{
		var inputtext = document.form123.searchgroupto.value;
		DWREngine._execute(_reportflocation, null, 'grouplookup', inputtext, getGroupResult2);
	}
}

function getGroupResult(groupArray){
	DWRUtil.removeAllOptions("groupfrom");
	DWRUtil.addOptions("groupfrom", groupArray,"KEY", "VALUE");
}

function getGroupResult2(groupArray){
	DWRUtil.removeAllOptions("groupto");
	DWRUtil.addOptions("groupto", groupArray,"KEY", "VALUE");
}
// end: group search

</script>

</head>
<cfparam name="alown" default="0">

	<cfif getpin2.h4700 eq 'T'>
  		<cfset alown = 1>
  	</cfif>
        


<body>
<cfform action="changeaccnoprocess.cfm" method="post" name="form123" target="_blank">

<!--- <h2>Print <cfoutput>#trantype#</cfoutput> Listing Report</h2> --->
<cfoutput>
<h3>
	<a><font size="2">Change Bank Information Report</font></a>
</h3>


<br><br>

<table border="0" align="center" width="80%" class="data">
   
    <tr>
      	<th width="16%">Changes Date</th>
      	<td width="5%"> <div align="center">From</div></td>
      	<td colspan="2"><cfinput type="text" name="datefrom" id="datefrom" maxlength="10" validate="eurodate" size="10" required="yes" message="Date From is Required" value="#startdate#"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('datefrom'));">(DD/MM/YYYY)</td>
    </tr>
    <tr>
      	<th width="16%">Changes Date</th>
      	<td width="5%"> <div align="center">To</div></td>
      	<td width="69%"><cfinput type="text" name="dateto" id="dateto" maxlength="10" validate="eurodate" size="10" required="yes" message="Date To is Required" value="#completedate#"><img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('dateto'));">(DD/MM/YYYY)&nbsp;</td>
      	
    </tr>
     <tr>
      	<td colspan="5"><hr></td>
    </tr>
    
    <td colspan="3">
    </td>
    <td width="10%"><input type="Submit" name="Submit" value="Submit"></td>
    </tr>
</table>
</cfoutput>
</cfform>
</body>
</html>