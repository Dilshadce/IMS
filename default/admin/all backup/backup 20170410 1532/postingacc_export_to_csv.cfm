<cfif export eq "Export">
	<cfquery datasource='#dts#' name="checkexist1">
		select 
		entry 
		from glpost9;
	</cfquery>
	
	<cfquery datasource='#dts#' name="checkexist2">
		select 
		entry 
		from glpost91;
	</cfquery>
	
	<cfif checkexist1.recordcount eq 0 and checkexist2.recordcount eq 0>
		<h1>No Posted Record!</h1>
		<cfabort>
	</cfif>
	
	<cffile action = "delete" file = "C:\\Inetpub\\wwwroot\\IMS\Download\\#dts#\\ver9.0\\glpost9.csv">
	<cffile action = "delete" file = "C:\\Inetpub\\wwwroot\\IMS\Download\\#dts#\\ver9.1\\glpost9.csv">
	
	<cfquery name="outfile" datasource="#dts#">		
		select * 
		into outfile 'C:\\Inetpub\\wwwroot\\IMS\\Download\\#dts#\\ver9.0\\glpost9.csv' 
		fields terminated by ',' 
		enclosed by '"' 
		lines terminated by '\r\n' 
		from glpost9;
	</cfquery>

	<cfquery name="outfile" datasource="#dts#">		
		select * 
		into outfile 'C:\\Inetpub\\wwwroot\\IMS\\Download\\#dts#\\ver9.1\\glpost9.csv' 
		fields terminated by ',' 
		enclosed by '"' 
		lines terminated by '\r\n' 
		from glpost91;
	</cfquery>
	
	<cfquery name="deletepreviouspost" datasource="#dts#">
		truncate glpost9
	</cfquery>
	
	<cfquery name="deletepreviouspost" datasource="#dts#">
		truncate glpost91
	</cfquery>
	<h1>You have exported the transaction successfully.</h1>	
</cfif>