<cfset ndate = createdate(right(form.enddate,4),mid(form.enddate,4,2),left(form.enddate,2))>
<cfoutput>
<cfquery name="insertvoucher" datasource="#dts#">
insert into icitemhistran (itemno,price,enddate,created_by,created_on)
values
('#itemno#','#val(price)#','#dateformat(ndate,'YYYY-MM-DD')#','#HUserID#',now())
</cfquery>
</cfoutput>
<cfoutput>
<cfform action="createhistoryprice.cfm" method="post" name="recreate">
<input type="submit" value="Create another History Price" />&nbsp;&nbsp;&nbsp;<input type="button" value="close"  onclick="closenref();">
</cfform>
</cfoutput>
