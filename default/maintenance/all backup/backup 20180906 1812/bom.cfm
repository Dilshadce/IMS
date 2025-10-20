<html>
<head>
<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script type='text/javascript' src='/ajax/core/shortcut.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script type="text/javascript" src="/scripts/prototypenew.js" ></script>

<script type="text/javascript">
// begin: product search
function getProduct(type){
		var inputtext = document.form1.searchitemfr.value;
		DWREngine._execute(_reportflocation, null, 'productlookup', inputtext, getProductResult);
}

function getProductResult(itemArray){
	DWRUtil.removeAllOptions("sitemno");
	DWRUtil.addOptions("sitemno", itemArray,"KEY", "VALUE");
}
// end: product search

function selectlist2(custno,fieldtype){
document.getElementById(fieldtype).value=custno;
									}

function selectlist(custno,fieldtype){

	for (var idx=0;idx<document.getElementById(fieldtype).options.length;idx++){
		if (custno==document.getElementById(fieldtype).options[idx].value){
			document.getElementById(fieldtype).options[idx].selected=true;
		}
	} 
}

function show_info(rset){
		rset.MoveFirst();
		DWRUtil.removeAllOptions("sitemno");
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
			document.form1.sitemno.options.add(myoption);
		}
		
	}
<cfoutput>
function additem(){
	<!---
	ajaxFunction(document.getElementById('addbomajax'),'bomadditemprocess.cfm?sitemno='+document.getElementById('sitemno').value+'&bomno='+document.getElementById('bomno').value+'&sitem='+document.getElementById('sitem').value+'&qty='+document.getElementById('qty').value 
+'&locat='+document.getElementById('locat').value+'&sgroup='+document.getElementById('sgroup').value)
addbomitem();--->

new Ajax.Request('bomadditemprocess.cfm?sitemno='+document.getElementById('sitemno').value+'&bomno='+document.getElementById('bomno').value+'&sitem='+document.getElementById('sitem').value+'&qty='+document.getElementById('qty').value 
+'&locat='+document.getElementById('locat').value+'&sgroup='+document.getElementById('sgroup').value,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('addbomajax').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error'); },		
		onComplete: function(transport){
			addbomitem();
        }
      })
}

function updateitem(bomno,itemno){
	
	<!---ajaxFunction(document.getElementById('addbomajax'),'bomUpdateProcess.cfm?sitemno='+document.getElementById('sitemno').value+'&bomno='+bomno+'&sitem='+itemno+'&qty='+document.getElementById('update_qty_'+bomno+'_'+itemno).value 
+'&locat='+document.getElementById('update_location_'+bomno+'_'+itemno).value+'&sgroup='+document.getElementById('sgroup').value)--->

new Ajax.Request('bomUpdateProcess.cfm?sitemno='+document.getElementById('sitemno').value+'&bomno='+bomno+'&sitem='+itemno+'&qty='+document.getElementById('update_qty_'+bomno+'_'+itemno).value 
+'&locat='+document.getElementById('update_location_'+bomno+'_'+itemno).value+'&sgroup='+document.getElementById('sgroup').value,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('addbomajax').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error'); },		
		onComplete: function(transport){
			addbomitem();
        }
      })
}

function deleteItem(bomno,itemno){
	<!---ajaxFunction(document.getElementById('addbomajax'),'bomDeleteProcess.cfm?sitemno='+document.getElementById('sitemno').value+'&bomno='+bomno+'&sitem='+itemno+'&qty='+document.getElementById('qty').value 
+'&locat='+document.getElementById('locat').value+'&sgroup='+document.getElementById('sgroup').value)
	addbomitem();--->

new Ajax.Request('bomDeleteProcess.cfm?sitemno='+document.getElementById('sitemno').value+'&bomno='+bomno+'&sitem='+itemno+'&qty='+document.getElementById('qty').value 
+'&locat='+document.getElementById('locat').value+'&sgroup='+document.getElementById('sgroup').value,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('addbomajax').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error'); },		
		onComplete: function(transport){
			addbomitem();
        }
      })
}

function updateMiscCost(){
	ajaxFunction(document.getElementById('addbomajax'),'bomMiscCost.cfm?sitemno='+document.getElementById('sitemno').value+'&bomno='+document.getElementById('bomno').value+'&sitem='+document.getElementById('sitem').value+'&qty='+document.getElementById('qty').value 
+'&locat='+document.getElementById('locat').value+'&sgroup='+document.getElementById('sgroup').value+'&mcost='+document.getElementById('mcost').value)
	<!---new Ajax.Request(url2,
			  {
				method:'get',
				onSuccess: function(getdetailback){
				document.getElementById('bomajaxfield').innerHTML = trim(getdetailback.responseText);
				},
				onFailure: function(){ 
				alert('Error '); },		
				
				onComplete: function(transport){
				}
			  })--->

}

function addbomitem(){
	var url2='bom2.cfm?sitemno='+document.getElementById('sitemno').value+'&bomno='+document.getElementById('bomno').value;
	ajaxFunction(document.getElementById('bomajaxfield'),url2)
	<!---new Ajax.Request(url2,
			  {
				method:'get',
				onSuccess: function(getdetailback){
				document.getElementById('bomajaxfield').innerHTML = trim(getdetailback.responseText);
				},
				onFailure: function(){ 
				alert('Error '); },		
				
				onComplete: function(transport){
				}
			  })--->

}

</cfoutput>	
	function getItem(){
		var text = document.form1.stext.value;
		var w = document.form1.searchtype.selectedIndex;
		var searchtype = document.form1.searchtype.options[w].value;
		if(text != ''){
			document.all.feedcontact1.dataurl="databind/act_getitem.cfm?searchtype=" + searchtype + "&text=" + text;
			//prompt("D",document.all.feedcontact1.dataurl);
			document.all.feedcontact1.charset=document.charset;
			document.all.feedcontact1.reset();
		}
	}

</script>

<cfif isdefined('url.type')>
<cfset itemno=trim(url.itemno)>
<cfset bomno=trim(url.bomno)>
</cfif>


<title>BOM Item</title>

<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<!--- <cfquery name="getitem" datasource="#dts#">
	select itemno,desp from icitem order by itemno
</cfquery>
<cfset listOfItems = valuelist(getitem.itemno)> --->
<cfquery name="getgeneral" datasource="#dts#">
select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,agentlistuserid,lTEAM,reportagentfromcust,filteritemreport,ddlitem,lbrand  from gsetup 
</cfquery>
<cfquery name="getbomdata" datasource="#dts#">
	SELECT bomno FROM billmat ORDER BY bomno
</cfquery>

<body>
<cfoutput>
  <h4>
    <cfif getpin2.h1J10 eq 'T'>
      <a href="bom.cfm">Create B.O.M</a>
    </cfif>
    <cfif getpin2.h1J20 eq 'T'>
      || <a href="vbom.cfm">List B.O.M</a>
    </cfif>
    <cfif getpin2.h1J30 eq 'T'>
      || <a href="bom_Search.cfm">Search B.O.M</a>
    </cfif>
    <cfif getpin2.h1J40 eq 'T'>
      || <a href="genbomcost.cfm">Generate 
      Cost</a>
    </cfif>
    <cfif getpin2.h1J50 eq 'T'>
      || <a href="checkmaterial.cfm">Check Material</a>
    </cfif>
    <cfif getpin2.h1J60 eq 'T'>
      || <a href="useinwhere.cfm">Use In Where</a> || <a href="bominforecast.cfm">Bom Item Forecast by SO</a>
    </cfif>
    || <a href="createproduction.cfm?type=Create">Create Production Planning</a>|| <a href="productionlist_newest.cfm?refno=sono">Production Planning List</a></h4>
</cfoutput> 
<cfform>
  <table width="60%" border="0" align="center" class="data">
    <tr>
      <th width="26%"> Item No :
        <input type="hidden" name="ttype" value="Add"></th>
      <td width="39%">
      <cfif isdefined('url.type')>
      <cfinput type="text" name="sitemno" id="sitemno" value="#itemno#" readonly>
      <cfelse>
      <cfinput type="text" name="sitemno" id="sitemno" readonly>
      </cfif>
      <!---
        <cfinput type="hidden" name="sitemno" id="sitemno">
        <script>
			<cfoutput>
				function checkItem(){
					var item = document.getElementById("sitemno").value;
					var itemlist=new Array(); 
					
					<cfset itemlength=listlen(listOfItems)>
					<cfloop from='1' to='#itemlength#' index='i'>
						<cfset a=evaluate('listgetat(listofItems,#i#)')>
						itemlist[#i#]="#a#"
					</cfloop>
					
					for(var i=1; i<itemlist.length; i++){								
						if(item.toLowerCase() == itemlist[i].toLowerCase()){				
							return true;		
						}
					}
					alert("Invalid Item No!");
					return false;
				}
			</cfoutput>
		  </script>--->
			<cfif isdefined('url.type')>
            <cfelse>
          <input type="button" size="10" value="Ajax Search" onClick="ColdFusion.Window.show('finditem2');" />
			</cfif>
</td>

    </tr>
    <tr>
      <th>Bom No :</th>
      <td>
      <cfif isdefined('url.type')>
      <cfinput name="bomno" id="bomno" type="text" size="5" value="#bomno#" maxlength="8" required="yes" readonly>
      <cfelse>
      <cfinput name="bomno" id="bomno" type="text" size="5" maxlength="8" required="yes">
      </cfif>
        <input type="button" name="submit" id="submit" value="Submit" onClick="addbomitem();"></td>
    </tr>
    <tr>
      
    </tr>
    

  </table>
  <div id="bomajaxfield"></div>
  <div id="addbomajax"></div>

  
</cfform>

<cfif isdefined('url.type')>
<script type="text/javascript">
addbomitem();
</script>
</cfif>

</body>
</html>

<cfwindow center="true" width="800" height="400" name="finditem2" refreshOnShow="true"
title="Find Item" initshow="false"
source="bomfinditem.cfm?type=Product" />
<cfwindow center="true" width="550" height="400" name="finditem" refreshOnShow="true"
        title="Find Item" initshow="false"
        source="finditem.cfm?type=sitem&fromto=" />
