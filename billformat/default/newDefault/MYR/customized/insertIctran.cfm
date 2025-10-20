<cfquery name="InsertICBil_S" datasource='#dts#'>
    INSERT IGNORE INTO r_icbil_s (	no, sRefNo, itemNo, aitemno, desp, despa, sn_no, comment, 
                                    unit, qty, price, amt, dispec1, dispec2, dispec3, itemdis_bil, 
                                    taxpec1, taxpec2, taxpec3, taxamt, taxCode, 
                                    brem1, brem2, brem3, brem4,
                                    qty1, qty2, qty3, qty4, qty5, qty6, qty7,
                                    titledesp, location, 
                                    counter_1, counter_2, counter_3, counter_4, photo)
                            
    VALUES ( 	<cfqueryparam cfsqltype="cf_sql_decimal" value="#j#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.refno#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.itemno#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.aitemno#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#toString(str)#">, 	
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#toString(getBodyInfo.despa)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#toString(mylist1)#">,																					
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#toString(getBodyInfo.comment)#">,
                    
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.unit_bil#">,
                <cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.qty_bil)#">,
                <cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.price_bil)#">,
                <cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.amt_bil)#">,
                <cfloop index='i' from='1' to='3'>
                    <cfqueryparam cfsqltype="cf_sql_double" value="#val(evaluate('getBodyInfo.dispec#i#'))#">,
                </cfloop>
                <cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.disamt_bil)#">,
                
                <cfloop index='i' from='1' to='3'>
                    <cfqueryparam cfsqltype="cf_sql_double" value="#val(evaluate('getBodyInfo.taxpec#i#'))#">,
                </cfloop>
                <cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.taxamt_bil)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getBodyInfo.note_a#">,
                
                <cfloop index='i' from='1' to='4'>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('getBodyInfo.brem#i#')#">,
                </cfloop>  
                
                <cfloop index='i' from='1' to='7'>
                    <cfqueryparam cfsqltype="cf_sql_double" value="#val(evaluate('getBodyInfo.qty#i#'))#">,
                </cfloop>
                
                '', 
                <cfqueryparam cfsqltype="cf_sql_double" value="#val(getBodyInfo.location)#">,
                
                <cfqueryparam cfsqltype="cf_sql_decimal" value="#toRecalculateRunningNumber#">,
                '',
                '',
                '',
                <cfif IsDefined('itemphoto')>
                	'#itemphoto#'
                <cfelseif getBodyInfo.photo NEQ ''>
                	'/images/#dts#/#getBodyInfo.photo#'
                <cfelse>
                	''    
                </cfif>
           )
</cfquery>