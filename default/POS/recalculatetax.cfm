
<!--- <cfquery name="updategroup" datasource="#dts#">
       update artran set taxp1 = 7, taxincl = "T" where type = "CS" and fperiod = 11 and left(refno,4) = "POSC" ORDER BY refno
</cfquery> --->

<cfquery name="getgroup" datasource="#dts#">
       select * from artran where type = "CS" and fperiod = "09" and left(refno,4) = "POSC" ORDER BY refno
</cfquery>

<cfloop query="getgroup">
<cfoutput>

<cfif getgroup.grand_bil neq 0>
<cfif getgroup.taxincl eq "T">
    <cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictran 
        set note_a='SR',
        TAXPEC1='#getgroup.taxp1#',
        TAXAMT_BIL=round((AMT_BIL/#val(getgroup.net_bil)#)*#val(getgroup.tax1_bil)#,5),
        TAXAMT=round((AMT/#val(getgroup.net)#)*#val(getgroup.tax)#,5)
        where type='#getgroup.type#' and refno='#getgroup.refno#';
    </cfquery>
    <cfelse>
	<cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictran 
        set note_a='SR',
        TAXPEC1='#getgroup.taxp1#',
        TAXAMT_BIL=round((AMT_BIL/#val(getgroup.gross_bil)#)*#val(getgroup.tax1_bil)#,5),
        TAXAMT=round((AMT/#val(getgroup.invgross)#)*#val(getgroup.tax)#,5)
        where type='#getgroup.type#' and refno='#getgroup.refno#';
    </cfquery>
</cfif>
</cfif>
</cfoutput>
</cfloop>

<cfform name="form1" id="form1" action="/default/POS/listpos.cfm" method="post">
    </cfform>
    
   <script type="text/javascript">
   	alert('Recalculate Process Done.');
    form1.submit();
    </script>