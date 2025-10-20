<cfquery name = "check_update_unit_cost" datasource = "#dts#">
	select 
	update_unit_cost 
	from gsetup2;
</cfquery>
<cftry>
<cfif check_update_unit_cost.update_unit_cost eq "T">
	<cfquery name = "getictran" datasource = "#dts#">
		select 
		custno,
		itemno,
		if(taxincl = "T",(amt-taxamt)/qty,price) as price,
        if(taxincl = "T",(amt_bil-taxamt_bil)/qty,price_bil) as price_bil,
		dispec1,
		dispec2,
		dispec3,
        UPDCOST,
        type,
        refno
		from ictran 
		where type=<cfqueryparam cfsqltype="cf_sql_char" value="#tran#">
		and refno=<cfqueryparam cfsqltype="cf_sql_char" value="#nexttranno#">
		and fperiod <> '99' 
		order by itemcount;
	</cfquery>
    
		<cfquery name="getformula" datasource="#dts#">
        SELECT * from gsetup
        </cfquery>
        
	<cfif getictran.recordcount gt 0 and getictran.UPDCOST neq "Y">
		<cfloop query = "getictran">
        <cftry>
        <cfset cost1=listgetat(getictran.price,1,'.')>
        <cfset cost2=listgetat(getictran.price,2,'.')>
        <cfcatch>
        
        <cfset cost1=getictran.price>
        <cfset cost2=''>
        </cfcatch></cftry>
        
        
        <cfset itemnumber = arraynew(1)>
        <cfset itemnumber[1]=left(getformula.costformula1,1)>
		<cfset itemnumber[2]=mid(getformula.costformula1,2,1)>
        <cfset itemnumber[3]=mid(getformula.costformula1,3,1)>
        <cfset itemnumber[4]=mid(getformula.costformula1,4,1)>
        <cfset itemnumber[5]=mid(getformula.costformula1,5,1)>
        <cfset itemnumber[6]=mid(getformula.costformula1,6,1)>
        <cfset itemnumber[7]=mid(getformula.costformula1,7,1)>
        <cfset itemnumber[8]=mid(getformula.costformula1,8,1)>
        <cfset itemnumber[9]=mid(getformula.costformula1,9,1)>
        <cfset itemnumber[10]=mid(getformula.costformula1,10,1)>

        <cfloop from="1" to="9" index="i">
        <cfset cost1=replace(cost1,i,itemnumber[i],"All")>
        </cfloop>
        
        <cfset itemnumber2 = arraynew(1)>
        <cfset itemnumber2[1]=left(getformula.costformula3,1)>
		<cfset itemnumber2[2]=mid(getformula.costformula3,2,1)>
        <cfset itemnumber2[3]=mid(getformula.costformula3,3,1)>
        <cfset itemnumber2[4]=mid(getformula.costformula3,4,1)>
        <cfset itemnumber2[5]=mid(getformula.costformula3,5,1)>
        <cfset itemnumber2[6]=mid(getformula.costformula3,6,1)>
        <cfset itemnumber2[7]=mid(getformula.costformula3,7,1)>
        <cfset itemnumber2[8]=mid(getformula.costformula3,8,1)>
        <cfset itemnumber2[9]=mid(getformula.costformula3,9,1)>
        <cfset itemnumber2[10]=mid(getformula.costformula3,10,1)>
        
        <cfloop from="1" to="9" index="i">
        <cfset cost2=replace(cost2,i,itemnumber2[i],"All")>
        </cfloop>
        
        <cfif cost2 eq ''>
        <cfset myResult=replace(cost1,'0',itemnumber[10],"All")&getformula.costformula2>
        <cfelse>
		<cfset myResult=replace(cost1,'0',itemnumber[10],"All")&getformula.costformula2&replace(cost2,'0',itemnumber2[10],"All")>
        </cfif>
        
        
			<cfquery name = "updateIcitem" datasource = "#dts#">
				update icitem 
				set ucost=<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.price#">,
                costformula='#myResult#'
				where itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.itemno#">;
			</cfquery>
            
            <cfquery name="updateictran" datasource="#dts#">
            	UPDATE ICTRAN SET UPDCOST = "Y" WHERE 
                type=<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.type#">
                and refno=<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.refno#">
                and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.itemno#">
                and fperiod <> '99'
                
            </cfquery>
			
			<cfif getictran.custno neq "">
				<cfquery name = "update_icl3p2" datasource = "#dts#">
					insert into icl3p2 
					(
						itemno,
						custno,
						price,
						dispec,
						dispec2,
						dispec3
					)
					values 
					(
						<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.itemno#">,
						<cfqueryparam cfsqltype="cf_sql_char" value="#getictran.custno#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.price#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec1#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec2#">,
						<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec3#">
					) 
					on duplicate key update 
					price=<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.price#">,
					dispec=<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec1#">,
					dispec2=<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec2#">,
					dispec3=<cfqueryparam cfsqltype="cf_sql_double" value="#getictran.dispec3#">;
				</cfquery>
			</cfif>
		</cfloop>
	</cfif>
<cfelse>
<cfquery name = "updateictran" datasource = "#dts#">
		UPDATE ICTRAN SET UPDCOST = "Y" WHERE 
		type=<cfqueryparam cfsqltype="cf_sql_char" value="#tran#">
		and refno=<cfqueryparam cfsqltype="cf_sql_char" value="#nexttranno#">
		and fperiod <> '99
	</cfquery>
</cfif>
<cfcatch type="any">
</cfcatch>
</cftry>

