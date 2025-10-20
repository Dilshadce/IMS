<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">

<cfquery name="getlocation" datasource="#dts#">
	select location,desp from iclocation where (noactivelocation ='' or noactivelocation is null)
	order by location
</cfquery>
<cfquery name='getgsetup2' datasource='#dts#'>
  	select concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,Decl_Uprice as Decl_Uprice1, concat('.',repeat('_',DECL_DISCOUNT)) as DECL_DISCOUNT1, DECL_DISCOUNT from gsetup2
</cfquery>
<html>
<head>
	<title>MULTI LOCATION</title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	
	<script type="text/javascript">
		<cfoutput>
			var fixnum=#getgsetup2.Decl_UPrice1#;
		</cfoutput>
		function AssignGrade(location,trancode){
			var itemno = document.form1.itemno.value;
			var tran = document.form1.tran.value;
			var refno = document.form1.refno.value;
			var opt = 'Width=800px, Height=500px, scrollbars=auto, status=no';
		
			window.open('dsp_multilocation_gradeitem.cfm?itemno=' + escape(itemno) + '&location=' + location + '&type=' + tran + '&refno=' + refno + '&trancode=' + trancode, '',opt);		
		}
		
		function UpdateLocation(){
			
			var loclist = document.form1.locationlist.value;
			var price_bil = document.form1.price_bil.value;
			var newArray = loclist.split(";");
			
			var qtylist = "";
			var oldqtylist = "";
			var locationbatchlist = "";
			var oldbatchlist = "";
			var mc1billist = "";
			var mc2billist = "";
			var sodatelist = "";
			var dodatelist = "";
			var expdatelist = "";
			var defectivelist = "";
			var milcertlist = "";
			var totqty = 0;
			for(i=0;i<newArray.length;i++){
				totqty = totqty + parseFloat(document.getElementById("qty_"+newArray[i]).value);
				if(i==0){
					qtylist = document.getElementById("qty_"+newArray[i]).value;
					oldqtylist = document.getElementById("oldqty_"+newArray[i]).value;
					if(document.getElementById("batch_"+newArray[i]).value ==""){
						locationbatchlist = " ";
					}
					else{
						locationbatchlist = document.getElementById("batch_"+newArray[i]).value;
					}
					if(document.getElementById("milcert_"+newArray[i]).value ==""){
						milcertlist = " ";
					}
					else{
						milcertlist = document.getElementById("milcert_"+newArray[i]).value;
					}
					if(document.getElementById("oldbatch_"+newArray[i]).value ==""){
						oldbatchlist = " ";
					}
					else{
						oldbatchlist = document.getElementById("oldbatch_"+newArray[i]).value;
					}
					if(document.getElementById("mc1bil_"+newArray[i]).value ==""){
						mc1billist = " ";
					}
					else{
						mc1billist = document.getElementById("mc1bil_"+newArray[i]).value;
					}
					if(document.getElementById("mc2bil_"+newArray[i]).value ==""){
						mc2billist = " ";
					}
					else{
						mc2billist = document.getElementById("mc2bil_"+newArray[i]).value;
					}
					if(document.getElementById("sodate_"+newArray[i]).value ==""){
						sodatelist = " ";
					}
					else{
						sodatelist = document.getElementById("sodate_"+newArray[i]).value;
					}
					if(document.getElementById("dodate_"+newArray[i]).value ==""){
						dodatelist = " ";
					}
					else{
						dodatelist = document.getElementById("dodate_"+newArray[i]).value;
					}
					if(document.getElementById("expdate_"+newArray[i]).value ==""){
						expdatelist = " ";
					}
					else{
						expdatelist = document.getElementById("expdate_"+newArray[i]).value;
					}
					if(document.getElementById("defective_"+newArray[i]).value ==""){
						defectivelist = " ";
					}
					else{
						defectivelist = document.getElementById("defective_"+newArray[i]).value;
					}
				}
				else{
					qtylist = qtylist + ";" + document.getElementById("qty_"+newArray[i]).value;
					oldqtylist = oldqtylist + ";" + document.getElementById("oldqty_"+newArray[i]).value;
					if(document.getElementById("batch_"+newArray[i]).value ==""){
						locationbatchlist = locationbatchlist + ";" + " ";
					}
					else{
						locationbatchlist = locationbatchlist + ";" + document.getElementById("batch_"+newArray[i]).value;
					}
					if(document.getElementById("oldbatch_"+newArray[i]).value ==""){
						oldbatchlist = oldbatchlist + ";" + " ";
					}
					else{
						oldbatchlist = oldbatchlist + ";" + document.getElementById("oldbatch_"+newArray[i]).value;
					}
					if(document.getElementById("mc1bil_"+newArray[i]).value ==""){
						mc1billist = mc1billist + ";" + " ";
					}
					else{
						mc1billist = mc1billist + ";" + document.getElementById("mc1bil_"+newArray[i]).value;
					}
					if(document.getElementById("mc2bil_"+newArray[i]).value ==""){
						mc2billist = mc2billist + ";" + " ";
					}
					else{
						mc2billist = mc2billist + ";" + document.getElementById("mc2bil_"+newArray[i]).value;
					}
					if(document.getElementById("sodate_"+newArray[i]).value ==""){
						sodatelist = sodatelist + ";" + " ";
					}
					else{
						sodatelist = sodatelist + ";" + document.getElementById("sodate_"+newArray[i]).value;
					}
					if(document.getElementById("dodate_"+newArray[i]).value ==""){
						dodatelist = dodatelist + ";" + " ";
					}
					else{
						dodatelist = dodatelist + ";" + document.getElementById("dodate_"+newArray[i]).value;
					}
					if(document.getElementById("expdate_"+newArray[i]).value ==""){
						expdatelist = expdatelist + ";" + " ";
					}
					else{
						expdatelist = expdatelist + ";" + document.getElementById("expdate_"+newArray[i]).value;
					}
					if(document.getElementById("defective_"+newArray[i]).value ==""){
						defectivelist = defectivelist + ";" + " ";
					}
					else{
						defectivelist = defectivelist + ";" + document.getElementById("defective_"+newArray[i]).value;
					}
					if(document.getElementById("milcert_"+newArray[i]).value ==""){
						milcertlist = milcertlist + ";" + " ";
					}
					else{
						milcertlist = milcertlist + ";" + document.getElementById("milcert_"+newArray[i]).value;
					}
				}
			}
			//alert(locationbatchlist);
			opener.document.form1.locationlist.value = loclist;
			opener.document.form1.batchlist.value = locationbatchlist;
			opener.document.form1.oldbatchlist.value = oldbatchlist;
			opener.document.form1.mc1billist.value = mc1billist;
			opener.document.form1.mc2billist.value = mc2billist;
			opener.document.form1.sodatelist.value = sodatelist;
			opener.document.form1.dodatelist.value = dodatelist;
			opener.document.form1.expdatelist.value = expdatelist;
			opener.document.form1.defectivelist.value = defectivelist;
			opener.document.form1.milcertlist.value = milcertlist;
			opener.document.form1.qtylist.value = qtylist;
			opener.document.form1.oldqtylist.value = oldqtylist;
			opener.document.form1.qt6.value = totqty;
			opener.document.form1.amt.value = (totqty * price_bil).toFixed(fixnum);
			window.close();
		}
		
		function UpdateTotalQty(){
			var loclist = document.form1.locationlist.value;
			var newArray = loclist.split(";");
			
			var totqty = 0;
			for(i=0;i<newArray.length;i++){
				if(document.getElementById("qty_"+newArray[i]).value == ''){
					document.getElementById("qty_"+newArray[i]).value = 0;
				}
				totqty = totqty + parseFloat(document.getElementById("qty_"+newArray[i]).value);
				
			}
			document.form1.totqty.value = totqty;
		}
		
		function showToolTip(text) {		
			var toolTip = document.getElementById("spnToolTip");		
			toolTip.style.top = window.event.clientY + 10; 		
			toolTip.style.left = window.event.clientX;		
			toolTip.innerHTML = text;		
			toolTip.style.visibility = "visible";		
			toolTip.style.background = 'lightyellow';	
		}	
		
		function showToolTipColorBG(text,color) {		
			var toolTip = document.getElementById("spnToolTip");		
			toolTip.style.top = window.event.clientY + 10; 		
			toolTip.style.left = window.event.clientX;		
			toolTip.innerHTML = text;		
			toolTip.style.visibility = "visible";		
			toolTip.style.background = color;	
		}	
		
		function hideToolTip() {		
			document.getElementById("spnToolTip").style.visibility = "hidden";	
		}
		
		function SelectBatch(location){
			var itemno = document.form1.itemno.value;
			var tran = document.form1.tran.value;
			var refno = document.form1.refno.value;
			var qty = document.getElementById("qty_"+location).value;
			var opt = 'Width=800px, Height=500px, scrollbars=auto, status=no';
		
			window.open('dsp_multilocation_batch.cfm?itemno=' + escape(itemno) + '&location=' + location + '&type=' + tran + '&refno=' + refno + '&qty=' + qty, '',opt);
		}
		
		function checknum(qty){
			if(isNaN(qty.value))
			{
				alert ("Please key in quantity in numeric.");
				qty.focus();
 			 }
		}
	</script>
</head>
<body>
<h1 align="center">Multi Location</h1>
<form name="form1" action="" method="post">
<cfoutput>
	<input type="hidden" name="itemno" id="itemno" value="#convertquote(itemno)#">
	<input type="hidden" name="tran" id="tran" value="#type#">
	<input type="hidden" name="refno" id="refno" value="#refno#">
	<input type="hidden" name="price_bil" id="price_bil" value="#price_bil#">
	<input type="hidden" name="locationlist" id="locationlist" value="#ValueList(getlocation.location,";")#">
</cfoutput>
<SPAN id="spnToolTip" style="BORDER-RIGHT: gray 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: gray 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 8pt; Z-INDEX: 111; BACKGROUND: lightyellow; VISIBILITY: hidden; PADDING-BOTTOM: 2px; BORDER-LEFT: gray 1px solid; PADDING-TOP: 2px; BORDER-BOTTOM: gray 1px solid; FONT-FAMILY: Arial,Verdana; POSITION: absolute" onMouseOut="hideToolTip()"></SPAN>
<table border="0" cellpadding="2" align="center" width="90%">
	<tr>
		<th>Location</th>
		<th>Qty On Hand</th>
		<cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
			<th>PO Qty</th>
			<th>Arrival Date</th>
		</cfif>
		<th><div align="center">Qty</div></th>
		<th><div align="center">Action</div></th>
	</tr>
	<cfset totqty = 0>
	<cfoutput query="getlocation">
		<cfset xlocation = getlocation.location>
		<cfquery name="getinfo" datasource="#dts#">
			select * from ictran
			where type='#type#'
			and refno='#refno#'
			and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#"> 
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#xlocation#"> 
			and price_bil = <cfqueryparam cfsqltype="cf_sql_char" value="#price_bil#"> 
		</cfquery>
		<cfif getinfo.recordcount neq 0>
			<cfset xqty_bil = getinfo.qty_bil>
			<cfset xtrancode = getinfo.trancode>
			<cfset xbatchcode = getinfo.batchcode>
			<cfset oldbatchcode = getinfo.batchcode>
			<cfset xmc1bil = getinfo.mc1_bil>
			<cfset xmc2bil = getinfo.mc2_bil>
			<cfset xsodate = dateformat(getinfo.sodate,"dd-mm-yyyy")>
			<cfset xdodate = dateformat(getinfo.dodate,"dd-mm-yyyy")>
			<cfset xexpdate = dateformat(getinfo.expdate,"dd-mm-yyyy")>
			<cfset xdefective = getinfo.defective>
            <cfset xmilcert = getinfo.milcert>
		<cfelse>
			<cfset xqty_bil = 0>
			<cfset xtrancode = "">
			<cfset xbatchcode = "">
			<cfset oldbatchcode = "">
			<cfset xmc1bil = "">
			<cfset xmc2bil = "">
			<cfset xsodate = "">
			<cfset xdodate = "">
			<cfset xexpdate = "">
			<cfset xdefective = "">
            <cfset xmilcert = "">
		</cfif>
		<cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
			<cfif type eq "INV" or type eq "CS" or type eq "DO">
				<cfquery name="getarrival" datasource="#dts#">
        			select a.rem9,b.qty from artran a,ictran b
           	 		where a.type = b.type and a.refno = b.refno 
					and b.itemno = '#itemno#'
           	 		and a.type = 'PO'
            		and a.fperiod <> '99'
					and b.location = <cfqueryparam cfsqltype="cf_sql_char" value="#xlocation#">  
            		order by a.rem9 desc 
            		limit 1
       	 		</cfquery>
        		<cfif getarrival.recordcount neq 0 and getarrival.rem9 neq "">
					<cfset arrivaldate = dateformat(getarrival.rem9,"dd-mm-yyyy")>
					<cfset poqty = val(getarrival.qty)>
				<cfelse>
        			<cfset arrivaldate = "-">
					<cfset poqty = 0>
				</cfif>
			<cfelse>
				<cfset arrivaldate = "-">
				<cfset poqty = 0>
			</cfif>
		</cfif>
		
		<cfquery name="getlocitembal" datasource="#dts#">
			select LOCQFIELD as locqtybf from locqdbf
			where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#"> 
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#xlocation#">  
		</cfquery>
		<cfif getlocitembal.recordcount neq 0>
			<cfset itembal = getlocitembal.locqtybf>
		<cfelse>
			<cfset itembal = 0>
		</cfif>
							
		<cfquery name="getin" datasource="#dts#">
			select 
			sum(qty)as sumqty 
			from ictran 
			where type in ('RC','CN','OAI','TRIN') 
			and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#itemno#"> 
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#xlocation#">  
			and fperiod <> '99' 
			and (void = '' or void is null)
		</cfquery>

		<cfif getin.sumqty neq "">
			<cfset inqty = getin.sumqty>
		<cfelse>
			<cfset inqty = 0>
		</cfif>

		<cfquery name="getout" datasource="#dts#">
			select 
			sum(qty)as sumqty 
			from ictran 
			where type in ('INV','DN','PR','CS','ISS','OAR','TROU') 
			and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#itemno#"> 
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#xlocation#">  
			and fperiod <> '99' 
			and (void = '' or void is null)
		</cfquery>

		<cfif getout.sumqty neq "">
			<cfset outqty = getout.sumqty>
		<cfelse>
			<cfset outqty = 0>
		</cfif>

		<cfquery name="getdo" datasource="#dts#">
			select 
			sum(qty)as sumqty 
			from ictran 
			where type='DO' 
			and toinv='' 
			and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#itemno#"> 
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#xlocation#">  
			and fperiod <> '99' 
			and (void = '' or void is null)
		</cfquery>

		<cfif getdo.sumqty neq "">
			<cfset DOqty = getdo.sumqty>
		<cfelse>
			<cfset DOqty = 0>
		</cfif>
							
		<cfset locbalonhand = itembal + inqty - outqty - doqty>	
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td>#getlocation.location#</td>
			<td><div align="center">#locbalonhand#</div></td>
			<cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
				<td><div align="center">#poqty#</div></td>
				<td><div align="center">#arrivaldate#</div></td>
			</cfif>
			<cfset totqty = totqty + val(xqty_bil)>
			<td>
				<div align="center">
					<!--- <cfif graded eq "Y">
						<input type="text" name="qty_#xlocation#" value="#val(xqty_bil)#" size="10" readonly>
						<input type="button" value="Grade" onclick="AssignGrade('#xlocation#','#getinfo.trancode#');">
					<cfelse> --->
						<input type="text" name="qty_#xlocation#" id="qty_#xlocation#" value="#val(xqty_bil)#" size="10" onKeyUp="checknum(this);" onBlur="UpdateTotalQty();">		
						<input type="hidden" name="oldqty_#xlocation#" id="oldqty_#xlocation#" value="#val(xqty_bil)#">			
					<!--- </cfif> --->				
				</div>
			</td>
			<td><div align="center">
				<input type="button" value="B" class="btn001" onMouseOver="showToolTipColorBG('Click For Select Batch Code','##FFFFCC');" onMouseOut="hideToolTip();" onClick="SelectBatch('#xlocation#');">
				<input type="hidden" name="batch_#xlocation#" id="batch_#xlocation#" value="#xbatchcode#">
				<input type="hidden" name="oldbatch_#xlocation#" id="oldbatch_#xlocation#" value="#xbatchcode#">
				<input type="hidden" name="mc1bil_#xlocation#" id="mc1bil_#xlocation#" value="#xmc1bil#">
				<input type="hidden" name="mc2bil_#xlocation#" id="mc2bil_#xlocation#" value="#xmc2bil#">
				<input type="hidden" name="sodate_#xlocation#" id="sodate_#xlocation#" value="#xsodate#">
				<input type="hidden" name="dodate_#xlocation#" id="dodate_#xlocation#" value="#xdodate#">
				<input type="hidden" name="expdate_#xlocation#" id="expdate_#xlocation#" value="#xexpdate#">
				<input type="hidden" name="defective_#xlocation#" id="defective_#xlocation#" value="#xdefective#">
                <input type="hidden" name="milcert_#xlocation#"  id="milcert_#xlocation#" value="#xmilcert#">
				<!--- <input type="button" value="G" class="btn001" onmouseover="showToolTipColorBG('Click For Grades','##FFFFCC');" onmouseout="hideToolTip();"> --->
			</div></td>
		</tr>
	</cfoutput>
	<tr>
		<td <cfif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">colspan="4"<cfelse>colspan="2"</cfif>>
			<div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>Total:</strong></font></div>
		</td>
		<td>
			<div align="center"><cfoutput><input type="text" name="totqty" id="totqty" value="#totqty#" size="10" style="background-color: ##FFFAFA;"></cfoutput></div>
		</td>
	</tr>
	<tr><td colspan="100%" align="center" height="10"></td></tr>
	<tr>
		<td colspan="100%" align="center">
			<input type="button" value="Ok" onClick="UpdateLocation();">&nbsp;&nbsp;<input type="button" value="Cancel" onClick="window.close();">
		</td>
	</tr>
</table>
</form>
</body>
</html>