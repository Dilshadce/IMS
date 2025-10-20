<html>
<head>
<title>Physical Worksheet Report</title>

<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,transactionSortBy from dealer_menu limit 1
</cfquery>

<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
	function calculate_adjusted_qty(balance,actual,row)
	{
		var qty_balance=parseFloat(balance);
		var qty_actual=parseFloat(actual);
		if(qty_balance-qty_actual<0)
		{
		alert('Qty Key is more than balance');
		var result=qty_balance-0;
		document.getElementById('actualqty'+row).value=0;
		return result;
		}
		else
		{
		var result=qty_balance-qty_actual;
		return result;
		}
	}
	
	function setallzero()
	{
		for (var i=1;i<=document.getElementById('totalitem').value;i++)
		{
			document.getElementById('actualqty'+i).value=0;
			
		}

	}
	
	
	
	
</script>

<cfquery name="getgeneral" datasource="#dts#">
	select compro,singlelocation from gsetup;
</cfquery>

<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfif isdefined('form.generateitem')>
<cfquery name="getalllocation" datasource="#dts#">
select location from iclocation
</cfquery>
<cfloop query="getalllocation">
<cfquery name="getallitem" datasource="#dts#">
select itemno from icitem
</cfquery>
<cfloop query="getallitem">
<cfquery name="insertlocqdbf" datasource="#dts#">
insert ignore into locqdbf (itemno,location) values ('#getallitem.itemno#','#getalllocation.location#')
</cfquery>

</cfloop>

</cfloop>
</cfif>

<cfquery name="insert_new_location_item" datasource="#dts#">
	insert ignore into locqdbf 
	(
		itemno,
		location
	)
	(
		select 
		itemno,
		location 
		from ictran 
		where location<>''
		and (linecode <> 'SV' or linecode is null)
		<cfif form.itemfrom neq "" and form.itemto neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
        <cfif getgeneral.singlelocation eq 'Y'>
        <cfif form.locationfrom neq "">
			and location = '#form.locationfrom#'
		</cfif>
        <cfelse>
		<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
        </cfif>
		group by location,itemno
		order by location,itemno
	)
</cfquery>



<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
<cfif form.itemfrom neq "" and form.itemto neq "">
	and itemno between '#form.itemfrom#' and '#form.itemto#'
</cfif> group by frrefno
</cfquery>
<cfset billupdated=valuelist(getdoupdated.frrefno)>

<cfquery name="getcust" datasource="#dts#">
   		select custno,name from #target_arcust#
        WHERE 0=0 
        <cfif getpin2.h1t00 eq 'T'>
<cfif GetSetting.agentlistuserid eq "Y">and ucase(agent) in (SELECT agent FROM #target_icagent#  WHERE agentlist like "%#ucase(huserid)#%")
		<cfelse>
           			and (ucase(created_by)='#ucase(huserid)#' or ucase(agent)='#ucase(huserid)#')  
		</cfif>
					<cfelse>
         <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i">
                   
         <cfelse>
		 <cfif Huserloc neq "All_loc">
					and (created_by in (select userid from main.users where userDept = '#dts#' and location='#Huserloc#'))
		</cfif>
        </cfif>
        </cfif>
        order by custno
	</cfquery>


</head>
<cfset totalqty=0>
<cfset totalact=0>

<cfif form.target_date neq "">
<cfset ndate = createdate(right(form.target_date,4),mid(form.target_date,4,2),left(form.target_date,2))>
<cfset form.target_date = ndate >
</cfif>
<cfinclude template="../../CFC/convert_single_double_quote_script.cfm">



<cfquery name="getiteminfo" datasource="#dts#">
	select 
	a.itemno,
	a.desp,
    a.aitemno,
    a.category,
    a.wos_group,
	a.unit,
    a.price,
	a.shelf,
	a.ucost,
	b.location,
	b.locqactual,
	b.balance 
	
	from icitem as a 
			
	left join 
	(
		select 
		a.location,
		a.itemno,
		a.locqactual,
		(ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance 
		
		from locqdbf as a 
		
		left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_in 
			
			from ictran
			
			where type in ('RC','CN','OAI','TRIN') 
            and (void = '' or void is null)
            <cfif getgeneral.singlelocation eq 'Y'>
            <cfif form.locationfrom neq "">
			and location = '#form.locationfrom#'
			</cfif>
            <cfelse>
			<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
			</cfif>
            </cfif>
			<cfif form.period neq ""> 
			and fperiod <='#form.period#' and fperiod<>'99' 
			<cfelse>
			and fperiod<>'99'
			</cfif>
			<cfif form.itemfrom neq "" and form.itemto neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
			<cfif form.target_date neq "">
			and wos_date <= '#lsdateformat(form.target_date,"yyyy-mm-dd")#'
			</cfif>
			group by location,itemno
			order by location,itemno
		) as b on a.location=b.location and a.itemno=b.itemno
		
		left join
		(
			select 
			location,
			itemno,
			sum(qty) as sum_out 
			
			from ictran 
			
			where (type in ('PR','CS','DN','ISS','OAR','TROU','DO') or 
            (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
            and (void = '' or void is null)
            <cfif getgeneral.singlelocation eq 'Y'>
            <cfif form.locationfrom neq "">
			and location = '#form.locationfrom#'
			</cfif>
            <cfelse>
			<cfif form.locationfrom neq "" and form.locationto neq "">
			and location between '#form.locationfrom#' and '#form.locationto#'
			</cfif>
            </cfif>
			<cfif form.period neq "">
			and fperiod <='#form.period#' and fperiod<>'99'
			<cfelse>
			and fperiod<>'99'
			</cfif>
			<cfif form.itemfrom neq "" and form.itemto neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#'
			</cfif>
			<cfif form.target_date neq "">
			and wos_date <= '#lsdateformat(form.target_date,"yyyy-mm-dd")#'
			</cfif>
			group by location,itemno
			order by location,itemno
		) as c on a.location=c.location and a.itemno=c.itemno 
		
		where a.itemno=a.itemno
        <cfif getgeneral.singlelocation eq 'Y'>
        <cfif form.locationfrom neq "">
		and a.location = '#form.locationfrom#'
		</cfif>
        <cfelse>
		<cfif form.locationfrom neq "" and form.locationto neq "">
		and a.location between '#form.locationfrom#' and '#form.locationto#'
		</cfif>
        </cfif>
		<cfif form.itemfrom neq "" and form.itemto neq "">
		and a.itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
        
	) as b on a.itemno=b.itemno
	
	where a.itemno=a.itemno 
	and b.location<>''
    <cfif getgeneral.singlelocation eq 'Y'>
    <cfif form.locationfrom neq "">
	and b.location = '#form.locationfrom#'
	</cfif>
    <cfelse>
	<cfif form.locationfrom neq "" and form.locationto neq "">
	and b.location between '#form.locationfrom#' and '#form.locationto#'
	</cfif>
    </cfif>
	<cfif form.itemfrom neq "" and form.itemto neq "">
	and a.itemno between '#form.itemfrom#' and '#form.itemto#'
	</cfif>
    <cfif form.groupfrom neq "" and form.groupto neq "">
			and a.wos_group between '#form.groupfrom#' and '#form.groupto#'
			</cfif>
            <cfif form.catefrom neq "" and form.cateto neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
	<cfif form.shelffrom neq "" and form.shelfto neq "">
	and a.shelf between '#form.shelffrom#' and '#form.shelfto#'
	</cfif>
	<cfif not isdefined("form.include_stock")>
	and b.balance<>0 
	</cfif> 
    <cfif isdefined("form.exclude_actual")>
	and b.locqactual<>0 
	</cfif> 
    <cfif form.brandfrom neq "" and form.brandto neq "">
	and a.brand between '#form.brandfrom#' and '#form.brandto#'
	</cfif>
    <cfif huserid eq 'ultralung'>
    and (a.graded='N' or a.graded is null or a.graded='')
    </cfif>
    
    <cfif lcase(hcomid) eq "simplysiti_i">
    order by b.location,a.itemno;
            <cfelse>
    <cfif isdefined('sortitem')>
    order by a.itemno,b.location;
    <cfelse>
	order by <cfif isdefined('form.itemdespsort')>a.desp,b.location<cfelse>b.location,a.shelf,a.itemno</cfif>
    </cfif>
    </cfif>
</cfquery>

<body>
<cfform name="location_physical_worksheetDO" action="location_physical_worksheetDO_updatestock.cfm" method="post">
<table align="center" class="data" width="100%" border="0" cellspacing="0">
	<cfoutput>
	<tr>
		<td colspan="8"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong><cfif lcase(hcomid) eq "mhca_i">Marketer<cfelse>Location</cfif> Physical Worksheet DO</strong></font></div></td>
	</tr>
	<!--- <cfif form.catefrom neq "" and form.cateto neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATE: #form.catefrom# - #form.cateto#</font></div></td>
		</tr>
	</cfif> --->
	<!--- <cfif form.groupfrom neq "" and form.groupto neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
		</tr>
	</cfif> --->
	<cfif form.itemfrom neq "" and form.itemto neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM.NO. #form.itemfrom# - #form.itemto#</font></div></td>
		</tr>
	</cfif>
	<cfif form.period neq "">
		<tr>
			<td colspan="8"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.period#</font></div></td>
		</tr>
	</cfif>
	<tr>
		<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td colspan="4"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
	</tr>
	</cfoutput>
	
	<tr>
		<td colspan="8"><hr/></td>
	</tr>
    <cfoutput>
    <tr>
    <td colspan="100%"><strong>Customer No :</strong> 
    <cfselect name="custno" id="custno" required="yes" message="Please Choose a Customer">
    <cfloop query="getcust">
    <option value="#custno#">#custno# - #name#</option>
    </cfloop>
    </cfselect>
    </td>
    </tr>
    <tr><td colspan="100%">&nbsp;</td></tr>
    </cfoutput>
	<tr>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">NO.</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><cfif lcase(hcomid) eq "mhca_i">MARKETER<cfelse>LOCATION</cfif></font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">ITEM NO.</font></div></td>
        <cfif getdisplaydetail.report_aitemno eq 'Y'>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">PRODUCT CODE.</font></div></td>
        </cfif>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">ITEM DESCRIPTION</font></div></td>
        <cfif lcase(hcomid) eq "ssuni_i">
        <td><div align="center"><font size="2" face="Times New Roman,Times,serif">PRICE</font></div></td>
        </cfif>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif">BOOK QTY</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif">CLOSING QTY</font></div></td>
		<td><div align="right"><font size="2" face="Times New Roman,Times,serif">ADJ.QTY</font></div></td>
		<td><div align="center"><font size="2" face="Times New Roman,Times,serif">SHELF</font></div></td>
	</tr>
	<tr>
		<td colspan="8"><hr/></td>
	</tr>
	
	
		<cfinput type="hidden" name="generate_adjustment_transaction" value="#iif(isdefined('form.generate_adjustment_transaction'),DE('yes'),DE('no'))#">
		<cfinput type="hidden" name="update_actual_qty" value="#iif(isdefined('form.update_actual_qty'),DE('yes'),DE('no'))#">
		<cfinput type="hidden" name="period" value="#form.period#">
		<cfinput type="hidden" name="target_date" value="#dateformat(form.target_date,'YYYY-MM-DD')#">
		<cfinput type="hidden" name="totalitem" value="#getiteminfo.recordcount#">
		
		<cfoutput query="getiteminfo">
			<tr onClick="javascript:document.location_physical_worksheetDO.actualqty#getiteminfo.currentrow#.select();" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td nowrap>
					<div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.currentrow#.</font></div>
				</td>
				<td nowrap>
					<input type="hidden" id="location#getiteminfo.currentrow#" name="location#getiteminfo.currentrow#" value="#convertquote(getiteminfo.location)#">
					<div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.location#.</font></div>
				</td>
				<td nowrap>
					<input type="hidden" id="itemno#getiteminfo.currentrow#" name="itemno#getiteminfo.currentrow#" value="#convertquote(getiteminfo.itemno)#">
					<div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.itemno#</font></div>
				</td>
                <cfif getdisplaydetail.report_aitemno eq 'Y'>
                <td nowrap>
					<div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.aitemno#</font></div>
				</td>
                </cfif>
				<td nowrap>
					<input type="hidden" id="desp#getiteminfo.currentrow#" name="desp#getiteminfo.currentrow#" value="#convertquote(getiteminfo.desp)#">
					<div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.desp#</font></div>
				</td>
                <cfif lcase(hcomid) eq "ssuni_i">
                <td><div align="center"><font size="2" face="Times New Roman,Times,serif">#numberformat(getiteminfo.price,",_.__")#</font></div></td>
                </cfif>
				<td nowrap>
					<input type="hidden" id="balance#getiteminfo.currentrow#" name="balance#getiteminfo.currentrow#" value="#convertquote(getiteminfo.balance)#">
					<div align="right"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.balance#</font></div>
				</td>
				<td nowrap>
					<input type="hidden" id="unit#getiteminfo.currentrow#" name="unit#getiteminfo.currentrow#" value="#convertquote(getiteminfo.unit)#">
					<div align="right"><cfinput type="text" id="actualqty#getiteminfo.currentrow#" name="actualqty#getiteminfo.currentrow#" value="#getiteminfo.locqactual#" size="5" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.location_physical_worksheetDO.adjqty#getiteminfo.currentrow#.value=calculate_adjusted_qty(document.location_physical_worksheetDO.balance#getiteminfo.currentrow#.value,document.location_physical_worksheetDO.actualqty#getiteminfo.currentrow#.value,'#getiteminfo.currentrow#');"></div>
				</td>
				<td nowrap>
					<input type="hidden" id="ucost#getiteminfo.currentrow#" name="ucost#getiteminfo.currentrow#" value="#convertquote(getiteminfo.price)#">
					<div align="right"><cfinput type="text" id="adjqty#getiteminfo.currentrow#" name="adjqty#getiteminfo.currentrow#" value="#val(getiteminfo.balance)-val(getiteminfo.locqactual)#" size="5" readonly></div>
				</td>
				<td nowrap>
					<div align="center"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.shelf#</font></div>
				</td>
                <cfset totalqty=totalqty+getiteminfo.balance>
            <cfset totalact=totalact+getiteminfo.locqactual>
			</tr>
		</cfoutput>
        <cfoutput>
    <tr><td colspan="100%"><hr></td></tr>
    <tr>
    <td colspan="3"></td>
    <cfif getdisplaydetail.report_aitemno eq 'Y'>
    <td></td>
    </cfif>
    <td>Total :</td>
    <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#totalqty#</font></div></td>
    <td><div align="right"><font size="2" face="Times New Roman,Times,serif">#totalact#</font></div></td>
    </tr>
    </cfoutput>
		<tr>
			<td colspan="8"><hr/></td>
		</tr>
		<tr align="center">
			<td colspan="8">
				<input type="submit" name="Submit" value="Submit">
				<input type="reset" name="Reset" value="Reset">
                <input type="button" name="ResetActualQty" value="Reset Actual Qty" onClick="setallzero()">
			</td>
		</tr>
	
</table>
</cfform>


</body>
</html>