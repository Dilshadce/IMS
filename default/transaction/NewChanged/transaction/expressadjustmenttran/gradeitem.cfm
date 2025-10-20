<cfset frgrade=11>
<cfset tograde=310>
<cfinclude template="/CFC/convert_single_double_quote_script.cfm">

<script language="javascript" type="text/javascript">
	function calculate_adjusted_qty(balance,actual)
	{
		var qty_balance=parseFloat(balance);
		var qty_actual=parseFloat(actual);
		var result=qty_balance-qty_actual;
		return result;
	}

	function setqty(){
		var totrecord = document.gradeform.totalrecord.value;
		var frgrade = document.gradeform.frgrade.value;
		var tograde = document.gradeform.tograde.value;
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

<cfset url.date = URLDecode(url.date)>
<cfset url.itemno = URLDecode(url.itemno)>
<cfset url.location = URLDecode(url.location)>

<cfset date1 = createDate(ListGetAt(url.date,3,"/"),ListGetAt(url.date,2,"/"),ListGetAt(url.date,1,"/"))>
    
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#date1#" returnvariable="cperiod"/>

<cfset form.period = cperiod>


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
	and b.itemno = '#url.itemno#'
	and a.location = '#url.location#'
	order by a.location,b.itemno
</cfquery>
<cfoutput>
<h2 align="center">Item No #url.itemno#</h2>
<h2 align="center">Location #url.location#</h2>
</cfoutput>
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
	<cfform name="gradeform" action="gradeitemprocess.cfm" method="post">
	<cfoutput>
    	<input type="hidden" name="uuid" value="#url.uuid#">
		<input type="hidden" name="totalrecord" value="#getiteminfo.recordcount#">
		<input type="hidden" name="date" value="#date1#">
		<input type="hidden" name="period" value="#form.period#">
		<input type="hidden" name="frgrade" value="#frgrade#">
		<input type="hidden" name="tograde" value="#tograde#">
	</cfoutput>
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
				<cfif getiteminfo["gradd#i#"][getiteminfo.currentrow] neq "">
					<tr>
						<td>#getiteminfo.location#</td>
						<td>#getiteminfo.itemno#</td>
						<td>#getiteminfo.itemdesp#</td>
						<td>#getiteminfo["gradd#i#"][getiteminfo.currentrow]#</td>
						<input type="hidden" name="balance_#getiteminfo.currentrow#_#i#" value="#getiteminfo["qty#i#"][getiteminfo.currentrow]#">
						<td>#getiteminfo["qty#i#"][getiteminfo.currentrow]#</td>
						<td><div align="center">
							<input type="text" id="qtyactual_#getiteminfo.currentrow#_#i#" name="qtyactual_#getiteminfo.currentrow#_#i#" value="#getiteminfo["qtyactual#i#"][getiteminfo.currentrow]#" size="10" onKeyUp="javascript:document.gradeform.adjqty_#getiteminfo.currentrow#_#i#.value=calculate_adjusted_qty(document.gradeform.balance_#getiteminfo.currentrow#_#i#.value,document.gradeform.qtyactual_#getiteminfo.currentrow#_#i#.value);">
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
			
		</cfloop>
	</cfoutput>
	<tr>
		<td colspan="7"><hr/></td>
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
	</cfform>
</table>