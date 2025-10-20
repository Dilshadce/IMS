<cfparam name='ndatefrom' default=''>
<cfparam name='ndateto' default=''>

<cfif isdefined('form.datefrom') and isdefined('form.dateto')>
  	<cfset dd=dateformat(form.datefrom, 'DD')>	
  	
	<cfif dd greater than '12'>
		<cfset ndatefrom=dateformat(form.datefrom,'YYYYMMDD')>
  	<cfelse>
		<cfset ndatefrom=dateformat(form.datefrom,'YYYYDDMM')>
  	</cfif>
	
	<cfset dd=dateformat(form.dateto, 'DD')>	
  	
	<cfif dd greater than '12'>
		<cfset ndateto=dateformat(form.dateto,'YYYYMMDD')>
  	<cfelse>
		<cfset ndateto=dateformat(form.dateto,'YYYYDDMM')>
  	</cfif>	
</cfif>

<cfquery name='getgeneral' datasource='#dts#'>
	<!---   select #prefix# as prefix, compro, compro2, compro3, compro4, compro5, compro6, compro7 from gsetup  --->
	select compro, compro2, compro3, compro4, compro5, compro6, compro7, cost, lastaccyear from gsetup 
</cfquery>

<cfquery name='getHeader' datasource='#dts#'>
  	select a.itemno,a.desp, a.category, a.sizeid, a.costcode, a.colorid, a.shelf, a.wos_group, 
  	b.custno, b.wos_date, b.fperiod, b.currrate from icitem a, ictran b 
  	where (b.type = 'INV' or b.type = 'CN' or b.type = 'DN' or b.type = 'CS') and a.itemno = b.itemno 
	<cfif form.productfrom neq '' and form.productto neq ''>
    and a.itemno >='#form.productfrom#' and a.itemno <='#form.productto#' 
  	</cfif>
  	<cfif form.Custfrom neq '' and form.Custto neq ''>
    and b.custno >='#form.Custfrom#' and b.custno <='#form.Custto#' 
  	</cfif>
  	<cfif form.catefrom neq '' and form.cateto neq ''>
	and a.category >= '#form.catefrom#' and a.category <= '#form.cateto#' 
  	</cfif>
  	<cfif form.sizeidfrom neq '' and form.sizeidto neq ''>
	and a.sizeid >= '#form.sizeidfrom#' and a.sizeid <= '#form.sizeidto#' 
  	</cfif>
  	<cfif form.costcodefrom neq '' and form.costcodeto neq ''>
	and a.costcode >= '#form.costcodefrom#' and a.costcode <= '#form.costcodeto#' 
  	</cfif>
  	<cfif form.coloridfrom neq '' and form.coloridto neq ''>
	and a.colorid >= '#form.coloridfrom#' and a.colorid <= '#form.coloridto#' 
  	</cfif>
  	<cfif form.shelffrom neq '' and form.shelfto neq ''>
	and a.shelf >= '#form.shelffrom#' and a.shelf <= '#form.shelfto#' 
  	</cfif>
  	<cfif form.groupfrom neq '' and form.groupto neq ''>
	and a.wos_group >= '#form.groupfrom#' and a.wos_group <= '#form.groupto#' 
  	</cfif>
  	<cfif form.periodfrom neq '' and form.periodto neq ''>
	and b.fperiod >= '#form.periodfrom#' and b.fperiod <= '#form.periodto#' 
  	</cfif>
  	<cfif ndatefrom neq '' and ndateto neq ''>
    and b.wos_date >='#ndatefrom#' and b.wos_date <= '#ndateto#' 
  	<cfelse>
    and b.wos_date > #getgeneral.lastaccyear#
  	</cfif>
	
	<cfswitch expression='#form.rgSort#'>
		<cfcase value='Item No'>
	  	group by a.itemno order by a.itemno
		</cfcase>
		<cfcase value='Customer'>
	  	group by b.custno,a.itemno order by b.custno, a.itemno
		</cfcase>
  	</cfswitch>
</cfquery>
<!--- <!--- Control The Decimal Point --->
<cfquery name='getgsetup2' datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = #getgsetup2.Decl_Uprice#>
<cfset stDecl_UPrice = '.'>
<cfloop index='LoopCount' from='1' to='#iDecl_UPrice#'>
  <cfset stDecl_UPrice = #stDecl_UPrice# & '_'>
</cfloop> --->

<cfquery name='ClearRPMargin' datasource='#dts#'>
  	truncate r_pmargin
</cfquery>

<cfset monthnow = month(now())>

<!--- For Grand FC Total --->
<cfset CurrArray = ArrayNew(2)>
<cfset CurrArray[1][1] = 'Currency - '>
<cfset CurrArray[1][2] = 'FC.S.Amt'>
<cfset CurrArray[1][3] = 'FC.S.Cost'>
<cfset CurrArray[1][4] = 'FC.G.Profit'>
<cfset CurrArray[2][1] = 'SGD'>
<cfset CurrArray[2][2] = 0>
<cfset CurrArray[2][3] = 0>
<cfset CurrArray[2][4] = 0>

<cfquery name='getCurrCode' datasource='#dts#'>
  	select CurrCode from Currencyrate order by currcode 
</cfquery>

<cfset i = 2>

<cfloop query='getCurrCode'>
  	<cfif getCurrCode.CurrCode neq 'SGD'>
    	<cfset i = i + 1>
    	<cfset CurrArray[i][1] = getCurrCode.CurrCode>
    	<cfset CurrArray[i][2] = 0>
    	<cfset CurrArray[i][3] = 0>
    	<cfset CurrArray[i][4] = 0>
  	</cfif>
</cfloop>

<!--- Track the Max Curr Code --->
<cfset CurrArray[1][1] = CurrArray[1][1] & ToString(#i# - 1)>

<cfloop query = 'getHeader'> 
  	<cfset invamt = 0>
  	<cfset csamt = 0>
 	<cfset dnamt = 0>
  	<cfset cnamt = 0>
  	<cfset invamt_bil = 0>
  	<cfset csamt_bil = 0>
  	<cfset dnamt_bil = 0>
  	<cfset cnamt_bil = 0>
  	<cfset itembal = 0>
  	<cfset xprice = 0.00>

  	<cfquery name='getinv' datasource='#dts#'>
    	select sum(amt_bil)as sumamt_bil, sum(amt)as sumamt from ictran where type = 'INV' and itemno = '#getHeader.itemno#' and (void = '' or void is null)
    	<cfif ndatefrom neq '' and ndateto neq ''>
      	and wos_date >='#ndatefrom#' and wos_date <= '#ndateto#'
	  	<cfelse>
	  	and wos_date > #getgeneral.lastaccyear#  
    	</cfif>
  	</cfquery>

  	<cfquery name='getcn' datasource='#dts#'>
    	select sum(amt_bil)as sumamt_bil, sum(amt)as sumamt from ictran where type = 'CN' and itemno ='#getHeader.itemno#'  and (void = '' or void is null)
    	<cfif ndatefrom neq '' and ndateto neq ''>
      	and wos_date >='#ndatefrom#' and wos_date <= '#ndateto#' 
	  	<cfelse>
	  	and wos_date > #getgeneral.lastaccyear#
    	</cfif>
  	</cfquery>

   	<cfquery name='getdn' datasource='#dts#'>
    	select sum(amt_bil)as sumamt_bil, sum(amt)as sumamt from ictran where type = 'DN' and itemno = '#getHeader.itemno#'  and (void = '' or void is null)
    	<cfif ndatefrom neq '' and ndateto neq ''>
      	and wos_date >='#ndatefrom#' and wos_date <= '#ndateto#' 
	  	<cfelse>
	  	and wos_date > #getgeneral.lastaccyear# 
    	</cfif>
  	</cfquery>

  	<cfquery name='getcs' datasource='#dts#'>
    	select sum(amt_bil)as sumamt_bil, sum(amt)as sumamt from ictran where type = 'CS' and itemno = '#getHeader.itemno#'  and (void = '' or void is null)
    	<cfif ndatefrom neq '' and ndateto neq ''>
      	and wos_date >='#ndatefrom#' and wos_date <= '#ndateto#' 
	  	<cfelse>
	  	and wos_date > #getgeneral.lastaccyear#
    	</cfif>
  	</cfquery>

  
    <cfif getinv.sumamt neq ''>
      	<cfset invamt_bil = getinv.sumamt_bil>
      	<cfset invamt = getinv.sumamt>
    </cfif>
  
    <cfif getcn.sumamt neq ''>
      	<cfset cnamt_bil = getcn.sumamt_bil>
      	<cfset cnamt = getcn.sumamt>
    </cfif>
  
    <cfif getdn.sumamt neq ''>
      	<cfset dnamt_bil = getdn.sumamt_bil>
      	<cfset dnamt = getdn.sumamt>
    </cfif>
  
   	<cfif getcs.sumamt neq ''>
     	<cfset csamt_bil = getcs.sumamt_bil>
     	<cfset csamt = getcs.sumamt>
   	</cfif>
  	  
  	<cfset totalamt_bil = invamt_bil + dnamt_bil + csamt_bil>
  	<cfset netamt_bil = totalamt_bil - cnamt_bil>
  	<cfset totalamt = invamt + dnamt + csamt>
  	<cfset netamt = totalamt - cnamt>
     
  	<cfif getgeneral.cost eq 'month'>
    	<cfif monthnow eq '1'>
    	  	<cfset lastmonth = '12'>
    	<cfelse>
      		<cfset lastmonth = monthnow - 1>
    	</cfif>

    	<cfquery datasource='#dts#' name='lastprice'>
      		select sum(amt)as sumamt,sum(qty) as qty from ictran where itemno = '#itemno#' and month(wos_date) = '#lastmonth#' and type = 'RC'  and (void = '' or void is null)
    	</cfquery>
    	
		<cfif lastprice.sumamt neq ''>
      		<cfset lastpriceamt = lastprice.sumamt>
    	<cfelse>
      		<cfset lastpriceamt = 0>
    	</cfif>
    
		<cfif lastprice.qty neq ''>
    		<cfset lastpriceqty = lastprice.qty>
    	<cfelse>
      		<cfset lastpriceqty = 0>
    	</cfif>
    
		<cfquery datasource='#dts#' name='lastprprice'>
      		select sum(amt)as sumamt,sum(qty) as qty from ictran where itemno = '#itemno#' and month(wos_date) = '#lastmonth#' and type = 'PR'  and (void = '' or void is null)
    	</cfquery>
    	
		<cfif lastprprice.sumamt neq ''>
      		<cfset lastprpriceamt = lastprprice.sumamt>
    	<cfelse>
      		<cfset lastprpriceamt = 0>
    	</cfif>
    
		<cfif lastprprice.qty neq ''>
      		<cfset lastprpriceqty = lastprprice.qty>
    	<cfelse>
    	  	<cfset lastprpriceqty = 0>
    	</cfif>
    
		<cfquery datasource='#dts#' name='pricenow'>
      		select sum(amt)as sumamt,sum(qty) as qty from ictran where itemno = '#itemno#' and month(wos_date) = '#monthnow#' and type = 'RC'  and (void = '' or void is null)
    	</cfquery>
    	
		<cfif pricenow.sumamt neq ''>
      		<cfset pricenowamt = pricenow.sumamt>
    	<cfelse>
      		<cfset pricenowamt = 0>
    	</cfif>
    	
		<cfif pricenow.qty neq ''>
      		<cfset pricenowqty = pricenow.qty>
    	<cfelse>
      		<cfset pricenowqty = 0>
    	</cfif>
		
    	<cfquery datasource='#dts#' name='prpricenow'>
      		select sum(amt)as sumamt,sum(qty) as qty from ictran where itemno = '#itemno#' and month(wos_date) = '#monthnow#' and type = 'PR'  and (void = '' or void is null)
    	</cfquery>
    
		<cfif prpricenow.sumamt neq ''>
      		<cfset prpricenowamt = prpricenow.sumamt>
    	<cfelse>
      		<cfset prpricenowamt = 0>
    	</cfif>
    	
		<cfif prpricenow.qty neq ''>
      		<cfset prpricenowqty = prpricenow.qty>
    	<cfelse>
      		<cfset prpricenowqty = 0>
    	</cfif>

    	<cfset up =  lastpriceamt - lastprpriceamt + pricenowamt - prpricenowamt>
    	<cfset down = itembal + lastpriceqty - lastprpriceqty + pricenowqty - prpricenowqty>
    	
		<cfif down neq 0>
      		<cfset xprice = up/ down>
      		<cfset xprice = numberformat(xprice,'.__')>
    	</cfif>
	<cfelseif getgeneral.cost eq 'moving'>
      	
		<cfquery datasource='#dts#' name='getprice'>
        	select sum(amt)as sumamt,sum(qty) as qty from ictran where itemno = '#itemno#' and type = 'RC'  and (void = '' or void is null)
      	</cfquery>
      	
		<cfif getprice.sumamt neq ''>
        	<cfset getpriceamt = getprice.sumamt>
      	<cfelse>
         	<cfset getpriceamt = 0>
      	</cfif>
	  
      	<cfif getprice.qty neq ''>
        	<cfset getpriceqty = getprice.qty>
      	<cfelse>
        	<cfset getpriceqty = 0>
      	</cfif>
    
	  	<cfquery datasource='#dts#' name='prprice'>
        	select sum(amt)as sumamt,sum(qty) as qty from ictran where itemno = '#itemno#' and type = 'PR'  and (void = '' or void is null)
      	</cfquery>
      
	  	<cfif prprice.sumamt neq ''>
        	<cfset prpriceamt = prprice.sumamt>
      	<cfelse>
        	<cfset prpriceamt = 0>
      	</cfif>
      
	  	<cfif prprice.qty neq ''>
        	<cfset prpriceqty = prprice.qty>
      	<cfelse>
        	<cfset prpriceqty = 0>
      	</cfif>

      	<cfset up = getpriceamt - prpriceamt>
      	<cfset down = itembal + getpriceqty - prpriceqty>
      	
		<cfif down neq 0>
        	<cfset xprice = up / down>
        	<cfset xprice = numberformat(xprice,'.__')>
      	</cfif>
    <cfelse>
      	<cfquery datasource='#dts#' name='getprice'>
        	select price from icitem where itemno = '#itemno#' 
      	</cfquery>
      	
		<cfif getprice.price neq ''>
        	<cfset xprice = getprice.price>
        	<cfset xprice = numberformat(xprice,'.__')>
      	</cfif>
    </cfif>
		  
    <cfif netamt neq 0>
      	<cfquery name='GetCust' datasource='#dts#'>
	    	select name from customer where customerno = '#Custno#'
      	</cfquery>
      	
		<cfquery name='getCurrCode' datasource='#dts#'>
        	select currcode from customer where customerno ='#custno#' 
      	</cfquery>
			
      	<cfset xPrice_bil = xprice * currrate>
      	<cfset GrossProfit_bil = netamt_bil - xprice_bil>
      	<cfset GrossProfit = netamt - xprice>
      	<cfset Margin = (GrossProfit / netamt) * 100>
		<cfset maxArray = right(CurrArray[1][1],1)>
      	
		<cfloop index = 'i' from = '1' to = '#maxArray#'>
        	<cfif CurrArray[i+1][1] eq getcurrcode.currcode>
          		<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + netamt_bil>
          		<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + xprice_bil>
          		<cfset CurrArray[i+1][4] = CurrArray[i+1][4] + GrossProfit_bil>
        	</cfif>
        	<cfset i = i + 1>
      	</cfloop>

	  	<cfquery name='InsertRPMargin' datasource='#dts#'>
        	Insert into r_pmargin (CustNo, Name, ItemNo, Desp, Curr,Amt1_bil, Cost_bil, GProfit_bil,
			ExchRate,Amt1,Cost,GProfit,Margin)
	        
			values ('#getHeader.custno#', '#getcust.name#',  '#getHeader.itemno#',  '#getHeader.desp#',  '#getCurrCode.currcode#',  
			'#netamt_bil#',  '#xprice_bil#',  '#GrossProfit_bil#', '#currrate#',  
			'#netamt#',  '#xprice#',  '#GrossProfit#', '#Margin#')
      	</cfquery>
    </cfif>
</cfloop>

<cfswitch expression='#form.rgSort#'>
	<cfcase value='Item No'>
      	<cfquery name='MyQuery' datasource='#dts#'>
        	SELECT    ItemNo, Desp, Curr, Amt1_bil, Cost_bil, GProfit_bil, ExchRate, Amt1, Cost, GProfit, Margin
	    	FROM      r_pmargin
	    	ORDER BY  Itemno
      	</cfquery> 

      	<cfreport template='..\Reports\ProfitMargin_Prod.cfr' format='PDF' query='#MyQuery#'>
        	<CFREPORTPARAM NAME='SGDAmt' VALUE='#CurrArray[2][2]#'>
			<CFREPORTPARAM NAME='SGDCost' VALUE='#CurrArray[2][3]#'>
			<CFREPORTPARAM NAME='SGDGProfit' VALUE='#CurrArray[2][4]#'>
	  	</cfreport>
    </cfcase>
  
    <cfcase value='Customer'>
      	<cfquery name='MyQuery' datasource='#dts#'>
        	SELECT    CustNo, Name, ItemNo, Desp, Curr, Amt1_bil, Cost_bil, GProfit_bil, ExchRate, Amt1, Cost, GProfit, Margin
	    	FROM      r_pmargin
	    	ORDER BY  CustNo, Itemno
      	</cfquery> 

      	<cfreport template='..\Reports\ProfitMargin_Cust.cfr' format='PDF' query='#MyQuery#'>
			<CFREPORTPARAM NAME='SGDAmt' VALUE='#CurrArray[2][2]#'>
			<CFREPORTPARAM NAME='SGDCost' VALUE='#CurrArray[2][3]#'>
			<CFREPORTPARAM NAME='SGDGProfit' VALUE='#CurrArray[2][4]#'>

        	<cfset maxArray = right(CurrArray[1][1],1)>
			<cfset j = 2>
        	
			<cfloop index = 'i' from = '2' to = '#maxArray#'>
          		<cfif CurrArray[i+1][2] neq 0>
            		<CFREPORTPARAM NAME='Curr#j#' VALUE='#CurrArray[i+1][1]#'>
            		<CFREPORTPARAM NAME='Amt#j#' VALUE='#CurrArray[i+1][2]#'>
	        		<CFREPORTPARAM NAME='Cost#j#' VALUE='#CurrArray[i+1][3]#'>
		    		<CFREPORTPARAM NAME='GProfit#j#' VALUE='#CurrArray[i+1][4]#'>
            		<cfset j = j + 1>
          		</cfif>
          		<cfset i = i + 1>
				<!---<cfset k = #i#>--->
        	</cfloop>

        	<cfloop index = 'i' from = '#j#' to = '5'>
          		<CFREPORTPARAM NAME='Curr#i#' VALUE=''>
          		<CFREPORTPARAM NAME='Amt#i#' VALUE='0'>
          		<CFREPORTPARAM NAME='Cost#i#' VALUE='0'>
          		<CFREPORTPARAM NAME='GProfit#i#' VALUE='0'>
        	</cfloop>
			<!---<CFREPORTPARAM NAME='Curr2' VALUE=''>
            <CFREPORTPARAM NAME='Amt2' VALUE='0'>
            <CFREPORTPARAM NAME='Cost2' VALUE='0'>
            <CFREPORTPARAM NAME='GProfit2' VALUE='0'>
            <CFREPORTPARAM NAME='Curr3' VALUE=''>
            <CFREPORTPARAM NAME='Amt3' VALUE='0'>
            <CFREPORTPARAM NAME='Cost3' VALUE='0'>
            <CFREPORTPARAM NAME='GProfit3' VALUE='0'>
            <CFREPORTPARAM NAME='Curr4' VALUE=''>
            <CFREPORTPARAM NAME='Amt4' VALUE='0'>
            <CFREPORTPARAM NAME='Cost4' VALUE='0'>
            <CFREPORTPARAM NAME='GProfit4' VALUE='0'>
            <CFREPORTPARAM NAME='Curr5' VALUE=''>
            <CFREPORTPARAM NAME='Amt5' VALUE='0'>
            <CFREPORTPARAM NAME='Cost5' VALUE='0'>
            <CFREPORTPARAM NAME='GProfit5' VALUE='0'> --->
		</cfreport>
	<!---<cfreport report='http://192.168.1.7:8500/reports/NewColdFusionReport.cfr' --->
	<!---<cfreport report='/NewColdFusionReport.cfr'
 	  dataSource = 'Global_ECN'
	  username = 'password2'
	  password = 'password2'>
    </cfreport> --->
    </cfcase>
</cfswitch>