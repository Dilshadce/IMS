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
			posted='P' 
			where type='#getbill.type#' and refno='#getbill.refno#';
		</cfquery>  
	</cfloop>
	
	<h1>You have done the posting successfully.</h1>
</cfif>