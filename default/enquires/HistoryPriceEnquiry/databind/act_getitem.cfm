<cfsetting showdebugoutput="false"><cfsilent>
<cfset value = "">
<cfset tabchr = Chr(13) & Chr(10)> 

<cfif text neq "">
	<cfquery name="getitem" datasource="#dts#">
		select itemno, desp 
		from icitem 
		where (nonstkitem<>'T' or nonstkitem is null) 
				and upper(itemno) like '#ucase(text)#%'
		order by itemno
	</cfquery>
	<cfif getitem.recordcount neq 0>
		<cfset itemnolist = valuelist(getitem.itemno,";;")>
		<cfset itemdesclist = valuelist(getitem.desp,";;")>
	<cfelse>
		<cfset itemnolist = "-1">
		<cfset itemdesclist = "No Record Found">
	</cfif>
<cfelse>
	<cfset itemnolist = "-1">
	<cfset itemdesclist = "Please Filter The Item">
</cfif>

<cfset header = "count|error|msg|itemnolist|itemdesclist">
<cfset value = "1|0|0|#URLEncodedFormat(itemnolist)#|#URLEncodedFormat(itemdesclist)##tabchr#">	
</cfsilent><cfoutput>#header##tabchr##value#</cfoutput>