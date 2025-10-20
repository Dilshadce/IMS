<cfquery name="gettax" datasource="#dts#">
select tax,refno,type,net,net_bil,tax_bil,taxp1,note from artran WHERE tax <> 0
</cfquery>

<cfloop query="gettax">
<cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictran 
        set note_a='#gettax.note#',
        TAXPEC1='#gettax.taxp1#',
        TAXAMT_BIL=round((AMT_BIL/#(gettax.net_bil)#)*#val(gettax.tax_bil)#,3),
        TAXAMT=round((AMT/#val(gettax.net)#)*#val(gettax.tax)#,3)
        where type='#gettax.type#' and refno='#gettax.refno#';
    </cfquery>
</cfloop>