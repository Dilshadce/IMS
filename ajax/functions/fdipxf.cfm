<cfinclude template="../core/cfajax.cfm">

<cffunction name="addNewJoborderProcess">
	<cfargument name="joborderno" required="yes" type="string"> 
	<cfargument name="supp" required="yes" type="string">
	<cfargument name="actualprintrun" required="yes" type="string">
	<cfargument name="worksheet" required="yes" type="string">
	<cfargument name="vendorcost" required="yes" type="string">
	<cfargument name="worksheetb" required="yes" type="string">
	<cfargument name="estimatedcost" required="yes" type="string">
	<cfargument name="remark" required="yes" type="string">
	<cfargument name="process_code" required="yes" type="string">
	
	<cfset arguments.actualprintrun = URLDecode(arguments.actualprintrun)>
	<cfset arguments.worksheet = URLDecode(arguments.worksheet)>
	<cfset arguments.worksheetb = URLDecode(arguments.worksheetb)>
	<cfset arguments.remark = URLDecode(arguments.remark)>
	
	<cfset object = CreateObject("Component","cfobject")>
	
	<cftry>
		<cfquery name="getmaxstep" datasource="#dts#">
			select max(step_no) as maxstep from joborder_body
			where joborder_no='#arguments.joborderno#'
		</cfquery>
		<cfset maxstep=val(getmaxstep.maxstep)+1>
		<cfquery name="insert" datasource="#dts#">
			insert into joborder_body
			(joborder_no,actual_print_run,step_no,supplier,type,process_code,work_sheet,vendor_cost,work_sheetb,estimated_cost,remark)
			values
			('#arguments.joborderno#','#arguments.actualprintrun#',#maxstep#,'#arguments.supp#','process','#arguments.process_code#',
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.worksheet#">,'#arguments.vendorcost#',
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.worksheetb#">,'#arguments.estimatedcost#',
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.remark#">)
		</cfquery>
		<cfset object.status="">
	<cfcatch type="database">
		<cflog file="ajax_fdipxf" text="Error msg (insert joborder process) : #cfcatch.Detail# (#HcomID#-#HUserID#)">
		<cfset object.status="Failed to insert Joborder Process #arguments.process_code#.#chr(10)#Error message: #cfcatch.queryError##chr(10)#Please check with Administrator.">
	</cfcatch>
	</cftry>
	
	<cfquery name="getsum" datasource="#dts#">
		SELECT sum(vendor_cost) as sumvendcost,sum(estimated_cost) as sumestimatcost 
		FROM joborder_body
		where joborder_no='#arguments.joborderno#'
	</cfquery>
	<cfquery name="update" datasource="#dts#">
		UPDATE joborder
		set sum_vendor_cost='#getsum.sumvendcost#',
		sum_estimated_cost='#getsum.sumestimatcost#'
		where joborder_no='#arguments.joborderno#'
	</cfquery>
	
	<cfset object.sumvendorcost=val(getsum.sumvendcost)>
	<cfset object.sumestimatedcost=val(getsum.sumestimatcost)>
	
	<cfset object.type="process">
	<cfreturn object>
</cffunction>

<cffunction name="addNewJoborderPaper">
	<cfargument name="joborderno" required="yes" type="string"> 
	<cfargument name="supp" required="yes" type="string">
	<cfargument name="actualprintrun" required="yes" type="string">
	<cfargument name="worksheet" required="yes" type="string">
	<cfargument name="vendorcost" required="yes" type="string">
	<cfargument name="worksheetb" required="yes" type="string">
	<cfargument name="estimatedcost" required="yes" type="string">
	<cfargument name="remark" required="yes" type="string">
	<cfargument name="paper" required="yes" type="string">
	<cfargument name="paper_status" required="yes" type="string">
	<cfargument name="size" required="yes" type="string">
	<cfargument name="open_size" required="yes" type="string">
	<cfargument name="qty" required="yes" type="string">
	<cfargument name="signature" required="yes" type="string">
	<cfargument name="paper_color" required="yes" type="string">
	<cfargument name="paper_price" required="yes" type="string">
	
	<cfset arguments.actualprintrun = URLDecode(arguments.actualprintrun)>
	<cfset arguments.worksheet = URLDecode(arguments.worksheet)>
	<cfset arguments.worksheetb = URLDecode(arguments.worksheetb)>
	<cfset arguments.remark = URLDecode(arguments.remark)>
	<cfset arguments.paper = URLDecode(arguments.paper)>
	<cfset arguments.size = URLDecode(arguments.size)>
	<cfset arguments.open_size = URLDecode(arguments.open_size)>
	<cfset arguments.qty = URLDecode(arguments.qty)>
	<cfset arguments.signature = URLDecode(arguments.signature)>
	<cfset arguments.paper_color = URLDecode(arguments.paper_color)>
	<cfset arguments.paper_price = URLDecode(arguments.paper_price)>
	
	<cfset object = CreateObject("Component","cfobject")>
	
	<cftry>
		<cfquery name="getmaxstep" datasource="#dts#">
			select max(step_no) as maxstep from joborder_body
			where joborder_no='#arguments.joborderno#'
		</cfquery>
		<cfset maxstep=val(getmaxstep.maxstep)+1>
		<cfquery name="insert" datasource="#dts#">
			insert into joborder_body
			(joborder_no,actual_print_run,step_no,supplier,type,paper,size,open_size,qty,paper_status,signature,paper_color,paper_price,
			work_sheet,vendor_cost,work_sheetb,estimated_cost,remark)
			values
			('#arguments.joborderno#','#arguments.actualprintrun#',#maxstep#,'#arguments.supp#','paper',
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.paper#">,
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.size#">,
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.open_size#">,
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.qty#">,
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.paper_status#">,
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.signature#">,
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.paper_color#">,
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.paper_price#">,
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.worksheet#">,'#arguments.vendorcost#',
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.worksheetb#">,'#arguments.estimatedcost#',
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.remark#">)
		</cfquery>
		<cfset object.status="">
	<cfcatch type="database">
		<cflog file="ajax_fdipxf" text="Error msg (insert joborder paper) : #cfcatch.Detail# (#HcomID#-#HUserID#)">
		<cfset object.status="Failed to insert Joborder Paper #arguments.paper#.#chr(10)#Error message: #cfcatch.queryError##chr(10)#Please check with Administrator.">
	</cfcatch>
	</cftry>
	
	<cfquery name="getsum" datasource="#dts#">
		SELECT sum(vendor_cost) as sumvendcost,sum(estimated_cost) as sumestimatcost 
		FROM joborder_body
		where joborder_no='#arguments.joborderno#'
	</cfquery>
	<cfquery name="update" datasource="#dts#">
		UPDATE joborder
		set sum_vendor_cost='#getsum.sumvendcost#',
		sum_estimated_cost='#getsum.sumestimatcost#'
		where joborder_no='#arguments.joborderno#'
	</cfquery>
	
	<cfset object.sumvendorcost=val(getsum.sumvendcost)>
	<cfset object.sumestimatedcost=val(getsum.sumestimatcost)>
	<cfset object.type="paper">
	<cfreturn object>
</cffunction>

<cffunction name="deleteJoborderP">
	<cfargument name="joborderno" required="yes" type="string"> 
	<cfargument name="stepno" required="yes" type="string">
	
	<cfset object = CreateObject("Component","cfobject")>
	
	<cftry>
		<cfquery name="deleteJobOrderP" datasource="#dts#">
			delete from joborder_body 
			where joborder_no='#arguments.joborderno#' and step_no='#arguments.stepno#'
		</cfquery>
		<cfset object.status="">
		
		<cfcatch type="database">
			<cflog file="ajax_fdipxf" text="Error msg (delete): #cfcatch.message# (#HcomID#-#HUserID#)">
			<cfset object.status="Failed to delete Job Order with Step #arguments.stepno#.#chr(10)#Error message: #cfcatch.queryError##chr(10)#Please check with Administrator.">
		</cfcatch>
	</cftry>
	
	<cfquery name="getsum" datasource="#dts#">
		SELECT sum(vendor_cost) as sumvendcost,sum(estimated_cost) as sumestimatcost 
		FROM joborder_body
		where joborder_no='#arguments.joborderno#'
	</cfquery>
	<cfquery name="update" datasource="#dts#">
		UPDATE joborder
		set sum_vendor_cost='#getsum.sumvendcost#',
		sum_estimated_cost='#getsum.sumestimatcost#'
		where joborder_no='#arguments.joborderno#'
	</cfquery>
	
	<cfset object.sumvendorcost=val(getsum.sumvendcost)>
	<cfset object.sumestimatedcost=val(getsum.sumestimatcost)>
	
	<cfreturn object>
</cffunction>

<cffunction name="EditJoborderProcess">
	<cfargument name="joborderno" required="yes" type="string"> 
	<cfargument name="stepno" required="yes" type="string">
	<cfargument name="supp" required="yes" type="string">
	<cfargument name="actualprintrun" required="yes" type="string">
	<cfargument name="worksheet" required="yes" type="string">
	<cfargument name="vendorcost" required="yes" type="string">
	<cfargument name="worksheetb" required="yes" type="string">
	<cfargument name="estimatedcost" required="yes" type="string">
	<cfargument name="remark" required="yes" type="string">
	<cfargument name="process_code" required="yes" type="string">
	
	<cfset arguments.actualprintrun = URLDecode(arguments.actualprintrun)>
	<cfset arguments.worksheet = URLDecode(arguments.worksheet)>
	<cfset arguments.worksheetb = URLDecode(arguments.worksheetb)>
	<cfset arguments.remark = URLDecode(arguments.remark)>
	
	<cfset object = CreateObject("Component","cfobject")>
	
	<cftry>
		<cfquery name="update" datasource="#dts#">
			update joborder_body
			set supplier='#arguments.supp#',
			actual_print_run='#arguments.actualprintrun#',
			type='process',
			process_code='#arguments.process_code#',
			paper='',
			size='',
			open_size='',
			qty='',
			paper_status='',
			signature='',
			paper_color='',
			paper_price='',
			work_sheet=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.worksheet#">,
			vendor_cost='#arguments.vendorcost#',
			work_sheetb=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.worksheetb#">,
			estimated_cost='#arguments.estimatedcost#',
			remark=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.remark#">
			where joborder_no='#arguments.joborderno#'
			and step_no='#arguments.stepno#'
		</cfquery>
		<cfset object.status="">
	<cfcatch type="database">
		<cflog file="ajax_fdipxf" text="Error msg (update joborder process) : #cfcatch.Detail# (#HcomID#-#HUserID#)">
		<cfset object.status="Failed to update Joborder Process #arguments.process_code#.#chr(10)#Error message: #cfcatch.queryError##chr(10)#Please check with Administrator.">
	</cfcatch>
	</cftry>
	
	<cfquery name="getsum" datasource="#dts#">
		SELECT sum(vendor_cost) as sumvendcost,sum(estimated_cost) as sumestimatcost 
		FROM joborder_body
		where joborder_no='#arguments.joborderno#'
	</cfquery>
	<cfquery name="update" datasource="#dts#">
		UPDATE joborder
		set sum_vendor_cost='#getsum.sumvendcost#',
		sum_estimated_cost='#getsum.sumestimatcost#'
		where joborder_no='#arguments.joborderno#'
	</cfquery>
	
	<cfset object.sumvendorcost=val(getsum.sumvendcost)>
	<cfset object.sumestimatedcost=val(getsum.sumestimatcost)>
	
	<cfset object.type="process">
	<cfreturn object>
</cffunction>

<cffunction name="EditJoborderPaper">
	<cfargument name="joborderno" required="yes" type="string"> 
	<cfargument name="stepno" required="yes" type="string">
	<cfargument name="supp" required="yes" type="string">
	<cfargument name="actualprintrun" required="yes" type="string">
	<cfargument name="worksheet" required="yes" type="string">
	<cfargument name="vendorcost" required="yes" type="string">
	<cfargument name="worksheetb" required="yes" type="string">
	<cfargument name="estimatedcost" required="yes" type="string">
	<cfargument name="remark" required="yes" type="string">
	<cfargument name="paper" required="yes" type="string">
	<cfargument name="paper_status" required="yes" type="string">
	<cfargument name="size" required="yes" type="string">
	<cfargument name="open_size" required="yes" type="string">
	<cfargument name="qty" required="yes" type="string">
	<cfargument name="signature" required="yes" type="string">
	<cfargument name="paper_color" required="yes" type="string">
	<cfargument name="paper_price" required="yes" type="string">
	
	<cfset arguments.actualprintrun = URLDecode(arguments.actualprintrun)>
	<cfset arguments.worksheet = URLDecode(arguments.worksheet)>
	<cfset arguments.worksheetb = URLDecode(arguments.worksheetb)>
	<cfset arguments.remark = URLDecode(arguments.remark)>
	<cfset arguments.paper = URLDecode(arguments.paper)>
	<cfset arguments.size = URLDecode(arguments.size)>
	<cfset arguments.open_size = URLDecode(arguments.open_size)>
	<cfset arguments.qty = URLDecode(arguments.qty)>
	<cfset arguments.signature = URLDecode(arguments.signature)>
	<cfset arguments.paper_color = URLDecode(arguments.paper_color)>
	<cfset arguments.paper_price = URLDecode(arguments.paper_price)>
	
	<cfset object = CreateObject("Component","cfobject")>
	
	<cftry>
		<cfquery name="update" datasource="#dts#">
			update joborder_body
			set supplier='#arguments.supp#',
			actual_print_run='#arguments.actualprintrun#',
			type='paper',
			process_code='',
			paper=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.paper#">,
			size=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.size#">,
			open_size=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.open_size#">,
			qty=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.qty#">,
			paper_status=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.paper_status#">,
			signature=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.signature#">,
			paper_color=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.paper_color#">,
			paper_price=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.paper_price#">,
			work_sheet=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.worksheet#">,
			vendor_cost='#arguments.vendorcost#',
			work_sheetb=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.worksheetb#">,
			estimated_cost='#arguments.estimatedcost#',
			remark=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.remark#">
			where joborder_no='#arguments.joborderno#'
			and step_no='#arguments.stepno#'
		</cfquery>
		<cfset object.status="">
	<cfcatch type="database">
		<cflog file="ajax_fdipxf" text="Error msg (insert joborder paper) : #cfcatch.Detail# (#HcomID#-#HUserID#)">
		<cfset object.status="Failed to update Joborder Paper #arguments.paper#.#chr(10)#Error message: #cfcatch.queryError##chr(10)#Please check with Administrator.">
	</cfcatch>
	</cftry>
	
	<cfquery name="getsum" datasource="#dts#">
		SELECT sum(vendor_cost) as sumvendcost,sum(estimated_cost) as sumestimatcost 
		FROM joborder_body
		where joborder_no='#arguments.joborderno#'
	</cfquery>
	<cfquery name="update" datasource="#dts#">
		UPDATE joborder
		set sum_vendor_cost='#getsum.sumvendcost#',
		sum_estimated_cost='#getsum.sumestimatcost#'
		where joborder_no='#arguments.joborderno#'
	</cfquery>
	
	<cfset object.sumvendorcost=val(getsum.sumvendcost)>
	<cfset object.sumestimatedcost=val(getsum.sumestimatcost)>
	<cfset object.type="paper">
	<cfreturn object>
</cffunction>

<cffunction name="checkJobOrderExist">
	<cfargument name="nextjoborderno" required="yes" type="string"> 
	
	<cfquery name="checkExist" datasource="#dts#">
		SELECT * FROM joborder
		where joborder_no='#arguments.nextjoborderno#'
	</cfquery>
	
	<cfif checkExist.recordcount neq 0>
    	<cfset status="This Job Order No Already Exist!">
	<cfelse>
    	<cfset status="">
	</cfif>
	
	<cfreturn status>
</cffunction>

<cffunction name="copyJobOrder">
	<cfargument name="joborderno" required="yes" type="string"> 
    <cfargument name="status" required="yes" type="string"> 
    <cfargument name="nextjoborderno" required="yes" type="string"> 
    
    <cfset created_on=CreateDate(year(now()),month(now()),day(now()))>
    
    <cftry>
    	<cfquery name="update" datasource="#dts#">
            update gsetup
            set joborderno='#arguments.nextjoborderno#'
        </cfquery>
            
    	<cfquery name="insert" datasource="#dts#">
            insert into joborder 
            SELECT '#arguments.nextjoborderno#',#created_on#,a.order_by,a.issue_by,a.date_requirement,a.salesman,a.custno,'#arguments.status#',
            a.itemno,a.ordered_quantity,a.unit,a.ordered_size,a.ordered_color,a.folded_size,a.number,a.number_in_color,a.remark,a.estimated_cost,
            a.total_cost,a.margin,a.unit_price,a.quoted_price,a.decided_estimated_cost,a.sum_estimated_cost,a.sum_vendor_cost,now(),'#HUserID#','#HUserID#'
            FROM joborder a
            where joborder_no='#arguments.joborderno#'
        </cfquery>
        <cfquery name="insert" datasource="#dts#">
            insert into joborder_body 
            SELECT '#arguments.nextjoborderno#',a.actual_print_run,a.step_no,a.supplier,a.type,a.paper,a.size,a.open_size,a.qty,a.paper_status,
            a.signature,a.paper_color,a.paper_price,a.process_code,a.work_sheet,a.vendor_cost,a.work_sheetb,a.estimated_cost,a.remark
            FROM joborder_body a
            where joborder_no='#arguments.joborderno#'
        </cfquery>
        <cfset status="">
    <cfcatch type="database">
		<cflog file="ajax_fdipxf" text="Error msg (copy joborder) : #cfcatch.Detail# (#HcomID#-#HUserID#)">
		<cfset status="Failed to copy Joborder #arguments.paper#.#chr(10)#Error message: #cfcatch.queryError##chr(10)#Please check with Administrator.">
	</cfcatch>
    </cftry>
    
    <cfset status="">
    <cfreturn status>
</cffunction>