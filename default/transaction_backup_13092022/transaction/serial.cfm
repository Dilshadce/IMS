<cffunction name="RemoveRecord_In" output="true" returntype="string">
	<cfset statusMsg="">
	<cfquery name="getLocation" datasource="#dts#">
		select serialno, location from iserial where type='#form.tran#' and refno='#form.nexttranno#' and 
		itemno='#form.itemno#' and trancode='#form.itemcount#'
	</cfquery>
	<cfif getLocation.recordcount gt 0>
		<cfif getLocation.location[1] neq form.location>
			<cfquery name="getOldRecord" datasource="#dts#">
				select type,refno,serialno from iserial where itemno='#form.itemno#' and location='#getLocation.location[1]#' and sign=-1 
				and serialno in ('#valuelist(getLocation.serialno,"','")#')
			</cfquery>
			<cfif getOldRecord.recordcount gt 0>
				<cfquery name="deleteRecord" datasource="#dts#">
					delete from iserial where itemno='#form.itemno#' and location='#getLocation.location[1]#' and sign=-1 and 
					serialno in ('#valuelist(getOldRecord.serialno,"','")#')
				</cfquery>
				<cfset statusMsg="Location has been Change. Below serial No have been removed.">
				<cfloop query="getOldRecord">
					<cfset statusMsg=listappend(statusMsg,"Type: #type#,Refno: #refno#,Serial No: #serialno#")>
				</cfloop>
			</cfif>
			<cftry>
				<cfquery name="updateRecord" datasource="#dts#">
					update iserial set location='#form.location#' 
					where type='#form.tran#' and refno='#form.nexttranno#' and itemno='#form.itemno#' and 
					trancode='#form.itemcount#' and location='#getLocation.location#'
				</cfquery>
				<cfset statusMsg=listappend(statusMsg,"Successfully Change Location.")>
				<cfcatch type="database">
					<cfset statusMsg=listappend(statusMsg,"Failed to Change Location.Please check with Administrator.")>
				</cfcatch>
			</cftry>
		</cfif>
	</cfif>
	<cfreturn statusMsg>
</cffunction>
<cffunction name="RemoveRecord_Out" output="false">
	<cfquery name="getLocation" datasource="#dts#">
		select location from iserial where type='#form.tran#' and refno='#form.nexttranno#' and 
		itemno='#form.itemno#' and trancode='#form.itemcount#' limit 1
	</cfquery>
	<cfif getLocation.recordcount gt 0>
		<cfif getLocation.location neq form.location>
			<cfquery name="deleteRecord" datasource="#dts#">
				delete from iserial where type='#form.tran#' and refno='#form.nexttranno#' and 
				itemno='#form.itemno#' and trancode='#form.itemcount#'
			</cfquery>
		</cfif>
	</cfif>
</cffunction>
<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">

<cfif form.type neq "Delete">
	<cfif form.tran eq "RC" or form.tran eq "CN" or form.tran eq "OAI"><cfset sign=1><cfelse><cfset sign=-1></cfif>
	<cfif sign eq 1>
		<cfinvoke method="removeRecord_In" returnvariable="statusMsg"/>
		<cfif statusMsg neq ""><cflog file="tran_serial" text="record msg : #statusMsg# (#HcomID#-#HUserID#)"></cfif>
	<cfelse>
		<cfinvoke method="removeRecord_Out"/>
	</cfif>
		<cfquery name="getgsetup" datasource="#dts#">
    select * from gsetup
    </cfquery>
	<html>
	<head>
		<title>Add / Delete Serial Page</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
		<script type='text/javascript' src='../../ajax/core/engine.js'></script>
		<script type='text/javascript' src='../../ajax/core/util.js'></script>
		<script type='text/javascript' src='../../ajax/core/settings.js'></script>
        <script type="text/javascript" src="/scripts/prototypenew.js" ></script>
        <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
        <script language="javascript" type="text/javascript">
		function PopupCenter(pageURL, title,w,h) {
			var left = (screen.width/2)-(w/2);
			var top = (screen.height/2)-(h/2);
			var targetWin = window.open (pageURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
		} 
	
		</script>
        
		<script language="javascript" type="text/javascript">
			<cfoutput>
			var type='#form.tran#';
			var refno='#form.nexttranno#';
			
			var trancode='#form.itemcount#';
			var qty='#form.qty#';
			var newqty = '#form.qty#';
			var custno='#form.custno#';
			var period='#form.readperiod#';
			var date='#form.nDateCreate#';
			var agenno='#form.agenno#';
			var batchcode='#form.enterbatch#';
			var xlocation='#form.location#';
			var currrate='#form.currrate#';
			var price='#form.price#';
			var sign='#sign#';
			</cfoutput>
			
			function validateserial(){
			<cfif lcase(hcomid) eq "netsource_i" or lcase(hcomid) eq "netilung_i" or lcase(hcomid) eq "sonycenter_i" or lcase(hcomid) eq "dossindo_i" or lcase(hcomid) eq "ssmobile_i" or lcase(hcomid) eq "ninetyeightmobile_i">
			if ((document.getElementById('totalitemqty').value*1) != (document.getElementById('totaladdedserial').value*1))
			{
				alert('Serial Qty Less than Item Qty!');
				return false;
			}
			<cfelse>
			
			if ((document.getElementById('totalitemqty').value*1) < (document.getElementById('totaladdedserial').value*1))
			{
				alert('Serial Qty more than Item Qty!');
				return false;
			}
			</cfif>
			return true;
			}
			
			function getResult(){
				var itemno= document.serialForm.itemno.value;
				ajaxFunction(document.getElementById('serialtablelist'),'serialtableajax.cfm?itemno='+escape(encodeURIComponent(itemno))+'&refno='+escape(refno)+'&type='+escape(type)+'&trancode='+escape(trancode)+'&custno='+escape(custno)+'&period='+escape(period)+'&qty='+escape(qty)+'&agenno='+escape(agenno)+'&location='+escape(xlocation)+'&currrate='+escape(currrate)+'&sign='+escape(sign)+'&price='+escape(price));
				var ajaxurl = 'addedserialajax.cfm?itemno='+escape(encodeURIComponent(itemno))+'&refno='+escape(refno)+'&type='+escape(type)+'&trancode='+escape(trancode)+'&custno='+escape(custno)+'&period='+escape(period)+'&qty='+escape(qty)+'&agenno='+escape(agenno)+'&location='+escape(xlocation)+'&currrate='+escape(currrate)+'&sign='+escape(sign)+'&price='+escape(price)+'&batchcode='+escape(batchcode);

				new Ajax.Request(ajaxurl,
					{
					  method:'get',
					  onSuccess: function(getdetailback){
					  document.getElementById('addedserialnolist').innerHTML = trim(getdetailback.responseText);
					  },
					  onFailure: function(){ 
					  alert('Error'); },		
					  
					  onComplete: function(transport){
					  <cfif lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "iaf_i" or lcase(hcomid) eq "scpl_i" or lcase(hcomid) eq "mfssmy_i">
						<cfif sign eq '1'>
						setTimeout("document.getElementById('text_serialno').focus();",500);
						<cfelse>
						setTimeout("document.getElementById('serialnoselect').value='';",500);
						setTimeout("document.getElementById('serialnoselect').focus();",500);
						</cfif>
						<cfelse>
						<cfif sign eq '1'>
						setTimeout("document.getElementById('text_serialno').focus();",500);
						<cfelse>
						setTimeout("document.getElementById('select_serialno').focus();",500);
						</cfif>
						</cfif>
					  }
					})
				
			}
			
			<!--- Display/Add Serial Control End --->
			<!--- Add/Delete Serial no Start --->
			function trim (str) {
				var	str = str.replace(/^\s\s*/, ''),
					ws = /\s/,
					i = str.length;
				while (ws.test(str.charAt(--i)));
				return str.slice(0, i + 1);
			}


			function addNewSerialno(){
				var itemno= document.serialForm.itemno.value;
				<cfif sign eq -1>
				var serialno=document.serialForm.select_serialno;
				<cfelse>
				var serialno=document.serialForm.text_serialno;
				</cfif>
				<cfif (lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "iaf_i" or lcase(hcomid) eq "scpl_i" or lcase(hcomid) eq "mfssmy_i") and sign neq "-1">
				var getserialnostring = document.serialForm.text_serialno.value;
				if(/\s{4,}/g.test(getserialnostring.split("      ")[0]) ==true){
				var mySplitResult = getserialnostring.split("    ");
				}
				else if(/\s{3,}/g.test(getserialnostring.split("      ")[0]) ==true){
					var mySplitResult = getserialnostring.split("   ");
				}
				else{
					var mySplitResult = getserialnostring.split("  ");
				}
				
				document.serialForm.text_serialno.value = trim(mySplitResult[0]);
				</cfif>
				<cfif (lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "iaf_i" or lcase(hcomid) eq "scpl_i" or lcase(hcomid) eq "mfssmy_i") and sign eq "-1">
				var getserialnostring = document.serialForm.serialnoselect.value;
				<!---var mySplitResult = getserialnostring.split("  ");--->
				if(/\s{4,}/g.test(getserialnostring.split("      ")[0]) ==true){
					var mySplitResult = getserialnostring.split("    ");
				}
				else if(/\s{3,}/g.test(getserialnostring.split("      ")[0]) ==true){
					var mySplitResult = getserialnostring.split("   ");
				}
				else{
					var mySplitResult = getserialnostring.split("  ");
				}
				
				var spliresult = trim(mySplitResult[0]);
				if(spliresult != ""){
				for (var idx=0;idx<serialno.options.length;idx++) 
				{
					if (spliresult==trim(serialno.options[idx].value)) 
					{
						serialno.options[idx].selected=true;
						
					}
				}
				}
				</cfif>
				
				<cfif lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "iaf_i" or lcase(hcomid) eq "scpl_i" or lcase(hcomid) eq "mfssmy_i">
				try{
				if(trim(mySplitResult[1]).toLowerCase() != trim(itemno).toLowerCase())
				{
				alert('The barcode not matching the itemno');
				<cfif sign eq -1>
				document.serialForm.serialnoselect.value = "";
				document.getElementById('serialnoselect').focus();
				<cfelse>
				document.serialForm.text_serialno.value = "";
				document.getElementById('text_serialno').focus();
				</cfif>
				
				return false;
				}
				}
				catch(err)
				{
				}
				</cfif>
				<cfif (lcase(hcomid) eq "dental_i" or lcase(hcomid) eq "dental10_i" or lcase(hcomid) eq "mfss_i" or lcase(hcomid) eq "hcss_i" or lcase(hcomid) eq "iaf_i" or lcase(hcomid) eq "scpl_i" or lcase(hcomid) eq "mfssmy_i") >
				<cfelse>
				<cfif sign eq "-1">

				var getserialnostring = document.serialForm.serialnoselect.value;
				var gotserialexist=0;
				if(trim(getserialnostring) != ''){
				for (var idx=0;idx<serialno.options.length;idx++) 
				{
					if (getserialnostring.toLowerCase()==trim(serialno.options[idx].value).toLowerCase()) 
					{
						serialno.options[idx].selected=true;
						gotserialexist=1;
					}
				}
				if(gotserialexist==0){
					alert('wrong serial keyed');
					return false;	
				}
				}
				</cfif>
				</cfif>

				if(serialno.value.search(/{no}/)!=-1 || serialno.value==''){serialno.focus();alert("Please make sure you have select/key-in Serial No.");}
				else if(serialno.value.search(/,/)!=-1){serialno.focus();alert("',' is not allow.");}
				else{
				var ajaxurl = 'serialnoaddnewajax.cfm?proces=Create&itemno='+escape(encodeURIComponent(itemno))+'&serialno='+escape(serialno.value)+'&date='+escape(date)+'&refno='+escape(refno)+'&type='+escape(type)+'&trancode='+escape(trancode)+'&custno='+escape(custno)+'&period='+escape(period)+'&qty='+escape(qty)+'&agenno='+escape(agenno)+'&location='+escape(xlocation)+'&currrate='+escape(currrate)+'&sign='+escape(sign)+'&price='+escape(price);

				new Ajax.Request(ajaxurl,
					{
					  method:'get',
					  onSuccess: function(getdetailback){
					  document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
					  },
					  onFailure: function(){ 
					  alert('Error Add/Delete Serial'); },		
					  
					  onComplete: function(transport){
					  getResult();
					  }
					})
				  
				  <!---ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
				  setTimeout('getResult();',750);--->
					
					}
			}
			
			function addNewSerialno2(){
				var itemno= document.serialForm.itemno.value;
				var serialnofr=document.serialForm.runningnumfr;
				var serialnoto=document.serialForm.runningnumto;
				var prefix=document.serialForm.prefix.value;
				var endfix=document.serialForm.endfix.value;
				var seriallen=document.serialForm.runningnumfr.value.length;

				if(serialnofr.value=='' || serialnoto.value=='')
				{alert("Please make sure you have select/key-in Serial No.");}
				else if(serialnofr.value.search(/,/)!=-1 || serialnoto.value.search(/,/)!=-1){alert("',' is not allow.");}
				else{
					var ajaxurl = 'serialnoaddnew2ajax.cfm?itemno='+escape(encodeURIComponent(itemno))+'&date='+escape(date)+'&refno='+escape(refno)+'&type='+escape(type)+'&trancode='+escape(trancode)+'&custno='+escape(custno)+'&period='+escape(period)+'&qty='+escape(qty)+'&agenno='+escape(agenno)+'&location='+escape(xlocation)+'&currrate='+escape(currrate)+'&sign='+escape(sign)+'&price='+escape(price)+'&serialnofr='+escape(serialnofr.value)+'&serialnoto='+escape(serialnoto.value)+'&prefix='+escape(prefix)+'&endfix='+escape(endfix)+'&seriallen='+escape(seriallen);

					new Ajax.Request(ajaxurl,
					{
					  method:'get',
					  onSuccess: function(getdetailback){
					  document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
					  },
					  onFailure: function(){ 
					  alert('Error Add/Delete Serial'); },		
					  
					  onComplete: function(transport){
					  getResult();
					  }
					})
					<!---
					ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
				  setTimeout('getResult();',750);--->
				  
					<!---DWREngine._execute(_tranflocation, null, 'addNewSerialno2',
						type,refno,trancode,custno,period,date,qty,seriallen.value.length,escape(itemno),serialnofr.value,serialnoto.value,prefix,endfix,agenno,location,currrate,sign,price,SerialnoStatus
						--->
						}
			}
			
			function addNewSerialno3(){
				var itemno= document.serialForm.itemno.value;
				var serialnofr=document.serialForm.autoserialnofrom;
				var serialnoto=document.serialForm.autoserialnoto;

				if(serialnofr.value=='-' || serialnoto.value=='-')
				{alert("Please make sure you have select/key-in Serial No.");}
				else if(serialnofr.value.search(/,/)!=-1 || serialnoto.value.search(/,/)!=-1){alert("',' is not allow.");}
				else{
				
				var ajaxurl = 'serialnoaddnew3ajax.cfm?itemno='+escape(encodeURIComponent(itemno))+'&date='+escape(date)+'&refno='+escape(refno)+'&type='+escape(type)+'&trancode='+escape(trancode)+'&custno='+escape(custno)+'&period='+escape(period)+'&qty='+escape(qty)+'&agenno='+escape(agenno)+'&location='+escape(xlocation)+'&currrate='+escape(currrate)+'&sign='+escape(sign)+'&price='+escape(price)+'&serialnofr='+escape(serialnofr.value)+'&serialnoto='+escape(serialnoto.value);
<!---
					new Ajax.Request(ajaxurl,
					{
					  method:'get',
					  onSuccess: function(getdetailback){
					  document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
					  },
					  onFailure: function(){ 
					  alert('Error Add/Delete Serial'); },		
					  
					  onComplete: function(transport){
					  getResult();
					  }
					})
					--->
					ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
				  setTimeout('getResult();',750);
				  
					<!---DWREngine._execute(_tranflocation, null, 'addNewSerialno2',
						type,refno,trancode,custno,period,date,qty,seriallen.value.length,escape(itemno),serialnofr.value,serialnoto.value,prefix,endfix,agenno,location,currrate,sign,price,SerialnoStatus
						--->
				
				}
			}
			
			function deleteSerialno(serialno){
				
				var itemno= document.serialForm.itemno.value;
				var ajaxurl = 'serialnoaddnewajax.cfm?proces=Delete&itemno='+escape(encodeURIComponent(itemno))+'&serialno='+escape(serialno)+'&date='+escape(date)+'&refno='+escape(refno)+'&type='+escape(type)+'&trancode='+escape(trancode)+'&custno='+escape(custno)+'&period='+escape(period)+'&qty='+escape(qty)+'&agenno='+escape(agenno)+'&location='+escape(xlocation)+'&currrate='+escape(currrate)+'&sign='+escape(sign)+'&price='+escape(price);

				   new Ajax.Request(ajaxurl,
					{
					  method:'get',
					  onSuccess: function(getdetailback){
					  document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
					  },
					  onFailure: function(){ 
					  alert('Error Add/Delete Serial'); },		
					  
					  onComplete: function(transport){
					  getResult();
					  }
					})
				  
				  <!---ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
				  setTimeout('getResult();',750);--->
			}
			
			
			function changectg(serialno,ctgno){
				var itemno= document.serialForm.itemno.value;
				var ajaxurl = 'changectg.cfm?itemno='+escape(encodeURIComponent(itemno))+'&serialno='+escape(serialno)+'&date='+escape(date)+'&refno='+escape(refno)+'&type='+escape(type)+'&trancode='+escape(trancode)+'&custno='+escape(custno)+'&period='+escape(period)+'&qty='+escape(qty)+'&agenno='+escape(agenno)+'&location='+escape(xlocation)+'&currrate='+escape(currrate)+'&sign='+escape(sign)+'&price='+escape(price)+'&ctgno='+escape(ctgno);

				   new Ajax.Request(ajaxurl,
					{
					  method:'get',
					  onSuccess: function(getdetailback){
					  document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
					  },
					  onFailure: function(){ 
					  alert('Error Changing ASA Roll'); },		
					  
					  onComplete: function(transport){
					  getResult();
					  }
					})
				  
				  <!---ajaxFunction(document.getElementById('ajaxFieldPro'),ajaxurl);
				  setTimeout('getResult();',750);--->
			}
			
			function SerialnoStatus(status){
				if(status.search(/success/i)!=-1){
					exceptStatus();getSerialTable();
					if(status.search(/insert/i)!=-1){document.serialForm.text_serialno.value='';}
					else{exceptStatus();}
				}//alert(status);
			}
			
			
			<!--- Add/Delete Serial no End --->
			function init(){
				
				DWRUtil.useLoadingMessage();
				DWREngine._errorHandler=errorHandler;
				exceptStatus();
				getSerialTable();
			}
			
			function change(layer_ref,state){ 
			if (document.all){ //IS IE 4 or 5 (or 6 beta) 
			eval( "document.all." + layer_ref + ".style.display = state"); 
			} 
			if (document.layers) { //IS NETSCAPE 4 or below 
			document.layers[layer_ref].display = state; 
			} 
			if (document.getElementById &&!document.all) { 
			hza = document.getElementById(layer_ref); 
			hza.style.display = state; 
			} 
		} 
		
		function handleEnter(event){
			var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
			if(keyCode==13){addNewSerialno();return false;}
			return true;
		}
		</script>
        
	</head>
	
    	<cfquery name="getremainingserialno" datasource="#dts#">
        select * from iserial where type='#form.tran#' and refno='#form.nexttranno#' and trancode='#form.itemcount#' and itemno='#itemno#'
        </cfquery>
        <!---
        <cfif lcase(hcomid) eq "asaiki_i" and tran eq 'SAM'> 
        <cfset ctgnolist=valuelist(getremainingserialno.ctgno)>
        </cfif>--->
        
        <cfquery name="getaddedserialno" datasource="#dts#">
            select * from (
            Select serialno,sum(sign) as sign
            from iserial 
            where itemno='#itemno#'
            and (void is null or void='')
            group by serialno
            order by serialno) as a
            where a.sign=1
            LIMIT 500
        </cfquery>
        
        <cfif (lcase(hcomid) eq "asaiki_i" or lcase(hcomid) eq "supporttest_i") and tran eq 'SAM'> 
        
        <cfquery name="getaddedserialno2" datasource="#dts#">
            select * from (
                Select serialno,sum(sign) as sign
                from iserial 
                where itemno='#form.itemno#'
                and location='#form.location#' and serialno like '#form.enterbatch#%'
                and (void is null or void='')
                group by serialno
                order by serialno) as a
            where a.sign=1
            order by a.serialno
        </cfquery>
        
        <cfelse>
        
        <cfquery name="getaddedserialno2" datasource="#dts#">
            select * from (
                Select serialno,sum(sign) as sign
                from iserial 
                where itemno='#form.itemno#'
                and location='#form.location#' and type<>'SAM'
                and (void is null or void=''
            )
            group by serialno
            order by serialno) as a
            where a.sign=1
            order by a.serialno
            <!---LIMIT 500--->
        </cfquery>
        
		</cfif>
    
    
	<body>
    
		<h1>Serial No Selection Screen</h1>
		<br>
		<cfform name="serialForm">
        
			<cfoutput>
            <input type="hidden" name="itemno" id="itemno" value="#convertquote(form.itemno)#">

			</cfoutput>
        <div id="serialtablelist">
		<table class="data">
		<tr>
			<th>Reference No</th>
			<th>Customer No</th>
			<th>Itemno</th>
			<th>Total Qty</th>
			<th>Qty To Be Select</th>
			<cfif sign eq 1><th>Added <cfoutput>#getgsetup.lserial#</cfoutput>. List</th></cfif>
		</tr>
		<cfoutput>
		<tr>
			<td>#form.nexttranno#</td>
			<td>#form.custno#</td>
			<td>#form.itemno#</td>
			<td align="center">#form.qty#</td>
			<td align="center">#getremainingserialno.recordcount#<input type="hidden" id="totalitemqty" name="totalitemqty" value="#form.qty#"></td>
			<cfif sign eq 1><td><select name="added_serialno">
            <cfloop query="getaddedserialno">
            <option value="#getaddedserialno.serialno#">#getaddedserialno.serialno#</option>
            </cfloop>
            </select></td></cfif>
		</tr>
		</cfoutput>
		</table>
        </div>
        <div id="ajaxFieldPro"></div>
		<br>
        <cfif getgsetup.serialnorun eq 'Y' and form.tran eq "INV" or form.tran eq "DO" or form.tran eq "DN" or form.tran eq "ISS" or form.tran eq "SAM">
        <cfoutput>
        <table class="data">
            <tr>
              <th rowspan="2" width="100px"><cfoutput>#getgsetup.lserial#</cfoutput></th>     
              <th>Running Number From :</th>
              <td>
              <cfif lcase(hcomid) eq "omegasparkles_i">
              <input type="text" name="autoserialnofrom" id="autoserialnofrom" value="">
              <cfelse>
              <select name="autoserialnofrom" id="autoserialnofrom" onChange="document.getElementById('serialcount').value=document.getElementById('autoserialnoto').selectedIndex-document.getElementById('autoserialnofrom').selectedIndex+1">
              	<cfloop query="getaddedserialno2">
            	<option value="#getaddedserialno2.serialno#">#getaddedserialno2.serialno#</option>
            	</cfloop>
              </select>
              </cfif></td>
            </tr>
            <tr>
              <th>Running Number To :</th>
              <td>
              <cfif lcase(hcomid) eq "omegasparkles_i">
              <input type="text" name="autoserialnoto" id="autoserialnoto" value="">
              <cfelse>
              <select name="autoserialnoto" id="autoserialnoto" onChange="document.getElementById('serialcount').value=document.getElementById('autoserialnoto').selectedIndex-document.getElementById('autoserialnofrom').selectedIndex+1">
              <cfloop query="getaddedserialno2">
              <option value="#getaddedserialno2.serialno#">#getaddedserialno2.serialno#</option>
              </cfloop>
              </select></cfif></td>
            </tr>
            <tr>
              <th><cfoutput>#getgsetup.lserial#</cfoutput> Selected</th>
              <td><input type="text" name="serialcount" id="serialcount" size="5" /></td>
              <td><input type="button" name="add_text3" value="Range Add" onClick="addNewSerialno3()"></td>
            </tr>
          </table>
        </cfoutput>
		</cfif>
        <cfif getgsetup.serialnorun eq 'Y' and (form.tran eq 'RC' or form.tran eq "OAI" or form.tran eq "CN")>
          <table class="data">
            <tr>
              <th rowspan="4" width="100px"><cfoutput>#getgsetup.lserial#</cfoutput></th>
              <th width="150px">Prefix :</th>
              <td><input type="text" name="prefix" id="prefix" value="" size="5" /></td>
            </tr>
            <tr>
              <th>Running Number From :</th>
              <td><cfinput type="text" name="runningnumfr" id="runningnumfr" value="" size="10" /></td>
            </tr>
            <tr>
              <th>Running Number To :</th>
              <td><cfinput type="text" name="runningnumto" id="runningnumto" value="" size="10" /></td>
            </tr>
            <tr>
              <th>End Fix :</th>
              <td><input type="text" name="endfix" id="endfix" size="5" /></td>
              <td><input type="button" name="add_text2" value="Add" onClick="addNewSerialno2()"></td>
            </tr>
          </table>
        </cfif>
        <div id="addedserialnolist">
		<table class="data">
		<tr>
			<th width="50">No</th>
            <cfif type eq 'SAM' and (dts eq "asaiki_i" or lcase(hcomid) eq "supporttest_i")>
            <th>ASA ROLL</th>
            </cfif>
			<th><cfoutput>#listfirst(getgsetup.lserial)#</cfoutput></th>
			<th width="70">Action</th>
		</tr>
        <cfoutput>
        <input type="hidden" name="totaladdedserial" id="totaladdedserial" value="#getremainingserialno.recordcount#" />
		<cfif getremainingserialno.recordcount neq 0>
        <cfloop query="getremainingserialno">
        <tr>
        <td>#getremainingserialno.currentrow#</td>
        <cfif type eq 'SAM' and (dts eq "asaiki_i" or lcase(hcomid) eq "supporttest_i")>
        <td>
        <select name="ctgno" id="ctgno" onChange="changectg('#getremainingserialno.serialno#',this.value);">
            <cfloop from="1" to="999" index="i">
            <option value="#numberformat(i,'000')#" <cfif getremainingserialno.ctgno eq numberformat(i,'000')>selected</cfif>>#numberformat(i,'000')#</option>

            </cfloop>
        </select>
        </td>
        </cfif>
        <td><a href="javascript:void(0)" onClick="PopupCenter('changeserial.cfm?tran=#getremainingserialno.type#&nexttranno=#getremainingserialno.refno#&trancode=#getremainingserialno.trancode#&serialno=#getremainingserialno.serialno#','linkname','300','150');">#getremainingserialno.serialno#</a></td>
        <td><input type="button" name="delete" value="delete" onClick="deleteSerialno('#getremainingserialno.serialno#')"></td>
        </tr>
        </cfloop>
        </cfif>
        </cfoutput>
        <cfif getremainingserialno.recordcount lt qty>
        <cfif sign eq '-1'>
        <cfoutput>
		<tr>
			<td>New</td>
			<td align="right">
            
            <select name="select_serialno" id="select_serialno" onkeypress="return handleEnter(event)">
            <cfloop query="getaddedserialno2">
            <option value="#getaddedserialno2.serialno#">#getaddedserialno2.serialno#</option>
            </cfloop>
            </select>

            <input type="text" name="serialnoselect" id="serialnoselect" value="" onKeyPress="return handleEnter(event)">

            </td>
			<td><input type="button" name="add" value="Add" onClick="addNewSerialno()"></td>
		</tr>
        </cfoutput>
        </cfif>
        <cfif sign eq '1'>
		<tr>
			<td>New</td>
			<td align="right"><input type="text" name="text_serialno" id="text_serialno" maxlength="<cfif lcase(hcomid) neq "dental_i" or lcase(hcomid) neq "dental10_i" or lcase(hcomid) neq "mfss_i" or lcase(hcomid) neq "hcss_i" or lcase(hcomid) neq "iaf_i" or lcase(hcomid) eq "scpl_i" or lcase(hcomid) eq "mfssmy_i">100<cfelse>100</cfif>" size="30" onKeyPress="return handleEnter(event)"></td>
			<td><input type="button" name="add_text" value="Add" onClick="addNewSerialno()"></td>
		</tr>
        </cfif>
        </cfif>
		</table>
        </div>
		</cfform>
		
		<cfif form.tran neq "OAI" and form.tran neq "OAR" and form.tran neq "ISS">
			<cfoutput>
			<form name="done" action="../transaction/transaction3.cfm?complete=complete" method="post" onSubmit="return validateserial();">
				<input type="hidden" name="tran" value="#form.tran#">
				<input type="hidden" name="currrate" value="#form.currrate#">
				<input type="hidden" name="agenno" value="#form.agenno#">
				<input type="hidden" name="nexttranno" value="#form.nexttranno#">
				<input type="hidden" name="custno" value="#form.custno#">
				<input type="hidden" name="readperiod" value="#form.readperiod#">
				<input type="hidden" name="nDateCreate" value="#form.nDateCreate#">
				<input type="hidden" name="invoicedate" value="#form.invoicedate#">
				
				<input type="hidden" name="refno3" value="#form.refno3#">
				<input type="hidden" name="status" value="#form.status#">
				<input type="hidden" name="type" value="#form.type#">
				<input type="hidden" name="hmode" value="#form.hmode#">
				<cfif isdefined("form.updunitcost")><input type='hidden' name='updunitcost' value='#form.updunitcost#'></cfif>
				<input type="submit" name="Submit2" value="Finish">
			</form>
			</cfoutput>
		<cfelse>
			<cfoutput>
			<form name="done" action="../transaction/iss3.cfm?complete=complete" method="post" onSubmit="return validateserial();">
				<input type="hidden" name="tran" value="#form.tran#">
				<input type="hidden" name="agenno" value="#form.agenno#">
				<input type="hidden" name="nexttranno" value="#form.nexttranno#">
				<input type="hidden" name="custno" value="#form.custno#">
				<input type="hidden" name="readperiod" value="#form.readperiod#">
				<input type="hidden" name="nDateCreate" value="#form.nDateCreate#">
				<input type="hidden" name="invoicedate" value="#form.invoicedate#">
				
				<input type="hidden" name="type" value="Inprogress">
				<input type="hidden" name="status" value="#status#">
				<input type="hidden" name="name" value="#form.name#">
				<!--- Add on 260808 --->
				<input type="hidden" name="hmode" value="#form.hmode#">
				<input type="submit" name="Submit2" value="Finish">
			</form>
			</cfoutput>
		</cfif>
	</body>
	</html>
<cfelse>
	<cfquery name="getUnwantedRecord" datasource="#dts#">
		select serialno from iserial 
		where type='form.tran' and itemno='#form.itemno#' and refno='#form.nexttranno#' and trancode='#form.itemcount#'
	</cfquery>
	<cfif getUnwantedRecord.recordcount gt 0>
		<cfquery name="deleteRecord" datasource="#dts#">
			delete from iserial where itemno='#form.itemno#' and 
			serialno in ('#valuelist(getUnwantedRecord.serialno,"','")#')
		</cfquery>
		<cflog file="tran_serial" text="deleted Serial : #valuelist(getUnwantedRecord.serialno)# (#HcomID#-#HUserID#)">
	</cfif>
		
	<cfif form.tran neq "OAI" and form.tran neq "OAR" and form.tran neq "ISS">
		<cfoutput>
		<form name="done" action="../transaction/transaction3.cfm?complete=complete" method="post">
			<input type="hidden" name="tran" value="#form.tran#">
			<input type="hidden" name="currrate" value="#form.currrate#">
			<input type="hidden" name="agenno" value="#form.agenno#">
			<input type="hidden" name="nexttranno" value="#form.nexttranno#">
			<input type="hidden" name="custno" value="#form.custno#">
			<input type="hidden" name="readperiod" value="#form.readperiod#">
			<input type="hidden" name="nDateCreate" value="#form.nDateCreate#">
			<input type="hidden" name="invoicedate" value="#form.invoicedate#">
			
			<input type="hidden" name="refno3" value="#form.refno3#">
			<input type="hidden" name="status" value="#form.status#">
			<input type="hidden" name="type" value="#form.type#">
			<input type="hidden" name="hmode" value="#form.hmode#">
			<cfif isdefined("form.updunitcost")><input type='hidden' name='updunitcost' value='#form.updunitcost#'></cfif>
		</form>
		</cfoutput>
	<cfelse>
		<cfoutput>
		<form name="done" action="../transaction/iss3.cfm?complete=complete" method="post">
			<input type="hidden" name="tran" value="#form.tran#">
			<input type="hidden" name="currrate" value="#form.currrate#">
			<input type="hidden" name="agenno" value="#form.agenno#">
			<input type="hidden" name="nexttranno" value="#form.nexttranno#">
			<input type="hidden" name="custno" value="#form.custno#">
			<input type="hidden" name="readperiod" value="#form.readperiod#">
			<input type="hidden" name="nDateCreate" value="#form.nDateCreate#">
			<input type="hidden" name="invoicedate" value="#form.invoicedate#">
			
			<input type="hidden" name="type" value="Inprogress">
			<input type="hidden" name="status" value="#status#">
			<input type="hidden" name="name" value="#form.name#">
			<!--- Add on 260808 --->
			<input type="hidden" name="hmode" value="#form.hmode#">
			<input type="submit" name="Submit2" value="Finish">
		</form>
		</cfoutput>
	</cfif>
	<script>done.submit();</script>
</cfif>
