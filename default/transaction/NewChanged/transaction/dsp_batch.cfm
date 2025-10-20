<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<cfquery name='getgsetup2' datasource='#dts#'>
  	select concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,Decl_Uprice as Decl_Uprice1, concat('.',repeat('_',DECL_DISCOUNT)) as DECL_DISCOUNT1, DECL_DISCOUNT from gsetup2
</cfquery>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfquery name="getbatchname" datasource="#dts#">
SELECT lbatch FROM gsetup
</cfquery>
<html>
<head>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	
	<script type='text/javascript' src='../../ajax/core/engine.js'></script>
	<script type='text/javascript' src='../../ajax/core/util.js'></script>
	<script type='text/javascript' src='../../ajax/core/settings.js'></script>
	
	<script type="text/javascript">
		<cfoutput>
			var fixnum=#getgsetup2.Decl_UPrice1#;
		</cfoutput>
		function onlyNumbers(evt)
		{
			var e = event || evt; // for trans-browser compatibility
			var charCode = e.which || e.keyCode;

			if (charCode > 31 && (charCode < 48 || charCode > 57) && (event.keyCode != 46))
				return false;

			return true;

		}
		
		function update(batchcode){
			
			document.form1.enterbatch2.value = document.form1.enterbatch.value;
			
			if(document.form1.enterbatch.value != ""){
				document.form1.enterbatch2.readOnly = true;
				updateDetails(document.form1.enterbatch.value);
			}
			else{
				if(document.form1.tran.value=='RC' || document.form1.tran.value=='OAI' || document.form1.tran.value=='CN'){
					document.form1.enterbatch2.readOnly = false;
				}
				else{
					<cfif checkcustom.customcompany eq "Y">
						document.form1.permit_no.value = '';
						document.form1.permit_no2.value = '';
					</cfif>
				}
			}
		}
		
		function update2(batchcode){			
			document.form1.xbatchcode2.value = batchcode;
			if(batchcode == ''){
				document.form1.expdate.value = '';
				document.form1.manudate.value = '';
				document.form1.milcert.value = '';
				document.form1.enterbatch2.value = '';
				document.form1.permit_no.value = '';
				document.form1.permit_no2.value = '';
				document.form1.batchqty.value='0';
			}else{
				updateDetails(batchcode);
			}
		}
		
		function updateDetails(batchcode){
			var tran = document.form1.tran.value;
			var location = document.form1.location.value;
			var itemno = document.form1.itemno.value;
			DWREngine._execute(_tranflocation, null, 'getBatchDetails', location, batchcode, itemno, tran, showBatchDetails);
		}
		
		function showBatchDetails(BatchObject){
			DWRUtil.setValue("expdate", BatchObject.EXPDATE);
			if(BatchObject.TRAN != 'RC'){
				var factor1=document.form1.factor1.value;
				var factor2=document.form1.factor2.value;
				if(parseFloat(factor1) != 0){
					dbatchqty=BatchObject.BATCHQTY*parseFloat(factor2)/(parseFloat(factor1));
				}
				else{
					dbatchqty=0;
				}
				
				DWRUtil.setValue("batchqty",dbatchqty);
				DWRUtil.setValue("validqty",dbatchqty);
			}
			<cfif checkcustom.customcompany eq "Y">
				if(BatchObject.TRAN != 'RC' && BatchObject.TRAN != 'OAI' && BatchObject.TRAN != 'CN'){
					DWRUtil.setValue("permit_no", BatchObject.PERMIT_NO);
					DWRUtil.setValue("permit_no2", BatchObject.PERMIT_NO2);
					if(BatchObject.TRAN == 'TR'){
						assignLot();
					}
				}
			</cfif>
		}
		
		function UpdateBatch(){
			
			var location = document.form1.location.value;
			var batchcode = document.form1.enterbatch2.value;
			var oldenterbatch = document.form1.oldenterbatch.value;
			var mc1bil = document.form1.mc1bil.value;
			var mc2bil = document.form1.mc2bil.value;
			var sodate = document.form1.sodate.value;
			var dodate = document.form1.dodate.value;
			var expdate = document.form1.expdate.value;
			var manudate = document.form1.manudate.value;
			var milcert = document.form1.milcert.value;
			var price_bil = document.form1.price_bil.value;
			
			for (i=0;i<document.form1.defective.length;i++) 
			{ 
				if(document.form1.defective[i].checked){ 
					defective = document.form1.defective[i].value; 
				} 
			}
			
			if(batchcode == ""){
				batchcode = " ";
			}
			
			if(oldenterbatch == ""){
				oldenterbatch = " ";
			}
			if(mc1bil == ""){
				mc1bil = " ";
			}
			if(mc2bil == ""){
				mc2bil = " ";
			}
			if(sodate == ""){
				sodate = " ";
			}
			if(dodate == ""){
				dodate = " ";
			}
			if(expdate == ""){
				expdate = " ";
			}
			if(manudate == ""){
				manudate = " ";
			}
			if(milcert == ""){
				milcert = " ";
			}
			if(defective == ""){
				defective = " ";
			}
			
			<cfif type eq "TR" and (checkcustom.customcompany eq "Y")>
				opener.document.form1.enterbatch.value = document.form1.xbatchcode2.value;
				opener.document.getElementById("oldenterbatch").value = document.form1.obatchcode2.value;
				opener.document.form1.batchcode2.value = batchcode;
			<cfelse>
				opener.document.form1.enterbatch.value = batchcode;
				opener.document.getElementById("oldenterbatch").value = oldenterbatch;
			</cfif>
			
			//opener.document.form1.enterbatch.value = batchcode;
			//opener.document.getElementById("oldenterbatch").value = oldenterbatch;
			opener.document.getElementById("mc1bil").value = mc1bil;
			opener.document.getElementById("mc2bil").value = mc2bil;
			opener.document.getElementById("sodate").value = sodate;
			opener.document.getElementById("dodate").value = dodate;
			opener.document.getElementById("expdate").value = expdate;
			opener.document.getElementById("manudate").value = manudate;
			<cfif type neq "TR">
			opener.document.getElementById("milcert").value = milcert;
			</cfif>
			opener.document.getElementById("defective").value = defective;
			if(document.form1.batchqty.value == ""){
				document.form1.batchqty.value = '0';
			}
			<cfif type neq "ISS" and type neq "OAI" and type neq "OAR" and type neq "TR">
				opener.document.form1.qt6.value = document.form1.batchqty.value;
			</cfif>
			opener.document.form1.qty.value = document.form1.batchqty.value;
			//opener.document.form1.qt6.value = document.form1.batchqty.value;
			opener.document.form1.amt.value = (document.form1.batchqty.value * price_bil).toFixed(fixnum);
			
			<cfif (checkcustom.customcompany eq "Y") and (type neq "RC" and type neq "OAI" and type neq "CN" and type neq "TR")>
				opener.document.form1.hremark5.value = document.form1.permit_no.value;
				opener.document.form1.hremark6.value = document.form1.permit_no2.value;
				opener.document.form1.bremark8.value = document.form1.bremark8.value;
				opener.document.form1.bremark9.value = document.form1.bremark9.value;
				opener.document.form1.bremark10.value = document.form1.bremark10.value;
			<cfelseif (checkcustom.customcompany eq "Y") and type eq "TR">
				opener.document.form1.bremark5.value = document.form1.permit_no.value;
				opener.document.form1.bremark7.value = document.form1.permit_no2.value;
				opener.document.form1.bremark8.value = document.form1.bremark8.value;
				opener.document.form1.bremark9.value = document.form1.bremark9.value;
				opener.document.form1.bremark10.value = document.form1.bremark10.value;
				if(document.form1.trtype.checked == true){
					opener.document.form1.bremark6.value='I';
					opener.document.form1.hremark5.value=document.form1.permit_no.value;
					opener.document.form1.hremark6.value = document.form1.permit_no2.value;
				}else{
					opener.document.form1.bremark6.value='E';
				}
			</cfif>
			
			window.close();
		}
		
		function checkExist(){
			
			var batchcode = document.form1.enterbatch2.value;
			var obatchcode = document.form1.oldenterbatch.value;
			DWREngine._execute(_tranflocation, null, 'checkLotNumberExist',batchcode,obatchcode, showLotNumberResult);
		}
		
		function showLotNumberResult(LotObject){
			if(LotObject.EXISTENCE == 'yes'){
				alert('This Lot Number Already Used!');
			}
			else{				
				UpdateBatch();
			}
		}
		
		function assignLot(){
			if(document.form1.trtype.checked == true){
				document.form1.enterbatch2.value=document.form1.xbatchcode2.value;
			}else{
				document.form1.enterbatch2.value=document.form1.lotnobackup.value;
			}
		}
		
		function checkValidQty(){
			document.form1.btnOK.disabled=false;
			if(document.form1.validqty.value != ''){
				if(document.form1.enterbatch2.value==document.form1.oldenterbatch.value){
					var factor1=document.form1.factor1.value;
					var factor2=document.form1.factor2.value;
					if(parseFloat(factor1) != 0){
						doldqty=parseFloat(document.form1.oldqty.value)*parseFloat(factor2)/(parseFloat(factor1));
					}
					else{
						doldqty=0;
					}
					dvalidqty=parseFloat(document.form1.validqty.value)+doldqty;
				}
				else{
					dvalidqty=parseFloat(document.form1.validqty.value);
				}
				if(parseFloat(document.form1.batchqty.value) > dvalidqty){
					alert("Quantity more than Balance!");
					//document.form1.btnOK.disabled=true;
				}
			}
		}
		
		
	</script>
</head>

<cfset xbatchcode1 = "">
<cfparam name="qty" default="0">

<cfquery name="getitembatch" datasource="#dts#">
	<cfif trim(url.location) neq "">
		<cfif lcase(hcomid) eq "remo_i">
			select a.location,a.batchcode,a.itemno,
			a.rc_type,a.rc_refno,((a.bth_qob+a.bth_qin)-a.bth_qut-ifnull(b.soqty,0)) as batch_balance,
			a.expdate as exp_date,a.manudate as manu_date ,a.milcert
			from lobthob as a 
			left join 
			(
				select 
				batchcode,
				itemno,
				location, 
				sum(qty) as soqty 
				from ictran 
				where type='SO' 
				and itemno='#url.itemno#' 
				and location='#url.location#'
				and (qty-shipped)<>0 
				and fperiod<>'99' 
				and (void = '' or void is null) 
				group by location,batchcode
				order by location,batchcode
			) as b on a.itemno=b.itemno and a.batchcode=b.batchcode and a.location=b.location
			where a.location='#url.location#'
			and a.itemno='#url.itemno#' 
			and ((a.bth_qob+a.bth_qin)-a.bth_qut-ifnull(b.soqty,0)) >0 
			order by a.itemno
		<cfelseif (checkcustom.customcompany eq "Y") and url.type eq "TR">
			select 
			batchcode,rc_type,rc_refno,
			((bth_qob+bth_qin)-bth_qut) as batch_balance,
			expdate as exp_date, manudate as manu_date,milcert
			from lobthob 
			where location='#url.trfrom#' 
			and itemno='#url.itemno#' 
			and ((bth_qob+bth_qin)-bth_qut) <>0 
			order by itemno
		<cfelse>
			select 
			batchcode,rc_type,rc_refno,
			((bth_qob+bth_qin)-bth_qut) as batch_balance,
			expdate as exp_date , manudate as manu_date,milcert
			from lobthob 
			where location='#url.location#' 
			and itemno='#url.itemno#' 
			and ((bth_qob+bth_qin)-bth_qut) <>0 
			order by itemno
		</cfif>
	<cfelse>
		<cfif HcomID eq "remo_i">
			select 
			a.batchcode,
			a.itemno,
			a.rc_type,
			a.rc_refno,
			((a.bth_qob+a.bth_qin)-a.bth_qut-ifnull(b.soqty,0)) as batch_balance,
			a.exp_date 
			from obbatch as a 
			left join 
			(
				select 
				batchcode,
				itemno, 
				sum(qty) as soqty 
				from ictran 
				where type='SO' 
				and itemno='#url.itemno#' 
				and (qty-shipped)<>0 
				and fperiod<>'99' 
				and (void = '' or void is null) 
				group by batchcode 
				order by batchcode 
			) as b on a.itemno=b.itemno and a.batchcode=b.batchcode 
			where a.itemno='#url.itemno#' 
			and ((a.bth_qob+a.bth_qin)-a.bth_qut-ifnull(b.soqty,0)) >0 
			order by a.itemno
		<cfelse>
			select 
			batchcode,
			rc_type,
			rc_refno,
			((bth_qob+bth_qin)-bth_qut) as batch_balance,
			exp_date 
			from obbatch 
			where itemno='#url.itemno#'  
			and ((bth_qob+bth_qin)-bth_qut) <>0 
			order by itemno
		</cfif>
	</cfif>
			
</cfquery>
<cfif url.type neq "TR">
	<cfquery name="getinfo" datasource="#dts#">
		select 
		location,expdate,qty,manudate,milcert,
		defective,mc1_bil,mc2_bil,
		batchcode,sodate,dodate<cfif checkcustom.customcompany eq "Y">,brem5,brem7,brem8,brem9,brem10</cfif> 
		from ictran 
		where location='#url.location#'  
		and itemno='#url.itemno#' 
		and type='#url.type#'
		and refno ='#url.refno#'
		and itemcount='#url.trancode#'
	</cfquery>
<cfelse>
	<cfquery name="getinfo" datasource="#dts#">
		select 
		location,expdate,qty,manudate,milcert,
		defective,mc1_bil,mc2_bil,
		batchcode,sodate,dodate<cfif checkcustom.customcompany eq "Y">,brem5,brem6,brem7</cfif> 
		from ictran 
		where location='#url.trto#'  
		and itemno='#url.itemno#' 
		and type='TRIN'
		and refno ='#url.refno#'
		and itemcount='#url.trancode#'
	</cfquery>
	<cfif checkcustom.customcompany eq "Y">
		<cfquery name="getinfo2" datasource="#dts#">
			select batchcode<cfif checkcustom.customcompany eq "Y">,brem5,brem7,brem8,brem9,brem10</cfif>
			from ictran 
			where location='#url.trfrom#'  
			and itemno='#url.itemno#' 
			and type='TROU'
			and refno ='#url.refno#'
			and itemcount='#url.trancode#'
		</cfquery>
		<cfif getinfo2.recordcount neq 0>
			<cfset xbatchcode2=getinfo2.batchcode>
			<cfset obatchcode2=getinfo2.batchcode>
			<cfset permitno=getinfo2.brem5>
			<cfset permitno2=getinfo2.brem7>
			<cfset bremark8=getinfo2.brem8>
			<cfset bremark9=getinfo2.brem9>
			<cfset bremark10=getinfo2.brem10>
		<cfelse>
			<cfquery name="getheader" datasource="#dts#">
				select rem6,rem7,rem8 from artran where type='#url.type#' and refno ='#url.refno#'
			</cfquery>
			<cfset xbatchcode2="">
			<cfset obatchcode2="">
			<cfset permitno="">
			<cfset permitno2="">
			<cfset bremark8=getheader.rem8>
			<cfset bremark9=getheader.rem7>
			<cfset bremark10="">
		</cfif>
	</cfif>
</cfif>

<cfif getinfo.recordcount neq 0>
	<cfset mc1bil = getinfo.mc1_bil>
	<cfset mc2bil = getinfo.mc2_bil>
	<cfset xbatchcode = getinfo.batchcode>
	<cfset defective = getinfo.defective>
	<cfset oldqty = getinfo.qty>
	<cfif getinfo.expdate neq "">
		<cfset expdate = dateformat(getinfo.expdate,"dd-mm-yyyy")>
	<cfelse>
		<cfset expdate = getinfo.expdate>
	</cfif>
    <cfif getinfo.manudate neq "">
		<cfset manudate = dateformat(getinfo.manudate,"dd-mm-yyyy")>
	<cfelse>
		<cfset manudate = getinfo.manudate>
	</cfif>
    <cfset milcert = getinfo.milcert>
	<cfif getinfo.sodate neq "">
		<cfset sodate = dateformat(getinfo.sodate,"dd-mm-yyyy")>
	<cfelse>
		<cfset sodate = getinfo.sodate>
	</cfif>
	<cfif getinfo.dodate neq "">
		<cfset dodate = dateformat(getinfo.dodate,"dd-mm-yyyy")>
	<cfelse>
		<cfset dodate = getinfo.dodate>
	</cfif>
	<cfset obatchcode = getinfo.batchcode>
	<cfif checkcustom.customcompany eq "Y">
		<cfif url.type neq "TR">
			<cfset permitno=getinfo.brem5>
			<cfset permitno2=getinfo.brem7>
			<cfset bremark8=getinfo.brem8>
			<cfset bremark9=getinfo.brem9>
			<cfset bremark10=getinfo.brem10>
		<cfelse>
			<cfset trtype=getinfo.brem6>	<!--- Transfer type, I: Internal Transfer; E: External Transfer --->
		</cfif>
	</cfif>
<cfelse>
	<cfset mc1bil = "0.00">
	<cfset mc2bil = "0.00">
	<cfset xbatchcode = "">
	<cfset obatchcode ="">
	<cfset expdate = "">
    <cfset manudate = "">
    <cfset milcert = "">
    
	<cfset sodate = "">
	<cfset dodate = "">
	<cfset defective = "">
	<cfset oldqty = "0">
	<cfif checkcustom.customcompany eq "Y">
		<cfif url.type neq "TR">
			<cfquery name="getheader" datasource="#dts#">
				select rem6,rem7,rem8 from artran where type='#url.type#' and refno ='#url.refno#'
			</cfquery>
			<cfset permitno="">
			<cfset permitno2="">
			<cfset bremark8=getheader.rem8>
			<cfset bremark9=getheader.rem7>
			<cfset bremark10=getheader.rem6>
		<cfelse>
			<cfset trtype="E">	<!--- Transfer type, I: Internal Transfer; E: External Transfer --->
		</cfif>
	</cfif>
</cfif>
<cfif checkcustom.customcompany eq "Y">
	<cfif xbatchcode eq "" and (url.type eq "RC" or url.type eq "CN" or url.type eq "OAI" or url.type eq "TR")>
		<cfquery name="getlotno" datasource="#dts#">
			select lotno,lotnorun from gsetup
		</cfquery>
		<cfif getlotno.lotno neq "" and getlotno.lotnorun eq "1">

			<cfinvoke component="cfc.refno" method="processNum" oldNum="#getlotno.lotno#" returnvariable="xbatchcode" />
		<cfelse>

			<cfset xbatchcode = "">
		</cfif>
		<cfif url.type eq "TR" and trtype eq "I">
			<cfset xbatchcode = "">
		</cfif>
	</cfif>
	<cfset lotnobackup=xbatchcode>
</cfif>
<body>
<h1 align="center"><cfif trim(url.location) neq ""><cfoutput><font color="red">#url.location#</font></cfoutput>: </cfif>Select <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse>#getbatchname.lbatch#</cfif> For Item <cfoutput><font color="red">#url.itemno#</font></cfoutput></h1>
<form name="form1" action="" method="post">
<cfoutput>	
	<input type="hidden" name="location" id="location" value="#url.location#">
	<input type="hidden" name="tran" id="tran" value="#url.type#">
	<input type="hidden" name="refno" id="refno" value="#url.refno#">
	<input type="hidden" name="trancode" id="trancode" value="#url.trancode#">
	<input type="hidden" name="itemno" id="itemno" value="#convertquote(url.itemno)#">
	<input type="hidden" name="price_bil" id="price_bil" value="#url.price#">
    
	<cfif isdefined('url.factor1') eq false>
    <cfset url.factor1 = 1>
    </cfif>
    
    <cfif isdefined('url.factor2') eq false>
    <cfset url.factor2 = 1>
    </cfif>
    
	<input type="hidden" name="factor1" id="factor1" value="#url.factor1#">
	<input type="hidden" name="factor2" id="factor2" value="#url.factor2#">
<table align="center">
	<cfif (checkcustom.customcompany eq "Y") and url.type eq "TR">
		<tr>
			<th>Internal Transfer</th>
			<td><input name="trtype" id="trtype" type="checkbox" value="#trtype#" onChange="assignLot();" <cfif trtype eq "I">checked</cfif>></td>
			<input type="hidden" name="lotnobackup" id="lotnobackup" value="#lotnobackup#">
		</tr>
	</cfif>
	<tr>
		<th>Other Charges 1</th>
		<td><input name="mc1bil" id="mc1bil" type="text" size="10" value="#numberformat(mc1bil,'0.00')#" onKeyPress="return onlyNumbers();"></td>
	</tr>
	<tr>
		<th>Other Charges 2</th>
		<td><input name="mc2bil" id="mc2bil" type="text" size="10" value="#numberformat(mc2bil,'0.00')#" onKeyPress="return onlyNumbers();"></td>
	</tr>
	<tr><td><br></td></tr>
	<tr>
		<th>Sales Order Date</th>
		<td><input name="sodate" id="sodate" type="text" size="10" value="#sodate#">(e.g dd-mm-yyyy)</td>
	</tr>
	<tr>	
		<th>Delivery Date</th>
		<td><input name="dodate" id="dodate" type="text" size="10" value="#dodate#">(e.g dd-mm-yyyy)</td>
	</tr>
	<tr><td><br></td></tr>
	<tr>
		<th><cfif checkcustom.customcompany eq "Y">Lot Number<cfif url.type eq "TR"> (IN)</cfif><cfelse>#getbatchname.lbatch# Code</cfif></th>
		<td>
			<!--- <input name="enterbatch" type="text" size="10" value=""> --->
			<cfif checkcustom.customcompany eq "Y">
				<!--- <cfif (url.type neq "RC" and url.type neq "CN" and url.type neq "OAI" and url.type neq "TR") or xbatchcode eq ""> --->
				<cfif (url.type neq "RC" and url.type neq "CN" and url.type neq "OAI" and url.type neq "TR")> 
					<select name="enterbatch" id="enterbatch" onChange="update(this.value);">
						<option value="">Select one</option>
						<cfloop query="getitembatch">
							<option value="#convertquote(getitembatch.batchcode)#" <cfif xbatchcode eq getitembatch.batchcode>selected</cfif>>#getitembatch.batchcode# (balance: #getitembatch.batch_balance#)</option>
						</cfloop>
					</select> 
					/ 
				</cfif>
				<input name="enterbatch2" id="enterbatch2" type="text" size="10" value="#xbatchcode#"<cfif (url.type neq "RC" and url.type neq "CN" and url.type neq "OAI" and url.type neq "TR") or xbatchcode neq ""> readonly</cfif>>
				<input name="oldenterbatch" id="oldenterbatch" type="hidden" size="10" value="#obatchcode#">
               <cfif xbatchcode eq "" and (url.type eq "RC" or url.type eq "CN" or url.type eq "OAI" or url.type eq "TR")>
                <input type="checkbox" name="checkautorun" id="checkautorun" value="1" onClick="setbatchcode();">
		<cfquery name="getlotno1" datasource="#dts#">
			select lotno,lotnorun from gsetup
		</cfquery>
		<cfif getlotno1.lotno neq "">

			<cfinvoke component="cfc.refno" method="processNum" oldNum="#getlotno1.lotno#" returnvariable="xbatchcode1" />
		<cfelse>
        <cfset xbatchcode1="">
        </cfif>
        <div id="lastbatchcodeno" style="visibility:hidden">
        Last Used Lot Number <input type="text" id="lastusednolot" name="lastusednolot" value="#getlotno1.lotno#" readonly>
        </div>
				</cfif>
<script type="text/javascript">
   function setbatchcode(){
	if(document.getElementById('checkautorun').checked == true)
	{
	document.getElementById('enterbatch2').value='#xbatchcode1#';
	document.form1.enterbatch2.readOnly = true;
	document.getElementById('lastbatchcodeno').style.visibility = "visible";
	}
	else{	
	document.getElementById('enterbatch2').value='';
	document.form1.enterbatch2.readOnly = false;
	document.getElementById('lastbatchcodeno').style.visibility = "hidden";
	}
	}
</script>                
			<cfelse>
				<select name="enterbatch" onChange="update(this.value);">
					<option value="">Select one</option>
					<cfloop query="getitembatch">
						<option value="#convertquote(getitembatch.batchcode)#" <cfif xbatchcode eq getitembatch.batchcode>selected</cfif>>#getitembatch.batchcode# (balance: #getitembatch.batch_balance#)</option>
					</cfloop>
				</select> 
				/ <input name="enterbatch2" id="enterbatch2" type="text" size="10" value="#xbatchcode#"<cfif (url.type neq "RC" and url.type neq "CN" and url.type neq "OAI") or xbatchcode neq ""> readonly</cfif>>
				<input name="oldenterbatch" id="oldenterbatch" type="hidden" size="10" value="#obatchcode#">
			</cfif>
		</td>
        
	</tr>
	
	<cfif (checkcustom.customcompany eq "Y") and url.type eq "TR">
		<tr>
			<th>Lot Number (OUT)</th>
			<td>
				<select name="batchcode2" id="batchcode2" onChange="update2(this.value);">
					<option value="">Select one</option>
					<cfloop query="getitembatch">
						<option value="#convertquote(getitembatch.batchcode)#" <cfif xbatchcode2 eq getitembatch.batchcode>selected</cfif>>#getitembatch.batchcode# (balance: #getitembatch.batch_balance#)</option>
					</cfloop>
				</select> 
				/ 
				<input name="xbatchcode2" id="xbatchcode2" type="text" size="10" value="#xbatchcode2#" readonly>
				<input name="obatchcode2" id="obatchcode2" type="hidden" value="#obatchcode2#">
			</td>
		</tr>
	</cfif>
	<cfif (checkcustom.customcompany eq "Y") and (url.type neq "RC" and url.type neq "CN" and url.type neq "OAI")>
		<input name="permit_no" id="permit_no" type="hidden" size="10" value="#permitno#" readonly>
		<input name="permit_no2" id="permit_no2" type="hidden" size="10" value="#permitno2#" readonly>
		<tr>
			<th>Permit Number (DP)</th>
			<td><input name="bremark8" id="bremark8" type="text" size="10" value="#bremark8#"></td>
		</tr>
		<tr>
			<th>Permit Number (OO)</th>
			<td><input name="bremark9" id="bremark9" type="text" size="10" value="#bremark9#"></td>
		</tr>
		<tr>
			<th>Permit Number (RM)</th>
			<td><input name="bremark10" id="bremark10" type="text" size="10" value="#bremark10#"></td>
		</tr>
	</cfif>
	<tr>
		<th>Expiry Date</th>
		<td><input name="expdate" id="expdate" type="text" size="10" value="#expdate#">(e.g dd-mm-yyyy)</td>
	</tr>
    <tr>
		<th>Manufacturing Date</th>
		<td><input name="manudate" id="manudate" type="text" size="10" value="#manudate#">(e.g dd-mm-yyyy)</td>
	</tr>
    <tr>
		<th>Mill Certificate</th>
		<td><input name="milcert" id="milcert" type="text" value="#milcert#"></td>
	</tr>

	<tr>
		<th>Quantity</th>
		<input type="hidden" name="oldqty" id="oldqty" value="#oldqty#">
		<input type="hidden" name="validqty" id="validqty" value="">
		<td><input name="batchqty" id="batchqty" type="text" size="5" value="#numberformat(qty,'0')#" onKeyPress="return onlyNumbers();" onKeyUp="checkValidQty();"></td>	
	</tr>
	<tr><td><br></td></tr>
	<tr>
		<th>#getbatchname.lbatch# Status</th>
		<td align="left">
        	<cfif checkcustom.customcompany eq "Y">
                <input name="defective" id="defective" type="radio" value="W" <cfif defective eq "W"> checked</cfif>> Write Off <br>
            	<input name="defective" id="defective" type="radio" value="D" <cfif defective eq "D"> checked</cfif>> Damage / Leakage<br>
                <input name="defective" id="defective" type="radio" value="B" <cfif defective eq "B"> checked</cfif>> Broken <br>
                <input name="defective" id="defective" type="radio" value="O" <cfif defective eq "O"> checked</cfif>> Over Landed <br>
                <input name="defective" id="defective" type="radio" value="S" <cfif defective eq "S"> checked</cfif>> Short Landed <br>
                <input name="defective" id="defective" type="radio" value="" <cfif defective eq ""> checked</cfif>> Good Intact

			<cfelse>
                <input name="defective" id="defective" type="radio" value="D" <cfif defective eq "D"> checked</cfif>> Damage <br>
                <input name="defective" id="defective" type="radio" value="W" <cfif defective eq "W"> checked</cfif>> Write Off <br>
                <input name="defective" id="defective" type="radio" value="R" <cfif defective eq "R"> checked</cfif>> Repair <br>
                <input name="defective" id="defective" type="radio" value="" <cfif defective eq ""> checked</cfif>> Good Item
			</cfif>
		</td>
	</tr>
	<tr><td><br></td></tr>
	<tr>
		<td colspan="100%" align="center">
			<cfif (checkcustom.customcompany eq "Y") and (url.type eq "RC" or url.type eq "CN" or url.type eq "OAI")>
				<input type="button" name="btnOK" id="btnOK" value="Ok" onClick="checkExist();">
			<cfelse>
				<input type="button" name="btnOK" id="btnOK" value="Ok" onClick="UpdateBatch();">
			</cfif>
			&nbsp;&nbsp;<input type="button" value="Cancel" onClick="window.close();">
		</td>
	</tr>
</table>
</cfoutput>
</form>
</body>
</html>
