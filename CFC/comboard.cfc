<cfcomponent>
<cftry>
	<cffunction name="display" access="public">
		<cfargument name="firstline" type="any" required="yes">
        <cfargument name="secondlineleft" type="any" required="yes">
        <cfargument name="secondlineright" type="any" required="yes">
        <cfargument name="comchannel" type="any" required="yes">



        <cfset firstline = left(trim(firstline),20)>

        <cfif len(trim(firstline)) neq 20>
        <cfloop from="1" to="#20-len(firstline)#" index="i">
        <cfset firstline = firstline&" ">
        </cfloop>
		</cfif>

        <cfset secondlineleft = left(secondlineleft,9)>

        <cfif len(secondlineleft) neq 9>
        <cfloop from="1" to="#9-len(secondlineleft)#" index="i">
        <cfset secondlineleft = secondlineleft&" ">
        </cfloop>
		</cfif>

        <cfset secondlineright = left(secondlineright,10)>

        <cfif len(secondlineright) neq 10>
        <cfloop from="1" to="#10-len(secondlineright)#" index="i">
        <cfset secondlineright = " "&secondlineright>
        </cfloop>
		</cfif>
        <cfset filecontent = "echo "&firstline&secondlineleft&secondlineright&">"&comchannel>
        
	<cfreturn filecontent> 
	</cffunction>
<cfcatch>
</cfcatch>
</cftry>
</cfcomponent>