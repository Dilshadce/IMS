<cfset frgrade=11>
<cfset tograde=310>
<cfset totalqty=0>
<cfloop from="1" to="#form.totalrecord#" index="i">
<cfloop from="#frgrade#" to="#tograde-1#" index="j">
<cfif val(form["adjqty_#i#_#j#"]) neq 0>
	<cfquery name="inserttempgrade" datasource="#dts#">
    insert into expressadjtrangrd (uuid,location,itemno,grade,bookqty,actualqty,adjqty)
	values ('#form.uuid#','#form["location_#i#"]#','#form["itemno_#i#"]#','#j#','#val(form["balance_#i#_#j#"])#','#val(form["qtyactual_#i#_#j#"])#','#val(form["adjqty_#i#_#j#"])#')
    
	</cfquery>
</cfif>
<cfset totalqty=totalqty+val(form["qtyactual_#i#_#j#"])>
</cfloop>
</cfloop>

	<script language="javascript" type="text/javascript">
	<cfoutput>
	window.opener.document.getElementById('qtyactual').value='#totalqty#';
	window.opener.document.getElementById('qtydiff').value=window.opener.document.getElementById('qtyonhand').value-window.opener.document.getElementById('qtyactual').value;
	window.opener.addnewitem2();
	</cfoutput>
		window.close();
	</script>