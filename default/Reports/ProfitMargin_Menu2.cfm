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
	select compro, compro2, compro3, compro4, compro5, compro6, compro7, cost, lastaccyear from gsetup 
</cfquery>

<cfquery name='getHeader' datasource='#dts#'>
  	select b.custno, b.name, a.itemno, a.desp, c.currcode, sum(b.amt_bil) as amt_bil, (sum(b.it_cos)/ avg(b.currrate)) as cost_bil, 
	(sum(b.amt_bil) - (sum(b.it_cos)/ avg(b.currrate))) as gprofit_bil, avg(b.currrate) as currrate, sum(b.amt) as amt, sum(b.it_cos) as it_cos, 
	(sum(b.amt) - sum(b.it_cos)) as gprofit, (((sum(b.amt) - sum(b.it_cos)) / sum(b.amt))*100) as margin
	from icitem a, ictran b, customer c
  	where (b.type = 'INV' or b.type = 'CS' or b.type = 'DN') and a.itemno = b.itemno and c.customerno = b.custno
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
	  	group by b.custno,a.itemno order by b.custno
		</cfcase>
  	</cfswitch>
</cfquery>

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
	<cfset maxArray = right(CurrArray[1][1],1)>
	
	<cfloop index = 'i' from = '1' to = '#maxArray#'>
		<cfif CurrArray[i+1][1] eq getHeader.currcode>
			<cfset CurrArray[i+1][2] = CurrArray[i+1][2] + getHeader.amt_bil>
			<cfset CurrArray[i+1][3] = CurrArray[i+1][3] + getHeader.cost_bil>
			<cfset CurrArray[i+1][4] = CurrArray[i+1][4] + getHeader.gprofit_bil>
        </cfif>
      	<cfset i = i + 1>
    </cfloop>
	
	<cfquery name='InsertRPMargin' datasource='#dts#'>
		Insert into r_pmargin (CustNo, Name, ItemNo, Desp, Curr,Amt1_bil, Cost_bil, GProfit_bil,
		ExchRate,Amt1,Cost,GProfit,Margin)
	        
		values ('#getHeader.custno#', '#getHeader.name#',  '#getHeader.itemno#',  '#getHeader.desp#',  '#getHeader.currcode#',  
		'#getHeader.amt_bil#',  '#getHeader.cost_bil#',  '#getHeader.gprofit_bil#', '#getHeader.currrate#',  
		'#getHeader.amt#',  '#getHeader.it_cos#',  '#getHeader.gprofit#', '#getHeader.margin#')
	</cfquery>
</cfloop>

<cfswitch expression="#form.rgSort#">
	<cfcase value="Item No">
		<cfquery name='MyQuery' datasource='#dts#'>
   			select    ItemNo, Desp, Curr, Amt1_bil, Cost_bil, GProfit_bil, ExchRate, Amt1, Cost, GProfit, Margin
   			from      r_pmargin
			order by  Itemno
		</cfquery> 

		<cfreport template='..\Reports\ProfitMargin_Prod.cfr' format='PDF' query='#MyQuery#'></cfreport>
	</cfcase>
	
	<cfcase value="Customer">
		<cfquery name='MyQuery' datasource='#dts#'>
        	select    CustNo, Name, ItemNo, Desp, Curr, Amt1_bil, Cost_bil, GProfit_bil, ExchRate, Amt1, Cost, GProfit, Margin
	    	from      r_pmargin
	    	order by  CustNo, Itemno
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
        	</cfloop>
        	<cfloop index = 'i' from = '#j#' to = '5'>
          		<CFREPORTPARAM NAME='Curr#i#' VALUE=''>
          		<CFREPORTPARAM NAME='Amt#i#' VALUE='0'>
          		<CFREPORTPARAM NAME='Cost#i#' VALUE='0'>
          		<CFREPORTPARAM NAME='GProfit#i#' VALUE='0'>
        	</cfloop>
		</cfreport>
	</cfcase>
</cfswitch>
