<cfsetting showdebugoutput="no">
<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<cfquery name="getitem" datasource="#dts#">
	select itemno, desp from icitem where itemno like'%#url.itemno#%' order by itemno
</cfquery>
<cfoutput>
			<select name="olditemno" onChange="dispDesp(this,'newitemdesp');">
          		
          		<cfloop query="getitem">
            	<option value="#itemno#" title='#convertquote(desp)#'>#itemno# - #desp#</option>
          		</cfloop>
			</select>
</cfoutput>