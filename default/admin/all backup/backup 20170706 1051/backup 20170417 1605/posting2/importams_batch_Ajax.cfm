<cfsetting showdebugoutput="no">
<cfset dts1 = replace(LCASE(dts),"_i","_a","all")>
<cfquery name="getbatch" datasource="#dts1#">
	select 
	recno,desp  
	from glbatch 
	where (lokstatus='1' or lokstatus = '' or lokstatus is null)
	and (delstatus='' or delstatus is null) 
	and (poststatus='' or poststatus is null) 
	and (locktran='' or locktran is null)
    and fperiod='#url.fperiod#'
    order by recno;
</cfquery>
                
                <cfoutput>
                <select name="batch_no" id="batch_no">
                <cfif getbatch.recordcount eq 0>
                <option value="">Please create batch</option>
                </cfif>
					<cfloop query="getbatch">
						<option value="#getbatch.recno#">#getbatch.recno# - #getbatch.desp#</option>
					</cfloop>
				</select>
                </cfoutput>