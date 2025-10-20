<cfif url.type eq "add">
	<cfset ndate = createdate(right(form.otdate,4),mid(form.otdate,4,2),left(form.otdate,2))>
	<cfset n2date = #dateformat(ndate,'yyyymmdd')#>
		
        <cfquery name="identify_date" datasource="#dts#">
        	select otdate, empno from ot_record where empno="#form.empno#" and otdate = "#n2date#" and project_desp = "#form.project_desp#"
        </cfquery>
        <cfif identify_date.recordcount eq 0>
            <cfquery name="select_emp_list" datasource="#dts#">
                select empno from paytran <cfif isdefined("form.allEMP") eq false>WHERE empno = "#form.empno#"</cfif>
            </cfquery>
            	<cfloop query="select_emp_list">
                
                    <cfquery name="add_data" datasource="#dts#">
                        INSERT INTO ot_record (
                            `empno` ,  `timeFr1` ,  `timeFr2` ,  `timeFr3` ,  `timeFr4` ,  `timeFr5` ,  `timeFr6` ,
                            `timeTo1` ,  `timeTo2` ,  `timeTo3` ,  `timeTo4` ,  `timeTo5` ,  `timeTo6` ,
                            `OT_Hour1` ,  `OT_Hour2` ,  `OT_Hour3` ,  `OT_Hour4` ,  `OT_Hour5` ,  `OT_Hour6` ,
                            `desp1` ,  `desp2` ,  `desp3` ,  `desp4` ,  `desp5` ,  `desp6` , 
                            project_desp, mc, NPL, otdate
                           )
                        VALUES(
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#select_emp_list.empno#">,
                    
                        <cfloop from="1" to="6" index="i">
                        "#evaluate('form.timeFr#i#')#",
                        </cfloop>
                    
                        <cfloop from="1" to="6" index="i">
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.timeTo#i#')#">,
                        </cfloop>
                    
                        <cfloop from="1" to="6" index="i">
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.OT_Hour#i#')#">,
                        </cfloop>
                    
                        <cfloop from="1" to="6" index="i">
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.desp#i#')#">,
                        </cfloop>
                    
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project_desp#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mc#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.NPL#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#n2date#">
                        <!--- ,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.DW#"> --->
                    )
                    
                </cfquery>
                
            </cfloop>
	<cfelse>
    		<cfwindow name="Error" title="Date is exist." modal="true" closable="false" width="250" height="160" center="true" initShow="true" >
                <cfoutput>
                    <p>Date is exist.</p>
                    <p>Please select other date or update the existing date.</p>
                    <form name="success" action="/payments/2ndHalf/AddUpdate/normalPayEditForm.cfm.cfm?empno=#URLEncodedFormat(form.empno)#">
                    <input type="submit" onClick="ColdFusion.Window.hide('error')" value="Ok">
                    </form>
                    <br />
                </cfoutput>
             </cfwindow>
	</cfif>
	<cfoutput>
		<cflocation url="/payments/2ndHalf/AddUpdate/normalPayEditForm.cfm?empno=#URLEncodedFormat(form.empno)#">
	</cfoutput>

<cfelseif url.type eq "update">

	<cfset ndate = createdate(right(form.otdate,4),mid(form.otdate,4,2),left(form.otdate,2))>
	<cfset n2date = #dateformat(ndate,'yyyymmdd')#>
	
	<cfif isdefined("form.allEMP")>
	
		<cfquery name="select_emp_list" datasource="#dts#">
		select empno from paytran
		</cfquery>
		
		<cfquery name="select_ot_table" datasource="#dts#">
			SELECT * FROM ot_record
		</cfquery>
		
		<cfloop query="select_emp_list">
		
			<cfquery name="update_data" datasource="#dts#">
				UPDATE ot_record 
				SET
				 <cfloop from="1" to="6" index="i">
				 timeFr#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.timeFr#i#')#">,
				 </cfloop>
				 
				 <cfloop from="1" to="6" index="i">
				 timeTo#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.timeTo#i#')#">,
				 </cfloop>
				 
				 <cfloop from="1" to="6" index="i">
				 OT_Hour#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.OT_Hour#i#')#">,
				 </cfloop>
			  	
				 <cfloop from="1" to="6" index="i">
				 desp#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.desp#i#')#">,
				 </cfloop>
				<!---  dw = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dw#">, --->
				 mc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mc#">
				 where project_desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project#"> and otdate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#n2date#"> 
			</cfquery>

		</cfloop>
	<cfelse>
		<cfquery name="update_data" datasource="#dts#">
				UPDATE ot_record 
				SET
				 empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">, 
				 <cfloop from="1" to="6" index="i">
				 timeFr#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.timeFr#i#')#">,
				 </cfloop>
				 
				 <cfloop from="1" to="6" index="i">
				 timeTo#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.timeTo#i#')#">,
				 </cfloop>
				 
				 <cfloop from="1" to="6" index="i">
				 OT_Hour#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.OT_Hour#i#')#">,
				 </cfloop>
			  	
				 <cfloop from="1" to="6" index="i">
				 desp#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.desp#i#')#">,
				 </cfloop>
				<!---  dw = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dw#">, --->
				 mc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mc#">,
				 npl = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.npl#">
				 WHERE entryno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.entryno#" >
			</cfquery>
			
	</cfif>
	<cflocation url="/payments/2ndHalf/AddUpdate/normalPayEditForm.cfm?empno=#URLEncodedFormat(form.empno)#">


<cfelseif url.type eq "del">

	<cfquery name="delete_date" datasource="#dts#">
		DELETE FROM ot_record WHERE entryno="#url.entryno#"
	</cfquery>
	<cflocation url="/payments/2ndHalf/AddUpdate/normalPayEditForm.cfm?empno=#url.empno#">
</cfif>


 