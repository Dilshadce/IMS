<cfinclude template="../core/cfajax.cfm">

<cffunction name="customerlookup" hint="type='keyvalue' jsreturn='array'">
	
	<cfquery name="getCust" datasource="net_crm">
		SELECT custid,concat(custno,' - ',if((custname='' or custname is null),'',custname)) as ctext
		FROM customer order by custno
	</cfquery>

	<cfset model = ArrayNew(1)>
	<cfset ArrayAppend(model,"-,Please choose one")>
	
	<cfloop query="getCust">
		<cfset ArrayAppend(model,"#custid#,#ctext#")>
	</cfloop>
	
	<cfreturn model>
</cffunction>

<cffunction name="addContractService">
	<cfargument name="tran" required="yes" type="string"> 
	<cfargument name="refno" required="yes" type="string">
	<cfargument name="custno" required="yes" type="string">
	<cfargument name="service" required="yes" type="string">
	<cfargument name="qty" required="yes" type="string">
    <cfargument name="unit" required="yes" type="string">
	
	<cfset arguments.service = URLDecode(arguments.service)>
	
	<cftry>
		<cfquery name="checkexist" datasource="#dts#">
			select * from contract_service
			where type = '#arguments.tran#'
			and refno = '#arguments.refno#'
			and custno = '#arguments.custno#'
			and servi=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.service#">
		</cfquery>
		
		<cfif checkexist.recordcount eq 0>
			<cfquery name="insert" datasource="#dts#">
				insert into contract_service
				(type,refno,custno,servi,qty,unit)
				values
				(<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.tran#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.refno#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.custno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.service#">,'#val(arguments.qty)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.unit#">)
			</cfquery>
		</cfif>
		<cfset status="">
		<cfcatch type="database">
			<cflog file="ajax_crmf" text="Error msg (Insert): #cfcatch.message# (#HcomID#-#HUserID#)">
			<cfset status="Failed to Insert Contract - Service #arguments.service#.#chr(10)#Error message: #cfcatch.queryError##chr(10)#Please check with Administrator.">
		</cfcatch> 
	</cftry>
	
	<cfreturn status>
</cffunction>

<cffunction name="editContractService">
	<cfargument name="tran" required="yes" type="string"> 
	<cfargument name="refno" required="yes" type="string">
	<cfargument name="custno" required="yes" type="string">
	<cfargument name="service" required="yes" type="string">
	<cfargument name="qty" required="yes" type="string">
    <cfargument name="unit" required="yes" type="string">
	
	<cfset arguments.service = URLDecode(arguments.service)>
	
	<cftry>
		<cfquery name="edit" datasource="#dts#">
			update contract_service
			set qty='#val(arguments.qty)#',
            unit=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.unit#">
			where type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.tran#">
			and refno = '#arguments.refno#'
			and custno = '#arguments.custno#'
			and servi=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.service#">
		</cfquery>
		<cfset status="">
		<cfcatch type="database">
			<cflog file="ajax_crmf" text="Error msg (Update): #cfcatch.message# (#HcomID#-#HUserID#)">
			<cfset status="Failed to Update Contract - Service #arguments.service#.#chr(10)#Error message: #cfcatch.queryError##chr(10)#Please check with Administrator.">
		</cfcatch> 
	</cftry>
	
	<cfreturn status>
</cffunction>

<cffunction name="deleteContractService">
	<cfargument name="tran" required="yes" type="string"> 
	<cfargument name="refno" required="yes" type="string">
	<cfargument name="custno" required="yes" type="string">
	<cfargument name="service" required="yes" type="string">
	
	<cfset arguments.service = URLDecode(arguments.service)>
	
	<cftry>
		<cfquery name="delete" datasource="#dts#">
			delete from contract_service
			where type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.tran#">
			and refno = '#arguments.refno#'
			and custno = '#arguments.custno#'
			and servi=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.service#">
		</cfquery>
		<cfset status="">
		<cfcatch type="database">
			<cflog file="ajax_crmf" text="Error msg (Delete): #cfcatch.message# (#HcomID#-#HUserID#)">
			<cfset status="Failed to Delete Contract - Service #arguments.service#.#chr(10)#Error message: #cfcatch.queryError##chr(10)#Please check with Administrator.">
		</cfcatch> 
	</cftry>
	
	<cfreturn status>
</cffunction>

<cffunction name="updateContract">
	<cfargument name="invno" required="yes" type="string"> 
	<cfargument name="remark10" required="yes" type="string">
	<cfargument name="remark11" required="yes" type="string">
	<cfargument name="contract" required="yes" type="string">
	
	<cfset object = CreateObject("Component","cfobject")>
	<cfset arguments.invno = URLDecode(arguments.invno)>
	
	<cftry>
		<cfquery name="edit" datasource="#dts#">
			update artran
			set rem10='#arguments.remark10#',
			rem11='#arguments.remark11#',
			frem9='#arguments.contract#'
			where type='INV'
			and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.invno#">
		</cfquery>
		<cfset status="">
		<cfcatch type="database">
			<cflog file="ajax_crmf" text="Error msg (Update): #cfcatch.message# (#HcomID#-#HUserID#)">
			<cfset status="Failed to Update Invoice #arguments.invno#.#chr(10)#Error message: #cfcatch.queryError##chr(10)#Please check with Administrator.">
		</cfcatch> 
	</cftry>
	
	<cfset object.refno=invno>
	<cfset object.status=status>
	<cfreturn object>
</cffunction>