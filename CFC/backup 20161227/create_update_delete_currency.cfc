<cfcomponent>
	<cffunction name="amend_currency">
		<cfargument name="dts" required="yes" type="any">
		<cfargument name="hlinkams" required="yes" type="any">
		<cfargument name="mode" required="yes" type="any">
		<cfargument name="form" required="yes" type="struct">
		
		<cfif hlinkams eq "Y">
			<cfset arguments.dts = replace(arguments.dts,"_i","_a","all")>
		</cfif>

		<cfswitch expression="#arguments.mode#">
			<cfcase value="create">
				<cfinvoke component="cfc.create_update_delete_currency" method="create_currency">
					<cfinvokeargument name="dts" value="#arguments.dts#">
					<cfinvokeargument name="form" value="#arguments.form#">
				</cfinvoke>
			</cfcase>
			<cfcase value="edit">
				<cfinvoke component="cfc.create_update_delete_currency" method="edit_currency">
					<cfinvokeargument name="dts" value="#arguments.dts#">
					<cfinvokeargument name="form" value="#arguments.form#">
				</cfinvoke>
			</cfcase>
            <cfcase value="delete">
				<cfinvoke component="cfc.create_update_delete_currency" method="delete_currency">
					<cfinvokeargument name="dts" value="#arguments.dts#">
					<cfinvokeargument name="form" value="#arguments.form#">
				</cfinvoke>
			</cfcase>
		</cfswitch>
	</cffunction>
	
	<cffunction name="create_currency">
		<cfargument name="dts" required="yes" type="any">
		<cfargument name="form" required="yes" type="struct">
		
		<cftry>
			<cfquery name="insert_currency" datasource="#arguments.dts#">
				insert into currency 
				(	currcode,
					currency,
					currency0,
					currency1,
					currency2,
					currrate,
					currP1,
					currP2,
					currP3,
					currP4,
					currP5,
					currP6,
					currP7,
					currP8,
					currP9,
					currP10,
					currP11,
					currP12,
					currP13,
					currP14,
					currP15,
					currP16,
					currP17,
					currP18
				) 
				values 
				(
					'#form.currcode#',
					'#form.currency#',
					'',
					'#form.currdollar#',
					'#form.currcent#',
					'#form.currrate#',
					'#form.currp01#',
					'#form.currp02#',
					'#form.currp03#',
					'#form.currp04#',
					'#form.currp05#',
					'#form.currp06#',
					'#form.currp07#',
					'#form.currp08#',
					'#form.currp09#',
					'#form.currp10#',
					'#form.currp11#',
					'#form.currp12#',
					'#form.currp13#',
					'#form.currp14#',
					'#form.currp15#',
					'#form.currp16#',
					'#form.currp17#',
					'#form.currp18#'
				);
			</cfquery>
			
			<cfcatch>
				<h2 align="center">Close Error - info below</h2>
				<cfdump var="#cfcatch#">
				<cfabort>
			</cfcatch>
		</cftry>
		<cfloop index="pd" from="1" to="18">
                        	<cfquery datasource="#arguments.dts#" name="updateTable2">
                            	INSERT INTO CurrencyrateMonth 
                                (Currcode,fperiod,
                                CurrD1,CurrD2,CurrD3,CurrD4,CurrD5,CurrD6,CurrD7,CurrD8,CurrD9,CurrD10,
                                CurrD11,CurrD12,CurrD13,CurrD14,CurrD15,CurrD16,CurrD17,CurrD18,CurrD19,CurrD20,
                                CurrD21,CurrD22,CurrD23,CurrD24,CurrD25,CurrD26,CurrD27,CurrD28,CurrD29,CurrD30,CurrD31)
                                VALUES
                               	(
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.currcode#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#pd#">,
                                <cfloop from="1" to="31" index="i">
                                	<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.currp#numberformat(pd,"00")#')#"><cfif i neq "31">,</cfif>
                                </cfloop>
                                )
                            </cfquery>
                        </cfloop>

	</cffunction>
	
	<cffunction name="edit_currency">
		<cfargument name="dts" required="yes" type="any">
		<cfargument name="form" required="yes" type="struct">
		
		<cftry>
			<cfquery name="update_currency" datasource="#arguments.dts#">
				update currency set 
				currcode='#form.currcode#',
				currency='#form.currency#',
				currency0='',
				currency1='#form.currdollar#',
				currency2='#form.currcent#',
				currrate='#form.currrate#',
				currP1='#form.currp01#',
				currP2='#form.currp02#',
				currP3='#form.currp03#',
				currP4='#form.currp04#',
				currP5='#form.currp05#',
				currP6='#form.currp06#',
				currP7='#form.currp07#',
				currP8='#form.currp08#',
				currP9='#form.currp09#',
				currP10='#form.currp10#',
				currP11='#form.currp11#',
				currP12='#form.currp12#',
				currP13='#form.currp13#',
				currP14='#form.currp14#',
				currP15='#form.currp15#',
				currP16='#form.currp16#',
				currP17='#form.currp17#',
				currP18='#form.currp18#'
				where currcode='#form.currcode#';
			</cfquery>
			
			<cfcatch>
				<h2 align="center">Close Error - info below</h2>
				<cfdump var="#cfcatch#">
				<cfabort>
			</cfcatch>
		</cftry>
	</cffunction>
    
    <cffunction name="delete_currency">
		<cfargument name="dts" required="yes" type="any">
		<cfargument name="form" required="yes" type="struct">
		
		<cftry>
			<cfquery name="update_currency" datasource="#arguments.dts#">
				delete from currency 
				where currcode='#form.currcode#';
			</cfquery>
			
			<cfcatch>
				<h2 align="center">Close Error - info below</h2>
				<cfdump var="#cfcatch#">
				<cfabort>
			</cfcatch>
		</cftry>
	</cffunction>
</cfcomponent>