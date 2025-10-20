<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script type="text/javascript">
	function checkall(objs){
		if(objs==true){
			alert(objs + " - " +document.getElementById('checkbox1').checked);
			
			document.getElementById('checkbox1').selected=true;
		}else{
			alert(objs);
			document.getElementById('checkbox1').checked=false;
		}
		
	}
	function SetValues(Form, CheckBox, Value) {  
		var objCheckBoxes = document.forms[Form].elements[CheckBox];     
		var countCheckBoxes = objCheckBoxes.length;     
		for(var i = 0; i < countCheckBoxes; i++)       
			objCheckBoxes[i].checked = Value; 
	} 
</script>

</head>
<cfquery datasource="#dts#" name="getgsetup">
	select * from gsetup  
</cfquery>

<cfif isdefined("form.radio")>
	<cfquery datasource="#dts#" name="getquery">
		select * from artran 
		where
		<cfif form.radio eq 1>
	    	iras_posted=''
	    <cfelseif form.radio eq 2>
	    	iras_posted='P'
	    <cfelse>
	    	posted='P'
	    </cfif>
	    
	    <cfif form.radio4 eq "INV">
	    	and type='INV'
	    <cfelseif form.radio4 eq "CN">
	    	and type='CN'
	    <cfelseif form.radio4 eq "RC">
	    	and type='RC'
	    <cfelseif form.radio4 eq "CS">
	    	and type='CS'
	    <cfelseif form.radio4 eq "DN">
	    	and type='DN'
	    <cfelseif form.radio4 eq "PR">
	    	and type='PR'
	    <cfelse>
        	and type in ('INV','CN','RC','DN','PR','CS')
	    </cfif>
	    and fperiod <> '99'
	    and (void = '' or void is null)
	</cfquery>
<cfelse>
	<cfquery datasource="#dts#" name="getquery">
		select * from artran
		where iras_posted=''
	    and fperiod <> '99'
	    and (void = '' or void is null) and type in ('INV','CN','RC','DN','PR','CS')
	</cfquery>
</cfif>
<body>
<!--- <table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td width="1007"></td><td width="128" style="background-color:#0FF; border: medium; border-color:#000" align="right" nowrap ><a href="billPaymentLedger.cfm?type=<cfoutput>#title#</cfoutput>">Bill Payment Ledger</a></td></tr></table> --->
<form name="form1" method="post" action="irasPosting3.cfm">
<!--- <div align="center"><strong><em>IRAS POSTING</em></strong></div><br><hr> --->
<cfif isdefined("url.status")>
	<cfif url.status eq "Yes">
		<div align="center"><font color="red">The Process is done.</font></div>
	<cfelse>
		<div align="center"><font color="red">There is no Transaction selected.</font></div>
	</cfif>
</cfif>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<tr bgcolor="##000099">
		<th><font color="Ivory" size="-2"><strong>DATE</strong></font></th>
		<th><font color="Ivory" size="-2"><strong>TYPE</strong></font></th>
		<th><font color="Ivory" size="-2"><strong>REFERENCE</strong></font></th>
		<th><font color="Ivory" size="-2"><strong>ACCNO.</strong></font></th>
		<th align="left"><font color="Ivory" size="-2"><strong>NAME</strong></font></th>
		<TH><font color="Ivory" size="-2"><strong>NET</strong></font></TH>
		<th><font color="Ivory" size="-2"><strong>TAX</strong></font></th>
		<th><font color="Ivory" size="-2"><strong>Action<input name="checkbox1" id="checkbox1" type="checkbox" onClick="SetValues('form1', 'boxes', this.checked);" checked></strong></font></th>
	</tr>
	<cfoutput>
	<cfif getquery.recordcount neq 0>
		<cfloop query="getquery">
			<tr bgcolor="#iif((getquery.currentrow mod 2) eq 1,DE('lightskyblue'),DE('aliceblue'))#">
				<td><font size="-2">#dateformat(getquery.wos_date,"dd/mm/yyyy")#</font></td>
				<td align="center"><font size="-2">#getquery.type#</font></td>
				<td align="center"><font size="-2">#getquery.refno#</font></td>
				<td align="center"><font size="-2">#getquery.custno#</font></td>
				<td align="left"><font size="-2">#getquery.name#</font></td>
				<td align="right"><font size="-2">#numberformat(getquery.net,'.__')#</font></td>
				<td align="right"><font size="-2">#numberformat(getquery.tax,'.__')#</font></td>
				<td align="center">
					<cfif trim(getquery.refno) eq ''>
						<!--- Just assign a value, because ColdFusion ignores empty list elements --->
						<cfset xrefno = 'YHFTOKCF'>
					<cfelse>
						<cfset xrefno = getquery.refno>
					</cfif>
					<input name="boxes" id="checkbox1" type="checkbox" value="|#xrefno#|#getquery.type#|#getquery.custno#" checked>
				</td>
			</tr>
		</cfloop>
	<cfelse>
		<tr><td colspan="10" align="center" bgcolor="aliceblue"><font color="red">No Record Found.</font></td></tr>
	</cfif>
</table>
<cfif isdefined("form.radio11")>
	<input type="hidden" name="postType" value="#form.radio11#">
<cfelse>
	<input type="hidden" name="postType" value="1">
</cfif>
	<input type="hidden" name="type" value="">
</cfoutput>
</form>
</body>
</html>