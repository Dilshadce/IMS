
        <cfquery name="getSum_ictran" datasource="#dts#">
        	SELECT refno,type,sum(amt_bil) AS sumAmt,sum(taxamt_bil) as sumtax
            FROM ictran 
            WHERE type = '#tran#' 
            AND <cfif IsDefined('url.nexttranno')> 
            		refno='#url.nexttranno#' 
                <cfelse> 
                	refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">)
                </cfif> 
            GROUP BY refno;
        </cfquery>

        <cfquery name="updateSum_artran" datasource="#dts#">
        	UPDATE artran 
            SET 
            	gross_bil = "#val(getSum_ictran.sumAmt)#",
                tax_bil = "#val(getSum_ictran.sumtax)#" 
            WHERE type = '#tran#' 
            AND refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getSum_ictran.refno#">;
        </cfquery>


        <cfquery name="updateGrand_artran" datasource="#dts#">
        	UPDATE artran 
            SET 
            	net_bil = gross_bil - disc_bil 
            WHERE type = '#tran#' 
            AND <cfif IsDefined('url.nexttranno')> 
            		refno='#url.nexttranno#'; 
                <cfelse> 
                	refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">);
                </cfif>
        </cfquery>

        <cfquery name="updateGrand2_artran" datasource="#dts#">
        	UPDATE artran 
            SET 
        		grand_bil = net_bil+tax_bil,
        		tax1_bil = tax_bil
        	WHERE type = '#tran#' 
            AND <cfif IsDefined('url.nexttranno')> 
            		refno='#url.nexttranno#'; 
                <cfelse> 
                	refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">);
                </cfif>
        </cfquery>

        <cfquery name="updaterate" datasource="#dts#">
        	UPDATE artran 
            SET 
            	grand = grand_bil * currrate , 
                net = net_bil * currrate, 
                invgross = gross_bil * currrate, 
                tax = tax_bil * currrate, 
                tax1 = tax1_bil 
            WHERE type = '#tran#' 
            AND <cfif IsDefined('url.nexttranno')> 
            		refno='#url.nexttranno#'; 
                <cfelse> 
                	refno IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sono#" list="yes">);
                </cfif>
        </cfquery>