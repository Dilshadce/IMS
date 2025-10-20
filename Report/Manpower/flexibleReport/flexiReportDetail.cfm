<html>
<html>
<head>
<title>Report Content</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/stylesheet/style.css"/>
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<link href="../../../scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>
<script type='text/javascript' src='/ajax/core/shortcut.js'></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type="text/javascript" src="/scripts/prototypenew.js" ></script>

<script language="javascript" type="text/javascript" src="../../../scripts/CalendarControl.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script type="text/javascript" src="/scripts/controls.js"></script>
<script type="text/javascript" src="/scripts/effects.js"></script>
<script type="text/javascript" src="/scripts/prototype.js"></script>
<script language="javascript" type="text/javascript" src="/scripts/collapse_expand_single_item.js"></script>
</head>

<cfquery name="createtable2" datasource="#dts#">
CREATE TABLE IF NOT EXISTS `selcolumn` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
`uuid` varchar(100) DEFAULT '',
`column` varchar(100) DEFAULT '',
`rename` varchar(100) DEFAULT '',
`position` varchar(100) DEFAULT '',
PRIMARY KEY (`id`)
) ENGINE=MYISAM AUTO_INCREMENT=204 DEFAULT CHARSET=utf8;
</cfquery>

<cfquery name="createtable3" datasource="#dts#">
CREATE TABLE IF NOT EXISTS `avacolumn` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity` varchar(200) DEFAULT '',
  `column` varchar(200) DEFAULT '',
  `realcolumn` varchar(200) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=260 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC
</cfquery>

<cfif url.type eq 'Create'>
	<cfset id = "">
    <cfset reportid = "">
    <cfset desp = "">
    <cfset reportTitle = "">
    <cfset fCustomer = "">
    <cfset fPlacement = "">
	<cfset fAssignment = "">
	<cfset fInvoice = "">
	<cfset fEmployee = "">
    <cfset selcol = "">
    <cfset sortby = "ASC">
    <cfset sort1 = "">
    <cfset sort2 = "">
    <cfset groupby = "">
    <cfset uuid = createuuid()>
<cfelseif url.type eq 'Edit'>
	<cfquery name="getreport" datasource="#dts#">
    	select * from flexireport where id = '#url.reportid#'
    </cfquery>
    
    <cfset id="#getreport.id#">
    <cfset reportid = "#getreport.reportid#">
    <cfset desp = "#getreport.desp#">
    <cfset reportTitle = "#getreport.reporttitle#">
    <cfset fCustomer = "#getreport.fcustomer#">
    <cfset fPlacement = "#getreport.fplacement#">
	<cfset fAssignment = "#getreport.fassignment#">
	<cfset fInvoice = "#getreport.finvoice#">
	<cfset fEmployee = "#getreport.femployee#">
    <cfset selcol = "#getreport.selcol#">
    <cfset sortby = "#getreport.sortby#">
    <cfset sort1 = "#getreport.sort1#">
    <cfset sort2 = "#getreport.sort2#">
    <cfset groupby = "#getreport.groupby#">
    <cfset uuid = "#getreport.uuid#">
	
    <cfquery name="getselcol" datasource="#dts#">
    	select * from selcolumn where uuid = "#uuid#" order by position*1
    </cfquery>    
    
    <cfquery name="getavacol" datasource="#dts#">
        select * from avacolumn where entity in (''<cfif fCustomer neq ''>,'Customer'</cfif><cfif fPlacement neq ''>,'Placement'</cfif><cfif fAssignment neq ''>,'Assignment'</cfif><cfif fInvoice neq ''>,'Invoice'</cfif><cfif fEmployee neq ''>,'Employee'</cfif>) and `column` not in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getselcol.column)#" separator="," list="yes">) order by id
    </cfquery>
</cfif>

<cfoutput>
<body>
<h1>Report Content</h1>
<form id="reportContent" name="reportContent" action="reportProcess.cfm?type=#url.type#&reportid=#id#" method="post"> 
    <table align="center" class="data" width="90%">
    	<tr>
            <th width="25%">Report Title:</th>
            <td width="25%"><input type="text" id="reportTitle" name="reportTitle" maxlength="200" value="#reportTitle#"></td>
            <td width="25%"></td>
            <td width="25%"></td>
      	</tr>
      	<tr>
            <th>Description</th>
            <td><input type="text" id="desp" name="desp" value="#desp#"></td>
            <td></td>
            <td></td>
      	</tr>
        <tr>
            <th width="25%">Field:</th>
            <td width="75%">
                <input type="checkbox" id="fCustomer" name="fCustomer" value="fCustomer" onChange="setColumn();sortGroup();" <cfif fcustomer eq 'y'>checked</cfif>> Customer
                <input type="checkbox" id="fPlacement" name="fPlacement" value="fPlacement" onChange="setColumn();sortGroup();" <cfif fplacement eq 'y'>checked</cfif>> Placement
                <input type="checkbox" id="fAssignment" name="fAssignment" value="fAssignment" onChange="setColumn();sortGroup();" <cfif fassignment eq 'y'>checked</cfif>> Assignment Slip
                <input type="checkbox" id="fInvoice" name="fInvoice" value="fInvoice" onChange="setColumn();sortGroup();" <cfif finvoice eq 'y'>checked</cfif> style="display:none"> <!---Invoice--->
                <input type="checkbox" id="fEmployee" name="fEmployee" value="fEmployee" onChange="setColumn();sortGroup();" <cfif femployee eq 'y'>checked</cfif>> Employee (PMS)
            </td
                     
        ></tr>
      	<tr>
        	<th width="25%">Column</th>    
            <td width="75%">
               <div id="colAjax">
               		<table width="100%">
                        <tr>	
                            <td width="40%"><strong>Available Column</strong></td>
                            <td width ="10%"></td>
                            <td width="40%"><strong>Selected Column</strong></td>
                            <td width="10%"></td>
                        </tr>                  
                        <tr>
                            <td>
                                <select id="avaColumn" name="avaColumn" size="20" MULTIPLE style="width:100%">
                                	<cfif url.type eq 'Edit'>
                                    	<cfloop query="getavacol">
                                        	<option value="#getavacol.column#">#getavacol.column#</option>
                                        </cfloop>
                                    </cfif>                             	            
                                </select>
                            </td>
                            <td align="left">                		
                                <input type="Button" value="Add >>" style="width:100px" onClick="addColumn()">
                                <br>
                                <br>
                                <input type="Button" value="<< Remove" style="width:100px" onClick="removeColumn()">
                                <br>
                                <br>
                                <input type="Button" value="Add All >>" style="width:100px" onClick="selectAll()">
                                <br>
                                <br>
                                <input type="Button" value="<< Remove All" style="width:100px" onClick="removeAll()">
                                
                            </td>
                            <td align="left">
                                <select id="selColumn" name="selColumn" size="20" MULTIPLE style="width:100%">
                                	<cfif url.type eq 'Edit'>
                                    	<cfloop query="getselcol">
                                        	<option value="#getselcol.column#">#getselcol.column#</option>
                                        </cfloop>
                                    </cfif>              
                                </select>
                            </td>
                            <td align="left">                     
                                <input type="Button" value="Up" style="width:100px" onClick="sortColumn('up')">
                                <br>
                                <br>
                                <input type="Button" value="Down" style="width:100px" onClick="sortColumn('down')">						                    	
                            </td>
                        </tr>
                    </table>
               </div> 
            </td>
            <!---<td width="25%"></td>    
            <td width="25%"></td>--->
        </tr>
        <tr>
        	<th width="25%">Sort Order</th>
            <td width="75%">
            	<input type="radio" id="sortOrder" name="sortOrder" value="ASC" <cfif sortby eq 'ASC'>checked</cfif>>Ascending
            	&nbsp;&nbsp;
                <input type="radio" id="sortOrder" name="sortOrder" value="DESC" <cfif sortby eq 'DESC'>checked</cfif>>Descending
            </td>
         </tr>
         <tr>
            <th width="25%">Sort By</th>
            <td width="25%">
            	<select id="sort1" name="sort1" onChange="selectSort()" style="width:50%">
                	<option value="">None</option>
                    <cfif url.type eq 'Edit'>
                        <cfloop query="getselcol">          
                            <option value="#getselcol.column#" <cfif getselcol.column eq sort1>selected</cfif>>#getselcol.column#</option>
                        </cfloop>
                    </cfif>                   
                </select>
                </select> 
                &nbsp;&nbsp;
                <select id="sort2" name="sort2" style="width:50%<cfif sort1 eq "">;display:none</cfif>">
                	<option value="">None</option>
                    <cfif url.type eq 'Edit'>
                        <cfloop query="getselcol">          
                            <option value="#getselcol.column#" <cfif getselcol.column eq sort2>selected</cfif>>#getselcol.column#</option>
                        </cfloop>
                    </cfif>   
            	</select>
            </td>
        </tr>
        <tr>
        	<th>Group By</th>
            <td>
            	<select id="groupBy" name="groupBy">             	
                    <option value="">None</option>
                    <option value="Customer" <cfif groupby eq 'Customer'>selected</cfif> <cfif fcustomer eq 'y' or fplacement eq 'y' or femployee eq 'y'><cfelse>disabled</cfif>>Customer</option>
                    <option value="Employee" <cfif groupby eq 'Employee'>selected</cfif> <cfif fplacement eq 'y' or fassignment eq 'y' or femployee eq 'y'><cfelse>disabled</cfif>>Employee</option>
                    <option value="User" <cfif groupby eq 'User'>selected</cfif> <cfif fplacement eq 'y' or fassignment eq 'y' or finvoice eq 'y'><cfelse>disabled</cfif>>User</option>
                    <option value="Project" <cfif groupby eq 'Project'>selected</cfif> <cfif fplacement eq 'y'><cfelse>disabled</cfif>>Project</option>
                    <option value="Pay Period" <cfif groupby eq 'Pay Period'>selected</cfif> <cfif fassignment eq 'y'><cfelse>disabled</cfif>>Pay Period</option>
                    <option value="Consultant" <cfif groupby eq 'Consultant'>selected</cfif> <cfif fplacement eq 'y'><cfelse>disabled</cfif>>Consultant</option>
                    <option value="Location" <cfif groupby eq 'Location'>selected</cfif> <cfif fplacement eq 'y'><cfelse>disabled</cfif>>Location</option>
                </select>
            </td> 
        </tr>     
    </table>
    <!---<table align="center" class="data" width="80%">
        <tr>
            <th width="100%" onClick="javascript:shoh('renameColumn')">
            	<div align="left">
                	Rename Column<img src="/images/d.gif" name="imgtransaction_menu_page1" align="center">
                </div>
            </th>
        </tr>
    </table>
    <table align="center" class="data" width="80%" id="renameColumn" style="display:none">
        
    </table>--->  	
    <table width="90%" align="center">
        <tr>
            <td></td>
            <td align="center">
            	<input type="hidden" id="hiduuid" name="hiduuid" value="#uuid#">
            	<input type="submit" value="  <cfif url.type eq 'Edit'>Save<cfelse>#url.type#</cfif> Report  ">
                <input type="button" value="  Back  " onClick="window.history.go(-1)">
            </td>
        </tr>
    </table>
</form>

<script language="Javascript">
imgout=new Image(9,9);
imgin=new Image(9,9);

imgout.src="/images/u.gif";
imgin.src="/images/d.gif";

function shoh(id) { 	
	if (document.getElementById) { 
		if (document.getElementById(id).style.display == "none"){
			document.getElementById(id).style.display = 'block';
			<!---filter(("img"+id),'imgin');--->			
		} else {
			<!---filter(("img"+id),'imgout');--->
			document.getElementById(id).style.display = 'none';			
		}	
	} else { 
		if (document.layers) {	
			if (document.id.display == "none"){
				document.id.display = 'block';
				<!---filter(("img"+id),'imgin');--->
			} else {
				<!---filter(("img"+id),'imgout');--->	
				document.id.display = 'none';
			}
		} else {
			if (document.all.id.style.visibility == "none"){
				document.all.id.style.display = 'block';
			} else {
				<!---filter(("img"+id),'imgout');--->
				document.all.id.style.display = 'none';
			}
		}
	}
}

<!---function filter(imagename,objectsrc){
	if (document.images){
		document.images[imagename].src=eval(objectsrc+".src");
	}
}--->

function setColumn(){
	if(document.getElementById('fCustomer').checked && document.getElementById('fEmployee').checked && document.getElementById('fPlacement').checked == false && document.getElementById('fAssignment').checked == false){
		document.getElementById('fPlacement').checked = true;	
	}
	
	var ajaxurl = 'colAjax.cfm?type=list&fCustomer='+document.getElementById('fCustomer').checked+'&fPlacement='+document.getElementById('fPlacement').checked+'&fAssignment='+document.getElementById('fAssignment').checked+'&fInvoice='+document.getElementById('fInvoice').checked+'&fEmployee='+document.getElementById('fEmployee').checked+'&uuid=#uuid#';
	
	new Ajax.Request(ajaxurl, {
        method:'get',
        onSuccess: function(getdetailback){			
			document.getElementById("colAjax").innerHTML = getdetailback.responseText;
			setSort();		
        },
        onFailure: function(){ 
			alert('Error Get Column'); 
		},		
		onComplete: function(transport){

    	}
	});
}

<!---function SelectMoveRows(SS1,SS2)
{
    var SelID='';
    var SelText='';
    // Move rows from SS1 to SS2 from bottom to top
    for (i=SS1.options.length - 1; i>=0; i--)
    {
        if (SS1.options[i].selected == true)
        {
            SelID=SS1.options[i].value;
            SelText=SS1.options[i].text;
            var newRow = new Option(SelText,SelID);
			var newRow2 = new Option(SelText,SelID);
			var newRow3 = new Option(SelText,SelID);
            SS2.options[SS2.length]=newRow;
			sort1.options[sort1.length]=newRow2;
			sort2.options[sort2.length]=newRow3;
            //SS1.options[i]=null;
			SS1.options[i].style.display = "none";
        }
    }
    //SelectSort(SS2);
}

function SelectSort(SelList)
{
    var ID='';
    var Text='';
    for (x=0; x < SelList.length - 1; x++)
    {
        for (y=x + 1; y < SelList.length; y++)
        {
            if (SelList[x].text > SelList[y].text)
            {
                // Swap rows
                ID=SelList[x].value;
                Text=SelList[x].text;
                SelList[x].value=SelList[y].value;
                SelList[x].text=SelList[y].text;
                SelList[y].value=ID;
                SelList[y].text=Text;
            }
        }
    }
}--->

function selectAll(){
    var ajaxurl = 'colAjax.cfm?type=addall&fCustomer='+document.getElementById('fCustomer').checked+'&fPlacement='+document.getElementById('fPlacement').checked+'&fAssignment='+document.getElementById('fAssignment').checked+'&fInvoice='+document.getElementById('fInvoice').checked+'&fEmployee='+document.getElementById('fEmployee').checked+'&uuid=#uuid#';
	
	new Ajax.Request(ajaxurl, {
        method:'get',
        onSuccess: function(getdetailback){			
			document.getElementById("colAjax").innerHTML = getdetailback.responseText;		
			setSort();
			
			for (var i=0; i<document.getElementById('selColumn').options.length; i++) {
                document.getElementById('selColumn').options[i].selected = true;
            }
        },
        onFailure: function(){ 
			alert('Error Get Column'); 
		},		
		onComplete: function(transport){
			
    	}
	});
    
	
}

function removeAll(){
    var ajaxurl = 'colAjax.cfm?type=removeall&fCustomer='+document.getElementById('fCustomer').checked+'&fPlacement='+document.getElementById('fPlacement').checked+'&fAssignment='+document.getElementById('fAssignment').checked+'&fInvoice='+document.getElementById('fInvoice').checked+'&fEmployee='+document.getElementById('fEmployee').checked+'&uuid=#uuid#';
	
	new Ajax.Request(ajaxurl, {
        method:'get',
        onSuccess: function(getdetailback){			
			document.getElementById("colAjax").innerHTML = getdetailback.responseText;		
			setSort();
			
			for (var i=0; i<document.getElementById('selColumn').options.length; i++) {
                document.getElementById('selColumn').options[i].selected = false;
            }
        },
        onFailure: function(){ 
			alert('Error Get Column'); 
		},		
		onComplete: function(transport){
			
    	}
	});
    
	
}

function addColumn(){
	try{	
		var e = document.getElementById('avaColumn');
		var value = e.options[e.selectedIndex].value;
		var pos = e.selectedIndex;
	}
	catch(err){
		return;
	}
	
	var ajaxurl = 'colAjax.cfm?type=add&fCustomer='+document.getElementById('fCustomer').checked+'&fPlacement='+document.getElementById('fPlacement').checked+'&fAssignment='+document.getElementById('fAssignment').checked+'&fInvoice='+document.getElementById('fInvoice').checked+'&fEmployee='+document.getElementById('fEmployee').checked+'&uuid=#uuid#&selcol='+encodeURIComponent(value);
	
	new Ajax.Request(ajaxurl, {
        method:'get',
        onSuccess: function(getdetailback){			
			document.getElementById("colAjax").innerHTML = getdetailback.responseText;		
			setSort();
			
			if(pos >= document.getElementById('avaColumn').options.length){
				document.getElementById('avaColumn').options[document.getElementById('avaColumn').options.length-1].selected = true;
			}
			else{
				document.getElementById('avaColumn').options[pos].selected = true;
			}
        },
        onFailure: function(){ 
			alert('Error Get Column'); 
		},		
		onComplete: function(transport){
			
    	}
	});
}

function removeColumn(){	
	try{	
		var e = document.getElementById('selColumn');
		var value = e.options[e.selectedIndex].value;
		var pos = e.selectedIndex;	
	}
	catch(err){
		return;
	}
	
	var ajaxurl = 'colAjax.cfm?type=remove&fCustomer='+document.getElementById('fCustomer').checked+'&fPlacement='+document.getElementById('fPlacement').checked+'&fAssignment='+document.getElementById('fAssignment').checked+'&fInvoice='+document.getElementById('fInvoice').checked+'&fEmployee='+document.getElementById('fEmployee').checked+'&uuid=#uuid#&selcol='+encodeURIComponent(value);
	
	new Ajax.Request(ajaxurl, {
        method:'get',
        onSuccess: function(getdetailback){			
			document.getElementById("colAjax").innerHTML = getdetailback.responseText;
			setSort();
			
			if(pos >= document.getElementById('selColumn').options.length){
				document.getElementById('selColumn').options[document.getElementById('selColumn').options.length-1].selected = true;
			}
			else{
				document.getElementById('selColumn').options[pos].selected = true;
			}
        },
        onFailure: function(){ 
			alert('Error Get Column'); 
		},		
		onComplete: function(transport){

    	}
	});
}

function setSort(){				
	var select = document.getElementById("sort1");
	var length = select.options.length;
	document.getElementById('sort1').options.length = 0;
	
	var select2 = document.getElementById("sort2");
	var length2 = select2.options.length;
	document.getElementById('sort2').options.length = 0;	
	
	var select3 = document.getElementById("selColumn");
	var length3 = select3.options.length;
	
	var newRow = new Option("None", "");
	var newRow2 = new Option("None", "");
	
	select.options[select.length]=newRow;
	select2.options[select2.length]=newRow2;
	
	for (i = 0; i < length3; i++) {
		selcolvalue=select3.options[i].value;
		selcoltxt=select3.options[i].text;
		var newRow3 = new Option(selcoltxt,selcolvalue);
		var newRow4 = new Option(selcoltxt,selcolvalue);
		
		select.options[select.length]=newRow3;
		select2.options[select2.length]=newRow4;
	}
}

function sortColumn(dir){	
	try{	
		var e = document.getElementById('selColumn');
		var value = e.options[e.selectedIndex].value;
		var pos = e.selectedIndex;
		if(dir == "up"){
			var newPos = pos-1; 
		}
		else{
			var newPos = pos+1;
		}
	}
	catch(err){
		return;
	}
	
	var ajaxurl = 'colAjax.cfm?type='+dir+'&fCustomer='+document.getElementById('fCustomer').checked+'&fPlacement='+document.getElementById('fPlacement').checked+'&fAssignment='+document.getElementById('fAssignment').checked+'&fInvoice='+document.getElementById('fInvoice').checked+'&fEmployee='+document.getElementById('fEmployee').checked+'&uuid=#uuid#&selcol='+encodeURIComponent(value);
	
	new Ajax.Request(ajaxurl, {
        method:'get',
        onSuccess: function(getdetailback){			
			document.getElementById("colAjax").innerHTML = getdetailback.responseText;
			document.getElementById('selColumn').options[newPos].selected = true;		
        },
        onFailure: function(){ 
			alert('Error Get Column'); 
		},		
		onComplete: function(transport){

    	}
	});
	
	//jQuery.noConflict();
}

function selectSort(){
	var e = document.getElementById('sort1');
	var value = e.options[e.selectedIndex].value;
	
	if(value == ""){
		document.getElementById('sort2').selectedIndex = 0;
		document.getElementById('sort2').style.display = "none";
	}
	else{
		var select5 = document.getElementById("sort2");
		var length5 = select5.options.length;
		
		for (i = 0; i < length5; i++) {
			if(i == e.selectedIndex){
				document.getElementById('sort2').options[i].disabled = true;
			}
			else{
				document.getElementById('sort2').options[i].disabled = false;
			}
		}
		document.getElementById('sort2').style.display = "block";
	}
}

function sortGroup(){
	var select4 = document.getElementById("groupBy");
	var length4 = select4.options.length;
	
	for (i = 1; i < length4; i++) {
		if(i==1){
			if(document.getElementById('fCustomer').checked == true || document.getElementById('fPlacement').checked == true || document.getElementById('fAssignment').checked == true){
				document.getElementById('groupBy').options[i].disabled = false;
			}
			else{
				document.getElementById('groupBy').options[i].disabled = true;
			}
		}
		else if(i==2){
			if(document.getElementById('fPlacement').checked == true || document.getElementById('fAssignment').checked == true || document.getElementById('fEmployee').checked == true){
				document.getElementById('groupBy').options[i].disabled = false;
			}
			else{
				document.getElementById('groupBy').options[i].disabled = true;
			}
		}
		else if(i==3){
			if(document.getElementById('fPlacement').checked == true || document.getElementById('fAssignment').checked == true || document.getElementById('fInvoice').checked == true){
				document.getElementById('groupBy').options[i].disabled = false;
			}
			else{
				document.getElementById('groupBy').options[i].disabled = true;
			}
		}
		else if(i==4 || i==6 || i==7){
			if(document.getElementById('fPlacement').checked == true){
				document.getElementById('groupBy').options[i].disabled = false;
			}
			else{
				document.getElementById('groupBy').options[i].disabled = true;
			}
		}
		else if(i==5){
			if(document.getElementById('fAssignment').checked == true){
				document.getElementById('groupBy').options[i].disabled = false;
			}
			else{
				document.getElementById('groupBy').options[i].disabled = true;
			}
		}
	}	
}
</script>

</body></cfoutput>

</html>