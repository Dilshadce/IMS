<cfsetting showDebugOutput="no">
<cfquery name="getCustomer" datasource="#dts#">
	<!---SELECT * FROM arcust 
        WHERE custno like "%#trim(form.name)#%"
        or name like "%#trim(form.name)#%" ---> 
        
    <!---Upgraded Search By Nieo 20171106 1218--->
    <!---<cfif form.name neq ''>
        <!---<cfset i = 0>--->
        SELECT * FROM (
            SELECT * FROM arcust 
            WHERE custno like "%#trim(form.name)#%"
            or name like "%#trim(form.name)#%"
            <cfloop list="#replacenocase(replacenocase(form.name,'sdn',''),'bhd','')#" delimiters=" " index="a">
                <!---<cfif i neq 0>--->
                UNION 
                <!---</cfif> --->
                
                SELECT * FROM arcust 
                WHERE name like "%#a# %"
                
                <!---<cfset i+=1>--->
            </cfloop>
        ) a
    <cfelse>
        SELECT * FROM arcust 
        WHERE custno in (SELECT custno FROM assignmentslip)
    </cfif>--->
     
    <!---Upgraded Search By Nieo 20171106 1416--->
    SELECT * FROM arcust 
            WHERE custno like "%#trim(form.name)#%"
            or replace(name,' ','') like "#trim(replacenocase(replacenocase(replacenocase(replacenocase(form.name,'sdn',''),'bhd',''),'.',''),' ','','all'))#%"
    <!---Upgraded Search By Nieo 20171106 1416--->
    <!---Upgraded Search By Nieo 20171106 1218--->
</cfquery>
<table>
	<input type="checkbox" id="selectAll" onchange="selectAllCustomer()"> SELECT ALL <hr />
	<cfloop query="#getCustomer#">
		<cfoutput>

					<input class="selectCustomer" type="checkbox" name="customer" value="#getCustomer.custno#"> #getCustomer.custno# - #getCustomer.name#
					<hr />

		</cfoutput>
	</cfloop>
</table>
<script>

		function selectAllCustomer(){

			if($("#selectAll").is(":checked")){
				$(".selectCustomer").prop("checked",true);
			}else{
				$(".selectCustomer").prop("checked",false);
			}
		}
	</script>