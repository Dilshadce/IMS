<cfif url.type eq 'Create'>
    <cfquery name="insertreport" datasource="#dts#">
        insert into flexireport (userid, reportid, created_on, desp, created_by, queryname, reporttitle, fcustomer, fplacement, fassignment, finvoice, femployee, selcol, sortby, sort1, sort2, groupby,uuid)
        values(
            '#huserid#',
            '#form.reportTitle#',
            now(),
            '#form.desp#',
            '#huserid#',
            '',
            '#form.reportTitle#',
            <cfif isdefined('fCustomer')>               
            	'y',        
            <cfelse>
                '',
            </cfif>
            
            <cfif isdefined('fPlacement')>
            	'y',        
            <cfelse>
                '',
            </cfif> 
            
            <cfif isdefined('fAssignment')>
            	'y',        
            <cfelse>
                '',
            </cfif> 
            
            <cfif isdefined('fInvoice')>
            	'y',        
            <cfelse>
                '',
            </cfif>
            
            <cfif isdefined('fEmployee')>
            	'y',        
            <cfelse>
                '',
            </cfif> 
            
            '',
            
            <cfif isdefined('sortOrder')>
                '#form.sortOrder#',
            <cfelse>
                '',
            </cfif>
            
            '#form.sort1#',
            '#form.sort2#',
            '#form.groupBy#',
            '#form.hiduuid#'
        )
    </cfquery>
    
    <script type="text/javascript">
		alert('Report created successfully!');
		window.open('flexibleReport.cfm', '_self');
	</script>
<cfelseif url.type eq 'Edit'>
	<cfquery name="update" datasource="#dts#">
    	update flexireport
        set userid = '#huserid#', 
            reportid = "#form.reporttitle#", 
            updated_on = now(), 
            desp = "#form.desp#", 
            updated_by = "#huserid#", 
            queryname = "", 
            reporttitle = "#form.reporttitle#", 
            fcustomer = <cfif isdefined('fCustomer')>               
            				'y',        
                        <cfelse>
                            '',
                        </cfif>
            fplacement = <cfif isdefined('fPlacement')>               
            				'y',        
                        <cfelse>
                            '',
                        </cfif> 
            fassignment = <cfif isdefined('fAssignment')>               
            				'y',        
                        <cfelse>
                            '',
                        </cfif> 
            finvoice = <cfif isdefined('fInvoice')>               
            				'y',        
                        <cfelse>
                            '',
                        </cfif> 
            femployee = <cfif isdefined('fEmployee')>               
            				'y',        
                        <cfelse>
                            '',
                        </cfif> 
            selcol = "", 
            sortby = <cfif isdefined('sortOrder')>
                		'#form.sortOrder#',
                    <cfelse>
                        '',
                    </cfif> 
            sort1 = '#form.sort1#', 
            sort2 = '#form.sort2#',
            groupby = '#form.groupBy#',
            uuid = '#form.hiduuid#'
        where id = "#url.reportid#"
    </cfquery>
    
    <script type="text/javascript">
		alert('Report updated successfully!');
		window.open('flexibleReport.cfm', '_self');
	</script>
<cfelseif url.type eq 'Delete'>
	<cfquery name="delete" datasource="#dts#">
    	delete from flexireport where id = "#url.reportid#"
    </cfquery>
    
    <script type="text/javascript">
		alert('Report deleted successfully!');
		window.open('flexibleReport.cfm', '_self');
	</script>
</cfif>