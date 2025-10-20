<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Item Balance Enquires</title>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<cfquery name="getmodule" datasource="#dts#">
	select * 
	from modulecontrol;
</cfquery>

<CFIF form.choose is "Submit">  
<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
and itemno='#form.itemno#' 
 group by frrefno
</cfquery>

<cfset billupdated=valuelist(getdoupdated.frrefno)>
<cfelse>
<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#' 
			</cfif>
 group by frrefno
</cfquery>

<cfset billupdated=valuelist(getdoupdated.frrefno)>
</cfif>

<cfquery datasource="#dts#" name="getitem">

 <CFIF form.choose is "Submit">  
	<!--- <cfif isdefined("form.url.itemno1")> --->
	select 
	a.itemno,
	a.desp,
	a.despa,
	a.unit,
	a.price,
	a.packing,
	a.category,
	a.wos_group,
    a.ucost,
    ifnull(b.sumtotalin,0) as qtyin,
    ifnull(c.sumtotalout,0) as qtyout,
	ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance,
	ifnull(a.qtybf,0) as openbal
	from icitem as a
	
	left join 
	(
		select itemno,sum(qty) as sumtotalin 
		from ictran 
		where type in ('RC','CN','OAI','TRIN') 
		and itemno='#form.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
		group by itemno
	) as b on a.itemno=b.itemno
	
	left join 
	(
		select itemno,sum(qty) as sumtotalout 
		from ictran 
		where
		<cfif isdefined('form.dodate')>
                (type in ('DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
				<cfelse>

		type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
		and (toinv='' or toinv is null) 
		</cfif>
		and itemno='#form.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
		
		group by itemno
	) as c on a.itemno=c.itemno
	
	where a.itemno='#form.itemno#' 
    and (a.itemtype <> 'SV' or a.itemtype is null)
    <cfif isdefined('form.negative')>
    and ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0)<0
    </cfif>
	
<CFELSEIF form.choose is "Display">
	
		<!--- <cfif isdefined("form.url.itemno1")> --->
	select 
	a.itemno,
	a.desp,
	a.despa,
	a.unit,
	a.price,
	a.packing,
	a.category,
	a.wos_group,
    a.ucost,
    ifnull(b.sumtotalin,0) as qtyin,
    ifnull(c.sumtotalout,0) as qtyout,
	ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance,
	ifnull(a.qtybf,0) as openbal
	from icitem as a
	
	left join 
	(
		select itemno,sum(qty) as sumtotalin 
		from ictran 
		where type in ('RC','CN','OAI','TRIN') 
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#' 
			</cfif>
		
		and fperiod<>'99'
		and (void = '' or void is null)
		group by itemno
	) as b on a.itemno=b.itemno
	
	left join 
	(
		select itemno,sum(qty) as sumtotalout 
		from ictran 
		where
		<cfif isdefined('form.dodate')>
                (type in ('DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
				<cfelse>

		type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>)
		and (toinv='' or toinv is null)
		</cfif>
		<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
			and itemno between '#form.itemfrom#' and '#form.itemto#' 
			</cfif>
		and fperiod<>'99'
		and (void = '' or void is null) 
		
		group by itemno
	) as c on a.itemno=c.itemno
	
	where 1=1
    <cfif form.itemdesp eq "">
    <cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
    AND	a.itemno between '#form.itemfrom#' and  '#form.itemto#' 
    </cfif>
    <cfelse>
    AND a.itemno like "<cfif isdefined('leftdesp') eq false>%</cfif>#form.itemdesp#%" or a.desp like "<cfif isdefined('leftdesp') eq false>%</cfif>#form.itemdesp#%" or a.despa like "<cfif isdefined('leftdesp') eq false>%</cfif>#form.itemdesp#%"
	</cfif>	
    <cfif isdefined('form.negative')>
    AND ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0)<0
    </cfif>
    AND (a.itemtype <> 'SV' or a.itemtype is null)
    ORDER BY a.itemno
</cfif>
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
	select lcategory,lgroup from gsetup
</cfquery>




<body>
<h1><center>Item Balance Enquires</center></h1>
<cfoutput>
	<h2>
		<cfif form.choose is "Submit"> 
	Item - #form.itemno#
	<cfelseif form.choose is "Display">
				
			Item - #form.itemfrom# to #form.itemto#
			
			</cfif>
	</h2><br><br><br>
	
	<table align="center" class="data" width="95%">
		<tr> 
    		<th>Item No.</th>
    		<th>Name</th>
			<th>#getgsetup.lcategory#</th>
			<th>#getgsetup.lgroup#</th>	
            <cfif lcase(hcomid) eq "hyray_i">
            <th>In</th>
            <th>Out</th>	
            </cfif>
            <cfif getmodule.auto eq 1>
            <th>Supplier</th>
            <th>Cost</th>
            </cfif>
    		<th><cfif lcase(hcomid) eq "hyray_i">Balance<cfelse>On Hand</cfif></th>
			<cfif lcase(hcomid) eq "hyray_i"><th>Cost Price</th></cfif>
            <th><cfif lcase(hcomid) eq "hyray_i">Selling Price<cfelse>Price</cfif></th>
    		<th>Unit</th>
			<th>Packing</th>
		</tr>
		<cfloop query="getitem">
		<tr> 
     	 	<td>#getitem.itemno#</td>
      		<td>#getitem.desp#<br>#getitem.despa#</td>
	  		<td>#getitem.category#</td>
	  		<td>#getitem.wos_group#</td>
            <cfif lcase(hcomid) eq "hyray_i">
            <td>#getitem.qtyin#</td>
            <td>#getitem.qtyout#</td>
            </cfif>
            <cfif getmodule.auto eq 1>
            
            <cfquery name="getsupplier" datasource="#dts#">
			select custno,name from ictran where itemno='#getitem.itemno#' and type in ('RC','PO')
			</cfquery>
            <td>#getsupplier.custno#-#getsupplier.name#</td>
            <td align="right">#numberformat(getitem.ucost,",.____")#</td>
            </cfif>
      		<td><div align="center"><font color="FF0000"><a href="/default/report-stock/stockcard3.cfm?itemno=#getitem.itemno#&itembal=#getitem.openbal#&pf=&pt=&cf=&ct=&pef=&pet=&gpf=&gpt=&df=&dt=&sf=&st=&thislastaccdate=&dodate=Y">#getitem.balance#</a></font></div></td>
            <cfif lcase(hcomid) eq "hyray_i">
            <td align="right">#numberformat(getitem.ucost,",.____")#</td>
            </cfif>
	  		<td align="right">#numberformat(getitem.price,",.____")#</td>
      		<td>#getitem.unit#</td>
	  		<td>#getitem.packing#</td>
    	</tr></cfloop>
	</table>
</cfoutput>

<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>