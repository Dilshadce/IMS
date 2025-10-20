<cfif post eq "post">
	<cfquery name="getbill" dbtype="query">
		select 
		distinct refno,
		type 
		from gettran 
		order by type,refno;
	</cfquery>
		
	<cfloop query="getbill">
		<cfquery name="updatetrxbill" datasource="#localdb#">
			update artran set 
			posted<cfif isdefined('url.ubs')>ubs</cfif>='P' 
			where type='#getbill.type#' and refno='#getbill.refno#';
		</cfquery>  
        
        <cfif left(hcomid,4) eq "beps">
        <cfquery name="updateassignment" datasource="#localdb#">
        	UPDATE assignmentslip SET posted = "P" WHERE refno = '#getbill.refno#';
            </cfquery>
		</cfif>
        
	</cfloop>
	
	<h1>You have done the posting successfully.</h1>
</cfif>