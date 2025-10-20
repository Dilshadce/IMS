<cfparam name="status" default="">

<cfloop index="a" from="1" to="#form.totalitem#">
<cfquery name="update_icitem" datasource="#dts#">
					update icitem set 
					ucost='#evaluate("form.ucost#a#")#',
                    price='#evaluate("form.price#a#")#',
                    price2='#evaluate("form.pricea#a#")#',
                    price3='#evaluate("form.priceb#a#")#',
                    price4='#evaluate("form.pricec#a#")#'
					where itemno='#jsstringformat(evaluate("form.itemno#a#"))#';
				</cfquery>	
		<cfset status="Update successful">
        </cfloop>

<!---Get the messaged to be passed into the view user page. (vUser.cfm) --->

<form name="done" action="icitem.cfm?process=done" method="post">
			<cfoutput><input name="status" value="#status#" type="hidden"></cfoutput>
            <script language="javascript" type="text/javascript">
	done.submit();
</script>
		</form>