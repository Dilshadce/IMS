<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">

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
		function UpdateLocation(){
		if(document.getElementById("totqty").value*1 > document.getElementById("totalqty").value*1){
		alert('Total Qty is more than Qty to fulfill');
		}
		else{
		updatemultilocform.submit();
		}
		}

		function UpdateTotalQty(){
			var loclist = document.updatemultilocform.locationlist.value;
			var newArray = loclist.split(";");
			
			var totqty = 0;
			for(i=0;i<newArray.length;i++){
				if(document.getElementById("qty_"+newArray[i]).value == ''){
					document.getElementById("qty_"+newArray[i]).value = 0;
				}
				totqty = totqty + parseFloat(document.getElementById("qty_"+newArray[i]).value);
				
			}
			document.updatemultilocform.totqty.value = totqty;
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
<h1 align="center">Multi Location<br>
Outstanding Qty : <cfoutput>#qty#</cfoutput>
</h1>
<form name="updatemultilocform" id="updatemultilocform" action="dsp_multilocationprocess.cfm" method="post">
<cfoutput>
	<input type="hidden" name="itemno" id="itemno" value="#convertquote(itemno)#">
	<input type="hidden" name="tran" id="tran" value="#type#">
    <input type="hidden" name="uuid" id="uuid" value="#uuid#">
	<input type="hidden" name="refno" id="refno" value="#refno#">
    <input type="hidden" name="trancode" id="trancode" value="#trancode#">
	<input type="hidden" name="totalqty" id="totalqty" value="#qty#">
    
	<input type="hidden" name="locationlist" id="locationlist" value="#ValueList(getlocation.location,";")#">
</cfoutput>

<table border="0" cellpadding="2" align="center" width="90%">
	<tr>
		<th>Location</th>
		<th>Qty On Hand</th>
		
		<th><div align="center">Qty</div></th>
        <th><div align="center">Item Remark</div></th>
	</tr>
	<cfset totqty = 0>
	<cfoutput query="getlocation">
		<cfset xlocation = getlocation.location>
		<cfquery name="getinfo" datasource="#dts#">
			select * from multilocupdatetemp
			where type='#type#'
			and refno='#refno#'
			and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#"> 
            and trancode = <cfqueryparam cfsqltype="cf_sql_char" value="#trancode#"> 
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#xlocation#"> 
            and uuid = <cfqueryparam cfsqltype="cf_sql_char" value="#uuid#"> 
		</cfquery>
		<cfif getinfo.recordcount neq 0>
			<cfset xqty_bil = getinfo.qty>
            <cfset xbrem1 = getinfo.brem1>
		<cfelse>
			<cfset xqty_bil = 0>
            <cfset xbrem1 = "">
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
			<cfset totqty = totqty + val(xqty_bil)>
			<td>
				<div align="center">
					
						<input type="text" name="qty_#xlocation#" id="qty_#xlocation#" value="#val(xqty_bil)#" size="10" onKeyUp="checknum(this);" onBlur="UpdateTotalQty();">		
						<input type="hidden" name="oldqty_#xlocation#" id="oldqty_#xlocation#" value="#val(xqty_bil)#">			
			
				</div>
			</td>
            <td>
            <input type="text" name="brem1_#xlocation#" id="brem1_#xlocation#" value="#xbrem1#" size="10">		
            </td>

		</tr>
	</cfoutput>
	<tr>
		<td colspan="2">
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