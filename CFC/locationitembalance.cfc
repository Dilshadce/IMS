<cfcomponent>
    <CFFUNCTION NAME="locationbalance" returntype="boolean">
        <CFARGUMENT NAME="dts" TYPE="string" REQUIRED="yes">
        
        
        
        
      
        <cfquery name="getbillitem" datasource="#dts#">
        SELECT itemno FROM locationitempro
        group by itemno
        </cfquery>
        
        <cfif getbillitem.recordcount neq 0>
        	<cfloop query="getbillitem">
            
            <cfquery name="getdoupdated" datasource="#dts#">
            SELECT frrefno FROM iclink WHERE frtype = "DO" 
            and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbillitem.itemno#">
             group by frrefno
            </cfquery>
            
            <cfset billupdated=valuelist(getdoupdated.frrefno)>

            <cfquery datasource="#dts#" name="getitem">
                
                select 
                a.itemno,
                a.desp,
                a.price,
                a.sizeid,a.colorid,a.supp,a.category,a.price2,
                b.location,
                c.balance
                
                from (SELECT itemno,desp,price,sizeid,colorid,supp,category,price2 FROM icitem WHERE itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbillitem.itemno#">) as a 
                
                left join 
                (
                    select 
                    location,
                    itemno,
                    (select desp from iclocation where location=locqdbf.location) as locationdesp 
                    from locqdbf
                    where itemno=itemno 
                    and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbillitem.itemno#">
                    
                ) as b on a.itemno=b.itemno 
                
                left join 
                (
                    select 
                    a.location,
                    a.itemno,
                    (ifnull(a.locqfield,0)+ifnull(b.sum_in,0)-ifnull(c.sum_out,0)) as balance
                    
                    from locqdbf as a 
                    
                    left join
                    (
                        select 
                        location,
                        itemno,
                        sum(qty) as sum_in 
                        
                        from ictran
                        
                        where type in ('RC','CN','OAI','TRIN') 
                        and fperiod<>'99'
                        and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbillitem.itemno#">
            and (void = '' or void is null) 
                            and (linecode <> 'SV' or linecode is null)
                        group by location,itemno
                        order by location,itemno
                    ) as b on a.location=b.location and a.itemno=b.itemno
                    
                    left join
                    (
                        select 
                        location,
                        category,
                        wos_group,
                        itemno,
                        sum(qty) as sum_out 
                        
                        from ictran 
                        
                        where 
                        
                            (type in ('DO','DN','CS','OAR','PR','ISS','TROU') or 
                            (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                        and fperiod<>'99'
                        and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbillitem.itemno#">
                        and (void = '' or void is null) 
                            and (linecode <> 'SV' or linecode is null)
                        group by location,itemno
                        order by location,itemno
                    ) as c on a.location=c.location and a.itemno=c.itemno 
                    where a.itemno=a.itemno
                    and a.itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbillitem.itemno#">
                   
                    
                ) as c on a.itemno=c.itemno and b.location=c.location 
                
                where a.itemno=a.itemno 
                and b.location<>''
            
                and a.itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbillitem.itemno#">
                order by a.itemno;
                </cfquery>
                
				
                <cfloop query="getitem">
                <cfquery name="updatebalance" datasource="#dts#">
                UPDATE locqdbf SET qty_bal = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(getitem.balance,'._______')#">
                WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getbillitem.itemno#">
                AND location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getitem.location#">
                </cfquery>
                </cfloop>
                    
            </cfloop>
        
		</cfif>
        
        <cfquery name="deleterow" datasource="#dts#">
        DELETE FROM locationitempro WHERE id in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getlist.id)#" list="yes" separator=",">)
        </cfquery>
        

        <cfset result = true>
        <CFRETURN result>
    </CFFUNCTION>
</cfcomponent>