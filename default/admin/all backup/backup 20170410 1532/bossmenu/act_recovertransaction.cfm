<cfparam name="status" default="">
<cfif form.checkbox neq "">
	
    
		<cfset refno = form.checkbox>
        <cfset reftype = form.type>
        <cfset frrefno = form.frrefno>
        <cfset frtype = form.frtype>
		
        
        <cfquery name="getqtyiclink" datasource="#dts#">
                select qty,frrefno,frtype from iclink where refno = <cfqueryparam cfsqltype="cf_sql_char" value="#refno#"> and type = <cfqueryparam cfsqltype="cf_sql_char" value="#reftype#"> and frrefno =<cfqueryparam cfsqltype="cf_sql_char" value="#frrefno#"> and frtype = <cfqueryparam cfsqltype="cf_sql_char" value="#frtype#">
        	</cfquery>
            
            <cfquery name="getqtyictran" datasource="#dts#">
                select shipped from ictran where refno = '#getqtyiclink.frrefno#' and type = '#getqtyiclink.frtype#'
        	</cfquery>
        
        <cfset shippedqty = val(getqtyictran.shipped) - val(getqtyiclink.qty)>
		<!--- Start to update artran ictran---->
         <cfif frtype eq 'SO' and reftype eq 'PO'>
         <cfquery name="update" datasource="#dts#">
				update artran
				set EXPORTED = '',order_cl = ""
				where refno = '#getqtyiclink.frrefno#' and type = '#getqtyiclink.frtype#'
			</cfquery>
        
            <cfquery name="update2" datasource="#dts#">
				update ictran
				set EXPORTED = ''
				where refno = '#getqtyiclink.frrefno#' and type = '#getqtyiclink.frtype#'
			</cfquery>
            <!--- ---->
            <cfelseif reftype eq 'INV' and frtype eq 'PO'>
         <cfquery name="update" datasource="#dts#">
				update artran
				set exported = '',order_cl = ""
				where refno = '#getqtyiclink.frrefno#' and type = '#getqtyiclink.frtype#'
			</cfquery>
        
            <cfquery name="update2" datasource="#dts#">
				update ictran
				set exported = ''
				where refno = '#getqtyiclink.frrefno#' and type = '#getqtyiclink.frtype#'
			</cfquery>
            <!--- ---->
            <cfelseif frtype eq 'DO'>
         
			<cfquery name="update" datasource="#dts#">
				update artran
				set toinv = "", generated = '',order_cl = ""
				where refno = '#getqtyiclink.frrefno#' and type = '#getqtyiclink.frtype#'
			</cfquery>
        
            <cfquery name="update2" datasource="#dts#">
				update ictran
				set shipped = '#shippedqty#',toinv='',generated = ''
				where refno = '#getqtyiclink.frrefno#' and type = '#getqtyiclink.frtype#'
			</cfquery>
            
            <!--- ---->
            <cfelseif (reftype eq "INV" or reftype eq "DO" or reftype eq "SO" or reftype eq "CS") and frtype eq "QUO">
            <cfquery name="update" datasource="#dts#">
				update artran
				set toinv = "", generated = '',order_cl = ""
				where refno = '#getqtyiclink.frrefno#' and type = '#getqtyiclink.frtype#'
			</cfquery>
        
            <cfquery name="update2" datasource="#dts#">
				update ictran
				set shipped = '#shippedqty#',toinv='',generated = ''
				where refno = '#getqtyiclink.frrefno#' and type = '#getqtyiclink.frtype#'
			</cfquery>
			<!--- ---->
            
            <cfelse>
         
			<cfquery name="update" datasource="#dts#">
				update artran
				set toinv = "", generated = '',order_cl = ""
				where refno = '#getqtyiclink.frrefno#' and type = '#getqtyiclink.frtype#'
			</cfquery>
        
            <cfquery name="update2" datasource="#dts#">
				update ictran
				set shipped = '#shippedqty#',toinv='',generated = ''
				where refno = '#getqtyiclink.frrefno#' and type = '#getqtyiclink.frtype#'
			</cfquery>
			
			</cfif>
                        <!---End of update artran & ictran---->
            <!--- 
            <cfelse>
            
            <cfquery name="update" datasource="#dts#">
				update artran
				set order_cl = "",generated = ''
				where refno = '#getqtyiclink.frrefno#' and type = '#getqtyiclink.frtype#'
			</cfquery>
        
            <cfquery name="update2" datasource="#dts#">
				update ictran
				set generated = ''
				where refno = '#getqtyiclink.frrefno#' and type = '#getqtyiclink.frtype#'
			</cfquery>
            </cfif>---->

            <cfquery name="update3" datasource="#dts#">
				update igrade
				set generated = ''
				where refno = '#getqtyiclink.frrefno#' and type = '#getqtyiclink.frtype#'
			</cfquery>
            
            <cfquery name="update4" datasource="#dts#">
				update iserial
				set generated = ''
				where refno = '#getqtyiclink.frrefno#' and type = '#getqtyiclink.frtype#'
			</cfquery>
            
            <cfquery name="update5" datasource="#dts#">
                delete from iclink where frrefno = '#getqtyiclink.frrefno#' and frtype = '#getqtyiclink.frtype#' and refno = <cfqueryparam cfsqltype="cf_sql_char" value="#refno#"> and type = <cfqueryparam cfsqltype="cf_sql_char" value="#reftype#">
        	</cfquery>

        <cfset status ="#reftype# No. #refno# has been recovered to #frtype# No. #frrefno# !">

<cfelse>
	<cfset status="Please Tick the checkbox!">
</cfif>
<cfoutput>
	<form name="done" action="recovertransaction.cfm?process=done" method="post">
		<input name="status" value="#status#" type="hidden">
        
	</form>
</cfoutput>


<script>
	done.submit();
</script>