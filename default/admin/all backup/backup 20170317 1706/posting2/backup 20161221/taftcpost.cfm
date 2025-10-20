<cfif type eq "RC" or type eq "CN"<!---  or type eq "PR" --->>
				<cfquery name="insertpost1" datasource="#dts#">
					insert into glposttemp
					(
						acc_code,
						accno,
						fperiod,
						date,
						reference,
						refno,
						desp,
						despa,
						creditamt,
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
                        <cfif lcase(hcomid) eq "taftc_i">
						,SOURCE,JOB
                        </cfif>
                        ,uuid
					)
					values 
					(
						'#type#',
						'#getcourse.grantacc#',
						'#ceiling(fperiod)#',
						#getartran.wos_date#,
						'#billno#',
						'#refno2#',
						<cfif getaccno.postvalue eq "pono" and type eq "RC">
							'#pono#',
						<cfelseif getaccno.postvalue eq "pono" and type eq "PR">
							'#pono#',
						<cfelseif getaccno.postvalue eq "pono" and type eq "CN">
							'#getartran.rem9#',
						<cfelseif getaccno.postvalue eq "desp">
							'#desp#',
						<cfelse>
							'#billtype#',
						</cfif>
					
						<cfif getaccno.postvalue eq "pono" and type eq "CN">
							'#pono#',
						<cfelse>
							'#getartran.despa#',
						</cfif> 	                   '#numberformat(val(getcourse.cdispec),".__")#', '#numberformat(val(getcourse.cdispec),".__") * -1#',
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                        <cfif lcase(hcomid) eq "taftc_i">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">
						</cfif>
                        ,'#uuid#'
					)
				</cfquery>
				
			<cfelse>
				<cfquery name="insertpost1" datasource="#dts#">
					insert into glposttemp
					(
						acc_code,
						accno,
						fperiod,
						date,
						reference,
						refno,
						desp,
						despa,
						debitamt,
						fcamt,
						exc_rate,
						rem4,
						rem5,
						bdate,
						userid,
                        agent
                        <cfif lcase(hcomid) eq "taftc_i">
						,SOURCE,JOB
                        </cfif>
                        ,uuid
					)
					values 
					(
						'#type#',
						'#getcourse.grantacc#',
						'#ceiling(fperiod)#',
						#getartran.wos_date#,
						'#billno#',
						'#refno2#',
						<cfif getaccno.postvalue eq "pono">
							'#getartran.rem9#',					
						<cfelseif getaccno.postvalue eq "desp">
							'#desp#',
						<cfelse>
							'#billtype#',
						</cfif>
						<cfif getaccno.postvalue eq "pono">
							'#pono#',
						<cfelse>
							'#getartran.despa#',
						</cfif>
						'#numberformat(val(getcourse.cdispec),".__")#',
						'#numberformat(val(getcourse.cdispec),".__")#',
						'#currrate#',
						'',
						'#getartran.rem6#',
						#getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                        <cfif lcase(hcomid) eq "taftc_i">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.source#">
                        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#getartran.job#">
						</cfif>
                        ,'#uuid#'
					)
				</cfquery>
				
			</cfif>