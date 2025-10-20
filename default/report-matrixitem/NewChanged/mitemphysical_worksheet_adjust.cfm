<html>
<head>
<title>Physical Worksheet Report</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<script language="javascript" type="text/javascript">
	function calculate_adjusted_qty(balance,actual)
	{
		var qty_balance=parseFloat(balance);
		var qty_actual=parseFloat(actual);
		var result=qty_balance-qty_actual;
		return result;
	}
	
</script>

<cfinclude template="../../CFC/convert_single_double_quote_script.cfm">
<cfif form.target_Date neq "">
<cfset ndate = createdate(right(form.target_Date,4),mid(form.target_Date,4,2),left(form.target_Date,2))>
<cfset form.target_Date = ndate >
</cfif>
<cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'INV','DO','DN','PR','CS','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'INV','DO','DN','PR','CS','ISS','OAR','TROU'">
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select compro from gsetup;
</cfquery>

<body>
<cfoutput>
<cfset location = form.locationfrom>
<cfquery name="getitemno" datasource="#dts#">
INSERT INTO LOCQDBF (itemno,location,LOCQFIELD,LOCQACTUAL,LOCQTRAN,LMINIMUM,LREORDER,QTY_BAL,VAL_BAL,PRICE,WOS_GROUP,CATEGORY,SHELF,SUPP)
  	select itemno,'#location#','0.0000000','0.0000000','0.0000000','0.0000000','0.0000000','0.0000000','0.0000000','0.0000000','','','','' from icitem where itemno not in (select itemno from locqdbf where location = "#location#") 
	<cfif form.itemfrom neq "" and form.itemto neq "">
	and itemno between '#form.itemfrom#' and '#form.itemto#'
	</cfif>
</cfquery>
</cfoutput>
<cfquery name="ClearICBil_M" datasource="#dts#">
  	truncate r_IcBil_M
</cfquery>

<cfquery name="ClearICBil_S" datasource="#dts#">
  	truncate r_IcBil_S
</cfquery>

<table align="center" width="100%" border="1" cellspacing="0">
	<cfoutput>
	<tr>
		<td colspan="37"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Inventory Physical Worksheet</strong></font></div></td>
	</tr>
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		<tr>
			<td colspan="37"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATE: #form.catefrom# - #form.cateto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<tr>
			<td colspan="37"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		<tr>
			<td colspan="37"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM.NO. #form.itemfrom# - #form.itemto#</font></div></td>
		</tr>
	</cfif>
	<cfif form.period neq "">
		<tr>
			<td colspan="37"><div align="center"><font size="2" face="Times New Roman, Times, serif">PERIOD: #form.period#</font></div></td>
		</tr>
	</cfif>
	<cfif form.target_Date neq "">
		<tr>
			<td colspan="37"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE: #dateformat(form.target_Date,'DD/MM/YYYY')#</font></div></td>
		</tr>
	</cfif>
	<tr>
		<td colspan="17"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td colspan="18"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
	</tr>
	</cfoutput>
	<tr>
		<td colspan="37"><hr/></td>
	</tr>
	<tr>
		<td rowspan="6"><div align="center"><font size="2" face="Times New Roman,Times,serif"><br><br>ART NO.</font></div></td>
        <td rowspan="6"><div align="center"><font size="2" face="Times New Roman,Times,serif"><cfif lcase(hcomid) eq "mhca_i">MARKETER<cfelse><br><br>LOCATION</cfif></font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">38</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">39</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">40</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">41</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">42</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">43</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">44</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">45</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">46</font></div></td>
        <td rowspan="6"><div align="center"><font size="2" face="Times New Roman,Times,serif"><br><br>QTY</font></div></td>
	</tr>
    <tr>
    <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">4</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">&nbsp;</font>H</div></td>
    <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">5</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">H&nbsp;</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">6</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">7</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">8</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">9</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">10</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">11</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
    </tr>
    <tr>
    <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">22</font></div></td>
		<td colspan="2"><div align="center">H</div></td>
    <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">23</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">24</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">25</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">26</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">27</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">28</font></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">29</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">H</font></div></td>
    </tr>
    <tr>
    <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">35</font></div></td>
		<td colspan="2"><div align="center"></div></td>
    <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">36</font></div></td>
		<td colspan="2"><div align="center"></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">37</font></div></td>
		<td colspan="2"><div align="center"></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">38</font></div></td>
		<td colspan="2"><div align="center"></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">39</font></div></td>
		<td colspan="2"><div align="center"></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">40</font></div></td>
		<td colspan="2"><div align="center"></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">41</font></div></td>
		<td colspan="2"><div align="center"></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">42</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">44</font></div></td>
    </tr>
    <tr>
    <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">27</font></div></td>
		<td colspan="2"><div align="center"></div></td>
    <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">28</font></div></td>
		<td colspan="2"><div align="center"></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">29</font></div></td>
		<td colspan="2"><div align="center"></div></td>
		<td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">30</font></div></td>
		<td colspan="2"><div align="center"></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">31</font></div></td>
		<td colspan="2"><div align="center"></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">32</font></div></td>
		<td colspan="2"><div align="center"></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">33</font></div></td>
		<td colspan="2"><div align="center"></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">34</font></div></td>
        <td colspan="2"><div align="center"><font size="2" face="Times New Roman,Times,serif">35</font></div></td>
    </tr>
    <tr>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Bal Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Actual Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Bal Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Actual Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Bal Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Actual Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Bal Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Actual Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Bal Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Actual Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Bal Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Actual Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Bal Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Actual Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Bal Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Actual Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Bal Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Actual Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Bal Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Actual Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Bal Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Actual Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Bal Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Actual Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Bal Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Actual Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Bal Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Actual Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Bal Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Actual Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Bal Qty</font></div></td>
    <td><div align="center"><font size="2" face="Times New Roman,Times,serif">Actual Qty</font></div></td>
    </tr>
	<tr>
		<td colspan="37"><hr/></td>
	</tr>
	<cfoutput>
<cfquery name="getiteminfo" datasource="#dts#">
	select 
	a.itemno,
	a.desp,
	a.unit,
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

			and location = '#form.locationfrom#'

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
			
			where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
			and toinv='' 

			and location = '#form.locationfrom#'

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
		
		and a.location = '#form.locationfrom#'

		<cfif form.itemfrom neq "" and form.itemto neq "">
		and a.itemno between '#form.itemfrom#' and '#form.itemto#'
		</cfif>
	) as b on a.itemno=b.itemno
	
	where a.itemno=a.itemno 
	and b.location<>''

	and b.location = '#form.locationfrom#'

	<cfif form.itemfrom neq "" and form.itemto neq "">
	and a.itemno between '#form.itemfrom#' and '#form.itemto#'
	</cfif>
	<cfif form.shelffrom neq "" and form.shelfto neq "">
	and a.shelf between '#form.shelffrom#' and '#form.shelfto#'
	</cfif>
    <cfif form.sizefrom neq "" and form.sizeto neq "">
			and a.sizeid between '#form.sizefrom#' and '#form.sizeto#'
			</cfif>
    <cfif form.catefrom neq "" and form.cateto neq "">
			and a.category between '#form.catefrom#' and '#form.cateto#'
			</cfif>
	<cfif not isdefined("form.include_stock")>
	and b.balance<>0 
	</cfif> 
	order by b.location,a.shelf,a.itemno;
</cfquery>

		<cfset j=1>
		<cfloop query="getiteminfo">
        <cftry>
        <cfset itemno2 = listgetat(itemno,1,'-')&"-"&listgetat(itemno,2,'-')>
        <cfset itemno1 = listgetat(itemno,1,'-')>
        <cfquery name="getitemdesp" datasource='#dts#'>
        select desp from icmitem where mitemno='#itemno1#' 
        </cfquery>
        
        <cfquery name="getitemsize" datasource='#dts#'>
        select sizeid from icitem where itemno='#getiteminfo.itemno#' 
        </cfquery>
        <cfquery name="getcolourdesp" datasource="#dts#">
                select desp from iccolor2 where colorno='#listgetat(itemno,2,'-')#'
                </cfquery>
        <cfset colour = getcolourdesp.desp>
        
        <cfif lcase(getitemsize.sizeid) eq 'male size'>
        
        <cfset qty1 = 'brem3'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.0'>
        <cfset qty1 = 'q040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.5'>
        <cfset qty1 = 'q045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.0'>
        <cfset qty1 = 'q050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.5'>
        <cfset qty1 = 'q055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.0'>
        <cfset qty1 = 'q060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.5'>
        <cfset qty1 = 'q065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.0'>
        <cfset qty1 = 'q070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.5'>
        <cfset qty1 = 'q075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '42.0'>
        <cfset qty1 = 'q080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '42.5'>
        <cfset qty1 = 'q085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '43.0'>
        <cfset qty1 = 'q090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '43.5'>
        <cfset qty1 = 'q095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '44.0'>
        <cfset qty1 = 'q100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '44.5'>
        <cfset qty1 = 'q105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '45.0'>
        <cfset qty1 = 'q110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '46.0'>
        <cfset qty1 = 'q115'>
        </cfif>
        
        <cfset qty2 = 'brem4'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.0'>
        <cfset qty2 = 'aq040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.5'>
        <cfset qty2 = 'aq045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.0'>
        <cfset qty2 = 'aq050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.5'>
        <cfset qty2 = 'aq055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.0'>
        <cfset qty2 = 'aq060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.5'>
        <cfset qty2 = 'aq065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.0'>
        <cfset qty2 = 'aq070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.5'>
        <cfset qty2 = 'aq075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '42.0'>
        <cfset qty2 = 'aq080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '42.5'>
        <cfset qty2 = 'aq085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '43.0'>
        <cfset qty2 = 'aq090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '43.5'>
        <cfset qty2 = 'aq095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '44.0'>
        <cfset qty2 = 'aq100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '44.5'>
        <cfset qty2 = 'aq105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '45.0'>
        <cfset qty2 = 'aq110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '46.0'>
        <cfset qty2 = 'aq115'>
        </cfif>
        
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.0'>
        <cfset title = 't040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.5'>
        <cfset title = 't045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.0'>
        <cfset title = 't050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.5'>
        <cfset title = 't055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.0'>
        <cfset title = 't060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.5'>
        <cfset title = 't065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.0'>
        <cfset title = 't070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.5'>
        <cfset title = 't075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '42.0'>
        <cfset title = 't080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '42.5'>
        <cfset title = 't085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '43.0'>
        <cfset title = 't090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '43.5'>
        <cfset title = 't095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '44.0'>
        <cfset title = 't100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '44.5'>
        <cfset title = 't105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '45.0'>
        <cfset title = 't110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '46.0'>
        <cfset title = 't115'>
        </cfif>
        
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f inch'>
        
        <cfset qty1 = 'brem3'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '4.0'>
        <cfset qty1 = 'q040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '4.5'>
        <cfset qty1 = 'q045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '5.0'>
        <cfset qty1 = 'q050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '5.5'>
        <cfset qty1 = 'q055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '6.0'>
        <cfset qty1 = 'q060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '6.5'>
        <cfset qty1 = 'q065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '7.0'>
        <cfset qty1 = 'q070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '7.5'>
        <cfset qty1 = 'q075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '8.0'>
        <cfset qty1 = 'q080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '8.5'>
        <cfset qty1 = 'q085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '9.0'>
        <cfset qty1 = 'q090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '9.5'>
        <cfset qty1 = 'q095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '10.0'>
        <cfset qty1 = 'q100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '10.5'>
        <cfset qty1 = 'q105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '11.0'>
        <cfset qty1 = 'q110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '11.5'>
        <cfset qty1 = 'q115'>
        </cfif>
        
        <cfset qty2 = 'brem4'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '4.0'>
        <cfset qty2 = 'aq040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '4.5'>
        <cfset qty2 = 'aq045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '5.0'>
        <cfset qty2 = 'aq050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '5.5'>
        <cfset qty2 = 'aq055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '6.0'>
        <cfset qty2 = 'aq060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '6.5'>
        <cfset qty2 = 'aq065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '7.0'>
        <cfset qty2 = 'aq070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '7.5'>
        <cfset qty2 = 'aq075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '8.0'>
        <cfset qty2 = 'aq080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '8.5'>
        <cfset qty2 = 'aq085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '9.0'>
        <cfset qty2 = 'aq090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '9.5'>
        <cfset qty2 = 'aq095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '10.0'>
        <cfset qty2 = 'aq100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '10.5'>
        <cfset qty2 = 'aq105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '11.0'>
        <cfset qty2 = 'aq110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '11.5'>
        <cfset qty2 = 'aq115'>
        </cfif>
        
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '4.0'>
        <cfset title = 't040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '4.5'>
        <cfset title = 't045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '5.0'>
        <cfset title = 't050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '5.5'>
        <cfset title = 't055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '6.0'>
        <cfset title = 't060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '6.5'>
        <cfset title = 't065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '7.0'>
        <cfset title = 't070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '7.5'>
        <cfset title = 't075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '8.0'>
        <cfset title = 't080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '8.5'>
        <cfset title = 't085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '9.0'>
        <cfset title = 't090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '9.5'>
        <cfset title = 't095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '10.0'>
        <cfset title = 't100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '10.5'>
        <cfset title = 't105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '11.0'>
        <cfset title = 't110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '11.5'>
        <cfset title = 't115'>
        </cfif>
        
        <cfelseif lcase(getitemsize.sizeid) eq 'm/f cm'>
        
        <cfset qty1 = 'brem3'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '22.0'>
        <cfset qty1 = 'q040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '22.5'>
        <cfset qty1 = 'q045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '23.0'>
        <cfset qty1 = 'q050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '23.5'>
        <cfset qty1 = 'q055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '24.0'>
        <cfset qty1 = 'q060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '24.5'>
        <cfset qty1 = 'q065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '25.0'>
        <cfset qty1 = 'q070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '25.5'>
        <cfset qty1 = 'q075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '26.0'>
        <cfset qty1 = 'q080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '26.5'>
        <cfset qty1 = 'q085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.0'>
        <cfset qty1 = 'q090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.5'>
        <cfset qty1 = 'q095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.0'>
        <cfset qty1 = 'q100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.5'>
        <cfset qty1 = 'q105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.0'>
        <cfset qty1 = 'q110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.5'>
        <cfset qty1 = 'q115'>
        </cfif>
        
        <cfset qty2 = 'brem4'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '22.0'>
        <cfset qty2 = 'aq040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '22.5'>
        <cfset qty2 = 'aq045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '23.0'>
        <cfset qty2 = 'aq050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '23.5'>
        <cfset qty2 = 'aq055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '24.0'>
        <cfset qty2 = 'aq060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '24.5'>
        <cfset qty2 = 'aq065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '25.0'>
        <cfset qty2 = 'aq070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '25.5'>
        <cfset qty2 = 'aq075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '26.0'>
        <cfset qty2 = 'aq080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '26.5'>
        <cfset qty2 = 'aq085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.0'>
        <cfset qty2 = 'aq090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.5'>
        <cfset qty2 = 'aq095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.0'>
        <cfset qty2 = 'aq100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.5'>
        <cfset qty2 = 'aq105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.0'>
        <cfset qty2 = 'aq110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.5'>
        <cfset qty2 = 'aq115'>
        </cfif>
        
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '22.0'>
        <cfset title = 't040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '22.5'>
        <cfset title = 't045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '23.0'>
        <cfset title = 't050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '23.5'>
        <cfset title = 't055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '24.0'>
        <cfset title = 't060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '24.5'>
        <cfset title = 't065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '25.0'>
        <cfset title = 't070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '25.5'>
        <cfset title = 't075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '26.0'>
        <cfset title = 't080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '26.5'>
        <cfset title = 't085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.0'>
        <cfset title = 't090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.5'>
        <cfset title = 't095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.0'>
        <cfset title = 't100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.5'>
        <cfset title = 't105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.0'>
        <cfset title = 't110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.5'>
        <cfset title = 't115'>
        </cfif>
        
        <cfelseif lcase(getitemsize.sizeid) eq 'children size '>
        <cfset qty1 = 'brem3'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.0'>
        <cfset qty1 = 'q040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.5'>
        <cfset qty1 = 'q045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.0'>
        <cfset qty1 = 'q050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.5'>
        <cfset qty1 = 'q055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.0'>
        <cfset qty1 = 'q060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.5'>
        <cfset qty1 = 'q065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '30.0'>
        <cfset qty1 = 'q070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '30.5'>
        <cfset qty1 = 'q075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '31.0'>
        <cfset qty1 = 'q080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '31.5'>
        <cfset qty1 = 'q085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '32.0'>
        <cfset qty1 = 'q090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '32.5'>
        <cfset qty1 = 'q095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '33.0'>
        <cfset qty1 = 'q100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '33.5'>
        <cfset qty1 = 'q105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '34.0'>
        <cfset qty1 = 'q110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '35.0'>
        <cfset qty1 = 'q115'>
        </cfif>
        
        <cfset qty2 = 'brem4'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.0'>
        <cfset qty2 = 'aq040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.5'>
        <cfset qty2 = 'aq045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.0'>
        <cfset qty2 = 'aq050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.5'>
        <cfset qty2 = 'aq055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.0'>
        <cfset qty2 = 'aq060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.5'>
        <cfset qty2 = 'aq065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '30.0'>
        <cfset qty2 = 'aq070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '30.5'>
        <cfset qty2 = 'aq075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '31.0'>
        <cfset qty2 = 'aq080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '31.5'>
        <cfset qty2 = 'aq085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '32.0'>
        <cfset qty2 = 'aq090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '32.5'>
        <cfset qty2 = 'aq095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '33.0'>
        <cfset qty2 = 'aq100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '33.5'>
        <cfset qty2 = 'aq105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '34.0'>
        <cfset qty2 = 'aq110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '35.0'>
        <cfset qty2 = 'aq115'>
        </cfif>
        
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.0'>
        <cfset title = 't040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '27.5'>
        <cfset title = 't045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.0'>
        <cfset title = 't050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '28.5'>
        <cfset title = 't055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.0'>
        <cfset title = 't060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '29.5'>
        <cfset title = 't065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '30.0'>
        <cfset title = 't070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '30.5'>
        <cfset title = 't075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '31.0'>
        <cfset title = 't080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '31.5'>
        <cfset title = 't085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '32.0'>
        <cfset title = 't090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '32.5'>
        <cfset title = 't095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '33.0'>
        <cfset title = 't100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '33.5'>
        <cfset title = 't105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '34.0'>
        <cfset title = 't110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '35.0'>
        <cfset title = 't115'>
        </cfif>
        
        
        <cfelse>
        <cfquery name="getcolourdesp" datasource="#dts#">
                select desp from iccolor2 where colorno='#listgetat(itemno,2,'-')#'
                </cfquery>
        <cfset colour = getcolourdesp.desp>
        <cfset qty1 = 'brem3'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '35.0'>
        <cfset qty1 = 'q040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '35.5'>
        <cfset qty1 = 'q045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '36.0'>
        <cfset qty1 = 'q050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '36.5'>
        <cfset qty1 = 'q055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '37.0'>
        <cfset qty1 = 'q060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '37.5'>
        <cfset qty1 = 'q065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.0'>
        <cfset qty1 = 'q070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.5'>
        <cfset qty1 = 'q075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.0'>
        <cfset qty1 = 'q080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.5'>
        <cfset qty1 = 'q085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.0'>
        <cfset qty1 = 'q090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.5'>
        <cfset qty1 = 'q095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.0'>
        <cfset qty1 = 'q100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.5'>
        <cfset qty1 = 'q105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '42.0'>
        <cfset qty1 = 'q110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '43.0'>
        <cfset qty1 = 'q115'>
        </cfif>
        
        <cfset qty2 = 'brem4'>
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '35.0'>
        <cfset qty2 = 'aq040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '35.5'>
        <cfset qty2 = 'aq045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '36.0'>
        <cfset qty2 = 'aq050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '36.5'>
        <cfset qty2 = 'aq055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '37.0'>
        <cfset qty2 = 'aq060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '37.5'>
        <cfset qty2 = 'aq065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.0'>
        <cfset qty2 = 'aq070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.5'>
        <cfset qty2 = 'aq075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.0'>
        <cfset qty2 = 'aq080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.5'>
        <cfset qty2 = 'aq085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.0'>
        <cfset qty2 = 'aq090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.5'>
        <cfset qty2 = 'aq095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.0'>
        <cfset qty2 = 'aq100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.5'>
        <cfset qty2 = 'aq105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '42.0'>
        <cfset qty2 = 'aq110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '43.0'>
        <cfset qty2 = 'aq115'>
        </cfif>
        
        <cfif numberformat(listgetat(itemno,3,'-'),'_._') eq '35.0'>
        <cfset title = 't040'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '35.5'>
        <cfset title = 't045'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '36.0'>
        <cfset title = 't050'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '36.5'>
        <cfset title = 't055'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '37.0'>
        <cfset title = 't060'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '37.5'>
        <cfset title = 't065'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.0'>
        <cfset title = 't070'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '38.5'>
        <cfset title = 't075'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.0'>
        <cfset title = 't080'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '39.5'>
        <cfset title = 't085'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.0'>
        <cfset title = 't090'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '40.5'>
        <cfset title = 't095'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.0'>
        <cfset title = 't100'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '41.5'>
        <cfset title = 't105'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '42.0'>
        <cfset title = 't110'>
        <cfelseif numberformat(listgetat(itemno,3,'-'),'_._') eq '43.0'>
        <cfset title = 't115'>
        </cfif>
        
        
        </cfif>
        
        <cfquery name="checkexistitemno" datasource='#dts#'>
        select itemno,amt,qty from r_icbil_s where counter_4='#itemno2#' and location='#getiteminfo.location#'
        </cfquery>
        <cfif checkexistitemno.recordcount eq 0>
        
		<cfquery name="InsertICBil_S" datasource='#dts#'>
	 		Insert into r_icbil_s (SRefno, No, ItemNo, Desp,despa, SN_No, Unit,qty,#qty1#,#qty2#,ucost, counter_4,location,#title#)
			values ('1','#j#','#itemno1#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#getiteminfo.desp#" >,'#colour#','',
			'#jsstringformat(getiteminfo.unit)#','#jsstringformat(getiteminfo.balance)#','#jsstringformat(getiteminfo.balance)#','#jsstringformat(getiteminfo.locqactual)#','#jsstringformat(getiteminfo.ucost)#','#itemno2#','#jsstringformat(getiteminfo.location)#','#jsstringformat(getiteminfo.itemno)#')
	  	</cfquery>
         <cfelse>
    <cfset qtytotal=checkexistitemno.qty+getiteminfo.balance>
    <cfquery name="InsertICBil_S" datasource='#dts#'>
	 		update r_icbil_s set #qty2#='#jsstringformat(getiteminfo.locqactual)#',#qty1# = '#jsstringformat(getiteminfo.balance)#',qty='#qtytotal#',#title#='#jsstringformat(getiteminfo.itemno)#' where counter_4='#itemno2#' and location='#getiteminfo.location#'
	  	</cfquery>
</cfif>
<cfset j=j+1>
<cfcatch>
        </cfcatch>
        </cftry>
		</cfloop>
        
        
<cfform name="physical_worksheet_adjust" action="mitemphysical_worksheet_update_stock.cfm" method="post">
		<input type="hidden" name="generate_adjustment_transaction" value="#iif(isdefined('form.generate_adjustment_transaction'),DE('yes'),DE('no'))#">
		<input type="hidden" name="update_actual_qty" value="#iif(isdefined('form.update_actual_qty'),DE('yes'),DE('no'))#">
		<input type="hidden" name="period" value="#form.period#">
		<input type="hidden" name="target_date" value="#dateformat(form.target_date,'DD/MM/YYYY')#">
        <cfquery name="getdata" datasource='#dts#'>
        select * from r_icbil_s
        </cfquery>
        <cfset total = 0>
        <cfset count = 0>
        
        <cfloop query="getdata">
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><div align="center"><font size="2" face="Times New Roman,Times,serif">#getdata.COUNTER_4#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getdata.location#</font></div></td>	
                <td nowrap>
                <cfset itemcode=getdata.t040>
					<div align="center">
						<a href="mitemlocation_stockcard_stock_card2.cfm
						?itemno=#urlencodedformat(itemcode)#
						&pf=#urlencodedformat(form.itemfrom)#
						&pt=#urlencodedformat(form.itemto)#
						&cf=#urlencodedformat(form.catefrom)#
						&ct=#urlencodedformat(form.cateto)#
						&pet=#urlencodedformat(form.period)#
						&gpf=#urlencodedformat(form.groupfrom)#
						&gpt=#urlencodedformat(form.groupto)#
						&dt=#urlencodedformat(form.target_date)#
						&location=#urlencodedformat(getdata.location)#">
						<font size="2" face="Times New Roman,Times,serif">#getdata.q040#</font></a>
					</div>
				</td>
				<cfset count=count+1>
                <td>
                <cfinput type="hidden" name="balance#count#" id="balance#count#" value="#getdata.q040#">
                <cfinput type="hidden" name="itemno#count#" id="itemno#count#" value="#getdata.t040#">
                <cfif getdata.t040 neq "">
                <cfinput type="text" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq040#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                <cfelse>
                <cfinput type="hidden" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq040#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                </cfif>
                <input type="hidden" id="adjqty#count#" name="adjqty#count#" value="#val(getdata.q040)-val(getdata.aq040)#" size="2" readonly>
                <input type="hidden" id="desp#count#" name="desp#count#" value="#convertquote(getdata.desp)#">
                <input type="hidden" id="unit#count#" name="unit#count#" value="#convertquote(getdata.unit)#">
                <input type="hidden" id="ucost#count#" name="ucost#count#" value="#convertquote(getdata.ucost)#">
                <input type="hidden" id="location#count#" name="location#count#" value="#convertquote(getdata.location)#">                </td>
                <td nowrap>
                <cfset itemcode=getdata.t045>
					<div align="center">
						<a href="mitemlocation_stockcard_stock_card2.cfm
						?itemno=#urlencodedformat(itemcode)#
						&pf=#urlencodedformat(form.itemfrom)#
						&pt=#urlencodedformat(form.itemto)#
						&cf=#urlencodedformat(form.catefrom)#
						&ct=#urlencodedformat(form.cateto)#
						&pet=#urlencodedformat(form.period)#
						&gpf=#urlencodedformat(form.groupfrom)#
						&gpt=#urlencodedformat(form.groupto)#
						&dt=#urlencodedformat(form.target_date)#
						&location=#urlencodedformat(getdata.location)#">
						<font size="2" face="Times New Roman,Times,serif">#getdata.q045#</font></a>
					</div>
				</td>
                <td>
                <cfset count=count+1>
                
                <cfinput type="hidden" name="balance#count#" id="balance#count#" value="#getdata.q045#">
                <cfinput type="hidden" name="itemno#count#" id="itemno#count#" value="#getdata.t045#">
                <cfif getdata.t045 neq "">
                <cfinput type="text" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq045#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                <cfelse>
                <cfinput type="hidden" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq045#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                </cfif>
                <input type="hidden" id="adjqty#count#" name="adjqty#count#" value="#val(getdata.q045)-val(getdata.aq045)#" size="2" readonly>
                <input type="hidden" id="desp#count#" name="desp#count#" value="#convertquote(getdata.desp)#">
                <input type="hidden" id="unit#count#" name="unit#count#" value="#convertquote(getdata.unit)#">
                <input type="hidden" id="ucost#count#" name="ucost#count#" value="#convertquote(getdata.ucost)#">
                <input type="hidden" id="location#count#" name="location#count#" value="#convertquote(getdata.location)#">                </td>	
                <td nowrap>
                <cfset itemcode=getdata.t050>
					<div align="center">
						<a href="mitemlocation_stockcard_stock_card2.cfm
						?itemno=#urlencodedformat(itemcode)#
						&pf=#urlencodedformat(form.itemfrom)#
						&pt=#urlencodedformat(form.itemto)#
						&cf=#urlencodedformat(form.catefrom)#
						&ct=#urlencodedformat(form.cateto)#
						&pet=#urlencodedformat(form.period)#
						&gpf=#urlencodedformat(form.groupfrom)#
						&gpt=#urlencodedformat(form.groupto)#
						&dt=#urlencodedformat(form.target_date)#
						&location=#urlencodedformat(getdata.location)#">
						<font size="2" face="Times New Roman,Times,serif">#getdata.q050#</font></a>
					</div>
				</td>			
				<cfset count=count+1>
                
                <td>
                <cfinput type="hidden" name="balance#count#" id="balance#count#" value="#getdata.q050#">
                <cfinput type="hidden" name="itemno#count#" id="itemno#count#" value="#getdata.t050#">
                <cfif getdata.t050 neq "">
                <cfinput type="text" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq050#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                <cfelse>
                <cfinput type="hidden" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq050#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                </cfif>
                <input type="hidden" id="adjqty#count#" name="adjqty#count#" value="#val(getdata.q050)-val(getdata.aq050)#" size="2" readonly>
                <input type="hidden" id="desp#count#" name="desp#count#" value="#convertquote(getdata.desp)#">
                <input type="hidden" id="unit#count#" name="unit#count#" value="#convertquote(getdata.unit)#">
                <input type="hidden" id="ucost#count#" name="ucost#count#" value="#convertquote(getdata.ucost)#">
                <input type="hidden" id="location#count#" name="location#count#" value="#convertquote(getdata.location)#">                </td>	
                <td nowrap>
                <cfset itemcode=getdata.t055>
					<div align="center">
						<a href="mitemlocation_stockcard_stock_card2.cfm
						?itemno=#urlencodedformat(itemcode)#
						&pf=#urlencodedformat(form.itemfrom)#
						&pt=#urlencodedformat(form.itemto)#
						&cf=#urlencodedformat(form.catefrom)#
						&ct=#urlencodedformat(form.cateto)#
						&pet=#urlencodedformat(form.period)#
						&gpf=#urlencodedformat(form.groupfrom)#
						&gpt=#urlencodedformat(form.groupto)#
						&dt=#urlencodedformat(form.target_date)#
						&location=#urlencodedformat(getdata.location)#">
						<font size="2" face="Times New Roman,Times,serif">#getdata.q055#</font></a>
					</div>
				</td>			
				<cfset count=count+1>
               
                <td>
                <cfinput type="hidden" name="balance#count#" id="balance#count#" value="#getdata.q055#">
                <cfinput type="hidden" name="itemno#count#" id="itemno#count#" value="#getdata.t055#">
                <cfif getdata.t055 neq "">
                <cfinput type="text" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq055#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                <cfelse>
                <cfinput type="hidden" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq055#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                </cfif>
                <input type="hidden" id="adjqty#count#" name="adjqty#count#" value="#val(getdata.q055)-val(getdata.aq055)#" size="2" readonly>
                <input type="hidden" id="desp#count#" name="desp#count#" value="#convertquote(getdata.desp)#">
                <input type="hidden" id="unit#count#" name="unit#count#" value="#convertquote(getdata.unit)#">
                <input type="hidden" id="ucost#count#" name="ucost#count#" value="#convertquote(getdata.ucost)#">
                <input type="hidden" id="location#count#" name="location#count#" value="#convertquote(getdata.location)#">                </td>	
                <td nowrap>
                <cfset itemcode=getdata.t060>
					<div align="center">
						<a href="mitemlocation_stockcard_stock_card2.cfm
						?itemno=#urlencodedformat(itemcode)#
						&pf=#urlencodedformat(form.itemfrom)#
						&pt=#urlencodedformat(form.itemto)#
						&cf=#urlencodedformat(form.catefrom)#
						&ct=#urlencodedformat(form.cateto)#
						&pet=#urlencodedformat(form.period)#
						&gpf=#urlencodedformat(form.groupfrom)#
						&gpt=#urlencodedformat(form.groupto)#
						&dt=#urlencodedformat(form.target_date)#
						&location=#urlencodedformat(getdata.location)#">
						<font size="2" face="Times New Roman,Times,serif">#getdata.q060#</font></a>
					</div>
				</td>			
				<cfset count=count+1>
               
                <td>
                <cfinput type="hidden" name="balance#count#" id="balance#count#" value="#getdata.q060#">
                <cfinput type="hidden" name="itemno#count#" id="itemno#count#" value="#getdata.t060#">
                <cfif getdata.t060 neq "">
                <cfinput type="text" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq060#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                <cfelse>
                <cfinput type="hidden" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq060#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                </cfif>
                <input type="hidden" id="adjqty#count#" name="adjqty#count#" value="#val(getdata.q060)-val(getdata.aq060)#" size="2" readonly>
                <input type="hidden" id="desp#count#" name="desp#count#" value="#convertquote(getdata.desp)#">
                <input type="hidden" id="unit#count#" name="unit#count#" value="#convertquote(getdata.unit)#">
                <input type="hidden" id="ucost#count#" name="ucost#count#" value="#convertquote(getdata.ucost)#">
                <input type="hidden" id="location#count#" name="location#count#" value="#convertquote(getdata.location)#">                </td>	
                <td nowrap>
                <cfset itemcode=getdata.t065>
					<div align="center">
						<a href="mitemlocation_stockcard_stock_card2.cfm
						?itemno=#urlencodedformat(itemcode)#
						&pf=#urlencodedformat(form.itemfrom)#
						&pt=#urlencodedformat(form.itemto)#
						&cf=#urlencodedformat(form.catefrom)#
						&ct=#urlencodedformat(form.cateto)#
						&pet=#urlencodedformat(form.period)#
						&gpf=#urlencodedformat(form.groupfrom)#
						&gpt=#urlencodedformat(form.groupto)#
						&dt=#urlencodedformat(form.target_date)#
						&location=#urlencodedformat(getdata.location)#">
						<font size="2" face="Times New Roman,Times,serif">#getdata.q065#</font></a>
					</div>
				</td>			
				<cfset count=count+1>
               
                <td>
                <cfinput type="hidden" name="balance#count#" id="balance#count#" value="#getdata.q065#">
                <cfinput type="hidden" name="itemno#count#" id="itemno#count#" value="#getdata.t065#">
                <cfif getdata.t065 neq "">
                <cfinput type="text" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq065#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                <cfelse>
                <cfinput type="hidden" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq065#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                </cfif>
                <input type="hidden" id="adjqty#count#" name="adjqty#count#" value="#val(getdata.q065)-val(getdata.aq065)#" size="2" readonly>
                <input type="hidden" id="desp#count#" name="desp#count#" value="#convertquote(getdata.desp)#">
                <input type="hidden" id="unit#count#" name="unit#count#" value="#convertquote(getdata.unit)#">
                <input type="hidden" id="ucost#count#" name="ucost#count#" value="#convertquote(getdata.ucost)#">
                <input type="hidden" id="location#count#" name="location#count#" value="#convertquote(getdata.location)#">                </td>	
                <td nowrap>
                <cfset itemcode=getdata.t070>
					<div align="center">
						<a href="mitemlocation_stockcard_stock_card2.cfm
						?itemno=#urlencodedformat(itemcode)#
						&pf=#urlencodedformat(form.itemfrom)#
						&pt=#urlencodedformat(form.itemto)#
						&cf=#urlencodedformat(form.catefrom)#
						&ct=#urlencodedformat(form.cateto)#
						&pet=#urlencodedformat(form.period)#
						&gpf=#urlencodedformat(form.groupfrom)#
						&gpt=#urlencodedformat(form.groupto)#
						&dt=#urlencodedformat(form.target_date)#
						&location=#urlencodedformat(getdata.location)#">
						<font size="2" face="Times New Roman,Times,serif">#getdata.q070#</font></a>
					</div>
				</td>			
				<cfset count=count+1>
               
                <td>
                <cfinput type="hidden" name="balance#count#" id="balance#count#" value="#getdata.q070#">
                <cfinput type="hidden" name="itemno#count#" id="itemno#count#" value="#getdata.t070#">
                <cfif getdata.t070 neq "">
                <cfinput type="text" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq070#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                <cfelse>
                <cfinput type="hidden" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq070#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                </cfif>
                <input type="hidden" id="adjqty#count#" name="adjqty#count#" value="#val(getdata.q070)-val(getdata.aq070)#" size="2" readonly>
                <input type="hidden" id="desp#count#" name="desp#count#" value="#convertquote(getdata.desp)#">
                <input type="hidden" id="unit#count#" name="unit#count#" value="#convertquote(getdata.unit)#">
                <input type="hidden" id="ucost#count#" name="ucost#count#" value="#convertquote(getdata.ucost)#">
                <input type="hidden" id="location#count#" name="location#count#" value="#convertquote(getdata.location)#">                </td>		
                <td nowrap>
                <cfset itemcode=getdata.t075>
					<div align="center">
						<a href="mitemlocation_stockcard_stock_card2.cfm
						?itemno=#urlencodedformat(itemcode)#
						&pf=#urlencodedformat(form.itemfrom)#
						&pt=#urlencodedformat(form.itemto)#
						&cf=#urlencodedformat(form.catefrom)#
						&ct=#urlencodedformat(form.cateto)#
						&pet=#urlencodedformat(form.period)#
						&gpf=#urlencodedformat(form.groupfrom)#
						&gpt=#urlencodedformat(form.groupto)#
						&dt=#urlencodedformat(form.target_date)#
						&location=#urlencodedformat(getdata.location)#">
						<font size="2" face="Times New Roman,Times,serif">#getdata.q075#</font></a>
					</div>
				</td>		
				<cfset count=count+1>
               
                <td>
                <cfinput type="hidden" name="balance#count#" id="balance#count#" value="#getdata.q075#">
                <cfinput type="hidden" name="itemno#count#" id="itemno#count#" value="#getdata.t075#">
                <cfif getdata.t075 neq "">
                <cfinput type="text" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq075#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                <cfelse>
                <cfinput type="hidden" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq075#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                </cfif>
                <input type="hidden" id="adjqty#count#" name="adjqty#count#" value="#val(getdata.q075)-val(getdata.aq075)#" size="2" readonly>
                <input type="hidden" id="desp#count#" name="desp#count#" value="#convertquote(getdata.desp)#">
                <input type="hidden" id="unit#count#" name="unit#count#" value="#convertquote(getdata.unit)#">
                <input type="hidden" id="ucost#count#" name="ucost#count#" value="#convertquote(getdata.ucost)#">
                <input type="hidden" id="location#count#" name="location#count#" value="#convertquote(getdata.location)#">                </td>		
                <td nowrap>
                <cfset itemcode=getdata.t080>
					<div align="center">
						<a href="mitemlocation_stockcard_stock_card2.cfm
						?itemno=#urlencodedformat(itemcode)#
						&pf=#urlencodedformat(form.itemfrom)#
						&pt=#urlencodedformat(form.itemto)#
						&cf=#urlencodedformat(form.catefrom)#
						&ct=#urlencodedformat(form.cateto)#
						&pet=#urlencodedformat(form.period)#
						&gpf=#urlencodedformat(form.groupfrom)#
						&gpt=#urlencodedformat(form.groupto)#
						&dt=#urlencodedformat(form.target_date)#
						&location=#urlencodedformat(getdata.location)#">
						<font size="2" face="Times New Roman,Times,serif">#getdata.q080#</font></a>
					</div>
				</td>		
				<cfset count=count+1>
               
                <td>
                <cfinput type="hidden" name="balance#count#" id="balance#count#" value="#getdata.q080#">
                <cfinput type="hidden" name="itemno#count#" id="itemno#count#" value="#getdata.t080#">
                <cfif getdata.t080 neq "">
                <cfinput type="text" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq080#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                <cfelse>
                <cfinput type="hidden" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq080#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                </cfif>
                <input type="hidden" id="adjqty#count#" name="adjqty#count#" value="#val(getdata.q080)-val(getdata.aq080)#" size="2" readonly>
                <input type="hidden" id="desp#count#" name="desp#count#" value="#convertquote(getdata.desp)#">
                <input type="hidden" id="unit#count#" name="unit#count#" value="#convertquote(getdata.unit)#">
                <input type="hidden" id="ucost#count#" name="ucost#count#" value="#convertquote(getdata.ucost)#">
                <input type="hidden" id="location#count#" name="location#count#" value="#convertquote(getdata.location)#">                </td>
                <td nowrap>
                <cfset itemcode=getdata.t085>
					<div align="center">
						<a href="mitemlocation_stockcard_stock_card2.cfm
						?itemno=#urlencodedformat(itemcode)#
						&pf=#urlencodedformat(form.itemfrom)#
						&pt=#urlencodedformat(form.itemto)#
						&cf=#urlencodedformat(form.catefrom)#
						&ct=#urlencodedformat(form.cateto)#
						&pet=#urlencodedformat(form.period)#
						&gpf=#urlencodedformat(form.groupfrom)#
						&gpt=#urlencodedformat(form.groupto)#
						&dt=#urlencodedformat(form.target_date)#
						&location=#urlencodedformat(getdata.location)#">
						<font size="2" face="Times New Roman,Times,serif">#getdata.q085#</font></a>
					</div>
				</td>				
				<cfset count=count+1>
               
                <td>
                <cfinput type="hidden" name="balance#count#" id="balance#count#" value="#getdata.q085#">
                <cfinput type="hidden" name="itemno#count#" id="itemno#count#" value="#getdata.t085#">
                <cfif getdata.t085 neq "">
                <cfinput type="text" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq085#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                <cfelse>
                <cfinput type="hidden" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq085#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                </cfif>
                <input type="hidden" id="adjqty#count#" name="adjqty#count#" value="#val(getdata.q085)-val(getdata.aq085)#" size="2" readonly>
                <input type="hidden" id="desp#count#" name="desp#count#" value="#convertquote(getdata.desp)#">
                <input type="hidden" id="unit#count#" name="unit#count#" value="#convertquote(getdata.unit)#">
                <input type="hidden" id="ucost#count#" name="ucost#count#" value="#convertquote(getdata.ucost)#">
                <input type="hidden" id="location#count#" name="location#count#" value="#convertquote(getdata.location)#">                </td>	
                <td nowrap>
                <cfset itemcode=getdata.t090>
					<div align="center">
						<a href="mitemlocation_stockcard_stock_card2.cfm
						?itemno=#urlencodedformat(itemcode)#
						&pf=#urlencodedformat(form.itemfrom)#
						&pt=#urlencodedformat(form.itemto)#
						&cf=#urlencodedformat(form.catefrom)#
						&ct=#urlencodedformat(form.cateto)#
						&pet=#urlencodedformat(form.period)#
						&gpf=#urlencodedformat(form.groupfrom)#
						&gpt=#urlencodedformat(form.groupto)#
						&dt=#urlencodedformat(form.target_date)#
						&location=#urlencodedformat(getdata.location)#">
						<font size="2" face="Times New Roman,Times,serif">#getdata.q090#</font></a>
					</div>
				</td>			
				<cfset count=count+1>
                
                <td>
                <cfinput type="hidden" name="balance#count#" id="balance#count#" value="#getdata.q090#">
                <cfinput type="hidden" name="itemno#count#" id="itemno#count#" value="#getdata.t090#">
                <cfif getdata.t090 neq "">
                <cfinput type="text" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq090#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                <cfelse>
                <cfinput type="hidden" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq090#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                </cfif>
                <input type="hidden" id="adjqty#count#" name="adjqty#count#" value="#val(getdata.q090)-val(getdata.aq090)#" size="2" readonly>
                <input type="hidden" id="desp#count#" name="desp#count#" value="#convertquote(getdata.desp)#">
                <input type="hidden" id="unit#count#" name="unit#count#" value="#convertquote(getdata.unit)#">
                <input type="hidden" id="ucost#count#" name="ucost#count#" value="#convertquote(getdata.ucost)#">
                <input type="hidden" id="location#count#" name="location#count#" value="#convertquote(getdata.location)#">                </td>		
                <td nowrap>
                <cfset itemcode=getdata.t095>
					<div align="center">
						<a href="mitemlocation_stockcard_stock_card2.cfm
						?itemno=#urlencodedformat(itemcode)#
						&pf=#urlencodedformat(form.itemfrom)#
						&pt=#urlencodedformat(form.itemto)#
						&cf=#urlencodedformat(form.catefrom)#
						&ct=#urlencodedformat(form.cateto)#
						&pet=#urlencodedformat(form.period)#
						&gpf=#urlencodedformat(form.groupfrom)#
						&gpt=#urlencodedformat(form.groupto)#
						&dt=#urlencodedformat(form.target_date)#
						&location=#urlencodedformat(getdata.location)#">
						<font size="2" face="Times New Roman,Times,serif">#getdata.q095#</font></a>
					</div>
				</td>		
				<cfset count=count+1>
               
                <td>
                <cfinput type="hidden" name="balance#count#" id="balance#count#" value="#getdata.q095#">
                <cfinput type="hidden" name="itemno#count#" id="itemno#count#" value="#getdata.t095#">
                <cfif getdata.t095 neq "">
                <cfinput type="text" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq095#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                <cfelse>
                <cfinput type="hidden" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq095#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                </cfif>
                <input type="hidden" id="adjqty#count#" name="adjqty#count#" value="#val(getdata.q095)-val(getdata.aq095)#" size="2" readonly>
                <input type="hidden" id="desp#count#" name="desp#count#" value="#convertquote(getdata.desp)#">
                <input type="hidden" id="unit#count#" name="unit#count#" value="#convertquote(getdata.unit)#">
                <input type="hidden" id="ucost#count#" name="ucost#count#" value="#convertquote(getdata.ucost)#">
                <input type="hidden" id="location#count#" name="location#count#" value="#convertquote(getdata.location)#">                </td>	
                <td nowrap>
                <cfset itemcode=getdata.t100>
					<div align="center">
						<a href="mitemlocation_stockcard_stock_card2.cfm
						?itemno=#urlencodedformat(itemcode)#
						&pf=#urlencodedformat(form.itemfrom)#
						&pt=#urlencodedformat(form.itemto)#
						&cf=#urlencodedformat(form.catefrom)#
						&ct=#urlencodedformat(form.cateto)#
						&pet=#urlencodedformat(form.period)#
						&gpf=#urlencodedformat(form.groupfrom)#
						&gpt=#urlencodedformat(form.groupto)#
						&dt=#urlencodedformat(form.target_date)#
						&location=#urlencodedformat(getdata.location)#">
						<font size="2" face="Times New Roman,Times,serif">#getdata.q100#</font></a>
					</div>
				</td>			
				<cfset count=count+1>
                
                <td>
                <cfinput type="hidden" name="balance#count#" id="balance#count#" value="#getdata.q100#">
                <cfinput type="hidden" name="itemno#count#" id="itemno#count#" value="#getdata.t100#">
                <cfif getdata.t100 neq "">
                <cfinput type="text" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq100#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                <cfelse>
                <cfinput type="hidden" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq100#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                </cfif>
                <input type="hidden" id="adjqty#count#" name="adjqty#count#" value="#val(getdata.q100)-val(getdata.aq100)#" size="2" readonly>
                <input type="hidden" id="desp#count#" name="desp#count#" value="#convertquote(getdata.desp)#">
                <input type="hidden" id="unit#count#" name="unit#count#" value="#convertquote(getdata.unit)#">
                <input type="hidden" id="ucost#count#" name="ucost#count#" value="#convertquote(getdata.ucost)#">
                <input type="hidden" id="location#count#" name="location#count#" value="#convertquote(getdata.location)#">                </td>		
                <td nowrap>
                <cfset itemcode=getdata.t105>
					<div align="center">
						<a href="mitemlocation_stockcard_stock_card2.cfm
						?itemno=#urlencodedformat(itemcode)#
						&pf=#urlencodedformat(form.itemfrom)#
						&pt=#urlencodedformat(form.itemto)#
						&cf=#urlencodedformat(form.catefrom)#
						&ct=#urlencodedformat(form.cateto)#
						&pet=#urlencodedformat(form.period)#
						&gpf=#urlencodedformat(form.groupfrom)#
						&gpt=#urlencodedformat(form.groupto)#
						&dt=#urlencodedformat(form.target_date)#
						&location=#urlencodedformat(getdata.location)#">
						<font size="2" face="Times New Roman,Times,serif">#getdata.q105#</font></a>
					</div>
				</td>		
				<cfset count=count+1>
                
                <td>
                <cfinput type="hidden" name="balance#count#" id="balance#count#" value="#getdata.q105#">
                <cfinput type="hidden" name="itemno#count#" id="itemno#count#" value="#getdata.t105#">
                <cfif getdata.t105 neq "">
                <cfinput type="text" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq105#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                <cfelse>
                <cfinput type="hidden" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq105#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                </cfif>
                <input type="hidden" id="adjqty#count#" name="adjqty#count#" value="#val(getdata.q105)-val(getdata.aq105)#" size="2" readonly>
                <input type="hidden" id="desp#count#" name="desp#count#" value="#convertquote(getdata.desp)#">
                <input type="hidden" id="unit#count#" name="unit#count#" value="#convertquote(getdata.unit)#">
                <input type="hidden" id="ucost#count#" name="ucost#count#" value="#convertquote(getdata.ucost)#">
                <input type="hidden" id="location#count#" name="location#count#" value="#convertquote(getdata.location)#">                </td>
                <td nowrap>
                <cfset itemcode=getdata.t110>
					<div align="center">
						<a href="mitemlocation_stockcard_stock_card2.cfm
						?itemno=#urlencodedformat(itemcode)#
						&pf=#urlencodedformat(form.itemfrom)#
						&pt=#urlencodedformat(form.itemto)#
						&cf=#urlencodedformat(form.catefrom)#
						&ct=#urlencodedformat(form.cateto)#
						&pet=#urlencodedformat(form.period)#
						&gpf=#urlencodedformat(form.groupfrom)#
						&gpt=#urlencodedformat(form.groupto)#
						&dt=#urlencodedformat(form.target_date)#
						&location=#urlencodedformat(getdata.location)#">
						<font size="2" face="Times New Roman,Times,serif">#getdata.q110#</font></a>
					</div>
				</td>				
				<cfset count=count+1>
                
                <td>
                <cfinput type="hidden" name="balance#count#" id="balance#count#" value="#getdata.q110#">
                <cfinput type="hidden" name="itemno#count#" id="itemno#count#" value="#getdata.t110#">
                <cfif getdata.t110 neq "">
                <cfinput type="text" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq110#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                <cfelse>
                <cfinput type="hidden" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq110#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                </cfif>
                <input type="hidden" id="adjqty#count#" name="adjqty#count#" value="#val(getdata.q110)-val(getdata.aq110)#" size="2" readonly>
                <input type="hidden" id="desp#count#" name="desp#count#" value="#convertquote(getdata.desp)#">
                <input type="hidden" id="unit#count#" name="unit#count#" value="#convertquote(getdata.unit)#">
                <input type="hidden" id="ucost#count#" name="ucost#count#" value="#convertquote(getdata.ucost)#">
                <input type="hidden" id="location#count#" name="location#count#" value="#convertquote(getdata.location)#">                </td>
                
                 <td nowrap>
                <cfset itemcode=getdata.t115>
					<div align="center">
						<a href="mitemlocation_stockcard_stock_card2.cfm
						?itemno=#urlencodedformat(itemcode)#
						&pf=#urlencodedformat(form.itemfrom)#
						&pt=#urlencodedformat(form.itemto)#
						&cf=#urlencodedformat(form.catefrom)#
						&ct=#urlencodedformat(form.cateto)#
						&pet=#urlencodedformat(form.period)#
						&gpf=#urlencodedformat(form.groupfrom)#
						&gpt=#urlencodedformat(form.groupto)#
						&dt=#urlencodedformat(form.target_date)#
						&location=#urlencodedformat(getdata.location)#">
						<font size="2" face="Times New Roman,Times,serif">#getdata.q115#</font></a>
					</div>
				</td>		
                
                <cfset count=count+1>
                <td>
                <cfinput type="hidden" name="balance#count#" id="balance#count#" value="#getdata.q115#">
                <cfinput type="hidden" name="itemno#count#" id="itemno#count#" value="#getdata.t115#">
                <cfif getdata.t115 neq "">
                <cfinput type="text" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq115#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                <cfelse>
                <cfinput type="hidden" name="actualqty#count#" id="actualqty#count#" value="#getdata.aq115#" size="2" message="Please Enter A Correct Quantity !" required="no" validate="float" onKeyUp="javascript:document.physical_worksheet_adjust.adjqty#count#.value=calculate_adjusted_qty(document.physical_worksheet_adjust.balance#count#.value,document.physical_worksheet_adjust.actualqty#count#.value);">
                </cfif>
                <input type="hidden" id="adjqty#count#" name="adjqty#count#" value="#val(getdata.q115)-val(getdata.aq115)#" size="2" readonly>
                <input type="hidden" id="desp#count#" name="desp#count#" value="#convertquote(getdata.desp)#">
                <input type="hidden" id="unit#count#" name="unit#count#" value="#convertquote(getdata.unit)#">
                <input type="hidden" id="ucost#count#" name="ucost#count#" value="#convertquote(getdata.ucost)#">
                <input type="hidden" id="location#count#" name="location#count#" value="#convertquote(getdata.location)#">                </td>
                
                <cfquery name="gettotalqty" datasource='#dts#'>
	 		select sum(qty) as sumqty from r_icbil_s where counter_4='#getdata.counter_4#' and location = '#getdata.location#'
	  	</cfquery>
                <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#gettotalqty.sumqty#</font></div></td>
             
                
		<cfset total=total+16>
			</tr>
            </cfloop>
		<tr>
			<td colspan="37" align="center">
            <input type="hidden" name="huserid" id="huserid" value="#huserid#">
            <input type="hidden" name="totalitem" value="#total#">
            <input type="submit" name="Submit" value="Submit">
			<input type="reset" name="Reset" value="Reset">
            <input type="button" name="Print" value="Print" onClick="window.print();">                </td>
		</tr>
        </cfform>
	</cfoutput>
</table>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>