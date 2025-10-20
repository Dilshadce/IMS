<cfoutput>

    <cfquery name="getrng" datasource="#dts#">
select * from imiqgroup_i.emptimesheet where empno=1244 and month='1' and year='2015'


    </cfquery>


<cfdump var="#getrng#">



</cfoutput>

