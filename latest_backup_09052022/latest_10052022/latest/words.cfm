<cfquery name="getlanguage" datasource="#dts#">
        SELECT dflanguage
        FROM gsetup
</cfquery>
<cfset language = getlanguage.dflanguage>
<cfif hlang neq "">
<cfset language = hlang>
</cfif>
<cfquery name="getWords" datasource="main">
	SELECT id AS id,#language# AS language
	FROM words
	WHERE id IN (<cfqueryparam value="#words_id_list#" cfsqltype="cf_sql_integer" list="yes" separator="," />)
	ORDER BY id
</cfquery>
<cfset words=StructNew()>
<cfloop query="getWords"> 
<cfset StructInsert(words, getWords.id, getWords.language,true)>
</cfloop>

<cftry>

<cfquery name="getuserWords" datasource="#dts#">
	SELECT id AS id,userset AS language
	FROM userdefinedwords
	WHERE id IN (<cfqueryparam value="#words_id_list#" cfsqltype="cf_sql_integer" list="yes" separator="," />)
	ORDER BY id
</cfquery>
<cfloop query="getuserWords"> 
<cfset words["#getuserWords.id#"]=getuserWords.language>
</cfloop>

<cfcatch>
</cfcatch>
</cftry>