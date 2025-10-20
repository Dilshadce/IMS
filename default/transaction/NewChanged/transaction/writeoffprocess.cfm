<cfset mylist= listchangedelims(form.idlist,"",",")>
<cfset cnt=listlen(mylist,";")>

<cfset refnolist = "">
<cfloop from="1" to="#cnt#" index="i" step="+3">
	<cfset xrefno = listgetat(mylist,i,";")>
					
	<cfif trim(listgetat(mylist,i+1,";")) eq 'YHFTOKCF'>
		<!--- Just assign a value, because ColdFusion ignores empty list elements and value assigned in updateA.cfm--->
		<cfset xitemno = ''>
	<cfelse>
		<cfset xitemno = listgetat(mylist,i+1,";")>
	</cfif>
					
	<cfset xtrancode = listgetat(mylist,i+2,";")>
	
	<cfif form["writeoff_#xrefno#_#xtrancode#"] eq "">
		<cfset form["writeoff_#xrefno#_#xtrancode#"] = 0>
	</cfif>
	
	<cfquery name="update" datasource="#dts#">
		update ictran
		set writeoff = #form["writeoff_#xrefno#_#xtrancode#"]#
		where refno = '#xrefno#' 
		and itemno = '#xitemno#' 
		and trancode = '#xtrancode#' 
		and type = '#url.type#' 
	</cfquery>
	<cfif ListContainsNoCase(refnolist, xrefno) eq 0>
		<cfif refnolist eq "">
			<cfset refnolist = xrefno>
		<cfelse>
			<cfset refnolist = refnolist&','&xrefno>
		</cfif>
	</cfif>
</cfloop>


	<cfquery name="getictran" datasource="#dts#">
        select * from(select refno,sum(qty) as qty,sum(shipped) as shipped,sum(writeoff) as writeoff from ictran where type = '#url.type#' group by refno,type)as a where writeoff+shipped < qty
	</cfquery>

	<cfif getictran.recordcount neq 0>
    <cfloop query="getictran">
		<cfquery name="updateartan" datasource="#dts#">
			update artran set toinv = '', order_cl = '', generated = '' where refno = '#getictran.refno#' and type = '#url.type#'
		</cfquery>
    </cfloop>
	</cfif>	
    
    
    <cfquery name="getictran2" datasource="#dts#">
        select * from(select refno,sum(qty) as qty,sum(shipped) as shipped,sum(writeoff) as writeoff from ictran where type = '#url.type#' group by refno,type)as a where writeoff+shipped = qty
	</cfquery>

	<cfif getictran2.recordcount neq 0>
    <cfloop query="getictran2">
		<cfquery name="updateartan" datasource="#dts#">
			update artran set toinv = '#getictran2.refno#', order_cl = 'Y', generated = 'Y' where refno = '#getictran2.refno#' and type = '#url.type#'
		</cfquery>
    </cfloop>
	</cfif>	


<cfoutput>
	<form name="done" action="writeoff.cfm?tran=#url.type#" method="post">
	</form>
</cfoutput>

<script>
	done.submit();
</script>