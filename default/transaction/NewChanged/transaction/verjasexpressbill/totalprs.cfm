<cfsetting showdebugoutput="no">

<cfif url.type neq "TR">
<cfquery name='getictran' datasource='#dts#'>
		select sum(qty_bil) as qty from ictrantemp where refno="#url.refno#" and type ="#url.type#" and uuid='#url.uuid#' order by 'refno' 
	</cfquery>
    <cfelse>
    <cfquery name='getictran' datasource='#dts#'>
		select sum(qty_bil) as qty from ictrantemp where refno="#url.refno#" and type ="TROU" and uuid='#url.uuid#' order by 'refno' 
	</cfquery>
    </cfif>

<cfoutput>
<input type="Text" name="totalprs" id="totalprs" readonly="yes" value="#getictran.qty#"  />
        </cfoutput>
		