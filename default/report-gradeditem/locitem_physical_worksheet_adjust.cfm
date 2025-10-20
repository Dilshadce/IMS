<cfset frgrade=11>
<cfif lcase(hcomid) eq 'supervalu_i'>
<cfset tograde=41>
<cfelse>
<cfset tograde=310>
</cfif>
<html>
<head>
<title>Location - Graded Item Physical Worksheet Report</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script language="javascript" type="text/javascript">
	function calculate_adjusted_qty(balance,actual)
	{
		
		var qty_balance=parseFloat(balance);
		var qty_actual=parseFloat(actual);
		var result=qty_balance-qty_actual;
		return result;
	}
	
	function setactqty()
	{
		if(document.form.set_actual_qty.checked==true)
		{
			var totrecord = document.form.totalrecord.value;
			var frgrade = document.form.frgrade.value;
			var tograde = document.form.tograde.value;
			for(i=1;i<=totrecord;i++){
				for(j=frgrade;j<=tograde;j++){
					if(parseFloat(document.getElementById("balance_"+i+"_"+j).value) != 0 || parseFloat(document.getElementById("qtyactual_"+i+"_"+j).value) != 0){
						document.getElementById("qtyactual_"+i+"_"+j).value = document.getElementById("balance_"+i+"_"+j).value;
						document.getElementById("adjqty_"+i+"_"+j).value = 0;
					}
				}
			}
		}
		document.form.set_actual_qty.checked = false;
	}
	
	function setqty(){
		var totrecord = document.form.totalrecord.value;
		var frgrade = document.form.frgrade.value;
		var tograde = document.form.tograde.value;
		for(i=1;i<=totrecord;i++){
			var totbalance = 0;
			var totactual = 0;
			for(j=frgrade;j<=tograde;j++){
				var totbalance = totbalance + parseFloat(document.getElementById("balance_"+i+"_"+j).value);
				var totactual = totactual + parseFloat(document.getElementById("qtyactual_"+i+"_"+j).value);
			}
			document.getElementById("balance_"+i).value = totbalance;
			document.getElementById("actualqty_"+i).value = totactual;
		}
	}
</script>

<style type="text/css">
.demoDiv{			
	background-color: #FFFAFA;
}
</style>

</head>
<cfinclude template="../../CFC/convert_single_double_quote_script.cfm">
<cfif isdefined('form.date')>
<cfif form.date neq "">
	<cfset date1 = createDate(ListGetAt(form.date,3,"/"),ListGetAt(form.date,2,"/"),ListGetAt(form.date,1,"/"))>
<cfelse>
	<cfset date1 = now()>
</cfif>
<cfelse>
	<cfset date1 = now()>
</cfif>
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#date1#" returnvariable="cperiod"/>
<cfif cperiod neq form.period>
	<cfset form.period = cperiod>
</cfif>

<cfquery name="getiteminfo" datasource="#dts#">
	select 
	<cfloop from="#frgrade#" to="#tograde#" index="i">
		(ifnull(a.grd#i#,0)+ifnull(c.qin#i#,0)-ifnull(d.qout#i#,0)) as qty#i#,
		(ifnull(a.cgrd#i#,0)) as qtyactual#i#,
	</cfloop>
	a.location,b.*,(select desp from iclocation where location=a.location) as locdesp
			
	from logrdob as a 
			
	left join
	(
		select x.itemno,x.desp as itemdesp,x.wos_group,x.category,x.graded,x.shelf,x.ucost,x.price,x.unit
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			,y.gradd#i#
		</cfloop>
		from icitem x,icgroup y
		where x.wos_group = y.wos_group
		and
			(y.gradd#tograde# <> ''
			<cfloop from="#frgrade#" to="#tograde-1#" index="i">
				or y.gradd#i# <> ''
			</cfloop>)
	) as b on a.itemno = b.itemno
						
	left join
	(
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as qin#i#,
		</cfloop>
		itemno,location
		from igrade
		where type in ('RC','CN','OAI','TRIN')
		and fperiod<>'99' 
		and (void = '' or void is null)  
		and factor2 > 0
		<cfif form.period neq "">
			and fperiod <='#form.period#'
		</cfif> 
        <cfif isdefined('form.date')>
		<cfif form.date neq "">
			and wos_date <= #date1# 
		</cfif>
        </cfif>
		group by itemno,location
	) as c on (a.itemno=c.itemno and a.location=c.location)
			
	left join
	(
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as qout#i#,
		</cfloop>
		itemno,location
		from igrade 
		where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
		and fperiod<>'99' 
		and (void = '' or void is null) 
		and generated=''
		and factor2 > 0 
   		<cfif form.period neq "">
			and fperiod <='#form.period#'
		</cfif> 
        <cfif isdefined('form.date')>
		<cfif form.date neq "">
			and wos_date <= #date1# 
		</cfif>
        </cfif>
		group by itemno,location
	) as d on (a.itemno=d.itemno and a.location=d.location)
		
	where b.graded = 'Y'
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and b.category between '#form.catefrom#' and '#form.cateto#'
	</cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and b.itemno between '#form.itemfrom#' and '#form.itemto#'
	</cfif>
    <cfif isdefined('form.tranitemonly')>
    and b.itemno in (select itemno from ictran where 0=0
    <cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and itemno between '#form.itemfrom#' and '#form.itemto#'
	</cfif>
    <cfif trim(form.locfrom) neq "" and trim(form.locto) neq "">
		and location between '#form.locfrom#' and '#form.locto#'
	</cfif>
    )
    </cfif>
    
	<cfif form.shelffrom neq "" and form.shelfto neq "">
		and b.shelf between '#form.shelffrom#' and '#form.shelfto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and b.wos_group between '#form.groupfrom#' and '#form.groupto#'
	</cfif>
	<cfif trim(form.locfrom) neq "" and trim(form.locto) neq "">
		and a.location between '#form.locfrom#' and '#form.locto#'
	</cfif>




	order by a.location,b.itemno
</cfquery>
<body>
<h1 align="center">LOCATION - GRADED ITEM PHYSICAL WORKSHEET</h1>
<h2>Update Actual Quantity</h2>
<table border="0" align="center" width="75%" class="data">
	<tr>
		<th>LOCATION</th>
		<th>ITEM NO.</th>
		<th>DESCRIPTION</th>
		<th>GRADE</th>
		<th><div align="center">BOOK QTY</div></th>
		<th><div align="center">ACTUAL QTY</div></th>
		<th><div align="center">ADJ. QTY</div></th>
	</tr>
	<form name="form" action="locitem_physical_worksheet_adjust_process.cfm" method="post">
	<cfoutput>
		<input type="hidden" name="totalrecord" value="#getiteminfo.recordcount#">
		<input type="hidden" name="date" value="#date1#">
		<input type="hidden" name="period" value="#form.period#">
		<input type="hidden" name="frgrade" value="#frgrade#">
		<input type="hidden" name="tograde" value="#tograde#">
	</cfoutput>
    <cfset runno=1>
	<cfoutput query="getiteminfo">
		<input type="hidden" name="location_#getiteminfo.currentrow#" value="#getiteminfo.location#">
		<input type="hidden" name="itemno_#getiteminfo.currentrow#" value="#convertquote(getiteminfo.itemno)#">
		<input type="hidden" name="itemdesp_#getiteminfo.currentrow#" value="#getiteminfo.itemdesp#">
		<input type="hidden" name="ucost_#getiteminfo.currentrow#" value="#getiteminfo.ucost#">
		<input type="hidden" name="uprice_#getiteminfo.currentrow#" value="#getiteminfo.price#">
		<input type="hidden" name="unit_#getiteminfo.currentrow#" value="#getiteminfo.unit#">
		<input type="hidden" name="balance_#getiteminfo.currentrow#" value="">
		<input type="hidden" name="actualqty_#getiteminfo.currentrow#" value="">
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			<cfif isdefined("form.include_stock")>
				<cfif getiteminfo["gradd#i#"][getiteminfo.currentrow] neq "">
					<tr>
						<td>#getiteminfo.location#</td>
						<td>#getiteminfo.itemno#</td>
						<td>#getiteminfo.itemdesp#</td>
						<td>#getiteminfo["gradd#i#"][getiteminfo.currentrow]#</td>
						<input type="hidden" id="balance_#getiteminfo.currentrow#_#i#" name="balance_#getiteminfo.currentrow#_#i#" value="#getiteminfo["qty#i#"][getiteminfo.currentrow]#">
						<td>#getiteminfo["qty#i#"][getiteminfo.currentrow]#</td>
						<td><div align="center">
							<input type="text" id="qtyactual_#getiteminfo.currentrow#_#i#" name="qtyactual_#getiteminfo.currentrow#_#i#" value="#getiteminfo["qtyactual#i#"][getiteminfo.currentrow]#" size="10" onKeyUp="javascript:document.getElementById('adjqty_#getiteminfo.currentrow#_#i#').value=calculate_adjusted_qty(document.getElementById('balance_#getiteminfo.currentrow#_#i#').value,document.getElementById('qtyactual_#getiteminfo.currentrow#_#i#').value);">
                            
						</div></td>
						<cfset qtyadj = val(getiteminfo["qty#i#"][getiteminfo.currentrow]) - val(getiteminfo["qtyactual#i#"][getiteminfo.currentrow])>
						<td><div align="center">
							<input type="text" class="demoDiv" id="adjqty_#getiteminfo.currentrow#_#i#" name="adjqty_#getiteminfo.currentrow#_#i#" value="#qtyadj#" size="10" readonly>
                            
						</div></td>
					</tr>
				<cfelse>
					<input type="hidden" name="balance_#getiteminfo.currentrow#_#i#" value="0">
					<input type="hidden" name="qtyactual_#getiteminfo.currentrow#_#i#" value="0">
					<input type="hidden" id="adjqty_#getiteminfo.currentrow#_#i#" name="adjqty_#getiteminfo.currentrow#_#i#" value="0">
				</cfif>
			<cfelse>
				<cfif getiteminfo["qty#i#"][getiteminfo.currentrow] neq 0>
					<tr>
						<td>#getiteminfo.location#</td>
						<td>#getiteminfo.itemno#</td>
						<td>#getiteminfo.itemdesp#</td>
						<td>#getiteminfo["gradd#i#"][getiteminfo.currentrow]#</td>
						<input type="hidden" name="balance_#getiteminfo.currentrow#_#i#" id="balance_#getiteminfo.currentrow#_#i#" value="#getiteminfo["qty#i#"][getiteminfo.currentrow]#">
						<td align="right">#getiteminfo["qty#i#"][getiteminfo.currentrow]#</td>
						<td><div align="center">
							<!--- <input type="text" size="10" name="qtyactual_#getiteminfo.currentrow#_#i#" value="#getiteminfo["qtyactual#i#"][getiteminfo.currentrow]#"> --->
							<input type="text" id="qtyactual_#getiteminfo.currentrow#_#i#" name="qtyactual_#getiteminfo.currentrow#_#i#" value="#getiteminfo["qtyactual#i#"][getiteminfo.currentrow]#" size="10" onKeyUp="javascript:document.getElementById('adjqty_#getiteminfo.currentrow#_#i#').value=calculate_adjusted_qty(document.getElementById('balance_#getiteminfo.currentrow#_#i#').value,document.getElementById('qtyactual_#getiteminfo.currentrow#_#i#').value);">
                            qtyactual_#getiteminfo.currentrow#_#i#
						</div></td>
						<cfset qtyadj = val(getiteminfo["qty#i#"][getiteminfo.currentrow]) - val(getiteminfo["qtyactual#i#"][getiteminfo.currentrow])>
						<td><div align="center">
							<input type="text" class="demoDiv" id="adjqty_#getiteminfo.currentrow#_#i#" name="adjqty_#getiteminfo.currentrow#_#i#" value="#qtyadj#" size="10" readonly>
                            adjqty_#getiteminfo.currentrow#_#i#
						</div></td>
					</tr>
				<cfelse>
					<input type="hidden" name="balance_#getiteminfo.currentrow#_#i#" value="0">
					<input type="hidden" name="qtyactual_#getiteminfo.currentrow#_#i#" value="0">
					<input type="hidden" id="adjqty_#getiteminfo.currentrow#_#i#" name="adjqty_#getiteminfo.currentrow#_#i#" value="0">
				</cfif>
			</cfif>
		</cfloop>
	</cfoutput>
	<tr>
		<td colspan="7"><hr/></td>
	</tr>
	<tr>
		<td colspan="7">
			<input type="checkbox" name="generate_adjustment_transaction" id="4" value="yes" <cfif form.submit eq "generate">checked</cfif>> GENERATE ADJUSTMENT TRANSACTIONS &nbsp;
			<input type="checkbox" name="set_actual_qty" id="4" value="yes" onClick="setactqty();"> SET ACTUAL QTY FROM BOOK QTY
		</td>
	</tr>
	<tr>
		<td colspan="7"><hr/></td>
	</tr>
	<tr align="center">
		<td colspan="7">
			<input type="submit" name="Submit" value="Submit" onClick="return setqty();">
			<input type="reset" name="Reset" value="Reset">
		</td>
	</tr>
	</form>
</table>
</body>
</html>
<cfif form.submit eq "generate">
<script language="javascript" type="text/javascript">
document.form.submit();
</script>
</cfif>