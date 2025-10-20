<cfquery name="getBodyInfo" datasource="#dts#">
    SELECT  a.refno,a.itemno,a.desp,a.despa,a.comment,
            a.unit_bil,a.qty_bil,a.price_bil,a.amt_bil,a.dispec1,a.dispec2,a.dispec3,a.disamt_bil,
            a.taxpec1,a.taxpec2,a.taxpec3,a.taxamt_bil,a.note_a,
            a.price,a.amt,a.unit,
            a.brem1,a.brem2,a.brem3,a.brem4,a.itemcount,
            a.qty1,a.qty2,a.qty3,a.qty4,a.qty5,a.qty6,a.qty7,
            a.title_desp,a.location,
            b.photo,a.type,a.trancode,a.nodisplay
            
            ,b.aitemno
            
    FROM ictran AS a
    LEFT JOIN icitem AS b ON a.itemno = b.itemno
    WHERE type = <cfif getheaderinfo.type eq "TR">
    			 	'TROU'
                 <cfelse>
                 	'#getHeaderInfo.type#'
                 </cfif>
    AND	refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getheaderinfo.refno#">
    ORDER BY trancode;
</cfquery>