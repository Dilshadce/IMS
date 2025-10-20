<cfset oriCode=form.oriCode>
<cfset oriPeriod=form.oriPeriod>

<cfquery datasource="#dts#" name="getcurr">
	SELECT * FROM #target_currencymonth# where currcode='#oriCode#' and fperiod='#oriPeriod#'
</cfquery>

<cfif getcurr.recordcount eq 0>
<!--- insert --->

		<cfquery datasource='#dts#' name="updateTable">
			INSERT INTO #target_currencymonth# set
			
			Currcode='#oriCode#',fperiod='#oriPeriod#'
			</cfquery> 
		<cfset status="The currency rates for #oriCode# had been successfully saved. ">
</cfif>
<!--- update --->
				
		<cfquery datasource='#dts#' name="updateTable">
			Update #target_currencymonth# SET 
			<cfloop index="mon" from="1" to="#dayofmonth#">
				<cfset myVal = "form.currD" & mon>
                <cfset xmyVal = "form.Rem" & mon>
                	currD#mon#='#val(evaluate(myVal))#'
                
                <cfif mon eq dayofmonth>
                <cfelse>
                ,
                </cfif>	
			</cfloop>
			where currcode='#oriCode#' and fperiod='#oriPeriod#'
		</cfquery>
		
		<cfset status="The currency rates for #oriCode# had been successfully saved. ">

<cfoutput>
<form name="done" action="createCurrency.cfm?type=Edit&currcode=#oriCode#" method="post">
		<input name="status" value="#status#" type="hidden">
	</form>
</cfoutput>

<script>done.submit();</script>