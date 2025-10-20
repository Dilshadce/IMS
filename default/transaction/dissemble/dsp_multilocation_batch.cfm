<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
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
				document.form1.enterbatch2.readOnly = false;
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
				DWRUtil.setValue("batchqty", BatchObject.BATCHQTY);
			}
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
			var milcert = document.form1.milcert.value;
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
			if(milcert == ""){
				milcert = " ";
			}
			if(defective == ""){
				defective = " ";
			}
			opener.document.getElementById("batch_"+location).value = batchcode;
			opener.document.getElementById("oldbatch_"+location).value = oldenterbatch;
			opener.document.getElementById("mc1bil_"+location).value = mc1bil;
			opener.document.getElementById("mc2bil_"+location).value = mc2bil;
			opener.document.getElementById("sodate_"+location).value = sodate;
			opener.document.getElementById("dodate_"+location).value = dodate;
			opener.document.getElementById("expdate_"+location).value = expdate;
			opener.document.getElementById("milcert_"+location).value = milcert;
			opener.document.getElementById("defective_"+location).value = defective;
			if(document.form1.batchqty.value == ""){
				document.form1.batchqty.value = '0';
			}
			opener.document.getElementById("qty_"+location).value = document.form1.batchqty.value;
			window.close();
		}
	</script>
</head>

<cfparam name="qty" default="0">

<cfquery name="getitembatch" datasource="#dts#">
	<cfif lcase(hcomid) eq "remo_i">
		select a.location,a.batchcode,a.itemno,
		a.rc_type,a.rc_refno,((a.bth_qob+a.bth_qin)-a.bth_qut-ifnull(b.soqty,0)) as batch_balance,
		a.expdate as exp_date ,
        a.milcert
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
	<cfelse>
		select 
		batchcode,rc_type,rc_refno,
		((bth_qob+bth_qin)-bth_qut) as batch_balance,
		expdate as exp_date ,
        milcert
		from lobthob 
		where location='#url.location#' 
		and itemno='#url.itemno#' 
		and ((bth_qob+bth_qin)-bth_qut) >0 
		order by itemno
	</cfif>		
</cfquery>
<cfquery name="getinfo" datasource="#dts#">
	select 
	location,expdate,qty,milcert,
	defective,mc1_bil,mc2_bil,
	batchcode,sodate,dodate 
	from ictran 
	where location='#url.location#'  
	and itemno='#url.itemno#' 
	and type='#url.type#'
	and refno ='#url.refno#'
</cfquery>
<cfif getinfo.recordcount neq 0>
	<cfset mc1bil = getinfo.mc1_bil>
	<cfset mc2bil = getinfo.mc2_bil>
	<cfset xbatchcode = getinfo.batchcode>
	<cfset defective = getinfo.defective>
	<cfset oldqty = getinfo.qty>
    <cfset milcert = getinfo.milcert>
	<cfif getinfo.expdate neq "">
		<cfset expdate = dateformat(getinfo.expdate,"dd-mm-yyyy")>
	<cfelse>
		<cfset expdate = getinfo.expdate>
	</cfif>
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
<cfelse>
	<cfset mc1bil = "0.00">
	<cfset mc2bil = "0.00">
	<cfset xbatchcode = "">
	<cfset expdate = "">
    <cfset milcert = "">
	<cfset sodate = "">
	<cfset dodate = "">
	<cfset defective = "">
	<cfset oldqty = "0">
</cfif>
<body>
<h1 align="center"><cfoutput><font color="red">#url.location#</font></cfoutput>: Select <cfoutput>#getbatchname.lbatch#</cfoutput> For Item <cfoutput><font color="red">#url.itemno#</font></cfoutput></h1>
<form name="form1" action="" method="post">
<cfoutput>	
	<input type="hidden" name="location" value="#url.location#">
	<input type="hidden" name="tran" value="#url.type#">
	<input type="hidden" name="itemno" value="#convertquote(url.itemno)#">
<table align="center">
	<tr>
		<th>Other Charges 1</th>
		<td><input name="mc1bil" type="text" size="10" value="#numberformat(mc1bil,'0.00')#" onKeyPress="return onlyNumbers();"></td>
	</tr>
	<tr>
		<th>Other Charges 2</th>
		<td><input name="mc2bil" type="text" size="10" value="#numberformat(mc2bil,'0.00')#" onKeyPress="return onlyNumbers();"></td>
	</tr>
	<tr><td><br></td></tr>
	<tr>
		<th>Sales Order Date</th>
		<td><input name="sodate" type="text" size="10" value="#sodate#">(e.g dd-mm-yyyy)</td>
	</tr>
	<tr>	
		<th>Delivery Date</th>
		<td><input name="dodate" type="text" size="10" value="#dodate#">(e.g dd-mm-yyyy)</td>
	</tr>
	<tr><td><br></td></tr>
	<tr>
		<th>#getbatchname.lbatch# Code</th>
		<td>
			<!--- <input name="enterbatch" type="text" size="10" value=""> --->
			<select name="enterbatch" onChange="update(this.value);">
				<option value="">Select a batch</option>
				<cfloop query="getitembatch">
					<option value="#convertquote(getitembatch.batchcode)#" <cfif xbatchcode eq getitembatch.batchcode>selected</cfif>>#getitembatch.batchcode# (balance: #getitembatch.batch_balance#)</option>
				</cfloop>
			</select> 
			/ <input name="enterbatch2" type="text" size="10" value="#xbatchcode#">
			<input name="oldenterbatch" type="hidden" size="10" value="#xbatchcode#">
		</td>
	</tr>
	<tr>
		<th>Expiry Date</th>
		<td><input name="expdate" type="text" size="10" value="#expdate#">(e.g dd-mm-yyyy)</td>
	</tr>
    <tr>
		<th>Mill Certificate</th>
		<td><input name="milcert" type="text" size="10" value="#milcert#"></td>
	</tr>
	<tr>
		<th>Quantity</th>
		<input type="hidden" name="oldqty" value="#oldqty#">
		<td><input name="batchqty" type="text" size="5" value="#numberformat(qty,'0')#" onKeyPress="return onlyNumbers();"></td>	
	</tr>
	<tr><td><br></td></tr>
	<tr>
		<th>#getbatchname.lbatch# Status</th>
		<td align="left">
			<input name="defective" id="defective" type="radio" value="D" <cfif defective eq "D"> checked</cfif>> Damage <br>
			<input name="defective" id="defective" type="radio" value="W" <cfif defective eq "W"> checked</cfif>> Write Off <br>
			<input name="defective" id="defective" type="radio" value="R" <cfif defective eq "R"> checked</cfif>> Repair <br>
			<input name="defective" id="defective" type="radio" value="" <cfif defective eq ""> checked</cfif>> Good Item
		</td>
	</tr>
	<tr><td><br></td></tr>
	<tr>
		<td colspan="100%" align="center">
			<input type="button" value="Ok" onClick="UpdateBatch();">&nbsp;&nbsp;<input type="button" value="Cancel" onClick="window.close();">
		</td>
	</tr>
</table>
</cfoutput>
</form>
</body>
</html>