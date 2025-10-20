<cfsetting showdebugoutput="no">
<cfoutput>
<cfquery datasource="#dts#" name="getlocationlist">
            SELECT "" as location,"Choose a Location" as desp
            UNION ALL
            select * from (
            select 
            location,
             desp 
            from iclocation 
            where 0=0
            and (noactivelocation='' or noactivelocation is null)
            and left(location,4) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.locheader)#">
            <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
            <cfelse>
            <cfif Huserloc neq "All_loc">
            and location='#Huserloc#'
            </cfif>
            </cfif>
            order by location) as a
        	</cfquery>
				<select name='location' id="loc6" <cfif isservice neq 1>onchange="getbalqty(this.value);"</cfif>>
				<cfloop query='getlocationlist'>
                        <option value='#getlocationlist.location#'<cfif URLDECODE(url.xlocation) eq getlocationlist.location>Selected</cfif>>#getlocationlist.location# - #getlocationlist.desp#</option>
                        </cfloop>
                </select>
</cfoutput>