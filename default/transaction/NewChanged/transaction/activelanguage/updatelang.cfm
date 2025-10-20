<cfif isdefined('url.desp1')>
<cfset desp1= URLDECODE(URLDECODE(url.desp1))>
<cfset desp2= URLDECODE(URLDECODE(url.desp2))>
<cfset comment= URLDECODE(URLDECODE(url.comment))>
<cfset brem1= URLDECODE(URLDECODE(url.brem1))>
<cfset brem2= URLDECODE(URLDECODE(url.brem2))>
<cfset brem3= URLDECODE(URLDECODE(url.brem3))>
<cfset brem4= URLDECODE(URLDECODE(url.brem4))>

<cfquery name="getlang" datasource="#dts#">
SELECT * FROM iclanguage order by length(English) DESC, english
</cfquery>

<cfloop query="getlang">
<cfset oldwords = getlang.english>
<cfset newwords =getlang.chinese>
<cfset desp1=rereplacenocase(desp1,"\b#oldwords#\b",newwords,"ALL")>
<cfset desp2 = rereplacenocase(desp2,"\b#oldwords#\b",newwords,'all')>
<cfset comment = rereplacenocase(comment,"\b#oldwords#\b",newwords,'all')>
<cfset brem1 = rereplacenocase(brem1,"\b#oldwords#\b",newwords,'all')>
<cfset brem2 = rereplacenocase(brem2,"\b#oldwords#\b",newwords,'all')>
<cfset brem3 = rereplacenocase(brem3,"\b#oldwords#\b",newwords,'all')>
<cfset brem4 = rereplacenocase(brem4,"\b#oldwords#\b",newwords,'all')>
</cfloop>

<cfoutput>
<input type="hidden" name="langdesp1" id="langdesp1" value="#desp1#">
<input type="hidden" name="langdesp2" id="langdesp2" value="#desp2#">
<input type="hidden" name="langcomment" id="langcomment" value="#comment#">
<input type="hidden" name="langbrem1" id="langbrem1" value="#brem1#">
<input type="hidden" name="langbrem2" id="langbrem2" value="#brem2#">
<input type="hidden" name="langbrem3" id="langbrem3" value="#brem3#">
<input type="hidden" name="langbrem4" id="langbrem4" value="#brem4#">
</cfoutput>
</cfif>
