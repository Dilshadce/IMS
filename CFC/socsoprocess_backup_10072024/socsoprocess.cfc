<cfcomponent output="false">
	<cffunction name="calsocso" access="public" returntype="any">
		<cfargument name="empno" required="yes">
		<cfargument name="db" required="yes">
		<cfargument name="payrate" required="yes">
		
		<cfquery name="get_now_month" datasource="payroll_main">
	        	SELECT * FROM gsetup WHERE comp_id = "#replace(db,'_p','')#"
	    </cfquery>
		
		<cfset socso_array = ArrayNew(1)>
		<cfquery name="emp_qry" datasource="#db#">
			SELECT socsono,socsotbl,national,dbirth,nricn,socsocat FROM pmast where empno="#empno#"
		</cfquery>

		<cfset sys_date = Createdate(get_now_month.MYEAR,get_now_month.MMONTH,1)>
		
		
		<!---<cfif (emp_qry.socsono neq "" or emp_qry.national eq "my") and emp_qry.socsotbl neq "" and emp_qry.dbirth neq '' and emp_qry.socsocat neq "X">--->
        <cfif emp_qry.socsotbl neq "" and emp_qry.dbirth neq '' and emp_qry.socsocat neq "X">
			
			<!---Age 60 Socso--->
			<!---Or Foreigner, Added by Nieo 20190218, government rules update--->
			<cfif (dateDiff("yyyy",emp_qry.dbirth, sys_date) gte 60) or emp_qry.national neq "my">
				<cfquery name="update_emp_qry" datasource="#db#">
				UPDATE pmast
                SET socsotbl="3"
                WHERE empno="#empno#"
				</cfquery>
				<cfset emp_qry.socsotbl = 3>
				
				<cfquery name="emp_qry" datasource="#db#">
				SELECT socsono,socsotbl,national,dbirth,nricn FROM pmast where empno="#empno#"
				</cfquery>
			<cfelse>
            	<cfquery name="update_emp_qry" datasource="#db#">
				UPDATE pmast
                SET socsotbl="1"
                WHERE empno="#empno#"
				</cfquery>
				<cfset emp_qry.socsotbl = 1>
			</cfif>	
			<!---End Age 60 Socso--->
		
			<cfset socsoyer_tbl = "socyer"&#emp_qry.socsotbl#>
			<cfset socsoyee_tbl = "socyee"&#emp_qry.socsotbl#>
			
			<cfquery name="socso_tbl_qry" datasource="#db#">
				SELECT #socsoyer_tbl#,#socsoyee_tbl# FROM rngtable 
				where socpayf <= #val(payrate)# and socpayt >=  #val(payrate)#
			</cfquery>
			
			 <cfset socso_yee = #socso_tbl_qry['#socsoyee_tbl#'][1]#>
		     <cfset socso_yer = #socso_tbl_qry['#socsoyer_tbl#'][1]#>
			
		<cfelse>
			 <cfset socso_yee = "0.00">
		     <cfset socso_yer = "0.00">
		</cfif>
		
		<cfset socso_array[1] = socso_yee >
		<cfset socso_array[2] = socso_yer>
		
	<cfreturn socso_array>
	</cffunction>
</cfcomponent>