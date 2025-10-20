<html>
<head>
<title>View Bill Listing Report</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type='text/javascript' src='../../ajax/core/engine.js'></script>
<script type='text/javascript' src='../../ajax/core/util.js'></script>
<script type='text/javascript' src='../../ajax/core/settings.js'></script>

<OBJECT CLASSID="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83" ID="feedcontact1" WIDTH="0" HEIGHT="0">
<PARAM NAME="FieldDelim" VALUE="|"><PARAM NAME="UseHeader" VALUE="True"></OBJECT>
<script for="feedcontact1" event="ondatasetcomplete">show_info(this.recordset);</script>
<OBJECT CLASSID="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83" ID="feedcontact2" WIDTH="0" HEIGHT="0">
<PARAM NAME="FieldDelim" VALUE="|"><PARAM NAME="UseHeader" VALUE="True"></OBJECT>
<script for="feedcontact2" event="ondatasetcomplete">show_info1(this.recordset);</script>


<script type="text/javascript">

function selectlist(custno,fieldtype){
	for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++) {
		if (custno==document.getElementById(fieldtype).options[idx].value) {
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

function getProduct(type){
	if(type == 'itemto'){
		var inputtext = document.form123.searchitemto.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
		
	}else{
		var inputtext = document.form123.searchitemfr.value;
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

function show_info(rset){
		rset.MoveFirst();
		DWRUtil.removeAllOptions("itemfrom");
		newArray = unescape(rset.fields("itemnolist").value);
		var itemnoArray = newArray.split(";;");
		newArray2 = unescape(rset.fields("itemdesclist").value);
		var itemdescArray = newArray2.split(";;");
		
		for(i=0;i<itemnoArray.length;i++){
			
			myoption = document.createElement("OPTION");
			if(itemnoArray[i] == '-1'){
				myoption.text = itemdescArray[i];
			}else{
				myoption.text = itemnoArray[i] + " - " + itemdescArray[i];
			}
			
			myoption.value = itemnoArray[i];
			document.form123.itemfrom.options.add(myoption);
		}
		
	}
	
		function show_info1(rset){
		rset.MoveFirst();
		DWRUtil.removeAllOptions("itemto");
		newArray = unescape(rset.fields("itemnolist").value);
		var itemnoArray = newArray.split(";;");
		newArray2 = unescape(rset.fields("itemdesclist").value);
		var itemdescArray = newArray2.split(";;");
		
		for(i=0;i<itemnoArray.length;i++){
			
			myoption = document.createElement("OPTION");
			if(itemnoArray[i] == '-1'){
				myoption.text = itemdescArray[i];
			}else{
				myoption.text = itemnoArray[i] + " - " + itemdescArray[i];
			}
			
			myoption.value = itemnoArray[i];
			document.form123.itemto.options.add(myoption);
		}
		
	}


function getItem(){
		var text = document.form123.letter.value;
		var w = document.form123.searchtype.selectedIndex;
		var searchtype = document.form123.searchtype.options[w].value;
		if(text != ''){

			document.all.feedcontact1.dataurl="databind/act_getitem.cfm?searchtype=" + searchtype + "&text=" + text;
			//prompt("D",document.all.feedcontact1.dataurl);
			document.all.feedcontact1.charset=document.charset;
			document.all.feedcontact1.reset();

		}
	}
function getItem1(){
		
		var text = document.form123.letter1.value;
		var w = document.form123.searchtype1.selectedIndex;
		var searchtype = document.form123.searchtype1.options[w].value;
		if(text != ''){
			document.all.feedcontact2.dataurl="databind/act_getitem.cfm?searchtype=" + searchtype + "&text=" + text;
			//prompt("D",document.all.feedcontact1.dataurl);
			document.all.feedcontact2.charset=document.charset;
			document.all.feedcontact2.reset();
		}
	}

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
        
<cfquery name="getgeneral" datasource="#dts#">
	select * from gsetup
</cfquery>
<!--- Add On 12-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,custformat from dealer_menu limit 1
</cfquery>

<cfquery name="getitem" datasource="#dts#">
	select itemno, desp from icitem order by itemno
</cfquery>
<cfquery name="getgroup" datasource="#dts#">
	select wos_group, desp from icgroup order by wos_group
</cfquery>

<cfset consignment=''>

<cfswitch expression="#url.type#">
	<cfcase value="1">
		<cfset trantype = "Purchase Receive">
		<cfset trancode = "RC">
        
	</cfcase>
	<cfcase value="2">
		<cfset trantype = "Purchase Return">
		<cfset trancode = "PR">
        
	</cfcase>
	<cfcase value="3">
		<cfset trantype = "Delivery Order">
		<cfset trancode = "DO">
        
	</cfcase>
	<cfcase value="4">
		<cfset trantype = "Invoice">
		<cfset trancode = "INV">
        
	</cfcase>
	<cfcase value="5">
		<cfset trantype = "Credit Note">
		<cfset trancode = "CN">
        
	</cfcase>
	<cfcase value="6">
		<cfset trantype = "Debit Note">
		<cfset trancode = "DN">
       
	</cfcase>
	<cfcase value="7">
		<cfset trantype = "Cash Sales">
		<cfset trancode = "CS">
        
	</cfcase>
	<cfcase value="8">
		<cfset trantype = "Purchase Order">
		<cfset trancode = "PO">
       
	</cfcase>
	<cfcase value="9">
		<cfset trantype = "Quotation">
		<cfset trancode = "QUO">
        
	</cfcase>
	<cfcase value="10">
		<cfset trantype = "Sales Order">
		<cfset trancode = "SO">
        
	</cfcase>
	<cfcase value="11">
		<cfset trantype = "Sample">
		<cfset trancode = "SAM">
        
	</cfcase>
	<cfcase value="12">
		<cfset trantype = "Issue">
		<cfset trancode = "ISS">
	</cfcase>
	<cfcase value="13">
		<cfset trantype = "Adjustment Increase">
		<cfset trancode = "OAI">
	</cfcase>
	<cfcase value="14">
		<cfset trantype = "Adjustment Reduce">
		<cfset trancode = "OAR">
	</cfcase>
	<cfcase value="15">
		<cfset trantype = "Transfer Note">
		<cfset trancode = "TR">
	</cfcase>
    <cfcase value="16">
		<cfset trantype = "Consignment Return">
		<cfset trancode = "TR">
        <cfset consignment='return'>
	</cfcase>
    <cfcase value="17">
		<cfset trantype = "Consignment Out">
		<cfset trancode = "TR">
        <cfset consignment='out'>
	</cfcase>
    
</cfswitch>

<cfif trancode eq "INV" or trancode eq "CN" or trancode eq "DN" or trancode eq "CS" or trancode eq "QUO" or trancode eq "SO" or trancode eq "DO" or trancode eq "SAM" or trancode eq "TR" or trancode eq "ISS">

	<cfquery datasource="#dts#" name="getsupp">
		select custno,name from #target_arcust# order by <cfif getdealer_menu.custSuppSortBy neq "">#getdealer_menu.custSuppSortBy#<cfelse>custno</cfif>
	</cfquery>
	<cfset title = "Customer">

<cfelse>

	<cfquery datasource="#dts#" name="getsupp">
		select custno,name from #target_apvend# order by <cfif getdealer_menu.custSuppSortBy neq "">#getdealer_menu.custSuppSortBy#<cfelse>custno</cfif>
	</cfquery>
	<cfset title = "Supplier">
</cfif>

<cfif lcase(hcomid) eq "mhca_i">
	<cfquery datasource="#dts#" name="getbill">
		select refno from artran where type = '#trancode#' and fperiod <> '99'order by refno
	</cfquery>
</cfif>

<cfquery datasource="#dts#" name="getagent">
	select agent,desp from icagent
    where 0=0
    <cfif alown eq 1>
			<cfif getgeneral.agentlistuserid eq "Y">and ucase(agent) in (SELECT agent FROM icagent WHERE agentlist like "%#ucase(huserid)#%")
			<cfelse>
            and (ucase(agent)='#ucase(huserid)#')  
			</cfif>
		<cfelse>
			
		</cfif>
    order by agent
</cfquery>

<cfif getpin2.h4700 eq 'T' and HUserGrpID neq 'Super'>
	<cfquery name="getlocation" datasource="#dts#">
		select location,desp 
		from iclocation 
        <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
        <cfelse>
		<cfif Huserloc neq "All_loc">
			where location in (#ListQualify(Huserloc,"'",",")#)
		</cfif>
        </cfif>
		order by location
	</cfquery>
<cfelse>
	<cfquery name="getlocation" datasource="#dts#">
		select 
		location,
		desp 
		from iclocation 
		order by location
	</cfquery>
</cfif>

<cfquery name="getproject" datasource="#dts#">
		select source,project 
        from #target_project# 
        WHERE PORJ = "P"
        <cfif lcase(HcomID) eq "mphcranes_i">
            order by project
        <cfelse> 
            order by source
        </cfif>
	</cfquery>
    
<cfquery name="getjob" datasource="#dts#">
		select source,project 
        from #target_project# 
        WHERE PORJ = "J" 
		<cfif lcase(HcomID) eq "mphcranes_i">
            order by project
        <cfelse> 
            order by source
        </cfif>
	</cfquery>

<cfquery datasource="#dts#" name="getuser">
	select * from driver 
</cfquery>

<cfquery datasource="main" name="getuserid">
	select * from users where userbranch='#dts#'
</cfquery>

<cfquery datasource="#dts#" name="getaddress">
	select * from address order by code
</cfquery>
<cfquery datasource="#dts#" name="getmodule">
	select * from modulecontrol
</cfquery>
<body>
<cfform action="bill_listingreport1.cfm?type=#trantype#&trancode=#trancode#&alown=#alown#&consignment=#consignment#" method="post" name="form123" target="_blank">

<!--- <h2>Print <cfoutput>#trantype#</cfoutput> Listing Report</h2> --->
<h3>
	<a href="bill_listingmenu.cfm">Bill Listing Menu</a> >> 
	<a><font size="2">Print <cfoutput>#trantype#</cfoutput> Listing Report</font></a>
</h3>

<br><br>

<table border="0" align="center" width="80%" class="data">
<cfoutput>
<cfif trancode eq "INV" or trancode eq "CN" or trancode eq "DN" or trancode eq "CS" or trancode eq "QUO" or trancode eq "SO" or trancode eq "DO">
<input type="hidden" name="tran" id="tran" value="#target_arcust#" />
<cfelse>
<input type="hidden" name="tran" id="tran" value="#target_apvend#" />
</cfif>
</cfoutput>
<input type="hidden" name="fromto" id="fromto" value="" />
	<cfoutput><input type="hidden" name="title" id="title" value="#title#"></cfoutput>
	<tr>
		<th>Report Format</th>
		<td colspan="3">
			<input type="radio" name="result" id="result" value="HTML" checked>HTML<br/>
			<input type="radio" name="result" id="result" value="EXCELDEFAULT">EXCEL DEFAULT<br/>
            <input type="radio" name="result" id="result" value="PDF">PDF
		</td>
	</tr>
	 <tr> 
        <td colspan="5"><hr></td>
    </tr>
    <cfif lcase(hcomid) eq "mhca_i">
	<tr>
      	<th>Ref No</th>
      	<td><div align="center">From</div></td>
      	<td colspan="2">
        	<select name="billfrom" id="billfrom">
          		<option value="">Select a ref no</option>
          		<cfoutput query="getbill">
            		<option value="#refno#">#refno#</option>
          		</cfoutput>
			</select>
        </td>
    </tr>
    <tr>
      	<th>Ref No</th>
      	<td><div align="center">To</div></td>
      	<td colspan="2"><select name="billto" id="billto">
          		<option value="">Select a ref no</option>
          		<cfoutput query="getbill">
            		<option value="#refno#">#refno#</option>
          		</cfoutput>
			</select></td>
    </tr>
	<cfelse>
	   <tr>
      	<th>Ref No</th>
      	<td><div align="center">From</div></td>
      	<td colspan="2"><input type="text" name="billfrom" id="billfrom" maxlength="24"></td>
    </tr>
    <tr>
      	<th>Ref No</th>
      	<td><div align="center">To</div></td>
      	<td colspan="2"><input type="text" name="billto" id="billto" maxlength="24"></td>
    </tr>
	</cfif>
	<cfif url.type eq "7" and lcase(Hcomid) eq "ovas_i">
		<tr>
			<th>Ref No Prefix</th>
			<td></td>
      		<td colspan="2"><input type="text" name="refnoprefix" id="refnoprefix"></td>
		</tr>
	</cfif>
    <cfif lcase(Hcomid) neq "sdc_i">
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
    <th>Show Refno 2</th>
    <td></td>
    <td><input type="checkbox" name="checkbox1" id="checkbox1"></td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
    <th>Show Status</th>
    <td></td>
    <td><input type="checkbox" name="checkbox2" id="checkbox2"></td>
    </tr>
    
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
    <th>Show PO/SO NO</th>
    <td></td>
    <td><input type="checkbox" name="checkbox3" id="checkbox3"></td>
    </tr>
      <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
    <th>Show SO NO</th>
    <td></td>
    <td><input type="checkbox" name="cbso" id="cbso"></td>
    </tr>
      <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
    <th>Show Project NO</th>
    <td></td>
    <td><input type="checkbox" name="cbproject" id="cbproject"></td>
    </tr>
      <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
    <th>Show Job NO</th>
    <td></td>
    <td><input type="checkbox" name="cbjob" id="cbjob"></td>
    </tr>
      <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
    <th>Show GST Code</th>
    <td></td>
    <td><input type="checkbox" name="cbgst" id="cbgst"></td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
    <th>Show DO NO</th>
    <td></td>
    <td><input type="checkbox" name="checkbox4" id="checkbox4"></td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
    <th>Show Agent NO</th>
    <td></td>
    <td><input type="checkbox" name="cbagent" id="cbagent"></td>
    </tr>
    </cfif>
    <cfif trancode eq "TR">
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th width="16%"><cfoutput>Transfer<cfif dts eq "simplysiti_i">  From</cfif></cfoutput></th>
      	<td width="5%"><div align="center">From</div></td>
      	<td colspan="2">
			<select name="trfrom" id="trfrom">
          		<option value="">Choose a <cfoutput>#getgeneral.lLOCATION#</cfoutput></option>
          		<cfoutput query="getlocation">
            		<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
          		</cfoutput>
			</select>
		</td>
    </tr>
    <tr>
      	<th width="16%"><cfoutput>Transfer<cfif dts eq "simplysiti_i">  From</cfif></cfoutput></th>
      	<td width="5%"><div align="center">To</div></td>
      	<td colspan="2">
			<select name="trto" id="trto">
				<option value="">Choose a <cfoutput>#getgeneral.lLOCATION#</cfoutput></option>
          		<cfoutput query="getlocation">
            		<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
          		</cfoutput>
			</select>
		</td>
    </tr>
    </cfif>
	<tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th width="16%"><cfoutput>#title#</cfoutput></th>
      	<td width="5%"> <div align="center">From</div></td>
      	<td colspan="2">
			<select name="getfrom" id="getfrom">
            	<option value="">Choose a <cfoutput>#title#</cfoutput></option>
				<cfoutput query="getsupp">
            	<option value="#custno#">#custno# - #name#</option>
				</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<cfoutput><input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" id="searchsuppfr" name="searchsuppfr" onKeyUp="getSupp('getfrom','#title#');"></cfoutput>
			</cfif>
		</td>
    </tr>
    <tr>
      	<th width="16%"><cfoutput>#title#</cfoutput></th>
      	<td width="5%"> <div align="center">To</div></td>
      	<td colspan="2">
			<select name="getto" id="getto">
				<option value="">Choose a <cfoutput>#title#</cfoutput></option>
		  		<cfoutput query="getsupp">
				<option value="#custno#">#custno#- #name#</option>
				</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<cfoutput>
<input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('findCustomer');" />&nbsp;<input type="text" id="searchsuppto" name="searchsuppto" onKeyUp="getSupp('getto','#title#');"></cfoutput>
			</cfif>
		</td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th width="16%"><cfoutput>#getgeneral.lAGENT#</cfoutput></th>
      	<td width="5%"><div align="center">From</div></td>
      	<td colspan="2">
			<select name="agentfrom" id="agentfrom">
          		<option value="">Choose a <cfoutput>#getgeneral.lAGENT#</cfoutput></option>
          		<cfoutput query="getagent">
            		<option value="#agent#">#agent# - #desp#</option>
          		</cfoutput>
			</select>
		</td>
    </tr>
    <tr>
      	<th width="16%"><cfoutput>#getgeneral.lAGENT#</cfoutput></th>
      	<td width="5%"><div align="center">To</div></td>
      	<td colspan="2">
			<select name="agentto" id="agentto">
          		<option value="">Choose a <cfoutput>#getgeneral.lAGENT#</cfoutput></option>
          		<cfoutput query="getagent">
            		<option value="#agent#">#agent# - #desp#</option>
          		</cfoutput>
			</select>
		</td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th width="16%">Period</th>
      	<td width="5%"> <div align="center">From</div></td>
      	<td colspan="2">
			<cfoutput>
				<select name="periodfrom" id="periodfrom" onChange="javascript:if(document.getElementById('periodfrom').value==''){document.getElementById('periodto').value=''};">
					<option value="">-</option>
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
                    <cfif lcase(hcomid) eq "taftc_i">
                    <option value="99">Period 99</option>
                    </cfif>
				</select>
			</cfoutput>
		</td>
    </tr>
    <tr>
      	<th width="16%">Period</th>
      	<td width="5%"> <div align="center">To</div></td>
      	<td colspan="2">
			<cfoutput>
				<select name="periodto" id="periodto" onChange="javascript:if(document.getElementById('periodto').value==''){document.getElementById('periodfrom').value=''};">
					<option value="">-</option>
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
                    <cfif lcase(hcomid) eq "taftc_i">
                    <option value="99">Period 99</option>
                    </cfif>
				</select>
			</cfoutput>
		</td>
    </tr>
	<tr>
      	<td colspan="5"><hr></td>
    </tr>
    <cfoutput>
    <cfif getitem.recordcount gt 500>
    	
        <tr>
            <th width="16%">Item</th>
            <td width="5%"><div align="center">From</div></td>
            <td colspan="2">
                <select id="itemfrom" name='itemfrom'>
                    <option value=''>Please Filter The Item</option>
                </select> Filter by:
                <input id="letter" name="letter" type="text" size="8" onKeyup="getItem()"> in:
             
                <select id="searchtype" name="searchtype" onChange="getItem()">
                  <cfoutput>
                    <cfloop list="itemno,aitemno,desp,category,wos_group,brand" index="i">
                      <cfif #i# eq "itemno">
                        <cfset sitemdesp ="Item No">
                        <cfelseif #i# eq "aitemno">
                        <cfset sitemdesp ="Product Code">
                        <cfelseif #i# eq "desp">
                        <cfset sitemdesp ="Description">
                        <cfelseif #i# eq "category">
                        <cfset sitemdesp ="Category">
                        <cfelseif #i# eq "wos_group">
                        <cfset sitemdesp ="Group">
                        <cfelseif #i# eq "brand">
                        <cfset sitemdesp ="Brand">
                      </cfif>
                      <option value="#i#" <cfif #sitemdesp# eq #getgeneral.ddlitem#>selected</cfif>>#sitemdesp#</option>
                    </cfloop>
                  </cfoutput>
                </select>
        	</td>
    	</tr>
        
        <tr>
            <th>Item</th>
            <td><div align="center">To</div></td>
            <td colspan="2" nowrap>
				<select id="itemto" name='itemto' >
					<option value=''>Please Filter The Item</option>
				</select> Filter by:
				<input id="letter1" name="letter1" type="text" size="8" onKeyup="getItem1()"> in:
             
				<select id="searchtype1" name="searchtype1" onChange="getItem1()">
              
                    <cfloop list="itemno,aitemno,desp,category,wos_group,brand" index="i">
                <cfif #i# eq "itemno">
                <cfset sitemdesp ="Item No">
                <cfelseif #i# eq "aitemno">
                <cfset sitemdesp ="Product Code">
                <cfelseif #i# eq "desp">
                <cfset sitemdesp ="Description">
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
			</td>
            </tr>
    <cfelse>
        <tr> 
            <th>Item No</th>
            <td width="5%"> <div align="center">From</div></td>
            <td><select name="itemfrom" id="itemfrom">
                    <option value="">Choose an Item</option>
                    <cfloop query="getitem">
                    <option value="#itemno#">#itemno# - #desp#</option>
                    </cfloop>
                </select>
                <cfif getgeneral.filterall eq "1">
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='from';ColdFusion.Window.show('finditem');" />&nbsp;
                    <input type="text" id="searchitemfr" name="searchitemfr" onKeyUp="getProduct('itemfrom');">
                </cfif>
            </td>
        </tr>
        <tr> 
            <th>Item No</th>
            <td width="5%"> <div align="center">To</div></td>
            <td><select name="itemto" id="itemto">
                    <option value="">Choose an Item</option>
                    <cfloop query="getitem">
                    <option value="#itemno#">#itemno# - #desp#</option>
                    </cfloop>
                </select>
                <cfif getgeneral.filterall eq "1">
                <input type="button" size="10" value="Ajax Search" onClick="document.getElementById('fromto').value='to';ColdFusion.Window.show('finditem');" />&nbsp;
                    <input type="text" name="searchitemto" id="searchitemto" onKeyUp="getProduct('itemto');">
                </cfif>
            </td>
        </tr>
    </cfif>
    </cfoutput>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
	<tr>
      	<th width="16%"><cfoutput>#getgeneral.lLOCATION#<cfif dts eq "simplysiti_i"> To</cfif></cfoutput></th>
      	<td width="5%"><div align="center">From</div></td>
      	<td colspan="2">
			<select name="locationfrom">
          		<option value="">Choose a <cfoutput>#getgeneral.lLOCATION#</cfoutput></option>
          		<cfoutput query="getlocation">
            		<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
          		</cfoutput>
			</select>
		</td>
    </tr>
    <tr>
      	<th width="16%"><cfoutput>#getgeneral.lLOCATION# <cfif dts eq "simplysiti_i"> To</cfif></cfoutput></th>
      	<td width="5%"><div align="center">To</div></td>
      	<td colspan="2">
			<select name="locationto">
          		<option value="">Choose a <cfoutput>#getgeneral.lLOCATION#</cfoutput></option>
          		<cfoutput query="getlocation">
            		<option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
          		</cfoutput>
			</select>
		</td>
    </tr>
	<tr>
      	<td colspan="5"><hr></td>
    </tr>
    <cfif lcase(Hcomid) neq "sdc_i">
	<tr>
      	<th width="16%"><cfoutput>#getgeneral.lGROUP#</cfoutput></th>
      	<td width="5%"><div align="center">From</div></td>
      	<td colspan="2">
			<select name="groupfrom" id="groupfrom">
          		<option value="">Choose a <cfoutput>#getgeneral.lGROUP#</cfoutput></option>
          		<cfoutput query="getgroup">
            		<option value="#getgroup.wos_group#">#getgroup.wos_group# - #getgroup.desp#</option>
          		</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchgroupfr" id="searchgroupfr"  onKeyUp="getGroup('groupfrom');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<th width="16%"><cfoutput>#getgeneral.lGROUP#</cfoutput></th>
      	<td width="5%"><div align="center">To</div></td>
      	<td colspan="2">
			<select name="groupto" id="groupto">
          		<option value="">Choose a <cfoutput>#getgeneral.lGROUP#</cfoutput></option>
          		<cfoutput query="getgroup">
            		<option value="#getgroup.wos_group#">#getgroup.wos_group# - #getgroup.desp#</option>
          		</cfoutput>
			</select>
			<cfif getgeneral.filterall eq "1">
				<input type="text" name="searchgroupto" id="searchgroupto" onKeyUp="getGroup('groupto');">
			</cfif>
		</td>
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <cfelse>
    <input type="hidden" name="groupto" id="groupto" value="">
    <input type="hidden" name="groupfrom" id="groupfrom" value="">
    </cfif>
    <cfoutput>
    <tr> 
        <th><cfoutput>#getgeneral.lproject#</cfoutput></th>
        <td><div align="center">From</div></td>
        <td><select name="projectfrom" id="projectfrom">
				<option value="">Choose an <cfoutput>#getgeneral.lproject#</cfoutput></option>
				<cfloop query="getproject">
				<option value="#source#">#source# - #project#</option>
				</cfloop>
			</select>
		</td>
    </tr>
   
    <tr> 
        <th><cfoutput>#getgeneral.lproject#</cfoutput></th>
        <td><div align="center">To</div></td>
        <td><select name="projectto" id="projectto">
				<option value="">Choose an <cfoutput>#getgeneral.lproject#</cfoutput></option>
				<cfloop query="getproject">
				<option value="#source#">#source# - #project#</option>
				</cfloop>
			</select>
		</td>
    </tr>
     <tr>
      	<td colspan="5"><hr></td>
    </tr>
    
    
    
    <tr<cfif getmodule.job neq "1"> style="display:none"</cfif>> 
	<cfif getmodule.job eq "1">
        <th><cfoutput>#getgeneral.ljob#</cfoutput></th>
        
        <td><div align="center">From</div></td>
        </cfif>
        
        <td <cfif getmodule.job neq "1"> style="visibility:hidden"</cfif>>
        	<select name="jobfrom" id="jobfrom">
				<option value="">Choose an <cfoutput>#getgeneral.ljob#</cfoutput></option>
				<cfloop query="getjob">
					<option value="#source#">#source# - #project#</option>
				</cfloop>
			</select>
		</td>
    </tr>
    
    <tr<cfif getmodule.job neq "1"> style="display:none"</cfif>> 
    <cfif getmodule.job eq "1"> 
        <th><cfoutput>#getgeneral.ljob#</cfoutput></th>
        <td><div align="center">To</div></td>
        </cfif>
        <td <cfif getmodule.job neq "1"> style="visibility:hidden"</cfif>>
        	<select name="jobto" id="jobto">
				<option value="">Choose an <cfoutput>#getgeneral.ljob#</cfoutput></option>
				<cfloop query="getjob">
					<option value="#source#">#source# - #project#</option>
				</cfloop>
			</select>
		</td>
    </tr>

    
    </cfoutput>
    <cfoutput>
    <cfif lcase(Hcomid) eq "simplysiti_i">
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th width="16%">Courier Date</th>
      	<td width="5%"> <div align="center">From</div></td>
      	<td colspan="2"><cfinput type="text" name="rem11from" maxlength="10" size="10">(DD/MM/YYYY)</td>
    </tr>
    <tr>
      	<th width="16%">Courier Date</th>
      	<td width="5%"> <div align="center">To</div></td>
      	<td width="69%"><cfinput type="text" name="rem11to" maxlength="10" size="10">(DD/MM/YYYY)&nbsp;</td>
      	
    </tr>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr> 
        <th>User</th>
        <td><div align="center">From</div></td>
        <td><select name="useridfrom" id="useridfrom">
				<option value="">Choose an User</option>
				<cfloop query="getuserid">
					<option value="#userid#">#userid# - #username#</option>
				</cfloop>
			</select>
		</td>
    </tr>
    <tr> 
        <th>User</th>
        <td><div align="center">To</div></td>
        <td><select name="useridto" id="useridto">
				<option value="">Choose an User</option>
				<cfloop query="getuserid">
					<option value="#userid#">#userid# - #username#</option>
				</cfloop>
			</select>
		</td>
    </tr>
    </cfif>
    <cfif lcase(Hcomid) neq "sdc_i">
    <tr> 
        <td colspan="5"><hr></td>
    </tr>
    <tr>
		<th>#getgeneral.lDRIVER#</th>
        <td><div align="center">From</div></td>
        <td><select name="userfrom" id="userfrom">
				<option value="">Choose an #getgeneral.lDRIVER#</option>
				<cfloop query="getuser">
				<option value="#driverno#">#driverno# - #name#</option>
				</cfloop>
			</select>
		</td>
    </tr>
    <tr> 
        <th>#getgeneral.lDRIVER#</th>
        <td><div align="center">To</div></td>
        <td><select name="userto" id="userto">
				<option value="">Choose an #getgeneral.lDRIVER#</option>
				<cfloop query="getuser">
				<option value="#driverno#">#driverno# - #name#</option>
				</cfloop>
			</select>
		</td>
    </tr>
    <cfelse>
    <input type="hidden" name="userto" id="userto" value="">
    <input type="hidden" name="userfrom" id="userfrom" value="">
    </cfif>
    </cfoutput>
    
    
    <cfoutput>
    <tr> 
        <td colspan="5"><hr></td>
    </tr>
    <tr>
		<th>Delivery Address Code</th>
        <td><div align="center">From</div></td>
        <td><select name="Daddressfrom" id="Daddressfrom">
				<option value="">Choose an Address Code</option>
				<cfloop query="getaddress">
				<option value="#code#">#code# - #name#</option>
				</cfloop>
			</select>
		</td>
    </tr>
    <tr> 
        <th>Delivery Address Code</th>
        <td><div align="center">To</div></td>
        <td><select name="Daddressto" id="Daddressto">
				<option value="">Choose an Address Code</option>
				<cfloop query="getaddress">
				<option value="#code#">#code# - #name#</option>
				</cfloop>
			</select>
		</td>
    </tr>
    </cfoutput>
    <tr>
      	<td colspan="5"><hr></td>
    </tr>
    <tr>
      	<th width="16%">Date</th>
      	<td width="5%"> <div align="center">From</div></td>
      	<td colspan="2"><cfinput type="text" name="datefrom" id="datefrom" maxlength="10" validate="eurodate" size="10">(DD/MM/YYYY)</td>
    </tr>
    <tr>
      	<th width="16%">Date</th>
      	<td width="5%"> <div align="center">To</div></td>
      	<td width="69%"><cfinput type="text" name="dateto" id="dateto" maxlength="10" validate="eurodate" size="10">(DD/MM/YYYY)&nbsp;</td>
      	
    </tr>
    <cfif trancode neq "TR">
    <tr>
    <th>Detail Listing</th>
    <td></td>
    <td><input type="checkbox" name="cbdetail" id="cbdetail"></td>
    </tr>
    </cfif>
    <tr>
    <tr>
    <th>Sort By Date</th>
    <td></td>
    <td><input type="checkbox" name="cbdate" id="cbdate"></td>
    </tr>
    <td colspan="3">
    </td>
    <td width="10%"><input type="Submit" name="Submit" value="Submit"></td>
    </tr>
</table>

</cfform>
<cfif getdealer_menu.custformat eq '2'>
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer2.cfm?type={tran}&fromto={fromto}" />
<cfelse>
<cfwindow center="true" width="550" height="400" name="findCustomer" refreshOnShow="true"
        title="Find Customer or Supplier" initshow="false"
        source="findCustomer.cfm?type={tran}&fromto={fromto}" />
        </cfif>
<cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem.cfm?type=item&fromto={fromto}" />
</body>
</html>