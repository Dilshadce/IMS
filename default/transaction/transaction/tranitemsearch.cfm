<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfquery datasource='#dts#' name="getgeneral">
	Select * from gsetup
</cfquery>	

<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>
<html>
<head>
	<title>Create Or Edit Or View</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

  <h1></h1>
  <br>
  <cfoutput>Mode - #type#</cfoutput>
  <br>
  <cfoutput>Type - #stype#</cfoutput>

  <cfoutput>
	<!--- <cfif #type# eq "Create"> --->
	<!--- <form action="tranitemsearch.cfm?tran=#tran#&type=#type#&stype=#stype#&nexttranno=#nexttranno#&custno=#custno#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&currrate=#currrate#&refno3=#refno3#&agenno=#agenno#" method="post"> --->
	<!--- <input type="hidden" name="nexttranno" value="#nexttranno#"> --->
	<!--- <cfelse> --->
	<cfif checkcustom.customcompany eq "Y">
		<cfset remark5=url.remark5>
		<cfset remark6=url.remark6>
	<cfelse>
		<cfset remark5="">
		<cfset remark6="">
	</cfif>
	<form action="tranitemsearch.cfm?tran=#tran#&hmode=#hmode#&type=#type#&stype=#stype#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&currrate=#currrate#&refno3=#refno3#&agenno=#agenno#&remark5=#remark5#&remark6=#remark6#" method="post">
	<!--- <input type="hidden" name="nexttranno" value="#refno#"> --->
	<!--- </cfif> --->
	  <cfif isdefined("form.updunitcost")>
		<input type='hidden' name='updunitcost' value='#form.updunitcost#'>
	  </cfif>
  </cfoutput>

  <h4><a href="..\maintenance\Icitem2.cfm?type=Create" target="_blank">Creating a New Item</a></h4>

  <cfoutput>
	<h1>
	  Search By :
	  <select name="searchType">
	    <option value="itemno"><cfif (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")>Stock Code<cfelse>Item No</cfif></option>
	    <option value="aitemno" <cfif lcase(HcomID) eq "hairo_i">selected</cfif>><cfif (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")>Vendor's Code<cfelse>Product Code</cfif></option>
		<option value="desp" <cfif lcase(hcomid) eq "mhca_i" or lcase(hcomid) eq "ideal_i" or lcase(hcomid) eq "idealb_i" or lcase(hcomid) eq "bama_i">selected</cfif>>Description</option>
		<option value="category">Category</option>
		<option value="wos_group">Group</option>
		<option value="brand">Brand</option>
	    <!--- <option value="phone">#Type# Tel</option> --->
	  </select>
		<input type="checkbox" name="left" id="left" value="1" checked />
	  Search for Item :
      <input type="text" name="searchStr" value="">
	  <input type="submit" name="submit" value="Search"></h1>
  </cfoutput>

  <!--- <input type="hidden" name="type" value="#type#">
	<input type="hidden" name="refno" value="#refno#">
	<input type="hidden" name="custno" value="#custno#">
	<input type="hidden" name="invoicedate" value="#invoicedate#"> --->
  </form>

  <cfif isdefined("url.process")>
	<cfoutput><h1>#form.status#</h1><hr></cfoutput>
  </cfif>
	
<cfif lcase(HcomID) eq "mhca_i" or lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i">
	
	<cfif invoicedate neq "">
		<cfset date1=createDate(ListGetAt(invoicedate,3,"/"),ListGetAt(invoicedate,2,"/"),ListGetAt(invoicedate,1,"/"))>
	</cfif>
	<cfquery datasource='#dts#' name="type1">
		Select a.itemno,a.desp,a.aitemno,a.despa,a.brand,a.category,a.wos_group,a.fcurrcode,a.price,a.nonstkitem,a.unit,(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf
		from icitem a 
		
		left join
		(
			select itemno,sum(qty) as getlastin 
			from ictran
			where type in ('RC','CN','OAI','TRIN') 
			and fperiod <> '99'
			and (void = '' or void is null) 
			and ( linecode <>  'SV' or linecode is null)
			<cfif invoicedate neq "">
	    		and wos_date <= #date1#
	    	</cfif> 
			group by itemno
		) as b on a.itemno = b.itemno
	
		left join
		(
			select itemno,sum(qty) as getlastout 
			from ictran
			where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO')
			and fperiod <> '99'
			and toinv=''
			and (void = '' or void is null) 
			and ( linecode <>  'SV' or linecode is null)
			<cfif invoicedate neq "">
	    		and wos_date <= #date1#
	    	</cfif> 
			group by itemno
		) as c on a.itemno = c.itemno
		
		order by a.itemno desc limit 20
	</cfquery>
<cfelse>
	<cfquery datasource='#dts#' name="type1">
		Select itemno,aitemno,desp,despa,brand,category,fcurrcode,wos_group,price,nonstkitem,unit
		from Icitem order by created_on desc,wos_date desc,itemno limit 20
	</cfquery>
</cfif>
  
  <cfif isdefined("form.searchStr")>
	<cfif lcase(HcomID) eq "mhca_i" or lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i">
		<cfquery datasource="#dts#" name="exactResult">
		  	Select a.itemno,a.desp,a.despa,a.aitemno,a.brand,a.category,a.wos_group,a.fcurrcode,a.price,a.nonstkitem,a.unit,(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf 
			from icitem a
			
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in ('RC','CN','OAI','TRIN') 
				and fperiod <> '99'
				and (void = '' or void is null) 
				and ( linecode <>  'SV' or linecode is null)
				<cfif invoicedate neq "">
		    		and wos_date <= #date1#
		    	</cfif> 
				group by itemno
			) as b on a.itemno = b.itemno
		
			left join
			(
				select itemno,sum(qty) as getlastout 
				from ictran
				where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO')
				and fperiod <> '99'
				and toinv=''
				and (void = '' or void is null) 
				and ( linecode <>  'SV' or linecode is null)
				<cfif invoicedate neq "">
		    		and wos_date <= #date1#
		    	</cfif> 
				group by itemno
			) as c on a.itemno = c.itemno
			
			where a.#form.searchType# = '#form.searchStr#' <cfif form.searchType eq "desp"> or a.despa ='#form.searchStr#'</cfif>
			order by a.itemno desc,a.#form.searchType#
		</cfquery>
	
		<cfquery datasource="#dts#" name="similarResult">
		  	Select a.itemno,desp,despa,brand,aitemno,category,wos_group,fcurrcode,price,nonstkitem,unit,(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybf 
			from icitem a
			
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in ('RC','CN','OAI','TRIN') 
				and fperiod <> '99'
				and (void = '' or void is null) 
				and ( linecode <>  'SV' or linecode is null)
				<cfif invoicedate neq "">
		    		and wos_date <= #date1#
		    	</cfif> 
				group by itemno
			) as b on a.itemno = b.itemno
		
			left join
			(
				select itemno,sum(qty) as getlastout 
				from ictran
				where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO')
				and fperiod <> '99'
				and toinv=''
				and (void = '' or void is null) 
				and ( linecode <>  'SV' or linecode is null)
				<cfif invoicedate neq "">
		    		and wos_date <= #date1#
		    	</cfif> 
				group by itemno
			) as c on a.itemno = c.itemno
			
			where a.#form.searchType# like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> <cfif form.searchType eq "desp"> or a.despa like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"></cfif>
			order by a.itemno desc,a.#form.searchType#
		</cfquery>
	<cfelse>
		<cfquery datasource="#dts#" name="exactResult">
		  	Select itemno,desp,aitemno,despa,brand,category,fcurrcode,wos_group,price,nonstkitem,unit 
			from Icitem 
			where #form.searchType# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.searchStr#"> <cfif form.searchType eq "desp"> or despa =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.searchStr#"></cfif>
			order by itemno desc,#form.searchType#
		</cfquery>
	
		<cfquery datasource="#dts#" name="similarResult">
		  	Select itemno,desp,aitemno,despa,brand,category,fcurrcode,wos_group,price,nonstkitem,unit 
			from Icitem 
			where #form.searchType# like <cfif isdefined('form.left')><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.searchStr#%"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"></cfif> <cfif form.searchType eq "desp"> or despa like <cfif isdefined('form.left')><cfqueryparam cfsqltype="cf_sql_varchar" value="#form.searchStr#%"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"></cfif></cfif>
			order by itemno desc,#form.searchType#
		</cfquery>
	</cfif>

	<h2>Exact Result</h2>
	<cfif #exactResult.recordCount# neq 0>
	  <table align="center" class="data" width="700px">
	    <tr>
		  <th><cfif (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")>Stock Code<cfelse>Item No</cfif></th>
          <cfif getdisplaydetail.item_aitemno eq 'Y'>
          <th>Product Code</th>
          </cfif>
		  <th>Description</th>
		  <th>Brand</th>
		  <th>Category</th>
		  <th>Group</th>
		  <th>Price</th>
		  <th>Status</th>
		  <th>Unit</th>
		  <cfif lcase(HcomID) eq "mhca_i" or lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i"><th>Qty On Hand</th></cfif>
		  <th>Action</th>
		</tr>

		<cfoutput query="exactResult">
		  <tr>
		    <td>#exactResult.itemno#</a></td>
            <cfif getdisplaydetail.item_aitemno eq 'Y'>
         	<td>#exactResult.aitemno#</td>
          	</cfif>
		    <td>#exactResult.desp#<br>#exactResult.despa#</td>
		    <td>#exactResult.brand#</td>
		    <td>#exactResult.category#</td>
		    <td>#exactResult.wos_group#</td>
		    <td>#exactResult.price#</td>
            <cfif lcase(hcomid) eq "sdc_i">
            <td>#exactResult.fcurrcode#</td>
            </cfif>
			<td>#exactResult.nonstkitem#</td>
			<td>#exactResult.unit#</td>
			<cfif lcase(HcomID) eq "mhca_i" or lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i"><td>#exactResult.qtybf#</td></cfif>
		    <td>
			<cfif exactResult.nonstkitem neq "T">
				<cfif type eq "Create">
					<a href="transaction3.cfm?tran=#tran#&hmode=#hmode#&type=#type#&stype=#stype#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#urlencodedformat(exactResult.itemno)#&currrate=#currrate#&refno3=#refno3#&agenno=#agenno#&remark5=#remark5#&remark6=#remark6#">Select</a>
				<cfelse>
					<a href="transaction3.cfm?tran=#tran#&hmode=#hmode#&type=#type#&stype=#stype#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&itemno1=#urlencodedformat(exactResult.itemno)#&currrate=#currrate#&refno3=#refno3#&agenno=#agenno#&remark5=#remark5#&remark6=#remark6#">Select</a>
				</cfif>
			</cfif>
		    </td>
		  </tr>
	    </cfoutput>
	  </table>
	<cfelse>
	  <h3>No Exact Records were found.</h3>
	</cfif>

	<h2>Similar Result</h2>
	<cfif #similarResult.recordCount# neq 0>
	  <table align="center" class="data" width="700px">
		<tr>
		  <th><cfif (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")>Stock Code<cfelse>Item No</cfif></th>
          <cfif getdisplaydetail.item_aitemno eq 'Y'>
          <th>Product Code</th>
          </cfif>
		  <th>Description</th>
		  <th>Brand</th>
		  <th>Category</th>
		  <th>Group</th>
		  <th>Price</th>
          <cfif lcase(hcomid) eq "sdc_i">
          <th>Curr Code</th>
          </cfif>
		  <th>Status</th>
		  <th>Unit</th>
		  <cfif lcase(HcomID) eq "mhca_i" or lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i"><th>Qty On Hand</th></cfif>
		  <th>Action</th>
		</tr>

		<cfoutput query="similarResult">
		  <tr>
		    <td>#similarResult.itemno#</a></td>
            <cfif getdisplaydetail.item_aitemno eq 'Y'>
          <td>#similarResult.aitemno#</td>
          </cfif>
		    <td>#similarResult.desp#<br>#similarResult.despa#</td>
		    <td>#similarResult.brand#</td>
		    <td>#similarResult.category#</td>
		    <td>#similarResult.wos_group#</td>
		    <td>#similarResult.price#</td>
			<td>#similarResult.nonstkitem#</td>
			<td>#similarResult.unit#</td>
			<cfif lcase(HcomID) eq "mhca_i" or lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i"><td>#similarResult.qtybf#</td></cfif>
		    <td>
			<cfif similarResult.nonstkitem neq "T">			
				<cfif type eq "Create">
					<a href='transaction3.cfm?tran=#tran#&hmode=#hmode#&type=#type#&itemno1=#urlencodedformat(similarResult.itemno)#&stype=#stype#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&currrate=#currrate#&refno3=#refno3#&agenno=#agenno#&remark5=#remark5#&remark6=#remark6#'>Select</a>
				<cfelse>
					<a href='transaction3.cfm?tran=#tran#&hmode=#hmode#&type=#type#&itemno1=#urlencodedformat(similarResult.itemno)#&stype=#stype#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&currrate=#currrate#&refno3=#refno3#&agenno=#agenno#&remark5=#remark5#&remark6=#remark6#'>Select</a>
				</cfif>
			</cfif>
		    </td>
		  </tr>
	    </cfoutput>
	  </table>
	<cfelse>
	  <h3>No Similar Records were found.</h3>
	</cfif>
  </cfif>

  <cfparam name="i" default="1" type="numeric">
  <hr>

  <fieldset>
    <legend style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;
	  font-style: italic;line-height: normal;font-weight: bold;text-transform: capitalize;color: #0066FF;">
	<cfoutput>20 Newest Icitem:</cfoutput></legend><br>
	<cfif #type1.recordCount# neq 0>
	  <table align="center" class="data" width="700px">
		<tr>
		  <th>No.</th>
		  <th><cfif (lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i")>Stock Code<cfelse>Item No</cfif></th>
          <cfif getdisplaydetail.item_aitemno eq 'Y'>
          <th>Product Code</th>
          </cfif>
		  <th>Description</th>
		  <th>Brand</th>
		  <th>Category</th>
		  <th>Group</th>
		  <th>Price</th>
          <cfif lcase(hcomid) eq "sdc_i">
          <th>Curr Code</th>
          </cfif>
		  <th>Status</th>
		  <th>Unit</th>
		  <cfif lcase(HcomID) eq "mhca_i" or lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i"><th>Qty On Hand</th></cfif>
		  <th>Action</th>
		</tr>
		<cfoutput query="type1" maxrows="20">
		  <tr>
		    <td>#i#</td>
		    <td>#type1.itemno#</a></td>
            <cfif getdisplaydetail.item_aitemno eq 'Y'>
            <td>#type1.aitemno#</a></td>
            </cfif>
		    <td>#type1.desp#<br>#type1.despa#</td>
		    <td>#type1.brand#</td>
		    <td>#type1.category#</td>
		    <td>#type1.wos_group#</td>
		    <td>#type1.price#</td>
            <cfif lcase(hcomid) eq "sdc_i">
            <td>#type1.fcurrcode#</td>
            </cfif>
			<td>#type1.nonstkitem#</td>
			<td>#type1.unit#</td>
		  	<cfif lcase(HcomID) eq "mhca_i" or lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i"><td>#type1.qtybf#</td></cfif>
		    <td>
			<cfif type1.nonstkitem neq "T">
				<cfif type eq "Create">
					<a href="transaction3.cfm?tran=#tran#&itemno1=#urlencodedformat(type1.itemno)#&hmode=#hmode#&stype=#stype#&type=#type#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&currrate=#currrate#&refno3=#refno3#&agenno=#agenno#&remark5=#remark5#&remark6=#remark6#">Select</a>
				<cfelse>
					<a href="transaction3.cfm?tran=#tran#&itemno1=#urlencodedformat(type1.itemno)#&hmode=#hmode#&stype=#stype#&type=#type#&nexttranno=#nexttranno#&custno=#URLEncodedFormat(custno)#&invoicedate=#invoicedate#&readperiod=#readperiod#&ndatecreate=#ndatecreate#&currrate=#currrate#&refno3=#refno3#&agenno=#agenno#&remark5=#remark5#&remark6=#remark6#">Select</a>
				</cfif>
			</cfif>
		    </td>
		  </tr>
		  <cfset i = incrementvalue(#i#)>
		</cfoutput>
	  </table>
	<cfelse>
	  <h3>No Records were found.</h3>
	</cfif>
	<br>
  </fieldset>
  <!--- <cfelse>
	<h1>URL Error. Please Click On The Correct Link.</h1>
  </cfif> --->
</body>
</html>