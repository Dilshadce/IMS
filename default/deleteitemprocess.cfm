<cfloop list="#form.itemno#" index="i">
<cfquery name="deleteitemgrd" datasource='#dts#'>
				Delete from itemgrd where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#i#">
			</cfquery>
			
			<cfquery name="deletelogrdob" datasource='#dts#'>
				Delete from logrdob where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#i#">
			</cfquery>
			
			<cfquery name="deleterelateditem1" datasource='#dts#'>
				Delete from relitem where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#i#">
			</cfquery>
			
			<cfquery name="deleterelateditem1" datasource='#dts#'>
				Delete from relitem where relitemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#i#">
			</cfquery>
            
            <cfquery name="deleteitem" datasource='#dts#'>
				Delete from icitem where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#i#">
			</cfquery>
            
            <cfquery name="deleteprice" datasource="#dts#">
            	Delete from icl3p2 where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#i#">
            </cfquery>
            
            <cfquery name="deleteprice1" datasource="#dts#">
            	Delete from icl3p where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#i#">
            </cfquery>
</cfloop>