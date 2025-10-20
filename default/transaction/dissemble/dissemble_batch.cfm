<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<cfquery name="getbatchname" datasource="#dts#">
SELECT lbatch FROM gsetup
</cfquery>

<html>
<head>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="qty" default="0">

<cfquery name="getitembatch" datasource="#dts#">
<cfif trim(url.location) neq "">
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
<cfquery name="getinfo" datasource="#dts#">
	select 
	location,expdate,qty,milcert,
	defective,mc1_bil,mc2_bil,
	batchcode,sodate,dodate 
	from issuetemp 
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
<cfform name="form1" action="" method="post">
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
			<input name="oldenterbatch" type="hidden" size="10" value="#xbatchcode#">
		</td>
	</tr>
	<tr>
		<th>Expiry Date</th>
		<td><cfinput name="expdate" type="text" size="10" value="#expdate#" validate="eurodate">(e.g dd-mm-yyyy)</td>
	</tr>
    <tr>
		<th>Mill Certificate</th>
		<td><input name="milcert" type="text" size="10" value="#milcert#"></td>
	</tr>
	<tr>
		<th>Quantity</th>
		<input type="hidden" name="oldqty" value="#oldqty#">
		<td><cfinput name="batchqty" type="text" size="5" value="#numberformat(qty,'0')#" validate="float" message="Numbers only"></td>	
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
			<input type="submit" name="issbatchsubmit" id="issbatchsubmit" value="Ok" >&nbsp;&nbsp;<input type="button" value="Cancel" onClick="window.close();">
		</td>
	</tr>
</table>
</cfoutput>
</cfform>
</body>
</html>