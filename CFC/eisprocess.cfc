<cfcomponent output="false">
	<cffunction name="caleis" access="public" returntype="any">
		<cfargument name="empno" required="yes">
		<cfargument name="db" required="yes">
		<cfargument name="payrate" required="yes">
		
		<cfquery name="get_now_month" datasource="payroll_main">
	        	SELECT * FROM gsetup WHERE comp_id = "#replace(db,'_p','')#"
	    </cfquery>
		
		<cfset eis_array = ArrayNew(1)>
		<cfquery name="emp_qry" datasource="#db#">
			SELECT eistbl,national,dbirth,nricn,socsocat FROM pmast where empno="#empno#"
		</cfquery>

		<cfset sys_date = Createdate(get_now_month.MYEAR,get_now_month.MMONTH,1)>
		<cfset sys_date = dateadd('d',-1,sys_date)>
		
		<cfif emp_qry.national eq "my" and emp_qry.socsocat neq "X">
			
			<!---Age 60/57(in 2018)/18 EIS--->
			<cfif dateDiff("yyyy",emp_qry.dbirth, sys_date) lt 18 or dateDiff("yyyy",emp_qry.dbirth, sys_date) gte 60 or year(emp_qry.dbirth) lte 1961>
				<cfquery name="update_emp_qry" datasource="#db#">
				UPDATE pmast
                SET eistbl="6"
                WHERE empno="#empno#"
				</cfquery>
				<cfset emp_qry.eistbl = 6>
				
				<cfquery name="emp_qry" datasource="#db#">
				SELECT eistbl,national,dbirth,nricn FROM pmast where empno="#empno#"
				</cfquery>
			<cfelse>
            	<cfquery name="update_emp_qry" datasource="#db#">
				UPDATE pmast
                SET eistbl="5"
                WHERE empno="#empno#"
				</cfquery>
				<cfset emp_qry.eistbl = 5>
			</cfif>	
			<!---End Age 60 EIS--->
		
			<cfset socsoyer_tbl = "socyer"&#emp_qry.eistbl#>
			<cfset socsoyee_tbl = "socyee"&#emp_qry.eistbl#>
			
			<cfquery name="socso_tbl_qry" datasource="#db#">
				SELECT #socsoyer_tbl#,#socsoyee_tbl# FROM rngtable 
				where socpayf <= #val(payrate)# and socpayt >=  #val(payrate)#
			</cfquery>
			
			 <cfset eis_yee = #socso_tbl_qry['#socsoyee_tbl#'][1]#>
		     <cfset eis_yer = #socso_tbl_qry['#socsoyer_tbl#'][1]#>
			
		<cfelse>
			 <cfset eis_yee = "0.00">
		     <cfset eis_yer = "0.00">
		</cfif>
		
		<cfset eis_array[1] = eis_yee >
		<cfset eis_array[2] = eis_yer>
		
	<cfreturn eis_array>
	</cffunction>
</cfcomponent>